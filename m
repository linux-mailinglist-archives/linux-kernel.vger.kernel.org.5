Return-Path: <linux-kernel+bounces-123049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A082890178
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EAAD71F22B3D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:17:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD31182D70;
	Thu, 28 Mar 2024 14:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/+o88us"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BF0E7EF07;
	Thu, 28 Mar 2024 14:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635462; cv=none; b=OenAjwJr1P/P8WzwAWShg/EVx2JU43lXQYHLa7Oqkw/Cb2yaemBjmzvA63jJDnbtGo2IKntEint98yo03Ven9pnRKVBe76zg6KyCFvyVyuGUkpnAxSirz8dMc9b/u5AZuavOJCPIfsP23DURDIIv/Qe4U0oGUnK3CN5Q9i++Brg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635462; c=relaxed/simple;
	bh=n+PGg8BqCmm7RHfRWbZq5wCNp0jW9v34CnTVjKfYlC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uo/r8twtXhN9qRa+94xy5p0bv8kXy2wBy9f1CQmWQz3ud8h61qUu7OpAHRoo7LP8M9LJYapX4CLsTRCCECv/FA6vpdI1HecN9IMu/Up8P5c2HTfO9W/GzTwoR+VXrevXWSWZ0GIxidWoAyUZeLzVze8NOAxISX41dW+NTnS//BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/+o88us; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d6c220a377so11806821fa.2;
        Thu, 28 Mar 2024 07:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711635459; x=1712240259; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tn0C7+0Dm66YuO/qUxNuddwmkSFDulHFNrQ8bvWigCE=;
        b=l/+o88usMI4a38t3f9Sqq0ObG+E/zNMwieGioHzvEIsCP8iRqJG99m5jvMBGOaNsEK
         Vt4wIhddRdvB3+f/N/V7lPRS7gapR7goFoZuXTjHdtWO1pQvNlyU+XwWQESzx2gxxhZ8
         NVsnsFAmghLwA+KMl0mizhQ9NLVu1FJkMz/nImm2RMJiAfBhwLugWM8RPh5Zfi9c6vkS
         lPtfBWZoACVTQG/I4R4Pzcn3B+a7YGXPxzr78LWfa3akd/KtmMZbJHQs95kRUAbxwXOP
         LhA2Irdowm18xRZsHrgjQUQP442woNfwFcg0bLPcao59lfG7X/vy2Pf3IOrineTbqXbl
         w5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711635459; x=1712240259;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tn0C7+0Dm66YuO/qUxNuddwmkSFDulHFNrQ8bvWigCE=;
        b=NUfhhD5YPW0h+Lyg/wg+EJcCZZI7uwFb+onhi8uHUmZjmIypTgNEL8nAk989UOR9Co
         V22mPqAPVNBUQ72Dp4DikmMKcG8cvQzQlhk7Qs2L//sF+7ueudo5Y0TFzYrqK76UZyvH
         xH/+QnlBnFQcarD21pMPeHFUt/CF6T5x59i42EttjWN/DJ0ahhVg04rMszfFtGorKD4H
         HZth+DXRqXm9CjDhNcgPHNBQpqLDPmh8UbbmAWimkU38NaSbgvmzdmekLVTfr1RJB/G2
         LyWEMhEgJov3vuqBQ4/iouMOpx3lHq417/shBy5PG65Qj7/2xXBJqk3ExVdg2HC7kgQd
         udaA==
X-Forwarded-Encrypted: i=1; AJvYcCVIPo0R4YOmUw6ESpkC76L19NZB+/c+rQAG53izPpL2fZ/v5CmQK+8kFrHne+Es3TmhNpKhPOUiq4HuDrx+eb0wqgoFdW23cpjCNmNNRyIFkz1az0xGgtwoVuqZUVnct3cGKP7J85B0aAZUfUk+
X-Gm-Message-State: AOJu0YxWQHkZexLgzxWRVwCbM2hEX6q7itCv60lGPAv9F/xjrD3O+Tl8
	JiT2y7NuwVxbGtPopSIcyKSAoqIMc5efkl1pDJrVJLi7hqf/Z3gtCkSxjrDuAIP68cLTXwa1AlE
	5QRh3cN0m6Qn/lyZQWKnqM2VUooh0o6Q9
X-Google-Smtp-Source: AGHT+IF9RgSMBn1jMvbbpAH4gobDT7p8gPgmkWaLNdCLjLPnpVDaxfXnU4EvB3/smhjaVlgBQPExOQfUO666rfvZrUs=
X-Received: by 2002:a2e:9cc6:0:b0:2d6:dba1:6d37 with SMTP id
 g6-20020a2e9cc6000000b002d6dba16d37mr2454605ljj.11.1711635458286; Thu, 28 Mar
 2024 07:17:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328131800.63328-1-wse@tuxedocomputers.com>
In-Reply-To: <20240328131800.63328-1-wse@tuxedocomputers.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 28 Mar 2024 10:17:25 -0400
Message-ID: <CABBYNZ+OaJ9QVE_KmBNL8QbBv4r5erL57u3BzFv0AnmUzY=PTA@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: btintel: Add devices to HCI_QUIRK_BROKEN_LE_CODED
To: Werner Sembach <wse@tuxedocomputers.com>
Cc: Marcel Holtmann <marcel@holtmann.org>, Christoffer Sandberg <cs@tuxedo.de>, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Werner,

On Thu, Mar 28, 2024 at 9:18=E2=80=AFAM Werner Sembach <wse@tuxedocomputers=
com> wrote:
>
> From: Christoffer Sandberg <cs@tuxedo.de>
>
> For HW variants 0x17, 0x18 and 0x19 LE Coded PHY causes scan and
> connection issues when enabled. This patch disables it through
> the existing quirk.
>
> Signed-off-by: Christoffer Sandberg <cs@tuxedo.de>
> Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
> Cc: <stable@vger.kernel.org>
> ---
>  drivers/bluetooth/btintel.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
> index cdc5c08824a0a..6dbfb74d0adf9 100644
> --- a/drivers/bluetooth/btintel.c
> +++ b/drivers/bluetooth/btintel.c
> @@ -2881,6 +2881,8 @@ static int btintel_setup_combined(struct hci_dev *h=
dev)
>         case 0x17:
>         case 0x18:
>         case 0x19:
> +               /* 0x17, 0x18 and 0x19 have issues when LE Coded PHY is e=
nabled */
> +               set_bit(HCI_QUIRK_BROKEN_LE_CODED, &hdev->quirks);

If it is just these 3 then we are missing a break here.

>         case 0x1b:
>         case 0x1c:
>                 /* Display version information of TLV type */
> --
> 2.34.1
>


--=20
Luiz Augusto von Dentz

