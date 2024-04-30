Return-Path: <linux-kernel+bounces-164287-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9E168B7BB9
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7289F288A67
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:35:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11990177986;
	Tue, 30 Apr 2024 15:34:07 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45DBA173323
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 15:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714491246; cv=none; b=gtKEkRsGmvJUtGTWa+GPhN0DPZM4GNGZHpsdFsYnRs/sjFDVTv2qv+7++rQyboRRSETyUENDTUTGGJmaCbLrh6MmCCfojOmysNTpN57K6K86oPMKLgGqMtZXFZtdhFnYYhOI5Avm3nsRkg4Fy1SCf1rjcZQfXLu4jr1NBfmM/+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714491246; c=relaxed/simple;
	bh=a6DG9EPp4LHYTB/kxsAFKGI/bMa66Q2ti78x/l5uuPU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=cBuQNtAppaA8Th1psEn41GaGhg6upPUmZVesSg+VJ2O63y8wiiP9S+LnY9sLsyM5zKWm4yJ9I38aNdTRHpwditov3vNLbIWV6EbFMzHbrHmxaz/YfNi5Pjr31OeRE9TOkeBRrOEyZXKJr1TN5XLzwQYTiMhD2tQPOT3+RXAF2R0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ded1e919d2so171725139f.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:34:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714491244; x=1715096044;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=73/i8lvVOuC8hjg79AFxCLGnH8urzBqAKlmV/iHDX0c=;
        b=PKvIIXQoSzaX1aGPqQasdedUNNdHWpaaRhcEWONZLhwKlsN7xW26fCurG7+COam0PM
         Va0z9KPgNMsAVhJrvjq8YzLwBj7iOt7F46z9uJuJVVFCSYwQ/85wf13CP3HCH5Le4Bj/
         hejqcNrvmlX62d7KZDd1LunFnfIqqkcy6F9ABeazcccXEUtcH6YfJlyf6S8K2vq+eSRK
         QxH5PrtywXfaF4ME5qs3FGz38J5YgiH72v+L9lhqSlYq03fGlTZBZAMJAnXVTehkk6I8
         ZBgdtxbxHy6DGSmchTn5PYLFyOhkPSmXFaqFbTCP+Ga/a+UYMM1J/BN1XEVVuefRJY3Z
         qy5A==
X-Forwarded-Encrypted: i=1; AJvYcCWv4taa7Fs1bfszuNTGcykEa2OV3ESwfPEmQfNRhEtdJe43wrITlrMxJx1M7Uv42vsul/zM5UK7fQQqb6RV6QCWtZ28i++rTLz474Yw
X-Gm-Message-State: AOJu0YwWzq7SGQmtXKnzbNhgeDOGgoCz7pQ4aoJrBe6bsvU8djgIkeO7
	qdqIBw1goVXD0MwjzGM49KWdGmxYVZ5z1xvkvWpQAF8GUD54YcyY0ASsg/qj5MaeZ4LLWrdSWtm
	mzBExxwHEECg/a2J+qCtdTtorUdlWFvPIJeP1ucJ2RYtf3W5BwGdSdo4=
X-Google-Smtp-Source: AGHT+IFT6h7ZDb2MDoE+pxGGfV6zYscDfaWIAYF1HL4AI1FqqtTQ5xPZ2w2jRux1KW7QT9ak472bheBhz+H8iaq7nortT6JmctTB
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:610d:0:b0:7d6:3ef7:a80c with SMTP id
 v13-20020a6b610d000000b007d63ef7a80cmr69827iob.1.1714491244391; Tue, 30 Apr
 2024 08:34:04 -0700 (PDT)
Date: Tue, 30 Apr 2024 08:34:04 -0700
In-Reply-To: <tencent_DF766FC02FA16CC095BCE976EF5ECFE8790A@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000097bda906175219bc@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=14312937180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=17e9556b180000

Note: testing is done by a robot and is best-effort only.

