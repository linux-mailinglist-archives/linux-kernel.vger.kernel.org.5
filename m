Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB86877BD35
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 17:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbjHNPim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 11:38:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjHNPiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 11:38:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53C2110D1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 08:38:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D952D63D7F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 15:38:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E173FC433CC;
        Mon, 14 Aug 2023 15:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1692027497;
        bh=TL3rZfF0FKoq/lNVrgEvxq3en07R8VjDiuGdt8fphQw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fK/m3s4GpGdYM772ZF+9Uw1Acxq1lvLyzgILR8GX3rfdwvIBvcKE3d0pp9d/evWxH
         ZxvarwnOQacBfJJp5DZZocx01Q+Et612HI2NTSug7jkcB9lKj2DiKBP7FH5iwpY6tk
         d1rZd+QlW9sWVfIvyn5u5xGB89NT7SJfH204ebRo=
Date:   Mon, 14 Aug 2023 17:38:14 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     linux-coco@lists.linux.dev,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] tsm: Introduce a shared ABI for attestation
 reports
Message-ID: <2023081432-evade-proofing-fb8c@gregkh>
References: <169199898909.1782217.10899362240465838600.stgit@dwillia2-xfh.jf.intel.com>
 <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169199900110.1782217.12112722316618515086.stgit@dwillia2-xfh.jf.intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:43:21AM -0700, Dan Williams wrote:
> One of the common operations of a TSM (Trusted Security Module) is to
> provide a way for a TVM (confidential computing guest execution
> environment) to take a measurement of its launch state, sign it and
> submit it to a verifying party. Upon successful attestation that
> verifies the integrity of the TVM additional secrets may be deployed.
> The concept is common across TSMs, but the implementations are
> unfortunately vendor specific. While the industry grapples with a common
> definition of this attestation format [1], Linux need not make this
> problem worse by defining a new ABI per TSM that wants to perform a
> similar operation. The current momentum has been to invent new ioctl-ABI
> per TSM per function which at best is an abdication of the kernel's
> responsibility to make common infrastructure concepts share common ABI.
> 
> The proposal, targeted to conceptually work with TDX, SEV, COVE if not
> more, is to define a sysfs interface to retrieve the TSM-specific blob.
> 
>     echo $hex_encoded_userdata_plus_nonce > /sys/class/tsm/tsm0/inhex
>     hexdump /sys/class/tsm/tsm0/outblob

Why is one way a hex-encode file, that the kernel has to parse, and the
other not?  Binary sysfs files should be "pass through" if at all
possible, why not make them both binary and not mess with hex at all?
That keeps the kernel simpler, and if userspace wants the hex format,
they can provide it much easier (with less potential parsing errors).

> 
> This approach later allows for the standardization of the attestation
> blob format without needing to change the Linux ABI. Until then, the
> format of 'outblob' is determined by the parent device for 'tsm0'.
> 
> The expectation is that this is a boot time exchange that need not be
> regenerated, making it amenable to a sysfs interface. In case userspace
> does try to generate multiple attestation reports it includes conflict
> detection so userspace can be sure no other thread changed the
> parameters from its last configuration step to the blob retrieval.
> 
> TSM specific options are encoded as 'extra' attributes on the TSM device
> with the expectation that vendors reuse the same options for similar
> concepts. The current options are defined by SEV-SNP's need for a
> 'privilege level' concept (VMPL), and the option to retrieve a
> certificate chain in addition to the attestation report ("extended"
> format).
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/sysfs-class-tsm |   47 +++++
>  MAINTAINERS                               |    8 +
>  drivers/virt/coco/Kconfig                 |    4 
>  drivers/virt/coco/Makefile                |    1 
>  drivers/virt/coco/tdx-guest/Kconfig       |    1 
>  drivers/virt/coco/tsm.c                   |  290 +++++++++++++++++++++++++++++
>  include/linux/tsm.h                       |   45 +++++
>  7 files changed, 396 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-class-tsm
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 include/linux/tsm.h
> 
> diff --git a/Documentation/ABI/testing/sysfs-class-tsm b/Documentation/ABI/testing/sysfs-class-tsm
> new file mode 100644
> index 000000000000..37017bde626d
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-class-tsm
> @@ -0,0 +1,47 @@
> +What:		/sys/class/tsm/tsm0/inhex
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) Hex encoded userdata to be included in the attestation
> +		report. For replay protection this should include a nonce, but
> +		the kernel does not place any restrictions on the content.

"inhex" and it's read/write?  Naming is hard :(


> +
> +What:		/sys/class/tsm/tsm0/outblob
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Binary attestation report generated from @inhex translated
> +		to binary and any options. The format of the report is vendor
> +		specific and determined by the parent device of 'tsm0'.
> +
> +What:		/sys/class/tsm/tsm0/generation
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) The value in this attribute increments each time @inhex or
> +		any option is written. Userspace can detect conflicts by
> +		checking generation before writing to any attribute and making
> +		sure the number of writes matches expectations after reading
> +		@outblob.
> +
> +What:		/sys/class/tsm/tsm0/privlevel
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) If a TSM implementation supports the concept of attestation
> +		reports for TVMs running at different privilege levels, like
> +		SEV-SNP "VMPL", specify the privilege level via this attribute.

Where is the list of potential values for this file at?

> +
> +What:		/sys/class/tsm/tsm0/format
> +Date:		August, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RW) If a TSM implementation supports the concept of attestation
> +		reports with "extended" contents, like SEV-SNP extended reports
> +		with certificate chains, specify "extended" vs "default" via
> +		this attribute.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 3be1bdfe8ecc..97f74d344c8a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21625,6 +21625,14 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> +TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
> +M:	Dan Williams <dan.j.williams@intel.com>
> +L:	linux-coco@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/ABI/testing/sysfs-class-tsm
> +F:	drivers/virt/coco/tsm.c
> +F:	include/linux/tsm.h
> +
>  TTY LAYER
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index fc5c64f04c4a..d92f07019f38 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -2,6 +2,10 @@
>  #
>  # Confidential computing related collateral
>  #
> +
> +config TSM_REPORTS
> +	tristate
> +
>  source "drivers/virt/coco/efi_secret/Kconfig"
>  
>  source "drivers/virt/coco/sev-guest/Kconfig"
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> index 55302ef719ad..18c1aba5edb7 100644
> --- a/drivers/virt/coco/Makefile
> +++ b/drivers/virt/coco/Makefile
> @@ -2,6 +2,7 @@
>  #
>  # Confidential computing related collateral
>  #
> +obj-$(CONFIG_TSM_REPORTS)	+= tsm.o
>  obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
>  obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
>  obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> diff --git a/drivers/virt/coco/tdx-guest/Kconfig b/drivers/virt/coco/tdx-guest/Kconfig
> index 14246fc2fb02..22dd59e19431 100644
> --- a/drivers/virt/coco/tdx-guest/Kconfig
> +++ b/drivers/virt/coco/tdx-guest/Kconfig
> @@ -1,6 +1,7 @@
>  config TDX_GUEST_DRIVER
>  	tristate "TDX Guest driver"
>  	depends on INTEL_TDX_GUEST
> +	select TSM_REPORTS
>  	help
>  	  The driver provides userspace interface to communicate with
>  	  the TDX module to request the TDX guest details like attestation
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> new file mode 100644
> index 000000000000..1bf2ee82eb94
> --- /dev/null
> +++ b/drivers/virt/coco/tsm.c
> @@ -0,0 +1,290 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/rwsem.h>
> +#include <linux/device.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +
> +struct class *tsm_class;

Nit, we are moving away from using class_create(), please make this a
const static class and register it with the driver core instead.  That
way we don't have to fix it up in the future when we finally catch up
with all of the existing class_create() calls we have left.

See the patches in this -rc cycle for a bunch of them already, with many
more on lkml for examples of how to convert this.  Here's one example:
	https://lore.kernel.org/r/20230810174618.7844-1-ivan.orlov0322@gmail.com

> +static struct tsm_provider {
> +	const struct tsm_ops *ops;
> +	struct device *dev;
> +} provider;
> +static DECLARE_RWSEM(tsm_rwsem);
> +
> +/**
> + * DOC: Trusted Security Module (TSM) Attestation Report Interface
> + *
> + * The TSM report interface is a common provider of blobs that facilitate
> + * attestation of a TVM (confidential computing guest) by an attestation
> + * service. A TSM report combines a user-defined blob (likely a public-key with
> + * a nonce for a key-exchange protocol) with a signed attestation report. That
> + * combined blob is then used to obtain secrets provided by an agent that can
> + * validate the attestation report. The expectation is that this interface is
> + * invoked infrequently, likely only once at TVM boot time.
> + *
> + * The attestation report format is TSM provider specific, when / if a standard
> + * materializes that can be published instead of the vendor layout.

Published where?

> +/*
> + * Input is a small hex blob, rather than a writable binary attribute, so that
> + * it is conveyed atomically.
> + */
> +static ssize_t inhex_store(struct device *dev, struct device_attribute *attr,
> +			   const char *buf, size_t len)
> +{
> +	u8 inblob[TSM_INBLOB_MAX];

Can this get too big for the stack?

> +static ssize_t inhex_show(struct device *dev, struct device_attribute *attr,
> +			  char *buf)
> +{
> +	char *end;
> +
> +	guard(rwsem_read)(&tsm_rwsem);

I like seeing the guard() usage, very nice :)

Overall, the sysfs api is ok, except for the hex values, which is easy
to change.  The usage of sysfs is ok as well, no complaints from me
there.

thanks,

greg k-h
