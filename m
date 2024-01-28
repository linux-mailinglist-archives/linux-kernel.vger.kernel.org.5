Return-Path: <linux-kernel+bounces-41615-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9163283F565
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 13:07:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 485261F2132C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 12:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D365E2376C;
	Sun, 28 Jan 2024 12:06:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1FE22EE8
	for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706443565; cv=none; b=fS+iY8BXaYod4G8MoSkCD1JqEN6IfeL1kgHWbKO/Glyu9wFFQK9BJ8kzRojWsqbTgY2SEwkAu8Fa2oY9DLrABb8r3f81pMgKz1GtNAi/B8/fQuaAvdgYxp0+c/H48WoE68f8gxuFk5PVanZ6DEVLOYAkxDQvxUxZOYLUVfga6C8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706443565; c=relaxed/simple;
	bh=QU22BPUKpV46xczwrX/R7oaA7p//jsIuJRmGAYHz4Ec=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=czsp57AeVAYOwD6petOvPSpssl4p43+XfDsIYX10ZuxorL9LiNVQkmpFRkHh4XeQZPmehQTGXlhN9/J207W5x55aVD/vHd210EwW7bhuNQqI9oHQv8Z5UYtetcIkkad1fUsmXHqbfzMxT6x6YIzOUwhvZ9242zrPM3ZLmaPbH3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3637a31cc3bso1814155ab.0
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 04:06:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706443563; x=1707048363;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mCIsLiZpavhtZme69985y3Pw37KfRaa4uVvsIrfjTqg=;
        b=MsSFoPidHBVACF3/kJtrEVsR7Km+nwg3PzUqOJrC0oh5PMjSrsJ1t4G40DYgKkE3wO
         PUFKeZ3HUsInsNy//awxtCzuxI6oWtwZVBUd8BuTj4J4S14mWwlzoevZM61T48oMmuBX
         N1w0y+cAgNBwiP9wBv35aGZCVNXDr73yUon4r1QLYxSqwXhkCK/ZA64ehdyHE8A8UOuL
         1M+4EXzAnOJOjEcp1Xs3TKRBPpI2guDxv3SsTo1eBYQJ8fxfXKGTnAIYm5Zj49HrdFN0
         vvCDbUTBL6UT72RazEoq5dhiaj6tP+a9MDHTVnmhLef73E4IeSmVrMsZF6BgnHT9U+t+
         6U9Q==
X-Gm-Message-State: AOJu0YxBjbBb0I6o+mAEP4KdlJQODdFJOItUT50u7Mc73NfA/ouEBsyO
	Fb74CYaqup3dy0pGgA1/l/cTQJrvRVDUDVShyu4txHARsdExLcZTNIgtj6qC6rU+In6Yis73cXj
	TZjGis0Wn9AQqbP9kQkla2TvVcPFJchOUEve+qmzRtKndT05T1pEALYI=
X-Google-Smtp-Source: AGHT+IG5aswdVskP0CaJ0qKXMTklJUrKqOw68KFqGGFdSWUtyV7kYVxyboEPGaYiV2Op0JVFX6ZvgZH8PF+ngzrjzRgY3okveKlu
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a0e:b0:361:a872:1570 with SMTP id
 s14-20020a056e021a0e00b00361a8721570mr400291ild.6.1706443563107; Sun, 28 Jan
 2024 04:06:03 -0800 (PST)
Date: Sun, 28 Jan 2024 04:06:03 -0800
In-Reply-To: <20240128112815.1161-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000688bc50610005a3e@google.com>
Subject: Re: [syzbot] [bluetooth?] INFO: task hung in hci_conn_failed
From: syzbot <syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a984066a63e9c1e62662@syzkaller.appspotmail.com

Tested on:

commit:         8a696a29 Merge tag 'platform-drivers-x86-v6.8-2' of gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1185e5a0180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc36d99546fe9035
dashboard link: https://syzkaller.appspot.com/bug?extid=a984066a63e9c1e62662
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14504eefe80000

Note: testing is done by a robot and is best-effort only.

