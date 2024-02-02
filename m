Return-Path: <linux-kernel+bounces-49138-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3426784666E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 04:16:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 605691C24113
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 03:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2309DC8E2;
	Fri,  2 Feb 2024 03:16:11 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36BD7C2CD
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 03:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706843770; cv=none; b=eZiXFbCpmByfYegVd4vndaZyIFdjhOVcTgTVsWg3CO10H7s1XTUtnnK/7JOqyc0VO3m9i2ISFqhKN353tqW03SWXcH30KJf65gLqj+ht26bDcZOnX36K97P0b5YVnkVLiK8Bx0NE/64nU3yF5diezkW+asQHPdItPqSO79r2GO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706843770; c=relaxed/simple;
	bh=hRH8z0CGDpBh5Pg4CWenL/clDAB+lvyYzuERxsx3zYg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=N2M++qi9iaMQPnKyQE73QJF1/TDY3ivGs8y3Drq3VTQdnW28C8bbTpwo5WZZdCETTs8viR1KzUomZ9dnHHw1QiU6M4v95TDG5fl/cSfTb8BCozGUS+TNzQpgadTirvYju3csY62MfdhsaZPuoXZDNEvKxuXoOd+zbx5qvoiUdCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-363ab88c5b0so8498075ab.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 19:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706843768; x=1707448568;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hNTh82Q50FGeOQ0uxlR1JVA0g+Lrvi8VKG5mDfKH6To=;
        b=MMzKX47GXxkRlGeW6tzqUDeYQOqNbcZkA1+DraVJR/xzpXS8UAfX4ei5tKFxp5cvUp
         EL1xI9WWxY3sp/SXpA/ECJdVRdKalpowu3JHWpevBXi2XrRNJC0OVc+C4PRj3DpAGKon
         dC/73gfzd/0karbcEdMjSmmxOvoKpOC3iO1U0cayf0FN9ElvXOZv9EkDFmVAcVjirAfY
         TuSr2i8xnYaVaYB0TEF+BDFoZBEPkfga76r3G9TAeKEyhNWQxm1XEc8P/qT8Wo8Rq+Vf
         WkwrV9EczGRxUQXhXxRuDZe5Uahhj6J1hbYiM1Lg2LAFTPS/pY54xEb3diUGDbsOZ1NO
         09qQ==
X-Gm-Message-State: AOJu0YwshKu5TffcZIuBWqV8qPZGHD96rT2NVNIC2v/DuNP4nfo+YinK
	QVcLVLcw1iojtvYsQPeGdjJQR7wXwznGcZRfoHWBaULEMzA7Uw6jrFhlNC9SPaEwFR/kpkXKaEw
	joXrOUsNo+pEU55g8k3y5H0tzk/neCwm0/6u6MZfHpygvou/hxvK8Z2X8RQ==
X-Google-Smtp-Source: AGHT+IFoBV+yKuRhED0KZlH6rWY0juqKzQRPnh5csdK0Al/tRfwHf6G/ImjX17qjydVhGO2lHIX2KZjibcwi1lLMD+MOgvXwOpVk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144e:b0:361:a5f4:bab4 with SMTP id
 p14-20020a056e02144e00b00361a5f4bab4mr670388ilo.5.1706843768397; Thu, 01 Feb
 2024 19:16:08 -0800 (PST)
Date: Thu, 01 Feb 2024 19:16:08 -0800
In-Reply-To: <20240202024950.941119-1-lizhi.xu@windriver.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000080a6e906105d883a@google.com>
Subject: Re: [syzbot] [ntfs3?] KASAN: slab-out-of-bounds Read in mi_enum_attr
From: syzbot <syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, lizhi.xu@windriver.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+a426cde6dee8c2884b0b@syzkaller.appspotmail.com

Tested on:

commit:         02153319 Kconfig: Disable -Wstringop-overflow for GCC ..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=101765d3e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ac580c73b7cf3629
dashboard link: https://syzkaller.appspot.com/bug?extid=a426cde6dee8c2884b0b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10e774b7e80000

Note: testing is done by a robot and is best-effort only.

