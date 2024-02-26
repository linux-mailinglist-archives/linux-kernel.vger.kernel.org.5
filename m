Return-Path: <linux-kernel+bounces-80435-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 777A3866869
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 03:58:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 292D51F221B1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 02:58:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFE0F1B7E4;
	Mon, 26 Feb 2024 02:58:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9EB61B59D
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 02:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708916286; cv=none; b=Dz5KKHwymy5EV3M4H3872e3IXCb9iKOuQBYgPBkFIRBC5XR4kEIkA+5Q1far6jp6CUpCCvyO5wVqKxdRJJ3ZyLq7UXT1zbQ0Y2Jhe2i0ItJplCN1C3J5TonpuN5ETJqqFV58TPiZbESFMRD6EezedbmsctT705YL860a7XXJs+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708916286; c=relaxed/simple;
	bh=aGR71Vhpr+XW0L+xURcf7ciXbyrrEkxYmCooO/pBrXw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=oqd+klfIuvCJJw8BnuP9diaWCwtsqpm8k10MDtzY9AZSa/026Bo4gDtvWIDtEN/4V2sOFpG3nAF2tUOkJnvYc4DuLufpDvSd0rAKSJ7WboLbkVPKbD0V1fe7zqz785gN2/5jgtXNPH7x/nIToKDjWte/iOUzvgqtBvR47F6NzIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3651f5a357bso19514475ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 18:58:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708916284; x=1709521084;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TD8oqj5D6F+ZpelebSdE/49eppyj393f1LkPMpVDt9o=;
        b=U9zb5nijr6EUjuY8fCuaopmF2gUXgqgMEhZ+syfaVjXN6mFt4vy1d0+VsyWL2vcE/7
         I5gosOokhenQnxkOozkrQpo5TeY65GwRocFn+YgBkl4Jve8OfpJVCq7ulqT0mfzy0SUj
         kn/9L3Q5MD1Bjj24MmLOGGdkEDAyXfvQgB2A3R7ylPfL8yFDX4DgOOtqaa+tLEXfWvaD
         I/ga6Xawq33Z4Ti7KYZYx05/d2iQIx8FToVSupt7XCfYvzrRxGnF3AQBkGMuNTC90lci
         fXJD/AKM6qz3M7IUe04uEQXcFSUDK5oJlbJx5uBhj9Acmfa1cdQ7lgFFRnDdbW2SSgi3
         PTaA==
X-Gm-Message-State: AOJu0YzYEoE4OXwTQ6cdUFondpYbR/w21+zzlNthRSMaLg5WIT2Wrf53
	+UTfV1IRH096d1Y1q0gk0MccZHlKtKeMf+ZelejewVQprMLjwZCP80VJCQnlzd3YF8vWTL369F9
	Tt23JaLkIhdIKw9HDrKBNSIapGrt4e6xrWz9l2PdCqwWluwPi/Nw25wLuMQ==
X-Google-Smtp-Source: AGHT+IHa83/6AqOpmv1mYvR6uZcbdEoK0k8MowCNhHzQc/MYkvEucYtHUL6AJZZyhA21DX0lJGSnrksSmpRkyXT2nawizycMPEBD
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda6:0:b0:365:26e3:6e51 with SMTP id
 g6-20020a92cda6000000b0036526e36e51mr358830ild.0.1708916284107; Sun, 25 Feb
 2024 18:58:04 -0800 (PST)
Date: Sun, 25 Feb 2024 18:58:04 -0800
In-Reply-To: <20240226025229.355810-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000010b5b40612401470@google.com>
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
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1401de9a180000


