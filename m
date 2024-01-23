Return-Path: <linux-kernel+bounces-34522-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C985837DE8
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D02DB1C2769F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066F11615A6;
	Tue, 23 Jan 2024 00:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ftJiLXY9"
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE5B160898
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970181; cv=none; b=pMeYZphWZeQ0hujx8eOxp3sRKGKyAddV08ZK5/IfvEDKCsXe0k+KAguzTHSaHEc5j6H6OT6z1mnvJrwA2F3XX2tbBk8DUmSeuRIaktoPcazV+7codOhzWn603LjrarJTYiAeHLlTwiCHo9oEIDcagnep1KmIdRiodyP5INcOkYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970181; c=relaxed/simple;
	bh=X4KPC/UgpHzHjLm9oqtA3x4JymqJVZ0DUnLq+Paa7ds=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PlPTtFUhsUnfh/mF82FzY+r/nolG1q/MLbDTpkZPQJa3nwWQlErtwB6U39GwpyvtqtVmoojbm4aQdc96qkGGFQ6eGV2wuPwCLkePqLybMJAur/PdidXajtpUEWbb9zGyIEjgyhz0/f6cFtFbVD9PLUnm0EhtHvDn4fEv9qN9ha4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ftJiLXY9; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5c66b093b86so3417095a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970179; x=1706574979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aEc2d2rSfjhDoBoq9fLjQenSkCLNzDWcQ8adwJB0hG0=;
        b=ftJiLXY9mCM9agVXh7u5DCh6zmbHD90qFASbREWPWGQxFL9HD4aC15JYGrJDAgKAJa
         YFI8ZvEBfAV7Jwl9eIT3LEU5hhqdyUU2/3SsuCAk5JCYk6fNMSRXyKFERn7ikxpzUzdZ
         r9KM4Mx5HtpAYZwRWciPGHMr930UQsRuilDNc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970179; x=1706574979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aEc2d2rSfjhDoBoq9fLjQenSkCLNzDWcQ8adwJB0hG0=;
        b=Q0gal3cmIdz3rZqkvLPggNomuV4N6Wcx1bDvkXcsyUEOQo+uXuMrQETVGu32vigNhw
         sdoCb6YV3h7eVncimbTAJfAvxIhvrCjpbSzC1VDZhvBr+dX06X80rfKRNyDNYrcVjHCu
         57xSij91tTwF8GUg2NXXHj2H2xJqCAqs5bncTMJPGTPxpHBsp+ryOkP5qdjGKGwFobun
         WHfrP1OAqGXaIHFovCtTziAe4sDWqOWxYEinMdhFv/juoRFEvLxB/Qr9VZ+qHRV8+m53
         BUQMorlo81Dx5oLPb5i5O/Gr0LdVsz2r+0VkZZS1gWlz7laOkia0gJF5Fl9UFtLwJ5Ug
         wdRw==
X-Gm-Message-State: AOJu0YyvBL5tv4McIKpjamPT88SNHZT2yfKLz2msSVLh2xfoxa/ukjsy
	udeAw6E1undD1/fTmdIgtObkFDJPC2y2BmOBkPSmQictNnKiyEd3m2CjGW84qg==
X-Google-Smtp-Source: AGHT+IHFbuHpc3vAdI6yegvV/L9r1Yb3ls3L9cW7fTD9Yq23EmXCVPkJqYozC29KOqZKziH+AAq5Jg==
X-Received: by 2002:a17:90a:ee42:b0:28f:fa9d:ebdf with SMTP id bu2-20020a17090aee4200b0028ffa9debdfmr6732264pjb.3.1705970179438;
        Mon, 22 Jan 2024 16:36:19 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id dj7-20020a17090ad2c700b0029065f70565sm5824388pjb.41.2024.01.22.16.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:17 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 59/82] lib/scatterlist: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:34 -0800
Message-Id: <20240123002814.1396804-59-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1669; i=keescook@chromium.org;
 h=from:subject; bh=X4KPC/UgpHzHjLm9oqtA3x4JymqJVZ0DUnLq+Paa7ds=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgKl36vVZG1nmdlZHD5EeRVSkhvMUsUGq27H
 GGTsQQr0yKJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICgAKCRCJcvTf3G3A
 Jko4D/wLOSdJgcYUIEXEWyZ094Wxs/bc+vFZ1200/hCn8653ZUrA3GFBQlNpz2j4KN4SGZaAUwx
 XwJbrwaPYj5jQDHGgEpePQTxEQUZO3iNMJarAxDNOV8Jp4y7Z8D58Mf31v/9HugXKic4tf8wXbd
 2z7mUpcMaG2/zFyfcuVCd5nuP6SGOfw1qSMdqDdEgHAF4lJuOPMi3jORDXoKcY1016c01JbQFzG
 PyzDWakatUQn3fG/IurRu8FlgDWXY0nfhz/R+ZG5YLj0KJ+FIceKRbj+fdDgDXUfYsbPBiSn7Kv
 cyv4nHAzcFSeV6kggiiFvczA0o+iQctKOUObrv9u8LzDKPU/gg72Yy1yeHoItbt8faH08EQGpHN
 IOFLAykVxVuBAhxbaKjqC8CiMDLtjlf56mwXKZkI1dGqzB2t01l1K/M/NU52aiJsd+pjZcfOPHy
 TqFEHvtJhzsPQXZag5/nu6I1yqmaIhbwCFDIJ7BnFuJYgvqUctQJFuJipD3T7jKZhAEyjUdFvDZ
 GULJFLehEJ3dGgLpoBn8tpWS/rVuuHQ4JF3zdxUPpoy2rjXbWm7xoXLCiiey4bCZK21q+OHDJCH
 8dDMZazDyBgAiPwQCGHfaAHulyiW6eEJe7qpDt5dmJHGrR6kOEELOyqY78LX7F7ljWlSML1tfWH lPasxNIE4hn6XbA==
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
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 lib/scatterlist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/scatterlist.c b/lib/scatterlist.c
index 68b45c82c37a..121905119bbc 100644
--- a/lib/scatterlist.c
+++ b/lib/scatterlist.c
@@ -624,7 +624,7 @@ struct scatterlist *sgl_alloc_order(unsigned long long length,
 	nalloc = nent;
 	if (chainable) {
 		/* Check for integer overflow */
-		if (nalloc + 1 < nalloc)
+		if (add_would_overflow(nalloc, 1))
 			return NULL;
 		nalloc++;
 	}
-- 
2.34.1


