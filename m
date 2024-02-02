Return-Path: <linux-kernel+bounces-50591-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 094C4847B56
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 22:09:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 87E401F2A79C
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:09:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CAC785956;
	Fri,  2 Feb 2024 21:05:26 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B697A72D
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 21:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706907925; cv=none; b=k1Oxm+r9NhlgV/g2/ehm0/jvN0YWLm48BHO4KowFvdH5KTkRuXG6HHneCTfBkwjFBSa9MZXP9N34+gWFZtfB9NlTP5/5UEyul3CxItwSPq093ySGyI0Pw91SIjxJh7C+JPVLegWx64pAy4pWdfQygdoWEAZtCoZlGScJh0FycNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706907925; c=relaxed/simple;
	bh=tPNHe42qhpvxWugl+y8i8cSrXsEAh6eoqotuLxhvPAM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZJMKc6RXw0cJRaljq3Z9Yd9v01Sb2o5mju9sTnSFV3koE6c/ECm75gaL7+a1uUg4SN37An9KBMPiRDAq6NSKsmA514eA5jsEjJR+CwtXaeI9GUWwU6tA9+itNVtKFV2W/l57+uOgAkktWdslhV3EptG/555WF1ZhEyXbJfzsMlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bf48e0f513so233461839f.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 13:05:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706907923; x=1707512723;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vFM4+u+D/xmqSyRabC7ssS3eRs0J/GqQmfrIhUog/SY=;
        b=tdytnBjWn8Mcw9YQRQvBTkazhKRrMErqqF5qMhfjyv3MeUPt9EE5QHH3FUYlc+2/Ss
         8o9KblnA5mD/o2O8LvfgcDdTHYSOaRYNh6n+Ht/e2MUT/skF7kvCoFd/0lYVQ55l8PrS
         Im/pJev2UZO7W6yITzDNP4ujiXQrt3Qtu4qI9IAZv1HEyIiFUJGjxL0tM6pWgObj6a6x
         emA6+HmzRglaA4CDG6+FagU1R/MQVtcC2y10Xth2FLqzlFvUhNAlFpEsNPeqNcTRs509
         7BkZjr3vko+cMrBfQo7Htjt46PCHOai2K7RIS2pcKcM3mzewV5Kse5rQjMXO6AZ6XtyY
         b1dw==
X-Gm-Message-State: AOJu0Yx9u6YOfXFV0T8qLcPKUOMIIthSKYYu3V+6PefOB+hAsiG5Es48
	3Xk+wHyiOgCcdcLSUp8gJh9lssCpEPagngAgADW1luz9rt16YZJnYTvWtWePIAc5aWbBN2iTbVY
	7pBuBiURS44hHyFCO6B6My/YqWzsId8cAVvFzZuTaO2QqpXgxzPOj1WM=
X-Google-Smtp-Source: AGHT+IFZ5k2HQeFwYdOHV1q9HUo1V7+1oMT1vQYZjiKlMix4m2CzNWzvCXvj8f7jLh9vYEXkIMVXTcH/0hat8fvQIerkXfGDtDdP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:45:b0:7c0:4a76:2422 with SMTP id
 z5-20020a056602004500b007c04a762422mr31621ioz.2.1706907923656; Fri, 02 Feb
 2024 13:05:23 -0800 (PST)
Date: Fri, 02 Feb 2024 13:05:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000074375c06106c787f@google.com>
Subject: [syzbot] Monthly serial report (Feb 2024)
From: syzbot <syzbot+listbb8340e4e1f8191bee93@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	linux-serial@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello serial maintainers/developers,

This is a 31-day syzbot report for the serial subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/serial

During the period, 3 new issues were detected and 0 were fixed.
In total, 16 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 51656   Yes   possible deadlock in console_flush_all (2)
                  https://syzkaller.appspot.com/bug?extid=f78380e4eae53c64125c
<2> 4747    Yes   BUG: sleeping function called from invalid context in console_lock (2)
                  https://syzkaller.appspot.com/bug?extid=dbac96d8e73b61aa559c
<3> 207     Yes   KMSAN: uninit-value in n_tty_receive_buf_standard
                  https://syzkaller.appspot.com/bug?extid=559c7fe4b8bac56d38c2
<4> 121     Yes   KASAN: stack-out-of-bounds Read in sched_show_task
                  https://syzkaller.appspot.com/bug?extid=8d2757d62d403b2d9275
<5> 73      Yes   general protection fault in serial8250_tx_chars
                  https://syzkaller.appspot.com/bug?extid=837b8c9032c053262db8
<6> 60      Yes   BUG: soft lockup in tx
                  https://syzkaller.appspot.com/bug?extid=5e87db90e68fbc4707c6
<7> 36      Yes   INFO: task can't die in show_free_areas
                  https://syzkaller.appspot.com/bug?extid=8f41dccfb6c03cc36fd6
<8> 6       Yes   INFO: task hung in paste_selection (2)
                  https://syzkaller.appspot.com/bug?extid=275e275bd3f536725dd8
<9> 2       No    KASAN: slab-use-after-free Read in tty_write_room (2)
                  https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

