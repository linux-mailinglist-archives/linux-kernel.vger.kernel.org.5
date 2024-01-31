Return-Path: <linux-kernel+bounces-47385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A07B8844D25
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 00:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D39681C210DD
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 23:42:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F3F3F8D6;
	Wed, 31 Jan 2024 23:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HZWmy43i"
Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FADC3F8C2
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 23:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706744189; cv=none; b=bWqMwNAb66u7pTJIjtnWi5YtjZFgnx9HRzUJCqpNlmRcVd6NdqA+8b73W0LD1sVABzAh3N8JmmDxjfRXZA8ZU2KsNCJOPZDf5qM5fTWzwLRbec6j8thebidXMPv7UCELSKteIGoRN6AhQt8WJJHvnnPJUyNq8j+ZIOpMdPVG7qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706744189; c=relaxed/simple;
	bh=u6w7iyMIHztAkgzB8Z5P9Y8ogonBdwbRa2zrhuDMRjY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cOfd/EQgRTvkxwUxvUlC20VQOTu/5D0lA1gKbF9q5mIazC/AEil0/BG4x7apH5AA8QHnRRBzpw9JKJoJ/kAvXlhg5BbKbbZ69+UKGSXF9QCcObimjrX4NO/QA32va0TBYyX1CUQhryTX8o/CuJfzrdfO1LxJWJ5jLL3pwbIIaZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HZWmy43i; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-7bc332d49f6so15695339f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 15:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706744187; x=1707348987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u6w7iyMIHztAkgzB8Z5P9Y8ogonBdwbRa2zrhuDMRjY=;
        b=HZWmy43isy9cSOq470cw5wsY5ETvIxAzmQ3YZZ1Uyyq8viChFV7WkvWGosZhQsUIXE
         m8FJLcJCAYJedqFj7PFbCHrT8Ublab8ZyNBVV9P9xOu5MUA+mVBfYslzptIQYMeiDlr8
         39RpjOtM7wqrsx10dVFt3No5opR5tK6VX0d0nNqFJSI1TBkoc9YSjeteoDk3nm7M9/KH
         PHHYoyK46GoDo+a42cWK/FTVW+RYaISYeL/eCeGl1ICJm1OKQWMw7xpyoP4VVL4Q8jfl
         kRMfozyNgHb2C+ivOLK7IWkRWOQxhndWG7pYa08EDmON2yB2kYsGheelw4p6S1sq7fcd
         1NdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706744187; x=1707348987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u6w7iyMIHztAkgzB8Z5P9Y8ogonBdwbRa2zrhuDMRjY=;
        b=M01F+UwK1UndlnYRHIYVGOjaRUDZP1j+npLuJyTXackaLTbdtRBk1z38RznspaYOR/
         Vq5rj2DdIDeC53mU0iJejNhnIYunRYR/26kLY3Wlb6fN1o1VwvNsm1fE2xvg5DT63DMy
         a+NKPYu+7lZQW9NW1+RNBeUzz/dLGJXdMADJ1wlGXv9B16d/6wZSV7W6WACLw6kAH0qt
         hC8gHfhKqvMUJNDKK+zWTvCR65KEpvaqbAUZUTDXqGrLtrD67lnjmTtTJflbk7JTRSDr
         EdlVtt2Bv2kFvsbYUltZE8EJXlioE/BtZSjQqCQgCHJtp6eR+xebXdG82XV3kRN6JCaJ
         ot1A==
X-Gm-Message-State: AOJu0YwZSri5XYCLHvAp85xBMIqbDi7Tw2zD4IJA5qNA+oA4WUPvwDYD
	SF7QDEIodWVbBOjkD4G2nKEccNlxJ7oX9QLre//kF2nCkyT0dl7mhHfCSkMqblKUFQ0UzWSl15s
	KLUkTNLMXTFOigHdEo2S2YZbgsC8=
X-Google-Smtp-Source: AGHT+IHd51jinF+TJrsQby6mj1+/NfzQkYdIZv716MNw8o+wEXnu0PS1Rzz+mumnUkGcoPzkMCbMGyWxwe2HhrCUpXk=
X-Received: by 2002:a05:6602:21d0:b0:7bf:5157:e7dd with SMTP id
 c16-20020a05660221d000b007bf5157e7ddmr3537861ioc.3.1706744187165; Wed, 31 Jan
 2024 15:36:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130014208.565554-1-hannes@cmpxchg.org> <20240130014208.565554-20-hannes@cmpxchg.org>
In-Reply-To: <20240130014208.565554-20-hannes@cmpxchg.org>
From: Nhat Pham <nphamcs@gmail.com>
Date: Wed, 31 Jan 2024 15:36:16 -0800
Message-ID: <CAKEwX=P-Awzpy_xQaGRMUa-s_c0V+KfN2j1sYKPBt6NBRZTjDQ@mail.gmail.com>
Subject: Re: [PATCH 19/20] mm: zswap: function ordering: writeback
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Yosry Ahmed <yosryahmed@google.com>, 
	Chengming Zhou <zhouchengming@bytedance.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 5:42=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> Shrinking needs writeback. Naturally, move the writeback code above
> the shrinking code. Delete the forward decl.

Honestly, do we even need a separate section haha. Writeback and
shrink are used interchangeably in my head - they're the same
category.

>
> Signed-off-by: Johannes Weiner <hannes@cmpxchg.org>

Anyway:
Reviewed-by: Nhat Pham <nphamcs@gmail.com>

