Return-Path: <linux-kernel+bounces-73215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F4585BF70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:07:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DF9B2833F0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2965745C6;
	Tue, 20 Feb 2024 15:07:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A68E467E91;
	Tue, 20 Feb 2024 15:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708441662; cv=none; b=tRn0QuAIO4YSbXY0u2Zf99MCeOYuKYn2i7o7ac0N+ZMR3+cxU45fbFDJBAYVfYqioZgCvdiPjiX/eChh4kk3jiRw/CcYjR5thxFMynbOac+FBI40bpIqvkf+SDlbWTMmwhoy7mAcZljE2zLqVlryshm5cwTIEMkiwD/PVCik3Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708441662; c=relaxed/simple;
	bh=I2jhKDuObvGJdDaIlPFqcuRI52gRZjbpYQq0Xx/YBXk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TT4NX5jXhPAaE5pja9OkJyY71sgrKMGhBRxlhBzsne+eKlZR1AJvUXcwJ2CJ71AzLH8vZ2V6m2xgVh5AunPGQ93xKcowqsTmdzJF+uKcXEf21I1J2dWuj6elwxyfHWeiH1xHxXaVRNfPKDEX3dPjzthH2cTRs9JsWRD5cRcvmTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 07B3FFEC;
	Tue, 20 Feb 2024 07:08:18 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 85EA93F73F;
	Tue, 20 Feb 2024 07:07:36 -0800 (PST)
Date: Tue, 20 Feb 2024 15:07:34 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, sudeep.holla@arm.com,
	andersson@kernel.org, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Message-ID: <ZdTANrUZuN_UZW9j@pluto>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-5-quic_sibis@quicinc.com>
 <CAA8EJpr8qLZ8Y7PjU05ZoxSHWOf=q-KtM+s-tnR5X2t96rFWhw@mail.gmail.com>
 <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0adaa065-3883-ebfe-8259-05ebdbd821eb@quicinc.com>

On Mon, Feb 12, 2024 at 03:54:27PM +0530, Sibi Sankar wrote:
> 
> 
> On 1/18/24 02:11, Dmitry Baryshkov wrote:
> > On Wed, 17 Jan 2024 at 19:36, Sibi Sankar <quic_sibis@quicinc.com> wrote:

Hi,

I'll comment this patch fully, just a remark down below about this
mail-thread.

> > > 
> > > From: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > > 
> > > This patch introduces a client driver that interacts with the SCMI QCOM
> > 
> > git grep This.patch Documentation/process/
> > 
> > > vendor protocol and passes on the required tuneables to start various
> > > features running on the SCMI controller.
> > 
> > Is there any word about the 'memlat'? No. Unless one  reads into the
> > patch, one can not come up with the idea of what is being introduced.
> 
> ack, will fix it in the re-spin.
> 
> > 
> > > 
> > > Signed-off-by: Shivnandan Kumar <quic_kshivnan@quicinc.com>
> > > Co-developed-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > > Signed-off-by: Ramakrishna Gottimukkula <quic_rgottimu@quicinc.com>
> > > Co-developed-by: Amir Vajid <avajid@quicinc.com>
> > > Signed-off-by: Amir Vajid <avajid@quicinc.com>
> > > Co-developed-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> > > ---
> > >   drivers/soc/qcom/Kconfig            |  10 +
> > >   drivers/soc/qcom/Makefile           |   1 +
> > >   drivers/soc/qcom/qcom_scmi_client.c | 486 ++++++++++++++++++++++++++++
> > 
> > Should it go to drivers/firmware/arm_scmi instead? Or maybe to drivers/devfreq?
> 
> I don't think it should go into arm_scmi unless Sudeep wants it there.
> As for drivers/devfreq, I would have moved it there if this driver
> benfitted being classified as a devfreq device. We can't use any of
> the available governors on it and the tuneables appear way too custom.
> These are the reasons why I placed it in drivers/soc/qcom instead.
> 

I think we used to host a couple of generic SCMI driver related to
standard protocols but they have been moved out of driver/firmware/arm_scmi
into the related subsystem...not sure if Sudeep thinks otherwise but I
suppose we want to host only SCMI drivers that are clearly lacking a
place where to stay...

> > 
> > >   3 files changed, 497 insertions(+)
> > >   create mode 100644 drivers/soc/qcom/qcom_scmi_client.c
 
 [snip]

> > > +static int configure_cpucp_mon(struct scmi_memlat_info *info, int memory_index, int monitor_index)
> > > +{
> > > +       const struct qcom_scmi_vendor_ops *ops = info->ops;
> > > +       struct scmi_memory_info *memory = info->memory[memory_index];
> > > +       struct scmi_monitor_info *monitor = memory->monitor[monitor_index];
> > > +       struct scalar_param_msg scalar_msg;
> > > +       struct map_param_msg map_msg;
> > > +       struct node_msg msg;
> > > +       int ret;
> > > +       int i;
> > > +
> > > +       msg.cpumask = monitor->mask;
> > > +       msg.hw_type = memory->hw_type;
> > > +       msg.mon_type = monitor->mon_type;
> > > +       msg.mon_idx = monitor->mon_idx;
> > > +       strscpy(msg.mon_name, monitor->mon_name, sizeof(msg.mon_name));
> > > +       ret = ops->set_param(info->ph, &msg, MEMLAT_ALGO_STR, MEMLAT_SET_MONITOR, sizeof(msg));
> > > +       if (ret < 0) {
> > > +               pr_err("Failed to configure monitor %s\n", monitor->mon_name);
> > > +               return ret;
> > > +       }
> > > +
> > > +       scalar_msg.hw_type = memory->hw_type;
> > > +       scalar_msg.mon_idx = monitor->mon_idx;
> > > +       scalar_msg.val = monitor->ipm_ceil;
> > > +       ret = ops->set_param(info->ph, &scalar_msg, MEMLAT_ALGO_STR, MEMLAT_IPM_CEIL,
> > > +                            sizeof(scalar_msg));
> > > +       if (ret < 0) {
> > > +               pr_err("Failed to set ipm ceil for %s\n", monitor->mon_name);
> > > +               return ret;
> > > +       }
> > > +
> > > +       map_msg.hw_type = memory->hw_type;
> > > +       map_msg.mon_idx = monitor->mon_idx;
> > > +       map_msg.nr_rows = monitor->freq_map_len;
> > > +       for (i = 0; i < monitor->freq_map_len; i++) {
> > > +               map_msg.tbl[i].v1 = monitor->freq_map[i].cpufreq_mhz;
> > > +               map_msg.tbl[i].v2 = monitor->freq_map[i].memfreq_khz / 1000;
> > > +       }
> > 
> > So this table goes 1:1 to the firmware? Is it going to be the same for
> > all versions of the SoC? If so, it might be better to turn it into the
> > static data inside the driver. If it doesn't change, there is no need
> > to put it to DT.
> 
> The table does go directly to the firmware but obviously varies across
> SoCs. Also since it's a SCMI client driver we don't have a way to
> distinguish between SoCs based on compatibles. So it made more sense to
> move it to the device tree instead.
> 

Well, the SCMI fw running the server DOES know where it is running right ?

So, if you have multiple fixed config tables to feed into the firmware
that vary based on the SoC you are running on, you could add an SCMI command
to your QCOM SCMI vendor protocol and expose a related operation in ops to get
the actual SoC model, so that you can embed the tableS in the driver here (as
suggested) and then choose at runtime which one to use based on the reported
platform...this is clearly config stuff (sa said by others) so it just
does not belong to DT descriptions. 

Thanks,
Cristian

