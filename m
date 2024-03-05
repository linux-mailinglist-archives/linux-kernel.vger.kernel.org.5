Return-Path: <linux-kernel+bounces-92223-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8F8871D0F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:10:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84F752861A1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0946B5491B;
	Tue,  5 Mar 2024 11:09:27 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CBF35475D
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709636966; cv=none; b=LGcXwfjlmxw9CDb54iQ6+NvmCR8gLRq6CPX3w31uFGsRtD+QOlMe97QtXmqAV64MV6paEhm46aTSFhKQ67zy0HSClQJ2+PPnMVixPSZXNTJ2VVQKEhVTlo2U3IkculfVSa9pUfsZ9LR5JNg0hsGNOFMoFSUOk3xMUxWMcVjJ/y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709636966; c=relaxed/simple;
	bh=jYj+F/xk3WJPyRzi6IalSK0U9GexqZYvRKC3L7ft9MQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JCoc1Tf8lcEW1fmqzUWu22C4bsweASTCz96An6Tm4YbkLjHohYYbWqvbZBVoaODmteoOJjj4z0WcyALP3oBsUHR0mVp/2mAiJ+t/EEcC4yFWrD2aaytZElu9BpfPZKphYqMYSMQ4rUqLJNCNpjJJ28Bf9xZKSoZHJiLmKWnkcZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c84939e5a4so178837939f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:09:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709636964; x=1710241764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+TvijFv5U6qCgNY1UsgnlQOfNBRfUiGnqvVLUn0F6zA=;
        b=IRL8hWFXweTV4fmJa/JfFonfbeFs3IeQTiSmnBNYIda7uCVLDYTjoB4gAFNcelLL16
         cTsmBbuB/GoJLXib65yf0mJjqhLkjQgpqi/gGhzCrIH92uoN3+7sdnaQeC3BVCIE06Fn
         xJmRNLgYABWS/EJxfQDvpVGhSpux0kB60OH28QAzFWDTdfiPp+ZfXlf+EssZ0eIvJWCJ
         LsEGdlRUXXGlREijauT3om8hRYDKd4cJn8X8MiauoTCPfkf0ovkrsxuDq8JWVgl9/aZl
         ZDn5NQ4j83373RPyaTahWSI8+QR1/KFayyHgEPeOOzfNpGuOH1DeryucIFH0lGQ9ZTPw
         2euw==
X-Forwarded-Encrypted: i=1; AJvYcCWxPN43Fx+WF0BoGDstwdbB3sXSWh0vNvEc2YqpS0HKQhSH98DJdg2bat9+bGEjitYfmZMRgq9dwUD8QEPdyEXcdP3N86xs6RacYVIg
X-Gm-Message-State: AOJu0YzH52hj01Sp3D+loZjzbqGvwRUf5/p68B3VnyWY6H1AnEHbQHZU
	1H/3myi2Qg5NGDhNXXTsUa5XYBw9xlJGt5d7gCexmzrhs5A818Tm8eeFKDXOSQ13hn4fAFdnbSj
	+agAvXWmHomCFuZUGFqMViffngeyHgSGu9btughACKpIqBn0BBIrLR/Q=
X-Google-Smtp-Source: AGHT+IHI1OjS8HXCP3CAxPPnVkCexzjpvrC9gtg3bA3avLzIjS4SYDuijewtEIwFRs2BdZwo46DKwbB8bmPznBrFpLTB0Ulw+xT+
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3413:b0:7c8:21ec:4dfc with SMTP id
 n19-20020a056602341300b007c821ec4dfcmr155571ioz.1.1709636964357; Tue, 05 Mar
 2024 03:09:24 -0800 (PST)
Date: Tue, 05 Mar 2024 03:09:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f4a65a0612e7df09@google.com>
Subject: [syzbot] Monthly dri report (Mar 2024)
From: syzbot <syzbot+list43753e4613c9d1d7ce5e@syzkaller.appspotmail.com>
To: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello dri maintainers/developers,

This is a 31-day syzbot report for the dri subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/dri

During the period, 2 new issues were detected and 0 were fixed.
In total, 21 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  287     Yes   WARNING in drm_syncobj_array_find
                   https://syzkaller.appspot.com/bug?extid=95416f957d84e858b377
<2>  133     Yes   inconsistent lock state in sync_timeline_debug_remove
                   https://syzkaller.appspot.com/bug?extid=7dcd254b8987a29f6450
<3>  90      Yes   inconsistent lock state in sync_info_debugfs_show
                   https://syzkaller.appspot.com/bug?extid=007bfe0f3330f6e1e7d1
<4>  12      Yes   WARNING in drm_gem_prime_fd_to_handle
                   https://syzkaller.appspot.com/bug?extid=268d319a7bfd92f4ae01
<5>  10      Yes   kernel BUG in vmf_insert_pfn_prot (2)
                   https://syzkaller.appspot.com/bug?extid=398e17b61dab22cc56bc
<6>  4       Yes   WARNING in drm_gem_object_handle_put_unlocked
                   https://syzkaller.appspot.com/bug?extid=ef3256a360c02207a4cb
<7>  3       Yes   divide error in drm_mode_convert_to_umode
                   https://syzkaller.appspot.com/bug?extid=0d7a3627fb6a42cf0863
<8>  2       Yes   KASAN: slab-use-after-free Read in drm_atomic_helper_wait_for_vblanks (2)
                   https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
<9>  2       Yes   WARNING in drm_prime_destroy_file_private (2)
                   https://syzkaller.appspot.com/bug?extid=59dcc2e7283a6f5f5ba1
<10> 2       Yes   divide error in drm_mode_debug_printmodeline
                   https://syzkaller.appspot.com/bug?extid=2e93e6fb36e6fdc56574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

