Return-Path: <linux-kernel+bounces-63649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 586268532C4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1334D285B97
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D9D357872;
	Tue, 13 Feb 2024 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="POd8PqyF"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8744257865
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 14:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707833612; cv=none; b=F0mc5sT1YJZj+3F8vmkxd/0olsZkfQGwdTXiPpxH8L5BtlhkSyIzvBsnMYXpXod24vjlqwy+IKh+X9r0CS5SYLfmMSSOELHvpu1pjeQKRwNAyw6zu5VqaPJDj0BSQWa9NqL+5kfsGpUdlXpiUsTt98MxGQhGVByE9Ed2qCLtBqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707833612; c=relaxed/simple;
	bh=5fI9tCr8zaLU98fmef1NViRValWabP78KKoZNLaPZu4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mUQH0tohNzOM8yKWSP7qK2y/qTPkqVI+MDKHoQus5R/1XIfiB5h4AndwO7ozzgTXdEtTj1QCzef1i+PdQ1dShx+3624bxmtOzOS/07j8dumy6Bedqj1UX6qNcAufCEL4HYRYKswQVs+odK3e14NIN8Rz3O1Q+JPvnP5uHs9+Poo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=POd8PqyF; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51182ece606so2331823e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 06:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707833608; x=1708438408; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qmq2UPFRqaq5ws3fnqDxJqDcSha4yTKtswPkJsibWOY=;
        b=POd8PqyFwgb8DsJK1T0sFAHxVDVNhaET9sW8dszzh+gFOj9GsJgeJB4A8POvLzaCwY
         CH2CpQ8IF7XXH1RUOpLbLh4pQztlYVb+hrjlWkTVH2Gngm79Vk6+2VRONJnjdXdu0Wi3
         L2ruz53JNLQ8PXhRQm/Zf8pizmWX2FJaNAMlA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707833608; x=1708438408;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qmq2UPFRqaq5ws3fnqDxJqDcSha4yTKtswPkJsibWOY=;
        b=Dy8Xn28Yps+WwI69a40x0gl7ocAz97S3t0h3zTNUmniknVraHJMqaJ5uIzB3Cw3fTV
         55lZn1nt7e4w1imva4ckFwFcARn2Rar3as6KwCJgqB96LZcfGLHYYhYjkFKndTdNmOOt
         D2Cwm81f+R7kZrrWAaUtudv9FVB2XWRazvUgQiX5KCzUv4CSvEMM+u/nU+/zoAfdLrFR
         DSs1LC/xpizzR7GwKhX8b4bk+Z4/TQrAb1aG1HBwArUIPs5OYNz8LX3EbdESPWkrxMAe
         Fmatt9H9h4CR/0fBQ4393lIXILxcT7cpFbSfKMFFkeMg00vU74D60LT4tMnNnlnKavs6
         Emfg==
X-Forwarded-Encrypted: i=1; AJvYcCXN+GxrB6mjS1hbVejv47ycT9ySFh/bQK9yBT/FUsvFJ1VPuhLBEXRZgVCgSAWiYmIyczjeSl3+aTnUifPnLrvjeTDBk2Q1zcZEsWrQ
X-Gm-Message-State: AOJu0Yy1Bu8sSr87LwaZd9WRs37Zjk3NePJHOZ1MTY0ztuZo7HzRbn/C
	s4xyllfezH99HTAtoMN/hCgAmbSqaXl4h8pX4m6e8x8U6Tvbu9RQeMygauvgtrlNelM5mOchp4R
	XONo04+gxCE66l/6wzwUcVyvYbLeMrv0cEwxS
X-Google-Smtp-Source: AGHT+IHBdt44ohe1WEmDJRwWk0PqMe3siXeot/wfISehMT/XqiceqCjXRIx22oyAYF8z9DxqrEN1z0sOsGsvydhzfN8=
X-Received: by 2002:a05:6512:4db:b0:511:6ef0:33d1 with SMTP id
 w27-20020a05651204db00b005116ef033d1mr949357lfq.13.1707833608459; Tue, 13 Feb
 2024 06:13:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130095656.3712469-1-wenst@chromium.org> <20240130095656.3712469-4-wenst@chromium.org>
 <92d4d421-54a8-4a41-8b47-61ae39b55ebb@linaro.org>
In-Reply-To: <92d4d421-54a8-4a41-8b47-61ae39b55ebb@linaro.org>
From: Chen-Yu Tsai <wenst@chromium.org>
Date: Tue, 13 Feb 2024 22:13:17 +0800
Message-ID: <CAGXv+5Ej1cEiNegMEf9GOMYTiabiBU1DpfC7QkQAsHEjuNPCxA@mail.gmail.com>
Subject: Re: [PATCH 3/3] nvmem: mtk-efuse: Drop NVMEM device name
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
	William-tw Lin <william-tw.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 9:07=E2=80=AFPM Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
>
> On 30/01/2024 09:56, Chen-Yu Tsai wrote:
> > The MT8183 has not one but two efuse devices. The static name and ID
> > causes the second efuse device to fail to probe, due to duplicate sysfs
> > entries.
>
> have you considered using NVMEM_DEVID_AUTO?

Yes, that was considered and what is actually implemented downstream.

However, since the reason for using a custom name no longer exists, it
seems simpler to just revert to the previous behavior, which is to let
the nvmem core deal with naming.


ChenYu

> --srini
> >
> > With the rework of the mtk-socinfo driver, lookup by name is no longer
> > necessary. The custom name can simply be dropped.
> >
> > Fixes: 4e6102d60d88 ("nvmem: mtk-efuse: Register MediaTek socinfo drive=
r from efuse")
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> > ---
> >   drivers/nvmem/mtk-efuse.c | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/nvmem/mtk-efuse.c b/drivers/nvmem/mtk-efuse.c
> > index f5bebcecf9bd..9caf04667341 100644
> > --- a/drivers/nvmem/mtk-efuse.c
> > +++ b/drivers/nvmem/mtk-efuse.c
> > @@ -86,7 +86,6 @@ static int mtk_efuse_probe(struct platform_device *pd=
ev)
> >       econfig.size =3D resource_size(res);
> >       econfig.priv =3D priv;
> >       econfig.dev =3D dev;
> > -     econfig.name =3D "mtk-efuse";
> >       if (pdata->uses_post_processing)
> >               econfig.fixup_dt_cell_info =3D &mtk_efuse_fixup_dt_cell_i=
nfo;
> >       nvmem =3D devm_nvmem_register(dev, &econfig);

