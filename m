Return-Path: <linux-kernel+bounces-151940-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8368D8AB612
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 22:42:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5BC71C21C17
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BC9168C4;
	Fri, 19 Apr 2024 20:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qpiNMdLi"
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0DD3232
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 20:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713559315; cv=none; b=fBuIB7QvFUbUjmeO6cVk183nWfCP4R2JCB+7zn1YQ4gg+GRYJCnx2uKxODVoI9Swjq8cOSiLTLw+m4OSDMngFoZz4AkczNiF/IljAa1WeO80NFTmR8RzIBMVhfEgP6Arwfti5M9vttxquey0r45dkHVhj4ASNQ+lvmVx7LyaP38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713559315; c=relaxed/simple;
	bh=RMZAGX6lS8OT/tfzcDXtJwOv1xMnu0fCjRT0ln1nlZ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UaoOiINQz4QxQAJRU09zDRYcALX+RRMwF9g57YYbS2VjWxRxoFdPRgkN9MV4AvKD55cJlBl44o/ODMrW8MtVLgY84UK5vvct41wS92P71jQxAbtxeGhLv3tzJrS4haH16tVSewpMUR7fUz5VQe+l0gBhdajiQtav56ZMTwdYGlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qpiNMdLi; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-434ffc2b520so88731cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:41:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713559311; x=1714164111; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6K3dsqSlYNszsCn1h++dCBb6+hru/S0oFdAjebQTHM0=;
        b=qpiNMdLi4h3j+N5/KTixWiaUnNhhiEKp6UWKh/lknBHXYiaiL6efrHMqkbjx7OoL7L
         Orp6E2ajyqvGlwbDUQHob802/pnN/hbxx/L8KYb9g2fXdqrnunOr3LHYevljjqHQq+U/
         5ieGsrPA+6QWocRwcfSv6SZRvuJAVA8kOn5aU+aXWUGsv1SaBmZT1Pd+FYTh61O8ugvC
         VFjgjrv4VQkKTaNfnJ7FOwoyETT5nmbZ/2PJKQWCSNbnsK/+WD0LmWaRC7nvYniqI3FD
         jctfzk53ODFuphVV6BFuIjXyfsRPjrqShMVcaaU9SJ/1GGZDb6nk/cYSeoC2OuphrVO9
         u5LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713559311; x=1714164111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6K3dsqSlYNszsCn1h++dCBb6+hru/S0oFdAjebQTHM0=;
        b=NB8ANNdIS1LYeIcXr12ZjhY1nOOSnJvmhnlKCvfcl3ANRdDd6T05P3jfdDHvSxrVqx
         Z3kr1p4uX2vr38U0tisCa0Yw+UnkJ0ncBDL9eqfEkpnF9u4JlHErONuDIB7u2l4ukXd5
         nq3PKyj/eMR/2rOrzFL8n3m+0GlOn3pvejFGwrUENMCE9fTWeGhuNxqJVWR+gkqANOe2
         Fnya3C2ONJ13K9hcrIFgEvPQou1B8+Jrd8k4WEcYjTYHkhzPvF29Gls6oln9qwQXEwrA
         z/LbN8nUZ7MXEGaCW5PrJRL3s4z7g6YaFSf6iwyERZuYgRv3xXE0MMjgBIVaIWu/M4xR
         ywlg==
X-Forwarded-Encrypted: i=1; AJvYcCVVrTfIH4Gtyf798CBLEAW9DMNuUWntafPWbMzLSiVaRisQl50CX2wFvpqH792c0/uA+SLkxf8HCw1iRSFeb2FShkJlNOesNQAOiZE7
X-Gm-Message-State: AOJu0YwdqjJ7jXUBQEHjOf8XreTTaZm7vLycG/Ujjw0P6Uu6Qlz267cG
	q4fSLVSsZWG0JuGwUIJre3Scnncgp+ylAS3tSwx0RF9Mp4utl5CazhbOBqI8dnotrXenZtUV/Uk
	v3MMJSsUpS55cfs3v1GNBFJIk+BhqblavpgrE
X-Google-Smtp-Source: AGHT+IHZbGtaHsrDZJlMeCvL5n3nHY8v9RvCEAZmDRwJuRM5kQHZzdgDzoyAqJc7HDUdc4L091tykzPFVNpxeTYTWEk=
X-Received: by 2002:ac8:729a:0:b0:437:b99c:dbf7 with SMTP id
 v26-20020ac8729a000000b00437b99cdbf7mr9471qto.11.1713559311445; Fri, 19 Apr
 2024 13:41:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240418124815.31897-1-lvzhaoxiong@huaqin.corp-partner.google.com>
 <20240418124815.31897-3-lvzhaoxiong@huaqin.corp-partner.google.com>
In-Reply-To: <20240418124815.31897-3-lvzhaoxiong@huaqin.corp-partner.google.com>
From: Doug Anderson <dianders@google.com>
Date: Fri, 19 Apr 2024 13:41:34 -0700
Message-ID: <CAD=FV=X5tk0tCcDa+vLnu0aoas1TDWuqvkMzM-278dOCX8K1gw@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] HID: i2c-hid: elan: Add ili2900 timing
To: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>
Cc: dmitry.torokhov@gmail.com, robh@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jikos@kernel.org, 
	benjamin.tissoires@redhat.co, hsinyi@google.com, 
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 18, 2024 at 5:48=E2=80=AFAM lvzhaoxiong
<lvzhaoxiong@huaqin.corp-partner.google.com> wrote:
>
> ILI2900 requires reset to pull down time greater than 10ms,
> so the configuration post_power_delay_ms is 10, and the chipset
> initial time is required to be greater than 100ms,
> so the post_gpio_reset_on_delay_ms is set to 100.
>
> Signed-off-by: lvzhaoxiong <lvzhaoxiong@huaqin.corp-partner.google.com>

Please use a proper name instead of "lvzhaoxiong".


> ---
>  drivers/hid/i2c-hid/i2c-hid-of-elan.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/drivers/hid/i2c-hid/i2c-hid-of-elan.c b/drivers/hid/i2c-hid/=
i2c-hid-of-elan.c
> index 5b91fb106cfc..3073620b2dec 100644
> --- a/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> +++ b/drivers/hid/i2c-hid/i2c-hid-of-elan.c
> @@ -137,10 +137,18 @@ static const struct elan_i2c_hid_chip_data ilitek_i=
li2901_chip_data =3D {
>         .main_supply_name =3D "vcc33",
>  };
>
> +static const struct elan_i2c_hid_chip_data ilitek_ili2900_chip_data =3D =
{
> +       .post_power_delay_ms =3D 10,
> +       .post_gpio_reset_on_delay_ms =3D 100,
> +       .hid_descriptor_address =3D 0x0001,
> +       .main_supply_name =3D NULL,

There's really no main power supply for this device? It feels likely
that there is one.

Also: other than the main power supply, there is no difference between
this and the ili2901. If you actually do have a main power supply,
then you probably don't need a new table. You probably don't even need
your own compatible string and in the device tree you could just
specify:

compatible =3D "ilitek,ili2900, "ilitek,ili2901";

..which says "I actually have an ILI 2900, but if you don't have any
special driver for the ILI 2900 it's likely that the driver for the
ILI 2901 will work because the hardware is almost the same."


> +};
> +
>  static const struct of_device_id elan_i2c_hid_of_match[] =3D {
>         { .compatible =3D "elan,ekth6915", .data =3D &elan_ekth6915_chip_=
data },
>         { .compatible =3D "ilitek,ili9882t", .data =3D &ilitek_ili9882t_c=
hip_data },
>         { .compatible =3D "ilitek,ili2901", .data =3D &ilitek_ili2901_chi=
p_data },
> +       { .compatible =3D "ilitek,ili2900", .data =3D &ilitek_ili2900_chi=
p_data },

If you do need this, these should be sorted. 2900 should come before 2901.


-Doug

