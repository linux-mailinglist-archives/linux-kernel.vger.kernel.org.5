Return-Path: <linux-kernel+bounces-144145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0BD8A4261
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:59:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 06B101C20DF3
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79A9D31A94;
	Sun, 14 Apr 2024 12:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="BhDRRFxR"
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFA3445BFA
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 12:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099527; cv=none; b=BbHWQA4gANgNQuYQwtbcGlU9rhS0YF6KTsndfjlniszwO3/ur9LZo5Cyji4wnzLVLlfngW0fybumIlqeDgHwDse8TRRMHWvE7lJMXvjFvywR1cXWPbHPqQ6JYllAKwxfjqzpU45ZT4dzX/VjBK+mPzHvWvSfYTtUGHTo0edUQQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099527; c=relaxed/simple;
	bh=sMxhbU6dM25nPdtxdNoi8c5Ojz30tMNpbM+n7PY3KlU=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Fdzny8nHP+CH4Eo3Z48cnEs0nGkMm48yAjq+3C3CpIa2IMC8pvBU/8VV9bX/0cRINHS3tfvftbUFKWE9bUR7tkVxtz6gXjaF6nfEIIDGPBrEerQks5l4XFX6aXF94E5sBYjwA526k0mDjdkefdeq/G2V9ok0/B4DhRPH0rsJXmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=BhDRRFxR; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1713099520; bh=Aa+9sN7eYARka6Ggy8Em6MwZUzzHlAIQfLmCZvygc9Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BhDRRFxRwwd11ASjYIs0cD4xfWvo6C0Pp1iujVn9gSI722b/vyZnzyMrzRO4/WR93
	 0Cnh+bPtiCPmnLKFKOceeRvoqV3rWScHErgvlsw5c3E3DFYQhsYJJuTjlBgALbaC6Q
	 FKqHrafLb9Fy8I3LQxauJl7IMUlnwRlLmDYx9QaM=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszc6-0.qq.com (NewEsmtp) with SMTP
	id EA69D298; Sun, 14 Apr 2024 20:58:38 +0800
X-QQ-mid: xmsmtpt1713099518tqpcya88w
Message-ID: <tencent_79835DC09931CFA58DEC258D8DA51200DD07@qq.com>
X-QQ-XMAILINFO: NSTsyPg8kQQYPafq0PxPC8aD8BvsfSvExymQI6nfTgUQ3m5giO63IXER+Zudqw
	 6QUTyIHSks2UgWx4pEvYwykZzHGkKnoVVjWY/Mk8ZY6r+o71UtEbrI/+amyMoGUw94+ARuvwbAFH
	 pdNU6vtNz9G0OyZFY9jtE27MqDt/+9B+R00dGIEfOLiFLIbBQETqMBC3bqF/Zh3naRzmkHOt17qj
	 ik53NfVlekj8VugvAx5k8nPKTVF9eZl0Ue4fPAO1I/hp/XRupEOT7TJFBk1bB+WM69WsYUsb6BtJ
	 zBcXUnMS0gWLNsWatjjx6+ujNdLEnfpBY9mD27z9RNlnZdoM+2ySQNVx85GO4Wd6RYRQeKryz/og
	 JvaEcOcO3EYK+pcGJhKBOnxSZyia9VZIN7oy9HsMF6ogvEqCbwmTjiRC/c7TblzqSkvzLZYXBRY8
	 wdjgJmGFz8u8t7+ETS6kn9ch0EeEoWz6LD+adEIBV6xoq6MlW5WiACVtE0ru4Fr5WAV9jh9ACSbL
	 eTUOFCiCNbyFXW+qtzqH14OnSchxxoy9fmOEgATh+QidJ6FD8Mw+rns2b2Xtpakwv3W5D3lmWq05
	 qHjQA8Y0DCYxXnYHCq5ZscgfTSxNieG58Ihh3FGZLCEGle+BAxblyLXb4KoYVPdHUIax0DrJSzQk
	 2h/qCcQkSkqhCsCqNATcxABpebOzH4M6UUa1H++voLBdiaugcOcCQ7/V7j7vnaFyAn82rZ4Il9Xl
	 w3p5hPXPT5IVD5rL67/NJZNJVKsVgIHbC7N2y3WvMN39qCzBACr4C/7LeTSGaGkxbsQUyZdXFGWr
	 0hsMOwzs725RY9HpXus2yVvlXNrhTvW7vWKprvd+dciAb7A3TXSDJ1jOCVAHrCPcgR1ugEgyk8Mn
	 s1FQx15024CJCw3Q+flAr+jnNweED+j2QpwJTYSkQjYSkSR5Fy3rAtuw/nbxl1x9UrCKpnToTHEM
	 Z27EUtPgY=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+d0f14b2d5a3d1587fbe7@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pvrusb2?] KASAN: slab-use-after-free Read in pvr2_context_set_notify (2)
Date: Sun, 14 Apr 2024 20:58:39 +0800
X-OQ-MSGID: <20240414125838.3707504-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000bb465d061606e827@google.com>
References: <000000000000bb465d061606e827@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test uaf in pvr2_context_set_notify

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git a788e53c05ae

diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
index 1764674de98b..e93bca93ce4c 100644
--- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
+++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
@@ -267,9 +267,9 @@ static void pvr2_context_exit(struct pvr2_context *mp)
 void pvr2_context_disconnect(struct pvr2_context *mp)
 {
 	pvr2_hdw_disconnect(mp->hdw);
-	mp->disconnect_flag = !0;
 	if (!pvr2_context_shutok())
 		pvr2_context_notify(mp);
+	mp->disconnect_flag = !0;
 }
 
 


