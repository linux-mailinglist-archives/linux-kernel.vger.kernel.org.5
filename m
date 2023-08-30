Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D6978E221
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:11:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245229AbjH3WLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:11:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245221AbjH3WLA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:11:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57A11A2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 15:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693433430; x=1724969430;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=9It6jt9oDe1EBkxKoqHIUD8hifyfi+HEqqJzI/Dk/lY=;
  b=DIiG7fJ1GhrefKjYrJnTn87wLmtze/LtsG+uFB4OHdqgV4yDKFgIvFik
   i1nZ4kaGZctThZ4QB6jbAdE8GaZj97/9D7/7tQLcFcpPX7b01EJfkPvms
   f27GaHYyaFBpRcH3xt5QMokzOERJ1FKOP43eKCidu9YFAenDIkm8XDPYB
   Whb/OaWSbHqHo6BSaDMTwbNTTeeYXZqqST7A1hErUC8ktGyI6w2hYOD5M
   C0CGZs1XO4j321GoR6Nm2+xH1X4hYMJrTr7BE+6TPA8W9BCpfIcrk8pL3
   VB6B+OsFOigPCKk3Kn4Z54bDL1LgHq3UwG6BcE3cd2MMkj+CdEzBlqSq2
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378476155"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="378476155"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:09:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="829382326"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="829382326"
Received: from asehgal1-mobl.amr.corp.intel.com (HELO [10.212.136.74]) ([10.212.136.74])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:08:53 -0700
Message-ID: <7333e392-a557-49e4-a457-067f18d12139@linux.intel.com>
Date:   Wed, 30 Aug 2023 15:08:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] configfs-tsm: Introduce a shared ABI for
 attestation reports
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Peter Gonda <pgonda@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Samuel Ortiz <sameo@rivosinc.com>, peterz@infradead.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <169342400469.3934343.12316161608372095860.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI,

On 8/30/2023 12:33 PM, Dan Williams wrote:
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
> The proposal, targeted to conceptually work with TDX, SEV-SNP, COVE if
> not more, is to define a configfs interface to retrieve the TSM-specific
> blob.
> 
>     report=/sys/kernel/config/tsm/report/report0
>     mkdir $report
>     dd if=binary_userdata_plus_nonce > $report/inblob
>     hexdump $report/outblob
> 
> This approach later allows for the standardization of the attestation
> blob format without needing to invent a new ABI. Once standardization
> happens the standard format can be emitted by $report/outblob and
> indicated by $report/provider, or a new attribute like
> "$report/tcg_coco_report" can emit the standard format alongside the
> vendor format.
> 
> Review of previous iterations of this interface identified that there is
> a need to scale report generation for multiple container environments
> [2]. Configfs enables a model where each container can bind mount one or
> more report generation item instances. Still, within a container only a
> single thread can be manipulating a given configuration instance at a
> time. A 'generation' count is provided to detect conflicts between
> multiple threads racing to configure a report instance.
> 
> The SEV-SNP concepts of "extended reports" and "privilege levels" are
> optionally enabled by selecting 'tsm_report_ext_type' at register_tsm()
> time. The expectation is that those concepts are generic enough that
> they may be adopted by other TSM implementations. In other words,
> configfs-tsm aims to address a superset of TSM specific functionality
> with a common ABI where attributes may appear, or not appear, based on the set
> of concepts the implementation supports.
> 
> Link: http://lore.kernel.org/r/64961c3baf8ce_142af829436@dwillia2-xfh.jf.intel.com.notmuch [1]
> Link: http://lore.kernel.org/r/57f3a05e-8fcd-4656-beea-56bb8365ae64@linux.microsoft.com [2]
> Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
> Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> Cc: Peter Gonda <pgonda@google.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Samuel Ortiz <sameo@rivosinc.com>
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---
>  Documentation/ABI/testing/configfs-tsm |   68 ++++++
>  MAINTAINERS                            |    8 +
>  drivers/virt/coco/Kconfig              |    5 
>  drivers/virt/coco/Makefile             |    1 
>  drivers/virt/coco/tdx-guest/Kconfig    |    1 
>  drivers/virt/coco/tsm.c                |  391 ++++++++++++++++++++++++++++++++
>  include/linux/tsm.h                    |   54 ++++
>  7 files changed, 528 insertions(+)
>  create mode 100644 Documentation/ABI/testing/configfs-tsm
>  create mode 100644 drivers/virt/coco/tsm.c
>  create mode 100644 include/linux/tsm.h
> 
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> new file mode 100644
> index 000000000000..0f137039643b
> --- /dev/null
> +++ b/Documentation/ABI/testing/configfs-tsm
> @@ -0,0 +1,68 @@
> +What:		/sys/kernel/config/tsm/report/$name/inblob
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) Up to 64 bytes of user specified binary data. For replay
> +		protection this should include a nonce, but the kernel does not
> +		place any restrictions on the content.
> +
> +What:		/sys/kernel/config/tsm/report/$name/outblob
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) Binary attestation report generated from @inblob and other
> +		options The format of the report is implementation specific
> +		(modulo options like @format and @privlevel) where the
> +		implementation is conveyed via the @provider attribute.
> +
> +What:		/sys/kernel/config/tsm/report/$name/provider
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) A name for the format-specification of @outblob like
> +		"sev-snp" or "tdx" in the near term, or a common standard format
> +		in the future.
> +
> +What:		/sys/kernel/config/tsm/report/$name/generation
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) The value in this attribute increments each time @inblob or
> +		any option is written. Userspace can detect conflicts by
> +		checking generation before writing to any attribute and making
> +		sure the number of writes matches expectations after reading
> +		@outblob, or it can prevent conflicts by creating a report
> +		instance per requesting context.
> +
> +What:		/sys/kernel/config/tsm/report/$name/privlevel
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) If a TSM implementation supports the concept of attestation
> +		reports for TVMs running at different privilege levels, like
> +		SEV-SNP "VMPL", specify the privilege level via this attribute.
> +		The minimum acceptable value is conveyed via @privlevel_floor
> +		and the maximum acceptable value is TSM_PRIVLEVEL_MAX (3).
> +
> +What:		/sys/kernel/config/tsm/report/$name/privlevel_floor
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RO) Indicates the minimum permissible value that can be written
> +		to @privlevel.
> +
> +What:		/sys/kernel/config/tsm/report/$name/format
> +Date:		August, 2023
> +KernelVersion:	v6.7
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(WO) If a TSM implementation supports the concept of attestation
> +		reports with "extended" contents, like SEV-SNP extended reports
> +		with certificate chains, specify "extended" vs "default" via
> +		this attribute.
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 4cc6bf79fdd8..996122ab62ab 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21671,6 +21671,14 @@ W:	https://github.com/srcres258/linux-doc
>  T:	git git://github.com/srcres258/linux-doc.git doc-zh-tw
>  F:	Documentation/translations/zh_TW/
>  
> +TRUSTED SECURITY MODULE (TSM) ATTESTATION REPORTS
> +M:	Dan Williams <dan.j.williams@intel.com>
> +L:	linux-coco@lists.linux.dev
> +S:	Maintained
> +F:	Documentation/ABI/testing/configfs-tsm
> +F:	drivers/virt/coco/tsm.c
> +F:	include/linux/tsm.h
> +
>  TTY LAYER AND SERIAL DRIVERS
>  M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>  M:	Jiri Slaby <jirislaby@kernel.org>
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> index fc5c64f04c4a..87d142c1f932 100644
> --- a/drivers/virt/coco/Kconfig
> +++ b/drivers/virt/coco/Kconfig
> @@ -2,6 +2,11 @@
>  #
>  # Confidential computing related collateral
>  #
> +
> +config TSM_REPORTS
> +	select CONFIGFS_FS
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

I think it is more appropriate to let TDX support patch add it. Agree?

>  	help
>  	  The driver provides userspace interface to communicate with
>  	  the TDX module to request the TDX guest details like attestation
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> new file mode 100644
> index 000000000000..da19257797d7
> --- /dev/null
> +++ b/drivers/virt/coco/tsm.c
> @@ -0,0 +1,391 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/* Copyright(c) 2023 Intel Corporation. All rights reserved. */
> +
> +#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> +
> +#include <linux/tsm.h>
> +#include <linux/err.h>
> +#include <linux/slab.h>
> +#include <linux/rwsem.h>
> +#include <linux/string.h>
> +#include <linux/module.h>
> +#include <linux/cleanup.h>
> +#include <linux/configfs.h>
> +
> +static struct tsm_provider {
> +	const struct tsm_ops *ops;
> +	const struct config_item_type *type;
> +	void *data;
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
> + * materializes that can be published instead of the vendor layout. Until then
> + * the 'provider' attribute indicates the format of 'outblob'.
> + */
> +
> +/**
> + * struct tsm_report - track state of report generation relative to options
> + * @desc: report generation options / cached report state
> + * @outblob: generated evidence to provider to the attestation agent
> + * @outblob_len: sizeof(outblob)
> + * @write_generation: conflict detection, and report regeneration tracking
> + * @read_generation: cached report invalidation tracking
> + * @cfg: configfs interface
> + */
> +struct tsm_report {
> +	struct tsm_desc desc;
> +	size_t outblob_len;
> +	u8 *outblob;
> +	unsigned long write_generation;
> +	unsigned long read_generation;
> +	struct config_item cfg;
> +};
> +
> +static struct tsm_report *to_tsm_report(struct config_item *cfg)
> +{
> +	return container_of(cfg, struct tsm_report, cfg);
> +}
> +
> +static int try_advance_write_generation(struct tsm_report *report)
> +{
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	/*
> +	 * malicious or broken userspace is attempting to wrap read_generation,
> +	 * stop accepting updates until current report configuration is read.
> +	 */
> +	if (report->write_generation == report->read_generation - 1)
> +		return -EBUSY;
> +	report->write_generation++;
> +	return 0;
> +}
> +
> +static ssize_t tsm_report_privlevel_store(struct config_item *cfg,
> +					  const char *buf, size_t len)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	/*
> +	 * The valid privilege levels that a TSM might accept, if it accepts a
> +	 * privilege level setting at all, are a max of TSM_PRIVLEVEL_MAX (see
> +	 * SEV-SNP GHCB) and a minimum of a TSM selected floor value no less
> +	 * than 0.
> +	 */
> +	if (provider.ops->privlevel_floor > val || val > TSM_PRIVLEVEL_MAX)
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	rc = try_advance_write_generation(report);
> +	if (rc)
> +		return rc;
> +	report->desc.privlevel = val;
> +
> +	return len;
> +}
> +CONFIGFS_ATTR_WO(tsm_report_, privlevel);
> +
> +static ssize_t tsm_report_privlevel_floor_show(struct config_item *cfg,
> +					       char *buf)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	return sysfs_emit(buf, "%u\n", provider.ops->privlevel_floor);
> +}
> +CONFIGFS_ATTR_RO(tsm_report_, privlevel_floor);
> +
> +static ssize_t tsm_report_format_store(struct config_item *cfg, const char *buf,
> +				       size_t len)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +	enum tsm_format format;
> +	int rc;
> +
> +	if (sysfs_streq(buf, "default"))
> +		format = TSM_FORMAT_DEFAULT;
> +	else if (sysfs_streq(buf, "extended"))
> +		format = TSM_FORMAT_EXTENDED;
> +	else
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	rc = try_advance_write_generation(report);
> +	if (rc)
> +		return rc;
> +	report->desc.outblob_format = format;
> +
> +	return len;
> +}
> +CONFIGFS_ATTR_WO(tsm_report_, format);
> +
> +static ssize_t tsm_report_inblob_write(struct config_item *cfg,
> +				       const void *buf, size_t count)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +	int rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	rc = try_advance_write_generation(report);
> +	if (rc)
> +		return rc;
> +
> +	report->desc.inblob_len = count;
> +	memcpy(report->desc.inblob, buf, count);
> +	return count;
> +}
> +CONFIGFS_BIN_ATTR_WO(tsm_report_, inblob, NULL, TSM_INBLOB_MAX);
> +
> +static ssize_t tsm_report_generation_show(struct config_item *cfg, char *buf)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	return sysfs_emit(buf, "%lu\n", report->write_generation);
> +}
> +CONFIGFS_ATTR_RO(tsm_report_, generation);
> +
> +static ssize_t tsm_report_provider_show(struct config_item *cfg, char *buf)
> +{
> +	guard(rwsem_read)(&tsm_rwsem);
> +	return sysfs_emit(buf, "%s\n", provider.ops->name);
> +}
> +CONFIGFS_ATTR_RO(tsm_report_, provider);
> +
> +static ssize_t read_cached_report(struct tsm_report *report, void *buf, size_t count)
> +{
> +	loff_t offset = 0;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!report->desc.inblob_len)
> +		return -EINVAL;
> +
> +	if (!report->outblob ||
> +	    report->read_generation != report->write_generation)
> +		return -EWOULDBLOCK;
> +
> +	if (!buf)
> +		return report->outblob_len;
> +	return memory_read_from_buffer(buf, count, &offset, report->outblob,
> +				       report->outblob_len);
> +}
> +
> +static ssize_t tsm_report_outblob_read(struct config_item *cfg, void *buf,
> +				       size_t count)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +	const struct tsm_ops *ops;
> +	size_t outblob_len;
> +	loff_t offset = 0;
> +	u8 *outblob;
> +	ssize_t rc;
> +
> +	/* try to read from the existing report if present and valid... */
> +	rc = read_cached_report(report, buf, count);
> +	if (rc >= 0 || rc != -EWOULDBLOCK)
> +		return rc;
> +
> +	/* slow path, report may need to be regenerated... */
> +	guard(rwsem_write)(&tsm_rwsem);
> +	ops = provider.ops;
> +	if (!report->desc.inblob_len)
> +		return -EINVAL;
> +
> +	/* did another thread already generate this report? */
> +	if (report->outblob &&
> +	    report->read_generation == report->write_generation)
> +		goto out;
> +
> +	kvfree(report->outblob);
> +	report->outblob = NULL;
> +	outblob = ops->report_new(&report->desc, provider.data, &outblob_len);
> +	if (IS_ERR(outblob))
> +		return PTR_ERR(outblob);
> +	report->outblob_len = outblob_len;
> +	report->outblob = outblob;
> +	report->read_generation = report->write_generation;
> +
> +out:
> +	if (!buf)
> +		return report->outblob_len;
> +	return memory_read_from_buffer(buf, count, &offset, report->outblob,
> +				       report->outblob_len);
> +}
> +CONFIGFS_BIN_ATTR_RO(tsm_report_, outblob, NULL, TSM_OUTBLOB_MAX);
> +
> +#define TSM_DEFAULT_ATTRS() \
> +	&tsm_report_attr_generation, \
> +	&tsm_report_attr_provider
> +
> +static struct configfs_attribute *tsm_report_attrs[] = {
> +	TSM_DEFAULT_ATTRS(),
> +	NULL,
> +};
> +
> +static struct configfs_bin_attribute *tsm_report_bin_attrs[] = {
> +	&tsm_report_attr_inblob,
> +	&tsm_report_attr_outblob,
> +	NULL,
> +};
> +
> +static struct configfs_attribute *tsm_report_extra_attrs[] = {
> +	TSM_DEFAULT_ATTRS(),
> +	&tsm_report_attr_format,
> +	&tsm_report_attr_privlevel,
> +	&tsm_report_attr_privlevel_floor,
> +	NULL,
> +};
> +
> +static void tsm_report_item_release(struct config_item *cfg)
> +{
> +	struct tsm_report *report = to_tsm_report(cfg);
> +
> +	kvfree(report->outblob);
> +	kfree(report);
> +}
> +
> +static struct configfs_item_operations tsm_report_item_ops = {
> +	.release = tsm_report_item_release,
> +};
> +
> +const struct config_item_type tsm_report_default_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_bin_attrs = tsm_report_bin_attrs,
> +	.ct_attrs = tsm_report_attrs,
> +	.ct_item_ops = &tsm_report_item_ops,
> +};
> +EXPORT_SYMBOL_GPL(tsm_report_default_type);
> +
> +const struct config_item_type tsm_report_ext_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_bin_attrs = tsm_report_bin_attrs,
> +	.ct_attrs = tsm_report_extra_attrs,
> +	.ct_item_ops = &tsm_report_item_ops,
> +};
> +EXPORT_SYMBOL_GPL(tsm_report_ext_type);
> +
> +static struct config_item *tsm_report_make_item(struct config_group *group,
> +						const char *name)
> +{
> +	struct tsm_report *report;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!provider.ops)
> +		return ERR_PTR(-ENXIO);
> +
> +	report = kzalloc(sizeof(*report), GFP_KERNEL);
> +	if (!report)
> +		return ERR_PTR(-ENOMEM);
> +
> +	config_item_init_type_name(&report->cfg, name, provider.type);
> +	return &report->cfg;
> +}
> +
> +static struct configfs_group_operations tsm_report_group_ops = {
> +	.make_item = tsm_report_make_item,
> +};
> +
> +static const struct config_item_type tsm_reports_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_group_ops = &tsm_report_group_ops,
> +};
> +
> +static const struct config_item_type tsm_root_group_type = {
> +	.ct_owner = THIS_MODULE,
> +};
> +
> +static struct configfs_subsystem tsm_configfs = {
> +	.su_group = {
> +		.cg_item = {
> +			.ci_namebuf = "tsm",
> +			.ci_type = &tsm_root_group_type,
> +		},
> +	},
> +	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
> +};
> +
> +static struct config_group *tsm_report_group;
> +
> +int register_tsm(const struct tsm_ops *ops, void *priv,
> +		 const struct config_item_type *type)
> +{
> +	const struct tsm_ops *conflict;
> +
> +	if (!type)
> +		type = &tsm_report_default_type;
> +	if (!(type == &tsm_report_default_type || type == &tsm_report_ext_type))
> +		return -EINVAL;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +	conflict = provider.ops;
> +	if (conflict) {
> +		pr_err("\"%s\" ops already registered\n", conflict->name);
> +		return -EBUSY;
> +	}
> +
> +	provider.ops = ops;
> +	provider.data = priv;
> +	provider.type = type;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(register_tsm);
> +
> +int unregister_tsm(const struct tsm_ops *ops)
> +{
> +	guard(rwsem_write)(&tsm_rwsem);
> +	if (ops != provider.ops)
> +		return -EBUSY;
> +	provider.ops = NULL;
> +	provider.data = NULL;
> +	provider.type = NULL;
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(unregister_tsm);
> +
> +static int __init tsm_init(void)
> +{
> +	struct config_group *root = &tsm_configfs.su_group;
> +	struct config_group *tsm;
> +	int rc;
> +
> +	config_group_init(root);
> +	rc = configfs_register_subsystem(&tsm_configfs);
> +	if (rc)
> +		return rc;
> +
> +	tsm = configfs_register_default_group(root, "report",
> +					      &tsm_reports_type);
> +	if (IS_ERR(tsm)) {
> +		configfs_unregister_subsystem(&tsm_configfs);
> +		return PTR_ERR(tsm);
> +	}
> +	tsm_report_group = tsm;
> +
> +	return 0;
> +}
> +module_init(tsm_init);
> +
> +static void __exit tsm_exit(void)
> +{
> +	configfs_unregister_default_group(tsm_report_group);
> +	configfs_unregister_subsystem(&tsm_configfs);
> +}
> +module_exit(tsm_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("Provide Trusted Security Module attestation reports via configfs");
> diff --git a/include/linux/tsm.h b/include/linux/tsm.h
> new file mode 100644
> index 000000000000..4b110b69a330
> --- /dev/null
> +++ b/include/linux/tsm.h
> @@ -0,0 +1,54 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __TSM_H
> +#define __TSM_H
> +
> +#include <linux/sizes.h>
> +#include <linux/types.h>
> +#include <linux/device.h>
> +
> +#define TSM_INBLOB_MAX 64
> +#define TSM_OUTBLOB_MAX SZ_32K
> +
> +/*
> + * Privilege level is a nested permission concept to allow confidential
> + * guests to partition address space, 4-levels are supported.
> + */
> +#define TSM_PRIVLEVEL_MAX 3
> +
> +enum tsm_format {
> +	TSM_FORMAT_DEFAULT,
> +	TSM_FORMAT_EXTENDED,
> +};
> +
> +/**
> + * struct tsm_desc - option descriptor for generating tsm report blobs
> + * @privlevel: optional privilege level to associate with @outblob
> + * @inblob_len: sizeof @inblob
> + * @inblob: arbitrary input data
> + * @outblob_format: for TSMs with an "extended" format
> + */
> +struct tsm_desc {
> +	unsigned int privlevel;
> +	size_t inblob_len;
> +	u8 inblob[TSM_INBLOB_MAX];
> +	enum tsm_format outblob_format;
> +};
> +
> +/*
> + * arch specific ops, only one is expected to be registered at a time
> + * i.e. only one of SEV, TDX, COVE, etc.
> + */
> +struct tsm_ops {
> +	const char *name;
> +	const int privlevel_floor;
> +	u8 *(*report_new)(const struct tsm_desc *desc, void *data,
> +			  size_t *outblob_len);
> +};
> +
> +extern const struct config_item_type tsm_report_ext_type;
> +extern const struct config_item_type tsm_report_default_type;
> +
> +int register_tsm(const struct tsm_ops *ops, void *priv,
> +		 const struct config_item_type *type);
> +int unregister_tsm(const struct tsm_ops *ops);
> +#endif /* __TSM_H */
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
