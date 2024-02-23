Return-Path: <linux-kernel+bounces-79178-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55803861E84
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 22:07:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B371C23C6E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96E5A149388;
	Fri, 23 Feb 2024 21:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CpbZ+1ON"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38B67146E71
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 21:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708722451; cv=none; b=XPywkOo2XwmjR3HT55T1BNgbNITq+EJ8CM7jYXxiSnS1cu5wTTiiCZ5n+aNvSqa3S5voabdWXdp752DfPMzdxOKJuEyDPvc5HGpgqrqN9t6870+A1iCmsie4tajI7yvjHEXMsKDZAIWi+mHBbDIxZKTbf5qr4JWxrg0Cl0oH5MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708722451; c=relaxed/simple;
	bh=6VgQr8fJjg6fEs6AHFjmsFnIQHc5a5uEmdWg5mQPymA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qUeXshgEz2gH/Y+hYwK961dCFLE8rnSlGre8QG9kFEz/dyq9paM1onvXf+mDQ+ehHxgn05HLwt2MwM5PnKJ8Xt86mi7WltmCWesOZvN0yuH8N5qcAS0zSMh043MzjPekOATz7IydI17s4fcygn/4EhDalsm7uN2vlSMcKo7ifdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CpbZ+1ON; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6087396e405so6931787b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 13:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708722449; x=1709327249; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=CpbZ+1ONoL4hAF2MgBVMj9+mDIUgqyyn2Rm0f6MXSEW7qL6SCnfVpPtW/MwXPpa3NG
         kZWWX7CumzKC5qLo4sP3uyGIa7FtcWmhi7C0HxIaKTCwUAM5DeFmd5hgrOWCefMeeCHU
         gC60pChbSpNcR42yqtujInW2HBd8I2l9aTLH5jDZxYaU9hIpZhsb1se8Du8BoKhZfeuN
         djJuvHVC7vEc7XuVFqFbUKmMPtEWcoGWkkNg519RijfyNs8orSCX8XnAoaRBCBNHHzDq
         bfvuirSyKlz3isF1tLaVmflxPZa4PfKELAvanWuHsnD3HJoIRe4GKWCJ3tWFCjARswO8
         Tfqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708722449; x=1709327249;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HTVIr1+DQqd7VndTuddH8HDUIEhAoCQ0AKItibRMycI=;
        b=uV9+ugiWzJ25I/X42mcMQ9URDkyho8HWxg6TUQzhzQ1eJrFf6JN1+vkKqAKeN2ADeB
         /igyZZ49tFstPRbrbAE3WhYnOfoC+icjAIx2/OTPeQj1AmgH7VE+WcNKXR/zTGPLHA1A
         EjVBIf+zq1sNzHAVXqMgHS+T2NtEgmYeoF1ovVKKQlH43lDOpT28SiMtSPIGZyGOBDL7
         FrUSFayS3ZXwAQAs1utWrpRms/5SukalvN+Tp4aWMSL6Py6bfrOpdend2bU/F82LZbzn
         qAfxwjGftnL087ilhKS7myiSdpxBy3lH16nUrzzEVKUcE4lN8nxfvl4+JBv96aPYHhh8
         9wpQ==
X-Forwarded-Encrypted: i=1; AJvYcCWP5voIKHnblCNIOB0OaJOZGcd36hEtlOY5FDvCrQ0a7apvvMJHdhV/0ExwmKptnKLADk8LRt8ze0iLuOulBvOZAMuopZ2wL4zPUPrR
X-Gm-Message-State: AOJu0YxXLjuyoZA7+ZZ8+jHEkuPJDJZCBoGtZoTvE6IfhymnM2IAs/5v
	U9nZP1PAIlRfIbf6eN1wIEqROuSXx98CQCVFPU7xL0QXXv2gLCCqy0tSyYoW7Q/okEK/mG5Ehn7
	ZyxqjZXLQ4GhSclLanJua+IqkaZMVa+2bfJVw
X-Google-Smtp-Source: AGHT+IFzOTG2gqhjwIuQqFrSF9kYO7XKdQQqylj7QZT68fEwlWe6kyHm8630oV+XgrXsN2qoMyNAn4/rC/VdW5ppCKY=
X-Received: by 2002:a25:b215:0:b0:dcc:97c:5754 with SMTP id
 i21-20020a25b215000000b00dcc097c5754mr892475ybj.5.1708722449224; Fri, 23 Feb
 2024 13:07:29 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240223190546.3329966-1-mic@digikod.net> <20240223190546.3329966-2-mic@digikod.net>
In-Reply-To: <20240223190546.3329966-2-mic@digikod.net>
From: Paul Moore <paul@paul-moore.com>
Date: Fri, 23 Feb 2024 16:07:18 -0500
Message-ID: <CAHC9VhQGLmeL4Buh3ZzS3LuZ9Grut9s7KEq2q04DYUMCftrVkg@mail.gmail.com>
Subject: Re: [PATCH 2/2] AppArmor: Fix lsm_get_self_attr()
To: =?UTF-8?B?TWlja2HDq2wgU2FsYcO8bg==?= <mic@digikod.net>
Cc: Casey Schaufler <casey@schaufler-ca.com>, John Johansen <john.johansen@canonical.com>, 
	James Morris <jmorris@namei.org>, "Serge E . Hallyn" <serge@hallyn.com>, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 23, 2024 at 2:06=E2=80=AFPM Micka=C3=ABl Sala=C3=BCn <mic@digik=
od.net> wrote:
>
> aa_getprocattr() may not initialize the value's pointer in some case.
> As for proc_pid_attr_read(), initialize this pointer to NULL in
> apparmor_getselfattr() to avoid an UAF in the kfree() call.
>
> Cc: Casey Schaufler <casey@schaufler-ca.com>
> Cc: John Johansen <john.johansen@canonical.com>
> Cc: Paul Moore <paul@paul-moore.com>
> Cc: stable@vger.kernel.org
> Fixes: 223981db9baf ("AppArmor: Add selfattr hooks")
> Signed-off-by: Micka=C3=ABl Sala=C3=BCn <mic@digikod.net>
> ---
>  security/apparmor/lsm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

If you like John, I can send this up to Linus with the related SELinux
fix, I would just need an ACK from you.

> diff --git a/security/apparmor/lsm.c b/security/apparmor/lsm.c
> index 98e1150bee9d..9a3dcaafb5b1 100644
> --- a/security/apparmor/lsm.c
> +++ b/security/apparmor/lsm.c
> @@ -784,7 +784,7 @@ static int apparmor_getselfattr(unsigned int attr, st=
ruct lsm_ctx __user *lx,
>         int error =3D -ENOENT;
>         struct aa_task_ctx *ctx =3D task_ctx(current);
>         struct aa_label *label =3D NULL;
> -       char *value;
> +       char *value =3D NULL;
>
>         switch (attr) {
>         case LSM_ATTR_CURRENT:
> --
> 2.43.0

--=20
paul-moore.com

