Return-Path: <linux-kernel+bounces-135949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CD8789CDB8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 23:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8038D1C21C86
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 21:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6925E148820;
	Mon,  8 Apr 2024 21:41:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81FC511725
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 21:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712612465; cv=none; b=dpUgNa28Gh8SzKR3bVLabN3pLLtnzV1lLpPz8oDAfwuyUx7E0D8IwNwio4Fc64B3B8XKoO56fnLbEpvyxYJrPDgLjRooZRcAAgYROkrOscH5l+dNtHkDM8CCy632BZzTMPKb6Hp/g2u/CCBtr8A2YbYbUtusABVSADq2W68Md60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712612465; c=relaxed/simple;
	bh=T9bsvzdpS7roiCAe+dlsW5jo9TgDtw7aLL8EifxQRng=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=h54uaAmrCKMBfdId2cWS4LNOmFhxCuQguE8frnX1QvATILP8MdbP/YLyxZbckkROZIPuoxMPaYAB/Hnf0ZZbkcjh1Hj4R/0sS/Y6A5sO3+fIgqyXtmVAlj/Dm9ScTuMCf9HZvq8caeer3php5NfmJiM0MP49isvp1SHCysXKYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c7f57fa5eeso402397839f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 14:41:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712612462; x=1713217262;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00VmtDciejUxwF/vfWcITKACbiIKOeDfJauSk01q20c=;
        b=d5B+Z5JRXphAN+aewmWwBIfnRYNLylmslLZ74BB+mofG6ZIAmZ3LVU8xsEx/vuge1R
         tpk+pq7QzDuBwfY5nOHGO0U+V9wjz5gMRH94xi96hc/nB8oTZyjbE+tGpOHKkhfVo3UC
         HK4nqHqvsBlPGi/tnLFJuyYVz02S8dc9Icjyk6NzQQEl0d/uw5B+cg2ZiO7C/L6NNsZ+
         WRpcMKQlirSkZScazebRjuIXxpvJgD5LWYkeQ381PSUXjVI74lfdwB6Qir3zGjKqDQlt
         xJdHht4hn1x278cVzmJTWFlZEnS19MeiAfVBm3o470E68ZNm7IKb29c5yBmkxWyyMxc6
         iybg==
X-Forwarded-Encrypted: i=1; AJvYcCVOeXevg9ppx/BlKO1eJLL10CYr5btPtuT3JyGW6RcfCnS42+gYC0ooceOHIA4PTSDRC4d5S4d+LsWCKEyTMotN9aDs5cDDNLB8yP2O
X-Gm-Message-State: AOJu0Yz4JeQPCCVU+FI5k10wykJ7uW+ZfDNb5OURVPQnj8XmtyHSo6HE
	oSzicTANySWPoNnrZreTZ5yPH+l79eAzS8Uf840XVSZQ/5wSoSOq+Ai1aN0wZZf3FcTJkHE8/8H
	yppxXnAeexECRQs/VYtzXeKHMzUPN4MDg0ch5jY4GVGQg2oq7eftURvg=
X-Google-Smtp-Source: AGHT+IHgjipPni5JW6D9BguScpkdAh97Mj/1UwyYCgi1ywFE2UQUkjhyKpVu7k9xj/gWfeMQWwe6Ki9FDTc/VaaZSAUat2HBILfo
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a04:b0:369:f7ca:a361 with SMTP id
 s4-20020a056e021a0400b00369f7caa361mr793906ild.1.1712612462718; Mon, 08 Apr
 2024 14:41:02 -0700 (PDT)
Date: Mon, 08 Apr 2024 14:41:02 -0700
In-Reply-To: <tencent_7C336C9E5A1B9C4B9F1B7C251BBA77BB4008@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007a80bf06159ca99d@google.com>
Subject: Re: [syzbot] [v9fs?] KMSAN: uninit-value in p9_client_rpc (2)
From: syzbot <syzbot+ff14db38f56329ef68df@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
no output from test machine



Tested on:

commit:         fec50db7 Linux 6.9-rc3
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16f83f8d180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=13e7da432565d94c
dashboard link: https://syzkaller.appspot.com/bug?extid=ff14db38f56329ef68df
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f0df4b180000


