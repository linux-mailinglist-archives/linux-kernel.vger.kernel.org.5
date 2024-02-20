Return-Path: <linux-kernel+bounces-72353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26EB185B259
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 06:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D7EBA281FBF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 05:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6FB457320;
	Tue, 20 Feb 2024 05:39:04 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C0856B88
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 05:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708407544; cv=none; b=VwCyt/jGa4LVlZR70rpqIPGj4qHseRJNq1Lr85YLKPoOlGXWuailf9A4e1AbC4EBil03sual6/oo5QQjh486/rrJ5xm5AMgIeAGBldqpV9snySLY5pnVHWKM0YwNg/VNQGaAXvsOJZUxQYgbcdk6p4EW+HjY8b8SUdgi2KdrCIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708407544; c=relaxed/simple;
	bh=3D6cn9XjzHjFbMm3ls5qO6AWGUO8EiGBOnsyhAWwwdw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p/tVctbUxGLGvVQACWE740zR8RM6v9M/nP1Jeuh5QJ116sAHmYSjF/NR6idBPuAu24GToYPKD0iijLbl1wzNwdb8F7yUwaFYnVNoj08hiqJ9z0uxFj6JRcvR3CPf1wTaPVB1q/Gu1uR/PdrU21pN4+T9YH7OJAScynBkP0rKgAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c495649efdso501055939f.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 21:39:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708407542; x=1709012342;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzEimjTxUiPK8QlGUDIMCLBh+dSodnszw3pR8qbBUsU=;
        b=ROxRkoQxky0lURcWH2glVAaoshpXHhOlM4xnA5jELdd0ivuG1EFO3+/ush17vg/LcV
         8N6Tbu4g73qFYZ1owt2AQIfIAK1Q3UqdjMIpoFPTQF0pK/b0NnyvNbrUo/iMZHa+fHOK
         6FyzbO87dCeD5Z3RLpF+KV5kTKP3BZCrbQ5Wq9iKNMyDTJ1K/5ZWtPpEdgZDpZiNYZ2i
         noEPH/th563L8cxAb+X9yY4fOcLTlhMmiOU2TcozRTfDLRWYXTuGa5spyu7y+mY2HKNH
         lmNjwqt1yOciz93qUD4oY2W7uzSfdtjPl18h5Gb1M0Xf2yW+nGZzabH+TK332lz7To8C
         IIcw==
X-Forwarded-Encrypted: i=1; AJvYcCV++Ikx8AhP6MumeB9y+P9T0S3fH502lxbGHEyz3UrctATr32h1fO3s4w4xDhMn59ckL+tOpYkt7JoWp1TzfI6W54R1tlNTDBEl3O6r
X-Gm-Message-State: AOJu0YzRju2BJ7wyLB7hI7xihwFcSCzRJYX61GNGLYYbNsrTYDqGrmrQ
	fW91PNsxeF0pfxum+oNmn7kHbjVxHGHWiLTRO6tZ2TpnOUox7fhKpPuT/ZSRhCRc6xl5tYj2wEr
	mQmsY6C7fwqeqSmP739hHZxoxmkw/h/os202ICMjRCZGYbcwg/gsisAg=
X-Google-Smtp-Source: AGHT+IEOpIm03ZiZ2lJ/lHSHFI+Mm8U5WA8Q/IrAgn3qmmy4iCtGItZ/O8nuHuz2UprhExvnzs9gW9Vv5lJb7mKBrqgvWKGHB8LF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4905:b0:473:edc2:9589 with SMTP id
 cx5-20020a056638490500b00473edc29589mr271909jab.3.1708407542209; Mon, 19 Feb
 2024 21:39:02 -0800 (PST)
Date: Mon, 19 Feb 2024 21:39:02 -0800
In-Reply-To: <000000000000ae0abc0600e0d534@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000af682a0611c9a06f@google.com>
Subject: Re: [syzbot] [apparmor?] [ext4?] general protection fault in common_perm_cond
From: syzbot <syzbot+7d5fa8eb99155f439221@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, apparmor-owner@lists.ubuntu.com, 
	apparmor@lists.ubuntu.com, axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	jmorris@namei.org, john.johansen@canonical.com, john@apparmor.net, 
	linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	paul@paul-moore.com, serge@hallyn.com, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1644f22c180000
start commit:   b6e6cc1f78c7 Merge tag 'x86_urgent_for_6.5_rc2' of git://g..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=6769a69bd0e144b4
dashboard link: https://syzkaller.appspot.com/bug?extid=7d5fa8eb99155f439221
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=137b16dca80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14153b7ca80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

