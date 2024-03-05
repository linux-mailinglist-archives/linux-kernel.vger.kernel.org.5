Return-Path: <linux-kernel+bounces-92022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 858EC8719E3
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 10:48:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B73471C21290
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 09:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57CA9535D6;
	Tue,  5 Mar 2024 09:48:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E509535AB
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 09:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632085; cv=none; b=soQJXnexXn3XHp4C5/v2KojALQXQz3oeYKeS2hpCjcPZBT19u2L10CdB57DbqeJP9P2xeglioE3Sd4um4Sb4TESDsVGMhYzgZRmth2seXqo1aWP3iDtcJ4Pyz/841G595/nlMQqJNqlDXtzSNcoNgIfevFnhbrJGezs4/h9B4Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632085; c=relaxed/simple;
	bh=FUV2UfMDI7InnPdcCSNJGtUvjpOsTPaChu2eym3FVR8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UY1hqzV3UtswJ6V+7wjLnPGha9jZepxXiTlEY3P3V653xoKWoibNFTdj5viXcLLu1b9qHTSXBs+O3jGiGiMLWDmGn4eqjYdqaIS/Hi+CcCgH1GaCtyfI6SXBoLe+pAW5y202xwJkmyFO11RYzDlH/jx9XQqYwb/DYLEtWTD3R+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c858e555d1so168465039f.2
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 01:48:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709632083; x=1710236883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F/PW67TWH8skqmU8vKJwkoq7t3qUI1ZITrOnwecy99Q=;
        b=xC4AeehqvW8Ab4zoC7/23YP9SIX8loqYaS0xj+OSMgMHNLYFLse2OTyOyGbED+pIsR
         l5HNHEmgfOdRzv9XYBv3ajQ8iaoesVdZfWx/o8Na+pAdOMDTezPqN5q0CpXiplyNZc2c
         gKIdKBzuDK/13OB1i5gR2s8ECHNAmp/CaqQe9fwV1IxvN8CXw/wwNC7eubMvl4OaSlB1
         OVWwf68UaKByHLmbweZ0oP+HX3FVNC8h+q76/ZrJyre5azWzPsnBZFCIytc5aVZWqWDe
         K8ePjSuXKjmM/2LfdXMEOT7pu2q30CGK5bXcrKpjX6zLN8hZtsucDiWMJ23JPCSZ2NHi
         zpBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWSh+0GUTVvI8ZVWkne6CK1AsDwj37FfnEgSJ2VDkW57rRO7pTt6JJMKkJyH1TKwPLs7+8hHykdrgq1i+8Dpj01r8lArRZJ57vds1zx
X-Gm-Message-State: AOJu0YzaFijNpQQ2EDwXxq5Revy3TCLWKiIAsqjS4qFIp6lVx0me/cEv
	h4Y/i5GZR7jnuCufbQ3PrUxj25nVwcpoFF6MkY3fypwV5vRKZN8D35BzTNeQzwnf4meq1f4A/hs
	tkld+aWPJWBlvJbYuTR9f9CcnBcT0m+U7cKlXqCT4KyV5dQy+EFbdkq8=
X-Google-Smtp-Source: AGHT+IG6l3HNMZupoKsS/1gWkPsOulXpjgLde5BhCiJPeE6FXHMXeTqCfcGSOQh3Xyp9sknk0aj3dTMHR9Y5+rBXctugU6xVy/Vs
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1611:b0:474:edd2:24d5 with SMTP id
 x17-20020a056638161100b00474edd224d5mr360168jas.4.1709632083746; Tue, 05 Mar
 2024 01:48:03 -0800 (PST)
Date: Tue, 05 Mar 2024 01:48:03 -0800
In-Reply-To: <000000000000c925dc0604f9e2ef@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000c6e0a0612e6bd58@google.com>
Subject: Re: [syzbot] [gfs2?] BUG: sleeping function called from invalid
 context in gfs2_withdraw
From: syzbot <syzbot+577d06779fa95206ba66@syzkaller.appspotmail.com>
To: agruenba@redhat.com, axboe@kernel.dk, brauner@kernel.org, 
	gfs2@lists.linux.dev, jack@suse.cz, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com, yuran.pereira@hotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119f927a180000
start commit:   6465e260f487 Linux 6.6-rc3
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=8d7d7928f78936aa
dashboard link: https://syzkaller.appspot.com/bug?extid=577d06779fa95206ba66
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dbcdc1680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17a367b6680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

