Return-Path: <linux-kernel+bounces-10882-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B57A81DDFF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 04:28:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8633E1C20BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 03:28:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E01A56;
	Mon, 25 Dec 2023 03:28:07 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9695B808
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 03:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7b739032bf6so435960339f.3
        for <linux-kernel@vger.kernel.org>; Sun, 24 Dec 2023 19:28:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703474884; x=1704079684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lNUCb6Pv7VM6kDAt30p9dfgzM4vJ9MiFHwME/0ySagM=;
        b=b4f5w80gX5+gWCRv2Xcl65IlckTgG10n0HC8GqODLt8vHnPZM2WmjpTi3UWwIdhrmm
         +n/B90Z0UWo+JN3dd+9LxdB7PBX95qK8D6nejUCyqk09t52SliQUtdwHGGgApFjt0vdm
         7KkTzLo6ZPk7zTciqNez5TK56iUUu7hz4aF49Fa3Jt4Jpwx/LOfzUbGDi09S2bFj1Gac
         lxZ9wq22l/aELKrhteo24fs5htkcmFnTrcBznIR7iYvFGze32Mv0hiLPbWbx5cezYRSt
         6PpnWPRjms50EgcUSG4ix+R7+NZbPHtJ5oLwFtKpBPC6GK/oyTygw/pqqYixQTClm3qE
         vhTw==
X-Gm-Message-State: AOJu0Yyje+qjJx0aIGBhnpwPH15Vn1UaZnUu1w+hla4H7EYRp258hRfG
	pRXZp5VqT7pwYNDCp8h6RyE18lbj5XI4JcTG/PQ0jXdKCO98Tso=
X-Google-Smtp-Source: AGHT+IGFgOYA+bTXxXnRtcNWSVNnby1Dfjec0vMVD913Lyi9uC5Z5V5aP8A9Z/GSd2YT0ISJsr9ho3kr0kjQejLDBOBNP4K5czl0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6423:b0:7ba:8e6e:25a1 with SMTP id
 gn35-20020a056602642300b007ba8e6e25a1mr197461iob.4.1703474884761; Sun, 24 Dec
 2023 19:28:04 -0800 (PST)
Date: Sun, 24 Dec 2023 19:28:04 -0800
In-Reply-To: <20231225031835.3191503-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000063ddb7060d4d274d@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in __run_timers
From: syzbot <syzbot+a3981d3c93cde53224be@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

kernel/workqueue.c:2744:17: error: implicit declaration of function 'raw_spin_unlock_irqsave'; did you mean 'raw_spin_lock_irqsave'? [-Werror=implicit-function-declaration]


Tested on:

commit:         88035e56 Merge tag 'hid-for-linus-2023121201' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=be2bd0a72b52d4da
dashboard link: https://syzkaller.appspot.com/bug?extid=a3981d3c93cde53224be
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=11c16d9ee80000


