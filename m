Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE9F7F05F6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 12:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjKSLd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 06:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjKSLdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 06:33:12 -0500
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2064.outbound.protection.outlook.com [40.107.104.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91C619AA;
        Sun, 19 Nov 2023 03:30:59 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UNMcTDzvC3EETKyZMKdcgGIZRj+ruNlMyjouDE7yQcoLtfGa7SyvVLKmJBJGk9CEyVQiIlNALsGGBp4hL2dzrKFWAmkXRQ+0FnHImr+S5zUKEegRCSPpLzzXtVCetxULZuzyBYgrHpNl2m8nMGDZCaRjIfHkw7WqSxMwxr/VsePDRRnZGimnpUP22SubtohyS1zyl2c2iOhbJgoyNoNkRR09oND695nC5ehWkFCxH9CNuyN+b8TqAP/bz6bL7bTkJ5iAip2FfiBk5iZDZBIkUDzcKtsd9po2ibaUKqGUJhyN6dklisJVAxGcPL4bZKRjvJZ8iEqD0dJ9opU+nVeb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ebPnrpWvtNskQGU9VdxDDVTFT0EpFdJL+SfMBJwjsmI=;
 b=mlUgOkPlx9k06qQDPmwjgFhyAZN5mebBrFeoHOquEvl2IhS/jfuXX2Fat1wySwJrtfr7oW5m7zZikCTYjAV7SS7vZ47umfF8aqoVSaG0myUteAHTr9DHRzvY7TWS+gZBgU+GkJ+oeAvtJV8Sbu7RdKpuh0TR4fmVj1ZDZzUowSjA9JPAP+11MjKhru7O8fJ1YJv2wbxY4TLlizDmy2rRAS/EmMM0fTN4NPR3o3s16BSfcyAzxdvZtRq4ew8VtGDWYFzBK/Sz2zkzIo1PUBhILc+P4Ou2bpApU7tP+khBwocMHRoF8IqkKUjc9Ge19bnYF5GK+2Ih2/vuIlPTXj2n5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ebPnrpWvtNskQGU9VdxDDVTFT0EpFdJL+SfMBJwjsmI=;
 b=Z16GkgyaNMbGMuK/n02nZUR5hq1G67JIydjsTmfCIDsIu2rbCXrDdaqUDe8zLYzhcLMcj/9HfQblSvyA1u2/B8Iwt0K7Brg00KyWBYO4zs9ZfSQzP2CiDy0sAgqZJaplVxgYZ5D0Y6HBoxtL3ILiPzRpBMw6jtWlsDo059MBtV0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1060.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:1e5::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Sun, 19 Nov
 2023 11:30:01 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7002.025; Sun, 19 Nov 2023
 11:30:01 +0000
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
Subject: [RESEND PATCH v4 4/7] serial: core: make sure RS485 cannot be enabled when it is not supported
Date:   Sun, 19 Nov 2023 12:28:52 +0100
Message-ID: <20231119112856.11587-5-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
References: <20231119112856.11587-1-l.sanfilippo@kunbus.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain
X-ClientProxiedBy: FR5P281CA0007.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::17) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1060:EE_
X-MS-Office365-Filtering-Correlation-Id: e20746de-aae3-4516-5588-08dbe8f2de2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jk/opv8mj/wscxDT/+tbinvNKNDSd7wnsNI+s8owrocjfKDfkWwpPihK3FJftWlY3fGUBTfa5spXA0yGm8lne4vDjnC53Lg3CVNSCL9YrId9gcM6Cwqc62A1LhEY98pzF8jbYTl62lgbUjE+ySmjTtnR9QSlVtVff2Rhqw7Z5CspNEfnwHhudAmS0ksN3rRyBk9WhPKJcloAsbSl4ofj5K3TpBR35Q7IwDGr2UrBXWPdZOqja7vgSvl78Gg7mJzThIgbEAmk40MFMxWooZBxnYAu61flz24AKqNCIwzdbCcq9EfvWpUyeUYIgQCZmxKZu7LC8G69DcEmpdcykQzfpOdnK6tVaaLR4Scc9ArstnjBOGbKpLBFt6kbrFfJUdzzRpGcDWEqPdDTrdkDkPfZaNGM7VUYd1gXPG1eDIUapH1hPzHpT/FDVDP5DSTe9pDzeYZOWouwlfErvc6MQYMsKYjf01ttmy1b+KUyFLLq7DfccGaG6eeOunqFTTnEGsi3Zpo1AmvtFrL0VK10LeVEUA4oERhW3l9e93HP9lqZYqdaQn8/XFfzC2HklKbotKba
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39830400003)(376002)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(6506007)(6512007)(52116002)(66946007)(66556008)(316002)(4326008)(8676002)(8936002)(66476007)(6486002)(478600001)(83380400001)(1076003)(2616005)(38100700002)(6666004)(5660300002)(7416002)(2906002)(86362001)(41300700001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b6VbNiO0AfcJxUwn7ShxXTbW9IOAOHZp/rIMQ0ySsx6HnEEHwYQjgk0rnu1+?=
 =?us-ascii?Q?RmN0f0g5a2pCbnSGiRmxAPKuY2KuU7LMRETHaqVchKuHoypijpT78OTfC/fR?=
 =?us-ascii?Q?R6XOF5QmGJnp/URdSPdfUcrulNJ/LqQclYM/aGdpSNT+2yVVpzmdI79yZJfA?=
 =?us-ascii?Q?lIZUZdcibU57A6z+kJmegJFS6FlZZmDVl0+BlO3Jt1dnVr+pQlICPAtzaEPE?=
 =?us-ascii?Q?Vww1V2x/ImBLyhuaao73uxJJOdBXbGnlF1CTgzlH6z0/GIBVS/ZdDfe+xgNM?=
 =?us-ascii?Q?22X9acUfnypMwVCojtDRruJXEFD+r02vW3aJL1fh2WrqiEezGojRbKqyoMIa?=
 =?us-ascii?Q?wV3aAZ6tnlTOG6IZmzCqBq8Rhjsqv70botHDKPDq0vWOEMbhz+aMrcn+XoZ4?=
 =?us-ascii?Q?yyo0srgqanP2aGjcqoLKcF3/A/Uj+C37QgfLpWhUgiYDxqi4zvxH1J++daGY?=
 =?us-ascii?Q?htLVVX6LlUfFa7PRlQvKfd5vMuTkBxPFDZ32GyA/+p+pf/B+eMVqn9BZmzHG?=
 =?us-ascii?Q?cXTtvC0ayc73xRMHc0K9YHcn++etytByvDkdvfScesCuY7vusKa9hI5G9GfZ?=
 =?us-ascii?Q?1CZeuCdMN7j9wV6UnpZ6pn39/JIZgkzqzS75PxzV4HmjX1AGdo/gpwmVAtXU?=
 =?us-ascii?Q?qectP4EtfVR245r5C1aBUKNLQI+ifVMeYWN84epTxVNHvncVeiuERNXA3juF?=
 =?us-ascii?Q?MvCgjNcTX5yIDoIRhqyh/wSJXmnER9YVYjyNreYcQ01HyiW3wQdQ/NThMmy5?=
 =?us-ascii?Q?cSw3nVee1Zx1spLSTs8JH583Nkmn50lcMLeVF1npH8BTMOsXpl/dX05spCcW?=
 =?us-ascii?Q?9mrFX3+bPqrxLYgf9Emx7Q9K53qhK3xUIJ3O2kC+G5Uv8Ylk3OaX7Z0b1vvz?=
 =?us-ascii?Q?9cI9Wfy+QeHOhKBj50z/ZrR1Hz0G6G+Qlac7zVH6ubQa5a3apOXuuAxOVGd3?=
 =?us-ascii?Q?dl2UyvBb9pKByOvEJ9nWjFQvWS1p5QgM4VnufWrpTnARWpH9iInsC5omJwPk?=
 =?us-ascii?Q?K5oIjZUTtt/M4RttU2knah7NNdT3a/4jM2oQeGAK2aGVHgfjJMAxK9ceuJ/G?=
 =?us-ascii?Q?q6rr4gpN4xldEbE45LQDDGvdgU3hnNmgzeEFRbFD7f1/k6plxBx5LNnUGRnh?=
 =?us-ascii?Q?9/SnsOvvqKraTIGLcK9YJsWuRQ3KpQWZEBm950eylUloJXw1Eli0mst7jlKg?=
 =?us-ascii?Q?RZpE04eXmwteX43kYCSPHdJ9R+q09AhF2I3cc6O27Vm+YOzw/SA9V2Oj7Xrv?=
 =?us-ascii?Q?R8H8M1PJb5B++iAJ9XpL6/fIdrGElxX0yXhr21EcOZcvaqFXIKZC2eSJWmun?=
 =?us-ascii?Q?kd5TuEKqPoJ0jNwHkT6VJSvVp4H//obn7EC23NruIx0JOXwdafVoMP3yZjyY?=
 =?us-ascii?Q?aFdvwH7obgZdf2dOwgcqyBKleoMMezLykDzs/6Qa+1ctSl8G+CcuERiweySk?=
 =?us-ascii?Q?4B2X4U2A/koLR2ezzcJhdWNoz5LccH1rxal6+0aBc5KvwyRcwyE83s5u73Ds?=
 =?us-ascii?Q?/nJROJHk969/Azuczuuid3E98Pc6BEbDCOne9Ymtco8iCyn6L9sotCNFH90y?=
 =?us-ascii?Q?abw1DD1YZHo1tmgM3hJCjYwls9lNigruHet39kZ6RfUafKk+vOK9FE2tjm49?=
 =?us-ascii?Q?poNvgh2DTWikICloWRgLrwtpx+qS1G/VQDSzQg+sCszw?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e20746de-aae3-4516-5588-08dbe8f2de2d
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2023 11:30:01.1375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ia8XkdAfzXIMiWZSRr1ER5Fvfnvcf4jGuJleTvzYVN0/BEUDe7KtWZtikC/fsiYGeEHPgA8HP9ZgvuxD6lVL6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1060
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
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
X2NvcmUuYwppbmRleCBiOTZmYzJiYTg1OTYuLmI2MzZlMmNlNmU4YiAxMDA2NDQKLS0tIGEvZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL3Nl
cmlhbF9jb3JlLmMKQEAgLTE0NDQsNiArMTQ0NCw5IEBAIHN0YXRpYyBpbnQgdWFydF9nZXRfcnM0
ODVfY29uZmlnKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJdW5zaWduZWQgbG9uZyBmbGFnczsK
IAlzdHJ1Y3Qgc2VyaWFsX3JzNDg1IGF1eDsKIAorCWlmICghKHBvcnQtPnJzNDg1X3N1cHBvcnRl
ZC5mbGFncyAmIFNFUl9SUzQ4NV9FTkFCTEVEKSkKKwkJcmV0dXJuIC1FTk9UVFk7CisKIAl1YXJ0
X3BvcnRfbG9ja19pcnFzYXZlKHBvcnQsICZmbGFncyk7CiAJYXV4ID0gcG9ydC0+cnM0ODU7CiAJ
dWFydF9wb3J0X3VubG9ja19pcnFyZXN0b3JlKHBvcnQsIGZsYWdzKTsKQEAgLTE0NjEsNyArMTQ2
NCw3IEBAIHN0YXRpYyBpbnQgdWFydF9zZXRfcnM0ODVfY29uZmlnKHN0cnVjdCB0dHlfc3RydWN0
ICp0dHksIHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQsCiAJaW50IHJldDsKIAl1bnNpZ25lZCBsb25n
IGZsYWdzOwogCi0JaWYgKCFwb3J0LT5yczQ4NV9jb25maWcpCisJaWYgKCEocG9ydC0+cnM0ODVf
c3VwcG9ydGVkLmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQogCQlyZXR1cm4gLUVOT1RUWTsK
IAogCWlmIChjb3B5X2Zyb21fdXNlcigmcnM0ODUsIHJzNDg1X3VzZXIsIHNpemVvZigqcnM0ODVf
dXNlcikpKQotLSAKMi40Mi4wCgo=
