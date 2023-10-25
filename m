Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31BF07D7877
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 01:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjJYXUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 19:20:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjJYXUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 19:20:17 -0400
Received: from CY4PR02CU008.outbound.protection.outlook.com (mail-westcentralusazon11012006.outbound.protection.outlook.com [40.93.200.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1EBFDE;
        Wed, 25 Oct 2023 16:20:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKD0Cz/7MOdVcKOBSUIwb6zT04/J/wuCpn6mGeYFtsQb2BqiadsIV4RcNiyIzPMAqWB6554bGAuAtAR5k6hCPXRFPGGUB1NDLFXALYmEyBOoZNR+Rf3kTeXUur0qWdQ8NXeC1WtH9dcQBiYOcnTsIO37mt66rmrbpEKw219zdpgO7MCUt2EkjnKgFOHLb6WHlYKjcb99PpK3jrb3MPLW4BKahly7agxXEWp6uhT/EIz0Gv9hTAgw8pU2NWKul1IyqnbpSe87a0Co4cIAYpBh3sf9bi1TFfvnvo4iXknP9ycWAHmebqCsrVW/sts9L6HOv1i4PD/nY1EfiMYaeJJFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EVkIsCgEvW+/Kjnyv/a2pfewJ/gBjvEG37FVKA9qEck=;
 b=lJDsji/nYnW/yQU0OKxG91XZmZ1dVnB5NIq6DDKpTw9HnzoNL8FMVRZdIIRiaa9bzs1Hdqqhi4QHgBakTwyheKJGWEh1RGWPyJCVl/+zLt+i7F/rvcxIBM2OlWuJNCUCaBPWRDvgpmjHzowuFwpEvi5feFOth3VVMvpRQxlECg/N91YBSfrdr2jgG3556Tl+g3Ihv4Z7b3vjB76z6Pk/W0mFg0kn9u+6jStZNGD9/qbyf7BMIdPD7t9JS3/CeQn+kzHRNTVE3jGO+C/yP6iUCs2uyE2DdJ4lUqmvYIpJOKlhb2EO3sFvQ2mh7WFm6aK0TKc0lQYAgsb+400fqtDnJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vmware.com; dmarc=pass action=none header.from=vmware.com;
 dkim=pass header.d=vmware.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vmware.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EVkIsCgEvW+/Kjnyv/a2pfewJ/gBjvEG37FVKA9qEck=;
 b=n19ZZTY9L52BKDKgh3aIUxwlmCTTw7mC4zJe9jT4FaJWaENDAMrm2S6Af3Wptaw35iabMeTmkVG0sP4jSfD3L6OuD9XvLC4MQPRubTJ243G3/DSsOLjuSKWyoDQ1f6WvWPw6+YadSkz1n3fhbciUgN4S0MjVleYv5heOs5sDHkQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vmware.com;
Received: from MWHPR05MB3648.namprd05.prod.outlook.com (2603:10b6:301:45::23)
 by SJ0PR05MB7456.namprd05.prod.outlook.com (2603:10b6:a03:288::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Wed, 25 Oct
 2023 23:20:12 +0000
Received: from MWHPR05MB3648.namprd05.prod.outlook.com
 ([fe80::b1ad:1c54:64b2:a39d]) by MWHPR05MB3648.namprd05.prod.outlook.com
 ([fe80::b1ad:1c54:64b2:a39d%6]) with mapi id 15.20.6907.030; Wed, 25 Oct 2023
 23:20:12 +0000
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc:     richardcochran@gmail.com, jsipek@vmware.com, akaher@vmware.com,
        deep@dshah.net, pv-drivers@vmware.com,
        Alexey Makhalov <amakhalov@vmware.com>,
        Deep Shah <sdeep@vmware.com>
Subject: [PATCH] MAINTAINERS: Maintainer change for ptp_vmw driver
Date:   Wed, 25 Oct 2023 16:19:31 -0700
Message-Id: <20231025231931.76842-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0019.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::32) To MWHPR05MB3648.namprd05.prod.outlook.com
 (2603:10b6:301:45::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWHPR05MB3648:EE_|SJ0PR05MB7456:EE_
X-MS-Office365-Filtering-Correlation-Id: 5742fcf3-b2a2-4490-9e7e-08dbd5b0efab
X-LD-Processed: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: XGqqRGMUwVlcYFJcH3GBBJSZgWtvYRWwBxSucg4qt8ERNjspwEsEmWvqbBrYxQBbGNe6aHCTCh8I1y+vS/dXU9c+Uz4/owvIdbD2O9hXcWmOQVpjsEKtuqj2oSW6Lll3WDLKiNSvA8ReolAwa87IZ8+XmeCcMEkU7TbzcCkXI0YohxT/WgL+IM5v7XFVTil4KcjSndC40OE32TRDPOJp1B4mSle78NUBBH7oQcvG15JSmnF3NSmfEmqkOk0+VvD8cc6DOJdwV9EByt/m7g77Wz4GCMKFk7qU1pg65pDe/qETn3wDCpfDTPLG3El3ZC7zmu6I+P6fOLlndr6q7gMbh3EmHOzSsECLqkFZQqXEDMxliBAJDf/gLJZdvoXxj+Ly563Iobeaf2jTJGG3p1qccBjy4YUBMLMjvlbJ+tt5zrU7QQCmri7lk/oCIzc3p3Jwnwh2MEi0fvg8oD+dcnhNzfciR2EnDZve9eCzONkCAKTznmQBtqnfo5feJ887N5WS8hwo657I080DVUYjA8Dtn8Z5KGFMsMaNbNRIDGimlWGHoUesDec+Xf71rVQcKWpxDKg4R6M1XL58UlChWK1qcXk1m6TM4nfyK2daayrtcX+37ykBcAK9YTj3RTkZaV6TPRS4YavBSWjktgpOccinnlu5FkXVB3UjodG+qPEfVys=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR05MB3648.namprd05.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(366004)(396003)(346002)(376002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(66556008)(41300700001)(66476007)(38350700005)(8936002)(66946007)(4326008)(54906003)(6486002)(8676002)(4744005)(5660300002)(478600001)(1076003)(86362001)(52116002)(2906002)(6512007)(6506007)(107886003)(26005)(36756003)(2616005)(83380400001)(6666004)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EJRxQ0X4hMsiiD6ygEeIxMuaNGaALmV4NceNTxZcAN3BfZxZsjCqORjNoLDG?=
 =?us-ascii?Q?kUkWz/GWduwRJf2PHoPQ3SyYHM9Ue9edrJUv7v4kGvrR+joipuOnRT93KnZn?=
 =?us-ascii?Q?j/s+sZ0Wm/ur2+XOyMp+FH/ZZCg/cfgrK/ecivzcFyvobpt2O2i7AX86tu3A?=
 =?us-ascii?Q?PCMYovkl+niPtnWAknWmRHYUyo5Fu9bGz8X/pv310o/Om7t++m0WUqM2/XI0?=
 =?us-ascii?Q?fZseyGdczZZl1ylBZTCDiHGIO68nPJE555ZCVxQJaGk7X15ml3lcmugWR7TW?=
 =?us-ascii?Q?0ytzDk9BFbTWUrznLNQB7+KAvwsv1wRc5/Cf7qpMA9sWKzCcWx8MUd4Phlhm?=
 =?us-ascii?Q?A+djM9z3IGd9zVVRgC/KyKgXHmzjuTHVHaMSrKlMLU3ftcUQCDBXm3BgRdut?=
 =?us-ascii?Q?vRxKcvY6ELe43bMQN5u6oloi/Le4hHniRW0JBNviw/TxjRmK3kCstGCOvSZn?=
 =?us-ascii?Q?layCU5QH4MseOqSAHwKV0hDIorTvD8VyXpSYWLQ0PiZC9CHCQKh8i5tFF2co?=
 =?us-ascii?Q?zKq6iz97GabusRA3mzSC1ShGE8wG9/z41stpz12km83ilMXSqH0XKG7Stazm?=
 =?us-ascii?Q?fRIL7LBTJ6keHSUsbom3Vf+xM152V1DuJ5L/c1wHo50jUTkY3//BQ+rit+70?=
 =?us-ascii?Q?YjYGXw2+8+4sebOhqS/btrDZGdGDW1vCauyEm0axLB8a7DuggGgndamMZq0K?=
 =?us-ascii?Q?FWeoxSxGfkFtMOsCjYtwmllTaYDx+dUAA683MeX4dX0K2w17iqssWB1LG1hB?=
 =?us-ascii?Q?wqU1c99PMM3UWxSekVs4sm0EzeDjtee03EB5AQ53+vHqUA+nqPQQp9Rc5p/E?=
 =?us-ascii?Q?2Z6LusSjWdeC+ribxesCmrfbT+2o61DpncmezjVILDG9p2BDyMI18xeJQwVE?=
 =?us-ascii?Q?8DKNzn6pPfSz7hWcO3gns4wORuZqEMyI0BfPQAO0+w/BQtHFJTr57qveHh/d?=
 =?us-ascii?Q?/JGe2r8uxS/jC8ZcOtUW9TwZ1SWjMYh5cAeuyCSyiB4A6ZdGVKMKsNUEfSS3?=
 =?us-ascii?Q?uy0prtQ+17wBednT8tksqNqwK9D1cEWho/vbA9GcLIlnIfqVeLdi5FhwAtmx?=
 =?us-ascii?Q?NpJVYJ4qGN4ehGI1EQmZyyVBMVpKBcDO20wQmVubfGyZN6cRTpwrHcvoIApt?=
 =?us-ascii?Q?ZNvXDwDQwrKfPd7SLJZ+RJCC8Lf1/NYiUViDrsFMUr/O8j0ta0xB4nwqx5Hp?=
 =?us-ascii?Q?jaQPwnKfxRobzWmcVDLj1m8Ka4b+YToZ5YDRP4vz3L+PaTivIIDBriBpVNfD?=
 =?us-ascii?Q?nPuO6KFLhDwFq8ye0o/WnBtC3jXvs9DMqGS1qtx7g0fxkGjLqoqvZVtZlAsE?=
 =?us-ascii?Q?C8YG9IQZqREBK+07I5zWwcnFSQtwH8VlPucBjYZgzEOSopxlrNaHSaXBz3kY?=
 =?us-ascii?Q?+CO4rGW79n7jijq03Vd3/NweP79FgXoIzUeJXH9/9HzxAUYzJPjzRb2b2at9?=
 =?us-ascii?Q?L3CyPS637z3wbjBuTeRiC39CN99i4TX6ghumkRWSGYzOL2Hhg3wCtlcuqKss?=
 =?us-ascii?Q?PYr6VkRKdZkTsddrlXJu1pTvHnazYLcIh6ohEHdJGdwDkYYGONW6guWfIxSL?=
 =?us-ascii?Q?QtpyWAXMoiRmGVu2ghDl5tyk+JrR89ElhRJ4+XHw?=
X-OriginatorOrg: vmware.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5742fcf3-b2a2-4490-9e7e-08dbd5b0efab
X-MS-Exchange-CrossTenant-AuthSource: MWHPR05MB3648.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 23:20:12.1302
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: b39138ca-3cee-4b4a-a4d6-cd83d9dd62f0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fiCDp9XzH+TnTCydarLiaAu7O/6xcONsdanrg2GS7L36hJ+wDaiN1Q1vGe/QvUjj+TcrOWEjwwUyvKdGEq3/LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR05MB7456
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Deep has decided to transfer the maintainership of the VMware virtual
PTP clock driver (ptp_vmw) to Jeff. Update the MAINTAINERS file to
reflect this change.

Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
Acked-by: Deep Shah <sdeep@vmware.com>
Acked-by: Jeff Sipek <jsipek@vmware.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 668d1e24452d..d04a1794c804 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23035,7 +23035,7 @@ F:	drivers/scsi/vmw_pvscsi.c
 F:	drivers/scsi/vmw_pvscsi.h
 
 VMWARE VIRTUAL PTP CLOCK DRIVER
-M:	Deep Shah <sdeep@vmware.com>
+M:	Jeff Sipek <jsipek@vmware.com>
 R:	Ajay Kaher <akaher@vmware.com>
 R:	Alexey Makhalov <amakhalov@vmware.com>
 R:	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
-- 
2.39.0

