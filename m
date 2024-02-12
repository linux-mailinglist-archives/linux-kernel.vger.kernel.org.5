Return-Path: <linux-kernel+bounces-61568-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08648513BD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 531F41F2549D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624BD3A1A1;
	Mon, 12 Feb 2024 12:44:49 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076CD3A8C9;
	Mon, 12 Feb 2024 12:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707741888; cv=none; b=q3SRjbgp+CR0RT9eBUSe+l1rFia/3qGyRJlqlKNibODMBiYOKVbVEgEMk5HSJsF+w0cnl/VIM+G0F5imvuQpmxgBGpMLLsZ+0TsyfLvNdUw2KhUJ1Kh31FQwE4U8Nbsz/47hJkYHUUej2pLnd6NntqK94i07mz3YNLzTARW7xtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707741888; c=relaxed/simple;
	bh=l/7dfJGxFN1vuiXcbvnIb03xHav/j11oYSN+cyDnLuI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CNMPqfjzVXH2XXlmkc9uvgqVe7ZKYFvCyD1qBzVWDIP74v9DDLpMq77VnC8g+KmFuhZSitylATIAvPJoZTAbZgFKm074ou3Qh7Fpli3QQhx6zG+isNN/BaByFaEu3A0NtoXpGF3aWEOdnVP85HiJosIZdhK+wqu/9HnSg9J9jHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B275EDA7;
	Mon, 12 Feb 2024 04:45:27 -0800 (PST)
Received: from pluto (unknown [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A2CE33F7BD;
	Mon, 12 Feb 2024 04:44:44 -0800 (PST)
Date: Mon, 12 Feb 2024 12:44:42 +0000
From: Cristian Marussi <cristian.marussi@arm.com>
To: Sudeep Holla <sudeep.holla@arm.com>,
	Sibi Sankar <quic_sibis@quicinc.com>
Cc: viresh.kumar@linaro.org, morten.rasmussen@arm.com, rafael@kernel.org,
	dietmar.eggemann@arm.com, lukasz.luba@arm.com,
	linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org, quic_mdtipton@quicinc.com,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH V2 1/4] firmware: arm_scmi: Add perf_notify_support
 interface
Message-ID: <ZcoSuv7qwexbXy-9@pluto>
References: <20240117104116.2055349-1-quic_sibis@quicinc.com>
 <20240117104116.2055349-2-quic_sibis@quicinc.com>
 <ZbfJN1c9viiLhO1L@pluto>
 <ZbfhdqBBpjyf3IRI@pluto>
 <20240131112854.24euh6c6xgljsj6c@bogus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240131112854.24euh6c6xgljsj6c@bogus>

On Wed, Jan 31, 2024 at 11:28:54AM +0000, Sudeep Holla wrote:
> On Mon, Jan 29, 2024 at 05:33:42PM +0000, Cristian Marussi wrote:

Hi Sibi,

> > On Mon, Jan 29, 2024 at 03:50:20PM +0000, Cristian Marussi wrote:
> > > On Wed, Jan 17, 2024 at 04:11:13PM +0530, Sibi Sankar wrote:
> > > > Add a new perf_notify_support interface to the existing perf_ops to export
> > > > info regarding limit/level change notification support.
> > > > 
> > > 
> > > Hi Sibi,
> > > 
> > > as I mentioned previously, in order not to add a needless stream of SCMI
> > > Perf accessors I posted this:
> > > 
> > > https://lore.kernel.org/linux-arm-kernel/20240129151002.1215333-1-cristian.marussi@arm.com/T/#u
> > > 
> > > to expose all the Perf domains infos via the usual info_get(), similarly
> > > to how other SCMI protocols do already.
> > > 
> > > I think that reworking this series on that, you can certainly drop this patch and just
> > > check the _notify booleans on the retrieved domain info.
> > 
> > Sorry, but hold on with this change, I will probably post an updated version
> > my patch above.
> > 
> 
> As discussed in private, I would prefer to avoid exposing all the internals
> to the users of SCMI perf. At the same time may we can do better if we can
> check the availability of notification as part of notification enablement
> from the SCMI driver, I need to think the details yet.
> 

as previously mentioned, after speaking with Sudeep, I posted a new
series at [1], that aims to solve your problem with registering
notifications and looking up reported Perf frequencies in a new way.

Using the changes at [1] you should be able to:

- register your notifier without caring to check if the notification
  is supported, since the SCMI core will take care of checking that and
  report an error if not supported, without sending any unneeded
  attempted notification enable message  (so you can drop 1/4 in this
  series)

- retrieve the pre-calculated OPPs frequencies from the new extended
  Perf notifications reports no matter if the system if operating in
  level_indexing_mode or not. (so you can drop 2/4 in this series)

Thanks,
Cristian

[1]: https://lore.kernel.org/linux-arm-kernel/20240212123233.1230090-1-cristian.marussi@arm.com/T/#ma68cefd753e34ba3e1f2d4392e978026a87e1bf8


