Return-Path: <linux-kernel+bounces-39021-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 091E183C9BD
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C6161C21823
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF09D131755;
	Thu, 25 Jan 2024 17:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EcmveteH"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA43C481CB
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706203074; cv=none; b=ZRfvCUmjJjwg4LPQDL7bY3vLDBzWH8CQH/l+wN5fOUzkF9Fkc9rC1D9S+fTvna/TKhxbXULW+lL65KSTWqccD4R50u/L9I9ej/AOiayjb0mv6zDjMelbbuxVGa7+epQIQ/HVA+by+pCBOQQEHKnO5FTGylJb7KFe6Gk6CnUGftI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706203074; c=relaxed/simple;
	bh=IzszeC5BwpXOho+0jEHlObu6yB5ChY5DXLP5nlCoAoI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OZrpYwgj4PHvoui2Nvy2jmdvI/Hr2Zu79nUHb1ppoiDmFkjtk+fDooC0Sj+Gp8AqxJEkQ3arYR+C6V5gWdHbLQWCwzCLoNm/fy3iitIn37Oux1nVHoajLORSDS+GTvUmvI3N4TaFGrCyY6NWI9w+8HvC8CsONdMHoyAtJtJtrXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=EcmveteH; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-510221ab3ebso417497e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:17:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706203070; x=1706807870; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=AU+fsHobuU39z9pQZP7B0amkHKcRajVu86fobjazaZU=;
        b=EcmveteHiinKlQK4Rr8y0SnQ0wi1CTiB77g+PMdAtGes79yZm0W0AJ8/JpzlpvgFLJ
         Y/GALcUkAousSqKJglxO3u4Vr8kcuSMswN2WieuDJZ6gCHpRBDoAejUenvOHFfTA6aMD
         zsqItsBSNS9hLsJ+cwgeG/u8DpkAHhBY6IN1I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706203070; x=1706807870;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AU+fsHobuU39z9pQZP7B0amkHKcRajVu86fobjazaZU=;
        b=OCHBNlv1J4aPHCdDy2HCdpxhH01hgX1R5bgM6wi3ft8MNdQiTI+QlJrsw9nVotRD8f
         uXMk0SgDV7soHNJo+WEIsNpm8pz1WfQw0j23pukpp/Aa6HX9Djr8Ay1R2uagroV6gphm
         o8hHNdobA0uA6I02+0cdqfW5x7yO514hmaNCtI+dnlwlLo7dOywRKFCGeS8c3OGKYB1j
         DzYS8K3PVFpkn9x2emrlYtk+1lKeTfgK1n+CwUa7Yrt9kbH4f9EOJwgyFTorgNoNY1GE
         FVd8ejLncRSTPvvNoZx77e05sXjOdXOdveIdznk5H9u5H7dHe5Ad0MbmmttCWoMW3I9R
         AC1w==
X-Gm-Message-State: AOJu0YxhWwI7jb6+u0F/ag9e4XZHbi4cYAekpItKPDyZZljf2LjfPpad
	H7yHw5F+ln6o3Wt+XpqIUZAKAAuKnTpNU+mXS+eA1PNHDnv4yp7JDJs8gEfec+rBBpO4CTDhCmY
	0H6dUng==
X-Google-Smtp-Source: AGHT+IG6VrYhwGfDgKL/B+u1lsgsSi7BQzhXETBVeEJbu2kLbkCAtgh/qdmwjooiYfRApLE565dSZg==
X-Received: by 2002:a05:6512:e99:b0:50e:74f0:c077 with SMTP id bi25-20020a0565120e9900b0050e74f0c077mr107294lfb.8.1706203070439;
        Thu, 25 Jan 2024 09:17:50 -0800 (PST)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id qo12-20020a170907874c00b00a2e3a1ae471sm1212233ejc.6.2024.01.25.09.17.49
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 09:17:49 -0800 (PST)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55d20f24275so58764a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:17:49 -0800 (PST)
X-Received: by 2002:a05:6402:1246:b0:55c:7e2c:ed7 with SMTP id
 l6-20020a056402124600b0055c7e2c0ed7mr836379edw.18.1706203069390; Thu, 25 Jan
 2024 09:17:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZbE4qn9_h14OqADK@kevinlocke.name> <202401240832.02940B1A@keescook>
 <CAHk-=wgJmDuYOQ+m_urRzrTTrQoobCJXnSYMovpwKckGgTyMxA@mail.gmail.com>
 <CAHk-=wijSFE6+vjv7vCrhFJw=y36RY6zApCA07uD1jMpmmFBfA@mail.gmail.com>
 <CAHk-=wiZj-C-ZjiJdhyCDGK07WXfeROj1ACaSy7OrxtpqQVe-g@mail.gmail.com>
 <202401240916.044E6A6A7A@keescook> <CAHk-=whq+Kn-_LTvu8naGqtN5iK0c48L1mroyoGYuq_DgFEC7g@mail.gmail.com>
 <CAHk-=whDAUMSPhDhMUeHNKGd-ZX8ixNeEz7FLfQasAGvi_knDg@mail.gmail.com> <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
In-Reply-To: <a9210754-2f94-4075-872f-8f6a18f4af07@I-love.SAKURA.ne.jp>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Jan 2024 09:17:32 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
Message-ID: <CAHk-=wjF=zwZ88vRZe-AvexnmP1OCpKZSp_2aCfTpGeH1vLMkA@mail.gmail.com>
Subject: Re: [6.8-rc1 Regression] Unable to exec apparmor_parser from virt-aa-helper
To: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Kees Cook <keescook@chromium.org>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, Kevin Locke <kevin@kevinlocke.name>, 
	Josh Triplett <josh@joshtriplett.org>, Mateusz Guzik <mjguzik@gmail.com>, 
	Al Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	Kentaro Takeda <takedakn@nttdata.co.jp>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 06:17, Tetsuo Handa
<penguin-kernel@i-love.sakura.ne.jp> wrote:
>
> On 2024/01/25 3:27, Linus Torvalds wrote:
> > The whole cred use of current->in_execve in tomoyo should
> > *also* be fixed, but I didn't even try to follow what it actually
> > wanted.
>
> Due to TOMOYO's unique domain transition (transits to new domain before
> execve() succeeds and returns to old domain if execve() failed), TOMOYO
> depends on a tricky ordering shown below.

Ok, that doesn't really clarify anything for me.

I'm less interested in what the call paths are, and more like "_Why_
is all this needed for tomoyo?"

Why doesn't tomoyo just install the new cred at "commit_creds()" time?

(The security hooks that surround that  are
"->bprm_committing_creds()" and "->bprm_committed_creds()")

IOW, the whole "save things across two *independent* execve() calls"
seems crazy.

Very strange and confusing.

                    Linus

