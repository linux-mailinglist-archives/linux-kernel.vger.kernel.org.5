Return-Path: <linux-kernel+bounces-130785-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7BA897D13
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 991FAB2A43A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 837B73FC2;
	Thu,  4 Apr 2024 00:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q+T8USfc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC1AED9
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190642; cv=none; b=KMl5PBpqmNsA0n8V0ai0c2ucB3ViMmPT1MCkxIPzGG83r0c1XIUM2npa+ugVUgfXehduQtUaOkxN9VikfTj7cpiEmG2laJoWPrddPx90x53wdHu6Gjw4ZJuk8jR/Od+yzsuXs3hEX8pdcA8GU/WyY4yfb3YmDz6bIvM7gAOCPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190642; c=relaxed/simple;
	bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RD+gzP3vJmwufI5OjcGl3RQtXMgqN18INL4PQu8LkIW8WAoobiTdwe8TvGHoEdTD1lv6uWFgbAUqkGCLqnKnpPRxu1toaLTjj8fpTABUBR69bWnog6HDwoX2K3y0ehhKn70gS5ToDuRqIcvVRKIvreGF7wIytxQeRBw75t6b+XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q+T8USfc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a4a3a5e47baso56940566b.2
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:30:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712190640; x=1712795440; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
        b=q+T8USfcIzKVt9BRYiKiuBOMurJkeMh0tPA/aEZl0enNuiegoAE35IjXJTmZ4AOpg2
         Lq4us65KFtCSug3LNjqsUDUB4ho5n/s6+sw78/bAm1NAYaxKuFzgo8yxUKWVIuzDltzj
         Aqds5cb7HY6e/G7BaBPOPl/NXjCIcTleqr8jLc//9sQyqL6kt4gzrs4pG1WB4n+Z1B/J
         9gOpH0rg6WQdp5ewsGKN1tyJE6HnQyYJ2dqMJy0CToOBu2ZcqPS0KnlqksmLolupMkDd
         J9/utlh6oK+a9PgtBZrc0u0mMqdO9J5N+oemv4VNvlWbd6MaXA0u907mK7MwRPJAedVV
         TtgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190640; x=1712795440;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=88Ifa5H3Ihdm6IuostTrtWxwBYQjqmSznZPdhj62PH0=;
        b=lB02Cb9CfDPCwvIPZ3ROSp1oAVmRNTO8D/c7L+kvqIPdQ5xkm/3vpol4hBP5hUvvTg
         RXIc2e7APB3Wt79i+Eou65MAAbebESZSndm4QhXiHqwTZ0S5iHRK7tZ+fksfMduFih2o
         osl3ysQ0xICoFRNzv3x+9PhmRPnXqu336taI0IUL4ape1vfThPLGMN/SmIWxaiJguYXA
         HrYKFJbj8suaXy3Wcu2eLXGNSm0UK61BjU6hdKQ/d0nlbeGbM5PxZczfL5BnBA3Vg5wZ
         bSe5BQ3RkQTMVBgdJEE9Bti5OE7pmZmIBgBJKH/2HcMNwV2BMymM9bB7b3Xw5aEYVTac
         sP8g==
X-Gm-Message-State: AOJu0YySuP0Z+A3vauPa4ZUpu4FvTWEsGlcOmD5UM1vJ8prFFhZe34Tf
	GiALsnNicF5A7OvDyaS6ZNJM+mVFJAIk67qZjp1Sqhzw9LMUH81tAu0v7TtB+TibhPDlC5WjABC
	dMoelcz7PU+I1eL5uXLL2qTReJs5+5fEpMC5Y7PWYth9AvS5/Wi8Y
X-Google-Smtp-Source: AGHT+IESNjdr4a4gdpIYRZZ7Qr0id7EJcDqGHA05AFboVyKymcEeQXtSdxUj/aCQK9jv0eVPF3hXLXn24Uu+txJEVgg=
X-Received: by 2002:a17:907:b9cc:b0:a47:34b2:ca4b with SMTP id
 xa12-20020a170907b9cc00b00a4734b2ca4bmr667908ejc.50.1712190639593; Wed, 03
 Apr 2024 17:30:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-strncpy-fs-squashfs-namei-c-v1-1-5c7bcbbeb675@google.com>
 <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
In-Reply-To: <594a6365-5cc6-4778-aec5-c5ad2a4b2930@squashfs.org.uk>
From: Justin Stitt <justinstitt@google.com>
Date: Wed, 3 Apr 2024 17:30:26 -0700
Message-ID: <CAFhGd8pCE11Xm219Pc8uyJnsDkSqaTM6gpY8Tpa2fWmHg4OnCA@mail.gmail.com>
Subject: Re: [PATCH] Squashfs: replace deprecated strncpy with strscpy
To: Phillip Lougher <phillip@squashfs.org.uk>
Cc: linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 3, 2024 at 12:32=E2=80=AFPM Phillip Lougher <phillip@squashfs.o=
rg.uk> wrote:
> A better way to remove the strncpy() is to remove the unnecessary string
> copy, which I have done in this patch here:

Great! Cleaning up this code while removing strncpy() is a two for one.

