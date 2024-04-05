Return-Path: <linux-kernel+bounces-133016-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB598899D7A
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:46:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 825D9288338
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 12:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 511B116D337;
	Fri,  5 Apr 2024 12:46:23 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52DB11E52C
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 12:46:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712321182; cv=none; b=bvec8gwhKtqKzN/qxir9m9w/iAu77RsPsuhIxLCw7GGv7DpWA8gafB8AGVtKuP8dfRS/bZMkVLNjo0F0qCMQJvK7rf1RLfIeVJNzYJp20EQJXO6blVJIMrmYIIgi/ybULE6e12H3k3t6a9A3ImRN3//5yFzAj4pxNnjuKb5Wm5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712321182; c=relaxed/simple;
	bh=WRsBuSjHUzTQxBfLyZla+hkSSKIsEqFIsaME6OB+fEo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YtwE9EVVQVDYk41p4r4l6ZRtu0WsTIObDvfXfdLpEf/BbFeXbpOjjjJFxVQKa077vJTOa3av1+jaOBi2jW9bboeUa10o1NCGAkg+WiNTUv0GvhrUjkjVJcBPip7Q/DtGFwjqvkmrjOUukgayuY8+rMJ/FRRSg2QZcXSvAoMBpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc764c885bso233751939f.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 05:46:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712321180; x=1712925980;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=12OUjT4o2BmUoPYzd0RNRensS2gycfoa6iSCUdJDBjA=;
        b=Bsv9uwiV9BgSled3z8U++2jFy4otMv1q1pNmAT2B/U0zj2gGlAPeVWQT1PUdqZrtkZ
         O/R/XLNNU4EHgOiKV6mhnpZfzdWJ8zVhCzzbdU3dh/HRq54TlQPONA7rW+grxw/LGjm6
         Jw8TwUTKluAvhcOxuPhce1pHtGcnpWn8yYCTU6EAfRdOgIA0NAImHwYYAeg4XDB7M/E3
         MsFb6/yCviFQVFTfexMLe9AreuaNngqT42Bc3kQL/7YmKzYeFe+m5hJdlUCgciYBO4t2
         e+EDiweiYFvqgFO8xXSqFewd1EOzXTVm7sBnXkHz9MIMeM/z2z/uIM65MtOghtJm6Nt4
         YSKw==
X-Gm-Message-State: AOJu0YyQgqgGeMehtdsa4oHxAaV58Tjj0wHkvcjubwU06Ga092N+OqLS
	d385/1Ra0J2DTwO7giKUr6UhiZleHtmwruw17yTcJMXepvG3bmSbjiGSIjneIcInXWKXnpLCkgN
	NhPBecgRJdcHzIYMHhxo4jNefVPdfaKbdRq1IyjNeLs9kFoGP0v8guWQy+w==
X-Google-Smtp-Source: AGHT+IHUSX+UTWlSb1AR/cJOIfpFBOJBQ8I/qjxG90HqOzL/9/H8NsvcgYdPdnTHg42wBEgpmd6txjF7jo0+6QOsy/mwLPFP5/lx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27c7:b0:7cc:342:72f9 with SMTP id
 l7-20020a05660227c700b007cc034272f9mr29400ios.2.1712321180474; Fri, 05 Apr
 2024 05:46:20 -0700 (PDT)
Date: Fri, 05 Apr 2024 05:46:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4284f061558d73c@google.com>
Subject: [syzbot] Monthly wireless report (Apr 2024)
From: syzbot <syzbot+list390ce5482b806d5e0aeb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello wireless maintainers/developers,

This is a 31-day syzbot report for the wireless subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/wireless

During the period, 5 new issues were detected and 0 were fixed.
In total, 31 issues are still open and 122 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  7813    Yes   WARNING in ieee80211_link_info_change_notify (2)
                   https://syzkaller.appspot.com/bug?extid=de87c09cc7b964ea2e23
<2>  7129    Yes   WARNING in __ieee80211_beacon_get
                   https://syzkaller.appspot.com/bug?extid=18c783c5cf6a781e3e2c
<3>  4419    Yes   WARNING in __cfg80211_ibss_joined (2)
                   https://syzkaller.appspot.com/bug?extid=7f064ba1704c2466e36d
<4>  925     No    INFO: task hung in ath9k_hif_usb_firmware_cb (2)
                   https://syzkaller.appspot.com/bug?extid=d5635158fb0281b27bff
<5>  862     Yes   WARNING in ar5523_submit_rx_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=6101b0c732dea13ea55b
<6>  761     Yes   WARNING in ieee80211_start_next_roc
                   https://syzkaller.appspot.com/bug?extid=c3a167b5615df4ccd7fb
<7>  47      Yes   WARNING in carl9170_usb_submit_cmd_urb/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=9468df99cb63a4a4c4e1
<8>  39      Yes   WARNING in ar5523_cmd/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=1bc2c2afd44f820a669f
<9>  7       Yes   INFO: task hung in reg_process_self_managed_hints
                   https://syzkaller.appspot.com/bug?extid=1f16507d9ec05f64210a
<10> 6       Yes   WARNING in drv_remove_interface
                   https://syzkaller.appspot.com/bug?extid=2e5c1e55b9e5c28a3da7

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

