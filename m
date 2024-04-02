Return-Path: <linux-kernel+bounces-127311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60F7889497C
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 04:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD80F2865DF
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECDB1429A;
	Tue,  2 Apr 2024 02:37:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E4814005
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 02:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712025427; cv=none; b=I4o9tdsw17ju1xHfzc30qyymmYTWTTlhO2TQLqCBZ9KYIhlkD/D/yRbqYWKHzbeiZhMVg82EdLe3X83O3kSKRacHqH9yzx3YkVZ+sJ/5jmAHtfGfZeyIhCozHjXuJQlKWLvTmpHJWKav6R3MeTmzBR2XlDcaln7sVmum3WM/8UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712025427; c=relaxed/simple;
	bh=1D8Fcx9I2niZIgg+ny98cxQ3N3SAIb9PluzfNA8g07k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=feJSkPX4QOgWgZaRQSh4Zgn7k0bCPHZDkNRBhW4+0+cZDyVUDkch2iVCk71AHetnTm3G6nyUc4eBXwnkbpA3PpdNkc0B4RaX8u7hn/QjmDRRIEa10cfuNYGbkhOu9pouUfbDcjLlDajI6EhBTCLJYuos6XpRg2hmuGmd+8vEtsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cc012893acso503827439f.2
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 19:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712025425; x=1712630225;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYLqAM7NIoIIfW5ZL4tUtzxk41h0VIj7EelgtPa0Wn0=;
        b=i1tZqBSJVoix12LaD7+U1V/ptOQEKw/LbSNb1YpkWnLialclEQqSdwaZnKTI1V3OFG
         xMxrM2QRLVSXp/iRQmiNvzc4HXshAhPKoo3FvC8VBgNhdhfCHAxqVevqBkMoItVFIMPz
         8EwS1E5LJZKVWs7E6NXJHDByRDjgQod756i6BbHZcY5tINvmgMtzombxTKOwu8O6FRp2
         zC5oJCCPwUdhHpvXZwmc15cdrkWleKc5DzcUgcldYLbZcrAQpQLU7wGUCk0RT36h3MA3
         T9b/VsCxxdvcEwjHDCj+y9bJB43pey/TywCYtoerPNJs0QRDKn399WMEjCFYtJgEKB5D
         O6bA==
X-Forwarded-Encrypted: i=1; AJvYcCUWRIX40O+vlfjNNk0o16cC64GUF+5p4DG2MqYeoeGEhszQQ79m7cCSACUSxTjkR6yt5ARtQFuAWTS/yZi+RkepOsDqjETsFUxzzCap
X-Gm-Message-State: AOJu0Yy61dt+RZ1P8QPy0y8z/4kqeSf0Ft6JtAVwxTh679vQ7plHpmF6
	4pUFVWPJswaXtf1S3zy6jpEz5rY/crejSo/yeCkiCot5t5erdtq6nAdT1KSYsgrhz/0q5O9EA7I
	9vN3xFc6+fEAEsriJxmFG+Mr3DQZd0fpvd9+aRATbqHw93XYQ3+Dmyes=
X-Google-Smtp-Source: AGHT+IHIqa+z+yjGrfER0ApYASlwuw4R8HPLGCxlrz/aag61j35+CkB4JH7QINu6wIwjQDUmA4S8hih4G1bGN8WTiRQCHSaicC7R
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6b84:b0:7cc:39c:143d with SMTP id
 ii4-20020a0566026b8400b007cc039c143dmr394439iob.0.1712025425431; Mon, 01 Apr
 2024 19:37:05 -0700 (PDT)
Date: Mon, 01 Apr 2024 19:37:05 -0700
In-Reply-To: <tencent_5E797A6E302C756D0494D4EAD2EEAACDB40A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000545ee1061513fbc9@google.com>
Subject: Re: [syzbot] [gfs2?] KASAN: slab-use-after-free Write in
 gfs2_qd_dealloc (2)
From: syzbot <syzbot+956651316bb16496a837@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+956651316bb16496a837@syzkaller.appspotmail.com

Tested on:

commit:         18737353 Merge tag 'edac_urgent_for_v6.9_rc2' of git:/..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba04c5180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f64ec427e98bccd7
dashboard link: https://syzkaller.appspot.com/bug?extid=956651316bb16496a837
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1542365e180000

Note: testing is done by a robot and is best-effort only.

