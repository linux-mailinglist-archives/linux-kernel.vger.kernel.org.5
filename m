Return-Path: <linux-kernel+bounces-128593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2FAA895CD2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:39:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52F3B1F21D8D
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:39:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538D715B98E;
	Tue,  2 Apr 2024 19:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="P7FTA2jL"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A229F15B962
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712086788; cv=none; b=cstULrYXpuwiA8+xqn9NzpqrqxjLuDREOoDmlSVQR3L3npN098GxAvhqvN4XFOKx6sucx65wgckjPpvGumEY9qLZJEJfHCJjtHzjwqeXsDiCctdsB0onMxM3jPRgtBLR2RzCS6BAmP9sfqZw7wK2thqt4RT1COZRf44yIr4khdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712086788; c=relaxed/simple;
	bh=FUitx7MgiMoEaaLuPTTMRh2BBePYzO9uMUChIAgHet4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qSI/kl8w9FsQyS4sOYVzpJlJkRrVXrzVRe6IBSKjlBKr0dQXt6zow5XMC5oRzBzJw1M3Qh61Z++52q4p1AWJzRQnFE3YBlQJtvaXgY8vMLbJ2fREl+bB0L2sPdsZKMZKMxyAZYupa+/n+CscOFGFiwiEDaFG5bIUG1B7aVMN6Xg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=P7FTA2jL; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a4e8904bd71so142809566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:39:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712086785; x=1712691585; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=P7FTA2jLoXfsCEtkxUDirRllSwd19LRpNYr/iGBO5t318EPrbrZ39u1tsh47t8Ulo2
         jLLSfOpozJBe/dazhfqMaB1G8OpvLowTauwQQ2YFZKFfUiPvepG3XlWsqEcWAfzsx8nu
         FSOKiZGXPGjOb0JnVv0dIIWsYk5w+O1Y38Uic=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712086785; x=1712691585;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0mQeGyOEkrbKK1USpW42EOtHV5nHSHeR2mY3J6ZfsUg=;
        b=OZumzTLLAWHeRfeMvB87Ef5rdX+JjgO5xScBnU8183bvpuc0cY2ylQr7LtZNIzjJyB
         Sjl18NcLcorvzdJCisA3MxT8ej/MfMLIq5AQck0OPIGlNP8QsMjWc8CO9KzAj604QQ+a
         gVCVY4KBV8b+gLlSDIuT2KMYJkyYSRkThKfW9TkMgR28uutDDU9c0wqEM0iYLiLVR64H
         J6y4MQoVnErS8Hl0FdqaSVLGbMUZw41q9QSyNCQTstDPZ9V6RDmLPXli8aAhj5rQ5KRk
         ORlyZG+dx1tPLG3EFnXM4O1aEFFD3K0ecVqWhfzKQ7EDEleTBFQOzOl4b9CBFnfSFuzn
         5M7Q==
X-Forwarded-Encrypted: i=1; AJvYcCUjtq9ZwiarDf8+X4BGNCzpJR3LJR9XkByC7tcjcjctBGORzz4VRcTs06O3+WorihIzXH6Y1Uf9at4foPaRaHmlt2VLmIwy08Gtr7Gv
X-Gm-Message-State: AOJu0YwGDAZmt4szHs2gPuJPvxc9NXsraGAD+ejl7pQR9tUP7ZhE9oDk
	B7zc4M23x3PxEXYJrdYvqp7KdnRitiuIVh/obR2Cgk3GedBVjyl065mKMY+67mZXTeqO22wJ6mX
	x8MI=
X-Google-Smtp-Source: AGHT+IHQsUdIkOotXOMFXq6u1DXx44pQYNnRiTAeyMdoYevb7wlc57/jsOg5TtFtUXHE4aALlYfmWQ==
X-Received: by 2002:a17:906:bb08:b0:a47:3651:a302 with SMTP id jz8-20020a170906bb0800b00a473651a302mr8473774ejb.42.1712086784719;
        Tue, 02 Apr 2024 12:39:44 -0700 (PDT)
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com. [209.85.208.41])
        by smtp.gmail.com with ESMTPSA id qk3-20020a170906d9c300b00a473abcb9fdsm6962122ejb.90.2024.04.02.12.39.43
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso8176334a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:39:43 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXvVctNH7ypGFHtXkAm2T6levq45NF/TKNqwb9NWpnCFSvbvNqUDtdQUV7nWjyrktiVZCykMsoLuZhfB03fX/aghcSAyXHb4xR7v8mF
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr8673776ejc.55.1712086783205; Tue, 02
 Apr 2024 12:39:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
In-Reply-To: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:39:27 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Message-ID: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 07:12, Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
> A single bug fix to address a kernel panic in the newly introduced function
> security_path_post_mknod.

So I've pulled from you before, but I still don't have a signature
chain for your key (not that I can even find the key itself, much less
a signature chain).

Last time I pulled, it was after having everybody else just verify the
actual commit.

This time, the commit looks like a valid "avoid NULL", but I have to
say that I also think the security layer code in question is ENTIRELY
WRONG.

IOW, as far as I can tell, the mknod() system call may indeed leave
the dentry unhashed, and rely on anybody who then wants to use the new
special file to just do a "lookup()" to actually use it.

HOWEVER.

That also means that the whole notion of "post_path_mknod() is
complete and utter hoghwash. There is not anything that the security
layer can possibly validly do.

End result: instead of checking the 'inode' for NULL, I think the
right fix is to remove that meaningless security hook. It cannot do
anything sane, since one option is always 'the inode hasn't been
initialized yet".

Put another way: any security hook that checks inode in
security_path_post_mknod() seems simply buggy.

But if we really want to do this ("if mknod creates a positive dentry,
I won't see it in lookup, so I want to appraise it now"), then we
should just deal with this in the generic layer with some hack like
this:

  --- a/security/security.c
  +++ b/security/security.c
  @@ -1801,7 +1801,8 @@ EXPORT_SYMBOL(security_path_mknod);
    */
   void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
   {
  -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
  +     struct inode *inode = d_backing_inode(dentry);
  +     if (unlikely(!inode || IS_PRIVATE(inode)))
                return;
        call_void_hook(path_post_mknod, idmap, dentry);
   }

and IMA and EVM would have to do any validation at lookup() time for
the cases where the dentry wasn't hashed by ->mknod.

Anyway, all of this is to say that I don't feel like I can pull this without
 (a) more acks by people
and
 (b) explanations for why the simpler fix to just
security_path_post_mknod() isn't the right fix.

                 Linus

