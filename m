Return-Path: <linux-kernel+bounces-66904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5795856363
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:39:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79B131F25E70
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 12:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E465212CDAC;
	Thu, 15 Feb 2024 12:39:16 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EC318EA2
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708000756; cv=none; b=f7gXaqFCnSh78mZNnvq5xdn+MfBsQ9HV6AwddcdFd3sXEqX0UaZjLOnvnLeEaZP1Nn4qvEE22zy5WgebbfWNlyguzvB4UjhZf8gk16yDZdNtgIqZkrPNmviSNMPl81QF9SccDnqk2Zk0sT/3SDTnmbV0UU8rD0zqjpRGJdToxXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708000756; c=relaxed/simple;
	bh=UWtQDYiNqdCvtUUJf09b0lgZVfPXiVHH71TdOe68xdc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cyXfQ7d2I2G4sQKX482hRf/obzZRav3k2I4p3AfFWIHUuyCtkWmkV8DTspF/eJ4mnZ8vG8axRDD8eNy/4t/JUFtOOZgUFRFAamCbbYkklJckeBEB7z78pO9ExLia6YkdBlGThryH5wOGjDZAAqFQyD8XbQZ/a3CYSPygq2kezXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7c414467bc2so58586939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 04:39:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708000754; x=1708605554;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UWtQDYiNqdCvtUUJf09b0lgZVfPXiVHH71TdOe68xdc=;
        b=YeDP05QXX5ZQPEdjty8bgNdKtlJ0toM8p/3r4sn5wzN2CVl639PBS4K0KbKIiTtOf+
         wmhFk5ss6lX2deiH7FwTtXXrBLFv/aBQbWpMlC2Vfaqa8v6eU/Hbx6TfydGhMYhd9fGm
         f18lzlKVlOOl+xKt2adVC+lzKq4AkxTjp+7NDdk+s0jco3bth9GzuPZmixf2dofNV7U9
         c1XvSz9t9dMcpih9thZUTEhT3VZfiqqk0a/810Lb/t07o3TbA7vnw8flx9Rkss++wrJK
         SeuC9zWA54kVSM+5YFJBk2jThMxzjXH+X95Cdgkc6m3Hz6N/MZn9hH+OEQqSj0s1sw+A
         N6Fg==
X-Gm-Message-State: AOJu0YwmuHTNYk4UwXQ2EPGswopmRJwzdwEsVk1q+sZjCADBhAW/ba72
	E1h/FsoXyu2JW/iBVQ6RZhckTVBfeBKKpLNOBN/vtBlsDri2Mi9/SDplB/fG2J9mxajpAqXbzJb
	b8FPpoTYl0K13+Hw1NVS6wlWoDSN7lwXGlXCsmt38QMOED44oY8heWhie0g==
X-Google-Smtp-Source: AGHT+IHQkuxve+rFy0Ykj/T9AFOUs2pGQqmLHpTyw43NJGOvYg1A7eC0h8ygOYwsVzr8PX6W+ULKKPNTZZBZaF4mv41GUppr/WWn
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218a:b0:363:c75c:8c9 with SMTP id
 j10-20020a056e02218a00b00363c75c08c9mr130554ila.5.1708000754296; Thu, 15 Feb
 2024 04:39:14 -0800 (PST)
Date: Thu, 15 Feb 2024 04:39:14 -0800
In-Reply-To: <000000000000d42dae0611477922@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003c6d3806116aea99@google.com>
Subject: Re: [syzbot] Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
From: syzbot <syzbot+ebbab3e04c88fa141e6b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com.

***

Subject: Re: [syzbot] [netfilter?] WARNING: ODEBUG bug in ip_set_free
Author: fw@strlen.de

#syz fix: netfilter: ipset: Missing gc cancellations fixed

