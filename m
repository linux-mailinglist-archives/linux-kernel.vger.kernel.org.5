Return-Path: <linux-kernel+bounces-133952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA5EA89AB5B
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 16:35:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 278531C21282
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Apr 2024 14:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D4E02B9D2;
	Sat,  6 Apr 2024 14:35:07 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DFE1E4B1
	for <linux-kernel@vger.kernel.org>; Sat,  6 Apr 2024 14:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712414107; cv=none; b=uMhH6G2/wOe8l+SAJyc7D9umQSX8YnPA4zwwvquFCZ9QYnJnf7PRfmpAYzy7AWMoDiuM1XBsy1F4rUgjGbQC3AGSIBQhtahjoUybeu/DRudLMS/1SjZ5SQtP9aH4+HGhddlFKlN3Ru58xzK3lYTnheKt4/TQr/4Ad57y/XrDfYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712414107; c=relaxed/simple;
	bh=Q7H+T+YHXStwNG9XTbR1xArNrCgw9zSxSNayVrvy1ow=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mVNkd0WGptkugKuN8F0YUZyxYLqjP3OhYBYD/lq6oorKItA1AkRekxgC9cv3pS0FTjNzj4e8l8HWTv+ahU9smC96cenIksj3xld7rFeInpYAHGseOQJQHpP948BBQksybpS84hFN+n2cG0Zs4b/gvVrteWZwkTnTf/KgZ5MSd2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c8a960bd9eso304996239f.0
        for <linux-kernel@vger.kernel.org>; Sat, 06 Apr 2024 07:35:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712414105; x=1713018905;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w3ge4Qo9FwdrImmPTlsL8FWJi3GtBpH5IpH+92PfA+k=;
        b=bFjCLSv1/XNhFG6m7TakP0df1NE2lpSMGWuSWsCyy8j+siKcLRmcYAO9w0ueUPdMXa
         iuHz1jLjTseQ0Y4VzTGFXcI/y25BIHlLQkzdN8GGr9opHbvlSL2ejAlZ8SBZK0e7yX5y
         QKReEKmNn4OjU1hT9LNJ3fqETXyap1WtoWf39EFNaIyRiQ3b+AhFn2h0NWRROGZBhu6H
         vWZa93+Jz6ll+ddeKJTfqZGMGuvwubAxWkgHahbDdH/bHqZq5ccc2tcqKX10VIXcVL9E
         MVOtut7x65+gZ+Uu5hgjeyqldrUJN7r9Tl8OzoTI4CmduGjV4NjE3O6sxGhh+x30KymZ
         XJaQ==
X-Gm-Message-State: AOJu0YyJtrv1705Se8T3QArdbrUHG1s7ubq6tOSurjwU1DvclrTdhcdt
	lkgLje917O9MY1Hn4k4on7it9snsskXKJtCWGHvxAW5Rj1bOrcb8bhwuI6Hy+Z7z79PUE0kkh/0
	hKCNmAksxIGbz4WF5IvK6lpnks9xQii9Y2spOgoQ9Cx1Xb1Nbxf+I4OFrMg==
X-Google-Smtp-Source: AGHT+IFQpNRlNeg3S0iwLPMpWucwz2ZpfQoR9/7bXHY5E/c1RvmGz/iCtbIes42VyvpApFlUXgIIsmm6xLiUlg83QC3Y0KrcTOEB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1302:b0:47e:cf59:7f48 with SMTP id
 r2-20020a056638130200b0047ecf597f48mr85114jad.0.1712414104977; Sat, 06 Apr
 2024 07:35:04 -0700 (PDT)
Date: Sat, 06 Apr 2024 07:35:04 -0700
In-Reply-To: <ZhAc4cxnkBm003Kf@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006fa4e306156e7aa9@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         58c806d8 Merge tag 'phy-fixes2-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=13947005180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=80c7a82a572c0de3
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15736155180000

Note: testing is done by a robot and is best-effort only.

