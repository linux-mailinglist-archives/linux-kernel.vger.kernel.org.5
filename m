Return-Path: <linux-kernel+bounces-563-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 501538142F7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 08:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 014B3284793
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 07:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1250210963;
	Fri, 15 Dec 2023 07:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vNrcWIPF"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D7EF107A4;
	Fri, 15 Dec 2023 07:50:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF90BC433C7;
	Fri, 15 Dec 2023 07:50:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702626635;
	bh=vbor0/x22PNu3gqlwMMEYKNlzreoR29T2zrYtNDm+o8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vNrcWIPFK81LdUvYkAvK3OXRcr0rv6R0UunNq23hDRlD087FCNlakv959X2MsvnQS
	 80YVslQkp57pnuAj3B6M0UU6fZ+aZzctt3U398gRKxNPurKsPu7hYK0a2bgt624dZn
	 SHCOoLuWK5Y43Oj4b9mNamaPaxr2AVoktXxz8NdPgZagn6o4pjPQXfvBoGYhsbSmbO
	 cUZ4l/PzS5mge5JtJvG1yv5ox/nLDywbUy2wifezM0B++QKXnyPyggjVP+Xllc6Cqf
	 ti5EV/7Vjcg9gHH7tS0XBT/nX1WTHSDDzgkXrBtB18lFaH+k6rf3ee2H95r1iRk9Bl
	 aTW+BIoEXmjBQ==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rE2xq-0006BT-2N;
	Fri, 15 Dec 2023 08:50:30 +0100
Date: Fri, 15 Dec 2023 08:50:30 +0100
From: Johan Hovold <johan@kernel.org>
To: Rob Clark <robdclark@gmail.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	linux-arm-msm@vger.kernel.org, Rob Clark <robdclark@chromium.org>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: pmic_glink: Fix boot when QRTR=m
Message-ID: <ZXwFRgPOEFGF-ac2@hovoldconsulting.com>
References: <20231213210644.8702-1-robdclark@gmail.com>
 <ZXqr0RFw9KsP876v@hovoldconsulting.com>
 <CAA8EJpoSvaq9imP-dT4p=4jveZyFmh=OoWOP7jWGo4OYkHQDTA@mail.gmail.com>
 <ZXsKzsij3Xb50Ap9@hovoldconsulting.com>
 <CAA8EJpqBstKyAfUcBPzoF2CitTwWBZ9Xhd28Y+FCo14OoBqkxw@mail.gmail.com>
 <ZXsMoFiivUCWA0yr@hovoldconsulting.com>
 <ZXshe83quTE0jO_Z@hovoldconsulting.com>
 <ZXsojADuspUVLbIn@hovoldconsulting.com>
 <CAF6AEGtQ-73voz3Wc6YkQ-UipbM9JsmZ06C_W_zKH4Qy8v-biQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF6AEGtQ-73voz3Wc6YkQ-UipbM9JsmZ06C_W_zKH4Qy8v-biQ@mail.gmail.com>

On Thu, Dec 14, 2023 at 12:44:10PM -0800, Rob Clark wrote:
> On Thu, Dec 14, 2023 at 8:08 AM Johan Hovold <johan@kernel.org> wrote:
> >
> > On Thu, Dec 14, 2023 at 04:38:35PM +0100, Johan Hovold wrote:
> >
> > > I took a closer look at this and indeed we do have code that triggers a
> > > reprobe of a device in case there was a successful probe while the
> > > device was probing.
> > >
> > > This was introduced by commit 58b116bce136 ("drivercore: deferral race
> > > condition fix") and the workaround for the reprobe-loop bug that hack
> > > led to is to not return -EPROBE_DEFER after registering child devices as
> > > no one managed to come up with a proper fix. This was documented here:
> > >
> > >       fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")
> > >
> > > But please spell this out in some more detail in the commit message, and
> > > add a Fixes and CC stable tag.
> >
> > And please update the commit summary as I've been booting with QRTR=m
> > all along just fine. I guess the issue is if you have pmic_glink
> > built-in or in the initramfs but forgot to include qrtr or similar?
> 
> I do have both QRTR=m and QCOM_GLINK=m.  I'm honestly not sure what
> started triggering this issue for me.. it seemed to have started after
> merging msm-next + drm-misc-next on top of your
> jhovold/wip/sc8280xp-v6.7-rc5 (the merged branches were based on -rc3
> so this shouldn't have really brought in random non-drm things).
> Maybe there is a timing element to it?

Yeah, possibly, and device links may also come into play here.

> I felt like the problem was obvious enough, and the exact details of
> why I started hitting this were not important enough to spend time
> tracking down.

The patch itself is of course fine itself as a clean up (or
microoptimisation) but the claim that it solves, and is the correct fix
for, a probe loop issue is not obvious at all and requires some further
justification.

Since he last time someone suggested reverting the commit that
introduced the probe-loop issue, the result was to leave things as they
were and just document the workaround, it should be fine to just refer
to that commit:

	fbc35b45f9f6 ("Add documentation on meaning of -EPROBE_DEFER")

Perhaps you can keep the Subject if you make it clear in the commit
message that this bug isn't always hit with QRTR=m.

Johan

