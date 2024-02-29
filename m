Return-Path: <linux-kernel+bounces-85923-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16E8286BCDC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 01:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48DFD1C22F99
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 00:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E9F134AA;
	Thu, 29 Feb 2024 00:33:07 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B608BE55
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 00:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709166786; cv=none; b=r7PjKiIDRQNeto+Pk/WoxA0FzetoqN1QZisjLDYLLrWyxPVdystW0yLJKF4wHiUScR0hV7iXnOiQOoovjYcHgQk0IMGGhXfVk0xQ1X5FKV/+7aeM5QNJUd6zITijqYhUzTuph5e3/n/Cvhv+425F6af/IEC+hp6VNN3l2OmSLSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709166786; c=relaxed/simple;
	bh=Jfy6IjRx/FSSVzO//9qWooWnRCudUP4MhW7bTV49z6Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=b6msI1+LzhQF6KurAeITO4kU9/8elBjRNpVM+Yr9pqxCZQK8OTxbWZkievH5E5soaU2JGeRN2RvVmuT7abeH3y8lL125mV2aUaae3T5S1DHw9jvIpxDm/NHRS5wRm7HPJDZVDBvsnhAdVLmrW2q+8ahcw6j3Sg/v/O87ABAJPJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7c784b01313so41673839f.0
        for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 16:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709166784; x=1709771584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0muDEbmiXwsrbOFIxJLnIjoJRKmx4ahL9Ls0vOb96tI=;
        b=BWjG0uMwhTjrK6GHz/fVWqhpLIqE7CJDqIEDTNlyrU4m1NJm9HDtCnVSC8zv/lEiJ2
         Dteqf83YSJJ6zzqr0zrGacRxABS7dwt6dDBCtdQZIv23U2+lfv2cC+v2AktyNyjTvHye
         TYL5dSBPAl7ytp990JyLV5MYe1fQMigiIZQWoHZGsFcKBSK3RqFM8zEcKAzlIXB3O7jm
         kJBLLqO7/88D1IR5eyYsDAheKO89Hyp8gr4H+4KGWyrakxiE/sEVC315tqDx2OKbg+fO
         Y42PnSjfmawKQAqFv7cgVEMDK6ojsdJj2HyTemppCwuaGGBD3KGLzHkyfVb/Unyn14a0
         YzfQ==
X-Forwarded-Encrypted: i=1; AJvYcCXIwq8FnMgwpXiubiqKwX0RSRiUmdOkfyl8bsToNgi0/+Kc8IhLoca+gfyT0nnGynyP5aK0XtcjQELShavL9aEjZmD3f8UBd38quYLy
X-Gm-Message-State: AOJu0YxnOCASPq1rzYEpvXwOt1e05QNHSy42vISS8XNsnmzk2LZC3AMM
	NfGGSURfU7HGIcxUq51rDGockGufT+L+uaZKKMN9VZAbJi9R/y4xBEI5J+wmM4KEZWWZJj6IWc5
	HD1DTUxXdh59vEh+V6qjzUCicSL2krdol2h/g4WTMM5rTUMpYAfNNa/E=
X-Google-Smtp-Source: AGHT+IFFoDjZa8al1Bx+sZkkysb9j6nUdYOliwAkJdFhkvEoCOjjuVFT5GoU0wlCz5QJGhY1RCmD052ceSyoFBQZaimruE/VsGA0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:365:1f8b:d103 with SMTP id
 x13-20020a056e021cad00b003651f8bd103mr42319ill.6.1709166784685; Wed, 28 Feb
 2024 16:33:04 -0800 (PST)
Date: Wed, 28 Feb 2024 16:33:04 -0800
In-Reply-To: <380909e4-6e0a-402f-b3ac-de07e520c910@rowland.harvard.edu>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000102fe606127a67f6@google.com>
Subject: Re: [syzbot] [usb-storage?] divide error in isd200_ata_command
From: syzbot <syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com>
To: bvanassche@acm.org, emilne@redhat.com, gregkh@linuxfoundation.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	martin.petersen@oracle.com, nogikh@google.com, stern@rowland.harvard.edu, 
	syzkaller-bugs@googlegroups.com, tasos@tasossah.com, 
	usb-storage@lists.one-eyed-alien.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+28748250ab47a8f04100@syzkaller.appspotmail.com

Tested on:

commit:         f2e367d6 Merge tag 'for-6.8/dm-fix-3' of git://git.ker..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/
console output: https://syzkaller.appspot.com/x/log.txt?x=15da3dba180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eff9f3183d0a20dd
dashboard link: https://syzkaller.appspot.com/bug?extid=28748250ab47a8f04100
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13287836180000

Note: testing is done by a robot and is best-effort only.

