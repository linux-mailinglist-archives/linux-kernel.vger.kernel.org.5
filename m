Return-Path: <linux-kernel+bounces-80553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A12F866968
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 05:34:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26898281DB6
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 04:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4B71AAB1;
	Mon, 26 Feb 2024 04:34:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4DD7460
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 04:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708922044; cv=none; b=pqesyRLpQYm1J0DtW4W5NWyxJOhx8/5EdTB0JxUFdjQsjGFzHeU3tKFlaK3lFy8zE3kxg3lC6N4sG4P2bujX9CA2BhduGc2STCORuC+A2BZ/TTWaApm0MGy+kcs/H54ItzPP6vcA/iodzQMXqjA9BpnkqFNWY0vyQ3iqEA4QYCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708922044; c=relaxed/simple;
	bh=SMdJhh5tzDfIDlT+tiH9ltfDPegOiSj7HNMgxNTw4/g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=SetCevcI1ch76Kn9COdBBie7pTb3mc9yKD21TNjhO34mrBZl8TzHs8U3cHjfCrpqV2jgx+iK24z0wCthwEVc4pCuolU6zSPf2qSAWB2krpKDrmfySLyFGX2ILArAXq5p4nE0or/9jrBHj+UcJM1RXHT8mavQewv5FB1+a1A7iVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3650bfcb2bfso24907675ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 20:34:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708922042; x=1709526842;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+5DeW0oMJDXyLARdo8cRuBdKt9VMO7ayTdJQz00jeOY=;
        b=RYe1L6wMURU9ASiI/eFHgXu0U8G7PKML/VKhn9rQeEsl31JMdAXIcJs6Ft3TJTrwF7
         8xnzHjpJ7rLr9Ku+JFzBIzK3CfpS28zS1RfsFavnsFgv1fQWUuoGGH3QX2O0JLKvNlkT
         IKCYWSuqasx0gbZE8ZrV8DYZh7xc8I0AN2sjzzblel2/ZpFDY+sI57yw/iFaDUh6QPxC
         dnCaWPHZ0PNmLyL2DaO1lQGdoF5pc0K9OwK+sIEtEB08ntx5HATNdyBAp9powxREuxUD
         vbhU7aq6r6GmQADvZT4RKiQZF+yqp0eykQl1ts9er2NYbDouYU3dEs/rd4B5Gu3J0BuD
         c/KQ==
X-Gm-Message-State: AOJu0YwpDxeBJnFUBcHziLg51rcHSUd0vyCKyVNvlaNzzHF1JDOSG3ob
	kPqW/psS5NPqFBk7B8U5WetogXwaDPyHyBgNsILszTxEMCb9OiKiZUReEL0wSUy49alkcSpqA47
	q/WRSbu0COI7ZWeX/5I5YofjRW1I7T6/Gv2X1sLmwX/oqIr7dB/qoOr9ATQ==
X-Google-Smtp-Source: AGHT+IE5P3dI51azNOhkbHSRAIWHmdSqN5IX9v/rL7htpTYpS1BsYyDeRo34JC9h4+AYZlYDpDEsSp3gl1U5N94WD0wsRSL8/bX8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d809:0:b0:365:4c07:8162 with SMTP id
 y9-20020a92d809000000b003654c078162mr287975ilm.0.1708922042590; Sun, 25 Feb
 2024 20:34:02 -0800 (PST)
Date: Sun, 25 Feb 2024 20:34:02 -0800
In-Reply-To: <20240226040213.1200539-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004c2ca80612416b4c@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         d206a76d Linux 6.8-rc6
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1555d602180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=18dc188a654638a3
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1255d602180000


