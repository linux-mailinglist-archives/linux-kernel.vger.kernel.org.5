Return-Path: <linux-kernel+bounces-46951-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EF6D8446C8
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:09:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C521D1F2558C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65B0D131726;
	Wed, 31 Jan 2024 18:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="a2Qzwq96"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9CD612FF8F
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724539; cv=none; b=LMoqkELTkyRhiUya2VV3WABFUBHBjkbwvIYm6ph7mqhi5AFhlaINguvtgJytHL0iaoLLcAUv7F83pumu0doNZkPpDkcXsc/fDlF5Oc/ozFUbxm0mQylOUVE4r9Ab9HxJ3pLnxxS5NDdNRYApShcu1FLkwIbE8KiU5riaDSizNiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724539; c=relaxed/simple;
	bh=blmiXtxuj4mntZApxPDJE7PTbuISn5ro/0Z3J2K+ecM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V3P08+CSs5tQD/lp0xSQ8y1pao2v/9otiAMwmYzaFYfinMwd948m7fDO27T+tM9P8QN0Sh8ZWMS6Elu3Jt7okHxMLTjvcu2TqbsD6GkJ6PrnMYLzX+gPNSaEbOIOZi2YCTUqx1otiFFh0+1HxL45hVyp8YHQ2CMw4Ue7UILvWVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=a2Qzwq96; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d03fde0bd9so1702521fa.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1706724535; x=1707329335; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jdXyGxV7lSUrZp0+m+N5dUYZe5f3ZNHmFavQF3mekH4=;
        b=a2Qzwq96uPAJ9D3CwYnE4rdalysVfrIVUvojhltFYF8wjUQeTjMcppT5kMe/FdtjaG
         KDjAOuvNkGwL2zo1xEplSR8DvOZCu0ICDk9l42U4i6wXAxII+MvVBaIMkB+9Vvifa8vp
         VBQ8VRsaED1oPBnVBOWtIsuEEnqXLfNom89Rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724535; x=1707329335;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jdXyGxV7lSUrZp0+m+N5dUYZe5f3ZNHmFavQF3mekH4=;
        b=bnLQnIElfqGVVf2R3Zb0yzM26LeCz/WPfrX7waJdxgSpgzNfHx46Kt4TAfphiFcpuF
         xRPg0qKspCUuxeJiUpIZrU0mEO3bhxbXi3oj6W5BPgBGnoAScfNQyZHTRoTMLwALNBGw
         58rqBieBu8xs2SoiptVwNChb4GYAnrXJXsdP12cfVMF13QTWRKd0ygXyIII+LARD3qRl
         vKhQC95tSXMZASBfvm479yWtnbnSRZ3qp14ufFfHwx6wueYvwqgFetS1ukq9M2ZZijW+
         fr+AHgG317jnw//S3CvCyZMdBlrtbTHxpDxUNPQpyacdSNg8+inzF++dNzKnLu2uHFGr
         HoJw==
X-Gm-Message-State: AOJu0Yws+j4A+pf+7cG0+RzULamLRj+xIHMNsekPwH/d95bb8VSm6gmd
	pEVkp0lWKHvySbI6JRnVlJD44BuqypOiWI8lG/O9m0CNnIRRIkJCgpZIBFRi4b8zQGOKHe50bRF
	ZVc8=
X-Google-Smtp-Source: AGHT+IFHxeVBmNqE5rUd8JKnfC3eJNzePawAepSHQDzs6lBL1fw9vKK386cs3MPH813H+qNaHrXLjQ==
X-Received: by 2002:a2e:a163:0:b0:2cf:2d44:ee1a with SMTP id u3-20020a2ea163000000b002cf2d44ee1amr1679031ljl.36.1706724535530;
        Wed, 31 Jan 2024 10:08:55 -0800 (PST)
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com. [209.85.208.53])
        by smtp.gmail.com with ESMTPSA id ec37-20020a0564020d6500b0055f8adf1d6esm672080edb.47.2024.01.31.10.08.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 10:08:54 -0800 (PST)
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55f0b2c79cdso41706a12.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:08:54 -0800 (PST)
X-Received: by 2002:a05:6402:35c1:b0:55f:a7d6:fd6a with SMTP id
 z1-20020a05640235c100b0055fa7d6fd6amr225894edc.5.1706724534163; Wed, 31 Jan
 2024 10:08:54 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130190355.11486-1-torvalds@linux-foundation.org>
 <20240130190355.11486-5-torvalds@linux-foundation.org> <20240131000956.3dbc0fc0@gandalf.local.home>
 <CAHk-=wjH+k47je4YbP=D+KOiNYp8cJh8C_gZFzSOa8HPDm=AQw@mail.gmail.com>
 <20240131003317.7a63e799@gandalf.local.home> <CAHk-=wg69FE2826EokkCbSKHZvCG-cM5t=9SMFLcfpNu8Yvwqw@mail.gmail.com>
 <CAHk-=whSse54d+X361K2Uw6jO2SvrO-U0LHLBTLnqHaA+406Fw@mail.gmail.com>
 <20240131075740.660e7634@rorschach.local.home> <20240131081449.6e917b71@rorschach.local.home>
In-Reply-To: <20240131081449.6e917b71@rorschach.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 31 Jan 2024 10:08:37 -0800
X-Gmail-Original-Message-ID: <CAHk-=whNqOa5rAr4Lq9j=zZgrSxyZwgt6imSydAY3vyeaHm01g@mail.gmail.com>
Message-ID: <CAHk-=whNqOa5rAr4Lq9j=zZgrSxyZwgt6imSydAY3vyeaHm01g@mail.gmail.com>
Subject: Re: [PATCH 5/6] eventfs: get rid of dentry pointers without refcounts
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 05:14, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> If you also notice, tracefs only allows mkdir/rmdir to be assigned to
> one directory. Once it is assigned, no other directories can have mkdir
> rmdir functionality.

I think that does limit the damage, but it's not clear that it is actually safe.

Because you don't hold the inode lock, somebody could come in and do a
mkdir inside the other one that is being removed, ie something like

 - thread 1 does took the inode lock, called ->rmdir

 - it then drops the inode lock (both parent and the directory that is
getting removed) and gets the event lock

 - but thread 2 can come in between that inode lock drop and event lock

Notice: thread 2 comes in where there is *no* locking. Nada. Zilch.

This is what worries me.

But it does help that it's all only in *one* directory.  At least
another mkdir cannot happen *inside* the one that is going away while
the locks are not held. So the good news is that it does mean that
there's only one point that is being protected.

But I do worry about things like this (in vfs_rmdir()):

        inode_lock(dentry->d_inode);

        error = -EBUSY;
        if (is_local_mountpoint(dentry) ||
            (dentry->d_inode->i_flags & S_KERNEL_FILE))
                goto out;

        error = security_inode_rmdir(dir, dentry);
        if (error)
                goto out;

        error = dir->i_op->rmdir(dir, dentry);
        if (error)
                goto out;

notice how it does that "is this a mount point" test atomically wrt
the rmdir before it is allowed to proceed.

And I do think that the inode lock is what also protects it from
concurrent mounts. So now what happens when that "thread 2" above
comes in while there is *no* locking, and mounts something there?

Now, I'm not saying this is a huge problem. But it's very much an
example of a thing that *could* be a problem. Dropping locks in the
middle is just very scary.

               Linus

