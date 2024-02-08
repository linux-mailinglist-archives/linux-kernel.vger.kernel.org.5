Return-Path: <linux-kernel+bounces-58253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 081E184E388
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:57:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324331C26522
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC8BC7B3C7;
	Thu,  8 Feb 2024 14:57:11 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4887995D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 14:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707404231; cv=none; b=vCtFH2opRJan75W4pSj2sjA+369fuK+b1f5n/OSNa97mhBAISkmo6KNwfhsi4RxX5guoKqkMUUDGwqjil0rFTivYcydTVEYr/TGQmW8EMRVeglNI9F8RAs+mdtnXezNwBEmAQHoF7UUICBMvsTsnHuQXPwVsOxrmmhVK7LI0zYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707404231; c=relaxed/simple;
	bh=EcT89sa0CxyQPOU9UiYTX07w8+mCU891y6BBe80654o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AyGXS2XcegOVzB+RjyOIC/3sbnZadkRkoEHoREc4XE/1p8Tgn31r0ffwwu6kjg+ryk2kzj8+lpMTto+hNyYKb1+EAZNtOvE6TQnq10btR4TQnx8VI5XD4H+iEu0csjqHrknpQqQ6qW4lFDxxx+zfoGClaC7cbca5dZroudeEhSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c0257e507cso131240439f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 06:57:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707404229; x=1708009029;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LcJiD/mRara/hhLkrTg732ODmYQ+uP41FmyKJ/8GEkU=;
        b=W0zwd/44F2U3Czt+53k3JZp6WwiSEGmRph3vy18pwc9rW8zUT0rSi2P5jCbMBfQqq/
         RNPJ83Kz9EEyWBoAutlPMQ/CgxyBUNovQLt0nZaSca9PRIKZZ+ci0BAeuSt9toaNKbzf
         qA3nSdXugHpUv9rmr7dqDLesqo5aXUqcwIITRti+SaVuCE4DG8x8Mu1hpistewKeC+ju
         zeFRuD/+Hkjr0fGf0OhubmyuyJxvSIdllFUCCE0lSZyVsFv5RrOV6A4bvGpcitQ2awzG
         gFlw7m25qZDYmUNarmjKuz2oJKj1+734HIbWP6gOb4a6Ee3vhl2ZdWNYF75sKykvINjD
         XngA==
X-Gm-Message-State: AOJu0YzwR0zZJpB5HlgLhPk0qNPR8CJw9oZg4SxHo/Icr1JpDoEbaU46
	4FLcYTzExGTnLOjE6ocAo1pPYY2fcbmh7NQbvC+rKZePGPNDrvG+TQQYWLYeS2UWTQ1W2NxiqYw
	2EjZqiNgLLel7flJazyqCoPyEkd9M6o+ViH/5hObcqL2E6tCgRDzUypI=
X-Google-Smtp-Source: AGHT+IGRyXJH9KkquSL5YHNP2ZJcCXVn/DbIJyhV1FaZoSlUL5Enc9Ksfp/fkqadCiyOutNlQQ+CpnxukUxtJAJgJUaWJqCk16IZ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2d8a:b0:7c0:2e8f:8a3a with SMTP id
 k10-20020a0566022d8a00b007c02e8f8a3amr413393iow.4.1707404229237; Thu, 08 Feb
 2024 06:57:09 -0800 (PST)
Date: Thu, 08 Feb 2024 06:57:09 -0800
In-Reply-To: <0000000000001e48350610dbc5c5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009263050610e00681@google.com>
Subject: Re: [syzbot] [gfs2?] general protection fault in gfs2_rindex_update
From: syzbot <syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com>
To: agruenba@redhat.com, cluster-devel@redhat.com, gfs2@lists.linux.dev, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	rpeterso@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit de3f906f0af0c3f5d862b07df4d020c9322cd9c3
Author: Andreas Gruenbacher <agruenba@redhat.com>
Date:   Thu Jun 2 20:15:02 2022 +0000

    gfs2: Revert 'Fix "truncate in progress" hang'

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f06904180000
start commit:   547ab8fc4cb0 Merge tag 'loongarch-fixes-6.8-2' of git://gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17f06904180000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f06904180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=89a5d896b14c4565
dashboard link: https://syzkaller.appspot.com/bug?extid=74edb1a3ea8f1c65a086
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11395147e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=126ff68fe80000

Reported-by: syzbot+74edb1a3ea8f1c65a086@syzkaller.appspotmail.com
Fixes: de3f906f0af0 ("gfs2: Revert 'Fix "truncate in progress" hang'")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

