Return-Path: <linux-kernel+bounces-154403-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B72838ADBAB
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:46:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7101D280A8A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5888E134C6;
	Tue, 23 Apr 2024 01:46:08 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7E417C73
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713836767; cv=none; b=sk3mewiIzNTvCTC6iB5W8amqgkUOfRuET9YM1ZQsYBKXd92lcZC5uWv6KHmlikGYMXs51yCJX3yqvTkPqJGuMxqfi1zGHKl4j+kLVl4lV2+aaowFm8G0aGARGpxvy8oT1cpkXq8ro8+vvMjEfUwcNhEHnA3XxL94A4M3L7ptk24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713836767; c=relaxed/simple;
	bh=VGeBMKGq9/Hj05caC3kl8lkmEKoFdqUf7+vqK4SSf9U=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oCnnqy4qbytbWW5Y3ZvIMi8pWKH012rpU5FO4+uf8ycwnJ9z3/usrrZoJ+5rJSVw1eml3Y7/IfnoJwxQHgqMSYKL3AamArSHbeY0brPFflPIH+otygkVE8iEGOByxAAcM3uw0k4t/01WhF5tb4XJNcdWu0fQgUGZKn/5tgfE5So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7dc40011f18so79664239f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:46:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713836766; x=1714441566;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0WCupfQ1dCDU21cSKiBT3YMKDn110UjiBH0ZicqUxGk=;
        b=cBuwzVgk4NpMaeVuyFlTIezBw4FoaktSQCm8MqPYzGI2OsP9IqMCHzvTOsVgN9MmBf
         JI2stiGNEdHK/2/b2j4oUjwZQ++ehfB3KcCE5FwyKz7erCFWZAfoD/OJ5x7XPVp/r0r1
         S/Q18ToW09XYQJt/T5zrn7/2Vyo/+m1LbyFHqdfTOCEkEM3/ql+KB34rsHHl9jJNvWnI
         0JxQwDYZ2SeXRNbARNjcelXZn8gahj5BThkxPWDTkBTasrVP389a/XqLKVFrjdc282P3
         yMGR5NFi8v6tIsv1dYEalTtpGPBDql9XiXHtCAGr+D0NPnH73IomUtfEl2RX9wwtD5m7
         FFcg==
X-Forwarded-Encrypted: i=1; AJvYcCXbX5KZJ7gxjq0k07TATpfDtguUZ9R52apwX+UipNCbzs2kVLAVe9tcRpbcgvDZVl9sHXIsL4J2xR2+vp/uct/fOK0MnPvQYcAV7bjb
X-Gm-Message-State: AOJu0YyvvH2NyKQuQQHv3ROmaB7C5J5WiEXA5Nc1mZNP36A2yX4aPesf
	0VFGL8ok3C+R23xp1BH8Lj/jvW6//1oI83YCkmfFi5+5cb3tppEAZWpeQjfGNbbAU2Vnikuw8L1
	2uGCZtZwZcfYvpg6X4cHOylw9ofjbrJzv2No9Dia6cMgRPJ0xfziBTng=
X-Google-Smtp-Source: AGHT+IH48UqFEkGt1Qqueqq3haIM+KLMvozMjEfBK3G/AergUVQ+XvZS8xlYf1kvWIScJiTdzSLWPApCVy3Ks0Ow5kGE+IM+n69M
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2c08:b0:7da:bb15:56fd with SMTP id
 w8-20020a0566022c0800b007dabb1556fdmr40563iov.1.1713836765934; Mon, 22 Apr
 2024 18:46:05 -0700 (PDT)
Date: Mon, 22 Apr 2024 18:46:05 -0700
In-Reply-To: <20240422160728.82185-1-kuniyu@amazon.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a30a9e0616b9b739@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in ipvlan_queue_xmit (2)
From: syzbot <syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	kuniyu@amazon.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+42a0dc856239de4de60e@syzkaller.appspotmail.com

Tested on:

commit:         f2e367d6 Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1286b06b180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1b015d567058472
dashboard link: https://syzkaller.appspot.com/bug?extid=42a0dc856239de4de60e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=117ae96f180000

Note: testing is done by a robot and is best-effort only.

