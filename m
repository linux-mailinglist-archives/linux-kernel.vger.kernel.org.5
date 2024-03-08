Return-Path: <linux-kernel+bounces-97176-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 505D3876683
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:43:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05756281767
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EDF11FBA;
	Fri,  8 Mar 2024 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="FXlU7QKk"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111431FB3
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709909030; cv=none; b=pFsMiF9VVzQu26Ix/KC82e1yRzZI3Q/fYPJtpeAsi7aysees4/ALvsbRJiyKjGskPHMQE0H20VlWubV+LWFDhFAORc1IU0ABUbAGNbr40E8zclg6k8Ab0yYvKZH9fK9UHPawJ6GODVn0uowf1h7jHVujo2KNqxekjI6wvRubi1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709909030; c=relaxed/simple;
	bh=7iffp7NKdMt6+1LEyhqfNIQkXZGhElssFGA20qTN1jY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=P+gMEzQOU/EJBXUeZV4C6hkvbGZXXDfGGRW9P/GPe+Fm+rmRHvjAHtBvRxXYxm7JN5IE4OF/UsgOG3QT9tvS12rpnxBJv5vP+OrWrnd0/aEi3sMHvlgSavO/tdZgytCXiAjxYbvZ521NlJV2WqMbGq5LDLIwV5D3mTFWY7PJfM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=FXlU7QKk; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dd59b95677so7005435ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:43:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709909027; x=1710513827; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rfUzWRFLFY+rkoyDqY8l5et5GO0+hQpyzOAN51RCdxI=;
        b=FXlU7QKk9JUuIL2pXoUyZ76KKYTjv3zud2xJ91W9tjP4QcxI9k79VtMNpZSWaEVvR/
         w4sg5VKTwb0F41rm8jsQv3F9EWfB227cF7w2tA5kKMGrOThijNKuVSpiCgGChJMKa5k9
         V0ZLR3SwBwH33GU/vVLRmcqkQB/ljoxw/4900=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709909027; x=1710513827;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfUzWRFLFY+rkoyDqY8l5et5GO0+hQpyzOAN51RCdxI=;
        b=ClZXbrgC8/r5z9sPwdCwDnLm9k3fF+U2y5JXVDqhqDd5rBpv+3XDZTdABgTs55dRYz
         c917MVrGmqeVy+joHvE/BLyPHu6KtuU+hw0i1bDN1A1gfw0879KEY+5Pq+TYhhreXaO8
         vT8OGDQlL9fx5ROoj/0vWfUiuHi5emHgvR0Qd+qUIzBd4+aCJR6Ig21E0QYt4CLiqQCI
         vBqc3L0M0VvYfZMoiHbLgmyijdTTT9ggxPaphxoKCzy26d7wnrU4cKrCLNjfHiLfDMq5
         rKz79d/kj/AzhokRDfJ4OX0rhTy+oFL1BCm+zLh5xNsGrbjN2CEY5U6S54xdTwZQObJi
         fu1Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVs9GkFRTs8IbY6Ox23MX8/gj+jNdxXDKedxdKHOqLSsrM68Gdua6e6qvVqh2oCuDN6qFlXj7b4O6otWSonF5DxNlP3kYpRLUgAodt
X-Gm-Message-State: AOJu0YzCz2vAb/+L1Y6wgCwMG4DteO05B3mUqGiZzyNM1jXUam1YN7W2
	aVYNaT5Qa7mB4f5a15Py4EpA24/xd8c668SlxZYHx04w/B9pKhILEbt3qB+QZcL6ba4nuRrQOCs
	=
X-Google-Smtp-Source: AGHT+IF22nCE/5BMCU7u7q9aD6FHyQy8M5CmnolpLHpneCyRIjZCVnrDevt0y3LoglW8RLm8PjzuDw==
X-Received: by 2002:a17:902:7845:b0:1db:51ee:8677 with SMTP id e5-20020a170902784500b001db51ee8677mr10129579pln.59.1709909027616;
        Fri, 08 Mar 2024 06:43:47 -0800 (PST)
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com. [209.85.214.176])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903124b00b001db2b8b2da7sm16230140plh.122.2024.03.08.06.43.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Mar 2024 06:43:47 -0800 (PST)
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-1dcd07252d9so123125ad.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 06:43:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2VGxShmyR/JBE9e0b5ys0vvvYLHO/0OZWjob0+LpUKJdBpa0Po0bmx9Ri/Y0CBlHOU6rgvBJmOBKZdUsXkgwcTNi5hGFTI2htgoyS
X-Received: by 2002:a05:622a:1a25:b0:42e:b6df:819d with SMTP id
 f37-20020a05622a1a2500b0042eb6df819dmr680036qtb.24.1709908714154; Fri, 08 Mar
 2024 06:38:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307230653.1807557-1-hsinyi@chromium.org> <20240307230653.1807557-3-hsinyi@chromium.org>
 <87jzmduoy8.fsf@intel.com>
In-Reply-To: <87jzmduoy8.fsf@intel.com>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 8 Mar 2024 06:38:18 -0800
X-Gmail-Original-Message-ID: <CAD=FV=VsTq_Yy14n5Ygbxqn4pnguG3wC2AQforP8vdX-Wgn0Dw@mail.gmail.com>
Message-ID: <CAD=FV=VsTq_Yy14n5Ygbxqn4pnguG3wC2AQforP8vdX-Wgn0Dw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/edid: Add a function to match EDID with identity
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Hsin-Yi Wang <hsinyi@chromium.org>, Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Mar 8, 2024 at 12:07=E2=80=AFAM Jani Nikula <jani.nikula@linux.inte=
l.com> wrote:
>
> On Thu, 07 Mar 2024, Hsin-Yi Wang <hsinyi@chromium.org> wrote:
> > Create a type drm_edid_ident as the identity of an EDID. Currently it
> > contains panel id and monitor name.
> >
> > Create a function that can match a given EDID and an identity:
> > 1. Reject if the panel id doesn't match.
> > 2. If name is not null in identity, try to match it in the detailed tim=
ing
> >    blocks. Note that some panel vendors put the monitor name after
> >    EDID_DETAIL_MONITOR_STRING.
> >
> > Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
>
> The series seems good to go. Thanks Hsin-Yi and Douglas for the
> constructive collaboration! I believe the end result is better now.

Thanks! Unless there are any objections in the meantime, I'll plan to
apply the whole series to drm-misc-next late next week.

-Doug

