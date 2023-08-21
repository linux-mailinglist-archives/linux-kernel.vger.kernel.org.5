Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2A67829A4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235128AbjHUM4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:56:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjHUM4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:56:17 -0400
Received: from pandora.armlinux.org.uk (unknown [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F391D3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 05:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=bZuXrJnycDPuWsVWT2G7AaUlErg2xS9Lt8LBAxiLYG8=; b=0dc2CaV81hgg0b9IKZ6hSLULgy
        +rz0Vi9EuPClZOLAAnIPmA632QV1vODZhVwckDuAEGo4dQAfs0QIEe21qFLqukhI3JQIJ+nlru49B
        G889dqmgZfC70ftNtB0w1I9UmwY6flzLmLvM60VsDx0x3J9XhwIDlpR2zX8wzUB/ZzoBFMQbYip14
        RS8F0G9yTMvfNy83FeiLA1FA7nhaFn7bMHkd2XHRenfxNNKtdHGNDSsPQqmpZVSDngDPBPx7u4gez
        88aaTXi394snz9GXA4BGLNCk7gqdQcjb0dGbG79vlAZTpN8/ZtgaZTzihcakvYlFdfDWOycPae1lf
        e+EhE6+Q==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41892)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qY4Rz-0008Va-2B;
        Mon, 21 Aug 2023 13:56:07 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qY4Rz-0004mn-3l; Mon, 21 Aug 2023 13:56:07 +0100
Date:   Mon, 21 Aug 2023 13:56:07 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Helge Deller <deller@gmx.de>
Cc:     linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][RESEND] arm: Fix flush_dcache_page() for usage from irq
 context
Message-ID: <ZONe5/SuQ0qpb7R0@shell.armlinux.org.uk>
References: <ZN/bYak6eLE02LJP@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZN/bYak6eLE02LJP@p100>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 18, 2023 at 10:58:09PM +0200, Helge Deller wrote:
> Since at least kernel 6.1, flush_dcache_page() is called with IRQs
> disabled, e.g. from aio_complete().
> 
> But the current implementation for flush_dcache_page() on ARM (32-bit)
> unintentionally re-enables IRQs, which may lead to deadlocks.
> 
> Fix it by using xa_lock_irqsave() and xa_unlock_irqrestore()
> for the flush_dcache_mmap_*lock() macros instead.
> 
> Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: linux-arm-kernel@lists.infradead.org
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Helge Deller <deller@gmx.de>

Please submit to the patch system, details can be found in my email
signature below.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
