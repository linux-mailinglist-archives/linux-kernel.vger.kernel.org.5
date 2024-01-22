Return-Path: <linux-kernel+bounces-32853-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F22F8360F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:17:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1617C1F21BC5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B44147F76;
	Mon, 22 Jan 2024 11:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vLhn8Prv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7368D47F66;
	Mon, 22 Jan 2024 11:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705921531; cv=none; b=OMeQ7m2+PPvTTi+kxwHdDsfwq89axlgZvColak0Oxl7YnmOhdINQEqd+B82yw6HQx2xOWNY2UJRhCMVOQnAxcKadRzQBDLrT4fBieRjZokn7P/qnICXbIjS7QSzO23c0L2L2GQqjg567R21greKCLbtknJPJJblCYFOzkzPw/uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705921531; c=relaxed/simple;
	bh=zFv7Kr7FP721KqeR4NrORFjQKCMrAzhMxyWo2XU+XzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sl3pceQlRc/IQh+PJ9Od/CpmA9FOOL8uDywzzr41w60ePzAFEdXHsCrIew2Kpg+arjixNKut0GAKgYVcdzroPsBx+ugLNI9wT38kefBA7RELWyv+Hr0zzbZ9fDvdoCIKlGwgTGKgYt6BUa0LOjCYP8yf8hnwMK9G3WsEjWY/5iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vLhn8Prv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52721C433C7;
	Mon, 22 Jan 2024 11:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705921530;
	bh=zFv7Kr7FP721KqeR4NrORFjQKCMrAzhMxyWo2XU+XzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vLhn8Prva2yRLU7jW7I1BnZpxdEoFxqXgkQlAGcmg8lkqYCiqGli4N438mFfLyJ0a
	 UhwYhfc6kz4KOFMXt0gkYRqhxuEdKMhJo7KM+1VskwbmQGvQY9tWjio7cM01YWCCvT
	 i70IKzQ8xNyUYteVR5AbwcfDIISzJmu8aDQutvduvKM+8pvxxs1bcjssvfnatht8DK
	 7fp3mjjHuY1Jd1ExoF2qMGABOiTrg4ctoyRz/LxgNQSVmYWjwn6ECdf9lnOU+mJDmO
	 m44+QY2vex/ST8aKisONPz1GY0ho5i1rjPVNzDqytyBKNA7t5yZ9bqVq/aGxZS+PXI
	 PsUc/2QNkha/A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH v2 40/47] tty: vt: remove consw::con_screen_pos()
Date: Mon, 22 Jan 2024 12:03:54 +0100
Message-ID: <20240122110401.7289-41-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122110401.7289-1-jirislaby@kernel.org>
References: <20240122110401.7289-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the previous patch, nobody sets that hook. So drop it completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 12 +++---------
 include/linux/console.h |  1 -
 2 files changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 0ac537f82f7a..4e9d689143e0 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -289,15 +289,9 @@ static inline bool con_should_update(const struct vc_data *vc)
 static inline unsigned short *screenpos(const struct vc_data *vc, int offset,
 		bool viewed)
 {
-	unsigned short *p;
-	
-	if (!viewed)
-		p = (unsigned short *)(vc->vc_origin + offset);
-	else if (!vc->vc_sw->con_screen_pos)
-		p = (unsigned short *)(vc->vc_visible_origin + offset);
-	else
-		p = vc->vc_sw->con_screen_pos(vc, offset);
-	return p;
+	unsigned long origin = viewed ? vc->vc_visible_origin : vc->vc_origin;
+
+	return (unsigned short *)(origin + offset);
 }
 
 static void con_putc(struct vc_data *vc, u16 ca, unsigned int y, unsigned int x)
diff --git a/include/linux/console.h b/include/linux/console.h
index 82e4b554a801..b2d8621cea57 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -96,7 +96,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	u16    *(*con_screen_pos)(const struct vc_data *vc, int offset);
 	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
 			int *px, int *py);
 	/*
-- 
2.43.0


