Return-Path: <linux-kernel+bounces-108617-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF7D880D09
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 09:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8B261F24357
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACC932C60;
	Wed, 20 Mar 2024 08:31:05 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF373D8E
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 08:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710923465; cv=none; b=MUmCzHrfNHhPngZgntWOWW/bSgKAzHtiq2/p3Q4r9W/oRL/noaCKqq8poyv9sZh3HBnT9rTbUU9OnTRhiKV/3ZUZtTMFXaV8x7ww6v72gBhajDixU/ZNvI9LfZTajMJNR9/nodbqOxb4y6hRrw9r1UsJJKMe1lDACPHDvlYk6gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710923465; c=relaxed/simple;
	bh=WaHYBkSmvPep1l3Mv5JaX0JJmBWUkVLPT1aupgFGCzU=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=RF7fkx5XAb2DgbvFUokpkn46yNHfikzg7N0Ty6mPR0AM1fYenBVJMQMtK2uonSBmj4+07X0z2jVjc1ruFsdCMOUXCGlrZcqkTcaaxZoRJEBEFkly5jIo+168cU1G4/n2V75/C0pSqAhsipYPjayms8YEY6HB5CFh9dunwIJhc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf2ff0e33so534732039f.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 01:31:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710923463; x=1711528263;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QgYGymkBxs4evhkqzMxc/e5m6AUrrWusifftjdT+UWE=;
        b=U6nmAmC396suAjVbzYBIwRwA0u3Y6nSMOUkN/xSAeMySsh4rbwL9xorxujgZU1kFe1
         ZG3AYNDImogldG0CsncK4uuMViZyORgEssXaVkSbxE1iw7fS8NqOCGNrcLVxQwkRFjQH
         X0UJ2ofM9HQ0h/w71Ip5RBO8n19B4DWo2ir7dQfCFP2XAxOFDIqpDTV4v8fJ7seqItVZ
         dl1tjh659PGavEYykOl/DF/MsiWnFbhZTWZCMwliaj4tibGuW2FqHdaWXJIpuUXQdHtX
         //KSPWGBr27NxRP/QQXb4ocHaGfz5q6dGsNnK5WfKAlAvHMdegHWBtoouDRIWOvzVXfv
         yBYw==
X-Gm-Message-State: AOJu0Yx1kaa7jzMja741DOKlYDQtJBtCFijpYGYaEP3RjqXnh8rpJ2qZ
	8G5OY5gMIiUvD44NEAFPYgm0kAJQXAifLPwzkJ9e9VDdiDv6lkLghf6r6EAkAEqfhYT83sOgNFD
	TZqthRz9ZDseaV1P77mcem6wLQegVJm1a+m6obIcP5u5TU5l58dIbskpZfA==
X-Google-Smtp-Source: AGHT+IEGSDucult3YqILeOnfLlLeypqtbspN06SDX6+e5H9MNTHqrVo2MRySI1UJ55DlsFXDJ79VRx5/tKji0skvRnKBKHM/55IQ
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13cf:b0:476:edba:7c5b with SMTP id
 i15-20020a05663813cf00b00476edba7c5bmr880105jaj.2.1710923463062; Wed, 20 Mar
 2024 01:31:03 -0700 (PDT)
Date: Wed, 20 Mar 2024 01:31:03 -0700
In-Reply-To: <4362246e-d804-43de-800b-a7840b70919a@I-love.SAKURA.ne.jp>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000410e3b061413692b@google.com>
Subject: Re: [syzbot] [mm?] WARNING: refcount bug in __reset_page_owner
From: syzbot <syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+98c1a1753a0731df2dd4@syzkaller.appspotmail.com

Tested on:

commit:         a4145ce1 Merge tag 'bcachefs-2024-03-19' of https://ev..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=131b1d66180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9f47e8dfa53b0b11
dashboard link: https://syzkaller.appspot.com/bug?extid=98c1a1753a0731df2dd4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13972985180000

Note: testing is done by a robot and is best-effort only.

