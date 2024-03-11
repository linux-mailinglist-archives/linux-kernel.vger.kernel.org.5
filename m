Return-Path: <linux-kernel+bounces-98424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8F38779E7
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 03:43:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 815C61C203B3
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 02:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BDC1841;
	Mon, 11 Mar 2024 02:43:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB77E7E8
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 02:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710124984; cv=none; b=TnAyPBRxW/T9GMQ1yeVhUn8emSts6+budeMay6JMnijRkC90AhAKdQyhZ14ZkMOLg/yx/wqpNYO2NxdPJwIrR3kJHwaQHZ6n73QJn4OhWCx0ezndVFCdU6/+43xa7abeHY+h7kDDUxE3WvASZOVnty7/b+6xzoMK/m8VoLM1iFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710124984; c=relaxed/simple;
	bh=xCUFlySz/HJzwmMAGBTFTxjuuWHHUASmrs7xC9rWZPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=VIjX/hdhDVCpDb7EZrIuwuFxiyMS3uORBHEScqYm0d4MBXUqcetz9FFOcE9pzegni7N1LaBi28trRVSxhMzde34p7qgePwy0mM+4xuknXsmg6/UJtivKO19nF1b+PHdZcSmJjPrhzSQl3eafcOyXg35H6wRa+YQL5T7aC7CdzkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a8d93507so112446939f.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 19:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710124982; x=1710729782;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lYcxoW7cD8kZbmcK9CYx64+UUR754gw2mSrSbnYLk3U=;
        b=GWWpLGgjUtqAR/fypas+6uRg1tvzON1LrruD/h8oXZOvBJra48x3fYMFBxTMYK0hLU
         LLUZq124Pi9FT+2jz5c7hK5siySDJtawcGWB6MZhYCj1iYaTkoFLG4DYyFMoJFf7/aE9
         LJoQwuaRB/EIv8J/zEqTdcTMBB0lDhdQ8QsVxA4yx+ly5brbqvyOgNT0uICpkgipLqRV
         kTBVxutHBk0MxAEhSEkozUkDaOe3Hl1fkua3otlGEGQyMenYezuI68xEBuMG+HRJW1jt
         R8D7tXwOlYqE1AZvpkJ7QfPln0eGXAKmg+osHP/0v+9R9FVlvTzjteMj/ZSsfMw4pb34
         WV4w==
X-Forwarded-Encrypted: i=1; AJvYcCUus1RdvV1oRLAnqp42UC5Ix6viyrGpqFhlJFJyV/zhkcf8zZAplQcLQep5P7PRRCsG0yhYNGhwjrbgmUn4K+QcwJ8uHgAazJHrkUMj
X-Gm-Message-State: AOJu0YyvLBGXipx9ovpKlVuo7zBTQvxaaHyhrlqSeIRhdJPZhcBwIk2w
	EolDT43WyA1CE26Qydi3HZozl0tpAj8W+GBiqGnR+GxnBhLsa3Nxejy7Pj8pcfVPhuMgFVJVQAR
	DZ+Xmyc5ncpROedc8p5Ihyst1mwT4GRBKPZMKF3LcHqM32BCuzbNmuso=
X-Google-Smtp-Source: AGHT+IFusFZ3cMvP6daHHhxIg1ZsGPjKlL68E2l1ow40+7e2ifpNBPt1WflepZ0E4AeJRGxuTr3IKFO2SzeuMxFXKz+Qf3Kkd3kN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2187:b0:476:d30d:8d10 with SMTP id
 s7-20020a056638218700b00476d30d8d10mr369190jaj.6.1710124981946; Sun, 10 Mar
 2024 19:43:01 -0700 (PDT)
Date: Sun, 10 Mar 2024 19:43:01 -0700
In-Reply-To: <0000000000001bd66b05fcec6d92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000121d4f0613598092@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in vfs_setxattr (2)
From: syzbot <syzbot+c98692bac73aedb459c3@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=124c2811180000
start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=f8e72bae38c079e4
dashboard link: https://syzkaller.appspot.com/bug?extid=c98692bac73aedb459c3
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=167dba7ee80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=160cfe19e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

