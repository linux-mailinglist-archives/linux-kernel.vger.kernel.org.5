Return-Path: <linux-kernel+bounces-103509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B326C87C069
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DF0A2826E8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9223A71B51;
	Thu, 14 Mar 2024 15:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Jc6Jc4iB"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1674EDDD9
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710430537; cv=none; b=jMd6ukOVi0lZwZVFLqSJoLlqC6ci2hfI9DyagNp1V12EC2K1u5+6HPp0UBwfbNgs4OqPFsCDoBprN5zqaQnuy2SCbJmfb+rXsvA4LNE/c6qJ7fVN0MBfsNidadk/v1MZzrsySRuoVl+F3kFlo1CMTuFQ0I0r9+ud/CxkScxkIHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710430537; c=relaxed/simple;
	bh=EmSDy+Y2eZ4rjNbfsPJyI2JRjG8zBMXiabnk6HVEFZU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fj2ebGkhZD4wzXx07YsctwnOn17x/z5RL8gwpOvXkjIM5vNrKlh7O2mHDv0yqPm0fbZkqsTUcV5r8HTOh8AX7STidda5aVjKU0Y5gmE9UPOzGgN+rnFJqJqASC8wgv9Gee4bf81wQM5mh2xWvg0y9hrZVBzDL2XGSqSoloSEmNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Jc6Jc4iB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-690db6edb2bso7099416d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710430534; x=1711035334; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd+EVORm9S4/nMKBvY+MY3YVPrA2LiyU3GMnNyIkvV8=;
        b=Jc6Jc4iBda5n2Qb9O51ze4mHUNuYNTcKp+Odmgbt6IKRd21FyIpgprOrzFTFhccEAa
         /lo4d1VJmxF8TBstS9+0BwDrcy0QaqSXGLExyoKOK5+SYDn4jLxSKI1CqEPynZhmlPSC
         b6KwahMCuxPLf/Q9Wjop64/bBm1CbApLbwhzI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710430534; x=1711035334;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd+EVORm9S4/nMKBvY+MY3YVPrA2LiyU3GMnNyIkvV8=;
        b=g0voVWo9YA9maVR5Dk2W9YqoBZirmQcwyc1vFFtIwbWqvzsdP7oziGkFxIEWLAha9/
         KkHEd02ypPXUqiIJ1bHxU0nboUn2igdWctsrtL+dv3S2VxoZ68n3yq5hAodxFqMFJbhZ
         8G/XAdVtqtZfhG9gcOFl4r6k/M8dj9zx93O/IpPy107wrZVOAubpMTQ1FYXWU0vPLK+a
         KZj6Y4Vd2oghAKETz1YQVAumKIGyCjGhz/a4gz0DctKrvCSRmKH0u6Zr4RtpdmW3yocL
         xL51hZ0EFaGxcFCpnMNCCpYiTQl5IAO0i2H9FZy1bcl4r8J75o0jjuDdwQh7gFaOSiPG
         NK3w==
X-Forwarded-Encrypted: i=1; AJvYcCWq4f6fsvAG7t3BY7Hso4BmJU8K2Njw1Ir41B4Lz7PGZAOoXFceXHHroLZDtNp9CkPDxuIr1ekyx+W4y7H/M7ifcZhBe/uHZAaRa4Qj
X-Gm-Message-State: AOJu0YwU2/G5szBVAn5kKJsVClMJ/Pim1XlTDLydm9/9gbbjZa0Oa26U
	PCFCeA3xVB1UWdg/IWzMC1vMMADWiXF0MAAwVnvn6YCigbXOwY2o/y2mVQdohwnq8UiKsaqNjDM
	IAA==
X-Google-Smtp-Source: AGHT+IF9l88HGaC1d1HLyyY7IDFpiEi4vq9qAa9NvPmfakPpV+kEbrvofK/e8BseRbKH4YZv3/3tvQ==
X-Received: by 2002:a0c:ed45:0:b0:690:9eaf:dae3 with SMTP id v5-20020a0ced45000000b006909eafdae3mr2320899qvq.54.1710430533929;
        Thu, 14 Mar 2024 08:35:33 -0700 (PDT)
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com. [209.85.160.172])
        by smtp.gmail.com with ESMTPSA id kj15-20020a056214528f00b00691624b5a44sm317973qvb.35.2024.03.14.08.35.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 08:35:33 -0700 (PDT)
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-428405a0205so338821cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:35:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX6V1JjyrxHq+zBVRfJLMfj+ebktaolVOBM4wMudb3lLMzpEI+EM7Jz+GIFN8SfJTYM72LjhlYpd3Klx78iXbDV6mVJTehZjQsPsNT/
X-Received: by 2002:a05:622a:1706:b0:42f:a3c:2d53 with SMTP id
 h6-20020a05622a170600b0042f0a3c2d53mr379616qtk.20.1710430532560; Thu, 14 Mar
 2024 08:35:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307230653.1807557-1-hsinyi@chromium.org>
In-Reply-To: <20240307230653.1807557-1-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Thu, 14 Mar 2024 08:35:17 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VLs0To3=SKkTdEXyoF=OD55PibpzmEMCvELnrCH+3okw@mail.gmail.com>
Message-ID: <CAD=FV=VLs0To3=SKkTdEXyoF=OD55PibpzmEMCvELnrCH+3okw@mail.gmail.com>
Subject: Re: [PATCH v6 0/5] Match panel with identity
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
> This series is a follow up for 1a5e81de180e ("Revert "drm/panel-edp: Add
> auo_b116xa3_mode""). It's found that 2 different AUO panels use the same
> product id. One of them requires an overridden mode, while the other shou=
ld
> use the mode directly from edid.
>
> Match the panel for identity (id and name). If not found, fallback to mat=
ch
> id.
>
> v1: https://lore.kernel.org/lkml/20240223223958.3887423-1-hsinyi@chromium=
org
> v2: https://lore.kernel.org/lkml/20240228011133.1238439-1-hsinyi@chromium=
org
> v3: https://lore.kernel.org/lkml/20240304195214.14563-1-hsinyi@chromium.o=
rg
> v4: https://lore.kernel.org/lkml/20240306004347.974304-1-hsinyi@chromium.=
org/
> v5: https://lore.kernel.org/lkml/20240306200353.1436198-1-hsinyi@chromium=
org/
>
> Hsin-Yi Wang (5):
>   drm_edid: Add a function to get EDID base block
>   drm/edid: Add a function to match EDID with identity
>   drm/edid: Match edid quirks with identity
>   drm/panel-edp: Match edp_panels with panel identity
>   drm/panel-edp: Fix AUO 0x405c panel naming and add a variant
>
>  drivers/gpu/drm/drm_edid.c        | 147 +++++++++++++++++++++++-------
>  drivers/gpu/drm/panel/panel-edp.c |  73 ++++++++++-----
>  include/drm/drm_edid.h            |  12 ++-
>  3 files changed, 177 insertions(+), 55 deletions(-)

As talked about in response to patch #2 [1], series has been pushed to
drm-misc-next:

ca3c7819499e drm/panel-edp: Fix AUO 0x405c panel naming and add a variant
bf201127c1b8 drm/panel-edp: Match edp_panels with panel identity
7ff53c2f77f2 drm/edid: Match edid quirks with identity
6e3fdedcf0bc drm/edid: Add a function to match EDID with identity
a0b39da11618 drm_edid: Add a function to get EDID base block

[1] https://lore.kernel.org/r/CAD=3DFV=3DVsTq_Yy14n5Ygbxqn4pnguG3wC2AQforP8=
vdX-Wgn0Dw@mail.gmail.com

