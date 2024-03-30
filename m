Return-Path: <linux-kernel+bounces-125781-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A3738892C06
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 17:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5EC4F283B87
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Mar 2024 16:24:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8410F3BB4F;
	Sat, 30 Mar 2024 16:24:06 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2C8B381C9
	for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 16:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711815846; cv=none; b=YeXLrYwLf1m13ff3q3wxf+sVUOsFVfq7qJDS8NalR71c8vmtlJ1KYDv1pZ2QumWaAMaizGFeMbulMgpfizgv7Ee38ZvPGqSHx/Y4S+CccqxEssFY9SpJmCmT0ALEgSCwsXgDORiVAL+GJMirZTlnwQdLpB96YXYvnygDQ3ETnIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711815846; c=relaxed/simple;
	bh=DEMfWEi7OXoQ2QxgjC0iNCTTdGD2Y+s9bw48Q6F3hTo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=L3QpwFRPdhOoQSqyXe3fDOK/AWMhkLoSZyapR1LKKQIdSNfgs05mRvPSK9TlueRVSC+yFp8UHgYrD/4THtPlNuaBpqylqyyjpruamCze6wMBTeSuF52KaTTeYBWY5mJpJRrkXUJhaWP+CbwB72shGhzC50F8qhzostqtmwybbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7cbf3ec6a96so317691439f.0
        for <linux-kernel@vger.kernel.org>; Sat, 30 Mar 2024 09:24:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711815844; x=1712420644;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F71zCftWioDEIwzAbPQ5dMWTP68H1egx1n1W9WE05ic=;
        b=uj/M/jO0Iuv8y7TNtr6aCTSmLi+3w/8tUBYM2iWYaxxoK5RnqKXjzXwZ+J5vvjlUoQ
         zKSMZiXzG9zhJZ4LoQggGzrpsp1FIDO0jJTDzC2woYs2JoQlHytjpywUrZyjsBzNyV39
         DuPVydM5q99ZYuFiHQhfCGShTAuS8tbQN70E7dAJRib6NA2lEaBG4clBEBsKEncBsixQ
         keUcMHzuZ1WRtOSi4smv1XsXcEodvu1kDYLm6ZTYfEkFthMS7fJYdmkK/sZgkK/7c11Y
         IEOpoFuTgqhGCdasaFoBHjRq/yaF59acd368Jw5+X2oVdqScqkdgd+5/+L+LqyV0jaFI
         lWcQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7JcnHg6eks9EAPRm6f76hw9qExJenZJKNtsGkg1e1TdS+FAGqlwZdESVRLQzJ0CwXHN7n/ZtJrTG7k1J3FiEgSPQFDs3RvUNxBIQS
X-Gm-Message-State: AOJu0YyNWS8ig6/xAUrXHQGveSMCEVF/RNtCP/uK6y4hk0sxyzbEKvWk
	Gp0x/cdNHIrBgn6Hu+W61hmOHBVwE8lr3BQ+t6JWONFd09YgskiR0DFm44FQwCDxdLMxO9BW1nC
	aDmHiaPIXf/q42k4gUlM4M5k99j9A+dpFECsWXafm4+m/Bu/T0HxDQUQ=
X-Google-Smtp-Source: AGHT+IHU6F9kuRk/eamairGzFSmnuIS6aRiMkeV8dfOSvT8XgwoPIAuNwDs4HQmXLzzvqHa1xnJn7oIL6i/O93Ff7jQp2lc3ghDl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:12cd:b0:47c:171f:23ad with SMTP id
 v13-20020a05663812cd00b0047c171f23admr337495jas.2.1711815843964; Sat, 30 Mar
 2024 09:24:03 -0700 (PDT)
Date: Sat, 30 Mar 2024 09:24:03 -0700
In-Reply-To: <tencent_F5284B3A74AB762167143CC936FE968C3609@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d141f0614e32faf@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in tick_setup_sched_timer
From: syzbot <syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e4374f6c021d422de3d1@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=12176341180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aef2a55903e5791c
dashboard link: https://syzkaller.appspot.com/bug?extid=e4374f6c021d422de3d1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e213b1180000

Note: testing is done by a robot and is best-effort only.

