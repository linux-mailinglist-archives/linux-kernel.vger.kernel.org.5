Return-Path: <linux-kernel+bounces-96494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94ADF875D03
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 05:02:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469491F21EB7
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC752C6B7;
	Fri,  8 Mar 2024 04:02:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9F528E1B
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 04:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709870524; cv=none; b=e9mhAO5SPGCIKSuagSt0377fSViW6fMaZdLA+qN0Y4CDs1jlN05qzMzk8xNdDZmeHcsglGnAENrnQeG4zhLNDNvKAhdfOfglgum/vIGssitatU/xMrf0qFOcfKqdJ6B6QxEGM1TvW+hcxYxGZCp5S9Q+ftZXSw9jsgEJxZcMR3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709870524; c=relaxed/simple;
	bh=G6Djrr2MxRBhWPFd/9J6IONYLwzSuiPfqPYSZd2yTsM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=sYX1ExJku4CkSywaQfDE4sqloktMO0rZd33HXs9MGfhvTh6wwjqTJFnbBPwrJPaQhwgD2ghGuptioyJHaivBFSAkjiaH66CP7+RSGWsgWPzJ2c09yRbviF/Pdr0UU2HhA8JmQDX3u8xAFYEs10BUvnVkUvLfgM4xAWN0mbNzdKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c873aa5a95so174893739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Mar 2024 20:02:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709870522; x=1710475322;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QCiyG4o54TrjDfLD0ps7QesGLXWPOUDgDBMKldRTYPg=;
        b=NFjlH0OczLa5HFrsbRnjS1HXwPdYZXqkfqeKYWxTamGADikJba2Tz3Zt5Dnx+PMDNE
         KoSEFz/14/PxjR1uQ54j1jIh0nIU3X/756hWIWfDDHXVKhb/rw38SXetq6OZ9Z+YcUS2
         00aNB3mZEsX69AkY2QDTxSJbIFsbYlZiZixrw4jcfNPmhljGxSNUIyPogcdUjTjZV0OK
         gWVUTgeD3l1582ZhZuHASMkiN9PcmOje8f+4E2v1cyZYs5ChqVHVJ525KYuU0GBWArbh
         KjNUF5+TpF0WYdMXNqaBEYpzBzw+gUuKzmtZ6qL7yX79FwIcbX3snJSkWi6cvI7yxLb+
         OkNA==
X-Forwarded-Encrypted: i=1; AJvYcCVBuOceTWsLiUPvsIQ2JPoT9J6f71Y2plU3eclXoX1iVIuiZAkqGjAZP1fq9WBq9Ko3w2ONjWv8E0MFLnXli18+BIgm+G0Z5eT4CLdw
X-Gm-Message-State: AOJu0Yx5UTHjJLOOjnOQWXYp2VhUr3wvSFP2uN0AaQbfN3KZr2pymz7Q
	8vixf4QYSorGkzgFd3bQt7G7w1fHItCG5CMNtiN5MRWaK3ND++V7WIQRVZxg6VzKYf2gQWnfwQ3
	/n9d7Gb9me6oVOBOO42a+eQdAKoFeMG8e2cnwNJlg8BP+7os5TdqtBZM=
X-Google-Smtp-Source: AGHT+IELur/qUvDjoOhOme4OZH1E9SVj/n5Qat2+FmIjlDtybLlgcVORnoYjLEk46wzNl3bCWeS6tLYD/IcJzmQxUF/5ah1d8gn7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:144e:b0:474:ebfd:1749 with SMTP id
 l14-20020a056638144e00b00474ebfd1749mr720212jad.0.1709870521959; Thu, 07 Mar
 2024 20:02:01 -0800 (PST)
Date: Thu, 07 Mar 2024 20:02:01 -0800
In-Reply-To: <0000000000009d4b80060df41cf8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012d93d06131e4140@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in reiserfs_xattr_set
From: syzbot <syzbot+74dce9511a59ad67a492@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, eadavis@qq.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fc31de180000
start commit:   453f5db0619e Merge tag 'trace-v6.7-rc7' of git://git.kerne..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c7bcb8f62f1e2c3e
dashboard link: https://syzkaller.appspot.com/bug?extid=74dce9511a59ad67a492
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1534af31e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1512b9a1e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

