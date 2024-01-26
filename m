Return-Path: <linux-kernel+bounces-40052-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18A1883D978
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:37:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E905B2806D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9A8F16428;
	Fri, 26 Jan 2024 11:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b="FZ8SciCW"
Received: from KOR01-PS2-obe.outbound.protection.outlook.com (mail-ps2kor01on2108.outbound.protection.outlook.com [40.107.128.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E79CA12B6A;
	Fri, 26 Jan 2024 11:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.128.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706268933; cv=fail; b=Sdakwk24+J7ryt2ziUMU2Iwjd5lYraMztzj0iAlouO2pXaf2Z4LbGaAMxr0lar7I2EFLCxbQN350K8st87fWjkblpIKPI3ygCEXmqXPxI73y+RhSJ8zgmVHPzFWHnTal2fIe4cJA3uSW2EJWPWyIp5neEQaatp/e6xFwja/ZtfU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706268933; c=relaxed/simple;
	bh=bdIa2yvx+dLbIR8UDvpkpkJfpYf6xV84fIogA+cm1ZI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=TRW3r3+DqBPkEBmb+e4h3XvjmSSn05wngcI5iEcwGAS4ZEroOGpCM87RpPks4TYtwqZpcjCexE/M0LP0KhqAlo9s5XfzXcw6dW1AY9pTgiG49NXIWUnXeIkAkQQecoJOfHoRoR5oUeHulCQNSaswJ0yXkxCTW9T45Xm2ZO3QxFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr; spf=pass smtp.mailfrom=unist.ac.kr; dkim=pass (1024-bit key) header.d=unist.ac.kr header.i=@unist.ac.kr header.b=FZ8SciCW; arc=fail smtp.client-ip=40.107.128.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=unist.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unist.ac.kr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6CjdXrMCv3kLg0cTBLDMfpc9iHsjcjLBpnCqC8u+Pgj655WAeIQm7H32CBAohVH8eiNgzSHg80cD11yPY73Htqck11NdtynO26kMBd5ReLJyiVKmn8/NUUBkk630L783HR82geGlpXZvbpWJLpBSfy3K2vE7cnGEqGqyZbas39eDMS4CKe1Tj6Caqsc015Yxc9I0LHb+nNnF/Xn1fYYwA1BKoWaqf8L6ZUsL7G+vrlw1q7aGb7r+8OMfORL8MfM/53rmHujHS6pgxq9mbGZ5Rm0BZtMQEIJdnjdIKp6svAUJpL+i4sce0leiP5FEotJ688mYcJANEdWM+TiOw3XLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQ4usMnnXmIaD7FxO5lcs6VJ13L3Pz055bEvYfOZiEI=;
 b=XT34vCZF2PUJ3cw65HTxHyqrY0tBacF66PyeCxeVgfbGw+qnppSHJ9AQT/W0wX9BDJYlJWX2PPZ21WzBybMFP9ijwwnVWEb+0E9sh9X1s1A/uFVjwolBGjDbhs6FwHsbvPSIiNah33kn4cPQ/1m0OEtT7iTkNB4X2bxrrkQY6CYk/2y4/66/LsrSxgLhb8nR+KdrtbcMtuWbS013Su/1Q1BfekYuYltVbyO/edeSl1jR3W/E/8rH3O7Srg//znb3BEgOMUMdcXyEhLM5v2nrVw6y12eYKsu9BAkLOprKPf9APHjOY/uERd9wLF6xZqYB0UbMFrAt14fJBPl1qbwTEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=unist.ac.kr; dmarc=pass action=none header.from=unist.ac.kr;
 dkim=pass header.d=unist.ac.kr; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unist.ac.kr;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQ4usMnnXmIaD7FxO5lcs6VJ13L3Pz055bEvYfOZiEI=;
 b=FZ8SciCWKJ/lFlwKLgdZfpm3OMPh2CrenlxkLHGN17zlE6jBk1BAQrAO7UjgeVlPmxKiOnlhQr2NwAiBBWD51CEYdX/ljN5B0AkqxI8JbzUGFGwB/t4LcdBYgw33mlYYHzIgDtF/sbdR+0xpxRuFWTG82xKRGrgo6AN34pPb3oo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=unist.ac.kr;
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM (2603:1096:101:15d::5)
 by SE1P216MB1843.KORP216.PROD.OUTLOOK.COM (2603:1096:101:f7::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.27; Fri, 26 Jan
 2024 11:35:27 +0000
Received: from SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c]) by SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 ([fe80::d365:3ee8:ce4d:c15c%3]) with mapi id 15.20.7228.027; Fri, 26 Jan 2024
 11:35:27 +0000
From: Ingyu Jang <ingyujang25@unist.ac.kr>
To: jejb@linux.ibm.com
Cc: linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ysjeon@unist.ac.kr
Subject: [PATCH 2/2] Add error checking and returning for transport_register_device() in scsi_sysfs_add_host()
Date: Fri, 26 Jan 2024 20:35:20 +0900
Message-Id: <20240126113520.1356491-1-ingyujang25@unist.ac.kr>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SL2P216CA0100.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:3::15) To SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:15d::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SE1P216MB2287:EE_|SE1P216MB1843:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ee3b9f-34b5-4419-6d79-08dc1e62e4af
X-LD-Processed: e8715ec0-6179-432a-a864-54ea4008adc2,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hOEdqsBnTUgLd2vZmJTlAkG1L6HOEicEYxiQvb4EEzgxPa30fn8QmwE1vCclVwVKyCkqNK1Hxub4NrcxzZlb1ciulmqUC17X20G0dFTNQU3B1Ba5RR9XPInFDvM8YNBLOUsv08niuhGBcwW7QiTSn9Dga1h5Gbll6K3i0Hkeru98pzWOLqFzdaybf8wzRDjTvovWAB9BXHpkhiUHcljY7vt24ArSn7GIkNq7b4QPdCT5zZYlUMp2ab93jEpeqEJAlcHKaAC1NpXIPK3YSWy2LZTxGCaWjqKtkfhjuqdomihFjlTG3W2UV2yd0U/QqkxyZUKEF1H67fyjkKK5FzIweb/EaGKShyMraEBFe6fftqkAYaV5mlbTKb3Bkv6H/VFvkuXWUwPuywBpx/RijK+aU6TSn/sOUrCgc9KcG84fctyeDwfxuPIUD4lk99ldpaKav3ATe/Dhn6wGSATacujv5FBvzeu2f7FY8dhTZVGwg7k634OE+0jRDghFwm4QLxAf4d68m8r+f3vUtz3flzbjo1wRn4R3jhW0ZKfl0ct4QjlLopIOLI2vqG7JribIzJ44001zW8/Jupoh5T8ifss1fhSAPuU42Kd652sOnqiKkMtNbPL53wVqAyfB0ED4IX2f
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SE1P216MB2287.KORP216.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(5660300002)(478600001)(6486002)(41300700001)(6512007)(6506007)(6666004)(86362001)(26005)(52116002)(6916009)(66946007)(8936002)(786003)(66556008)(8676002)(66476007)(36756003)(316002)(38100700002)(83380400001)(2616005)(1076003)(107886003)(41320700001)(38350700005)(4326008)(2906002)(4744005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZDVpoOg20+TiaF2lA0TMpNwhI8XSkzLlhMxEkuHQKfXiVcLsu8y4q6Znm/1h?=
 =?us-ascii?Q?DIJkZkTclEabGCAs8N/rZgMHwRRA+HKRqgt5pmgPn5Rc9WyuA5QTIK2dfne8?=
 =?us-ascii?Q?9Kw8ZNzg7wec7lLohGSZ95hDvWW67NNBCgcyKRt4UtFnnE1WyMTtEahrP5Lf?=
 =?us-ascii?Q?boQBqMSsoT+vciyqFfnWt9tT6YeYxWPSmZyMEeMj4hLw8f4v3gNAlVAtHSX0?=
 =?us-ascii?Q?wk6g5d5FJt0QCbwd5ISi+5Z1ovdIllLDQxczJXkQ5NsbfbZYIZLDZRjVTdgu?=
 =?us-ascii?Q?GK/NqS0eRXEmmwVyrpuWP6Fv1ZFa/nEuLhjDi27wwwCMo+bRll2y6DQ++Uhf?=
 =?us-ascii?Q?6mtm01OoaPhUHjyT4Duhnpdhwpl+V3iSSFu0lTtqBhZZP5ik6+3774U/69Ox?=
 =?us-ascii?Q?fgO7xD5GY8rlpJHTkKXR/wJbMmWaqJ5dOBdNjxUNiKAUgudMXSAqjwEZt/Gd?=
 =?us-ascii?Q?EgNdy9HufYcbW3AU6vsbWEvmXKgs8AI0Fe+B3uz9m0hOYPcpLxtfseQnF6vS?=
 =?us-ascii?Q?jiwJQkxORXnQnAuPJ1Ny8E1o/z9Rv8w9HxM3ETcO3ig2pSkqvGQq0bxUNCZV?=
 =?us-ascii?Q?wRQse9RhgzyS8nXQsTLWPjHrz3K3Vus5Qub8NQjpA26/gbNssJLuISdFrv+c?=
 =?us-ascii?Q?iMwyIGiNhO+0cJ3FPoUwsCLudo3Nj8OFqYWdKbODDcgxDjKXK5XtZELBLDCW?=
 =?us-ascii?Q?zGu+oKpuTdHWJDWrk8vP5AleDc0qq0qZeUD91FakKbXNPssTPjMmqF2+330M?=
 =?us-ascii?Q?yclsynDKVXsvpILVUa2BxW3Mp4rXeeWmCODsYR+8c2fOCbNk857pHEhu9Vvv?=
 =?us-ascii?Q?cXwtKmUeuU8bKl/Nh4vcmmqWkUcEGIqx4rj5qgJNCPvZOAw3Y0R+L6gbwse1?=
 =?us-ascii?Q?kQ2veaDM+4sIoLEdGBlyEjqeeg7pD+iZJ0UNwqCuBjT0+O1pyOltzBV9lKhr?=
 =?us-ascii?Q?bpxzFpkdbGK4dR+DNg2kknH/KCOxQmsqBlJv6Sqmy+IhjzlCpHJOVjBXXujX?=
 =?us-ascii?Q?lbSFQvrV4RaMZgPzVMcKBGuE84q2vpsG+zkNa+3qVordrIAqo6qz0soxdMLe?=
 =?us-ascii?Q?6Ww+0ErFzZZgb5XziHVmAzXcoqdpa2nwnJx6018w4Wtasf0B/rNyaVE6G+S/?=
 =?us-ascii?Q?LoI2KCmkPUD3YeQ+60PhtrguSBd7E3JurKKCnERQZFSsnm1eCxc67C+k4NXN?=
 =?us-ascii?Q?Tb7MbaQZBeiNH8PPmAOTfLFfpWZ2z6XHkojt0TEh6azrelWyeLETAVrVE+r8?=
 =?us-ascii?Q?Amwdyp5a/60Cs0gyLSzEIGStj+vXwQ9wBdFRZLVQa/kg/HAFj3ySL93PIxb2?=
 =?us-ascii?Q?qPWZ51Tfs/6KNboEzU2PeSqeqx2SaJdKpgs0hxADmXdXMcPItkfuK4Por+0N?=
 =?us-ascii?Q?ZJqpSBK2d7C/H99HJBjUA4hzkiB4FU9UUdPPzQtsz9awUh+8r+Nai0Jsadp5?=
 =?us-ascii?Q?8p5DeCDZU9i2JR/0IcT75SRktKZ2dOudI/iOd1i3GwfBSLbL6hZVzaGnTWuT?=
 =?us-ascii?Q?9slxmtiPZOcrVmlw8YKudhKJQFhAu9kAsvoVHfRHRrk1/garIQ5DVu94UtUh?=
 =?us-ascii?Q?dBi5lwIR8qUm92gNczu1ED0W5GnIetuiM+CcZe5Q?=
X-OriginatorOrg: unist.ac.kr
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ee3b9f-34b5-4419-6d79-08dc1e62e4af
X-MS-Exchange-CrossTenant-AuthSource: SE1P216MB2287.KORP216.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2024 11:35:27.3427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e8715ec0-6179-432a-a864-54ea4008adc2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ksQHWhZyedUjR49LwVMFEnBgyNXEoHIbFWHbgahxHVVGg1aBohrAXPfdMkI1IOygMorHBQ7TEyoXtnzuqFCC2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SE1P216MB1843

The function transport_register_device() can return error code.
However, scsi_sysfs_add_host() currently does not check return value
of transport_register_device() and always returns 0.
Also, return value of scsi_sysfs_add_host() is
checked at drivers/scsi/hosts.c:307.

Therefore, this commit adds error checking for transport_register_device()
and returning error code in scsi_sysfs_add_host().
---
 drivers/scsi/scsi_sysfs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 24f6eefb6803..1a322fbd420e 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1621,7 +1621,10 @@ EXPORT_SYMBOL(scsi_register_interface);
  **/
 int scsi_sysfs_add_host(struct Scsi_Host *shost)
 {
-	transport_register_device(&shost->shost_gendev);
+	int ret;
+	ret = transport_register_device(&shost->shost_gendev);
+	if (ret) 
+		return ret;
 	transport_configure_device(&shost->shost_gendev);
 	return 0;
 }
-- 
2.34.1


