Return-Path: <linux-kernel+bounces-78306-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F189D8611AA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57E08B25873
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:40:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8801B7EF10;
	Fri, 23 Feb 2024 12:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="MXcBIHFd"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2106.outbound.protection.outlook.com [40.107.247.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045EA7CF1A
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691961; cv=fail; b=tTtvQCVl9cxrFpdks+uVxRQFXNYcJLPQGr22Fwge5VZ+MIXVmOE4weCqNeFGSV+QHbpAN5M8EDvAaypB21p9f8Z7ZRrvbQwPImT61YukWSBAwfwmolz9Ha3LAqOF6w7SZYenBmJI2+DRaGkJ9Y1XKmRFOq/DYMx0WAD0WU4KmVc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691961; c=relaxed/simple;
	bh=LCxoHJKlvCzkg+gCcy6lxRcFLxAI3D2/dSRbrSLftd4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SuZj27ZwTO7Bx32GEarv3fy35yZgFo3uX1zrUkdFhD8hD+NuFOrlKwYHh72ZbIZygqOaohp9yOF/XklFhqB9DxhmczvWpnkaTWR1j3W94zkb48PfL/gQTRU4Wqd/HvgXij6dYG0ULb3zVboYMiR5z8/foLI5zY0zKQ1co9kBQOI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=MXcBIHFd; arc=fail smtp.client-ip=40.107.247.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dAmBmz/1qucL5Q3VENKNdPu4SVvpvAJsd37ame/qqJ0XteYFy8AlMLv25zh+f5cbd+0Ma5jpAwgBmyhBaYAVPTQPv5n+2kMMLs+Wjcq2R9gfBRXXZSvwGB74RexIfU4+2amisOayecPe8p2idT4rZ6CFuzd/iNI/rj5IGas5JhVq3jc2UKgBQxl/clqGg6rwztg1dtibKIgInBGwwGt8tuEMj1u4+nlvBXVEiVoZV5LoWrqoKmAtFrGH4b7N+0zJyVhE+iZG7RI5RTjLEhdVSeH6aETiWCu7I7p62sAQiLh7cov4SW64OAaYnO+j7S4yPSMWs1nGoyc9T+H7dIcQDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jcXygmdCL1kMhs5XlsdmhMDfG+iyNyYT/HLrcPNSL4U=;
 b=KIaQ3gwD4dOj0LCxAYAeOu8QrBazB3k2oo5FW5MN/yRr5M0LDVC8/E1DkAo2gLebdIDyDgZk3/cDjioM3Lutj2M9mU8AVM95CV5xhpqsjYHEFBxI18wfNJGfTcYFa+jLQ7mgj4Cl4lF4lgxobsO91ag0CS+sn3uGqszfLVEQIZr2sxvN0X80icFM2mr0snmyBji0QmtpHzhM0czICMXrwlRA3i2YXu4v72XyIKVjc/zTQY1x4mdzKz5rV8u+eNwlpmxVVH9p95AiVvzLx/rMlK1QALXcaBt2Crupmb8n0HolI3SJ337eODYi5XmlnvmaPYklnHuz54YpgPmVlrsMaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jcXygmdCL1kMhs5XlsdmhMDfG+iyNyYT/HLrcPNSL4U=;
 b=MXcBIHFd9/MKrRDDxAQHTTXejxZ6JzkMtnc+K9QJH1K5UQ8XCHvkHtCYOS60J6B9u15gBryymCJaN4Ip1hzjO6QJe4SvSP3CgqNnee9uX7dIHTmdWiFQFu4nIRapXiIOE9/Ts0nIk618M6rPZa1ZFglhb9L7yXoddRq5czwZFdc=
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19)
 by DU0PR10MB6343.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:411::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Fri, 23 Feb
 2024 12:39:14 +0000
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8]) by AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 12:39:12 +0000
From: Michael Brunner <michael.brunner@kontron.com>
To: "lee@kernel.org" <lee@kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "mibru@gmx.de" <mibru@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Topic: [PATCH RESEND] mfd: kempld-core: don't replace resources
 provided by ACPI
Thread-Index: AQHaZkfqoQvbWL67f0u16KhjtwoT27EX3gqA
Date: Fri, 23 Feb 2024 12:39:12 +0000
Message-ID: <af8756be81c9062f9543d2e5d9373cf5e7877b1e.camel@kontron.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
	 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
	 <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
	 <20240223105242.GR10170@google.com>
	 <34ae1832d52a3f03994843d01cd1d9a0ecb7a72d.camel@kontron.com>
In-Reply-To: <34ae1832d52a3f03994843d01cd1d9a0ecb7a72d.camel@kontron.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7551:EE_|DU0PR10MB6343:EE_
x-ms-office365-filtering-correlation-id: 6e219c29-62f4-4976-b921-08dc346c702d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 uzOncn89i4dfMfjrd7Grt80sxsPOc9ZLsvOAoVto/XnmbikQbY9hLkNuN3MGq1qCLwiHR+t5qfV577nxlVwMGNVSvVTGPZlodaz9cass6YNt2c6qJUtQMUBTEOW2Mv2BzhYNeL9NGKfnNFBCI1BiuMTF/yyZE5wcjwoj86LqSgjrHU9xiVEb8ve8IDWIwBgkLAWqFv2y7xAO8rVtKMJSzIgy6ecp2XpPRkaPbQHTGdo91f/nQXHgnqX3LCLnlpk5k1QQmti+BxKLfC3PjO+ldzYXhI6XK6evns3S0UUEDPJaGa7Q8biWBft4Lvw06RbQ+KGvd5cBw8UOoFS4BVoHmC4VyTg5MB5fLZvnibhOOadimZcvvwy9asLIHwh1gz+5Gp+iwvcq7Q549Zg/shxcRZ60hthnagOPh8FGbY2rofCJML1j+vRJGmjKAjyDDtxzxTn5Z9wEWX+yliosAhiyLOZ7S2iNtc+/q/jszPo/KLfu2Zt6YE+FbZFbLu/1cBsISZ9kXRJgl79RDD13aDcY0NbecCMaIUmQWWB0IA94dg3/+FBO2VxSZZC5jNaKIt9bizpQQdzqR1Kw+HHWpuVvS3o9UCjpgunIVWJbHYW2qk/g16wT+HTrGkBYUGEJyzlR
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?kdlaTtDX3MSX8k9ilOkqNGw2TT6yeLlap2AMfuK6Y9q40I/j8EKslC2Tw?=
 =?iso-8859-15?Q?Ehjra1HGJAKUZ3lOJjbOQGet0KHYCDcLpqVicS4TNzv6DOmiFERsWUvHd?=
 =?iso-8859-15?Q?CgOke0xmFM5ILFAU4YwS4J2ldQrpl716LjB9sj6LJGtUIo0W9ioDhOSR/?=
 =?iso-8859-15?Q?kLrEa6yTc2kTbctRLl/vwDYKSh4CG5BHbLXU0tm19KpUuxA0Yx6lrm+c3?=
 =?iso-8859-15?Q?W5i8+4SBku4d0FMoxrm8eclqikS3xs39+0/8vr+0BVVbiXXcOg4V58u8m?=
 =?iso-8859-15?Q?Rp5O7IZx/oZOIWaWRLy3L9WGDP+yycuXJ0jOGLdsub18ocN1srSMWHioU?=
 =?iso-8859-15?Q?ptMpkE5oBAdC3PlUJnsYpdHbz9xVeJEw4/Q6D304A+Ip6poh/vsReJMiC?=
 =?iso-8859-15?Q?M7ghCDYbRoWanE18IQH8EiItAUAOkloYYIdcGX4yogRsV7nRTt/3Onstf?=
 =?iso-8859-15?Q?b4WTVBTRTgx2YafR7gA2lg8G1bEWiPsFouKboBOhxpwH48btC7uwLDvG5?=
 =?iso-8859-15?Q?h5JZeq2yv724BWKo/gvn5+j01Ys+3qkmzMHOQuUaWsIPI0tP4YgL9YjSY?=
 =?iso-8859-15?Q?Td/NCEuNOlnqbk2RFDEW1FpRgcuYu2ucgSqtl3wIznNzWai/InGLRTNn2?=
 =?iso-8859-15?Q?IkYhAUVU3kAG+vBw4/Twqp+DwG4fpopK1nDgi7vIwG8u0JjPW+23U7urb?=
 =?iso-8859-15?Q?HeGOvPGY8pjyramlHR2PCmYOaJ27JyBn1daOIx20dvjcpa5/nnFi7hVv9?=
 =?iso-8859-15?Q?N5CG+RLazcNS/fdfxOa3bhTgSOH/pOZD5+4bTuYLyJVcMOTA/XPUog8oG?=
 =?iso-8859-15?Q?SvipbgXxXIuA3wfMQ71ucA9pEGi6NGNql+Ox7jZ9vFr7Q3xBIwVZBkf9k?=
 =?iso-8859-15?Q?+2hO94wh53GFDCli/kaEYDITtF53okUxYPUWURouHqXOAJ0tXywyUrzmX?=
 =?iso-8859-15?Q?4cZYtq7L8wFCZYnkuISM6AGjyPCE1vsYsZljsGVx1ArWR09Uv39BggStA?=
 =?iso-8859-15?Q?iKJl0tkirQGIjpv43ywtawBlM+i8uPNQgAmeqCSoFUrqPfH9xMcL9EgKx?=
 =?iso-8859-15?Q?fdPWPxRYoWAS/xYpWn9P9WsMfJVWe0b5qwuyVqFfE90FADv4ufWPzb476?=
 =?iso-8859-15?Q?6MRrO0dW1nP8wah0kWlX+lX44vfnI9LsvfwT+g+9Y1uvlULWELgWqJlnj?=
 =?iso-8859-15?Q?gwuvPqa8Ac8tupKSU20pQRMfozwRLuJacUUrzgvfidn9gyWPMqstfvEjw?=
 =?iso-8859-15?Q?Q0Awv8tlEm8weawkkay64AJfpE52odYoiXQPWN/yfj5Dr3kUtppEq6nlI?=
 =?iso-8859-15?Q?+ai6f5dR0jbcK4wXoazE+yZ5Ls9TfE9i2Dnkb+2JCPPZWjvdZF3BoF3AM?=
 =?iso-8859-15?Q?qX28ifSWDffaSFt12G2Xsfn6XM2LghPvOajXsEEWfjCKWDbKlXj/lm5Mf?=
 =?iso-8859-15?Q?+5+Hnn8cn2oiHXwlBC4o7K+QVlHZUGvnGayw1q+vpCgEytjdKlHkYUDFL?=
 =?iso-8859-15?Q?TQ5XMkkHWL+t6M0kIlxUfAq9NQDvgb/fyIGPC0LtUU91RJL8S96I5QoTD?=
 =?iso-8859-15?Q?BBUwSGHyZ5cxIrvi4Uaxep4BzEb4RWUH+5Sepbfhrt4HSYIN2h9CySyXP?=
 =?iso-8859-15?Q?8AAJETMVXf5kEad4ve2qv4CDd/a7aepTAvmADSPCHnyHDBs7MNfHK4Oj0?=
 =?iso-8859-15?Q?CSZguCQ0J+t/3IUPQt9RxTjibxDWq2vCFpkIgQznyNLd4uc=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <DA1F0DBDAC21C643BCADB4569F5E1EE8@EURPRD10.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: kontron.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e219c29-62f4-4976-b921-08dc346c702d
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 12:39:12.2538
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vIq8TXtbeoPOXSeqWLTadUIFZmN5G0aG9EsAcHjMlomghWm05gYhLe1o03XJN9fdY5lPkzzxKbCpfIyqiLoMT58Q212vVivVTLPBpjIrpAk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB6343

The current implementation to retrieve ACPI resources is faulty
and may cause issues that even can lead to non-booting systems.

When adding data from an ACPI device, the resources are already
assigned to the platform device. Therefore there is no need to
retrieve the resource list from ACPI and manually assign it to
the platform device. Also there shouldn't be any BIOS in the wild
anymore, that does not have resources added to the KEMPLD ACPI
data.

In particular this fixes an issue where the retrieval of the
resource list using /proc/ioports is disturbed and does not list
the assigned resource for the kempld device or even no resources
at all.
On some distributions this also leads to problems during system
initialization (e.g. with udev) and causes the system to not
boot at all.

I have reproduced the issue with the following kernel versions:
    5.10.209
    5.15.148
    6.1.25
    6.6.17
    6.7.5
    6.8-rc5

The patch applies to all of those versions and seems to resolve
the issue.

Signed-off-by: Michael Brunner <michael.brunner@kontron.com>
---
 drivers/mfd/kempld-core.c | 37 -------------------------------------
 1 file changed, 37 deletions(-)

diff --git a/drivers/mfd/kempld-core.c b/drivers/mfd/kempld-core.c
index 67af36a38913..5557f023a173 100644
--- a/drivers/mfd/kempld-core.c
+++ b/drivers/mfd/kempld-core.c
@@ -428,50 +428,13 @@ static int kempld_detect_device(struct kempld_device_=
data *pld)
 #ifdef CONFIG_ACPI
 static int kempld_get_acpi_data(struct platform_device *pdev)
 {
-	struct list_head resource_list;
-	struct resource *resources;
-	struct resource_entry *rentry;
 	struct device *dev =3D &pdev->dev;
-	struct acpi_device *acpi_dev =3D ACPI_COMPANION(dev);
 	const struct kempld_platform_data *pdata;
 	int ret;
-	int count;
=20
 	pdata =3D acpi_device_get_match_data(dev);
 	ret =3D platform_device_add_data(pdev, pdata,
 				       sizeof(struct kempld_platform_data));
-	if (ret)
-		return ret;
-
-	INIT_LIST_HEAD(&resource_list);
-	ret =3D acpi_dev_get_resources(acpi_dev, &resource_list, NULL, NULL);
-	if (ret < 0)
-		goto out;
-
-	count =3D ret;
-
-	if (count =3D=3D 0) {
-		ret =3D platform_device_add_resources(pdev, pdata->ioresource, 1);
-		goto out;
-	}
-
-	resources =3D devm_kcalloc(&acpi_dev->dev, count, sizeof(*resources),
-				 GFP_KERNEL);
-	if (!resources) {
-		ret =3D -ENOMEM;
-		goto out;
-	}
-
-	count =3D 0;
-	list_for_each_entry(rentry, &resource_list, node) {
-		memcpy(&resources[count], rentry->res,
-		       sizeof(*resources));
-		count++;
-	}
-	ret =3D platform_device_add_resources(pdev, resources, count);
-
-out:
-	acpi_dev_free_resource_list(&resource_list);
=20
 	return ret;
 }
--=20
2.25.1


