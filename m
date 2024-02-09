Return-Path: <linux-kernel+bounces-59981-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C849984FE29
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:07:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9F561C21F28
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33637175B0;
	Fri,  9 Feb 2024 21:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GiHQOwb8"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20094DF55
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 21:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512844; cv=none; b=eQvURNTKUc+mDxjJbM0vlyjm7IJS2eDI80jGyPUKY4Pf3saVFrkQPeXuy8yKDyK9/bqu4xf1YBvl7WcYN2iHnQZulGtfMcJDhoCL8XbjlnoStDP0K0h5smUXeQ7oNP58BT0JV/9t5CrkSkRbDFlDzAFPwHe6xjnGxXL1HCFHd2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512844; c=relaxed/simple;
	bh=EsssZPfuAofzCYmifTEhn5L6k/IYT1EjOB6B81GWfQg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LlbVZbGEpzpQHUSBVrk2pb7ZR5uKBjhMti9VUEgMEdZ8KYqRAQqShGztU4OGo2XdktJTcqfPgv68OMBBBRiAIzbUaWsjzu1z2Es4+nDQuGulEis16S6nzT+Ws1Y+UZ3mFJfJYpVlTjZvFjpWmgX4ZhuPGVIt+2/O/Tm4CFz0UBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GiHQOwb8; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6b5d1899eso3277778276.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 13:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707512842; x=1708117642; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QJVA7E4OPiD00glr6A2eE7hMnsJp0FoP1xE3INulbjM=;
        b=GiHQOwb8WUG6fBVWqqW7XtV8lwwikpuA16Jxl3d7GkbymzzcSG3J/57H77NC6LRg5j
         2MFc9d8a8BbJvXryVliz54FXtqBWFov0iws0K3O37FzybhWocI9D6usdBFLQpoqbkhIk
         u1S4d7Q+k8huoAWe/ZTpVElj1bUXQh0DLrQWhpPg955Iwue6vwiF6mf6kh2d/tDRmgje
         1RQgtICQMo9k5XEzYBjrESRQWOjXjMQ722yWs6bQB9rT4uQRO1iqUXnBoAhTHBBei1t+
         D723gS4+zXizbPqFRq3/wdKrX+Zzz6BksPNQP0pvkp7j/Nvu8pnGhyOIg/C4ylEpj11O
         4jUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707512842; x=1708117642;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QJVA7E4OPiD00glr6A2eE7hMnsJp0FoP1xE3INulbjM=;
        b=r35P1IYckBDDORVyOmcbf8HZrvdoaWFAWGLRNpkb6WA7pNZMF1jsY7Um2j8jv3IXKD
         ii8RDmb2LqGADsqBxzOuNkNcTY5GBR5W/kcHUnTtbWSCifpVtxxkQwb5G5uDLfJaQGpz
         ajOjL9Ud6IY0p+PdHZNyPT69j2S6rLe0Z/6/Roadvc4s1Pyki8d7RD2DBEYleond8W0v
         k1AkgFj8sbzS6RaJ4m7EzCvo2imrXMYMLMkHtMYpt7+xlINHCPGCwTg8bUhGmLtIB8sG
         BlCVdt3OFEAPv38C5UPAxGilPQxlXuEWGkw4OxfYW02K6lvZu53ht1tZTtEl+9q3RWLa
         UHmw==
X-Gm-Message-State: AOJu0Yy0Xt28GH2i6ngBns8s9aYEfI8QaQlSz4e+PjeW1hQa0EopE+Us
	TSdWwql9m+kshIy8bw/Yb0+jIrfuRP/fFNcSL2l7Ml2DXZlvBK1XSLXuE7mCrbzM6TVtHhJ8qe3
	63w==
X-Google-Smtp-Source: AGHT+IGUHHBgahILEYWs+MFS2D8cEf65K6zPE01Gf0qcohepgEWrWwH95oTQfWnppRqpfBG3AOVVBhi0ZVA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1002:b0:dc6:e884:2342 with SMTP id
 w2-20020a056902100200b00dc6e8842342mr79952ybt.5.1707512842181; Fri, 09 Feb
 2024 13:07:22 -0800 (PST)
Date: Fri, 9 Feb 2024 13:07:20 -0800
In-Reply-To: <000000000000f6d051060c6785bc@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000f6d051060c6785bc@google.com>
Message-ID: <ZcaUCPka_WL4ruTq@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_change_pte
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+81227d2bd69e9dedb802@syzkaller.appspotmail.com>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 13, 2023, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    f2e8a57ee903 Merge tag 'scsi-fixes' of git://git.kernel.or..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=14fdc732e80000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=e56083f7dbe162c2
> dashboard link: https://syzkaller.appspot.com/bug?extid=81227d2bd69e9dedb802
> compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129d09cae80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10b8afeee80000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/7b75e59fc59d/disk-f2e8a57e.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/f853580d61be/vmlinux-f2e8a57e.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/8c893ce02e2c/bzImage-f2e8a57e.xz
> 
> Bisection is inconclusive: the first bad commit could be any of:
> 
> d61ea1cb0095 userfaultfd: UFFD_FEATURE_WP_ASYNC
> 52526ca7fdb9 fs/proc/task_mmu: implement IOCTL to get and optionally clear info about PTEs

#syz fix: fs/proc/task_mmu: move mmu notification mechanism inside mm lock

