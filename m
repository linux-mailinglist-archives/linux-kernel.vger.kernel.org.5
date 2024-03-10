Return-Path: <linux-kernel+bounces-98143-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6B3877594
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 08:03:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67E0EB219B6
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 07:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93E0D2F5;
	Sun, 10 Mar 2024 07:03:06 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0378916FF48
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 07:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710054186; cv=none; b=aFvYkvqiAscDhlfvcPXxfOI54hoG2YSs5RhettGtRjeiPbi2HCcOsCclX5sVPDzxkEfq5Su04tq+Tdw+tRNcBMjvqnK+9ixuKY8R7edqsZ0ta4iaer4EHdfbq+OUEenD6pOr2FFkO+YWATjvkKv3bNi7kpGtuSrNs/cvj01OOkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710054186; c=relaxed/simple;
	bh=U5cQeCZfGNuvmn1CBBLh9ozKjtInGURH3unQVcppWHI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=HJfi9btuWIrXKJMeaZmmjGGxP2JiCFDQGtLnKrfVQcIChPCCf+ujU6YJzTbiuc1Sk8ztoAFTbb1J+Qybg6YvgnVIWH4CJ8yrKHKhUb6LjTbEKw/GmqFG/k+5/h67O3yod7Rrvkm94rMXwBzKFcxoSCh7jbO+JeP5vSFDkQkWB+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7c8a7d77806so65811539f.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Mar 2024 23:03:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710054184; x=1710658984;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x+bRvVgWGc1gnEK3RscUQ5g0RP0Rwls8zXeJwEl53dQ=;
        b=IjjN6M9j+I5vMWJbDn5B2R8s1pC3UlIduxHM6OiRnnNbR8CKNTVqW20y2WxYNwmw9W
         uR/PX3dUu4QL3yDCvWvJkg35flIcWDUqzuy9OS+TPlys6VK/Vm1sLYb35noKbOtOrKF4
         mIRWn2y5Ldbf0ZVErgRhTEdHn18woBThMeHKtq/bWFiSIpZXUiAdh1xB053E8DMCE+qS
         w/b54PaTMV0o7eB4g6cOeUqYL6143drvoTlPRWePKaDK+s5ITY8fqNi1ihRd68yV1DhE
         SkZqChk3jzUpbrTsfJ4y12PDnImCM4E9vCsujzQeMxkyqRg+UasH36tzK20iNyJSZYwe
         RcmA==
X-Gm-Message-State: AOJu0YwKx28lRkG9QkwWQ8BZR04Ye+6ErmH3Jk0QkvukmhN6p5hFO4t9
	OLRnZFKMiizUBwjJmKAnoNGqFI2WUXD6Tv0pCo1Y4zISnop2iL/jKhoEiiwAdoo3rZkvVsbF+Nl
	Rayllf+pvOe/ictFQ2YBv3mIYcLYDmoUfeF7Zv2cPAKqoFsmQd7MkwWmgWg==
X-Google-Smtp-Source: AGHT+IGAZ/62DyKsgN7dG9goQnly+p0JmtoXucxyz6iw+7209HLbBDkCkJgM2Z5BmWyJ+K2ryuWNiPijlFynPDKh2hqBuCjOy5Qi
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a7:b0:476:decd:a9c5 with SMTP id
 w39-20020a05663837a700b00476decda9c5mr32324jal.5.1710054184270; Sat, 09 Mar
 2024 23:03:04 -0800 (PST)
Date: Sat, 09 Mar 2024 23:03:04 -0800
In-Reply-To: <Ze1PTNpum86xXNcI@mars>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000334ee9061349040f@google.com>
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
console output: https://syzkaller.appspot.com/x/log.txt?x=1011c7e1180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=7ea9413ea6749baf5574
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1161f41a180000

Note: testing is done by a robot and is best-effort only.

