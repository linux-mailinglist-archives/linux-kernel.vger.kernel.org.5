Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEE80B47A
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbjLIM7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjLIM7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:21 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC401700;
        Sat,  9 Dec 2023 04:59:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eYKjBCdu/eGPMNX+fe+3/V5zgyrTSTpHBOQ1awwSPZ3tO9rXImITj6kBWkNaPiD0+eDpZjVFNHS09sn1tkjN+Bcc+WKgXAwOJ2j3ATOV8H8IBcOI4Zc/UOu6Pt1ywTjgiYO8JMjuPmrDHhP9hEqE1y46bnyjme9QPUe/yL2CAj1Us7haDFCF43oqNXSi7dex1pJkYPgnB7aPY2UF2EoEkPvBUbWWxL7Ruuzsizoaq7NC/WOoDd0gIf/esu6CMqDe82Xhkc5WvJNwUFFJvytLavypObC+fI+WV7Hby5/u0ExuPdZceZ4O9bBx7J6o/JNCr1KUO3BIrhIF3BWVlfd6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qHmqorGPiqKU1kxDm9dkMnJf57dw2Nb8XZdG0MJ9jEw=;
 b=BpsXINK+GkGPWFRkBEJ1d1P6liWojs4EgrfcSQDtY3nsNJ5caDd3i6JbRwneCBbQWDF3+L7R3CixMGsoaqCZKcB8vkwm/3Oj1qfGLhaS/rxm1AioNVH3LCdeQjWpPOsH1c6+UmZjZSCu86i5uSRwc/hjrj94FDZAqJMYYFC0KUiNSTdb4RTSUk6qrk3Tf2qg+Gs+kdqdXp5aiePxzsV2dEr4bdGE2hRTss2KZUZWbRr8gRoAT7DDfHz80YouHt/67xaM3WlRUGmqVkG51GetylT4kEURHAcYJSrnqHIzW+f4DhFckXBS59p+ugkIZpaE9VS9Dqr+8ryVRwh7bkw4Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qHmqorGPiqKU1kxDm9dkMnJf57dw2Nb8XZdG0MJ9jEw=;
 b=QWQ8DxD9jvfp64kfnKa+DZdR0Fo8tOqDQjxFzMifPYs+9chnXBKuO2n7NAakWE3Vnk+WmwqXed8oYvVrlvxkdsvoSIJry6YM/5IR+CLKQiQo+xjFHq4pyLCCrHUGc9HNgjzvVSCV6AL9zGr/fs+1ulZvXxRlWGJ+d5WXvC+67XI=
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
 12:59:19 +0000
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
Subject: [PATCH v5 5/7] serial: core, imx: do not set RS485 enabled if it is not supported
Date:   Sat,  9 Dec 2023 13:58:34 +0100
Message-ID: <20231209125836.16294-6-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
References: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: fd583afb-b76f-49bd-9a10-08dbf8b6a84b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LuWzlqxT404t32a5H3O7UTs/oIv7w3VLSgR+vV4JuYI4sbcX48eYcXlSk4iVdfqad25mW36LCl+0x8Z4lSenuEJEPvo0Wts3oXo7SiO4310M3egN8SJZzVwRHbwK0ugqwwt0QcU6ECS1OxMYz7ef2ONdlHgI79QtBjdzMSRY5+Pzv5xr/i39ipxFcYiEQMq9Vr0fHCP9d+oajmycb+RjTMhz/KNHXo7BRU2fRkWv4+nPy/+JGLvqLqfPJw74CepFljpxvqzOSElMK85PTavxjMbp3g4HvG0CPGzNoP+xvd6QpJRlDnN7ivmYXFfRQk8eSlrZ4pacsEKUTo7GTAMZxwh+pp+sCHqced8e2fsUYXcOsxkSlNaJ58hZj+UCyvbEO42AaJssYUNXhoWqxpcjVCnm3imT1EiAQJp3cH1HPmJ4rgPyxU5J8RwLOUhCHc8b5uL0XfiXCEd+8LOwK+p2Qr5P6sck43lcREoTQ6ORl+XcZuEvAOKhkUzrA9yprvv8F6x1XirZG0be7JNzW72SVNhpIcjG9rPtijgqs+MZDEkOQ5AgpotEJep3vinwWu2L
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eC93VnJsZWtwVTdwaERPNEhLZnVVN2VIT3BhTGVhdkNqeGEzN0ZsOGIxQ3VC?=
 =?utf-8?B?UjU1M0JyRjBFRmlub1lYRWs5VVE2R0xVMHhpNlMwM3JDeThRVHRoamNoNUNl?=
 =?utf-8?B?a0FGTTJGZHhncTlCQlh3Y1FCRk5ldFozeXNyQ2Z5bXhCcVdKd3crYis4S3FT?=
 =?utf-8?B?N0Fpc0VtKzFGY2hESnlmeW1rOUd5VlB5UURwaGRtQStHV1VxT2Jxd3lQZDFq?=
 =?utf-8?B?N1FyVzhMYktKemlndlhOTGhxcE8wSDVOVlM1eHNNY1F0UVlyNjN6OFZPTTJx?=
 =?utf-8?B?aFl2SWpEbC9VQlFYNVlwWVlRZXZlSS9oUFJHRVFRaFlBRjVlaXkxQ1k2YWUx?=
 =?utf-8?B?T0p6RlJnOFp0czY4WjF6cmlERnBDZGxhdDdISnJLYWRRRUxzbHdhN29lUWtL?=
 =?utf-8?B?Sk83allPZEFwY3R0Um54QzEzSlB1TFlaWkcvWHZNRnBmcmE0d3JaSG1tcFIr?=
 =?utf-8?B?bThPTzd1YmdkM21xM1M4czc0VEFsV3NSL1NXMlZZMmgwVGlHWDdSejhwMGc4?=
 =?utf-8?B?QXBUZE52T2FZTTdyNzVlc2FmbWtzT0g1TVlCUE8wSitKdWVxN0NmandDWDBZ?=
 =?utf-8?B?RmoyMEdjeTJoK0xQK0tycmVWTEV1WTlQcmpGcnQ4MUVOSCtaR1k5VW40MS9u?=
 =?utf-8?B?OEswdzNYVWw5ZGgxcEh3ZExwRzlOK2JTZW9HbCtHcDVvbUVMbk55cVptWDNZ?=
 =?utf-8?B?K1JiTCtvZytoMHhORmU0VjVBTGZKbnZqUTJwYmwzMm1uTTl5SzFGcFQ5LzV3?=
 =?utf-8?B?Z1hUVnh5dzlzY1RmWmVZZ2x3Y3NIdFIwMnNPejRiamsvVEROTEFVOWZQakla?=
 =?utf-8?B?OGRUNXQ5WVk3SkJMSjFoazNhZHhWelp1WDVOSURRdnl3WVRzRUtKVVltem1h?=
 =?utf-8?B?em9MQ1o5TDRlM3ZZZ09FQUs1SGlZVk9RM0FnaUNqaTFpS1h3L0tXdHZWd3pU?=
 =?utf-8?B?SlE2ckg5SUFLT1BTVVdITkI1Q1RRVHFQVy8wWFJBcjN3eWVjNDJRV2Q2YU9F?=
 =?utf-8?B?NlFOeDYycFdESXoyaDR4V29leHVnUXdSUGk4bTJQVFJFRFdHTDFaM2NzT0Js?=
 =?utf-8?B?L3RZTkcyY0FPZ2ZtSytJMEZCUUFTaUFWWlRuUnZKU010Um11b3hiNnA0SWs0?=
 =?utf-8?B?dG5iUjBQYWg2ejRubmIyVUZwZzZzc0EyTGRGZGVwb0pjbTd5ZnZ2SGhkYjgv?=
 =?utf-8?B?Q2MyTEVvc1JDYnpsekNXZmNsbEhhMUJrcDMwV0RpTDdYZ2ZZbDVMWVIwRFFZ?=
 =?utf-8?B?T0g3ZWJYSFNaWDhjblBYb21LTElsVm16QTJVT3V1WGgzY3E1anFTd1RvSnhI?=
 =?utf-8?B?QWtjQVMxRkw4RVo1WUwrSVJNTGRuWEphajlBMnhrRWJBdktZenNEY3gwMG1T?=
 =?utf-8?B?S0NxaU5EZklaRGV6K0R4MDFYYzRvR0hZeFJiTVQ0MGRKVGVZTlhQVDZ2NVNy?=
 =?utf-8?B?Wndnclh6THBQVE9rQVV4T2ZINDBNYjJWYXB0cnVGMHJTY01KN2k5Wm54R3Zk?=
 =?utf-8?B?Tnd5UXo0Z0VuS2U0TmNoS0gyYld4NExnRE12ajBsUFNlTkxWeTM3azhJWGpW?=
 =?utf-8?B?U3Z0L1JDc1RpVmhiSmRobmY2d2dYVE5GZGtIVnU3WFJHTEJFaXFvb1ZmNW1n?=
 =?utf-8?B?blVPRnFnaENGQlh0QWRQRkJLOXExTHowSk9YT0JleVh3QVZEcXErcXE4K1V2?=
 =?utf-8?B?OUhqU05uWTdMdmR5cmRqa2NuSjU0bzhJZDQ1cEkzL1U1cG0vNFRTU2oxalE1?=
 =?utf-8?B?OEVYbDFsZ0xjSHJlc1ZxMGFPQUtSMzZLRStPVDV4Q2RsdnZMOVRla0pQbEFK?=
 =?utf-8?B?Y3JjWmlGWTN6Z2JtVUFBVzRkWEFMVHNzV2I5bGdHNVA2M1VINzBtWWtVei9S?=
 =?utf-8?B?VDZJWkRzeU1YaUhHR2dHQzk3WEFxWU5hME45VEpwSWVuNVpPUFNoTzNvZWU3?=
 =?utf-8?B?ZnZESVZTaFRhSUVIT200QjJ4M1hZTTFWaFN3ZWdhNEdrTmg1cXdSbkJCQ0Y4?=
 =?utf-8?B?TFB5clZPdDBueEE5aU9kZjZxVjVaY2YvZkR4cUhaNVV2aHNLS0dkcFNkdkV5?=
 =?utf-8?B?a1I1VDZJRVFLbytuaWZFbXFrTU1XRmRsTnRqVkgxbXB0bVgxclc3b2JjQlFO?=
 =?utf-8?B?Z3plc0FTTFFDREZiRmFJd05wZWY0R1RvdFZjVnNmMnoxVFBDN2h1eVMvMXI4?=
 =?utf-8?Q?3h6CrGm3CXM6B/MStZJYzZCCXa3j4zemLVnGjnOZiB4d?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd583afb-b76f-49bd-9a10-08dbf8b6a84b
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:19.5497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rMQLiMbnIIPC2Sll4u+t26Qb1EKC2d0xMOQtvD4hEonnn6q3SRuW7y7s5zoAHVrmu1dOrpxMGChWr685cgFnpg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P193MB0555
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SWYgdGhlIGlteCBkcml2ZXIgY2Fubm90IHN1cHBvcnQgUlM0ODUgaXQgc2V0cyB0aGUgcG9ydHMg
cnM0ODVfc3VwcG9ydGVkCnN0cnVjdHVyZSB0byBOVUxMLiBCdXQgaXQgc3RpbGwgY2FsbHMgdWFy
dF9nZXRfcnM0ODVfbW9kZSgpIHdoaWNoIG1heSBzZXQKdGhlIFJTNDg1X0VOQUJMRUQgZmxhZyBu
ZXZlcnRoZWxlc3MuCgpUaGlzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQgdG8gY29uZmlndXJlIFJT
NDg1IGV2ZW4gaWYgaXQgaXMgbm90IHN1cHBvcnRlZAp3aGVuIHRoZSBmbGFnIGlzIGV2YWx1YXRl
ZCBpbiB1YXJ0X2NvbmZpZ3VyZV9wb3J0KCkgYXQgcG9ydCBzdGFydHVwLgoKQXZvaWQgdGhpcyBi
eSBiYWlsaW5nIG91dCBvZiB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgaWYgdGhlIFJTNDg1X0VOQUJM
RUQKZmxhZyBpcyBub3Qgc3VwcG9ydGVkIGJ5IHRoZSBjYWxsZXIuCgpXaXRoIHRoaXMgZml4IGEg
Y2hlY2sgZm9yIFJUUyBhdmFpbGFiaWxpdHkgaXMgbm93IG9ic29sZXRlIGluIHRoZSBpbXgKZHJp
dmVyLCBzaW5jZSBpdCBjYW4gbm90IGV2YWx1YXRlIHRvIHRydWUgYW55IG1vcmUuIFJlbW92ZSB0
aGlzIGNoZWNrLCB0b28uCgpGaXhlczogMDBkN2EwMGUyYTZmICgic2VyaWFsOiBpbXg6IEZpbGwg
aW4gcnM0ODVfc3VwcG9ydGVkIikKQ2M6IFNoYXduIEd1byA8c2hhd25ndW9Aa2VybmVsLm9yZz4K
Q2M6IFNhc2NoYSBIYXVlciA8cy5oYXVlckBwZW5ndXRyb25peC5kZT4KQ2M6IHN0YWJsZUB2Z2Vy
Lmtlcm5lbC5vcmcKU3VnZ2VzdGVkLWJ5OiBVd2UgS2xlaW5lLUvDtm5pZyA8dS5rbGVpbmUta29l
bmlnQHBlbmd1dHJvbml4LmRlPgpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2Fu
ZmlsaXBwb0BrdW5idXMuY29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9pbXguYyAgICAgICAg
IHwgNCAtLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDMgKysrCiAyIGZp
bGVzIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKaW5k
ZXggOWNmZmViMjMxMTJiLi45OGI3OGQzNjBhNzQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nl
cmlhbC9pbXguYworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMKQEAgLTIzMjgsMTAgKzIz
MjgsNiBAQCBzdGF0aWMgaW50IGlteF91YXJ0X3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpCiAJCXJldHVybiByZXQ7CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0LnJzNDg1LmZsYWdz
ICYgU0VSX1JTNDg1X0VOQUJMRUQgJiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9ydHNjdHMgJiYgIXNw
b3J0LT5oYXZlX3J0c2dwaW8pKQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJubyBSVFMgY29udHJv
bCwgZGlzYWJsaW5nIHJzNDg1XG4iKTsKLQogCS8qCiAJICogSWYgdXNpbmcgdGhlIGkuTVggVUFS
VCBSVFMvQ1RTIGNvbnRyb2wgdGhlbiB0aGUgUlRTIChDVFNfQikKIAkgKiBzaWduYWwgY2Fubm90
IGJlIHNldCBsb3cgZHVyaW5nIHRyYW5zbWlzc2lvbiBpbiBjYXNlIHRoZQpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2Vy
aWFsX2NvcmUuYwppbmRleCA2NjEwNzRhYjhlZGIuLmI0MTg5NTJjMDNkZiAxMDA2NDQKLS0tIGEv
ZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFs
L3NlcmlhbF9jb3JlLmMKQEAgLTM1OTMsNiArMzU5Myw5IEBAIGludCB1YXJ0X2dldF9yczQ4NV9t
b2RlKHN0cnVjdCB1YXJ0X3BvcnQgKnBvcnQpCiAJdTMyIHJzNDg1X2RlbGF5WzJdOwogCWludCBy
ZXQ7CiAKKwlpZiAoIShwb3J0LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgJiBTRVJfUlM0ODVfRU5B
QkxFRCkpCisJCXJldHVybiAwOworCiAJcmV0ID0gZGV2aWNlX3Byb3BlcnR5X3JlYWRfdTMyX2Fy
cmF5KGRldiwgInJzNDg1LXJ0cy1kZWxheSIsCiAJCQkJCSAgICAgcnM0ODVfZGVsYXksIDIpOwog
CWlmICghcmV0KSB7Ci0tIAoyLjQyLjAKCg==
