Return-Path: <linux-kernel+bounces-84334-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F7D86A505
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 02:28:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B82284CCC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 01:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDFE1FA3;
	Wed, 28 Feb 2024 01:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="eg5J9fy/"
Received: from mail-ot1-f50.google.com (mail-ot1-f50.google.com [209.85.210.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07AC1852
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 01:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709083714; cv=none; b=YPTWOxRwrLLXSqGv6CwK4qOuDUg5ZwZqSNikDFegIWV0dj2uZiJs/99RapO6ycHhVRK1xW/BA1TE1YIqnnrsDU5mCMzGWA3bSN1WAns6Y5TaZX2cSasOZMNB7oN4dLWBlOIXcXgcxdLYzxC6Ms2MunO0qGzyxwDeVCmFy4OlghE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709083714; c=relaxed/simple;
	bh=VIXnPoDc1Mpfsib1HzzAu8abKwj15m1iiwAjNWVWB4U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KW7lKwqlJIpJfGYf89sHDJtMPogKCpW5d4g1PZIfJMEyCZDfqeXndoJOquCKcpaz4aZ5BltnHXLYWa1Ir79Crg0flqpK9f5HuCDV0+OX9emmq/mNj0ocKzCImkOXe23dOllOUh463UkPfqW7Cwfmimym/Pqepd0kJbdvmiVHkaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=eg5J9fy/; arc=none smtp.client-ip=209.85.210.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f50.google.com with SMTP id 46e09a7af769-6e4899fa7f1so2256124a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709083712; x=1709688512; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TG9LRH7eFEOhXweP6BfJavoKE1KflH590lEzMtnAQb4=;
        b=eg5J9fy/iNQl0xB7nhkQ86qiGny4EnbxaLIdykeC+6aFi5jUp3yZh/Ned1WTXjsP52
         b4FY9chX4pS/U4Mc0ubcT/8tKlGqPPDDQ8a6ptdwx9AGrY7QLSAHoB14MKtyrs48/6sf
         g1Uh+ea3eqd+D0w0O7JeokCpck4BXeRa1J9k4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709083712; x=1709688512;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TG9LRH7eFEOhXweP6BfJavoKE1KflH590lEzMtnAQb4=;
        b=wQAWJZo6vHXv1pLVO9C15Vn8CJCQ/rNUKg93SZbc5RL2rsozQ3jL1B/vAdv5mLs8HE
         65oHAjSKVgdDT/v8R4Cb1+3OJBvw7apoM8r05Otl8jUQabUjuC2hHqP1X4MvN4wzcw3X
         Wld5LXgAF5QMAtVjmbmNufpu86QF5MGMjyLqDCEZRtZ94mZKYwDtqm4csGcHyNfiRQ/4
         QKIV42PJwJDtwyjqPUJS5anRgpMUa8Kn3weWdzYc2GqKxJ/GIoY2SRN0dP4gi7RmeuWz
         75jM8BDbSYtdI0m3PU+KcNRTTDYzNAWSSzIUsCs+3zhCHasjcFD3PciJNSIuKxQWnQyc
         Gp5g==
X-Forwarded-Encrypted: i=1; AJvYcCVVJlWFNzyEU5/WJAPcnQowumfoNZYj8SE9sKh12fR4CD4tg5tZbQH5tIT5cDthszkyxrBB8+Of0fB1PJV+NOMKEIhzgI5iAdsOHExr
X-Gm-Message-State: AOJu0Yy63sWuAnbbVZ8cuGRO5Xg8uMZQj68UO5+GuXNmd0u1oJCWZzys
	5XRAYdO/BPr6SyNNEw54kFNdDeota4J7sKQv1A5KKV3mGg7Yo8TNBVqNYRTJa7co+0jCe3WWBjn
	jzaUF2TDP6LZSOL1ctf2cBqLvnEqFlldof3Eg
X-Google-Smtp-Source: AGHT+IG1dEAkf5yEFaKk9SWNj5ZtLwHK0Fg2SkuBw6fFTV//VPKF/d0SiFkgQOj+YmtOoPBTxv5ug7sL0HVECZSr2jM=
X-Received: by 2002:a05:6830:11d2:b0:6e4:6305:367b with SMTP id
 v18-20020a05683011d200b006e46305367bmr13453954otq.30.1709083711928; Tue, 27
 Feb 2024 17:28:31 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240228011133.1238439-1-hsinyi@chromium.org> <20240228011133.1238439-2-hsinyi@chromium.org>
In-Reply-To: <20240228011133.1238439-2-hsinyi@chromium.org>
From: Hsin-Yi Wang <hsinyi@chromium.org>
Date: Tue, 27 Feb 2024 17:28:06 -0800
Message-ID: <CAJMQK-h2RcZb_PmyYQxndBogY=dBiXMOBZJB=mXgwQb5Wm6ucg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] drm_edid: Support getting EDID through ddc without connector
To: Douglas Anderson <dianders@chromium.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>, 
	Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
	Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 5:11=E2=80=AFPM Hsin-Yi Wang <hsinyi@chromium.org> =
wrote:
>
> Some panels are interested in the EDID during early probe when connector
> is still unknown.
>
> Add a function drm_get_edid_no_connector() to get edid without connector.
> No functional change for existing usage.
>
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
> ---
> v1->v2:
> add a function to return the entire edid without updating connector.
> ---
>  drivers/gpu/drm/drm_edid.c | 45 ++++++++++++++++++++++++++++----------
>  include/drm/drm_edid.h     |  1 +
>  2 files changed, 34 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 1ad94473e400..15b97c8ed993 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -2364,7 +2364,7 @@ static struct edid *_drm_do_get_edid(struct drm_con=
nector *connector,
>         struct edid *edid, *new;
>         size_t alloc_size =3D EDID_LENGTH;
>
> -       override =3D drm_edid_override_get(connector);
> +       override =3D connector ? drm_edid_override_get(connector) : false=
;

typo: should be NULL here. I'll update in the next version with other comme=
nts.

>         if (override) {
>                 alloc_size =3D override->size;
>                 edid =3D kmemdup(override->edid, alloc_size, GFP_KERNEL);
> @@ -2385,18 +2385,20 @@ static struct edid *_drm_do_get_edid(struct drm_c=
onnector *connector,
>         if (status =3D=3D EDID_BLOCK_READ_FAIL)
>                 goto fail;
>
> -       /* FIXME: Clarify what a corrupt EDID actually means. */
> -       if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_BLOCK_VERSI=
ON)
> -               connector->edid_corrupt =3D false;
> -       else
> -               connector->edid_corrupt =3D true;
> +       if (connector) {
> +               /* FIXME: Clarify what a corrupt EDID actually means. */
> +               if (status =3D=3D EDID_BLOCK_OK || status =3D=3D EDID_BLO=
CK_VERSION)
> +                       connector->edid_corrupt =3D false;
> +               else
> +                       connector->edid_corrupt =3D true;
>
> -       if (!edid_block_status_valid(status, edid_block_tag(edid))) {
> -               if (status =3D=3D EDID_BLOCK_ZERO)
> -                       connector->null_edid_counter++;
> +               if (!edid_block_status_valid(status, edid_block_tag(edid)=
)) {
> +                       if (status =3D=3D EDID_BLOCK_ZERO)
> +                               connector->null_edid_counter++;
>
> -               connector_bad_edid(connector, edid, 1);
> -               goto fail;
> +                       connector_bad_edid(connector, edid, 1);
> +                       goto fail;
> +               }
>         }
>
>         if (!edid_extension_block_count(edid))
> @@ -2444,7 +2446,8 @@ static struct edid *_drm_do_get_edid(struct drm_con=
nector *connector,
>         }
>
>         if (invalid_blocks) {
> -               connector_bad_edid(connector, edid, num_blocks);
> +               if (connector)
> +                       connector_bad_edid(connector, edid, num_blocks);
>
>                 edid =3D edid_filter_invalid_blocks(edid, &alloc_size);
>         }
> @@ -2637,6 +2640,24 @@ struct edid *drm_get_edid(struct drm_connector *co=
nnector,
>  }
>  EXPORT_SYMBOL(drm_get_edid);
>
> +/**
> + * drm_get_edid_no_connector - get EDID data without updating connector =
status
> + * @adapter: I2C adapter to use for DDC
> + *
> + * Similar to drm_edid_read_ddc(), but not checking any connector status=
 Use
> + * this function to get EDID when connector is still unknown.
> + *
> + * Return: Pointer to valid EDID or NULL if we couldn't find any.
> + */
> +struct edid *drm_get_edid_no_connector(struct i2c_adapter *adapter)
> +{
> +       if (!drm_probe_ddc(adapter))
> +               return NULL;
> +
> +       return _drm_do_get_edid(NULL, drm_do_probe_ddc_edid, adapter, NUL=
L);
> +}
> +EXPORT_SYMBOL(drm_get_edid_no_connector);
> +
>  /**
>   * drm_edid_read_custom - Read EDID data using given EDID block read fun=
ction
>   * @connector: Connector to use
> diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
> index 70ae6c290bdc..80c9e32ff80e 100644
> --- a/include/drm/drm_edid.h
> +++ b/include/drm/drm_edid.h
> @@ -565,6 +565,7 @@ struct edid *drm_do_get_edid(struct drm_connector *co=
nnector,
>         void *data);
>  struct edid *drm_get_edid(struct drm_connector *connector,
>                           struct i2c_adapter *adapter);
> +struct edid *drm_get_edid_no_connector(struct i2c_adapter *adapter);
>  u32 drm_edid_get_panel_id(struct i2c_adapter *adapter);
>  struct edid *drm_get_edid_switcheroo(struct drm_connector *connector,
>                                      struct i2c_adapter *adapter);
> --
> 2.44.0.rc1.240.g4c46232300-goog
>

