Return-Path: <linux-kernel+bounces-64617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 545868540EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 01:50:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76981F266FD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 00:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3404B8F59;
	Wed, 14 Feb 2024 00:50:07 +0000 (UTC)
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B87F
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707871806; cv=none; b=HJIg9ifkwTXjvNF2b0x52gsi0pApjUKDvvmYhQ4ueciTBWfgF8tx07NrOKPe446aee1xdqhv6YcrNEedOLGqMxcAuzFt2cHe6RbSLFdo1QR+iFNadjwck9bZt8+lDRU/2cLw2+61FqP4H2VjrfJt3zx0SS+OjWOi2qubO81cW18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707871806; c=relaxed/simple;
	bh=jaxtpZ0663iqnN7EBMC3ZqbscHY28zOTt9aArO9FjqI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=LZHAE80vdGBbcdp9lY68sQlgac06N1JJn+8gNP/eR3PHcK171tNKLCJ3CwOhT+6i7LBCRUa865SFG/4OgGAFt5WBXFm+ixO/Zygi4P9vzi4smBS13ViY3OE/ptsnniTTcL5dOgLGjlRVs0BZoAm6wlAvBffvSsOFpDTLL5HwCpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-363da08fc19so44200535ab.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 16:50:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707871804; x=1708476604;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H3SRQ8DEyl68XNK63acvMRoRC2VuTaU9K5Tv/JLPamo=;
        b=i+o4+GCsx3jwiAOO3gwF5Z7NVNHstHhzgB/WbuFRbPZqTljo69zAtUoipATrOZzqjm
         urMcRh1BkvOOWgqp7HA+w+83k3ES4/VnmAucrigjzLQBd6KGQaQudSVGaWAaZxicwpYN
         uSGe/IGu3Djy0wOqPy3GS3uaCOAKvQXNTVRAAwqUMIPr+cSjFsmxJM+TdKrWjifxFgwj
         oqRBdCCRev3dZygohXtlbdYxUa68aJtezhtLb73qo3otVlT04byEjVIN8Yo/Oqv1ZvxH
         h8SMVIlbYWh/JdGvP8AnMNPcuFYBtKMuUhrfZN/VjNK5OyANwR4PZ0lZUx3HAsUDCQKw
         eP5g==
X-Forwarded-Encrypted: i=1; AJvYcCU1cbS54Z9bkmwmwizUws1UeejeB7ANcVZ80eZFnlw3x2Nx4k8dWrPTAplFqDPdYVZXpE9IJiYjUe9DGE/O50bGMhRcMZtcgUuc1Jw4
X-Gm-Message-State: AOJu0YyF9M61cJpeCfIL8PkkMMM3Zz8FybliraFDaQ9zeV549+ZiRzoE
	FqCQ7TNCPUt/wmgvVBrpMio+bcUp9w+ps8WS5RVCkShzrOvSTNLZs4wyYSBI8kH9YT64BYFVMlP
	TDmsvjsuCf1NnU+xQ47NXcflpZVG6tvuNHN+RCmB2t0maYhFDn4cDiN4=
X-Google-Smtp-Source: AGHT+IEhOVtGPDd5aySr6u0bkZejLqyVDNX0gn22RuRdey2JIUogL1xiuIA5hE133ReBtiTSKlCArtKtTk/t1Chzi3wMfK5fb28z
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a8f:b0:364:2283:d1d9 with SMTP id
 k15-20020a056e021a8f00b003642283d1d9mr82018ilv.5.1707871804425; Tue, 13 Feb
 2024 16:50:04 -0800 (PST)
Date: Tue, 13 Feb 2024 16:50:04 -0800
In-Reply-To: <20240214002407.1035-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000398eb106114ce403@google.com>
Subject: Re: [syzbot] [bluetooth?] WARNING in ida_free (2)
From: syzbot <syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+dfab1425afcdae5ac970@syzkaller.appspotmail.com

Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16cc5184180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=dfab1425afcdae5ac970
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15cb5e42180000

Note: testing is done by a robot and is best-effort only.

