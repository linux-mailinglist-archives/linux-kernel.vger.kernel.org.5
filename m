Return-Path: <linux-kernel+bounces-85057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6AA86AFD2
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:04:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 63C501F2252E
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 13:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D6B14AD3B;
	Wed, 28 Feb 2024 13:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="X5jbiB9w"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A20C3BBEE
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 13:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125467; cv=none; b=C/FdODGdPMUr4vRMAAmzjQZ0IooMyeXu4z3xUnlgzXDxnpfR5jHYhHg8ubTSFAloB7hT9UG3Ywk2zl+MAAvX3q8FFo5kS7MMx1MpeXhnBA7ngdYZEndoqBdkO6E7S1PmwlVQR4NSAmbkCrZpdon5f7vmraIyK7cREqQAg/C+O8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125467; c=relaxed/simple;
	bh=E8Q8BUTHPfJyeoU9Q6QdXQerQaQjnZ/2HuOscrhXz2w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gE98QsSzScbO68rOCvPEzfPudoGaUCrNjZAQEBbvF/HQ5WRQ/IQ6dGnEG+J1pDvuQpOF2NlZWbGAnxrsDnaG9jIT/1Pdf06LwKv9PTDXXRZ+pcR2qU4NOivxq1ug+TjS+hgYE/WKt0sycy+qXN15u9ig7r1iDgfeq7FahBZGTf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=X5jbiB9w; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dc236729a2bso5089410276.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 05:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709125465; x=1709730265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jAVkysIrddkYfA1tLe0rVWGFMQxH9A+gv88vB1iCZTo=;
        b=X5jbiB9wGoTpduk3FeUv1VZkPef+oGG/mEw4fNENnr7kFNQeMU/6JyPQLeR9GHr5jq
         x/u5j+zayDVBlfZsrK+paFkGUuMFpRZBxNbU67Ofwg7+1/ta1hilnGhCz5Kw0SzlzkPu
         mS9R+CW9OK7iJCcqhex1cBhyLVG4o/8MB7v107RExifcnlKpUlsRFk1khuiEbkvgmqCA
         eQEdiBxkpyVqtutG9tmGm8Ha0kwAOMX+/SiGh2UUSPSNSI1b/YyZI/DDOa/BLf/KCic4
         +fatOeL4RChqvkY8QmwWaPOsEEM4cMRj6TWzOIL+AXQrxO4F7YmkhsHN842hseMKGHmX
         NDjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709125465; x=1709730265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jAVkysIrddkYfA1tLe0rVWGFMQxH9A+gv88vB1iCZTo=;
        b=fhFqSWF5MdafhhuUIf0wPDl4UbBSsnRvUzPXtBsOgncYkhSN+H64BJF0fjCaNv41vb
         EbM6IJ7R91eAIPNqnbrOGL27jfjTvopZ9vxfC5dy4Epb8t40E7q9S3GL03+LVv2pZSG9
         pyPrrFXIfMDDh502G4hmAt57gUhQT3qMVmyIF24136r73oGRnKW9A7iJhIuM5p4XOCgf
         6LOw67cQdk1zJwDi0OQRPlRa9ABvZGtuigbS70jERVp9MaW33ePgTTvJeEWWjXyu87VB
         jmpuz1JM2uS+z8DjdB55y881LaMyALAc4fKDbTzbRKB6GHA8CKq9SMPFTHjbh+DHfJSk
         V7YA==
X-Forwarded-Encrypted: i=1; AJvYcCULLxx8tL+sl1lYxwBHllFUNSe8A4fTGWTi6UOUuD3Gyflr3Bx9FFCh0SlpThfLV/+QkTaNO2S8XJN/mq6XD5DvgHE4O4KtJo4qrhp1
X-Gm-Message-State: AOJu0Yzy+HQek1AQlzhspSzxGCV3Z+CLTVIv+Aodc2m3iWgKlsjYL4Fn
	E7zDMiaAch7veoJ8CQspabNAqnfsK2fVel/BF6uKMeoEVx61TwZUB2mTeD0GvJn3DDaIJW926ze
	VhzOc1h37jotiqk2J+joKkv9OvZv2gkMqY4aXlSAingxrRFPk
X-Google-Smtp-Source: AGHT+IEDs/w431tr4qF6okypXXHq9KVTC5AOppR1Q9xcmNDFdy2AyqsDq48PDYDgQFnhrDDXuj09h87Q5miAGmhXqhw=
X-Received: by 2002:a25:4c89:0:b0:dc7:4951:5f8 with SMTP id
 z131-20020a254c89000000b00dc7495105f8mr2636701yba.22.1709125465317; Wed, 28
 Feb 2024 05:04:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
In-Reply-To: <20240221-fix-sh-mmcif-v2-0-5e521eb25ae4@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Wed, 28 Feb 2024 14:03:49 +0100
Message-ID: <CAPDyKFpJra0+XKG3CvnTk99gvXg5qgeuSQ3UddU4rx1-S-dNLA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] Try to fix the sg_mitet bugs in SH MMCIF
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, linux-mmc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Content-Type: text/plain; charset="UTF-8"

On Wed, 21 Feb 2024 at 22:23, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> This adresses some bugs found after the introduction of the
> memory iterator sg_miter to the sh mmcif driver.
>
> This was first just one patch for fixing the atomic bug, but
> now also a second patch is needed to fix a semantic issue.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Changes in v2:
> - Collect Geerts test tag on patch 1
> - Add a second patch fixing the problem with advancing to
>   the next sglist entry before reading/writing the first block and
>   after reading/writing each block in a multiblock operation.
> - Link to v1: https://lore.kernel.org/r/20240220-fix-sh-mmcif-v1-1-b9d08a787c1f@linaro.org
>
> ---
> Linus Walleij (2):
>       mmc: sh_mmcif: sg_miter does not need to be atomic
>       mmc: sh_mmcif: Advance sg_miter before reading blocks
>
>  drivers/mmc/host/sh_mmcif.c | 46 +++++++++++++++++++++++++++++----------------
>  1 file changed, 30 insertions(+), 16 deletions(-)
> ---

Applied for next and by amending the commit message header as pointed
out by Geert, thanks!

Kind regards
Uffe

