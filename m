Return-Path: <linux-kernel+bounces-92478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 619358720FD
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:59:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2832B20A89
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 13:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DD586146;
	Tue,  5 Mar 2024 13:59:04 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2400986122
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 13:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709647144; cv=none; b=ofl2llH0gYYA3B/pqfzUAz8eAYSQnfHQKIEeblP4sKQT4llmmPljoW5u206vZ4/J485kr+jm7U6FJTVnbXCO5LNcSQf4FnX65L9ciBAaOLSPUAcrg3Ufwu+VaNAAmT1nBcLN0A9KLLyan5PRG7k4ZZql6G8SNP6cXiIdayT+Nks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709647144; c=relaxed/simple;
	bh=7l33o63t817PVAJxkpl+CDCljilBzWublR/7OYtNxNM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=a0cF9OKjvy/aRUxJEj//37QVG70f7p63NCLZcEgcaf4qC3EcESK0gwUhxRnQPYyP/pOxqwVBDiV2nVF7y6KuEHrexiRPiXGDkCc3bOXXiJweN21cJtPAl1cXmU5a2rccmPwSrKqLDagL9It4MlTWgh7GxHE5Z31RNOLOFA3RG2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c49d118546so449465939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 05:59:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709647142; x=1710251942;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ozqm1QJ84yI8HdJqurYAliOOcrvYW5cx3nOSejB731o=;
        b=gXCzvSTbR4ONql/4VHczYggVBsNsmw1yl7exbi91Z7A001e2nk/CyKQ6glNgwUpBbg
         IFACbRDEUlLvJrUkXLhyPkgec1GUsNscohHCF3X8Xbtuir23vkSImQlvb63QX5GXJDli
         KvMglPEoCYt9ghrxo2I5REyObWrJcyF5F+k3Mp6LJP51MGNdkN+o5yyozhLHJ8egNb7X
         Aur3N4Zn69D2Cf5Xkl1wHwVoRFy9VDoq19Xz3UeToYU8XGLM8s8vsBBcVMlLAhgWNDBX
         cE1G0pK8I94eMMRo943pA4P+so2Yo3XfDpbU0s3xJ+wilzSu4I2V4nCvLJxU8B8G51Dc
         T88A==
X-Forwarded-Encrypted: i=1; AJvYcCWoILZIMfyLZl+XZjmMErjmYIyADMd+iZ0N5fVtT2lX1KgYN3l7ADAQ1Qhd3Awmydo/dFC1o9PjveevzT/pWOaZ8uHi2Al0JHOQf+S9
X-Gm-Message-State: AOJu0YzrOE3kB0q3wO5KfsUd7tAg3knfDZHy4op8yVH1UiazF+eMfPkO
	S7sdT+D2x4kXqDhwq1tMvyTMRK1jcQhoQ71QNRlQvBenJskv1JlZAjasT4YR/D0+U72P34uMHFo
	K9IoLh8+DC03Epuh+YTvzq0/UezFPT6EYyl1RjjI79xdl2wCLOmxxBLY=
X-Google-Smtp-Source: AGHT+IEP8n8qSf96nLlSO2rFxSJmbyVVUTknjVpsBlFop11mtXH7lx6mogLF/UQM1fodPwn/6hIAi5kpU8HrhUOEGbHhzUj7aJDi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:474:d2f6:f0d1 with SMTP id
 v39-20020a05663835a700b00474d2f6f0d1mr81402jal.1.1709647142220; Tue, 05 Mar
 2024 05:59:02 -0800 (PST)
Date: Tue, 05 Mar 2024 05:59:02 -0800
In-Reply-To: <000000000000376d93060a5207ed@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009a8bce0612ea3e3c@google.com>
Subject: Re: [syzbot] [kvm?] WARNING in kvm_mmu_notifier_invalidate_range_start
 (3)
From: syzbot <syzbot+c74f40907a9c0479af10@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, pbonzini@redhat.com, seanjc@google.com, 
	syzkaller-bugs@googlegroups.com, tintinm2017@gmail.com, 
	usama.anjum@collabora.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 4cccb6221cae6d020270606b9e52b1678fc8b71a
Author: Muhammad Usama Anjum <usama.anjum@collabora.com>
Date:   Tue Jan 9 11:24:42 2024 +0000

    fs/proc/task_mmu: move mmu notification mechanism inside mm lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1638c66c180000
start commit:   b57b17e88bf5 Merge tag 'parisc-for-6.7-rc1-2' of git://git..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=d950a2e2e34359e2
dashboard link: https://syzkaller.appspot.com/bug?extid=c74f40907a9c0479af10
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15785fc4e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1469c9a8e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs/proc/task_mmu: move mmu notification mechanism inside mm lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

