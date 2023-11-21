Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897AB7F3A0F
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 00:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbjKUXJF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 18:09:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjKUXJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 18:09:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AB0A4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 15:09:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57535C433C7;
        Tue, 21 Nov 2023 23:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700608140;
        bh=qBLKfkbkagbdBbl6e0aA2LHfmNjL2L1x6etHid+StRk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WPficb9hFbv57jkbne0ldlaIiOnFY9BJwatJstHDqOTvAu8cnx4xrLqY87ObZH3E+
         3xMpYQP2cUgqRYRVRQ8rIzZYBCTV5kmJCVCLc1hbo+z4cePu5gvr4aYpAcd7wePho8
         skLQrVM41tGzuI/DE2vHdbYq9/C6N0uvQ/ZQeeUa3IqF2juxa8/c7h+IV11lsgwLMc
         vTkPDPAon7dUReZR75aVjy3Vp1y2P1P1osbp7CaTU44JN2mATJj9ZnYB8Uu3UUXMdH
         I5F/z112G27jBLetkyoAtUacNZgf6U4D9zKw4OnGBWEEIob4drB4VHwJh4yRsmjYno
         gd8FydaASHrXA==
Date:   Tue, 21 Nov 2023 15:08:59 -0800
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
Message-ID: <20231121150859.7f934627@kernel.org>
In-Reply-To: <20231120193504.5922-1-ansuelsmth@gmail.com>
References: <20231120193504.5922-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Nov 2023 20:35:04 +0100 Christian Marangi wrote:
> It seems some arch (s390) require a more specific mask for FIELD_PREP
> and doesn't like using GENMASK(15, 2) for u16 values.
> 
> Fix the compilation error by adding the additional mask for the BITS
> that the PHY ignore and AND the passed addr with the real mask that the
> PHY will parse for the mailbox interface 4 addr to make sure extra
> values are correctly removed.

Ah. Um. Pff. Erm. I'm not sure.

Endianness is not my strong suit but this code:

	/* PHY expect addr in LE */
	addr = (__force u32)cpu_to_le32(addr); 

	/* ... use (u16)(addr)       */
	/* ... use (u16)(addr >> 16) */

does not make sense to me.

You're operating on register values here, there is no endian.
Endian only exists when you store or load from memory. IOW, this:

	addr = 0x12345678;
	print((u16)addr);
	print(addr >> 16);

will print the same exact thing regardless of the CPU endian.

Why did you put the byte swap in there?
-- 
pw-bot: cr
