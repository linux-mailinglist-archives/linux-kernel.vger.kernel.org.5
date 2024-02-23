Return-Path: <linux-kernel+bounces-78741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50AC861824
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ED62284718
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01C0C128834;
	Fri, 23 Feb 2024 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="LeW1JYd4"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E641112838F;
	Fri, 23 Feb 2024 16:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708706357; cv=none; b=qxfzJ5HBnjcSYAHu91y8hv7aZCiuQNJUWb9L+ppMloEG935GATCuuL6Porc2Y+HXQO1+W5klrIPKI4VhhiT4pxkyL8eP3cNoNy8dG5qYRtninc9ydW2RV1sp4seKq278MEe2UAzngcpQKUObO1u3udosR0VewHzHKX8F1lXsPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708706357; c=relaxed/simple;
	bh=wMCc8J1PCY8KB0C8TU2S2VGitU5uhYxb7pS5TWKpv/4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m0ywGQ+wYF/c5YBT3yGn4pJa0knmqxISxLYl3038cqoH/QZV/gKp2Au4RhGMLPzIfzwFA7p8C1GskKMYyFxSNG5ojYB9NeTztX51zhiG1Z7DDMlaHtGGeTslbBYCz4SPbF68TtxAoZZSTx/5tYB0Ny0cCrvGE7hDIiFO1cUQnm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=LeW1JYd4; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1708706344; x=1709311144; i=w_armin@gmx.de;
	bh=wMCc8J1PCY8KB0C8TU2S2VGitU5uhYxb7pS5TWKpv/4=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=LeW1JYd4sZeYAiv5q6V+9W1F7OPREwHsyP+1oXuEd2SaiJRuO7myQioMtDGAYi2B
	 4qdLV9XR3wspI8rAu9tQEzAfnpMFLv/stztJP/npHkrwOt4UXeJJgNDlt8Kw0oe8y
	 dA3PXqYPjb6VFZHCfYCxQ/R/z3YyY+y66Fgv3URpuJ5ChAor8mpbo1xrtx2yjF1go
	 6jzQCoCq/6HcW5US70Y6GVevMAytStgPoT82jL2fYVHPK/36FTkskUywHslNpUoBF
	 ZoJXfOM8yWSQZklUm2S1rNLRuXR4gJl6516Tw3hrHkqLMVcz3NdgXIz9jzoCOxKRP
	 xxje+Kz/hzUJ9F6v3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1Mv31c-1qmYRs2gwS-00r2Ea; Fri, 23 Feb 2024 17:39:04 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: Shyam-sundar.S-k@amd.com,
	mika.westerberg@linux.intel.com
Cc: sathyanarayanan.kuppuswamy@linux.intel.com,
	hdegoede@redhat.com,
	ilpo.jarvinen@linux.intel.com,
	platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] platform/x86/amd/pmf: Add missing __iomem attribute to policy_base
Date: Fri, 23 Feb 2024 17:38:59 +0100
Message-Id: <20240223163901.13504-1-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:g6CwP8ZbyVS4WMdNo0t7gz5el5M8L0xLzd/hWpAiC8OJ9LRzQM8
 Vz3TSxFE5BKM92JTfjUnWEh0RI+1DGljTOVADnhg64X9i44y7l/fGMX5WoO7JXZd+A4Kwqd
 vTiXn0aXuPscJIHIBEiPY3RtidWsnSZVGe86XvOkEFIR9CWUJRRePTjOCozOO2Zr2KCJovY
 kLPMmlbkOHQsI6S0WkUKw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:2aICjQ/9zTo=;MM8khOtZJ//pj63x0PsCKT0JlmC
 QWPXzZ/4ipsD84Q/qJLJ/3v0vvMNQgHjpx4UOWi3IZctxVHTJmhpkUNMvB5gYBYtehgBstN0c
 rDKa7dOhR1Fh/+c68RoiriFHleKmwx26cp9DAG7xlnyNRlbHz/bkqJ1k1Rvpxs4lq5Z2zpayg
 tfnfVNw6uOVmfPzb/xn4uVQxoJVJMmRHJrmRO6oIqMhWSKVDm/Zp5JMDqOB+WcccFvrUdtEzj
 TfMjAUSqO7kCrtL5Ngnv8fINP4UHo2/Viu4bg8XyzGM73wtV5Jv2cJgMJWs6e0uPnH+PcRRqs
 B0pIndmbs6dUGif2ECLVZ8bgEmpb5HeDoaC+eRdj8lF/+oJwdbrbzRlsbj/LVMZC0/ldeBjex
 2fSU4Ywri9rD+cINz68PcRW+6wWqC9kLCD4pDPtGfzu0r6mCQF+KkTbO4t87ZzfHKmvzcRK8R
 QoGkkZR+2W3wH0UTfKbfNlNOZ2QN71SgZpKzcfL5yC0LLD8yKAS8zPEVwrpfFDAgfIDKyz2Ru
 P6g/X9QhWSHTUbsHqHpS3rqEMHMLdqTpL6hfiWnUkHFKf4veGRjoBFH3klNwZwGOSo+TQERk5
 epCx+5TJIalBA+wBTaW0NgMNFgxp1JdXfwfjz/eWY4htc8INkc214WOUbhEnpL1rVea+GpCOf
 2FHL0zKjP/ogVAW2FcKzkaqe+CPmWf65FYIojkwXEAWflprkETDUPIfIUb7a2KObnyGPHPwmn
 Ga2fd0zYfnolaV7N38gGg5pvxvunFbMKTSs/JMyuF9cTVE0/eEX5P4ZH4OH81RWyuZWwXyaDf
 z3l4Fmb+PtNS+BiDCPWKE1a+Kos7m1byliKnesrJjn+ww=

The value of policy_base is the return value of a devm_ioremap call,
which returns a __iomem pointer instead of an regular pointer.
Add the missing __iomem attribute.

Compile-tested only.

Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/platform/x86/amd/pmf/pmf.h    | 2 +-
 drivers/platform/x86/amd/pmf/tee-if.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/amd/pmf/pmf.h b/drivers/platform/x86/amd=
/pmf/pmf.h
index 16999c5b334f..bcf777a5659a 100644
=2D-- a/drivers/platform/x86/amd/pmf/pmf.h
+++ b/drivers/platform/x86/amd/pmf/pmf.h
@@ -229,7 +229,7 @@ struct amd_pmf_dev {
 	struct delayed_work pb_work;
 	struct pmf_action_table *prev_data;
 	u64 policy_addr;
-	void *policy_base;
+	void __iomem *policy_base;
 	bool smart_pc_enabled;
 };

diff --git a/drivers/platform/x86/amd/pmf/tee-if.c b/drivers/platform/x86/=
amd/pmf/tee-if.c
index f8c0177afb0d..16973bebf55f 100644
=2D-- a/drivers/platform/x86/amd/pmf/tee-if.c
+++ b/drivers/platform/x86/amd/pmf/tee-if.c
@@ -346,7 +346,7 @@ static int amd_pmf_get_bios_buffer(struct amd_pmf_dev =
*dev)
 	if (!dev->policy_base)
 		return -ENOMEM;

-	memcpy(dev->policy_buf, dev->policy_base, dev->policy_sz);
+	memcpy_fromio(dev->policy_buf, dev->policy_base, dev->policy_sz);

 	amd_pmf_hex_dump_pb(dev);
 	if (pb_side_load)
=2D-
2.39.2


