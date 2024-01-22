Return-Path: <linux-kernel+bounces-32910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC8BD8361CB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3EE32934B3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAE43D3B8;
	Mon, 22 Jan 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WMrHQv8z"
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAC94776B;
	Mon, 22 Jan 2024 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922513; cv=none; b=IRKNQFApo05PYVgESUaRElV+4UhSKGu2Jl1dl5+XqB2GJFR6DMQpq6Ep6/UKoajzkQjQOQijLNSdIgr7rrz30iNR+AkcaqMsp/9gna/Yh8XfWTZC9QFiiSXCWiVJUa8NXXTDGNCxjzpJEEXkiR7lQe0ej+5snNUvljJ2pp7+Oo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922513; c=relaxed/simple;
	bh=Aoa2uD6JhnOWVhqPLVHgP+kBp2d3drpGdH+IsOITYSQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PDTtodwYEZ3okafor2qeDHQjGbxZw3MkR/l21P5RYYpb6AcQwOcvf8aDJ80vsMpUzctAcA7bR4HuwqC5vR9Fhlg+SexnycCdmxyTlJu6hE5a4BB1AYqnabCmm0fchZjYQUcpbqtdlPGxHzKdI2IUV1GWU9xSP3kvftIyfoE+q5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WMrHQv8z; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-5fc2e997804so25452057b3.3;
        Mon, 22 Jan 2024 03:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705922511; x=1706527311; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Aoa2uD6JhnOWVhqPLVHgP+kBp2d3drpGdH+IsOITYSQ=;
        b=WMrHQv8zwFo3Dvox9r3jp13jSM8o1d0aRYSjxjukF9d863tT1x1PS6CZMYSDofoWKb
         DNjFpGJfj4++YgUKCmGY+4dNykQKYRYMeIJqAhaDX4i/1YyP0WD3jr/uZzNhHEkrxGMi
         A6VtFYkweLyuONStIr3feIWV/QOt5/Mm24tJBzvXKN1esXdgV9vTBLcJSF5yvOR4BRuE
         wW74f/AlmrwcB9BRzZHtWGJgwLIgOs3V7xZmWZINqgYA+u8KQSUtueHU72AfZngOJdot
         XJg3cqWhukQ86nuIQQTnpe82R1tzHDk78kDj9Z3L4W/ZMYacY62gWSTofz6PltzgBjjT
         S81Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922511; x=1706527311;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Aoa2uD6JhnOWVhqPLVHgP+kBp2d3drpGdH+IsOITYSQ=;
        b=O4nHF3835SjN87MwowKDJCIz2VfSvxwlcMCMlb4bu6zGvIO7D0PA7vsrtW8W6A38hk
         /rGtPFy1ps04IBOmVha0JKs4+yR0FELT4GKwQUTkbkTCTM2+k7t6R/niVTGeH3kUOSS1
         9JOQBxmaw+Xufvuf2sQZdmdy98nbdiZp7F1DOO/MQQeW9DPtpOcoMWnWTsVRN/jS/sQv
         Ts+8pGhWKa/Q+5LdbZU1b7wRY3c/7vCotN6M0deefIUu5Map5ZZUwwvOEMi1Mll3LAN0
         xR0wQfzeESGJX+/2Z1JMklzWPqbjYDjgaZAtjfuEcPdq1uNpRggPiUbOvYx928CK3/uy
         T9yQ==
X-Gm-Message-State: AOJu0Ywohywwu7aVjDgs/JgXi9/GKApYtNpfjcKGvL4iv+rC+IJJ2mUD
	wU7seCHIub89Z47pIswIEBHBhtceYwTx4wwcCF2MaQsIQSrK4ERtimdvjk2BO/DCjoUJkIUl62A
	usPgICsqFM7qRhhX19oJKU4zFTA==
X-Google-Smtp-Source: AGHT+IF3tNBm3AaqbWBH2APl+K+A1l2FMfhzy88eG1EvSwkSOyNPO716qqkCrAEbgCBTWnAKulQ6FYnzhC/hyyHotkE=
X-Received: by 2002:a81:5384:0:b0:5ff:617e:6edf with SMTP id
 h126-20020a815384000000b005ff617e6edfmr2939801ywb.34.1705922511434; Mon, 22
 Jan 2024 03:21:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240122092338.25047-2-rsalvaterra@gmail.com> <0b6f3998-135f-4059-a8a8-e924281353f8@linux.intel.com>
In-Reply-To: <0b6f3998-135f-4059-a8a8-e924281353f8@linux.intel.com>
From: Rui Salvaterra <rsalvaterra@gmail.com>
Date: Mon, 22 Jan 2024 11:21:40 +0000
Message-ID: <CALjTZvZoH-+yZz5Z7237rhM5BxknFbG_Bt-dkperpgfLKfcAuQ@mail.gmail.com>
Subject: Re: [PATCH] ALSA: hda: Increase default bdl_pos_adj for Apollo Lake
To: =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= <amadeuszx.slawinski@linux.intel.com>
Cc: tiwai@suse.com, linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, Amadeusz,

On Mon, 22 Jan 2024 at 11:05, Amadeusz S=C5=82awi=C5=84ski
<amadeuszx.slawinski@linux.intel.com> wrote:
>

[snipped]

> And seems like I've missed some IDs, when doing PCI IDs conversion.
> Anyway, can you use PCI_DEVICE_ID_INTEL_HDA_APL instead of 0x5a98 as it
> is self describing (no need for comment)?

Oh, of course! I would have done it if I knew we had those constants define=
d. :)

> And if you want more patches in kernel - convert first 0x0f04 & 0x2284
> to PCI_DEVICE_ID_INTEL_HDA_BYT & PCI_DEVICE_ID_INTEL_HDA_BSW and then do
> the above change ;)

Killing magic numbers is always a worthwhile goal. Expect a two-patch
series soon, then. ;)

Cheers,
Rui

