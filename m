Return-Path: <linux-kernel+bounces-100320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 768488795AD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C8E71F24FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:08:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C26A7A72F;
	Tue, 12 Mar 2024 14:08:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BEEA78298
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252486; cv=none; b=dJye+u2e5r7wJovXc4TupUACTaOlRfaS+GdRdR+E71pFCJ7akxcmrtQvOIYOrLvcUsvVSNe5vq8UN3r0emCFPQBt4xp0VwyDGM1WrQw6XtgbnBBjVq3yDDDRs1GpscNJ7nwHruWyQJyaxHzNYAXvwAm6qQ3jAjx6UocX1bsIyT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252486; c=relaxed/simple;
	bh=HHVDSFp36ZnZErKZO9wmMVy6SRsc9Fju0AWIIIYPKSk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TKxrgpmetc4AsEETo9OJ2tladMPxkveH/APNkJlsCTELLPMftiAIHHJiJgYD3O8XXGyzyRaYu2vQMNql8GVdTL5lShPr4EKwhpaRBm4Q2aBt5kJ6kUg5ZxHvplnsKTReyhfiJTg7Yoz0YAYd/WCHrf714ZfskFz4KMFsyCl4rdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c8a87a58e5so304455539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:08:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710252484; x=1710857284;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CRxbYyAl65YGCI67bVSRKMZcJ777VEo8CqlNScBoQqs=;
        b=C2xRzaIZzwb1IxmfRdAnHFTKelcbEJqOstIscBNDqp89oirnudwlsQKUB4nVBbQzAd
         jWFBFBT3MKEGU4H4cXrZ84UX1BVUgbTnyEacaO9S3oxGsMMBqQBjP7vDWROFKB9+O2Yz
         ol2CGuxjvnypcTLvH2docnpFLMCMWgOgnkdg0k9SLIvze72hImmhou4HvjOB8uEjm+FF
         vA7zJDS8f2pzvFPdHZLo6gKPB/6ngWUzuDp+hncAKTxrytKXUAxt+RPrkzam4iQDXBpK
         fnKIyZSeVJDcZUzNn1gDsE4E9kDTPYdd5gikUhSIoXSLaTazm+rWs70/rKlU4HqZ2E1E
         5VIw==
X-Gm-Message-State: AOJu0YyDrHeENsyKomW5z8v5ZXiYTVQbYGOvsuW++wCMujolk2FgR5yF
	289R93mMjnAwhvChcMYWHOe8YMFzPFcE5z4C84wVsh5VxizIolKrBOPQPnt77xRqsFFq9FKY5lX
	YCY1/QK+Y7o8ASJGnzjVx2FXy/t6e5K5GLMcCD+IR3KBgm/R9Mci1CHQ5hw==
X-Google-Smtp-Source: AGHT+IFIwSTCU3UVGry21b/AXH+QRACbvZwjrdsA5TJxonFxftKG/2wmtwt125G5mhHrX3vEuM08OBAWFvb4epFP8/ZIBqbWbnZH
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2581:b0:476:e064:b02b with SMTP id
 s1-20020a056638258100b00476e064b02bmr407170jat.0.1710252483815; Tue, 12 Mar
 2024 07:08:03 -0700 (PDT)
Date: Tue, 12 Mar 2024 07:08:03 -0700
In-Reply-To: <ZfBbcgv4PHg7SojP@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c640a80613772f82@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_dev_up
From: syzbot <syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+7ea9413ea6749baf5574@syzkaller.appspotmail.com

Tested on:

commit:         9f8413c4 Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=127fa91a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16060901180000

Note: testing is done by a robot and is best-effort only.

