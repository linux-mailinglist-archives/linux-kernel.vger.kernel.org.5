Return-Path: <linux-kernel+bounces-86857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5790586CBCE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B3FD1C20D44
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C7EB13774C;
	Thu, 29 Feb 2024 14:42:07 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 960E012F580;
	Thu, 29 Feb 2024 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709217727; cv=none; b=USn7R2B+hJfcxEVHPc1fWvorZcsdIFk3tWWTBeNguLQttdDNrBDyw0FkHHc7DAi5S2Sv0NQahMdlZ6G7ZZfGKYQBPp9qmkZmoMLRiwgoRRe4dBjZ9e3HdI6h8OlyzBHrUi+fvCDnbEXm6juH/Y66fntpDuf1mrCiVJ+OsNKGiHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709217727; c=relaxed/simple;
	bh=nieHaErrV6K3GIlaqVdHZU2SZ5kKZDLqrnYXcD8MWio=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fTq666wFtT8q2MuuAaJc7AoRshNda8ev9dO91tbmJOMTjaRY1JsQzxz50CcrjxlQoXQrHjtzStYKa++i3APY8LWjqEowoRWxaMBsCNaKfe+FcTPOVdaS7S0hcSUP5UMvyknbaPkRrpgwWkH14MbQEskk9lAsWXoNONhebE+E8yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B6CDF1FB;
	Thu, 29 Feb 2024 06:42:42 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFA333F6C4;
	Thu, 29 Feb 2024 06:42:01 -0800 (PST)
Date: Thu, 29 Feb 2024 14:41:59 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Message-ID: <ZeCXtzwX2xTyEGtK@bogus>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
 <ZdTQ9ur3XpNVlduo@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZdTQ9ur3XpNVlduo@pluto>

On Tue, Feb 20, 2024 at 04:19:02PM +0000, Cristian Marussi wrote:
> On Wed, Jan 17, 2024 at 11:04:55PM +0530, Sibi Sankar wrote:
> > From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > 
> > This patch introduces a client driver that interacts with the SCMI QCOM
> > vendor protocol and passes on the required tuneables to start various
> > features running on the SCMI controller.
> > 
> > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > Co-developed-by: Amir Vajid <avajid@quicinc.com>
> > Signed-off-by: Amir Vajid <avajid@quicinc.com>
> > Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > ---
> >  drivers/soc/qcom/Kconfig            |  10 +
> >  drivers/soc/qcom/Makefile           |   1 +
> >  drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
> >  3 files changed, 497 insertions(+)
> >  create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
> > 
> > diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> > index c6ca4de42586..1530558aebfb 100644
> > --- a/drivers/soc/qcom/Kconfig
> > +++ b/drivers/soc/qcom/Kconfig
> > @@ -264,6 +264,16 @@ config QCOM_ICC_BWMON
> >  	  the fixed bandwidth votes from cpufreq (CPU nodes) thus achieve high
> >  	  memory throughput even with lower CPU frequencies.
> >  
> > +config QCOM_SCMI_CLIENT
> > +	tristate "Qualcomm Technologies Inc. SCMI client driver"
> > +	depends on QCOM_SCMI_VENDOR_PROTOCOL || COMPILE_TEST
> > +	default n
> > +	help
> > +	  SCMI client driver registers for SCMI QCOM vendor protocol.
> > +
> > +	  This driver interacts with the vendor protocol and passes on the required
> > +	  tuneables to start various features running on the SCMI controller.
> > +
> >  config QCOM_INLINE_CRYPTO_ENGINE
> >  	tristate
> >  	select QCOM_SCM
> > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > index 05b3d54e8dc9..c2a51293c886 100644
> > --- a/drivers/soc/qcom/Makefile
> > +++ b/drivers/soc/qcom/Makefile
> > @@ -32,5 +32,6 @@ obj-$(CONFIG_QCOM_APR) += apr.o
> >  obj-$(CONFIG_QCOM_LLCC) += llcc-qcom.o
> >  obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
> >  obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
> > +obj-$(CONFIG_QCOM_SCMI_CLIENT)	+= qcom_scmi_client.o
> >  qcom_ice-objs			+= ice.o
> >  obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> > diff --git a/drivers/soc/qcom/qcom_scmi_client.c b/drivers/soc/qcom/qcom_scmi_client.c
> > new file mode 100644
> > index 000000000000..418aa7900496
> > --- /dev/null
> > +++ b/drivers/soc/qcom/qcom_scmi_client.c
> > @@ -0,0 +1,486 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/*
> > + * Copyright (c) 2024, The Linux Foundation. All rights reserved.
> > + */
> > +
> > +#include <linux/cpu.h>
> > +#include <linux/err.h>
> > +#include <linux/errno.h>
> > +#include <linux/init.h>
> > +#include <linux/kernel.h>
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/qcom_scmi_vendor.h>
> > +#include <linux/scmi_protocol.h>
> > +
> > +#define MAX_MEMORY_TYPES	3
> > +#define MEMLAT_ALGO_STR		0x74616C6D656D /* "memlat" */
> > +#define INVALID_IDX		0xFF
> > +#define MAX_NAME_LEN		20
> > +#define MAX_MAP_ENTRIES		6
> > +#define MAX_MONITOR_CNT		4
> > +#define SCMI_VENDOR_MSG_START	3
> > +#define SCMI_VENDOR_MSG_MODULE_START	16
> > +
> > +enum scmi_memlat_protocol_cmd {
> > +	MEMLAT_SET_LOG_LEVEL = SCMI_VENDOR_MSG_START,
> > +	MEMLAT_FLUSH_LOGBUF,
> > +	MEMLAT_SET_MEM_GROUP = SCMI_VENDOR_MSG_MODULE_START,
> > +	MEMLAT_SET_MONITOR,
> > +	MEMLAT_SET_COMMON_EV_MAP,
> > +	MEMLAT_SET_GRP_EV_MAP,
> > +	MEMLAT_ADAPTIVE_LOW_FREQ,
> > +	MEMLAT_ADAPTIVE_HIGH_FREQ,
> > +	MEMLAT_GET_ADAPTIVE_CUR_FREQ,
> > +	MEMLAT_IPM_CEIL,
> > +	MEMLAT_FE_STALL_FLOOR,
> > +	MEMLAT_BE_STALL_FLOOR,
> > +	MEMLAT_WB_PCT,
> > +	MEMLAT_IPM_FILTER,
> > +	MEMLAT_FREQ_SCALE_PCT,
> > +	MEMLAT_FREQ_SCALE_CEIL_MHZ,
> > +	MEMLAT_FREQ_SCALE_FLOOR_MHZ,
> > +	MEMLAT_SAMPLE_MS,
> > +	MEMLAT_MON_FREQ_MAP,
> > +	MEMLAT_SET_MIN_FREQ,
> > +	MEMLAT_SET_MAX_FREQ,
> > +	MEMLAT_GET_CUR_FREQ,
> > +	MEMLAT_START_TIMER,
> > +	MEMLAT_STOP_TIMER,
> > +	MEMLAT_GET_TIMESTAMP,
> > +	MEMLAT_MAX_MSG
> > +};
> 
> So the reason why you can have just a single qualcomm vendor SCMI protocol is
> that it really implements and expose just a couple of set/get generic commands
> and exposes a few related ops so that you can piggyback any kind of real messages
> into this new sort of transport layer and at the end the full final message payloads
> are built here in the client driver...and any future further QC SCMI client driver
> will implement its own set of payloads for different protocols.
> 
> Seems a bit odd to me (but certainly a creative way to abuse the SCMI stack), anyway
> I have personally nothing against it, if you are happy with this design, but the spec
> says that the protocol messages have to be little endian-encoded so I suppose that you
> should, down below, define your smuggled (:P) payloads with __le32 & friends and use
> the proper helpers to be sure that the values tranferred are properly interpreted, from
> the endianess point-of-view, on both sides of the channel.
> 
> ...but Sudeep could think differently...I would wait for his feedback...

No not really. I agree. I have more fundamental question which I expected to
find some reasoning somewhere. It could be me not having followed the patches
properly, but

1. Why this bus/memlat dvfs can't be done using perf protocol ?
2. What std perf protocol lacks that is needed here ?
3. Why it needs to be vendor specific ?
4. If so, why MEMLAT alone doesn't deserve a separate vendor protocol ?
   IOW why is vendor protocol is implemented as more generic one for all
   qcom needs(I am assuming here) and MEMLAT is just command extension
   of that protocol(as Cristian said protocol on top of the generic qcom
   vendor protocol)

These are few details that helps to understand and review the patches. So
please add as much as documentation. If it is too much, we can remove it
(but I am sure we may not reach that point).

-- 
Regards,
Sudeep

