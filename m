Return-Path: <linux-kernel+bounces-83436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB21869930
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4426E284059
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E2613B797;
	Tue, 27 Feb 2024 14:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="iV49nW+P"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CCC13B289;
	Tue, 27 Feb 2024 14:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709045726; cv=none; b=iBcXdBR7IfXluP2palF86MLFvjcx3jvdRJMA9ODf1DiVOCgfVN1srcksBkl8DzMzX5iYhgyvYlKQIh/KEt1nhT7qxNFnD02QGVYq55jRnV8wudCIr0jTEXR/BGMqKAb0IarbyoRyynTf9yRePuDOCDjZv4vSq2qGz1tqmSTTleY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709045726; c=relaxed/simple;
	bh=fBLBJnTXEesUlwnv6flfi7CtneDxF1nsqo3zSFZ/SCs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=D67rGPOroS/7VtcRpTOZOsu1sz7RtHtzSrVlS+IKuWTnu5ferB9KWQ6PIcqLQAzB+YwJHt5VPdphy4vaNk2M55Irug7xC6XwFm7tuVoi4LWO3UoqI2xB/ck88v1ro7617tXsjAeBM10R3yAbTruRzIHhAfUsqANaz9T1uEmOUso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=iV49nW+P; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709045708; x=1709650508; i=w_armin@gmx.de;
	bh=fBLBJnTXEesUlwnv6flfi7CtneDxF1nsqo3zSFZ/SCs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=iV49nW+PM1NvK+0/Fb5KnrvKctrOzz088gPi78nErBhSlex1JBHymmG9e4ITqitD
	 Gj5N7wEWXWhkYHqHqWj3+oGRDRWtZ2p42J2McAosJkiVb9MhRVT1a5MOYW2Y+7iUk
	 cHm5NzdebPpsrUoW+q7NjgB+VpLy86J/itI8PQsHLdEeSb29XWn6MDBG+LNhRG6TQ
	 SgpRx3wun2SYkmYuWGItwtt+Hlpdjf3DeCPpaqBMxQpHeCxPR+uDA6RorCR4Hy9bw
	 X2I/sb7fOOn4JAAwwWT1xrjmgQkq3qppUWjsIbJI2gWsG8fOck7viHc17uiDwe+sj
	 repCWkx/NSeLGcYWuA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1Mulm5-1qoFTz26Vv-00rqYP; Tue, 27 Feb 2024 15:55:08 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] platform/x86/amd/pmf: Fix possible out-of-bound memory accesses
Date: Tue, 27 Feb 2024 15:55:00 +0100
Message-Id: <20240227145500.299683-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227145500.299683-1-W_Armin@gmx.de>
References: <20240227145500.299683-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mwB/4+OQxc3beQYvIPV5xzGZIUOShegwwrNBgf2oo3MXenhZKFn
 bLP7TMzPgdsBYdgMbfx/KV+sy/zk32uwTlQjBeZRJIXYhi5A1ym5YXoBbmabvZb5R+iEMhH
 ZpB5nX7NBegF/ok7HNjUd5y5eU8tywxrGPW4gq0k33+ZHTV6bZ6RbHdjHzlj3vgo8gWIi6s
 d9Y/faRB1BIVmDPrv2Zsw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:zQEp+AMOBAE=;RccVHBJEzxHJeOPYwc5sLut92VT
 4zv4X4Yy9b7mGc4eOoSAwV0vzU+2vlT17wh42WWplCbusylS/AoMQI4gFPMm9r1tlFKpMH4cj
 KoliPSYlRfOzK09yDNcr4BVYgNGAJitXG0jJVNLED5OoWyLBCv8US2bC+QEagXQEGuD2uHJXD
 kEYT2FhIxs/YT0XQ1GG3dwalo7xqbSeEag27UGKYPpSJdnVbyktyloz3VDfVDHZlRRL19/Lzk
 KmrNYiBua4wfQ7NvLYI35MG8Y0AkKxmK0b/aQj258qvq1dzub9DYwNCQODXn0ekUhntJy6FXl
 SII3l6uVYuW042qxHFQ3vBjjlyhCnD46Ch/amn+UBvP1BQF0fNhUH0D27jCBfVTOi02ry/0Oy
 m/wJiw5ZFo6ju6q1ER7YrygVrWhLsZeCzqpc3OUYNV9qjSyOM/ferF598b5UpteIg8L8zOe71
 XmMlADWNMo2x96JmPRAiVl7sTwbCSm0vjzjSRE166YO+cgwhQN4a7wwO8oceBmS4bGUzLY7ZF
 XZS8nyZJ3uShNWldDXzCBJYvJNEUCINCENB0bjx0GI/XLAS4B1OuqUkgbhvk8ev18EULiUyp4
 zEUKdEntPWmYJqsnXb8uNFX8Juamh3KKhQ3/5Dqd1BHkQfBe6LpY147A0n+xZaX0kEcDo6a08
 V1fYHsNUHZwpO623W0TIZMzU127Ur3DcMgGevEQTm23N0WhNloakK7MMnbn6AaeZQDdpRgxP0
 jXEU6rOLuQHSQL8HXXpyislqhz3PtZkmRi8+bjg9hb/TSLQwhOkA9v0vNu5eDJDZ3mjKdyFS3
 n7xWznp81IBYR5mP9/gCMWqg/Rw+VxprF0Z6IfKFaOCnM=

The length of the policy buffer is not validated before accessing it,
which means that multiple out-of-bounds memory accesses can occur.

This is especially bad since userspace can load policy binaries over
debugfs.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- check if the policy buffer also has enough room for storing the length
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index b3491268b6a0..09e3c620a9c7 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,12 +249,18 @@ static int amd_pmf_start_policy_engine(struct amd_pm=
f_dev *dev)
 	u32 cookie, length;
 	int res;

+	if (dev->policy_sz < POLICY_COOKIE_LEN + sizeof(length))
+		return -EINVAL;
+
 	cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
 	length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);

 	if (cookie !=3D POLICY_SIGN_COOKIE || !length)
 		return -EINVAL;

+	if (dev->policy_sz < length + 512)
+		return -EINVAL;
+
 	/* Update the actual length */
 	dev->policy_sz =3D length + 512;
 	res =3D amd_pmf_invoke_cmd_init(dev);
=2D-
2.39.2


