Return-Path: <linux-kernel+bounces-92534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D773A8721C6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 15:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9123128AC37
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 14:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B90986AE9;
	Tue,  5 Mar 2024 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CYbZOhqS"
Received: from mail-yb1-f194.google.com (mail-yb1-f194.google.com [209.85.219.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126B486AD5;
	Tue,  5 Mar 2024 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709649736; cv=none; b=P+QKrYT2ZmfHmp1Nq2hdPmybI+rTg4z8zkj1VCdjj7C4Irihm+WfJ+WGuKe/pZ/rsOx65ocEERPws5KgEKauN0nVGco6WD0WIhaG8l5TdeB26GSuvfBYf6XI0YOTKAj9oJyfzXFGfixRUe9tDtraNa0Gr4GhAEFym0ROXh29oVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709649736; c=relaxed/simple;
	bh=gOkcqvkH4D3gY0n9wniKJjMcha0dhupF5N5XpLv3Ch4=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=qehryNLjs8eJF1CW0DhpR3enX5C6Ka0VUZ6oRcC9cekuVNA/c2CkKLzbRCcMS5PTchXdSTZ7CRwmQQRDIEUcbGDg9CTK+9Va3JVONymAeBUnN8pwo5zR64XvsZ2ZDSCH+Ds9HUoHHqMVj6tOLwaJOFRw8YAqWqxZWaUKa7iMmMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CYbZOhqS; arc=none smtp.client-ip=209.85.219.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f194.google.com with SMTP id 3f1490d57ef6-dcc4de7d901so5391267276.0;
        Tue, 05 Mar 2024 06:42:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709649733; x=1710254533; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=csPhwUZ0maNDO/kaNYv8h2cWEul9MJDz344oSfBRaZ8=;
        b=CYbZOhqSCJfaAfalrPOqAYvpwslqG6k7JsfcTVNzN5Tu9QT4Y8n1DsI9HrtzHf6kLM
         y8/nat2+zAnUF9haQmZ/P5eQE/93sYBG9M5YESDVP3fHjRshvaNsjkhZYZERG2fck9Em
         iw8dY+6NYCi2beOAumop6D1PFoPdK2lP4ZgXiPFfS8/gG0xHC1y6FCzy7WkYSjY2gKV/
         WfMy25+hnVhJXo9UBZ25mo8bejI6mve+rJxwAdWLLFUKdE/xPsvRuaJC6NwVbLtw4s4k
         labiWVETsCnEf39nokhMrl5ARcEO1t6NkpuPfmcTma6j+Yqd0Ju2q3HdeL4J38QI5hBx
         HrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709649733; x=1710254533;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=csPhwUZ0maNDO/kaNYv8h2cWEul9MJDz344oSfBRaZ8=;
        b=t0EV1cEPSgPscABjceyiys2wdiEdqvjqTgYh45YO/Uo4yICmCWxvLFvanVE2EmMy+i
         OrRrdNsAPRYZtATQGUZZAgEpF1yuj71Njlxk/KjVZDOL24OSFJevotKnWlt/JsNqUnIe
         kiB5LMxvRtDxSELe2BoV9i+OChIUPw0bOMeXxZi62kPRrPrI9gWc7F2G5YXrzQy5XFcW
         5Sa9OfPMV9DEYTdikOJNwEgF1bjY4PqmfMx3Ji/gnm2PU9e80uMyL84ytrKmo97FlMgH
         23JtTaw4mX5bTou11r52AAZCzFgGtWc5gEpfCkJHMDw+NC1DqR83uF/A0Cxg3iDsG36G
         2ccg==
X-Forwarded-Encrypted: i=1; AJvYcCVvBI6sj1KB/0/nGFA+GhD/RIvsHF5rXI5y+EnQ2pT2HrWd6i29LesD66GcUjwAsatgBTQ4uPY5olQBuwWdx3BoUdLk98F3xcDHhDyVBG9Jgmj7xDLwilycY0Mz2pJ24OsmPEfw
X-Gm-Message-State: AOJu0YyhbWPMrTxb/U5/P7okkGHvcljftVeYEf/CMHJgpfaMZQy+XmRR
	g6jxM0LxnK0CiBEiqKBuvdlVX8uNF8zDDmXzRj36mfcdNcI8DTaThKfs+COiRBkjui+84kaRYcp
	evIu32gkld2ZUwD/q8lIHfrWi1c4=
X-Google-Smtp-Source: AGHT+IHWHDy+FAU3g6qvTuYFUmEnFnw6aA+MA+BXaZcVDBrx94Z8KwzZE6neyEITOiDh3pAIUCK5OH2PPx2cLHbFkf8=
X-Received: by 2002:a25:b9d2:0:b0:dc7:4f61:5723 with SMTP id
 y18-20020a25b9d2000000b00dc74f615723mr8551184ybj.39.1709649733725; Tue, 05
 Mar 2024 06:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Zixuan Tan <tanzixuan.me@gmail.com>
Date: Tue, 5 Mar 2024 22:42:04 +0800
Message-ID: <CABwm_eRuL9UXanmTaC7U820=8GLAHHwWuFP=REOpECsPR+pPvg@mail.gmail.com>
Subject: [PATCH] net: bridge: Replace deprecated build flag HAVE_JUMP_LABEL
 with CONFIG_JUMP_LABEL
To: Florian Westphal <fw@strlen.de>, Roopa Prabhu <roopa@nvidia.com>, 
	Nikolay Aleksandrov <razor@blackwall.org>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Pablo Neira Ayuso <pablo@netfilter.org>
Cc: bridge@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

The build flag HAVE_JUMP_LABEL has been deprecated and removed in commit
 e9666d10a567 ("jump_label: move 'asm goto' support test to Kconfig").
It is no longer defined or used. The correct flag to use is CONFIG_JUMP_LABEL.

Fixes: 971502d77faa ("bridge: netfilter: unroll NF_HOOK helper in
bridge input path")
Signed-off-by: Zixuan Tan <tanzixuan.me@gmail.com>
---
 net/bridge/br_input.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bridge/br_input.c b/net/bridge/br_input.c
index f21097e73482..3700e47ff181 100644
--- a/net/bridge/br_input.c
+++ b/net/bridge/br_input.c
@@ -255,7 +255,7 @@ static int nf_hook_bridge_pre(struct sk_buff *skb,
struct sk_buff **pskb)
    int ret;

    net = dev_net(skb->dev);
-#ifdef HAVE_JUMP_LABEL
+#ifdef CONFIG_JUMP_LABEL
    if (!static_key_false(&nf_hooks_needed[NFPROTO_BRIDGE][NF_BR_PRE_ROUTING]))
        goto frame_finish;
 #endif
-- 
2.40.1

