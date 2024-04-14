Return-Path: <linux-kernel+bounces-144118-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AA8A420C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 49F01B20F4C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 11:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9935C36B1C;
	Sun, 14 Apr 2024 11:27:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F40364A1
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713094025; cv=none; b=VsBZRxenJBSRWvBtkiNcRYL1qevnovvVgNeIH1qk7geqA+DPxLE/ZqtQODuLwJ4Rnm76JjMHVI1ZoOYdTico/kqvsFTsUSLLHd9R31KFHmDAIMLDA3tf6GMwZbzCTxWRAMGYuefl4QGsihfssWpFjT9BSC3UDl7wusK6ALvovTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713094025; c=relaxed/simple;
	bh=fkilD6RXXITJvunj7/Llw0NbNITB6YbE2nYjiH6+fU8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lrK0wC98NJEIoVLz7J9wBCcyLjhuo5btu5WaCfPINtkOR6dTZgg6gkhC/u2on8uFW63GjV2R873VG6GplwN77tI6+3mdTb8ioDE5DFMgSEgK9exM3OGesSfnO06VmJEzQgNNhGmHvssuzFjmZcvZbykejgIKmV97jrlJi5jtqCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cc78077032so340523439f.0
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 04:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713094023; x=1713698823;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eUbouy2oNNu8eN3BipV2iCaoziEuCexrXqKmN558sqY=;
        b=BtC3hRwSiyR7ZYGKdN9yht8A2gzDoq1PncOd8BI4b/1S4GHLktPycJ7CyPUSQmQYpi
         aLube4EBy/iMIOTJoAyrzBgmVs6+G2jPpOCyIG7MIPZOVAS+H9sLFjcNgDjm4HelSIUh
         sjrYQ2mLHTHUR5pq36T/QYxnIQiGzcT3LftwQLAdMBz4pPlWRvGDEe9P1G5czHuS4bAi
         0sZ/18S4hs6NpoXhihUnBaZdIgXXj7ph5Pw2RzQQkfPXpLDodaVDQl1FvfOt7WR0/7Ps
         yFdzAdHDil/M7HoDRUOKIEFnRlwRkB/1m6DQvuGu3wBCyH5JYlVeBXTryRz/2qMIGsU8
         2ZcA==
X-Forwarded-Encrypted: i=1; AJvYcCU449hwNP2QT0ii0rz/vv1EaYYjOUnef19AbnZBMKASEl+JV4fuS6PS9RA071TofBmWOZdOA0po1MKute6IDwKBb4sRvwEjkemcvoFx
X-Gm-Message-State: AOJu0Yy/8BdoEdRUFi1Sbww9tiJKnKK0zCuUOxzWb+meCSZn0L7/zyyp
	+233g911Wwae4Wl0icm40isU+dJUEeG70DsfHkhimV8wJ1g2o+hPRsgMLY8FEFTkvpKWz5PZTl1
	6uj4yiYtawgww8a/KyAGPZ2DavoC+vKBWsImEd6fAHga3Emh6/blq8x0=
X-Google-Smtp-Source: AGHT+IFZDqxjKodW1h4BsIA7GL78eyIQ+YTcgW+REk2q/S/k+H1pWhRuNWDz2Uf16+r7Ik7nCyICQb7ZyZRvNx/3SUwu3TkoLjHz
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:40a8:b0:482:ccc3:e7fe with SMTP id
 m40-20020a05663840a800b00482ccc3e7femr259144jam.6.1713094022920; Sun, 14 Apr
 2024 04:27:02 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:27:02 -0700
In-Reply-To: <20240414110952.2437-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b4106c06160cc803@google.com>
Subject: Re: [syzbot] [pvrusb2?] [usb?] KASAN: slab-use-after-free Read in
 pvr2_context_set_notify (3)
From: syzbot <syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com

Tested on:

commit:         9ed46da1 Add linux-next specific files for 20240412
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=177851eb180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ab8f5778cb7b9a7d
dashboard link: https://syzkaller.appspot.com/bug?extid=d0f14b2d5a3d1587fbe7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174c9857180000

Note: testing is done by a robot and is best-effort only.

