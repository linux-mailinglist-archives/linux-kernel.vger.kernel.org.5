Return-Path: <linux-kernel+bounces-103042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140C987BA4D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 460201C2329D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 09:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290DD6CDBB;
	Thu, 14 Mar 2024 09:23:26 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B22B6CDAB
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 09:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710408205; cv=none; b=llurVt42NuI6qk6v1n6q8jXt/Kl3iKc91Y0lU3P2mhlD+nB2eZZTothDo/BBknKUsztZLTQOHDSf/DNvGpo/BmXWFYJ1qKSpyoyDeQrhZkaFM55JArXim+AnfdmQiAd/wj5UMae2CfT+4CWBXPbKSIoesY0wdSUD8xu/0+cTr4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710408205; c=relaxed/simple;
	bh=HdPNgS2PRN84+QqmdjiGCVLBprs0q2toXD7J54d5g9Q=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LCvpAvPN7rIshLu5GHyYf3yyJMRCOPOaqMFfv1G/77J/fU9YewsEsjdGiH669boufTyONfqpXfOSvySxg5QGhetGGeq2ucaa9yT7I5Ic8tZYQ3VrWrs3DKYq8ibNxwWV4xiQlA0tgcVsNeo4jBVoDb4iNptunGgfkMrAHwH5BCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3662feb9789so7473815ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 02:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710408203; x=1711013003;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cnl3rPO9e4Jwunh0GqBUGtre38f4fNn8+xGZSnr97dk=;
        b=SABqUAQUcE4uVs9Et7y//vywpg0CnhE4Qg8S1qmn1S/aHuZhPfGmDwYZHqCrbuKWpt
         zVojb08qIfoOgu60C12fHDJ5VcjZHfi2qqGZ+iqGVsrP++mSTHxqFNjdxOZES4Imgr5a
         f12PMizjP6AAPrMWmCkfWg8P8LptaUcihY+dkDdWViq5h6YCFZKxUQbTrMObQY+8+GMA
         JqatgDxzKmN0crxE6guSxYzto3kh4hfgFc6QS9YPNj5ux27iVynRIUg/c35T1NF/e+c1
         3KgoO2DB+P0XlFGkeU7c/1T2Ny0sSsm2SeFPJ1Ou9fGXhYrkeTtrPfCWzL71R42BZRCi
         2iNA==
X-Forwarded-Encrypted: i=1; AJvYcCWcNeDzESqMHvq70ducnX5pMI2ti8k0AkvMJwEM+ACocRgPhW7etFKGoz78D5p2+jEDEaOMCcv/BCPBEHXHtXH3VDjaprgVgQvIs9XE
X-Gm-Message-State: AOJu0YwVp1SHSW49jqf4zU0h30zhq1TvhWjA+eXLuyumvtn+l9ITYTDB
	uHqb4Y8SFs+uoLEpd14Tv3pMt2ubMOhLwzCDBA2Af/HYNpb2Wp7GKbPKE8b2a7OaIOP691hedov
	7nsaoagVs/EzlhYiFy3wl4m3Sdm3GtPEWGHlZQO6RoxAeTC3WvJJpsRo=
X-Google-Smtp-Source: AGHT+IGsbEW4Tsgl6Muol8d/yWJNRcsrUQpbImQBAKIkuHgYgiXB+36MzcP95S/cQpWwaQQvyw4DKPnpN5XbJW7Sdzf5lJ5vQSvA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218f:b0:365:3db4:16eb with SMTP id
 j15-20020a056e02218f00b003653db416ebmr71496ila.3.1710408203579; Thu, 14 Mar
 2024 02:23:23 -0700 (PDT)
Date: Thu, 14 Mar 2024 02:23:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000065425306139b714a@google.com>
Subject: [syzbot] Monthly nfc report (Mar 2024)
From: syzbot <syzbot+lista5c2019c6476fd6bd578@syzkaller.appspotmail.com>
To: krzysztof.kozlowski@linaro.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello nfc maintainers/developers,

This is a 31-day syzbot report for the nfc subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/nfc

During the period, 0 new issues were detected and 0 were fixed.
In total, 11 issues are still open and 21 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 852     Yes   INFO: task hung in rfkill_global_led_trigger_worker (2)
                  https://syzkaller.appspot.com/bug?extid=2e39bc6569d281acbcfb
<2> 329     Yes   KMSAN: uninit-value in nci_rx_work
                  https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
<3> 143     Yes   INFO: task hung in nfc_rfkill_set_block
                  https://syzkaller.appspot.com/bug?extid=3e3c2f8ca188e30b1427
<4> 38      Yes   INFO: task hung in nfc_targets_found
                  https://syzkaller.appspot.com/bug?extid=2b131f51bb4af224ab40
<5> 34      Yes   KMSAN: uninit-value in nci_ntf_packet
                  https://syzkaller.appspot.com/bug?extid=29b5ca705d2e0f4a44d2

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

