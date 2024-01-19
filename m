Return-Path: <linux-kernel+bounces-31319-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AC68832C74
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 16:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4504E1C23A20
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 15:44:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7EAE754BE0;
	Fri, 19 Jan 2024 15:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WQCl1BVN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458C554BD0
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 15:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705679058; cv=none; b=GK3owy3ImZ+uzBI/8gVzAYA+zxrtqIzkMPz125TbDK76Sw2/LbLBLSfF+An6Kag/Hp7Tb84Ziy2soEKCccgeizPdK64dFdNPMjB2yaCASCHAr9hkLFOh9Rxw4kP+KGGvjNrfn4qnYtDmrBha0BZtxmI3DMJTivL7PB1Qg9m4G10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705679058; c=relaxed/simple;
	bh=q5UJVGX3yfRfi60/H2zTOA89guV2jb+xgf5zKB4s9SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=obS9yFdeEqZbpQKVbXF12DB7Bci7b2o+oz+9mL8VQz/mi8zD1bxWmk4fuxjsCEzp9GRcxev+1ccKGNdqU03FviWoKM+LAbwDUBeNJBxsDzIqL/ET4+TXLPuMFh+Zuk9Olkm/NyfuA/bU0xRg3p/SMObzH4IGLFwLIiBcD6JJU50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WQCl1BVN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705679056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QjYsUi6PYjDB4zhjAZoeXh7tMhPQit/CHnee+lSIhAM=;
	b=WQCl1BVNmOcQa3DzlZSe3W9Fh1yS1CXd7U/o++24fTlOp00kmPZeyMvt7WSSopQ8hTM4YC
	PiQvIImzdaxl58aRLkO3ns8IABYXoie3M51AKEPo0a8vX0CGvm+8PZVTT3V2XBTm6eTouj
	LxYHTBFwBVAlDfmVEV2kSFX1j6SM6IM=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-R_fL2xzANGGAEZdcbpmuFA-1; Fri, 19 Jan 2024 10:44:12 -0500
X-MC-Unique: R_fL2xzANGGAEZdcbpmuFA-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-7d2ca4372d2so332854241.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 07:44:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705679052; x=1706283852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QjYsUi6PYjDB4zhjAZoeXh7tMhPQit/CHnee+lSIhAM=;
        b=Wzo0jd1B2Q5Q8pTBnsepTQJe3k8USb+dAQWCG1qXMmfWImU1DJ4cfbODm/ShQcTQxJ
         LfURu9xgX+uuS4Pbr3uxWg59hiDqhh1DMbyOxiFVHjLwUjj4cHiIlxlbLgxY+VZu+XuK
         JXcLBsQvW8P2Xsan21KeZFjdyLT7eJBgOu2hZvqTitkMcG32WTTGj6y/hhTrRko8gE/w
         2vQj6+Yun4varGCLjulOM1xuO749MmJDM8FbSzpO5TJiDtoqu2m1RQhC1h49jaC6Nl6V
         sOJV0nMWis0722N1AgeaDMEbXC7bwAylosyb3yJpmwXUXRN97x2t51syAuj0B5bnRFpF
         WApQ==
X-Gm-Message-State: AOJu0YzV8R++f+VfscNa6zyaAkuw2rsN33M2+kgOBB4uFbMZbUrQp35C
	88ghyigqz5z4x+6MGou/oR9qiyNtjTrUOtg10JQQdRz+VQERzwAjFo5NwKejnQ2NGB+uISwV44B
	4UsKLS8697X7dLsLo0HYZyN5Caowsk23TKDK8K8RZnrLc20DlU1HnMK0npscZcQ==
X-Received: by 2002:a05:6102:162c:b0:469:a26c:cd40 with SMTP id cu44-20020a056102162c00b00469a26ccd40mr343270vsb.71.1705679051978;
        Fri, 19 Jan 2024 07:44:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQAFTPc2F/rZAHEH0XAopgBDhs3oui2/5EzTmX8AuLUGPhO0TyKvAjcXSh+rDUgPiYp2JKLg==
X-Received: by 2002:a05:6102:162c:b0:469:a26c:cd40 with SMTP id cu44-20020a056102162c00b00469a26ccd40mr343255vsb.71.1705679051642;
        Fri, 19 Jan 2024 07:44:11 -0800 (PST)
Received: from fedora ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id ow18-20020a0562143f9200b006849db7c44esm247053qvb.60.2024.01.19.07.44.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jan 2024 07:44:11 -0800 (PST)
Date: Fri, 19 Jan 2024 09:44:09 -0600
From: Andrew Halaney <ahalaney@redhat.com>
To: Maulik Shah <quic_mkshah@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	quic_eberman@quicinc.com, quic_collinsd@quicinc.com, quic_lsrao@quicinc.com
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Enhance check for VREG in-flight
 request
Message-ID: <6tnescmrw4j2wzhc2p2lih6624xgt7spoxj2ahus6wzfcmmear@cqdkohjquzr7>
References: <20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117-rpmh-rsc-fixes-v1-1-71ee4f8f72a4@quicinc.com>

On Wed, Jan 17, 2024 at 02:24:10PM +0530, Maulik Shah wrote:
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

Two minor things:

    1. Does this deserve a Fixes: tag?
    2. The Signed-off-by chain here confuses me, you sent the patch
       so your SOB should be last, but then that makes me believe Elliot
       was the author which I don't think is reflected here (no From:
       line). Please read [0] for a bit more details

[0] https://www.kernel.org/doc/html/latest/process/submitting-patches.html#developer-s-certificate-of-origin-1-1

> ---
>  drivers/soc/qcom/rpmh-rsc.c | 20 +++++++++++++++++++-
>  1 file changed, 19 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index a021dc71807b..5371d7e3090a 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
>   * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + * Copyright (c) 2023-2024, Qualcomm Innovation Center, Inc. All rights reserved.
>   */
>  
>  #define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
> @@ -91,6 +92,15 @@ enum {
>  #define CMD_STATUS_ISSUED		BIT(8)
>  #define CMD_STATUS_COMPL		BIT(16)
>  
> +#define ACCL_TYPE(addr)			((addr >> 16) & 0xF)
> +#define VREG_ADDR(addr)			(addr & ~0xF)
> +
> +enum {
> +	HW_ACCL_CLK = 0x3,
> +	HW_ACCL_VREG,
> +	HW_ACCL_BUS,
> +};
> +
>  /*
>   * Here's a high level overview of how all the registers in RPMH work
>   * together:
> @@ -557,7 +567,15 @@ static int check_for_req_inflight(struct rsc_drv *drv, struct tcs_group *tcs,
>  		for_each_set_bit(j, &curr_enabled, MAX_CMDS_PER_TCS) {
>  			addr = read_tcs_cmd(drv, drv->regs[RSC_DRV_CMD_ADDR], i, j);
>  			for (k = 0; k < msg->num_cmds; k++) {
> -				if (addr == msg->cmds[k].addr)
> +				/*
> +				 * Each RPMh VREG accelerator resource has 3 or 4 contiguous 4-byte
> +				 * aligned addresses associated with it. Ignore the offset to check
> +				 * for in-flight VREG requests.
> +				 */
> +				if (HW_ACCL_VREG == ACCL_TYPE(msg->cmds[k].addr) &&
> +				    VREG_ADDR(addr) == VREG_ADDR(msg->cmds[k].addr))
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
> 


