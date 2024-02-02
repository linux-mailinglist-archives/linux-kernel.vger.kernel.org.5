Return-Path: <linux-kernel+bounces-49970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C9960847247
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 684011F27616
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B57E0144632;
	Fri,  2 Feb 2024 14:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wQr4qiWa"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2DC140771
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885700; cv=none; b=MHnu/c4B9PZlG1GzBe/pFUc2mVWdr1cWdH33SNWki5QCWIFJc143GSWP9mcHbxYYulcGO9B09fZPTnm/p1QaTLCgKbGB48TmblMEv67WM5j+xy3mCplKWhm5Y410xmQN03P3W1KPRgraT/Jtoj+5ReVGH932fW5ULjyG7FMvcJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885700; c=relaxed/simple;
	bh=MdKH193MLZ1uUjDMsLOJIGIGHHF/3sdAUXTepKp2jrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YX1h1K54LR1gog9C+ExScDbBC5q0CM7dXmTEa5L1pwsi3k5prsZ+DuTCymExKGso39jKSh1jHc4B9+syqnYX/MWrNmk6l+Lt+nX7ytkWFi+lApfgT5UsuBjwPEWERwOLfZ2z2pEZoELQqrqzDGK6SlIgCCDfgBRVrZO7sE+q72A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wQr4qiWa; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6de24201aa6so1382617b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:54:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706885698; x=1707490498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MgZY6y3hYltlhybXLFHX3JY6qUiQxBKoDPMqI4ObTdA=;
        b=wQr4qiWallvd3zrm7rcwpIQxb8RSXItV0c1xtQi8an2TrF6mPXfuaREooXpcTpigtJ
         /J97f6b65dR7gf5Zqlg0n1yEy7qFwSBznIhJKdgxNdLX6Fcue/sxxiZOmXdnxZTNjwOR
         aHl8tzjbAJVVGaDe/hDYsZAtT02/99VxV1Tp0DaMh7xy5QuJjf9cTNT/BAxPLc1CaShM
         TSNbk3LZUMeHzUt0IqZOZX7Y6QTwD3fMw12a87VF4A8nYKtsQweeP6VMm02+ty2IkOZY
         IiLC2hMGkEOK+W8abTnQjlFAm+yEzYJDQjTs2mbfkZrLhVbQ9M4PkEYF2ZbMuqqNqwlu
         d3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885698; x=1707490498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MgZY6y3hYltlhybXLFHX3JY6qUiQxBKoDPMqI4ObTdA=;
        b=R/XsQmi7VY9RiVHVXq1TJu94D7cmMXI9TpRYl+HASAgLN82crlbdzJHlJFffq4TDRh
         ltYAYOv5gsoZNPQtidIJ+3le4b9cNUre7AV3dkorCupU0DjWW4mO967qA/MyAWGHk358
         H9sg8vDwpugcoXi91hQQEQNkyNI8b0L50dp9rseD4bVbeTgPmXd61Ss9FjFkYPrs0EvA
         3ai73+F+S59MsIUV/ZtKhUMwKKVvDgUXd2qdoR2uWfu2tE8SVX1eHWOvXrkFPobCJOcl
         KdjAXvUVRNZ+TgqEoYeQ8r55SxEaAzKm4IPxJ4TzQJMV+j/K0ifZl9izipgMFcw5ozzB
         23Jg==
X-Gm-Message-State: AOJu0Yxs4uxA+KxbcokwNrNzDFZG4ALDU7ndlgNckPxn6EkGTQOvz3Ek
	5gQZ1g5WKWvStXMxn4/ohA80CoQ5WDvbHVVcxEIbs7hALLeYLeG8FfGBLpeqYZCxlVLj8d7X+tf
	Lii3DwKdrPTVHL9UoBkTU8DbfrKHNdLOJAiL/Uw==
X-Google-Smtp-Source: AGHT+IFFYDDuTFvmOwr9M8ASQb3hTgoGrlx9OXayKv245V/5FAXMHWqna8B3y+9sdEi69bzIL4D85SyxTGIfNpF0rJM=
X-Received: by 2002:aa7:984b:0:b0:6dd:c1b4:2643 with SMTP id
 n11-20020aa7984b000000b006ddc1b42643mr7914114pfq.28.1706885697829; Fri, 02
 Feb 2024 06:54:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202010507.22638-1-semen.protsenko@linaro.org> <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
In-Reply-To: <bed3d775-2d80-445f-bf28-b28a17a6370c@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 2 Feb 2024 08:54:46 -0600
Message-ID: <CAPLW+4nPnPywwsjkeJE70GzyBL=smEo5_=0usGwmnaPRgZwdrQ@mail.gmail.com>
Subject: Re: [PATCH] tty: serial: samsung: Remove superfluous braces in macro
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jirislaby@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 2, 2024 at 1:49=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 02/02/2024 02:05, Sam Protsenko wrote:
> > Commit 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> > removes parameters from EXYNOS_COMMON_SERIAL_DRV_DATA() macro, but
> > leaves unnecessary empty braces. Remove those to fix the style. No
> > functional change.
> >
> > Fixes: 59f37b7370ef ("tty: serial: samsung: Remove USI initialization")
> > Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
> > ---
> >  drivers/tty/serial/samsung_tty.c | 8 ++++----
>
> I am pretty sure you did the patch on some old tree, not mainline rc1.
> Please work on maintainers tree (or linux-next).
>

Hi Krzysztof,

I worked on linux-next, and rebased it on top of the latest linux-next
yesterday, right before submitting. I distinctly remember solving a
conflict while rebasing, due to the new commit 0b87a9fd670a ("tty:
serial: samsung: set UPIO_MEM32 iotype for gs101") which just got into
linux-next yesterday. Please let me know if you want me to rebase it
on another tree and re-submit.

Thanks!

> Best regards,
> Krzysztof
>

