Return-Path: <linux-kernel+bounces-59103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B6E84F137
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 09:05:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5FBC2B22769
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 08:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD465BA7;
	Fri,  9 Feb 2024 08:05:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C66B4433D8
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 08:05:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707465907; cv=none; b=R4LLeUs+0o2jmHQDoG/3LLU9AkqB6q0Kijl7lnJoYrvPJXXSBjXftS+izwe/huM9N3H6HW7IE2qxVS/wRgm4UAGlPByk6E98QyThtm09hO1RXpuYxuW5sYfJcsX5PiwJNq+VOSc3WDVCM6WLfGwO8TheCI8MFbn78LvlFjPDXwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707465907; c=relaxed/simple;
	bh=ofm/iUYQqJ6d1CEgqRkAoXITLX0GB7a1/5llOxoK6Uk=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=fQOX6V50zedevEiefMPWJM2o13ZKq/RMGADoCO/a8vzQSq92Ku1K524Lm8LtxWdX5TV0T5CUjs8/EDVzqgvnfdLNXBJ5ucd8giAdMjOgXnWENvW8aKkfei5SF0BnXZ5qJVHPZdrQtDGJZa7wRH5fMMO6mTsYYeBhKHubAZb+OT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c0001148c3so56601439f.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 00:05:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707465905; x=1708070705;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bW10+HuPJ3VD2u87S4kbzhAx/2XSi/G48i9rbMqY774=;
        b=WXM1LFATCADT/9zwzYrzBb6OBIZ8lk/Y2j9I9dBrCfADcpnLt7uaIzfDjAtkDzK4m1
         cXCKfDNvOA/PRcL/yIb0xNDiecLbHXB3fbCBJauJbZtuAFq+YCqI+iEWFUL1U1bBW56s
         Okwmi+8SbR4SzcPoHs/OTfCcDZeMQAIVn0RWHt/2NRF/v0rLUozRSofY+XxBiy3EOJxQ
         CipQEmtBK8KItIq0a63sbwxEfBTPx/Jy358DmZGieLWSF0s9D4gVHwSbtltNOnPhAoDQ
         /Okfyg5UJo2iyvCOoATXBnH2hSxJleRgOgIbcwGIzWENorLXbrwQy6vKbPURVdGOusxc
         RsRw==
X-Gm-Message-State: AOJu0YzfscdBybtA/4sGLWECZ7JkFfBKGdLTRB+Vdb+vNLEsProJox8X
	3RVU4QcTfTqhNrQ0itttxU4ZcMbg/JbpxvKofA48I7M74dlB19gTHYkIh+/qmdEV58QBer4BDdv
	SuWCxPF2iwoWiBKhhebQTpXIUzvCYQJMyruVPrUHcFS1WXv1cIQIv3H0=
X-Google-Smtp-Source: AGHT+IHdxJSABFojXkwRPKewJkw1NM/GkW5kZE0NjjifeJ6qX3KPQ72n1ZOOTcLVE0wjbGfOt1mOGTRc3GF5EWWgio4hKDL1jW2L
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:4914:b0:471:41d8:6cd4 with SMTP id
 cx20-20020a056638491400b0047141d86cd4mr11617jab.2.1707465904863; Fri, 09 Feb
 2024 00:05:04 -0800 (PST)
Date: Fri, 09 Feb 2024 00:05:04 -0800
In-Reply-To: <20240209073719.84-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b9c4940610ee625e@google.com>
Subject: Re: [syzbot] [bluetooth?] KASAN: slab-use-after-free Write in __hci_acl_create_connection_sync
From: syzbot <syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3f0a39be7a2035700868@syzkaller.appspotmail.com

Tested on:

commit:         445a555e Add linux-next specific files for 20240209
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16e15042180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=85aa3388229f9ea9
dashboard link: https://syzkaller.appspot.com/bug?extid=3f0a39be7a2035700868
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15b1e3a2180000

Note: testing is done by a robot and is best-effort only.

