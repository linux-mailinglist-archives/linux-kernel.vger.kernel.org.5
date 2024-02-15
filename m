Return-Path: <linux-kernel+bounces-67410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFB4856B04
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 18:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 704BF1F266F5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04CF91369A8;
	Thu, 15 Feb 2024 17:30:05 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F7136998
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 17:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708018204; cv=none; b=h9zxHX+vJzcyZSOsiEi2BjFoo8Q8HSyT5pZ4rKCFNuBUuVj5lJXrU+Q/N64AvlucjvK60jSqOKO7kKjVHMICqW9nG2pbA3dyU3BwBjfZYyk7tX33qUXljw31asyjOKnntlwtK3oDsyWZmmAN8HFeX/4PQtIOi2l1myUyvGWt4QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708018204; c=relaxed/simple;
	bh=VthmcxhVEuqz9eJ5clxXTesoB8WduMoco1RaCTXD9Qk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=ILYUnX95BZtE+gYLrFRzuO0db0DVDaRzSppQ7qXWczy00hU5Zx8Y2jHg1w0iyru8OxLiUk8Rw2mtnCrHocJXfCNu4grOLvjAHKe6qxL5Wk8iPv6iSLoXekPZtJpP1TstJFIYvSVHJpOdmb1onVKscbzmxHVkzRdSrU3sKxjSCM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bc2b7bef65so95066739f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:30:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708018202; x=1708623002;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Mas1+oMkdzW0fSqjxmSiwbESID1pMxANi5qAJUaYfqg=;
        b=ubyiJTH8xAxwDP16oVHRzryDmwur2fZ4selzJkTWCJo8u7dDKYriE22iuEgNIKX71t
         JKZ7fFIYBdxzRIHqZxN4IZecVWQ4u5JJchl8637RsNiM6HGDoPu3OPdZEHZc8tpEDqBx
         D1UFFHcomt4y/826hmcbXeym7ZQhqHn6lZOXOsY2x0L7bIpapRQFWB8Y0uLAJUAomupa
         LiULVaq8yknBNwfmE+1Csr9NsUsAViieg0CO1D9Ac5RAcHerRe51QD2EtqbJTZUDW51J
         MnL0aQng1630obx2vOz+0R7DRnJ8fMiNb8eWv/sd/5Q+b+2pE5i3h9PtYSnbpdCE7t2P
         V2CA==
X-Forwarded-Encrypted: i=1; AJvYcCW/5kPLNJTn3Ms+OI1p9eLOOEikCXxS9WyP30PjIdWhmxk1Mum93gznt4F4vq+EUWpDunfcGA8ovXxGgKRY9ZVAmk6j8cSaj1VSJUdx
X-Gm-Message-State: AOJu0YyEVWCC5ClJNKdddjhLc2DjoAicmZT6lEEFvoIIWdJk6zLsSI4X
	dCOMX2F8fvzpaqz8FVYovewMUMg7ROhdtzjyqbarob6QI96OtGlvgwIuxABKrg2G70dbMPsPJJC
	hqB6GCR3ufxqARUd4Wk0JtefC5rWykhgmLlfbB5pRSmSqVYqdcKjFA5A=
X-Google-Smtp-Source: AGHT+IE7NYplBG53Q/FVg4oPpnY6PC138cqIKFc7dpg4p9ejsuwS+Ss4O9qFDe+Y8yNN7yBtZmj1I0gXd2bDryxkvj/RPXstuNOI
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4907:b0:473:f904:f04 with SMTP id
 cx7-20020a056638490700b00473f9040f04mr17206jab.3.1708018202302; Thu, 15 Feb
 2024 09:30:02 -0800 (PST)
Date: Thu, 15 Feb 2024 09:30:02 -0800
In-Reply-To: <0000000000000fdc630601cd9825@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000037dfd406116efacd@google.com>
Subject: Re: [syzbot] [udf?] UBSAN: array-index-out-of-bounds in udf_process_sequence
From: syzbot <syzbot+abb7222a58e4ebc930ad@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	osmtendev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17ef13dc180000
start commit:   9e6c269de404 Merge tag 'i2c-for-6.5-rc7' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c37cc0e4fcc5f8d
dashboard link: https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175ed6bba80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146c8923a80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

