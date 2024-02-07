Return-Path: <linux-kernel+bounces-56788-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B6E884CF34
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 17:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BE1282394
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:45:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E56A81AD3;
	Wed,  7 Feb 2024 16:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="Q6PXEEPK"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6866C81AB5
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 16:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707324315; cv=none; b=tcA7UU9zxleI9eU4THFELuyAKzSdzNh9xyW006oKNNHTF2MotfyamDiBQqH1vEdzC8Tybd/UV3NltVfCEsZZOth5aIX887g1FtldR+YO6SPkHhPVHRAorH71U1s3jZUe9PDTRD8VO4uDZzGAJQ/0aPc4b23n4TDRwc0gR4ZM1pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707324315; c=relaxed/simple;
	bh=jX1o2DqvrsVX0Ygwc04l+jqit2/Rd//ugPrvxIoI0Uo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EWghalxqu++90jJ9Os9fKDOob4lQZTk7KFEH/Qfd9obAXqJivUXbpiwlW0cOoJA9wlofzCI+JJCWlwS7PjwQX5jdiYjrFtVdr103Kojc9PtXJkrWbfYlerw1GNLvVPK3KSKnGb53MOhpTWbaUlCnYFWZSFZ+ZXojqkvXeSFw64k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=Q6PXEEPK; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dc6d5206f18so826337276.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 08:45:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1707324313; x=1707929113; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u+RVmbChygOBAmJgHT868vpaz7uzT1TsygZuYJ78CkQ=;
        b=Q6PXEEPKhVwQ0kPkyUuCmFZmJvRBtJDjCwG92W00qtmlbKFfQnCxuiLerP3Eht2KzT
         tMh962ihgzeOX704jHS7OdJSNAN7MobRFV67cUF2Ni+rxAG+ZCer0YIgPs2sHsYi/pkq
         q9DAqtlbesMRkBAxR2REnehYh+mc+dNa11SKxdVlzBjTwRoOOD9jmsnBRCoC3Ta43mKB
         HmLP1hNmtYhBhzN3fMYLi9OAht/3DWzoKqyH9+PcO2TU5hvcVBTcY3ICsNgU51cvGjDZ
         IhAvsczAwFIkSzvxh1iET00m3Cda+utAsMpWG6yU8H/sof51MAtjq/uRoidY/Cn/3BnL
         w5kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707324313; x=1707929113;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u+RVmbChygOBAmJgHT868vpaz7uzT1TsygZuYJ78CkQ=;
        b=Cpk4Yui5ACC3zV9nN95wksergpmlKuOHi2v6284kIUF7iYkuX2oBKe+POa4m34g8Ty
         updPyn72R/e2dSkbHNG2BQ7Sv+vr2MnsYUvSP5YVu9yWfyYqL3tPVhZWTm9HZTmjzM3V
         Xh0vzSC6jorkB/UWLu0p2ZZqJme1p5Xq6DwFsKgXUmrCJFrifQeu2Nov/RA7QYQGr4AE
         HT0R/8yPjFOiMgSDKIaDtFvsytKpGPO4N6bamgP3lwbx8R/wPeqyppzhS+CLmzscWc1i
         o4a5duXGC1YnBbpbUiQe4n+hhDCuqhT8FxUYdsglPL34577QygicZXofA6YCHqiSjXvu
         N1Gw==
X-Gm-Message-State: AOJu0YxlBzRs9iM4VIFDL9zQS+ttaLFcsRyOUFsnHwAA/vZf9BBbnUs7
	YuZSkUgYiDbhttbH9a4zyN1BDaTAgl+15cOkDlEViP3LXx+Du2oJesRpMCnx1GjDuKR73xjXcOK
	vwRC5FVHLvobT3Y5aHB2aBJVYeu8PPPY37bnq
X-Google-Smtp-Source: AGHT+IHRgcgMxbkrsPyJQIEFMLZQE+5SzwFbUZBRUzL4DU8q0Ya24A0FTp6644UsHQnVPJ1XIg6pqBWs0HQgn0Qzw7s=
X-Received: by 2002:a05:6902:1b05:b0:dc6:898:150d with SMTP id
 eh5-20020a0569021b0500b00dc60898150dmr6082425ybb.25.1707324313368; Wed, 07
 Feb 2024 08:45:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8fafb8e1-b6be-4d08-945f-b464e3a396c8@I-love.SAKURA.ne.jp>
 <999a4733-c554-43ca-a6e9-998c939fbeb8@I-love.SAKURA.ne.jp>
 <202402070622.D2DCD9C4@keescook> <CAHC9VhTJ85d6jBFBMYUoA4CrYgb6i9yHDC_tFce9ACKi7UTa6Q@mail.gmail.com>
 <202402070740.CFE981A4@keescook>
In-Reply-To: <202402070740.CFE981A4@keescook>
From: Paul Moore <paul@paul-moore.com>
Date: Wed, 7 Feb 2024 11:45:02 -0500
Message-ID: <CAHC9VhT+eORkacqafT_5KWSgkRS-QLz89a2LEVJHvi7z7ts0MQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] LSM: add security_execve_abort() hook
To: Kees Cook <keescook@chromium.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Eric Biederman <ebiederm@xmission.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, 
	linux-security-module <linux-security-module@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 10:43=E2=80=AFAM Kees Cook <keescook@chromium.org> w=
rote:
> On Wed, Feb 07, 2024 at 10:21:07AM -0500, Paul Moore wrote:

..

> > Please hold off on this Kees (see my email from yesterday), I'd prefer
> > to take this via the LSM tree and with the immediate regression
> > resolved I'd prefer this go in during the upcoming merge window and
> > not during the -rcX cycle.  Or am I misunderstanding things about the
> > state of Linus' tree currently?
>
> My understanding was that TOMOYO is currently broken in Linus's tree. If
> that's true, I'd like to make sure it gets fixed before v6.8 is
> released.
>
> If it's working okay, then sure, that's fine to wait. :)

Okay, let's get confirmation from Tetsuo on the current state of
TOMOYO in Linus' tree.  If it is currently broken, I'll merge the next
updated patchset from Tetsuo into the lsm/stable-6.8 branch and send
it up to Linus during v6.8-rcX after some soaking in linux-next.  If
it's working, we'll wait :)

--=20
paul-moore.com

