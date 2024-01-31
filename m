Return-Path: <linux-kernel+bounces-47086-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F09A88448F2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:32:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FF451C2359B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B155D13D50A;
	Wed, 31 Jan 2024 20:30:02 +0000 (UTC)
Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFAF613D4FB;
	Wed, 31 Jan 2024 20:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706733002; cv=none; b=aorUtI2IWEwfAadK4eQLJqkU1MnHOGy+VVp1CAkanOTJ8pyCBNv1p6otjQwtkGwHS9h4lO24ndDKDfv7uyn0qn0DPEXgJaCsOCw+9p71dajraZIKeG5ukta0uAWOT/YHXO7gB506A1QNOj7gI8l9thg6yXo1HVPD7eE2DpGuy0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706733002; c=relaxed/simple;
	bh=4GtRh7WJods/5nRPcNIU9DIYmVO3KiovibqAa0Mp2Rw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M56TTePju7QzWhvnhDIoK5bK87XolbbKS/xeu5Y13KJkpLOD9xjysXYhgDt+rQVHX+iTVOqgG1ABHTTBMcFjcT8h2oHXCh+cmnxTYa9RBV8/AIKAF3vYnVjHAU/6QeUVtDjqCqv4UdEGTltTFbusEFyCWDlxguM4FLQVd0fYLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com; spf=pass smtp.mailfrom=perches.com; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=perches.com
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id A1EE3A06B0;
	Wed, 31 Jan 2024 20:22:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id AAC116000C;
	Wed, 31 Jan 2024 20:21:55 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: linux-input@vger.kernel.org
Cc: Sandeep C S <sandeep.cs@samsung.com>,
	Junwan Cho <junwan.cho@samsung.com>,
	Jitender Sajwan <jitender.s21@samsung.com>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <benjamin.tissoires@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] HID: samsung: Object code size reduction and neatening
Date: Wed, 31 Jan 2024 12:21:35 -0800
Message-ID: <cover.1706732238.git.joe@perches.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AAC116000C
X-Stat-Signature: idn3j8kwcz5oiy3p75yr3871yf98u3xp
X-Rspamd-Server: rspamout04
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1/wBRyWJqoR/km88mI/HUD17tBDCUtzVAg=
X-HE-Tag: 1706732515-608211
X-HE-Meta: U2FsdGVkX18oyJN/QLZ3rVHRUr9xW74gldjYie8Xz3gqd9xBRywKAhztgv+9cUg5J72ra18ugOoD9ZZ4UCU+Dy6q6eCB3jfczoZqMx4ZGesQb1SRABxpL/1fpW/Q8guXDJlSw8xlYaprgf4PTjGWE9IDwhqkOQA+lFHc0mlTaT/7ToqFwX6aUEm/YkBha4czT0LVzIxNr0N7LXMtNZnnzdm23B9Vjo/LUDSVTj0+WP1kSpZduJR8h7j8iJ2MuvbWqCILX0C/cEYQJULjrs4OoA==

Reduce object size and neatening

Joe Perches (2):
  HID: samsung: Reduce code size
  HID: samsung: Object size reduction and neatening

 drivers/hid/hid-samsung.c | 652 +++++++++++++++++---------------------
 1 file changed, 283 insertions(+), 369 deletions(-)

-- 
2.43.0


