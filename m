Return-Path: <linux-kernel+bounces-162835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 257608B6133
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5A401283B4D
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:37:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A08D12A15A;
	Mon, 29 Apr 2024 18:37:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41AF83CB9
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714415825; cv=none; b=qsB1+GxtUF/757HrnU57XG9aSnduRXR16E6qnEYsY+9CDzTFFV03wNfXk39LtfcwvLex8aISirL5vPe9Eujc06RHZZyhaQMRi5PKelGZFGHRMq4ViR4L9kin4P2JAA+qpAwZ19AxDrtW7xosn8UBCAqp+JNDGwGwr2hVJVTwgCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714415825; c=relaxed/simple;
	bh=VtpWIt2Cg10SpMJg2TSidcDR0e8buD5s+hNLaTrQo9o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GsfCOWwf+9mW1hR9pufUHpoo4RB5qfCg/Jt6LAoVy3EpyiPNO3XYKFoJjxUp5sDZZn7blv7imI60dCloMg9P3+JHTohfKBNuRpIXqekKpM8CcGhIINcgknZBqBHpso8JGiYe19iOKTCf/9c3SRqtCeh8KnSeciDKKRIxBRgAdfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36c4f83de66so11973115ab.3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:37:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714415824; x=1715020624;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MujhuQRr+Zfbg9mAy/KHY5eP40BaRZQ7dzpBhYWyEFM=;
        b=PbrPRQpEIA9haDJbPWh0Iq10ZF7FcJnne7uaavsz/jvowszQ/TRCYUoKTmFF39z54F
         ItOFJqm1aBR+lf796tg5ZR+g/vnNDDSjw+ZDGV8DoL4lh7wQqI7+BujdsCPeDiYbsPPt
         uyFRYpEGLn4PoiFrUYUKAmzVGBUBbU88YZ23wgZ54Ua5qo4jxmOHvedfDBDmo8A8h1me
         SvDqv7kNYSFkqjQ88B50dsb8gV2oyCsTwrd5Zi/e+Gql4CkcQe0U3hWfEbUUZZV59bjt
         bkNbzgbIgbbqKBFEvR5Te6PNmVD7o0xSSmUB11lA+FItsc8gZhn4W2J2qhhOmQBmCJD+
         MZDA==
X-Forwarded-Encrypted: i=1; AJvYcCWFG/EpxeqH7/nib6VHcDBBxdh0YMOupQzodh671rSPhgPIm4gJnFXrmJExMwEWW5tBKoPgpRIP5J3BUcMvsxEZYIiYJLvFERvN8dvr
X-Gm-Message-State: AOJu0YwRfkMFLfsnkjpEYp8qMC61E4moQKNtCfcFaFam2ssucqMRVrHj
	TZ4Iu+WiKFIygsMe0IKnIT9QuGdrhppuX371C50rKHNR1R7iML9mMoa2dOfwCuQaD5iFTURPb4Q
	2BLmDKyMhPTI1yNyB/nKCZbIqRrVB/Mozo9lLYF3X6aQJ4Qcod66E0UI=
X-Google-Smtp-Source: AGHT+IGz26Ea8EVfxmD7CYD1EYjaqOZ0tv4UBwYEaCP+dicgzHzlyyAYT0+U65N/8UcdrEHzAZFVltcTlujTmNGdSCUHHDgVF6KP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4117:b0:487:31da:eaf1 with SMTP id
 ay23-20020a056638411700b0048731daeaf1mr628996jab.1.1714415823840; Mon, 29 Apr
 2024 11:37:03 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:37:03 -0700
In-Reply-To: <0000000000007e812306170008d1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002d7a7f0617408af1@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
From: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
To: hdanton@sina.com, iam@sung-woo.kim, johan.hedberg@gmail.com, 
	linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org, 
	luiz.dentz@gmail.com, luiz.von.dentz@intel.com, marcel@holtmann.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 37dd04e4d59487c928bf3561e4bd3a045762eabc
Author: Sungwoo Kim <iam@sung-woo.kim>
Date:   Thu Apr 25 04:11:28 2024 +0000

    Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14457fd8980000
start commit:   bb7a2467e6be Add linux-next specific files for 20240426
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16457fd8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12457fd8980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=c55f7bc8d4809b2bad59
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1590bcf8980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1349ee9b180000

Reported-by: syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com
Fixes: 37dd04e4d594 ("Bluetooth: HCI: fix slab-use-after-free in cmd_sync_work")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

