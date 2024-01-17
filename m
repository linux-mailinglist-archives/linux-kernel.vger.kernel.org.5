Return-Path: <linux-kernel+bounces-29482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F927830F20
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3DFF61F24C6E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B8B286B9;
	Wed, 17 Jan 2024 22:20:26 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E4E2563F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705530025; cv=none; b=auAH3jBIJOR54qtgAKeY4bukh8xu7fuJ3mFnhiRIS0pkwjzf9gH3bCKBFt89bYlDG3ylDNeYcfqKStQhxYI3F2T8DHwj5U0ET6r4rAgUTOR5/L8L4hWBczHzFQh6G6m/YdBQ/BoGsOvHun0Yj4nQa6DdyNR0y99vzN40fI0Ojic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705530025; c=relaxed/simple;
	bh=KB1471y1XKx6xdGO5u/QjdpW08VInYUwNZQLrfxQroI=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=TA6AwGJOmDpmlUjwoYzc4Qo37swiEvbBWqadEFDGgAb31/v5XaQ2ezIrvYkgIN+2ZejFc79CrVyvAqTfolxEPDCGZorrgs/gE27uQ22vGu3sYMPf7HaLB+Q7/E8JW//wR5+1m0KiCphvKkzg55uu4GNjci6SeJKa0fceZF3hryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36195724134so9484855ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:20:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705530023; x=1706134823;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8tV4gRU2K0YE0IjE7ArrNBUc0MHW7ZpL4XfMaNQQYMo=;
        b=WofY6MLLtrRlqifOMTcII+uuTui65h60s79E6MsgELHgkYhFU1DhWWr/h17Bks0D9d
         YyiXh6dWNho086nJeH8efot6AXRF6XqQAr8+rY0dBhm5KUiEMo9G2EGMu2tjYVxJEXZU
         c0eVNj+MsjwQSt6z+hRfdJoyx9KBallk4XdojwBix4TeiA2JlMlKd+S2z4Y3yGwX2IMO
         QtbzzVL2Bk16C0j7+bIQ/nMQlLn6UcLVO8A1omd0Z9lgeA2rriOQF3pYBy7aj5Ecoht/
         xfWFFPL6+CQCX7MCLRT790zrQCYosheDPvTR/AHqD+r6cvbMKA6nWL2t6dkFWJwRqCv8
         LpCA==
X-Gm-Message-State: AOJu0YxRQdkEFTfl/sBCWNg8Od5ee3Y0AuZ3WriSbCT6IKfUX8rX+aXg
	I0WORUHg13oNWsmNrUDzbYwOKrvVz+d3zHuPPkytRdxjTAxU
X-Google-Smtp-Source: AGHT+IHxqpZP0uv7lPrdEFdBKRFzHG2O3t34ovXoLfNBWilymfKi6pCvba5IFy5rlNfOtpPM50stwngkTz5mzyQlJrSRX/qN98fl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:164d:b0:46e:677d:9028 with SMTP id
 a13-20020a056638164d00b0046e677d9028mr436199jat.1.1705530023539; Wed, 17 Jan
 2024 14:20:23 -0800 (PST)
Date: Wed, 17 Jan 2024 14:20:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000034f719060f2ba746@google.com>
Subject: [syzbot] Monthly wireguard report (Jan 2024)
From: syzbot <syzbot+list3b7ff8aa9cee9123dcec@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 2 new issues were detected and 0 were fixed.
In total, 4 issues are still open and 15 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 841     No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 1       No    KCSAN: data-race in wg_packet_handshake_receive_worker / wg_packet_rx_poll (7)
                  https://syzkaller.appspot.com/bug?extid=97d9596e4ae0572c9825
<3> 1       No    KCSAN: data-race in wg_packet_send_keepalive / wg_packet_send_staged_packets (6)
                  https://syzkaller.appspot.com/bug?extid=6d5c91ea71454cf3e972

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

