Return-Path: <linux-kernel+bounces-167082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5742F8BA440
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:55:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4F2BB2332A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81205158878;
	Thu,  2 May 2024 23:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="SPyStiYg"
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61ACE1C683
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714694141; cv=none; b=Gp3Q7FSAnO7ioJGEaP3BRqynWtXaW70ZElU0vOzuRO71h+uAJYFlBePNDd1uN3a+IFso8brHFD7IhJIERMAdePEFvfMPO9MVYo8fK/3H+vcAeJXDhZYbTrjXTk9qdzJ5GgjF9MwR83EIe91Da9GJYlZg4jEYQPnY6N3nEGxf1zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714694141; c=relaxed/simple;
	bh=wM8m/OAEQmArjED9gfb+eLyjWAyrYbDGIX2hsyQpqx0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K9k4yPq7UG6P5sZajq0rlYJheqWUqUdylms19uTbbYo3SDvqAkfKnwse3wFqmd1E+1s7DQ77BovaRkohwb5Bce9YsAhQ/G9DBJOF61cvWJr/Bt9NT8bvrRnaug8EsMSC+e/1Zo77AjQgnBNOazQUTrWRvQIAOmKlPbhngBLB+Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=SPyStiYg; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-6ee1c0ecfa5so3350844a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 16:55:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714694139; x=1715298939; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+MHWuPJaqDhO89L9XgtzGeKdwZ07KcerlIPh46wVx1U=;
        b=SPyStiYg8KH98M0nH59HjXCgCnQg+/kftslWiChOIGcYH5hqStCzQwlUkft1GRtQdG
         NIDkp2+Kp0jzo/3BHdU6bQbwiAsVqSoNIpOZwtNYkSS2uhP+c/Ft3mb+jIoYJ9dNzpb3
         27jUZXkPBjRDXQZGFMqwLv84RzLQ4fr3TLsVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714694139; x=1715298939;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+MHWuPJaqDhO89L9XgtzGeKdwZ07KcerlIPh46wVx1U=;
        b=PER/YWGAPFUZf+gqWGdU0N/YUdXgxeXnlABgNJsqbncLtO4Rwc7yrDw1QXQsAfD/0E
         B3/0jEK+9f9eqnOzumUXvRK2uBpx8crEQLsYk0LVeU1Zx2Vpa/sCC11C6J95LYMnULOe
         cvCCg8dZU5Zl6RKpifeCqj5/26vgaY7fnI3DtKnIwjiZxgX3vj6HXyRwe1EkojJx00to
         ZHEZCFTfgh2ihVeoWYtiVnsZKH4/bwRca6R1VOwm+zwS9XbJHRtKstJj0Q5DyfvPpcr7
         0fyuEgCYLLI66Vqvm/3KAng25wGWe9Z81/QYrkDUoXuy4BCL/bjD6VX//EaRhIOuMv9r
         RRLw==
X-Forwarded-Encrypted: i=1; AJvYcCVV76/uhruCoUAp8bxvio1Q71ZHtOwEub+FsqkIVdNVtIm6a91k+9MUu1Qw0cXgwTb6LYHVEu4wfH1mLY6meCVY8oenFwMVFn3ZoFd3
X-Gm-Message-State: AOJu0YwYo5h9ddsYzE55bptMxC78T4WXIMr3Jqad1cu3TNwW7zrGEZko
	M5SW9BFKRBRd/4ekX9jDcWZdncdGZKZzTEXTZs2q9jRt+5R8Viym9aLqcgNDQblCPqlawGi84i8
	MrPBp3d/829VQo5vE4GTD0sGgqerIsPsYwoIG
X-Google-Smtp-Source: AGHT+IGyCxHV28Dg21fvPd5sjHZ7KhAUqE2uO+gL3ofkHFj9jXN9KaEpVVpZug4C3MFxRV+i3b5mcbdpzvWf2Io+5NM=
X-Received: by 2002:a9d:6e89:0:b0:6ee:2d1e:f4f with SMTP id
 a9-20020a9d6e89000000b006ee2d1e0f4fmr1511449otr.9.1714694139352; Thu, 02 May
 2024 16:55:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502164746.1.Ia32fc630e5ba41b3fdd3666d9e343568e03c4f3a@changeid>
In-Reply-To: <20240502164746.1.Ia32fc630e5ba41b3fdd3666d9e343568e03c4f3a@changeid>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Thu, 2 May 2024 16:55:13 -0700
Message-ID: <CAJMQK-h24xoO6jsYu4NK8ENoA6nsidcF8aN2pCzNMPgmu1NxEw@mail.gmail.com>
Subject: Re: [PATCH] drm/panel-edp: Add ID for KD KD116N09-30NH-A016
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 2, 2024 at 4:48=E2=80=AFPM Douglas Anderson <dianders@chromium.=
org> wrote:
>
> As evidenced by in-field reports, this panel shipped on pompom but we
> never added the ID and thus we're stuck w/ conservative timings. The
> panel was part of early patches but somehow got left off in the
> end. :( Add it in now.
>
> For future reference, EDID from this panel is:
>         00ffffffffffff002c82121200000000
>         321e0104951a0e780ae511965e55932c
>         19505400000001010101010101010101
>         010101010101a41f5686500084302820
>         55000090100000180000000000000000
>         00000000000000000000000000000000
>         000000000000000000000000000000fe
>         004b443131364e3039333041313600f6
>
> We use the ASCII string from decoding the EDID ("KD116N0930A16") as
> the panel name.
>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Reviewed-by: Hsin-Yi Wang <hsinyi@chromium.org>

> ---
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pa=
nel-edp.c
> index 6db277efcbb7..9cfa05c7d193 100644
> --- a/drivers/gpu/drm/panel/panel-edp.c
> +++ b/drivers/gpu/drm/panel/panel-edp.c
> @@ -2094,6 +2094,7 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv=
_a010.delay, "116N21-30NV-A010"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1118, &delay_200_500_e50, "KD116=
N29-30NK-A005"),
>         EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "1=
16N29-30NK-C007"),
> +       EDP_PANEL_ENTRY('K', 'D', 'B', 0x1212, &delay_200_500_e50, "KD116=
N0930A16"),
>
>         EDP_PANEL_ENTRY('K', 'D', 'C', 0x044f, &delay_200_500_e50, "KD116=
N9-30NH-F3"),
>         EDP_PANEL_ENTRY('K', 'D', 'C', 0x05f1, &delay_200_500_e80_d50, "K=
D116N5-30NV-G7"),
> --
> 2.45.0.rc1.225.g2a3ae87e7f-goog
>

