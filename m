Return-Path: <linux-kernel+bounces-64215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 37296853C0C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 21:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BB053B21FCC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 20:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1B60B8E;
	Tue, 13 Feb 2024 20:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1Ar2/Vhm"
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB275FB8E
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 20:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707855110; cv=none; b=oM+HsH4O9VZziyT45O9zGi5zam/4Yq6GVAScUJHYStqvZzSxzB6QL52R7cWmRhrAU7hACbvOZBLS5rs8iY3UMhctgtbkGxfxDbYizjwfBMH5flpwPO4g4rXq/UGLbN42hEc76s53ZOUDxuT/ow5b9Y8mHY8W0/LQaduyw5eEzAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707855110; c=relaxed/simple;
	bh=VBS16/kMyx2f20eZKr1u+bSkeWuiKrVVw2Zxr1GXfWM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=u2W1JYdA5LcG9864qSLRNW1zS26KfGuzRQnZsnj9PdHuWFhaX/UCUEHibAuDNSbBk/ldVE06tI10dlvXX9i7zx38bZPtRH3OAgK7psnYABSc0h26A14efT+uKPczR08g3q00geMEaTLFunAHSLZNRGQRWVOQBSzPGYLjxUKiza4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1Ar2/Vhm; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ericchancf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5efe82b835fso106852527b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 12:11:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707855107; x=1708459907; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=9AN85m1qKFo3T4IguFVx7FthdqHAYUz/jnXNP6aoo4M=;
        b=1Ar2/Vhm+MXWB6BhKB+P9hn5RQYDTgdxDuYZOGO7aF4mr7D7jSTQr6F6ur7gESaLZV
         /zGPfQfoMtKjQaNMkI2VKFKLIifjc140kZyQ6dkwEUzPj9Zf7vboGOd2C0d2PL2r4olC
         bRQFv5gv2zbLLNxV0V4FsjVrMcAirfeMKdIrHl0chzjWPXg8bfXEyZabAowHnHYgO4Tf
         FDHI68rm74vGn8VU778niW4E0V+ippKZ99eLPu7/3bh+MN/ifnsqJg4WfIcGBMMykTlQ
         rq6d9Y7I9hP0elU+gy4xJlFEFDuQGKKE8Bk5YeSW86YeQK/DoZzLErHApzh+aG2X2OC7
         NtIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707855107; x=1708459907;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9AN85m1qKFo3T4IguFVx7FthdqHAYUz/jnXNP6aoo4M=;
        b=ds7YPJoOunav8JZdFLz8wpUC/jWfFfNNIqChS6ck2FTVsBWb1xYfLpjzhF70+Q03b2
         RALtE9VIsNK+shOsFZmJESsioR+HM6lHH3LGg5XM+GkuEyOeAsPBRCNR5t12D2NppgXy
         1tb/zwrM0FP3GXsgUrdNG8VCMPADX/lF2+sqkNtGW2HncJxOviru1sw5HS3uE0s1SE+e
         7Bd4/BqAT7ywmQcjXxz6pRvkDX23HVineMUZI3IDhbu2p1YKArTmduUO3TBT0e1mxQJM
         kYEoTtTRweZ0dGVqvpTL7ptdSMWCBRpGrgi6ebHUgW7MWXBLB3Nw81b3nLdKAlkxjL/d
         5SbA==
X-Forwarded-Encrypted: i=1; AJvYcCV651hGpPeTVcv9W3WurymzRLY03ESpVNKhE5M4Wp0z/s3utp5agUIznykJxIjjnEv4Z18lLmA/W0RcR0TJpIlln40wxg0RUxeW4ka0
X-Gm-Message-State: AOJu0YwlFChgSOWzUSyGbPeUof8sy3Cdkht33Z4UQ8CSmHk6IjGEC/TA
	i+eTRAd8Wb6dW4k3okpHa2Y/ogdzWPNJfa69zZs8xbNv7rN1ZA+zt690/7Cjl+IGiJ8LkaaIaO2
	SmY8vPbi2BeSuTBZySA==
X-Google-Smtp-Source: AGHT+IGMIclG+7YbInh36DBFGSv+S+9wOLUvuY0VCBHEkOA7/oMOOhJaZ/IoUpXnIoxvZ+FmUQ5Y/z21q44C2Xhz
X-Received: from ericchancf.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:4139])
 (user=ericchancf job=sendgmr) by 2002:a0d:d989:0:b0:607:8b76:4744 with SMTP
 id b131-20020a0dd989000000b006078b764744mr104441ywe.2.1707855107574; Tue, 13
 Feb 2024 12:11:47 -0800 (PST)
Date: Tue, 13 Feb 2024 20:11:41 +0000
In-Reply-To: <20240213200923.2547570-1-ericchancf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240213200923.2547570-1-ericchancf@google.com>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
Message-ID: <20240213201141.2548566-1-ericchancf@google.com>
Subject: [PATCH v4 1/4] riscv/barrier: Define __{mb,rmb,wmb}
From: Eric Chan <ericchancf@google.com>
To: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	ericchancf@google.com
Content-Type: text/plain; charset="UTF-8"

Introduce __{mb,rmb,wmb}, and rely on the generic definitions for
{mb,rmb,wmb}. Although KCSAN is not yet support, it can be made more
consistent with generic instrumentation.

Signed-off-by: Eric Chan <ericchancf@google.com>
---
v3 -> v4: fix commit message weird line breaks

 arch/riscv/include/asm/barrier.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/include/asm/barrier.h b/arch/riscv/include/asm/barrier.h
index 110752594228..4c49a8ff2c68 100644
--- a/arch/riscv/include/asm/barrier.h
+++ b/arch/riscv/include/asm/barrier.h
@@ -20,9 +20,9 @@
 	__asm__ __volatile__ ("fence " #p "," #s : : : "memory")

 /* These barriers need to enforce ordering on both devices or memory. */
-#define mb()		RISCV_FENCE(iorw,iorw)
-#define rmb()		RISCV_FENCE(ir,ir)
-#define wmb()		RISCV_FENCE(ow,ow)
+#define __mb()		RISCV_FENCE(iorw,iorw)
+#define __rmb()		RISCV_FENCE(ir,ir)
+#define __wmb()		RISCV_FENCE(ow,ow)

 /* These barriers do not need to enforce ordering on devices, just memory. */
 #define __smp_mb()	RISCV_FENCE(rw,rw)
--
2.43.0.687.g38aa6559b0-goog

