Return-Path: <linux-kernel+bounces-78197-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D029861014
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:03:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 502582882A6
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 11:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D03163121;
	Fri, 23 Feb 2024 11:03:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b="Ahw0iX8h"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2138.outbound.protection.outlook.com [40.107.20.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D247814B835
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 11:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708686209; cv=fail; b=Qjb3prdHvy6b401ZbKZqqgl3uhSJF/o35Okux6OKLu9WrTrGXEO7t7RCrFqgDlCVJV4uaz4nqnrYS8ShahB2FRH4ESgFYJDcOuPnWF5zJhsy7tOK7CxjKFrW972uc//5SYJfLy8dAFIAoqryN2BwGTXB4yjkuLGislY/ehAwS8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708686209; c=relaxed/simple;
	bh=5baE0mc+GvtS/1E37589e9iaYet1ekD9jqaADKyeZ7g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mjlnJk0wc54DR72SfwcJqm+/EhRWD0+1xBCPF52BoTr9tQfF0DPfYeh3Geqyb6L44GpeUc5xkEYPve7BFVBEli6fVRbLa7ASJXZLTNpkfsJUGgKr4ZjXfCsAf/14lkbzsrbjxE5amLqAQzicD43eRVvR4RKpXnmUib3oZcBom8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com; spf=pass smtp.mailfrom=kontron.com; dkim=pass (1024-bit key) header.d=mysnt.onmicrosoft.com header.i=@mysnt.onmicrosoft.com header.b=Ahw0iX8h; arc=fail smtp.client-ip=40.107.20.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kontron.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kontron.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jbLmA97I7zQNKdhlLXdDSNFvJ4k1fMXsN0KvESlFsWHFaUNk3LPwD5e++pAtxFbVvgQaOVgggifodoiCvNjOMGTRG69Jh4gAhVXCO03IP7WTcnh9o1qIKdhxKePowH9SO1B4XAe/thKk0AG4A4MyReBEznZATwJYiCqmoWpmKbunf/05M7ypq/WYjB6PtSNgB+gybQ682uqSGGOmskiW6RmKjUDovi6J+YSWuhBk9Oarp7ijUJ6knNKerHBmO/cBzSfx2mUQ893WIARV3qDRc7O/+bOikdf8MEKfB1kV38TCs0JiPBZE/aShvQ9w5EgaVtVPWDLDkl+NXqlQq4szbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rf1fchIiB75ENEMWIMzyvCZWCUzCYZjRngYRlqK7+v4=;
 b=ZmcpfSniDzSzV65q8gf4OhUPpdCplbEZ4pmfThZ47lpmuqK+2Zgd81feCeBmqqk7KhoksviPu3TCBZphRiXlQFe/AMJQ1VKL5nZjY0+iEmwuKrxttxXob29pqWqifHMDx5B6Q0iV3SZpB0fJ2NJ7Z9U3FHeWiFPL4pJF5wZl9mswewKQTBlFnifVS5W81NWWhLABMas+k943j/TESiH5Jh6kFrzwPJNik5e8xk1I27ZcASXEBNHCMYTICnQmQQLtg8hOoJ3nnM+B/bPZpti0NAv/tFUE6KIaednbcXPN0QLsLLjMxD0OI/MEP/9KO6P/HHuPnHbC8tG0J8ZG62hGnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kontron.com; dmarc=pass action=none header.from=kontron.com;
 dkim=pass header.d=kontron.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mysnt.onmicrosoft.com;
 s=selector2-mysnt-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rf1fchIiB75ENEMWIMzyvCZWCUzCYZjRngYRlqK7+v4=;
 b=Ahw0iX8h6H2bq3KBXdOlMf+LPe6EYEKJp7FKmYc1CBiUhTJtPZhc7S1M9SfT2LW3UNXWF8Ye+30vD2hpy9fRpKu8nzXgEUrn2Gv5Csb8RQVe+I56+z2j4HMhbHml5fJpSPxnVz/wAvwwn9xKY80jLowVXdWosUHgxsBEkQI10N8=
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:591::19)
 by VI1PR10MB3230.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:803:136::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.24; Fri, 23 Feb
 2024 11:03:22 +0000
Received: from AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8]) by AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::5208:477d:77da:84f8%7]) with mapi id 15.20.7316.023; Fri, 23 Feb 2024
 11:03:22 +0000
From: Michael Brunner <michael.brunner@kontron.com>
To: "lee@kernel.org" <lee@kernel.org>
CC: "linux@roeck-us.net" <linux@roeck-us.net>, "mibru@gmx.de" <mibru@gmx.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH RESEND] mfd: kempld-core: don't replace resources provided by
 ACPI
Thread-Topic: [PATCH RESEND] mfd: kempld-core: don't replace resources
 provided by ACPI
Thread-Index: AQHaZkfqoQvbWL67f0u16KhjtwoT2w==
Date: Fri, 23 Feb 2024 11:03:22 +0000
Message-ID: <34ae1832d52a3f03994843d01cd1d9a0ecb7a72d.camel@kontron.com>
References: <09855448430a5f090dbe09cbb269959a08881ee7.camel@kontron.com>
	 <8ec638c2-93b6-48e4-8ac4-965072b1d5af@roeck-us.net>
	 <de6bc09c779a4b4fa2ddaa1fa3a595de323b7f5a.camel@kontron.com>
	 <20240223105242.GR10170@google.com>
In-Reply-To: <20240223105242.GR10170@google.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Evolution 3.36.5-0ubuntu1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kontron.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS2PR10MB7551:EE_|VI1PR10MB3230:EE_
x-ms-office365-filtering-correlation-id: 44441a71-3dbc-4136-6b4c-08dc345f0cd5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 1hZapr61pbGCsjzrlaHqV8jQ0J0OccEQAXKGnxBDzyOBdbF7Zk800kNoqQVtl+KLa+CE6kbgYhvCo6Id7zUWPZPBuN5k3yh5QGi/eTcHT8O5lCjHAwVWDr7c/PPlDEbYFvBfj4YZlhYoHbHoWRqE3Huq89cokxo/aHrYx9X8mbsK0ks0pECPcuGFrIA26LOPKKMhidH1YzH8c7xRDsoapkFgdZ9T1SoCsnUv8xlUwk1yo8KNKQ97+y/VZVkYVzPvjxnsQP0RHHth354lBh9TL8RC6IgnoTOu4Khr9rhA96A1TDsUBpQjvmNH++VIY4OQCWi5z+6IWNLJbu+XzLAQEKh2chFyPb+YcREtmHSMxSesbYnrIt8l/+TdugV2jJfVI6OH9xmQMURZWEagP3QwHTpVRUQcu5DDljevEyT+5ORKy/BAJHWdVbymziKhEnUyE1fo2r74GU8uL5Ipf9yIBft2u+j/+9M0SJ1JM8qeRzFYuq46CUpZyRAJR7UBHs39uNcoYhdDDjv59o79FvDhxf+hDGh16TkrKR2mtorjwquvqlVUBSnZ0dzttQGGNQdX44/sDQrXTdba3f8qXcZ2Bk0T1npDExbh8U84v16OEZ1XBUM5afCGMRhIR0hZaaJ8
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS2PR10MB7551.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-15?Q?C09onMOcvA3Di6RUePnZ92JJ9r3Cbkb8uCFzl70KtorUpEocGEfVbRmEl?=
 =?iso-8859-15?Q?kGozQNJm+2+iexWEFn7la+44iqglzU3fpx+5Oxbn/aOp3mGu7XZz/jZgK?=
 =?iso-8859-15?Q?FWALB+10OANfVlJL/xnrLk6GZ4Vmz6EvNMdt97p/qbF+wotZj4Nx6ylsA?=
 =?iso-8859-15?Q?pbgxs3QaYgYQhcBGLBbnoQkcDiOWtEwD6ErSESRuwXYhr5dhWHUVnLp3g?=
 =?iso-8859-15?Q?PwCWrZt5iEph8i9LekJOXuGx5QCg9cgSvs9TiKdXXRijoc4uy5UsECIYM?=
 =?iso-8859-15?Q?tsM4UraQDG/nhODv0np3LYBIt1LhlGgR3Qg3/L2xrvflNxzc479OSZBnD?=
 =?iso-8859-15?Q?IsHvQm64c40OkElBx2c6sZMDZQFrgfOiTTD+pb/KEZKsOgRH1auk8bkV9?=
 =?iso-8859-15?Q?nr5mSMGD+9yJpsiOqnyF9nEUZAp0eFe+NbSnxOt30/eFpvR3yul+0QT8r?=
 =?iso-8859-15?Q?mSeRjTLc+KmMRT3N7DzrUx1sMsE+OYN468OftLHh59YdAupoirJyGDlwn?=
 =?iso-8859-15?Q?WvgEy+HA/CpXUIdg0IF1VLa340CY+a684NJ0KGuAnPlGaqgc/M9BLjaE2?=
 =?iso-8859-15?Q?3GV8Xbg8/gGQFPfyYS1OZ3PJDp6kxg0MNNE0sWWGkPK/hpWsUyrv/qVU7?=
 =?iso-8859-15?Q?k/LGfYZELhMusVqdQDGx7pFDtUTyjD7IDJA7O+UhDplSeE/SwPVbppfJS?=
 =?iso-8859-15?Q?ENshEqLWDxnr/fUiVm9/es+iu/HA9xPm40axzPdUwnxZ6pKoFvdi8jx8c?=
 =?iso-8859-15?Q?iqOotFxs73JjuU/bFHObYxLNhRXyTbsx7OJPsGAZ6Hq5JhAShwkN5h4eD?=
 =?iso-8859-15?Q?iWpCU2t2UiPoSlm6jBOgPuwIBia5AkzkFwXM3AUpV3gd34vpN7RROs1lo?=
 =?iso-8859-15?Q?xPkJGEHSapUM4e24UpUyX1wlGusbejoBKPMszR/7gGVN485zziQiq9PMq?=
 =?iso-8859-15?Q?59tV7zaCeOZ2cFZLR+Vep/1zegXIjsQW5ey6U514L3WjY1SPnfQ+ktUtB?=
 =?iso-8859-15?Q?1b4Oho2Agl0sxcumI53yeCWMm82RTl2LVhH9CSWIEqC4R4XIAVUxqcvbX?=
 =?iso-8859-15?Q?R/rgpvjPWl3NHNXDfpL638QrxD1jDE7QqflkQDmn6/UTxsH33SOAORQpN?=
 =?iso-8859-15?Q?9nVryD/pxvbpnTHeSZcs/XuFoItb2K47ZajiqX8e5bIhSye+1bBAFapH5?=
 =?iso-8859-15?Q?nMKpthXW2+XlblwnZGNn3CRCB1ZdtdGPJ3GGvXuOWF02dGDukY7Fytrsu?=
 =?iso-8859-15?Q?4wOopYpbd5saN09Ma2s3kzt+0nvvs09FP+OTsD7cWK/J1/gMwc7g86RXt?=
 =?iso-8859-15?Q?hR0J5cwjrmzDjMjcxaL2mGfpy6aTdebg59AqxHRw5EVhaODAMMQnff2o9?=
 =?iso-8859-15?Q?LQUuX3lJnITDdBO1Kcme1ko7nf2kDYQA6udNpwP28oVzVaiZ0XGY7pqfv?=
 =?iso-8859-15?Q?nbF4caqUSkDnKl0seXnz9Iev/qT5N9XbIsIovpJohbe185rnQKQ3okC69?=
 =?iso-8859-15?Q?mOFFxW2Jyu5lRs+SnPT6STPXV0huPZ+o3q98IfdEDCu6yjR0escH7RcOw?=
 =?iso-8859-15?Q?XUllsojg2cE6OiDK+8fQeVSrQGtROVDd3cZXekBoMYDA5bMnfCYUdTXzU?=
 =?iso-8859-15?Q?Qqg/5mr/r8hE0b79virFfY01S4NfsFYVIqpGgydriuaxfaYmmg1xjozH6?=
 =?iso-8859-15?Q?O2igj3P32gH/ikx51PiXdKsB85m4Dcywxv2zbT5W8bPQapo=3D?=
Content-Type: text/plain; charset="iso-8859-15"
Content-ID: <E2B490788B26EB4AB760CA23536CF742@EURPRD10.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 44441a71-3dbc-4136-6b4c-08dc345f0cd5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 11:03:22.1330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8c9d3c97-3fd9-41c8-a2b1-646f3942daf1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9ZeqaoDvGwHwhfRwBmL/voSuIvWJtMXaL7OWE0lg+ajwQzsv7oODiWMKfWAViZmNGRgzvceH9rOb90TTIdmnzrYqMeJUT1Vt253eRW2JNtE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB3230

The current implementation to retrieve ACPI resources is faulty
and may
cause issues that even can lead to non-booting systems.

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


