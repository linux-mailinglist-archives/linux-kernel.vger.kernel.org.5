Return-Path: <linux-kernel+bounces-49326-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EED18468B2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:59:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7BCE1F24385
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:59:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55BB82943D;
	Fri,  2 Feb 2024 06:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u2Gxc7Vw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B41282E9;
	Fri,  2 Feb 2024 06:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856987; cv=none; b=bBkZiune8khOsk22QTEs0vRQJ+2zDbLwBVfb0iy8NASVVgDuuMUR2XWUkUijNSs122vJ94jmPknHwjDwFi1JqNtdqWBov6P0eG1JyxR+eCntOGpI/VK5WuNlTOZ6Aw6SHVFha5XF5OOwKA1rPtN1OZQGkv1AZY2qC5j4whb5Uj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856987; c=relaxed/simple;
	bh=UbOFvmxMCfDnw/gmoV7JLKUwxcacwjOcrfiF+WJiOpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Qh1Di9RA2MyL3HdpKZnCpRJryFI6HF4yoSvIUWeeiQKBoIvNik0k9aFzQI8RVbEtuRCDcaUNp4ikc1CvkRJOtq2Dqcm2Jcj3f1D9H6TSMR9lhnjFyf2Ee3s9aq6Cl6BA6uAqSz3dd3f4v4oJHCWwsoe6viUruRrUV0XC7JTzXrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u2Gxc7Vw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 043D3C433C7;
	Fri,  2 Feb 2024 06:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856987;
	bh=UbOFvmxMCfDnw/gmoV7JLKUwxcacwjOcrfiF+WJiOpA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=u2Gxc7VwSJBG7CcwBfKs9oPAEVwykMwexruSoEhi8oUL0csvCt+2CF0WkHFYMaIWE
	 X3PWCJKXlhMvIS2zvFaENLuA6DQ32HEeAjQr/j44j3egVRA490bidTep3YqB7d0M6d
	 J80MmCN58phB0hL1EoULMno8ykxGoAwHCchWlHF7LnE2dN0qHfqhaYXaCqN34lnn9R
	 Bjtsnw4FHQgoo/WqjqFSg7F8E8R4+4yTVMfUM1Q5MQq6/9rZ+3tsUNiVVPgCgPC0LR
	 /D/kZehfDHaaZhZ7B7uktgYV0OeviVaQoM4ljNCDT0Fg3/tctWP23hdpLKox3eKYzx
	 e4e7SQhG3fnUQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 10/22] tty: vt: accept u8 in do_con_trol() and vc_setGx()
Date: Fri,  2 Feb 2024 07:55:56 +0100
Message-ID: <20240202065608.14019-11-jirislaby@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202065608.14019-1-jirislaby@kernel.org>
References: <20240202065608.14019-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These functions expect u8 as the control character. Switch the type from
'int' appropriately. The caller passing the value (do_con_write()) is
fixed as well.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 42bc0957a654..451a852ed234 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2144,7 +2144,7 @@ static void reset_terminal(struct vc_data *vc, int do_clear)
 	    csi_J(vc, CSI_J_VISIBLE);
 }
 
-static void vc_setGx(struct vc_data *vc, unsigned int which, int c)
+static void vc_setGx(struct vc_data *vc, unsigned int which, u8 c)
 {
 	unsigned char *charset = &vc->state.Gx_charset[which];
 
@@ -2198,7 +2198,7 @@ enum {
 };
 
 /* console_lock is held */
-static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
+static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 {
 	/*
 	 *  Control characters can be used in the _middle_
@@ -2963,7 +2963,7 @@ static int do_con_write(struct tty_struct *tty, const u8 *buf, int count)
 	param.vc = vc;
 
 	while (!tty->flow.stopped && count) {
-		int orig = *buf;
+		u8 orig = *buf;
 		buf++;
 		n++;
 		count--;
-- 
2.43.0


