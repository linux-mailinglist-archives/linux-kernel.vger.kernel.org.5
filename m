Return-Path: <linux-kernel+bounces-128627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B89895D32
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 21:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F4B1F272A8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 19:58:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C835015D5A4;
	Tue,  2 Apr 2024 19:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="LNtqNNSK"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2356015B146
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 19:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712087870; cv=none; b=Et153bRxUS72a7BIKhiD7t83AuDb+HKd8ZGQq7kuDaepoefx+C7VyBpIxz5TebT3CjaGbdoc7HuM4h65LzrJTMvlQeoe5UALERHaFSuvXSfKcMa2wURXRskmr4aFjpUKVdeNolZA/dyhA5mySSJcHAvWtRcceIqbxb2lSqKhOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712087870; c=relaxed/simple;
	bh=dktNbJSE4AMUUSXBqDMDbOSzD2AIdHi/2em6bOnXPak=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sLV/IfllqhI59XOI03WIRTqk6zmH6Y7+OG7ijEGJR3XJC1c2FljtiTf5xZwcOt3fXD1lSI/vOBTr//UHG32zo7czk1eAI0HPGL9r7iP9fpUHoz3TJ1VcWOmedphCZHTgqAAv/7jAhDB6j7yxKOaNClkXS27qWGMG75RTx0V7QNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=LNtqNNSK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466e53f8c0so735856466b.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1712087866; x=1712692666; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=LNtqNNSK2bxx5ZBmRwBbbisytbYWfxwNUm4pCONxSDiyQA4x40LNM9pwUOlV9l6SBd
         dq3annfM35j9CkSniihaifFKA/I9XrLJv1LyYi9GqAKPmLaNy4iSI/Xcr8gfRZo5AXsE
         30yfgTyqewyZ1yQ9OivJubpMkTgvXkjWl0ff8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712087866; x=1712692666;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xZSMPyJcLDwQQyPD929o3b508jAKY9ueBln0f3F7O4Q=;
        b=O+BXNUdSe+iJwZxRm78r5ZRQsD5Zp8d+oY1bP4BghGWJU2Im70FHjJGVVvH7DVPgEf
         4iEdUEoiBnqZ1xzVynKs5FIoIzVcXDBbviNTdn+4o3njyXqAuhz0tSMsEa0GvgvcpBF4
         Qt+ztFvWR4Nj4TMWJcBvyEdmkwF/Vz1PxImPhs9IOIGpaaYmAvK3JIlqNgBuBGCYVsAk
         vdcoiKodMEE9fdMZut1Wx4NdBSOUiUuSuEYNBLgFj3kUOWTWUQqvEevVm0du3PYGjM3C
         tAJXTPPgg3I5pIzOqFPE8xqLzaXsCOX9KfFZ3/CMS/mt/8Zh5sN/gyjULe8aNui93gyo
         K0ew==
X-Forwarded-Encrypted: i=1; AJvYcCWlQtkCWpvegSrzaJTfZRz/jqqK63E6Sb/QyyFWVqO1qOQAX/18cidj8mBW/t0mQ9UjNmLh8ilQdoU7plaBCAV5uacT/+TPjhOzcR6e
X-Gm-Message-State: AOJu0Yxc34xSwJ9Em+ONmF7jrQpc5qpMTurSu7kWJcqRQ8iNKVAjQQ4M
	sRH38vXhfpv84hrcH8RFlYiFmf3euf/QD8YHmRfQ967PSSSRjTVP5Qg1tu8/Rb5QbAFPewVJJPW
	IaKY=
X-Google-Smtp-Source: AGHT+IGSRUogylczAMlJ3YJqYheuVqinrlm/rv0jhNgzxb8cLrJckbJ2i8QVHQ3ZLhTJEl28EF4Myw==
X-Received: by 2002:a17:906:5290:b0:a4e:2d07:70a6 with SMTP id c16-20020a170906529000b00a4e2d0770a6mr9794605ejm.44.1712087866394;
        Tue, 02 Apr 2024 12:57:46 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id lo3-20020a170906fa0300b00a46a3ad035esm6996305ejb.179.2024.04.02.12.57.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a4e39f5030dso560611166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 12:57:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVCmeoSvmz9hdmT04LVUk7a04zLRYt1+vkoxalcCb9VH/8W5TMZr3+64FYcrPzbwpsiSD/GrtLUK5ko6aWP/KzPKtOPV+qAbvzKzS3l
X-Received: by 2002:a17:906:5794:b0:a4e:7b8e:35ae with SMTP id
 k20-20020a170906579400b00a4e7b8e35aemr3749307ejq.38.1712087865212; Tue, 02
 Apr 2024 12:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240402141145.2685631-1-roberto.sassu@huaweicloud.com> <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
In-Reply-To: <CAHk-=wgepVMJCYj9s7J50_Tpb5BWq9buBoF0J5HAa1xjet6B8A@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Tue, 2 Apr 2024 12:57:28 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Message-ID: <CAHk-=wjjx3oZ55Uyaw9N_kboHdiScLkXAu05CmPF_p_UhQ-tbw@mail.gmail.com>
Subject: Re: [GIT PULL] security changes for v6.9-rc3
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: linux-integrity@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Roberto Sassu <roberto.sassu@huawei.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 2 Apr 2024 at 12:39, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>

>    void security_path_post_mknod(struct mnt_idmap *idmap, struct dentry *dentry)
>    {
>   -     if (unlikely(IS_PRIVATE(d_backing_inode(dentry))))
>   +     struct inode *inode = d_backing_inode(dentry);
>   +     if (unlikely(!inode || IS_PRIVATE(inode)))
>                 return;
>         call_void_hook(path_post_mknod, idmap, dentry);

Hmm. We do have other hooks that get called for this case.

For fsnotify_create() we actually have a comment about this:

 * fsnotify_create - 'name' was linked in
 *
 * Caller must make sure that dentry->d_name is stable.
 * Note: some filesystems (e.g. kernfs) leave @dentry negative and instantiate
 * ->d_inode later

and audit_inode_child() ends up having a

        if (inode)
                handle_one(inode);

in it.

So in other cases we do handle the NULL, but it does seem like the
other cases actually do validaly want to deal with this (ie the
fsnotify case will say "the directory that mknod was done in was
changed" even if it doesn't know what the change is.

But for the security case, it really doesn't seem to make much sense
to check a mknod() that you don't know the result of.

I do wonder if that "!inode" test might also be more specific with
"d_unhashed(dentry)". But that would only make sense if we moved this
test from security_path_post_mknod() into the caller itself, ie we
could possibly do something like this instead (or in addition to):

  -     if (error)
  -             goto out2;
  -     security_path_post_mknod(idmap, dentry);
  +     if (!error && !d_unhashed(dentry))
  +             security_path_post_mknod(idmap, dentry);

which might also be sensible.

Al? Anybody?

                Linus

