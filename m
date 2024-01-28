Return-Path: <linux-kernel+bounces-41521-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 815C583F3A4
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 04:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A65171C214C9
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 03:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D031763D9;
	Sun, 28 Jan 2024 03:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j8OVdmOI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AEC4C85;
	Sun, 28 Jan 2024 03:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706413428; cv=none; b=JPn5qL+BXFGsyA73KBlkkGVIIuvjaRAPLoIvHnDRWhd1wAyQRt39MOTwtnpoBUG6Rsn2eMCya2mW/+sl5Gs5YFct2mHCIQmXzJmqwxXqSU7YHfAG/dTeqNQd70zxwGDncQhZOMDmlDNsJTG44gsy7SjJLP/g3Ygb2Q3cYaMrqCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706413428; c=relaxed/simple;
	bh=aY4B8zzOWdf/8l2np8fF4UyMvfNAxrpL2qafcdX+Fas=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=S0gSWYjVfHxveJSVDeYbfivlGzOW1+RQl0Qe9bBZjf35eq+B3KIzzEXEUsZBOJj7WO4OYo2DXXfV9GXFXg5dzi5ptPGEck5cEEiB1KDDVFVpXt008kGe4w8z0GDrrUIr7SIQlcCfh+Ie14brTL8wORSXRsnPZMBiTbbqyH3T9rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j8OVdmOI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB65C433F1;
	Sun, 28 Jan 2024 03:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706413427;
	bh=aY4B8zzOWdf/8l2np8fF4UyMvfNAxrpL2qafcdX+Fas=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=j8OVdmOIg9bXCe9vyzExOtj9qjrVgQLT4VhnwVBY6bHgeTVfVfKCiscH72ZYgLrnB
	 dUi1VKo5TZikLO2hvBHo3RUStnYWozpIJ/g8eW5+cJzisiymjAmzNnge0678oERuDA
	 UP9CBwFvg8zqlbH2lF9PAufRmdtVpVX2cwDB/Vsp8bAvET6zl5iG+BmDlb9PgK1yMT
	 Ymqjb4ivPz+r0SX96FDAADKZgmB5kGTJDzP4narx8DjAQrfUnqqVRRzgwAygItgcSe
	 RqlOvgITf78kYh2b7QC+UFUl129AC2XXbMIhyDa/g7gSsqFndd0J48fR3D21SjuCd7
	 VcL5t+t7JZyeA==
Date: Sat, 27 Jan 2024 21:43:45 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, quic_eberman@quicinc.com, 
	quic_collinsd@quicinc.com, quic_lsrao@quicinc.com
Subject: Re: [PATCH v2] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Message-ID: <xjcefuurfbv7oquotsmm4iv4pnwzoone7jxrm42vjsnpfcgk4z@mnrsxec43bhp>
References: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119-rpmh-rsc-fixes-v2-1-e42c0a9e36f0@quicinc.com>

On Fri, Jan 19, 2024 at 01:56:54PM +0530, Maulik Shah wrote:
> Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte aligned
> addresses associated with it. These control voltage, enable state, mode,
> and in legacy targets, voltage headroom. The current in-flight request
> checking logic looks for exact address matches. Requests for different
> addresses of the same RPMh resource as thus not detected as in-flight.
> 
> Enhance the in-flight request check for VREG requests by ignoring the
> address offset. This ensures that only one request is allowed to be
> in-flight for a given VREG resource. This is needed to avoid scenarios
> where request commands are carried out by RPMh hardware out-of-order
> leading to LDO regulator over-current protection triggering.
> 
> Signed-off-by: Maulik Shah <quic_mkshah@quicinc.com>
> Signed-off-by: Elliot Berman <quic_eberman@quicinc.com>

The s-o-b chain doesn't look right.

> ---
> Changes in v2:
> - Use GENMASK() and FIELD_GET()
> - Link to v1: https://lore.kernel.org/r/20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com
> ---
>  drivers/soc/qcom/rpmh-rsc.c | 21 ++++++++++++++++++++-
>  1 file changed, 20 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index a021dc71807b..e480cde783fe 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1,11 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
>  
>  #include <linux/atomic.h>
> +#include <linux/bitfield.h>
>  #include <linux/cpu_pm.h>
>  #include <linux/delay.h>
>  #include <linux/interrupt.h>
> @@ -91,6 +93,15 @@ enum {
>  #define CMD_STATUS_ISSUED		BIT(8)
>  #define CMD_STATUS_COMPL		BIT(16)
>  
> +#define ACCL_TYPE(addr)			FIELD_GET(GENMASK(19, 16), addr)

Command DB is there so we don't have to make assumptions about the
addresses of resources. As such, I dislike this define.

> +#define VREG_ADDR(addr)			FIELD_GET(GENMASK(19, 4), addr)
> +
> +enum {
> +	HW_ACCL_CLK = 0x3,
> +	HW_ACCL_VREG,
> +	HW_ACCL_BUS,

We already define these in the kernel, but with different names:
CMD_DB_HW_ARC, CMD_DB_HW_VRM, CMD_DB_HW_BCM. I see no reason to use
different names for the same thing.

> +};
> +
>  /*
>   * Here's a high level overview of how all the registers in RPMH work
>   * together:
> @@ -557,7 +568,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>  		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>  			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
>  			for (k = 0; k < msg->num_cmds; k++) {
> -				if (addr == msg->cmds[k].addr)
> +				/*
> +				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
> +				 * aligned addresses associated with it. Ignore the offset to check
> +				 * for in-flight VREG requests.
> +				 */
> +				if (ACCL_TYPE(msg->cmds[k].addr) == HW_ACCL_VREG &&
> +				    VREG_ADDR(msg->cmds[k].addr) == VREG_ADDR(addr))

I'm sure this work, at least for some targets, but I don't fancy
encoding this information here. It feels like a hack.

Furthermore, I really would like TP_printk() of trace_rpmh_send_msg() to
be able to resolve the symbolic names for VRMs as well, and it would
need the same information...

Please consider how we can query command db for the type and/or grouping
information.

Regards,
Bjorn

> +					return -EBUSY;
> +				else if (addr == msg->cmds[k].addr)
>  					return -EBUSY;
>  			}
>  		}
> 
> ---
> base-commit: 943b9f0ab2cfbaea148dd6ac279957eb08b96904
> change-id: 20240117-rpmh-rsc-fixes-6c43c7051828
> 
> Best regards,
> -- 
> Maulik Shah <quic_mkshah@quicinc.com>
> 

