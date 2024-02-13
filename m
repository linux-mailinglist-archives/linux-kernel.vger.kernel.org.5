Return-Path: <linux-kernel+bounces-63792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC02B85346D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59274281AF6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A8625DF02;
	Tue, 13 Feb 2024 15:18:05 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58BB8376F3
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 15:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707837484; cv=none; b=Foo3eyn9y/Bh9do+uCnnV6f1AG+jHk3GyndyWSFXku+2ucBuFPi9aTsLbLcNJObuwFM4lKeByufc6iv+mLgu2MUCQ/reZSnnEDA9EF5uMirHV9PpZp01Zi2TujcdwWkhhMxVgtbvzQmytUFFaLeh1wkGqyjrROb4+lK7yufJkpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707837484; c=relaxed/simple;
	bh=9N4yp46I09Vt1zrhKDIWj0X2m/kxgdfQNfr7b5+kr38=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=g82VJNfAgKtChXiEx3rBmEJ6ImQlOqlryjn+QzP/7l15hOMHrosWrKlPF577NcfrSZ433kNQcafrkDnXCcfNcfZiHcWzI3aplZWbytGRm/0GOXzfDSYY6ysmobKE+BHlb7I5MRSyOFRKRohqZ9P0kRv3gd9X2V/lRLkLxHo9MtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7becfc75cd4so451494539f.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 07:18:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707837482; x=1708442282;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jQfwFmebYPn3o/3uDpE7555wz6xNVQRlELdxUcPOe+I=;
        b=PyHkYOz6f/JjfZC1WDR1tWllic9yb+MoljFZDoB+RVIV+tj7BxB+3gnOIhwE4ihTHt
         qR8jyheO021A3rXnTQDQ+lz7mEWuDgmt0ZbOrKQGqQkbGO4b9TBqhH2I0oi6jNG++eZT
         btnJkeAUiGY784HUxjfU8LFbwDtSOEOuBS2wbNOPZKjhqqL+iJYrWOzd6dFEaMTGHe5t
         Prh0W39IadPmdYdi0CtCKV26qPx11Q7HZWjMAT9SMueMYeHelnwwCSeUPJ69Oiy7zboq
         BN1Nc+J2EIrlDIr5rKayKZT7L4MOMdtqCo9ZA4pZLIlib4zxQqL8/gVQ1J2g7nsaBQIS
         VedA==
X-Gm-Message-State: AOJu0Yx6RduvJSVLz/k15GElFDXFwFJFP30SiVKkTNm/AytYaazP+/Ay
	YAadycpA266ImsjFguCTtAq3UHpc4UigcyUPUhZeM6qoC5ZJ7iajWLL2ZE+avhl28ZE0PLT8VoS
	iq0fmqh/oTvBbMWDatN6DNu4LWLsTxG9zn2l++TRq2NWD/tUULxniLrlYYA==
X-Google-Smtp-Source: AGHT+IHi0mK5qk/NG+QxVK8m7V9yXfAE/FH+15pSjYDcKZnn147pheWscJ8fmuN3qyIR84hssIZs+hkLn0bT1WoIYQbwvjIX3jPa
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:480e:b0:471:2af4:a41f with SMTP id
 cp14-20020a056638480e00b004712af4a41fmr128294jab.6.1707837482384; Tue, 13 Feb
 2024 07:18:02 -0800 (PST)
Date: Tue, 13 Feb 2024 07:18:02 -0800
In-Reply-To: <20240213141705.3267-1-n.zhandarovich@fintech.ru>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000078c7af061144e6b5@google.com>
Subject: Re: [syzbot] [wpan?] KMSAN: uninit-value in ieee802154_hdr_push (2)
From: syzbot <syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, n.zhandarovich@fintech.ru, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+60a66d44892b66b56545@syzkaller.appspotmail.com

Tested on:

commit:         46d4e2eb Add linux-next specific files for 20240213
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=16edfe42180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e558550134480d4a
dashboard link: https://syzkaller.appspot.com/bug?extid=60a66d44892b66b56545
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1096c324180000

Note: testing is done by a robot and is best-effort only.

