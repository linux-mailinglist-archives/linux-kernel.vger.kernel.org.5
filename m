Return-Path: <linux-kernel+bounces-30647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D224832278
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 01:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F709B22D79
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 00:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A88F634;
	Fri, 19 Jan 2024 00:08:13 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7252B38B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Jan 2024 00:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705622892; cv=none; b=GsJ6t34xesE/1PbBZ213I3ciTw9WFu+iX5MnDcDH3R2IC8GPVjbt0UON000mTjSUkk7AgWyH07jyZ4ZlMawYq38g+Vin/LHLAT99ZeGaTu2I57yFNUEJ8935/tgV8ugr0EMrTVzHV7waIKnZR1xU4b6+b3V+blVi6JrOBlehXuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705622892; c=relaxed/simple;
	bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Cord/8bfwUSwUTpyEnYv969Oh9TtPkh21iKwI3MZd8anlOiGpeElIbZq4tQ70qpZNep1JJaWMhWHc5pPO7K4+Km1sxLFkBkLDRhR1uUO0khawy44mtWdYZFhcfyGKINWxzJKOYzg6jIAYQAK24/Nglx0b4rol4RfW2LB8h+Qtvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bf44da02c3so16173739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 16:08:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705622890; x=1706227690;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CPKlspD/ZSfWixUM8SglUnOrdGxitKBWwWP9lEY6reA=;
        b=kyX1bPGmAZdkkSNFDWg58YVYYKzy7qphtpRhoawSRFoLL26HM3DKx0xjadgzazutSJ
         WEAXTv790WP23VQf07rtmR948T7BjqjS3iZpZBeflfTtqNh6MkBmHV3M5vq/qrkcNfhi
         1r/dsxT8R0C9T2uc75c2AzOCwtBrITXPqZaQdHwbxnkLOytRkY3A5K3L1RSU52ZYrx5i
         /26lnwW16RrKnPNlEf3aTEX4mbniO6vWIQn6fGYyEwQUNhRQUAey2QUHXDNCRkdwO7Oi
         XwN2RN/I7l8le4yfZyPNHnEEL2Wo5bPrklguVMdVeucNLX3NtOmvsQX6A67aJ34AXrQ4
         w38w==
X-Gm-Message-State: AOJu0Yxg9Egwfbz4QhS1Tgc+PRir4C9G8zBrYBvK/JYYpJN42YqCg729
	PlZmAyzih9zCePjvrwYIasCRvOAOeXYLx7MQSy9GYwTcE2yQYv0sNU4GelVq8EW6b0iCI+BVbBv
	tr+jBfAUb4u/XSoPFfDW6mGyr1FuSmDZMGmV6NC6fnlxwtWlMDPDPLQk=
X-Google-Smtp-Source: AGHT+IE+20ODISW063pUWTzU3qYgT+tD4QbDYTdBWXIP3yqFphYyDanVroxowDzV4LV9aaQmKl8KVb83SSsvWZJB9EKHizymSZ3r
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8c:0:b0:361:9826:5209 with SMTP id
 r12-20020a92cd8c000000b0036198265209mr179106ilb.0.1705622890710; Thu, 18 Jan
 2024 16:08:10 -0800 (PST)
Date: Thu, 18 Jan 2024 16:08:10 -0800
In-Reply-To: <0000000000006fd14305f00bdc84@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000085902f060f414615@google.com>
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

