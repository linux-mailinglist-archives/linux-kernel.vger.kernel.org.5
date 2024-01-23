Return-Path: <linux-kernel+bounces-35792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4A08396A3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:42:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD221C20A81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 17:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3BE8003F;
	Tue, 23 Jan 2024 17:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CEMifkmo"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0348480036;
	Tue, 23 Jan 2024 17:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706031732; cv=none; b=TqYKwRlEh6//7Bqxpp5aghbAmaKgawpnVu+epSuqaTa3GEBYqgRLwmCr6Cd+Hm0rwRbzZkqldl7DyFX2W5lxfYvXCODBPvvtGICwuSo3davxKJmFRACWQ00dw7kSd+EPNHvhQ8QUEw4KSum2B75CZG8/FuS8fRmPvkEE+PlgPbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706031732; c=relaxed/simple;
	bh=eax/EtDLlyAHvmuizexdFChDdC8AlZ8nFb8XRqzXxHs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Xrctk2bmUZ63bvlDLdYeWaDWp2sUZ9LT51uqXajonvHq9J0dmQopXFWUrjBcYSOLJaHGQdcZ4f1bOwg/8kw8ITmTcmP74q4i2eszKziOkUIGHrLIYS8R8bSHRzw6jvcSf9R60sREcPDdxsCVC925PYoM6xKlwKYHXT5D6XfMQZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CEMifkmo; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40e5afc18f5so50267215e9.3;
        Tue, 23 Jan 2024 09:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706031729; x=1706636529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eax/EtDLlyAHvmuizexdFChDdC8AlZ8nFb8XRqzXxHs=;
        b=CEMifkmo4FCQ/Vn3t+0B/W+urlc8MbwOkt4llWhR4ffkxVySTlYhHR3evMYbLlnH2Z
         wfeFqOalty7b8zRbgYSBTz1nQ9aAb8EZxkZqwezy9zEfKwbzwefCOYaY/aN0qlxr7HGG
         v8AxsOVsPprgjJPQrnUuGsreIg/jkYRyIaeiwHMht77NPQw7PdMqoOW3heTaYrj4U0eu
         7kNPzNvCAMmZPUY25yTOyT4C6XU5cmxY5g2TIKK4HVswlXd9QDRRJXZWRhGr4zIwtI2r
         mF1Zs1jn/g3U85NdzYT/NqmovrgbalSBfxgzsAdb0XC4MYlp7o2aVQKQByUinEmLtFJl
         qeCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706031729; x=1706636529;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eax/EtDLlyAHvmuizexdFChDdC8AlZ8nFb8XRqzXxHs=;
        b=cR6dxo0gzgAByk6mK/Mzv7ldtmVSzM7cnt1/bBI6TlCZ5F4U1Sscj0zcx+EpoHKsVE
         12ESmUKmikMgkLHk5zvPjh/IjMmweYJv4odIpG8ASpmQ4krIA2IGko+o9TZWqFHCOZEG
         nfO6AfUeUjb3dBQEgcqhaAwML6xlCg7dDKjgRQ4GIdoS6pqevAKDeq6owKH9pgcP1FPo
         ZeBSeXyQ0lqU5mttUd7VP4Pr+nkXLE9OtY4EuWnZBb3D6Pt5ufHkIqwCUqmVHCX6/XLF
         flVeaexJ/fpLYAX5kOpKzbq/in0csPrZCpV0TJmkDrWuwABcEesU4T5vqu/xN792tcue
         pvPQ==
X-Gm-Message-State: AOJu0Yx51V46/mY6NvsTMwNCyd/7Zwt388trq5adGQitSw9zDzpBS7j6
	HC/Wb9rizJF4vofBK3XRv744NUZW6t2E24MOS5L0gfv2lNyYPpV2x7sDpuPh
X-Google-Smtp-Source: AGHT+IEHI4pj/K4LiqnxQDGK5V6KRCyGVOa0sFel7fFOcCnONd7ha8avu5EPQBpiJt5XmNPfzI6IJQ==
X-Received: by 2002:a05:600c:1e23:b0:40e:758a:96d5 with SMTP id ay35-20020a05600c1e2300b0040e758a96d5mr339369wmb.167.1706031728897;
        Tue, 23 Jan 2024 09:42:08 -0800 (PST)
Received: from jernej-laptop.localnet (86-58-14-70.dynamic.telemach.net. [86.58.14.70])
        by smtp.gmail.com with ESMTPSA id az8-20020a05600c600800b0040ebf626bfcsm2267320wmb.1.2024.01.23.09.42.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 09:42:08 -0800 (PST)
From: Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>,
 Emilio =?ISO-8859-1?Q?L=F3pez?= <emilio@elopez.com.ar>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>,
 linux-clk@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] clk: sunxi: a20-gmac: fix kernel-doc warnings
Date: Tue, 23 Jan 2024 18:42:07 +0100
Message-ID: <12366031.O9o76ZdvQC@jernej-laptop>
In-Reply-To: <20240121051837.17564-1-rdunlap@infradead.org>
References: <20240121051837.17564-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"

Dne nedelja, 21. januar 2024 ob 06:18:35 CET je Randy Dunlap napisal(a):
> Move the function kernel-doc comment to be immediately before the
> function implementation, then add a function parameter description
> to prevent kernel-doc warnings:
>=20
> clk-a20-gmac.c:43: warning: expecting prototype for sun7i_a20_gmac_clk_se=
tup(). Prototype was for SUN7I_A20_GMAC_GPIT() instead
> clk-a20-gmac.c:53: warning: Function parameter or struct member 'node' no=
t described in 'sun7i_a20_gmac_clk_setup'
>=20
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Emilio L=F3pez <emilio@elopez.com.ar>
> Cc: Michael Turquette <mturquette@baylibre.com>
> Cc: Stephen Boyd <sboyd@kernel.org>
> Cc: linux-clk@vger.kernel.org
> Cc: Chen-Yu Tsai <wens@csie.org>
> Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
> Cc: Samuel Holland <samuel@sholland.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-sunxi@lists.linux.dev

Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



