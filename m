Return-Path: <linux-kernel+bounces-43633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AD768416FF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 00:38:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02C5F284889
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FDF3524B1;
	Mon, 29 Jan 2024 23:38:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3AD2C6B0
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706571486; cv=none; b=p/5pNUa+Y+cY3rRcr6delvn+7vb1JW0QyA6QMhsrqauIdi7hL5uES58UHBvgoB+bmWatRZ/Htxi80l4R5HTuQWV+A+gYOVJiSlaNxleM44DR8HO/55DlxIBPGTr/1JvoPA56qeE/NrLCcPOU+fRs1YSJfJZ+m4yjSG/09L+lfdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706571486; c=relaxed/simple;
	bh=H48sGsj3HNdX89HxhKfoAZ6Sggeqc5HvbjoyfUqC/c4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LyttVNEz5Q4DfeYgjsiBi3huIVusx/cVIeoiY4u7ReOaHJEq5slwL3ZitKEckheLL4zhSYwfeli7rBd9A0YGaX90hugqlvYPpEdAhkC+bzcxrXUS6Wz5APYxsTJEyILbP3xPtI3s+AoNsJx0//ZQ40lKtfXs8jXrKn+2KimOm2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3637b5e1487so9333775ab.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 15:38:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706571484; x=1707176284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F4Tinh/H7tHl27YrLYf0X5FVFd8ZedfgHTYYqmO8A00=;
        b=WaFWAVQR3SxuvC3VCJJeZDldxgKWdS/QDJ66WnN5XY+ws609Wt+idSw71C8j+tXWTc
         HE/WUBXluNOANznrfFR5ozcRMlTmQ92Pykbj1NZC2qTiUJQQKjFwlLSnGpdZV/n3YzI+
         RQGMghhT28Gf+EatjLPLYUt+EHC+5qnKH2Eqcbhp0BAb+9x7VS8YiezPkzfGPBYbGcO7
         FkI61ImffZq/w/be4j2/uXarCi1cZsKdKycUbFNhUEWVs2SxM10FOkioINWBfigxj3Aw
         FbY0QeXm7iDDvYue7V6+Lf+y3GIakJyP8tHm5gB4fi/3q4UrCUOdJc0q+ECmcbwSvtlt
         TzjQ==
X-Gm-Message-State: AOJu0YyIQA5oehjhC9/rZsOCaGUz+f04Re+6xgMRzeadA7VcR2+j7Tih
	TxqtvH0fBa0sepZmA9PZRRPrOAvHv1qdJ1lz4FTpoVLP6cP60Du+XJ704N8kcUbvxnw+uz+mr91
	q+4m//bkNdUS726ZnexFry11n6dYcmWIQik4euiZYTV4I8F0WFVBQ4xlGvw==
X-Google-Smtp-Source: AGHT+IFkyOtbhvDU2h7EioJqlzFkhpS+1hWuR4GycpeVQIgcdYGybbRwzO8PqHyqni9bShcWYX2RH8MuE3yn1TitW/8OKuqH4etm
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1e02:b0:363:819c:926d with SMTP id
 g2-20020a056e021e0200b00363819c926dmr319268ila.1.1706571484017; Mon, 29 Jan
 2024 15:38:04 -0800 (PST)
Date: Mon, 29 Jan 2024 15:38:04 -0800
In-Reply-To: <d7b5e144-7d10-40cd-abd6-91578d29fb3f@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000016bbcd06101e2385@google.com>
Subject: Re: [syzbot] [net?] WARNING in ip6_route_info_create
From: syzbot <syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, sinquersw@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c15aa445274af8674f41@syzkaller.appspotmail.com

Tested on:

commit:         fb52af4c selftests/net: Adding test cases of replacing..
git tree:       https://github.com/ThinkerYzu/linux.git fix-gc-uaf
console output: https://syzkaller.appspot.com/x/log.txt?x=11840f4be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca5885ce8d5696bb
dashboard link: https://syzkaller.appspot.com/bug?extid=c15aa445274af8674f41
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

