Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A250777451
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:21:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjHJJV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:21:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234776AbjHJJVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:21:11 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE5C49FD;
        Thu, 10 Aug 2023 02:19:54 -0700 (PDT)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 379LrI9Z030101;
        Thu, 10 Aug 2023 02:18:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : content-type : content-id : mime-version;
 s=s2048-2021-q4; bh=ECbYKy5KcRwshJ7/UEpJhtUT2ZIvB35haOCJn5Nfeyo=;
 b=XGopA0qtBScInCYGTe5EUSSe4z8f+wS/eBm2cX2/WTXWEAFYUvL1l1Pntp+GEK/ZaaCc
 P4/7ePLmIYZ13QXtbniRB5idttHTLD6PZpHmz0ECJZkRN48E9NDrgcxO6x7oA+n4GHKh
 KLG+9SZYg5I7f/rAWUYdmC9qXfebMAbL0fEsFU7Sa0WoPazNJR665XUmvKhsZUc4QuUY
 4poFnOPaEJQN7voUFs397fMNyiD5y2Bh1o8rxCcj6gqKryHOzk9piIxQkS3paKFCe1uW
 lr8BWxZn4Dg7Wt5ZcGarNmyUDY8UQZMEVcg7wypbHAgVurYdKB8DG5x8aa8I3qpPVE9P +A== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by m0001303.ppops.net (PPS) with ESMTPS id 3sc9v094jn-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 10 Aug 2023 02:18:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QbhLxcrY6Awte+M+QD6n8wbWGXn4NWHjyNbvVgBlOOrqXWWtDf/Ke3YZxZv4mOcIL0LX1Fii9OuPtQGfutu+4B8UYsF5DbC1irxTqTOo+B+eDUZYnBHcvDxBHLKD02l64fgsOcKdrf8WWTHJNgu4Eo49bZfd9EJ5eYFKIUb+7e1HYiQjbt3+AQEROyvz4ohYVwd+7inlo3ecWBdmMk5q5hgwXVMcUAha0TZ3FnEYsgU5C8O9PzPw8bTeKuUSFIU7slBc7D88w7DQaM+LygVhVKyOVHJ/+NhWXxgGafS6q5rF/ceqUr62tCJzt6CSDC9wpdze9w6Rbz9/lUoBUx+hMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ECbYKy5KcRwshJ7/UEpJhtUT2ZIvB35haOCJn5Nfeyo=;
 b=KI2/DjAsSNiFl2HI4VLGLJxgX+c9xj7922Fwm4WGC1rpUCOwgFA8XQJOt7uvLlQzVIEfYEDdoBPVXGSOdSPnpha7uYjhS0a8yOZJoZc5DRRxzbw1UVFX1qN6G5qAPc7YdwjltWG8/jrLbOIL2xZSwqLnpralUuHGCN42nXIyWHl/EpzGnx9e/l6VAPcf4TaoLcwGka1a9s3cn6nwsuA4EQ+v21tcq/6sU45CZvhim2qEQdJmebojs2IhuhxZPQiCFWDOYwSmKxGw6LuP71P07C9JY89oYXnEQem6xMc5an0nMHRcIqzukjVjbOcSKR4/wEBcSufrYckuCGOLErSN+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA0PR15MB3997.namprd15.prod.outlook.com (2603:10b6:806:84::21)
 by PH0PR15MB4845.namprd15.prod.outlook.com (2603:10b6:510:a6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Thu, 10 Aug
 2023 09:18:55 +0000
Received: from SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::fdb:2c72:511d:1b3]) by SA0PR15MB3997.namprd15.prod.outlook.com
 ([fe80::fdb:2c72:511d:1b3%3]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 09:18:54 +0000
From:   Jonathan McDowell <noodles@meta.com>
To:     Peter Huewe <peterhuewe@gmx.de>,
        Jarkko Sakkinen <jarkko@kernel.org>
CC:     Jason Gunthorpe <jgg@ziepe.ca>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] tpm/tpm_tis: Disable interrupts for MSI GS66 Stealth 11UG
Thread-Topic: [PATCH] tpm/tpm_tis: Disable interrupts for MSI GS66 Stealth
 11UG
Thread-Index: AQHZy2uvJhqtBOgeUUqhgtaOcrpo8Q==
Date:   Thu, 10 Aug 2023 09:18:54 +0000
Message-ID: <20230810091851.GA1088011@noodles-fedora.dhcp.thefacebook.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA0PR15MB3997:EE_|PH0PR15MB4845:EE_
x-ms-office365-filtering-correlation-id: af6bad54-d48c-4280-f0be-08db9982d1c4
x-fb-source: Internal
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UNkCkHSXMGQHv7Kly9oqseU6kqrdz0opD5iyonLe67CdA22msk4yJt5FZ1leVs1dJ+wpQMe3gBc9D1r3QzlYtENSCHRTqg3juHC5lyzj67jgMVkhUex0vshzDrRTSEMkDLqdWMLGETtVFGlwTE+VbetVZn+sCXb4Zy71E+f5CSmrpT5zfL08cl/gY7VxyVhyobLFovOs7+WNW2D55oM9tq9gqQj+woJzL3MdnZnl+F82U/UKpyYktvZ55D67+p9mc/M9qMuWb4m6UIHw1za/oSfHh3c6w3AjGqqiwYZ+UpR0ygMtqeiTWXwSpnEtiEcdySo1BkbgPChDGUC3jVdt8/vK+bv+9ON/UqxZ4sFuQZFBw110NrTIvEATjt/XYHcR6siyw1oeaZIBND9heq9aPfUot9GuFNDdZcBkpC404blZCiw7Jr8Pq05cqTZy4wan4M9lESiZ2+vp+tujt7CgmhVv4eRvhZN3LoGz+KnIx0WG/SihWDPCItoVKFPnRcqJuKnbTLUM/eJANkdX278RB4hlXEJO807jblo4swZfbfAXbHvQnYWTzlRkoEU/JxUxGKqUm5CBYbXEm+kxBBVI+bUsVRCeyQ4iBkmR+foaai0v3aUaB6h5sX5MbLXNR1V1
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA0PR15MB3997.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(396003)(136003)(376002)(346002)(366004)(451199021)(186006)(1800799006)(4744005)(2906002)(41300700001)(316002)(38070700005)(5660300002)(8676002)(8936002)(33656002)(86362001)(122000001)(71200400001)(38100700002)(54906003)(110136005)(478600001)(26005)(1076003)(6506007)(6512007)(9686003)(76116006)(6486002)(4326008)(91956017)(66946007)(66476007)(66446008)(64756008)(83380400001)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?DaLIFubDHMNuhlADE1SQ0A+sdYwMmGls1MTRNabh4fk5D0lX1q92TPcqNgFv?=
 =?us-ascii?Q?4nqCttn5rGoa989sPOFVpDogoHUh4gAaVtAC1GbWvZvttpjGnE6xBi7D0grB?=
 =?us-ascii?Q?LxmvuYew0RA+FRbqQ0PS1OaUAdHObHguVyCPdEuwcYfV1OvmXkMUxfjnjqWX?=
 =?us-ascii?Q?dC5+NIBye1qlnZFaNxSSU55G9ZEOPFpnOfhhTs/FI636ZEkjmb5JICiEEBj2?=
 =?us-ascii?Q?Uch674+LxHxtzBHwSSbQ+48FEybNFjNkj2iAAK7GkfLfB5F1UZj0ihnYZ3CP?=
 =?us-ascii?Q?c7vinYUrSJ2G0YP+zm/TAxdUW4zoqOY+mYYElXDwHCHXJgARWh3DgwY7q1Do?=
 =?us-ascii?Q?wNUDkEtEFfVdMZ5l0D+QTyptlFSDrx9hUiG6CUHccLluC2AKcQUua8rCenRp?=
 =?us-ascii?Q?B5Ds1TTU4eb+axYGUzTVI6KE/udB5PB+CL9i4UhemnVDSgvQFuU0/0eYhnUr?=
 =?us-ascii?Q?O9FEvXMQZeRmIfA/DfZh5Xh/mwFLM5KEfhUAqDhZPoLqMg9pPIk+CGDk/HS2?=
 =?us-ascii?Q?D3BHLeDavytMDL6ApU2BVtbGZx1fszJYNF6DnSwg++Ek314+8/wdYqgaFRZN?=
 =?us-ascii?Q?I8Zd3PTmH/umVw9iaJ0rdjImiEmwlzQjQqxtmIPaBVd6btxOiOckVJkSAELY?=
 =?us-ascii?Q?UynCxoQZXvVxv+ImLR+mQ+e+B4F1V/kypusY9RCXXTn+6for5R8rW/Y4JlaI?=
 =?us-ascii?Q?ux5qZTmJJLEGp8QYI4zIyITT1xov8lBOZfsgacdgeEWKUsiq/WyOfD5t21WK?=
 =?us-ascii?Q?78wggW+EEAksVM6F2QYwfUc6Qz9CYwqSKb+fiX/08Ksj/h1EfuGmaJNEsUGu?=
 =?us-ascii?Q?Xmh6a0f+c9GrKpBiIs1vj0/nm4jwJYWJFLxa8eUq6l8j5fMfOsnVyIl73WzP?=
 =?us-ascii?Q?kTSrjHYIK4BrYcWU9eaSA/95DAtbs+yjxT2dXSDIJdW0gQ0ddwqPVlZfLqDW?=
 =?us-ascii?Q?O06WeimSYjwgooUF0mgB3Z3wRSuUdoGQ4vb+79yjbcYf4J15/VfIOfVxfnpq?=
 =?us-ascii?Q?hW++OY3UXXJnROTE/3Ptn7s/qwNMepUBDWRUz3b5RW6T/ozXsk4zKES5wRS2?=
 =?us-ascii?Q?mIF8vjxVFEz1VA/v3HaUZLwQtSW2GPTbBnQIU1OpmMeU4rpT0h0PYmlJPF89?=
 =?us-ascii?Q?IOyxNe0Hac2QS0Gb4nz1WkVprbPk04Ol8i+xNQ4njrcgtWJqLbS+bJHjW4/5?=
 =?us-ascii?Q?kCx9CoKadfkoxmln+xpL3DA7ZW7M8G+G7ldRoIrISA8Rzvh/MIRPhYro9/HI?=
 =?us-ascii?Q?mrpxekzQLsNsolJWP4lES5EzaAQd4Gqpa1c1kv/uJCojffB5v6T0Aq3nt1RT?=
 =?us-ascii?Q?q+XkkHF8PT+i83I4WQhPNelSYCKJPkuiFfiDv7WtsbTc64nnBJk7mcHHPNqb?=
 =?us-ascii?Q?KpPDn85p8m2K4g03UtuRVxo/k9y9FdrhSTZGxtDNW93Zs2+UW2EAaGtQ0d27?=
 =?us-ascii?Q?d+JoWHn72ENS6ht2yPH4qT2gnaFwcdRmB/5temu3DNHzO2V1Kr2zoDebip6M?=
 =?us-ascii?Q?gjVh/FoCEJSI6defNOh2SoXYSPLbq0B4x33lF1V9Km0Ud5VDaQHC3lgz+95u?=
 =?us-ascii?Q?zuXFOhZgBUIa/QaUSOabCNGimm+QYM0TNhXDyl5g?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <60AE0870EF5FF642B7ED5B41A0F04B0E@namprd15.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA0PR15MB3997.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af6bad54-d48c-4280-f0be-08db9982d1c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2023 09:18:54.6709
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0zws8TSdZCksoDsS9yNTLQQER4q3ge0Kfj/wSmoPZMZ2BoCchW1CL+xsh9U4vW9Iq3MEpPZrKJxRS2cAHzfXSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4845
X-Proofpoint-GUID: HGK1obO8AwfFzuMFRESV4x3X5zLd5wmz
X-Proofpoint-ORIG-GUID: HGK1obO8AwfFzuMFRESV4x3X5zLd5wmz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-10_08,2023-08-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The MSI GS66 Stealth 11UG laptop also suffers from an IRQ problem with
tpm_tis, causing the TPM to be inaccessible. Add an entry to
tpm_tis_dmi_table to force polling mode.

Cc: stable@vger.kernel.org # v6.4+
Fixes: e644b2f498d2 ("tpm, tpm_tis: Enable interrupt test")
Signed-off-by: Jonathan McDowell <noodles@meta.com>
---
 drivers/char/tpm/tpm_tis.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/char/tpm/tpm_tis.c b/drivers/char/tpm/tpm_tis.c
index ac4daaf294a3..14dee959ee19 100644
--- a/drivers/char/tpm/tpm_tis.c
+++ b/drivers/char/tpm/tpm_tis.c
@@ -130,6 +130,14 @@ static const struct dmi_system_id tpm_tis_dmi_table[] = {
 			DMI_MATCH(DMI_PRODUCT_NAME, "Laptop (13th Gen Intel Core)"),
 		},
 	},
+	{
+		.callback = tpm_tis_disable_irq,
+		.ident = "MSI GS66 Stealth 11UG",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Micro-Star International Co., Ltd."),
+			DMI_MATCH(DMI_PRODUCT_NAME, "GS66 Stealth 11UG"),
+		},
+	},
 	{
 		.callback = tpm_tis_disable_irq,
 		.ident = "ThinkPad T490s",
-- 
2.41.0
