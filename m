Return-Path: <linux-kernel+bounces-136139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584E489D067
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 04:34:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF99A1F230C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 02:34:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3617F54736;
	Tue,  9 Apr 2024 02:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TfxLRoCY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7704553E28;
	Tue,  9 Apr 2024 02:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712629985; cv=none; b=TpsXPOedvDj4KiImV2k2hMtYqegEFsWx6Yl0TuRFYHG/3gf8H/IsrywkHjWwzx7P1hthW6cnRgq1LsHiwcpDDQbFyavm5O81hmFRIv0KrJAA1VUSXwkVCs6VysyJ6/CQ7qBHa8zIzfp3el9Ft/sjY1RlRYsRTG4PBJEjm+W3nxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712629985; c=relaxed/simple;
	bh=kaZl5aohS6PHHFbY2k20Vr3WSpd8PK+x4cpaK0dNKmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t73FtQt6hCohHN1H3SF4EJBasQ+30RcCstb2m3cBTS+nZqNKc2x6rO4D7PFNdlxShNLKSelgN0JKYM89+O2oAdzee6ON4MjcSCXvi1z3suPbCXk3Y1P8+TIVwCUMa56DxMh+6KlWWAWa9UUt1M0WFr9IrKhHnBMwORKCb3oJdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TfxLRoCY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD6ECC433F1;
	Tue,  9 Apr 2024 02:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712629985;
	bh=kaZl5aohS6PHHFbY2k20Vr3WSpd8PK+x4cpaK0dNKmk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TfxLRoCYZ6eJmGn+zCrqSrSkyt8vdVMAYrrgcWYfH859DTwiz0QbeOkUl2gd8W3wW
	 tYfgW7Q4nSZAaIHPaNygIb543E+DdcPaBQWEAskTmSYqGzbSMD/tmjk9OSEZZCfn4n
	 dDBQvkJ9RZU4L+R4pwcOegp16Xftx13uPA4ZK1/74W8iDNNzggQdMlzc09tn5Lp4ae
	 Xw7doy/Cq5BvOhsacixw895GRwCODLpBSviiHmv1691KUlgEEfNeTholDarGPFuBee
	 E5LCvi/ngmgTS16bEBVYBqU/pJYKTydYkHjfi4xa0VDHH3HPoDbNQhAWi+j69szgvs
	 8srocdUR5vi7g==
Date: Mon, 8 Apr 2024 21:33:01 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, swboyd@chromium.org, 
	quic_jesszhan@quicinc.com, quic_bjorande@quicinc.com, johan@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
Message-ID: <covjipaso7bhgiifb62vdh24dpadr7kdypl2dleg7a2vc4jwjd@s4ci5xc6qpa3>
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
 <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
 <01cb1c0d-a801-37f9-2f55-2bbd8d3a68b9@quicinc.com>
 <CAA8EJprzH0LiWNx9Udt6og3G063odY6ccvaAgsNS1r3zG8TmdA@mail.gmail.com>
 <905222ad-612a-3eaf-d966-23c89c99e1f0@quicinc.com>
 <CAA8EJpp6Lc7sc5fnKp+O8TYdaywiE+dZ=YJin351s=r5rxi+Kw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAA8EJpp6Lc7sc5fnKp+O8TYdaywiE+dZ=YJin351s=r5rxi+Kw@mail.gmail.com>

On Tue, Apr 09, 2024 at 01:07:57AM +0300, Dmitry Baryshkov wrote:
> On Tue, 9 Apr 2024 at 00:23, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > On 4/8/2024 2:12 PM, Dmitry Baryshkov wrote:
> > > On Mon, 8 Apr 2024 at 22:43, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> > >> On 4/7/2024 11:48 AM, Bjorn Andersson wrote:
> > >>> On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
> > >>>> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
> > >>> [..]
> > >>>> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
[..]
> > >>
> > >> I will need sometime to address that use-case as I need to see if we can
> > >> handle that better and then drop the the DISCONNECT_PENDING state to
> > >> address this fully. But it needs more testing.
> > >>
> > >> But, we will need this patch anyway because without this we will not be
> > >> able to fix even the most regular and commonly seen case of basic
> > >> connect/disconnect receiving complementary events.
> > >
> > > Hmm, no. We need to drop the HPD state machine, not to patch it. Once
> > > the driver has proper detect() callback, there will be no
> > > complementary events. That is a proper way to fix the code, not these
> > > kinds of band-aids patches.
> > >
> >
> > I had discussed this part too :)
> >
> > I totally agree we should fix .detect()'s behavior to just match cable
> > connect/disconnect and not link_ready status.
> >
> > But that alone would not have fixed this issue. If HPD thread does not
> > get scheduled and plug_handle() was not executed, .detect() would have
> > still returned old status as we will update the cable status only in
> > plug_handle() / unplug_handle() to have a common API between internal
> > and external hpd execution.
> 
> I think there should be just hpd_notify, which if the HPD is up,
> attempts to read the DPCD. No need for separate plug/unplug_handle.
> The detect() can be as simple as !drm_dp_is_branch() || sink_count != 0.
> 

What is detect() supposed to return in the event that we have external
HPD handler? The link state? While the external HPD bridge would return
the HPD state?

If a driver only drives the link inbetween atomic_enable() and
atomic_disable() will the "connected state" then ever be reported as
"connected"? (I'm sure I'm still missing pieces of this puzzle).

Regards,
Bjorn

