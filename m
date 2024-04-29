Return-Path: <linux-kernel+bounces-161660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F9B8B4F1E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 03:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE91B1F21DA4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 01:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E6C624;
	Mon, 29 Apr 2024 01:10:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7587F
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714353004; cv=none; b=ph011K+QzgDhD3gi6ET5eqUknJc75O2PeQig/PehthDfHhMGU5NSS7IqP1bmYkwwcd+zfOLuTienklNRhzuWoKl51sUCIeL8ZyJ7yAnYpMxWjMqzGinMth4b5VvCHaW5BLH53VkeSkfgxNq/fcJfTAbysAiRORgKLb13cAr+xa8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714353004; c=relaxed/simple;
	bh=vrSQTxWBFab2Mboo9C43dx/oR/DcLbQlMKsI2BCX9xc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TW30gxbX7HIOEfx05itq2ZJmBLpGy0S4FJ61o072UNkJHXfW3BvXh2uMkiBN6k+ReD24hL56JVlPns7X/HFC5z380yh/k6Pyd9CdvDDeF3aeayvEVrw5LlELMnyxkL2rVutnboaT6XxQlNdL3q2KtFsej4NAl8fLcKVFqDHujIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7da3d17a35cso423562039f.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 18:10:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714353002; x=1714957802;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T1744AvMemfGe060IOAxiA57Uo8IhwgAsilqKUNvK8Q=;
        b=f8faXJr/kS3JE1INGi1sIxysi+iN5zYo3PwAbiKkwFI9bmfWQfRZB3qvjmKCq1lsBi
         2xNWWeoJwQxfB8XsOdMlC9ZPRUKxxC23RsBDl+uQP4WySKCMtLaeR5JNkcyd09CabI5X
         k4uX81riW07F3Nd4QkgFbXYHnJZ3OQEgaYG25DJDoV/NEl5BJEDx5lwIk7v4OZax7Srq
         rDpDsqiLb2aZZbHhDAcTdg75YkBnOPHpyKBlsTQZAVPkUGlOJ5PNdMM3rtu1102i/X8K
         i+nEVW1pG4kkEbYSBM1sBwVPehkZ5+Wc2CkCxYJSPsabqQdKp404y/o4sSB3M+JsiHKh
         Pf1A==
X-Forwarded-Encrypted: i=1; AJvYcCUTeIRH3JI2xZSWTDcUOJYMuLnq++yY5HNCWytSxUNd8QRPX+FSgLBQosumOLtTwqcBYcgzp8oiMzd1iO628Ahd+uYz2hTgfthhomUV
X-Gm-Message-State: AOJu0YzlsjmzaqadhDTG3m7islThqmDOBdnS+B5R6fC6IGBCzBxfIiKt
	PTwLslEQN4vDZURiBlivL+nfgj+SPm7dvwdYsU14NqZfY4EOU3lglD95BfU4bs62M3VBpF9YbHC
	KszK5yzODpaBDrHboUiz+02dp6XDAvlZg68NGMLQEqiwVtSxIaWUauqM=
X-Google-Smtp-Source: AGHT+IGhfbMIkHkX2tFFSUs1nSKn3JTchoSURqhzyYPQq2YNeeu+MYjLUilTLflItXHpTrWTV/N9eDlDn+Z5QZo1T6jlHa4oAkqe
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4117:b0:487:31da:eaf1 with SMTP id
 ay23-20020a056638411700b0048731daeaf1mr527811jab.1.1714353002758; Sun, 28 Apr
 2024 18:10:02 -0700 (PDT)
Date: Sun, 28 Apr 2024 18:10:02 -0700
In-Reply-To: <20240428234240.4096-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bfd87b061731e96f@google.com>
Subject: Re: [syzbot] [bluetooth?] possible deadlock in hci_dev_do_close (2)
From: syzbot <syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+c55f7bc8d4809b2bad59@syzkaller.appspotmail.com

Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1459ee9b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=c55f7bc8d4809b2bad59
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13483327180000

Note: testing is done by a robot and is best-effort only.

