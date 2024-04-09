Return-Path: <linux-kernel+bounces-137047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 184E689DB95
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:03:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93084B2668F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F22C13175E;
	Tue,  9 Apr 2024 14:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MSSa5z1S"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB061311B9;
	Tue,  9 Apr 2024 14:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712671278; cv=none; b=Vmv8bmuu7pOlNIa+PJck2V6glqOf7ucQ77BewfMtr+umtBuU5O+D1q9F57HgcJ0WdLZqa5P/0egdYdnboK2xC+vuORBFgiYcS2fNVJHH5H2ZyTD+xE9kTvJ2IscmzBx9HIJsJHD+s31A/8DZ6yimTiRhMK0lbHrXt6EUixdMppY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712671278; c=relaxed/simple;
	bh=apx3gbxkYNqe3VpAmpZgPTdGN3/2cOQjfTIRYJyoYL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZrLuoZAmzLwDtERMC71+W/24VHTwqAPWZJJUqR6HeAjfOQx5Pwe1XFwakes2cd0aJ2aB1d692yV5NGp1OV2y9M72TVMLlPvpuSdSOHkN3dXC0yV5MLaFrHo7H7IxBJCQgyVr2rt2yi0ZX7NGVoPqOaexs3iFur1QyWnyYwg6fEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MSSa5z1S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD480C43142;
	Tue,  9 Apr 2024 14:01:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712671278;
	bh=apx3gbxkYNqe3VpAmpZgPTdGN3/2cOQjfTIRYJyoYL8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MSSa5z1S9ryJwrH6rhZwsfZ+WYHqk+DUN6umSYaSz9+PInQkEmLLg9HxlScb7SB66
	 INAABa+8rjj1c4bradO8L6DkDBPNDU7qPWK7URSSmUPTxK+4hefFZn2CZXuFgBrngb
	 QdlQN775GdzBYwFXCsuI8v5PtJCTjL+tCs3wkzvRFaW5ly10uQ3/gpx0iQk6QTCQNL
	 x3PysVOlaDEUIoyLnkd+Jm0Vi30mdh9slrYCeOOucTVTqixQKDXisg4oPy8r6K1xlD
	 BcBWJB4mfLTtXNA4AAKEknHbTNgkfQrMFIZi1WJwSfYfbs/hZovigEojcExc6eLrtw
	 S96r3fjZf4spg==
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
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 2/5] [v2] acpi: disable -Wstringop-truncation
Date: Tue,  9 Apr 2024 16:00:55 +0200
Message-Id: <20240409140059.3806717-3-arnd@kernel.org>
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

gcc -Wstringop-truncation warns about copying a string that results in a
missing nul termination:

drivers/acpi/acpica/tbfind.c: In function 'acpi_tb_find_table':
drivers/acpi/acpica/tbfind.c:60:9: error: 'strncpy' specified bound 6 equals destination size [-Werror=stringop-truncation]
   60 |         strncpy(header.oem_id, oem_id, ACPI_OEM_ID_SIZE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/acpi/acpica/tbfind.c:61:9: error: 'strncpy' specified bound 8 equals destination size [-Werror=stringop-truncation]
   61 |         strncpy(header.oem_table_id, oem_table_id, ACPI_OEM_TABLE_ID_SIZE);
      |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

The code works as intended, and the warning could be addressed by using
a memcpy(), but turning the warning off for this file works equally well
and may be easir to merge.

Fixes: 47c08729bf1c ("ACPICA: Fix for LoadTable operator, input strings")
Link: https://lore.kernel.org/lkml/CAJZ5v0hoUfv54KW7y4223Mn9E7D4xvR7whRFNLTBqCZMUxT50Q@mail.gmail.com/#t
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/acpi/acpica/Makefile | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/acpi/acpica/Makefile b/drivers/acpi/acpica/Makefile
index 30f3fc13c29d..8d18af396de9 100644
--- a/drivers/acpi/acpica/Makefile
+++ b/drivers/acpi/acpica/Makefile
@@ -5,6 +5,7 @@
 
 ccflags-y			:= -D_LINUX -DBUILDING_ACPICA
 ccflags-$(CONFIG_ACPI_DEBUG)	+= -DACPI_DEBUG_OUTPUT
+CFLAGS_tbfind.o 		+= $(call cc-disable-warning, stringop-truncation)
 
 # use acpi.o to put all files here into acpi.o modparam namespace
 obj-y	+= acpi.o
-- 
2.39.2


