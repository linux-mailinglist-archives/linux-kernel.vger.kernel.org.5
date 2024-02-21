Return-Path: <linux-kernel+bounces-74876-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EDA85DE6C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:18:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 087511F24679
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C8B7BB10;
	Wed, 21 Feb 2024 14:18:06 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7B14C62
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708525085; cv=none; b=LYHYQwUkF3z89bp7zscrf3mAAE2iFiYJ6a2vs8TG9vygTIiyDfL4SiWLOQqggEii3ZrgEmWk+F6U+jMCE1pfIZAAd7Q+TCF+YoFvq4aiTyrqgrGU/e9qdKrgm1xjLvjdkPcVY3l4Ppt16LG0v/tNjsCH0y12/idRin81AFmoxzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708525085; c=relaxed/simple;
	bh=iGgWjgLgpBt/9RgPmSEvpnYqtBKXQsB/KW/8Pa56KgY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TdQerDDVKrK88wvhtbYAQNhF5tTZ2LQojuzWzpDkeOj8A2EU/6gznHPb+vXV0lofuaP2Lr/ZsZ7lWqCwoZ8NkT6tw0ngtMb19YsTtVsL9WHQcmt8kGsTvRPKioWpP2VtP/4m7FwycrweKiOtgIMQ96gNyv+G4P7aNsX0vtvad1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36525729ea3so37541165ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:18:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708525083; x=1709129883;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1klTTAIrFGmvBnYQd2zOqJEkvXD6C5G+n1BZglALIZw=;
        b=t4AMLpC/Dk0B2805JA2LoDkkP4gvNWU83NPX3QYHWyrULN2Vx/KmTkUNKeu3Y8HhBW
         sQ+Qg9k/IDYbbR3cVc1oW7tcFSRPEe+BZ0be0SlEF/dL5VfSEkwSlVTX2UGSu98rHlma
         YASzpBD4vSBqpwOQ/cOxSa0fYjI/YvQQohvOgANhAzuCxPJbU5J2GZjmtLkqtxhagibL
         NKMtsASVjYGDKGUvp3LcUaqBzvpDryZVXU9j48Pzx2Ndy78F/A4cGQYQ0eWkqxl5lQai
         zu6IwaWx55ZZ8tuKX+YKzGROhcbsdhsuVJBjdjC6ZEzQ8IkJxo3vXVgECfucCch5R+58
         YGAg==
X-Forwarded-Encrypted: i=1; AJvYcCUvPlgUlIlMfRy1mScqw7BSwwKT/9TtQnmWUqaCCRmd3irFe67WUg+AxLMUxaVKHyHI1lmDs3g4+JPjZkYhWpgM0I2486nUSSIAx6kF
X-Gm-Message-State: AOJu0YzA+ek2u0G8bge0e2Didym9tKylLrarfAgA7xkjyartSeBAWxls
	z9dH56g2SIOx44DKvN+Om54X+PlqbY7A+jPG8vFL32zbGB1quJ8AzQduSeiscIrCOLZGCAs6KJd
	FB18f9A4P5a5ZzFFC16ye9TfYQDzeWQFeWr2s5Ar0VDDgL6i28FJZidY=
X-Google-Smtp-Source: AGHT+IF9MpHqAqond0Z1ygJ9VfO5pGsiUZ/EJPPIM/DKqrBFsMJPde9pPYl8c7erSB/4gbsGDy3z2nVhZMCZNUtniGt3lxzW4svw
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4c:b0:365:22a6:596e with SMTP id
 u12-20020a056e021a4c00b0036522a6596emr869470ilv.6.1708525083818; Wed, 21 Feb
 2024 06:18:03 -0800 (PST)
Date: Wed, 21 Feb 2024 06:18:03 -0800
In-Reply-To: <tencent_AF13764368E97383BA244FD768576566C205@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b606560611e4fe5b@google.com>
Subject: Re: [syzbot] [media?] INFO: task hung in cec_claim_log_addrs
From: syzbot <syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+116b65a23bc791ae49a6@syzkaller.appspotmail.com

Tested on:

commit:         9fc1cccc Merge tag 'for-linus' of git://git.kernel.org..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=162ca072180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=95be8c66da553d84
dashboard link: https://syzkaller.appspot.com/bug?extid=116b65a23bc791ae49a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=148ff694180000

Note: testing is done by a robot and is best-effort only.

