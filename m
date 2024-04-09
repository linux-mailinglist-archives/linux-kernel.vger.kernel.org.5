Return-Path: <linux-kernel+bounces-137045-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9046989DB8F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:02:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0386B26092
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77B61130E3C;
	Tue,  9 Apr 2024 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f+sLbW0I"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966F3130ACF;
	Tue,  9 Apr 2024 14:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671273; cv=none; b=WQMtXTcj+B2/YUzi7QVbZO7nwoFQxSCNp/+KheKDscYkYNUYV6ezUtsDpSmK5KLAhu+ulz0hkUET1LTANZ/tPiZYby28r2rBuobnb44FfMwPPM0t1oXlYcMv5iceU9F0amtxm8LIFMP6gbWuV6w1kzO6kJihkQqYext/lzaKwKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671273; c=relaxed/simple;
	bh=51Sfm2xp0PQT1gFODKUdeFbVWX58fUeGaMiFqFdRF90=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=G2XYJ2neX2oRO4Q2KyfznSQOrnoK5Fc5SlJabwKeD4pVdAV+TObloGw9D+W0S2PAO7aUPF4FlfyqF7rn9kPFeF986M5YJsA0O2YQaysJU45sjuv75oM1dcCmIUR0XY18RCcYiJh/8LFVrMA1S+HwWqLS53POBCQlh5qZmy+IrPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f+sLbW0I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D60BFC433B1;
	Tue,  9 Apr 2024 14:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671273;
	bh=51Sfm2xp0PQT1gFODKUdeFbVWX58fUeGaMiFqFdRF90=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=f+sLbW0ImOrvVzf5VOnMgtlmcW5JlPVUKLm+TksiUIm87QHwts5XhrwCkeu0+a775
	 kucx+qagico8Y7FiqyDwpWV7aJYhNg/sBc4ij6yZwCml8OLedkqHfMy990NutRYSLo
	 o2Q69k0HsodpvGjQC9oZW1jLG9QOQjoI8T30/2Tb3qIYnJoc1GfbYdKoVRbVrBsZ4S
	 7WCJGAMull3hGNt4lnfSrrA7+hz7p/FD8CRkT1Jz1k/HspEJOLrVwINHLlCQsYcUlp
	 FiuuTQvX6PhA0pez7lzCebwbKsCQtj64D/VfLCV3Zq4Bx3KiNzr0BxVWhbtvcI4E/P
	 SBVvxTGXuNKkQ==
From: Arnd Bergmann <arnd@kernel.org>
To: linux-kbuild@vger.kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>,
	"Richard Russon" <ldm@flatcap.org>,
	Jens Axboe <axboe@kernel.dk>,
	Robert Moore <robert.moore@intel.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Len Brown <lenb@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas@fjasle.eu>,
	Lin Ming <ming.m.lin@intel.com>,
	Alexey Starikovskiy <astarikovskiy@suse.de>,
	linux-ntfs-dev@lists.sourceforge.net,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org,
	acpica-devel@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	Justin Stitt <justinstitt@google.com>
Subject: [PATCH 1/5] [v2] test_hexdump: avoid string truncation warning
Date: Tue,  9 Apr 2024 16:00:54 +0200
Message-Id: <20240409140059.3806717-2-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240409140059.3806717-1-arnd@kernel.org>
References: <20240409140059.3806717-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

gcc can warn when a string is too long to fit into the strncpy()
destination buffer, as it is here depending on the function
arguments:

    inlined from 'test_hexdump_prepare_test.constprop' at /home/arnd/arm-soc/lib/test_hexdump.c:116:3:
include/linux/fortify-string.h:108:33: error: '__builtin_strncpy' output truncated copying between 0 and 32 bytes from a string of length 32 [-Werror=stringop-truncation]
  108 | #define __underlying_strncpy    __builtin_strncpy
      |                                 ^
include/linux/fortify-string.h:187:16: note: in expansion of macro '__underlying_strncpy'
  187 |         return __underlying_strncpy(p, q, size);
      |                ^~~~~~~~~~~~~~~~~~~~

The intention here is to copy exactly 'l' bytes without any padding or
NUL-termination, so the most logical change is to use memcpy(), just as
a previous change adapted the other output from strncpy() to memcpy().

Cc: Justin Stitt <justinstitt@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
---
 lib/test_hexdump.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/test_hexdump.c b/lib/test_hexdump.c
index b916801f23a8..fe2682bb21e6 100644
--- a/lib/test_hexdump.c
+++ b/lib/test_hexdump.c
@@ -113,7 +113,7 @@ static void __init test_hexdump_prepare_test(size_t len, int rowsize,
 			*p++ = ' ';
 		} while (p < test + rs * 2 + rs / gs + 1);
 
-		strncpy(p, data_a, l);
+		memcpy(p, data_a, l);
 		p += l;
 	}
 
-- 
2.39.2


