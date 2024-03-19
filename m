Return-Path: <linux-kernel+bounces-108226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE592880810
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 00:10:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A2C2F284CC1
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 23:10:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1822C5FB8B;
	Tue, 19 Mar 2024 23:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="c/QF7TMa"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA81A4F889
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 23:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710889816; cv=none; b=iBHr6R6ucJa2me6kh08ZPkpEPDQZxe24jE7rP+RLmkuERNDpsx/8Zu5+nP1XcZx3vIMS8WNZQXW9Vmtuqg/KOp3Yoz7/uKWVFxZFwg2l3MzC7ZP2u4wAb4SIpE0a6DQn6EJfb8wTA8iF37nWqla66aWpd5tnW+vPuGBWfZ6tvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710889816; c=relaxed/simple;
	bh=n2hwhhpCp+wrS8iH5XBuAd5W5hKp1kphMF+/gXoFfXA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EKa5ZxW9tK/4d2gv9Dx51FnV2rZAj3Lnr8//9iCVVquNwEc+gfB+3itovNiXHqgT6nocAE8bzBhKJRiqP8KHGNuN+2FP5DH9ngOyZNH94GE6b/SoqTlGnKIF7+NGBnsIba48iuR6BeQi23oiE3QgTeXGCGgX6iztadW4jbbpGM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=c/QF7TMa; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5563866276.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 16:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1710889813; x=1711494613; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+dHH9ODplRPDsF7SLLanW1hsK5MRMZ53v3XJwlytqw=;
        b=c/QF7TMaLp6yUZO44kvhv4DltTfXDhHCHdYZxZY51HjneZ14x8gZrL+qr+oql8uVnL
         HJWKL9ghAvhcw+W2Fqk1teId9IpRR4NDF9ty3xv8puyvLZIPq0F8+To4fHZU5Y3uPU46
         ISrYhRw//mbf/dUE7Pwcw1k3HYujLXanZv/1W4JekHu+LCO2dPElFLsbRMYaG9m/4Q/p
         Ma8LeMFPZ4zEnxN1JxfdQJ324TBJGpHfT9Umt5B+vDPGdDCZTuofMYxS54iQ6MqaOpL8
         FJFv0SfoWFso7z3O6fb9536wLzo1J3YElC6/Wb0W9dEbyhz+xyeXDh0k94z8bubCsnoI
         RPIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710889813; x=1711494613;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C+dHH9ODplRPDsF7SLLanW1hsK5MRMZ53v3XJwlytqw=;
        b=U1aeZ2UcyYkRDVF4cIn18fz1tahS0APEt/NsXItGyNfDTHxtsWxD7Go3cXqAQnKzX4
         AsZi3M8FFXTzA8ctHIn28vxRIcaZhxggEr1Gzv3O5n+TWHRgNEvK2a9Pzp3A+ktL8SKd
         wnFY8hYSLgINs5ZCKnmbvks7EUb/1Rft4QQlcCMMY2zn265I4iOfXB7t9iboZogq7fFZ
         r0u8umsz+tUHsCs/Hg7WCksL3GTAxWiC1UFF77ZJi/fnXkZkTEw/pwWrKaNjCPi3GmqO
         31AddNIq++uw+oKUxeeg5xnpTsRiFAtcd3kvqDz2CuLYVvjRYXzKWJJCNqfPxjnjyvGT
         h8EA==
X-Forwarded-Encrypted: i=1; AJvYcCXCIJLyPoaly7Y5DlvE4mUNE4tEc+WADYGsLiYVGr3EtitNdgusEAml9OjMS+pa/o+Gvjp/FdxT5bxvLnNAb9bCpylVMNsqn1dSyF7s
X-Gm-Message-State: AOJu0YwzRj7qp3VlMNeTijHOoUwldB1Jk6wC4pu+4GnQhpoK2MUaExEo
	2uJTzyZJND22L8JhyEf8rfsm7KfROxGCW1NSVYC/JNJ5fdpvqc5b8dAJmsj7SsyqA3YoEYNB9tP
	CwwJMiEUqbLHaGT8H7KD4RBHfVqV+Q53wDW/9
X-Google-Smtp-Source: AGHT+IG3Yh4bbfa1wN00q4KaF6p48afEQKOxM8IY1af14YL2d/7MolgsUvabXrQz8hWdkCEJDKcZlgNSYZvMusHk3aM=
X-Received: by 2002:a25:a547:0:b0:dc6:cf96:2956 with SMTP id
 h65-20020a25a547000000b00dc6cf962956mr14662766ybi.44.1710889812886; Tue, 19
 Mar 2024 16:10:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240315181032.645161-1-cgzones@googlemail.com>
 <20240315181032.645161-2-cgzones@googlemail.com> <CAHC9VhRkawYWQN0UY2R68Qn4pRijpXgu97YOr6XPA7Ls0-zQcA@mail.gmail.com>
 <5368DC74-41CF-4450-AF6F-FFB51EFCCF99@kernel.org>
In-Reply-To: <5368DC74-41CF-4450-AF6F-FFB51EFCCF99@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 19 Mar 2024 19:10:02 -0400
Message-ID: <CAHC9VhTpTbVL4=tchR3Bpcfe0Hsijf5XJ6wsEvU7cu8eUy_iDA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/2] lsm: introduce new hook security_vm_execstack
To: Kees Cook <kees@kernel.org>
Cc: =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>, 
	linux-security-module@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, 
	Kees Cook <keescook@chromium.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Khadija Kamran <kamrankhadijadj@gmail.com>, 
	Andrii Nakryiko <andrii@kernel.org>, Casey Schaufler <casey@schaufler-ca.com>, 
	Alexei Starovoitov <ast@kernel.org>, Ondrej Mosnacek <omosnace@redhat.com>, 
	Roberto Sassu <roberto.sassu@huawei.com>, Alfred Piccioni <alpic@google.com>, 
	John Johansen <john.johansen@canonical.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:24=E2=80=AFPM Kees Cook <kees@kernel.org> wrote:
> On March 15, 2024 1:22:39 PM PDT, Paul Moore <paul@paul-moore.com> wrote:
> >On Fri, Mar 15, 2024 at 2:10=E2=80=AFPM Christian G=C3=B6ttsche
> ><cgzones@googlemail.com> wrote:
> >>
> >> Add a new hook guarding instantiations of programs with executable
> >> stack.  They are being warned about since commit 47a2ebb7f505 ("execve=
:
> >> warn if process starts with executable stack").  Lets give LSMs the
> >> ability to control their presence on a per application basis.
> >>
> >> Signed-off-by: Christian G=C3=B6ttsche <cgzones@googlemail.com>
> >> ---
> >>  fs/exec.c                     |  4 ++++
> >>  include/linux/lsm_hook_defs.h |  1 +
> >>  include/linux/security.h      |  6 ++++++
> >>  security/security.c           | 13 +++++++++++++
> >>  4 files changed, 24 insertions(+)
> >
> >Looking at the commit referenced above, I'm guessing the existing
> >security_file_mprotect() hook doesn't catch this?
> >
> >> diff --git a/fs/exec.c b/fs/exec.c
> >> index 8cdd5b2dd09c..e6f9e980c6b1 100644
> >> --- a/fs/exec.c
> >> +++ b/fs/exec.c
> >> @@ -829,6 +829,10 @@ int setup_arg_pages(struct linux_binprm *bprm,
> >>         BUG_ON(prev !=3D vma);
> >>
> >>         if (unlikely(vm_flags & VM_EXEC)) {
> >> +               ret =3D security_vm_execstack();
> >> +               if (ret)
> >> +                       goto out_unlock;
> >> +
> >>                 pr_warn_once("process '%pD4' started with executable s=
tack\n",
> >>                              bprm->file);
> >>         }
> >
> >Instead of creating a new LSM hook, have you considered calling the
> >existing security_file_mprotect() hook?  The existing LSM controls
> >there may not be a great fit in this case, but I'd like to hear if
> >you've tried that, and if you have, what made you decide a new hook
> >was the better option?
>
> Also, can't MDWE handle this already?
> https://git.kernel.org/linus/b507808ebce23561d4ff8c2aa1fb949fe402bc61

It looks like it, but that doesn't mean there isn't also value in an
associated LSM hook as the LSM hook would admins and security policy
developers/analysts to incorporate this as part of the system's
security policy.  It's great that we have all of these cool knobs that
we can play with independent of each other, but sometimes you really
want a single unified security policy that you can look at, analyze,
and reason about.

Regardless, my previous comments still stand, I'd like to hear
verification that the existing security_file_mprotect() hook is not
sufficient, and if its current placement is lacking, why calling it
from a second location wasn't practical and required the creation of a
new LSM hook.

--=20
paul-moore.com

