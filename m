Return-Path: <linux-kernel+bounces-120059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56D788D10C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 23:35:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81322321E90
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F43C13DDC5;
	Tue, 26 Mar 2024 22:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="bxtrlIfD"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B821131185
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 22:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711492491; cv=none; b=t6MfT/Bxi/EJLEjw6hFIgeEoGU6RtrOzNB20F3ID2CULJbfrp4nGkM795z6V2mp7URHD5B/fXzDTbOKfdKbh3hCwkWZkrmv+Pe29JZ+yCzwu4zcsaRqAfiJGkLEipna+ASwQsSM6qcbcc/DsGVPTAUT2bBbiNR4acl8IUCMK7Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711492491; c=relaxed/simple;
	bh=0M4LvvNI77zQI/9DV2/Qo4nlzkup1uIbZ/plEPq0ClM=;
	h=References:From:To:Cc:Subject:Date:In-reply-to:Message-ID:
	 MIME-Version:Content-Type; b=HZ7lRfUc1SQ7LajMxGdspHzcsCiXJp7z5G0cK5RQ+x/AnI13JAppyYgsuZMkQqtEg2lrMuXd2mNYemTGktPvQ+TMCeRIQyBYeHFtkI224fQeWqRg5JSf9u3xeKYJf68oxagCpT9FlZMUfFOP7Sndg36d4akLxSZ/mQxwW0gXZOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=bxtrlIfD; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-56c36f8f932so550940a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 15:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1711492488; x=1712097288; darn=vger.kernel.org;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=ab5N2/+UMfCyeLSLqFwz+fy2fJSFKubepMeB6XNxJn0=;
        b=bxtrlIfDbbiE/5MrJFqFtrQrJ50HoLyNg9llDly7kaSAi+zSWauS4PBLKN/3QAmD3T
         ZFgg9rMOD4gSXQbu9mWywK7vJiOZ19uKpz470DBzEDiD8P1x26fhK6VdTDlTVnRuLg/D
         aBQPJ29Lom9hqjUOzPgc+1bfi3RbFHXe8H1yezqnL4rWkBlF9zIFg52i10HcUNXvqJxV
         3DLAKxttTZgbIR0pK5cxZkliX+4MXfxO/0rPkeS0KvsDr4hUbBrIerq4wtmVt8lDuGWl
         zqCGlfY9rfVerVbW6yzIzSr1O86Kw72TZvAPpMQCLtykwg7re0kSg34AprY/yn4BoByZ
         xyNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711492488; x=1712097288;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ab5N2/+UMfCyeLSLqFwz+fy2fJSFKubepMeB6XNxJn0=;
        b=kBEp5R8ALREWRjyMfxqD4Z8NJE+k5ITNlOD2/4JigYvZMK7ZCbuwhUlwYEafY+1Sdn
         YL+tctwLf8u+xpcxbNPFDfFMEUf+rWel43MaHYSUZ2YK/mn3nOJ/2yvYT/i/ZLBxmx3C
         lfvfKBc/22S5N7h7kxxKjYurO1XarhSHizFMqnOeSfQoHuySIUC9U7W2ODRptSuUG4Dz
         sny9kovS763EcNPcaqZexfxbisXYilFYyfMdqI0XIJyMrKCcTBAWe+R6iBRZBdVdK8ST
         bVyFpGNOj66+BaNOQkSNE+H3ftet/W4RKnQUVnztU+Oab+en4iJ8twz3CaCy4F9nakQK
         f7Eg==
X-Forwarded-Encrypted: i=1; AJvYcCUATKWnHP4Vos0LhJvwPE/mFlxGzKvM8wlRzGx+zwRVUsZn+kNKYUmwzdyg0onkmU5mtO72U5RCyBU6tc3sSBS1eiUKtF5SI75OKWsB
X-Gm-Message-State: AOJu0Yx2bizSf+obJQ+ebmykVw7hwGyiVrXIvTn1lKfiPJaJiXQowJS0
	FbmxV5UZsm3k0OZS6hRDlKwUQ71NexFoE24wGB2BD0X2Olx064eMlPkmm8zctcA=
X-Google-Smtp-Source: AGHT+IFd29NI7E7fmbI2DetVVaDs2M2zc93WZvEnIfgrzdHQe3qFznuwCZPaHATWQui+pZyinL6lOw==
X-Received: by 2002:a17:906:2655:b0:a46:e9f9:2208 with SMTP id i21-20020a170906265500b00a46e9f92208mr2494997ejc.3.1711492488485;
        Tue, 26 Mar 2024 15:34:48 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5064:2dc::49:1b1])
        by smtp.gmail.com with ESMTPSA id v8-20020a170906180800b00a46be5169f1sm4672377eje.181.2024.03.26.15.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 15:34:47 -0700 (PDT)
References: <000000000000dc9aca0613ec855c@google.com>
 <tencent_F436364A347489774B677A3D13367E968E09@qq.com>
 <CAADnVQJQvcZOA_BbFxPqNyRbMdKTBSMnf=cKvW7NJ8LxxP54sA@mail.gmail.com>
 <87y1a6biie.fsf@cloudflare.com>
User-agent: mu4e 1.6.10; emacs 29.2
From: Jakub Sitnicki <jakub@cloudflare.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Edward Adam Davis
 <eadavis@qq.com>, John Fastabend <john.fastabend@gmail.com>
Cc: syzbot+c4f4d25859c2e5859988@syzkaller.appspotmail.com,
 42.hyeyoo@gmail.com, andrii@kernel.org, ast@kernel.org,
 bpf@vger.kernel.org, daniel@iogearbox.net, davem@davemloft.net,
 edumazet@google.com, kafai@fb.com, kpsingh@kernel.org, kuba@kernel.org,
 linux-kernel@vger.kernel.org, namhyung@kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, peterz@infradead.org, songliubraving@fb.com,
 syzkaller-bugs@googlegroups.com, yhs@fb.com
Subject: Re: [PATCH] bpf, sockmap: fix deadlock in rcu_report_exp_cpu_mult
Date: Tue, 26 Mar 2024 23:15:47 +0100
In-reply-to: <87y1a6biie.fsf@cloudflare.com>
Message-ID: <87plvgbp15.fsf@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 25, 2024 at 01:23 PM +01, Jakub Sitnicki wrote:
> On Sat, Mar 23, 2024 at 12:08 AM -07, Alexei Starovoitov wrote:
>> It seems this bug was causing multiple syzbot reports.
> Any chance we could disallow mutating sockhash from interrupt context?

I've been playing with the repro from one of the other reports:

https://lore.kernel.org/all/CABOYnLzaRiZ+M1v7dPaeObnj_=S4JYmWbgrXaYsyBbWh=553vQ@mail.gmail.com/

syzkaller workload is artificial. So, if we can avoid it, I'd rather not
support modifying sockmap/sockhash in contexts where irqs are disabled,
and lock safety rules are stricter than what we abide to today.

Ideally, we allow task and softirq contexts with irqs enabled (so no
tracing progs attached to timer tick, which syzcaller is using as corpus
here). Otherwise, we will have to cover for that in selftests.

I'm thinking about a restriction like:

---8<---

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 27d733c0f65e..3692f7256dd6 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -907,6 +907,7 @@ static void sock_hash_delete_from_link(struct bpf_map *map, struct sock *sk,
 	struct bpf_shtab_elem *elem_probe, *elem = link_raw;
 	struct bpf_shtab_bucket *bucket;
 
+	WARN_ON_ONCE(irqs_disabled());
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	bucket = sock_hash_select_bucket(htab, elem->hash);
 
@@ -933,6 +934,10 @@ static long sock_hash_delete_elem(struct bpf_map *map, void *key)
 	struct bpf_shtab_elem *elem;
 	int ret = -ENOENT;
 
+	/* Can't run. We don't play nice with hardirq-safe locks. */
+	if (irqs_disabled())
+		return -EOPNOTSUPP;
+
 	hash = sock_hash_bucket_hash(key, key_size);
 	bucket = sock_hash_select_bucket(htab, hash);
 
@@ -986,6 +991,7 @@ static int sock_hash_update_common(struct bpf_map *map, void *key,
 	struct sk_psock *psock;
 	int ret;
 
+	WARN_ON_ONCE(irqs_disabled());
 	WARN_ON_ONCE(!rcu_read_lock_held());
 	if (unlikely(flags > BPF_EXIST))
 		return -EINVAL;

