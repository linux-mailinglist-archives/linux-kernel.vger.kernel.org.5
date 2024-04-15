Return-Path: <linux-kernel+bounces-144830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01E258A4B61
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 11:23:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 844A9B2148A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 09:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27B833FBA5;
	Mon, 15 Apr 2024 09:23:20 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803DE3CF6A
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 09:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713172999; cv=none; b=JVRN/uMHZ+34Qx7FBKV6cEiuX6Gtln+XlRCxSJgeVE5hnVVvRSknJ9t578IOZjh5+haeVNbECVjOFt5J500hy2p2xMMT/vWN4+2wlbT1XX/f2Bik/uLFYz9YYEzlXrGWDOc7qPw968mBIZvzwD0WqETNZNoZ/DWKkcVR1muEsfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713172999; c=relaxed/simple;
	bh=1R3b+01FBqsK89omiuCfSSv5XfBcGhv/E9FDyrklszI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q2DaCipAxv7uEZBlF1hw4ra/kY+vO/KJxt032Yo3fD8pa3PyaRpyeWQ2F9hZoOqjfWcKYXg5BkqqYldloh2y1HEIVPghvOBLxyn/jGfMyypI+0DfUrLlhMjr/SORzo6r3Dvb+6PNr8Flwlswh+It52V8GOFbqB428KnR0Dm+Sio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so304907639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 02:23:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713172998; x=1713777798;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GNp4QZ8G+4M5fH5n//pQKxqEn38eSths+NGC58BJ3gA=;
        b=lPghPwiBEqhvw6TG2/nLYn6Xvg/oW1l6aqr8LTjAeO5sVRWqLt1pLHCEIX2dWf66Dy
         4Z2va3JHJkrx8BgM49nHESDm0RprPY/Ops5UBFwe3IxMhKyJtlP6saPepLx6Usre+z5j
         8wJtn0/3gR9CjHKcF0BpoTUjItj+ubg36Cl/7CQv3nAeSSREbefZpCmrqotwTHwGR6Z9
         tabEwfpd4XEySwHOq9Abb6wGmVxrVpjR7itW0+Y9PM/3mggryRMaLkRsjGbPmpkJ9f5U
         ABMP/gciEztZyEDRSV1379MqBZOtam4Fzs8rpZHo1XUd+H89sktUlX2DMKXmlLvpmLYA
         XtSQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0pq5t0qcMzMEuflr85BaMVL7r63EQabj6QlyE5fy369/5BPhNtzpDKLnNI5LsHQRdgVj9XiidM6KvU87u8bakUDA6LvmyNc9egQsL
X-Gm-Message-State: AOJu0Ywg+frG0V0lMmnCrHnNbV8GkblM7PMzk7GwfarxqnaGa4/opvzQ
	uk3vQ1pCI20xRZcaVgdRHlpiWjtyf1YduD/ailEYSbG4xUhbI0OSEECIl9u6WIFZj3fmvdHbqI2
	7E3flnyjQFNKmIjNGi17JLMNJ0i0CfIFjFTLkWRQQPKXjuQFHA9JBYyQ=
X-Google-Smtp-Source: AGHT+IHiVaUzy6lx78eL6QuWHokphRvLeb0POIZk1UNBzOjle100VhF6YWBFxZpxxOCZTQgVxZ5p1WiY+CESWkkoDHltH0kUiUej
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2720:b0:482:dafb:95b7 with SMTP id
 m32-20020a056638272000b00482dafb95b7mr530840jav.2.1713172997784; Mon, 15 Apr
 2024 02:23:17 -0700 (PDT)
Date: Mon, 15 Apr 2024 02:23:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f8e62006161f2bf5@google.com>
Subject: [syzbot] Monthly nfc report (Apr 2024)
From: syzbot <syzbot+list076b173dc0214a44347c@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 1 new issues were detected and 3 were fixed.
In total, 11 issues are still open and 24 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1024    Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 167     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<3> 45      Yes   INFO: task hung in nfc_targets_found
                  https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
<4> 33      No    INFO: task hung in nfc_urelease_event_work
                  https://syzkaller.appspot.com/bug?extid=e9e054e7ec32ca9f70da
<5> 26      Yes   INFO: task hung in rfkill_sync_work
                  https://syzkaller.appspot.com/bug?extid=9ef743bba3a17c756174
<6> 15      Yes   INFO: task hung in rfkill_unregister (3)
                  https://syzkaller.appspot.com/bug?extid=bb540a4bbfb4ae3b425d

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

