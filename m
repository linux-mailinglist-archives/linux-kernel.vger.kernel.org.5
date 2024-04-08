Return-Path: <linux-kernel+bounces-134702-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0888589B5BC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 03:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D7051C2111F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 01:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DBA15C3;
	Mon,  8 Apr 2024 01:50:04 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CBE9EBB
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 01:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712541004; cv=none; b=pzUpobQHYfQTQAcHNdLuGFydVAZBmp4mC+6ltXsmECAlQUdRAY+vYJNOq/tCm3YLD89SgxPCtCeHrEtd37DtdjxF1LhDKHSVRH3YW2OgnWvUDfUO6CHEd6IewJw4fHyc2e3lzEh5z0s6UXIqNuQs2SN35ZpOx6vbe6pLXlqwEVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712541004; c=relaxed/simple;
	bh=UEiTTos3mfrnLERt7ZraEBUjwdQWEtNDedYj8zyBcXo=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Yn9HxkZZsMYkipW85iAQ1Pfh0ArYE3RCtjaO4Q5+lAjFtJlg3dyO/edcM/FqcVaoFEg0cpRhSSMt6chJgFdprFzn61MEA3cVXoBI9hu3lsDT8R4CWXWNLtTDdmvLUanovYj3bTIxsXgOy7Iv0/aqBHwpAMCUltcBkRw6NafwOTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3689678c5efso38210315ab.1
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 18:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712541001; x=1713145801;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qwByaI+Arj0GTeB2ueY7ev9vT4m6RPyIs15b84pV1iw=;
        b=IhTe1e/ych/qFp+9iRmuF14mr0Qs5pXbJIHYmtAMGcxpkpSukUzuE0zKFiicUHsYdo
         ZziR33136mG/mMVdSlumBn8i5FWMF4HQ2Ju1AHQCZolinC77i7vUE0r/XLj87iPhuoCY
         0Ocl0M0TEh5432/eRgUb7gjAYoZo9GNXGAMNR344vdWRcgS1jsuZv7ASeXDyCxHPXEK9
         wbCwQ0hpo0fXgfiwBs+p5UiCQ2fVrL0b6cezMvCTL35nAkAtvipWLtRTIJt66wDpHtcw
         Gdx5d4dOrg86TSVGUbiJX+wtFA41XIeVq04TiYbwJ5uQBJonPwMTp2aZciNl9qBz10NP
         xq4Q==
X-Forwarded-Encrypted: i=1; AJvYcCU8ZtvzB7XqXuY8DOVuvB9E1QsF4vnqxto5/n4mXX71OMOlJ2YMo2NCajIdssHhKh11aE10PYfpjd7UIeIOr56nfERrP9cdIfEmalIZ
X-Gm-Message-State: AOJu0Yxwp2cP1wqrxtFAR8OYJYRByli2q4CqMWDH6FsB5Z/bHcNUqqDr
	KbearuV48XpKyZ6s0ouarkCAxNZlT6uO+BCCHcEm/pnUTRwEqxClL9o/++CYHF02whSWe7Ov+3E
	yKak96irMqWdC/C4GmeIKeUFzvKIHs58Hop7o1t5Dyok25LeBcrJrLdU=
X-Google-Smtp-Source: AGHT+IF/eOORZDLVOU6KeqKjj1wuYMYMLIQHcyWiAJer3scT/sd3e/u3eFyGnRT8Nx+0oUH1zZQ0ukf8HDNOOhuZyj/SzMbdwEko
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b03:b0:36a:23da:ced0 with SMTP id
 i3-20020a056e021b0300b0036a23daced0mr127018ilv.2.1712541001744; Sun, 07 Apr
 2024 18:50:01 -0700 (PDT)
Date: Sun, 07 Apr 2024 18:50:01 -0700
In-Reply-To: <20240407231414.1496-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000012925b06158c061e@google.com>
Subject: Re: [syzbot] [bluetooth?] BUG: sleeping function called from invalid
 context in hci_le_create_big_complete_evt
From: syzbot <syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+2fb0835e0c9cefc34614@syzkaller.appspotmail.com

Tested on:

commit:         480e035f Merge tag 'drm-next-2024-03-13' of https://gi..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=171f2b39180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e5b814e91787669
dashboard link: https://syzkaller.appspot.com/bug?extid=2fb0835e0c9cefc34614
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14dfa699180000

Note: testing is done by a robot and is best-effort only.

