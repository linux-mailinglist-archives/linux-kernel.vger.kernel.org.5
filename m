Return-Path: <linux-kernel+bounces-127543-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE4F894D64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 10:28:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1BA2834AF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 08:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40C83DBBE;
	Tue,  2 Apr 2024 08:28:10 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D85513D982
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 08:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712046490; cv=none; b=CpWXmLqtZGqzby7o9w4a62KiuNS+nE7pqmpK750OvhhjZAtV9aJUwDMV41TaQQnMuJkxxDTzH19OsETO1ll5CFSqZDHMuwpTKSUfAJxxPeohZgUijR8CuzM1DN403E05RnzxI9HW8Tuz/88VyqUrQGFCjYxfdilqc212NcQahc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712046490; c=relaxed/simple;
	bh=BdQN3nJTgmkKC2WPKVAld47dWMfaDO96QvzomiVFULg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=J7ONmLEyU0tzoCH7DwXB8IbuelBv1M9kbQKKtsxpUxkp3pg/zUG/tDNXYzQlrvUEK+Oy0bBj7VmKP0Qf8fa1JagqJB5uXlOTDFjUSK/hJyWNwx7OlBcQ7Ch8F8RzpMFe5HDshGjz3LI6DbQBqrloSmnCWDx1VSpzghKlldQ9EQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36683ec010eso49309925ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 01:28:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712046488; x=1712651288;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nM4okNe635dymTuHMjpPdEqlSOsTArgHBjbWYpB4UnQ=;
        b=MIkQVrWIlQOszJSaovminTtywVbQZgBBOgRLIKmz4pTxo33rf/1b6363r26qEZqVt8
         o0PZisxl5uP1iKCE+0eozllHVw/B5Q2MVD4v4dEys+kEzYkOAxp11Fcg++yoe9fP1PuV
         7OFnIKt9BSMhFKXwdyNsH/8ToRcYaKuomAXWftX50SEiFvdNTd6dsS03aY19AbL3BhrY
         m/HtccPGRNnNgdxaOWfwx34VwPJBHzQfAdyGscijjUIwD/aTFHqaMgRX+rcJggzdIsTa
         Tn4KAAz9v1989FC1xOxt+nqVkpiRglRRQTtebl46KJPCaPn+qAkB2uOQFQJtmsmtHise
         fMhA==
X-Forwarded-Encrypted: i=1; AJvYcCVZqybs0ed30oMIPEO9LMXeGLU1VHi9KjnZkGi+v3kNILbpIvKJ+86ibQ2NhR5B+eElizDk3NYGF6Hu9/8fsJW0Q/HFdTZtLV47bHZy
X-Gm-Message-State: AOJu0Yxu7ESl2+x5ioAlya5G7CSXjWcMOsFb/8+dRCKfeEodFfZX7Wex
	FN88dH7sQZJ6fof3zjE80B/G8dubqwGSQ+zwORiExXV9eLLmLT5huL2fma4LBCyuroSX0IiRAP3
	80G2Re4R/5539Z+azcY7PlL5te3S62axs6VnOfkqrxCKuHxW7QmjtzfE=
X-Google-Smtp-Source: AGHT+IG4g7IetFL02w/swp7iJ2dD6nrgyOfxNHdhuteAFvFle69NxlhOlby9oESFGUyh5qdQj2DYoPll7vDeapSxtjwOKsmy2OiG
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a06:b0:369:98a3:6f98 with SMTP id
 s6-20020a056e021a0600b0036998a36f98mr417436ild.4.1712046488106; Tue, 02 Apr
 2024 01:28:08 -0700 (PDT)
Date: Tue, 02 Apr 2024 01:28:08 -0700
In-Reply-To: <tencent_29AECB6ED24C92A7F606DE92D0C67909A606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c34ec0061518e2dd@google.com>
Subject: Re: [syzbot] [mtd?] WARNING: zero-size vmalloc in ubi_read_volume_table
From: syzbot <syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f516089d7815b10197c9@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1287dc5e180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=f516089d7815b10197c9
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16e5b9f9180000

Note: testing is done by a robot and is best-effort only.

