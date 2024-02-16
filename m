Return-Path: <linux-kernel+bounces-67880-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31418857246
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 01:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC03A1F2556B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 00:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1918F49;
	Fri, 16 Feb 2024 00:09:15 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4E0149DE4
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 00:09:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708042154; cv=none; b=p6P0NeflwbP6eOFWlyyRX9qd7fkThm7w21VmZoa/ZWpk6ICnPxAAcQcibXJOyUTnSTxAZrj6z9R0WeZMGDjXlOhCAqrsKp9kOTFCAg0Dbpmz8Bp51x8hYWM6l1pbHFYYcFTrjblYaafIrPbsiaf2MQ+V51k9XvVuCZ8I2oMwYYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708042154; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=CKjkDrpTXiDQGk2rVrl1M/JFAJSOuBJ6DiOZUW+TfzKBXa23OSrJcraqoHDiZvq6gPJkMfMlHDAr+qhAHmK6L60odOdPKlL7Ey4xG1D7m3SmdH+9+tcHjpLjPfkWp1KbCIj56+rtYKl+GUKeqzSGeDylQnWEPRHtW6r3B0i/8E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363ca646a1dso12915535ab.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 16:09:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708042152; x=1708646952;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=QZ3MBuoZ023B62CCPhHXe20IwjJG4SjAqXIAPSkV8zvDnWkMlJ/RqLXLPFLLNYmMuQ
         xygLrM96feDskKn187wRz+NmPtQ7DtzTBlraHaGVA/SdLwcHcWc+NaQCLZhN0h7whiKH
         ioc1Ch7lrVSJWc+R/dre57xhSLO7tngbdw8Jzo7W9H2rSyQ59NhXUH9RNAtdwkYm04ED
         CR3lbwqFqEW0iMc9zkBTZYw05ZOka9KaCccWvkvHusz8lKXJMww/N+ynObHeMmBICSXZ
         bOfUAvoTUfDyHIhmtNgGTPjcH2P5BAp7XizAQv+ducw6ou1DuMACzJwCaH/zTj+U0fpL
         ucpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWfrTOlGKeHtIq/h6T9TMMd/c9vuk6Ci5D3jLEFen28Vk/0WaHpG62Kcjr+Y+1S6x1E35C6jTPyRhIj2f3VgpASz8QagUefaDlZD2+
X-Gm-Message-State: AOJu0YwVpzCGQtj5oSdu0y9BZ476vaAdJaBsvoRLX5tEF84Web4fvoFO
	PnI8hNabTOQKlMQv0MqICmoEOTy1gZQriVcVW0F6uiCwzyubrQdYBL/J0ZRVCH9YmOXpzb+Ws/3
	Ws5i0ijmv0Taf/Tq6eiCy7ZiHrNK7fYUmOfUZy11GBNRYwswVxSfPLUI=
X-Google-Smtp-Source: AGHT+IHWCVuUeC7v0lAZJFezIkfQcaDrrBjAbxzk6k6ndWAM0wqDyd8gqinQBOi355JqaWTeH85DoeiriithR+xpOQuYk5VA0C5d
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:363:c75c:8c9 with SMTP id
 j10-20020a056e02218a00b00363c75c08c9mr271591ila.5.1708042152425; Thu, 15 Feb
 2024 16:09:12 -0800 (PST)
Date: Thu, 15 Feb 2024 16:09:12 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c1bf960611748d2f@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_do_writepages
From: syzbot <syzbot+d1da16f03614058fdc48@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
ext4: fix race condition between buffer write and page_mkwrite

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d1da16f03614058fdc48

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

