Return-Path: <linux-kernel+bounces-104862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A095B87D4B3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F0CD284C8A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 19:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ADA4548F1;
	Fri, 15 Mar 2024 19:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="T7F54xHe"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA80535B6
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 19:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710532511; cv=none; b=ZYKMEmddIi19iMsCfKvd0y/tT3C5swHlQg/vEnytHi2Q9J1IPofZbOhMqSMTGJ59dK+dsowKzEU7DJyCtec1pzQsNclbgIFgeEn5YMKv7fb4hXG3Adv3gXj/OIG7MjWBQtmQJajxXCCkEEA92b8Ty1CnU052OEFXvzobTJw0RDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710532511; c=relaxed/simple;
	bh=h0zEXR9iEwGcrR1alN0rw2NJr4Lf0gOSf4DLUKJT8MY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FLFfCWGqyrYiJ1nKwz1OneuWrvimulSWyliRrtH3rYfSCEBVnAtw0U1ZYs4HN0snNPHvl1vhHvwmQEXa8JKlUPcTwMkpOHBc2maxf3gPo7jipa/mNNvOstqBwt0x1wzK06adke5ipPchWiS18FfOj7YBCdIo/2SvGk7NQ9u2Cbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=T7F54xHe; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-690c1747c3cso22735816d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 12:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710532506; x=1711137306; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EbbNmWl+lfF606jlI7tSahkKxu0DvLBvSy6/KumUR7w=;
        b=T7F54xHezWeUQNF5aqawytxJFmXZ7+aOPuXm9nRL2MKfWcJaIVNzOn1AdFQcc8GbYR
         EyEk2XPpV5hHAkP1/TuB6BQJwRZ1yCLZgn6WDWAqmhqcZWZlnDD9BvwZK4dIbEIsO8GG
         sj5G76cggqxJNvyN1WX857CVruQJ1Hj6qDrsWADsLjgLnCcDv+0A90iJkgYwmwnj9x28
         RnDSx7v0Kt1af285HTRFSDM+Ya8wPgF8EVPX0dcMRjUmzW94N3mRG4Mt/HAFifCeyKvc
         DedU16B7L7ZaxdYfsZEhZpPfoYVJrRsQlz5L9LaOUSfn7KnOYP0CpcokHySokXGxVmCj
         5oxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710532506; x=1711137306;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EbbNmWl+lfF606jlI7tSahkKxu0DvLBvSy6/KumUR7w=;
        b=SlflWsg75payHYTSIZqddPePqEjdG2GSKIV6zhFj5EQTGGkg51PuT0QfAtTYupbYtQ
         H8nNxi3e5UmqLSYbezyygLM4/6cCg5Dmm4c37guWAZ6on4xvjtvLXuml6ad9szqMKMW9
         dEOrHty2ff9qC+itSxTmJvShIB7RjG5GowAYObH/f8aJUsqLXuu9GR3sBgbV3GEZXEKo
         URhzzKMoC9sAcCVUqtyG528RmvxsvLbTqTuQxQLt66a5DdKOvS01hdtra+U0oa2HsJT2
         aJo0cQnopzJPIdxuY+4yjcQqf7s76P0G6VMjsJf4mXdKYSfy/NTjCyJbviVn7wUueOnw
         iG1g==
X-Forwarded-Encrypted: i=1; AJvYcCVAjsnQmLspd4aJBoOMemP1YBvnTmAGuaPWEjDq1tG2Dj5MpbI99aTkUWG/GFg+mLr3ZdPj2IooYhLBKYctOTo+ImUUaN1lcOQTsRQr
X-Gm-Message-State: AOJu0YzwnjTNNm+KIlWtYjMebsswScqjpeukdIsIe/OiQiLhHIvWY6j7
	2K80ZnJ4rNkm0qgcczB5C4rzCsAEuMtHavvCWmdDpwogiwlU/53n5DTEu4kbjI8=
X-Google-Smtp-Source: AGHT+IEZQd7hDHzs8WEgt9d/S5CteOD7EJxWIfDQQlT75NalMwM1VREuk3EwSMns3glFGvmJhcYR/g==
X-Received: by 2002:a05:6214:1187:b0:691:4d1f:6a65 with SMTP id t7-20020a056214118700b006914d1f6a65mr9684907qvv.27.1710532506319;
        Fri, 15 Mar 2024 12:55:06 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1046::19f:c])
        by smtp.gmail.com with ESMTPSA id i14-20020a0c9c8e000000b0069160557ec1sm2139110qvf.136.2024.03.15.12.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 12:55:05 -0700 (PDT)
Date: Fri, 15 Mar 2024 12:55:03 -0700
From: Yan Zhai <yan@cloudflare.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jiri Pirko <jiri@resnulli.us>, Simon Horman <horms@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Coco Li <lixiaoyan@google.com>, Wei Wang <weiwan@google.com>,
	Alexander Duyck <alexanderduyck@fb.com>,
	Hannes Frederic Sowa <hannes@stressinduktion.org>,
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>
Subject: [PATCH v4 net 1/3] rcu: add a helper to report consolidated flavor QS
Message-ID: <491d3af6c7d66dfb3b60b2f210f38e843dfe6ed2.1710525524.git.yan@cloudflare.com>
References: <cover.1710525524.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710525524.git.yan@cloudflare.com>

There are several scenario in network processing that can run
extensively under heavy traffic. In such situation, RCU synchronization
might not observe desired quiescent states for indefinitely long period.
Create a helper to safely raise the desired RCU quiescent states for
such scenario.

Currently the frequency is locked at HZ/10, i.e. 100ms, which is
sufficient to address existing problems around RCU tasks. It's unclear
yet if there is any future scenario for it to be further tuned down.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v3->v4: comment fixup

---
 include/linux/rcupdate.h | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 0746b1b0b663..da224706323e 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -247,6 +247,30 @@ do { \
 	cond_resched(); \
 } while (0)
 
+/**
+ * rcu_softirq_qs_periodic - Periodically report consolidated quiescent states
+ * @old_ts: last jiffies when QS was reported. Might be modified in the macro.
+ *
+ * This helper is for network processing in non-RT kernels, where there could
+ * be busy polling threads that block RCU synchronization indefinitely.  In
+ * such context, simply calling cond_resched is insufficient, so give it a
+ * stronger push to eliminate all potential blockage of all RCU types.
+ *
+ * NOTE: unless absolutely sure, this helper should in general be called
+ * outside of bh lock section to avoid reporting a surprising QS to updaters,
+ * who could be expecting RCU read critical section to end at local_bh_enable().
+ */
+#define rcu_softirq_qs_periodic(old_ts) \
+do { \
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) && \
+	    time_after(jiffies, (old_ts) + HZ / 10)) { \
+		preempt_disable(); \
+		rcu_softirq_qs(); \
+		preempt_enable(); \
+		(old_ts) = jiffies; \
+	} \
+} while (0)
+
 /*
  * Infrastructure to implement the synchronize_() primitives in
  * TREE_RCU and rcu_barrier_() primitives in TINY_RCU.
-- 
2.30.2



