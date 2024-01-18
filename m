Return-Path: <linux-kernel+bounces-30398-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E1A56831E33
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A7EC283268
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25C412C6BF;
	Thu, 18 Jan 2024 17:12:08 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 748472C6AA
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705597927; cv=none; b=foPS0sNTV3CC0OxsTA6KFiUtVfK+JyKDcc5gOX1xRiUp/gF6p4GTt3eYtHLUJgG5mtfYl62A4J8+CBTet56C6IXW2A3Jx1hibdhGGfhlgOqjBKnZ2s62ReCoLlhYHE4QdkLPlNRpBszBUjhXRxk0L3ttEFGwXJRXczIQWZG2fcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705597927; c=relaxed/simple;
	bh=plkS0Cb5m3wGIp9mBxx3Cvy5ey0zTOa/OJowls4woCA=;
	h=Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Google-Smtp-Source:MIME-Version:X-Received:Date:In-Reply-To:
	 X-Google-Appengine-App-Id:X-Google-Appengine-App-Id-Alias:
	 Message-ID:Subject:From:To:Content-Type; b=Ej5OZGKBb39kjAWiFfRL6ORia29rir4WaHvSbgnprCLURK38T3TVRxUBHmasU9bK+9qihUdFcpqyExpWglfGva1A4VJZgJvfTztzHcDErnqafDJrusLxJXpz5by3Jl57mqCsKgRbv6EDgbNksUnjEAH+/r5ZjksyOtRYfK06WvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3606d19097dso113965495ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:12:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705597925; x=1706202725;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q0aesP44SQA07vf/J7lx+pFb7k7N2JWJ4dm9oa1x9KE=;
        b=sEXAx+U33iI4LEJXeiO3rSk64p4Ugj/Jk8VwdSuBc43dg+PBGiJn983hy1ohdtqgXR
         vEfEnmd0wmHaD87e1N0zyilvJxWZNxYjzkuC6nOayACnr8EOmyZq5sMd1EwV05E+TwkY
         UU/MGSBlZiqAtwsMxFegkmqcXz2VTkX7lrKmjhfBczl6RvJJeQyooHs6FRiQvVwGPY4i
         05rnnAvVI35vDf3oTZFWnnTBig0b2MsiRmYXJ3YjFPI9s3/bS7BfZuufBNXAr4EDXwY1
         eDIRAIfKOeykHBe0QGvouoMK0J6I28Fvxp+cl3xAzaGmoehSvnHxPqpT1heuD9xLYxbZ
         OsBw==
X-Gm-Message-State: AOJu0Yz6cRC8fqCkjW5oGXdVI47ermAqT8rVu3Y2cMN1HMQWB+IbuvmJ
	leLVjN09z8jzi99RYYhUK5KMwvjU7NiLoG7sP4eMRPwgf4i5DbOrylOL5KvlS/S+i4Smn40I8+h
	h/16zpFHqVc3Ef/z2/r/tc7lharoSpIvUCSC8jthw1DbopqEjmO7XSzs=
X-Google-Smtp-Source: AGHT+IGBUlst1a8Q1xbWOzmaYptfqdjmsEaXoXe04eVuJX6v/PyVidOB7uPKXrw+OPFKcLcsG2zvzIBa0XmQpZ2VPkZV2cRhspXV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:218d:b0:360:a340:dae0 with SMTP id
 j13-20020a056e02218d00b00360a340dae0mr141931ila.2.1705597925619; Thu, 18 Jan
 2024 09:12:05 -0800 (PST)
Date: Thu, 18 Jan 2024 09:12:05 -0800
In-Reply-To: <20240118164534.14880-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007c7cea060f3b7618@google.com>
Subject: Re: [syzbot] [nfs?] KMSAN: kernel-infoleak in sys_name_to_handle_at (4)
From: syzbot <syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com>
To: glider@google.com, linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+09b349b3066c2e0b1e96@syzkaller.appspotmail.com

Tested on:

commit:         d1d7f15c DO-NOT-SUBMIT: kmsan: add the kmsan_exceed_ma..
git tree:       https://github.com/google/kmsan.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=125bb51be80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4778da307461370c
dashboard link: https://syzkaller.appspot.com/bug?extid=09b349b3066c2e0b1e96
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10f39bfbe80000

Note: testing is done by a robot and is best-effort only.

