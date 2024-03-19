Return-Path: <linux-kernel+bounces-108116-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A98880633
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98B621C21A99
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890FE3FBAF;
	Tue, 19 Mar 2024 20:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="WjVndhal"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7803BBFA
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710881080; cv=none; b=suORAGIHF6F7CPhkWpZ9fZimcBTBQLSqqHiSZzAnmWNlx9XbGROtOWBCx+cESO0yh0fqEHr35O1aKgqV2K9pQhlYEaNN7W2P2a49yNdo3azJ9E4RyCwUwpWk4s3Xj0xj2olOmhH2fLCmwp7AP6TihINIqjJUj8wfXgEOFQpm8o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710881080; c=relaxed/simple;
	bh=ZAThU7X8Id0Ifv3iZYWLGZRQ2drhENDwE2HLxuCty7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H6CYV4BLNJy0agQauQz9apFogO3aOlHKYtQk4NzTeW0OuORG7H9xvAPo0hVhQg4WMBqXmSsm5hFSVs2nnV4j/X+UlrSrpdJIVK8Bqwd1nA/8yiSno3jip741IezkHqP1necxMrA9Z/96u4KI5moRDKazQq6qzpS2rO8uY1YT/Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=WjVndhal; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42ee23c64e3so24450311cf.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:44:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710881078; x=1711485878; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DhzHlt2GgEWWpszDk+jfUxmmnOotOx21FcVTcjSCNeQ=;
        b=WjVndhalYYr9Sz1PTyICYsAXuaQju457TgXB1vmBCskifqLPojR0+IxYYPcOaWTQiZ
         +zafvpQZtkBi3IUAhY3AG0eu3kpeIWb9MXwoz35NJOXpqhBesEBB7mutauHACMAsBbfk
         OKD5k9teYFOPQVUqTZYQBjaVnWCz2wd2FJcC8tZk7rm51R29g/6zFEDlx2pjQzaUVdrd
         8qZJz/7dnkPOg0F7NjMlJQ1ZpYn44Jw1rpnILbQbIRRzxvPnS0SXA0k9zFZvEI49utBX
         vz8U577AqGnSyi0rgWLgOqGU01YUtw7y1HRYRiE8Pte5WKITOWmAlDY9vMn+xpumFWgS
         6mAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710881078; x=1711485878;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DhzHlt2GgEWWpszDk+jfUxmmnOotOx21FcVTcjSCNeQ=;
        b=elaqa14LX+RBDmy48FWFbxfiZ0du60NM7+rLbYWHe80YnQaEbDE8rhoevMtkyrWp8y
         Eur19zO7VUmKmK7fkSyyjtw9x697gjKiQVr3JntjQIRfQC5plKhc9ATURSAxZPqeKtqw
         lMPPXj0yGS6vpNWWm3ddB7GXrgBFQ+kE7G22CVVBgV0ygLgQ+oLYc1IVfM0dK0THsosj
         QNN6pPQ0oERv8RDgPxGllx+4DX2+P6sUyajsL74MRjGMdBqMq8b8KBcsxO9yU7obEYYt
         muuHX/yxH5JaiuvCUxrWluMz2zOJiOOe82gKlqy7VMqcytEL/XBgiZEzM93WAkcHTjPh
         x+qA==
X-Forwarded-Encrypted: i=1; AJvYcCUOvLyFQWQAYaYW96Q3RwNkf6JnMiV8zjNhvCzKIW3Uu1SrvtfzR7xY8IWvfv7DMaNOqqwRHJIpIN/zIfnAlGQe/pcNPAu+FO6RXpdA
X-Gm-Message-State: AOJu0YwZMM9YFVf2t//8/HC+e1IxnX+t0V/gJejiMkQw2rbMkDxex/l/
	kEg7n2Hi7Hj1jBVFoVLLWH413jOyfNRHmKo27UR63JZ6GIu5juqQ3BibKSw68no=
X-Google-Smtp-Source: AGHT+IE0UM9LxDtJtc5S/HyOTxf5CvZO+23gx12ZhJ+rAVD9OduvA+dRZqVWHTNHXmdvPaVSKpTvmg==
X-Received: by 2002:a05:622a:1746:b0:430:eeba:b30 with SMTP id l6-20020a05622a174600b00430eeba0b30mr2430930qtk.43.1710881077371;
        Tue, 19 Mar 2024 13:44:37 -0700 (PDT)
Received: from debian.debian ([2a09:bac5:7a49:1cd2::2df:49])
        by smtp.gmail.com with ESMTPSA id i13-20020a05622a08cd00b00430eecd29c5sm790856qte.63.2024.03.19.13.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Mar 2024 13:44:36 -0700 (PDT)
Date: Tue, 19 Mar 2024 13:44:34 -0700
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
	linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	bpf@vger.kernel.org, kernel-team@cloudflare.com,
	Joel Fernandes <joel@joelfernandes.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>, mark.rutland@arm.com,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v5 net 1/3] rcu: add a helper to report consolidated flavor QS
Message-ID: <90431d46ee112d2b0af04dbfe936faaca11810a5.1710877680.git.yan@cloudflare.com>
References: <cover.1710877680.git.yan@cloudflare.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1710877680.git.yan@cloudflare.com>

When under heavy load, network processing can run CPU-bound for many
tens of seconds. Even in preemptible kernels (non-RT kernel), this can
block RCU Tasks grace periods, which can cause trace-event removal to
take more than a minute, which is unacceptably long.

This commit therefore creates a new helper function that passes through
both RCU and RCU-Tasks quiescent states every 100 milliseconds. This
hard-coded value suffices for current workloads.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Jesper Dangaard Brouer <hawk@kernel.org>
Signed-off-by: Yan Zhai <yan@cloudflare.com>
---
v4->v5: adjusted kernel docs and commit message
v3->v4: kernel docs error

---
 include/linux/rcupdate.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 16f519914415..17d7ed5f3ae6 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -247,6 +247,37 @@ do { \
 	cond_resched(); \
 } while (0)
 
+/**
+ * rcu_softirq_qs_periodic - Report RCU and RCU-Tasks quiescent states
+ * @old_ts: jiffies at start of processing.
+ *
+ * This helper is for long-running softirq handlers, such as NAPI threads in
+ * networking. The caller should initialize the variable passed in as @old_ts
+ * at the beginning of the softirq handler. When invoked frequently, this macro
+ * will invoke rcu_softirq_qs() every 100 milliseconds thereafter, which will
+ * provide both RCU and RCU-Tasks quiescent states. Note that this macro
+ * modifies its old_ts argument.
+ *
+ * Because regions of code that have disabled softirq act as RCU read-side
+ * critical sections, this macro should be invoked with softirq (and
+ * preemption) enabled.
+ *
+ * The macro is not needed when CONFIG_PREEMPT_RT is defined. RT kernels would
+ * have more chance to invoke schedule() calls and provide necessary quiescent
+ * states. As a contrast, calling cond_resched() only won't achieve the same
+ * effect because cond_resched() does not provide RCU-Tasks quiescent states.
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



