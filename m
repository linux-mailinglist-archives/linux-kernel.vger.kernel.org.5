Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 562BD7F3A5B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:39:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234808AbjKUXjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjKUXjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:39:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 689D4D1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:39:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD3C433C8;
        Tue, 21 Nov 2023 23:39:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700609960;
        bh=RszxG6K3d072jCkBLTpgU6IMlmbsLSh8U2l2W3DjB44=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PhFltCL0gbtiIIW1uBM0Rn2oSxvzt0/b0DVLL45rNn90lyd/b9GmKyzps6Mi39Qht
         7oTRbeOBlMQYX2hlDp6/lyuWy7Kyh1W0q+3fnblhM20p4Y23sxo3v9V5BVtuZFVCqL
         6UKvElsYYkddh3T/jLy3D94Vwg5DQt2PPh/Yfs4y4Q3NgEVCbP1Bg2ongMRwODTZKW
         OCDGO6IODTj2VQE3A/zeHiqIK7n0K82RbUPO26Hm2uLm4div8Pr5mJgexoLxiYAtfV
         46AoiSX9uHpF7pXuMA6AAyjAJBSlfwSyO7Lof/2rwESyJwE/XHLj3O5nNUAMfz6eCq
         jf8Ac3+K6e7qQ==
Date:   Tue, 21 Nov 2023 15:39:18 -0800
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
Message-ID: <20231121153918.4234973d@kernel.org>
In-Reply-To: <655d3e2b.df0a0220.50550.b235@mx.google.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
        <20231121150859.7f934627@kernel.org>
        <655d3e2b.df0a0220.50550.b235@mx.google.com>
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

On Wed, 22 Nov 2023 00:32:56 +0100 Christian Marangi wrote:
> the 2 addr comes from a define
> 
> #define DRAM_BASE_ADDR		0x3FFE0000
> #define IRAM_BASE_ADDR		0x40000000
> 
> it wasn't clear to me if on BE these addrs gets saved differently or
> not. PHY wants the addr in LE.
> 
> On testing by removing the cpu_to_le32 the error is correctly removed!
> 
> I guess on BE the addr was actually swapped and FIELD_GET was correctly
> warning (and failing) as data was missing in applying the mask.

I think so. It's the responsibility of whether underlies 
phy_write_mmd() to make sure the data is put on the bus in
correct order (but that's still just within the u16 boundaries,
splitting a constant into u16 halves is not endian dependent).

> If all of this makes sense, will send a followup patch that drop the
> cpu_to_le32 and also the other in the bottom that does cpu_to_be32 (to a
> __swab32 as FW is LE and mailbox calculate CRC in BE)

Not so sure about this one, it puts the u32 on the stack, and takes 
the address of it:

	u32 word;

	word = (__force u32)cpu_to_be32(word);
	crc = crc_ccitt_false(crc, (u8 *)&word, sizeof(word));

so the endian will matter here. My guess is that this part is correct.
