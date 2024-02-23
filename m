Return-Path: <linux-kernel+bounces-78742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F09A86182A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:39:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 41E62B23706
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFE412A167;
	Fri, 23 Feb 2024 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="Fz5UPeMu"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0715C82D74;
	Fri, 23 Feb 2024 16:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706359; cv=none; b=MK72e0ocHaIY4fXKj1xVfxLnS1deeoMYxP2JapMxxP50XS6JuLgxsthyBRa9DCkxEe+W2IzZRkd7EHdkDhBsN57UoEgw6QHzIybmbdSrNg2D4m5NzOQ/NHN+MCtWeNA8z8Eq06lxqsakfgW259IZgREMBcY3CuJCXMB2uCtl5Jc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706359; c=relaxed/simple;
	bh=Tp+JT9YYfHOzAPbMml4VpkAxfEnq7R4BcbZtIE6tpTw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZbWF+rFdcq3J1OnGmG+DkrITshtWUDuL5jgB2KXUIQFKWF+SW+oNvLz7pAmUeUQfpm9ZcIaapm99+uSpOSI0Yp4/45z4pQe236lG3qLmy4KZGcq1LYqrKQsbRCgx7QGLDyR5UPfjOplQiminfuLdVVwxtd3exrFJx8OWNl99j0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=Fz5UPeMu; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708706347; x=1709311147; i=w_armin@gmx.de;
	bh=Tp+JT9YYfHOzAPbMml4VpkAxfEnq7R4BcbZtIE6tpTw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=Fz5UPeMuXNv5QzNDMfJu4x4KNgOMzSN4Vf+BmJ6usglyr2bIVcVKMWjpOWkpCks0
	 fI1b9G6AayYpueC56lRyIDukxB5s6REyzi5E0aqmsP19xnNeHE+29W+xz0c3D0z9E
	 EwUEsPPYPUEWWzjOZ5tTq5kcTWXALp7qoGNPatudUSaSJg1xvAC6cgTeKEZ2KalZH
	 7EXm1123v5yDqYBShezn7fuJWeOocNi4vPdmvZkpESInm7bn8Iw3qEK38GZF7Qen4
	 fBXIkGcv/UB8ljb0SlAookmEeIjV6TKgbn3MwTbLgRsKqjdF9pbIHsF0jC7Um/hga
	 nwja84hPH/dVz2m3FQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MvsEx-1qoTzY1EyF-00sxUm; Fri, 23 Feb 2024 17:39:07 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] platform/x86: intel_scu_ipcutil: Make scu static
Date: Fri, 23 Feb 2024 17:39:01 +0100
Message-Id: <20240223163901.13504-3-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240223163901.13504-1-W_Armin@gmx.de>
References: <20240223163901.13504-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:lTG5s8N4IywScvenWJgM5TMMrBm9ZKnIeQN06JuVGNny2sW8kex
 kWoqwXNAWyFVl+CPrC5FrHxJ16MxancwqIfVx0jcbgO2VZLiQTqxVM2X/25xvsQ+Vh87gJj
 P+AOc4ZytxvkRl7/eKq6ePewBL7xIZz/1+XqDgl5AjSkcFTk3wK6hT2GGD+Mg3QbKQUaYer
 DHy+BaoPrSJ+vSCC8he7g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:kE0PH3YImSY=;+aTDFTGVvwEGGX00nQM22OmknxE
 MgbFC2VaFcSUlCbkvtz+EIhWQyx8IGfjDyIIB54BuDgEHlk+N6jClQnvbW6JHm398WFztdElm
 AsQXmC380Mo99lxUpx/vZI+aL/dvMoJRB57TV/72ze3FN05agFr5gfcPAMFMDkh6w7imXMuas
 E7VqE1JRzFzC6MVreFbFqgFQcYWpPPp/GTiKnYCp0yffecaU3kVQKE/v4J9RbB764ZrULsnEI
 bJu3CKhZstdz0RG2ezgMkLmeXbpYLAOE8uLiWfyEuxFSVyh1dtN6ygGEU5Ah5iCoBpHy2bZ9T
 s5CBIr7OFIpjmpAzpJi0WCLvllXmTd1Q8Hf8ICVjTH2Hiuj8NLP1vKu9WP8hNCbqf3zAuijjI
 62gmsO9Ro1nywLTSTQMaC39AojvCsy2KNitysm+CrTjqJo+eIWNTq9b38jUFAP5U84yfMoFoF
 Z6SpgjJf9C3edIctcd3q1a1/8mg5rBo4xKxT92ejzNPCKj9vyA9bhuo2o40mSrT8i/cWWuDbC
 ieBRVOh8m9n15Ju5r9HLCEoys1rz3vCdo/XtOC6Bi6TDAqhCQysmrCJoHXDf8Bjp11BbBF8Kc
 nV8B+0uIUD6GogbGFw72ipK6iJNNYXZydnSi/D4gXIDlei0Kln4YboymSV57oSA4MxkaxXoOg
 J0KNw2YEwfoZ4ZKfeTxur5EALLjd8MMpsJ53jw2z/WaC2dd2ZfIKbc/Np5uwR5CHtuG8CJMa6
 5zMhguwQgJV8Nv2rhQ+aj3/wIQVHP1NUa5fjNANk9K7X2Bx8rJgPOyT2fs5F46Ac+bnmx0pkP
 Uq4xwvJhDKQanZRGwGIOocScA+WSpQy3o3/Aj+hHxaUL0=

The variable is only used internally and has no external users,
so it should me made static.

Compile-tested only.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.=
intel.com>
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
Changes since v1:
- remove Fixes tag
- add Reviewed-by tag
=2D--
 drivers/platform/x86/intel_scu_ipcutil.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel_scu_ipcutil.c b/drivers/platform/x=
86/intel_scu_ipcutil.c
index b7c10c15a3d6..7d87cbd4b9c6 100644
=2D-- a/drivers/platform/x86/intel_scu_ipcutil.c
+++ b/drivers/platform/x86/intel_scu_ipcutil.c
@@ -22,7 +22,7 @@

 static int major;

-struct intel_scu_ipc_dev *scu;
+static struct intel_scu_ipc_dev *scu;
 static DEFINE_MUTEX(scu_lock);

 /* IOCTL commands */
=2D-
2.39.2


