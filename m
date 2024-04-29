Return-Path: <linux-kernel+bounces-162252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B088B58A7
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:34:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 28F101F2495A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7291BE49;
	Mon, 29 Apr 2024 12:34:26 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0776FBA50
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714394066; cv=none; b=QwlqrtJbX/51/05x/8OtzscamCd7Or2YPc5Jwu42J7JbgS72a6i7P7qvxBhWUuNTZveiSdlUhjSrCwDJXLIgM/UkHIXSPx7BZZ1JGukbif4tBiZoqI9vEPeHw1zhbROPjwC//aqShVFssBnlsUSWcc7N2qn0ni53VL8MNwXpVwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714394066; c=relaxed/simple;
	bh=zNX4dvMj8sMaSc/H5ov7uAslSWACWgUB2DwD63KMJfc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MmBptOHjVM9FA8nODiII5loMs9bfkNuxBcwJzqU0wxKhSAtYu2imUjz9dt7KoCfg0O82tXfSKjP5ObJKOWkjKp1YyPvII1QOfyLv//AOLRwPj3IXUduIW5uVpMyAuT4PiCZ8cUYM+Z02LS2B227OhQoA+MQkLU/wG4edP30Ej+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da41c44da7so531575039f.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:34:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714394064; x=1714998864;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lIcH+uqjp3vumX9YpVxoQmZo6VBkUG5FwDdMSz/9KgE=;
        b=rgXS3UJ5gyEd77ESvRrYJ7AdKgJ3t6BjQdE+ysYzBttO/PhTJlrXKW5th7lv5BS8Bx
         J0YU59oeTLViHmi97CuOCSzDYi3h2kUbnqMbKmvSDadru5FOernuiztNUV/Dqv+iAi1A
         agHtjgX1Dy9zsDm3mgtXeSvUKExlzQi8UeXxNBwKA21zMll/+U37CAmFRKhDbzGj+C/t
         HJOm8RYY40/PxGY7+x3TFOaBH2n/ZN2uOQaKIoiaszFGVv0hKN4OLf0tS1RUrHPLfRQO
         ia2h3ssuv2lsQaOm2s6baBDZ7/njY6iwr0Q6Q1pA1TNF3OxINgN4bcnc2PKqaSxNEYKy
         tdOg==
X-Forwarded-Encrypted: i=1; AJvYcCVdgRI22t2kcuiS3rdEvl4fKU+kkkFUrk1KZVC0DRXVA8UB0is1++xk9PbVIF99v5QzX/8a2w4sSUks0X29ILXBx1XH+aeE6ixTCUgV
X-Gm-Message-State: AOJu0Yw5bVQA2l5n3u+DgtmSwo+Y6nQCgI5TGoVHI2+EShfr1YcDQC4S
	nhtc7TTCFaB8zdgXu+w1E4skqh5qQJwCkTrQirdnZZ8baOPwYX1wXlitMgAax+a20C4mtpfr1L1
	r3HFPgno8xfsZDqG+xUJl3mCn+1D3GbAUb6+Ea9bgL2XlM2o28rkorpw=
X-Google-Smtp-Source: AGHT+IFmGFq5GWv4TOIvJdOwBbT+UeOKGABz5MfdMy4OwFM1jJZ30xEQ78iGkI8pgziDJHL8eka2027lOFMUoQQis9xo9C0fNNFr
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3d89:b0:487:c6e:1bf2 with SMTP id
 ci9-20020a0566383d8900b004870c6e1bf2mr816814jab.1.1714394064267; Mon, 29 Apr
 2024 05:34:24 -0700 (PDT)
Date: Mon, 29 Apr 2024 05:34:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034bbf206173b7991@google.com>
Subject: [syzbot] Monthly gfs2 report (Apr 2024)
From: syzbot <syzbot+list8ffe20412d57261746c6@syzkaller.appspotmail.com>
To: gfs2@lists.linux.dev, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello gfs2 maintainers/developers,

This is a 31-day syzbot report for the gfs2 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/gfs2

During the period, 6 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 31 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 61493   Yes   WARNING in __folio_mark_dirty (2)
                  https://syzkaller.appspot.com/bug?extid=e14d6cd6ec241f507ba7
<2> 746     Yes   kernel BUG in gfs2_glock_nq (2)
                  https://syzkaller.appspot.com/bug?extid=70f4e455dee59ab40c80
<3> 108     Yes   INFO: task hung in __gfs2_lookup
                  https://syzkaller.appspot.com/bug?extid=8a86bdd8c524e46ff97a
<4> 90      No    possible deadlock in do_qc
                  https://syzkaller.appspot.com/bug?extid=8ef337b733667f9a7ec8
<5> 22      Yes   INFO: task hung in gfs2_glock_nq
                  https://syzkaller.appspot.com/bug?extid=dbb72d38131e90dc1f66
<6> 12      Yes   WARNING in gfs2_check_blk_type (2)
                  https://syzkaller.appspot.com/bug?extid=26e96d7e92eed8a21405
<7> 1       Yes   KASAN: slab-use-after-free Read in gfs2_invalidate_folio
                  https://syzkaller.appspot.com/bug?extid=3a36aeabd31497d63f6e
<8> 1       No    KMSAN: uninit-value in inode_go_dump (4)
                  https://syzkaller.appspot.com/bug?extid=bec528924d6c98923e5d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

