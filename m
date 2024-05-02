Return-Path: <linux-kernel+bounces-166514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D6F68B9BBC
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:39:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EA961C217F9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 13:39:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B586013C673;
	Thu,  2 May 2024 13:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b="jwSxetVz"
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7B013C683;
	Thu,  2 May 2024 13:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714657141; cv=none; b=TVWk3Qmhi2Bo2o1YjJpXTeTNQZILYt94f/xrMschJI7wWSysatHJBdhx6H2elcwnDAyrySz8+TUDJ+ZH3QDxX7W8cJXFbDE6Q4J7jzJHPcV+JsUo+MPtC6f8iT3R28oxwZ9PJAIVBDsARFmwSRyuU7YjXZzC/o2VpoABS3xwMng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714657141; c=relaxed/simple;
	bh=GlzUyv7TeS5tQNfn+8AH834Lccwh+Av25GmzBQzZ0q0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=B2VAXB7b1bpw/OKzD4Jyls8It5/K+Re8qKruRfmwhJC556/gn2AaN5u/ODrX1rQ8qiHaQQA3+Kd9Rq6bCTvo+7Ave1+QA/SLG4BJyKEgyPMlUw+sECFqoTwzPy2mztUdbrczIq6ZICHheo0eG/E7Ra1qUk4wtOOKAi7MJ8el+6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net; spf=pass smtp.mailfrom=gmx.net; dkim=pass (2048-bit key) header.d=gmx.net header.i=j.neuschaefer@gmx.net header.b=jwSxetVz; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.net;
	s=s31663417; t=1714657135; x=1715261935; i=j.neuschaefer@gmx.net;
	bh=W+m24AKIXaW9TRJJVqYE7PZW+JDIoHU7gSnGnDXrLBU=;
	h=X-UI-Sender-Class:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:To:Cc:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=jwSxetVzbP3m3ZivRB7NLRITl6q2TgXvfklok3pIunP/9yaTutES918i1YvlGwuj
	 CR0Pwtne5Wp627b1DtI2Q+JoQwSoSuYE7LgbrXSWqlqiKlIJhBdrkZZa+NX4orued
	 WrizizHCWjwjcYxvLwXcGYCIUG+norae1D2PBa9OIRuDOdHlNUcN0hPdxK7P6X+y1
	 aRmPCysnnMZDFkJfvtFXjE3PiLVWk1AL5kkZ1FiWCT52e7MgFuo/n04Xbe5kxiKs3
	 RSdNHhMl0TeBk5S55Is56RhLPGmyLSah3cKmcSNEIV9xhjcGZN2dgc4p+WRKoxma3
	 CoBaad8AcbQj5VozNA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from probook ([5.145.128.125]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MxUnz-1sqlks0XUH-00xsXx; Thu, 02
 May 2024 15:38:55 +0200
From: =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Date: Thu, 02 May 2024 15:38:49 +0200
Subject: [PATCH] alpha/sys_sio: Add const to irq_tab
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Message-Id: <20240502-const-alpha-v1-1-b1516c267c20@gmx.net>
X-B4-Tracking: v=1; b=H4sIAGmXM2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUwMj3eT8vOIS3cScgoxEXQtLCxPjRKNkM6NEQyWgjoKi1LTMCrBp0bG
 1tQCqViRuXQAAAA==
To: Richard Henderson <richard.henderson@linaro.org>, 
 Ivan Kokshaysky <ink@jurassic.park.msu.ru>, 
 Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org, 
 =?utf-8?q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714657134; l=1365;
 i=j.neuschaefer@gmx.net; s=20240329; h=from:subject:message-id;
 bh=ZtsDt+F77FgKd01Vi9O/7bLqLlT8yhHHC+4b2uIyCpI=;
 b=Gco6+LeS6NTbL4WLuZBXYffFA4JK1hUGxnXteiSwHHiCUec9tSzEeGoxJMl2dzHXtQYQbcmw1
 16mSkjjU4X1BNdpsBpbwZ7eX/n0puWvuIYK5J785PBGoo5Rgg+AX6Rt
X-Developer-Key: i=j.neuschaefer@gmx.net; a=ed25519;
 pk=NIe0bK42wNaX/C4bi6ezm7NJK0IQE+8MKBm7igFMIS4=
X-Provags-ID: V03:K1:y886ktDm7CjDrx2v5yux/pdGaj+qQ2TDm+x11SlYZ0FxjDmQlGH
 n+uQmqDeyyjIrS25np1fk2BMYDRx1c8jhxHX74JEUT3UX5nL3z+FmrhFEdENWuZNK0QVRkP
 pY8b5SWJCjSjbm5SBLYW+b9ZOSQF9ERIcLYUsDPQzZcWmoCEnkpwQN5FZuCyt9C/24sFOzZ
 VmruamBskql/WsPB0la8g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:CYD+LLiBvzo=;K0HI5TzlwPDB6ouhDcSCc6GRkG8
 zMeYh2J2X7/JmJQgWw9L3TlbKHo4R5OQubp3cXpEiMlA7GNgqQyytd0jBfXyvpH9V/ZpP9EIe
 LfvQzRS3QzqARE54YKXPSZKjRfliI1IpHHkYMqiFz2swrb2EobyLdr+9RoZvOQpFBIB73OEQC
 HjWbHZZmlDCaatMuReUnpFq/7WTkuP3ekQs2pWFm/uBucx8FHEZ8eaQULH06o3rs/UQECEJnE
 YZmsKjTP/WyQSUSBgvA8TCmQ5iK00N/ojQLR1hVV6pLZ+5krj9f+Kqhj0SO0B+Atk/R0S5NAr
 5r3BmKEwJq1bJTBT8bIafli7facvFloTRRAimfKQGhXQxFZ5u/ijr24QfIcjYv7sosxgaZDSy
 ZvULdN5Hhi0n824duohH8Yz2SXbtSQj5nXOFs1zy+sFxHNpZ/q0iNnK9qsNkC0TMR1pc5jx+g
 mWvqQmi2ojTj8/S4cteARJjSgmWa6ikWOdo5XEA9AS1jHD8sImr931fBL9cuEj3InXLDKRu9D
 jPzAeVHD3Ao9n1XiqtB1mDl3kRE335UrpLX8Mq1kQhE/JwTB55mIcLhx7sNsx6YxrsSjG/K50
 dR+tKWShlNnEEeKC6xAanr7no3LQGT+YM6k5V3GK42+uL/GAHw+C4RqynyarekUu0FBuGk1xQ
 W6KYR4MucLHhV5JSjVj+ev7TNWGcVfZBUJk8KyTWjcr09NKq5RXDugvv9N7E8sz7DhtTciFpV
 u4gthwl8PzAlJ8MJ1CQTJRDXNTNvp2NnfB9u1ajQ3x20gsEntGEvZY5DluswPu9PxaIv1xE0m
 u1xs8CwPBogcEZtK2ndYqw6NHT9kbWAsZX1ioKC40W9NQ=

The IRQ tables in noname_map_irq and p2k_map_irq are not modified.
Make them const.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
=2D--
 arch/alpha/kernel/sys_sio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/alpha/kernel/sys_sio.c b/arch/alpha/kernel/sys_sio.c
index 086488ed83a7f4..7fbfde32dc27f2 100644
=2D-- a/arch/alpha/kernel/sys_sio.c
+++ b/arch/alpha/kernel/sys_sio.c
@@ -183,7 +183,7 @@ noname_map_irq(const struct pci_dev *dev, u8 slot, u8 =
pin)
 	 * that they use the default INTA line, if they are interrupt
 	 * driven at all).
 	 */
-	static char irq_tab[][5] =3D {
+	static const char irq_tab[][5] =3D {
 		/*INT A   B   C   D */
 		{ 3,  3,  3,  3,  3}, /* idsel  6 (53c810) */
 		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */
@@ -211,7 +211,7 @@ noname_map_irq(const struct pci_dev *dev, u8 slot, u8 =
pin)
 static inline int
 p2k_map_irq(const struct pci_dev *dev, u8 slot, u8 pin)
 {
-	static char irq_tab[][5] =3D {
+	static const char irq_tab[][5] =3D {
 		/*INT A   B   C   D */
 		{ 0,  0, -1, -1, -1}, /* idsel  6 (53c810) */
 		{-1, -1, -1, -1, -1}, /* idsel  7 (SIO: PCI/ISA bridge) */

=2D--
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240502-const-alpha-89843a2c62a1

Best regards,
=2D-
Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>


