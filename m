Return-Path: <linux-kernel+bounces-127596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F8E894E2A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB5AD283E64
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 705E757305;
	Tue,  2 Apr 2024 09:01:12 +0000 (UTC)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8649357306
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 09:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712048472; cv=none; b=toeoA/BJz/9ez0ny++RKtf/QKc3WCVIBBaCw96COAxUZMMabNFpd8kGNEfSdhYgltDiQjr7X3ET5lnkWPiM+AazkYY593Kk0Yt9f3GqWqoFSPRtyorwJILZDjiIBcx7OX3tqEt2XJ1uK82gChUAadKFMcPbtbBzQZnJGHR3bpuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712048472; c=relaxed/simple;
	bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=n3Ec3XNts350MVwJX8CUQTAA5f6yn3kqJnNDTQztqOruYIf+FYWX4LejtcKizC/8Wq2ZX7/Rq38LZlJ+tdWGbDCphLFGCCGZiizzGYrgCBw6kCmrGKcvUaBgjAk2kAIgAtJ0cJYGPKtxF4Qok001bpfBK9Go5WmE6j2xJs90Zdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7cbf092a502so521029539f.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 02:01:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712048469; x=1712653269;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pKFwtZTaqrc8nj4olYRMlSYneEQsyW5GpRxBrsnGAMc=;
        b=EJf0P4PZrNKHtkDHzfkoF9HwvkVONDKTXo/x+56gdLAAdOWyprXblKqiG6Y9s0JASs
         qtooI6A0ia7iaHFZYiki/90hfy9Gje8Mio81gXHrvLohKfisBXfnG2z9yUw5FZCJxKix
         FJPZ3gon+jdYWWmNibuTzsHuedsiRtqcbjZVvaqC0O1JSTJnK3w7BdgtBisipm/jVl5w
         AbRZPtynZaeie5dZg1YOZJBNfoGDV8C9VSE4GqDCCCtF6Crog673hJfGQnalbMeRc9qt
         UdK6fLvE8C+DIhTdrycEQ7UWCu7dq0hW/PVeFuTQRoVJLqnVtIslQfv5n5luzxAnXyId
         2cSw==
X-Forwarded-Encrypted: i=1; AJvYcCVtOl1bkulta4xmjKPnFRhRFrORC2AmiLSWKFongUci+PWYzRha36Ugra0dqMQbU1s6YBn8wuOFUHOjnoNSWafVAZNuJLs75eVvL1D5
X-Gm-Message-State: AOJu0Yz5BoIw0txdgy6XSbadPVZ2HNmE9IXOzIxOqJdPARdDI30ZKxB3
	X8LLdv05FL1irUUr5EcVdMydVimcGtu+yDvaLEDyGJ+nGSnGpH2hPvcdttFdcy9kbywn1+YLDjT
	JQarqbmhwqg3hc84+u+o3abLYLL2wfK115jNBzZlWj9pZnoFn4ZTJbVY=
X-Google-Smtp-Source: AGHT+IF8E3F4FXRMTBFfB6xAfwhi7CTp7Nr5gYOuq0JjZ2Z7aLBhtOaUiHvu9/q2yRiyU1L6TrbYLDtBs5pPYp8fhgcrHdH2nEc2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2109:b0:47e:c145:c770 with SMTP id
 n9-20020a056638210900b0047ec145c770mr816747jaj.6.1712048469733; Tue, 02 Apr
 2024 02:01:09 -0700 (PDT)
Date: Tue, 02 Apr 2024 02:01:09 -0700
In-Reply-To: <CAGn+7TXh4gzeQ3EktnYQ=TXO_LutRU8iSQ=VbBpPpVX=Cr_UEA@mail.gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e086c706151958eb@google.com>
Subject: Re: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr
From: syzbot <syzbot+d4066896495db380182e@syzkaller.appspotmail.com>
To: jakub@cloudflare.com
Cc: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	jakub@cloudflare.com, john.fastabend@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

> #syz dup: [syzbot] [bpf?] [net?] possible deadlock in ahci_single_level_irq_intr

Can't dup bug to itself.


