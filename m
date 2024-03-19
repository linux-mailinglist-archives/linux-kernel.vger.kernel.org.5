Return-Path: <linux-kernel+bounces-107915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06389880377
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF911F230B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:28:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6A2746D;
	Tue, 19 Mar 2024 17:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NtdOUzi1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB60208C4;
	Tue, 19 Mar 2024 17:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710869282; cv=none; b=Q07Lhov5i9olEIUKNdMlpyZMXUv92oDLjHYF1f6C+k7SsECuaemQV1hjl0GUamA8e/S1glxsfLUQ+7bOmY/k9oa2TLlJS7o+gQ5XeZagP0BSN9v4W3Awa7c90A0gvAUl1o6Tu2t9xXIhvHQbfFZtWiWdRaZaJWb3aMUaeJLMMXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710869282; c=relaxed/simple;
	bh=BmjDLFOVVf87fF20Q7iFvAzUVKO78z0OH3SPBHvtlbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX3+dN739BAodExrGZk+DiRLMCSwloy4uohZlOxAPNhue//wOuTYq0O5kd173IQmsIqirk6k1TB1ifBV6oxcvY5Yf3Omd04MUeVP7asKD3Es2eJFMZb/nflsJu2gcT9uZfpNlqnwvvK6CtUl2XneDFPE7TPCrjoDPISrcnh1Ka0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NtdOUzi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBC59C433C7;
	Tue, 19 Mar 2024 17:28:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710869281;
	bh=BmjDLFOVVf87fF20Q7iFvAzUVKO78z0OH3SPBHvtlbk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NtdOUzi1Q7UTk4HP/QwEE2ZYOe/YCr2YpzkB4PTRdc+9wk2nMfXs4QD8zMx7LwB/A
	 IhyFX8fahAwF7tColwxJw8emGbkDZkS37rdht4o5D+n9NpWjbMN0NIVUUnueEbhanc
	 RV+kHQ2H1sv0UpkQamqsXRwglPqYp7I+iWijNzlHW4nqyzOVzhsjnyrvhtF+lgce69
	 toxyg2DnmNRTIS0wo1jNWg63A/UJd/oYO0GcJRANUHhIzK+9czpyGCFbY6wcn1ZEbX
	 x1TAEgRfQspZTLRkhAKJnMbf3lmK6QyEUWiveiuA7mW8QNJywOZG/MoL4TFjpXrR4k
	 XqQQjOZ5FFDVg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rmdFw-0000000014I-093X;
	Tue, 19 Mar 2024 18:28:08 +0100
Date: Tue, 19 Mar 2024 18:28:08 +0100
From: Johan Hovold <johan@kernel.org>
To: Doug Anderson <dianders@chromium.org>
Cc: Johan Hovold <johan+linaro@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	cros-qcom-dts-watchers@chromium.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
	Matthias Kaehlcke <mka@chromium.org>,
	Rocky Liao <quic_rjliao@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	Nikita Travkin <nikita@trvn.ru>
Subject: Re: [PATCH v3 3/5] Bluetooth: qca: fix device-address endianness
Message-ID: <ZfnLKC7B9o2reC8x@hovoldconsulting.com>
References: <20240319152926.1288-1-johan+linaro@kernel.org>
 <20240319152926.1288-4-johan+linaro@kernel.org>
 <CAD=FV=WqwY07fMV-TuO8QMRnk555BJYEysv4urcugsELufHr4A@mail.gmail.com>
 <Zfm_oFLNgPHqJKtG@hovoldconsulting.com>
 <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=FV=UgCNmeWJiwWAGj_jm78eeTNoo-_bx7QrqLfyDMJwRNKA@mail.gmail.com>

On Tue, Mar 19, 2024 at 10:12:25AM -0700, Doug Anderson wrote:
> On Tue, Mar 19, 2024 at 9:38 AM Johan Hovold <johan@kernel.org> wrote:
> > On Tue, Mar 19, 2024 at 09:10:38AM -0700, Doug Anderson wrote:

> > > Personally, I'd prefer it if you didn't break bisectability with your
> > > series. As it is, if someone applies just the first 3 patches they'll
> > > end up with broken Bluetooth.
> >
> > It doesn't break the build, but yes, the device address would be
> > reversed for Trogdor machines for two commits and possible break any
> > previous pairings. That's hardly something to worry about.
> >
> > So I consider this to be acceptable for sake of clarity, and especially
> > since these patches will be coming in from separate trees anyway.
> 
> I guess I have a different opinion on the matter. I often end up
> cherry-picking stuff to older branches and I generally assume that
> it's relatively safe to pick the beginning of a series without picking
> later patches because I assume everyone has a goal of bisectability.
> This breaks that assumption. IMO splitting up the Qualcomm Bluetooth
> patch into two patches doesn't help enough with clarity to justify.

I did that in v2 because then the two patches had to be split to
facilitate backporting as wcn3991 support was added later.

But the big issue here is taking the patches through different trees. If
Bjorn could ack the DT patch so that everything goes through the
Bluetooth tree, then I guess I can reorder the DT patch and squash the
two driver patches.

But waiting several weeks just to make sure that the DT patch hits
mainline (and the binding patch before that?) before the driver fixes
can go in just does not seem worth it to me.

> > I don't think it's worth spending more time and effort on this issue
> > (which should have been caught and fixed years ago) for this.
> 
> Sure, that's your opinion and if the BT folks agree with you then they
> are free to land the patches without my Reviewed-by on them. ;-) Mine
> is not a strong Nak but I feel strongly enough that I'd prefer not to
> have my Reviewed-by added without the re-organization.

Of course, understood.

Johan

