Return-Path: <linux-kernel+bounces-39146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D46E483CB79
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 19:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7C41F258B3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F0E135A75;
	Thu, 25 Jan 2024 18:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=awooo.ru header.i=@awooo.ru header.b="etKWKqNC"
Received: from forward100a.mail.yandex.net (forward100a.mail.yandex.net [178.154.239.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C89135A57;
	Thu, 25 Jan 2024 18:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.83
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706208311; cv=none; b=n8CzeZ5sJOKmGwelz/4IWdH9OZCB7biw8t2wU0eHZQoyMLMkg498NBSGmV5Ozge+zBgoi41YtyPhl2MJ3LHHJafBDB406jOIc65TumgaJW6g9Sae78ogFSyqk0iKbWwUQrWzSw1ovxW3isHyySTmVfaG0Vb5jWocTWB3oxBwaP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706208311; c=relaxed/simple;
	bh=sknFg9YjLUkGOi+bdNa/wlBuPFMCgxZuVS5giXLTTSM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=M+k+Lm3LRQIVy6OGuFl5rhutWoCfioorXl2PwRKe7+DT4Tc3/BeEpbChvW3XSONIoCSS5F7dIKlaGuRIbjrRawJPT4Edtp1uVhe7jjBdSLkoVRiQJWy7pAQpohfTFmaAyRasRNST+T4Sa3h+Ax+9VD+uEAYV3ZrSKcZMeGjjVwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awooo.ru; spf=pass smtp.mailfrom=awooo.ru; dkim=pass (1024-bit key) header.d=awooo.ru header.i=@awooo.ru header.b=etKWKqNC; arc=none smtp.client-ip=178.154.239.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=awooo.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=awooo.ru
Received: from mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2c95:0:640:f90:0])
	by forward100a.mail.yandex.net (Yandex) with ESMTPS id 1320046C82;
	Thu, 25 Jan 2024 21:44:58 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id siZhwt2CbeA0-zVloaVIl;
	Thu, 25 Jan 2024 21:44:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=awooo.ru; s=mail;
	t=1706208297; bh=mBLIg9GlT5gPcbCunKgcUcrc/pkQPGEuGacL3O8h1U4=;
	h=Cc:To:Message-Id:Date:Subject:From;
	b=etKWKqNCciYFq48C5RCbkV8Nqurj2lGteP1xEwvnIaqRDx4JCF/fPL1w9hKX0Mtxx
	 G33cW4BLK/dPKWPco46uu481BCr4DAmXvPS97xtIUBb0ypJcnU/Y5wnaiqpvSCoOer
	 JLEjE/XbDmwGavdzGx+DzReviIlN17BZ/kBnb3R4=
Authentication-Results: mail-nwsmtp-smtp-production-main-67.vla.yp-c.yandex.net; dkim=pass header.i=@awooo.ru
From: kotborealis@awooo.ru
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Namhyung Kim <namhyung@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Evgeny Pistun <kotborealis@awooo.ru>,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] perf data convert: Output empty string for null pointer
Date: Thu, 25 Jan 2024 12:44:11 -0600
Message-Id: <20240125184411.30757-1-kotborealis@awooo.ru>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Evgeny Pistun <kotborealis@awooo.ru>

Providing ill-formed input to `perf data conver --to-json`
causes it to crash with segmentaton fault. There's a bug in
`output_json_string` functon: input string is not validated.
This could be reproduced by crafting input that does not specify
hostname/os-release/etc, which are written to 'headers' section of
outputted json.

This patch adds a null pointer check. If `output_json_string` is
called with a null pointer, it should output empty string (`""`).

Signed-off-by: Evgeny Pistun <kotborealis@awooo.ru>
---
 tools/perf/util/data-convert-json.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/data-convert-json.c b/tools/perf/util/data-convert-json.c
index 5bb3c2ba9..f8fd22bd7 100644
--- a/tools/perf/util/data-convert-json.c
+++ b/tools/perf/util/data-convert-json.c
@@ -42,7 +42,7 @@ struct convert_json {
 static void output_json_string(FILE *out, const char *s)
 {
 	fputc('"', out);
-	while (*s) {
+	while (s != NULL && *s) {
 		switch (*s) {
 
 		// required escapes with special forms as per RFC 8259
-- 
2.25.1


