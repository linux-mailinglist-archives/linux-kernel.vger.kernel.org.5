Return-Path: <linux-kernel+bounces-80427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6047086685B
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165F31F212F0
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F020817BCB;
	Mon, 26 Feb 2024 02:53:05 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D78C17722
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708915985; cv=none; b=D9DhT+Y2WqGyFYmLH91cFiOcytl9s1C4kYt/mcrUrWbKUZyrR481LSint97tUcMZniRVdHsM1hkRSC3J0rCgv96CoRF7to98aGP+yDWmAl4gGA7d8kV2zthHMlycsR6s/yFFkX1vBKhKMLam5y5uH6tj0qhKJBi4ONAxdVYKAFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708915985; c=relaxed/simple;
	bh=Bnr9/HrCCqt6VxpqJl7JDc5CK9jt5xwixXG80R4+tRM=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=mv529/IDIuUPLTy0WFvGMCuvAg3x9cx4yYy/HTivPAHLTDegYn805VlInjuUDVIKzjyw7dY5+dBc4qMnZ1seSFQt6Xv7IPT9pDIm3soZPG+bxhhUr1ID0tpEanlOraNPuYILmbZrYmCCYt9eNgULBunp2CRqI5qYFS4YXkpZ2RI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3659343e9bfso5687835ab.2
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:53:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708915983; x=1709520783;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d371mQ1crjjdmNPbPyI/JNlSUBXqwddrp9AND/IIhMs=;
        b=dyYXUlQdi9I/5e22SOM8k6HywE2MYZPseksbEchk35r0CDgaFEMIvVNesZj7PQPMew
         LZ58QzwBal0yUVTdyvWZwPPH0c8OmAT+VrWiJ8XfQk0Jl3LoykBaOtfAYra+TPkzXHm+
         4SiJx3M4wnSd1XPDad3pN3w4bfOUJSHX6SVyM2GpM/VeMIl/eZBEmzQSGmH3VBCrG3yt
         HOQ/JC/J1KHEhjQOJvhBle0oyGnerMikNtK313Y72MNmNRXC1XtD/Hp7Gg+moI4MLyaf
         pXDjvX6/TLwVgaWfGAT7IkYauVDlWo1RHdjZ2r0CbB6UcCZB9FyR5x9XdVaHyRKa1bab
         NA7Q==
X-Gm-Message-State: AOJu0Yx/p0rdiVmTuy6NrZobtxiBPklHW+P3dVQZ+Lh3RLJHtAeackLh
	GU2dqOU0cpymzQWJYqZZ5/r0GNDKKuxfW1edLJ7AkPSA0+cm6fvTXnu/37f8xh6xFVGrckzNAT9
	osXevTmj82tk9TVaqw5jBEqaUYJZutTHgCV/5rW6y/DeTxdy3rdCcq1w8+w==
X-Google-Smtp-Source: AGHT+IGLQNbednTdNRez8vrZ4yuLDKCZuhJd6+eVRuy0gIWLs6T1bzVSFW+2fG61JzK2UHyULVhpebhsLLH2beGBeWb/nJqpmPct
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d99:b0:365:1212:3f0 with SMTP id
 h25-20020a056e021d9900b00365121203f0mr344297ila.6.1708915983495; Sun, 25 Feb
 2024 18:53:03 -0800 (PST)
Date: Sun, 25 Feb 2024 18:53:03 -0800
In-Reply-To: <20240226023715.2653372-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025b9030612400228@google.com>
Subject: Re: [syzbot] [dri?] WARNING in vkms_get_vblank_timestamp (2)
From: syzbot <syzbot+93bd128a383695391534@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/v6.8: failed to run ["git" "fetch" "--force" "4d52a57a3858a6eee0d0b25cc3a0c9533f747d8f" "v6.8"]: exit status 128
fatal: couldn't find remote ref v6.8



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.8
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c0ac5dfae6ecc58
dashboard link: https://syzkaller.appspot.com/bug?extid=93bd128a383695391534
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=16c78602180000


