Return-Path: <linux-kernel+bounces-135360-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F11F89BF79
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 14:52:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F9CBB2252E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 12:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14F3971742;
	Mon,  8 Apr 2024 12:51:48 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2276064CF2
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 12:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712580707; cv=none; b=XzMSh/ckEMccUeBj+hk1AgbThBgSwZG2UQjFY42TmV0HFdsRdpzVeCoa89MhlJs1R5LDSpzafYJLu1Es5yk0O1jSYlb+fVNjBTLXtXwKmSvYs9yq8o7Y943UGh1Sn9xN+vrlkmXYZ1107PAw47hBi2GSm/Cxhsm95SFzuskZQT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712580707; c=relaxed/simple;
	bh=an9wisbyTSnk2raK+dpw1pmjthfdwNEelOBmsVvbcM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RF7tt3Ie8WW90jHuWyiWksfyQLBbEz7tqPda2LkvlyZQoY/Kn3+vXRjtSnqvz/HNxANa9fRsubARlT+TcRNHkl+IQbTD9lyFFAeaOuZuoKcGJP/P/WeOSesfMzedRsazfNr1qHiUc5WRH0otyPccDV/iZi210grxRUjLR/5F3ZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cc7a6a043bso484088639f.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 05:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712580705; x=1713185505;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rMm8OK2iY1NN0ydcTFsM47gu9FTR6VVjcDM8JV5DdKM=;
        b=W43sLCdvNnOKdDR1cRcghGuw2bu/+ZzPGvTT6i9jS1d8XA33fjpiwCuiZQlELtmNCC
         cJrv7k2JKTN+7bfa9U4irdMQ3FOb2TqvmLJplQkiIKgEySEaw0/d3hnsFojZKUE0k4JM
         RxiBYQ/DC2NV4Cpqxap4QfzuM9jdrDDsJgVHFtygzZyECbt1xXjLTn39SjPfCS0QVp8c
         V7rL0Ma8nSMGf6GN7sew2kK+IEGTfwcmLMZ7IPr0S566FA+OxpHPzRX1Ty1UGRiFjgac
         K+J2v5lGgJK29bxleFwwaw42Kz6dwmcPEOepWTnb/dUe7W9Kl2Yz33BnhjmdSFCEcGRV
         KWPw==
X-Forwarded-Encrypted: i=1; AJvYcCXe7sSFpGqJDobElAEkkKz9XMqKxAgEuLWKVIkygHfF5k/GTkndVrZeVOCi3UVxBLcoUJFAqp/7B+GfmncYWZnMeVbQTW33MjwKR4TC
X-Gm-Message-State: AOJu0YzIeoo5hQ5sXhUHyDFuemVOnY+aMKFkSw55EAJuD56rcp7LAOt1
	lUiWmXjSDhyF0wus/HvpEMXtw8PYrqas7i1DdI12tZIXi3xthY79aYEq3gOuUgm0ZKXp43N5Jfh
	vtwUFa07ncyvMLoDYbZATmAiHm/pAp1DpM9zUAvV1r8nO7iqnZhxi5uY=
X-Google-Smtp-Source: AGHT+IG7B6y4/ijfW8yD86XjK/DsDMHgpVQKqQ6rP53+1ZeEQJTt+PfNv0M3oly3Kep2iTpxmqpt3Te4RlR7rALhywnYUV04EYly
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:164a:b0:7cc:ce74:4293 with SMTP id
 y10-20020a056602164a00b007ccce744293mr239694iow.0.1712580705358; Mon, 08 Apr
 2024 05:51:45 -0700 (PDT)
Date: Mon, 08 Apr 2024 05:51:45 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097a6120615954449@google.com>
Subject: [syzbot] Monthly bluetooth report (Apr 2024)
From: syzbot <syzbot+list97e2700fec38f6c59827@syzkaller.appspotmail.com>
To: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, marcel@holtmann.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello bluetooth maintainers/developers,

This is a 31-day syzbot report for the bluetooth subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/bluetooth

During the period, 13 new issues were detected and 0 were fixed.
In total, 38 issues are still open and 63 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  19159   Yes   possible deadlock in rfcomm_sk_state_change
                   https://syzkaller.appspot.com/bug?extid=d7ce59b06b3eb14fd218
<2>  10784   Yes   possible deadlock in rfcomm_dlc_exists
                   https://syzkaller.appspot.com/bug?extid=b69a625d06e8ece26415
<3>  4973    Yes   WARNING in hci_conn_timeout
                   https://syzkaller.appspot.com/bug?extid=2446dd3cb07277388db6
<4>  2414    Yes   WARNING in call_timer_fn
                   https://syzkaller.appspot.com/bug?extid=6fb78d577e89e69602f9
<5>  307     Yes   memory leak in corrupted (2)
                   https://syzkaller.appspot.com/bug?extid=e1c69cadec0f1a078e3d
<6>  221     Yes   KASAN: slab-use-after-free Write in sco_sock_timeout
                   https://syzkaller.appspot.com/bug?extid=4c0d0c4cde787116d465
<7>  220     Yes   WARNING in hci_conn_del
                   https://syzkaller.appspot.com/bug?extid=b2545b087a01a7319474
<8>  62      Yes   general protection fault in lock_sock_nested
                   https://syzkaller.appspot.com/bug?extid=d3ccfb78a0dc16ffebe3
<9>  56      Yes   KASAN: slab-use-after-free Write in sco_conn_del
                   https://syzkaller.appspot.com/bug?extid=6b9277cad941daf126a2
<10> 52      No    possible deadlock in __flush_workqueue
                   https://syzkaller.appspot.com/bug?extid=da0a9c9721e36db712e8

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

