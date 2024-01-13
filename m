Return-Path: <linux-kernel+bounces-25157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 564CE82C8B4
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 02:28:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0398C1F2317A
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 01:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA8931549F;
	Sat, 13 Jan 2024 01:28:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248B512E62
	for <linux-kernel@vger.kernel.org>; Sat, 13 Jan 2024 01:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b7f98e777cso643053139f.3
        for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 17:28:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705109284; x=1705714084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yO/xdw8mUiUeRo79DAK0wxdvi30bQpvVBNatj0IZ9bQ=;
        b=FlFH1KW+pn4s2ZzksGPwH4lLSU36M/jynI0L8tEK1MRyJBCGPc1I+SY0kaz53qNfTX
         xkZQV71cI3rElrWgucM6J4guv7rUQCdMcXT94ibQ2bcmGliEB+k5sRQtFiuNcYRgBEZ9
         TiiIk4OfZLn5VKJH8e9vBncArBN73zwPTLw2WHl3a7WZIAR/r4dhNFiOc+TbMOrBMqZN
         EEt2zuaiTPWCUCI79qxnDoEsUpBEo9qMpsyRYF/Y/WOKj+pPh5hVW1Cb1r390e1n2T5p
         xvpFQd0nXXqQiEZsPytLnyHfoIkzeObi/DmioXXanxi2A+YQD4kOGFxHm6XUdCZzpjyh
         NTXw==
X-Gm-Message-State: AOJu0YxX9YvXBUUEzr9pWoCdjQfnviQJIOxb1KmvBXrmu5AjNtIL8Sm3
	xG9lWlzV/SJfcox+UvaAGUkS2QJKmvv2x1AllsOoZ7EBHaUC
X-Google-Smtp-Source: AGHT+IGcMUlOs/Tzd0+a1Uuk+acyfi90LBsot4shAq3B70+iVAprve0XWavepzODdBa0BESDLdRg+h02+m2jOZGlDkT26zifC63/
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a07:b0:35f:d5ea:8a86 with SMTP id
 s7-20020a056e021a0700b0035fd5ea8a86mr194343ild.5.1705109284375; Fri, 12 Jan
 2024 17:28:04 -0800 (PST)
Date: Fri, 12 Jan 2024 17:28:04 -0800
In-Reply-To: <0000000000009e798305fe8e95ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000032d485060ec9b172@google.com>
Subject: Re: [syzbot] [jfs?] kernel BUG in txEnd
From: syzbot <syzbot+3699edf4da1e736b317b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1280b62be80000
start commit:   692b7dc87ca6 Merge tag 'hyperv-fixes-signed-20230619' of g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=e74b395fe4978721
dashboard link: https://syzkaller.appspot.com/bug?extid=3699edf4da1e736b317b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16b373a7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1749e8f3280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

