Return-Path: <linux-kernel+bounces-46311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B917843DCB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B2021F26F87
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4CF5745E7;
	Wed, 31 Jan 2024 11:07:06 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4A7E69DE1
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 11:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706699226; cv=none; b=GH2wVlc3MmN9VsUJ7wu3CrtB3SDcRGDGl+E1ccw3L6+vhsakwS0+dcCL3DdhknX4nOO7X6/rNY/eCoPVCM5KDueDRhrOzp+0/mQKMRY+c3WRsgEREuWy9Vdqi4qe07W3muP8LyYl3dlg934ayO3MEUSaz/SXhn884NDGwIgk3MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706699226; c=relaxed/simple;
	bh=MWVEeMI+AR17w5LxB7gkS4p9qHfzsQG3ENYxj2aOXPg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YYlQmipu6+lWTnXHssGFTFsMdzWbg3ffS1/xIIm7m1EixweRmut8ingQZ3Q0YqVk3FjIUJONfX/VubqxodFAq1dhgRAqpjT9djN6ZF6XG0Lv8XhVp6qmovx7rj7ESGqmE6B91MWHJ/J15aT4w7jARYKllvmRc9A3y7JmpHJM5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-35fc6976630so33508855ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 03:07:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706699224; x=1707304024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BiqnltLZtUrfkf/hwn5e2UoVwvR5WnSmBI8kS+16w3I=;
        b=Tiz0q1ziJxoo58n9dfU++VVL/928jsmXW5LJPKFrsMG8jNZRSjbP9r2IUyohaPc1h7
         HWPGtKWfHdnG28vuTLIPAGuGfWQ7XIP74xu2GR0XUSnCRHqbN6YrNl7BCyuxT1bPfhaO
         d/MCRVyC0KyDHpG89W0nhHClhcXACfT7PPNCLFzCUGPdMj/px9s2qILdJkT9F6JfyswK
         vqA0oFMzFhsWvUBFDoPyLqmf1z1kPS33+AMCJsHi4yn+J3CS33iS+mmBJaD/Jb0Wxi/X
         Df1i2jK9UXRlsxynQCZ+/AbqOtCHO+4Ui94BS4oHdjXYpSt9sK70GCx+Qlg9wg4mahoh
         6vBQ==
X-Gm-Message-State: AOJu0YzQUPSpTTOV5mPT+kVeVHGDyyHmqHN1ESDkq/u87TE8ll189GuA
	MgubfpArjbCRVotH6fBOPCm8F8yUdkxSUSUDy89KSnOanpRWsc7sq+hKrvVoVaRJaUWnfPHtLdP
	YIdEHdTvHPcUA0hJPYR/OO8/7V5V+XYI7Mc/UrHXEl+xVjQjv3bbpE/c=
X-Google-Smtp-Source: AGHT+IHcgBnPutZg/4GvTtnKB1CThxnrrFAj2JHnHuoL2yBlzIiOOQN8mpdvd1nb3uaFjljUmpQGve3BB5xgwYRoUcZYkBw0gUD8
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:216b:b0:35f:eb20:3599 with SMTP id
 s11-20020a056e02216b00b0035feb203599mr126539ilv.2.1706699224059; Wed, 31 Jan
 2024 03:07:04 -0800 (PST)
Date: Wed, 31 Jan 2024 03:07:04 -0800
In-Reply-To: <tencent_F29790365A4AF8744577D967B83C95361E09@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fd1d0106103be071@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com

Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=13b02540180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=107c63dfe80000

Note: testing is done by a robot and is best-effort only.

