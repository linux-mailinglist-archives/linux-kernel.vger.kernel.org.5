Return-Path: <linux-kernel+bounces-137049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3080989DB9A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61AFF1C21111
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:03:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BED912FB26;
	Tue,  9 Apr 2024 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="seYFDBBN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3D41311B9;
	Tue,  9 Apr 2024 14:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671283; cv=none; b=UCM1Vd5/tKR/jkD3QxamFkrGDgf9RRQyk17NWint7ykWeBCCwRr0IZ4rfvsHOyVM8X+pAxZQuaydphuD9W27xY3z0XbQl9H3j2GLF32d7oOunOvIKw1nA2xgxzSTlAaytTqNTYRxMJ9KnYCWKsGrHoCxZzP0tMgRSP0Fpaeax3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671283; c=relaxed/simple;
	bh=+6XHH0IKbKZJZfLuR8UiLY5DybHOF/uJqvg3k5VIrYY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Rd+fBWDsoEzUeYIgDJlqM1CRLCiazXSa6efWCLSO5Jofx0eR22avpH2ekLvuehnLfNiKziu02BL6lYqmAuvYnImN2nlV9aZvVAAyRiapLVn9iSSfowWAH3/82Y1bwZrergV1P9yV09SqAozTSswS7mmfUCp4SEd6SE0tKrxon9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=seYFDBBN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB531C43601;
	Tue,  9 Apr 2024 14:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671283;
	bh=+6XHH0IKbKZJZfLuR8UiLY5DybHOF/uJqvg3k5VIrYY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=seYFDBBNQDwm3rbyua/v8J3aR2fdaXaheTfVVTdXR7eE7sMrmz3miSMjwS+ALRTjO
	 3keDS7/WA23UgDKScxs2qbPxAnxQq5cKW2mqPPIzRmx4q+oajuSJYMhsI8NPbxIyDe
	 r8JSc6Wgt3n9s+H0fYI8xAqv0qbNj5HjUi/CceuFaOYrBzwSHYdlvQtFE7HpZT7Icf
	 Jg9mP/RwmYcvzfeiTgsNl/sQ7NDJHRRJBuPTy7r8unNf7A3LnopNDxu/rlBnjOOKP+
	 U7BAgVieDFa+2RczYDaBt0X77ALDKlU+jKCIDGhyluyaj9mTJOimEu/sG7GQGhji7S
	 y15jJwN/Osm5Q==
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
Subject: [PATCH 3/5] [v2] block/partitions/ldm: convert strncpy() to strscpy()
Date: Tue,  9 Apr 2024 16:00:56 +0200
Message-Id: <20240409140059.3806717-4-arnd@kernel.org>
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

The strncpy() here can cause a non-terminated string, which older gcc
versions such as gcc-9 warn about:

In function 'ldm_parse_tocblock',
    inlined from 'ldm_validate_tocblocks' at block/partitions/ldm.c:386:7,
    inlined from 'ldm_partition' at block/partitions/ldm.c:1457:7:
block/partitions/ldm.c:134:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
  134 |  strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
block/partitions/ldm.c:145:2: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
  145 |  strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
      |  ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

New versions notice that the code is correct after all because of the
following termination, but replacing the strncpy() with strscpy_pad()
or strcpy() avoids the warning and simplifies the code at the same time.

Use the padding version here to keep the existing behavior, in case
the code relies on not including uninitialized data.

Reviewed-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/partitions/ldm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/partitions/ldm.c b/block/partitions/ldm.c
index 38e58960ae03..2bd42fedb907 100644
--- a/block/partitions/ldm.c
+++ b/block/partitions/ldm.c
@@ -131,8 +131,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 		ldm_crit ("Cannot find TOCBLOCK, database may be corrupt.");
 		return false;
 	}
-	strncpy (toc->bitmap1_name, data + 0x24, sizeof (toc->bitmap1_name));
-	toc->bitmap1_name[sizeof (toc->bitmap1_name) - 1] = 0;
+	strscpy_pad(toc->bitmap1_name, data + 0x24, sizeof(toc->bitmap1_name));
 	toc->bitmap1_start = get_unaligned_be64(data + 0x2E);
 	toc->bitmap1_size  = get_unaligned_be64(data + 0x36);
 
@@ -142,8 +141,7 @@ static bool ldm_parse_tocblock (const u8 *data, struct tocblock *toc)
 				TOC_BITMAP1, toc->bitmap1_name);
 		return false;
 	}
-	strncpy (toc->bitmap2_name, data + 0x46, sizeof (toc->bitmap2_name));
-	toc->bitmap2_name[sizeof (toc->bitmap2_name) - 1] = 0;
+	strscpy_pad(toc->bitmap2_name, data + 0x46, sizeof(toc->bitmap2_name));
 	toc->bitmap2_start = get_unaligned_be64(data + 0x50);
 	toc->bitmap2_size  = get_unaligned_be64(data + 0x58);
 	if (strncmp (toc->bitmap2_name, TOC_BITMAP2,
-- 
2.39.2


