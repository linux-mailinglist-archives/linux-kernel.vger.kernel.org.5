Return-Path: <linux-kernel+bounces-60274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BE3E85027F
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 05:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 153161C237BA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 04:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF2C566B;
	Sat, 10 Feb 2024 04:08:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7325620E4
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 04:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707538085; cv=none; b=VBujo03ji14A9cBJR7FN6KrFA4kKDpx0xIo5Q1ICoPJpsLUdvzFVaZOICubvOCzikEzFdOLSv3Z7c7ZUR1x141Ct3/3NXuTJg+s8d2iSru96viLv0YcnKZ77yqza40hR6W/5CXmNQfaXGqgkGGB/60yKmZhji+dM+Sg4NnjNbZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707538085; c=relaxed/simple;
	bh=ybnP3ZhiWDoYTWu5V/Xspe9zKXj8IbIPsZvC04akN34=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ePagIecTayme9mnqOMWr+mhUj0sx3THffDLD6klW7lu8ez/JJYEhX1iGQHjO0lS0a1Q6jMqfvRglz9iwHjt+56xh+iChp8qaqhO+PedX7YWt+A9rdb9EYB28MRqrpp0OXqMvoHcxJk+LG/5DQXCYp5czjBua+ElYeSrrHWxdOm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363befae30fso13463025ab.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 20:08:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707538083; x=1708142883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLBJ1ysf/erCCObYNp8PsSlQqrZqwP8kcEaBiq+UZyE=;
        b=XtcHrsuoprBbhJpuMavdCBOmB/5kU+o1l96yaX1p/E+Nfv7W/+lbR7TYk31eB2Ha4K
         mZAndY+RZXZWwljhTGgNDEEdY7Fl+yAO63FXbCNbTLJoqNx+3BA/tYjWm/0LEZkhyxh8
         29Zh2uYagqcj2PsdxxDSjYDkO/dhTV63JN0kAJWPnk1AKH0SVHKWzF1bsY1ErxiTfKg+
         rcgyimgwUIuhMA0nwesEUvYuOpFak2ONRSwcgCPn/tBmlrdZ5LP7zGt/isEHy8pJYCwC
         k/XpVcMa8L0nKi7T1sgyltuxfHGT9m2IwhfHyhJOARNywnudHedL3uVHv3KlXBIIMV/b
         u+gg==
X-Forwarded-Encrypted: i=1; AJvYcCVuGkiarxwHV4YBHV5Ic4/MrEbRbSj9VohzDEuMNAxCyHdvuYB+VkEb0EWbNuJXS2icVLbMjqjlj5l5oTV3CJp6m6eORxyAFyo9CcnO
X-Gm-Message-State: AOJu0Yw6GvqcFMM+Mu5SV1QvhypjRPiP+XqeY6bxr/VyQwkkqEnYi8Bq
	MdtAm8oQfmQflsk1u0FnfV+oVNDws77AncCLkBB1G4TWtLvgcdxHt+Z2cT2Mh4zquRWhFViJ5Bt
	3iNbq6o8iWzS/kszDJ0mhe/R8aa8d0Wtc46EDAeT2dpqgM05uTHQlQ/A=
X-Google-Smtp-Source: AGHT+IE8lR2YGgsRe1nB/6OT4L3CsM+WP6btBAKMg8HefhyRQLJovH3cjssFAeboeduVgEvsX9sjYtZIMbKCpACQ2TADmPQ0XUWb
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e2:b0:363:ab40:78c7 with SMTP id
 q2-20020a056e0220e200b00363ab4078c7mr84923ilv.6.1707538083553; Fri, 09 Feb
 2024 20:08:03 -0800 (PST)
Date: Fri, 09 Feb 2024 20:08:03 -0800
In-Reply-To: <20240210022453.773-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e929570610ff30ef@google.com>
Subject: Re: [syzbot] [kernel?] KASAN: slab-use-after-free Read in __unix_gc
From: syzbot <syzbot+5a630f8ca0120ab43f55@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git on commit e7689879d14e: failed to run ["git" "fetch" "--force" "--tags" "ee231638377c5338d84cc90b6c821555f8e3813f" "e7689879d14e"]: exit status 128
fatal: couldn't find remote ref e7689879d14e



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git e7689879d14e
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac1116e4986e7570
dashboard link: https://syzkaller.appspot.com/bug?extid=5a630f8ca0120ab43f55
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16f3d320180000


