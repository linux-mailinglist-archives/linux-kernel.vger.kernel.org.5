Return-Path: <linux-kernel+bounces-132094-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8871898F89
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:23:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C1E1F22E90
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 563C11350E3;
	Thu,  4 Apr 2024 20:23:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832D4133413
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 20:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262184; cv=none; b=eyfhXrJ9Jn0v5fkzMuMotzZgsrCs0tSJiOIR+yX/ShEqhJO12QxDGGHukqWYthi1ptUuNoW/g3e/r3p0cFDVm4eE1jdvoVpNSKi62bTMwQ7oSANlS0JUh2L/SWe847WE3UZHz68XkePBAijfTFE4eGESLheTHXNxKVLkzcVFU/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262184; c=relaxed/simple;
	bh=uujuhgPWn7BfnWs/am+7oZPl7F9F8g4JM9r+8Im0bTc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=E97mIXR5HmSCL4NO7RGqrqaYFCP1qa78SMDqrS80TE+NzNbIav32tm+L6kR+wDJUlg4SEoM5vOBLRxOPwFYb2/morCJeQmVC6RFN83R7LI8nVvg/dUMpGflQ6Wo62x6IRHWYUdHs1jd+i5tOCLheKut/uvlqYD7gX6ATjUllQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cf265cb019so128996939f.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 13:23:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712262182; x=1712866982;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GoWK+t+SunCdw0Oet4smtH/dqc5s6JQfB+mg1AZhCBA=;
        b=g1AliLbuptssyBllM2A8p5SCnm5PBX6kFu1RtbQ2ga/qUtmSOpQTu8rRTZFwrkJbe3
         uJLUn716EgRammKT3yTzVxfJJF8KsnMjDwb8z3UwqUn9oRUVASEsOTM0sf4IoEbXq/9K
         qsyaj+iytSfAvDJF4VOvRhqPerhGW64AcUTMSPs/vU+txo2c84HhA0Fuews9Qr4s1zdu
         oBry3LGVcbdJ8jPXCTnqPIX0u6wqnQgZSoEMrj5M/Hom4Xa1rEBzU7XZ7vwMptJQyx2J
         OLp5x/1mrKahRXBsPX3aks7wB+MaarQM3+TUSZ53TL1vaqE/XfcG5nEsGT6M5Ec8yw6R
         ko6Q==
X-Forwarded-Encrypted: i=1; AJvYcCUwnw+ZqmhxpAFI0Mkh4W2pdWC2LtSxb7KGzYhr8FHFwzqP1ZoFFPcw1emijSE/L/7Jqz63M9fQKLOsPbcgkjn+9OHE2bTYAmbG6Hpi
X-Gm-Message-State: AOJu0YyTNnnMJRJ+jJrJtIpVWuNgJ249VUzx1b6sd6Lkg408EViwQdHx
	Z9lWI77V3A956l/KyJvBUo0jJpxTcdAt6f8XXCHSFZK7xglSXcsu3a9t4YNN/awSTJWmCrwP6WK
	gPQ71cDV2zvAKp730mM9talN6nRWeHqZNE4lvK5j2oIImR022Yt8YHhE=
X-Google-Smtp-Source: AGHT+IGAEUdiatjQ+zRYdaSz5SxDWX2sI8xcyn98p0jBYscg+6ZotGp3A9/YsZiVw6LSbR6LpXRUOKySYTK8MifHMDaPzWvhVvOx
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:489:b0:7d0:ad03:af0b with SMTP id
 y9-20020a056602048900b007d0ad03af0bmr29095iov.2.1712262182796; Thu, 04 Apr
 2024 13:23:02 -0700 (PDT)
Date: Thu, 04 Apr 2024 13:23:02 -0700
In-Reply-To: <20240404105853.4079-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002b103f06154b1beb@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (2)
From: syzbot <syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e29c204bd2e3906fe69c@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15616223180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=e29c204bd2e3906fe69c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1110ad29180000

Note: testing is done by a robot and is best-effort only.

