Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D3757CE540
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbjJRRtz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjJRRto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:49:44 -0400
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50C69B8;
        Wed, 18 Oct 2023 10:49:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nTdovfUV9LgZfPyETCwshmyT4G5MXBMWPB8GroxXedEznjWI/8bhfWebdMaaDIcfljSNaRUtT07l+2+jOEr7XVLdUTqSpBGbclT/4e1MoHHbH9YVXazjU2nOQe3lv1pJOo+v5Cxx0sfKkUC1E8jPIqNRhXAdQFy6SAYyY1+GNLEInKHnl+pBmgrOVvBzBUukin36FI/YiS3UaD1uo4/2ycENE6ILWRWRlkqDpsQNQk4A580R5KlUtwhqKqZPz3Srpcs5pJ+JgrUJWE72BCg+vPWX+40cVPtZByXBbkVX3migFCnHC/UiVT8nJHVkyDK4Pg8+4V40GNcBL6/ZsRYX6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dJ0aXBQC3DduVUO3LMOak7Vihfr1WaSMQA9Zk5Ski10=;
 b=nXmTgFvLZIHIuiNcShh44L/41ADMeqG6A7JbdxXICS5BpFmN9vThftEMkTqTr/GkJFTAfopYOqsvjjL36NXfmLm9r4guC45OjsduMYhZ/JFwLyIHvhC9kKVNrSN9dd+uPnXFYw4jJwD/vt+slV4b1aDVCftlRVi/o16gnm2ycx6q1/oFUBySChyJdWzSztY/yN448bF0p/U8agj4ldtpTHV4xe3VOd/ho06wzNZ/Yo+INdlgGqh9Ia9J/dCDLxuJoSqAn8S/C/B223c+J7NriXPrcAwMaNXqHWII+ROz1Bb938iGSWITtCIbVBFgkgMZsFpg9VBjLuCbSbNyd5lmtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dJ0aXBQC3DduVUO3LMOak7Vihfr1WaSMQA9Zk5Ski10=;
 b=N3IkT233IuCFcWwVhLskZ9j8inzLxwpOuutBhIZMVWzqCqUxwsLzYdU2ws80leLbXGzXlS0saeeK+G3uRu1pw2dyoCAJmEzL+F1+AACUV725qA8Jx1X3U2HNo4ayU3yFBUSCrg4KpqZ9GCQvWR3qd7KdqUXlh4S7GBIk/vDZ/tI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AS8P193MB1478.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:350::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 18 Oct
 2023 17:49:38 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6886.034; Wed, 18 Oct 2023
 17:49:38 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 2/7] serial: core: set missing supported flag for RX during TX GPIO
Date:   Wed, 18 Oct 2023 19:48:35 +0200
Message-Id: <20231018174840.28977-3-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
References: <20231018174840.28977-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR0P281CA0130.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:97::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AS8P193MB1478:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f5d1cd6-6f42-4737-f170-08dbd0029906
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gD6bpCM/evei2bhCdZ7F7S2cX+acAS6jdVrtZ/yCNQqBdKY4q8FrlsGBBzDA/baqB0N+Av4jxwepLwTa9OcZHptcHQ8M52BYub7OoKjUOk28DzCqQ0W6emJXLMjSJfVbAH7eg/p85P8x1tb+6NF2awoxYF3LUXEp1nRPxBhQhWAttEkzTNKXDZbcMCZtQxzLHoWiFV3x/GLj5P2bgPzNQgwPnHCCMReauu7IHLbYZ83sTNNFYXNyRn/IIRmpre6nK4dbIzX9j8jKwxaPtLmLdKMavycowLOi+4pQhsx1dQrLnSNxDP+XMLCrMNGHhK6Xz+4UMWqrGSnLHadrMxHkhhnMDWLp1jc1ynHxJtNfRRsjH6718o61IkG7vmBO6E9CZvmS0vayqcoMiRwz5S9SUO+qYSiaAe92q1nEFEnCROEqO8Cn05TLx/VtEw7//GvnaDbavhS4ur//D/xs7yfjNiHbudMn71CQ8PeLijeHi4Nc5k8eU3Gi0SPMv0Ye4N5/txz/ZWZQWcJZgwQyd4aotbrvEVAvJ355ctGu2iJ+31m3F15e0IsJHvTx8e/sUpVC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(366004)(136003)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(36756003)(66946007)(66556008)(66476007)(86362001)(38100700002)(1076003)(2616005)(6666004)(6512007)(52116002)(6506007)(7416002)(6486002)(316002)(478600001)(5660300002)(4326008)(8676002)(41300700001)(2906002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bbVuxL6ogjdrrz365fPYKfjbqPyyvuqLtYDvN3+DznTrwTx8YRhIc8wqI8GS?=
 =?us-ascii?Q?lr+/AS+L1E2e0/dyY1w6P36wlIPzblmCKf285tjOjOOuKhzFqJkIhzb8H+B5?=
 =?us-ascii?Q?sIqWC8N8IYHpG4vLFKeWiPsB2/Y3GksQsI9Y1exor5ODIvd2QQ6uHAB4seYm?=
 =?us-ascii?Q?rQdD83AK0qNN9zfWBaF7LQlMRJRuelz+ZZK/JeYEkwHr/rd3Kq/UOx5kLdx1?=
 =?us-ascii?Q?Cs6ejSGDqgbXVzGBrBagxrFbb7D2h3v4ZdEqpaVqbIs9bMNdhh5tS+Nx6K9j?=
 =?us-ascii?Q?gXluF/y9rT6FN+qV4scMz8jfMwu8fzNiIkmz74xi3jinotJFjXwJ24XGX5TN?=
 =?us-ascii?Q?6oYAF+f5nywGY7YqiEXN+nlHnaUqXZdHegBJrLjk9MCkd5xbpqQfeq7L34ba?=
 =?us-ascii?Q?WC/19o2YsOv1ynfAg1yJn6KSu35N/K30MBHebsSH0aAIib9Ib8RXDswTQ2Jo?=
 =?us-ascii?Q?/9vTPF2lXsB3awEkTmQN3/D3eMuYx/upyB+xPZEYmMBU2RID+vCR3SLwnDIx?=
 =?us-ascii?Q?GBg6pVQs4zk3t9BmXNhQc4Hf9Z5YWIv5IIsgKwt9ewXoBmTaT9KrkdvDWE0Y?=
 =?us-ascii?Q?rfYZidn25LVLjnHXqrBqxvKc9M7NeVLeszIjftLWVBAPbCZ7xnLccb4+hyge?=
 =?us-ascii?Q?XtyrUvES2jOVAub6xoEOaOYeqjLuW0IvbJvGvFuyPpc+fMWK02Uv14ECJg4b?=
 =?us-ascii?Q?x88ckrgoskSE6zZCD1TtMFHtqaifCQkWYSjt1OGYigoDf3XhZFk/ilOucJgi?=
 =?us-ascii?Q?GnOXCfICrPerr8m08rOcUw7nhEEaRzsb19FstvmwbpEpJfF9ZA0huCBRG4iw?=
 =?us-ascii?Q?+63YLstMrloEiqZrYTe4x+n1bU/ax661gn9UY9hRcycB0T57J/H/giQtBXQ4?=
 =?us-ascii?Q?fMU+mTkSQzhUw0O+w1Elkx5fy9+0Y1IjfcpPcpbsRPQb/F5dIGO3AZxAJuib?=
 =?us-ascii?Q?bGTMpvqqMHPYCwHizo9jJPdx4+B5CUs/tCjKgalPAiB9M/QzhSsTy+RYPcCs?=
 =?us-ascii?Q?0y5zQjltfnEnkSKywaZ/zD5PJ5CHf3Dt16Uk2tjdmy/yS+qBUwHYIMWZ+mG5?=
 =?us-ascii?Q?C+x9nAvCd9pApI0LLDFryQNsDCPzcJzRQn1IAQGWzJBW+x0fBdRZWF1VVGwG?=
 =?us-ascii?Q?DZXCs1hH7snnZrmGxkQQcccl2L2aNoaUR07aAiWbuG30aP44RylRv9+sAVcu?=
 =?us-ascii?Q?lGl6bonWq1HLrl5u+tztOr2EeaznqGXR1IVOAjcNjC04ENZ0H7WXmr0gPOaH?=
 =?us-ascii?Q?PfvKc59c9xAAnS+MlnNGIHkIORYjLhL1Odm59ug8Mu9/vHCTsNVYfqEoFjJa?=
 =?us-ascii?Q?I/gS5zI7LbHUnHrpGy2uN79rOA+UXWerZMBIqjAJFw90fuCg/D7Nz7L8DfjO?=
 =?us-ascii?Q?R7fc+xlEg18o0znO6h3+lc/R/hzN/QYI1Nyph9w/5gKOAV5JkbyrMKpg9sz+?=
 =?us-ascii?Q?7F0vhZ5si3ayV7Zn7Y4srA5B4i4UQZQp3PtyvP5qKcWYf3BR7axQu4X29x78?=
 =?us-ascii?Q?pRZxpwowUbi8G8lakv+Fb2si9fCqKpK79HkKh/RfD/UObA375usbuwt8HEv0?=
 =?us-ascii?Q?CEtV79PX/QnfSyC2S/dk0Yi5NJAnstZGKy82tLx2pOi308pY9Xg8LrrZcuL/?=
 =?us-ascii?Q?zpwAKg2qnGVdBnGqtoeVJPdq8rE2RF2fo+GhYnrjCkZe?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f5d1cd6-6f42-4737-f170-08dbd0029906
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Oct 2023 17:49:38.0434
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DhogkkMz2tk0H78vxdgDXmW5bdVXcvn5kX6Ku5icSHLJhcdIssMHw3DpyiJgbiI9jU6rBs/tKbRKLlq0xM14IA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P193MB1478
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIFJTNDg1IGZlYXR1cmUgUlgtZHVyaW5nLVRYIGlzIHN1cHBvcnRlZCBieSBtZWFucyBv
ZiBhIEdQSU8gc2V0IHRoZQphY2NvcmRpbmcgc3VwcG9ydGVkIGZsYWcuIE90aGVyd2lzZSBzZXR0
aW5nIHRoaXMgZmVhdHVyZSBmcm9tIHVzZXJzcGFjZSBtYXkKbm90IGJlIHBvc3NpYmxlLCBzaW5j
ZSBpbiB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRoZSBwYXNzZWQgUlM0ODUKY29uZmln
dXJhdGlvbiBpcyBtYXRjaGVkIGFnYWluc3QgdGhlIHN1cHBvcnRlZCBmZWF0dXJlcyBhbmQgdW5z
dXBwb3J0ZWQKc2V0dGluZ3MgYXJlIHRoZXJlYnkgcmVtb3ZlZCBhbmQgdGh1cyB0YWtlIG5vIGVm
ZmVjdC4KCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCkZpeGVzOiAxNjNmMDgwZWI3MTcgKCJz
ZXJpYWw6IGNvcmU6IEFkZCBvcHRpb24gdG8gb3V0cHV0IFJTNDg1IFJYX0RVUklOR19UWCBzdGF0
ZSB2aWEgR1BJTyIpClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBv
QGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCAyICsr
CiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YwppbmRleCAzNWUwMTRmODM0NjUuLmVmOWU5MDE0YmZhYiAxMDA2NDQKLS0tIGEvZHJpdmVycy90
dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9j
b3JlLmMKQEAgLTM2MzIsNiArMzYzMiw4IEBAIGludCB1YXJ0X2dldF9yczQ4NV9tb2RlKHN0cnVj
dCB1YXJ0X3BvcnQgKnBvcnQpCiAJCXBvcnQtPnJzNDg1X3J4X2R1cmluZ190eF9ncGlvID0gTlVM
TDsKIAkJcmV0dXJuIGRldl9lcnJfcHJvYmUoZGV2LCByZXQsICJDYW5ub3QgZ2V0IHJzNDg1LXJ4
LWR1cmluZy10eC1ncGlvc1xuIik7CiAJfQorCWlmIChwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhf
Z3BpbykKKwkJcG9ydC0+cnM0ODVfc3VwcG9ydGVkLmZsYWdzIHw9IFNFUl9SUzQ4NV9SWF9EVVJJ
TkdfVFg7CiAKIAlyZXR1cm4gMDsKIH0KLS0gCjIuNDAuMQoK
