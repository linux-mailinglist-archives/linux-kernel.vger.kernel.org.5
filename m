Return-Path: <linux-kernel+bounces-37830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B19D83B62B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 01:44:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8F941F24E05
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 00:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D34CA3D;
	Thu, 25 Jan 2024 00:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBKWHnUs"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2983F63AE;
	Thu, 25 Jan 2024 00:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706143436; cv=none; b=PtI+UCtNj+qfkr9RWmcfmy2k9rhfXW+85duAXNwq8h+b2AywzoTe/VwbmkIIW642e05I3WuSNFcnrEFp//kkgbIwIIppP+eSuePYmqILoIs4ZPJLdBRrzq9QMpnoOOzfb4wjEnC8Wpyx7e3VR5MbvfpzK7bA3UUHkPmuj1dMoO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706143436; c=relaxed/simple;
	bh=yCcZeaaqYYRu8RPX/c6SSdgg2TCYbsxPPTWCp3Obvfw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jGt3/sbYLGDUF9dtl2j9EXRUMIPEnF8dj0IaZmtcAKb3zBz295Sc03CcLuM4vyJq3f5dCTDAzNUp5M7a1CQlrTjknS2if6a67mbJhhjEKi/n58Sf0lNcnoCRMqJxw4tvaP/zhkMoTkryYFMh68GZp76tjjK1CV+DuIsDilSFYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBKWHnUs; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a313b51cf1fso39858966b.0;
        Wed, 24 Jan 2024 16:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706143433; x=1706748233; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hFc+kSQFufwfP1edBk1kaebdfjp3/wv6fnY/t4JcCA0=;
        b=BBKWHnUs/k5ZLrpSnhZOsExCwVgs8R0AKBhTcDCNNwo3pGy4HLQLyHGBA01C+J4ToC
         pvJZlGXOlyTrcYIYU6cmZnX6CUYl16Ijd4HYP16/R7ORkH/sGf2NTnuiY2jfsccmRN86
         /E4AnvRy7nG3cDjc+Q2s1q97eAWcEEIJiJhBR4Pvo9GBc2la0XuMLHy+KQY9eJOF3tQm
         5CpALmjsAt6KzzXiOLPotG0BNbyksZJ+yzNGyeFS/hxfZ89mcVYdbv/jhcCX560gG6V4
         CLsiGEcrn1tKCYInRdhFYG5YkQvFSfnFktVHlTBYwaRiC9BmMK5vd/YUv+VzFC8BgR3F
         Rf8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706143433; x=1706748233;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hFc+kSQFufwfP1edBk1kaebdfjp3/wv6fnY/t4JcCA0=;
        b=rLezO/4yAqqLCIx/GK0pSSP5D795dX+KlhzMnqvwe7a3LoO3jPl7cDH6SFz3B8kDi0
         bjV0rhRd4abjLrzEkPFWiSGaPc6WXgnoDMgqa/6B4q2U8Ow81mQbNFGCQa+PXk5JI4lq
         kGBUNgXHEZSDF2b7fkJlsFaM4RMkaGZr9sb0fTJf/+G4MbjePswXfUMRlJZvJs934GRA
         AyYXrGChdAPuvSuVTm93HfSbsVUDSXlPOtrVm6BtYr9WGGQ4mjZy2HryR0rFvueRT7Xz
         U4aixScIqA8F6o8L80Ac84LX1DQQ7uMFucOCx5+vYFrSZfrKBJhJsNmvcQr+JyHUhx5E
         rzPA==
X-Gm-Message-State: AOJu0YypONi7zJ82G1uV4G52+i7u5II9qdR1BJv+QBbj3SMjUJi09Xg5
	DneUTvyq1a/IRWmPHNVutZ//r5J8rXcG/aBsP139CO2M2l9KyWVFWLV0oOjN0Dtfu7ORSmK0KFW
	b9rn2BQ9Tj6cTLDX3NmYVDoozR1M6qh3V
X-Google-Smtp-Source: AGHT+IEddp8f1pcDM+A+XBbfQ3qR7lQckcJQJU5SEbjHDBe9mW2JEaW+SasVs+pocbF3rLzURICRTuYx7M04rvaYBHI=
X-Received: by 2002:a17:907:c207:b0:a31:1179:199a with SMTP id
 ti7-20020a170907c20700b00a311179199amr191478ejc.3.1706143433122; Wed, 24 Jan
 2024 16:43:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115144538.12018-1-max@enpas.org> <20240115144538.12018-4-max@enpas.org>
In-Reply-To: <20240115144538.12018-4-max@enpas.org>
From: Roderick Colenbrander <thunderbird2k@gmail.com>
Date: Wed, 24 Jan 2024 16:43:41 -0800
Message-ID: <CAEc3jaDD76e+Lkwc8WSac30-kXBYKP6_R2+kM4+Z_RVOinD9Kg@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] HID: playstation: DS4: Don't fail on FW/HW version request
To: Max Staudt <max@enpas.org>
Cc: Roderick Colenbrander <roderick.colenbrander@sony.com>, Jiri Kosina <jikos@kernel.org>, 
	Benjamin Tissoires <benjamin.tissoires@redhat.com>, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 15, 2024 at 6:51=E2=80=AFAM Max Staudt <max@enpas.org> wrote:
>
> Some third-party controllers can't report firmware/hardware version.
>
> Unlike for the DualSense, the driver does not use these values for
> anything in the DualShock 4 case, but merely exposes them via sysfs.
> They will simply be 0x0.
>
> Signed-off-by: Max Staudt <max@enpas.org>
> ---
>  drivers/hid/hid-playstation.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/hid/hid-playstation.c b/drivers/hid/hid-playstation.=
c
> index 0a3c442af305..12321cae4416 100644
> --- a/drivers/hid/hid-playstation.c
> +++ b/drivers/hid/hid-playstation.c
> @@ -2561,7 +2561,7 @@ static struct ps_device *dualshock4_create(struct h=
id_device *hdev)
>         ret =3D dualshock4_get_firmware_info(ds4);
>         if (ret) {
>                 hid_err(hdev, "Failed to get firmware info from DualShock=
4\n");
> -               return ERR_PTR(ret);
> +               hid_err(hdev, "HW/FW version data in sysfs will be invali=
d.\n");
>         }
>
>         ret =3D ps_devices_list_add(ps_dev);
> --
> 2.39.2
>
>

This looks good. Perhaps could have been a hid_warn then, but err is
probably fine.

Roderick

