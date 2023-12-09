Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7278380B474
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbjLIM7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230174AbjLIM7U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:20 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B90F710D8;
        Sat,  9 Dec 2023 04:59:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DwGjeDt+HZ4pv0n0fE2VlrLzZcuz/qoqZrXMaTF9iZHStnKNSdLPxH6ARySb5Jw1jXkSvKNqtqVL3og30UtLQiMpyTQ5S2lTnj9NNN1PCNYP0Q2gvFufxcN7AsozpBE0kWr1+vNkBdhIpfRSV4s2lu/skq7xjBMqZvmrRiXnOAa3EkmarvtM/QuUSoWS6BSVFYtDlPZVx44n9ixPALjVhut12fKl2AhbwP6tdzEPiUNY+oTDrjiQxsHien23fC95KHM0cgR4SQyZpv0yRBYYIj58nKSfbj+CStqhNk4/xYqbgjQ7VmqsoBGXDLTsjTIME/bOlNb0VdoxQY9n/6II7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=giTj5RrPHXa3a+Lx1xc7jw4vgGwf3+BKO1xkJ+5ZPDo=;
 b=JtaQAz+xe4nUuz2IFVNs/NueDn5wpxO0+pcEGL72H42K7nyAiOAWeMgDFlOlR5EjkOiXrvjYiX8f/OixVuQ7JBrj79ug+9f7A7znzZwP/n7l+J4e0ev59vRxuSloeyrl42e7mrrF7+ucG9Rf07jrvi5+HE9LkazlFX07o9+8nyupc70yb5Q+kLSGZMKxDvE7pQ6hFjhyYtjgAzfRYjRteYHMVZQPsyLUkn1DiCdROFItmJ4qN+Wfw5kyhsb2TLHv1dpdOzN2U8xR+GEodFZnE0zYo21BRhg0Wy524C7H04cxLPYbZJLMwfayVDdjRmy59/pm+jOfmrH7FSKftNfXgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=giTj5RrPHXa3a+Lx1xc7jw4vgGwf3+BKO1xkJ+5ZPDo=;
 b=IEZv6+qqSpeGVls0ymRynD9cbAk+3O6ET6NS9ugFaSnJiXkvzr3W7mkAwHr+fTIby2Qvp4bub0pj6OcqA67GHY+bpblQIX3eW3Ki6CJW7TgyVAMhCtIP7DLuti5Y5iuPdmc2knr/O1bhggwNR7Jc1aZ7SmmK9X9xk8wXMoAr6GU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:19 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:18 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>,
        stable@vger.kernel.org
Subject: [PATCH v5 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date:   Sat,  9 Dec 2023 13:58:33 +0100
Message-ID: <20231209125836.16294-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f929983-ff7a-4f98-d96f-08dbf8b6a7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TMnn2UGZpEGMBSgFA+R7ZeE0qTIQJ9xMCvKxabWdl3GX60XEi8JslXdmWppGwzWy0YKL6bVNCCKiwjIlh/bKaMeavLj9vzgYnj+hO0jlIDTr2tyrul+g3H0+0bt5MOToxNTgLGpckrBHeXkbcshITa+wO2gzkvZ2/W/T977427HUP8O8wTtYW+oD4GtX03MUOV3ngl8LaZsaI9vZz1EE0uetJkM/0mow146VJLI6WeOCqMu+5m7I4UBhYjAb0wQQ3/iSKcZG4Tn/pzUazsafv4jscoWeiOVz5EaeNbrcTQwQb/cynlxXUB2nYhGcgjHNYafMrn82hA3PuynJ56Kt/thUBuuVnDZlMck6DRtLEHuGhG57tGBtUKD7P72zgcWtK3DqEnEqIk7NPokJzGVpEeh/KfCO8HShrR4r52wBNU9+XaE/cXf/suC36mpicbLBE50n1rnEzfz6pMRZsK21WQTLFPazkgT5n/gjibwkkxYRdaZDexwwbIAIi8eVnP6+tG6FCxJYE+Hp8KfS3ICp6xxW5bsGu7Qc/AJArD0qRyrHhtqcij9hzqyWyNqAgnwI
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/kb+AFq7Shdeot/IU9p+Hch3qin+YP1i3I8EbG+HDPp2fEC4HBqvwSqpPPQC?=
 =?us-ascii?Q?ulFsQcLY38c1eDzqD2z7XWR6hzkcITt+CmvshCoP7PkgHacBl4YNm2KoG4Bl?=
 =?us-ascii?Q?PQKBPVn3IARf7hC31bBOglc/DswB/4SY07i3Yjsa/sCm9BEvxEYcPT5HFzUN?=
 =?us-ascii?Q?6/mYCGyP48LoHi+3DOgYKEyI+1J/owkP25oaIuYJ0J0U6YzLqoA8bJg91JOr?=
 =?us-ascii?Q?6g2mEquE88EQ4KhldfqXwj0HHjj4XpJUQeUGopeyen52lk0WmE5t11Oyin9c?=
 =?us-ascii?Q?2wAW2kxVuMhb0ZFLTbXMxe1ttnuDevdFORuHPrz742t5BH8HRR7hGY3CpGEq?=
 =?us-ascii?Q?jtfiRum4eqcVzCFb6aShgiJhndwqHr0Z1k+i9D1zzkZyq5PAD5eg3pPYmtnT?=
 =?us-ascii?Q?n3+MsS3FzTFbN2shVuSva0XQc6j4Ds6Ojlk2frr8PsWuAd0sJMaCHn9DrmDK?=
 =?us-ascii?Q?5nmZWMJz+iOtgFj7iMNEGBAbnU609Y3rmX/sgfpWK7HgLaj1g3PPKmZNt3xU?=
 =?us-ascii?Q?aH2KWDodNzVtwhsG1yu26J9CszBM4CoYTGVlyQzGxN5ysjSZdl+t8z52gUjf?=
 =?us-ascii?Q?N39TDfYrw6kRsbTHHFqZDW7OdqVGEiY1XFfgmUWMeixhFxSvDqdBm73k9fTV?=
 =?us-ascii?Q?pLi+QNtIX3oPIybx3RNRRhWUuMnPz5GKNbtY+05mM32LEIlivdJxxCf9b8Mr?=
 =?us-ascii?Q?o7kATm/7jIaV+4U+I+0P9ekfx6cKOa3ob5OGZ9LPshY/pAbXzndWsICS1kQh?=
 =?us-ascii?Q?/w2qkuaFQwfkNo9xJORHTRwtJffXNzPBj+k6oLizx26VFKKpM+JaJvxhN2wj?=
 =?us-ascii?Q?83i9qHMwCqZy5mGrYeVsfHRF00X+bajhqJIL3fFTDSdN+CINeSV2DlvubAcH?=
 =?us-ascii?Q?Tvo0nJCt2Pi8u5Ku6/eqTZebwFZbEI5IuJsXxCwsy6QrdIUU/CaV4hY2MRC7?=
 =?us-ascii?Q?OeM0zsignp9NMOFJXPMkeIXd1GGfsBy8gDs13xbuJdGxIXFhpIOpuBOj0qj7?=
 =?us-ascii?Q?w9fA40TUW2RiHettgLI3Cy/6fVj7jIw2zC6xAi0kdP9iMgX4JReE2bttA1hu?=
 =?us-ascii?Q?xbn8Q/BmIBz8U2h2fsFgERLd6JO69W4N+per+y8MfeZI8rbUd9/zZN5+HiMu?=
 =?us-ascii?Q?FU9DP0FkO4Eh+ZaoyZ9AkovCka70CbVkyA+Vhxpy885HOgNRgrFa6hKUsoMO?=
 =?us-ascii?Q?Bmtr751qHWE6PnPfw6MQL2ft2cX80YqjeW0H+wMqy0dHm9twtzwxw8mZPb6V?=
 =?us-ascii?Q?Xq0O2WKB+mT/NuUPiqN1G5GWiiKUKL5p/m2vjGD5uSdKx2GT/LlERzELgrZb?=
 =?us-ascii?Q?i5Jm5GPMgUfQhsUTwdngQBfsUV5jff1lCmMMGP7a5mZnqi2G8EAjQm6eEv1y?=
 =?us-ascii?Q?LMvyzKVfF9xta3VFR0p8D6kPt2o8BYVrpHFuFA6WzILCGO1EPvujn8Nrnk63?=
 =?us-ascii?Q?CGdPP8lW5YbUMegb+kqxb1Y6osaAZu6xIDL7alCZu3tYiI8iTB3JOiy5cSYA?=
 =?us-ascii?Q?VcWP/o59BoqOBmUZzCqVqhG+1Z+cpxMVwpIeAB72AG0GFElWWtfUpLKoIFlc?=
 =?us-ascii?Q?Q22+g+huiHt7mUKdbbEf7QOl0C1sgirp3xs4cBGOqH8jGrFpCJDQTnQRov6I?=
 =?us-ascii?Q?9tztQzTDv3yqtuJRZROip7TDP/BcRGc6rrcgvBdTIREp?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f929983-ff7a-4f98-d96f-08dbf8b6a7e9
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:18.9258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PZbWvp9aAfEst6+gLAp4bp7CQo0Iu/fWI+YPr/GECft0qxGPO+kyMdzvb4Jpo3ht9oA3swxB/F6ea3elCG+fqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0555
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

U29tZSB1YXJ0IGRyaXZlcnMgc3BlY2lmeSBhIHJzNDg1X2NvbmZpZygpIGZ1bmN0aW9uIGFuZCB0
aGVuIGRlY2lkZSBsYXRlcgp0byBkaXNhYmxlIFJTNDg1IHN1cHBvcnQgZm9yIHNvbWUgcmVhc29u
IChlLmcuIGlteCBhbmQgYXI5MzMpLgoKSW4gdGhlc2UgY2FzZXMgdXNlcnNwYWNlIG1heSBiZSBh
YmxlIHRvIGFjdGl2YXRlIFJTNDg1IHZpYSBUSU9DU1JTNDg1Cm5ldmVydGhlbGVzcywgc2luY2Ug
aW4gdWFydF9zZXRfcnM0ODVfY29uZmlnKCkgYW4gZXhpc3RpbmcgcnM0ODVfY29uZmlnKCkKZnVu
Y3Rpb24gaW5kaWNhdGVzIHRoYXQgUlM0ODUgaXMgc3VwcG9ydGVkLgoKTWFrZSBzdXJlIHRoYXQg
dGhpcyBpcyBub3QgbG9uZ2VyIHBvc3NpYmxlIGJ5IGNoZWNraW5nIHRoZSB1YXJ0cwpyczQ4NV9z
dXBwb3J0ZWQuZmxhZ3MgaW5zdGVhZCBhbmQgYmFpbGluZyBvdXQgaWYgU0VSX1JTNDg1X0VOQUJM
RUQgaXMgbm90CnNldC4KCkZ1cnRoZXJtb3JlIGluc3RlYWQgb2YgcmV0dXJuaW5nIGFuIGVtcHR5
IHN0cnVjdHVyZSByZXR1cm4gLUVOT1RUWSBpZiB0aGUKUlM0ODUgY29uZmlndXJhdGlvbiBpcyBy
ZXF1ZXN0ZWQgdmlhIFRJT0NHUlM0ODUgYnV0IFJTNDg1IGlzIG5vdCBzdXBwb3J0ZWQuClRoaXMg
aGFzIGEgc21hbGwgaW1wYWN0IG9uIHVzZXJzcGFjZSB2aXNpYmlsaXR5IGJ1dCBpdCBpcyBjb25z
aXN0ZW50IHdpdGgKdGhlIC1FTk9UVFkgZXJyb3IgZm9yIFRJT0NHUlM0ODUuCgpGaXhlczogZTg0
OTE0NWUxZmRkICgic2VyaWFsOiBhcjkzM3g6IEZpbGwgaW4gcnM0ODVfc3VwcG9ydGVkIikKRml4
ZXM6IDU1ZTE4YzZiNmQ0MiAoInNlcmlhbDogaW14OiBSZW1vdmUgc2VyaWFsX3JzNDg1IHNhbml0
aXphdGlvbiIpCkNjOiBTaGF3biBHdW8gPHNoYXduZ3VvQGtlcm5lbC5vcmc+CkNjOiBTYXNjaGEg
SGF1ZXIgPHMuaGF1ZXJAcGVuZ3V0cm9uaXguZGU+CkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3Jn
ClNpZ25lZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+
Ci0tLQogZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgfCA1ICsrKystCiAxIGZpbGUg
Y2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pCgpkaWZmIC0tZ2l0IGEvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFs
X2NvcmUuYwppbmRleCA0ZWFlMTQwNmNiNmMuLjY2MTA3NGFiOGVkYiAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKQEAgLTE0NDgsNiArMTQ0OCw5IEBAIHN0YXRpYyBpbnQgdWFydF9nZXRfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJdW5zaWduZWQgbG9uZyBmbGFnczsK
IAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGF1eDsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRl
ZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuIC1FTk9UVFk7CisKIAl1YXJ0
X3BvcnRfbG9ja19pcnFzYXZlKHBvcnQsICZmbGFncyk7CiAJYXV4ID0gcG9ydC0+cnM0ODU7CiAJ
dWFydF9wb3J0X3VubG9ja19pcnFyZXN0b3JlKHBvcnQsIGZsYWdzKTsKQEAgLTE0NjUsNyArMTQ2
OCw3IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0
ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJaW50IHJldDsKIAl1bnNpZ25lZCBsb25n
IGZsYWdzOwogCi0JaWYgKCFwb3J0LT5yczQ4NV9jb25maWcpCisJaWYgKCEocG9ydC0+cnM0ODVf
c3VwcG9ydGVkLmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm4gLUVOT1RUWTsK
IAogCWlmIChjb3B5X2Zyb21fdXNlcigmcnM0ODUsIHJzNDg1X3VzZXIsIHNpemVvZigqcnM0ODVf
dXNlcikpKQotLSAKMi40Mi4wCgo=
