Return-Path: <linux-kernel+bounces-100161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FE0C8792C5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9AC11F23243
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 778CD79B89;
	Tue, 12 Mar 2024 11:12:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986AF78B7B
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710241925; cv=none; b=ufFkfxyI+UQyvm/KIIC4dOiOgYKb1OKAN2kI+ALa+M5HDA03Myst0YPmMdJE9APQumEFP+Sp9fXwpFHdwtA3uov3zW5oShFHA/Gr2Gw1Bh+LC7Nmx6HrzJWmCoR0EDN68Fqs/uAq9iTkacYoeSDq95Bsdiceo2HO4pdELSRofVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710241925; c=relaxed/simple;
	bh=F/F5iY7dNNbeFNuDWmqJTXlF4HeuHZwN+TMZQ4coK0g=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jNZPkLwpxTCfV7pQAvpJ6ta0zrW+EVxewqn896eXTDBc7hGO7javdOTGW2PYAzGY69ITgj8fRYdPQVKz6FrXB2n/hJGcXQ9aDGPZCs4GzB2ZxPNYKilIOhcvMmVEDKHZw15NYmWzYR3ZvmUMWihj8hcjUFdTbpCwobdGd89QYcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so244151639f.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 04:12:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710241923; x=1710846723;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HZbS9O7jYNBOBghH7cVJooPu+oqs6wIvnfHd3EqYfcA=;
        b=jCibTyPj8NEPNTB5KAVltCZnoXgRLC9tTlCRdLH1ziZGA+WplYxj6JmIVC06TIovYY
         O1e4DI1/MWmXsFVZqyPfOqZ4iPK/aXOz7cEggsXFqLN64moSNEsggr0TKQjeT2YI046Y
         3AnDt8wf3cERVdxyNjrY2/WGCzptSKIe4IYaxrnUlBmy+uT1dKc26/hmKfMxBU8ra0uz
         faNHCQN8glT5z5Duw3kZIq+wNxEOn8lFR7t7tpUp+AYzNEsJAazIAgTwZX+9amB6oFur
         Pvs60Arn/zjRGVfFz1+8poPyBHtvvf6aloqC+DEnqtVYcRC1HbdTNoHqccrI1/3tQ/1m
         3MRg==
X-Forwarded-Encrypted: i=1; AJvYcCVUI9MBi5lyykmRKwwPxTG1ZTmCgLCEFoshqA+hAmZUHDdlEPdc5QHg2ess8Uj9p0dtgLrL6hukskUeZYGXVS7mWhlYWLh44Ne6FQnS
X-Gm-Message-State: AOJu0Yyatk/URcKkRpWJTGR7xfI5SH4QqBejqiZ3kdVP21Mkm9DBQetS
	jGfOiLQyAXy9OWkEEB9I/CX+P31nxsKXEEwlZUwLP2tEMKKYxK3RHLcAxm0sMRkXUqDiRjQJTxb
	JQoPzlN+VnYfMxS3InYB9xlB6+/LGxmrPtlmDZit7r0IZvnXTqrtZ46E=
X-Google-Smtp-Source: AGHT+IGfGq3rEfX/wKWwVeENmMXpKFCaNRe2flrJiSKzamE5rF5j9cNAunR0ycSD57ABQVQD/SPDwd6rXQp4sBQlhp4bVx5bvynT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3fcc:b0:7c8:b6cb:9201 with SMTP id
 fc12-20020a0566023fcc00b007c8b6cb9201mr138082iob.2.1710241922914; Tue, 12 Mar
 2024 04:12:02 -0700 (PDT)
Date: Tue, 12 Mar 2024 04:12:02 -0700
In-Reply-To: <000000000000fc57030601f44e7a@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004babdc061374bab1@google.com>
Subject: Re: [syzbot] [btrfs?] INFO: task hung in extent_writepages
From: syzbot <syzbot+d9d40a56a26bdd36922e@syzkaller.appspotmail.com>
To: anand.jain@oracle.com, brauner@kernel.org, clm@fb.com, dsterba@suse.com, 
	johannes.thumshirn@wdc.com, josef@toxicpanda.com, linux-btrfs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit a1912f712188291f9d7d434fba155461f1ebef66
Author: Josef Bacik <josef@toxicpanda.com>
Date:   Wed Nov 22 17:17:55 2023 +0000

    btrfs: remove code for inode_cache and recovery mount options

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13a76f71180000
start commit:   861deac3b092 Linux 6.7-rc7
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=10c7857ed774dc3e
dashboard link: https://syzkaller.appspot.com/bug?extid=d9d40a56a26bdd36922e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13db2979e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: btrfs: remove code for inode_cache and recovery mount options

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

