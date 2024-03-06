Return-Path: <linux-kernel+bounces-94737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DFA87448D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A8721F27A10
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EB3B1D54D;
	Wed,  6 Mar 2024 23:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Wcex9lJa"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B911D546
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709768154; cv=none; b=WbqhsQKKsYnmBP6OmXu9IQyrOTPATNkBunUPSVlEqrXzxKtu0APYT5E8kmPYTvXN8d5ZIUSy42ODI+yIb6wJDSEyRcJ9DcagggNkWOY5+lpSLJDtysilNN85rOVYmch/ZD5ynp2G9CuATyPUBxWQdDp6BpFFqy1q5Y8L2mgI5hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709768154; c=relaxed/simple;
	bh=bpCYm7lk/Zt2nlVqJJ9jqReyYUgSKztCBgaYlIlkBmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iAdY5fDJ6PCPFF/2tdai9QN0KZfEQm61Ac3JnazukBhn44xPA80lxcMTaRLRtDVN4ZBxturuJSnCuPyjM5A5qKDvrzU4NYxKaPJsIpW8kt6U/f0J+cdTtJVIcCn5olbXCXna/WhMSx751rrXVpA3c67XNT4L6vhHF9Kq65LAdMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Wcex9lJa; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1dca3951ad9so2283855ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709768151; x=1710372951; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PJPa29UemqkJNoNGTKdfNViJ5FBTYfS9WvG9ykZmeu8=;
        b=Wcex9lJaVQPr8dhdDL1YwJ/BYb/5HFHZwRSCyT1dT41I3KJr2SK5A9vJymiYNeFui9
         ErcjkebaeOhfUKm+UEiLFoLgZyYQyJ9f9v7+Amxq2GOdexfnKUfuRPyG7VuK3zp3wuMG
         0XSODgl/FuCXmInKbJ8HfAhsp0wjXwEMC62mA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709768151; x=1710372951;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PJPa29UemqkJNoNGTKdfNViJ5FBTYfS9WvG9ykZmeu8=;
        b=bf8YU7KE3jxHM5nYsQ9Ah9RHaI9Ue28y9G9JEVWWU3dLd1hudBtWCCvKwLNC0X96cQ
         DRREqlfviJQTsgqc2a5NBevEePt5iswswh+OSCJmq+NM+e2QPRnl1kr9/POQbJahk+Og
         dRmHEAHO+LMsx58zv5iGWUEBJa1DDBrSIJv0tSc8nToEy0nvm5pb6RFFChj0JstFbQsL
         Idr+LuSTOqwh4VWRNJ7duY+IditXzrE4AHcbkprreJOWFpBEm9mzeP2gPWzPGunTZGMU
         BozAUaHoz+yUS6eX31pKuxQ24aMjO9zITVWoOTn0WUTtHaEN3e0AX8SkwOQX97P4Ss+v
         mAUA==
X-Forwarded-Encrypted: i=1; AJvYcCUQdCetgxRsbnSFbLvA9anpgiNDfbsKJhD25kkaRSDiPp0sCHJldRA7/gZY3yvXo4rXduKPxQ0gtX/004JIFQRIE+XwmY506ycKNV2G
X-Gm-Message-State: AOJu0YzoTvRvqvpjNw8dokaLk0bwZzccG5JqzKaQbA13uCz8/fBWxQ73
	7f6MATp1vIcK+lnFGJl2wrObolN62dKJB8JoL0hh86vgbvJB0FtSIzwkPCtICy4FpN7wY1hTphY
	=
X-Google-Smtp-Source: AGHT+IGxmjI3HnqTiHMNFI+XFCCi6WXLxPukpdJuxbNF5IZ3qw/8U/7BZQ5vRcM/uXNE2xi4tctEkw==
X-Received: by 2002:a17:902:930c:b0:1dc:334:a87b with SMTP id bc12-20020a170902930c00b001dc0334a87bmr6646098plb.20.1709768151477;
        Wed, 06 Mar 2024 15:35:51 -0800 (PST)
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com. [209.85.214.177])
        by smtp.gmail.com with ESMTPSA id j6-20020a170903024600b001db608107ecsm13102971plh.167.2024.03.06.15.35.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:35:51 -0800 (PST)
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dcd07252d9so36565ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:35:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUbgzClu2YbuZOoRAFRYH28xLn4Q7rlMU1/UWld12HnhSvarTd7yTcfppB40wG6PCoHIS6FzITsd37GJ8yTKYHFMqs17GRXo5ywmrCi
X-Received: by 2002:ac8:5ad3:0:b0:42e:dced:d36c with SMTP id
 d19-20020ac85ad3000000b0042edcedd36cmr86231qtd.29.1709767796260; Wed, 06 Mar
 2024 15:29:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-4-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-4-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:29:44 -0800
X-Gmail-Original-Message-ID: <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
Message-ID: <CAD=FV=W2CKoOyhN49RBU0FdzcRC6SEwvVQYdJRnBBK16Lp-=FQ@mail.gmail.com>
Subject: Re: [PATCH v5 3/6] drm/edid: Add a function to match EDID with identity
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
> +static void
> +match_identity(const struct detailed_timing *timing, void *data)
> +{
> +       struct drm_edid_match_closure *closure =3D data;
> +       unsigned int i;
> +       const char *name =3D closure->ident->name;
> +       unsigned int name_len =3D strlen(name);
> +       const char *desc =3D timing->data.other_data.data.str.str;
> +       unsigned int desc_len =3D ARRAY_SIZE(timing->data.other_data.data=
str.str);
> +
> +       if (name_len > desc_len ||
> +           !(is_display_descriptor(timing, EDID_DETAIL_MONITOR_NAME) ||
> +             is_display_descriptor(timing, EDID_DETAIL_MONITOR_STRING)))
> +               return;
> +
> +       if (strncmp(name, desc, name_len))
> +               return;
> +
> +       /* Allow trailing white spaces and \0. */
> +       for (i =3D name_len; i < desc_len; i++) {
> +               if (desc[i] =3D=3D '\n')
> +                       break;
> +               if (!isspace(desc[i]) && !desc[i])
> +                       return;
> +       }

If my code analysis is correct, I think you'll reject the case where:

name =3D "foo"
desc[13] =3D "foo \0zzzzzzzz"

..but you'll accept these cases:

desc[13] =3D "foo \nzzzzzzzz"
desc[13] =3D "foo \0\0\0\0\0\0\0\0\0"

It somehow seems weird to me that a '\n' terminates the string but not a '\=
0'.

I would have done:

      for (i =3D name_len; i < desc_len; i++) {
              /* Consider \n or \0 to terminate the string */
              if (desc[i] =3D=3D '\n' || desc[i] =3D=3D '\0')
                      break;
              /* OK for spaces at the end, but non-space is a fail */
              if (!isspace(desc[i]))
                      return;
      }


> @@ -367,6 +367,12 @@ struct edid {
>         u8 checksum;
>  } __attribute__((packed));
>
> +/* EDID matching */
> +struct drm_edid_ident {
> +       u32 panel_id;
> +       const char *name;

Might not hurt to have a comment for panel_id saying that it's encoded
by drm_edid_encode_panel_id() so it's obvious what this random u32 is.


-Doug

