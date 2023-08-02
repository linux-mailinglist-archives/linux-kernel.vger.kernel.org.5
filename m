Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5B776DA0E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 23:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjHBV6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 17:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231996AbjHBV6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 17:58:31 -0400
Received: from mgamail.intel.com (unknown [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1105C30C3;
        Wed,  2 Aug 2023 14:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691013507; x=1722549507;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=r+m4opMizQ6LAk9BBG6aOX5ScHmf410e3LtrOPinIrM=;
  b=OUanyhILeet5A3pg7X1RIGnlrY4cu73eJJKJ7/YzJ5RSpwU4Wli2Yj30
   LsO+lOg+GrlBfO+PpWFkyq6PjiCmxYb84NExYZdjqzCt96CU0dDhYIT6J
   uFYk78lXn5BtpRgxvtO7cJJ5KPv5EVXTsr46khFyd54t/ANydVBv3OOlw
   VxoO4NNrdcLReHXnPb8ciqVNXSSvhn/D7tEqNPyCVnPKkBABtpmgK4w8b
   We0XFiZ346EhxtPzLCZN4jJgENI5frXa0rqTZ0cJ+QjT8lJgt5cyWLC/6
   RwOexbf9eKC77QaaE9CmmkXktcXagikxy7lWpvu56+Zo5/fijUbYTBwn6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="456083275"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="456083275"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:58:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="975831045"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="975831045"
Received: from rbappers-mobl2.amr.corp.intel.com (HELO vcostago-mobl3) ([10.209.84.112])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 14:58:24 -0700
From:   Vinicius Costa Gomes <vinicius.gomes@intel.com>
To:     Vladimir Oltean <vladimir.oltean@nxp.com>, netdev@vger.kernel.org
Cc:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jamal Hadi Salim <jhs@mojatatu.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Jiri Pirko <jiri@resnulli.us>, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org,
        Muhammad Husaini Zulkifli <muhammad.husaini.zulkifli@intel.com>,
        Peilin Ye <yepeilin.cs@gmail.com>,
        Pedro Tammela <pctammela@mojatatu.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Zhengchao Shao <shaozhengchao@huawei.com>,
        Maxim Georgiev <glipus@gmail.com>
Subject: Re: [PATCH v3 net-next 06/10] net: ptp: create a mock-up PTP
 Hardware Clock driver
In-Reply-To: <20230801182421.1997560-7-vladimir.oltean@nxp.com>
References: <20230801182421.1997560-1-vladimir.oltean@nxp.com>
 <20230801182421.1997560-7-vladimir.oltean@nxp.com>
Date:   Wed, 02 Aug 2023 14:58:24 -0700
Message-ID: <87wmyd14zj.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Vladimir Oltean <vladimir.oltean@nxp.com> writes:

> There are several cases where virtual net devices may benefit from
> having a PTP clock, and these have to do with testing. I can see at
> least netdevsim and veth as potential users of a common mock-up PTP
> hardware clock driver.
>
> The proposed idea is to create an object which emulates PTP clock
> operations on top of the unadjustable CLOCK_MONOTONIC_RAW plus a
> software-controlled time domain via a timecounter/cyclecounter and then
> link that PHC to the netdevsim device.
>
> The driver is fully functional for its intended purpose, and it
> successfully passes the PTP selftests.
>
> $ cd tools/testing/selftests/ptp/
> $ ./phc.sh /dev/ptp2
> TEST: settime                          [ OK ]
> TEST: adjtime                          [ OK ]
> TEST: adjfreq                          [ OK ]
>
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v2->v3:
> - split off ptp_mock into separate patch
> - fix ptp_mock compilation as a module
> - turn phc->lock into a global spinlock
> - drop bogus support for ptp_clock_register() ever returning NULL
> - add MAINTAINERS entry
> v1->v2: patch is new
>
>  MAINTAINERS              |   7 ++
>  drivers/ptp/Kconfig      |  11 +++
>  drivers/ptp/Makefile     |   1 +
>  drivers/ptp/ptp_mock.c   | 175 +++++++++++++++++++++++++++++++++++++++
>  include/linux/ptp_mock.h |  38 +++++++++
>  5 files changed, 232 insertions(+)
>  create mode 100644 drivers/ptp/ptp_mock.c
>  create mode 100644 include/linux/ptp_mock.h
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index c4f95a9d03b9..164b7930f5d0 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17175,6 +17175,13 @@ F:	drivers/ptp/*
>  F:	include/linux/ptp_cl*
>  K:	(?:\b|_)ptp(?:\b|_)
>  
> +PTP MOCKUP CLOCK SUPPORT
> +M:	Vladimir Oltean <vladimir.oltean@nxp.com>
> +L:	netdev@vger.kernel.org
> +S:	Maintained
> +F:	drivers/ptp/ptp_mock.c
> +F:	include/linux/ptp_mock.h
> +
>  PTP VIRTUAL CLOCK SUPPORT
>  M:	Yangbo Lu <yangbo.lu@nxp.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
> index 32dff1b4f891..ed9d97a032f1 100644
> --- a/drivers/ptp/Kconfig
> +++ b/drivers/ptp/Kconfig
> @@ -155,6 +155,17 @@ config PTP_1588_CLOCK_IDTCM
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called ptp_clockmatrix.
>  
> +config PTP_1588_CLOCK_MOCK
> +	tristate "Mock-up PTP clock"
> +	depends on PTP_1588_CLOCK
> +	help
> +	  This driver offers a set of PTP clock manipulation operations over
> +	  the system monotonic time. It can be used by virtual network device
> +	  drivers to emulate PTP capabilities.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called ptp_mock.
> +
>  config PTP_1588_CLOCK_VMW
>  	tristate "VMware virtual PTP clock"
>  	depends on ACPI && HYPERVISOR_GUEST && X86
> diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
> index 553f18bf3c83..dea0cebd2303 100644
> --- a/drivers/ptp/Makefile
> +++ b/drivers/ptp/Makefile
> @@ -16,6 +16,7 @@ ptp-qoriq-y				+= ptp_qoriq.o
>  ptp-qoriq-$(CONFIG_DEBUG_FS)		+= ptp_qoriq_debugfs.o
>  obj-$(CONFIG_PTP_1588_CLOCK_IDTCM)	+= ptp_clockmatrix.o
>  obj-$(CONFIG_PTP_1588_CLOCK_IDT82P33)	+= ptp_idt82p33.o
> +obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
>  obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
>  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
>  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
> diff --git a/drivers/ptp/ptp_mock.c b/drivers/ptp/ptp_mock.c
> new file mode 100644
> index 000000000000..1525aafca752
> --- /dev/null
> +++ b/drivers/ptp/ptp_mock.c
> @@ -0,0 +1,175 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 NXP
> + *
> + * Mock-up PTP Hardware Clock driver for virtual network devices
> + *
> + * Create a PTP clock which offers PTP time manipulation operations
> + * using a timecounter/cyclecounter on top of CLOCK_MONOTONIC_RAW.
> + */
> +
> +#include <linux/ptp_clock_kernel.h>
> +#include <linux/ptp_mock.h>
> +#include <linux/timecounter.h>
> +
> +/* Clamp scaled_ppm between -2,097,152,000 and 2,097,152,000,
> + * and thus "adj" between -68,719,476 and 68,719,476
> + */
> +#define MOCK_PHC_MAX_ADJ_PPB		32000000
> +/* Timestamps from ktime_get_raw() have 1 ns resolution, so the scale factor
> + * (MULT >> SHIFT) needs to be 1. Pick SHIFT as 31 bits, which translates
> + * MULT(freq 0) into 0x80000000.
> + */
> +#define MOCK_PHC_CC_SHIFT		31
> +#define MOCK_PHC_CC_MULT		(1 << MOCK_PHC_CC_SHIFT)
> +#define MOCK_PHC_FADJ_SHIFT		9
> +#define MOCK_PHC_FADJ_DENOMINATOR	15625ULL
> +
> +/* The largest cycle_delta that timecounter_read_delta() can handle without a
> + * 64-bit overflow during the multiplication with cc->mult, given the max "adj"
> + * we permit, is ~8.3 seconds. Make sure readouts are more frequent than that.
> + */
> +#define MOCK_PHC_REFRESH_INTERVAL	(HZ * 5)
> +
> +#define info_to_phc(d) container_of((d), struct mock_phc, info)
> +
> +static DEFINE_SPINLOCK(mock_phc_lock);
> +

Not a big deal, but as it is possible to have multiple netdevsim
instances (is it?), I think it's better to move the lock inside struct
mock_phc.

> +struct mock_phc {
> +	struct ptp_clock_info info;
> +	struct ptp_clock *clock;
> +	struct timecounter tc;
> +	struct cyclecounter cc;
> +};
> +
> +static u64 mock_phc_cc_read(const struct cyclecounter *cc)
> +{
> +	return ktime_to_ns(ktime_get_raw());
> +}
> +
> +static int mock_phc_adjfine(struct ptp_clock_info *info, long scaled_ppm)
> +{
> +	struct mock_phc *phc = info_to_phc(info);
> +	s64 adj;
> +
> +	adj = (s64)scaled_ppm << MOCK_PHC_FADJ_SHIFT;
> +	adj = div_s64(adj, MOCK_PHC_FADJ_DENOMINATOR);
> +
> +	spin_lock_bh(&mock_phc_lock);
> +	timecounter_read(&phc->tc);
> +	phc->cc.mult = MOCK_PHC_CC_MULT + adj;
> +	spin_unlock_bh(&mock_phc_lock);
> +
> +	return 0;
> +}
> +
> +static int mock_phc_adjtime(struct ptp_clock_info *info, s64 delta)
> +{
> +	struct mock_phc *phc = info_to_phc(info);
> +
> +	spin_lock_bh(&mock_phc_lock);
> +	timecounter_adjtime(&phc->tc, delta);
> +	spin_unlock_bh(&mock_phc_lock);
> +
> +	return 0;
> +}
> +
> +static int mock_phc_settime64(struct ptp_clock_info *info,
> +			      const struct timespec64 *ts)
> +{
> +	struct mock_phc *phc = info_to_phc(info);
> +	u64 ns = timespec64_to_ns(ts);
> +
> +	spin_lock_bh(&mock_phc_lock);
> +	timecounter_init(&phc->tc, &phc->cc, ns);
> +	spin_unlock_bh(&mock_phc_lock);
> +
> +	return 0;
> +}
> +
> +static int mock_phc_gettime64(struct ptp_clock_info *info, struct timespec64 *ts)
> +{
> +	struct mock_phc *phc = info_to_phc(info);
> +	u64 ns;
> +
> +	spin_lock_bh(&mock_phc_lock);
> +	ns = timecounter_read(&phc->tc);
> +	spin_unlock_bh(&mock_phc_lock);
> +
> +	*ts = ns_to_timespec64(ns);
> +
> +	return 0;
> +}
> +
> +static long mock_phc_refresh(struct ptp_clock_info *info)
> +{
> +	struct timespec64 ts;
> +
> +	mock_phc_gettime64(info, &ts);
> +
> +	return MOCK_PHC_REFRESH_INTERVAL;
> +}
> +
> +int mock_phc_index(struct mock_phc *phc)
> +{
> +	return ptp_clock_index(phc->clock);
> +}
> +EXPORT_SYMBOL_GPL(mock_phc_index);
> +
> +struct mock_phc *mock_phc_create(struct device *dev)
> +{
> +	struct mock_phc *phc;
> +	int err;
> +
> +	phc = kzalloc(sizeof(*phc), GFP_KERNEL);
> +	if (!phc) {
> +		err = -ENOMEM;
> +		goto out;
> +	}
> +
> +	phc->info = (struct ptp_clock_info) {
> +		.owner		= THIS_MODULE,
> +		.name		= "Mock-up PTP clock",
> +		.max_adj	= MOCK_PHC_MAX_ADJ_PPB,
> +		.adjfine	= mock_phc_adjfine,
> +		.adjtime	= mock_phc_adjtime,
> +		.gettime64	= mock_phc_gettime64,
> +		.settime64	= mock_phc_settime64,
> +		.do_aux_work	= mock_phc_refresh,
> +	};
> +
> +	phc->cc = (struct cyclecounter) {
> +		.read	= mock_phc_cc_read,
> +		.mask	= CYCLECOUNTER_MASK(64),
> +		.mult	= MOCK_PHC_CC_MULT,
> +		.shift	= MOCK_PHC_CC_SHIFT,
> +	};
> +
> +	timecounter_init(&phc->tc, &phc->cc, 0);
> +
> +	phc->clock = ptp_clock_register(&phc->info, dev);
> +	if (IS_ERR(phc->clock)) {
> +		err = PTR_ERR(phc->clock);
> +		goto out_free_phc;
> +	}
> +
> +	ptp_schedule_worker(phc->clock, MOCK_PHC_REFRESH_INTERVAL);
> +
> +	return phc;
> +
> +out_free_phc:
> +	kfree(phc);
> +out:
> +	return ERR_PTR(err);
> +}
> +EXPORT_SYMBOL_GPL(mock_phc_create);
> +
> +void mock_phc_destroy(struct mock_phc *phc)
> +{
> +	ptp_clock_unregister(phc->clock);
> +	kfree(phc);
> +}
> +EXPORT_SYMBOL_GPL(mock_phc_destroy);
> +
> +MODULE_DESCRIPTION("Mock-up PTP Hardware Clock driver");
> +MODULE_LICENSE("GPL");
> diff --git a/include/linux/ptp_mock.h b/include/linux/ptp_mock.h
> new file mode 100644
> index 000000000000..72eb401034d9
> --- /dev/null
> +++ b/include/linux/ptp_mock.h
> @@ -0,0 +1,38 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Mock-up PTP Hardware Clock driver for virtual network devices
> + *
> + * Copyright 2023 NXP
> + */
> +
> +#ifndef _PTP_MOCK_H_
> +#define _PTP_MOCK_H_
> +
> +struct device;
> +struct mock_phc;
> +
> +#if IS_ENABLED(CONFIG_PTP_1588_CLOCK_MOCK)
> +
> +struct mock_phc *mock_phc_create(struct device *dev);
> +void mock_phc_destroy(struct mock_phc *phc);
> +int mock_phc_index(struct mock_phc *phc);
> +
> +#else
> +
> +static inline struct mock_phc *mock_phc_create(struct device *dev)
> +{
> +	return NULL;
> +}
> +
> +static inline void mock_phc_destroy(struct mock_phc *phc)
> +{
> +}
> +
> +static inline int mock_phc_index(struct mock_phc *phc)
> +{
> +	return -1;
> +}
> +
> +#endif
> +
> +#endif /* _PTP_MOCK_H_ */
> -- 
> 2.34.1
>

-- 
Vinicius
