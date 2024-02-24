Return-Path: <linux-kernel+bounces-79522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EB3862396
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:05:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C3FDA1C2195E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 09:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3701DDD1;
	Sat, 24 Feb 2024 09:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="JkdJLm/W"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDA518628
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 09:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708765488; cv=none; b=sxJ8xPwXHvzpBao33NDpfnJHl3T5Ml6cO9nGSBQAcoJkY25Qu4fSmCcvVuMvSNDKOuKzokT+V4DATIzEgc5Jao48DN1ADmVxEdIqN8tdKaViPQgREBbnPpgdvt54WFJeRasFGAHp6dBcg+4IV/9kBr5NYnnGmtCsmgenXjDtvuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708765488; c=relaxed/simple;
	bh=MVFcWwkG7n4Gl2hWUwI00JsntCopPDcwfLrApRfCBMw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BxXKjMYCdbJbziInIAMnMfA5Zi1zzmQH0bU3oBdRMtplwvNjxT/UfjU1MwELEBs/K901puJFnU5NdCq0AHNQLl3+RpHjOOQf93dX7Gpv3vT0bqPDekTUMELXESYQugy8cXbnelvvxQXncsJrey2ryBnWHMnjuz8lqEAGT+W0I4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=JkdJLm/W; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41298159608so4364615e9.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 01:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1708765485; x=1709370285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Juqpa+YmJMwWq9ujgAmWRIwmIrMmMg68TxjW3KTtjMY=;
        b=JkdJLm/W/2E0JuRaSjNeRaBuvh0Q6nUFzXkuTjEDekShHSYiXMGrAJyzo08+y1FlAq
         4s42PdQmLfhcs2HCFUYY1oqDvamI4m6dax5rAfZuUepnswPsOYgrcL5fLrY8L5eB9nYH
         3+JsCdtnuGr5E4ZfWnHQVYh2tKQeZ9omPMsSDrzhog/PTKMgQ7PaKO/Ym5zaL+nyepqS
         K9c2Gs2cEHBryvnZd+aCFq8iyl14r8mEQUJz7cIguLr4EtxAyzSAkT+4HUjXv3zD8v6h
         r8/23pY3rzQ/D3u8fspW8blhHj4L9bsKNh0U5zLwOuLqVxBiV8tmIfIC9SMd6xW/Utc8
         Cekw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708765485; x=1709370285;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Juqpa+YmJMwWq9ujgAmWRIwmIrMmMg68TxjW3KTtjMY=;
        b=FgLH7AyrVEO0vRKjm5efH7gMoPG/8EGf0tCxeo7+RE5CzbU6PL/90796seaBA3By3z
         89cT7KFNnYPFFgjYzEboED8vA3XWLixBtFfhiTQKFkURHJcLZgYDQV8syYSGlAy9WMay
         iS9NXJL6NbPOg6QmdADCmJrwHSzYwdriKPEkOmGSSJIZnbWhWd0ii5uQkmXEc15QIR7j
         kfuWm5/u8fIwm1PHFkW20Wj/Odj+BNRqpzgj5ixz8RCZzmwgYJ7EMXpHn9Qdfhfym88j
         Khv+YdcWw69Z6IU7ahNa0Jh1vG7Xqn4SrmK0emhp154jwkfx8VqPy06HAgoi4JltKKbh
         5ddQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7kStGQOz16TsFZoRW0cSS4JoAd2MvJLvo4sgZIxK1GrBeCdxB2Mdc1+BLkrhV3m+lI0DpvbLyzVUQmdNmUm0qdetpXpwsas2j0lE9
X-Gm-Message-State: AOJu0YwL0fhdE8+1viv7rL9zhZAKbCQW1Cj/FD5r1BEb6dTf64FoUHlO
	tmKHE/6JXgJXLVqRtCkx75Dj/OJyhycJO7csaGiA6XW1Wnc9U8sJKEoEV6NEZA==
X-Google-Smtp-Source: AGHT+IE/v4Y77xHfDfwUj7mgt7/JJNZWj546Xq0JHNRXMyVIyZqM5v5JOrhU5whoc/IWfYePwfpQdw==
X-Received: by 2002:a05:600c:4708:b0:412:8f3f:bd06 with SMTP id v8-20020a05600c470800b004128f3fbd06mr1948177wmo.8.1708765484836;
        Sat, 24 Feb 2024 01:04:44 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id m6-20020a7bce06000000b00410bca333b7sm5320593wmc.27.2024.02.24.01.04.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Feb 2024 01:04:44 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Dmitry Safonov <dima@arista.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Dmitry Safonov <0x7f454c46@gmail.com>
Subject: [PATCH net-next 02/10] net/tcp: Add a helper tcp_ao_hdr_maclen()
Date: Sat, 24 Feb 2024 09:04:10 +0000
Message-ID: <20240224-tcp-ao-tracepoints-v1-2-15f31b7f30a7@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
References: <20240224-tcp-ao-tracepoints-v1-0-15f31b7f30a7@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708765347; l=1223; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=MVFcWwkG7n4Gl2hWUwI00JsntCopPDcwfLrApRfCBMw=; b=dYV67W6rPZfpE9Z+hOApC8UtuF3cZlqJCdYtSwEPqPdI/XlEslH54K7WXEmeNVQZYPNjTlQfD rproo9nfyO5Ab6uMz3+AcGp19e8cuXGVCR5WBgvfXMlxprRbocWK6P4
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

It's going to be used more in TCP-AO tracepoints.

Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h | 5 +++++
 net/ipv4/tcp_ao.c    | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 471e177362b4..6501ed1dfa1e 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -19,6 +19,11 @@ struct tcp_ao_hdr {
 	u8	rnext_keyid;
 };
 
+static inline u8 tcp_ao_hdr_maclen(const struct tcp_ao_hdr *aoh)
+{
+	return aoh->length - sizeof(struct tcp_ao_hdr);
+}
+
 struct tcp_ao_counters {
 	atomic64_t	pkt_good;
 	atomic64_t	pkt_bad;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 3afeeb68e8a7..8726aa58e8b6 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -884,8 +884,8 @@ tcp_ao_verify_hash(const struct sock *sk, const struct sk_buff *skb,
 		   const struct tcp_ao_hdr *aoh, struct tcp_ao_key *key,
 		   u8 *traffic_key, u8 *phash, u32 sne, int l3index)
 {
-	u8 maclen = aoh->length - sizeof(struct tcp_ao_hdr);
 	const struct tcphdr *th = tcp_hdr(skb);
+	u8 maclen = tcp_ao_hdr_maclen(aoh);
 	void *hash_buf = NULL;
 
 	if (maclen != tcp_ao_maclen(key)) {

-- 
2.43.0


