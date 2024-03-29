Return-Path: <linux-kernel+bounces-124333-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FE8915CC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 10:28:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 916FA1F223D1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 09:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176B74F8AB;
	Fri, 29 Mar 2024 09:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="jfZsineP"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBF3F4AEED
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711704466; cv=none; b=sCNd5vR/Umb2L4YFh1EwcBfAjCM9+7/1Xbvv6Isul7QREaC16cxue4h/T9czNiZ32Y1izv0VbK3cfS0XNqFaG0bSsFCcBf8DCfja6V3kGEAEqG0ye1eZvzIalLkxSqdjsRZTbYlJlx/zkgUMHbuVx57aaVf5QX2JX/HX3R/6OVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711704466; c=relaxed/simple;
	bh=LSg/rLuOsrxnsspgQ4r75KW0fisxGsUYFmGBfMYsNR4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k6GI8vsqM0+/tNYcb8Is/0Gk/MfA79Jgb/RWZHw7/vRiSEjK5XEvXuLGg5XTZqrnmBoe6cJsKMAq/Zs2IJQeGKk72rVnIgjBsMxwmVkVYi45EWWobj8SGlxaaSS1pIbKwJnqlBplruk5ScwpqmugaQQxb32QGBzdSV+iqsepmHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=jfZsineP; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-29e0a1fd9a7so1374386a91.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1711704464; x=1712309264; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=jfZsinePGh8GvughMdULBUqVVMU1/IJRkTvq/SnnFQDY0Q+6enwRM+p1Y4Db8388LN
         Ld0i1RVKMNpoau3cAcSqb5TrIJqhYrW7P+fQz3J9IQJwOkKcKowBRgEsvr2lUU4DYjbA
         /0snbQzpo2MYpphrbq8vQGY5i4KqzuiwtPry/z1RnbZD0+6Z7gFRBshffAJ23D5v+uzW
         cxFsXRI/7R2j1NvNuFIxlcuapbcsxuuPFr3lv8UNbBysKwDbWFlx9IMC+SQBuCFDf3vA
         mAtSjLmfnj5tnMuaHSHq+O4ceHaGTfHdGvxbTVd48Jv+s4Ly7qh3TAv1BDpU6+Sp9wHq
         4anQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711704464; x=1712309264;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=36s8w1btdvP+IRdBHf7/8nd9U/EcEkIO6Yh0YtSkXJI=;
        b=uXgKD0xBg0oJBFRlHkrS0Vh/pfFe0OMnibPTkvM2QgEaihYZFIe6QCHYaesygP2wTr
         uxGNcq+0AkmUSDmSjFHumWyXtcIu4mqwQrGIRYY3rn2RtOBq3rdQYrpIZ1CEBhSoc32N
         877zp+EdlxgtVOlkiHio25DS30CZ2NV50GX2jPByP4T9lh2kV4MVtDm1zSdl5lENAxro
         XwAjh0x9FMzJ1s0ot55GAz6UTa3QZHM93iay/275NXtTDzEQeXse0ZyD/Mv7McHsz6YA
         z2vlHD05xlISdGwLk1Fv1t+fK1BRr2CsbBCCwksnZY5PfJ0FP1W+ysL7gOmag0LovYq/
         1Zmw==
X-Forwarded-Encrypted: i=1; AJvYcCXWr+2tmSiQbvtIKXQjMWCcyNFfR6eQW78ISJOOJpy8WWfvZzaDl5Dd0QFRxqLhHbkG0Kp8k6+ivD5k2DUqy0WmxmnoyOGGQ87Z6spo
X-Gm-Message-State: AOJu0YwCXaeuwSg/kPWIN9xO4zdOd8D3saAba/4wUvltQPEtwxYIsFp3
	6ZyFFss/305gtGgWezObIkIuEOWJ++NWBJJ0jWq3GkFNEoRND9cIpltMKKoVyig=
X-Google-Smtp-Source: AGHT+IFlwBZNBeq8Vspi+hcWxSywtk3eGAD9nkXigHO0/VIsXQXySmGGcQSPVllJIcGqIgMzGVu2Kw==
X-Received: by 2002:a17:90a:6986:b0:2a2:1012:fbbf with SMTP id s6-20020a17090a698600b002a21012fbbfmr1808164pjj.14.1711704464008;
        Fri, 29 Mar 2024 02:27:44 -0700 (PDT)
Received: from [127.0.1.1] (59-124-168-89.hinet-ip.hinet.net. [59.124.168.89])
        by smtp.gmail.com with ESMTPSA id cv17-20020a17090afd1100b002a02f8d350fsm2628830pjb.53.2024.03.29.02.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 02:27:43 -0700 (PDT)
From: Max Hsu <max.hsu@sifive.com>
Date: Fri, 29 Mar 2024 17:26:17 +0800
Subject: [PATCH RFC 01/11] dt-bindings: riscv: Add Sdtrig ISA extension
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240329-dev-maxh-lin-452-6-9-v1-1-1534f93b94a7@sifive.com>
References: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
In-Reply-To: <20240329-dev-maxh-lin-452-6-9-v1-0-1534f93b94a7@sifive.com>
To: Conor Dooley <conor@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
 Anup Patel <anup@brainfault.org>, Atish Patra <atishp@atishpatra.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Shuah Khan <shuah@kernel.org>
Cc: Palmer Dabbelt <palmer@sifive.com>, linux-riscv@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pm@vger.kernel.org, kvm@vger.kernel.org, 
 kvm-riscv@lists.infradead.org, linux-kselftest@vger.kernel.org, 
 Max Hsu <max.hsu@sifive.com>
X-Mailer: b4 0.13.0

As riscv-debug-spec [1] Chapter 5 introduce Sdtrig extension.

Add an entry for the Sdtrig extension to the riscv,isa-extensions property.

Link: https://github.com/riscv/riscv-debug-spec/releases/download/ar20231208/riscv-debug-stable.pdf [1]
Signed-off-by: Max Hsu <max.hsu@sifive.com>
---
 Documentation/devicetree/bindings/riscv/extensions.yaml | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/riscv/extensions.yaml b/Documentation/devicetree/bindings/riscv/extensions.yaml
index 468c646247aa..47d82cd35ca7 100644
--- a/Documentation/devicetree/bindings/riscv/extensions.yaml
+++ b/Documentation/devicetree/bindings/riscv/extensions.yaml
@@ -121,6 +121,13 @@ properties:
             version of the privileged ISA specification.
 
         # multi-letter extensions, sorted alphanumerically
+        - const: sdtrig
+          description: |
+            The standard Sdtrig extension for introduce trigger CSRs for
+            cause a breakpoint exception, entry into Debug Mode,
+            or trace action as frozen at commit 359bedc ("Freeze Candidate")
+            of riscv-debug-spec
+
         - const: smaia
           description: |
             The standard Smaia supervisor-level extension for the advanced

-- 
2.43.2


