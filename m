Return-Path: <linux-kernel+bounces-100423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AD879754
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 16:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DAA21B224D4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:18:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 799C17C09B;
	Tue, 12 Mar 2024 15:18:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B527C7A71D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 15:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710256686; cv=none; b=YIJb2+aOCcgQ2sZL/bsOkxIlKy65mNAt5Iw8AP2rjAjeK8AkeV72tLdVnfeJoqhRsqorYsc5iJUGbDrH/uv8bXX+jxZGx2I4G9Jmqf7CmkU+vukNE1CUkvBwFa7du5rMcWvOJCY7XGyfyw/LV/59bB3X2mUgEUwkZxPmk2IrGDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710256686; c=relaxed/simple;
	bh=buXPkvpfvxrAsxrO5udnDoFbareGFaSBnFcStr7xiig=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=bUfGwshZpsZf9NtVDn0wOBYTBIvONtYx4h9hBa36rdrjBlvYE+faqZu4ejHpsxESbiI3+LgG1F29bH0SH9QozejnyS4FjRoVehEYzFxiLeBw68WfWR+cIvALfB0ZGlKoYfz7wERhVVBSevV8+KkUchs+OVaOqg/uRKRyMDEA4nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36660582003so20583385ab.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 08:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710256684; x=1710861484;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=16x60mCGx6riT4OHN40JAzmKXSCIdz2dUQK8j9mBb5w=;
        b=AtSL2WmDWaw0KPGA03A/X/8NfsXATRe2XOhRwzQiSs+EoRGJG9SP0a9CHTpRQYMzzK
         lU/V3DIB4sNIlQjyVQDhGlmnLI82A7UAZs1kOMEZotX3vjRqLPXKGFq5gilJzi45EjrO
         2lQCs5G6g0eMOWIjnPHQit0FG+pkuMIGrviioPTKh9tU59X64htn9Cgovkd6t28VhYSo
         7UxT1mo83XFs7AqCGnCJNOtD0r4Y/r0OGZpDy0fOOuwxd6ZH17JL9ggN0BIjwZZ+TWi+
         /6YdxFjDkP+X8wqTLTA/0AOj17YBzKmOsE3lMBubeNAJhJ/A5aqBSCtOm8ISwOU2zWBL
         Mh/Q==
X-Gm-Message-State: AOJu0Yz7T94LTBKks8dNdQAqUZ74J2nX3qtBLyp10RXQfCRE062OZ0aF
	ecsl7NPwYlNK9jJ/4+ROTbyIa4tSKG9k+vk381p9FNsUwBKuf96sqEVTUAStUBoDjevaEPogdfZ
	WpV4t4DCR1t618gvPWHvAHeCLYBik+VmkO5lg2d3GdpGCiMfe/quHMrRl7A==
X-Google-Smtp-Source: AGHT+IGxuKzwqtNZMHgATMHZxMPIs6Nja85daGFU5Fy05Oi9YkbNZeReS9EN+BPa63saOBha3NHy9fTVBMEH8/F6aHQ3Wk/lrCVF
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:20e6:b0:365:1f8b:d103 with SMTP id
 q6-20020a056e0220e600b003651f8bd103mr354170ilv.6.1710256683935; Tue, 12 Mar
 2024 08:18:03 -0700 (PDT)
Date: Tue, 12 Mar 2024 08:18:03 -0700
In-Reply-To: <20240312.233252.1252431549899302393.syoshida@redhat.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001f0b830613782a47@google.com>
Subject: Re: [syzbot] [net?] KMSAN: uninit-value in hsr_get_node (2)
From: syzbot <syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, syoshida@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2ef3a8ce8e91b5a50098@syzkaller.appspotmail.com

Tested on:

commit:         9f8413c4 Merge tag 'cgroup-for-6.8' of git://git.kerne..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=10eda48a180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=656820e61b758b15
dashboard link: https://syzkaller.appspot.com/bug?extid=2ef3a8ce8e91b5a50098
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=130ce669180000

Note: testing is done by a robot and is best-effort only.

