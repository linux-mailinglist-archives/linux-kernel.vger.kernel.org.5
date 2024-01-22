Return-Path: <linux-kernel+bounces-33872-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C01B836FCC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4299C1F3206A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA274EB50;
	Mon, 22 Jan 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TfFR7Z4f"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BE8F4EB39
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 17:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705945928; cv=none; b=RiR/yOZ2ZGvgZZA7Uu+b4eIcint/P6HAKRX2VCvAFNGjww0pLKBzfMsSQG7GKGZJkH1qCyIxOhaFgmH0/khU2CkvT8GBN5cIKy9QV0xtExbpqe1UqSAM1+iBCKIi/v3E0smQgdV8Q5h+j0VoaOWbXeSWWAt2YlF+HWpbWu/ujCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705945928; c=relaxed/simple;
	bh=T/9atzQ+lsfJpVq4rVjcojR7wtS+meio7H0bTtXDqOU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=byBIRC/Xxo3ngGCtnQCJf9/hBHCc62nnodj9ZxXGo0ObxN+uw4FnokzaY2bvrqIOuRtnH58ewhDy5D1oRpUMZ/DBMiCJEILJVPHSXxjhDuAl/opwj0vjAsAoEVSvnBIRRGCAQXaXeHgQ6EcHJFFUPY5+qYwdJOlpscFtgnb7GVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; spf=pass smtp.mailfrom=sifive.com; dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b=TfFR7Z4f; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sifive.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6db9e52bbccso1830681b3a.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1705945926; x=1706550726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QSWAH2h2yO14oAYqsgN1KrIEfgODNEl2dQs2ayTirC8=;
        b=TfFR7Z4fYlpu5q2DiVgOnOsIqfY32+MiEKA5ls0TSuLZr06E2ygTTLZxbdzsdSGsYA
         t0xgYevO7CXRBaMxzDR0wFTjlbcOqedWFQ7qtMG+m9FpBFa64x1wesH2x+d9TGP9VwqZ
         1JRwqunQEdtHXzCuQjMxRLlVAa0UAdSYhib22ocBv0RAoqCKIuf2ElaBmssuJbv52/Rr
         AyTV12USZeMAhGiBbRrapm0vpQMrDGagWBnaVB6Z05R5PdymuhByi5AjZzS8f15CjNUI
         krMEquswNlXwqxIC0LxihcdrP5PlsCPtPFlGnG35SuE90HYTApklOr27jtv2EulX0rvu
         YByw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705945926; x=1706550726;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QSWAH2h2yO14oAYqsgN1KrIEfgODNEl2dQs2ayTirC8=;
        b=D4gZ0uuB/D7+UEA4CtQdw5Aya24YeG1m05KBzUatgq3PKc+91XSzO4+DQ7Ayhlkogx
         Fkig/elzlNEq6XqUJuOOc0o51RgyeG7HYtbOTadH6z2DwATu73D4a0YECOcomLqDoCBL
         oesaf50UKpTQFSAk8xVkqL7XxJrOH5JYPmaswgrOU1ybUypFClOj/mNCyOC/LmHjy4Kg
         W29Wgxaf1ZB+aRfrP/Xl+qVHZDylayPzMaUxaMWR1kdpPd+AXCBIt/P4b5uHDZWSpeIT
         FOyEUBvlF44bq0mxDwXFWp+mHfwJEIMf/J/NF6aaGQT/E6vyl/+7nB16zaB6xBQQf13i
         7RFw==
X-Gm-Message-State: AOJu0YxZcogbAgzWBkN5VScUeguJ0zjNxwK3GGyoHrmJln4MXKAKu44f
	xl+zpNJ4KWoB6wOKpGHa7aDbgBCpbHdaeiTrWlN6TRQ5anba+FKPxu14CNr7GFQ=
X-Google-Smtp-Source: AGHT+IGfEmU7Y0GXncAuI5uEVMFJA8FBQOiUEOthF03g+BeQxP7YLhrCmPsfmbi9UrbKJWW5TptqEg==
X-Received: by 2002:a05:6a00:2d09:b0:6db:d1d8:2e68 with SMTP id fa9-20020a056a002d0900b006dbd1d82e68mr1924330pfb.14.1705945926479;
        Mon, 22 Jan 2024 09:52:06 -0800 (PST)
Received: from sw06.internal.sifive.com ([4.53.31.132])
        by smtp.gmail.com with ESMTPSA id x126-20020a626384000000b006dbd7e5bd1esm3232377pfb.52.2024.01.22.09.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 09:52:06 -0800 (PST)
From: Samuel Holland <samuel.holland@sifive.com>
To: Sami Tolvanen <samitolvanen@google.com>,
	Will Deacon <will@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	Samuel Holland <samuel.holland@sifive.com>
Subject: [PATCH] scs: add CONFIG_MMU dependency for vfree_atomic()
Date: Mon, 22 Jan 2024 09:52:01 -0800
Message-ID: <20240122175204.2371009-1-samuel.holland@sifive.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shadow call stack implementation fails to build without CONFIG_MMU:

  ld.lld: error: undefined symbol: vfree_atomic
  >>> referenced by scs.c
  >>>               kernel/scs.o:(scs_free) in archive vmlinux.a

Fixes: a2abe7cbd8fe ("scs: switch to vmapped shadow stacks")
Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
---

 arch/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index c91917b50873..a5af0edd3eb8 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -673,6 +673,7 @@ config SHADOW_CALL_STACK
 	bool "Shadow Call Stack"
 	depends on ARCH_SUPPORTS_SHADOW_CALL_STACK
 	depends on DYNAMIC_FTRACE_WITH_ARGS || DYNAMIC_FTRACE_WITH_REGS || !FUNCTION_GRAPH_TRACER
+	depends on MMU
 	help
 	  This option enables the compiler's Shadow Call Stack, which
 	  uses a shadow stack to protect function return addresses from
-- 
2.43.0


