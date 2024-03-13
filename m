Return-Path: <linux-kernel+bounces-101730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCDFC87AB17
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 492241F21968
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D97952F62;
	Wed, 13 Mar 2024 16:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="YveUiEzC"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5014F1FE
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347160; cv=none; b=d6Q/S7zdXvNjr9zu8ZbDgusPe1W4ySUys+yKZclxPsaMkS/qw+Bse0txpGI/JEKqnupM398f6DfncDLK8NOjTzgQVWhB/WQpbdsIOnvxq+qE/cVHLpvbVURKUNQEMfk+WqkcNlz6uiu6UxIWV9rLBubKzZxK1IZfYlQqqLqjr58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347160; c=relaxed/simple;
	bh=WZXQ3n6OAHQk56baal6CzZ+snXfrxRm2xjx8a0VoWYc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FdONIzOlBhj48gE5tORHrAJ9Jou6+NswSuPnZ7dXH+Ug7lL/GWL7I9u83kGUj/ge2N6nxXyvpADYJlvbJDaqMn+Es/7gY3Kfsk16I4tGZoDS//yaOtWrNxepOBFR4RASi5jg7FUn/4FcxLGI8kNZ4LU8IuO5Q/9D5AQ2U3JJ560=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=YveUiEzC; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-42f37657e91so26800351cf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710347158; x=1710951958; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=YveUiEzC/32H1ytCovwTz9zaPUHN1E0CPx783n6uHVYrg7GjxAUME3P0UhV1DTd6Ah
         3zMTCZED8Fjuvqmq57tZma7oeF+mofWikhPkKytUA+a4s5Og6RErjr2LieFYUovauFWf
         AKoyQ3gh7xQ13w7nKgU/BOnF9UNTvzgh58A45IPS7AIKCE6zCtSq5askW1IljZw/xnKK
         8yRqkdSl5Noc9xw8a4zyK1+jySvQuVsJV6jJuJUALn1aalzUIfP4aBeat0wXg4y2PVWh
         CevkxTP3UDfbhulwPsQTwX7a/cSOZnQvBmpF1A+5qIQE+C+MtNxsFh8zJnvYeszxXIQB
         KplA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710347158; x=1710951958;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JuTpc8vOHdn72vm+nW+iFZ+lBgZnpQ42Xv3ej2YV4rQ=;
        b=sTRbCzLYiNWSwbr8PTBha8LAwZWJFA7CVsnkr/Ob9bj1i3LlVid9wLkJcivu1u6t67
         8o4B1Av1ajmrcNqq1LRg1nKQbipUl9u9foxi+hpmaJ7vEQgO5Ro1kiwGqW7dNAlejpOv
         0dpXdZ+/GjqMSgWzNvkJKP8b8LQXey+bpV3+szvOZNf0BqG2Maq74uQxwaBBmmuSojTh
         C+zgXfXA7i0i+QGamHDFus+uvJQ58qmFHIEe93qvGAFn7utR4FyNA229i3Ek+qGRLsen
         Y+PDJS8pmhwemq1nIQvldQHw/itNUmgQWA6upaaX9eUO9QRdD8Ds/t1I5B8gcoWCGLED
         owUA==
X-Forwarded-Encrypted: i=1; AJvYcCX8IGJABLFMSu+BmVeMblC4/0tQEdrZtOv7UEDxOqFVr93fgu+JIPmje7d///T9PPGXIvU87rhiST9YjGa6s9LzqAZoWj1J2u/I5gbX
X-Gm-Message-State: AOJu0YwqQDF9N9LnPDlE4qwf7Um2U6kAGevjAi8dQnoSDeoXLzXfgqsR
	+AQ0OtfZT0nE7FDO9Q8QXgWfV1Ble27S5pnza7RVyZJCDGYGrmcm8aqGmLoEMLY=
X-Google-Smtp-Source: AGHT+IEI5lC3i4ZzAG9M2/sNgNAyGuzNjHl2dssxPjvKQlI6GB/Cg43iYqdnjnkGtZ41amsgTrXgsg==
X-Received: by 2002:a05:622a:11d5:b0:430:9773:b083 with SMTP id n21-20020a05622a11d500b004309773b083mr823078qtk.19.1710347158423;
        Wed, 13 Mar 2024 09:25:58 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:f91::18d:37])
        by smtp.gmail.com with ESMTPSA id c25-20020ac853d9000000b0042f2130cd0csm4975824qtq.34.2024.03.13.09.25.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Mar 2024 09:25:57 -0700 (PDT)
Date: Wed, 13 Mar 2024 09:25:55 -0700
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
Subject: [PATCH v3 net 3/3] bpf: report RCU QS in cpumap kthread
Message-ID: <3112a13efb21893b6cf285b3757877dc466c5f58.1710346410.git.yan@cloudflare.com>
References: <cover.1710346410.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710346410.git.yan@cloudflare.com>

When there are heavy load, cpumap kernel threads can be busy polling
packets from redirect queues and block out RCU tasks from reaching
quiescent states. It is insufficient to just call cond_resched() in such
context. Periodically raise a consolidated RCU QS before cond_resched
fixes the problem.

Fixes: 6710e1126934 ("bpf: introduce new bpf cpu map type BPF_MAP_TYPE_CPUMAP")
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
 kernel/bpf/cpumap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
index ef82ffc90cbe..8f1d390bcbde 100644
--- a/kernel/bpf/cpumap.c
+++ b/kernel/bpf/cpumap.c
@@ -262,6 +262,7 @@ static int cpu_map_bpf_prog_run(struct bpf_cpu_map_entry *rcpu, void **frames,
 static int cpu_map_kthread_run(void *data)
 {
 	struct bpf_cpu_map_entry *rcpu = data;
+	unsigned long last_qs = jiffies;
 
 	complete(&rcpu->kthread_running);
 	set_current_state(TASK_INTERRUPTIBLE);
@@ -287,10 +288,12 @@ static int cpu_map_kthread_run(void *data)
 			if (__ptr_ring_empty(rcpu->queue)) {
 				schedule();
 				sched = 1;
+				last_qs = jiffies;
 			} else {
 				__set_current_state(TASK_RUNNING);
 			}
 		} else {
+			rcu_softirq_qs_periodic(last_qs);
 			sched = cond_resched();
 		}
 
-- 
2.30.2



