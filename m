Return-Path: <linux-kernel+bounces-97509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61D3C876B33
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 20:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C85E282D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 19:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF5815A7A2;
	Fri,  8 Mar 2024 19:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gjCBGDpX"
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B484B5917C
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 19:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709926033; cv=none; b=Y/rITbcHJOhEpHTaHklnM2Ca1EOpO8XiZ0dDw3qr242dyiUYk7nRKnGXXiFsnecms0uiGcxLX6YyGkMILEHqYB6KK+zWpeyDAVIAHqaRj4mbz9CJlvfbWCtd8kewgmjT7InZeYlAsdwjJH+F/wpltjc6eQWeBda9RupG194nJ/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709926033; c=relaxed/simple;
	bh=NQIm1Xlm5K0yFcS/EEBe5ub14MQkk1VLcdHd5RPBZ3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qp64tEEcaPdlAUJvHE8azUCh/upDTEAitjZLNWgkl6KQHR1yslWXHCqyBEuazWgNNzJREd7DD+k/0wXku/e41cyoQHjMlRhCXXKqYYq3lZSsjaiVBNsNliKyq5V318qki0usajmfj0Tnsme/1gjuJ3owFSxa42/RW44pbwAnzvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gjCBGDpX; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6e4e8be9c85so1273803a34.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 11:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709926031; x=1710530831; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jXnvICRLW55e5QZKhdr3I+R6SijOyLEgFcbGwwnR6cU=;
        b=gjCBGDpX5ib9BvMFSEXuO1uPV6bwc0xUT6hSDPhPmr9kJw8zLXumBw4jMMEumBREeY
         3jsbeG+pOlp3PJ6w6VMCjIyxge9+H+6yTId4xWjh2fscxYjCVMcjBr2Wkg7/KUx+Jf9g
         vb3vvm396sLQkIAA3qQsxgCFtVcMHBkVv2v9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709926031; x=1710530831;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXnvICRLW55e5QZKhdr3I+R6SijOyLEgFcbGwwnR6cU=;
        b=BWoJ5LVOBD0cRes+k1WOSVVHlktSLYqP13LhTNhC0v2akpAPPbtEIWWCroUvtIhH3P
         DVHULQac5tnqa8/vsYHH5vwKhKY4yF3kiB6UPA9PP/Yzrgy7mjCQ8wkVITMt6YGn/ESb
         vsQmS11Scqxz4OSqM3q10xLxOxSPH5Yly2K0mvVkCo4saSP3tFeQR8wB98H7pu6RjCDs
         rH9stsTnpOonWSWebdoEZhbySjIWNvdDemPvkqSgA/46Mydv+ht8valF8fw87HaZ0uAa
         CyaGB2ogP264CA4M8q54QXGBTEimS9OJULtOYQLp/INmR6MJw7rcXSa7IglZAPmiD9rn
         dPkw==
X-Forwarded-Encrypted: i=1; AJvYcCUJl6JRCFlN8i6AtZPp95Eyn4yLytwtFl7RQQ9PJN0DP5VNMCvg15guduotQATAnPaDR27OBsDxBNLsWRYX8CNcNrHtAxSNhB4Eua/N
X-Gm-Message-State: AOJu0YxR5K2D1a71JfdJCpLsc87ZdJ915XkbWjxO6nR9XzbnX+OIu+PK
	kvi6Nlzsrcp+LVR3NUhAyDn61YBqVGxMSmgrus2Yt2dR2aARQztERqgPljpIKtfhBah2pVUTs77
	05XZQhhf+g1P7tOUWkd2+kY0lYkgA7PsC2S2x
X-Google-Smtp-Source: AGHT+IHmJ73jVY79eXpNqwiPYZUcyVadGKAGRX0v7t36s1qBJT5asJhL74zysAc8l8NcjH3TYQI4pBDICuxAwPrSWz4=
X-Received: by 2002:a05:6830:1510:b0:6e4:a1a1:8d78 with SMTP id
 k16-20020a056830151000b006e4a1a18d78mr13033330otp.2.1709926030873; Fri, 08
 Mar 2024 11:27:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307230653.1807557-1-hsinyi@chromium.org> <20240307230653.1807557-3-hsinyi@chromium.org>
 <87jzmduoy8.fsf@intel.com>
In-Reply-To: <87jzmduoy8.fsf@intel.com>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Fri, 8 Mar 2024 11:26:45 -0800
Message-ID: <CAJMQK-gy2BW8ySbBfUmKn=rVEyEyzLgMtAu0kS7vc8H=e5ayzw@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/edid: Add a function to match EDID with identity
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Douglas Anderson <dianders@chromium.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
>

Thanks for everyone's suggestions to make it better.

> Thanks,
> Jani.
>
> --
> Jani Nikula, Intel

