Return-Path: <linux-kernel+bounces-116894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 737B888A4F0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11851F3D1D6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:44:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC43B15B0FC;
	Mon, 25 Mar 2024 11:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b="ajmH/3hz"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2136.outbound.protection.outlook.com [40.107.117.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88DB139561
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711364119; cv=fail; b=XstBHSDwI0LTlZ9wvnfeRNMG0XKdNq8EO9JiiA+ryQFljlahJ+n7/99Gu07AzSoGx6Sbs0j8WcMOIyHU8wEHiqganr78XuGxcLtlY6zuR+cnT0nuRgDiTZCziEfoPKwooJ96pjxl0X1/oFG+0cGsTNcyw2MQgXJ2kOkuCN4wAs4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711364119; c=relaxed/simple;
	bh=uwLAFG3YtlQs8DzdJy7AVwMYReJK/uIC2RWLXRef93s=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=CZx/o15TiAuqf9X3WwZjsExxU6Tz2oaf9wQ+/AKsqVV2hVE98SWKjFy+NdpVNY9a/2ATGa4Y0Ons8AlAQr4wWi5x703jiMmYZV6OSLqDQIpmfMbBN9opnJyInHmGIqnsDpcpY4KpSfTLr/DFJ3fpDpDGJ+0PsLLtwEkci14k4Mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com; spf=pass smtp.mailfrom=jaguarmicro.com; dkim=pass (2048-bit key) header.d=jaguarmicro.com header.i=@jaguarmicro.com header.b=ajmH/3hz; arc=fail smtp.client-ip=40.107.117.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jaguarmicro.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jaguarmicro.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZhQYOAKNOrXK0rc0gMC78ZzIQjzTnh+r++ctJJKlc4Iugx2FAGFxX876yExUUSzc/JFOJ5oDBI18vo/X/xfpRoRdsfEikfNqlAKXKaAcecoUa3cxgJAaduErhLW6uyYpDv9nGZ3T8LCfrBABlPLF80fNX+yhB5GKY1vnyvYaapt5SUTrcfmBQB1QqslnAzdZFywneS6vHuUEeKD7CKT8B3XNFf43sVMSJC835pN/mN2EABgJrLhqUBNbfdkrlMJfONtCcYK+BD0OK8oWTgOSPDeHF1arMdx2sLbndRSgTEnRlkH0uoejT2byScA25okNQLO9CAjFyQh22+2A/Hq3pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tG7VTbd0cEGa9QCWFI9+pgRa/zqNboFBoSDZAj5VLGQ=;
 b=MN1NeFjdsZxwBWjrq595FkFYKYe5UA/5jhdiX4xMkoNKGwKDCVGvyQu2YaARbFJO6euHLrcQ2d/0KaJyze4nCYyJxNeOcG/WdT7JJ7iFwwVcgUmTDw6FaUY/f6YcPpmBlrJYbG/jb8Cmfwh+CQL435Py9sG09OKE6lsSaUJPqAWNnq7wAIVuN/e7C6pwR6+yJS16Cs27PlZSj/NGAM1eGGDA+LSJmlqcKWe7u4PH/hZlIDhF84Sxr5b4yVy65J3GMOMTPg7i3xN+Nei+jFst2u04NqmbxC/uE6HDU2RrJ5dlEnZQSL1L9mNc7lCfEaOPPZEMirOwOpeXW0gkfwzOjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tG7VTbd0cEGa9QCWFI9+pgRa/zqNboFBoSDZAj5VLGQ=;
 b=ajmH/3hzt8gmRvDjwbdbMAI0waOJV7inCkggvML8IMcT6uZ1a9UUHc4A1kQLcEjfKbuSt9JTdnP0MjTELoFGXT8OxffgzYr+iLDQYkLnMav1xGLnAp7n9ldn6hwD0amlmRfMY/HWuNJiCI3MIlIZZNukJhKrLGG2mSJ4bazBjXKWU0ZE98aQF73/3eokaiN45CLybm9rAK2j0RlJ2GtXCFv8CztFXweXP4Eg41wEXSvPBsTJpjyuTpYAm198tMIlAqwGUIEZ3GjCDHI3AdQy4tl0kxGHTrkCmXaWM2Jz4CbXdNS8lM4oJgzf7msaM9q8chlsBkifFHZyD1pXp27C8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
 by PUZPR06MB6224.apcprd06.prod.outlook.com (2603:1096:301:116::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 10:55:09 +0000
Received: from SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8]) by SEYPR06MB6756.apcprd06.prod.outlook.com
 ([fe80::ce49:84ce:23db:8b8%6]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 10:55:09 +0000
From: "gavin.liu" <gavin.liu@jaguarmicro.com>
To: jasowang@redhat.com,
	mst@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev,
	yuxue.liu@jaguarmicro.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] vp_vdpa: Fix return value check vp_vdpa_request_irq
Date: Mon, 25 Mar 2024 18:54:47 +0800
Message-Id: <20240325105448.235-1-gavin.liu@jaguarmicro.com>
X-Mailer: git-send-email 2.33.0.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGXP274CA0017.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::29)
 To SEYPR06MB6756.apcprd06.prod.outlook.com (2603:1096:101:165::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SEYPR06MB6756:EE_|PUZPR06MB6224:EE_
X-MS-Office365-Filtering-Correlation-Id: dd3be308-a907-4deb-4c72-08dc4cba09a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	r/TvFwV47lGwADZYOy1byU5Z/LegKcHX8VIvq3UdH3up5E3pvgItlLJ2L4U5uvBAy+5YXfLLtfRbJZ0Rfc56h0YVERwiW8fFkIdlQPNM9KfV8w8yHOjvVroPwaMXjcsySNGNtNWXQBa7pdQC0FKRTPtHgvV5fjOdanuzp4q0e4zp62S8gAgFZdtfAaGy5uNsAaZQj1d1usQuWEnjZHFtcmR33HEt5sROzMn/8mAUPT8BNZ6SdYP77F+IiVV7Mk4HZWX34/le/LdKFGxz8ZwrP8GcA4RWGo9o6Q6Va8GuEsyOYDXOhiX6NpEdfEDGJ8N2B56BuPH0DdSTB2cM2IBmySzGM02WbVA9mtv/dbcacVrXjefsYqv3pCvjcXtjXTys9smwWvmOPE3N/0wDADt4Tnxlx29zx9G7TpW3nMqevl2jNfe33O/HGCeU884dE6MZtEmv2VJnqGE5ttE7KP7qBheK3mLx1ZGttEfrcS/F2+oojhMXb5UjGRnuBPjr9uLO3wwZ/9m+MGuQP80E2aC6Tu6mwKJSLxhr7iiYeLGBo6kZaUJuvrQyQ+lrlpdW6aO9++UVXV5vy23Wd9GJd43cTYk7Z3pqprZ61+O1+txaDYWn8AdVjFLoLOD6/528C25nNWtWRMua4n492PB4S4j3cjwhIup5TUl8tTSmrIiepMM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB6756.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?y6KI6QsVXoVIKaryFxdpuEgpDoN47pP4nZTm/UC140NNJdG2VEy0gXCNLaa9?=
 =?us-ascii?Q?GXpjSDkFR+bituhEx7IFB5B+TZKI5U9sVqoQzOSYwX4a/UCyJFNPR00cYpQm?=
 =?us-ascii?Q?3nLluokkLalcUZlG5QEugLLWGH3kVWJywc2HTUUMyqTJ7AYwm7C6BWDZJrNS?=
 =?us-ascii?Q?rZ3SrEGHjqyXhUAhooP+t5lYJO6qKTPfKjDAkERkAk+Ci6qNwVbQlOC4ok6V?=
 =?us-ascii?Q?NSvb+7t8sz3TaqaMw4bMf67B+yGCB9AxwYSP0+LETj3dJle4XmfnfH0pbc6+?=
 =?us-ascii?Q?6p7TrSxYXb5Gqg7dQ+7SeJVA0KWEl7fMfC9cu8LLsr9gYukpRQd6r0XssAfW?=
 =?us-ascii?Q?HJuB7rlxxCdqK0FczS6q/KOGDBE3oIin+nOVAK1VueM9ooOomw7OZmk4P/4p?=
 =?us-ascii?Q?g3b+q+le7+ACsSD4p2tksoedkSz7RuZVWkxcd/I1Nxtl1k8ASxazhkqZ4Tqd?=
 =?us-ascii?Q?S0dSJm6LL5fHk76cfGWTi4hvcOuWX6NNxG/ranA9sB1PDxDvkXKwd7IXh3Ja?=
 =?us-ascii?Q?l9kKq2/4zbrdy9QSBW2ePjvN4W+4l3uE5ETSdnzJUHuO/VlvBiEOog0gdfIz?=
 =?us-ascii?Q?GSjGlG+5gXg3XQamRrzeH81m5D6W2MODoINR00YuCK4Xow595z40F0cmKqnp?=
 =?us-ascii?Q?K+1lNd4gaJQ9+slEUv/57BtY9mMVbyVw0Y3eazjZZimhiZeBeTKxRIrZN6lW?=
 =?us-ascii?Q?SrijJS6GLJvgGGgdsc3QWRy5VrXVWcRFGSgrPCQOcrtUNo5zxENuFL608BrG?=
 =?us-ascii?Q?GMwoLY5d38mWatmGt2uA0h0LRJPO/U1rb4DBFgP4TwWEExLPhkmEZtnDFPXk?=
 =?us-ascii?Q?jlwovPCVXjTlho9JnqKPDo9Abmxi2K7FxFuS+yfQSsM9M7ivuqgTGMW67KeG?=
 =?us-ascii?Q?rGTc6a8qxcpXbS54dpZLcrNfZVZQPwgjws3BobgJlcE0CNXxxPiisVJWpfDE?=
 =?us-ascii?Q?wHhtObnhKcu1bTfzD9pjXi7JtiVGogWSUoilkfbSDZ9k3IQhKE3bpM72OpQV?=
 =?us-ascii?Q?lYmsnwXrveQsmHFMo1X5r4YJMFP9ARdTTmRdaAcyc7HyV0tiQ1voapY0kXEZ?=
 =?us-ascii?Q?tGb0lmbgl5JiO0rCJajtn1kTgZU/HAeJHv9cFy/IQrRX9XiMtGT/4edlaJPu?=
 =?us-ascii?Q?rdyd3WzyVgViNrHwm3mPYkjTUgL4qeFfU1hcRG6qR6DxTSL15WHbs+5YVcnp?=
 =?us-ascii?Q?yM1T4VOr/NBm9BNNiAnOpsmV61QoKng6viiiIcSwF5SKMjyk0amW9la9jHCt?=
 =?us-ascii?Q?GxsJ9sXGm+hNZwifXbr9D5ihNMTJGJ/c20wrxJYoC9bepJ+fq+BoBcQuaNVD?=
 =?us-ascii?Q?hN8JsNHxr+t/969cUlxXiRLZ0oqKr5ncUAdsG4MA3MpS6m4+6U9PtmbL6Yl5?=
 =?us-ascii?Q?N2ujNvtpfCNhGmNOm10BQpHbsvwmyUWKIlW/RVJXksuvy2pk8AWE9dDTugzN?=
 =?us-ascii?Q?9ji3AVRw2pxVcomyaHbmokiHuTueVXf0kfaoxuIINWvIGHkQWRop/8BF8lXn?=
 =?us-ascii?Q?21lIjb0H+sU6ZRfJS19a3VERaUV11ClJTV4UUIyxdZJSi+DSZqhF8Z8C+r/c?=
 =?us-ascii?Q?yKlpO3Ug7paxFU2MBUAzX3x5GfRXyR0zbbA717uN5d5jQQJDm2CcfzJrsxMd?=
 =?us-ascii?Q?Jw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd3be308-a907-4deb-4c72-08dc4cba09a0
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB6756.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 10:55:09.1516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O6x+UGY19wMo6saDZBHNV2ge66NrrtFkTr7LPZ2mVheONcnSKLP3pQx4HJkuYx53pcdj5EavX4jy9yinBNkU0UfBcQ8ed/wRj+YImLX7YsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PUZPR06MB6224

From: Yuxue Liu <yuxue.liu@jaguarmicro.com>

In the vp_vdpa_set_status function, when setting the device status to
VIRTIO_CONFIG_S_DRIVER_OK, the vp_vdpa_request_irq function may fail.
In such cases, the device status should not be set to DRIVER_OK. Add
exception printing to remind the user.

Signed-off-by: Yuxue Liu <yuxue.liu@jaguarmicro.com>
---

V1 -> V2: Remove redundant printouts
V1: https://lore.kernel.org/all/20240315102857.1803-1-gavin.liu@jaguarmicro.com/

---
 drivers/vdpa/virtio_pci/vp_vdpa.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/virtio_pci/vp_vdpa.c b/drivers/vdpa/virtio_pci/vp_vdpa.c
index df5f4a3bccb5..4caca0517cad 100644
--- a/drivers/vdpa/virtio_pci/vp_vdpa.c
+++ b/drivers/vdpa/virtio_pci/vp_vdpa.c
@@ -216,7 +216,10 @@ static void vp_vdpa_set_status(struct vdpa_device *vdpa, u8 status)
 
 	if (status & VIRTIO_CONFIG_S_DRIVER_OK &&
 	    !(s & VIRTIO_CONFIG_S_DRIVER_OK)) {
-		vp_vdpa_request_irq(vp_vdpa);
+		if (vp_vdpa_request_irq(vp_vdpa)) {
+			WARN_ON(1);
+			return;
+		}
 	}
 
 	vp_modern_set_status(mdev, status);
-- 
2.43.0


