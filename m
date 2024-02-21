Return-Path: <linux-kernel+bounces-75086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 92E0285E2DE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 17:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE06CB223C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 16:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FABC8175F;
	Wed, 21 Feb 2024 16:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GcbRNF9h"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629B98120D;
	Wed, 21 Feb 2024 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708532224; cv=none; b=RrfBDBy9znifJ7hQHaFeyJVc6AmUsBpzM8YJSLRfTjseYQT5a/RIuOHbLpXPjVWj5Ikm4NqIYrDqPl0mdzK3Gv+ZW8GWpJhjsDfVnAUHUH5vVYJEknbZsv5zR/gEz0vEOc68sc5BDrUOQClLYQHy52hiw25Bgm3A8SBYZVfzPAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708532224; c=relaxed/simple;
	bh=6fOBDO7iJ8ftT39BIy1ZtWkOJ30pe6Fq4tEA+QJBOqs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=URWoUOJU4eDe6d9OIAnvLdh60r/i+2lATxay7WrenstMsDh8hBBYW/MZsvXUFM1EFC+KDLrcgmg0AGNiKqbGA5tkN1uhGzqJTO1OSG9TPBi8xMHwVG4CLtR+OhcmCSH57yTCwhDfy5ky5nAzWV5NUttenk1fhoYHpAEO+0z2Yp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GcbRNF9h; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708532222; x=1740068222;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6fOBDO7iJ8ftT39BIy1ZtWkOJ30pe6Fq4tEA+QJBOqs=;
  b=GcbRNF9hdgbRzRt+gNUAQzEUSdy1hkA/j+A/67JFaRpXhCIBHH+JrulC
   DWp5RlU9Jlt+3UFPEpiDk1+NebPe/Nt2BNOimtMYqrkYjeel2+3Pcz7j/
   0VjAJphtn5rvregm041wxHfUCyN7Dh5EnGhQBZrmTCB78f2Sm9c4Vxi/k
   05eRNEO1IoE2JRBgZibwDs/YOdpxU2Wu5UXwB/ggm0mKcfR2yXnJLWDFD
   T4J0Auc/pKIr83nNnVBVgbHlQm2zpCVc/O4B6oGD86ae+CKavnCKemdpL
   /kHZ8Z0Ho5EUIrqBzzKFrJNv9lBeGpxjGgVODr6bwGFj9c+11wfkR9gmP
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28142855"
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="28142855"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:17:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,176,1705392000"; 
   d="scan'208";a="36202107"
Received: from slisovsk-mobl.ger.corp.intel.com (HELO himmelriiki) ([10.249.44.9])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 08:16:57 -0800
Date: Wed, 21 Feb 2024 18:16:47 +0200
From: Mikko Ylinen <mikko.ylinen@linux.intel.com>
To: Samuel Ortiz <sameo@rivosinc.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Qinkun Bao <qinkun@google.com>,
	"Yao, Jiewen" <jiewen.yao@intel.com>,
	"Xing, Cedric" <cedric.xing@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, biao.lu@intel.com,
	linux-coco@lists.linux.dev, linux-integrity@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 2/4] tsm: Add RTMRs to the configfs-tsm hierarchy
Message-ID: <ZdYh73NVJ_OR4M9i@himmelriiki>
References: <20240128212532.2754325-1-sameo@rivosinc.com>
 <20240128212532.2754325-3-sameo@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128212532.2754325-3-sameo@rivosinc.com>

Hi,

On Sun, Jan 28, 2024 at 10:25:21PM +0100, Samuel Ortiz wrote:
> RTMRs are defined and managed by their corresponding TSM provider. As
> such, they can be configured through the TSM configfs root.
> 
> An additional `rtmrs` directory is added by default under the `tsm` one,
> where each supported RTMR can be configured:
> 
> mkdir /sys/kernel/config/tsm/rtmrs/rtmr0
> echo 0 > /sys/kernel/config/tsm/rtmrs/rtmr0/index

I implemented the plumbing for TDX to experiment with this patchset a bit
and to try out some ideas for the event logging.

The first mkdir triggers the following, FYI:

[  353.984801] ======================================================
[  353.984805] WARNING: possible circular locking dependency detected
[  353.984808] 6.8.0-rc5+ #14 Not tainted
[  353.984812] ------------------------------------------------------
[  353.984814] mkdir/3374 is trying to acquire lock:
[  353.984817] ffffffff8ae59d90 (tsm_rwsem){++++}-{3:3}, at: tsm_rtmrs_make_item+0x26/0xa0
[  353.984830] 
               but task is already holding lock:
[  353.984832] ffffffff8ae59890 (tsm_configfs.su_mutex){+.+.}-{3:3}, at: configfs_mkdir+0x188/0x470
[  353.984842] 
               which lock already depends on the new lock.

[  353.984845] 
               the existing dependency chain (in reverse order) is:
[  353.984848] 
               -> #1 (tsm_configfs.su_mutex){+.+.}-{3:3}:
[  353.984853]        __lock_acquire+0x4d1/0xbb0
[  353.984861]        lock_acquire+0xcb/0x2b0
[  353.984863]        __mutex_lock+0x9b/0xb80
[  353.984874]        mutex_lock_nested+0x1f/0x30
[  353.984878]        configfs_register_group+0x7b/0x1d0
[  353.984880]        configfs_register_default_group+0x54/0x90
[  353.984883]        tsm_rtmr_register+0xb9/0x140
[  353.984886]        tsm_register+0x89/0xc0
[  353.984888]        tdx_guest_init+0x81/0x110
[  353.984896]        do_one_initcall+0x62/0x370
[  353.984903]        do_initcalls+0xe3/0x1a0
[  353.984909]        kernel_init_freeable+0x2ea/0x400
[  353.984912]        kernel_init+0x1e/0x1c0
[  353.984915]        ret_from_fork+0x3e/0x60
[  353.984921]        ret_from_fork_asm+0x11/0x20
[  353.984925] 
               -> #0 (tsm_rwsem){++++}-{3:3}:
[  353.984929]        check_prev_add+0xed/0xc60
[  353.984931]        validate_chain+0x488/0x530
[  353.984933]        __lock_acquire+0x4d1/0xbb0
[  353.984936]        lock_acquire+0xcb/0x2b0
[  353.984938]        down_read+0x45/0x190
[  353.984941]        tsm_rtmrs_make_item+0x26/0xa0
[  353.984944]        configfs_mkdir+0x349/0x470
[  353.984946]        vfs_mkdir+0x1a5/0x260
[  353.984955]        do_mkdirat+0x83/0x140
[  353.984958]        __x64_sys_mkdir+0x4e/0x70
[  353.984960]        do_syscall_64+0x67/0x110
[  353.984964]        entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  353.984972] 
               other info that might help us debug this:

[  353.984975]  Possible unsafe locking scenario:

[  353.984977]        CPU0                    CPU1
[  353.984980]        ----                    ----
[  353.984982]   lock(tsm_configfs.su_mutex);
[  353.984985]                                lock(tsm_rwsem);
[  353.984988]                                lock(tsm_configfs.su_mutex);
[  353.984991]   rlock(tsm_rwsem);
[  353.984993] 
                *** DEADLOCK ***

[  353.984996] 3 locks held by mkdir/3374:
[  353.984998]  #0: ff3af65b4ae05408 (sb_writers#13){.+.+}-{0:0}, at: filename_create+0x61/0x190
[  353.985006]  #1: ff3af65b492a97f8 (&sb->s_type->i_mutex_key#6/1){+.+.}-{3:3}, at: filename_create+0x9d/
0x190
[  353.985014]  #2: ffffffff8ae59890 (tsm_configfs.su_mutex){+.+.}-{3:3}, at: configfs_mkdir+0x188/0x470
[  353.985020]
               stack backtrace:
[  353.985023] CPU: 36 PID: 3374 Comm: mkdir Not tainted 6.8.0-rc5+ #14
[  353.985027] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 2023.05-2+tdx1.0 11/05/2023
[  353.985031] Call Trace:
[  353.985033]  <TASK>
[  353.985034]  dump_stack_lvl+0x4e/0x90
[  353.985041]  dump_stack+0x14/0x20
[  353.985044]  print_circular_bug+0xec/0x110
[  353.985047]  check_noncircular+0x130/0x150
[  353.985051]  check_prev_add+0xed/0xc60
[  353.985053]  ? add_chain_cache+0x10e/0x2d0
[  353.985059]  validate_chain+0x488/0x530
[  353.985062]  __lock_acquire+0x4d1/0xbb0
[  353.985065]  lock_acquire+0xcb/0x2b0
[  353.985067]  ? tsm_rtmrs_make_item+0x26/0xa0
[  353.985071]  down_read+0x45/0x190
[  353.985074]  ? tsm_rtmrs_make_item+0x26/0xa0
[  353.985094]  tsm_rtmrs_make_item+0x26/0xa0
[  353.985097]  configfs_mkdir+0x349/0x470
[  353.985100]  vfs_mkdir+0x1a5/0x260
[  353.985105]  do_mkdirat+0x83/0x140
[  353.985109]  __x64_sys_mkdir+0x4e/0x70
[  353.985112]  do_syscall_64+0x67/0x110
[  353.985116]  entry_SYSCALL_64_after_hwframe+0x63/0x6b
[  353.985119] RIP: 0033:0x7f35aad19d4b
[  353.985124] Code: 0f 1e fa 48 89 f2 b9 00 01 00 00 48 89 fe bf 9c ff ff ff e9 d7 c6 ff ff 0f 1f 80 00 0
0 00 00 f3 0f 1e fa b8 53 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 05 c3 0f 1f 40 00 48 8b 15 99 40 0e 00 f7
d8
[  353.985132] RSP: 002b:00007ffc3f2ccc78 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
[  353.985139] RAX: ffffffffffffffda RBX: 00007ffc3f2cd5a5 RCX: 00007f35aad19d4b
[  353.985143] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 00007ffc3f2cd5a5
[  353.985147] RBP: 00000000000001ff R08: 00000000000001ff R09: 0000000000000000
[  353.985151] R10: 0000556f33617249 R11: 0000000000000246 R12: 0000000000000000
[  353.985155] R13: 00007ffc3f2cce18 R14: 0000000000000000 R15: 00007ffc3f2cd5a5
[  353.985161]  </TASK>

> 
> An RTMR can not be extended nor read before its configured by assigning
> it an index. It is the TSM backend responsibility and choice to map that
> index to a hardware RTMR.
> 
> Signed-off-by: Samuel Ortiz <sameo@rivosinc.com>
> ---
>  Documentation/ABI/testing/configfs-tsm |  11 ++
>  drivers/virt/coco/tsm.c                | 164 +++++++++++++++++++++++++
>  2 files changed, 175 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/configfs-tsm b/Documentation/ABI/testing/configfs-tsm
> index dd24202b5ba5..590e103a9bcd 100644
> --- a/Documentation/ABI/testing/configfs-tsm
> +++ b/Documentation/ABI/testing/configfs-tsm
> @@ -80,3 +80,14 @@ Contact:	linux-coco@lists.linux.dev
>  Description:
>  		(RO) Indicates the minimum permissible value that can be written
>  		to @privlevel.
> +
> +What:		/sys/kernel/config/tsm/rtmrs/$name/index
> +Date:		January, 2024
> +KernelVersion:	v6.8
> +Contact:	linux-coco@lists.linux.dev
> +Description:
> +		(RW) A Runtime Measurement Register (RTMR) hardware index.
> +                Once created under /sys/kernel/config/tsm/rtmrs/, an RTMR entry
> +                can be mapped to a hardware RTMR by writing into its index
> +                attribute. The TSM provider will then map the configfs entry to
> +                its corresponding hardware register.
> diff --git a/drivers/virt/coco/tsm.c b/drivers/virt/coco/tsm.c
> index 1a8c3c096120..bb9ed2d2accc 100644
> --- a/drivers/virt/coco/tsm.c
> +++ b/drivers/virt/coco/tsm.c
> @@ -419,6 +419,108 @@ static const struct config_item_type tsm_reports_type = {
>  	.ct_group_ops = &tsm_report_group_ops,
>  };
>  
> +static ssize_t tsm_rtmr_index_store(struct config_item *cfg,
> +				    const char *buf, size_t len)
> +{
> +	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
> +	const struct tsm_ops *ops;
> +	unsigned int val;
> +	int rc;
> +
> +	rc = kstrtouint(buf, 0, &val);
> +	if (rc)
> +		return rc;
> +
> +	guard(rwsem_write)(&tsm_rwsem);
> +
> +	/* Index can only be configured once */
> +	if (is_rtmr_configured(rtmr_state))
> +		return -EBUSY;
> +
> +	/* Check that index stays within the TSM provided capabilities */
> +	ops = provider.ops;
> +	if (!ops)
> +		return -ENOTTY;
> +
> +	if (val > ops->capabilities.num_rtmrs - 1)
> +		return -EINVAL;
> +
> +	/* Check that this index is available */
> +	if (tsm_rtmrs->rtmrs[val])
> +		return -EINVAL;
> +
> +	rtmr_state->index = val;
> +	rtmr_state->alg = ops->capabilities.rtmrs[val].hash_alg;
> +
> +	tsm_rtmrs->rtmrs[val] = rtmr_state;
> +
> +	return len;
> +}
> +
> +static ssize_t tsm_rtmr_index_show(struct config_item *cfg,
> +				   char *buf)
> +{
> +	struct tsm_rtmr_state *rtmr_state = to_tsm_rtmr_state(cfg);
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +
> +	/* An RTMR is not available if it has not been configured */
> +	if (!is_rtmr_configured(rtmr_state))
> +		return -ENXIO;
> +
> +	return sysfs_emit(buf, "%u\n", rtmr_state->index);
> +}
> +CONFIGFS_ATTR(tsm_rtmr_, index);
> +
> +static struct configfs_attribute *tsm_rtmr_attrs[] = {
> +	&tsm_rtmr_attr_index,
> +	NULL,
> +};
> +
> +static void tsm_rtmr_item_release(struct config_item *cfg)
> +{
> +	struct tsm_rtmr_state *state = to_tsm_rtmr_state(cfg);
> +
> +	kfree(state);
> +}
> +
> +static struct configfs_item_operations tsm_rtmr_item_ops = {
> +	.release = tsm_rtmr_item_release,
> +};
> +
> +const struct config_item_type tsm_rtmr_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_attrs = tsm_rtmr_attrs,
> +	.ct_item_ops = &tsm_rtmr_item_ops,
> +};
> +
> +static struct config_item *tsm_rtmrs_make_item(struct config_group *group,
> +					       const char *name)
> +{
> +	struct tsm_rtmr_state *state;
> +
> +	guard(rwsem_read)(&tsm_rwsem);
> +	if (!(provider.ops && (provider.ops->capabilities.num_rtmrs > 0)))
> +		return ERR_PTR(-ENXIO);
> +
> +	state = kzalloc(sizeof(*state), GFP_KERNEL);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +	state->index = U32_MAX;
> +
> +	config_item_init_type_name(&state->cfg, name, &tsm_rtmr_type);
> +	return &state->cfg;
> +}
> +
> +static struct configfs_group_operations tsm_rtmrs_group_ops = {
> +	.make_item = tsm_rtmrs_make_item,
> +};
> +
> +static const struct config_item_type tsm_rtmrs_type = {
> +	.ct_owner = THIS_MODULE,
> +	.ct_group_ops = &tsm_rtmrs_group_ops,
> +};
> +
>  static const struct config_item_type tsm_root_group_type = {
>  	.ct_owner = THIS_MODULE,
>  };
> @@ -433,10 +535,48 @@ static struct configfs_subsystem tsm_configfs = {
>  	.su_mutex = __MUTEX_INITIALIZER(tsm_configfs.su_mutex),
>  };
>  
> +static int tsm_rtmr_register(const struct tsm_ops *ops)
> +{
> +	struct config_group *rtmrs_group;
> +
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	if (!ops || !ops->capabilities.num_rtmrs)
> +		return 0;
> +
> +	if (ops->capabilities.num_rtmrs > TSM_MAX_RTMR)
> +		return -EINVAL;
> +
> +	tsm_rtmrs = kzalloc(sizeof(struct tsm_rtmrs_state), GFP_KERNEL);
> +	if (!tsm_rtmrs)
> +		return -ENOMEM;
> +
> +	tsm_rtmrs->rtmrs = kcalloc(ops->capabilities.num_rtmrs,
> +				   sizeof(struct tsm_rtmr_state *),
> +				   GFP_KERNEL);
> +	if (!tsm_rtmrs->rtmrs) {
> +		kfree(tsm_rtmrs);
> +		return -ENOMEM;
> +	}
> +
> +	rtmrs_group = configfs_register_default_group(&tsm_configfs.su_group, "rtmrs",
> +						      &tsm_rtmrs_type);
> +	if (IS_ERR(rtmrs_group)) {
> +		kfree(tsm_rtmrs->rtmrs);
> +		kfree(tsm_rtmrs);
> +		return PTR_ERR(rtmrs_group);
> +	}
> +
> +	tsm_rtmrs->group = rtmrs_group;
> +
> +	return 0;
> +}
> +
>  int tsm_register(const struct tsm_ops *ops, void *priv,
>  		 const struct config_item_type *type)
>  {
>  	const struct tsm_ops *conflict;
> +	int rc;
>  
>  	if (!type)
>  		type = &tsm_report_default_type;
> @@ -450,6 +590,10 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>  		return -EBUSY;
>  	}
>  
> +	rc = tsm_rtmr_register(ops);
> +	if (rc < 0)
> +		return rc;
> +
>  	provider.ops = ops;
>  	provider.data = priv;
>  	provider.type = type;
> @@ -457,11 +601,31 @@ int tsm_register(const struct tsm_ops *ops, void *priv,
>  }
>  EXPORT_SYMBOL_GPL(tsm_register);
>  
> +static int tsm_rtmr_unregister(const struct tsm_ops *ops)
> +{
> +	lockdep_assert_held_write(&tsm_rwsem);
> +
> +	if ((ops) && (ops->capabilities.num_rtmrs > 0)) {
> +		configfs_unregister_default_group(tsm_rtmrs->group);
> +		kfree(tsm_rtmrs->rtmrs);
> +		kfree(tsm_rtmrs);
> +	}
> +
> +	return 0;
> +}
> +
>  int tsm_unregister(const struct tsm_ops *ops)
>  {
> +	int rc;
> +
>  	guard(rwsem_write)(&tsm_rwsem);
>  	if (ops != provider.ops)
>  		return -EBUSY;
> +
> +	rc = tsm_rtmr_unregister(ops);
> +	if (rc < 0)
> +		return rc;
> +
>  	provider.ops = NULL;
>  	provider.data = NULL;
>  	provider.type = NULL;
> -- 
> 2.42.0
> 

-- Regards, Mikko

