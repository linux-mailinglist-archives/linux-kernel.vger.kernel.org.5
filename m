Return-Path: <linux-kernel+bounces-139302-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEF338A0126
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CFAD1C24173
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 20:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1577181B88;
	Wed, 10 Apr 2024 20:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="H/RMv6Th"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0163B17B4FA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 20:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712780302; cv=none; b=ssZZkv4nBwRuvIOK0C9RcgiAoRiBruYWVyFTkRRtQhDyf4608kc1nmvGuKTqlD9X8YWzbMrtO0wWjCbP42nCDTjczA+QsaySizF82kVGL5OSx/1U/ROk+sDfK8fX6LYlSTFANeYvVV9wduy2MZ1k9tCI3OBmlJjdaArvQubwfKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712780302; c=relaxed/simple;
	bh=0QmAEO9gx6lEuCEFA6L/n80e1g8oAxeOfd6kHXLpqyA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tiP4TGrK9WMQMpJ/4/ffIfmO8B584e7qIYxVZeGBYDGg5zCoD8lIjtJc3RyVUfVEH6pMdW9C3vDBvPcoweN7qn4awkno1jwAisb9B6fmUoD3xjBStJg23m5boJAlspOWCSUfVGYOd7D1YZFxqwKUISTmDkk1KHhoF7vK1TFQo8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=H/RMv6Th; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d895e2c6efso42404991fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:18:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712780298; x=1713385098; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NrCW3DHTcZwfmublVXY2qPJR7NVLmg9fl0riAP8CR10=;
        b=H/RMv6Th/2sbroktS5xFRhDp4fYlAplzCRpQq1FkN3UkdLh0eUElCDulc7kXo0EuWv
         NrOX8wfmbCcNEMTil71D3joPJhux+Loxe96j1dPmjjWPYqhaX1cNz+8Qjs4yYW5le4Ld
         a+EPlfuRowOh7dSV+zVfCd7mWJxKY/ZQ4NTQ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712780298; x=1713385098;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NrCW3DHTcZwfmublVXY2qPJR7NVLmg9fl0riAP8CR10=;
        b=iiKK6GGFaFzQ2s7qKb4EQzrBp9QNfR6Bh7NQqU7GM7Je6glNIVcls5Sa29/gADRLiZ
         p9IxmFdyIMyTB529o5B4Mci6CJd2gdHDUDciTfKK9/h2HH5TZRuqymjB3LYaODEW4TMV
         wzicyqXFKf9Ub3cCBfWp/m9+WMjImpu3tqD8eO9rmPIgpJPhg7tn8Nzz0a1M2IhkhI6i
         YE1wDoe/Xnveupp4JNeUfQGIS0CIb6qKI8vgoCmoggQ4UqBwLh0VcLunA9tojfAK7Qth
         g0MK8FbfkAnWVaM0cuVV/NxNIoz2o41nt4gUMdgIpWKIyBx91BfTpGoZqhkwgJqztjzh
         MDaw==
X-Forwarded-Encrypted: i=1; AJvYcCXG3z0ZsEFBhNyYqWKFCBMgXoWFta9E+NSFLnr6Vip85AX4VVPAW18pZsV57Ya5bRvgLugSArNUXK1N73e8kqxQEjqyyuVslbmIdjX8
X-Gm-Message-State: AOJu0Yw49/BoB23Ak6Ld2DXDZ9OLHKStX0FMwI9tOIHyf6Te+i7cwkcs
	h+eIFInEueC/uWS/CdfgrJBX4aeJKHSsZldIkRkbmafsCt9Fz1dub/jd2iEMs0OB8J2A3OTwLeo
	MtdXfFw==
X-Google-Smtp-Source: AGHT+IHBeuzU2PNQqhW0GOwh3QaMGnE4JN5A8zeKN/3HgGFGUlNWqDtiV1d0RGxTrlCbOFBnb9Inyg==
X-Received: by 2002:a2e:7304:0:b0:2d8:68ad:1e87 with SMTP id o4-20020a2e7304000000b002d868ad1e87mr2640336ljc.18.1712780297861;
        Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id h1-20020a0564020e8100b005682a0e915fsm6767667eda.76.2024.04.10.13.18.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a51beae2f13so531215166b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:18:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVw/QciN6mOj2bUzZU+IApieJDZ8oX6YhbbyVNaqgUKu4Xp66DvPIcVTG4McXvBOdUwkcI6OOGbPkXZAA9H6ysPGoYzzvaZWuLuQ/ew
X-Received: by 2002:a17:907:b9d3:b0:a4d:f5d4:fb02 with SMTP id
 xa19-20020a170907b9d300b00a4df5d4fb02mr2295400ejc.51.1712780296715; Wed, 10
 Apr 2024 13:18:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
In-Reply-To: <CAJvTdKmK_U7nChpm=MzaDyw3T9V6hSua-6C89WCjo828vxm+yw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 10 Apr 2024 13:18:00 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
Message-ID: <CAHk-=wgaTzpJssX2z7OiQOLL0BZzHGAfJn0MYPhuN9oU0R2f-Q@mail.gmail.com>
Subject: Re: [GIT PULL] turbostat 2024.04.10
To: Len Brown <lenb@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 10 Apr 2024 at 06:24, Len Brown <lenb@kernel.org> wrote:
>
> Turbostat version 2024.04.10

Tssk. Things like this should still come in during the merge window
and preferably be in linux-next.

I have pulled this, since it's obviously just tooling (and the
maintainer file pattern update), but stil...

                Linus

