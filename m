Return-Path: <linux-kernel+bounces-5470-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 31AE0818AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 16:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C52321F22830
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 15:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955321C69D;
	Tue, 19 Dec 2023 15:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="jkdig+W1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C8C1C683
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 15:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-50e33fe3856so3223434e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1702998940; x=1703603740; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PN8rbSgplrrQWhIPY3LvrBoVsaVg7KJ2wpNV5ztnbpo=;
        b=jkdig+W1mokfQYBAiCJsxC/brdcF8v+d1ZDPkpbDUcBsLkEPnJZtF+fbGNNkUTAGfa
         0vqd4OfTrLZrgPl/Ig9BT5ld/cp8BfZTmcSnnuz6mXPy/p3anUgZcSJXmfFa/ROw8LTQ
         mVN7rQuzedtW1UEX+7FQEY2b76lB3nxvxjooI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702998940; x=1703603740;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PN8rbSgplrrQWhIPY3LvrBoVsaVg7KJ2wpNV5ztnbpo=;
        b=NtB2MzopeAN1dYgzPauZkQjKcyRxX4WZIfbMAps0f1ZUmu1PqLZYr0pz3EVu/HkESI
         kC4E2YFr4BDUL0TivCidwBaokwWLmKIgKVdzYBYqgYlMmmtOy+3Yoovwm6sxptn8zW1p
         89cW1Tj1pXkqJof0nTOtbzOgaNVHwHDTerlN68SdJjTefmneuV9hB/dWDstw/PQNJV+J
         nzk5ra+uDJBCh/0scollJnpLJ4NpI4bzYkLRKFzn8zX4eGxBMEZG1tOxkEnMkAcpQ3Zc
         v3y2eZ2Y988XfjzWuRHHSJuDd0qc8K/eG59q10ouhq/+kyRizTWj9Mn+30MiqrmS+7LR
         zfmA==
X-Gm-Message-State: AOJu0YzG70+EIqUMPNSJY7TXHMnws2A/Z9BD8d/Fy8FZKc4aXCrjMdAD
	9caCVojv+ukY4N+w7eHrHBLJraeh2sysQjyMgmSh2ZR5
X-Google-Smtp-Source: AGHT+IE1kn+kmDeK/wYucbjMizcXqHNWsFJIWnmIjSMGQs3AqQDrrOoXZ37VkIp/lYujMt1b0Z9xew==
X-Received: by 2002:ac2:4244:0:b0:50e:4098:3798 with SMTP id m4-20020ac24244000000b0050e40983798mr714046lfl.60.1702998940081;
        Tue, 19 Dec 2023 07:15:40 -0800 (PST)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com. [209.85.208.46])
        by smtp.gmail.com with ESMTPSA id eo4-20020a056402530400b0054c7dfc63b4sm11671060edb.43.2023.12.19.07.15.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Dec 2023 07:15:39 -0800 (PST)
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54744e66d27so16040a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 07:15:39 -0800 (PST)
X-Received: by 2002:a50:8d4f:0:b0:553:773b:b7b2 with SMTP id
 t15-20020a508d4f000000b00553773bb7b2mr184335edt.6.1702998939101; Tue, 19 Dec
 2023 07:15:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
In-Reply-To: <20231218090454.1.I5c6eb80b2f746439c4b58efab788e00701d08759@changeid>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 19 Dec 2023 07:15:21 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W65K6M_hYqvPFv01NosGE=WnUVBOAsTQH+B7p_L3tVGA@mail.gmail.com>
Message-ID: <CAD=FV=W65K6M_hYqvPFv01NosGE=WnUVBOAsTQH+B7p_L3tVGA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Fix size mismatch warning w/ len
To: dri-devel@lists.freedesktop.org
Cc: Guenter Roeck <groeck@chromium.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
	Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@gmail.com>, 
	Jernej Skrabec <jernej.skrabec@gmail.com>, Jonas Karlman <jonas@kwiboo.se>, 
	Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
	Sam Ravnborg <sam@ravnborg.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Dec 18, 2023 at 9:05=E2=80=AFAM Douglas Anderson <dianders@chromium=
.org> wrote:
>
> After commit 26195af57798 ("drm/bridge: ps8640: Drop the ability of
> ps8640 to fetch the EDID"), I got an error compiling:
>
>   error: comparison of distinct pointer types
>   ('typeof (len) *' (aka 'unsigned int *') and
>    'typeof (msg->size) *' (aka 'unsigned long *'))
>   [-Werror,-Wcompare-distinct-pointer-types]
>
> Fix it by declaring the `len` as size_t.
>
> Fixes: 26195af57798 ("drm/bridge: ps8640: Drop the ability of ps8640 to f=
etch the EDID")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
> Sorry for sending this hot on the heels of the other patch, but for
> some reason that other patch compiled fine for me until I picked it
> back to my downstream tree. I'll see if I can track down why. In any
> case, as soon as I see a Reviewed-by tag I'll land this.
>
>  drivers/gpu/drm/bridge/parade-ps8640.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I've added a short explanation that the issue only shows up on
backports to kernels that don't have commit d03eba99f5bf ("minmax:
allow min()/max()/clamp() if the arguments have the same signedness.")
and landed this.

35ba6bd582cf drm/bridge: ps8640: Fix size mismatch warning w/ len

