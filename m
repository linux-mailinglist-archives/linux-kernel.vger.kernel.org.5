Return-Path: <linux-kernel+bounces-130789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06800897D1F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 02:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3846F1C2158E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 00:34:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18D7B4C7D;
	Thu,  4 Apr 2024 00:34:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 486823FC2
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 00:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712190844; cv=none; b=epphVvoyFw38PnBEn57aLVFHdqN1vjClAwA0L3VUyke5kerX0DgbL859E0cRjaeCsc3X5de4t1ULvTZyuZGfv4iEct/7p65209StMRpPCiT+m31Su4FstEYFyAndVpApdTM/rymcCOs7qBgXw2A2pDpoWYAvV6DGpvQ3Q3kBKKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712190844; c=relaxed/simple;
	bh=0UfpBIxWC9yUYf3SIOMzb9XBZY/TgJbRwSIHErPnzrM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TChCk6PhJ/SHg4AWkrkKaCichH5XJoiyefhSla5DTYoAy7T3ts8mVsH6rpCJHcDvphTsIeQNtAdo5/5GgxzZs7dzbuuocXcEDDQW+lNwJ8zunUJS97M8omcbjPie+deWL2ejzCcckGp8AGu4fGopALiVLf68jAIaO7FhAXTxNG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so136554839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 17:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712190842; x=1712795642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/oQDMAVsLvFPsJ5ZC8wEiAzk5lvfhtBZeNZiS4Knl8o=;
        b=dOF06qCg5JGa9rS6WQT7xILZArcavnZFhXPwQ3y+cfi448h1EZVhxZ2WgUW0rg1sW1
         V7esMNNUHL4ywUmbbjLZJJXxdY/6oqq4oglDpZn3ZlAo9WKY+xHiD8V6gl2JSoqo2R4a
         UMu3axX2QOfeO3QzNCr6gbbE+3FP6EyVljycwMSa9b36ZPo1Ajt9c4hyELSLUVng1hm5
         A60WqOW6w+xWBeMhKLdhaAhzZIdgB8Ym8txtgiucL/SnHALiDZJiiTdxVq/01Ylr19Hp
         5jTjc0OUQ7GW4SYOqbvgWGZJRToQusydWHkqNVX0Iz9YbkgztIk9rQvTc04tmBoKm9dV
         s4Bw==
X-Gm-Message-State: AOJu0Yy8Q18uXbo8vzrsBV71KXkC+Lr3DNki/ssXue9UMJTTP/t6sTD/
	OXCUnKVWZ4kEtNU7bGzr+MPLgosCeSXYtlKNrBU104o67LWbcR14w6tKT6xJUddbNV1MGEcevwr
	z4g+F/wvFxyYeDRQpb1qvPisURanTVsHo/YB2YNO2LbzdhHYH0zMXV/7z6g==
X-Google-Smtp-Source: AGHT+IGvT52j4/eiJKYb7yvGZx16MZl8BVmh2LNiEDsmww+rZi9UA5wGaulVgxnCx01hORRLDMTAbx0oIuWaHvrcCDfa563pgMO0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d207:0:b0:368:8597:8292 with SMTP id
 y7-20020a92d207000000b0036885978292mr41796ily.1.1712190842436; Wed, 03 Apr
 2024 17:34:02 -0700 (PDT)
Date: Wed, 03 Apr 2024 17:34:02 -0700
In-Reply-To: <20240403133301.14177-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f3912806153a7e4d@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com

Tested on:

commit:         c85af715 Merge tag 'vboxsf-v6.9-1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1612eea1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5112b3f484393436
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=174fdc5e180000

Note: testing is done by a robot and is best-effort only.

