Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD854789FB4
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 16:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230413AbjH0N7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 09:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbjH0N7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 09:59:24 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1094ACE;
        Sun, 27 Aug 2023 06:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=JVvm7fYZ5VOK8prRPe7vWiswKOsY/Xrn4DbAyJv08DE=; b=blS9u+03U+DRRvi7hm21XlM3e7
        jIeTjieA1Ygwew0uEhAWoM5fwMeoLP9JQzFdcMWw50IosMfbGiUixW4x14+oezpz0bIDclAfDpatp
        6tYDEILCgxVH98uuSohS4ecTtSrPsj55rxc0E1Intxpj0vwk1q67bO+kSGA66lAguXKt5pqnZoSv/
        6ROtW203TwgoiJ0E4EefRvryEwMWPduUjarUX6+Fp1ti9raeKwW6HTar9vyAncD6M2WZVDghdjKxM
        NVi5eUxX+QATiCkNDIaIfaqnmKuotb1PPs4MMre+yy+4OV0adtPlWbbJMneiiJ3mLPTHyzHzhGSk9
        tDQ+0rCA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:44638)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qaGI1-0006xW-0x;
        Sun, 27 Aug 2023 14:58:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qaGHx-0002ZZ-Gq; Sun, 27 Aug 2023 14:58:49 +0100
Date:   Sun, 27 Aug 2023 14:58:49 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jisheng Zhang <jszhang@kernel.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Samin Guo <samin.guo@starfivetech.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac-starfive: improve error
 handling during probe
Message-ID: <ZOtWmedBsa6wQQ6+@shell.armlinux.org.uk>
References: <20230827134150.2918-1-jszhang@kernel.org>
 <20230827134150.2918-2-jszhang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230827134150.2918-2-jszhang@kernel.org>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 27, 2023 at 09:41:49PM +0800, Jisheng Zhang wrote:
> After stmmac_probe_config_dt() succeeds, when error happens later,
> stmmac_remove_config_dt() needs to be called for proper error handling.

Have you thought about converting to use devm_stmmac_probe_config_dt()
which will call stmmac_remove_config_dt() if the probe fails or when
the device is unbound?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
