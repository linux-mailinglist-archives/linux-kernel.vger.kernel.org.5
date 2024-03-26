Return-Path: <linux-kernel+bounces-119647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DFC88CB85
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 19:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1755E320004
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953288526B;
	Tue, 26 Mar 2024 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idPN9GsJ"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05CB1B28D;
	Tue, 26 Mar 2024 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711476357; cv=none; b=bSepqGO/rrte/PYaaDx+vx5OHRcZNK1/qldDcWVtVqr55OravYoH+nVWWg8aN4VoLUwzarM6iycbjMFrUg4CLhqBnuBBM7c9vC7HUkJ94QI/vtqxWnT9g33xET2tBBIpyFpHntGChu0R9Tfx8ggsti2faX+JHvVFxfF7NlZ87No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711476357; c=relaxed/simple;
	bh=WVwmfLFTjN/pZJB2PZOy2F3bp1qYpZXyLRMujyUYXzY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sQLE3wKiqASjZc1IOyA3aW8+NFdst8aE9kp4YF/n0nigq6FQvEVhDTyvkh3OQVoQ4hO9vLkrphY0eWcqctKcm4NeMHPkkTPfT/+Eg5tJLKEFHFAo0odaMGUTBa5VsSHcs67ktC7/NmPYehSdIehGlf85VITqwjcUEwAapmpl5ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idPN9GsJ; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d46dd8b0b8so75197861fa.2;
        Tue, 26 Mar 2024 11:05:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711476354; x=1712081154; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s5/Cgp9uewUmDlAlZ60jx5hmzzPypTIAxJ1cc0TNCps=;
        b=idPN9GsJ6psAiuL18D5HGrhOwpg+F8AIW+nz6lV4P4LCYvSaE440YS0FCiqvpJaP1x
         M9bVKu7HkTAvIFVCeN32/ZM5mIMs7iLYxxlqmn1PaZFjqoCdN/EoJZjw20pa1whgM6BK
         nylZPO0WkSGR5ViPGw/Ixqvw81dULFgfHjixzMXpI0K8W4VU98lmHGfhuM8Gdwfyk2gL
         fUcaKEXoQxfWUKHfnmGpxO5XAFtbRdW167MD9JAjTEX6uj54ryLQ9dzTiS4nihaO8dRb
         qdYXIB3LDrX6fvnrASF9Zl4Ssz5GqzbX6ueZFgi3B+Z4JLT1pyWuAnr+wdl+n8YxQMRG
         4fCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711476354; x=1712081154;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s5/Cgp9uewUmDlAlZ60jx5hmzzPypTIAxJ1cc0TNCps=;
        b=cOpMhyLaNPRIqCIkwrlPdS671CJQ9Tfa3vKRTeCnKEBrfSvdtzwFbReOerEHKUbuX+
         6SAXMkVqql6M1ZwplKMkUGAhKP6t+hxj0C6WGa0bj97WkEFgUCeIKuVqdDcSvghp/uIK
         GM0ICg4P3UEDXCi3/uWTKxude3rz+Av7wPuYsBcgcPoV6xH61KdeNCDhtSxK1AqccMsk
         vkIgdpYFh7rtuR8Hcqjkqn1/bbWZAi34G5QSfFlW0TJzWoQgO8tifDk6UC0FgEbFY2BU
         dh93o0fIArB9spisaYt+HfCTHXMO0hSGOsxE186GA6w9SyxbeFY+H/WIM5ZUXKdUTdCc
         ZJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCWhdJvyMxOOEOgBQYI+YNRJ9AviGouzMCWEcjZKgpl7JTJXwniEBsxudtX0dWzRroM2rUXVRssNcHS87vJWU5YNtj+14mn8k84uYSu814mv/NnT+N8hbIKfwu9bqD8+3g0bkRO3xuE+Q8BBtRVCiBqmD0Fi1jqXfkhf4AbsnsRlWyy0T83E0tnB
X-Gm-Message-State: AOJu0YxSnGxrMeEL3BcUvZpY5a7q8uu/VX+NDb0pz/MNXlg/WC98d51C
	5ktJqANtIvV64kRhBdkKTaMYHy9IaVhX7EM6/aijbLdk9EYxBgwN
X-Google-Smtp-Source: AGHT+IHYBm858QXQHIQg6skcaogKllaGjroPEkdwzIRGVNz52r+XzelyPsebqZKuVxRZse98NPQHhg==
X-Received: by 2002:a05:651c:613:b0:2d6:957e:10a9 with SMTP id k19-20020a05651c061300b002d6957e10a9mr1894685lje.16.1711476353948;
        Tue, 26 Mar 2024 11:05:53 -0700 (PDT)
Received: from localhost.localdomain (91-83-10-45.pool.digikabel.hu. [91.83.10.45])
        by smtp.gmail.com with ESMTPSA id fa7-20020a056000258700b00341c6b53358sm8275523wrb.66.2024.03.26.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 11:05:53 -0700 (PDT)
From: Balazs Scheidler <bazsi77@gmail.com>
X-Google-Original-From: Balazs Scheidler <balazs.scheidler@axoflow.com>
To: kerneljasonxing@gmail.com,
	kuniyu@amazon.com,
	netdev@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Balazs Scheidler <balazs.scheidler@axoflow.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH net-next v4 1/2] net: port TP_STORE_ADDR_PORTS_SKB macro to be tcp/udp independent
Date: Tue, 26 Mar 2024 19:05:46 +0100
Message-Id: <9e306f78260dfbbdc7353ba5f864cc027a409540.1711475011.git.balazs.scheidler@axoflow.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1711475011.git.balazs.scheidler@axoflow.com>
References: <cover.1711475011.git.balazs.scheidler@axoflow.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch moves TP_STORE_ADDR_PORTS_SKB() to a common header and removes
the TCP specific implementation details.

Previously the macro assumed the skb passed as an argument is a
TCP packet, the implementation now uses an argument to the L4 header and
uses that to extract the source/destination ports, which happen
to be named the same in "struct tcphdr" and "struct udphdr"

Reviewed-by: Jason Xing <kerneljasonxing@gmail.com>
Signed-off-by: Balazs Scheidler <balazs.scheidler@axoflow.com>
---
 include/trace/events/net_probe_common.h | 40 ++++++++++++++++++++++
 include/trace/events/tcp.h              | 45 ++-----------------------
 2 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/include/trace/events/net_probe_common.h b/include/trace/events/net_probe_common.h
index b1f9a4d3ee13..5e33f91bdea3 100644
--- a/include/trace/events/net_probe_common.h
+++ b/include/trace/events/net_probe_common.h
@@ -70,4 +70,44 @@
 	TP_STORE_V4MAPPED(__entry, saddr, daddr)
 #endif
 
+#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)		\
+	do {								\
+		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
+									\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->source;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
+		v4 = (void *)__entry->daddr;				\
+		v4->sin_family = AF_INET;				\
+		v4->sin_port = protoh->dest;				\
+		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
+	} while (0)
+
+#if IS_ENABLED(CONFIG_IPV6)
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)			\
+	do {								\
+		const struct iphdr *iph = ip_hdr(skb);			\
+									\
+		if (iph->version == 6) {				\
+			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
+									\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->source;			\
+			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
+			v6 = (void *)__entry->daddr;			\
+			v6->sin6_family = AF_INET6;			\
+			v6->sin6_port = protoh->dest;			\
+			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
+		} else							\
+			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh); \
+	} while (0)
+
+#else
+
+#define TP_STORE_ADDR_PORTS_SKB(__entry, skb, protoh)		\
+	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb, protoh)
+
+#endif
+
 #endif
diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index 3c08a0846c47..1db95175c1e5 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -273,48 +273,6 @@ TRACE_EVENT(tcp_probe,
 		  __entry->skbaddr, __entry->skaddr)
 );
 
-#define TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)			\
-	do {								\
-		const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-		struct sockaddr_in *v4 = (void *)__entry->saddr;	\
-									\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->source;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->saddr;		\
-		v4 = (void *)__entry->daddr;				\
-		v4->sin_family = AF_INET;				\
-		v4->sin_port = th->dest;				\
-		v4->sin_addr.s_addr = ip_hdr(skb)->daddr;		\
-	} while (0)
-
-#if IS_ENABLED(CONFIG_IPV6)
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)				\
-	do {								\
-		const struct iphdr *iph = ip_hdr(skb);			\
-									\
-		if (iph->version == 6) {				\
-			const struct tcphdr *th = (const struct tcphdr *)skb->data; \
-			struct sockaddr_in6 *v6 = (void *)__entry->saddr; \
-									\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->source;			\
-			v6->sin6_addr = ipv6_hdr(skb)->saddr;		\
-			v6 = (void *)__entry->daddr;			\
-			v6->sin6_family = AF_INET6;			\
-			v6->sin6_port = th->dest;			\
-			v6->sin6_addr = ipv6_hdr(skb)->daddr;		\
-		} else							\
-			TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb);	\
-	} while (0)
-
-#else
-
-#define TP_STORE_ADDR_PORTS_SKB(__entry, skb)		\
-	TP_STORE_ADDR_PORTS_SKB_V4(__entry, skb)
-
-#endif
-
 /*
  * tcp event with only skb
  */
@@ -331,12 +289,13 @@ DECLARE_EVENT_CLASS(tcp_event_skb,
 	),
 
 	TP_fast_assign(
+		const struct tcphdr *th = (const struct tcphdr *)skb->data;
 		__entry->skbaddr = skb;
 
 		memset(__entry->saddr, 0, sizeof(struct sockaddr_in6));
 		memset(__entry->daddr, 0, sizeof(struct sockaddr_in6));
 
-		TP_STORE_ADDR_PORTS_SKB(__entry, skb);
+		TP_STORE_ADDR_PORTS_SKB(__entry, skb, th);
 	),
 
 	TP_printk("skbaddr=%p src=%pISpc dest=%pISpc",
-- 
2.40.1


