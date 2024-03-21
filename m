Return-Path: <linux-kernel+bounces-110201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37128885B70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69D191C21F24
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4604C86249;
	Thu, 21 Mar 2024 15:10:32 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A5A585943
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 15:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033831; cv=none; b=ce0fotZOS6VHbN+4N/2NukUcedGAZGlkSz7owG6hSYZS1siE/WfX0AyPG4rFOvtesA7ypzp9j7jsfGVMiiB6Fh41Eg7D/ZRF6ZEtXJ6aIo1fob8QbGKOUPYK7iiWA6yYjN8XrbGhax1ZIEPWpkz+1fLhbwGswiWgT4i/xSfCygA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033831; c=relaxed/simple;
	bh=lkwGELEVRrIIvXlvXJsBZZkp2IgOovTNvk11SNLj5tk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DNMI7C6VZYqJVqtnknznRMomRtnyPj5PjF5WbNum7sQr31JUT6/dFHjSDUAZvrDU9dUkkyFPT/MH+cYlppnqG5A8ioUYARBjBpJ9PAkcfkn3cJiaUXzDi6axihHhjwgbKIEVN9muA7FDaAA6+q0rWP9qFmzdrmykZAa440EgBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so199027539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 08:10:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711033829; x=1711638629;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mt2HNZyZoapYjaOUsclhOl7e3kA64Zv5KEZzZn4Zy4o=;
        b=t+j3V5wwyGRNSBS2zJblPHcpBdr15LJ57R9CRDiO7zmi3VDIQ42PGk2RxRurN0mkVx
         AVGa/BAACH+PeaoEi8bCAj7Fh7QEF0NK5XqmPCmX/FBDgIw8Ab470ZsPpEpscRxS108T
         uZo4lJicplaQF5Y46q3P7uKNro6xHDeTcqKzRH2FkfjZ6GLHOft6Ost5S/L+3hB2D3mI
         /zBSPLGXj5BGfv0QFUXxEVnzEJttUJqzdNF7WSycPqyemlfWh1ULcOYfS54XyKe8LUEu
         Nc85zkRIy9gY+lf7kQRiIBWqBckCSGF6juZsA++X634iKeZKs4dT1B9f24pWw5otfwIp
         fcpQ==
X-Forwarded-Encrypted: i=1; AJvYcCU6PQw+lqgCGdaOhI78XxOK43Nfat5dXnMIOwkEtorqGqBjsJyDXR1tmnbY7nFkpw3F5ifOINgSTNWnocjwMafmNZB453ZVthxj8Yri
X-Gm-Message-State: AOJu0YxoColO6qxTyO9XqAsX5jR0P4M2DWp01Ygax7h3gpsb1Drj4QZq
	6wJZlOQqVR0et5S2MXAEG1Mi4rgbrppFbwGR4BHeYaU4Gh7W4iyOwXvyuw/X/8Ei5MxYKFAecia
	Rxm2jW5aYb1O2K4UZWKsqKGzTOCKg1tD+Dl8Qb/GcgFHLq6biOnU9NqI=
X-Google-Smtp-Source: AGHT+IEKMhB9ZG2lXARfsTj9O9X+nYpyS5T7vlLFwtRWGNc7OzuulrlNwf0KpGrcMFM+ugXTAm+ECMn7rUGaHfpRvo4Nai1LtKz5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:477:307d:abd9 with SMTP id
 i3-20020a05663813c300b00477307dabd9mr163534jaj.0.1711033829646; Thu, 21 Mar
 2024 08:10:29 -0700 (PDT)
Date: Thu, 21 Mar 2024 08:10:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009d6f3a06142d1b9c@google.com>
Subject: [syzbot] Monthly xfs report (Mar 2024)
From: syzbot <syzbot+lista1e41fd3fe8612aa32c2@syzkaller.appspotmail.com>
To: chandan.babu@oracle.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello xfs maintainers/developers,

This is a 31-day syzbot report for the xfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/xfs

During the period, 2 new issues were detected and 0 were fixed.
In total, 7 issues are still open and 20 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 604     Yes   KASAN: stack-out-of-bounds Read in xfs_buf_lock
                  https://syzkaller.appspot.com/bug?extid=0bc698a422b5e4ac988c
<2> 14      No    possible deadlock in xfs_ilock
                  https://syzkaller.appspot.com/bug?extid=d247769793ec169e4bf9
<3> 8       No    possible deadlock in xfs_qm_dqget_cache_insert
                  https://syzkaller.appspot.com/bug?extid=8fdff861a781522bda4d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

