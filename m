Return-Path: <linux-kernel+bounces-61308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5018510D0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 11:28:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B52DFB25024
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 10:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A62C37710;
	Mon, 12 Feb 2024 10:26:28 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB41EEFD
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 10:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707733587; cv=none; b=QvbrJCe8WvAKY1bflqBKdZYUqZVKWdTcnjX3LLxcQ84dgnPgKR7MWlD9d7K+CBgUkKPbB3NtIB6I+zy89bop3yy/fYY7y03BNKGdV5xQsrV7oE7IjRKrdb1vP80SGEvcsTgYlBsaeJ+ylGHny3IQpm3C4BxKNLuBkiK+f64yY4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707733587; c=relaxed/simple;
	bh=531Ts2F2L+gYAuoaLZw+susPFcEHA9WVYqQFaFOod4E=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TVjMTvUCmjeJmqQ8tdha4wK3fNUa+lnV1MesF4y6nhHh02y+yxnuvlX52KdQPrHtTNoJ59l0AGbrrQ2EOeWAU++IiOfVXriwTN4UnFK9cVBpICaLRz5mSoujQoXXXQ+76ICIdUoLbRpyzUiw8LDWA7HFOCKsu/REjSkLpIztO6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-363cef35a5eso29584095ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 02:26:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707733585; x=1708338385;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ROTc4vXH6Cy6WhFsQYMvKi8mWbRCVNpoUTIHgUKuxwM=;
        b=H6bzQyfe8+OK6G1nMyd5ATtgNBOMC9Nzxvve2QBM3tcftOmnxYXf5HP/dKVQJv/0ou
         nX/oKF9IONM3Qkw04sz7JgVY1MA6OiMs7NySdPgORYEDAjh9KfLVQAVlw9AHuKp4zfe/
         7z9IOtOCXAVyUzf9XBhdMK8D3vTUtiiE+fVojOSW+Ov34mka88+TKv0GgjY6g2w3Dn5J
         YaBGnFJJ9Y15QH79CPdVlah17w7lB0tNgEtS+2nf9C9C2Je8a33+d2M8wHEDy5ZLY06g
         c+s/NvoS4mRJckIMqqnML3SK6ASmnFaXGCRFZDcTvQnW8TTIDrJ+cfnC/MdJqRoHNTKT
         OUnA==
X-Forwarded-Encrypted: i=1; AJvYcCVXNobeajRF1QHCjOI5PM/Y5sHgXKxIg28wPWrf+Q96iVLojBQiARLf0bg/TU/AS2RFmLH2+CDc0Tjh8MNwwFSNLWBoc9P8XJd3qAGy
X-Gm-Message-State: AOJu0YwJ25bE5JHmqxT92hOaQRcuyDsDJyeeA0BAo5FY6QPLvO9KkRQN
	1H4ATWFDp+ItNdo8fR+s4SK92So1p2Woqg2rkRj5ybaemjKw7D73jUbsZDvQtogI2YtU2e4s+2w
	zxBixsUKxWHkPmcHlZQ7xQs6UYHdTxvs01x4BI4EI3ErCGeo1f0fU4Cc=
X-Google-Smtp-Source: AGHT+IFUCXdMO3Od87whdVdGgxMLtPs6AyV1D6OtQpIeraQYtc9ov1pY9Mo7EZrJk9A2zYklaR49LIaQtm3zy5wmqx28XAXLtq5v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218c:b0:363:bc70:f1b1 with SMTP id
 j12-20020a056e02218c00b00363bc70f1b1mr572390ila.2.1707733585268; Mon, 12 Feb
 2024 02:26:25 -0800 (PST)
Date: Mon, 12 Feb 2024 02:26:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8955106112cb5cf@google.com>
Subject: [syzbot] Monthly nfc report (Feb 2024)
From: syzbot <syzbot+list19658f79671580b2ed42@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 2 new issues were detected and 1 were fixed.
In total, 11 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 810     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 135     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<3> 36      Yes   INFO: task hung in nfc_targets_found
                  https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
<4> 25      Yes   KMSAN: uninit-value in nci_ntf_packet
                  https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2
<5> 22      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 5       Yes   KMSAN: uninit-value in nci_dev_up
                  https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

