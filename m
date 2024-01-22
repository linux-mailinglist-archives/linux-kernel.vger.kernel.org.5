Return-Path: <linux-kernel+bounces-33483-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57AEC836A36
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:21:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 10EB728532D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 16:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60DE52F7A;
	Mon, 22 Jan 2024 15:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DN2Lis9/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AD0152F6B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705936465; cv=none; b=bHrctu7HqzspruwXN/15Xb31JlDM9o0doq5GuqWmdjf5OKUTBOakNhe3F23tUw+1l2jlV2NZGXr+UjCcx2JK0i/7q+QeTuxRNqNWTXiqihLEqh7KE5V/RUxfzmkGjIW9XsPaMtK3o0hHVYYm/4uuUxOT2l54wbIQb4De4X5oZpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705936465; c=relaxed/simple;
	bh=DCZ1yeweHK2ZD0/uXdu9bE6/Jcq3FK7B2WmAhGZfcIk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DrtL9GlsK1atu4XvBqmm0IXvjomvl1OPeIJRMBAXOCbeZeRJai00vG0j2k5t+tNx4Zvso68YM3P6viD8RKAcUmVpFqdOPvLwgZxFUKwuxtwVVdK7gp17areO9vgueu/R9XdVUKNVJMaWHHSBUCnQ6S9xsbIixGQLpvfEcVjUKH8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DN2Lis9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55CAC4166B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 15:14:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705936464;
	bh=DCZ1yeweHK2ZD0/uXdu9bE6/Jcq3FK7B2WmAhGZfcIk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=DN2Lis9/iFq5QR+6FC0X0SvlTktEklejUr/3e8HjykOk7Lsgc5bcKpMhYCkKC2iYD
	 T9steyNhvyHKhP4TsWHn/tZVpG1aKTBC4aqYvUFH2qo3usH51KhwMJ3ITdVxk7WPh0
	 AT5lC3YybaCAjFgZ/W38LDMrYgcYIasm707zfrq8ym/UHiBVgrOzI9ThYmMREjR9rV
	 X3+PwJTc8vNyo3M14CCZxCQ3+W7LpOppSTBMVkgH4Zoinln+2WB8zQpUcBmdx8z1L9
	 qUmh0p79qbxe2HemO3pdqBS9D4ie34AJKgcrPlT9JyyH8DMAuhKN0x6qUXlhx5g0FW
	 pkC9is7+/O5YA==
Received: by mail-yb1-f179.google.com with SMTP id 3f1490d57ef6-dc22597dbfeso3533100276.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 07:14:24 -0800 (PST)
X-Gm-Message-State: AOJu0YwUmVdxulAva5eI5Zqm6YBwDVLokmQB5+VjqntSWLgFyhzYmEHe
	qecgHGkvBRzA4oj1w5NuSmlUo8f30jPCNOJCeXePcnmiIdSNdjb32cfprNwuxS7gcyv0nn5Ud53
	mmNG8gwVTSg1m/ZAjQbP0vs3x1eVgWlQfpz4Wjw==
X-Google-Smtp-Source: AGHT+IELeqUZHcuEi6czSy6GxZtZYY24kkEpIurvFbFmTxvGFQUNqb3M5tKbk3ha+xCzPOeAwzOOrlbwEjoG5Tvhq/U=
X-Received: by 2002:a25:8049:0:b0:dbe:aab1:b0e3 with SMTP id
 a9-20020a258049000000b00dbeaab1b0e3mr2553106ybn.98.1705936463808; Mon, 22 Jan
 2024 07:14:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231214123205.v2.1.I9d1afcaad76a3e2c0ca046dc4adbc2b632c22eda@changeid>
 <20231214123205.v2.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
In-Reply-To: <20231214123205.v2.2.I7b83c0f31aeedc6b1dc98c7c741d3e1f94f040f8@changeid>
From: Robert Foss <rfoss@kernel.org>
Date: Mon, 22 Jan 2024 16:14:12 +0100
X-Gmail-Original-Message-ID: <CAN6tsi4LtcSK0vc7oWn_H2Mk=pHj9kxTnk1aB5FZi2varHox=g@mail.gmail.com>
Message-ID: <CAN6tsi4LtcSK0vc7oWn_H2Mk=pHj9kxTnk1aB5FZi2varHox=g@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] drm/bridge: ti-sn65dsi86: Never store more than
 msg->size bytes in AUX xfer
To: Douglas Anderson <dianders@chromium.org>
Cc: dri-devel@lists.freedesktop.org, Guenter Roeck <groeck@chromium.org>, 
	Andrzej Hajda <andrzej.hajda@intel.com>, Daniel Vetter <daniel@ffwll.ch>, 
	David Airlie <airlied@gmail.com>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	Jonas Karlman <jonas@kwiboo.se>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Sam Ravnborg <sam@ravnborg.org>, 
	Stephen Boyd <swboyd@chromium.org>, Thomas Zimmermann <tzimmermann@suse.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 14, 2023 at 9:32=E2=80=AFPM Douglas Anderson <dianders@chromium=
org> wrote:
>
> For aux reads, the value `msg->size` indicates the size of the buffer
> provided by `msg->buffer`. We should never in any circumstances write
> more bytes to the buffer since it may overflow the buffer.
>
> In the ti-sn65dsi86 driver there is one code path that reads the
> transfer length from hardware. Even though it's never been seen to be
> a problem, we should make extra sure that the hardware isn't
> increasing the length since doing so would cause us to overrun the
> buffer.
>
> Fixes: 982f589bde7a ("drm/bridge: ti-sn65dsi86: Update reply on aux failu=
res")
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
> Changes in v2:
> - Updated patch subject to match ps8640 patch.
>
>  drivers/gpu/drm/bridge/ti-sn65dsi86.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi86.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi86.c
> index 9095d1453710..62cc3893dca5 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi86.c
> @@ -527,6 +527,7 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *=
aux,
>         u32 request_val =3D AUX_CMD_REQ(msg->request);
>         u8 *buf =3D msg->buffer;
>         unsigned int len =3D msg->size;
> +       unsigned int short_len;
>         unsigned int val;
>         int ret;
>         u8 addr_len[SN_AUX_LENGTH_REG + 1 - SN_AUX_ADDR_19_16_REG];
> @@ -600,7 +601,8 @@ static ssize_t ti_sn_aux_transfer(struct drm_dp_aux *=
aux,
>         }
>
>         if (val & AUX_IRQ_STATUS_AUX_SHORT) {
> -               ret =3D regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &le=
n);
> +               ret =3D regmap_read(pdata->regmap, SN_AUX_LENGTH_REG, &sh=
ort_len);
> +               len =3D min(len, short_len);
>                 if (ret)
>                         goto exit;
>         } else if (val & AUX_IRQ_STATUS_NAT_I2C_FAIL) {
> --
> 2.43.0.472.g3155946c3a-goog
>
>

Reviewed-by: Robert Foss <rfoss@kernel.org>

