Return-Path: <linux-kernel+bounces-66303-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25335855A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:14:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57F3C1C22565
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 05:14:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA00CB675;
	Thu, 15 Feb 2024 05:14:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EC279DD
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707974047; cv=none; b=drfqftkcDpDOZdndXLJ8BvycSAWp42lQSFrqe0mActvbZ36GfreaFIEDWAoQoUMBUq4+yPHZ9U6QYoTfIyusYLM7Qu7iKPoRW0dMoobE4OnkAieSRAALmzdOO2sKmTL/xmjGBc2UdI0E4BkoOQ5Pax4GATWJ//nx3pIKgZAx92M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707974047; c=relaxed/simple;
	bh=u2zTvaigkuJAkh2Bm7RwzFPDKiy8E7ZaQMlfwujq1to=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OGIbVeUNCuLG5AIEK8gRCA6V5J7CuR20tprZppXQ2lTa+sTflvLDOEcrgkK5Vg3qvk+Q8qt1ul2n3ki9n859FFSH1ajtxqkotbsaLN5AU5c3mehxC2tvr0DcPxBbQgXG4ch+weWF2D/ycmBHPlBTnTuKwqA7l6mkImxY9+w3gIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-364278061caso4824275ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 21:14:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707974045; x=1708578845;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=833iic8uS6oQb0u2s6ULb+vs6qVpUUqEMT9wxJUBre0=;
        b=rdoB9W+JUmeg5jzVpOrQXFfgJ4JqERlpAPhv4ccDqxznk8BVy49X8f7kC0cuwDeOMW
         BokjU0ZzUzTGajg+zmfW7Erf23B3nDE8hXM5oFQz8AV9kcIqBxSjCKFQqNrBk7xESVG8
         Od/dG2Mgm/CxAMecO4+4zjzOgVqAsC+VDjCb0yZLwpFF5ZyQmZVRM1UiWBRAoqOVWnFI
         acO6vD4hFB/rxoAC4wQtL5BMrO0r2kyQIQwuJdgdY9D5IggdX/gKEHpaqQnTypqjq+Do
         rcPY0YHPtVFojq7cFKtuB46Ox3Cnl1rA02vIWW+EaD5tPBFzfq8RwC1/Npkugn+UZ1tD
         m81w==
X-Forwarded-Encrypted: i=1; AJvYcCUafUp+UNJR3dSAtSAfqsrgSRP+Xl4bKDBPwS3nSlj/9KLlRTxuYFub+XWtOMRT+TlapSELzQiHgBZ4K95ER83wPnLer3T913pMathS
X-Gm-Message-State: AOJu0YwHELTXxq0V6nTwg/0BHAUFx7tCwx7U+xB0/kOqTU6zL2i1A2F4
	EydmU71SxjXUZszRoQi8nJDNJyOUJLZ+xHtUzFFQTGCCgfloFinwgug66uVXTEbtYX4W/Ge1UnH
	9b0nLXeEwebgaXRR4ZqBLBDIPLsAr1DR720q4ou4kuUWL3MxxLTFDVTk=
X-Google-Smtp-Source: AGHT+IGwo2Km0QbPqs+xCV/X1YBQCNiq02WGU+O3hroB+S6cLCUqdysdrb1ky+UxiUyUXtIsyMc0dCia1ge+gPgv8pa+molAyFdf
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:220b:b0:363:bc70:f1b1 with SMTP id
 j11-20020a056e02220b00b00363bc70f1b1mr55404ilf.2.1707974045245; Wed, 14 Feb
 2024 21:14:05 -0800 (PST)
Date: Wed, 14 Feb 2024 21:14:05 -0800
In-Reply-To: <000000000000caa956060ddf5db1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000040a8cd061164b23a@google.com>
Subject: Re: [syzbot] [reiserfs?] general protection fault in __fget_files (2)
From: syzbot <syzbot+63cebbb27f598a7f901b@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chouhan.shreyansh630@gmail.com, 
	eadavis@qq.com, jack@suse.cz, jeffm@suse.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, reiserfs-devel@vger.kernel.org, 
	rkovhaev@gmail.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de, 
	viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16fbb3dc180000
start commit:   f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=da1c95d4e55dda83
dashboard link: https://syzkaller.appspot.com/bug?extid=63cebbb27f598a7f901b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230c7e9e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=133d189ae80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

