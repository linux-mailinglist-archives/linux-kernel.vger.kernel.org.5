Return-Path: <linux-kernel+bounces-110148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9A4885AB0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC6DF28136C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:28:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1740086151;
	Thu, 21 Mar 2024 14:28:06 +0000 (UTC)
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0B185957
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 14:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711031285; cv=none; b=OqfZ5lxSOdvRhzo/18EAvoUgdMTgKjmVN7E34YpIGsUFHsJdy3OYZwaDwFypNJ5HrK2zFibhLRlf3V4eXJg1/L8/Eg4vjhm3gX1LyrEFsrya/q5vjbYUapkqXnuRmTt1l2QCwu/Y0SGGcOoWESevln9lJiMq8/39GtaOPH0XQds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711031285; c=relaxed/simple;
	bh=IhCIjYcsJTcTh0Ne4siMGs1KObTKCrtAyzR1ZUHgjyc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=lz8sJNUIEBAxREbT56a3S/s9gH9TLpiOnIho1Wy4bduqUpr3ye1NTThECgMFF2l5jDzxSz/aI+C3YVjnu15SjX2i5WCX3xWA3bTYZ5BXalEp9tVy31QsSEuq8DK3aJa7YLieA8plURTXwCGPC7DdVvjJJ59i4Q7p2H/nMDt98Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7cbf1aea97fso106591439f.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 07:28:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711031283; x=1711636083;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3etRVZh4JDKSafG4jfomctqFkBB0y78hVizxABw8bTI=;
        b=trwZH8aNSNXs/y+5lGlD99cR2XryeHmq52SF8rMAHSwEJ7DlO2/7QD0IzdQvfmyr/z
         7mPpsxKhh7/RD+jV1I35JVrfxisQpz3XAQVFnTKjtx+coHtlUYNNq5d28+w15xYfBq0n
         +x8zXOo9EyHmVSvELmL291MJrfPEfFxpAZSYhuNx0bu3Au4Kau6mbNuzEM5IjCRzwAqg
         Xw1/8yB03z546bHu23M1oOvnqaHBATY+ks37X8kFkICvu1lcHv2dbpoeh2Aqp1im9hAb
         9Lav/Jzhtr6wA9imFtajSRNLhOXEZLdjBE2anj1gN3sS+HDrcMqNdoOWQfW+X3HRzNAu
         AbUA==
X-Forwarded-Encrypted: i=1; AJvYcCVcpBvkawEoXVBwqXQMrS4yaR1vcAEEF0k+7nTg2Q3T5mAicHR1hq22suU0+9ii1Uaml/YrgYBwBSSWR1YeaVDFBhrvkaMcmvrxllcC
X-Gm-Message-State: AOJu0YwhrNsCGwiPnx94VZ19e1XbEQbsPWU+MIyqYAxZJmP5oJjt4NOv
	cCC2aDE9Gi29QyMt7gC1JHEfXEf66PW7cDbFMlkLdMbVF/Yw7yF0jFy4Z2gE+RDl+EfSBvYoKrH
	LKdoEkBmubxAvDnpQpLs+ZyfpbqEFo4X7RBXeP42vjF7MEL6nD7r8O6M=
X-Google-Smtp-Source: AGHT+IGjnT/ykheEohkY17kLn82StHEuryxdXnlHp3LmGPXKn8nPbea+jua/twjPJIiNBmJsEJ6vKj74KpacS8zuXOmIYNL+WxTL
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:349f:b0:477:2ff3:4a76 with SMTP id
 t31-20020a056638349f00b004772ff34a76mr905173jal.6.1711031283388; Thu, 21 Mar
 2024 07:28:03 -0700 (PDT)
Date: Thu, 21 Mar 2024 07:28:03 -0700
In-Reply-To: <20240320235126.2407-1-hdanton@sina.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d8aa6806142c8347@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in scheduler_tick (3)
From: syzbot <syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com>
To: hdanton@sina.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+628f63ef3b071e16463e@syzkaller.appspotmail.com

Tested on:

commit:         ea80e3ed net: ethernet: mtk_eth_soc: fix PPE hanging i..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net.git
console output: https://syzkaller.appspot.com/x/log.txt?x=151dd185180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=628f63ef3b071e16463e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=164f17a5180000

Note: testing is done by a robot and is best-effort only.

