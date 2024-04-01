Return-Path: <linux-kernel+bounces-126541-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0D31893945
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 11:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DDDB1C21220
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 09:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AAE910799;
	Mon,  1 Apr 2024 09:11:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8C0101C5
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 09:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711962666; cv=none; b=TzEvWQpOKSTbEYm1pNjQX+yqpyEMZc2bG5xsXWxo0hvY8wFE8h7H3Mj+uamtnkkcW5Rz/6U/oQUOHq77AdlZPoBuGOADjW0dAH7Bumafbq0CHcISP0+Gv+53QrJUQoyy5betoDalWBLdWMu5HWMNavmh4vh9LA3mb0IADvEtiLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711962666; c=relaxed/simple;
	bh=eHLlxe+/fcV5EMW0303FsID7n5kUGWU03vzhAaAEHwA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=adcfpgdWf1Y97SJQb/9Od3uHSff6//WyBWmf071TM1+m9zqc/3ITrPBASfVh1/y3oDat/FsoW16TKBI6XuPvjVk52fYMyxK06+iFpIwkpiiG7NUXpKTrtD+7wMIIYYpPLo/qHwrrgA+YwTbuwc8LWavnHUAEzH2gw0wpsdS0+n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc01445f6bso447897639f.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 02:11:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711962664; x=1712567464;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpZAn0hzMcQfUJjNIJF6wXilxAIPYYEZoWnhIREoQjs=;
        b=GuHnpVfgKhLH+ZG9za/NGIf98DTA+sVomhduckLWuAAvEQdcxtMlNtqkCY+EV9i4Bl
         n7vzlRlIQXFhBaNF8v3DM+JZgV3Jqz6Dre+m1ZqgPqhN+RmDKTAVGGFVi/JFxBOmPNJd
         DdgYPiXCnX8d9rQ0qbuKyu6hgIakBNEQjaC3KjWulDcOtaybCGv3UmY32l/G/Ib2TSfL
         lHbh+WHiup5p/kU0xmX59YYuGFmCcJ7pHFd+x6ohyHyOdJ8NDma9d6g5JBm0UK+ruqPJ
         u/bXiiQwgNjF/0CcGMIrZT3371sjPCP2HvjixUMhuSypgv0W2i0qJWqfSQQ5+PvZcYme
         lqMQ==
X-Gm-Message-State: AOJu0YxvbM4b32k5d+TlC6jDNgylZBSpVv8PCb9Qvw0gxnYv6zIaqcFk
	SbU0PUnFnXHwijHpfwHEaVwdUBMS6qxdhgi0pc39M6+xyvum0cx7tI+KR+In0ijJbgOQfiuSxPM
	26yJGVpBiepdCXX22dE2HVndKEVKb2SUYqaFYpxKSluqshBmY0FOrHdp1LQ==
X-Google-Smtp-Source: AGHT+IHs/cT0UBD29UGN2Io20/aLNPWRr4I2h7qJtFTuTg+L5CCVMAZKTPspkYmpldrns1bPBEz8gvRcTB99p1UUq7rRCmMMwr7e
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c11:b0:7cf:16d5:181c with SMTP id
 w17-20020a0566022c1100b007cf16d5181cmr510880iov.4.1711962664712; Mon, 01 Apr
 2024 02:11:04 -0700 (PDT)
Date: Mon, 01 Apr 2024 02:11:04 -0700
In-Reply-To: <20240401083613.441892-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007fcbf90615055ea6@google.com>
Subject: Re: [syzbot] [kernel?] inconsistent lock state in sock_hash_delete_elem
From: syzbot <syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1dab15008502531a13d2@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=11bcf70d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=1dab15008502531a13d2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=129b452d180000

Note: testing is done by a robot and is best-effort only.

