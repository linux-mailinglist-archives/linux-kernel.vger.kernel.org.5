Return-Path: <linux-kernel+bounces-76895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D5F85FE50
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 17:44:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0856C1C25563
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:44:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33D9D1509AF;
	Thu, 22 Feb 2024 16:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iaKY3TNQ"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC393132C1B
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 16:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708620232; cv=none; b=L0+E/hurYJ363aY/mX+cszZ92B8mc6Gex15LxL40yGfH0k/7KV5Xw66V5NoHjAk77HARQuZM/ht4P0r+5pQvhZtvmowWWgHWn3zyF9Zi/qvaP4fAsKuYtC7n4rjtSctWJNNXj3VJVFsSAw3b8cuCWCP8rpir/BS84ZJEXGyGzQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708620232; c=relaxed/simple;
	bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0PY+WiSpGXuKDF/WZdSfu9L2KHPQcarRQvsVw729M/HotkjL2Fk7feurAGeCAEtnRg/LFBxRQLfS+TOj8LzRDqGZPemCzPRg4v7DEeqC6NnEcdcj2+w/D6kex0KFWfMREsUW6uCy+1dO/MTEHdwiDM/eSa5JW3uuK/dYdhK7UI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iaKY3TNQ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-41279203064so12319915e9.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 08:43:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708620229; x=1709225029; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
        b=iaKY3TNQAt1pe8rPYA6dM2vsv1TiNG446InpPbybZoeIcG/pSCkv9mVqN5A6MjViMP
         UDcZLj5NvHhziGP+ZP0sVljWuEFYRF2st4B2JdxEO8VYj9eEOundVpvPkMmiwPWxfkaC
         b9NbfuhE34bl3fu0zpuz3nOrNQbb3qjdOErU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708620229; x=1709225029;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=blGXCQWbinQD12tf5lew+OFO7kdmX5WYe1FXNjbh2d4=;
        b=xTJvlReMyZvg//0L/HaFTmOk4IXzDmqACWRQ68yG7PUadaIZPvpewQ44jL+Z8+rpxo
         V7FNsNP/JX9w6cdPXxDJHZj2BTedBnFF4lL7/ID3+Prt4xFHqKEXubmA7uv5XGPYo5KO
         if3+eOtdFmQIu4GTuC1yZxnZEXSOFSt4a0wEJYo1CairuMaBCv4kOw9WpoNpQQD3Eugc
         PwfJWYGapZkiLXR3ScHlXFzf0v4o9tDxvYbLI8ojVMICjs6/PDoDD4s2ufzW7bAwuCtt
         8msp5zeOYgyM1H6WPEli12Fp8m8WXzu5BKmRPJw8LvqDfPalU08JHXDWC85otpAMWvG2
         bShw==
X-Forwarded-Encrypted: i=1; AJvYcCXIweD29xtrHweey3Y9XHnenY4dXSRXsPZGHDrVkavHzIwEDUF6vCQFCriQmChg7xIpjSKtk6IZghqbsObXTITER3YxAE6sWEh4GZmD
X-Gm-Message-State: AOJu0YwyB91rGY4kYLtElO+XR+1/ET9ZjVjZoek1MsP/OaUJWDxOr9/U
	yRDAf5x83EwC0RDF5cjfQeetNovXLxLxLiUvS7P5obWEi7+a6WtPDRgMpFJAg/rKlPc8k3PIOw0
	8H7pyQXi3MFtbhHYMsoQ/pl73Pi9bV7kfp9/5
X-Google-Smtp-Source: AGHT+IHPeFbJSDEot8fEBJUOQpHH3P+T2gkvI8J+VDy41RkRYDYg/pUrSO1BaeS0Z3eGGdJvHPDd7UZsn6op8oO0QU4=
X-Received: by 2002:a05:600c:1391:b0:410:e41a:fc0d with SMTP id
 u17-20020a05600c139100b00410e41afc0dmr16692583wmf.24.1708620229216; Thu, 22
 Feb 2024 08:43:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAG-rBihs_xMKb3wrMO1+-+p4fowP9oy1pa_OTkfxBzPUVOZF+g@mail.gmail.com>
 <20240221114357.13655-2-vbabka@suse.cz> <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
In-Reply-To: <CAG-rBihOr+aAZhO4D2VBwSx-EGg_gbgBYKN3fSBTPKCXdz9AqA@mail.gmail.com>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Thu, 22 Feb 2024 09:43:38 -0700
Message-ID: <CAJZwx_nLcMjV+4vShx9LqCOVo26Bk_gDPXP6PiTp2UXdQAh2Zg@mail.gmail.com>
Subject: Re: [PATCH] mm, vmscan: prevent infinite loop for costly GFP_NOIO |
 __GFP_RETRY_MAYFAIL allocations
To: Sven van Ashbrook <svenva@chromium.org>
Cc: Vlastimil Babka <vbabka@suse.cz>, Andrew Morton <akpm@linux-foundation.org>, bgeffon@google.com, 
	cujomalainey@chromium.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-sound@vger.kernel.org, perex@perex.cz, stable@vger.kernel.org, 
	tiwai@suse.com, tiwai@suse.de, Michal Hocko <mhocko@kernel.org>, 
	Mel Gorman <mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

With this patch, the test results have been promising so far. After 10
hours of stress testing, we have not hit the reported problem yet. We
will keep testing and report here if we hit the problem again. Thanks
for engaging with us.

On Wed, Feb 21, 2024 at 8:53=E2=80=AFAM Sven van Ashbrook <svenva@chromium.=
org> wrote:
>
> Thanks so much ! We will stress test this on our side.
>
> We do this by exhausting memory and triggering many suspend/resume
> cycles. This reliably reproduces the problem (before this patch).
>
> Of course, as we all know, absence of evidence (no more stalls in stress =
tests)
> does not equal evidence of absence (stalls are gone in all code paths).

