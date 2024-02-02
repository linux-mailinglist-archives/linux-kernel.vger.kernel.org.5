Return-Path: <linux-kernel+bounces-49318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E3184689E
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:57:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 006251F2401F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:57:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B578117C7F;
	Fri,  2 Feb 2024 06:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="puyPq7MW"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE92D17C79;
	Fri,  2 Feb 2024 06:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706856977; cv=none; b=kx65CX4dQlO9gc6xvnmitT9tD5K3lQrINvI43ZEnlhKP+kAhv/I6E6vmid+LoAQYLJOWIJDaVAEOVnRyvV7loEncLP92kswrESsBL21N/14XWrm/gtdutqRad6lq8GewwWnffl09YU2kaGGdakLNrEFaFJ6r2BMHPQx17lTG7iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706856977; c=relaxed/simple;
	bh=1ggf9N68+vMUK1jcvrtDR4Sh3DWkqEikyT9dyj3heQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bKEF35J9Tr+WZymZZM4eZVNhq/5BkyX1gcQM3z0QBxUfBJhnanpCQyHeTiMvLrQDxf26e33umeLY0DxfBCpTJKml4F8h3lThpzEBTTsRTZnJSDKl7ltZToFvlPcznhNgLY9cDAjzTEreDz3D1ywhP2Pk+LdkyApgBZbnstLTcK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=puyPq7MW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72FD5C43394;
	Fri,  2 Feb 2024 06:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706856976;
	bh=1ggf9N68+vMUK1jcvrtDR4Sh3DWkqEikyT9dyj3heQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=puyPq7MWSrRarl+OmiFB6rP1PURCFE9fChZXyP29VV50HvdluViBp0absbs22mr8+
	 +Wg66Mvsn2QD6LeBDPrwKxI2A0bc3Q49W+pdum3o2S7jHgTYcwEe0Zocxx3IMPZ4uo
	 9lkufuHYBZjnMp18ULpEcVaxREIfCJXYGIGmgab8JCvFmJgktrptZDPSgQPk9Mp5/+
	 oP4g3NmqhbcF0+RQ/4QG6GuEhD7jyWz0yYzLpqnbXtvjIAnsP3L+0yoyinHHZzjbRD
	 DbimhrdoG0z86nZFOnAZ/LP74NV/SBd8YMnWLMhRglPovbI7HfaP/u+BUBfSxbOUMK
	 AanEK4lgXGe5Q==
From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>
To: gregkh@linuxfoundation.org
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Jiri Slaby (SUSE)" <jirislaby@kernel.org>
Subject: [PATCH 03/22] tty: vt: rename set_mode() to csi_hl()
Date: Fri,  2 Feb 2024 07:55:49 +0100
Message-ID: <20240202065608.14019-4-jirislaby@kernel.org>
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

It's how the other CSI handling functions are named, so unify to that.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
---
 drivers/tty/vt/vt.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7b55d87248f8..ae333f49790a 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1881,7 +1881,7 @@ enum {
 };
 
 /* console_lock is held */
-static void set_mode(struct vc_data *vc, int on_off)
+static void csi_hl(struct vc_data *vc, bool on_off)
 {
 	int i;
 
@@ -2380,11 +2380,11 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		switch(c) {
 		case 'h':
 			if (vc->vc_priv <= EPdec)
-				set_mode(vc, 1);
+				csi_hl(vc, true);
 			return;
 		case 'l':
 			if (vc->vc_priv <= EPdec)
-				set_mode(vc, 0);
+				csi_hl(vc, false);
 			return;
 		case 'c':
 			if (vc->vc_priv == EPdec) {
-- 
2.43.0


