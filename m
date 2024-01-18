Return-Path: <linux-kernel+bounces-29795-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 516CB8313B8
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:00:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04ADE1F23635
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6983120B3F;
	Thu, 18 Jan 2024 07:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QTrWph8k"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD77820B1B;
	Thu, 18 Jan 2024 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564698; cv=none; b=iMKg9Ji6k8thZyqvsBa48W+h72EVJel2y5iyZI8NegWAvgkmCSSrr5tRhCkyxajyCITWMl5B3y+qC1rngeOQvUFGakjgM8JOQug/ytd4I6A1l96m36Ionu9npj4V5oFJmZm+nZLHqEpfSyM+HIpuL4mrvQv6NJnirOsRywZStyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564698; c=relaxed/simple;
	bh=NurnY/n3MIEH+3Fog1rQ9f+5l/LwSVWrvTynpHmGqrk=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=EO0Ga7NHRAa9l25+uSyTykM02fUTZAWG+J8ks78RsjqygCLld/FJq8411F4RoRua6xRBCxFKpiSmch9+y1mbI0T6L0XogzkLM08YGtOdSULS9ITSMn0k52L9BsHk/Mr+sw2EktPltC92+DPYXERZAdlLWz3N6aoW5dbUk6TGXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QTrWph8k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56CBAC433C7;
	Thu, 18 Jan 2024 07:58:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564698;
	bh=NurnY/n3MIEH+3Fog1rQ9f+5l/LwSVWrvTynpHmGqrk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QTrWph8kxlXCEl0PNiUQ+8nzl8VC1/+BTUhxVyqof9IU+7f4kOb20rjKiLgq1Idgk
	 2z6+ck6vQDGhSg88rzt2PZAX7GqlKeTUH4pzP0+vzJ54Q7p/h82N2PM92i54B8KdQW
	 r1TtbQU4lxHRekpLmwcr9mYL4jwXs/1eE23Ngb2TxlbW2hmWL+0Q4SDGe2ry+JDvl7
	 lIsvUfOLS0kpsrte41ew0zbsukI3q4Md8PJHzivZlVCSiwsSGQd7oqUhywvpwMmFAz
	 KB6urOcZ2sl+oDsIxQI4oRss7/9Ic+54iC2QKzpDte0rAmz0FK2XYznSJGzUA4R8xi
	 fdumJOCEeGoHg==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 08/45] tty: vt: make vc_is_sel()'s vc const
Date: Thu, 18 Jan 2024 08:57:19 +0100
Message-ID: <20240118075756.10541-9-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240118075756.10541-1-jirislaby@kernel.org>
References: <20240118075756.10541-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's only an aid to people reading the header and/or calling
vc_is_sel(). vc is only tested there, so having it const makes sense.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/selection.c | 2 +-
 include/linux/selection.h  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 91d789c025c6..34ee09f5a8f4 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -88,7 +88,7 @@ void clear_selection(void)
 }
 EXPORT_SYMBOL_GPL(clear_selection);
 
-bool vc_is_sel(struct vc_data *vc)
+bool vc_is_sel(const struct vc_data *vc)
 {
 	return vc == vc_sel.cons;
 }
diff --git a/include/linux/selection.h b/include/linux/selection.h
index b7cd23e56a2b..533509f6ba4f 100644
--- a/include/linux/selection.h
+++ b/include/linux/selection.h
@@ -24,7 +24,7 @@ extern int sel_loadlut(u32 __user *lut);
 extern int mouse_reporting(void);
 extern void mouse_report(struct tty_struct * tty, int butt, int mrx, int mry);
 
-bool vc_is_sel(struct vc_data *vc);
+bool vc_is_sel(const struct vc_data *vc);
 
 extern int console_blanked;
 
-- 
2.43.0


