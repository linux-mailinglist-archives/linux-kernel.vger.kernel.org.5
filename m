Return-Path: <linux-kernel+bounces-57630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4798F84DB9E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:42:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E55181F24332
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:42:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EC376A8C1;
	Thu,  8 Feb 2024 08:42:08 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7103D6A348
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:42:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381727; cv=none; b=L/wyYEBE3KVo4D5TqRh7ST/PB4Msvz/8VSBJfz/IgxRAGU0jdXk7REuqwtXqruJHz9476CDXfKMJjK0luxePz3mcG/eiZF14S7aOZpg7x7XoILY5GaSi2TbDOrtj17kLcHJDRMqKVwH5yt0jMuUD21/wLCrlH9SuBeDD1x9jDDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381727; c=relaxed/simple;
	bh=owM+DNpsKkXyinnw4wd0FBpjXm/GovegDPMh1yJNq3k=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=c9JSGh/tVj4u5M306pQpnnG/mGw5u37DijlFedIxMrKnJjw8EhNhjf7edMl058YPOnU5YBXqGZsRiFp3FLu31xEVtMoOQ1u8C4Q6p+L3ZQHshe22izkW/macef+FkZg1Qx3yN6+uNKVEyg5S7JBMCgZAPNC/UQyCah1LSBiwpCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c02ed38aa5so128875339f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:42:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707381725; x=1707986525;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gi3Aj5CpZSqfEPpOTz0NyFdtwkFwo4vzB4CbD3V/hMU=;
        b=wBhsFpxos4kbXp1MOAxWG4l2yBuw7my9BMx9jh/aVY7lkVyH3jLpMVkpcVBxdYHPxE
         N8khS8+zloy8mXGkAOIj+1Ruur+7R/n+1DKlIg4fEHM3NYOxUG6cxtmCpRbdGeLFdKQI
         opS2UHvVVFwlSVsuz+xUkR91S5pxgZDw15az0rNNoGqIJiL/e5f98G8h0jv3MQelrEkK
         8egX3YRFU65ZZcD/OqL4C77wtstay8tIzNUWPYPWMQv66C+hwd8DXBUWdlUscyjNsubP
         i2H9bjthUBTwkqpUNkbZUrvWpJkmAIz2nWyVmGyTwMFunH5QF9+D1vOs6np7q/hP7OI9
         vyfg==
X-Gm-Message-State: AOJu0YzVg0M3X6vFL1NVXbVI9umtYvCa6XUDsn1YPqTn5hVfVA/chlos
	A2FzRa+TkfeacDiTF/kWrw/wL9deONcLO8AMnhzHiQg80OCR8xSseKvvjI00foe6M3p8Asmq8ng
	gSZVauzt1N8DvfeiVHUpMoQexR0A+cvyjBgkGEszUhQid822kFHyC3cE=
X-Google-Smtp-Source: AGHT+IG7PoBe/+uQDEV3xHx1bDZIx7KmSroS4aAxMKdS6uE3XoEiKFcrp+MQPEGidl9GEYHKZ9GTPfdaZh84P8DZd8F1RvyrB1SV
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6428:b0:7c0:38b:403c with SMTP id
 gn40-20020a056602642800b007c0038b403cmr395454iob.4.1707381725627; Thu, 08 Feb
 2024 00:42:05 -0800 (PST)
Date: Thu, 08 Feb 2024 00:42:05 -0800
In-Reply-To: <0000000000006f7cb5060cc9c9ac@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000408e8f0610dac93b@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: shift-out-of-bounds in adjust_reg_min_max_vals
From: syzbot <syzbot+46700eea57ecc7f84776@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, eddyz87@gmail.com, 
	haoluo@google.com, hawk@kernel.org, john.fastabend@gmail.com, 
	jolsa@kernel.org, kpsingh@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, martin.lau@linux.dev, 
	nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org, 
	sdf@google.com, shung-hsi.yu@suse.com, song@kernel.org, 
	syzkaller-bugs@googlegroups.com, trix@redhat.com, yhs@fb.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 96381879a370425a30b810906946f64c0726450e
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Sun Nov 12 01:05:58 2023 +0000

    bpf: generalize is_scalar_branch_taken() logic

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16e65a9fe80000
start commit:   b1dfc0f76231 net: phy: skip LED triggers on PHYs on SFP mo..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=e043d554f0a5f852
dashboard link: https://syzkaller.appspot.com/bug?extid=46700eea57ecc7f84776
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128c8ad1e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12456fb6e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: bpf: generalize is_scalar_branch_taken() logic

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

