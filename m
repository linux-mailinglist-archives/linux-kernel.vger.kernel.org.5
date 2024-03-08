Return-Path: <linux-kernel+bounces-96901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C238762C4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:10:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ED73282A25
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B47455E41;
	Fri,  8 Mar 2024 11:10:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1205579F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 11:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709896205; cv=none; b=c7LBXGb9DrD9I4hb1+rkGGs48pUo2F3qRl1WZQiaS2jHAsIRD+t7F7uFbC1FqEkP5ZZhps8KaKFBo9sneHYwPDsaDWJ0lbUIsvdSwwwGCFJYoe4koEsnJbisbkj3jD0OtX+PYqHKITmdBuQ0P6RCTYXwx8a91jyvsDbxxboB7ow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709896205; c=relaxed/simple;
	bh=FrYzcEw0p+l4M5ctio1889wXMZgzFn5PhPC+9nAVQMQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=OuZkhiFMFnOL78Z0h1oqPU219nBsEMeSRnZHO7RBs0Z7rg7SWPQ1+Nn6Oo2YMs+8pNOYyZgRqxFK76EaEgAV6zrU11PMglFEh/IRuAJ0EvB/RS1eTBvGrUblvJprdzo/+vYOpqqGZOt/umP+EGmr1f2BwsZt630q21yteLZrGzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c83a903014so202502039f.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Mar 2024 03:10:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709896203; x=1710501003;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NQ8TufsD7KPXCcu0y//i8jXNAGtGghQ7YVU08pwafXc=;
        b=FhJpe1Lv4xsY3q85IdBpBQA6PksS14AIvzbJS2WmuSP5BOblewLjGH1FeuVf+RDZbq
         uR5AADsn5VGE0umVPjLcbmRVlw/OwwyvBpKLoM+vpcmQrdiNhf9LImLHRtcyyjR+4Lm1
         VpUz92DhBkqkrYH1DBaKqE3hqkHY+RgoyFCYSFwyI2+FgvMXVAvj+N4+8j9BXwHFI4vJ
         /gkGctTc/y0hV2I3G/KSZCy5Jkh9Oikyt0umunRLXGPnYFTJFzqiv0ns8xHkBwOPcoNO
         tzzpBzWRlUu68jnqBX//ILT+63dnd4EEOkev8qiIjHFjkGH90QjO5OvcSZFuQTzbHlZb
         11wA==
X-Forwarded-Encrypted: i=1; AJvYcCWOVPD0CzEyqzzkxOfhQD7N/v7aEJ6wWzED9PHAY5lLLHocP61Fa4489xz1Oufoaqeb30NTw5B9d4y41YdtjF0olGeE9Jqbmqu8RRii
X-Gm-Message-State: AOJu0YwFFvfpSfg1T9bA+rfvEHqpsDLXcotwQ0cTRCOmxmpQpTz5tXK/
	Eg5yGSwZO1wOSe5JT/Xs5wRm6M1tSuS2/zG6XQPjiZh1/K/8/ok+KUWY5P/FkNw/W1BfU5j85KT
	fbQzzxKfBTOw2PIfoMWXxsJ/nS8Un70YmCVcSPfyKxZX1AT3gTlFvZKc=
X-Google-Smtp-Source: AGHT+IGrLI/lkv//KLnRzr8N0GslKr2WdWvndoicXU9vRVvsv+s8NjyH+J4paVGfZOzRmFDKbXuH24vQEPpqDo/fnF7pqFuARKZw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:475:402:bf46 with SMTP id
 v39-20020a05663835a700b004750402bf46mr413607jal.3.1709896203803; Fri, 08 Mar
 2024 03:10:03 -0800 (PST)
Date: Fri, 08 Mar 2024 03:10:03 -0800
In-Reply-To: <000000000000fd56c405eabc7b6d@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d4c7fb0613243b62@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in path_openat (2)
From: syzbot <syzbot+a844a888fbc0ba4829ce@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10a231de180000
start commit:   833477fce7a1 Merge tag 'sound-6.1-rc1' of git://git.kernel..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dd3623e135f4c106
dashboard link: https://syzkaller.appspot.com/bug?extid=a844a888fbc0ba4829ce
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10dfb81a880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15a68f24880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

