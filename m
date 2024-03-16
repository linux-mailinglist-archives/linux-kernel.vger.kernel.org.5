Return-Path: <linux-kernel+bounces-105262-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 36EF587DB2C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB098B21A4D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:58:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838BA1BF3A;
	Sat, 16 Mar 2024 17:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RXcYuBuh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD401C680;
	Sat, 16 Mar 2024 17:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710611883; cv=none; b=apcB+4MciRKmDjgHt5mDdO07XwxH5ytnoiAl+IGNa0JaKA+NXBz0WJVp3uVllGI5srU6ihnn3dhNVXbsrRiWgP2A8sp7E20A4+5BwtgZ45C8RRcF6owuvnDOo1lFm9kxKIKC5225BlO5qKst/xjAIN9zYH9N2Bz8xlMMftgaBEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710611883; c=relaxed/simple;
	bh=LLxDN7DJwsrWN3R0UF5L0gaj2YrCdYe/2m3/JYHm58I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O+YG4u9VUpjF6a81tPcnkgOwkqGhjisgDslheIodOGjfv/7hl8tAE24OADdUkW02Y3RlEI5YA+wc+eiyP1dP/X7hTjcFqFTyaLeRISnt7Z9i/3t+sQ6bOx+gUDFSgkkHh8wRAA4cePLtGxhyHVOl8Qcz2kHR1rCsaAmnBDkHTKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RXcYuBuh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4F88C433C7;
	Sat, 16 Mar 2024 17:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710611883;
	bh=LLxDN7DJwsrWN3R0UF5L0gaj2YrCdYe/2m3/JYHm58I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RXcYuBuhrvYt6pjLrkaJsyFmEHzw+gWtEIb3d04M/HZbByHSkhaQf0DGYR1DUsZDG
	 L2/wbW4XsS3AdvhNSWsM/02xOcEjNW9hbl5NibcyQt3oEbqQNFiUp4L0m5xGSEOYDu
	 687QwOmu+X2EJntLsZd0nNbHhlWN1y0/k15GkB2GFc2JS+LFt9rfdqZ85ywPXm59wt
	 aWuEbe+Gcxm4k+n2wjvcJ7E1AaLiJvKN5AP7+S9f4BV6RmEEwz6e+JkbkKNGsFvFnr
	 CWOvlQPWNPD0E0WndHRJYZsxL3XrOPTvHObyu2X36ws5yAN/0QZ0K0j11gAOQ7sdSt
	 Dk8gpLYDWZUrw==
Date: Sat, 16 Mar 2024 12:58:01 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Gabor Juhos <j4g8y7@gmail.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Message-ID: <c2iyfoy4io73hzjdxbvropofxdpyzkulskq5szazbuwmlrjetg@6dhzjcmcswpc>
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
 <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
 <20240305200306921-0800.eberman@hu-eberman-lv.qualcomm.com>
 <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fdb87f5-3702-44d9-9ebe-974c4a53a77d@linaro.org>

On Wed, Mar 06, 2024 at 05:02:37PM +0100, Konrad Dybcio wrote:
> 
> 
> On 3/6/24 05:10, Elliot Berman wrote:
> > On Tue, Mar 05, 2024 at 10:15:19PM +0100, Konrad Dybcio wrote:
> > > 
> > > 
> > > On 3/4/24 14:14, Gabor Juhos wrote:
> > > > There are several functions which are calling qcom_scm_bw_enable()
> > > > then returns immediately if the call fails and leaves the clocks
> > > > enabled.
> > > > 
> > > > Change the code of these functions to disable clocks when the
> > > > qcom_scm_bw_enable() call fails. This also fixes a possible dma
> > > > buffer leak in the qcom_scm_pas_init_image() function.
> > > > 
> > > > Compile tested only due to lack of hardware with interconnect
> > > > support.
> > > > 
> > > > Cc: stable@vger.kernel.org
> > > > Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> > > > Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> > > > ---
> > > 
> > > Taking a closer look, is there any argument against simply
> > > putting the clk/bw en/dis calls in qcom_scm_call()?
> > 
> > We shouldn't do this because the clk/bw en/dis calls are only needed in
> > few SCM calls.
> 
> Then the argument list could be expanded with `bool require_resources`,
> or so still saving us a lot of boilerplate
> 

I don't think there's reason for making this more general, because I
think this is a problem specific to PAS - much related to Bartosz
special handling of shmbridge for these calls.

It would be very nice if someone could help document why this is.

Regards,
Bjorn

