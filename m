Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 578E37E6814
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:29:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233420AbjKIK3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:29:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjKIK3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:29:38 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD5D211B;
        Thu,  9 Nov 2023 02:29:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=k2gkeOQrNAEjn39cRXCfbpgo6HGUJfn9iHjQZ+mCvpE=; b=IHSMPuWYcuLCdYJoZFFHEG8thf
        9jhhPJSykRLloUzaTWB4BUbFOkPu8loXs39HW9H8x4N5rRmEh38UyjZQIwLCF0Afp6ktJOPMGz+Xf
        ueHVW9YySJOX2vw4OEy4zJjjj4EE5/zCN4jUZNjweQ9e8s8yknfigbErHK8XcLW/MiKh9Qn+PPDBV
        DU5IAe2iD5JjtMfuW7zFqO82ZzKbT9eSsLuUBjL5fihCHqnuQjdhggMMaZMgZPerYH9MCj0pvIhb5
        iSXhbPROGKwd+XCrFhhcWjsE88bL9nzHMW3hg2V8Cza4PBuLBnLCJhi8oPMvNNVaX/vdxFPFI/N2i
        AjY9v+WA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:40426)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <linux@armlinux.org.uk>)
        id 1r12Hx-0002KD-09;
        Thu, 09 Nov 2023 10:29:29 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1r12Hv-0000TA-GL; Thu, 09 Nov 2023 10:29:27 +0000
Date:   Thu, 9 Nov 2023 10:29:27 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Shaoqin Huang <shahuang@redhat.com>
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
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH RFC 06/22] drivers: base: Use present CPUs in
 GENERIC_CPU_DEVICES
Message-ID: <ZUy0h/lc3QCPsuU8@shell.armlinux.org.uk>
References: <ZUoRY33AAHMc5ThW@shell.armlinux.org.uk>
 <E1r0JLB-00CTwy-7y@rmk-PC.armlinux.org.uk>
 <f00dd1cf-5b4c-38a8-a337-817d474d53d1@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f00dd1cf-5b4c-38a8-a337-817d474d53d1@redhat.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2023 at 06:09:32PM +0800, Shaoqin Huang wrote:
> Hi Russell,
> 
> On 11/7/23 18:29, Russell King (Oracle) wrote:
> > From: James Morse <james.morse@arm.com>
> > 
> > Three of the five ACPI architectures create sysfs entries using
> > register_cpu() for present CPUs, whereas arm64, riscv and all
> > GENERIC_CPU_DEVICES do this for possible CPUs.
> > 
> > Registering a CPU is what causes them to show up in sysfs.
> > 
> > It makes very little sense to register all possible CPUs. Registering
> > a CPU is what triggers the udev notifications allowing user-space to
> > react to newly added CPUs.
> > 
> > To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
> > it to use for_each_present_cpu(). Making the ACPI architectures use
> > GENERIC_CPU_DEVICES is a pre-requisite step to centralise their
> > cpu_register() logic, before moving it into the ACPI processor driver.
> > When ACPI is disabled this work would be done by
> > cpu_dev_register_generic().
> 
> What do you actually mean about when ACPI is disabled this work would be

Firstly, please note that "you" is not appropriate here. This is James'
commit message, not mine.

> done by cpu_dev_register_generic()? Is the work means register the cpu?

When ACPI is disabled _and_ CONFIG_GENERIC_CPU_DEVICES is enabled, then
cpu_dev_register_generic() will call arch_register_cpu() for each present
CPU after this commit, rather than for each _possible_ CPU (which is the
actual code change here.)

> I'm not quite understand that, and how about when ACPI is enabled, which
> function do this work?

This is what happens later in the series.

"drivers: base: Allow parts of GENERIC_CPU_DEVICES to be overridden"
adds a test for CONFIG_GENERIC_CPU_DEVICES, so this will only be used
with architectures using GENERIC_CPU_DEVICES. Then in:

"ACPI: processor: Register all CPUs from acpi_processor_get_info()"
which is not part of this series, this adds a call to arch_register_cpu()
in the ACPI code, and disables this path via a test for !acpi_disabled.

Essentially, this path gets used to register the present CPUs when
firmware (ACPI) isn't going to be registering the present CPUs.

I've changed this to:

"It makes very little sense to register all possible CPUs. Registering
a CPU is what triggers the udev notifications allowing user-space to
react to newly added CPUs.

"To allow all five ACPI architectures to use GENERIC_CPU_DEVICES, change
it to use for_each_present_cpu().

"Making the ACPI architectures use GENERIC_CPU_DEVICES is a pre-requisite
step to centralise their register_cpu() logic, before moving it into the
ACPI processor driver. When we add support for register CPUs from ACPI
in a later patch, we will avoid registering CPUs in this path."

which I hope makes it clearer.

> > After this change, openrisc and hexagon systems that use the max_cpus
> > command line argument would not see the other CPUs present in sysfs.
> > This should not be a problem as these CPUs can't bre brought online as
>                                              ^ nit: can't be

Thanks, I'll fix that.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
