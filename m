Return-Path: <linux-kernel+bounces-73583-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 538A685C47F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:17:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 858671C21632
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:17:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44591353E0;
	Tue, 20 Feb 2024 19:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QGZj5toX"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4799E763EB
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 19:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708456656; cv=none; b=fn/ypNo5aWrJuaBudu+qqH0F52ADgTOr1BGgnDXwSRILE0HuYWUewa55Ml+m6ZLwsXf7Hyv4A6k6fSfvXNUJ7zxNksPCEfUP1yIi5E74Tq31q2KxwbV4mtAFI0kksJLFaN/aYW4LRzppFl0H9LBmlMp2mRSLp3rOksVDwt51bvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708456656; c=relaxed/simple;
	bh=hGmkzXSXBoH3gleCPQ/Kdc0rasVlhcF3ZGIuYJlEuuM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQG4+8lObGELUZTAbWa53OfM6jTE6WjmQhsQOIpUizPkJMfnKRvxmpzdqy41hSZYXFCim35hIFz8X50dLKI70GPqEcac6zSP6cLH4+abcG4CQKtoN09YIV/ZgX/sG8rWGTcw+6qVxpp+8pfPjXzNu2o7/fYj1gWrk8RQoNTEUBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QGZj5toX; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dcc7cdb3a98so5959495276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:17:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708456654; x=1709061454; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=owfyNv1TJxXYhYzgoZWH50Nlji30FNL3ho0Wn/WI7Hs=;
        b=QGZj5toXLRpSLMdFEf32JjD5/6ZKh+GGWNRkaz3im5ahQgiDmDrIW/M51ckMHa0ahl
         3i8G3Qvbgun7fdKQqidjwPhspVnS/EvSHnUewg+vYuPe8x38MOCjDC1EncCszLbCsk0k
         9NWjPSeeKqHzTVsYq5+UKFcT3DavO8/WOYxYzmiv+qZdgnBbLHyFf2K2rnZqxHXhop8O
         zPjvL8BxEn1samW1+mvFGHnufaUHcvVv2fjKh4tkdPKfEVhVQJ5gTlYgcFybgv72sjmi
         RaJSehb1+gFIo7Q/t5tj/N0/dwyu/sqH9xx76viA0IYY2wa0diXIPhEA8WxkHrs2q14i
         Y7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708456654; x=1709061454;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=owfyNv1TJxXYhYzgoZWH50Nlji30FNL3ho0Wn/WI7Hs=;
        b=Y7TlN0NUJJsfgDwZ64e+ah2OKhnAabA/dGnSM0Ry5mrBN+8QtKYvAMoZaMkWBkRQn+
         3XDmVtDTUZi/ESoldCH+uMSWEnT7xl3UCY8Q1HqRogZ3ipWZHS8Cv2prXMC2oQ2P766S
         wjCnY17W54E5E1JuNeluBos2wEgKfiUh8WbzfunVY05duLGXartpvG6P7Tbpf6FN0jhP
         3nrLlT1a9ODDM4TqZ1L5RC6J9SfdQFi0s39tKGYpwulxj4oqnF2zdC6cueuRGpbKd0qh
         cgbP+d72QANCk2vgqX64tArhRsPw2kxYhTyNY/H+us6JDLazHqI7+JG4TIfNiRRg4QUB
         Sk0A==
X-Forwarded-Encrypted: i=1; AJvYcCWAxmc/4EYNRvatVs2CGljXRZk4pTEQu6atQZ1Yky+l+JIjHFyyAwuEWkc5uApKE5d5Pgmbx8A+tSKSv16Fox5qmfm3KKc+6EeJNAPl
X-Gm-Message-State: AOJu0YxtYBsIg80XVGB5eg2qLN0Abhl1lF5OvcIZU5ewn01rmglxP7Zk
	Z4OqwcVJ3z7S9FVnzRSiAZf5cgDY0Z29pGDtR2A2KKWV3MRFCjIkGA9wZIAonptPMY21rRRLJXF
	p+magBZgbCZlWqNN/oyAOiJvPpAz+GgCMoDqrbw==
X-Google-Smtp-Source: AGHT+IE8vOzreFrHGur0jS728Ji3ZC+G2E6ohtg7f5EWmauJPRGX3K7oIaJ+B/vZwTHbfV04pJ1H+RxFa/SFzYZAjQo=
X-Received: by 2002:a25:e0d5:0:b0:dcd:97da:926e with SMTP id
 x204-20020a25e0d5000000b00dcd97da926emr14466623ybg.13.1708456654138; Tue, 20
 Feb 2024 11:17:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215190834.3222812-1-quic_abhinavk@quicinc.com>
 <CAA8EJppQquHgSgCrxKZHPHk248Pxg7Q8mvmmjbcpUxpreQkcuA@mail.gmail.com>
 <d3674c10-5c29-d917-44f5-758d90d9e679@quicinc.com> <CAA8EJpqaG+fBA_FO-L7Bimtjqqg3ZDQtyJL0oPFEueb-1WxjUw@mail.gmail.com>
 <b1f4856a-ee08-c1fc-2db0-e22773633bcb@quicinc.com>
In-Reply-To: <b1f4856a-ee08-c1fc-2db0-e22773633bcb@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 20 Feb 2024 21:17:22 +0200
Message-ID: <CAA8EJppY3tmv5FchykWG+d3vUBcAoaqZ3zjgYDr8kF5D4C9c1w@mail.gmail.com>
Subject: Re: [PATCH v2] drm/dp: move intel_dp_vsc_sdp_pack() to generic helper
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: dri-devel@lists.freedesktop.org, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Jani Nikula <jani.nikula@linux.intel.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
	Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>, robdclark@gmail.com, 
	freedreno@lists.freedesktop.org, intel-gfx@lists.freedesktop.org, 
	ville.syrjala@linux.intel.com, quic_jesszhan@quicinc.com, 
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 20 Feb 2024 at 21:09, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
>
>
>
> On 2/20/2024 11:05 AM, Dmitry Baryshkov wrote:
> > On Tue, 20 Feb 2024 at 20:53, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>
> >>
> >>
> >> On 2/20/2024 10:49 AM, Dmitry Baryshkov wrote:
> >>> On Thu, 15 Feb 2024 at 21:08, Abhinav Kumar <quic_abhinavk@quicinc.com> wrote:
> >>>>
> >>>> intel_dp_vsc_sdp_pack() can be re-used by other DRM drivers as well.
> >>>> Lets move this to drm_dp_helper to achieve this.
> >>>>
> >>>> changes in v2:
> >>>>           - rebased on top of drm-tip
> >>>>
> >>>> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> >>>
> >>> v1 had an explicit comment before the ack:
> >>>
> >>
> >> Yes, I remember the comment. I did not make any changes to v2 other than
> >> just rebasing it on drm-tip to get the ack from i915 folks.
> >>
> >>>>      From my side, with the promise of the size fixup.
> >>>
> >>> However I observe neither a second patch removing the size argument
> >>> nor it being dropped as a part of this patch.
> >>>
> >>
> >> Yes, now that in v2 we got the ack for this patch, I can spin a v3 with
> >> the addition of the next patch to remove the size OR as another series
> >> so as to not block the main series which needs this patch.
> >>
> >> I would prefer the latter.
> >
> > It doesn't work this way. The comment should have been fixed for v2.
> >
>
> Ack, I can post a v3 now by adding the removal in patch 2 of this series.

Yes, please.

-- 
With best wishes
Dmitry

