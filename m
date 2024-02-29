Return-Path: <linux-kernel+bounces-86841-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B1986CB8C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 15:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B98A284055
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 14:28:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D18B1350EF;
	Thu, 29 Feb 2024 14:27:53 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 600C712E1E3;
	Thu, 29 Feb 2024 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709216873; cv=none; b=q5psmjm14rNFne1/9MM5EsPZ82AM6jb3nUUcdOTH8KrfBrucbH1nI3uN5lUz1i6p3imnXKS76Xvir2Oc39R76yGydDUVEbzWLNXCcMmtLnqLI6BOvX8Tvp0WCOZFfyYoXfsG4zapyctdhMiUEEoil0EqiEF4vcFtpLCbWctPdAQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709216873; c=relaxed/simple;
	bh=mLugH3aooFG4/leFki5Lw96GURVocZkDSRqqnTwtSOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gloHkOkrpJvwkTaac0ypU2XppV6zw4SiK2l/dyT0GWysnc21ck+DhPwwFnl9fQWIGL+Mh/BqBOfQqnXtD13NPBrvtlGm97FVe0RDiqANeJwrXamo7DL8Gy5dq9U/wIbOjF3Uy0gkuiPaAOkt0XaRwFf/Mq3h6AaLXsobmVsXfIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B09B1FB;
	Thu, 29 Feb 2024 06:28:29 -0800 (PST)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FDBA3F6C4;
	Thu, 29 Feb 2024 06:27:48 -0800 (PST)
Date: Thu, 29 Feb 2024 14:27:45 +0000
From: Sudeep Holla <sudeep.holla@arm.com>
To: Sibi Sankar <quic_sibis@quicinc.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>, <cristian.marussi@arm.com>,
	<andersson@kernel.org>, <konrad.dybcio@linaro.org>,
	<jassisinghbrar@gmail.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<quic_rgottimu@quicinc.com>, <quic_kshivnan@quicinc.com>,
	<conor+dt@kernel.org>, Amir Vajid <avajid@quicinc.com>
Subject: Re: [RFC 4/7] soc: qcom: Utilize qcom scmi vendor protocol for bus
 dvfs
Message-ID: <ZeCUYVnZ8ZTRBobV@bogus>
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

I won't comment or worry about those silly details yet. I would like to
understand the design better first and all these can be sorted when we
get closer to getting this merged.

-- 
Regards,
Sudeep

