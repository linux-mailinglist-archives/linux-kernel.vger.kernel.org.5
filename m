Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 194FB7E92FD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 23:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231906AbjKLWu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 17:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbjKLWuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 17:50:54 -0500
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEC3211B;
        Sun, 12 Nov 2023 14:50:51 -0800 (PST)
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-581fb6f53fcso2404169eaf.2;
        Sun, 12 Nov 2023 14:50:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699829451; x=1700434251;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TWAcZjn7Ch1o5An0rWKeLYCmQj8qOToDak4kAyPRN+c=;
        b=F9lYdgSTHFYPcbFWhexOWfnPlFk5Cm0i7TYLzRcOuZPgk58zyFP4KtuPLYCG0vBKLo
         YuxW/+wn1mpu4YtfnvJa/OkDTF5YTzaX2jZADaOtb5zbSsheVbn9lwUdLU1uxigoEI7v
         3fRKhcnWhY2CzITiPVqsziS/xetu1MxpNQOVQKdiK+0vU5BhV9sxjtUMRCf0dm9kYtgd
         QisCXvIubWlI8hCtcqKZeCNqn9qdjb+oMScWSPQ6YKkgCUCa6TvWQ+sb5rENXQL6f1jW
         FF9qglSswoqZktLbpW88qMIN8YsIBURZCq0pujCSGHnDW2KTHAQsoFIsxxiBE20s7Gqp
         nBfw==
X-Gm-Message-State: AOJu0YyunDY6UgPIAuGnJIx7AI/B+IGT8EQViKiZiqEuMyDJnBge/CXy
        i0Z73uxi0jiBDJ5N9qlkjMc=
X-Google-Smtp-Source: AGHT+IGo2RiylimHuPe/oLxdgA5A6mxB5zhFxni/J0Tva1sb+ZLh8EiRnAbmrg9yRAs6NAIgKhC1LA==
X-Received: by 2002:a05:6871:4e8b:b0:1ea:29a:8628 with SMTP id uk11-20020a0568714e8b00b001ea029a8628mr6345251oab.15.1699829450797;
        Sun, 12 Nov 2023 14:50:50 -0800 (PST)
Received: from liuwe-devbox-debian-v2 ([20.69.120.36])
        by smtp.gmail.com with ESMTPSA id z4-20020a170902708400b001c739768214sm2972963plk.92.2023.11.12.14.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 14:50:50 -0800 (PST)
Date:   Sun, 12 Nov 2023 22:50:48 +0000
From:   Wei Liu <wei.liu@kernel.org>
To:     Saurabh Sengar <ssengar@linux.microsoft.com>
Cc:     kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        decui@microsoft.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, linux-hyperv@vger.kernel.org,
        linux-kernel@vger.kernel.org, ssengar@microsoft.com
Subject: Re: [PATCH v2] x86/hyperv: Fix the detection of E820_TYPE_PRAM in a
 Gen2 VM
Message-ID: <ZVFWyO74GkJZCGR7@liuwe-devbox-debian-v2>
References: <1699691867-9827-1-git-send-email-ssengar@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1699691867-9827-1-git-send-email-ssengar@linux.microsoft.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 12:37:47AM -0800, Saurabh Sengar wrote:
> A Gen2 VM doesn't support legacy PCI/PCIe, so both raw_pci_ops and
> raw_pci_ext_ops are NULL, and pci_subsys_init() -> pcibios_init()
> doesn't call pcibios_resource_survey() -> e820__reserve_resources_late();
> as a result, any emulated persistent memory of E820_TYPE_PRAM (12) via
> the kernel parameter memmap=nn[KMG]!ss is not added into iomem_resource
> and hence can't be detected by register_e820_pmem().
> 
> Fix this by directly calling e820__reserve_resources_late() in
> hv_pci_init(), which is called from arch_initcall(pci_arch_init).
> 
> It's ok to move a Gen2 VM's e820__reserve_resources_late() from
> subsys_initcall(pci_subsys_init) to arch_initcall(pci_arch_init) because
> the code in-between doesn't depend on the E820 resources.
> e820__reserve_resources_late() depends on e820__reserve_resources(),
> which has been called earlier from setup_arch().
> 
> For a Gen-2 VM, the new hv_pci_init() also adds any memory of
> E820_TYPE_PMEM (7) into iomem_resource, and acpi_nfit_register_region() ->
> acpi_nfit_insert_resource() -> region_intersects() returns
> REGION_INTERSECTS, so the memory of E820_TYPE_PMEM won't get added twice.
> 
> Changed the local variable "int gen2vm" to "bool gen2vm".
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Dexuan Cui <decui@microsoft.com>

Applied to hyperv-fixes. Thanks.
