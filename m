Return-Path: <linux-kernel+bounces-85353-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDB986B4A6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:21:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DB411C22742
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 16:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 289046EEFD;
	Wed, 28 Feb 2024 16:21:34 +0000 (UTC)
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5459D6EEE1
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709137293; cv=none; b=FtDiblMJ/1i3k+LI5aT+x3DCkQhf2RdrgUxDWodKF0rKWoR+DoJC1nqfJyGWfb3zdoinCqlTamqhsVpj2GdFsx4fynf0UnGc38bC76erwhEsrL87fFI3AA5NO4jSevwPFfghbe921aMeBCQ5/On/2gisjLSm4QBnfJ674Ezp8kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709137293; c=relaxed/simple;
	bh=nm0QIhozGeokRZEeYOZ32vlq1g1dRDypTQbyfbboVlY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=MsoeUBcIK/smajn74TNaBXCIQkOeeq4BMbooTyqwnVDuusBgWcb6HyjMomS4A0S84wu/D70g8mMDPj9kVwrLafSFTf7IJq2OkrwbHQCAKVu+UbGxlAe4SMpUKirh/SeeuONAGAF5fUoZjAHIuGEoT0K8Fl31MptDei65OE0Zrrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-42e520c4283so17678561cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 08:21:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709137291; x=1709742091;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D2+BZjLMLPbTol5136AECdswnej6ENJrpqcO+Did4T8=;
        b=q5DvoeU8jM6nDMn9J8Iy86iZ17h7FASpmRh+XQrkRcVLYpI0q0iqSlEy/nnNsQG48a
         A5NP78fxnVwkZZB8PD6j+or8K4Rg7QGsbbBiM0KaHzYMgNv4ds2JyyYCtjfJGjSO7Y0r
         10kllScL/yz++1KMGVCBrvOvLpt1rlQlegvywZF3m7sFYl9Lhd+YN3L0xZQ6zKy68pTt
         swIO8cQv9LVk4T0PFAMSVaRMvYUwNT/jwF/0gxD02FPrdVJ/n0UCXbRO7DHlOOvzelVw
         PpVCVFCMl6tLvN+1w3S5UNGMB85MAvXTiF5ElUARZhF7kP6z2lw96KWlMzkXODgt+h2i
         baCg==
X-Forwarded-Encrypted: i=1; AJvYcCWgckBXL85ARYv82wI6sDLj8adW0dvOB2O/jOcjNx6mv750Yi+8cnqWoiLwywz01RYXux+mk4QpCFkxvyJ2GhCYbGokuDb9tYPy2/Lr
X-Gm-Message-State: AOJu0YzNSh31p2GGZA+z4zgYS+K1jbQ6w9E2D9NHe/NX6yS4kxNyuS6L
	/jCaV2FOox+4rwIHLGTs7pxRXnJ63slxvp0YrMjk4KV6lyVTjIpRIC9hDjYLGlbb0E3ISsFr4Ml
	ws4QfERFIpMN0dNNHY3r36WOBJ3W+Da5bgD+mbMflRrqgU0ZOeMFL2rk=
X-Google-Smtp-Source: AGHT+IGlkaQCxb15VvCvtUjD5hXCn8zkfnnfuqU3idRbfSsF7m5N12Lg7/fsFG9dW79vLkDmOEpPcnTFxjGJeXE5lxUifLJZwae7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:9a:b0:365:616c:59dc with SMTP id
 bc26-20020a056e02009a00b00365616c59dcmr28337ilb.2.1709136784996; Wed, 28 Feb
 2024 08:13:04 -0800 (PST)
Date: Wed, 28 Feb 2024 08:13:04 -0800
In-Reply-To: <13add23d-af18-4f84-9f1a-043932a9712b@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f1426a0612736a90@google.com>
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
From: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>
To: bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tasos@tasossah.com, 
	usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to checkout kernel repo https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ on commit f2e367d6ad3b: failed to run ["git" "fetch" "--force" "--tags" "7b440d1b40dd93ea98b5af6bba55ffca63425216" "f2e367d6ad3b"]: exit status 128
fatal: couldn't find remote ref f2e367d6ad3b



Tested on:

commit:         [unknown 
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/ f2e367d6ad3b
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=28748250ab47a8f04100
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164aa516180000


