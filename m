Return-Path: <linux-kernel+bounces-96374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DCF9875B63
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:04:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D9B91C20D29
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C22AC7FA;
	Fri,  8 Mar 2024 00:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="H+6T7YMT"
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A865364
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 00:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856277; cv=none; b=MpUN2PDdRKlPjmp2caG9BREhHCqPSNNqFZWtIJOfz27ssn77L8rqx8+SucvhVTZrE9K/tvVf0jzGVCI59XITIcgeVQ1ihuDdwmI0IoNuxxFFWkLvQ6NO6gN31lmGxqiLhxTUrjbp7Q5zeegn9MSGCYvpK197caNoA8+59moZiaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856277; c=relaxed/simple;
	bh=CDLPcVDHnrLerJP/BD1eekTfobIlJbj9Hts/Ecuzcoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HNWvfNW6RSkHbgpcWZ+gBsBlnkXMvdB2Fafs+jNWp5TdkuhmM4vOFxsEO4yhk6qUWWPHaM8HByOS7QHanT8nBuMwwjPRh0Cqn6i5ln95F8r3wS25DJ3CTXC5WiXusYO6qkaZiIXfpb1V66BtvAgUMaEOpIsYIKRYHBBoNSK/ekQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=H+6T7YMT; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-78830bba6a4so79619285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:04:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709856272; x=1710461072; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K6zr9T8K6LSYxoWWjQTrp1KLLoOTIIRDfeq7Eu5cxkE=;
        b=H+6T7YMTPhBcrwrmIumo1sXS8o8RZ96zhncp8wiHgxYIaQoqXk9VEYmOwjXcv+lN9j
         I6riOmpDZPL0qnRUdPZVqul0dRKidjdLNMgXpAf/QQFhurnF1QO5j4G6IdmGfuivePnR
         jy3HcG4bV0jWGYFgCwNS7MaFXpD0sShTgqNhk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709856272; x=1710461072;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K6zr9T8K6LSYxoWWjQTrp1KLLoOTIIRDfeq7Eu5cxkE=;
        b=uZY6S2qOK8O+B6j8Ttr3kG8tsWMpnV9Gse64/a2R7sdGLAo3784d585tLD9Z/SpdTy
         z8RDCZa150nbTZx9H5t3sWvr+90afVhiyNrHNCAUUE7H4Hj1LErEhY8Tg8DlPkV+C2hP
         lIQmHF+ZMy0aW/TJ1beHGgxRvVc9QjaAuiqnatsaojoVL3Mldg10tjjBJ8lQ5vUv9ZET
         Tdu/gfjsl3M5N3kQdnl4sTYMU8Brv0IhmUwRrzYM4DLQjppXOsB98fumtH2TR/ViWsxR
         msH8oN9l3tmTEg1h067RDNg0A2mdTXzmFNfm3OyGA88KrTqy1jXosCNJIkMs/QE1z+Rl
         V58A==
X-Forwarded-Encrypted: i=1; AJvYcCVnFPDSok/ZMPQC+KMWyD74AFOcV256PrhpdElgSN7uLTj0YTDFSXO+zOhnkTEqiUfVlwbRb9eGWh2xCS8Pg5MSbifLl1XcUHQpY8rA
X-Gm-Message-State: AOJu0Yw/xFsBqbRV7fQop4oV3NIWz+dt+b5Ohx/xAkz/4ahYJo6EWmLh
	2lRYULPI3y+KE70u8ouWmJtVRhSpyrFXSuRzzlQ8jGe1Zr07avnQ1qgIa5BpC0PRjdFBG1UkAtw
	=
X-Google-Smtp-Source: AGHT+IFzJmYYEYCBJD7cvqpzifvV968UlEE2zy5SiTWwWPwfx49XEC2p6jfTQ20/cy+JJtd3vsCRJw==
X-Received: by 2002:a05:620a:91a:b0:788:51eb:6e1b with SMTP id v26-20020a05620a091a00b0078851eb6e1bmr246051qkv.24.1709856272363;
        Thu, 07 Mar 2024 16:04:32 -0800 (PST)
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com. [209.85.160.176])
        by smtp.gmail.com with ESMTPSA id f23-20020a05620a15b700b00788265d3f29sm4994668qkk.44.2024.03.07.16.04.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 16:04:31 -0800 (PST)
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-42ef8193ae6so62361cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 16:04:31 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUxAuMXo+os0cNxn6zaP96Yv9DkGbmeorI1iJGnT1NrlBe+ZidyUJiFCEF07RmLmnVEXvbJQdu8Iu+gZCBGkZ6VuvtL8z5wpdbcds+t
X-Received: by 2002:a05:622a:148a:b0:42e:f45c:6761 with SMTP id
 t10-20020a05622a148a00b0042ef45c6761mr466501qtx.22.1709856270686; Thu, 07 Mar
 2024 16:04:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307230653.1807557-1-hsinyi@chromium.org> <20240307230653.1807557-3-hsinyi@chromium.org>
In-Reply-To: <20240307230653.1807557-3-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 7 Mar 2024 16:04:14 -0800
X-Gmail-Original-Message-ID: <CAD=FV=UXUpf3H=fnQTZhUq5aDXFeVGW9OJuA5BmnRRvWQz6qaA@mail.gmail.com>
Message-ID: <CAD=FV=UXUpf3H=fnQTZhUq5aDXFeVGW9OJuA5BmnRRvWQz6qaA@mail.gmail.com>
Subject: Re: [PATCH v6 2/5] drm/edid: Add a function to match EDID with identity
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

On Thu, Mar 7, 2024 at 3:07=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> w=
rote:
>
> Create a type drm_edid_ident as the identity of an EDID. Currently it
> contains panel id and monitor name.
>
> Create a function that can match a given EDID and an identity:
> 1. Reject if the panel id doesn't match.
> 2. If name is not null in identity, try to match it in the detailed timin=
g
>    blocks. Note that some panel vendors put the monitor name after
>    EDID_DETAIL_MONITOR_STRING.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v5->v6: finalize the trailing white space and/or NUL decision:
> Allow only white space before \n.
> ---
>  drivers/gpu/drm/drm_edid.c | 65 ++++++++++++++++++++++++++++++++++++++
>  include/drm/drm_edid.h     |  9 ++++++
>  2 files changed, 74 insertions(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

