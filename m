Return-Path: <linux-kernel+bounces-34492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1CA837CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:21:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E617C28EBB2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD1405B5CF;
	Tue, 23 Jan 2024 00:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="dei4nlrQ"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80BF015B2E7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969754; cv=none; b=gC3YxrvmAzisY1m1+BqPiVZ57Osqtp9vxgVfZlMSaNKI4t/BH19UPeAqwHoRRLHRJwLF0zp2Gxn/lBB65EPAtMav8CwYvA/n/n5OQD9g29fllz4WBbt315TL1qrb3Wni9rCu9fSSyxGgdQOvIoeyYFby8YP37H9OjtzhXi39pTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969754; c=relaxed/simple;
	bh=Le2cw8/EMeZDvyWiTZfIKGAqobpbeo1xxbxe1eKIEog=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OAW+1XK4vOvBPNetVFTFsNdZKD90+PfvnJddzXammGLLZ7K/RyvNZwaQhCxiobQgplOFeLOE80spbI5FHSzuICSAMyiQZeLZ6lmfvNejTDQpr6zELgXGXwOh3cvYF8IUZiZpCtEXN4Nux5BP2zzcUzv6swFvZHbclpGFd+WgQfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=dei4nlrQ; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7431e702dso10690305ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705969753; x=1706574553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4kSZcErhkvLURXFhEcykitt7q+k1IsSKXy6VMnrbEx4=;
        b=dei4nlrQVSmZaRc7i9w34s2JHXoCLSllCDEuYyKgw7v/ZalCE32trcheV5afy+MkG4
         PJDijwomQl32hvpaX7i9vlIpJPROylLEcbAWBZlgsmhlVnMbt0Azr1BHJcpwp31KpjSR
         Jl+FV2Cok0fJt1RRiwZNQxM+Jm6CWWrYE87H8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705969753; x=1706574553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4kSZcErhkvLURXFhEcykitt7q+k1IsSKXy6VMnrbEx4=;
        b=QTkk7IULCJYoHe12affgaQw0oPLQ+nNm+Isf9eXIyiGBLfuUKs+BGo3JJnr5JQLyx/
         B7+b82c43QCs1iYKrqwJcM007nSNojTY8AQ2h/QJsHng90Q/ebkcaWZLHKl4LmrQJsWw
         OTKawEpTHfTonLGDI++ak555TbC8la0oH8pDob9YgqtxURukuMm0AT2rUY4kS+gBlh4m
         Pt7ZE3RNGq1f/JvGlDgAHqZnjQKN2AYYS6YZg222pJ9smsjrEllMqMkkIskmApGd6Ydq
         dVm3XYjgeGJr53pw9RWU1OxGtyTZE4VYee+GkGQwPwgiWZHvtHQks4cxEWGKX7D6Avzf
         8rZA==
X-Gm-Message-State: AOJu0Ywh25ddgMNTG87ZpMIfFxLNXv7s3A+5J4ep4UrSl4+L9jouHFt9
	6GrvwglX7og9WUtO1kw+VLTiR3zVa8T1df9k0LK+voJN5BNYZA2o/ZfgyBh1UQ==
X-Google-Smtp-Source: AGHT+IG3RDfq5susdGGtZ5t8hNNXczrgazB2fai6AkFle9yipHha6eOEWBtXrxnRKsK0nSd5aI3KHw==
X-Received: by 2002:a17:902:c946:b0:1d7:ad4:7d9 with SMTP id i6-20020a170902c94600b001d70ad407d9mr2794072pla.60.1705969752949;
        Mon, 22 Jan 2024 16:29:12 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902a9c400b001d74b1ef56fsm2652747plr.271.2024.01.22.16.28.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:29:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 56/82] usercopy: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:31 -0800
Message-Id: <20240123002814.1396804-56-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1952; i=keescook@chromium.org;
 h=from:subject; bh=Le2cw8/EMeZDvyWiTZfIKGAqobpbeo1xxbxe1eKIEog=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJFBcLI030OvWlIdf+JlEl9ZpGqp2xZrVGc
 OF5/tb3LLKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JlAfD/4hK8oQxeilJy5M1BswN23KROlrOk+00GSMbycYwZKmxQcAxh0DnW23pgXbeUgj2xRlH7k
 /F+1z4vu9eaAj8Y/Y9hBh2STz4jydgyEv7WtfzL7Jw1BNKRrtbBNLwAwKJ0huo8jHVSKWwPVexP
 H0dsQTMPDxMkMaS77DgFrqDnf83+cga/jJS5LHAev1F3Rt7Vzx4KZTVfeW2Dto3dvVvaDA7Mr1W
 zclIJH/mqpfAZHnTuBX0Lc9+8RKLG4qO+2/IUsGeLKMWwR1WVPmDTM2bkl/aMTUuS9zUOBkJ+kz
 KOHdKKXC1Rs12cJXs6FaDHdaa14Rs0A4hpkuD5hOdyzaS307IhV5depO3u68Tj2Uik5iOAg0Sd+
 mbpV425cNRUyFHClpds5aX3e702vMEC0hgaOLiRwlk5K3u6RQW1N7GluN4un20Sn6BhkHSH4U+N
 YixLEE2YDQcd7gaZZwk6n5ylkZBndaXc6h2B9qpnebQVrz7cHnXCvjJ523k41Bmm1MZTcW9H7Np
 ST8joAjzTwXfRq5dJvhigwFDMdUGFtxsZ2soh6RZ/+fTiuyYL+m8B2frhQ33eS/G9AbMn6WFBxK
 EFYGaKAJmKlp3x8HgzZyfaTqO4BFToZOSpxteo584SQH5dsfYvS3kwiZW/3iIX05kIzLTWTZTqU IgI+hkYy5CRcMww==
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
Cc: Kees Cook <keescook@chromium.org>
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-hardening@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 mm/usercopy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/usercopy.c b/mm/usercopy.c
index 83c164aba6e0..5141c4402903 100644
--- a/mm/usercopy.c
+++ b/mm/usercopy.c
@@ -151,7 +151,7 @@ static inline void check_bogus_address(const unsigned long ptr, unsigned long n,
 				       bool to_user)
 {
 	/* Reject if object wraps past end of memory. */
-	if (ptr + (n - 1) < ptr)
+	if (add_would_overflow(ptr, (n - 1)))
 		usercopy_abort("wrapped address", NULL, to_user, 0, ptr + n);
 
 	/* Reject if NULL or ZERO-allocation. */
-- 
2.34.1


