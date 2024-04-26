Return-Path: <linux-kernel+bounces-160486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8A68B3E1F
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:30:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D40681F284DB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B2B8181BAA;
	Fri, 26 Apr 2024 17:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="fBqviliE"
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFA5B181B9A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152216; cv=none; b=I7p3Mq3Qf5eBNLYCOXvy/NcAAakVHTWCMua4GFq5SlHBLwhBDKONvuXGjvk7wgql15V1gGuYQas1MEun/hGQ65LFSel1O7lX+S6e6bhiEG9wH72fyWSd9j2Q2WIxd7ZxxNkfOlSCQJnmo5RWycmkPPO6Cxa7lMfZRmq/nRcxA1U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152216; c=relaxed/simple;
	bh=DoeVH595qsmuQPIQOHZlMJzQnEWVUckuQY6sXPiNVxo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyWsQjTrJJTFgaHqquoSSkj2y0PK7llXSqV+LHTS9Hh/0If18eWK/XLPuB9K1sFttpbqIuzN5aZhNOZf3300F9TVBNSeea9t3NjzPiFCbUofe7Mx/oDB2v01qZnCw9L3eBq5l1fAGv/A/PELAwGWWNTUHTgHF3fGuzqMNvRIkXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=fBqviliE; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-43a8246b51dso3902901cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:23:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714152213; x=1714757013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BgXARGPALUa9HNkXZ7dJ4KGZjVGqNQ8BWrBEfj+sA+g=;
        b=fBqviliE2ur33q/zidQcPI+y1dcba0ss4jaVUAICPGmx0exFlJPLayfwsBtXJQstGP
         NgYLusF4EYISkZ1FmUpuVA/wVeTqhN0y9WSw2BUT/xsRaQEKrN7Lz1D02oEVM5eP6gae
         G09MM7bmqQjoFgVWSrcLsI8rTWTx0WZaAbvLQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714152213; x=1714757013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BgXARGPALUa9HNkXZ7dJ4KGZjVGqNQ8BWrBEfj+sA+g=;
        b=bKMQ2GQpOSh8c3abqeGZPq5aTmjbrRY+Wi0cGoXL11YoBoHAgEXBt1jshX0y1ZUNiO
         5tUKAqCLbq0dTV3vksGnBN3Y6BVY3ABztBuvB11upmXLsbjJ6HoC10To8/pK3Abkz1Mq
         jgIuEztc1i2y4DrKeSo7KLCfBl8DnhssDW5PSXOrrX84v1hOI2BTi9IVV0kCkMi67BPw
         V2pY63HMseYKuDQYl8Qv27ywoGV0iLDHhZ01D72T+s8BkxX3n/VeDvdI5nygYm3UDSd2
         ki93vU6/9bZqGRaOOoTLgSXpO8n3SD9OsDVs8TEti5v5U2h4j7VjwaA5n2r5b+jewESk
         NFtg==
X-Forwarded-Encrypted: i=1; AJvYcCVrtDGEtMeaq4jQFbYhLK4NG76sN29otJT1E5r1NgWRdSgTgeSPM0c881TfIuPmvrVT6i39ySnrBrcPTj+C4xMUBWcHEojvTPfG6J4t
X-Gm-Message-State: AOJu0YyvohHgmF3GDLdZgugC4SXya+wZdDFQkvAEQaManLlGPkkFu4RF
	V5O/ADN2Ean2MRLGrwLYa24P2lZH7acvFW/KegtTaaK+vYIpWPk6xltu/EI2dbRuqm0B2qEtCiA
	=
X-Google-Smtp-Source: AGHT+IFHJvPtmFzW16HTn4812iZDmRAOYaNB+mxVZwALXno+1DGmCqgziJTiiFucD+UU7VGAZfVCVg==
X-Received: by 2002:ac8:7f56:0:b0:439:9222:ca8b with SMTP id g22-20020ac87f56000000b004399222ca8bmr3813046qtk.63.1714152212730;
        Fri, 26 Apr 2024 10:23:32 -0700 (PDT)
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com. [209.85.160.178])
        by smtp.gmail.com with ESMTPSA id js7-20020a05622a808700b0043936ed09bfsm6592518qtb.27.2024.04.26.10.23.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Apr 2024 10:23:31 -0700 (PDT)
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-439b1c72676so24651cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:23:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCViNa4yTZT+yCqiFQ+ZptxFaHHjGmp5fyJ9VJEe7gJ00fTAfFUBMN4OePJunCBkql0In0tcE2VF1AbkkEbvfhUezeMNzYH++YVmHR4k
X-Received: by 2002:ac8:7493:0:b0:439:891f:bbd2 with SMTP id
 v19-20020ac87493000000b00439891fbbd2mr373509qtq.28.1714152211256; Fri, 26 Apr
 2024 10:23:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240426155801.25277-1-johan+linaro@kernel.org>
In-Reply-To: <20240426155801.25277-1-johan+linaro@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 26 Apr 2024 10:23:15 -0700
X-Gmail-Original-Message-ID: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
Message-ID: <CAD=FV=V-pG9+5fLonNvydmjS=ziUFUHAyF8T7YTkEHiO405aSA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: qca: generalise device address check
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Janaki Ramaiah Thota <quic_janathot@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Apr 26, 2024 at 9:00=E2=80=AFAM Johan Hovold <johan+linaro@kernel.o=
rg> wrote:
>
> The default device address apparently comes from the NVM configuration
> file and can differ quite a bit.
>
> Store the default address when parsing the configuration file and use it
> to determine whether the controller has been provisioned with an
> address.
>
> This makes sure that devices without a unique address start as
> unconfigured unless a valid address has been provided in the devicetree.
>
> Fixes: 00567f70051a ("Bluetooth: qca: fix invalid device address check")
> Cc: stable@vger.kernel.org      # 6.5
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Janaki Ramaiah Thota <quic_janathot@quicinc.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
>  drivers/bluetooth/btqca.c | 21 ++++++++++++---------
>  drivers/bluetooth/btqca.h |  2 ++
>  2 files changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
> index cfa71708397b..d7a6738e4691 100644
> --- a/drivers/bluetooth/btqca.c
> +++ b/drivers/bluetooth/btqca.c
> @@ -15,9 +15,6 @@
>
>  #define VERSION "0.1"
>
> -#define QCA_BDADDR_DEFAULT (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x00,=
 0x00 }})
> -#define QCA_BDADDR_WCN3991 (&(bdaddr_t) {{ 0xad, 0x5a, 0x00, 0x00, 0x98,=
 0x39 }})
> -
>  int qca_read_soc_version(struct hci_dev *hdev, struct qca_btsoc_version =
*ver,
>                          enum qca_btsoc_type soc_type)
>  {
> @@ -351,6 +348,11 @@ static void qca_tlv_check_data(struct hci_dev *hdev,
>
>                         /* Update NVM tags as needed */
>                         switch (tag_id) {
> +                       case EDL_TAG_ID_BD_ADDR:
> +                               if (tag_len !=3D sizeof(bdaddr_t))
> +                                       break;
> +                               memcpy(&config->bdaddr, tlv_nvm->data, si=
zeof(bdaddr_t));
> +                               break;
>                         case EDL_TAG_ID_HCI:

nit: blank line after "break" ?

Also note that on my firmware I never see this tag and thus your patch
breaks trogdor. Specifically I put a printout here and it never gets
hit.

I printed all the tags/lengths:

[   17.961087] DOUG: id 0xde02, len 0x0010
[   17.965081] DOUG: id 0x0000, len 0x0000
[   17.969050] DOUG: id 0x0000, len 0x0011
[   17.973025] DOUG: id 0x0000, len 0x0a00
[   17.976991] DOUG: id 0x0303, len 0x0303
[   17.981066] DOUG: id 0x0033, len 0x1001

Probably EDL_TAG_ID_BD_ADDR should have been 0xde02, not just 2.
..but then the size is wrong? When I print out the bytes in ID 0xde02
I see the address you're looking for 4 bytes in...

[   17.663602] DOUG: 0x00
[   17.666132] DOUG: 0x00
[   17.668638] DOUG: 0x00
[   17.671237] DOUG: 0x00
[   17.673689] DOUG: 0xad
[   17.676120] DOUG: 0x5a
[   17.678551] DOUG: 0x00
[   17.680980] DOUG: 0x00
[   17.683409] DOUG: 0x98
[   17.685846] DOUG: 0x39
[   17.688278] DOUG: 0x08
[   17.690704] DOUG: 0x00
[   17.693137] DOUG: 0x08
[   17.693139] DOUG: 0x00
[   17.693139] DOUG: 0x00
[   17.693140] DOUG: 0x00


> @@ -624,6 +626,9 @@ static int qca_check_bdaddr(struct hci_dev *hdev)
>         if (bacmp(&hdev->public_addr, BDADDR_ANY))
>                 return 0;
>
> +       if (!bacmp(&config->bdaddr, BDADDR_ANY))
> +               return 0;

The above test feels non-obvious enough to deserve a comment. Could
you add one? That would also help alleviate my confusion since I
_think_ your if test is unneeded and maybe wrong? Let's say that the
firmware didn't have a default address stored in it. It still seems
like we could try to read the address and then if the firmware gave
back BDADDR_ANY (0) we should set the `HCI_QUIRK_USE_BDADDR_PROPERTY`
property, right?

