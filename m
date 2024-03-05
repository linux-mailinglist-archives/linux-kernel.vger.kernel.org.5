Return-Path: <linux-kernel+bounces-92628-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E905387231C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 16:50:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26F851C230E5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:50:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B73127B6A;
	Tue,  5 Mar 2024 15:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gd03VV3q"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E270127B50
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 15:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709653804; cv=none; b=Giic5DzY1KzrG5v2FBYlCvqDgnl6nU3RN4Higvh2yeVLnPcq27yGOuRuA+CB2ZkNyPG5D/HHLWFvfvneIVGt448Z+3uXIBLVnSgq37NyJg2/AvKuKLGTKZ6om/K6WUe6r/v6JWmzoIsKeHiXb5p+CI0UdWq/Kt2Nf4hrRyhLT7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709653804; c=relaxed/simple;
	bh=+XtwfPPzlgnB4RBNy2vV+a4eTKUlSTn4IPZnnwRh+SI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=q5RUDVimM3WCtQjENUGvoCHpJomVkd0CjM8fa5Nn6aXmXmjGxoaTATieaVgBj+dzXpGOhlv1gdzf/VryOFf/KRP0D/s629fzpZ+gkbGaidW1SiRX9ZjZLGpWYofwpOzZzwH5qYDEIy8AkvXuDUrTO+RpYpSxRY3hmV8tXs1Utc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gd03VV3q; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-609ce331defso10214907b3.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 07:50:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709653801; x=1710258601; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ASWwD/q66AKnfmaM1STdFVXHI6YQnXzwPo0Knx3FJaM=;
        b=Gd03VV3q+0RVjjmQBQ/Z28hvbxC1yrFWH+Jiq7FUS8nhWLW5vN9dNitLsvnH/NURG+
         KO99Jzg+pE5xGZZkT2nreM8TVMUVYMYa5JVgxkUq9vhkclGhsWUrUyVzv2BM0t5Z5kzL
         bl42fPqKTs9aFyFE9Ihx2UntsVSoOOp0KeRAWH3kk/VH33n6aeZDnvQS9EKA0/yHx7YL
         YeqH0IiQI7fKfFg2ROi/BSqUX+udEUs18ZYsHAuLdDdECycAh6FuUjtZ4pkkeLO0G4Bi
         pNC+ja9xM2h/g5RmjgJmIIcZUDAGjY+dDk3QClMnFFKqMpIGkd4HKHiFTHCQkwW4LA5k
         V20g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709653801; x=1710258601;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ASWwD/q66AKnfmaM1STdFVXHI6YQnXzwPo0Knx3FJaM=;
        b=DI8gYoK6CA4dtLhRbplqjnRXCd4ots+Rneeycr9caBEWALQtMI0sUztEOzSCCxY4xi
         Wk+qG16La8Dhp1CoWaAzlptQ4oB7AnviyJoiG7r7cssodjD1egjpRSvMedMAtezxrHH9
         T71ELF36h3wHQiCljryEJRiFjL8n3amISimNMrAVnm/4Uk+Up9/367akIqW6FxC4Ks03
         40B9XpEkuPoZ1nT7IezAVBBpB14T0ZY6bNgOOwsq/N+lApuDPnPUvYMjCNrgZdZnSjA2
         iUncdz5oWpOb1bXDwT6vckCP9Jm5ZohcMpe/4/hJ9+QECB3iU3MoYtTo2pcoeYwjvt+a
         mRyw==
X-Forwarded-Encrypted: i=1; AJvYcCXG9WG5fEo3PxX4NXegq4HxX/XZiC/1b7Lco1K5xq1tTiWuuun1Brsc/BRidIxTCt5TS8nalbQwz0aN6jE9vfBs7dbxnkIbT93+IMwG
X-Gm-Message-State: AOJu0Yw6WGNuh3fam/WNKzQVkN2jjokQFZxe1FMpoOsfRMGtMVsM9yeb
	qigWP4bFwiX/iOf5pnAiDJJdcRtYa+ylZiUnXwVAv/Ohp1CGDH3BtXjBGoYCSf+JLyMF9exWBzN
	luA==
X-Google-Smtp-Source: AGHT+IH5NhL/twNWnmBcbZsXxhVpApXcvivMmR/ALiJ03As9pm7V1yl7lux12oyyZ8px2D/3xX7jGH1MZkM=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:fcd:b0:609:33af:cca8 with SMTP id
 dg13-20020a05690c0fcd00b0060933afcca8mr3473082ywb.2.1709653801455; Tue, 05
 Mar 2024 07:50:01 -0800 (PST)
Date: Tue, 5 Mar 2024 07:49:59 -0800
In-Reply-To: <0000000000009a8bce0612ea3e3c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <000000000000376d93060a5207ed@google.com> <0000000000009a8bce0612ea3e3c@google.com>
Message-ID: <Zec_J7VKp_4QAP0Z@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_invalidate_range_start
 (3)
From: Sean Christopherson <seanjc@google.com>
To: syzbot <syzbot+c74f40907a9c0479af10@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, 
	syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com, 
	usama.anjum@collabora.com
Content-Type: text/plain; charset="us-ascii"

On Tue, Mar 05, 2024, syzbot wrote:
> syzbot suspects this issue was fixed by commit:
> 
> commit 4cccb6221cae6d020270606b9e52b1678fc8b71a
> Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
> Date:   Tue Jan 9 11:24:42 2024 +0000
> 
>     fs/proc/task_mmu: move mmu notification mechanism inside mm lock
> 
> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1638c66c180000
> start commit:   b57b17e88bf5 Merge tag 'parisc-for-6.7-rc1-2' of git://git..
> git tree:       upstream
> kernel config:  https://syzkaller.appspot.com/x/.config?x=d950a2e2e34359e2
> dashboard link: https://syzkaller.appspot.com/bug?extid=c74f40907a9c0479af10
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15785fc4e80000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1469c9a8e80000
> 
> If the result looks correct, please mark the issue as fixed by replying with:
> 
> #syz fix: fs/proc/task_mmu: move mmu notification mechanism inside mm lock
> 
> For information about bisection process see: https://goo.gl/tpsmEJ#bisection

#syz fix: fs/proc/task_mmu: move mmu notification mechanism inside mm lock

