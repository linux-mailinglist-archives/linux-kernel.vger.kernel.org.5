Return-Path: <linux-kernel+bounces-94715-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AAFF08743F5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:32:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F7D4287FAB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:31:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3EB3FB2F;
	Wed,  6 Mar 2024 23:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="no9sMMUJ"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBBB1CA97
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 23:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767836; cv=none; b=qp1ZVs9eEikCDttCm1W0TUa/ou2e1qHsOhDKB7lmZNDObS9WpZ7EL3ygC4LMiyzWgayhHATHWzabpP19erTOiIaZQzfHs+EUVpV7D5/4mJVCNNI/Lwi4T+XwC4PMz9VZTan8dmSmxKXgzlWDfehibhYr3LFdXeB8muQL8AGCpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767836; c=relaxed/simple;
	bh=J3Am2n7team/9EkTjy6YPHAoeXaWgzPxsA3+RQ2XbTE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=putJf26QRP23Lj9yN6YB6of+HgBYYasxEV0dbJw2OjwQlQkDwjMRP47dTXJ2hHSJNMzGLIVkZS1udwRGsgvfFt8fyi4n0GyllXfeXidt57qe9boKODKPc959xoqG8SuUxDBpq0YlEnbcH9ss5O3/RaLrHnV++J2VR4pfxDAvQE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=no9sMMUJ; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-42eff08e3f8so1110181cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709767829; x=1710372629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3s2xlVEAfJBrVxkA6EpLcD8kwhVsasxC35kpd9zGC/E=;
        b=no9sMMUJl6U/gQzagbjOcue4qAHMHz8kesveBvrIi5Gz5HRaeoOGxlijiDxFt7EO2z
         bZa3WAWtKK7nnc7R7lUqpIXNhD8N7s7hYkYxetcuImGWDHwDo2v60jxBz6ZUxFu2Stez
         3zs/C3H1cXZRlII2BKy767Bcnof6FTFfTzuJ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709767829; x=1710372629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3s2xlVEAfJBrVxkA6EpLcD8kwhVsasxC35kpd9zGC/E=;
        b=cz0GHMQ8Veks5inp4Jg6bChhgdOfahNnWVfFPjbMuoywLBpW/TBVQ32z5h8DtUGaSZ
         uzcMKK4FCvef/O3G6FOAUS1G+sBbGCtEiM78q+7J3HKEOOsNdbJMVIaOmewoUGWkwxGW
         38FKzmoR7w4JJFEibI+sa7yfOzke21HQ3rXB2TKL/6h+ynxiJsOq+jDSnQHS6cpDTZ3v
         iy1VAdtQt00s4z5M38wDn+Ita81c2kXD5vupz9+TWJ1DH+qUtkFiX6PKYbHXd9jt4xAe
         LdPmfx6oTO1EHQ+KgF8ozgDVIbkeG8VSNfppzmTY3hoNj/W761Pl4PNSAYt317yODhvI
         9Hgw==
X-Forwarded-Encrypted: i=1; AJvYcCXCuE20X4UDowgXKn+e1wvq0LPHxxGDkY9W2qevpqFXl+m45XrGGYfLNeuQhuBLP7B4GrQevo1k7l/8/+ZxW5wWUgC/URevdR3PtGI6
X-Gm-Message-State: AOJu0YzPKw3EcbGLn/IrpI/s7D+WlMttZO8B9xyw5tfeRf5hEyae4bD8
	HVeNiWu1XIGFrzrsoD3YTGqN+8WF43XO1xAAQ3WVCYR+ZxWdZMvSEdGEd/KGDD1f5RdXp0SkMKs
	=
X-Google-Smtp-Source: AGHT+IEdkqBoCPoxlySP6Mx/S5wqJFa9EBQIScHGD5wL8IAHYqQFJxQ28Bq8g2WRuLnVLFpZgWFu/g==
X-Received: by 2002:ac8:7f4a:0:b0:42f:1c0a:39db with SMTP id g10-20020ac87f4a000000b0042f1c0a39dbmr41827qtk.51.1709767829495;
        Wed, 06 Mar 2024 15:30:29 -0800 (PST)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com. [209.85.160.169])
        by smtp.gmail.com with ESMTPSA id h12-20020ac8138c000000b0042ee2920298sm4363082qtj.61.2024.03.06.15.30.16
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 15:30:19 -0800 (PST)
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-42ef8193ae6so56381cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 15:30:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXKx9jQYGacxvcVkUc8UswRdJD4PCLmWw9AqU5dHVapQOdinAgDGXAVtuFVtdKSrRAF+5ajMCrJiPsIXlAxFwBq16+XsNVKYwUDguBT
X-Received: by 2002:ac8:5891:0:b0:42e:fce9:a5e4 with SMTP id
 t17-20020ac85891000000b0042efce9a5e4mr149098qta.4.1709767816368; Wed, 06 Mar
 2024 15:30:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240306200353.1436198-1-hsinyi@chromium.org> <20240306200353.1436198-6-hsinyi@chromium.org>
In-Reply-To: <20240306200353.1436198-6-hsinyi@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 6 Mar 2024 15:30:00 -0800
X-Gmail-Original-Message-ID: <CAD=FV=U0CGmqYRCUr6-X6Ttkkp4NOP+2BQOpYn3hW-mO0wrtxw@mail.gmail.com>
Message-ID: <CAD=FV=U0CGmqYRCUr6-X6Ttkkp4NOP+2BQOpYn3hW-mO0wrtxw@mail.gmail.com>
Subject: Re: [PATCH v5 5/6] drm/panel-edp: Match edp_panels with panel identity
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
> @@ -2111,15 +2113,16 @@ static const struct edp_panel_entry edp_panels[] =
=3D {
>         { /* sentinal */ }
>  };
>
> -static const struct edp_panel_entry *find_edp_panel(u32 panel_id)
> +static const struct edp_panel_entry *find_edp_panel(u32 panel_id, const =
struct drm_edid *edid)
>  {
>         const struct edp_panel_entry *panel;
>
> -       if (!panel_id)
> -               return NULL;
> +       for (panel =3D edp_panels; panel->ident.panel_id; panel++)
> +               if (drm_edid_match(edid, &panel->ident))
> +                       return panel;
>
> -       for (panel =3D edp_panels; panel->panel_id; panel++)
> -               if (panel->panel_id =3D=3D panel_id)
> +       for (panel =3D edp_panels; panel->ident.panel_id; panel++)
> +               if (panel->ident.panel_id =3D=3D panel_id)
>                         return panel;

Reading through this another time, I wouldn't object to a comment
reminding the user why there are two loops here. Something like "Try
to match both the panel ID and name at first. This allows handling the
case where vendors incorrectly reused the same panel ID for multiple
panels that need different settings. If we don't get a match with the
name, that's OK. Panel ID _should_ be unique anyway". Feel free to
reword.

In any case:

Reviewed-by: Douglas Anderson <dianders@chromium.org>



-Doug

