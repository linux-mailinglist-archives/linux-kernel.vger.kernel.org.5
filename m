Return-Path: <linux-kernel+bounces-129520-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4E2896BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 12:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC8361C243D1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D046D136676;
	Wed,  3 Apr 2024 10:16:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF6C135A68
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 10:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712139365; cv=none; b=V4twE+S2BKYQqScx+HgTlSnh7bFmPGt/IWCJokfVOZsQ85mL0tFGZgRj8OMct0WCU0xVYxPO/xoNa8qV2IKExMprZ7LVeaiza+aTljwk2v9SwH8Wt1RbKFuQBY6HH2mJhYpnoXOEJ4xqZAqlpDvvbE+2WDHnqGl81juB7GCamIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712139365; c=relaxed/simple;
	bh=0m+mEBkWM2xkYT6T032qq1g6LsT4SgFckX7jIzdWo8o=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fc/pFMtQzXJ85y+OTwRdKVRxoIgBdMHump9aaYxOzQK0AyruXTM5azP2XCSqLJdYYlnQ2g3gguwyDvDxOkyqOMvnNep6NVO1qT+volT9/FLTmIAC+5hq7jwzNyo7jZEk7VIAk3OzU3DuD240lEZcXYm5Cxf0dPW9NaEdYyIFcHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cc764c885bso691657239f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 03:16:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712139363; x=1712744163;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/wM0KdPD3Vm+wRioEoDYjHtqAGzPDviPsshBrGrOn4=;
        b=sCxL+xqWG2W6WD4FZeEbvt+/40fGtneg2ma+YYibxCpo3zQRdvKnR9eqLTI/7dlr/Z
         Pq7ozrPnCGrzoD/7FVkIx17KVsCVAQxDjQ/99Iyr3xiY+KrM2kNJ/mqJtyADTa439QUd
         PhC4vecH4NBdhfUg+nAc/t8wnIHZUA1JktOIZhnqVJa1EON5GGAuMjvD7oGbGZsUYw8J
         k8VvkUrvmS7edYV3zbLh3O0RACh6AKXO+j3WxP7wLST1vwm4w8WbdL2Vnhi4LjqlzuaU
         CrQG2k8MYTP4asD40Jrwl8ZLuT9RZdHNjBRWm8SujsAkQpAZ/YoLmLvU8ShQEUSsTX0f
         +XKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxmypj3lW+nW3TueTE7DZoGDDXRSkDL1+FO051CkVvArHgJ2ABgBqeUbWB2LocSiH2hJHLDuV0N3g3X95ggY8JaBfbgTPzVm+wV0TF
X-Gm-Message-State: AOJu0YxperEEvNh+z/mftl+ReyfZFLp+N3OStknnnlqzmLWKEcFoEEaB
	6aWGkXYLQ87QWLqKBeMAUUgwXBbvIM/vT84Mpi6mqKOKGYIrnllves8/9+H4lkUyjFiUxWGd9Dw
	Q97sMhwaeQ9tr7JnWIiVBScQ5nJylOlSRYZWesAb7Dl/5jjT8MCx/DFs=
X-Google-Smtp-Source: AGHT+IE9rdCcPpwH0d6m6leYvMgeOO+n8O8d5yy58DVGmQh6qnpHbPCpakQGV4SHifN4m+5scYIBrdnjfK8auUqA99EZjweV6AzM
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:22ca:b0:47e:cf59:7f48 with SMTP id
 j10-20020a05663822ca00b0047ecf597f48mr739456jat.0.1712139363188; Wed, 03 Apr
 2024 03:16:03 -0700 (PDT)
Date: Wed, 03 Apr 2024 03:16:03 -0700
In-Reply-To: <20240402130040.3715-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008c948706152e82f7@google.com>
Subject: Re: [syzbot] [mm?] general protection fault in shmem_get_next_id
From: syzbot <syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+05e63c0981a31f35f3fa@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12cb9d29180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fe78468a74fdc3b7
dashboard link: https://syzkaller.appspot.com/bug?extid=05e63c0981a31f35f3fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1156321d180000

Note: testing is done by a robot and is best-effort only.

