Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A33047BE6AF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 18:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377672AbjJIQjO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 12:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377684AbjJIQjM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 12:39:12 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A009E;
        Mon,  9 Oct 2023 09:39:11 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1CB6C433C8;
        Mon,  9 Oct 2023 16:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696869551;
        bh=7z+60XSm3ueWD/Rb4nlz+Vx6kE/PtSD/zyuDb2uuKVA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=ZeVwvbsew4OBEZgXJbPtLKAoeYKvOgZkxARjbRxOkfq+0LfDHeRfil98CBH72p960
         YjDTKW3IlcfIXN2oPpobCBvVx02vEu//3oNTujV5HUyFWGaN0EegpK5bp9nP4uB7ho
         N+9qDwcb5sCjWAZxWLkLR2SQB/VB/6/1etaipdB03FIHyUi7vSFVUSdaSqXxO5KofO
         TH7XD4fsOj2jSu9X47H9zI3NdtL4vS4XbezbTztgt/1sa0HjdX1hEhComZJnwzBN8J
         PizzHSQ8phs9zxf3aR1/oVWYtePxjmax6lLe74PgEAHWAiaWo//cJxOoBWfTDbvzdW
         Ikx1Wc5spCLHA==
Date:   Mon, 9 Oct 2023 11:39:09 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Bjorn Helgaas <bhelgaas@google.com>
Subject: Re: [resend, PATCH v1 1/1] PCI: Update the devres documentation
 regarding to pcim_*()
Message-ID: <20231009163909.GA939056@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231006150634.3444251-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 06, 2023 at 06:06:34PM +0300, Andy Shevchenko wrote:
> There were many changes to PCI core in scope of managed resources APIs.
> Update documentation to list the current state of affairs.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Looks good.

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  Documentation/driver-api/driver-model/devres.rst | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
> index 8be086b3f829..c5f99d834ec5 100644
> --- a/Documentation/driver-api/driver-model/devres.rst
> +++ b/Documentation/driver-api/driver-model/devres.rst
> @@ -322,10 +322,8 @@ IOMAP
>    devm_platform_ioremap_resource_byname()
>    devm_platform_get_and_ioremap_resource()
>    devm_iounmap()
> -  pcim_iomap()
> -  pcim_iomap_regions()	: do request_region() and iomap() on multiple BARs
> -  pcim_iomap_table()	: array of mapped addresses indexed by BAR
> -  pcim_iounmap()
> +
> +  Note: For the PCI devices the specific pcim_*() functions may be used, see below.
>  
>  IRQ
>    devm_free_irq()
> @@ -392,8 +390,16 @@ PCI
>    devm_pci_alloc_host_bridge()  : managed PCI host bridge allocation
>    devm_pci_remap_cfgspace()	: ioremap PCI configuration space
>    devm_pci_remap_cfg_resource()	: ioremap PCI configuration space resource
> +
>    pcim_enable_device()		: after success, all PCI ops become managed
> +  pcim_iomap()			: do iomap() on a single BAR
> +  pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
> +  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
> +  pcim_iomap_table()		: array of mapped addresses indexed by BAR
> +  pcim_iounmap()		: do iounmap() on a single BAR
> +  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
>    pcim_pin_device()		: keep PCI device enabled after release
> +  pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
>  
>  PHY
>    devm_usb_get_phy()
> -- 
> 2.40.0.1.gaa8946217a0b
> 
