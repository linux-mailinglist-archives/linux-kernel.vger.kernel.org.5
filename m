Return-Path: <linux-kernel+bounces-43917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FDD841AB7
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 04:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EFAA1F26250
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 03:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78E8D381B0;
	Tue, 30 Jan 2024 03:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="DKBNEd5N"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8CC376EA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 03:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706586724; cv=none; b=Ur8BqXEf2A65mnyBGMj0h4ROG7D3tDQTIVlV3sRWd3V8k8D0pA0f/j3SvyH2AV2OopQiubzPRRneNFSfku5NCYnIBwQDQm1C8k1QPqYU74SLaqHJMgSnJ0KPJwrJkGUIneTsouMS7Zp8BknicbHYRhG8UTepfanuNmHf1gMhRpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706586724; c=relaxed/simple;
	bh=g3LZEPq6heJ2PjzSdX/5RGenjQC82aVAzQinn15OdBU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JEBdQ7RP/cnecnx/JvRkjNI2e9vu1xk2GtZ3HzH4peVlkvvNS9Ty5+o/SHpLC122jcZ4J+BbRU6OCyYju0hLXXypLSDNHiGHma8aaANTHxB/inItrJimJP1jVkQfVSy6zQttBvN0bV6Rtpd5JOjwaYiWDQmZ4DyVpxCRR900B9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=DKBNEd5N; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-40f02b8d176so1215175e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 19:52:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1706586721; x=1707191521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBB0GD/+gXda5aeiB3X+LkFjStia1JqAQuf0Qc5+FME=;
        b=DKBNEd5NyO1LzWKUkgp61coQZ+2+d7CTpQzs5a/uQEuxa21S3RdpMKuffZ1yCeHRWS
         htCLIEgjwpvKgOrsggpt6cW+ia5bREhdbEdA66U3QIG+P4JB8tWSDv5MZLbs7LWCtaSj
         IBIJ6fQ7liOBIdr0F3pGQUSv3LpbLECJsNiRTLlvXLf0kCw5ijDJQOJvE7FZEAbly7Gu
         NEf05K/gCCqpC9lna5sePVq1HpRW1lMfXnH7aYMTm6nflmQvef95oVDuLm4TbX4H8dK3
         rIAO6nk5maVdWmceQ0IOIP02xTtdtYt8CD157KY4O3nDOFx/jX9VThQW62aHHtaQhf+Q
         xwfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706586721; x=1707191521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBB0GD/+gXda5aeiB3X+LkFjStia1JqAQuf0Qc5+FME=;
        b=KMB8jNuZCPzxLPTdh7wUuU/7zvclboallpoMjkGy+ReYQocROFw27ImD56b4/UjVML
         bLO05IJEevWIjIN0rBMXtCYEwpMXNFFPJ2n2o/jf6anvxdxWGe7YUwd/aYo4vf+3rm10
         kUDXTm3iVEatXd8UB1FpMrRzwKg5WsBaF61Q67CSA2ia7y/nqcgrV83O/RNDWr1HmxLF
         umotvLHxeRpkXDcUFOinsFPFbgyvyLsUGCtF9jIygUpSYMh/sVGoIlDIGdyrdyzxHjuW
         mo7uttuL1JOfUlWHCtTHz2baCmohFThwYZ1d9lQOEuTLprdEhO8dDjlMXhJcrRLpjBYu
         zhWg==
X-Gm-Message-State: AOJu0Yx1FAyGrirCau5ROTNKq3it44a4HRD2L4w0NOOukCT7lyo11yZI
	cPMkKUZg+gRFn5T8ZYPd00cRKlDuhEQVRn2/mVrWsa1F/bd95GrJQgEPT5kQEA==
X-Google-Smtp-Source: AGHT+IFltZVkqklBjWCImfIKZmnuL//3dK2NohBsMAZhtTrRR64UxLbjxRfLFy3PgEbCWICzKFexwQ==
X-Received: by 2002:a5d:64e3:0:b0:33a:e9cc:69b0 with SMTP id g3-20020a5d64e3000000b0033ae9cc69b0mr4114355wri.11.1706586721013;
        Mon, 29 Jan 2024 19:52:01 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id ay13-20020a5d6f0d000000b00337d6aa3912sm9513207wrb.10.2024.01.29.19.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jan 2024 19:52:00 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Dmitry Safonov <0x7f454c46@gmail.com>
Cc: Dmitry Safonov <dima@arista.com>,
	Mohammad Nassiri <mnassiri@ciena.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] selftests/net: Argument value mismatch when calling verify_counters()
Date: Tue, 30 Jan 2024 03:51:52 +0000
Message-ID: <20240130-tcp-ao-test-key-mgmt-v2-1-d190430a6c60@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
References: <20240130-tcp-ao-test-key-mgmt-v2-0-d190430a6c60@arista.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.13-dev-b6b4b
X-Developer-Signature: v=1; a=ed25519-sha256; t=1706586711; l=1578; i=dima@arista.com; s=20231212; h=from:subject:message-id; bh=oDDbsLWpXr1cc2nzkZ+D8Lfqh5gwTIMhKVDrcVIHxuQ=; b=wOh80+80UVdeb8USEOeN8k210twHOJCkW6S4WeORL7Duxc0gwL3jIHLaEP1GvAkoXjSqJR4Na lIWOvijjVxnDjPY1gZnOmWexs8GlGDerBeQ8uimxPHJH2DCcgQRSp8y
X-Developer-Key: i=dima@arista.com; a=ed25519; pk=hXINUhX25b0D/zWBKvd6zkvH7W2rcwh/CH6cjEa3OTk=
Content-Transfer-Encoding: 8bit

From: Mohammad Nassiri <mnassiri@ciena.com>

The end_server() function only operates in the server thread
and always takes an accept socket instead of a listen socket as
its input argument. To align with this, invert the boolean values
used when calling verify_counters() within the end_server() function.

As a result of this typo, the test didn't correctly check for
the non-symmetrical scenario, where i.e. peer-A uses a key <100:200>
to send data, but peer-B uses another key <105:205> to send its data.
So, in simple words, different keys for TX and RX.

Fixes: 3c3ead555648 ("selftests/net: Add TCP-AO key-management test")
Signed-off-by: Mohammad Nassiri <mnassiri@ciena.com>
Link: https://lore.kernel.org/all/934627c5-eebb-4626-be23-cfb134c01d1a@arista.com/
[amended 'Fixes' tag, added the issue description and carried-over to lkml]
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 tools/testing/selftests/net/tcp_ao/key-management.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/tcp_ao/key-management.c b/tools/testing/selftests/net/tcp_ao/key-management.c
index c48b4970ca17..f6a9395e3cd7 100644
--- a/tools/testing/selftests/net/tcp_ao/key-management.c
+++ b/tools/testing/selftests/net/tcp_ao/key-management.c
@@ -843,7 +843,7 @@ static void end_server(const char *tst_name, int sk,
 	synchronize_threads(); /* 4: verified => closed */
 	close(sk);
 
-	verify_counters(tst_name, true, false, begin, &end);
+	verify_counters(tst_name, false, true, begin, &end);
 	synchronize_threads(); /* 5: counters */
 }
 

-- 
2.43.0


