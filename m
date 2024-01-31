Return-Path: <linux-kernel+bounces-45973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5284C843889
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83FDC1C25725
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7FD656B9D;
	Wed, 31 Jan 2024 08:09:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BFD56763
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706688548; cv=none; b=sRhHPvDBzXm80SY5kiIyKWOOpMvmutyhkMLLrzGyH52kyqCG+eINu3B2qUwJIO9emxrg7EcjKtI8v6PHWodWhLtUixjFCnLnsXe6/OC3uJy08uOlVJDQDp5pCjQqup5xVgvAhkwuLy956Tdad1GCRm+Z4+jbGBZycuUFsbUrdgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706688548; c=relaxed/simple;
	bh=vlU+av4tow0au8BzN3BT11hR6QdXD5/0HfkC6tBFjTE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=eeTLAPKDN3jhaVvmWEetpXASEQwJFL21ppRKJU6HVej76MUPzDMUb6WUUHuLqOKO9wgFDslSLeI95n6uqirkXdHVXfLCKz+J+y4YXmFUFS0NwOybrnNyoH6OogIp0vH3c1OIFpGOHqSHsr2In2uMGYa5eaZy82mHsfKEeZykkcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36382780342so18494875ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:09:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706688546; x=1707293346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u4Wy0NM/M6DMCkFNLkyI8/rtu9Gqv4i5j3N+Dxkh9ag=;
        b=vzpB9K0j1P8kOjxuj6vHFNhUov4i0ME/zFIM6zG0ck9/TbvNiS07HQK3EeWnOfAjZN
         TFMrIaaI1Ss6R4Hm1uFlOOLDn5RhfFSC/S7NnVlzBaLz+Xb/Zd1phjMH0ZZcJgWHmLjs
         1mDhBdRTve8iioxKTbfQWUvHEBF0/MlgJ7NPaQd4BGzpcCy/y7V/yS+CqZmJFfiSrqSn
         bz3Z38lAHh3PE6n7ip5etzAR9fp3E2Grt/6V8jwn0JkQCzCTMy1rh6OUdnlbK+K2GybB
         FJAp1KoQowAgMAMGpfImSSwyH/WWIOkPTSdT46UJicAGHdtyvAJgurxYgVhbHG7NT+L5
         vyvQ==
X-Gm-Message-State: AOJu0YxjjVoJLSyp+d6knroYvaAn8rzOIEgdoqnCSUcxF6AMRxGCKCXG
	B0I4DWZZrJO0JLoz4lFKngAHa8nAXDuHTGpkrEQ6ZxQJFxvFZqgZN1hXiB65yEsH7RLSvrYYCXs
	Dea75CDx82hjhBmiwpSS+bf77QVOBzDH/xneq9Deng/mSHPh/olYF+Hg=
X-Google-Smtp-Source: AGHT+IHNZOS7TTu4x5H0vJ96+6rHym+FThJ1eC8lGyJnjUrKOOEg2BjdFSpw2famcrGq5UAyczYpwwNYlLtFZXsfD0uP5Llr9Z4u
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1544:b0:363:96e6:1206 with SMTP id
 j4-20020a056e02154400b0036396e61206mr80972ilu.6.1706688545983; Wed, 31 Jan
 2024 00:09:05 -0800 (PST)
Date: Wed, 31 Jan 2024 00:09:05 -0800
In-Reply-To: <769c0c42531eaa64fd5356c2436fd2aa054461cf.camel@oracle.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008693060610396480@google.com>
Subject: Re: [syzbot] [rds?] possible deadlock in rds_message_put
From: syzbot <syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com>
To: allison.henderson@oracle.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f9db6ff27b9bfdcfeca0@syzkaller.appspotmail.com

Tested on:

commit:         7fc83268 net:rds: Fix possible deadlock in rds_message..
git tree:       https://github.com/allisonhenderson/rds_work syzbug_f9db6ff27b9bfdcfeca
console output: https://syzkaller.appspot.com/x/log.txt?x=11f92e1fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f6611a08d8d2621a
dashboard link: https://syzkaller.appspot.com/bug?extid=f9db6ff27b9bfdcfeca0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

