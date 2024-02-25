Return-Path: <linux-kernel+bounces-79954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 893D18628EF
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 04:12:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1F2B31F215AD
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 03:12:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEDF5382;
	Sun, 25 Feb 2024 03:12:06 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688CD2FB2
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 03:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708830725; cv=none; b=TQy6gOISQ5eOVgkaVHSxYpZCoWfIDNoxwW2e/i/bfPdL4Evdyf6bqdY40/HtY3u4K4AnKvPlo9dQuDKyvBHV1k6ubC868O0YzkBNVerlWSg6i18O1gxpIE869ML7/9k914+OWwcNsGyegYZSvbYeZPCNGcOkS6Gky7NF8WoY6KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708830725; c=relaxed/simple;
	bh=EMzaupCH/vKKODQcuZVYe1pZpWPxWhDxD02ETJbgfOA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=jF89wV0LkOG2EHI1FBdrKfrMdSPyVA8Unr84JWf2uG5d9sSGiNuOjF6bbI4o8npY9/yIFJ4N45QJTWuJWhYXUoFu3uTETW1ScXJ1Sx1psdd6BOAdOnTH92bjvDRTjs9e25HcGc6oKW8D48I58gxywWjN3vjrBKoPEdRZXRrnp0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7c78573f2e9so248842339f.2
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 19:12:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708830723; x=1709435523;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vXJwngd7F9kg0wq/CBywGg8JyW8eN+CIcC7q8Yl1r3M=;
        b=eo0/gpYzHE7BI6zPg7SLvrjd0OyUwPe8SHsFpPbpGwJZ/y3eghziaR8sCXUupDc8mB
         i1Y5vkcDoxN1ZsrrP+H1D5l8jKSoMwkwFn8onJngIKQ5cyxy29DmQ0PvNmyO/5z+gqCg
         jvrOLcpkvMOFZrZZgVgBEJZAtl5QybeWRfFxujZmEumI7r6oEsvatEBjFiONuZG9I7gL
         lyYOjqGJPq8UCvc3IxuTAxE+Nnv2ap/3wbB1hbF1TDnAxl246+b6zeyn0BCk3m99Ux/L
         HaA7VrEUsQ2P6brXdj9PSCZJ96oV+rhzN/UKlwba3RGMXu9Pv2z3Sakmf8yGgYtCc+d1
         sanw==
X-Gm-Message-State: AOJu0Yw5Ct5PAhR8tPVmrRmidMxUr3JCeUVEEmx/PWqBK74PfOzwJIiG
	ualzDBeD4WdfJ7kISS1J1aApk1BYsUTIzc0++8C1lXOjgifteqALMxAlKl1fUuueM9XZYUOEKpz
	DEslVmIOKO33FLM7NoP373zzXafdnQyNZE6EYVKr0j0NL3ZynOpwzKpTP0g==
X-Google-Smtp-Source: AGHT+IGs+PEkSsD7DJLirwNGRXiXsC6fQ6wrlnobLVYLpJ+UFWcdt9nKnYqRP1qOItoaPXBscox+KwMPiSjXVAqI4hIgn0oYXa26
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2488:b0:474:7eb2:f0f with SMTP id
 x8-20020a056638248800b004747eb20f0fmr13283jat.0.1708830723587; Sat, 24 Feb
 2024 19:12:03 -0800 (PST)
Date: Sat, 24 Feb 2024 19:12:03 -0800
In-Reply-To: <554675d7-afc8-445f-94b1-8bba0a774dc3@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042c3c306122c289c@google.com>
Subject: Re: [syzbot] [mm] KMSAN: uninit-value in virtqueue_add (4)
From: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com

Tested on:

commit:         0dd3ee31 Linux 6.7
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git v6.7
console output: https://syzkaller.appspot.com/x/log.txt?x=13efd0c4180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=373206b1ae2fe3d4
dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=179789d8180000

Note: testing is done by a robot and is best-effort only.

