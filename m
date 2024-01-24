Return-Path: <linux-kernel+bounces-37660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E6083B330
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:48:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6D9E1C2200D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD11350CB;
	Wed, 24 Jan 2024 20:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JCf5YSNv"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB9EA134750
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706129296; cv=none; b=kU73TOES2SA2C/TfEJvGdmXmSCMPwV7E6ENc7hAiHQuRiaclXan45NtzoZWFEKI0W1AGs0wqJeDOxoQzNHvmeFXu/mNXDaWXq5FglPYrq9RSv5CDdH6lALOd/T0Z79Truq8Zrv8jLjqZBZ6TT0fw6YIgYr4NlLhdAl1Udg50PuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706129296; c=relaxed/simple;
	bh=7cPnVJTTwAqS5m/D9fwBaWJXEtqGZq8IcE/AOficsKI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sIIbGEVaA7Vs4XJAuLt4MH5i5lt/2ahnP0CQxwAFXRXZDKDAp1OdwlHvSj5MHWfUaq4tbxaAy7jqzYzmxADEwMyhvf1tZbBjUsXQ9rei33Ek0I6LlL6O/lGzO27Xq16Vl6CbgtCfe6lHxQISWpme2pSO2Z2+KsvoWaI4spFTXaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JCf5YSNv; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a28a6cef709so619026066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706129293; x=1706734093; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=JCf5YSNv1AEp68/Ka12er32EYzrHNguUv/zyrA8tULnBiIA+/7Bm5imRwSGEPHJe9u
         8R3gxPxQcloqGfIo/jgZIqjH/621XGstAc4mDpsJDcfx0ku3sybiMhkRnd0/pRI9p0N3
         4hlX6qEFwjW5w63BCmZuPl6b9ZZBig/bUozOg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706129293; x=1706734093;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rk3ry+wMmO/dN2zz3UHRD0lGEi4syprX1/TUT7irM/o=;
        b=tVZ+SUCn2LUq7qqduHg+7gDsWcRXJBJvMjOeqEMYOHYTTMPFK+LVLaIBwP+2ZkDLPX
         FiHAgsS3nGSyP2LFzrXG/yS6WsW5jGamSFg+pd4lJcADOqfBnM7paOnYbMIWE37QSXYt
         MrHk6WO39/DMLSJDnRaphxKh29xeyiBKEg9Z0YAtesLdj6u2EHkUc/a80LEBWmN4IjcC
         JsH7+rt/OZPR+ZhBAY7L15v/IZmYWaD4G/NXx8COe2PPaIoshKGcWoEzpeGM6p8UFLqw
         BAc4bTgikmZ66w+KLUeTxqJzvoPXJhD79ox7f6PXn80B5dkLbvLCjeh3clflKycN/aL8
         qHkQ==
X-Gm-Message-State: AOJu0YxfGwvbKfWhLs16nYbzRaZBPV1Kp9eNG6BzSIQ23QbN3ANUmUgZ
	iQd5xc4eP8siDyWHENLFyn9EQyhC9OzqX6APcaK6BT9aZPOoNgvwqQNuq3Z0g7nheq9rz40rpC+
	srh98pA==
X-Google-Smtp-Source: AGHT+IFPo+8PokzS9QOyM6j+t9/dQRGOBwJyEq7vewehHm2uSy1nafNx7TMGHPFlxF0V79+ifbsl9Q==
X-Received: by 2002:a17:906:5aca:b0:a2a:19c8:e4ef with SMTP id x10-20020a1709065aca00b00a2a19c8e4efmr1183058ejs.141.1706129293071;
        Wed, 24 Jan 2024 12:48:13 -0800 (PST)
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com. [209.85.128.49])
        by smtp.gmail.com with ESMTPSA id k14-20020a1709065fce00b00a28aa4871c7sm241360ejv.205.2024.01.24.12.48.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 12:48:12 -0800 (PST)
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e76626170so65476055e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 12:48:12 -0800 (PST)
X-Received: by 2002:a05:600c:4ec9:b0:40e:a3aa:a463 with SMTP id
 g9-20020a05600c4ec900b0040ea3aaa463mr1545745wmq.20.1706129271244; Wed, 24 Jan
 2024 12:47:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240124192228.work.788-kees@kernel.org> <CAG48ez017tTwxXbxdZ4joVDv5i8FLWEjk=K_z1Vf=pf0v1=cTg@mail.gmail.com>
 <202401241206.031E2C75B@keescook>
In-Reply-To: <202401241206.031E2C75B@keescook>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 24 Jan 2024 12:47:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Message-ID: <CAHk-=wiUwRG7LuR=z5sbkFVGQh+7qVB6_1NM0Ny9SVNL1Un4Sw@mail.gmail.com>
Subject: Re: [PATCH] exec: Check __FMODE_EXEC instead of in_execve for LSMs
To: Kees Cook <keescook@chromium.org>
Cc: Jann Horn <jannh@google.com>, Josh Triplett <josh@joshtriplett.org>, 
	Kevin Locke <kevin@kevinlocke.name>, John Johansen <john.johansen@canonical.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Jan 2024 at 12:15, Kees Cook <keescook@chromium.org> wrote:
>
> Hmpf, and frustratingly Ubuntu (and Debian) still builds with
> CONFIG_USELIB, even though it was reported[2] to them almost 4 years ago.

Well, we could just remove the __FMODE_EXEC from uselib.

It's kind of wrong anyway.

Unlike a real execve(), where the target executable actually takes
control and you can't actually control it (except with ptrace, of
course), 'uselib()' really is just a wrapper around a special mmap.

And you can see it in the "acc_mode" flags: uselib already requires
MAY_READ for that reason. So you cannot uselib() a non-readable file,
unlike execve().

So I think just removing __FMODE_EXEC would just do the
RightThing(tm), and changes nothing for any sane situation.

In fact, I don't think __FMODE_EXEC really ever did anything for the
uselib() case, so removing it *really* shouldn't matter, and only fix
the new AppArmor / Tomoyo use.

Of course, as you say, not having CONFIG_USELIB enabled at all is the
_truly_ sane thing, but the only thing that used the FMODE_EXEC bit
were landlock and some special-case nfs stuff.

And at least the nfs stuff was about "don't require read permissions
for exec", which was already wrong for the uselib() case as per above.

So I think the simple oneliner is literally just

  --- a/fs/exec.c
  +++ b/fs/exec.c
  @@ -128,7 +128,7 @@ SYSCALL_DEFINE1(uselib, const char __user *, library)
        struct filename *tmp = getname(library);
        int error = PTR_ERR(tmp);
        static const struct open_flags uselib_flags = {
  -             .open_flag = O_LARGEFILE | O_RDONLY | __FMODE_EXEC,
  +             .open_flag = O_LARGEFILE | O_RDONLY,
                .acc_mode = MAY_READ | MAY_EXEC,
                .intent = LOOKUP_OPEN,
                .lookup_flags = LOOKUP_FOLLOW,

but I obviously have nothing that uses uselib(). I don't see how it
really *could* break anything, though, exactly because of that

                .acc_mode = MAY_READ | MAY_EXEC,

that means that the *regular* permission checks already require the
file to be readable. Never mind any LSM checks that might be confused.

           Linus

