Return-Path: <linux-kernel+bounces-109362-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AA714881810
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 20:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE041F233CA
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 19:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D23E8593A;
	Wed, 20 Mar 2024 19:42:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC7A8592E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 19:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710963726; cv=none; b=tA+6hjxNrMD3ltvuZP6oPIJiOpZvWo9rlMWchlheXN8s74ijf3FUxMMFd6HBgQg9+yWUNYL+j/1LyZ5gZSHsDNfvEHClGGWchutToXJKm06lPFbWw01CAOyD5FhqrtHT3tMYLHmBNCT2tzcHkG/YcBVOAqnwpVp1Xuo4gSlGLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710963726; c=relaxed/simple;
	bh=wj6GvVE8NO0a0MF8tvqng9uECylE9Y6Bt0yHJ+OVw38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=tOi7JubA2SqCfQNRqHQ3j7VM54HyFUF68B4RdiV8nlvSDVFLq8QkWXoBZG2NcHn7QPWvAfNieIKYe01f3GzE6ZPU5Gi+bk2uvkEXruHDjkb4frCG7tIs5yioeVl8ZUEnpBXndFdLvq+gT4jmvXDO+DL8eUc4qm+8/iIzXcG4WrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a98e52b5so16305939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 12:42:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710963724; x=1711568524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oLPLG9indD1Y1wzuW8DkBusPmLGDoOY7ruOXngc5dKw=;
        b=Cn574pBkfSunqdAxlyX9V6LbYBriwLKo1HWNr2Hw7Db4U6CwmTR/rvqREPKN4JZRpQ
         o3G+J75Fq7IFv55MglhdZ8by7yW1wZ+sJccnGZxsChVtI9UrIgx5ZGSLrQFTYRE2T047
         gxtuMO+RynbCjMzDm8aUoQfoVdOQSDHvmsvamS+uf8rZiuVWr9wmQy9jsHByID7a8F65
         KIhzk4z+2Wds2Jri4Dm+7RQKFreE5r5oLcXimjc6wCgK/xqbstyYjo+nWHJnHUlne+LI
         C/wZ+f8pkXas6EXMmyyUKuC/Tfq3OSWKC3pYBvC5e04NdGmXBszigTKrNeiCKODV17rU
         yy5w==
X-Forwarded-Encrypted: i=1; AJvYcCX2NtNNyV3FLktwCjxHdVV+/KN9AXqoeRdaCtgYI9s1UleSeUs3o826dMdzw1psrj3BpQaF3nL1CwCgHxgrqKyKAtNdKpZcsrpUmI+9
X-Gm-Message-State: AOJu0YwSIK9hXtQvajLlKsgsBXhSfZlvnShapXrELzLpovIBeHxh3nAj
	yRCtiW7q+LB7lhTEXasM3Tg1QhDfxikO6mWdPHOWUcFKw+EiGYGJ5ZA/ZaaigzuxlA1f7ZZ+YP0
	GeedxyNf5tYLqeNV8xHAFj7GfhTGqcU7luChFpsvurlXYY9tzKdW6j1s=
X-Google-Smtp-Source: AGHT+IEWqxFg6a8hezopCgcsjZIIqbqntAazswVd1Z2/EQPXsWWDcE64OFyCfFiDhuFISDHKBrALikAhhH9iVyiAp8ESeI6I/Kqo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6412:b0:7cc:2522:f5fd with SMTP id
 gn18-20020a056602641200b007cc2522f5fdmr384717iob.1.1710963723919; Wed, 20 Mar
 2024 12:42:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 12:42:03 -0700
In-Reply-To: <20240320103224.2123-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcfa6406141cc8ac@google.com>
Subject: Re: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com

Tested on:

commit:         32fa4366 net: phy: fix phy_read_poll_timeout argument ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=174f8dc9180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1600783a180000

Note: testing is done by a robot and is best-effort only.

