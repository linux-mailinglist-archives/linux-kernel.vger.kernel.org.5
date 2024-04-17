Return-Path: <linux-kernel+bounces-147837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E3C8A7A4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 04:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90FD41F22299
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 02:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ECAD4C8C;
	Wed, 17 Apr 2024 02:03:05 +0000 (UTC)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2396184F
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 02:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713319384; cv=none; b=Q7eRuMiW4mK6KkivhOu8d0a/y0/pqMEuDZkvKTZhtRxGsgLMT6CATjrGJHSO/rE1LXy6OEcTC2qx/drhJL/LP2lMgVFCxzZwM+S9qQz/xC8A1OAAkIjYffm8eU9xJpqW1nHWR0R+YtjQbAKb4UMwqMLAyQi2qb7A1s9r+bEC/rg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713319384; c=relaxed/simple;
	bh=7R5fFoaVMO58nLKlC8ofNl99FYUCmZ9nMK3uFXMrBiE=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X9fVQhlzjNdyQXW6WdnyGJ1mlLK7Q0cARaEiHi6xe0YvVeVCIX24VSOXQ8ZfhMirrTMbnjv/3Ee1clDyRdLqH+gAygXvINz434ortX2ZWbfA2HS6w2NRSsIrc6xIj9AUKO+ddQhkqPVL4ShRQFQNqmomkPw1nCS1VAd9t8+Z0bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7d5f08fdba8so34063039f.0
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 19:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713319383; x=1713924183;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7YdGzxIuIhIClLP3KBEn3c7sTLVSJtp6QQ8NED0sW0=;
        b=CIOA/T+XgpoX7INxbHQ/ivoYkp148+SCuyt6QU0tl1nb0WOlpM1sL9a0tMhF+84FvS
         XwQw1M8qeVrCSXBspfYVmHBsu7oELwkT6r4kA8SkKxltu8wRASPCgOcxK84Gv7izPcma
         Yx0vRidkVwTxf2lylzW01lDO2ngXGFKUJCjk1rSSDTKaxQf35jaJ+8Fzgc3j+6uijxDu
         PgyrB1WbPrNZAYpQEdD4vonDKSyPCjK6mdqNzIBwQ9bDXz82pSk6mKpTGW3ABsAeziro
         vSsdGNtIBGeV9/wKbBTwu/Ir4ZDKW4zm80vOAc5sHx+8Yte7li7vX6vCymm8reB6/brF
         wp/A==
X-Forwarded-Encrypted: i=1; AJvYcCURZw4ib6aokI71b4V53KvtXM/+hcrXEMheEWFxuj1W2Eg7TvYLBwc9XuzMynfFGZluV3sj195ZHgm/0y4nLMdU5ay9+ssESn/iK9ui
X-Gm-Message-State: AOJu0Ywz+bK23A1a7cYe4gjTZwfCIR93xuKEQ0ZH6rmu8MS6Px/LKssr
	Degz59vhbpilzkt+pBRjqxnLXin2/l5IJp0WTR0+8r8ccdUnmd9S5DfGCFrhPOkAdrNMCF7dkYq
	0hlNjp46skfRA2DYmtLGoQKyh4apGMYtVaEXty6yS7xAVsz9m7DAusPI=
X-Google-Smtp-Source: AGHT+IH9W3j+txljAd4Ru1fIjaEdLExekzA9d7bphDz7e0hhfAnQYUjYjLwhqL197IxJl5EegTqPzJSU3rdbWNiVPEotT1y7wWUN
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8622:b0:482:e8c4:6eb0 with SMTP id
 iu34-20020a056638862200b00482e8c46eb0mr325174jab.0.1713319382875; Tue, 16 Apr
 2024 19:03:02 -0700 (PDT)
Date: Tue, 16 Apr 2024 19:03:02 -0700
In-Reply-To: <CAOQ4uxg_qkqos7pXaTRAL++wYfuWZCWVcn64XK2g=GKR3zpOzQ@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000340f260616414106@google.com>
Subject: Re: [syzbot] [ext4?] KASAN: slab-use-after-free Read in fsnotify
From: syzbot <syzbot+5e3f9b2a67b45f16d4e6@syzkaller.appspotmail.com>
To: amir73il@gmail.com, hdanton@sina.com, jack@suse.cz, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file fs/notify/fsnotify.c
Hunk #1 FAILED at 103.
Hunk #2 succeeded at 510 (offset 4 lines).
Hunk #3 succeeded at 540 (offset 4 lines).
Hunk #4 succeeded at 569 (offset 4 lines).
1 out of 4 hunks FAILED
checking file include/linux/fsnotify_backend.h



Tested on:

commit:         2f012b22 fsnotify: fix UAF from FS_ERROR event on a sh..
git tree:       https://github.com/amir73il/linux fsnotify-fixes
kernel config:  https://syzkaller.appspot.com/x/.config?x=16ca158ef7e08662
dashboard link: https://syzkaller.appspot.com/bug?extid=5e3f9b2a67b45f16d4e6
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10103657180000


