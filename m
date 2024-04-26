Return-Path: <linux-kernel+bounces-160680-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E14F48B40FB
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 22:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 977471F22BE0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 20:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CB42C85C;
	Fri, 26 Apr 2024 20:57:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0494813AF2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 20:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714165024; cv=none; b=lGEUrkJB60jK78D5nRVIFr8hELyvje4oKYgeDyPrryc3MwLbF9jsxXqb78eFU9Pf4h0ZBohSQqWlhAKLJfTBg86E2iFZ/s920DP2QPvBBHEmk510W41OG4DW4PDc7DtY1wgr/NH445KI+8P7icGm5edWjBtVKaXix5WqDGLQuQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714165024; c=relaxed/simple;
	bh=ColKp8LTeqV3MomYovw1AaLOb4uUmnU2k5nxP/XTD6M=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qFcWuaD831Wtw18KDXM73G5Xq+XdiZiDga/os2kwhUhen6lvYuEZYbafpRw/l1keItbsCFhdKQ1QFuEyd9LquPqHiVpkOxNhyKFcf8yhbHD7j90mvGF4yDCti175qqI1PSb/2bXpvW5C2B4Z73ntkSy6z5OkmWhew75diHiQxhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7de9b67cdc7so272165439f.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:57:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714165022; x=1714769822;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2wmPxjA1cjQgQAONaZgBDFgfHJ2vCvymGfali2ADE1s=;
        b=I6JBeatWgHB7RsHw846VoAoSc/NPbfB2oplQQQGua6nn3cTG/O/PJehrYab6uUerny
         vlJVmO8cg8Hm9OEglPsxPpzWU1G2+Q6GwLDAN1zaNzz3GAgbl2udseB2HILprrMr3bmt
         STGV+1VLYCkuA2IMxbQzJLc+MKo6JUCNcQ89D1+yW3N2UA8umCwtZJ37Rrq0FpKFUsQP
         mIBUsNgrVgWZzLioFi//hUMa3AcZISWAbHU3UWCPneVDrYNMqpsxsi8/RNVbm7nkXDL1
         OYd7JCArZ+XrIyaBW0WpMkWr/7o1DD026czw1wFsztbpMwsc5Exb+gAbZ3wWCmjjVoTx
         yKow==
X-Forwarded-Encrypted: i=1; AJvYcCUuCvDL9B/4YtfoXsa+YKileCKxbhaXZI1Vv+x8hCItTdBy8FqGCOeMU5ZsqsgBDRIQukkcwSfWy+HtfJFafNKv0yham+8IPfS8oDNO
X-Gm-Message-State: AOJu0YxxCRR1f9IHM8nFOva51XBViNvQ6A2/EJGGTqzKt+3p8e3hImS1
	sWA1ImGMbDrlOhuKel+ULagqXlGWJSNRBc6htDBI9N4hEW7p5Ge60nCUFbu/MhukrK3wrSWShpS
	Ea0OkEwVjYC/Cjw4/Aic9Uzra1eQAZV2OAwjzcO3Uz3usCdNJt0pWvo0=
X-Google-Smtp-Source: AGHT+IHBare5qaUO/kJwI42/lbgUs9Vos7M9Tuo43dypHaC5WkLmbSXOx39jMzLVqNXtInVCffs3LOc42jWH6h5bBadKTSIgegTA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1451:b0:487:1189:3544 with SMTP id
 l17-20020a056638145100b0048711893544mr312104jad.3.1714165022327; Fri, 26 Apr
 2024 13:57:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 13:57:02 -0700
In-Reply-To: <000000000000f386f90616fea5ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e1ae2061706252a@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-use-after-free Read in chrdev_open
From: syzbot <syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, 
	clang-built-linux@googlegroups.com, kari.argillander@gmail.com, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	nathan@kernel.org, ndesaulniers@google.com, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit ef9297007e9904588682699e618c56401f61d1c2
Author: Kari Argillander <kari.argillander@gmail.com>
Date:   Thu Sep 2 15:40:49 2021 +0000

    fs/ntfs3: Make binary search to search smaller chunks in beginning

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=144f18b0980000
start commit:   e33c4963bf53 Merge tag 'nfsd-6.9-5' of git://git.kernel.or..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=164f18b0980000
console output: https://syzkaller.appspot.com/x/log.txt?x=124f18b0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=5d34cc6474499a5ff516
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11655ed8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12499380980000

Reported-by: syzbot+5d34cc6474499a5ff516@syzkaller.appspotmail.com
Fixes: ef9297007e99 ("fs/ntfs3: Make binary search to search smaller chunks in beginning")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

