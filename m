Return-Path: <linux-kernel+bounces-74576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14B985D62C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7123A1F215A2
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F025E3F9D8;
	Wed, 21 Feb 2024 10:58:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221363F9C7
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708513106; cv=none; b=XdleQDthOksGQjWRhmEclqjBUgyhB20vCQ0r0T3A/QunvzB3iVUDDKKBTzpMgspqBqIB6wcwm6ETVAcBBk7HgImAAWJmTLLWaHqHCNiC2eqw8KKq4sT9x/SDe1fBxBbmZ0Mof9L98tlK2laicKohoPLM8w2RsZ67RJ3VDlxEQwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708513106; c=relaxed/simple;
	bh=lGPQ43gb/7NPsiaz7Cp7fgKM8BKLJeb9YsmKQc95CeI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sYvYKU6r7NqkbMwKlzXC3NYgsCDbgUQjc9kq5h56h1wH232zK78AJJgrcdZuv8JTEZnePm+m24hhq3LfQ/ilHMQXHrq/6xWYPoszrxi1hV4/VSeGaY0b70ugi64Yj16hLpxtRhQbVBxParTz4mfQor7btdsaFpToSrGkw9jtMuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3652275e581so5005635ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:58:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708513104; x=1709117904;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5jm6Ei9nJOAtDNiwBs++J+e2bUk4eeHrUjSMfCNj5Lc=;
        b=h7lV6J5Y8XI2BlvweKHfkDKusbMLeiU/Ad4KIJVTx4N8i2xq8VMOLdQ7xgfx7KwtDu
         kfkLlFTFSOAQYwzAZ24QlbKGdrAi5BE98LqPIlPI5oNdwHSptLHqNNhGMxlJPf0O6U+R
         1adzB4pBbii6CM2P7K/yKKqOluChjGsl27P/dfRIKGa7eBPVfF1pJvbJBf8y6oY3xQe8
         izbWdl4ME7i95Epc5zLEDJZj68JeZ5mZQrzz8wTPfURvyQvMOrd3zPeCA8elKJkMt5OO
         yBK73gfMK70CF9Aj4Dl2dOhbcX/bOswITPvJtyp7hIIF5Qr13uBr8HrlczMWnIq+RoXt
         PFWw==
X-Forwarded-Encrypted: i=1; AJvYcCX2XmaEyyHo5D77indPYU5i8rYUcISj4/6TAj3mS5eJ/qQwIfuXOw6+qtTCMlcOsa18oxTJK2SBWop5RywivHL+DI8Bf6D3yDPUWtie
X-Gm-Message-State: AOJu0YzcvK4OHA0gLJRKPOPL5oW0paC93db9zzwkUd5YJWKr4etjqZaK
	HrEpmzM5f3nbg7a8m9DGQJzgNd4fx4vL109R/mDE3Kh3uZUZvd89bAqRhP+zYOxl6CgzGxsVLdy
	tL0gg7btk6nnr7Oye9bRf3vqpDQniQmrY702rey04SsXfhTtTBsCkivo=
X-Google-Smtp-Source: AGHT+IF/JWOtF3bGcvLFPn3GepiEaaD446INF6uZGhTQ4fNNmNDEu93tyDBDGuF0MTsp3ToTDrXiTZpCQ4CRsnblj+TOTDzWYQpL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4d:0:b0:365:21f4:7008 with SMTP id
 q13-20020a92ca4d000000b0036521f47008mr979051ilo.4.1708513104412; Wed, 21 Feb
 2024 02:58:24 -0800 (PST)
Date: Wed, 21 Feb 2024 02:58:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aec9480611e23402@google.com>
Subject: [syzbot] Monthly wireguard report (Feb 2024)
From: syzbot <syzbot+listb237e3b69c5568cf7073@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello wireguard maintainers/developers,

This is a 31-day syzbot report for the wireguard subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireguard

During the period, 1 new issues were detected and 0 were fixed.
In total, 3 issues are still open and 15 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 868     No    KCSAN: data-race in wg_packet_send_staged_packets / wg_packet_send_staged_packets (3)
                  https://syzkaller.appspot.com/bug?extid=6ba34f16b98fe40daef1
<2> 683     No    KCSAN: data-race in wg_packet_decrypt_worker / wg_packet_rx_poll (2)
                  https://syzkaller.appspot.com/bug?extid=d1de830e4ecdaac83d89
<3> 1       No    KCSAN: data-race in wg_packet_receive / wg_packet_receive (7)
                  https://syzkaller.appspot.com/bug?extid=fd07f3da9110f5f18b4f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

