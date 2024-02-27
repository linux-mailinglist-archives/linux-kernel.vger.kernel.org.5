Return-Path: <linux-kernel+bounces-83370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E438695D4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 791EF1F2BFCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A3FC145B0F;
	Tue, 27 Feb 2024 14:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Rts4oMyt"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3354213DBB3;
	Tue, 27 Feb 2024 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709042716; cv=none; b=aaW6X4XaZON5UnnD2wto85PnKa1+f1wXyFPChaXBsHGp57X97gAn6kHs4oNl0pR3QynCvyZZ650wUjUKM/REts64TKUjrdlNUVx9WnXp4rEyHuTxs4IdmuDfcwM3Ebp6BVCg/bFixxtrLUmoC3qwqWH98j32X92CJOgmsTKBgqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709042716; c=relaxed/simple;
	bh=xX2I1MKb6pDRYs2bp7Zf7ZhxShvaggxGHP0EN8JRI64=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H3zLYLY3F1HxX6derOecVxrSGZ/Zrp5OfdvZVBC452ENBCVYReM7C+Gn3rHmDAHgB7MbxFOzWlB4v4uChLbo3rBQ5W48+HT6pWGLJmT64EcbLusDDuChCqLSrdEgO0nRxwgFqXNodrD6vRjYo16PLjjXbcfLBozLcUaxdy2iqDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Rts4oMyt; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709042704; x=1709647504; i=w_armin@gmx.de;
	bh=xX2I1MKb6pDRYs2bp7Zf7ZhxShvaggxGHP0EN8JRI64=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Rts4oMytgLEJC4i0r9yHabZImMvVlWFY1rY0IqtybjaB3I5hb3RcNDAy+i9N9Ixo
	 dAstM8OPZDXGxikJjZ8KeR5V0Dtsh3ziaKFKJDHZCDwnU6XjEePhCxVCJiRzvqSIM
	 f3oMmuILYYM8TOFwiP3UUa96CVKCjivb0hSX83s0ktvvoFzd2z3MRWwxZDNJD1WXo
	 2YUGP7jYaOdvfoTbLxNgxl2/22PkAfD3t7p3XMgb8aX8Ch27LU/N4OO6WdjrsmTFH
	 BPVNbqBJVnL/7Vhv6MGNwLB2by65PebVzxtaVDfCAHgLkUhRLlfvYOHg6PLugr+9h
	 +UgU+nKzrGCKH2XYRw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx104 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MNbox-1rGzJD2dBb-00P2SH; Tue, 27 Feb 2024 15:05:04 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com
Cc: hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] platform/x86/amd/pmf: Fix possible out-of-bound memory accesses
Date: Tue, 27 Feb 2024 15:05:00 +0100
Message-Id: <20240227140500.98077-2-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240227140500.98077-1-W_Armin@gmx.de>
References: <20240227140500.98077-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:jTFha4DE5UVuluwTxez9gJWlcTStg4nlPLWHYN5H20dNqMcKDtg
 sgqehJe9I+VoFfMEBHqsOlMuImr4i9GufkMFDRx1Y1tO276Hk/wWVlrOqjt8Sfl9HrlHHvJ
 RWCmJFAYcIfVKouXWFyxqztHIySuEs//kZq3CWrwit3xXMWAFhZwpnb/iLfhqYj62XtNxxW
 oJSLh6S6CW/DM6S7GDt5Q==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:9tVv3i1dTRo=;TY1sbJ9+jK9Iu4IsjEmYxohd2C2
 Ub/plmOEOZc9Grc8iZBCXWKWwZ11Sd/eE7n4lwiMA4pSGppNvfV2n6UfMMy/CCBC1znh9da5E
 lb/w/GBoZ7RZmRscVWvDIuO6lOpVfxP0rUDXJx5sbfch6ncR0EgkF1mWKECpStA+KK2CK3JUL
 aVuyyffvQ1EdXKdNHD8izBy63HBqEtodh9bLFIJgZuBtztbni9ajpylwqmbX/rN2TGujA0uFJ
 6JFkrb4c7BAoWwlY5j8NtdjpBkRtNMvVa/yKlr9sD2vo9vOVq/Ze+46NSKpPf6dcyu/0yPNNe
 kUp2Y+RXvlJ2qQazTpTezA5uDQgLBeOGudWq82S4chesRwJGfn631g41GvI/1IWFyo6vco3S+
 gcDlHTPT3HCvpRoDdmssCb2Hgo9D+yVXDeT0RsnLEh2F5yoeSm+aMEc4G3AeaMCOyy5PJBqes
 +WuCfvEWQoVDPwbRleJJ1IQsWUmVWuYSiwXD1Xag5flfT1MSZU9FBqRXybQDjrtJUoZRf5LWy
 wtzKG97ZLFRkH9Zu60rhTPqFC2IaPIC8jSKU7Xh6OqG3wfyiee23Tp/863HYiwKkFMHaiIo7X
 yVTMsdnDyx83DsuLvrHcZ7QrkY4qb7IEuQ3mnmBlyYdyCwqfCikGCoxDgKuO6lJsDJGG2sHwj
 5L9T7GPUCMeIfiWsO1FbX9EscV6uGvAFfvGOXO0Mc3JGWadiOafUG0uf+YJC5Q4kmkxhPsqaN
 /OzHdHXQ6q12CGXE9ca4YLjHq/sX7gAB+YF8Tl7m6jMM8KFl4pWnkUjihAZ7xbctG0IY2Pzfa
 NK+Qzh/RN8Hfp0wvwxmdrMDkUFRQoSndXKvqJM9c4Lgo0=

The length of the policy buffer is not validated before accessing it,
which means that multiple out-of-bounds memory accesses can occur.

This is especially bad since userspace can load policy binaries over
debugfs.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/tee-if.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index 70d09103ab18..f2f9204b3a11 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -249,12 +249,18 @@ static int amd_pmf_start_policy_engine(struct amd_pm=
f_dev *dev)
 	u32 cookie, length;
 	int res;

+	if (dev->policy_sz < POLICY_COOKIE_LEN)
+		return -EINVAL;
+
 	cookie =3D dev->policy_buf[POLICY_COOKIE_OFFSET];
 	length =3D dev->policy_buf[POLICY_COOKIE_LEN];

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


