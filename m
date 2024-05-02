Return-Path: <linux-kernel+bounces-166000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 227898B947D
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 08:04:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F8EF1C214EF
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 06:04:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBD2020DE7;
	Thu,  2 May 2024 06:04:04 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D28A1C6AE
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 06:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714629844; cv=none; b=DUUKtetxMIbUpYzI6y4jE75KkGuiW6kpxY1aKw9/UJrHyFpL4q7gqICLu4mDqVMzr9wjhD3ERdnk3a9bT4kn0FQ/NqN9hnIHlUj0eflgVR4dDFfmo8r+DjKjUZrqSXoAvvFhA3BZs1kpyDxxV54v0ai5+8oILbVs8fjI5+uYWdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714629844; c=relaxed/simple;
	bh=lI+zYYhwfdiozaRC5irM1Z9SGyZ7PZ1GJTG4/ppi83A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Uz2Fi6w7tgThvDDf0yoAcweJCDBSx6YfmgoPOz3Ifh6giKO2zEtTTzJ/+SVamMZoXNc4WiUszQmiEVIuv/fTjPZlgp7TqMweGKn/XE5W+3uK6lbU6Hcuhzol9WWf7RJM815aoEJRcJmmQJf3/jPdUosLtxkIRCLwiJlnE1nTe5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d9d0936d6aso860625939f.0
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 23:04:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714629842; x=1715234642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zGOj66+WzT3abwAJPa/hUYebqscE1cEduzWpvyCpWPA=;
        b=dbWDDmiEFL3X/1y1wL2VKbQ0/9kqzXMAhlxTnmw6rYTv8Z8aF1OP8+UMgdojUuoTE7
         vssot9+QD3VpJZe1LM57INkLY6P5qi6hPF2PBCjVTOFPZGdHNm/X+602WV/Dx8mlKbq/
         gZLDkR0XXLYtPHNNMDtQTrDGK/bhUvyEqCrfquSYEdlWrgmzkBCr+hM2JmBKCxb+a6cL
         Kt77A2OmJ5swJpaz/QZ4cOA8oo5VC4bF+XCy/xM4X/EJmrlePXwuxpT1YHwAu5ioLZ+0
         64Lygdc5S2ATt1gbjwlZpEzTEAhne9BotNml0ulYSrIZ+bOSZewi7sFlDE5qdR1h/fiW
         UCww==
X-Gm-Message-State: AOJu0Yx+A7kuPCx7ibCzLXbcNdKX9E/DdMVXPBjhJMzM30dRMsDu7CeV
	aCbL7aA5h+nQ5/Y2Ob3LC9p7v9omNVLJnt6L8PO0nMPAHM+p/lpAgqb8unzdGdl/dfxrriOmrdX
	DXql2BhFWrCu/ozUmPDxTiiIbdKyqlk1aJs2pzaKadR42rWNB/90uSRA=
X-Google-Smtp-Source: AGHT+IH0zCVUIBY6sDcixsmAoK1ZKjmwCKA1Wx+965sYUy8p2WK/VRYQnlRIJcculiUrPEIc6Wrobl6ARmQS4tjaeuNduDAAyDk2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20ed:b0:36c:5f85:6979 with SMTP id
 q13-20020a056e0220ed00b0036c5f856979mr83307ilv.0.1714629842488; Wed, 01 May
 2024 23:04:02 -0700 (PDT)
Date: Wed, 01 May 2024 23:04:02 -0700
In-Reply-To: <ZjMkFLuOdNVQVCl6@zeus>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000aee1800617725e64@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KMSAN: uninit-value in nci_rx_work
From: syzbot <syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, ryasuoka@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7b4dc6cd50410152534@syzkaller.appspotmail.com

Tested on:

commit:         e88c4cfc Merge tag 'for-6.9-rc5-tag' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=15d07a28980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b43eff4125d4e9fe
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b4dc6cd50410152534
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14fadc90980000

Note: testing is done by a robot and is best-effort only.

