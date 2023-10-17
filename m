Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242377CC14F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 13:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343667AbjJQLAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 07:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233570AbjJQLAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 07:00:19 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2047.outbound.protection.outlook.com [40.107.249.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1CDA2;
        Tue, 17 Oct 2023 04:00:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MDdlg/N8ajOjuk2w0hWM882kceqq2yM0x3YhjX49gWJjRxo2OvuQ71F+eNz3OJaR2WWX2u83TOwrHDdu6OockrgYT4qcV87Q4v2sP/bXhF2Q1Jttg9AjeZoKbg4BBdnOfT1OJZRffDeyMJj0UAEk05+8ZzHqafCM+OItQCZ9d3iMXCkAUYFihIIe1tUn4dXAHw+1mmyRzCBfnNDze2uk77R0os1dKz+RfJ53iCe151C07v2du5d9lRGq5EyiI1RT/lWFCd8k51/3I+7PmrwzmjIcO11FOJvnHbSpfKvb+KK4fxuGtJiR75p9Sh13a16k6N+cD1OOHpBepdMc8s0dAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lqvpOZgVuqAiTswabysgNNArqeLq+Bv8x8Yr9bv0T3g=;
 b=OlExJ7KYM+3f7yciZo9liZWcdCVa/7glPnAEL+bGMDWDizwUuCIB0DAYJ4eyR4mOdSL/WCDzJ4/OOfZFLbxrt5u3HFnkKagAcaZhPJ9ZcM38EYK1EsN3ir6AbfkfUA+pNNMAilVHtl1hq994yrXgLQZ6vJA5Z5iE6WKg1PoR9EKtN0g9KPuWs7bgNligWS4BMh+hz9z/yk3QeCrzi7g8ZnurysRjUXeGAKUcaKhj/39sPQPKJQq/+AnMelziaGge3n2whzAeJwxLhrD/KNsH6Ji1MQHjcW1VyXQrs5QsawJk6Bkq2/xG6jBWDSnJ2cYNl2KeBjRNPnVMvrhx6o/h0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lqvpOZgVuqAiTswabysgNNArqeLq+Bv8x8Yr9bv0T3g=;
 b=ZK4XaJ6zbQ2+HOTZXCdURJY1WHi4PlNoQb+GwEe+D4Vyeb5MAsw9bb3wYfbdz8OhGH997n6J7vww7FbMQ1tGTygyosf82SUVxneWnwGdAGI/zmA2PakAsTPczP76j87/M7T9i8bD0NYpqZdO2lEojVwGpYzirQPdIKjl9ZxtH00=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by AS8PR08MB6295.eurprd08.prod.outlook.com (2603:10a6:20b:295::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 11:00:14 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 11:00:13 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v5 0/4] Input: support overlay objects on touchscreens
Date:   Tue, 17 Oct 2023 13:00:06 +0200
Message-Id: <20230510-feature-ts_virtobj_patch-v5-0-ff6b5c4db693@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADZpLmUC/43PzY4CIQwH8FcxnBcDDB9mT76HMaZgu4MxMwYQd
 2Pm3Rfc43qY479Nf22fLGOKmNnn5skS1pjjPLVgPjYsjDB9IY/nlpkSahBGCk4I5Z6Ql3yqMZX
 ZX043KGHkqKwzWgCg06yNe8jIfYIpjB2odqt5CrK3bgkpfr+2Ho4tjzGXOf28jqiyV1fsq5ILb
 gAN7qQPyur9Y77S3wfbCQvrclVrNdU0sjuwntCBoLfasFYbmuY1eUdBe/DurabXarp/GmwQFCT
 i2f7TlmX5Bf98YMrKAQAA
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Bastian Hecht <hechtb@gmail.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1697540413; l=3347;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=9AhahKLvQy2iVxKfLpup2HNG8zrmddrtnSjz+rr2NvA=;
 b=YFEoWxw7yC+jKqzzs4O8qoUMoZGkdCw7936nEyy4a+9rqZ51TQUjDONdYLozfHdfRCc6txNbV
 eD7DQ9BgteCDw0nfusxxCox3vcC6uLjmTP2HsneUvBa9OrB8t6Xjnxt
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR07CA0250.eurprd07.prod.outlook.com
 (2603:10a6:803:b4::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|AS8PR08MB6295:EE_
X-MS-Office365-Filtering-Correlation-Id: 77f4ae82-a160-45b2-251a-08dbcf003d3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QsI++GwjyAGvuXQfyOmT5vs60PRsqLBX7925lutAi2+n901BQn4rT/FeHjVkt6/OswwaR7LMadkHsrQ8qaKzuWZqcd+kV+L9dlQ9BLDW8OQQ5RQpzzWbmsnfNtGHsXlCormVZsycd/a/AurraCsZYAulk+e+w43Rpf2qSpaFAo2jq9l9jVNftxgmGr09orXi96qdZZKXAcq7OFzk0S4RTJH8hcznidummgN3JxKNvOrfEFFmHcBN+FC4TXxUwDD0m9V1qpWHqCbC2qCNrMlcLSlaRg5Q93n4hUrLJDAChpWvOkF07wFJVGgdI8Fak0fE+eBw4UUSNKrZBWYw6xNtFeg8tk2hw1yO39/yxWef3j3cAIczlVb6bLX1AoQgU2U7g83IdsK3LOXYIfRrCJQ5PE32OYqSwVyVQG+5IHOp5HSFIFKZBCIMBGoj+ssVL9jokgFy0jRpOf9oWlC9Z0BU5V+QG91GGtt/GCIKK4mKxewLNe5yPTdlyDMF3uuHARd9vIKZdWohs9R4e3yHiRKvA+YUrmPK9d6YFAp8zIpdLljFLWELJIIfyi72miyd/pDRfUd0iLD4baykSNxAdKib2kYTe/Gah6KmsbooiUQqVjs=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39840400004)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(107886003)(478600001)(38100700002)(52116002)(6506007)(2616005)(6486002)(38350700005)(83380400001)(26005)(966005)(6512007)(6666004)(41300700001)(66899024)(44832011)(5660300002)(4326008)(8936002)(8676002)(316002)(66946007)(86362001)(110136005)(2906002)(66556008)(66476007)(6636002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0ZwMmRMY1VMZklqdktaczhzd3piMkd6U2p6cmRmQ3J2YWhrQUhkcFhDaEh1?=
 =?utf-8?B?T0FyUGFRVU1yNm94QStlNzIvaHMwQy9JL3Bzb1huclFRVWZGUCtVK1J5MXo3?=
 =?utf-8?B?TzdnVFEvU0pQNE1LeGI3eDhjUG5UT3drZ0hLUTExYWJDL3V3RHp4TnFYYVRw?=
 =?utf-8?B?UkR2M2MyVzVyVHpJWE5Fb2ZRc0h2N3p2ek40dTBiMXdlNGpsb3BvN1ExQUlK?=
 =?utf-8?B?L1gwZHlkMkZnV0tlajJkMDkwVzNjQ2VrSUtNK0FoakgzSVdVaG5Bdk1BQmN5?=
 =?utf-8?B?K2NDck45NDRkZC95WHBtNEJoMERQbGxNMkV6MUZaY0ZNM0VDbCtPTFZzeHIv?=
 =?utf-8?B?aGhDZkhOMTlYL0pMTkhOb3psM1ZLeGNzV3hrRDJqOVpHVHdoY1Q5TTB1Si9y?=
 =?utf-8?B?Tlh4M1AzaStkT2FSSUxqRDlHdmNibWRTM0tmeFlBd3gzdkkzSmo5WkJIWk1W?=
 =?utf-8?B?YzYxV25YQkRHZUZQYjI2SWovOERqTVplcmRBTlpVdVJsUzlQWnlxV3dLL3Bt?=
 =?utf-8?B?SWx5UmFhaUNTQTMzbFl5ZDIvZ1dLb0tyRW5IZ1J2SjRpRExUc1A4bDRHbDFa?=
 =?utf-8?B?dUt4dzVBQzdxSkhRQ2xCN3ZrcDlrejUwRDBqMjlLSkp2QzA5MStsNXdiRE9F?=
 =?utf-8?B?aDgwa2w5UjBSbEpVb0F2MDExYVRkdkh6dko4MWdLME1wNDIxTmpyMEpEWkhK?=
 =?utf-8?B?Vkh3UCtCTER0VllsdjJtZVBGNHBKY2hEWnhENkdhdHk0dFg4TU02QlUvV3ZB?=
 =?utf-8?B?c0FYZ08xS3k4enpuejJiLzVzQ015QzdoMFFWZENvL2Jrb2s2VTRrUElJSG5X?=
 =?utf-8?B?VnVUZXZpRjg1K09XVG43TG0vcW1aU0dkSDF6UTkzQlZWczAyZzJNUk1nWjM0?=
 =?utf-8?B?T3VsWjVuMEJIYWI0RUNiY0xRSldqbGxKMzFiTW9MNDV5M3JhYVVJVUJVUmYw?=
 =?utf-8?B?NDFxUURJT244RmpxQ21ySFRuTE82ajYxWGFtS0lPZjAyd1huZGdETXRFU1Z3?=
 =?utf-8?B?WlhCdWQ4Z253S3dxMG55SlRRd2J1MkhtelVYRGpXeHJCVm5pazJwVlB6R0ta?=
 =?utf-8?B?bWxMNWQ1Ni83RHFuVnBzRnZpUDAvbFRrcVFNZmFaMHZmcXNpbXFlSnI4Qk9M?=
 =?utf-8?B?eDI0VmpBWDRPL3dHdmR3ckloNHpXUnYxUk01azBIYW85ZFhGRXdLOXhpVlVP?=
 =?utf-8?B?NC9sUlRyenVXWkpvVkcxMXhtSnNjUURpWWVPYks0aFZhWjgwc1JhaGErS0Vw?=
 =?utf-8?B?a2lVUzlVbnF5Qm9Yd2wrZHVYWDRiQWlYQk83OWVkRnQ0SGw1UVRNYVJUNzlW?=
 =?utf-8?B?RXU2SEFZL0srSWF4aWZkR1d5ZDVvY0xnMHV4VmwxeXRjdUlMMHdaT3ZoTFhz?=
 =?utf-8?B?cXN2WWhlZEdKY0VnamM1L1RVUWVUUjRuWWVRLzRWb1ZkZVJaSmtrYlRTYldn?=
 =?utf-8?B?TXZ4QzNlOFFraDdEaTlkcWpWdGJqMlBHQkRIVmxjVnZMdU1UaXBiMCs4UlpM?=
 =?utf-8?B?eGhSYVFuK3JZRHhUK0VxN2Y0cXVPNnF5UW9hZnlNZStOK29SVDNLSXZYSG50?=
 =?utf-8?B?dkRFRDVONmlMUHA3bjc0ek9YR3J1VzdleXBkSFpTWlYyWVkwVTBJMDRaL0to?=
 =?utf-8?B?MVc1MHUzMU5zcWltZ3R3QkhycVNEc1Ira1prdXlFRVNRR21BaHN3NDJZSTBO?=
 =?utf-8?B?cWsxcExRa2FPQkNBSURPZG9va2hhQUtlWUtzVWRTVHlUd2ZxRUFmaVFPd2I4?=
 =?utf-8?B?Wlc3N005M0JwdGpURVJCejVOaXJVWFl6TFl3VHBCTGVVYkpvd3gwSGY1Y1d6?=
 =?utf-8?B?Y1ZacTBoQUNSU3REampiRjdKdjIwN3VGemxqajRLNjZoSm9ydmE5dWxLSW45?=
 =?utf-8?B?Y3pQNzNzU2NuRVllT3p4dVpwWlFqSElTQmI1eG9IZUtXZkFxQ0tMRStWM3V3?=
 =?utf-8?B?aUJxVmJGTXNTam1CSW5abFNjL2JhMy96ZEhiRWZ0OG9NNmRFeVNwcVdzUjVu?=
 =?utf-8?B?cXk4SFJtWW10TFIwc1VFeW9sU0c3OXUrWDcyR2EwWGtCLzBxL1NjSExMYk9s?=
 =?utf-8?B?SGRqS1M3R1ZCSUZMSGlBQ3JZSldXUnNaSGh2eFhyQzh5QXFIRnNVejFLZjd3?=
 =?utf-8?B?WnZpdXRaSXhQQlUyRDFqRVE4czl4dlBqMGJKWGNlcldEeTBwbTVEQWJkcWhY?=
 =?utf-8?Q?C/5g771Z2/yaHIs+BzMwHtI=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 77f4ae82-a160-45b2-251a-08dbcf003d3f
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 11:00:13.9005
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yRzDN3vQFcSInh1FbWEWSb+45YcVlvkNfzwnlQuw8/WQZc6uIH6NCiwAs+JJTx+BNF2Mj5rKMnE8sfTV3Z+UDk0U2eSG1v6XDdjbILEyBK4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6295
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some touchscreens are shipped with a physical layer on top of them where
a number of buttons and a resized touchscreen surface might be available.

In order to generate proper key events by overlay buttons and adjust the
touch events to a clipped surface, these patches offer a documented,
device-tree-based solution by means of helper functions.
An implementation for a specific touchscreen driver is also included.

The functions in ts-overlay provide a simple workflow to acquire
physical objects from the device tree, map them into the device driver
structures as overlay objects and generate events according to
the object descriptions.

This feature has been tested with a JT240MHQS-E3 display, which consists
of an st1624 as the base touchscreen and an overlay with two buttons and
a frame that clips its effective surface mounted on it.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v5:
- touchscreen bindings: move overlay common properties to a $def entry (Rob Herring)
- st1232 bindings: move overlays to the existing example instead of
  making a new one (Rob Herring) 
- Link to v4: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v4-0-5c6c0fc1eed6@wolfvision.net

Changes in v4:
- General: rename "touchscreen" to "touch" to include other consumers.
- PATCH 1/4: move touch-overlay feature to input core.
- PATCH 1/4, 3/4: set key caps and report key events without consumer's
  intervention.
- PATCH 2/4: add missing 'required' field with the required properties.
- Link to v3: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v3-0-b4fb7fc4bab7@wolfvision.net

Changes in v3:
- General: rename "virtobj" and "virtual" to "overlay"
- PATCH 1/4: Make feature bool instead of tristate (selected by
  supported touchscreens)
- Link to v2: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v2-0-f68a6bfe7a0f@wolfvision.net

Changes in v2:
- PATCH 1/4: remove preprocessor directives (the module is selected by
  the drivers that support the feature). Typo in the commit message.
- PATCH 2/4: more detailed documentation. Images and examples were added.
- PATCH 3/4: select ts-virtobj automatically.
- Link to v1: https://lore.kernel.org/r/20230510-feature-ts_virtobj_patch-v1-0-5ae5e81bc264@wolfvision.net

---
Javier Carrasco (4):
      Input: touch-overlay - Add touchscreen overlay object handling
      dt-bindings: touchscreen: add overlay-touchscreen and overlay-buttons properties
      Input: st1232 - add touch overlays handling
      dt-bindings: input: touchscreen: st1232: add touch-overlay example

 .../input/touchscreen/sitronix,st1232.yaml         |  28 ++
 .../bindings/input/touchscreen/touchscreen.yaml    | 143 ++++++++
 MAINTAINERS                                        |   7 +
 drivers/input/Makefile                             |   2 +-
 drivers/input/touch-overlay.c                      | 399 +++++++++++++++++++++
 drivers/input/touchscreen/st1232.c                 |  70 +++-
 include/linux/input/touch-overlay.h                |  34 ++
 7 files changed, 668 insertions(+), 15 deletions(-)
---
base-commit: 213f891525c222e8ed145ce1ce7ae1f47921cb9c
change-id: 20230510-feature-ts_virtobj_patch-e267540aae74

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

