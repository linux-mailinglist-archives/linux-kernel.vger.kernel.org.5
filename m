Return-Path: <linux-kernel+bounces-34551-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE0B3837ED1
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:46:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E66D1C26303
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E53913D4EA;
	Tue, 23 Jan 2024 00:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EtTIlukh"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC4B13DB93
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970770; cv=none; b=NpJGbWRJ+o9j419LgHQd9ZaLloRc9O5nxIEb1O27wCvkDMoCKN45aBg2PMRGp0f1Fe8OBa2G8vqHtLjsJc8ch50ayH5HmSx+GWLV2aLKTn7XOxtFxsYn7zpMZopt9NF4a9wZlJ8DOfsMwOkGfgllh7sp8Eu1uHC5mibMaK1mpRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970770; c=relaxed/simple;
	bh=7EjHVZinq5vMXU1+hzn38DepLpa6iDayHYypzEUYJ8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TNK90Zw1otWYJgW9no4k5kzMoCFtdUKrAKcvbdVDNcqwYP+8iMY8s/VnHxnhRboIbJl7Q1ytehSONhby3uoRyVsJwtib44bzBGXWnEbMklta1/EOjbGI5IWhYHnBEWlTnRfGfXAdjEzQYUeDlvmE39stro0nqGdtLjtPdB5B4jI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EtTIlukh; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-29041f26e28so1827406a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970767; x=1706575567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QL2EbelNfKplPRaLFa/5pxqZ1ShWs/qPJgvqE5R3xUI=;
        b=EtTIlukhFan/pNGUy5e9gjkv2ADBCOb8zjKv323DqiiPALFjM0EMgCLOQUEKib1nfv
         c+1jW7qdWU7miLssL8qiDsYTFzy4RLQflCD8hdFhKwktEHiC/QIVPu3UL50a1O8j+pXA
         p3YsKTEKT5bDRSHWx3bGOYqyDUo/rJz8Y/+iU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970767; x=1706575567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QL2EbelNfKplPRaLFa/5pxqZ1ShWs/qPJgvqE5R3xUI=;
        b=pNVkZOSrKUVcG7x5RCNm6iYt9YWswchpr1mZvySq5lgg6LnvULhRktQtuaU7eyGQ+l
         5ud/kUOwnlIaNAVPIg7cH1YNJBpuNDzLhV0Gplzc1fOnLpptHNXRpJzstFKIUeqLh07C
         Md8qQS/+pcmrQ9Pb5dPeRi81jz6bKyIZmO/YWkZGgRIqLBjWwMXEzM9svUCfp/UP9o7d
         zPARAxjjwlo7WCs3E13xH4iNar8l3ZKceBqFwpQn87RzwvcFFqJYb6HqDg7XtuWfo2Jk
         jtf1F7foRiTqx9kZF0bcHuHDz0Mk/U3HgFGm2ntCGbglQglSGrjgzuPqV5tI5EizWeFF
         BhFw==
X-Gm-Message-State: AOJu0YzI7/gEpV3gV82zkY/rmdbWvo4BhR2pyE56qEXafA2nZMAEnrdY
	usDd5zL3KoS/C8EQmadELc3AHtlmAxTi8lm+LgmH5+X8n8JpLmZN6djsJVQBIg==
X-Google-Smtp-Source: AGHT+IGRFhkPzejcuLL4VRK+c8dRwaf1aYOd9GmP0Xdnbl6TsX/mwlLYTiaazDEJC80Uor5945a4rA==
X-Received: by 2002:a17:90a:d306:b0:290:5ccf:af0 with SMTP id p6-20020a17090ad30600b002905ccf0af0mr2174216pju.60.1705970767490;
        Mon, 22 Jan 2024 16:46:07 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id oe11-20020a17090b394b00b00290d0459e3bsm120871pjb.47.2024.01.22.16.45.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:46:03 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Wei Liu <wei.liu@kernel.org>,
	Paul Durrant <paul@xen.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	xen-devel@lists.xenproject.org,
	netdev@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 80/82] xen-netback: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:55 -0800
Message-Id: <20240123002814.1396804-80-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2080; i=keescook@chromium.org;
 h=from:subject; bh=7EjHVZinq5vMXU1+hzn38DepLpa6iDayHYypzEUYJ8I=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgMGbwjLdUBipRWV/86VXIdYYa28FnqDE8e3
 ji0sb3+qXmJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8IDAAKCRCJcvTf3G3A
 JsN6D/9/9pZCcQMxkCKVjCzbTzXOAQTMNmntEY/KiITUeK8EZC1n44hzsCtSDO9z3x4VtvUW53Y
 pRmydxh3JiySpsfiK4OxljXZ/xvSG+v1GEOgkMGo2iye6zXeVeadXsRCP2MY/IsaXKyM0TKUH5i
 g4+ChtKvF7D9haRMeRaLK4ST+SPfUX52+Z0xW6LUaGrz824SDJhB6Gq9j70+OoNvQaUNHrgZjdR
 a67Kgz/3+HnspC4bx9lGFxCUiPdmTZOz2mgatPghMoE1oX04GIjku1UTthsh6180c00i2Sk/LJI
 1bRchLyEexiVH65VHvz3Ge37s/qRJosLl2xW1ds7SHJKd3qfVFTBa++CN+0tvpd22m7lAAYF7cU
 Rkfs/ZXcyHX1COeG62Bsp15wHODlwmJxEzU00q1Rl6ynr8uVniiXT4RIR9ZRxO5c25/mmUzGvmW
 3rnZGTP9QuvpKRY6GaVrOWKPiaKo3XhsasnsuFP3f6lkYw/WdOVxY2UUWqvlpj3eah/klmSKi1a
 lDJR8pC8b50zoXsumq3xtz1lKSL3iETbnda7hCBHkYCfEhGJi2WPdHrfeEaXwDkde5gZEwPCzZ3
 EJ9TGrYsYcED0KeZFlmbguqSvBeanX+PMcLQckWAXPEbi1WgzcVvFGckq6ZyPuUJHl0C9DAM8Dk 2036V40Dg9GXNKw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: Wei Liu <wei.liu@kernel.org>
Cc: Paul Durrant <paul@xen.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: xen-devel@lists.xenproject.org
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/xen-netback/hash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/xen-netback/hash.c b/drivers/net/xen-netback/hash.c
index ff96f22648ef..69b03b4feba9 100644
--- a/drivers/net/xen-netback/hash.c
+++ b/drivers/net/xen-netback/hash.c
@@ -345,7 +345,7 @@ u32 xenvif_set_hash_mapping(struct xenvif *vif, u32 gref, u32 len,
 		.flags = GNTCOPY_source_gref
 	}};
 
-	if ((off + len < off) || (off + len > vif->hash.size) ||
+	if ((add_would_overflow(off, len)) || (off + len > vif->hash.size) ||
 	    len > XEN_PAGE_SIZE / sizeof(*mapping))
 		return XEN_NETIF_CTRL_STATUS_INVALID_PARAMETER;
 
-- 
2.34.1


