Return-Path: <linux-kernel+bounces-48941-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25B9F84636D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:26:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AACB228B828
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44DDD3FE4E;
	Thu,  1 Feb 2024 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Y2sUzDTq"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6AB3FB38
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 22:26:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706826389; cv=none; b=pcnpmBupq6+xHReXqYgUwBcjTdPlbcF0ejGjoyT9JLkHX1aLx2PlCnI2OFcEVc6wO0RoHDLDWICguIARm1qFV6zzC7SJ6Fhb3jKGJ+8GQUU1cSlX1dWHvnQIHQg5c8nfBoofq5tiuKdGE23umRoS8f20+BiYVwAZfu8Qj/2CO00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706826389; c=relaxed/simple;
	bh=g1niz+9BFP8nJJvQSZtstaXWeqGreuVXwyIK+21IaXQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WThh3fuGrpJHMrclQ5y6H4a7VNdOrZ8y/gb0XZy9xZcV3hcXJkpKp5AQZKskYrkweEd6/OhGIEAcfQCUPs2dIRJsjcf1tMR0udLhC4332NlTjRZJRxP3bduvOW1KvdcklvHm8DNDv0LRBYR15DsOkXIQCLPpLE5D1BXaQP5m4XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Y2sUzDTq; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-46b165745deso628704137.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 14:26:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706826387; x=1707431187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1niz+9BFP8nJJvQSZtstaXWeqGreuVXwyIK+21IaXQ=;
        b=Y2sUzDTqMNuq2LzRYMJ2GlU9BO6W+f/1pmQLHYXUfbCvU7tgwRHhY9fPU9PS4ZiRR8
         Cd0z4e4zrmZ//iqvBng9HRHRqgrN2atants60IeG+KzI85kYnfLPNcehqSB5ZwX2CbN7
         Q15Nt+B2z878uj+vMtVJppo5mqdtoUCfADGQRqHyO1UVsXncSOHHGnL2LB/iTRl9ZbRP
         yiGdXnCiJqwvkFGQF5QqdWGlQlkChh/rJr8rwK7X2EHvu7YUEGhoOWYYXOuko2jQiFUK
         Rk1u5IbEDkWq8vLsWnvlEkOkVPmfvwBaJcKprAAkUKWCYrOQSRcVAUN7BTpK3OyaeuW+
         EL6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706826387; x=1707431187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=g1niz+9BFP8nJJvQSZtstaXWeqGreuVXwyIK+21IaXQ=;
        b=YzdDn2EVjLJi7gaS4tyyL3x5c4oxRnXLgJZ80x/uBgPUg1QeakR9yW3oyLQEGuJQdR
         bZEXGGkkipnoILT3KUFOSsUt5dXxYUbuwJsW5HTuPrMNcwNKBg814qpK7ytn+1rqb/dx
         /IaqP7J+6qIi1xb7Pwm0xC8S8B6fmpHozIU5RzvM7iqx0zhvFg3yHhov9K+wKmWoCu2z
         GfyYADpPIN/8thPQa4Afnl5Am4fmtuWwdng3gzhmGPOy9zFaW1N6DW0uhT4HV24DJA5S
         BElvJBhGaqOtLg3ZjtSveCzwohsMP8MTvoDRDpsAniWPolVPL3fghrVV1KPt5zdR6+pl
         MrVg==
X-Gm-Message-State: AOJu0Yxg1VnTv0l8YESJH6sIwafco0qdkP3G0cvjbxN/HptIj1M5nVHD
	kUJA+ET3qOnNEKwQ06IpXYyKEs8HmKTSVjOvPomoMljUsy2sJgxaR771I2fDpd7IhoZ6M5n8NbF
	aRfgansQmX4hf/wzZS8IzHdLqCKF4VpqfTgGZ
X-Google-Smtp-Source: AGHT+IFCuKF6QiU+ny6kuZUF3GaDPIhQfm+qSFreoCq2anMqN2UYkMUcoGIgF+ZV3z+Yz9/V09IBhzG82IgRKFYsfqw=
X-Received: by 2002:a05:6102:806:b0:46a:fd91:c15b with SMTP id
 g6-20020a056102080600b0046afd91c15bmr339945vsb.13.1706826386679; Thu, 01 Feb
 2024 14:26:26 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-3-1d946013a421@chromium.org> <20240201221654.GC2240065@dev-arch.thelio-3990X>
In-Reply-To: <20240201221654.GC2240065@dev-arch.thelio-3990X>
From: Sami Tolvanen <samitolvanen@google.com>
Date: Thu, 1 Feb 2024 22:25:48 +0000
Message-ID: <CABCJKudd3SUy3Qor7Tc0zyJsSAWy0PavbbBFALuWEpBa32pBCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] media: mediatek: vcodedc: Fix Wcast-function-type-strict
 warnings
To: Nathan Chancellor <nathan@kernel.org>
Cc: Ricardo Ribalda <ribalda@chromium.org>, Mauro Carvalho Chehab <mchehab@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>, 
	Tiffany Lin <tiffany.lin@mediatek.com>, Andrew-CT Chen <andrew-ct.chen@mediatek.com>, 
	Yunfei Dong <yunfei.dong@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 1, 2024 at 10:17=E2=80=AFPM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Sun, Jan 28, 2024 at 02:12:22AM +0000, Ricardo Ribalda wrote:
> > Building with LLVM=3D1 throws the following warning:
> > drivers/media/platform/mediatek/vcodec/common/mtk_vcodec_fw_vpu.c:38:32=
: warning: cast from 'mtk_vcodec_ipi_handler' (aka 'void (*)(void *, unsign=
ed int, void *)') to 'ipi_handler_t' (aka 'void (*)(const void *, unsigned =
int, void *)') converts to incompatible function type [-Wcast-function-type=
-strict]
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>
> I am not positive because I don't have any hardware to test this driver
> but I suspect this patch is just hiding the warning without actually
> addressing the issue that it is pointing out.

Agreed, this won't fix the issue. The correct solution is to drop the
cast and change the handler type to match the pointer type (i.e. use
const void* for the first argument).

Sami

