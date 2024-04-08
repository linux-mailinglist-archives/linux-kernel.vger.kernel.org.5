Return-Path: <linux-kernel+bounces-135954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3741089CDD4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6FDA284905
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 322F0148836;
	Mon,  8 Apr 2024 21:51:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C727E8
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712613066; cv=none; b=R9HvOHfPPE/Bgu1JMhUkrfWv+XfETgmoEasqlI5hZ3Si4qeX9LKimzX6ja6xDG+d3c30xtPM/JO/vu96YoNxo4+ays+YioLgyih6U3RDUsOZlK6Bb2hqeJ3mLUUtI/wCMQvDlCFeH4o68cBgyfcC9mriLs5LL6KRcU0KPUqA27s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712613066; c=relaxed/simple;
	bh=2x+6KvoH32K8EzxgSJkqDxaoAVQEpeU2PsTNogoNZ44=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qBykmzosTu87TL9amIY3tHuCgufEUH5q1T+i/HdzlWEyjlDG4l/M0F8uCBG/SBkjTOFSByfpYlxYV9fsVaJP/+a6zT2Y/GnvmftckF9t/f1YtQRsTlaDDlL6LJdT/SYBQXM/oXOCRgFcABz8L3v3t11mH4PlQsypipokgtfUZ20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d5efba3f8fso129129839f.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:51:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712613064; x=1713217864;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O1XSBFQxppuDIBA6DKA8wazKAqSDRqcEM0rBXWCorMY=;
        b=JpxFQcfA8cjTPd722zptcKUpeXrB8e1DBuFBI7StaWI7Chv3ANkogV2Waychr+Qes7
         R2U2GIijHgPqk3EZTkUAMHz7wn492WPw4wC6KGS5xAswjQtP1drfDYIKduwH2JWGu1Uz
         Gf5eOxFqh4FnvFp/RyHNq/nl0GFN3ODF5zdCYd6rOeAKfsdSzEsB2yWbgzwUzRcuBzWp
         RiycnGvug41uqq15MIfJ/588hHyXeHAKGe3my5mMUGBRMZD7ufYxHMAkSQoK4n4RPk4X
         g5dABZFeD2pw+UP4PAhu8K+DuBYUhijcQSwrrVgzgs1DMt0El3XklV1X3OUxkp4h6/Et
         j+yg==
X-Gm-Message-State: AOJu0YxwtItW2qA61kT4IgusX8IR24678zHd2FbooanYXCC6acw3UEg6
	Z6XF5LgYRn9EzaT8+BFacuTiANrIdWXf9EjGiWWc+ZOFuZWKaezVbuK4CXcteeQ2yHll3id6bMs
	V3elXQrkfQ8vohphfYltoWuAPJwkteHnTb+cU5ZN5VcXks2kwF7ng2iXS6Q==
X-Google-Smtp-Source: AGHT+IF6+jYiKS9aNPe7q0ivPhn2muXxdFR85m/Vxot8+1Ypei3KIE5QPbnE3t6gxHC6pKx3wAlwVE77knw73GV7LsHTGDYz+BdI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20c9:b0:368:c21e:3898 with SMTP id
 9-20020a056e0220c900b00368c21e3898mr771465ilq.3.1712613064603; Mon, 08 Apr
 2024 14:51:04 -0700 (PDT)
Date: Mon, 08 Apr 2024 14:51:04 -0700
In-Reply-To: <20240408111049.28844-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005a8d0606159ccdd1@google.com>
Subject: Re: [syzbot] [usb?] [media?] WARNING in smsusb_start_streaming/usb_submit_urb
From: syzbot <syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+12002a39b8c60510f8fb@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15e8df4b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcd96d223f515533
dashboard link: https://syzkaller.appspot.com/bug?extid=12002a39b8c60510f8fb
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=147f1bd3180000

Note: testing is done by a robot and is best-effort only.

