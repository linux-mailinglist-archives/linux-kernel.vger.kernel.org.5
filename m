Return-Path: <linux-kernel+bounces-100250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 371A4879405
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7571F22C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1030E79DDF;
	Tue, 12 Mar 2024 12:18:08 +0000 (UTC)
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45690BA28
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245887; cv=none; b=DuxN0EqdPbsB5CTxwbRXH9ZkJnWBER9QWv71nllcQx8WfxbZYlOIE9ecNZvul3ryLh2yi7c52YighZjQkFcg8qoTsw/aqhjKqkFtFNrZKB1KvxWp17Dj+98p3NJZfYkHScvZPnTEcAJmWlZqtMiwr641dEC/qVJEy4/IxdLDi9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245887; c=relaxed/simple;
	bh=BMNa0iqqTNrrPepLo511+eVYUIjH/3QtTo0U/lgEWf8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=GU46to/BZBITsfGLD2DTY8Gpy+fsQomFsZtebMpAXiBjcxGbdpRIKRlCnJPY/kMYZ9bB4jT1KoicIOwiy+9RYrYPmWARJmWhbHgpBFALUgHtDXNDOlYgde3i8PMIgdgmNb0R2Q6NGX3BHqgTbwV8oPafmU1Z8gqxe2TyDNKGvM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-36630680c5dso43741475ab.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:18:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245885; x=1710850685;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lZjmdDKkotI3ZTVxyyTk6+8Can01RLGsOA/I/QirXVo=;
        b=CWcADUsj5pIV/wEvzH7L9jxA5CkysLv2U5lbOFgaGktfqis31bYG2NDoLG98DWqL2K
         qsTzR5FKyRxwtUvQu/nRlww3yW+R1rPUtG8SFNkRYEvkgl8kOP6SweATfl4EoVliplwc
         ER6rY+H18IoNQHOsUq12kMZ42wFxL2dys+Xvm6s/23reaVjk8e+4E+ZZixsmqLYoxOYh
         9qulwaQ2m+Y2B6xinpmWRZ0I4L714rqZSu9QHqejtHyI30+FyhT/YB5+RTWcASja3WBs
         DYpUhlBDixXKnj9tF+WnEcA0DmDYq6FuzrcyikmIN3QXuuqlSLC1OG+QffZR9DoBZoJu
         qHWg==
X-Forwarded-Encrypted: i=1; AJvYcCWLWpCX8kfOu1TAia3ybhOUn0bRGKJxPyFTt1Hk8m/jEX98WrAgl1jY+CT3nBUk9Qte+iz0FZZWB6KfAciDVnAY9FAuBtcy/dhng7ev
X-Gm-Message-State: AOJu0YwaHw5dsHvCI0Ub+/L8FQZuyJdhJHACuXE6y7uFD7gFc0yji9j7
	D5YI6lz/S2nExEGtbytqVkHTSiu0M5Qw5gD2aXyxM1VuCwe797opfeGgHY4CiFbPDejBfGIyXx0
	H0bcLGkWbtprdA19OGvIgUOpaXP6pthTuToZX3N74rIDMVucqpHCngDI=
X-Google-Smtp-Source: AGHT+IHL87gV356YaBphFDzY55qV7bYcBziIOkKAW8kN+lCCopMykpNRISZZUZwXdMCjcXNfZe+bg7fmtTmtP/VzCfiUoOFOdeQt
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d8e:b0:365:7607:3f4b with SMTP id
 h14-20020a056e021d8e00b0036576073f4bmr471774ila.2.1710245885422; Tue, 12 Mar
 2024 05:18:05 -0700 (PDT)
Date: Tue, 12 Mar 2024 05:18:05 -0700
In-Reply-To: <20240312112003.2116-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ac1c5061375a605@google.com>
Subject: Re: [syzbot] [serial?] KASAN: slab-use-after-free Read in
 tty_write_room (2)
From: syzbot <syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2a81fdd5c6ddffee3894@syzkaller.appspotmail.com

Tested on:

commit:         855684c7 Merge tag 'x86_tdx_for_6.9' of git://git.kern..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=157056fa180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2081781438cc5e28
dashboard link: https://syzkaller.appspot.com/bug?extid=2a81fdd5c6ddffee3894
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=12651646180000

Note: testing is done by a robot and is best-effort only.

