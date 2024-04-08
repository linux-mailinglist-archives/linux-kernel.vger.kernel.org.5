Return-Path: <linux-kernel+bounces-135361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C5A089BF7A
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DD2B1C210E6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55EF174BE5;
	Mon,  8 Apr 2024 12:51:48 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54C6CDA9
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580707; cv=none; b=aCphCP5FAJ1n+0uaYca3BcOFI7XKK+lpU/Wl73hsPLwUppDr/R0/wVYcWQuNe1kUi6Mk6jqHC+I6Nc2vBaCFLx13sHrichhJl35AbwFL9YI33w/8CWs0yrd0MFLj3TzQADv+NmSU3aa8ANk4jGMku40SlDBL5W2W4JaQ7Y1/CYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580707; c=relaxed/simple;
	bh=UlDn3u++VeRTZAzlozVhYrVIfqq8x5y6K4ftZAsXbmk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bHxVX15t6F2DbW8/jYdNXBwkTdPlgqpMaSka9Tnsf9fDUcqosRPiDaDe8yf1smVdjD/gOrZTKWl7y990v4QzbLITzitVoVjPIpG+D9xc5AOtA+9k5S+fZAN5i3+djxUwJ/aLnuPnbp8HrpVLXtFvfDVkUHYDi6RO71rm1JyIcjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36660582091so51249465ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:51:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580705; x=1713185505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7h8z+6KiyxOrExyagXtxcsJEsWxSoMptUt8KwlryBoo=;
        b=NU9sJCafPwrVmCKseFYHcGdIyo8SwpKcM5oEc0cwqm1nwU4SNWlSeI8hj/q9urUp50
         n5E3xm7RnoJ5Wi3Lh0k6Ag8nb11pWCMwADmK9GKOo6bz5ASqhjFm7/7Rxz7ZPYL4MAkt
         AqeutfMICcudMdPk6zFzvwcOVwvYbN0TPZWDUne57T+DeMV7mtp4qVQn8D/lSstM8YAn
         xDk3jwT58j9cu9s9W7aJ0XNohp8NDh4EHzaZGGO0/liY+K82raXmA2BSBHK71UMSxFtD
         lfIJJc6TQmb9UcPMSagciX7bjn4zSpKwXrONSztOhjFi1YzPaTDIm28tDEBaCjYwvaEl
         qA2A==
X-Gm-Message-State: AOJu0YxJ5aYPSljXkHvOW1Lht/4rezdhKAUp4u9GZ+XF3Te5bJZsGBS4
	YIT22zl0zQXMy2Yw4ODvAwl/fzU3DH7XUuTWGgb3cP3uim76AG9MSAJn0uNcDO8+iyNaPbFJgGo
	cZsugeEPzQ56lzAD9Zwe75jxF+tLi7qpnTa9O9d26MQHN0B5/3oOEqRMjBw==
X-Google-Smtp-Source: AGHT+IG3RXDgu1mZrMGeacXrivnfLnJeUxeVWoc6ktafOUWjoHbP13kwuCJYGVN0ahs8jANM22OwW6DLXaUcyHwM8k8ppKipmGoE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2488:b0:36a:20a2:e493 with SMTP id
 bt8-20020a056e02248800b0036a20a2e493mr335683ilb.6.1712580705601; Mon, 08 Apr
 2024 05:51:45 -0700 (PDT)
Date: Mon, 08 Apr 2024 05:51:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009b56fe06159544a4@google.com>
Subject: [syzbot] Monthly usb report (Apr 2024)
From: syzbot <syzbot+list56b350aa6b0ae73ad4c4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello usb maintainers/developers,

This is a 31-day syzbot report for the usb subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/usb

During the period, 4 new issues were detected and 0 were fixed.
In total, 72 issues are still open and 332 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3410    Yes   WARNING in firmware_fallback_sysfs
                   https://syzkaller.appspot.com/bug?extid=95f2e2439b97575ec3c0
<2>  2870    Yes   KMSAN: uninit-value in dib3000mb_attach (2)
                   https://syzkaller.appspot.com/bug?extid=c88fc0ebe0d5935c70da
<3>  866     Yes   general protection fault in ir_raw_event_store_with_filter
                   https://syzkaller.appspot.com/bug?extid=34008406ee9a31b13c73
<4>  621     Yes   INFO: task hung in usbdev_open (2)
                   https://syzkaller.appspot.com/bug?extid=b73659f5bb96fac34820
<5>  401     Yes   INFO: task hung in r871xu_dev_remove
                   https://syzkaller.appspot.com/bug?extid=f39c1dad0b7db49ca4a8
<6>  304     Yes   KASAN: use-after-free Read in v4l2_fh_init
                   https://syzkaller.appspot.com/bug?extid=c025d34b8eaa54c571b8
<7>  274     No    INFO: task hung in hub_event (3)
                   https://syzkaller.appspot.com/bug?extid=a7edecbf389d11a369d4
<8>  225     Yes   INFO: rcu detected stall in hub_event
                   https://syzkaller.appspot.com/bug?extid=ec5f884c4a135aa0dbb9
<9>  195     Yes   WARNING in cm109_urb_irq_callback/usb_submit_urb
                   https://syzkaller.appspot.com/bug?extid=2d6d691af5ab4b7e66df
<10> 189     Yes   INFO: rcu detected stall in syscall_exit_to_user_mode (2)
                   https://syzkaller.appspot.com/bug?extid=a68ef3b1f46bc3aced5c

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

