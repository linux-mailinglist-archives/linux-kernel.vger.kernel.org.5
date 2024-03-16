Return-Path: <linux-kernel+bounces-105243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A559B87DB02
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 18:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 384071F21BCD
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E16271BDCD;
	Sat, 16 Mar 2024 17:18:04 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4431BDCF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 17:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710609484; cv=none; b=ScJqNu4V/yufNJDT4TikugVR3I0aiZd9MsCw49mb9NkWHyhnOVw7p3/te3oSrerjen0ZPz2cm8mvjznFAmNC3OHaj8GI3Q8dwCFS06V67DYhU6/mVoeMWJ0Yjbwt8xeqKnYu7ETLJZcpa47ycjIX+t0DEn+TPXh8d9IFgEzHtDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710609484; c=relaxed/simple;
	bh=rdXGU4H11/Rq5F0nYUcD2gQwSnehnBMG7uxvjVyx7Mw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dhkoL2c8AkK7OFtuJHhmTD2CJ2EA+mbEBnU2ADhSsJGWkUnODCfSTRiairp1sltkjwcGMZ2/FwFXCeL4uOZi00ZHO8ZHrj7YEOhbAmN39uC2y+xuYj3y9tGjLm/gTfSunY2YY/ZdVI3sOFxqXs6kQyEhELrWo3esftca2BWEFCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3657cf730a0so34628915ab.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 10:18:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710609481; x=1711214281;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xhM0gim6EF1YfH3MdtafDzmojNURjVNL+R2IpqotLCI=;
        b=XcafxEp7g/fm5UFxQs0mkQvegDW3uY17eYxx2TU9Mu0ZHnxi6WEGwXIQsTav8qI+o5
         Fbxsii8P96nkr0ekjF3wCnkQ4w+Tw+ly1KwzxBYOo6rRshxpQ275UNI8sEnyoC2a+tis
         hSSK5KFwOYoKicoNuAcFTOhryG3wHuqRb9fMyTcCTNIv0biMLEU8i0/dc9ZPGZXtyGYl
         hgqvC7EmiRltgcsWB+bJW98X3oifV4sEyrRT6AzDcQHFlZqztc6I72pttQ6eCUgYQ84d
         IcfrcBFaWjvC+tfTOYTaWE5qPqBeKYsEI/JRZb6/l/soC6EA9TivSh+v5aZeGTgMekt+
         sS6g==
X-Forwarded-Encrypted: i=1; AJvYcCUq1343eErFfU6RLAunbuQp1/b237LRkZzBJDFEkVMfCYxtBhaE8MGkZbHBN0NhVDaL9v/iQth3NmfLui0naTd6A33ZZMYK7Th4i6x8
X-Gm-Message-State: AOJu0YwhNJVtywgFfdAqjjaWOaRRj6EXcSkehkW6f0xOrRZ/O+ntRJWU
	ABUmxNUa16AxUj5iRzgF+CDeS3yshfK+kjC4RZW7clHuaFOfAHQ15uFzrK1PSjXcQgB/KH07u25
	1Wrf3/El1G+2Kr5n3BGMYRk3GTe4c49BCpnBXoAJCNZeexNxEWvM28j4=
X-Google-Smtp-Source: AGHT+IGbh8CgYLlXYyb2rdwY1DPoaPJm+/aXkkT4BfWZP495D8dscBNjGHdwHaTcSCwqHIzyDWtSgRN34xGRThIX2K3Qd0gl10B7
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:b743:0:b0:366:a4df:fc93 with SMTP id
 c3-20020a92b743000000b00366a4dffc93mr94888ilm.6.1710609481540; Sat, 16 Mar
 2024 10:18:01 -0700 (PDT)
Date: Sat, 16 Mar 2024 10:18:01 -0700
In-Reply-To: <7c16c203-8b5f-41cd-8c86-cba36887b505@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007f33eb0613ca4e5c@google.com>
Subject: Re: [syzbot] [io-uring?] KMSAN: uninit-value in io_sendrecv_fail
From: syzbot <syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com>
To: asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+f8e9a371388aa62ecab4@syzkaller.appspotmail.com

Tested on:

commit:         ae551333 io_uring: clear opcode specific data for an e..
git tree:       git://git.kernel.dk/linux.git io_uring-6.9
console output: https://syzkaller.appspot.com/x/log.txt?x=12656231180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a271c5dca0ff14df
dashboard link: https://syzkaller.appspot.com/bug?extid=f8e9a371388aa62ecab4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.

