Return-Path: <linux-kernel+bounces-56421-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5E0284C9F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:52:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3FB541F27BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C34C1D52B;
	Wed,  7 Feb 2024 11:52:06 +0000 (UTC)
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB061D524
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306726; cv=none; b=FMQh/xACFzy05+c64YrGQ1H+oxhielrHENSqqbnn9rcr269g/fKBlTL73Y15QG0dJYujKrLLwIuHP0TcINM9HR0gs/KLL+K2pkGgtU8/Gg1v85nPO/O8RgbSsd5tFIQqJdDCI9ERra9mh/PgWxeaUZJZjG3/AZBWFYRU0tbGz2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306726; c=relaxed/simple;
	bh=JyyB+xwzTfWceLKzrVoFyYUD8McBiLaCxrGO49shQ1Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=F75Tc0MpFHgBWRjzl1FZWEQH+ks/wvpO0gPe/rm6F4koyQJRy5UON2NAhWH3vGTAIzlyzVVtfArqQt19VJac/HTqovj1wXDzx3i3uBnA4GqJGseeGwumXflQqEkyZ6EP1Qf5xlxChr7G6fQ3LX/8IUqoMhHidEW98VrSE7WrDYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-363d86bef43so2518315ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306724; x=1707911524;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YYjWeZ/hZEvaM5rvBaNC11crdBcOmLYiQvMupK8SDMs=;
        b=duzYzfmXSh1OLKrS8/p2vEzPrKlPqVk6kMj2RMEe4dDGUsxTrtKwyt8zSg0LlcJW9s
         Aj4lExlnRF+T0UHyqG21st7Eef2yOg9UqAK+HaE43Zd693MFP78is21FlSKVpyBr/0EN
         7etrAO34K5RDBv6Q/GiZZxzpVQkNOx6X+qpbiijEENZR+Z9l2JNhZscu6vhAo8WSJLGS
         CjQn2estEhuDLFy3Z2Peit/gOH0h9YdMc1bDhNaHdlhDT7TzNUYaSeJeACjUNvtgyMGj
         rINe5IeNR1CQs7ItuRq+qrjQIGrC0KCXALno4Vv46yifRbVqdi9Tv+kAWWOT6mAKSyN6
         qaXw==
X-Gm-Message-State: AOJu0YwTmEHonmFH5ul9YH8sXmoRchcoNl7tlH5CJcdiWus/uYxCqsd6
	NYqIxuaeCCSWw7vilEqeV1zaa0lwUIcMu5NC/AwpMsj+mwrQLJzlisIWGvIY5N4pYKY+T9VBCCy
	Ov899eVPF2mme75tlMnotnN7DJNcZEcng7aeM0oW72JPACFLHqa/LEyQ=
X-Google-Smtp-Source: AGHT+IFw8HXwSFcBftnlV/RhW8Iy6rHtZpG8DlCt4YFa5TIHMnyAiSIf3K6K01l93PaAzYabLAOxysa9v3BljxgEwihUoXTyJKvT
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a09:b0:363:96ee:cc55 with SMTP id
 s9-20020a056e021a0900b0036396eecc55mr352541ild.1.1707306723917; Wed, 07 Feb
 2024 03:52:03 -0800 (PST)
Date: Wed, 07 Feb 2024 03:52:03 -0800
In-Reply-To: <20240207113405.999-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000cd471a0610c95277@google.com>
Subject: Re: [syzbot] [usb?] [fs?] KASAN: slab-use-after-free Read in comedi_release_hardware_device
From: syzbot <syzbot+cf1afeda4043ffecf03e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+cf1afeda4043ffecf03e@syzkaller.appspotmail.com

Tested on:

commit:         ed555127 Merge 6.8-rc3 into usb-next
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=16ba118fe80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28a3704ea90ef255
dashboard link: https://syzkaller.appspot.com/bug?extid=cf1afeda4043ffecf03e
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=131153c4180000

Note: testing is done by a robot and is best-effort only.

