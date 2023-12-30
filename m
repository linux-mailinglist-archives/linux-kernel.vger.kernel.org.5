Return-Path: <linux-kernel+bounces-13338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 888398203B9
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 06:38:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22B841F2188E
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 05:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601A1864;
	Sat, 30 Dec 2023 05:38:16 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38C3015BF
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 05:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-7b7fe6d256eso1064397039f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 21:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703914694; x=1704519494;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xA09gMB3ML3lOLChXFxZR9a0ioNE2AnJcnW0WH8RchY=;
        b=eFxse+TKviVlJdOOHYm2rqNjYeHI43sU0uGwbXPVuMqguy5iWzz11661wHofSNyTBE
         NlDDnA7HyZco1cmTuZBfFlXt08d8GGl9YNumWjqa49wLZ4HquURDHDFjmuB8BDzwpTl7
         4r7w81RObXrotlGS+5K1yUkJuaxQljmeIzsoH7JAce7NZsOzi5w1HsrBZ/yCTUx0JSbu
         lWF4CDHtmtNoNZIcsB1CQChU699ENHoGJwOIRSlLVg8Vl0ofSPrZR+b8kbGFjTaCgVqi
         0nWGtvfTWl/ae2dJjNaWbTErXevvkuRdVjs80q9Ku5uA6gAvAN/KqETvRmzw5mXcwtgW
         USMg==
X-Gm-Message-State: AOJu0YzEcNVtKnpbm6hlrGz6S8HZQCDKmt220Ur4Q19/CRvUHsidhYV0
	NQXucmV3NbJYJuxIkls/TN7jnyVQ6a/uLQ5Aq4olPNlP2ko6DKQ=
X-Google-Smtp-Source: AGHT+IEe7tV4IBJ3nggmrHzGSAFaBHjmqrypz/WQfrnUl+Q9LkvMA6KEv8l4TVe0gIiHr0F758KVvBWQolh+CKDXmMgYebN0E27X
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:488c:b0:46d:21:773b with SMTP id
 ct12-20020a056638488c00b0046d0021773bmr323361jab.0.1703914694347; Fri, 29 Dec
 2023 21:38:14 -0800 (PST)
Date: Fri, 29 Dec 2023 21:38:14 -0800
In-Reply-To: <000000000000d6b55e060d6bc390@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000015905b060db38ee5@google.com>
Subject: Re: [syzbot] Re: [syzbot] [kernel?] KMSAN: uninit-value in
 profile_hits (3)
From: syzbot <syzbot+b1a83ab2a9eb9321fbdd@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

For archival purposes, forwarding an incoming command email to
linux-kernel@vger.kernel.org.

***

Subject: Re: [syzbot] [kernel?] KMSAN: uninit-value in profile_hits (3)
Author: eadavis@qq.com

please test uninit-value in profile_hits

#syz test https://github.com/google/kmsan.git master

diff --git a/kernel/profile.c b/kernel/profile.c
index 8a77769bc4b4..37f30292b626 100644
--- a/kernel/profile.c
+++ b/kernel/profile.c
@@ -114,7 +114,7 @@ int __ref profile_init(void)
 
 	buffer_bytes = prof_len*sizeof(atomic_t);
 
-	if (!alloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
+	if (!zalloc_cpumask_var(&prof_cpu_mask, GFP_KERNEL))
 		return -ENOMEM;
 
 	cpumask_copy(prof_cpu_mask, cpu_possible_mask);


