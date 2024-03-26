Return-Path: <linux-kernel+bounces-118305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2034088B77D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 03:37:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB42B2E7ADC
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 02:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8913128392;
	Tue, 26 Mar 2024 02:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b="shEsJcMp"
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04olkn2091.outbound.protection.outlook.com [40.92.45.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B43DABF7;
	Tue, 26 Mar 2024 02:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.92.45.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711420652; cv=fail; b=KKZYFsndFFAnPT7KKSnIrZ//RZePSyiffxPtvcD4htwTp+BTmKjL9XJ8nzBDWQ3AESJ7Nz4aAg9bOmtG0vGyABXWfRWuS7FhM396f4Tmv4y+V3KWuL9zX6+jVEEKV91SFgDlBraayLkPr4VgtTyo6RF4dq6biZHeVbx18ErLp0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711420652; c=relaxed/simple;
	bh=0jd371tw0u47S9i/T53T1Zk5GCxMsQrx6KpdfqtOipg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=crkemf+o/tv9tVa+zkRowRBm3NtcFmBgn2ZctTGjm2iUa5gALLPa3YYqp9HDC6bJPdcEXQIuC3zoD7pH+pja03p5rBNqgzJD2k2aNy4RiyPKg6Rw/vJTVQcmVdpN83xTXFUX2xs5jQX6wt9wukQ9e+kxhFcxhHeyys4/UB8F7yE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com; spf=pass smtp.mailfrom=outlook.com; dkim=pass (2048-bit key) header.d=outlook.com header.i=@outlook.com header.b=shEsJcMp; arc=fail smtp.client-ip=40.92.45.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=outlook.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=outlook.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RR2EXPv6eKauB6NoDvLsjsnJR80v/YfSNREMeBZL0GVGvUMJwgY2Wz2S9Gs0Z3s8+G8LXFJaJN6IUuWsipSpeGhAreRoI55V+8gz3lk4oOPYFVAjOtoQLATcebgiFB4F0edm2E1wYNfJOovSkJd+iQQKLqvQtxcmWWm1em8CmwPTYq60BHJ8QUE8Bl834gzfmGaoh09yU9wjsk5ztK8WuME3Mj2NaCv1aQhEU0zGHcT2YIVulQv1+iGLs8h3eWhnBhzemS/2d1V86yCYgEHRDJy53Lged0RFn+ul/bKFj+tlcG75fcqosb7oKWViyV7z89cZZJtZx4ARooJPFq+bhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qPkfA1Y+e7LibXvzP4jvf1Im4DAIZUKLWkuZCIZA4gg=;
 b=M98xq6OyvUL7IlkMuDneT27IhD0ecIEqlq1sOiXxwDpHmmhhZeWTF8l1k4qqWOOc/tF83RZFQuLAmm7R2tO9cp4Ik5pANWh9E6euMns8gEPb9gWc0n7gCld5QW3QNHO52cKQgNdD+1i3NN2omp074AuF1/Dj7AybQCNnEi516iS9apsZV1y21B++Aj+MoJnOflPHcKY7u9nGuc8oTQBSZyEYtoWyucpWHP4s4rbwp1FMsmxDYIJBx5qM/R0ak+OW1eQe5+CjX2HXTsJHF8QcEjsGI2h7rNbfVFpA4heADQ3KhEhJtOuXr0+pa5YPocM+Hh/elnS8j4XHmNk8/HTNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qPkfA1Y+e7LibXvzP4jvf1Im4DAIZUKLWkuZCIZA4gg=;
 b=shEsJcMpS5rhha6bdiLCCMhObWG24sCPQf/WaZ3RAZrvP0kjdjtbmJMsjgrLtNhy5h5M3notSO2ihRuzW9EGs+BOA2AeQJ5Zo1A8G+aJVYiq/E4N/I4aPaa0E2hj4y7wcaMleJKNkortHhL38buSfcJCSVz20x2ejdKcNPIhFe97PERp9w4pcOoDK3AYUMGl/H8CEBC+nKd8V8zkV272dmsgWi5dAGbs5PErccSu5ZG09ssTQS58OX2oglFYxPm/RX9XbbHxfksKPgTsYOLKOfEIA90xniod2PXDDSkwHVHWyEj03AgVYrz/IieSJbGwmv1iqxm10G7UFs+7QOnJnQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by IA1PR20MB5076.namprd20.prod.outlook.com (2603:10b6:208:3a3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Tue, 26 Mar
 2024 02:37:28 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::182f:841b:6e76:b819%2]) with mapi id 15.20.7409.026; Tue, 26 Mar 2024
 02:37:28 +0000
From: Inochi Amaoto <inochiama@outlook.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Minas Harutyunyan <hminas@synopsys.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>
Cc: Chen Wang <unicorn_wang@outlook.com>,
	Liu Gui <kenneth.liu@sophgo.com>,
	Inochi Amaoto <inochiama@outlook.com>,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org
Subject: [PATCH 1/2] dt-bindings: usb: dwc2: Add support for Sophgo CV18XX/SG200X series SoC
Date: Tue, 26 Mar 2024 10:37:28 +0800
Message-ID:
 <IA1PR20MB49530A43A81CF4B809DBC2F8BB352@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
References: <IA1PR20MB49537ED844CEBF19880326CEBB352@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN: [KdgOFASCdVlHX4JUf2RyBV7ALROlGPA8oKRKJmvoYyM=]
X-ClientProxiedBy: TYCPR01CA0010.jpnprd01.prod.outlook.com (2603:1096:405::22)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID:
 <20240326023730.381199-1-inochiama@outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|IA1PR20MB5076:EE_
X-MS-Office365-Filtering-Correlation-Id: dad492dd-3e2f-4608-61c5-08dc4d3dad73
X-MS-Exchange-SLBlob-MailProps:
	7J/vb0KDx3ghsXKwRy/t5h7NdWkXmzB0niMmniiG7D1xo02q7jSS/kaDB9wsScu4G7XNpLVI2ZO2z6JHRUAkaH5YKjnX7He71DBSy1Ak8qqSHi7UX1vEGXvNgT0USHNY6amLd2qyXEGWtEQzN4cGpXwJPoNK3h9UyX8Ntrl4ZcyH57Qna30J2bzzLrcFBaYjPmzin5QAJh2EzkvCOQ1StygBdX13OJQzVPCanMMyE6D+JBMkcn02zSyO+Y7lGbCyhNd/GSAavMGou1dnz8biXi8XZohw+oZ8OyjSzIwQNr50saCxubSfz3mVx1AEYzDDkEP7qe1WKNVGPbosAyWM3RYqv7NCMXqgIgSvXSnEsDDiME0JrOmbj2MaeTgg8B94OMSKcJWvwC8x+AIXS5ubFlXditz5M4gdPSmxyJuzP93uxB9uZhONCf8MypadnN0I3VHeBdCvj/ufk0i2E0O4E8XRorroAONtX0aeAJNX5TeNIBs004CvcUu0mKhpRapRn+urandaHYU84mAdo++jaIG1Xqls0pLyHzz7HIaz+o225Y20nGlkCfzxUm+enitNAVimMq/GoDvicn4lBKJmcEfF8KulNd3IXnDsEbwEMFWTbZF4FJPICIO48f+9DR9n1pzjeXLnitPRcxadxMPYBCDu2ubR+rX5k673SpzQL8PzEV8vnGMtrSWhs+ji6nT8GRsWkZRw3w6Vo4+4ppnSjBQ4F77YUeZSO1gC+iF4TXqjDfFkLXNaY4Lh1U6HcD5nSybMJsDMsP/rpvbMKCAlgRx2wrKoNmlEoWkmSO8Qo00=
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GzaHRlxAtcVAmWxmYcVkS9zHUu497FuJVuTAXaEc8ZqamLEt1z90wy17R4Ahh934EJ4RBkKZIVPvgmTuISFLAtcXmbQmpkkn5kNYepeK4avzUarr0DQuWgL81DRWqt85zAYkRzPxZU/COFs5A56w3DGEz4Ozi5q8myI3H7pZmYBWNzpPB3B6FMqG2zQZAK0GEkrO35uHioGS3dK5gyKlHIWR3ZtI6chtFLUvyEmunu1OKXkMDTddcVDujXP+9bOmzTYT7mxcpbK6dh73C7tKKNt7EZG7pKc0iKJD3DPdFV84ZWeA/6V2Hv/g+qgUjB0B3gLdbEnZDXDcvJY6ZTLaGMDgbjT5huCShke7NPJ0LP57/uO6ZO2Yduks2M1ixd2Myky1hrAALgPWQTQcRDzmfR3sHXTvDQbovG0CPFgiJ6nQeX7qEoCXQZlDcKbj2J8tICuNwhtT+998VPDmwBrADd6bpRYinEm0gKJh5qO8U9BreW2N+nmPGPaM17hTvdM2zJvnu3JuU7hiugs+4VLuJ+9Zfqrtf309D8WU2xLmMi3koCym9k9w3fxFNkyOr3teTKl3EzDrPw7pw+3NnTb0stcTq+DtSS3VCCtXG6H1FlBBFOejgTNeTWYJnDGHOhsM
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?356Re8LoyXFav/pvMALQNOp+nrjcwq6Dy1JHuMJK4Y3eT8rwnQJt+8gmnu8S?=
 =?us-ascii?Q?OCEp8VHNtCAqmszLmbaVJT2YFiUUA4vFGCvSzpNkpJMuqoHdaGmdWTo2aJR9?=
 =?us-ascii?Q?xxv6Gfxx3kfvlvJOW3qqMMmNRu221q45waKfu+b3rlu6qQtmHL+SCAcYKkSu?=
 =?us-ascii?Q?GysSjzpRau7hBS5pWf221B2jJDnuLSZwHew2UCQlUjES5S24Rr9uzFmPBE3F?=
 =?us-ascii?Q?Dwcf3fdww5OXZvQ/Jtfo+jswLKSXkD4hcePznzhntqUI2IeCUd2ylFR/+ftJ?=
 =?us-ascii?Q?iuGKJRgqqGHGhAP5WCvwDgohrq2jqtfWxBPfzuwEjqlfQ2oOjMmrUP3YOEvC?=
 =?us-ascii?Q?ZVJ651ADy87LYprC3TRkJG5gC0UhPYS+GRnRE2rJQrGrqPYku6ChjipSU0hc?=
 =?us-ascii?Q?E8pjjvm8XLmAQeZmxTHEZ8/untBKh1cpvAItmPOwp6gefjlf9Rtuwb7nO1Wb?=
 =?us-ascii?Q?+oZiUTrfedsH4pe6Y244/oYer+oCJEBrdAX9u4izoUIkaGaZcT8rDpQzfseD?=
 =?us-ascii?Q?7HDjiP22imchzoKAb2XfZ3SU79KVweFpbwTprV5UjQuX6LbMZdMijCKOsj4F?=
 =?us-ascii?Q?M7x8AokqJijQ3MwYVNKYTJGqOVEn/GZDz6+5nd3pGcOb5rt6pl2z8LD2BCEG?=
 =?us-ascii?Q?fRBoMZ+0k0Cypxu2CQAZJB2npqMxuVYz2PlVKoCNtMMDBwSsR9T9Z44a0lUw?=
 =?us-ascii?Q?hq0AjlHLKSzllehQUoJP31qpDkiqeeUW2UsZiD67mgBZFEKshqmc3sE2P6Yp?=
 =?us-ascii?Q?/kUaqFN41BtuY+8oRSVos+TSgr9USv5volXnTONx0j2bpZtF0h5VHlz+Y9t5?=
 =?us-ascii?Q?buoH9Y+mXHzu/jFQQeCz0/RZQ1UOhCgHwHW2BbeK3SEuZmaj3k9lHVVcGcTI?=
 =?us-ascii?Q?eHHeFBuMsVC3IR4as4SfPF+ID5+G0CcqvfAE6cxwXOxa8HtVsYsMVaPb17Pd?=
 =?us-ascii?Q?kWkgMIFMu+2BEXsm1NGl28QO5/0tRlRNynV1kds9x4tZMhq2CLZGGQQkcQIv?=
 =?us-ascii?Q?puQROq4KXGzW3LGI+5Ke75m7z6q48cjzOKjjzOmUr1p9ZRVE1tbrui+llH6R?=
 =?us-ascii?Q?YbgqAgjc6KoQoE3eiLSvZ//wYNj77cXNxcZBjqXkZ/yCYWL6E5PFXphwLeV4?=
 =?us-ascii?Q?lWWLCH6FFbuDx409WSrAU3XyHqfFO7BBtmvXV6zZ451sGwIBmL1XWQejNlHq?=
 =?us-ascii?Q?aPudSjJ72fxxU6bPfnSIlQOEcIEQndh0mLSzEONnBkzoDqzhsBJTDvCYS6VI?=
 =?us-ascii?Q?Il/83BlQc3owCm4iXnuV?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dad492dd-3e2f-4608-61c5-08dc4d3dad73
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2024 02:37:27.9696
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg:
	00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR20MB5076

Add compatible string for the DWC2 IP which is used by
Sophgo CV18XX/SG2000 series SoC.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
---
 Documentation/devicetree/bindings/usb/dwc2.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
index 0a5c98ea711d..9a2106e7b4b6 100644
--- a/Documentation/devicetree/bindings/usb/dwc2.yaml
+++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
@@ -59,6 +59,7 @@ properties:
       - const: amcc,dwc-otg
       - const: apm,apm82181-dwc-otg
       - const: snps,dwc2
+      - const: sophgo,cv1800-usb
       - const: st,stm32f4x9-fsotg
       - const: st,stm32f4x9-hsotg
       - const: st,stm32f7-hsotg
--
2.44.0


