Return-Path: <linux-kernel+bounces-46249-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 84341843D03
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 11:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E0C51F326B4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 10:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B27869D28;
	Wed, 31 Jan 2024 10:42:08 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3270569D07
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706697727; cv=none; b=l/IzWWmw44n5K2+3S/YL55FpuodOvVLD85l5+rGlq8hLCVucnhLdAHH1dgEVwpqCSH8fXt7DzJQ/AEpR5SZN8us+9DB+KG2P25d6+eC3UOi17agCtsxOBc5ATJ8h7Mq9UhJyLR0Mtkuqhdj5y5aKGNB3aB6QfEZN4ga9Q6ZEKj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706697727; c=relaxed/simple;
	bh=eayMnaDsNdevHI7EIvetwx02Ohz4VwMDQyUm5aeVlko=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PPxRWVtphNqkB4HzhrDt4GvJNSj1x6dGEAFNqOV/ZduK+y8VgjK6gPbRCr+Axp1CSlI9ckZ5htWK5K7/y3prQ8eN5zRGJj4atcmwfJoIlfQO4o/TVAEuOWiSGfAdOnXgpTOJTLqoDq0vhDVV3yvXaS0Mfvzz4Yy86PZXxOfiC6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7bfeea77d25so36666439f.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 02:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706697725; x=1707302525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6zq36DHtfPWyBMcJu7aIWuZgaP48vHVKyxM8wnY802E=;
        b=ixmqIaZ9P+jk7oY8x+WI6AR+fwktPD0JU17mFPj+FP3sXQ8ZkgIQMqzwpCqiWyoS1j
         J5ts3Am0hYoLKvzumlzADS9k1MyytDGPGKuIJFYhvtDwTPvLTBrQXK/Yv4T4yOj2TSzz
         VHevZoHU2eOqnUxlByNeVVw3BVWbN1KJmy8DqdJenpIYbIPa7cUhSzeiMcKqblcqWLS1
         UPqe3BkhYENbA/I80u3O6vYuUlFf7tOMyvm9ZHjCDpULU4e1J/cMjYmXP4ux1tOERY2J
         GP8Y36RWMyIQhJBY9aZmx49RpBpO0E1HoEtP/0wlxZOt04BHsqSybu+qz7YELYFKBg+6
         QymQ==
X-Gm-Message-State: AOJu0Yzh/b5/bLG4mLV38x2/9MGGWh4kyAW24MOKACWi36XyddCIKosf
	gg6TNu1F6H0V77uL89IfwRiYMLnIZJo650l08XOh6c6Dx5YF+tWEHupmoo4InztjeITiLtyQa8n
	FPpnvNo0F8ic1tY7Tz5PHdBiS3vQRzfdDcc3GHMkJQmj/hKQ05/MIr0Y=
X-Google-Smtp-Source: AGHT+IGFSm0yzMIBYZnSH9YM7YTw/MXj06fxm98oZ/EuspyBnUhiMljwplvKsh/tUYmHsHreyltVlGLHhf+tjKMvtlAFmtRyzvUa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2d90:b0:470:e01b:547d with SMTP id
 gs16-20020a0566382d9000b00470e01b547dmr44706jab.0.1706697725281; Wed, 31 Jan
 2024 02:42:05 -0800 (PST)
Date: Wed, 31 Jan 2024 02:42:05 -0800
In-Reply-To: <tencent_E65689B9AEDBAEC48C92A7D306C0D2EE4606@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a78b0306103b875d@google.com>
Subject: Re: [syzbot] [block?] [trace?] INFO: task hung in blk_trace_remove (2)
From: syzbot <syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2373f6be3e6de4f92562@syzkaller.appspotmail.com

Tested on:

commit:         1bbb19b6 Merge tag 'erofs-for-6.8-rc3-fixes' of git://..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1527cad3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b168fa511db3ca08
dashboard link: https://syzkaller.appspot.com/bug?extid=2373f6be3e6de4f92562
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1650be40180000

Note: testing is done by a robot and is best-effort only.

