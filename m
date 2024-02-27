Return-Path: <linux-kernel+bounces-83663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA4E9869D09
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 15F58B31E50
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8436B4E1C8;
	Tue, 27 Feb 2024 16:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nCR9YSNx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC6E4CB45;
	Tue, 27 Feb 2024 16:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709052976; cv=none; b=LHlj/jD62iog8MDD13knpDJ+5ldzVZcK50tW7tVrQrv7wv/RFjCQsU97vTOm4Psj+D1MoUFZv99FBKMNH8UoPFcqUsvSC32ZEn84gobrEPUblfcxW1KG09HV1APzo+axLZPsH9VGH/NNUicWSL0oA6RKx17t/XWWT7RoVLDYNpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709052976; c=relaxed/simple;
	bh=mgo4yeLW+ttbeoLLIJzNjCrFuHKZlPxeJXjaNZAMcI0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MpdjDFDb7wH44WZr9rEdFfrQZw7VN1dcIKjwR1rNsB2dqYCbahkQ2jJU1SgIf9o65bH3HEufgpjkwJoeuyfONqgIluxLHt1Q3mxrJeO3uz46EXOxvRFNX/6j/YSXHWe3lESNWrPgvUxfZ7n5qPbxUppQBEH8KsVKh0J0fzMm8xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nCR9YSNx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE5D0C43390;
	Tue, 27 Feb 2024 16:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709052976;
	bh=mgo4yeLW+ttbeoLLIJzNjCrFuHKZlPxeJXjaNZAMcI0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nCR9YSNxDsGHxuUxMe5KNkYXeWRSiNau8RDAEKw2r0FpQZxwnp7Ug5CEVJCr1WgXL
	 44/PFr6XlhBYZ31wanYypbkwUXPk/V6zFkm5pfOuEaOi71F+Zp88Lnf//B3cMondZJ
	 SutV0wVSlQUUUq/kyrofo8LlH5kjd5+Om1zIeFkyLunuq9YtnAOvUNNydMbS4MJ5GL
	 h5xsZQy6w922uQT/HRZU+HD/Oj28Nrz1bQ9wA5z4hXZzB3q99ZL/SJJxR8rBcm2K5S
	 5FDwUy54QkNe9o1gD1kg3KnMEsOUXO+EP0yczauP4ewdn7GbOGTEYlg6oKirt4UAe1
	 FKQRBWaxc7RaA==
Date: Tue, 27 Feb 2024 10:56:13 -0600
From: Bjorn Andersson <andersson@kernel.org>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andy Gross <agross@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Elliot Berman <quic_eberman@quicinc.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Guru Das Srinagesh <quic_gurus@quicinc.com>, 
	Andrew Halaney <ahalaney@redhat.com>, Maximilian Luz <luzmaximilian@gmail.com>, 
	Alex Elder <elder@linaro.org>, Srini Kandagatla <srinivas.kandagatla@linaro.org>, 
	Arnd Bergmann <arnd@arndb.de>, linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, kernel@quicinc.com, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, Deepti Jaggi <quic_djaggi@quicinc.com>
Subject: Re: [PATCH v7 10/12] firmware: qcom: tzmem: enable SHM Bridge support
Message-ID: <mq63i2dlfop67zzs5q4r7v7ogeoqdi74h6rapgyur5y6a33kyo@cdxckvywotxd>
References: <20240205182810.58382-1-brgl@bgdev.pl>
 <20240205182810.58382-11-brgl@bgdev.pl>
 <7pybw4wxlzxfl65yuqxzks5w7uq52hosyq53etlzas6i6o5l6d@vxd4sykcxora>
 <CAMRc=MfTtcFb=7vDfkFiaPYvb+o6o4zd_RnYd2om+cAiaKY2dQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=MfTtcFb=7vDfkFiaPYvb+o6o4zd_RnYd2om+cAiaKY2dQ@mail.gmail.com>

On Thu, Feb 22, 2024 at 05:24:19PM +0100, Bartosz Golaszewski wrote:
> On Sun, Feb 18, 2024 at 4:41 AM Bjorn Andersson <andersson@kernel.org> wrote:
> >
> > On Mon, Feb 05, 2024 at 07:28:08PM +0100, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> 
> [snip]
> 
> > >
> > > +config QCOM_TZMEM_MODE_SHMBRIDGE
> > > +     bool "SHM Bridge"
> > > +     help
> > > +       Use Qualcomm Shared Memory Bridge. The memory has the same alignment as
> > > +       in the 'Default' allocator but is also explicitly marked as an SHM Bridge
> > > +       buffer.
> > > +
> > > +       With this selected, all buffers passed to the TrustZone must be allocated
> > > +       using the TZMem allocator or else the TrustZone will refuse to use them.
> >
> > It's funny how this is the only place in the whole series I can find
> > this mentioned. One could from this statement guess that the eluding
> > scminvoke requires shmbridge and that this patch series exists solely
> > to facilitate the requirement stated in this paragraph.
> >
> 
> Yes, scminvoke *requires* SHM bridge. So does the wrapped key support.
> No, this is not the only reason as - as stated by Srini - it improves
> overall safety of the system for all users.
> 
> > Either this guess is correct and this should have been made clear in
> > the commit messages, or I'm guessing wrong here, in which case I need
> > some help to figure out why this series exists.
> >
> 
> This series exists and IMO should get upstream soon to facilitate
> adding new security features (in addition to improving existing ones).

This needs to be stated in the cover letter/commit messages.

> As there are at least two such features in development (mentioned
> above) pushing this series upstream will make it easier to develop
> them independently.
> 

Show me the work-in-progress code and I will entertain this argument.

Regards,
Bjorn

> Bart
> 
> [snip]

