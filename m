Return-Path: <linux-kernel+bounces-154877-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 556D88AE25E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0FCBA281EBA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25125FEE6;
	Tue, 23 Apr 2024 10:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GgmNbMeh"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED18D527;
	Tue, 23 Apr 2024 10:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868633; cv=none; b=cx1OdcQMtFiJTLXAoSpTvV5qEo3sWEP1a9nDWqSMPteQs2eLdu6AW3RtYGRrZz2M3WfgGrts9UkA3YLQy/RMpvIdsh5bCwf8RVah+giBfdBkT7jgVloRd/qcbS7NWt1D2KQsNZKawzUZbXwYjdEesuOQHoShYiCrBv6AQ+WjeV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868633; c=relaxed/simple;
	bh=oQzpIetGYEjpNjrW802xBPkO5SLHFUj/yYs7N+iAehQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O4B2U1AsZW1PuHGoVXj2xr2kppxwOrF1SBZ8QzPFtb/qs7alSLkT/6u/Gnqfd9jqkalrGqBQk27Rp5/PDaID/SiYZrsIul/IYZjJr7XwSFgUWGFhXlWMDtP0lF/QUrAby8QRXg1vGwm5iO5ErcfKk0Cv/Gin5X9L8yDM3ut22Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GgmNbMeh; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so11169375a12.1;
        Tue, 23 Apr 2024 03:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713868630; x=1714473430; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4t1dFtTzt1DbzNhCtENme26b4OP2uWZCLOXLsBPkGec=;
        b=GgmNbMehz+cIWYTcQ3+6arKep19Ybg3PE5+pcwnnGE1VQsw88KGdYpL4sBpNFxT50W
         QyjuwBCfLxxH04mO6XiSxGL8vyPwuk4B7u9b6QOylItdNVy0LKVu25CFQ5ep5QwX06Jz
         8QUxzRlsucxq2SBwi/9SwsjmbA7AthccV2iLu8w9izCEYNs4mNRTpaj028OOOMx8vPei
         tHEgBdaeDm9dOM5s8aDB+5KL/QVRmVkOd+Bqc2f7xWr8wd4VWss6HiJP+msXMV6Wnrzc
         357wobya0E2Pe83VsoKx8Gw1b9f3xuVErLb72dD1b4PP10joqHcuJFm0LgnXRwaDJMsz
         UxIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713868630; x=1714473430;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4t1dFtTzt1DbzNhCtENme26b4OP2uWZCLOXLsBPkGec=;
        b=AwpCquO4dSiTlR5f4v5t74Ws2DOwuHr6svUFEk5fMxr5dN1ufPkbBJSxI+2C7d6Jts
         Q8krXdrTRQa8UY/Qb87gbhsRc7caa/L1eryqZNsHCQ6xnXeEZay+UtFDlNwBojitrS2H
         XlHAorK+K4sRigIMqGaMRxBpcQV7iUgCPs7O3ZpD4hrNdufz81RTRSHAYesAfCox9VX4
         v815Un4NFrP8D4xx/6EAFcgFIk/b/Q7fM3gbHh34tqhk+6eVpf1p6cJnSx8+PRR8PASU
         cSeOXbxXngiIlBcnTyc6UGYUKMdll0kEsldt8WfeL/izziG1NY8zocGnDEDPtB+cFv2h
         N3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCVXUXfjY06M92p69G8GHgjuDCAIUJK2tJ4kRA+3epZa2utrI0oRgfHxPmzlult/JVYb2xyDGDGPTwv/UbtTL6IxTPhDEkraVElmHVnrFF09BTkoCGpzN6YYTq7n6iieZetCcqMD5vUc/Ea8
X-Gm-Message-State: AOJu0Yys51WreYfyXCqftjjyfDUDRKAo42SAyjF8TefcO4GFHNbK2E1q
	kM81wGWWuzm6dMMn3dwdrI+JtCvE0GYtHdk1kMLs1e8NgaCjIvFjyjwgmiAzb1RW/eqMa5NCE/Z
	chZeZc9WQ72sFJr0ClzKqzgDezKM=
X-Google-Smtp-Source: AGHT+IHeyR5nQGBgo5SeYHczmWihZE3aKnPx7Y4MP1/SAb+Xn/Xtqgb6/Zfv88R3JRQyVZHsNuV7z2K57QLyYdhJ60g=
X-Received: by 2002:a17:906:a2cf:b0:a55:75f7:42fb with SMTP id
 by15-20020a170906a2cf00b00a5575f742fbmr2425875ejb.24.1713868629805; Tue, 23
 Apr 2024 03:37:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240409154253.3043822-1-hugo@hugovil.com> <20240409154253.3043822-4-hugo@hugovil.com>
 <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
In-Reply-To: <CAMuHMdVq=rf-6o485KiA+zcwJPHMe5STKUtSWtFPs2nmvshu-A@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 23 Apr 2024 13:36:33 +0300
Message-ID: <CAHp75Vfi2YjE0wzwABURxXhcWLozAf9Cdj_pT+DL_tm8E_zm4Q@mail.gmail.com>
Subject: Re: [PATCH v4 3/5] serial: sc16is7xx: split into core and I2C/SPI
 parts (core)
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Hugo Villeneuve <hugo@hugovil.com>, gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	peterz@infradead.org, mingo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, Hugo Villeneuve <hvilleneuve@dimonoff.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 1:01=E2=80=AFPM Geert Uytterhoeven <geert@linux-m68=
k.org> wrote:
> On Tue, Apr 9, 2024 at 5:48=E2=80=AFPM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:

..

> So if SPI_MASTER or I2C is enabled, the corresponding SERIAL_SC16IS7XX_*
> subdriver can no longer be disabled?  According to
> https://lore.kernel.org/all/20240403123501.8ef5c99f65a40ca2c10f635a@hugov=
il.com/
> you did want to support that?

I believe it has been taken from one of the IIO drivers as an example.

--=20
With Best Regards,
Andy Shevchenko

