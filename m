Return-Path: <linux-kernel+bounces-74775-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 071F885D9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:21:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89215B2481B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 13:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED337A70E;
	Wed, 21 Feb 2024 13:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNCLnebn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1083653816;
	Wed, 21 Feb 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708521670; cv=none; b=sJg34yxA9+PU0CmGtQsZRouZL00kIhbMKhpLqTBwbbGgzQbUWYJ4r/TqNAtehPKWSLaVlMKg4FKsr5sEsemwN9Hwjfe/MW0jflhhTCJjolQFAc3O7dB4WxBFOjCEoXPd+ojpA2f8G6Np6Aotg5RZ8LfgBp8FAaI6NUC3Euxrsmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708521670; c=relaxed/simple;
	bh=vZ/3Z3kWjsvIRSCYP+NqhBkV01COSs3cgT6ojHsts0Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RrZG4hLzEdVvb4cgWlCMh593JvK2yCi6+lKsdssYJcxrBNYQ3xFVhrfEZLQef5FKBsDck1mnQcw5ICzaG2m6IAaTlJHjvxl+/JI0SpS0c8TP7onSGr57sOqqGnzsn4rW/rpE3bmn2ogVadMKERxqgi60dvBD0oquibwePV1LwBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNCLnebn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06DBEC433F1;
	Wed, 21 Feb 2024 13:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708521669;
	bh=vZ/3Z3kWjsvIRSCYP+NqhBkV01COSs3cgT6ojHsts0Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lNCLnebnbcp9cdVqA+fkBdmc+S9vQFvdUArU7QeU/aR8J7gl8+wshxTVPN7cbgc14
	 N0aTytKwlkF8rbLP0QGmHj9D2YQzdG5w1Hl/wBjdoRxBZGxwT2f8TittX1DxvXI+vZ
	 VBrckXg9iamrvXsAvN/joX2ifR4tj/HDIeNIZbEtZg0bFK8FcS1v4l5lskjVbIn7td
	 97Ja5yzOvqE1xHJc4sVL9gHJk4Ol0PiSRc9TrkirxAbVKMJUYwCJdnUyiB/bPKb7Ex
	 UWSMRHQfmAr9kjkF8JyBU2gpNtUlmzGdx36uQ+YC41VnJbZaK2uQX/tEvn6FJ39zRV
	 rfzdU1zIyvwUw==
Date: Wed, 21 Feb 2024 13:21:02 +0000
From: Will Deacon <will@kernel.org>
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robin.murphy@arm.com, joro@8bytes.org, dmitry.baryshkov@linaro.org,
	konrad.dybcio@linaro.org, jsnitsel@redhat.com,
	quic_bjorande@quicinc.com, mani@kernel.org,
	quic_eberman@quicinc.com, robdclark@chromium.org,
	u.kleine-koenig@pengutronix.de, robh@kernel.org,
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com,
	quic_molvera@quicinc.com, linux-arm-msm@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
	saravanak@google.com
Subject: Re: [PATCH v9 4/5] iommu/arm-smmu: add ACTLR data and support for
 SM8550
Message-ID: <20240221132101.GB7273@willie-the-truck>
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
 <20240123144543.9405-5-quic_bibekkum@quicinc.com>
 <20240213134714.GC28926@willie-the-truck>
 <201fef09-50ab-436b-af63-4535c7510d15@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201fef09-50ab-436b-af63-4535c7510d15@quicinc.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Wed, Feb 21, 2024 at 02:25:26PM +0530, Bibek Kumar Patro wrote:
> On 2/13/2024 7:17 PM, Will Deacon wrote:
> > On Tue, Jan 23, 2024 at 08:15:42PM +0530, Bibek Kumar Patro wrote:
> > > Add ACTLR data table for SM8550 along with support for
> > > same including SM8550 specific implementation operations.
> > > 
> > > Signed-off-by: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
> > > ---
> > >   drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c | 90 ++++++++++++++++++++++
> > >   1 file changed, 90 insertions(+)
> > > 
> > > diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > index 6004c6d9a7b2..db15b1eade97 100644
> > > --- a/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c
> > > @@ -23,6 +23,86 @@
> > > 
> > >   #define CPRE			(1 << 1)
> > >   #define CMTLB			(1 << 0)
> > > +#define PREFETCH_SHIFT		8
> > > +#define PREFETCH_DEFAULT	0
> > > +#define PREFETCH_SHALLOW	(1 << PREFETCH_SHIFT)
> > > +#define PREFETCH_MODERATE	(2 << PREFETCH_SHIFT)
> > > +#define PREFETCH_DEEP		(3 << PREFETCH_SHIFT)
> > > +#define PREFETCH_SWITCH_GFX	(5 << 3)
> > > +
> > > +static const struct actlr_config sm8550_apps_actlr_cfg[] = {
> > > +	{ 0x18a0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> > > +	{ 0x18e0, 0x0000, PREFETCH_SHALLOW | CPRE | CMTLB },
> > > +	{ 0x0800, 0x0020, PREFETCH_DEFAULT | CMTLB },
> > > +	{ 0x1800, 0x00c0, PREFETCH_DEFAULT | CMTLB },
> > > +	{ 0x1820, 0x0000, PREFETCH_DEFAULT | CMTLB },
> > > +	{ 0x1860, 0x0000, PREFETCH_DEFAULT | CMTLB },
> > > +	{ 0x0c01, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > > +	{ 0x0c02, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > > +	{ 0x0c03, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > > +	{ 0x0c04, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > > +	{ 0x0c05, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > > +	{ 0x0c06, 0x0020, PREFETCH_DEEP | CPRE | CMTLB },
> > 
> > [...]
> > 
> > Isn't this effectively hard-coding the topology of the SoC in the driver?
> > Wouldn't it better describing higher-level prefetch properties in the DT
> > nodes corresponding to the upstream devices?
> 
> Since prefetch data stored in this table represent settings for the
> ACTLR register, and doesn't exactly define the hardware (So in this
> manner prefetch data won't exactly be a part of soc topology ?).

The first two columns of the table are StreamID/Mask pairs, no? How is that
_not_ the SoC topology? I really think it would be better to define some
high-level prefetch properties in the DT binding which can be put on the
master nodes.

> So it seemed apt not to use the device tree for storing the prefetch
> property. Hence we reverted from the DT approach (initial proposal in
> RFC to piggyback on iommus property to store prefetch settings) back to use
> driver for storing this data.
> 
> Some drivers use the same approach for storing their platform specific
> data. Examples being
> drivers/phy/qualcomm/phy-qcom-qmp-combo.c
> drivers/soc/qcom/llcc-qcom.c
> These drivers were taken as reference for storing platform specific ACTLR
> data.

I don't know anything about those drivers, but on the SMMU side we already
have ways to describe the topology in the DT and the driver is using them,
so I'm struggling to see the need to add these tables as well.

But as I said before, if Robin and the DT folks prefer this approach,
then I won't get in the way.

Will

