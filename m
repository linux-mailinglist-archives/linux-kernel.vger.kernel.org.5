Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA047F3A85
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:58:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234941AbjKUX6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:58:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjKUX6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:58:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75C7319E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:58:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FED0C433C7;
        Tue, 21 Nov 2023 23:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700611094;
        bh=RpcmV04Y5XssEbTca1q02Yjdopi3rB3NOK/3fMzbaj0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jD0Q3Q7N3DsvX6sLJReEOxJuUr9/ay4yEYPRnx698HUHlGRgTCPpBt3q4r9+o6gZe
         CdEpwa3ZmVSqGU/WfS8ZmnVNqQzDwM+cTK/9oWT4kpNOPYnGaYavXIfHnC9zmYE8Ec
         1h0u+oVutz7lXx5+R7W+J1NL8A9By3MsAVg1RHyoEr+uMQbkkeniXaz3mvDF49v7ae
         UH0ZZ8Emd1vsM7p0XPScgRve5l+PVPeBcdP2kz2bENuCJvP6bCsMHZErIl4HONK0uO
         xIb1Ue7tcP2TFfd3TweP38mRGs5X74zX1VYyBI5VSZHjM8k2lLcHNW3dYHhmpM1AOF
         jt/jgsQi9wk5w==
Date:   Tue, 21 Nov 2023 15:58:12 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Robert Marko <robimarko@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Subject: Re: [net-next PATCH] net: phy: aquantia: make mailbox interface4
 lsw addr mask more specific
Message-ID: <20231121155812.03113405@kernel.org>
In-Reply-To: <655d41b4.050a0220.36e34.359e@mx.google.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
        <20231121150859.7f934627@kernel.org>
        <655d3e2b.df0a0220.50550.b235@mx.google.com>
        <20231121153918.4234973d@kernel.org>
        <655d41b4.050a0220.36e34.359e@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 00:48:01 +0100 Christian Marangi wrote:
> > Not so sure about this one, it puts the u32 on the stack, and takes 
> > the address of it:
> > 
> > 	u32 word;
> > 
> > 	word = (__force u32)cpu_to_be32(word);
> > 	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));
> > 
> > so the endian will matter here. My guess is that this part is correct.  

Actually I'm wrong about this, you're reading and writing the data,
so endian conversion happens twice. Canceling itself out.

> Ehhh this is problematic. Data comes from nvmem or filesystem, in theory
> they should not be touched/converted.
> 
> nvmem_cell_read or request_firmware return pointer to u8 and it's the
> firmware (that is always in LE)
> 
> If data is not converted and passed AS IS from what is read to the
> allocated data, then data should be always swapped.
> (this PHY is fun... it's probably BE internally but expect LE stuff in
> the mailbox, as it does emit BE CRC.)
> 
> Any idea where I can verify if nvmem_cell_read or request_firmware makes
> any kind of endianess conversion on the data it does read?

The underlying storage should be byte-accessible, so neither interface
should change anything about the endian.

You should probably switch get_unaligned_le32() for reading it into 
the word variable, tho.
