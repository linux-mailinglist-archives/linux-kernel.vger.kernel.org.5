Return-Path: <linux-kernel+bounces-131953-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5119A898DE0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:26:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E62EAB23BC0
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F4A9130A75;
	Thu,  4 Apr 2024 18:26:21 +0000 (UTC)
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33AB9130485
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712255180; cv=none; b=dcI+6vWYXCoFHA7TG9xV58v02vHW1wfdAYvmzHAYHF6IxnlGKcabyz1gsdfDety6XuZn80MVLjk0tVQQexQ8l0qrOjQBEPXEi6yC8aBgcn9P7qqlx8sUjB78TNiKE2fdxV2PZ+ei/Am3rZke6vVlJGpB7IdI+/A22WVNfc5gPOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712255180; c=relaxed/simple;
	bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=kA9OKOf2WFpPIYokltksQChM6KfWs/WfEhBmN7eLAcv+wh/p3uXN0MUhJbFQLVWfP16qqbcGKU+UbRXWQCZLpUG0y70t34Md1g7g8tb8e3AkMOV9+OIiYvKd8O2teLyfN+azR9sA1vZltHJV7R23T4MnfKhZBvEVTLlsatJp4A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7d34f49058fso116419139f.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 11:26:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712255178; x=1712859978;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UzKx2uEzqgslDAiwUDJyVu5c/uy6CYD26vc1Ic3/26A=;
        b=rN3XxX0QvzXwkv3zc47wzdU6tn0bKj67Rc4Vb3Zr0yXe/5so/35GFLisyNpZFM56xx
         FFtMMGQFu1sy6OztZGkx8fB9tc2wTIGeWzy6Ojf6yPzCSUfjO2993oYUeRTLS2Bwfhln
         vRXEqFFuD/+VzfA/LGHfrWDjLqiC9vgwQuuD1Ue3ikhk7J0JF7NIvaZZDA8SUjvK5MxM
         eBLqPmecsBUg4H9yyZ6PIMrlp1E6uJ6ebJfyjeoWtk8u6lqSttVrkhLCU28X4DcW/41H
         qoqdDxh19IAFM3cFwkFpSRjyjJmheR4uSQN9nVWk+53vQPDZIjiVoBk1BJNC1LIW1wPa
         N7Bg==
X-Forwarded-Encrypted: i=1; AJvYcCVqPjkKudpfmF9uERHASTgpRzH+1yWvExITdz4LxgwUyRY1fgNcrHzr24puQQpZbKjsOLfZ6McUp803hTG0qdDos+OUYSjf+pc4NE1e
X-Gm-Message-State: AOJu0YykrQhaijgRX68Wv09umhJeGt438MEGJpkH9ksDDk+2RGlN+ZDY
	jzbdOTlVkDYVYXoJWaT6sJRBmDp5U3QCykjtQZWrzplSv4MGgCrkDOd/yIsubHNvXEE0hcB4ZnP
	Z7yzj33HEfYUCQEK4H8BR6lnyxP+HXJ/JGDSS1dKlaXv1sqk22rc9rS0=
X-Google-Smtp-Source: AGHT+IFpIWIHg6mhLlxKV0QUFxwSst0730/ptvTeVTNW/UryKELPdtjXE7jGOfXhNo5XLeYMDXSWFx9yJlRLe08U2sRzZ13cTnsP
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:2b0f:b0:7cc:805d:38b2 with SMTP id
 p15-20020a0566022b0f00b007cc805d38b2mr22900iov.0.1712255178459; Thu, 04 Apr
 2024 11:26:18 -0700 (PDT)
Date: Thu, 04 Apr 2024 11:26:18 -0700
In-Reply-To: <000000000000a62351060e363bdc@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ad5b3b06154979cd@google.com>
Subject: Re: [syzbot] memory leak in ___neigh_create (2)
From: syzbot <syzbot+42cfec52b6508887bbe8@syzkaller.appspotmail.com>
To: alexander.mikhalitsyn@virtuozzo.com, davem@davemloft.net, den@openvz.org, 
	dsahern@kernel.org, edumazet@google.com, f.fainelli@gmail.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	nogikh@google.com, pabeni@redhat.com, razor@blackwall.org, 
	syzkaller-bugs@googlegroups.com, thomas.zeitlhofer+lkml@ze-it.at, 
	thomas.zeitlhofer@ze-it.at, wangyuweihx@gmail.com
Content-Type: text/plain; charset="UTF-8"

This bug is marked as fixed by commit:
net: stop syzbot

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=42cfec52b6508887bbe8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos

