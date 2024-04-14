Return-Path: <linux-kernel+bounces-144056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE298A4154
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 10:43:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8BCB8281C18
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 08:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAA7723769;
	Sun, 14 Apr 2024 08:43:03 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29ABA23748
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 08:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713084183; cv=none; b=TQTcUvkXeHff1rpYZYUizODp90uUJKFMT0soPLVXcfKr7LGFWby0vt8C4FX93NGl7A5AVbQJ66xSJOv8jvK/AZOaeCE1w3R/5A875VbSEPPXxDD2X9i2Nata64wcTympBx28M2jczaM1e7q6+rIbvXoIqoVvHTyqYIUwrHZlONw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713084183; c=relaxed/simple;
	bh=uSPc+HdJ+Rb+EmYSDBjz6U2QTfpqZh7JyX0077Ua1II=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=BxLcm2DOjUsiEz3RgDkCq48TL4oIhHDrEYaLlaabIf4mKPIwIHm27HxhQbQ9QBaVaUiHEbI015G//e9NJPiBt4Wx9/SV5p9uavObEOAMgXFmq2lbvw8vfMucrCjQ4C2zxss1RwhaKAWx6O5PmekB/scPfJ9ZSRSo6TcLUxSKxi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-369f9e8863dso18694375ab.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 01:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713084181; x=1713688981;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SxwEwJN275TCCeXDA//pQzCNLF8B93UqBEls/FsCpJY=;
        b=voxAnEQF1nulPuNK7F8VEcBZVScFMCk4iX2SUQZmrNaFfrTpfvz3NJW/iFJgIR6tI7
         eC6p712LNS41GWnPawg4VmwHgeKrTvSAEVpcFX9itmjNncXNZbdrjhHH18RqKRYFbfPe
         ERhlXjAfIgoAXhVb80NXI6n85dNk/AiPc4cYKdCqvRTSd6weUZClx0zu4Jl6ThfMvIGv
         G41bcQ8yZHnNNqtWHITPrVuv+6+VftjwNwdk5Bx4XkNPM7JXP/DsCiSReu5RTf8cXyYf
         RCNcNPIk9kpZCRi7Pg7X9cUWw1o5BApCxaLMRdTNXE4KYGR5BGUKyO1gqp9/sS5XHU6l
         m7AQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6VWnyeMFnQ5jzdPixCc2jvsJsN9RUhvEjal62QLvjBeF0BJsPGAexszp9NRFVwdsWofoIUIBlBZ68bhPrIRitv7XMG1RGMlQOWgUp
X-Gm-Message-State: AOJu0YwrTZNWG8WlcW2a+ixBM0OEdoIoHScBxMqSpzKwgrQ3x86hYbxV
	dMR4GX9ej+MnUouqMUQD2gKG4/QHFTSw8WYfJuNNA4EVPTlO0X2tUMULaIDGvQ813ggh0sH9Xvn
	mLaQGzs62AaqcgTkf1i9siV/o/+FK6TjViO67LtQmLV/a3Zboq+CJV/c=
X-Google-Smtp-Source: AGHT+IEzRDbF3EHKpvP1cNGKRVQ3CUbAtFDXsXt0T4VyhXpb9pQfjotc8C4HWMWWehCw7QrEzI7mfjT9J3CiZKR4qcMSuo+YSLxv
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a89:b0:36a:220b:4078 with SMTP id
 k9-20020a056e021a8900b0036a220b4078mr591904ilv.5.1713084181479; Sun, 14 Apr
 2024 01:43:01 -0700 (PDT)
Date: Sun, 14 Apr 2024 01:43:01 -0700
In-Reply-To: <20240414081317.2137-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001b926c06160a7e73@google.com>
Subject: Re: [syzbot] [sound?] possible deadlock in _snd_pcm_stream_lock_irqsave
 (5)
From: syzbot <syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tiwai@suse.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+faf0acea764965b3e59e@syzkaller.appspotmail.com

Tested on:

commit:         fe46a7dd Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=154d4961180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1a07d5da4eb21586
dashboard link: https://syzkaller.appspot.com/bug?extid=faf0acea764965b3e59e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12c77a77180000

Note: testing is done by a robot and is best-effort only.

