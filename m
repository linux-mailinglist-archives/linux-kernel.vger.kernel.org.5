Return-Path: <linux-kernel+bounces-79928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A31668628CB
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:28:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517D41F217A3
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 02:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91BBD7460;
	Sun, 25 Feb 2024 02:28:04 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91B04C96
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 02:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708828084; cv=none; b=lpMfGNy5mDt/mnQzEueYVfNGtwA0v2+GRJLVCjUhidMw9Btx1pEgN0x1+uO06GiIEdAZTz8qZDNwQ9cqVeRZ2MHLPrO1QqefoQzXh6rsxOJYsOrRluRSPZOn2q2w9gxEb43ivhz1pciG01tt7dAzwMZlNoNwDtzTuln+beN800E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708828084; c=relaxed/simple;
	bh=3aKaHbYMteihl+U5QPccjJuoz28iAXGcuSjcPWIAdYM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nj+Bh764GbmDobW4sWLVIyuKyGT52qPNmasywGqWqbY47m2M/99GyPkRJ4JjoCHjtv+sJHhonRrwYO6+msDGV+/Zrl/7xSmIAgnkrRj2jnNmkYuqpIIdAZF3r4dq0AzgXXMNWioU6daEPi5ISUWeUz75f2fX8Ljzq3IF2QatPYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3657dff68d6so21609295ab.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 18:28:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708828082; x=1709432882;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=69jxe5/lbItSx/8NI9A2BEbecQ+1y4zcJUS034QABIU=;
        b=pGX1O2jZ2JEDi+fdnveukA5mKJtyWogVZzvkn6neZAWAga0GJLv+ZyUcsi9YLdYBDh
         AhMPc6nLFlCHHvQkLQz+I495Hjc/hGOkzZBtLjTg4yrXygglozvoaNh+2Z33C3bGFyLA
         BWjwcOFzd92Ae13xZNWwYx8LEaukTM61Al3HUd2vD+Hi8rEIZBZQDSSjTrP/W4kA8VAK
         tbQofM0Fnro+AeQHdciCfRaUXzUXP9gk/EMRxTlaVtKWiHS0G2vHon8cSXFCeSLtiLwZ
         iQ4JlIktuB3a4s+KDyLTDV2Of4SAfWjWjRgJn6QlmWq0JBnTc7AKtv92dOeuIg2Sk2ND
         eQAg==
X-Forwarded-Encrypted: i=1; AJvYcCVgZCtO1f+5F/nw9PpzFn4fjOI043IPj5dE8Rt7AYc/BSmzo3zmqNMMI4vX7aiSCAD0v5l79CwORC8gCIpRBMm4tdbMumNTzm0rR44n
X-Gm-Message-State: AOJu0Yw4BOt3xSLdbl9twumthf80nmq6OkZqpZ6ajvSAdMRK92K812Xa
	GtwcCXGO1flZXPftrNlTDZ35Atqi9bxIXas3IlLpTXQt98R4KbGqSe2Kt3J8kzciLlsbxRvJjrv
	Hrk0WAdx3mG8eWomWXwSn7FiaPDqwjJ+yM84fJk+POr2LrcAYOclJoZM=
X-Google-Smtp-Source: AGHT+IEG8FPgH/7NK/GAXHzyqfV7repgm9p6T8Oh150j3NsDupdAxMqK6KEkh/wv/1TTMVWJk7WkKE5lfntNKFj4Rm9OXT9ei4b9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:365:df1:840d with SMTP id
 t13-20020a056e02160d00b003650df1840dmr239448ilu.4.1708828081920; Sat, 24 Feb
 2024 18:28:01 -0800 (PST)
Date: Sat, 24 Feb 2024 18:28:01 -0800
In-Reply-To: <00000000000071ce7305ee97ad81@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ce24de06122b8a39@google.com>
Subject: Re: [syzbot] [fs?] BUG: sleeping function called from invalid context
 in __bread_gfp
From: syzbot <syzbot+5869fb71f59eac925756@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hch@infradead.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=164a0a54180000
start commit:   a92b7d26c743 Merge tag 'drm-fixes-2023-06-23' of git://ano..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=2cbd298d0aff1140
dashboard link: https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17fa78c7280000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e73723280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

