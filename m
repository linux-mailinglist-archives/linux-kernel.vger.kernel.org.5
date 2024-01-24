Return-Path: <linux-kernel+bounces-37590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F9183B22F
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:21:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E2628D788
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 19:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A47132C27;
	Wed, 24 Jan 2024 19:21:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A27131755
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 19:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706124067; cv=none; b=VbicGDRtM0Z4Tt7q+l2aiZpMicAMQ1Zj4PEpWMOiUR9+2Zhfsmg7uxhLtDBht5oam9KuB04iKCR4s3BGt/lyglCkfKpuVvsxcjidCRM443QkxSbFXjVkyn9IfItkJcLNYjo6VI4Is6CWgzindqyfqpovKX7VbTZPFtYMc5JkZB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706124067; c=relaxed/simple;
	bh=c6WFIf+JHlsGEfzQEZQLoJIP7VaM+Bmu6MrXa+u4PA4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=XV4TBsmlYQ4ylAf/Zq+x4AB0ia7ydFdR3dxKeLin/KXBhWz2VCtstb5CW0FDaf1BQ4q3naUZHVsnC5t/1PrKBjv67AkKbZHzrU4mgDMuAbPfyk7lJ9XBjLa4/pyvoeohVWptLXrVc5M7u36JJtlclhJvxsetNCDbKnGgLZkynoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3627a593d76so31320005ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 11:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706124065; x=1706728865;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z7uAoJlJc/r/AdH+EKRBB9ocEe4x/wXE6PggxylocZs=;
        b=p6SCy9JUxel/gjLYCP6MjdW48OXVYJN6qY2hrIdxoWWZvNqJWd7atgpu9xyYhFrMkK
         m8dcJibYTKeZrjLL+9+j1IfBBJnZHm9ud53+0UlTWU3zrIJ5hE+w5uBl1dBlX0pgQsLa
         mTfFN8cmG8GtB8slHdP4lKLMo8v1bYXfvDWAQ8qlSvhP5d7fJ/M7ZkPBgv/QV5Bezq2+
         lJwSyHAtxWFwBHWQe12wletgOn+z7LmSA82/esdJlrZoIpU0eyfe4WGopXW7NQQFkY9C
         gOweyWhGUhfFzMYK0dZyhvJepNsp+DNg3qaCP43OYImWIzgdHDx4Zb4WXaXHYby7OpUN
         Awsw==
X-Gm-Message-State: AOJu0YyqS4C64rJkWTIC/Lp/3DumzU9ZxeerY70z9sACnTIJNw2NqWFn
	x8HXIBy0uZNTn901aRIkOD+oh2OwUGolA0kqXXY5yS89B4vG1PyzduydAb8cVd5u7FiwB9Ftv14
	wgF/oGWVTlQ9yHHs+IKxMMvLvSZoYOffauQZWb0h65djez+FNfWO8pwg=
X-Google-Smtp-Source: AGHT+IE0i10pqpyY8PAMZM/n2o6EisAhLNFNU3MnVtH68x+1q+ebTb1VrFJvegV2R7EiIEC4oR8hRVnJ+M70p6wabP5Bx+g/3ZW9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bcf:b0:35f:9ada:73a8 with SMTP id
 x15-20020a056e021bcf00b0035f9ada73a8mr269347ilv.2.1706124065104; Wed, 24 Jan
 2024 11:21:05 -0800 (PST)
Date: Wed, 24 Jan 2024 11:21:05 -0800
In-Reply-To: <00000000000099887f05fdfc6e10@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d7ed43060fb5f676@google.com>
Subject: Re: [syzbot] [ext4?] kernel BUG in ext4_split_extent_at (2)
From: syzbot <syzbot+0f4d9f68fb6632330c6c@syzkaller.appspotmail.com>
To: adilger.kernel@dilger.ca, axboe@kernel.dk, brauner@kernel.org, 
	jack@suse.cz, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu, 
	yebin10@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=102ded8be80000
start commit:   25041a4c02c7 Merge tag 'net-6.4-rc6' of git://git.kernel.o..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7474de833c217bf4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f4d9f68fb6632330c6c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11b3bc8d280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

