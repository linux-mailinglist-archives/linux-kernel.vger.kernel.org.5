Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A3957569D2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:06:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230126AbjGQRGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbjGQRGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:06:15 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2092.outbound.protection.outlook.com [40.107.101.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE0F1131;
        Mon, 17 Jul 2023 10:06:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hEELworVsY7KUE42u6uXCFvID0KqpZTjDpr8RY9EhOceJi8E7mcMpv103BdwGHGSVkR5/pmltply/2JyjpvNnaDX5CTw5bfGYTMNCVVuRN78qt6Bndn2JbyQsronfa37+YktQHw+OU6h1S3G1lRY6cbuwdmrNr7OYFp+Q6E5TWzikuhrj/GzyCtSxbMzwX5m8DkV+hrYRKulXmAFaLqpaLMKvC8vm/Xq+fUoGvzeqfssOkdoWiYU9uwFLzpKq42WmJiACPvGX/q02VKGgPJNND9ugUnsNVjj2SJ2JT+u6KnuSzQtxI+z19XOypX5dTfhJSoC7C/VJx5Ubu/9rZX7vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d5lg1ashcb/zxq6bY4uNOvcmTg1nWnOlwEFykk+SOBE=;
 b=MoaVyURyNi1QdkMSeEyWVddh30XobE/eZ7Sp83hsTRfBzUS7UfTN9OLmJfeX3OacNxDXkRTVgXC+Mm9sB6QxjX/OfvxyG/dB+WEVyaTZlY5wQauWF8vMca6PdCLmwYpIcc2u6Pe7PWgAjygxyzga7tWC46dyPCLCZXHhGENiHlJDSDOaH4357CVI4JBcIeZwLM9GnW6uPAqtejzCdiWafEQ88C+Uuje1v3nx/E3HU+hNrTJyFSHS67Kj87pWo7hZsd7VCrJxHbJgy+0MWEMvsEk2UhmLzJfGp+dpnSDF4rMqgndDgmwJ97VGS27dvQmuATk+Qfzxkle52oVQsdcDYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ni.com; dmarc=pass action=none header.from=ni.com; dkim=pass
 header.d=ni.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ni.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d5lg1ashcb/zxq6bY4uNOvcmTg1nWnOlwEFykk+SOBE=;
 b=XdP9aJ3kGu90EfIVtXIf3p/T1codcuH1y4/BTfs3AzOqHLh+eJ3kVylm7zH6uLq6v6bBnhhaaRaMv/VN39VD2zyBcDUDTWwB/2gyQtnPHZ4xqqsDk7OBnOy+IF89eNcy/J/rr5Sioj/9/g2ydoRo5JnCeEcYHW69OBcrqdzfOTQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ni.com;
Received: from SN6PR04MB4496.namprd04.prod.outlook.com (2603:10b6:805:a3::23)
 by BL3PR04MB8201.namprd04.prod.outlook.com (2603:10b6:208:348::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.32; Mon, 17 Jul
 2023 17:06:10 +0000
Received: from SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115]) by SN6PR04MB4496.namprd04.prod.outlook.com
 ([fe80::fba6:1478:6dd7:9115%3]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 17:06:10 +0000
From:   Gratian Crisan <gratian.crisan@ni.com>
To:     Thinh.Nguyen@synopsys.com, gregkh@linuxfoundation.org,
        hdegoede@redhat.com, felipe.balbi@linux.intel.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        gratian@gmail.com, Gratian Crisan <gratian.crisan@ni.com>
Subject: [PATCH] usb: dwc3: pci: skip BYT GPIO lookup table for hardwired phy
Date:   Mon, 17 Jul 2023 12:05:52 -0500
Message-ID: <20230717170552.466914-1-gratian.crisan@ni.com>
X-Mailer: git-send-email 2.41.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SA1PR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:806:2ce::6) To SN6PR04MB4496.namprd04.prod.outlook.com
 (2603:10b6:805:a3::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR04MB4496:EE_|BL3PR04MB8201:EE_
X-MS-Office365-Filtering-Correlation-Id: 979416f7-9a75-4b4d-b063-08db86e81df8
x-ni-monitor: EOP Exclude NI Domains ETR True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oRvjJK8X/dd87begz+TX0g1GiT2XbkgazrkBGFxkct4Ojj9XLqBFSSmcAAd3RKYSGlQ02guL/mLw5bx5D+InOP3QwvPQl6FlSQ4tvLi9ytCa1hhznN5W4kYd3LSjNn+G7tPQZXmmjo9MKmQmruGaIAwm6GL331NvQUob2tUUSs/geOPDmwO7ZUm+FBzJDV5lvv5n0YuUvNQfi0EM6zM0QzvYpsSQSMDJOzlKnWMUIHz3TQXSuIVxpW/CE+XkU+U6dw5rooYAS+saQeVpGskNMsuzt/E2jn+FINBGKFETr282DQxP9JB5Wbuahochdm8H2UFrOb2oGOqncWrm3atAZu64W5qGr8TH0AyYI8rCQNPjpFfKkIIgN6CsYP7RbPM+dVA1pUi8ahg/wgqzC2/ZVRxukWfq9ctN7fngiHkGjhcCMhvOZtVEZs0KdTWuoBNZXclLcjZYZa3xsgmmwiBbB2bYEbHeEyQHgPa/M049xm8V1FL67vD5EE9p3nxRWDKVQjaE8Zbq6pT6y2yyX1r3G0mh9xA42Q3hVE2LnOfMDqD6tFnlauiTjXdTGOaORC6H
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR04MB4496.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(136003)(39860400002)(366004)(376002)(396003)(346002)(451199021)(86362001)(2906002)(36756003)(44832011)(6512007)(186003)(83380400001)(6506007)(1076003)(26005)(38100700002)(6486002)(6666004)(316002)(5660300002)(66476007)(66946007)(66556008)(2616005)(4326008)(478600001)(41300700001)(8936002)(8676002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?DRv3BxZBhuSB29U93zNMycLXED9TQpop8sSj7N6rKDKZ+6ymsDCkO9aq7Pgc?=
 =?us-ascii?Q?zZMximT/CV5D8AarMGIT4UFx9B0p6bjKvAAE9lQQ2UQjKqh8jkB9dUuFXX0G?=
 =?us-ascii?Q?9SwrsOKDl9bTPl27XtUk3d/YZe5iakduiApgmvFA1gbj27RUdCfTIbHVBbeX?=
 =?us-ascii?Q?fQBpjC4cE6a5PlZJlRC8iRpLuHJhga/WQsK4RaGebKE+ZRlNd1iBiOHirk4R?=
 =?us-ascii?Q?SNxfyKa589XfB38H+hi2w/EzH1YmLfw3Es1nrstQ8VTv6uVX/quLY8GqO/3w?=
 =?us-ascii?Q?CbK8NPn2IOUyDPVtw2UOHqhCXZaLRLsuR/fkMYg29OMb20vYaJ6Z6hkIkQtv?=
 =?us-ascii?Q?G/0WE+EGKE1UaFyXNbRp20TGnXeNfPGO4cTrEuBiWzmUWOVBJq/nAjNf6gWK?=
 =?us-ascii?Q?/28QBnypHeVwZNgRrEKxL9Ra4jgQCV1FXA2wpB7j0TAA1dmjMbrC/HlGKjF7?=
 =?us-ascii?Q?WdQvqCYNCmsYwl903CqrZQ+5EpnXtCuQyVyAsvRqBbL9loF8CFRALWhgouZ7?=
 =?us-ascii?Q?CsOX/lJXbtP5WAGuLfXlDK6zHEVUA7wy8XBlTnVMNDjRp4Sihr8ri6DERL5O?=
 =?us-ascii?Q?KlERhQSEy9hE8UXp94XjfdcZuTjMLFICZpTjuDCThm/VKkNlTgeVHVyxHJcS?=
 =?us-ascii?Q?SAAhp5EyAm6ZyKdYXUjWQMcDIw78n61y4qs8oq0OVR+XGSuUz5RJQdRRM5Cl?=
 =?us-ascii?Q?aw02zSQtX4Y9ltpfut1Ux568sXNYwlz4tNMjyphyvUpIh/0QqO5BWscfFcuB?=
 =?us-ascii?Q?u+Y9kIetCPpEvIvJj84GRnpepX7FEbgvQmhRWnyU3yU1grW8lN55GTsirE11?=
 =?us-ascii?Q?oXRzzNJJHWKYptpSnlbqnDFQbfxwh5objPxexDxHd07wUvVKVyyb2e7NoWVi?=
 =?us-ascii?Q?5YLrjTaP9AWUgxn7eGHODC4JyD13tarIbsG5hA6BZLZP62ZA65jxBl7DjXm/?=
 =?us-ascii?Q?UQ6h0xLM1/k1xcQMj4qkEEGChg3nyZzz5iy2Gwhwh3WaL7FpXIaJ09QmphCz?=
 =?us-ascii?Q?Ql6/Fabg/+SQF1iZxrHQHzlBI0Ve3sN+DEksM8VQqZFuCw/XzvJNqwM24lEZ?=
 =?us-ascii?Q?USTJYOU/bxm6rjfcrnjSww4GLUxp6SDSw9DLRQPXAbq60NmHb8x7JByy4FHl?=
 =?us-ascii?Q?mjiBmrcJ09K4/iN6Hrsh79dzOaraZqIvABNEJCqOgSw4ekLu0ikijWD1Yg2l?=
 =?us-ascii?Q?m2mIHewXADubN8s7z0BLNNEsubs6kQV6+R1Tba5Srd12bSyK3mXI7pX9xr5+?=
 =?us-ascii?Q?xEIzNNebqyjbN5UblBtSLV/FxSIOr1w+dZ8tHmJGT7hn8J6sBaBdlAFlk9Xp?=
 =?us-ascii?Q?fBqeNmer2NBOChsN73SBTI/9jJVk3l6c/L7c7Frrl8I0wIfxFiDMpsJFraUY?=
 =?us-ascii?Q?dF0HnPfTnnffPkQ/RaYA7lSj4JJPUXXgfKMfb0orbuGYEzs2Uik7z8bqjU5Y?=
 =?us-ascii?Q?oA7TL7Y/tzqF4BR8kg8Gz5QPOKDM92V11MmRRhj2LrevkQUT6nP1jmIBSi10?=
 =?us-ascii?Q?3giZ6VvCpGQ3W+09TQugOzxacKPP/4xl+BjfrtKRK03kMmj69dmx1phghdcp?=
 =?us-ascii?Q?ojJfLIiijEQjq6zFoQIQtxqyIImKfu/xa8nWgG2M?=
X-OriginatorOrg: ni.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 979416f7-9a75-4b4d-b063-08db86e81df8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR04MB4496.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 17:06:10.3382
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 87ba1f9a-44cd-43a6-b008-6fdb45a5204e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CoIxJv/cSvvYu26cWyYvLEMxGYkkDfzA3+7Eyk9Du0wlEZuiaTbnykFPr7txtF5mKFEBPCnJh8cg+x4ITrHTeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR04MB8201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hardware based on the Bay Trail / BYT SoCs require an external ULPI phy for
USB device-mode. The phy chip usually has its 'reset' and 'chip select'
lines connected to GPIOs described by ACPI fwnodes in the DSDT table.

Because of hardware with missing ACPI resources for the 'reset' and 'chip
select' GPIOs commit 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table
on platforms without ACPI GPIO resources") introduced a fallback
gpiod_lookup_table with hard-coded mappings for Bay Trail devices.

However there are existing Bay Trail based devices, like the National
Instruments cRIO-903x series, where the phy chip has its 'reset' and
'chip-select' lines always asserted in hardware via resistor pull-ups. On
this hardware the phy chip is always enabled and the ACPI dsdt table is
missing information not only for the 'chip-select' and 'reset' lines but
also for the BYT GPIO controller itself "INT33FC".

With the introduction of the gpiod_lookup_table initializing the USB
device-mode on these hardware now errors out. The error comes from the
gpiod_get_optional() calls in dwc3_pci_quirks() which will now return an
-ENOENT error due to the missing ACPI entry for the INT33FC gpio controller
used in the aforementioned table.

This hardware used to work before because gpiod_get_optional() will return
NULL instead of -ENOENT if no GPIO has been assigned to the requested
function. The dwc3_pci_quirks() code for setting the 'cs' and 'reset' GPIOs
was then skipped (due to the NULL return). This is the correct behavior in
cases where the phy chip is hardwired and there are no GPIOs to control.

Since the gpiod_lookup_table relies on the presence of INT33FC fwnode
in ACPI tables only add the table if we know the entry for the INT33FC
gpio controller is present. Additionally check the 'cs' gpio handle is
not NULL before using it (like we do for the 'reset' line). This
allows Bay Trail based devices with hardwired dwc3 ULPI phys to
continue working.

Fixes: 5741022cbdf3 ("usb: dwc3: pci: Add GPIO lookup table on platforms without ACPI GPIO resources")
Signed-off-by: Gratian Crisan <gratian.crisan@ni.com>
---
 drivers/usb/dwc3/dwc3-pci.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/dwc3/dwc3-pci.c b/drivers/usb/dwc3/dwc3-pci.c
index 44a04c9b2073..780984b07437 100644
--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -233,10 +233,12 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 
 			/*
 			 * A lot of BYT devices lack ACPI resource entries for
-			 * the GPIOs, add a fallback mapping to the reference
+			 * the GPIOs. If the ACPI entry for the GPIO controller
+			 * is present add a fallback mapping to the reference
 			 * design GPIOs which all boards seem to use.
 			 */
-			gpiod_add_lookup_table(&platform_bytcr_gpios);
+			if (acpi_dev_present("INT33FC", NULL, -1))
+				gpiod_add_lookup_table(&platform_bytcr_gpios);
 
 			/*
 			 * These GPIOs will turn on the USB2 PHY. Note that we have to
@@ -247,8 +249,10 @@ static int dwc3_pci_quirks(struct dwc3_pci *dwc,
 			if (IS_ERR(gpio))
 				return PTR_ERR(gpio);
 
-			gpiod_set_value_cansleep(gpio, 1);
-			gpiod_put(gpio);
+			if (gpio) {
+				gpiod_set_value_cansleep(gpio, 1);
+				gpiod_put(gpio);
+			}
 
 			gpio = gpiod_get_optional(&pdev->dev, "reset", GPIOD_OUT_LOW);
 			if (IS_ERR(gpio))
-- 
2.41.0

