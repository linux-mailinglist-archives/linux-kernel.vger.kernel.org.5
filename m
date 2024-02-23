Return-Path: <linux-kernel+bounces-78571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFFC861532
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:07:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A1A1B23959
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A8A5FEE5;
	Fri, 23 Feb 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tL5Winiv"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542D77175E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 15:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708700850; cv=none; b=Qwz8BjMWg2BGAtFi4/ZqbUbq5cfWtfqH6SUcRsGQyIMa+AOf0QHziXEFwECN7+EWrGryMUoBbTC/M8P/A2fssJtzVqIzye4ApoiE9064w574yeuCgLB/hGyBlZFkV/2eJXN6gsIQOXXS/YcMpEYRo3SITg4aOCE6VFRemy0hnG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708700850; c=relaxed/simple;
	bh=NId8MgG3/SUMuIAbVWmEJCUH5j84rbDkiitN42p58MU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BVm0hmIc6Pz8ergOjnnuGytPT19vPZNR+E255dFEWRGs1+8TW6IZ49sCLEO4LANYFwx/woZnTefZVYdL6V9dwPe2tyg4D4uqvDSd0uvE79m4FY0pQv9FsvF6O7zJGc5P1HJQPZSwsKJuxoeb/k0KzKDvlCPAC2sR+CtEiGWKbDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tL5Winiv; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dc742543119so956160276.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 07:07:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708700846; x=1709305646; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=A7N/x1XZZ13w/J9RvBvRRguBA+rtWAzOoF+dbMHjtzE=;
        b=tL5WinivURQifsKX2Qrj54bUzsMPHFHSfCwnuhC06fF78go07/iN237ceHrEHQWqFC
         nWAJKgOs/qCGTuHPLDuaW4wk3MgO+miF5MdD9Ok7zFAGcyxlpOsV6Nq9p1fg1ZQkUjjh
         EGAVN1WEZbLIT5fRXo2766xLNEVDMx30eIlV00yVJnlvNiktA9NXGC4JPZKEz7nRFCcr
         B7/4LEZ4IkjOQ06RaCtvDM8Dm6KUcjHWWl2fa6fcaXW9nHPOQh/v3V+7p2zi8hxc6wkG
         VM11Asq9asMEKFQ4/Qjr8glRboQGa1GqXH+yL1NgSWNFr/LNrGWHWcU9V3Ila0SDVXPt
         QVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708700846; x=1709305646;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A7N/x1XZZ13w/J9RvBvRRguBA+rtWAzOoF+dbMHjtzE=;
        b=qlQXnxOoc7r5rjQLgGos/1ZR5Bb3xK/S5TxwBq0Ma+MqX/uDAyJQxAk5WQe/8hjA3q
         E42U3rgUqycXAwWY+GlqJJtpdicmZh+qPE35Z2rQsNWM5cPJ2y9aXKNh3Z73y9l9OQiG
         o0RUVMWWPtrDZ0ktiYpde5wZVZKi6eTPXT2SxjcyavAqWt2KRlJcHMKuHAVJMk3B9QBt
         UrNHgLKbop7B3ZGd2mrwklfIMsdXRtBZFqn3uld7K9c1pFjW9LOglUiJiP5rzuvwa2ql
         WQ7YDMP7bT9gF+TD587phTAp9E0ydho5thqntp33ik0NtlP0uKVLS7hNlOaE4+pUGVy7
         WlUQ==
X-Forwarded-Encrypted: i=1; AJvYcCX9NFS6SN/CcN5NP3LVqiouRhLJxDTViR5/g/fdb9miDX+zwbnrBZHMzBcVzfAGpOmYtxtwpnG6Ql2oWMCN/jjMMmk/kXsAq+c/mk5P
X-Gm-Message-State: AOJu0YxQjuSeP0nEkSyZis6YDNTFSSC0nH1kNLsj5r0Hzs6rvuE2Ovk0
	E12lgPKuyFabgjmAFk9qtEuSJyJY2oVGaG6uhbzWoMSvfjN0SSb8Br0ud8wjNWIFg7lBU0h8f+7
	xLuydj7F7qxJIZF5tGSDZ2kDa/bUKABD4+dJxPg==
X-Google-Smtp-Source: AGHT+IHVp3IoavGMPyTgcYZAB/4X0W31P+xAKxbr9Gb+QsxAn1gv0v6QzKKvAYqZ5A5+yYWrSQ0bJyPW0Vw0YbTeOKw=
X-Received: by 2002:a25:86d1:0:b0:dc6:e75d:d828 with SMTP id
 y17-20020a2586d1000000b00dc6e75dd828mr84838ybm.18.1708700846276; Fri, 23 Feb
 2024 07:07:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217150228.5788-1-johan+linaro@kernel.org>
 <170868613914.4029284.5549880672870201262.b4-ty@linaro.org>
 <3c4246b6-431a-442e-8ace-3b0d0e67743f@linaro.org> <ZdiU2z8rzo542_Ih@hovoldconsulting.com>
 <d4049823-ad24-4426-887b-9c66cdd96318@linaro.org> <ZdiqAPPTn9SvsjL8@hovoldconsulting.com>
 <77715ecd-ddb9-450c-98bf-4fcade0e81c0@linaro.org> <ZdixFo2EjUQDgeFh@hovoldconsulting.com>
 <b5401b19-09d9-4907-86d6-9aab9dc2970e@linaro.org>
In-Reply-To: <b5401b19-09d9-4907-86d6-9aab9dc2970e@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 23 Feb 2024 17:07:14 +0200
Message-ID: <CAA8EJppJL7ha8AQ7g+_b=0omcWRnTpjRc655V58FKoowUDRPeA@mail.gmail.com>
Subject: Re: [PATCH 0/6] soc: qcom: pmic_glink_altmode: fix drm bridge use-after-free
To: neil.armstrong@linaro.org
Cc: Johan Hovold <johan@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Bjorn Andersson <andersson@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Robert Foss <rfoss@kernel.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Vinod Koul <vkoul@kernel.org>, Johan Hovold <johan+linaro@kernel.org>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Rob Clark <robdclark@gmail.com>, 
	Abhinav Kumar <quic_abhinavk@quicinc.com>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 23 Feb 2024 at 16:55, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 23/02/2024 15:52, Johan Hovold wrote:
> > On Fri, Feb 23, 2024 at 03:38:13PM +0100, Neil Armstrong wrote:
> >> On 23/02/2024 15:21, Johan Hovold wrote:
> >
> >>> But it is *not* standalone as I tried to explain above.
> >>>
> >>> So you have to drop it again as the later patches depend on it and
> >>> cannot be merged (through a different tree) without it.
> >>
> >> drm-misc branches cannot be rebased, it must be reverted, but it can still be applied
> >> on drm-misc-next and I'll send a revert patch for drm-misc-fixes if needed, not a big deal.
> >>
> >>> I thought you had all the acks you needed to take this through drm-misc,
> >>> but we can wait a bit more if necessary (and there's no rush to get the
> >>> first one in).
> >>
> >> If you want it to be in v6.9, it's too late since the last drm-misc-next PR has been sent
> >> yesterday (https://cgit.freedesktop.org/drm/drm-misc/tag/?h=drm-misc-next-2024-02-22)
> >>
> >> Please ping Thomas or Maxime, perhaps it's not too late since the drm-misc-next tree
> >> really closes on sunday.
> >
> > I don't want this in 6.9, this is needed for *6.8* as this fixes a DRM
> > regression in 6.8-rc1 that breaks the display on machines like the X13s.
> >
> > If you guys can't sort this out in time, then perhaps Bjorn can take
> > this through the Qualcomm tree instead (with DRM acks).
> >
> > But again, this is fixing a severe *regression* in 6.8-rc1. It can not
> > wait for 6.9.
>
> Right, I can't apply them right now, I send a patchset ack so it can be applied ASAP,

Applied and pushed patches 2-4. Patches 5 and 6 can go through the
phy/fixes. There is no need for them to go through drm-misc tree.

-- 
With best wishes
Dmitry

