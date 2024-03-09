Return-Path: <linux-kernel+bounces-98029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DA88773D3
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 21:14:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 594DF281A49
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Mar 2024 20:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5457054BF4;
	Sat,  9 Mar 2024 20:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="fiU1ZcuW"
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A755753E27;
	Sat,  9 Mar 2024 20:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710015220; cv=none; b=RLQPHpdrqzpX7pGs2cR6/E5jKLtesb8MhQLoLDLtSH7+NXuFJjcPX4SLUoCdnOjHEKFPipvBQnhefZxkiD59n2HYNHxmTDFsjiCsKEa+BnmYH8SRF54W68vo3cuSsPxPq6zdzNSSjFyznMjhTIzWfs0hH5lkuQeXSIpEo7AJz+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710015220; c=relaxed/simple;
	bh=ahUYjYw8kA/+Bjg2ABTW2gzExb4Nrutf13nNb+pttWs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=otgYrAhO4+74i/BHADajgnWZuyGPpB5ZIakaJmbfWGyEC54CmT8ySEWJe2sQIbOnUKNb8sjECf1Nt75VmXVDYOe/kuQNATZ32X3bhwqLQO5g+Lvet1YbmGIzzDPIZTFNtyXGZVdOKNlPNJYfb1NB/bFpBtyDjRgNQYKQ9yLi2Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=fiU1ZcuW; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710015213; x=1710620013; i=w_armin@gmx.de;
	bh=ahUYjYw8kA/+Bjg2ABTW2gzExb4Nrutf13nNb+pttWs=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=fiU1ZcuWSgJQiDpNOxws8xnYWx5vZLga5v+tmHcajhBqhS0eCoiH6dRwXGg3r0kB
	 kMcEI4r5EbKbwgBNoIuT0MnDfUsNFFGt9sVFm9QCl/JKGKGR1Fhcxv2RzbPphxd5u
	 QeraAwCE20iYT0CqNv00KyfEdoKS0mj/y6XCoLVKuSAukdLGoTuPBpE9LlixctZlc
	 x+PKY5HgMiBbB6TU0z3OLZborhTYlIhqgBqBHhtlJM1wu25z+R3o1rKkA73Qes7kT
	 5f/6vq9c/pwqY/+ylzhmiMY+RF4ulDNFkkyk6tHUBpOaHQoABfJxUC68kSQ//lQFQ
	 QFlMSdbJEfl/eSJQZg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from mx-amd-b650.users.agdsn.de ([141.30.226.129]) by mail.gmx.net
 (mrgmx105 [212.227.17.168]) with ESMTPSA (Nemesis) id
 1MuUnK-1qsaoI3TUY-00rZzg; Sat, 09 Mar 2024 21:13:32 +0100
From: Armin Wolf <W_Armin@gmx.de>
To: rafael@kernel.org,
	lenb@kernel.org
Cc: linux-acpi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] ACPI: bus: Indicate support for IRQ ResourceSource thru _OSC
Date: Sat,  9 Mar 2024 21:13:10 +0100
Message-Id: <20240309201310.7548-6-W_Armin@gmx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240309201310.7548-1-W_Armin@gmx.de>
References: <20240309201310.7548-1-W_Armin@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ajxKF2sRDtuGSq8Evx8/nuKPIB5CoSQT3HMEoEAQCWoVsfKVSy7
 3YvlNHTq6SHsoesZVzLEVXU5qVskul9g4jiKm5jlWxm0TTYDptHKrFWkf97dZZf0LQjCBo+
 eoT/Giaoq0UhJNBoCg4hFo1hRQAtk+7kUN44eT7pxGQ5b2D54f9LSk8Z8Tc5XqyoFB8DQIi
 gef8genRqLdtuIRTxU/LQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:HCs6odhmgeA=;jlEKTmUZ4Hc0aXpEVkEpL4andRq
 hfCxjwGzEj4ezmK4WbIQjlswmlFyE1SQIltDLDL3RZy0wGjOCdG/D6SFiVd/WllhUkZpKXVx5
 D1lRBLY7tDwBh1bWSxZV53UFtZqDQtAVt0x/MRTzu/M4+5o/FQyddHAB9ZcjAvCNNY7nJV+GF
 OtBfENeereB/4jIa77hxpgE6SgLuItmH0qEjbbJ+Vh65XnwEeBT6LsgRI1w5mc7opdYlmsaCE
 DizL5iCvsJfY7K5mqcMvvWWCyWtyxVuhda+K8lqSW5iS4WriaIzXAN6GYyezsiUHJBnm2qnvY
 ouB+FNZok2DsNN085Vry6lvA7kdRmIwNSTOIRRa7szbMT+ZxH06PLs7CTlxgCde6BKepORpLw
 nvaAaVx+yyjXeV/P+TjARKl5kFN+BdBq49U+FjfkSkaMUzptKaFuuknpT0sKKzN5obRkGd49C
 CeGBHl6Z1g6ne3FO/KNNjwBNQBxcJ5SRNZRjmkziwIC4JhokFHoAYYSlEwZEtpU5ykhe6uhIx
 3c7mPQfSV5XpfYnu+b9ezH9f7RXyFBQNvGX2X49W9zkTxOOUiYmx1jXfgV1kObQQ972gLDiNo
 C/cVrmvNdAuN7O+TTfkA8ud3AiXm8e89pZHcVZracTZhPnH32eCLa5+YpcAq4YFDk+EXq87ez
 8yInDCxU4kMohes4udtIj2T/Mj63I1dx1+AYqPSGVOA2nMtqQZPinTBnwUJ2JuNJKysSZVqNr
 2R/i1eyASfw8aXGnbXczHFl2p4ABzdow0DaGEBxAna1//J5su01pLZJrNU6q+rOhT5MjBQrdf
 Kcbv4JD8pYw9f2v6dcX2/LoVLhs3yIpqxzBItbu7RpuBI=

The ACPI IRQ mapping code supports parsing of ResourceSource,
but this is not reported thru _OSC.

Fix this by setting bit 13 ("Interrupt ResourceSource support")
when evaluating _OSC.

Fixes: d44fa3d46079 ("ACPI: Add support for ResourceSource/IRQ domain mapp=
ing")
Signed-off-by: Armin Wolf <W_Armin@gmx.de>
=2D--
 drivers/acpi/bus.c   | 1 +
 include/linux/acpi.h | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index 0c48b603098a..a87b10eef77d 100644
=2D-- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -323,6 +323,7 @@ static void acpi_bus_osc_negotiate_platform_control(vo=
id)
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PCLPI_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_OVER_16_PSTATES_SUPPORT;
 	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_GED_SUPPORT;
+	capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_PRMT))
 		capbuf[OSC_SUPPORT_DWORD] |=3D OSC_SB_PRM_SUPPORT;
 	if (IS_ENABLED(CONFIG_ACPI_FFH))
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index b99c83968a9d..d62be29cf7a6 100644
=2D-- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -577,6 +577,7 @@ acpi_status acpi_run_osc(acpi_handle handle, struct ac=
pi_osc_context *context);
 #define OSC_SB_OVER_16_PSTATES_SUPPORT		0x00000400
 #define OSC_SB_GED_SUPPORT			0x00000800
 #define OSC_SB_CPC_DIVERSE_HIGH_SUPPORT		0x00001000
+#define OSC_SB_IRQ_RESOURCE_SOURCE_SUPPORT	0x00002000
 #define OSC_SB_CPC_FLEXIBLE_ADR_SPACE		0x00004000
 #define OSC_SB_GENERIC_INITIATOR_SUPPORT	0x00020000
 #define OSC_SB_NATIVE_USB4_SUPPORT		0x00040000
=2D-
2.39.2


