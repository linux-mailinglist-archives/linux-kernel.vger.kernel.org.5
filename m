Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD667FC15E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346046AbjK1PmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345899AbjK1PmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:42:21 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 416D612A;
        Tue, 28 Nov 2023 07:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=IMKJEnNn+G4rdqFGH3iRHztZa/N2RADNEAueBo8O0cY=; b=z16DHxP08aFFFJ47LD9uxtJpsn
        +t0RB0TyQ2KyCYVbEMXvvjymQCwHExD6/vKRXzXzkjojJ7IP2XE8qmxVC8cAHrtCd0+IIrVCm7qdN
        ZdkxE7l6xOULssxdV73BHOuaELu62t9SvZuDP9ZN1aCfYYnQMrGlQxH4qVoIMelPnGvcPnaF38Pkr
        h5A/PWeMHMTxSr3BM1Zuta51o2q+gTVoiMVbBs0Dc0KEwgofXauGinHENQ/qNDFrdL2D7Y0vYeL4i
        sMNspndTH56fozoySkkm+Xwt+BdU09U7Sw0FK8bN/SgdK1YxaDQXRaJcCIRC8UP2EoMRf9O+b1H83
        t070MZQg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:54994)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r80E9-0007Xq-1d;
        Tue, 28 Nov 2023 15:42:21 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r80EA-00034k-5Y; Tue, 28 Nov 2023 15:42:22 +0000
Date:   Tue, 28 Nov 2023 15:42:22 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     linux-pm@vger.kernel.org, loongarch@lists.linux.dev,
        linux-acpi@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, kvmarm@lists.linux.dev,
        x86@kernel.org, linux-csky@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-parisc@vger.kernel.org, Salil Mehta <salil.mehta@huawei.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        jianyong.wu@arm.com, justin.he@arm.com,
        James Morse <james.morse@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH RFC 02/22] x86: intel_epb: Don't rely on link order
Message-ID: <ZWYKXvbAck9kQ+iy@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JKq-00CTwZ-Mh@rmk-PC.armlinux.org.uk>
 <20231128144059.000042c8@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128144059.000042c8@Huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 02:40:59PM +0000, Jonathan Cameron wrote:
> On Tue, 07 Nov 2023 10:29:28 +0000
> Russell King <rmk+kernel@armlinux.org.uk> wrote:
> 
> > From: James Morse <james.morse@arm.com>
> > 
> > intel_epb_init() is called as a subsys_initcall() to register cpuhp
> > callbacks. The callbacks make use of get_cpu_device() which will return
> > NULL unless register_cpu() has been called. register_cpu() is called
> > from topology_init(), which is also a subsys_initcall().
> > 
> > This is fragile. Moving the register_cpu() to a different
> > subsys_initcall()  leads to a NULL dereference during boot.
> > 
> > Make intel_epb_init() a late_initcall(), user-space can't provide a
> > policy before this point anyway.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> 
> Seems reasonable. FWIW
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Thanks, however this has already been merged into the tip tree since
Rafael suggested sending it separately.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
