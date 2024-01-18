Return-Path: <linux-kernel+bounces-29790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C258831391
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 08:58:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54278283249
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 07:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6744A1D521;
	Thu, 18 Jan 2024 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vJESU3IA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A96C41BDFD;
	Thu, 18 Jan 2024 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705564689; cv=none; b=mDeagyyNX3faHD3xRpLttFDdf6Q8mPSc+VdHd4vTTWo4KGGZ8V+vXU0W5AnE7gtRZz0mbCKwu6/Nyh6lPqrnYExJnS2l1YqT/DPxyBYCkdRzYFM3kuSnD7lEhGbz7phzHnhl6Mb5DrLsrNMON5MEXM55Bn03H6NbzNTZTAsWQrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705564689; c=relaxed/simple;
	bh=JLskyX1cYZHzZMmvuU1LzSTACKKk6cE/XiYsShkR8C4=;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding; b=O4lX+jvsjY33OBMrVkLPfbLP2HxGu7UtEC26gCTdngTrekwChp0ijftqA8ue08SWdqMCowPPoOwmP5E4yVuB17Eyn6vSDGWn1Rt8sQmVD7Lc9YOJfIkgm/c4D6X8VxWMV2lQW9HhT3Cx9sQT5HsqseGLdOM8uYGh9gz4uLDhhCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vJESU3IA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D71D0C433C7;
	Thu, 18 Jan 2024 07:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705564689;
	bh=JLskyX1cYZHzZMmvuU1LzSTACKKk6cE/XiYsShkR8C4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vJESU3IAqd69GLqIiFKDFIagNUQv3n+FfY2/R5MVHbje30/2WTE86E8phmkCHG3Eu
	 21hxB3uIcNRnCYuU8yD+JblDqnZPUXsX3iIzO4vcoK46t4mTo4n28msoJ1pLIhPxjm
	 k0GPU3RwtmPqcCOYPn6xxigoG2RSXbikDJG8cnQOpe5/0KvPfE3qQaRDJbBqw700OK
	 N9mSdQd9MinsTAuwV1Rn0GaIUvjqwJkaHnQ7o+vSicWMVJ0xjeVDnVgd+oEobig4dW
	 GxMIX6K8jDouI751V07ITF6XQ9WAtPji2kmmU+LsoO9K+K1tVljjr5ZNSMsv1IHSKx
	 epMMnNfmD+x7A==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Martin Hostettler <textshell@uchuujin.de>
Subject: [PATCH 03/45] tty: vt: fix 20 vs 0x20 typo in EScsiignore
Date: Thu, 18 Jan 2024 08:57:14 +0100
Message-ID: <20240118075756.10541-4-jirislaby@kernel.org>
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

The if (c >= 20 && c <= 0x3f) test added in commit 7a99565f8732 is
wrong.  20 is DC4 in ascii and it makes no sense to consider that as the
bottom limit. Instead, it should be 0x20 as in the other test in
the commit above. This is supposed to NOT change anything as we handle
interesting 20-0x20 asciis far before this if.

So for sakeness, change to 0x20 (which is SPACE).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Fixes: 7a99565f8732 ("vt: ignore csi sequences with intermediate characters.")
Cc: Martin Hostettler <textshell@uchuujin.de>
Link: https://lore.kernel.org/all/ZaP45QY2WEsDqoxg@neutronstar.dyndns.org/
---
 drivers/tty/vt/vt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 3f3f7c216819..55ce6cdecbca 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2469,7 +2469,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		}
 		return;
 	case EScsiignore:
-		if (c >= 20 && c <= 0x3f)
+		if (c >= 0x20 && c <= 0x3f)
 			return;
 		vc->vc_state = ESnormal;
 		return;
-- 
2.43.0


