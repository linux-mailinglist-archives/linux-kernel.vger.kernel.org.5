Return-Path: <linux-kernel+bounces-36391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA1D839FF6
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 04:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE64228ACE4
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 911AC5392;
	Wed, 24 Jan 2024 03:13:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C756A1FDC
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706065988; cv=none; b=fVUFwTQ8CYJ/7zvW9AHKJCQNeYlfP24neAyOFCTTX4Nc1oEFjEz6KvLKzLa4H29VSyFupIFUqZUNCyiKh4QgGhA8cJn0ElB7A6sbIAKjFrGzZYvpul298rtLBfA3D9KBWp6a9BOPUy4L8RgXtjmcPs8T/Wik91pppmA6gMYMAqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706065988; c=relaxed/simple;
	bh=w01aMp201H6VWZNQ37i2iLMbZxPXmWRmhch+jUDgNkk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=WaFpX8pJSYfVEXnQWbR1I/rfaxhljF6zEcWEU48lCCjKrxvndWwedvxK4cBWOenDPLntj/ZYDwE+3tIx5bTyUtveBnzz7o6QB3Iz0dt9Vqg0yTcVw2CgBBPgDIWTf9rHxMBhXVR6BCA6wq2nFMFuSw6Cci3dB9eKTf2b0W00PRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bedddd00d5so410846439f.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:13:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706065986; x=1706670786;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ChLC0C/DZwwNzt8D451FXLemj6J/mBxJU4hzpYjiQSY=;
        b=jdDfpKIVsSFFuK/MnjHBKqVBmIEaJIw7tZLlsej0/+EpY9ZZ4XI3OrcYHeBVEdS0cx
         TcfEK7J49HxcNBEgvgo6ujJqnRF9PC5q0rxzOI67k0OOTkpQTYwBmQLQN8uukKcPteCi
         DfkjFPgyNPhpiBZ5rNH0Nswy2nSdCN1N8UvZG/qCJvAmIvBiSTl+SWsDmMzuwwoJuAxB
         Pjx9QolHRe0XKUGgGIC+YmXjJOJ5pSRI+BzyfEsjhMAkF+lvBb1I+3Z8tILb9AGQ9/CQ
         WMLGIQMj+xvBNugfYGp7ck1VX32+EnsojxJv4R3Ze2ePBp8wcST9yD03bEH8HrdUDps+
         szqQ==
X-Gm-Message-State: AOJu0YyqfSy28eJIATkRtifQRydkmMF05F020Pi7Sap2cqa4eufIPoMb
	ZLFs77k6DdukbBCVii7YIqYH3swxAD37DC+pfAY3g0ryQ0GglpzHTIyPi15YESoy1a518W0aSAT
	WULKsH6J/Rnywm2XLx4n/ZET0ZSkGdlQWUCUFMR8OuXJ82hyiuoaTj08=
X-Google-Smtp-Source: AGHT+IGnhA04iRpv01odYyOpQkc+whytR4BuVv8gSP+mg9ucelQToolvhCL3CRWmvHV4wtE0T4vA2cmWn0eXdh3b3hQU1qfttzsA
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a84:b0:360:17a7:d897 with SMTP id
 k4-20020a056e021a8400b0036017a7d897mr77474ilv.4.1706065985976; Tue, 23 Jan
 2024 19:13:05 -0800 (PST)
Date: Tue, 23 Jan 2024 19:13:05 -0800
In-Reply-To: <tencent_85364A4A447431779D67703D19366A97C009@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000ec514060fa87179@google.com>
Subject: Re: [syzbot] [jfs?] WARNING in dbAdjTree
From: syzbot <syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+ab18fa9c959320611727@syzkaller.appspotmail.com

Tested on:

commit:         615d3006 Merge tag 'trace-v6.8-rc1' of git://git.kerne..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1455ed8be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4460091fe9fceda
dashboard link: https://syzkaller.appspot.com/bug?extid=ab18fa9c959320611727
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=171ad715e80000

Note: testing is done by a robot and is best-effort only.

