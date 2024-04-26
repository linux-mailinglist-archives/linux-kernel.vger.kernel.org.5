Return-Path: <linux-kernel+bounces-160060-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A1D28B388B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 15:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C6271C22D0D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 13:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25591147C6C;
	Fri, 26 Apr 2024 13:35:05 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1D3145B0F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 13:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714138504; cv=none; b=VpE3gUfe0kmonNvTWLq8ISHSx52QedxKGQTk3giCX9GWvvGaBFqJRCnJpoIgTF/PzapAeL+mkkGXIDWDpSmEGPT4gtMC9oiwPqkjKlbDTpOxzzH5OnrJvHxn828yJqDYDVMCps6ImQQiky8p+btUZi+aqWdkyBSdMbLsUDFZoRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714138504; c=relaxed/simple;
	bh=m+kS218jt0du5H+U4ww/ufMUqNVw+bWZWMftVxqX6uU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cIgFztB1JmFHoNob9FEnHVKNt6FMCEhsTuOATZ41Na9D6WVKkzugz5v3zoYXN2/ZwcJVX5NZrg/5TCNfCVuWkF8lyZe9twJU8QVcSOryCbCq3bEtsr/8zp0ljLgB4PnK/5I3f60DFLOGkk4JKetkEnsUSfBicmp/n4o9jCbvACg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b34b3a5fdso20269325ab.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 06:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714138502; x=1714743302;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wuDLgNPEPbdMqePbD8KgIT6xOlVG4D1tdaDE2YInWA8=;
        b=iONeeq+QhbNjuD0gPUOWc05bhqIR2p94fNNpFMxHolW3r7eFbgpBvMh2OgXg9QCtg7
         7DMRRZDuAxQ7f4ZBl7NcojDfQq79r/3P0i9I6rIRgWdKUXY0mLI34Y+2NVu3Y3WOotTT
         UQf1zjkjV3fjJAxRZuca40kBCHmVD0lR7wf69GCyA3+kc1p1nerCKiyp5sC1whE7GXh6
         aXsrgsTAbdkyAzzCioXP1QOYdy9VzmWwa8Hcntr8Go6hbZcAaMsmwqVslkIDKjNyjeps
         0zqoynqp3rwEbmBsXQ4BqaQc1C5krU3N9YX2TumOhH3OxucTQjAlpc0CgEczRNwmxkDg
         W1Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWCkJjYkUaR32/iN67HM8Tq1qSZgtlK3fWpn/8rcjD0kQIxJgTvA62613Hayfk0GeycVXU9QrFlAqjfpMKl6RoaSAAubm/98lI3rsJR
X-Gm-Message-State: AOJu0Yz7egc/VBB56QrJP4iHVzjiKApO8EC4Kr8QL8QVDBZvgK4+lZZd
	dxDRc12xU/+F0yLpIr7szsiJqlmJpENLuVdUzt6Hrg9vQ1eMgXYDNfIZZxJ0P9ZtZ7zbBzJlVn7
	jJ5yOUeYgtY0ZW6RT8VOl1rKvxra5N4xlCp14LeFl7VsY0XVM1Q/jzzc=
X-Google-Smtp-Source: AGHT+IEmE/D5eUWM3aazPdASVp2ndWN2Klx3oxJWUkQ8hKxgnVlM7qt0MSyaTsonzow98DrxSD3ec2fL1yp+5/rIGkUCMCzs2HRR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d9a:b0:368:c9e2:b372 with SMTP id
 h26-20020a056e021d9a00b00368c9e2b372mr59976ila.0.1714138502468; Fri, 26 Apr
 2024 06:35:02 -0700 (PDT)
Date: Fri, 26 Apr 2024 06:35:02 -0700
In-Reply-To: <c0a1b8d8-4b54-4881-b924-406e0e2cbca5@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000892ccb0616fff80b@google.com>
Subject: Re: [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in f2fs_get_node_info
From: syzbot <syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com

Tested on:

commit:         77d6a556 f2fs: fix to do sanity check on i_xattr_nid i..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=1535f237180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5a05c230e142f2bc
dashboard link: https://syzkaller.appspot.com/bug?extid=3694e283cf5c40df6d14
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

