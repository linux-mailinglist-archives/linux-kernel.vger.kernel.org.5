Return-Path: <linux-kernel+bounces-116467-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72E35889F39
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:28:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2DCC1C36284
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:28:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2038F48;
	Mon, 25 Mar 2024 07:31:50 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645B7525E
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 03:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711338844; cv=none; b=txeYLGEX+og5A6V7YPRxtgF5ktYXkAXcB9UMglnQMejaGzIWLu9H8OyoJ8m8uFUuuSJg7p+Z0/iiWQ+8aZe7kNGynEuXRvUDdO51j4oofYHIiGXnDRrIByz6U2Vq2ccr6Aqf/dbhnX1+Tub31ooIpluJwb00uEznJH3V5cFn9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711338844; c=relaxed/simple;
	bh=RAulFATBP8ENmBB14b4I535VVswM9Co/gYI+KGYvuSs=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=epDHnewWHIsfZqmf9dhb58qVbW82nCD2VUfXrhz1MG1S0h/ry32uosYJzGhndzrmGbfhMbF/vshoA3wqZAnqAv8qOoZ7bxhy/n9W1GyWPSQSlfb7RfpURy6Xbq1P0/MqjGOLlGVSnZ8lyMKDrlj8KkVl2qjEOq4SKWudqpB67tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7d0330ce3d4so249482739f.1
        for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 20:54:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711338842; x=1711943642;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rfMJa00nqm4ZuvIYdwpoNEppIoTF/0uunyYBH1QfJQI=;
        b=oOy7ZEo2WI+i8x/WHlYnGWPH26sstYdzp0+y6/VVl93qdLQcSeaplCDptuCPaO64Mk
         JkFwoJ5R20OGJYzubYmBfHX5B8iXzgiWQBO8dJkE06J9DYOT4n733Sovp5rQOvBOqJWm
         uZu1fmZ4jt4r765gsi/gH4NY1za/eOM59fSqC2765+RwACW0zfVmNSUXJUs1N7O8i1XB
         8n+iO89wQ8AYzU7G4Pb6K+7vzSYJlA2lcrewd7mJEDFXGcQ6wQ4mOKKvR3G2YP8s1llw
         gybqc8K3mj8c79cCCgwRLlcjePqTIvmq1tPChu9T1c82aZ+VWS7PPBkej+59naUoZAz4
         s6nw==
X-Forwarded-Encrypted: i=1; AJvYcCWDq4ykrcU0tyQv+/jkG56f+hSB2qhj8lmlQMWLzLbjwg5RM58/DS0M9L1Ozk/OE70gNDskwTeen2u2sIaVoeQHm3nrX/x/KVqLU4MO
X-Gm-Message-State: AOJu0YztkhdColTYJypZD0IYPkGVdybIQUJBdB8K1p65Kja97M+DE+jY
	FnuwPl9N/M3Xj+Kh3mHxL89JhNusP1lGrCSiHLoqQHjrwLFI0UQU4dFNyoBUVRaDtD3Iv4ntoiW
	XsgNegZ5kW03hpsa99ilgrxCBeTUswwm53zyIJHNh6fseksU25gEYEts=
X-Google-Smtp-Source: AGHT+IFStHcjNvvk5QRAicHW8LmXuPZ43kh9a6cZmOI7rN49wVzpRDVi15yRQFUVUg8qJukFFgCjCjf3i7XKVyK3Ny2z4FO5Wl8v
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:150a:b0:47c:1bac:c727 with SMTP id
 b10-20020a056638150a00b0047c1bacc727mr128126jat.4.1711338842430; Sun, 24 Mar
 2024 20:54:02 -0700 (PDT)
Date: Sun, 24 Mar 2024 20:54:02 -0700
In-Reply-To: <20240324231006.79378-1-cam.alvarez.i@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cb31ce0614741f84@google.com>
Subject: Re: [syzbot] [bpf?] UBSAN: array-index-out-of-bounds in bpf_prog_select_runtime
From: syzbot <syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com>
To: cam.alvarez.i@gmail.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d2a2c639d03ac200a4f1@syzkaller.appspotmail.com

Tested on:

commit:         9187210e Merge tag 'net-next-6.9' of git://git.kernel...
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16a2a7b6180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=222448ff79dba2ea
dashboard link: https://syzkaller.appspot.com/bug?extid=d2a2c639d03ac200a4f1
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1557a979180000

Note: testing is done by a robot and is best-effort only.

