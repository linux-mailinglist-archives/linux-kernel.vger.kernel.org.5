Return-Path: <linux-kernel+bounces-94770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40C02874505
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 01:10:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C5DF1B210FB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 00:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16AFC641;
	Thu,  7 Mar 2024 00:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LQz6n0yq"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355A9161
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 00:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709770194; cv=none; b=T1R0dRv5cEJ7EGrk+voVYh0XqYjmGtHfzGu4y+0KKClTsO8BaY/V+8TjQty9ztX7KI3vzvaOcIvLECS1aL65Gs3y7WcupdmgQ4IRRWw+HyxEdm4VfJbtESMHzq4/bdgGncZDK2s3xiNLSDgf1/OSqpmJf3GwvigQm8yjq+U0xtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709770194; c=relaxed/simple;
	bh=tOqJBXaZeVSV8axvr01B9lRN4hAxvuMwf/T6Ki3ZOLw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jlN3r4SAmi1ivUHkqS5x6Mmo0QyE517sr6pviryjLHnW+3yzdyRVZQkN5HdBl/g8lab1+eV3M7WnD0CdbGninV0GLsqQc3AWcClic6FtOo9dSZqhYl8TH/EQCLH/8W5HB2byBXUNWHmBcZOT936sZdTDMHLR6yl8yFM/B8/JP9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LQz6n0yq; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a45606c8444so34868166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:09:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1709770190; x=1710374990; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=u06nZ2DWpJktMWK7UhBFXPvQ5pWNvpHECWD/Jt3Ivqw=;
        b=LQz6n0yqCfOlycGWRCWwRCx3JsMKjBmnThU1yBij2GYIbY9mQtd2enMjqX2AHwfRls
         u/zUIhk7FZO9IJVS2l/KYdKCeyfv+uTBGHnI7MRv/cguehRKqYs+1ydFIBKo08ScI+4M
         AimSUebd/BGjmIl03ObBB2cENncHtMPHXvDD8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709770190; x=1710374990;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u06nZ2DWpJktMWK7UhBFXPvQ5pWNvpHECWD/Jt3Ivqw=;
        b=v9bHMlE1opu/ZTC4jTyA/J18vW/0lMWHRh8bbeQ/TdfbFt/8tlktm1pOOW3dOwUU8V
         2W6wI2Ux+0dfjSqunzAUVhw5Lv+2tw6lcwDLMDCQNlGpN6FV0TlFWlJ6qVGrOcrsNTX9
         SYm7Vnklj3pNlOmdhAFeXQn76ZtGJ0vbLADQKS/wjslf/eUt8MB1onuHei9E5AXEbZPY
         D/krmANwz/J/OpgUxpiQmUdeEvtkHjrwzH+TcL3H+MW/0r2ZBNp9icDih1+O4R2Z2iZj
         93tHsp5Wh1ACXzvr05mkV4zEj0QwrsAXOzBTghHoa1cvya9v/CF5Rxz0HnXCmosKB0Gr
         tsuA==
X-Forwarded-Encrypted: i=1; AJvYcCVZGujbbU9kc7WJw7R6NgCPMDc2oWhx9QoqCJCgkd+MB9/d9L9aH4OLQYTxUuSbBYowrwRlOJReX+3F7jNZKgRC0lvbHUU132J6vLUI
X-Gm-Message-State: AOJu0YxCFX/nLmjOG2iQB36x35oKfAOVUPyQcZvvl9996Es/F43SLRW1
	mgdCatJe5OWo5qyXnhRIt/SJfS2qPeXaHaM8NCf8PYPSE3dJ7MOLPwmFSD9HQu6ah7xafG3ONfV
	uKG+S5Q==
X-Google-Smtp-Source: AGHT+IHG+uFaX1HlFoR2k+YVp09fcZtO3WWXsVZmfmW2taTPsE6o317+pZew9geua5O81RsqiAcfAg==
X-Received: by 2002:a17:906:6409:b0:a45:8ab6:5f3c with SMTP id d9-20020a170906640900b00a458ab65f3cmr5572236ejm.45.1709770190004;
        Wed, 06 Mar 2024 16:09:50 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id s23-20020a170906a19700b00a44899a44ddsm6708357ejy.11.2024.03.06.16.09.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 16:09:49 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a36126ee41eso40215966b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 16:09:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXcpwFihjt0mghhelKtJxVrt/I/6yz1zvDSCwETVAGHVS5VfqVKpstLeg2eHoUL5qCTwx1KL0CVh9Cr15QBsAwfwPqrN4AXtz+GHBRQ
X-Received: by 2002:a17:906:3392:b0:a44:bf5a:2175 with SMTP id
 v18-20020a170906339200b00a44bf5a2175mr10557302eja.71.1709770189003; Wed, 06
 Mar 2024 16:09:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <3b7dbd88-0861-4638-b2d2-911c97a4cadf@I-love.SAKURA.ne.jp>
 <06c11112-db64-40ed-bb96-fa02b590a432@I-love.SAKURA.ne.jp>
 <CAHk-=whGn2hDpHDrgHEzGdicXLZMTgFq8iaH8p+HnZVWj32_VQ@mail.gmail.com> <9692c93d-1482-4750-a8fc-0ff060028675@I-love.SAKURA.ne.jp>
In-Reply-To: <9692c93d-1482-4750-a8fc-0ff060028675@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 6 Mar 2024 16:09:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgA1N72WfT9knweT=p1jhHGV3N0C2Z+7zvGL+LgG-AwXA@mail.gmail.com>
Message-ID: <CAHk-=wgA1N72WfT9knweT=p1jhHGV3N0C2Z+7zvGL+LgG-AwXA@mail.gmail.com>
Subject: Re: [PATCH v2] x86: disable non-instrumented version of copy_mc when
 KMSAN is enabled
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Alexander Potapenko <glider@google.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev <kasan-dev@googlegroups.com>, 
	LKML <linux-kernel@vger.kernel.org>, "the arch/x86 maintainers" <x86@kernel.org>, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 6 Mar 2024 at 14:08, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> Something like below one?

I'd rather leave the regular fallbacks (to memcpy and copy_to_user())
alone, and I'd just put the

        kmsan_memmove(dst, src, len - ret);

etc in the places that currently just call the MC copy functions.

The copy_mc_to_user() logic is already set up for that, since it has
to do the __uaccess_begin/end().

Changing copy_mc_to_kernel() to look visually the same would only
improve on this horror-show, I feel.

Obviously some kmsan person needs to validate your kmsan_memmove() thing, but

> Can we assume that 0 <= ret <= len is always true?

Yes. It had better be for other reasons.

                  Linus

