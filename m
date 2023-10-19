Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4A17D04C0
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 00:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235543AbjJSW1t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 18:27:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231238AbjJSW1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 18:27:48 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2080.outbound.protection.outlook.com [40.107.22.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 003DDCA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 15:27:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Lj3EsRzpLJ46nQha9tICQUZTGmt9uDZnfClGevI9xiLkbRXaBJTpXXFKHejiNsZzP0rAHMheQooPiLRDruOFiql+lxOl8c9/OIEKHuITCaXENbrb70VEnDXmww+uUuW/JfQp/YKrrUvBhoWy0npjgtQ5TOC/fbTPwT+0uSpi1w16qOt+TzEdA7oZCZCPMQDbT7Pugeeh0arE/hBTW5bup2oaFpCIa0VycDelFDkwh7XE1mgjjLdGu+BhG5CUxDJgFTsyzXu539E83aWOpruD311SD4Y10puVDZUbOi2IQfYUi/Lg7mnbuf9u2lh3h7wTCFFqMkzyDZaeto7ZLQetKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kpqvn7Saipv5UhkeKE6LZMupYPezxDUL+/aJ+3yl/fA=;
 b=VUswl3x9fcdbqNq2oZkvpXWl/N/vjWQKuEVYJEZ2THeCUHGmarNlqWDzSATlj/okA5TdIup8D9tLBSggm/izLvhL9yJ5IGFVhmT6C08jNOyhfR0CkYvqpuGTt1Wk7u7qDhhNKDVHZuzugltnawTXuGBBkAkhXYketMvBQW1uJuy0/rbpridV67x6EzcejqmmbWE025uRk3+jKslrcz/1ULnYbi0WZEzBfyE0q7c4DLn9OAPOqim7arwRGBXtikF+KXRCQ20JW9WP30RUz1XlbTV0aIvaDapAZU5UWFMGyq6U5lrSlqS+zks9k9Rdp3uhE3+7drLU0UHx+ZdbxCcQOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kpqvn7Saipv5UhkeKE6LZMupYPezxDUL+/aJ+3yl/fA=;
 b=cPoZm8WY2ws+wmmBjex8UGBtF2wVUz/o8A9WkfmdQDwXUvO1sWFjZTymAM+nL4B8W2GzJFZFQ70mMFpWX8mokFN/XiaZ5KSL6nHYrS8ZecOAain0svatIhgB8ECXC0tPLHJWNwRXUVQ7nFA9xBjT1bH944pXcLcVuyKPYfIr19U=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com (2603:10a6:20b:4::16)
 by DBBPR04MB7708.eurprd04.prod.outlook.com (2603:10a6:10:20d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.10; Thu, 19 Oct
 2023 22:27:43 +0000
Received: from AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2]) by AM6PR04MB4838.eurprd04.prod.outlook.com
 ([fe80::1774:e25f:f99:aca2%4]) with mapi id 15.20.6907.022; Thu, 19 Oct 2023
 22:27:42 +0000
From:   Frank Li <Frank.Li@nxp.com>
To:     miquel.raynal@bootlin.com
Cc:     Frank.Li@nxp.com, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/6] i3c: master: svc: collection of bugs fixes
Date:   Thu, 19 Oct 2023 18:27:19 -0400
Message-Id: <20231019222725.3598022-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH7PR17CA0042.namprd17.prod.outlook.com
 (2603:10b6:510:323::21) To AM6PR04MB4838.eurprd04.prod.outlook.com
 (2603:10a6:20b:4::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM6PR04MB4838:EE_|DBBPR04MB7708:EE_
X-MS-Office365-Filtering-Correlation-Id: c11762b5-edd0-4226-eca4-08dbd0f29bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rSti9og5khwPNzfp7//WcqW9TfugCZcnwwPFOo9xwag/Vvf0Iy4sZaZO45wfKb5QrlaMI9iK9MYqdlRJswj4rT/5V+mgJN3+WeGzcr75s8ffTNhf4Ch5gqMyuwObXMfn8sd7oUA5EgMkBZJmDKgCIOc3l47iKgiIrLrlliIyviSeAgRrvKnVas4zSGtIJFvtzgr0tGIXrtbD4xtTk0N2ZYhzWzEF9X0g1kvGZAMANGHad6IyMAhmCVRuWpgAEniu6xyblnm+hvBKI6sljuH2mNGxHNZF/UGw108ap4WCgFpeiblifRNGLlvRyC7b0sqPW9AEhXDe4N8L2Uj+dGsyu8Snck1/2uzSx5sadaqZOtA2k7I1gUVcY4UaFvNHs23KGqbmjq6RAWCpedArfeHopEmeK3yKl+WBuBM6uAkvi+d6RmzrLUVxT/wLDaNw0iMX/4koS5FdupCaTsFPbnP3E8gGiUWBOc9pRCByNbNHlysYrHTbFofm9cN9ks+XYd1h7oqqLFKAdgiKgn7hlno7+RY6n1q+ZaVdvmjZ/L/hXhIWHZGzt5cDKBOq89XgpuCjXJYSkUKVm8c2riBVcgUD7872KLjQf1aTWsoVMGDYT9ngosuIx+z1trWskIq6re4WEJD/MtDS4kIKQ+lIhRW+tHE5JRAcZQVflZz7HKzUsSw=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB4838.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(39860400002)(376002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(6506007)(83380400001)(6512007)(38100700002)(478600001)(36756003)(66476007)(66556008)(66946007)(316002)(6916009)(86362001)(6486002)(52116002)(2616005)(1076003)(26005)(6666004)(5660300002)(2906002)(41300700001)(8676002)(8936002)(4326008)(4744005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OUd5ZUdRczQ0bVFDcjRDQkhZa1NrWW5Vd1A2Nmhib2hKNTh3a2d1bHkyWW9v?=
 =?utf-8?B?ZG5YSVNBZGtUSXpOV1UvTTYxUHFTMG52dHM3dlpHeklNejJ6MmQ2WnJJUE0r?=
 =?utf-8?B?V1BTcjNabERadFVqcVh5TWtndW1kMWhLU0V2VlF0UHRVaHRRNk0renJBcGJ1?=
 =?utf-8?B?TnZTdUk4TmhFVmtaVmU1TmxXUXAvQVdRcHdYWEdEQjdrZzd2KzQ2czg2OFMz?=
 =?utf-8?B?VHIrRkxVRUdXREFGQ0I4VzdER2U4MEZvdHduWDZJeit5WlVMbzMzbVlIV0RI?=
 =?utf-8?B?T3JOci90L3c5YWNIR21qV0RCRStTTVU4dG50YXVZUzIzOEh6RTg5YmJxYUEy?=
 =?utf-8?B?aTlCTWZVM1hWSXN6eGRVOWN4MU5PbzNZcFJxZWtGbDlXVlNGbG01aGZiQm5O?=
 =?utf-8?B?dHFvQm9FejRxQlRVZXlucFp2M1VDRlJiWHcwclhUSFg3ekFkUzg4K0Yza0RB?=
 =?utf-8?B?aWVFOWp4TVRJNStuekFnZXN4Ny8zRUp4NmRvSmZzR3F4bUVjNml0eURNY2g4?=
 =?utf-8?B?VTNIdHRLN0hkQ0lBRnRpNllEM00xMmtNbGhmcWZ2eEswSFVKSWxvNWs0RE9I?=
 =?utf-8?B?a2E5VGxYOE1xcFFWRjVyNnBJUVR1OVFSeVBhTVU1MjN0RjV4RnJ0TGdlZFpp?=
 =?utf-8?B?UVRJSnRBNmJxTktqMGQ2OUd6bnVObjhwSEw2U29TR3RBUE4xNkNIOEhvTm5Q?=
 =?utf-8?B?aHBLNnF3SG1kUXVFNnlUVWpxRUU0NGhMOEEvRndUSzZ6cVhrZ1M1SGE2T3Nj?=
 =?utf-8?B?Y1pkUmZsd0lRZkp1eFNGSFBqZVdVVkdFVW9majFKZjhsRHlMOEtVVHlvOTZY?=
 =?utf-8?B?bzNvTHBNWE10L3daUWdlY2MwNG9NKzYvTUtrcHdDZWdYc1NCd2hWVTVxb0hw?=
 =?utf-8?B?UGtDYTMzUXFodGx3TmxoZDhaRCtuU0tDRHZ3L3dUWTJEcjVZdmFJd1ExL0FY?=
 =?utf-8?B?UVF1V3lZdGFCa1lPMW9QTHRhdG90dHlJc0N2ZW5JY1VxWUxTNFhSaTlRek5J?=
 =?utf-8?B?M2JtOUVvMEhnb3hFQm04ZHlzb2FadVVYSW1kSTFwTnpnSE44Zy9VMUJkNEoy?=
 =?utf-8?B?T3pwUnowcHUwMTNVTG5NYVpEUXk1cFNLU3Y0WkppRTZYcmZoam42WHhjNlVI?=
 =?utf-8?B?TTJYaGZMK1Zka28zYkJpT3dNcVo0YnZVamEzc3p5WWhqY2haeVhDQ2ZHU0tE?=
 =?utf-8?B?UzFhTmhQZTNjdE9ETEsrYS9TV2l3eisya2ZWWldSTDBJdUFyTHBjZm9wTkhn?=
 =?utf-8?B?MjlhZW9aUzMwM0hVeEtwVTk2ZllpMG12amU3cWZncXFDd0p6MUlmeWJrc2FX?=
 =?utf-8?B?ZUtUVlJSN2FxL05lS2tUc1NhcUkyN1M5RTF2N0xPd0hIckMxS0V6aVhINXIw?=
 =?utf-8?B?MkVKMmx2YzVnbmg3NUlURkZpZHJpdGp5M0kyMHcrV1FhZUhTZVZ5ZWpLUG96?=
 =?utf-8?B?QjViNjR5VDY5SkdONzdpbFZIOENxM0NtK0g3cXJDbWh0NGNmU1Z6RzVZMlJU?=
 =?utf-8?B?SGFHNjRvUjJidUpzT1Nzb0JNYjcyS0tNNVZ5ai9XcjA3eGJicFdPWWc5NDVz?=
 =?utf-8?B?N1cwVGM0TTVHTmJHR0xsM1loZVhzZkpubjlNblBzWWpyRUZRdVhJYXZUQkp5?=
 =?utf-8?B?MzJQSXpYMjh2dnJrQ1M5SWhLWXUxZ2F4YnNaUlhSaGNNTkpTSkJ0SlAyVmdZ?=
 =?utf-8?B?Q2huZ0FzMWFrMGRTVWdOVXFmOVRvL3BsNjJlYmZ6bVl2cmZVdHFaVVh5NVdN?=
 =?utf-8?B?V1BPWmhWbHJITGptdm1XQlBTZGxQUmJUT3hBVVF0c3pOOEs1NzVEQzZwcFFI?=
 =?utf-8?B?cXNlQ1R2RU1GYnIxNjBJNGo1b2d1OWJsRXpKN0xOVTRjVzV5emF3SW12V3Iw?=
 =?utf-8?B?OUdvVFlsd1B3S0lxZHYyREFCM0VRUldFVGk2ODRjeHR2cGp3L0pIRXRSbW1h?=
 =?utf-8?B?ME5wRm11c0ExZG1zQWhnNU1YRVBlYkxRNWFCQ0JnamR0dkY4MGk5ZjhlNnB1?=
 =?utf-8?B?ZGROYmF1QVhGTXgyV1hQdGY2UzhjS2NlQSttY2dsZXk2eXJSQmpkYkk0elVx?=
 =?utf-8?B?STRhMUdYb3BwYnhUMnBXT01KQS9XNElzdExPMkQwYlFZS2xmQkZiMW5JNEtC?=
 =?utf-8?Q?JNKU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c11762b5-edd0-4226-eca4-08dbd0f29bb8
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB4838.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 22:27:42.2315
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4SOB3TLqkmxd7qk6oR5DS/+CkCk60uWTXvSeyr5ChMNV5g9q8/N6QxoMxE4lzwHG+1xskWti3hTOJSV3L5APg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7708
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each patch is indepedents. See commit message for detail.

Change from v1 to v3.
See each patch notes

If there are notes between v2 to v3, that's means not change.

Frank Li (6):
  i3c: master: svc: fix race condition in ibi work thread
  i3c: master: svc: fix wrong data return when IBI happen during start
    frame
  i3c: master: svc: fix ibi may not return mandatory data byte
  i3c: master: svc: fix check wrong status register in irq handler
  i3c: master: svc: fix SDA keep low when polling IBIWON timeout happen
  i3c: master: svc: fix random hot join failure since timeout error

 drivers/i3c/master/svc-i3c-master.c | 51 ++++++++++++++++++++++++++++-
 1 file changed, 50 insertions(+), 1 deletion(-)

-- 
2.34.1

