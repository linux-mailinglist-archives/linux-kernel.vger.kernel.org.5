Return-Path: <linux-kernel+bounces-164795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469AA8B82FC
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 01:21:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAD121F23D43
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 23:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E430C1BF6FE;
	Tue, 30 Apr 2024 23:21:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E24229A2
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 23:21:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714519265; cv=none; b=tP28qfLyLMIn25SXOt+ZaGnAaoxCRf++DhBEuoa4IWODzHvLQ4Y4LjTk9hrdpsUi2c+ZhJNAmfwAVubNAtK73qQqP71X8IXQCrdQkZiV3F2kpCqE5Q1oICvn7tM1SeUiyY03I4Eo5Vy+jGQ/NP/afZwkYjUEjrv6WJvVwqmlDd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714519265; c=relaxed/simple;
	bh=LduVP271EQjRJNuXqUxM2pAzcJ/5HzpZOHXPNgsGTzI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IBNMCVCcQukQJfr/xGjXbTe/ea/B2mx9Zuf5b0CI79qyk/AUQbHV3wxwmZkPV6ZXWNUxPfopZ60Jf25euI7X/L9Upoe8GL9eFWJ/PpP8og4PIQzmZ6Y59ZYFB9xP5m80YS0nZl2Rok3jxq0BqJk/LfmkXdiIz+7TOjgb0uByMyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7da7d4ccb67so672560139f.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 16:21:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714519263; x=1715124063;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sf2AoeXJLdenA59zRnjhwo48B83WRv18jg6MXn4asmY=;
        b=E/tHne/pYa7GAZlhUpjvljMmbF8xCospqAuTB6svD+GaDkmLqb5Y6tXjPhsuYM/JeH
         nMKrC2/pDQv+8OLCU91FSCRIjO0fP9KdS839p1Ppv2Ui/wNLfOLS5ZnMLBt5JxcMrC4U
         OKvRDq1wMQqvzOIeK+irYTf++mT2cwUg79e5x5F02PpQql/kTU8IOV/OlZelaxDyVm4p
         u42UuQT1fc+6ddqvGPS6F59pj6ZPGYtSj869THcJnUEOtgf2yOoa46YTq1MmVlJLLERw
         vx6Oc11vU1gMcmPD+rB+P4yQqUs8RcJugUKzNbcm0PcYf75bCPgQVYQrsmswYI9Kio9f
         uuYg==
X-Forwarded-Encrypted: i=1; AJvYcCWN9U5CSR6f7PSI2JuY5FYea898PM4wbCncPC2HEQGSOPzBXYSpq3R/PO3pOmW6fH7/xP39orrLHs+CtC+TG6y1DIG2s/s9Qq6mc2bE
X-Gm-Message-State: AOJu0Yw45B+bnfMcTThzJLHsbfhNQ9l9PGwgS7fin3gsFsDi8xrDBCDJ
	4joo1WhiyV8Y0t251gdB4Us5/3VsaJqbArgrNeuuUTF2U6QjbO3gRtw1yHtA5w+xGJ0ZY8ldt21
	poFlUALDMgBw/1wTSkUA9ca7+0ceuHKWKAZeAGjIRyaalKIOwbfk2oIM=
X-Google-Smtp-Source: AGHT+IFjf5xXqsxHYPaTVsz+9COeIbSeb2TnwC35XtjukDSWuHoB8jhUnwmfGViBoiwcUQDdd4/r6euVudBxpMB8WcXL43VbzdD9
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9407:b0:485:7266:7eb3 with SMTP id
 ky7-20020a056638940700b0048572667eb3mr51406jab.3.1714519263404; Tue, 30 Apr
 2024 16:21:03 -0700 (PDT)
Date: Tue, 30 Apr 2024 16:21:03 -0700
In-Reply-To: <20240430225005.4368-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a7f8470617589ff2@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com

Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
console output: https://syzkaller.appspot.com/x/log.txt?x=16dcb2ef180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10ca9b80980000

Note: testing is done by a robot and is best-effort only.

