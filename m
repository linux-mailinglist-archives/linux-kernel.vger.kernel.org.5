Return-Path: <linux-kernel+bounces-97599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE3C876C5E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 22:27:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7617E1F21801
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 21:27:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 241095FB8F;
	Fri,  8 Mar 2024 21:27:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 446145E077
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 21:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709933226; cv=none; b=URBBYKoscLpI7KRus4tJk44mRAa01FEIoq1sKp6UBOMHazt4Sb6+6BGVVCI1lXz0Uyr3hF0PpcAz20VoWaDj8IjaSD18pYCBoZnOLjeIWv32CtL69KuGw0iKRxoKtxAbd23DUUoY2fDdenVvqCq3TfDNmdVor3S0XoJxk7Flmn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709933226; c=relaxed/simple;
	bh=u7l/U1k0b8WLPkq/O7XnXWPK2N8wgWRoVz/cbJw/lxo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PWXFfWwHazlpCl7Wix+hyaV7oNvolhVTlX70eXIc+97qRnn8GjXRk9SItmWdnTKojm9f9mODK8FIoJoOeC0S3fgkc8kOgzZxZtg2K1rWGB7KMhWN7doE+sAu/7dRMm4IpP3J2DGFTzBvb/VsuGfLD6VwfQ1cvcQuA23ib/nkj9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c83a903014so268307439f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 13:27:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709933224; x=1710538024;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I7u6kH6QRLYYasOKH6vti3N8lwLjnLDCzgOQh2S+Wgc=;
        b=hFdYRUyXCTN8RmNcrGVYPh0iFRhaEsOuK9aAHlYtWJ0MVrJ8T/r7lyO8Eq7tXp05FJ
         BUh+dtU3gvKiCs5bU7pX4ZOG0r5JAzLyqxJ6m93+RZ5o7n/xvYe/bbCaf2wjxdlJCM0k
         hjDQPjY9v9Q44tyEhX1JaDYR5mt82FCKy0Ungg4o5QXVlF7DCi9+4wE2UeON7V/JVSbe
         daA8TEgev7+s8Y5v+cq13jGmliMRw651A45oFdhZNd1f+JEeaIWzdFxFh5iyS0+y+G6J
         jle0e55PQVlTqV54Rhf9fB8XvKzO0I7jCceoREIcGq6/xATSsjFO6DlnwmLw/zAEMAW+
         ONXA==
X-Forwarded-Encrypted: i=1; AJvYcCVCYlwGuBpugpEA2VfGK48iC306+4onVUdJph/8mXL8alfktjTgNifaBOTIQgIjCO11jUDM8aCwU/cIdwzqN5ZcmEot6gfU+bI4BquC
X-Gm-Message-State: AOJu0YwRxymnsAmc6FiphxJBYr9TYLShU4fAgJ5LTNCwxnYwNVzmFvCV
	Vl4RMz+ROJNo6O+0ZhdAbIJ9PBEoZByDugDJ62xCxhqJ87DFSTHl3PVGUSliGQlze7tqwyldTQB
	SIrnJqTEXEfQoFE3Y7H9JQZudF2uVNDQh3+3nXAaE1YM79lxzJRdAtls=
X-Google-Smtp-Source: AGHT+IGnhB6ok+UT6dhlPPsdCYDSnoJazzwrIi3u8UzfwuMhJBQqJy+kvc9v9EefH+8uxg2q+1ZBvU6SUVqi6RBl+GmY/FXaZX7d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2b09:b0:474:bc7d:544b with SMTP id
 fm9-20020a0566382b0900b00474bc7d544bmr4094jab.6.1709933223590; Fri, 08 Mar
 2024 13:27:03 -0800 (PST)
Date: Fri, 08 Mar 2024 13:27:03 -0800
In-Reply-To: <0000000000006c2bbc05e714ec79@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000061cc2d06132cda4f@google.com>
Subject: Re: [syzbot] [reiserfs?] WARNING in reiserfs_lookup
From: syzbot <syzbot+392ac209604cc18792e5@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1748692e180000
start commit:   9b4509495418 Merge tag 'for-6.0-rc4-tag' of git://git.kern..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c79df237bd9a0448
dashboard link: https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142a4277080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146950ed080000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

