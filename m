Return-Path: <linux-kernel+bounces-49336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 414758468CA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 732631C22528
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AFE548CD4;
	Fri,  2 Feb 2024 06:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oKsN4Buf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95AEF487A3;
	Fri,  2 Feb 2024 06:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706857002; cv=none; b=KbIZaseLzQQgJCv9/qQXkqvqfnXixjIe+ZOCq9WJhSaRgnJOHiu+UE07cKuiWzm0PwGn/ITcf5DO6hEUCfNbh1rtcLAQs6gIgymxHSMxbIyZXcwXX1wfSKdb4eD8+t0PEPxU3gNmbZDRm7PhhUxBmfmFnaeJFeoljGKqYmoLOSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706857002; c=relaxed/simple;
	bh=nkWkHSb0yfwwGbw4xRVlBM1cIu2gl8Yeewy4ovMPibY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVt6+wmq0xelnKdi89uzNKmZ7LRy1NU4mUpXqaWok8SB36M9aX3qDG91EJ+j6t/2UlMQ851oy5YXyZMqoKo06rZbPUdaPF5VkVoi1mi9EoNN9Rjl/2KSRhhSXhqKrRtKyJWiiIEjK4jdpMvvb+gm/mu98YAS4FauDSWc2bQ6Jtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oKsN4Buf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B97EC433F1;
	Fri,  2 Feb 2024 06:56:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706857002;
	bh=nkWkHSb0yfwwGbw4xRVlBM1cIu2gl8Yeewy4ovMPibY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oKsN4Buf4FfaSfj508bocnUZ2FXfe0mjiJMu1gXev4VDSb3zPJ8AQH5LsQX1lgY++
	 zCzNsYG4x4nA7nfIpp4n7HawBEo/EVAKGi1+htZxXfrYMsLjCk/e9TVxX4J6hzymdE
	 zKR/wjycigLKJS9eougbDQ2HbgHec3zKK76/YmGgY4DX2kO6EJqF5Z2k4+osDutU+v
	 qxLQ176yzHFWvRE9/K0wF8Gd5WvjtJUMpdgOHPLQp8T4x0rrgnMUj0W2I7OtvGsfKd
	 t0EtUQWVu8tZHHjfCKjCpp7nS5NjQ/74UShvnVM3u+6RYsCc1vrPIbpLyZ0pZaGrYH
	 5BCHfqZFtfwNQ==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 20/22] tty: vt: use switch+case in the ESgetpars case
Date: Fri,  2 Feb 2024 07:56:06 +0100
Message-ID: <20240202065608.14019-21-jirislaby@kernel.org>
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

To be uniform in the 'c' handling, use switch-case (with ranges) even in
the ESgetpars case in do_con_trol().

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index b5fc3b896e26..b3c61ec92df9 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -2628,10 +2628,14 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, u8 c)
 		vc->vc_priv = EPecma;
 		fallthrough;
 	case ESgetpars: /* ESC [ aka CSI, parameters expected */
-		if (c == ';' && vc->vc_npar < NPAR - 1) {
-			vc->vc_npar++;
-			return;
-		} else if (c>='0' && c<='9') {
+		switch (c) {
+		case ';':
+			if (vc->vc_npar < NPAR - 1) {
+				vc->vc_npar++;
+				return;
+			}
+			break;
+		case '0' ... '9':
 			vc->vc_par[vc->vc_npar] *= 10;
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
-- 
2.43.0


