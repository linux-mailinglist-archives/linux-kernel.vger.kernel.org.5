Return-Path: <linux-kernel+bounces-94714-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C795E8743E4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:30:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FF11F220F7
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B1A1CA8E;
	Wed,  6 Mar 2024 23:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Stewac8y"
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 762CC1C6B9
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767818; cv=none; b=qeuENL0HlXWFV1q0D+IKlUew6JalJwMpBPyWKiGkdSI2WeMXEJbinvvksyAjarlpmry9V4eHuynmJL+VTILyMy3iOybix5V+2Sy5CwOk/CRFje6zDaV+SVdBlV/UnRYVyR90foSrTvtW2JNavFbe55TWeCDd7AMfQFNSCZXWEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767818; c=relaxed/simple;
	bh=sPhd2KQA/avd1ni9YV51bTSXQMhTze2MYbIU247grTc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jPhEGLjTfC2ioMhdUy3wKeKPxjNY9fugxAWhss7XQ57jBan9tYWCdNBUGIIGgxnr8P3R0q97c/3xp7iGoWIaXzucBUQuTEanB1xnJ/Zv0kIdAg7GmYABqPTrtpMNx2QwynYtNcq8uJfLyvNuCWbqP6c5+WtAlKV8+JJaqn+p0rU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Stewac8y; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a11ed428c5so126844eaf.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709767813; x=1710372613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8uphQrob++9Iti6sZOTD0y0JTDAZhZm8PP0VwpFINJk=;
        b=Stewac8yap7KWNHXrP0Tw3qyxxJSt1Njcg91nhbT5UOs15f64dWkWP5nqjDSLMphbv
         L2W3urS0Y3zA9FbmEwBV7EhonCqfzq3movN69+7CJSYrzKKhhbA733BpSGdJiiGDRvG9
         jzLEX6PcMUNreTu/zw+Z+PE2MUkrmC2zUXxVY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767813; x=1710372613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8uphQrob++9Iti6sZOTD0y0JTDAZhZm8PP0VwpFINJk=;
        b=cFkRs3O0s6+yVQfI6nGGTTymkjF+IZQyhsY6gkQH2ttnC04uoF3kQlJa35fX98GjDD
         W8fNeXRegGzGhi12teb2NhAmfzT18pn9KOAvc679QPnH2I1fHxlIkrkUdRYYA1pgF77F
         5KNpcaht8nykIz3Vr7mOoWNrvdGnk0ItvOIsqITX3vuojqmTt6ag5RohLv1nQoHV/Zu5
         UnbBPX+EOd7JROTVu3Z1VgVlMPzTls2mDjWmieHudUNJSGidpmLYqV837BECDBF8yclb
         PeXTOCpZteQ/6kA7cqSlKTh7nDTrWzmsphNTHuU4hepV73U0+227dDrJGHue/wyEngvy
         /PZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUXXb7Q3SPTu674dkEaeC64ezx0lWzibdi7y0yKTY+8P0zHj2PL7Y2yUB4Ub17jPdGjVix1biaXeJNF2KqPhLYMj2iryt0Yjbo+oYJe
X-Gm-Message-State: AOJu0YyZp28LtErv/jt5V1JCMwk+G/JufXDBj8fBE5HCHXkTT7nLkUya
	61vvK4xfGnIwkTwpgKYL2tsaQ8I4GQbfRGrPamRIo8gExA/AXvcDlS+kwtblifqE97ebcyzhBeU
	=
X-Google-Smtp-Source: AGHT+IGALZ1o9Tv8havUqFe1rw+oNlOwGzkAUIA4VoBYYD7sTLrt/wjbMIvjZNsBzWoWP3ua0Fy3ew==
X-Received: by 2002:a05:6358:885:b0:17c:a67:3579 with SMTP id m5-20020a056358088500b0017c0a673579mr6699307rwj.1.1709767813360;
        Wed, 06 Mar 2024 15:30:13 -0800 (PST)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id t20-20020a05620a0b1400b007881ed0f87dsm4730561qkg.65.2024.03.06.15.30.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:30:10 -0800 (PST)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-428405a0205so55251cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXzfYZO98eXFSpyKSdexj3Yb5zmtf34voLQULmuyNvAOyYxPv9QPstXL42IOrBpONafg6J7UPougEZJDVggjK81lCfnipWbVSBRp+Y6
X-Received: by 2002:a05:622a:590:b0:42e:e077:3ee1 with SMTP id
 c16-20020a05622a059000b0042ee0773ee1mr104034qtb.3.1709767809742; Wed, 06 Mar
 2024 15:30:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-5-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-5-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:29:51 -0800
X-Gmail-Original-Message-ID: <CAD=FV=X66sW-zcnZbv1ecnZ733AKJh1LbjGNVWLjggT_x1sxGw@mail.gmail.com>
Message-ID: <CAD=FV=X66sW-zcnZbv1ecnZ733AKJh1LbjGNVWLjggT_x1sxGw@mail.gmail.com>
Subject: Re: [PATCH v5 4/6] drm/edid: Match edid quirks with identity
To: Hsin-Yi Wang <hsinyi@chromium.org>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 6, 2024 at 12:04=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Currently edid quirks are matched by panel id only.
>
> Modify it to match with identity so it's easier to be extended
> for more complex matching if required.
>
> Suggested-by: Jani Nikula <jani.nikula@linux.intel.com>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> Reviewed-by: Jani Nikula <jani.nikula@intel.com>
> ---
> v5: no change
> ---
>  drivers/gpu/drm/drm_edid.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

