Return-Path: <linux-kernel+bounces-92229-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 047AC871D1E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 12:11:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1B2C286E3A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 11:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 624385A783;
	Tue,  5 Mar 2024 11:10:31 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D88159B5B
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709637030; cv=none; b=i+aMD2zzT1LiD+grJIofK6rseYmcqOIoczhNgf99xTm/GbUDvWk9wkSIJIVJVyTYJfWx2cZkCRpJqb4RrSlzqOlLDPXe5XT7k4y/IaryToH0qBeuJSUQ0VGnUwSxdoUildDWHEHgenNWuPASjAgiSskH9uAhb2bVoYggjbgJNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709637030; c=relaxed/simple;
	bh=3aWM+91DGc9RE3bgTrHL867wjYtGysNmqDvLBzzTZaY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SjUKDJo/YNcFUuqzgKc1f1B10J0ZW/6RY/TtdbcNnBiBQIgWIlPVZ4+Ak4yEi7P9pW1ORYbKAOFigx3GOQoQfnEzL5BwPLR0T4j3iL1MYuifzgeRVK2NgaNqRsh+CjrQDyaKtgVs4C8PPQLVYau2FyJdToZtUNJpn4WBxm+mIyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8713acf98so49839f.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 03:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709637028; x=1710241828;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GlbGQTRl1i1EmCVY75Q3aR01OrbCMT+99f6zJT7YSHM=;
        b=muTSICtE7+UnfT24k/JDdnGKCO7hjfVMpEX41R6T86IlFIUQv3ngrKFxXQQ3+/BhCv
         5ESr6VcXjZB4RF4UPJSQdFKUuUIPZZWAW4ZUBArTzAjnr5HAO5gfA10y/2KgFv4Ir5F/
         Far1MP+g6T+6W+kuyD6iaU1v2rX0TosWndfLicqWfnvm+vulNrI0ApkTjuucjqu319Go
         TGmlkwjWYrZUK84k/D/ZiccyAHCFO5ZL9NgfsKJp3tfIy2z2NUu3AVKAx/S5I9b42jOZ
         U8Nq0u5FQVV9Ezk1bmbdEtJd/2++szmzGvOxjY/Rtl9V5pCxJ0vi9FJlO2BXKPaBNH4p
         jm6w==
X-Gm-Message-State: AOJu0YwnKRG81JSHMAUP090tEbG7H6BFeJx82CSnnZTSPLaeBlArXtRH
	EbtFJrdYLDCr+oAhVHId8jCIBsT+wDWgSlsmDbIQhydIRL8e20GLbb5S90zsr2quZGi+yfWvJXv
	ODYLaQWbxp9lxAtFzo+nEmIGEkrwpmqNwnODPDvM+b3UVstDbZbrektcTsg==
X-Google-Smtp-Source: AGHT+IHp3WS83ust8Ksdj+hUBC78IFEEyfY1HV/DLw6pXRpDzKVan7IPZBIFLya9QJyc2diwAZ/whRJPVClTM6jKlj+30It+RNUg
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c241:0:b0:365:1611:5d5b with SMTP id
 k1-20020a92c241000000b0036516115d5bmr638510ilo.2.1709637028447; Tue, 05 Mar
 2024 03:10:28 -0800 (PST)
Date: Tue, 05 Mar 2024 03:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c690fb0612e7e30f@google.com>
Subject: [syzbot] Monthly wireless report (Mar 2024)
From: syzbot <syzbot+list1dffa7f965b817f6f840@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 2 new issues were detected and 1 were fixed.
In total, 28 issues are still open and 121 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  6920    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<2>  6045    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<3>  4412    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  1222    Yes   WARNING in __rate_control_send_low
                   https://syzkaller.appspot.com/bug?extid=fdc5123366fb9c3fdc6d
<5>  844     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  750     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  720     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<8>  73      Yes   WARNING in ieee80211_free_ack_frame (2)
                   https://syzkaller.appspot.com/bug?extid=ac648b0525be1feba506
<9>  46      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<10> 38      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

