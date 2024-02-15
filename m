Return-Path: <linux-kernel+bounces-66977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A95856454
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6B271F215D8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0EE130AF7;
	Thu, 15 Feb 2024 13:28:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AA8E130AE1
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708003706; cv=none; b=oF3PQe6xxaF+KKaoOqjqPHuNh8NotE5o/6Vv2Y4+24426FxwySgeq+CiOdlaDJGZ4HH0GSJlTz1p8G/MIYOoxzklKYa5XdDxoEGaX4JtLmysXNI956MvsQDJPPSR4njjngGU4ZSlkZIk0W3NxasHtSoC4mHrI2JppAkX1vFegVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708003706; c=relaxed/simple;
	bh=W+BInuv+uaYZEdgHM7yo4xi7Cnqhjg2drhGZO4Ls9FY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SZ5V2r0CUDkWdVaDOmZaddEjiR/TcweRO3OOD57nIPp+Hr3v0WjO24PGsy/G9WWUts9Esz+9U3KUjTprpV9dgfvSeyKlgOrGMA4YmDPWmFDOXHkuzPHTRspYqE/cCXfwFRfj2Glnk7sVs8PeNDWanaFC1IXJIyDAi3ugvcIBssg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3610073a306so6635055ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:28:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708003703; x=1708608503;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YOyAVj8iZnfLPO2Tj57CukZdvRkebiNy5RkDdicIJsY=;
        b=De3Y71t2mhugw7gf5NhOnzi3FbMYMFPcpLlPLRc124zObfm8QCTTW1MCi3pWWoRcPL
         pJ9jOUDBb0OiwXsUv3o9Q5Ov5+hNKOqy8c2UUmba76mI0A6RISZ0E6HYh4srNRQX8OHI
         HfpCYH5kV6dXfj+gVqwJKL9dSz6fPm5h+xC/qd9C4ZYPA7ucdqLALxiG1+88MS6375ES
         Qo7nT7/a53qb/QTfFDLaikBOby3wsbxjOgaAGflEaF0YQhqPKrCwjAI6L+nqdf+a5kC5
         ssgXkcD9JZJhDqGhSjzD9z/x/pojyt72Md9W8EL+zN42yH8uy6xF1eTF6D2pbCq8RbV3
         C5dQ==
X-Forwarded-Encrypted: i=1; AJvYcCXscP5lqVflqOTqRjEfB+f2sxup/a14+VgBAGvZl8mMnqN8ykGFM45AtRNVejMsUxzrY5WK/IdIsS1Voxvrpg+Q2mQr1eokxxT88ODY
X-Gm-Message-State: AOJu0Yw2CekGBR2jKriGduKzuHC6TjVVP4vCxKevONx71btfsTJA2RAw
	Fpuv0yUhoTKJFfG47sE/v8uSEuBxWBMSSAhJKXFkxClTbi+f4kucsLXFMEbcfOS/s9DOV7H4QLW
	sN6S6OLfpq0rCY8my4mS5w+Ex2/5iIykWi/vI/SXAVL6czD1TQq8R4U8=
X-Google-Smtp-Source: AGHT+IEREh9yEaNckCxDoksWb7wYynsZ3OGb1J//mCCzUvWZ9+ATJgsqnYvz2H3RflTF2wLmuskGIv7izrXcerbLZ2tV4ESMUnDv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1e:b0:363:c25b:75e4 with SMTP id
 i30-20020a056e021d1e00b00363c25b75e4mr143497ila.5.1708003703797; Thu, 15 Feb
 2024 05:28:23 -0800 (PST)
Date: Thu, 15 Feb 2024 05:28:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000a40fa06116b9aeb@google.com>
Subject: [syzbot] Monthly f2fs report (Feb 2024)
From: syzbot <syzbot+list794268f47f12e7406f24@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 0 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 35 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 314     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 17      Yes   kernel BUG in f2fs_evict_inode (2)
                  https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
<3> 13      Yes   KASAN: slab-use-after-free Read in f2fs_filemap_fault
                  https://syzkaller.appspot.com/bug?extid=763afad57075d3f862f2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

