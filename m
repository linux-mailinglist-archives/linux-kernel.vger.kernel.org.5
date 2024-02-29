Return-Path: <linux-kernel+bounces-86822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87D5286CB47
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F281B22264
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:18:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89B8A1361A5;
	Thu, 29 Feb 2024 14:16:44 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5127612E1E3;
	Thu, 29 Feb 2024 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216204; cv=none; b=GvBW6cBWRXxsIiB4KLYNyRvQVouF/kOLNUAgrzicdEZfGKTXIzK9bgTa80/0tgujLx+DlSjTSjdwck6TcWumqD2p0B4O8EW4bPloWiS90bRwOikyYksy6NdluxfbaK+71FIabhBmevgkXThJv7J1T5+uDqjUnJrvQD1no6LiLmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216204; c=relaxed/simple;
	bh=CwPbKWNjMP0nh0cY2U+B8n7NhSWz1CSP0wEAb4gTmx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=plodutLIskgTGHgdErpDvHmcVQ8+UC5Vvqixwo2EkIj7zUGqcV5Sv2fwPMxTg6/X3GV2Cf19u/wLWj7RYxHnUyPZY3H5lpAljArvOug/h04Oz3BDT+FD+ju7DIUSpEKpj8C2gRxuUJtocEYWMf0FoiyavKfO+ublKMjmm9gJkKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 584511FB;
	Thu, 29 Feb 2024 06:17:20 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 610B23F6C4;
	Thu, 29 Feb 2024 06:16:39 -0800 (PST)
Date: Thu, 29 Feb 2024 14:16:36 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Cristian Marussi <cristian.marussi@arm.com>
Cc: Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
	Sudeep Holla <sudeep.holla@arm.com>, konrad.dybcio@linaro.org,
	jassisinghbrar@gmail.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
	quic_rgottimu@quicinc.com, quic_kshivnan@quicinc.com,
	conor+dt@kernel.org, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 3/7] firmware: arm_scmi: Add QCOM vendor protocol
Message-ID: <ZeCRxP9PnHK_UFK7@bogus>
References: <20240117173458.2312669-1-quic_sibis@quicinc.com>
 <20240117173458.2312669-4-quic_sibis@quicinc.com>
 <ZcpXx8NkVImwRqX-@pluto>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZcpXx8NkVImwRqX-@pluto>

On Mon, Feb 12, 2024 at 05:39:19PM +0000, Cristian Marussi wrote:
> > diff --git a/drivers/firmware/arm_scmi/Makefile b/drivers/firmware/arm_scmi/Makefile
> > index a7bc4796519c..eaeb788b93c6 100644
> > --- a/drivers/firmware/arm_scmi/Makefile
> > +++ b/drivers/firmware/arm_scmi/Makefile
> > @@ -17,6 +17,7 @@ obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-core.o
> >  obj-$(CONFIG_ARM_SCMI_PROTOCOL) += scmi-module.o
> >  
> >  obj-$(CONFIG_ARM_SCMI_POWER_CONTROL) += scmi_power_control.o
> > +obj-$(CONFIG_QCOM_SCMI_VENDOR_PROTOCOL) += qcom_scmi_vendor.o
> >  
> 
> I am starting to think to put vendor protocols in their own dedicated
> subdir given that a bunch of those appeared recently :D
> 

Yes I tend to agree with different subdir for each vendor. Not sure if we
need new Kconfig entry or just use ARCH_<vendor/group of SoC> to build all
subdir used by that vendor.

> ....have to discuss with Sudeep...anyway not really an issue...
> 
> any thoughts about this ?

In general, I see lot of discussions on this thread when I was away for
past 3 weeks. I will wait for newer version as that seems simpler for me
than getting lost to follow the discussions so far.

-- 
Regards,
Sudeep

