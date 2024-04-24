Return-Path: <linux-kernel+bounces-157849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5564F8B1747
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:38:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E9C221F21E7A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:38:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED08416F295;
	Wed, 24 Apr 2024 23:38:06 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB702901
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714001886; cv=none; b=FS0osMVV/44F0PH7OdtUwR74oq1emiXCtMjz6z1nwpDzMtGanvgEsO50jfohPD3z5CbmUPXn0YSB5H9tYdTauHSEUi+Cj8yJn/LXVh7/LD27R4miFYxcgabEPDVWySjuHpfidi5suU+lp2o4UK28dtyNJHMAO7fAJw7aVg8X+vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714001886; c=relaxed/simple;
	bh=khVCt5Dog1tiLOXWDJgREu2x1xVSvY8rGLoZBrpEms0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=AV0d0L3ZLQMNrYwLcc+F2VzsGvUD4FO6uOAwz9L7BWwdSRZohPUhNhT+OqNHqtfGE5R28eC6kXxkgEjKbL5BXoZJLuNM5orFkoG7Ro2VdDGP7LoTSJqIrUbRZ/SbNuI/4DRVCxsEiH30aatvVuXJD5vA+YDNMCJHqHSs5cjGdFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-36a168177f0so12108995ab.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:38:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714001884; x=1714606684;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kcaB+Da5NKS4slkBhA8BS8DXtYe54xoXMCS2AeazuGs=;
        b=Vif5GLj7r4ZS/P+k48zrCjLCfIMJZ/TJymveyrW0xbc6G463vhOkRi7L47/F6TmSTZ
         qFIV2jpHFWy9GKOqUaS+8c5an8EczZq9JBoq0QvU0gkFpUdLFF6q6mG8z3gK+7lVZsTE
         UOGQP2/oOeRvxfq7Fze1OylbfoyY0YzMwlWZc+QYaHtWy+LiasK/RJHAkfeVE30k6xbh
         VZ1BLVdcIxjbcGzaZ2XzKW+eq1gLe/WOWs/hBh8ah8j4spD1lo9IN6XyPySbWC4fGtzN
         9ekZ/Vuc6sDn+4JUy5/D1Q7hBKrSUEdgrWF2dUaGFs1OvdLLx+wQodE6elYjzKF7Uysz
         bGQQ==
X-Forwarded-Encrypted: i=1; AJvYcCWlCqr3IS+g2CpWclDfJmCppKEhoAkb2J1R45Jj+89JLWcmJtb1oQt4hJ3/znAWO0NnT1Gj3MlUWlxfn1l598a400PnZVffnjE2V6Rc
X-Gm-Message-State: AOJu0YzIQBb+ItAF57DgGWdD8gDV3640InoNhWZjfqOgUV0kYUC+zFEi
	8z8pq6YWxaVGtrhywu4f27Po/rFeYTvTbGIAIP/djwyiqbUj33R4kxYgTFiiRXws0ukXVgtC7Ew
	ujeFSnW1//XUMfcjsM/B42mVRqGYjQ2ay6uKpMsodu/Kaa41+z+rb38Q=
X-Google-Smtp-Source: AGHT+IFRQDKzIQMldnn3lL3gptJNnkTuljlosUzewjv5tRaiA2dPnlAZeIJvN0manq6Lv6/EIceykVRcnZGJnDX9SYgx1Hoocrp7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:50b:0:b0:36c:2357:7ad3 with SMTP id
 q11-20020a92050b000000b0036c23577ad3mr14063ile.3.1714001884380; Wed, 24 Apr
 2024 16:38:04 -0700 (PDT)
Date: Wed, 24 Apr 2024 16:38:04 -0700
In-Reply-To: <20240424161201.147150-1-aha310510@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007691c20616e02945@google.com>
Subject: Re: [syzbot] [hfs?] possible deadlock in hfsplus_file_extend
From: syzbot <syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com>
To: aha310510@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+325b61d3c9a17729454b@syzkaller.appspotmail.com

Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ master
console output: https://syzkaller.appspot.com/x/log.txt?x=1533285f180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=98d5a8e00ed1044a
dashboard link: https://syzkaller.appspot.com/bug?extid=325b61d3c9a17729454b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131f0927180000

Note: testing is done by a robot and is best-effort only.

