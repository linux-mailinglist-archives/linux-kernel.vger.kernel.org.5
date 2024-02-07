Return-Path: <linux-kernel+bounces-56897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87F3C84D0F9
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:16:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB29D1C24863
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D3B385276;
	Wed,  7 Feb 2024 18:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="SWReDU48"
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com [209.85.219.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F156682D82
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 18:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329547; cv=none; b=itA/EjCcI0iqWUN1L7jCZusaaA8vUrb6gQP3nv0sIReOsS8vDqx7iDhizkW6CerwYfkU8mnj7HKO999OeWjfsTojZod+gei0XjIJO7+ci7jAW/PaYOPAPjLO3E+mTFfkgJuWBaqfRP6vKu8mjK/jywc3qUm+Sj6NFhdhFZJHl+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329547; c=relaxed/simple;
	bh=HemVGK6zZne3B0GajBNYqVima/P4OLJW7RPvot4BnIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ciKbL1CJAADo0k+XxaN7nTtA1/QoeudgdGE2DosoQNLbHW0l5pO2v9n1XpTKvwC+JuuWC5o5QDa8xlh8JgbU00bFFjYcrPStZpcQVZADVg2U56f7dMiwPThqRmHn2Ecjym63+gca6exvOCt44R+cgymHCBsw2o646Sbww5pXT+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=SWReDU48; arc=none smtp.client-ip=209.85.219.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f172.google.com with SMTP id 3f1490d57ef6-dc6d9a8815fso926957276.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 10:12:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707329545; x=1707934345; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=SWReDU48FE7BclzS2BxrGrfX+g+CGjiVq0wUg09cuz9SyES6ugYQ7Lm6UvTijviwcO
         tSkY9hIEDdWyIdw0VWpCZLPduw5Uxtrn6aLpU2VScppiocx0+zKxTVby62emzn8JcOth
         yFRa0KaCzlOjDXa8L7VecFSlHMKb4eG/N/zaZJyQxcpoVAN3wH+Rf0pDiWsfTTLVdW6D
         6js/jtMKe06gp35Nziyib/+X8yA7wazlz0VXWZddYfeQPgiYvx9ziTvG47XTWvvI5nby
         L8t+zNZ/XYGWX1B7kG7BWW9yE5D03ZoJIw2BoavzC5rh1s5UORbC+XfkdQ7jchiRNCZn
         L/wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707329545; x=1707934345;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9hHXbmrv3ps1sMVSmLFG15zm3/Plob5tS/368EqKz5w=;
        b=V/a6emN+U3rhZX2Yzk35BHr1Fn2WE8au0KS2ALWSstoqsAq/hPa6JVLaFHWARXhn3L
         ts6rUPAsf05PQOTV1ePDr7eIBnUUl9ojJsQ+/0gUMPIdUG+HRkIeAvWfRi0wPF8ONBQ0
         XqEClzFaMuV5yDGegqcrMXhcS9Nkj6oSxuOPAm6g/s9tKxroBYp+JD69z+OKrOxw5Ux8
         yEfdewlE1WAa3LHa8xpz1lZruOKXYnfxwUlzX9D0DJRhgVmQCsmYgkxqT7gCc38AJyNw
         eK0g1S4ZfRZauMfEI2lKDwpN8vWlfqd0Tg4jTySmnSJUfogBv7W67TTn/rrSK7aMlPc4
         3l2w==
X-Gm-Message-State: AOJu0YzfT0OSfqej8Q/PG1gzfzz4H/jyhnYpvzxWAM1UKZLCdBkK3ZEX
	8fOA6NJcmNmkVpfBWbR2Uhh14d+cHlJ40BXUr2714vSF87aghYrfkNvTac8a2gLNew7lrvk768D
	npKJnocLzLhIs+SFNgy9VjzxkEx6EDYnqP9DS
X-Google-Smtp-Source: AGHT+IHxnQ5vAEAJSNuMes3+eXgpNC1vkbsCULnqxfu1b77zpdub65nMVS21AFiTfVqgPjNJ25GA/1LSAKxOdxXqZY4=
X-Received: by 2002:a25:ec0e:0:b0:dc7:1d:5db4 with SMTP id j14-20020a25ec0e000000b00dc7001d5db4mr5835418ybh.34.1707329544772;
 Wed, 07 Feb 2024 10:12:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook> <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
 <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
In-Reply-To: <CAHk-=whSMoFWCw=p1Nyu5DJ2hP2k=dYmPp-WjeY8xuc7O=ts7g@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 13:12:13 -0500
Message-ID: <CAHC9VhQ4UZGOJg=DCEokKEP7e5S62pSax+XOgiBB-qQ=WGCbOA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:57=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Wed, 7 Feb 2024 at 16:45, Paul Moore <paul@paul-moore.com> wrote:
> >
> > Okay, let's get confirmation from Tetsuo on the current state of
> > TOMOYO in Linus' tree.  If it is currently broken [..]
>
> As far as I understand, the current state is working, just the horrid
> random flag.
>
> So I think the series is a cleanup and worth doing, but also not
> hugely urgent. But it would probably be good to just get this whole
> thing over and done with, rather than leave it lingering for another
> release for no reason.

I've always operated under a policy of "just fixes" during the -rcX
period of development, but you're the boss.  Once we get something
suitable for merging I'll send it up to you after it has soaked in
linux-next for a bit.

--=20
paul-moore.com

