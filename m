Return-Path: <linux-kernel+bounces-59397-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1884F64C
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 14:58:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 598F31C21A9D
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0CE4D59C;
	Fri,  9 Feb 2024 13:58:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0154A4D11A
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 13:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707487084; cv=none; b=T3CPKrCzolSrUd8D8xeY+4Fpxtq8IxRI6malHxHM0h+QR5t/avNoGxRrvT8KYka/pKzzglHUUWVpeIYDe8dMU4spRyvcn9eyiyM2k2zicYOCqFkLe8kwwodnc4gNlCHv6XM5QgirhRLy0exUDABKXw51Hh+OW6IP6McyPu4+Krw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707487084; c=relaxed/simple;
	bh=KgvrOHqW/nOwXmmrHWcgs42V7NoASj+/ZUYp4NpDRp0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qeIMvizqnos4VOmea8AbwhbpE1aYYnJxqWPsOtkapepHIUSd1o/hys0wP7GO4cEYVFcnG9nDW4NnYgk8E49/0uh6qrMbnZmY+Jn9wLWdkMPmsF5lY5z59a4CHgDiTIbNUntoT/fqO1q7tkRqnb1uMEWIfFmgBLCU+x67ZyYwIZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363bedeec4fso7803015ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 05:58:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707487082; x=1708091882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BGMm3AEkbwxMmZYoWinLQYL05MhebYQIefChB73Qd5Q=;
        b=QjJlqtaNduFo8L/Xe5Obz29khtBqyva8ocyE/SkzNiBDQnPyILaRhK8ujdWC7RPyD3
         gL/W7nBAttiUHjykkJEQIKK7GD3PGYwG8BYyxlfzEa3Zpxw1CX39ZOP9q+4rFO8bmvzY
         trZdIFijmCE6rHWOQtMaGS8sB7FjoE17uGHe40WDwjNBm9qBOEQxe8LJPDnXJ+gYw8SM
         Co8QbGxkiGxLm0d258vDsDjJXYqezdYe1owGRb7ryZD4jyTnbCb2M7TzIXvtqAiMU5qt
         zgdmE2mHLK2/PbXo32faud4Yb/JPg1En4nebaYg9GDhevOutc4ybvDjfpnrpJ2av6Fe+
         X8EQ==
X-Forwarded-Encrypted: i=1; AJvYcCXlnQeyjveGqmTNPZbIbFeAHpeZR91aXmsdoT+5p/8z3CjVrFfiQ6BqFn8upYPCAQZUWc1qmrcC1UDiWmSSzGc78UrcS39akTV+mVWm
X-Gm-Message-State: AOJu0YxjEa5NVlOM0IL6o7qxsxn8SSPqWShOk31XDqN7WwUXIBx6rhW5
	hNQyhzgpJ1awzHFzPjuq487WsDCrXCRzT2wEMMuAaMo3rYtONafyJ/4UG2dPDW9V/YSWNCfsJV/
	f1ES+O8mPno+oEmO9PCCM42brvJFrOcpIpo8G2h5GBRBs34c+4WzYW3k=
X-Google-Smtp-Source: AGHT+IE1Ro5KKyB2KXxAJGaNjl4gJ7od7nzug7FOJ01vkjLcehKwnlBmqmZkRahWgzVJeNq5bjctrle8kWwK5Tq9gBrgLHQw+F9M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2190:b0:363:bc70:f1b1 with SMTP id
 j16-20020a056e02219000b00363bc70f1b1mr101138ila.2.1707487082274; Fri, 09 Feb
 2024 05:58:02 -0800 (PST)
Date: Fri, 09 Feb 2024 05:58:02 -0800
In-Reply-To: <000000000000ce2dde0610db47a8@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ff69600610f35011@google.com>
Subject: Re: [syzbot] [media?] possible deadlock in v4l2_ctrl_handler_log_status
From: syzbot <syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com>
To: benjamin.gaignard@collabora.com, daniel.almeida@collabora.com, 
	hdanton@sina.com, hverkuil-cisco@xs4all.nl, linux-kernel@vger.kernel.org, 
	linux-media@vger.kernel.org, mchehab@kernel.org, 
	nicolas.dufresne@collabora.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 9801b5b28c6929139d6fceeee8d739cc67bb2739
Author: Hans Verkuil <hverkuil-cisco@xs4all.nl>
Date:   Wed Jan 17 14:52:04 2024 +0000

    media: v4l2-ctrls: show all owned controls in log_status

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1278acec180000
start commit:   b1d3a0e70c38 Add linux-next specific files for 20240208
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1178acec180000
console output: https://syzkaller.appspot.com/x/log.txt?x=1678acec180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bb693ba195662a06
dashboard link: https://syzkaller.appspot.com/bug?extid=9948f8e188482c5d1a3e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=148953c4180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1746f9b7e80000

Reported-by: syzbot+9948f8e188482c5d1a3e@syzkaller.appspotmail.com
Fixes: 9801b5b28c69 ("media: v4l2-ctrls: show all owned controls in log_status")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

