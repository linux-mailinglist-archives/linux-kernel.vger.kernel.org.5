Return-Path: <linux-kernel+bounces-102967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB7287B933
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:20:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 25120284D29
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 08:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363E5D905;
	Thu, 14 Mar 2024 08:20:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B41C5D732
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710404405; cv=none; b=S6itWeBuzxRMpNVTl4vPgII47Chb3ZzH90dqDVOaxeCq98kEz8++lGnc+wzpSwGVEtGMZ4tELUBUJMxM4/1M2OqGoNgTn2kndbRp1vSJoeXkk7dv7ZwKXpq7nbHOc8/BpnRUai4evJ5yo+bzcFIe35QZOjniFD6J04AzuBv/ke4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710404405; c=relaxed/simple;
	bh=pLijTaaGqsNYpZ0JNU5AhEhkoq1KNqhkwOPIbIgdc+o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=s047dXr09z59+lFMbP3jleGcjXG3Keo8hSTUohk6H3Iis3eh5IiKTzLy+H7yY7XmH5PdJ8Qgue+J6SasjSkxb6zBxujHAjPXSuCOhlBd45VGh0VWY4fhMCtcMZuIoAvGbrfDrjf8ZwZBPuc+qhuedgghV/1xwuFws4k4oQpgYIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3667abe11b3so8972165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 01:20:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710404403; x=1711009203;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A3oPJoshpwChDZFULBNEY3r7ZShFReyEiNklWPwNBME=;
        b=EW0i78rXIzCF1SVtXE7Tk+D+fltfl1qntqxwuASQlsE3NFIbPyaxRHZrr3d4k79pCd
         x4bamDonir5KNz3EdwDMLb1WZak3mTtFVT3cdjaRsVf0ju42Dg0gjul5ygjbD7S3twLf
         7OHPxO9pmMFM2KygETGwORgWa/G+U9M4DzxG7peA/XrbiZBue4Wipx4ind8itBnFCwVo
         tui1vaKY7D5yGYT5XH/4GEExgcISIwxzRl67sUS5kDzPemhVaCC28SLvwU19nbVMuVcQ
         Ayu3OwGjUbs40olMw1PFr5HJMBYJScOME0G3/wynTfbzYlz6uA+9sQyfCgcrzhlbzCo6
         k6cQ==
X-Forwarded-Encrypted: i=1; AJvYcCVa63ydYn4uBb4pndL1xOaYwz0jr5WbKAQl3p7l2VeoLch3D4fBFgj6AjhXrAmeMKpUnN8Zbs97O9oRAqrGLPGdhPY+6x2MevJYgqHq
X-Gm-Message-State: AOJu0Yxz8Yw48iQgPJL1rgQyw2PlyuWbVW4kJ3KjUDcSGT/feKw7KMgP
	N+nbd3ZVY6GKKdSDXfcaEew7XD9ERMoUFjCMPQOtD2Mm0YIvPam+sQmxuj4WsXyH1bajpGciP/9
	wqvGU2OEK71IFyukr9EYJJljT3ypssj0LWnWYMc4Oq8alIN4utne26tM=
X-Google-Smtp-Source: AGHT+IGexVF6kJHRixtfNWM8O/jW6bGVIion56trq7RgTz7dZZkEAJtou7mSjuVdQejwGM09vC7glKeZOwRjRP/DuOabm7RUKmFH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e0c:b0:365:1f2b:7be8 with SMTP id
 g12-20020a056e021e0c00b003651f2b7be8mr85926ila.5.1710404403446; Thu, 14 Mar
 2024 01:20:03 -0700 (PDT)
Date: Thu, 14 Mar 2024 01:20:03 -0700
In-Reply-To: <0000000000009c31e605ee9c1a13@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e3d63206139a8e1a@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_block_allocate
From: syzbot <syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, fmdefrancesco@gmail.com, ira.weiny@intel.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pbonzini@redhat.com, seanjc@google.com, slava@dubeyko.com, 
	syzkaller-bugs@googlegroups.com, yongwei.ma@intel.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 427c76aed29ec12a57f11546a5036df3cc52855e
Author: Sean Christopherson <seanjc@google.com>
Date:   Sat Jul 29 01:35:32 2023 +0000

    KVM: x86/mmu: Bug the VM if write-tracking is used but not enabled

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1779a8c9180000
start commit:   61387b8dcf1d Merge tag 'for-6.9/dm-vdo' of git://git.kerne..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14f9a8c9180000
console output: https://syzkaller.appspot.com/x/log.txt?x=10f9a8c9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e30ff6b515606856
dashboard link: https://syzkaller.appspot.com/bug?extid=b6ccd31787585244a855
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=129e58c9180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=154b15d6180000

Reported-by: syzbot+b6ccd31787585244a855@syzkaller.appspotmail.com
Fixes: 427c76aed29e ("KVM: x86/mmu: Bug the VM if write-tracking is used but not enabled")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

