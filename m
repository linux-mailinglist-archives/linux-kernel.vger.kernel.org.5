Return-Path: <linux-kernel+bounces-73789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED82C85CB3A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 23:58:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 65B1D1F22B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 22:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12EBD154439;
	Tue, 20 Feb 2024 22:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="RpAGfWLP"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133C15442A
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 22:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708469834; cv=none; b=oDhNRXRBx63CSeGX/yaAa99zk6wNW0P1iVhUad92jCSZ+A6J07ipqyeudCXPxpxeQQyntnwgpG4T2n/26g4Q10FFEFeP+Obw1CxesE6pcFhFXBVWIa91tzQj4vZcQWOybNlz6TpRw8n86MBu9muofTjY8JpWa+GwLnVQ7VufVKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708469834; c=relaxed/simple;
	bh=0YoTDIJcncc26mTV5po/0I8NONU1TIZscyHen9QSqfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LdXHqGLs9OWJjiPLRdQ/8GwGTxcSyJA56gcprLWthEEePFEzLp8zjoOaHHDSkeRYrexS56iwyvkAtIXnRsXSDUlS+HSSuGuIhbJebZnixCSkIyNG6e737DGRpfgp5fwTNv7vRYmPvdVZKNEWApcoiwI/AtqlXMxFyBjCoqJIMjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=RpAGfWLP; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6e080c1f0so5587911276.2
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 14:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1708469831; x=1709074631; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=RpAGfWLPPDa5nT1skE2IjquSvPCpH4XDjqXhHemyIuLz/hdLFGrOI1tMaygPMyiCVs
         q1vL4So8FLcrldPFKwFwxHFIOlY3Tn9XtYh0dp0OU9mZt1hPj1KBXbigYV7RhBWQ72m3
         /5oWhtMSkEItzPCnERUndzCdoGbwMpLUX4LwXn+8CwqgLtjgehsJeMbx8stcuhe+DiQq
         9DTWoLBnlupgUmDPko6bERx8iVPqd/o3z4lCax8zyHitOjbWF5QwbAOx1z9SvZjJtvoX
         Va9Q7470lI85S94fjTf32AqcWVxq857I6+nq+RDXXdOmVqQUPU2L2VNe4GAXhWQ8FpVE
         RPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708469831; x=1709074631;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GJd9Z95KHyUDEhlhjVDF9yk1T1M4Mk1fPdy0+yG5dqM=;
        b=N2MxaoobdfXfib8Je/FEtAyxd+wN9p6nzMRD2fLgrxqaRJ47ZuKrlUWdFJ19Ch3Sql
         mxy3iNE7QCBwQf8iSWb+NjbgTd+Kv3m4aO9I8uCwCXgm+ka6RHv3GqdlujabSwhubIDb
         NNAQZy1hNw2rE7o9CR6jrQmaFSp1oSYsbX8R8rFLPjBtbyinvfkbN9asKX5z1NjWqr55
         114CPW1KcVKOzVetAidQrM+qKM1dKB1HBtpfT7XUROaGQjlmvgOlr2mrL8Lhx2LOLHW1
         ZOvZ7snbs7mlguws+fnvUKD/BoUEDCmb016EVJkrWUPSXFCu6tQBWztZFt6rdYeTZoTB
         ep/g==
X-Forwarded-Encrypted: i=1; AJvYcCWJ4BjJc173JAwZWAs5hIXhJDCejWbiw0BoW5qxOuGiAiE3jEaYioRlq3aDfrqAB9FRx6Ji7GoV7Mfdwkg9+SGxYs0uWDbDzHSx3567
X-Gm-Message-State: AOJu0YxmBprv0ccbOQBpM96EOUSz8TyflSsqPLxDbpLuau6qNeCFBspV
	FCtd/u6BEb11D1R7AqOH4likvZIz5+vHRK8WRR0ocYQSx8vp2dysx/v3wRr7+8HqXYuetBoSKwm
	FSEbyXGYrcXTo5BqLhbH6WvqusUpyb7uKUl21
X-Google-Smtp-Source: AGHT+IFHQeTBpph6bd5Wo+fr48nsOpy94ua8Yw9g49gmhGuBFZaV/bAGvI69UADzVdw79h3Ed3LE/pbEkd6/IuyV7L0=
X-Received: by 2002:a25:ef0d:0:b0:dcd:ad52:6927 with SMTP id
 g13-20020a25ef0d000000b00dcdad526927mr16249258ybd.11.1708469831057; Tue, 20
 Feb 2024 14:57:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240205182506.3569743-1-stefanb@linux.ibm.com> <20240205182506.3569743-3-stefanb@linux.ibm.com>
In-Reply-To: <20240205182506.3569743-3-stefanb@linux.ibm.com>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 20 Feb 2024 17:57:00 -0500
Message-ID: <CAHC9VhQeJGjm5VCF84W_u2wRZxHtWPMt_Ku-NqJpXUaA53EtVw@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] security: allow finer granularity in permitting
 copy-up of security xattrs
To: Stefan Berger <stefanb@linux.ibm.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-unionfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	jmorris@namei.org, serge@hallyn.com, zohar@linux.ibm.com, 
	roberto.sassu@huawei.com, amir73il@gmail.com, brauner@kernel.org, 
	miklos@szeredi.hu
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 1:25=E2=80=AFPM Stefan Berger <stefanb@linux.ibm.com=
> wrote:
>
> Copying up xattrs is solely based on the security xattr name. For finer
> granularity add a dentry parameter to the security_inode_copy_up_xattr
> hook definition, allowing decisions to be based on the xattr content as
> well.
>
> Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
> ---
>  fs/overlayfs/copy_up.c            | 2 +-
>  include/linux/evm.h               | 5 +++--
>  include/linux/lsm_hook_defs.h     | 3 ++-
>  include/linux/security.h          | 4 ++--
>  security/integrity/evm/evm_main.c | 2 +-
>  security/security.c               | 7 ++++---
>  security/selinux/hooks.c          | 2 +-
>  security/smack/smack_lsm.c        | 2 +-
>  8 files changed, 15 insertions(+), 12 deletions(-)

Acked-by: Paul Moore <paul@paul-moore.com> (LSM,SELinux)

--=20
paul-moore.com

