Return-Path: <linux-kernel+bounces-68058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EA92685756F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 05:59:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AA6FB22969
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 04:59:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AFC12E74;
	Fri, 16 Feb 2024 04:59:05 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29209125CC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 04:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708059545; cv=none; b=cZbMRuJGPIMKyih2P4BjB0WAiPrf0caHMwAScvA93COmkbJy7+HWcGki33jD8LU/Ue8/+pyf23Q3r4SGi79LvVbO/6YZZ4lJza5cpF3vydbW7Y1GImO24UZkYjR68UpdBMj0sZDxqQeRPG7b6odQD3kNdcYnZT9+6AuLeC9f+zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708059545; c=relaxed/simple;
	bh=+AGLJ+h6ksQ1LMrUfaPJw1kfoY13+VERfmtwUV0/xm8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Ax76+92K44iu+M/+pobI8GqHCd8+yVPDmrPW4DGfYF/4wSC+eSq+rQNpaCGrIE43yN/JNQNdGz7aHw/MUIoWzv570mCtoYOyNDKiFrJyN1F6SqeNZkY+Grmlpzzwwtp/1lNQisyilL0wnt8NJLRPbySmVZPIBd/Mis1bNXDLH4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3650bfcb2bfso1667165ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 20:59:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708059543; x=1708664343;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JculTRychqwIzbiVTR2hbbWMlo9K2vSRcy7NOSpjdFc=;
        b=LigTgWGoZKWx6+k4OPtvYIMXBGqO/IDqWbQan72sYImo02OULL+ugmxG3NaXtKUp3v
         0lbRt5EHV64DkUpA5KiIhvlSo9eksXQdZBbxs0ncHgup/ek3CuYoXmLVL1Ldn4CdMiPT
         b4IUMn+HXQVLpcHGIsR/Kw5KhzIwJzPSZrqnDRLDm84OnVWsPVBfA9qXlZ8ygQzEsQNX
         5BqJhbB9Tm3dZ9o5MGkF8e9r3viCPcwCHEPMr4Yt98tHbdEAKttUNd3DxJLTSuaxoCtd
         SoDDZT2ttlfJd05fH56Qi1WNY0Y+Uh1l0nTx6wXqoJB5ptrolPB+GlRO6V5at0DCPIyb
         XRmw==
X-Forwarded-Encrypted: i=1; AJvYcCX+HFG/0c69JvvxJIDeQv83sbT6C1MlqWXTC3tIE+XErprIqD/td/+yqGHJa2QLrObKdZMTdu2m0DaADV38GOBJzB+nj6OBSTVkJfE5
X-Gm-Message-State: AOJu0YyCChEkLpPEh4t8JDKTm6LO6CGupppaZgFmYR2kUHtuYDbq+P4v
	LsaFS+vRvKOpGarDabI59cW6QscolTnpaqhY2MRYJRb7mxVzdomXOPP87vhhqRMrxXSB665/peb
	OzY3ijm4CBLHxeVgDf6BAJKB+1NwgCYYvGpPSw70UL8tqiU6B8UqAOCI=
X-Google-Smtp-Source: AGHT+IG8V/bytoc11b1/xnBwTe9cwikfexDe7rGUBOXKjOIuOWeIt138WrdbT0Z2LLvL3fWDIHkULxgTTGnYyB59KvUPbLFgzdS4
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c568:0:b0:363:8b04:6df7 with SMTP id
 b8-20020a92c568000000b003638b046df7mr297584ilj.0.1708059543346; Thu, 15 Feb
 2024 20:59:03 -0800 (PST)
Date: Thu, 15 Feb 2024 20:59:03 -0800
In-Reply-To: <00000000000096592405e5dcaa9f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005626e80611789a1b@google.com>
Subject: Re: [syzbot] [exfat?] [ntfs3?] INFO: task hung in __generic_file_fsync
 (3)
From: syzbot <syzbot+ed920a72fd23eb735158@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, axboe@kernel.dk, 
	brauner@kernel.org, david@fromorbit.com, fgheet255t@gmail.com, 
	hdanton@sina.com, jack@suse.cz, linkinjeon@kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	ntfs3@lists.linux.dev, sj1557.seo@samsung.com, 
	syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=131679fc180000
start commit:   200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=ed920a72fd23eb735158
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15dd033e080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16dbfa46080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

