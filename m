Return-Path: <linux-kernel+bounces-140723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D7C8A183F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A053D28747C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46EB613AEE;
	Thu, 11 Apr 2024 15:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DTiKJazT"
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CC5156CF
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848198; cv=none; b=o236Gv3UKFlPWpP/dYGuugOx7ezFbBJ1zJXO9owdOHiMqLiAJUdUDk/b0Pqi2FKXpD8lT4rtrrfGLHaPoFF2VdU+kUYUmykjl6gjBIF/BelhIpMVr4Taq4CCtYXsVTx8KrgTdOnSWDeIwpo4flEuuI3QlmOy9YgDXYxnnqhdpsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848198; c=relaxed/simple;
	bh=4625D/B3C/UFea8y+oXUw6ruHkwZk1o0sRh6oX8bUZE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngYDIKKlUBG/Mm6616QrEZkQhyi6LVChfZRlbY0aKlxgZPl8Fdy9MMPEucDLDZLx+1YtXluVbyg0OnDfLMc+cb+cfIJICREpskGUV7lKZFEVKZOq3C1POvvNtydzDce4v9Jc/bavCPmWGhBUEPSancKx2xkopEIIL3ydDFXSLvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DTiKJazT; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6eb52d3aa1eso212307a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712848196; x=1713452996; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OZyuj75Ez/rddFFT5oB20s7V0CQchh27dVHWZ4w414Q=;
        b=DTiKJazTA8s7i01hgDKIAMG8kB0xOOM2EBfJB/sBjqlV7gjocpXKVysiQ7z5x9tUcZ
         CXoEYFj/Nh7v8sHo/UufGy9zVD4Ial1ao92KmZK3ilcLCdsuOnkLlfGYr/1O4gHsq4OU
         orkh4e4d4XgomIFgw3ojutn+v5mbMuD90zXBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712848196; x=1713452996;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OZyuj75Ez/rddFFT5oB20s7V0CQchh27dVHWZ4w414Q=;
        b=E5RNMxpME+Kl+vDJTEN0jjXwiV9AWvs8VziuMLBuROPyGYi0Xsh4FBhVkASAWvVuP/
         mrpJY3QwPc6j6eZt8I3EFQTezZdLuY1vygHCRTFE13BdrpM9YUo9ZRbwib48NuL/2R10
         1FA91wLkT/HvEK/Bdezpfy+Ocs9jdukJkLS4bUZ7zB5kxV/VCS/KYYeTqfqfiglspBOC
         OL+IoJje0vMoH816xnwwYsYojplZiSO1WROyiO2SOVQjcfWpMrowtoOp0ovFQrWRLgsB
         mI8A5fU8MtwO8JWebVIS8htNXyN6/0crxrib9uN2Rk0C60bEs7HhSkLeMmtq5iYQiiNi
         Ek+A==
X-Forwarded-Encrypted: i=1; AJvYcCUTsmfXdVMNBN1ebIETFVyvtPK4o/XuLTfLij+wyQ5GwAAjEyDBjUI25sH/gsaihtCMB+H+b5GM9CdXk+aP8QPT3VKGv/eI4viZIiNW
X-Gm-Message-State: AOJu0Yxie/FgnqjEmF7Aq/d2fT09rqymfCwodPtg3/iw2tyaDZY0MwGO
	gEaSWJXPypitZsHwTta2AfVM7L5irqH+t+kBBwCPAiAGC7H2bqEK27JyegTaATWxXJuiaKiG+bY
	=
X-Google-Smtp-Source: AGHT+IFVSS5c2Wxlba4wbhQIYe8YmbIxRDm9IhFzPbDdC/k+m7mmpBhAriLUr2SR2JVp3wJXtIUa2A==
X-Received: by 2002:a05:6830:c9:b0:6e9:f2f0:fadd with SMTP id x9-20020a05683000c900b006e9f2f0faddmr5706653oto.1.1712848196015;
        Thu, 11 Apr 2024 08:09:56 -0700 (PDT)
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com. [209.85.167.174])
        by smtp.gmail.com with ESMTPSA id x13-20020a9d628d000000b006ea2013b948sm320412otk.58.2024.04.11.08.09.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Apr 2024 08:09:54 -0700 (PDT)
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3bbbc6e51d0so3331711b6e.3
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:09:54 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWpsTH6W+9YV/nHU9Jqh7736qUj1f6DvOcBCAQg7iP/eW702z28i0L35Z3e/mwescSM5e+7YHGuVSjKZjKyWBlaniZL4g/+50DH6reJ
X-Received: by 2002:aca:2b16:0:b0:3c6:58f:8792 with SMTP id
 i22-20020aca2b16000000b003c6058f8792mr5313561oik.20.1712848194156; Thu, 11
 Apr 2024 08:09:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409035355.27659-1-jason-ch.chen@mediatek.com>
In-Reply-To: <20240409035355.27659-1-jason-ch.chen@mediatek.com>
From: Fei Shao <fshao@chromium.org>
Date: Thu, 11 Apr 2024 23:09:16 +0800
X-Gmail-Original-Message-ID: <CAC=S1nhc-5QRmd21Mi28pKCbzK8zt0ntsdo8J9xxp+BHJ7ONnw@mail.gmail.com>
Message-ID: <CAC=S1nhc-5QRmd21Mi28pKCbzK8zt0ntsdo8J9xxp+BHJ7ONnw@mail.gmail.com>
Subject: Re: [PATCH] soc: mediatek: mtk-socinfo: Correct the marketing name
 for MT8188GV
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Jason-ch Chen <jason-ch.chen@mediatek.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>, 
	Project_Global_Chrome_Upstream_Group@mediatek.com, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 9, 2024 at 11:54=E2=80=AFAM Jason-ch Chen
<jason-ch.chen@mediatek.com> wrote:
>
> From: Jason-ch Chen <Jason-ch.Chen@mediatek.com>
>
> Change 'Kompanio 830' to 'Kompanio 838'.
>
> Signed-off-by: Jason-ch Chen <Jason-ch.Chen@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-socinfo.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/soc/mediatek/mtk-socinfo.c b/drivers/soc/mediatek/mt=
k-socinfo.c
> index 6943ab29f095..74672a9d6d13 100644
> --- a/drivers/soc/mediatek/mtk-socinfo.c
> +++ b/drivers/soc/mediatek/mtk-socinfo.c
> @@ -48,8 +48,8 @@ static struct socinfo_data socinfo_data_table[] =3D {
>         MTK_SOCINFO_ENTRY("MT8183", "MT8183V/AZA", "Kompanio 500", 0x0001=
0043, 0x00000940),
>         MTK_SOCINFO_ENTRY("MT8186", "MT8186GV/AZA", "Kompanio 520", 0x818=
61001, CELL_NOT_USED),
>         MTK_SOCINFO_ENTRY("MT8186T", "MT8186TV/AZA", "Kompanio 528", 0x81=
862001, CELL_NOT_USED),
> -       MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 830", 0x818=
80000, 0x00000010),
> -       MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 830", 0x818=
80000, 0x00000011),
> +       MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/AZA", "Kompanio 838", 0x818=
80000, 0x00000010),
> +       MTK_SOCINFO_ENTRY("MT8188", "MT8188GV/HZA", "Kompanio 838", 0x818=
80000, 0x00000011),
>         MTK_SOCINFO_ENTRY("MT8192", "MT8192V/AZA", "Kompanio 820", 0x0000=
1100, 0x00040080),
>         MTK_SOCINFO_ENTRY("MT8192T", "MT8192V/ATZA", "Kompanio 828", 0x00=
000100, 0x000400C0),
>         MTK_SOCINFO_ENTRY("MT8195", "MT8195GV/EZA", "Kompanio 1200", 0x81=
950300, CELL_NOT_USED),
> --

I've spoken to the MediaTek folks who are familiar with the MT8188 SoC.
This is an intended marketing name change, so

Reviewed-by: Fei Shao <fshao@chromium.org>

Regards,
Fei

