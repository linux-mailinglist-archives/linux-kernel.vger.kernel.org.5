Return-Path: <linux-kernel+bounces-29828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 47A47831423
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 09:08:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F13481F23140
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33AF0200AD;
	Thu, 18 Jan 2024 07:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mm3nIJXo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 779C933CE9;
	Thu, 18 Jan 2024 07:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564773; cv=none; b=FlFfZUWCzsexKdbD4Yrd05pIMDdHD/2XhI+hlRD0u0CIsCd8GFpFBiH7wjv3Q6kgJtz6EU/C73Z3khrueiw9TTncem17mTQnSvUSmd0WjlOcRvh6lP6VrKLKn1iTCaY1pgGrDQjKM/yDtUrO5uWDtvdF5wX3d2xmw/x3kKJnwO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564773; c=relaxed/simple;
	bh=MR+NuATfSYHNVmx82TTROPf/5gbNbFwpQP6yg+dZ/d8=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=n8YrPSKtcp898pyBFGo7LePCfKsjrDQQuEWhoGCBwuIOTZn5LFjoOlPIJ6oc4sTYADvHW9mC9nyuxG3F8vwx39G3PYHuCdLJsysCo4d+aUY7uVl61O0KUQnytUB48KfBW2MEFicaLiDbhGxkSJ3wN5Y+F2h9JQhEBaCqrsVBK48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mm3nIJXo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C54C43394;
	Thu, 18 Jan 2024 07:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564773;
	bh=MR+NuATfSYHNVmx82TTROPf/5gbNbFwpQP6yg+dZ/d8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mm3nIJXoZMPbRn4yehphjA5VP8jv7ep9JhBxEfhuYCDk0idvxkfB8kRTLlcMeXOcY
	 8D5oo3k0XgbY4mpLCB0P45Xe/qoDHlBish90lFuBmG6ptmwuvCustOCMVaqn3wfaro
	 LfkFKcB1WU4mT/24kObB4tnvtX06ZY2DyfafcEeGQe+ZElizURKKnOPyfxsgHoY3Ge
	 faE2ZUcOyUgz7ATMwVKPGRqsJ4IUfCA41v8MknixBgxtDZjopejqneroTpoy9jYfDV
	 DPU5EfjBkfasr4kvKuPw4e5wB5plYE+iN1l4M5bbmMWjo/b1mv0olTJ9ZqY4TtsHrk
	 +Rt/xvfnq6OTA==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 41/45] tty: vt: remove consw::con_getxy()
Date: Thu, 18 Jan 2024 08:57:52 +0100
Message-ID: <20240118075756.10541-42-jirislaby@kernel.org>
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

After the previous patch, nobody sets that hook. So drop it completely.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c     | 20 +++++---------------
 include/linux/console.h |  2 --
 2 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 69d85a030ebc..539b30e198a9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -593,18 +593,12 @@ static void con_scroll(struct vc_data *vc, unsigned int top,
 static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 {
 	unsigned int xx, yy, offset;
-	u16 *p;
+	u16 *p = (u16 *)start;
+
+	offset = (start - vc->vc_origin) / 2;
+	xx = offset % vc->vc_cols;
+	yy = offset / vc->vc_cols;
 
-	p = (u16 *) start;
-	if (!vc->vc_sw->con_getxy) {
-		offset = (start - vc->vc_origin) / 2;
-		xx = offset % vc->vc_cols;
-		yy = offset / vc->vc_cols;
-	} else {
-		int nxx, nyy;
-		start = vc->vc_sw->con_getxy(vc, start, &nxx, &nyy);
-		xx = nxx; yy = nyy;
-	}
 	for(;;) {
 		u16 attrib = scr_readw(p) & 0xff00;
 		int startx = xx;
@@ -627,10 +621,6 @@ static void do_update_region(struct vc_data *vc, unsigned long start, int count)
 			break;
 		xx = 0;
 		yy++;
-		if (vc->vc_sw->con_getxy) {
-			p = (u16 *)start;
-			start = vc->vc_sw->con_getxy(vc, start, NULL, NULL);
-		}
 	}
 }
 
diff --git a/include/linux/console.h b/include/linux/console.h
index 2c8a77865437..c0525ccc54d9 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -104,8 +104,6 @@ struct consw {
 			enum vc_intensity intensity,
 			bool blink, bool underline, bool reverse, bool italic);
 	void	(*con_invert_region)(struct vc_data *vc, u16 *p, int count);
-	unsigned long (*con_getxy)(struct vc_data *vc, unsigned long position,
-			int *px, int *py);
 	/*
 	 * Flush the video console driver's scrollback buffer
 	 */
-- 
2.43.0


