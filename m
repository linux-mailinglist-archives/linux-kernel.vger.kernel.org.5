Return-Path: <linux-kernel+bounces-4554-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 69123817F3F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 02:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E411D284DEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C473F1FAA;
	Tue, 19 Dec 2023 01:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pqrs.dk header.i=@pqrs.dk header.b="088xH3k1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4D5A15A0
	for <linux-kernel@vger.kernel.org>; Tue, 19 Dec 2023 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pqrs.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pqrs.dk
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pqrs.dk; s=key1;
	t=1702949136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=axGj3enhg+YeIx3Crw8OdM616NaGhSm4kX8xiNtcf6E=;
	b=088xH3k1u1oMAfJp6Qzyyme9hxtW4LAb6VgTYE6/DlYaPNA6ByIGXZzvjCQ6txJ+1s/6lg
	bz6eotxsBMBBqT6L1KulzV+A65MEkmvo7AbR4iCroM1MjYfqRmMJUxgruvZjKpM91EV6mt
	aCWQcvHYC2cDceqYwk6JXtRnUNT2OV39PSQKRdlozIFZGTA/I/MIl26kXKWwl3AIykmhhB
	3cC4rjPjp+a4joHkuqxLzbIRXlY8wwdi9PXLN0gZXxr6OkgKV7R14W0LA0HCJEaEG/b5yc
	T1Sc7QaDebf5l7mpJuVAN0skjHgKvZ0op6I17WOFQxR287KlcURCxGQ+n9xxHQ==
From: =?utf-8?q?Alvin_=C5=A0ipraga?= <alvin@pqrs.dk>
Subject: [PATCH v3 0/2] get_maintainer: correctly parse UTF-8 encoded names
 in files
Date: Tue, 19 Dec 2023 02:25:13 +0100
Message-Id: <20231219-get-maintainers-utf8-v3-0-f85a39e2265a@bang-olufsen.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPnwgGUC/4XOsQ7CIBAG4FcxzGLKgS06+R7GgcLREpUaoETT9
 N2lXRyMcbjhv+T/7iYSMTiM5LiZSMDsoht8CXy7IbpXvkPqTMkEKuCsYoJ2mOhdOZ/KYIh0TFZ
 SDrrea2FqKxUp1UdA654re76U3LuYhvBar2S2bP+AmVFGubJSNwpb4IdTW56hw220Ef3OXMnCZ
 vhQ8JOCQrVMSqObSoAS39Q8z28FIQBrCQEAAA==
To: Joe Perches <joe@perches.com>, 
 Linus Torvalds <torvalds@linux-foundation.org>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje.mihanovic@skole.hr>, 
 Konstantin Ryabitsev <konstantin@linuxfoundation.org>, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>
X-Migadu-Flow: FLOW_OUT

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
Changes in v3:
- add more rationale for opening everything with UTF-8 encoding
- fix a separate issue identified when introducing UTF-8 names, namely
  that they would not get escaped with quotes as expected, due to Perl's
  default behaviour being to match UTF-8 characters with \w
- add a second patch to fix an unrelated issue mentioned by Joe whereby
  a mailing list might get the display name '-'
- Link to v2: https://lore.kernel.org/r/20231214-get-maintainers-utf8-v2-1-b188dc7042a4@bang-olufsen.dk

Changes in v2:
- use '\p{L}' rather than '\p{Latin}', so that matching is even more
  inclusive (i.e. match also Greek letters, CJK, etc.)
- fix commit message to refer to tools mailing list, not b4 mailing list
- Link to v1: https://lore.kernel.org/r/20231014-get-maintainers-utf8-v1-1-3af8c7aeb239@bang-olufsen.dk

---
Alvin Šipraga (2):
      get_maintainer: correctly parse UTF-8 encoded names in files
      get_maintainer: remove stray punctuation when cleaning file emails

 scripts/get_maintainer.pl | 48 +++++++++++++++++++++++++++--------------------
 1 file changed, 28 insertions(+), 20 deletions(-)
---
base-commit: 2cf4f94d8e8646803f8fb0facf134b0cd7fb691a
change-id: 20231014-get-maintainers-utf8-32c65c4d6f8a


