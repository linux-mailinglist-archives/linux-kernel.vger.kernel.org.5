Return-Path: <linux-kernel+bounces-165126-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 798FD8B8861
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 12:13:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A0DDB1C23118
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 10:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 300F7524D4;
	Wed,  1 May 2024 10:13:07 +0000 (UTC)
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 750B250271
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714558386; cv=none; b=ShZjAZOrxQTdmgRLW+dwyKLsrWe2KHQYG49DPIJx3ydnC7fRdaQxCNCcEPAIP4/WbSCmmu1nHyaKORgANyaPXZsFEDvrdlic/XygFoDY9JO/cnEZCYslEyQQGjbpPbXicQF9EscvIo5ulHO5PpAJAKprxPOhACHmYZJUyBLVTiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714558386; c=relaxed/simple;
	bh=pioStqYgJf4OhfpIfNUBBQv8F95pBysErxaAtFAHqdg=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Eb9p3zLeJkiAaqQ3weOnM1lXMZ6myYccpeVZue/w76DWllj5b5XZdiR+rYoLH2TWKfl5xu67KdkniNIIisApG9SrduNYEQWpbmT/jcsPdsI74TnU0oduKLTZXGTfmcbV1NIHTqh3aD63NxtDOtFqFwQMFhir+JThLdl7E+5pSg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36b3c9c65d7so64500345ab.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 03:13:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714558384; x=1715163184;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KMqmzGESuSD+ENSY1XUPSg+1oJAARhOnJzLdofJdJTw=;
        b=IMrdz4GTc5LYki2rkNsdbB+vgeFfjRXTQ/tqvAs6Qwxqf2y+cdlEKxL7OMNEGytd6a
         yyaaIuihINYz0SPEL6zcfFNeo22Ivo40Bcfhei4iSMGGkaF7HEri1Xlj8q/NtDx7ZEFs
         CXZe6i9F0C6+jBDRDGiONvr/VDIP0cECMXZmR4zBM9WEeBjRwa7wuH9OyGGhDXQsoH62
         apt7fHLuN6tpuQzFz2kxUIBi6RYAFPl8xbyQ4QJOnspMgjk2qlnfLMGz06s1vTpDTJ0Y
         QOI2xuzkjG0/2FGH39dTS/d+b4MQtUJercq5aE6sZ99c/rB/XdoVGhnQUYFS5tU5ed8E
         e31A==
X-Forwarded-Encrypted: i=1; AJvYcCVZBGijjtuEa68ACX5C6Q6PdJVVnfyG4MptLxBjScicGgxpoer2w/vgvxtS9Chtkd0cT0eVnfXzDEpw7HmRzJDE6BtoiX5g7gX3Vzka
X-Gm-Message-State: AOJu0YwzN7+ooe/HxRxELJ28RB5CWZignKnxx7fspcjxxOlsprpA55Zb
	yX7VziPLGYTorXRHTrZ4MtFgfyUTYDwkYW6YOlk8bo87MN/NeZXOMdqnNTFoo5YsNVveqYM5KaN
	PmNF24qpq40RJcO+0H7r2dx3ODjHKlCOjCiB5FCPP8Hwcq98KYaq+C9U=
X-Google-Smtp-Source: AGHT+IHSxfTaFhEyc6O91SDuuZui0/DOLGDLleC9mLbJU0/nthy047nsy/eSscQeHpLz94vNG8ePRszCwEPWJvmkYevBfJ12SMsY
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2199:b0:36c:2ed4:8d4c with SMTP id
 j25-20020a056e02219900b0036c2ed48d4cmr167516ila.4.1714558384654; Wed, 01 May
 2024 03:13:04 -0700 (PDT)
Date: Wed, 01 May 2024 03:13:04 -0700
In-Reply-To: <tencent_C006E452DF067C49AD2ED7AED90CAB27CB06@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000076e6f5061761bb3c@google.com>
Subject: Re: [syzbot] [net?] [virt?] [kvm?] KASAN: slab-use-after-free Read in vhost_task_fn
From: syzbot <syzbot+98edc2df894917b3431f@syzkaller.appspotmail.com>
To: eadavis@qq.com, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file kernel/vhost_task.c
patch: **** malformed patch at line 14: @@ -508,7 +508,7 @@ static inline bool lockdep_softirq_start(void) { return false; }




Tested on:

commit:         bb7a2467 Add linux-next specific files for 20240426
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git
kernel config:  https://syzkaller.appspot.com/x/.config?x=5c6a0288262dd108
dashboard link: https://syzkaller.appspot.com/bug?extid=98edc2df894917b3431f
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=167125a0980000


