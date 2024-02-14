Return-Path: <linux-kernel+bounces-65163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D658548C4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 12:55:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 053631C22623
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:55:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2421AAD0;
	Wed, 14 Feb 2024 11:55:07 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F6018C38
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 11:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707911706; cv=none; b=C7qvFNLqoCiGOuAikagy0CCUTg0jwZpYt5NFO2lzbvUpA8cEFAaG5xvdeNJ15kfzNG35cc0UqwvQ6p9Gi4JjtcsUHzO+Z1adedzByE5f0f43KbDCA5T5SPjZv1Be3lXWgkJjl8RdHmShMUN5pOWn5FBhzFCkomK+X2bU5n5d/VA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707911706; c=relaxed/simple;
	bh=tcUbq9dyZkkpaVKaFLPcmPgwJDGN2R6PI8sl+6Wbj8A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UsoLnNlm4JnY3rX8ttmXE8Hhrjl5NCw74sL5CCUdp5qGFkTLaLujFX4OF9N67KjS4BjeRLrn8mGWxOyzfEpXm85EpOwyHL3Db0ekRo7igbh1rPVbU6lNDvsxBjv+zwDKrT5EamtCS9FFTzBqdJRa7U0AgY20dlH8mhd+kueQiaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-364278061caso10968155ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 03:55:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707911704; x=1708516504;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+t3HPEqElybihqqYbhKiluFg2SoyKB29KV1I8eSe+k=;
        b=i1qT/aEjrcsZ7Yk/8UPxB3gPmUxulWjcbLLZYTcNLduwrxpiftMCavNkZzTSMMhy9H
         hZXSt5MYzQAjh3twGNQ37FfY1mBJJu0OZZgM85NZcBdzRrBECTnmQF2asCI7yzbCDyFH
         Bu8MmRc8T1uZP68LRxPWL5lW+PoZdkGaEsTt3G7w9eWgddTuS9LsDwR28AIiokwRut9H
         jWscYa3CsBTTvz6k12Pp72/Pe73yrBYFubbd95GXyGz3BZvv4CZh/yVI4cSRBaTUFsdW
         0qgyrJS5y3ILlMFREqtBp45qujfPu0D6t0rkPeM+khs0XC9Shk7UFaALckVJmQqMVsat
         jOjg==
X-Forwarded-Encrypted: i=1; AJvYcCVi8PAsn2g+hBELGTRmjGYFws3quOvwnb6F1u8G1xOUdu9pt5ZR6bKStcgrbm4NCcVbUdhq7qHvHXr82v0MJOR9Qtyy8rfVs4fbrnpX
X-Gm-Message-State: AOJu0YyY3CyzYcYEKfNhkcSTomOcAjtKFxslEtNKx5SqrGlMDr6uUR9s
	lpGmAGSv9qgpuTskUiqa3KZ8NFai2dvguuTPa/HBy/eEhLIOzYHfX2c/7qRgY6BC1Y1h6bXmi4e
	UG9xnz1ytB/q0eJuMIjS2Jn8re/Z+ePmj4cRZ0+CRfumQxD3+wRLAovI=
X-Google-Smtp-Source: AGHT+IHrrmRCThSQvCIs9/0bi7IBCR2XvLDAtEOyqvrqcBzhpwhxDz/cYJqulQlLyovyFGxdpYQseqL0pB88M80bp4KTLV2m4JRR
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa7:b0:363:bc70:f1b1 with SMTP id
 l7-20020a056e021aa700b00363bc70f1b1mr190967ilv.2.1707911704572; Wed, 14 Feb
 2024 03:55:04 -0800 (PST)
Date: Wed, 14 Feb 2024 03:55:04 -0800
In-Reply-To: <20240214111856.168-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000757b5e0611562e3f@google.com>
Subject: Re: [syzbot] [dri?] KASAN: slab-use-after-free Read in
 drm_atomic_helper_wait_for_vblanks (2)
From: syzbot <syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+0f999d26a4fd79c3a23b@syzkaller.appspotmail.com

Tested on:

commit:         7e90b5c2 Merge tag 'trace-tools-v6.8-rc4' of git://git..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=1790f698180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=df82262440d95bc4
dashboard link: https://syzkaller.appspot.com/bug?extid=0f999d26a4fd79c3a23b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12fa241c180000

Note: testing is done by a robot and is best-effort only.

