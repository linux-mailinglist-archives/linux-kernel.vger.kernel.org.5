Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4342380B464
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 13:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjLIM7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 07:59:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjLIM7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 07:59:15 -0500
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2043.outbound.protection.outlook.com [40.107.7.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AD610D0;
        Sat,  9 Dec 2023 04:59:20 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P2ATX3KvYqafdrFZ8hAPo7RhIXR01Ael7YSTgBz/iAnYTrkPC+LSAJ24efq0I4dDlGdD42uXxlmPBkYOvSm2Kg71SIv0EpVbkcD2/HbuvcuaIyUgd9UdmPhrsHltMMkK4UVn13NVwcGKoxd/U6Vh7P2Me78Ci/sq3IR00oNeXw1KzXw0NyOh+sD00n31wgHRzkg41OlX9SU89Hxcjk51fR+m1xgNt9awJsZ3pvYX7LKb2kmWNB+m+UkBJtSq76fhbXCVIpK3iVqOAYqQOzyvA1urKhmElKTHjmUpjh1EG8u/PJ/j+FL26gHi0eeIYji0Xy97ePizdvsWV/MnrNYvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/19jT5xjHvyfQoWOMyzF+oUc7qc5rYYEI2f2qQd3w3Y=;
 b=naxSZGDjjo1WubhnAXyEwNJ2lFSmvyNaSQbw2y3cLakaeNra+x0NI2wSTKdDjnuT9AHnZlEWBICGTDIhghr3uyIbd9wQhOJCAi6k7xHK2xe0ZDEc/71pSeKZwSKZgB0X9bE7E9YppKaus4PuTLQJDYMvS0tCcSJJwkGWChMSGrHPbaJx5S/gGuOTfqzXgEjeF0Uv7E90NKP//yhWA2EIGt5X1AcVehkQ695FLvPHPpNpbleFVuI80itxfizm9TvE5z0CMMEP/rMVizByguqVA9+5rVkq/hzvQVBcJ2/IExGQyquPJScrRQZZkFdJISTSLjA758No51gj7AbAjckrTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/19jT5xjHvyfQoWOMyzF+oUc7qc5rYYEI2f2qQd3w3Y=;
 b=L1aHeqHszH8rcv6xq9c8cbCcXwwL2e8Tuv5varUilNWDK7uZ0cPd2lzxgVElIaPZEjlr1rizXG14zRriAHgt3OsATR5DNJq1jfIwF5hmldhdE6eUnTiCb2sAgyFh97U2akJi8TWPPyKJxnFoqDK3f4XjPLtinEd6Iu7Uf3mhDSY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by PR3P193MB0555.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:31::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.29; Sat, 9 Dec
 2023 12:59:16 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::653f:d0f3:e7f6:8c06%5]) with mapi id 15.20.7068.029; Sat, 9 Dec 2023
 12:59:16 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     u.kleine-koenig@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        hugo@hugovil.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v5 0/7] Fixes and improvements for RS485
Date:   Sat,  9 Dec 2023 13:58:29 +0100
Message-ID: <20231209125836.16294-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.42.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0070.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:4b::22) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|PR3P193MB0555:EE_
X-MS-Office365-Filtering-Correlation-Id: 105869ad-628a-40c6-787e-08dbf8b6a622
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iFxsNEPVgTmWCAjfnLESy2HdSTkltn/SX3Cf5WwjXag5kqwtNdRf3iKboeyHeQSDLi0aV7L1A7S09I9NgZOAJoSzOKRvZZyxPfz26ZNg8mTVXW8NTheqHDeispmfl+vnk6C+XMnlXL4aB8ZLJc5iwziZdEPO58t0kdrc4fK/oMuQFIqIHtEV65MmMaVUMDpLo86ZdKtBdEwciZR9P2WyQYMFmn+MbmrUN863IJTUhf1M78zAuTxtiY0CgmYUDlhbvY5U2+0qIBkUlnk0bdbJhTi0pficSDNXAR2vvexQeONKYgBfJSJk529yd0e0URCX+u45g3g/+CLs5YId6sf3neBcuFnofcCj10jmdIGBIsIJY86dlzlhrRLiH3kuT5LOu3/JlBeL1CL9kk0o/xPDJveSczrLrP1+1QIZHfpuKBXzXtxjXN3/oFn/1DsKfN+XocA+4TcRnFMB5NTHa8heVwx35G5yp31CdMCv0vaTj4vK4s0esBE9BCssvvwbUslSyHIudO35hEPjzWqIIcDbz2msA6vEfL+mpEQq7R5hx17fcyzfWyA+JiyHoiSXyeWa
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(39830400003)(366004)(376002)(396003)(346002)(136003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(2616005)(107886003)(1076003)(478600001)(6506007)(6666004)(52116002)(6512007)(41300700001)(83380400001)(5660300002)(2906002)(4326008)(8676002)(8936002)(7416002)(6486002)(66946007)(316002)(66476007)(66556008)(38100700002)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlU1YVRPZjNxTVdma3RvZGJ4Yk9hUVk4aEpQYzdFMHVrRFlXdGVoaHlaMnBO?=
 =?utf-8?B?SmIzbzJKMjE2RUxVMklOZFFmWkRLTHFMMnlLZE4zc2x4Y1JYMWtTOEFON2JG?=
 =?utf-8?B?VzBZUHZxQUc2OTV6bUNBZUU5bmRrcFhsZUROU0ZSemc2N09leHZYNWlqdTZj?=
 =?utf-8?B?SmhHdEwyUklyb1c4dHplWmJrNTROV0sxSS91eU5uRjdIS1NvMzY1M1VEMGtj?=
 =?utf-8?B?UmhhVk8xQXJMUGovSTg3WWp5QUsvcXMrV2g3QWkvY05xbGh6dWpSSVZvc2Ji?=
 =?utf-8?B?d3NLdTZsSTZlUkhJVVU4TlJwU2JhTmREdno1d040eXJUNEVwMmE1NUhuNWM1?=
 =?utf-8?B?OGJDUTdtUGIwN0w2eWRyd2NmVXBiZnVJN2FzK2VuWVI2QTAvZXVPaTRKbEVn?=
 =?utf-8?B?Rnl2T2l0MUM5SlR4VnducldqNlUwQTNiSnhmUzlGMittOFNKUHNtbjBwLzNO?=
 =?utf-8?B?UVNXdUpscWtXdFVod1doKy9UTFMweXAzQkdvT0lYcWR3a2hPYVIxTTFMMlJS?=
 =?utf-8?B?clUwM3F1T3FCTUd0QjlNQmdQSDEyUjd5VVJ5amlkZFFKdE1zdCtHK2ZMWUYz?=
 =?utf-8?B?Um12ODBlODNabERPOEZlN21KVGVOS1NQc2k1ODBTaG1OVmFCcFJYSlFwYXJn?=
 =?utf-8?B?aW44cndjczhyMFgyRXZreEFES1lpVUJuSk90T0Z2VXBZbEkxT21LZUJ3b0FT?=
 =?utf-8?B?VStHZW54RThxSjZSYTkyNVZnUjFYL3hTdCs4akRzZ0Uyb3F3eUtVaUZCUVFo?=
 =?utf-8?B?NlloQXMzdnpOOTVBQ0t2Q3NKeE15NTZibk8vbFo4amI1Y2RwY0dBSkdLdXJp?=
 =?utf-8?B?YjhWQ3Z1dTdycE5XbldqckdyYVJBWThTRlZLcW1rNWZiT3J2cWJ5TkpENkxl?=
 =?utf-8?B?UGtMV0VDeFZuYXBtTmh6WXFMdHRud3VQeUk3bHNsc3dGeGdoRnZUWnQvTGh6?=
 =?utf-8?B?OG9DTm8wRVJUcjRGc3ozWUFvNnJlby96NkZEMlkxUkk4SEErSlU4aXVKWDFU?=
 =?utf-8?B?ZkJMODgwQkEzZzIydzZ1UW9DOXE5RFZQODU1ckZmenRFZWRYMmJzZXU1bEdF?=
 =?utf-8?B?UGN1RXBDcW5Qc1V0R1BLZHlsSVFpNDdCdCt1N1Q2ZElUYmxYKzZCemprc3Qr?=
 =?utf-8?B?d2VLZ0preGt5Z1pCYmFVOEloNkdRWHpMR09hOUl2WTdpcHo3VGovSHkyV2E3?=
 =?utf-8?B?TFplL3hBOUVkZFIrNnFNbDd3UFZHak5WNVd2cjhsZkVvQTZaY3lkVEpnRUds?=
 =?utf-8?B?R0thWEYwbEJPNHpvSUdOWHNuN21ZS0FNZHBycG1URjBoVnI3bW01eEFhMnEz?=
 =?utf-8?B?eStnelpuZlBTeG5qV1JOdUdteHlCeGNKYk5jVlNWbXVrSEF3STM0NlBONDA2?=
 =?utf-8?B?Z2g3ZXJIZkM4bWpkR2lTdVM3OW5JNDk4c1lXSGUweThONWUzYmcrUzhzMnJG?=
 =?utf-8?B?dXpwREZYRmxENmZQb3ZCRjZLQzloR3VLRjRoenlMZWlZeWVVcEdnWHRXU1FV?=
 =?utf-8?B?MGZ0NEtsd1p4ODIxSXE0KzZlQmZKUjV2VjNHTGxYeFZ1THo5eDhOaWpWYTF6?=
 =?utf-8?B?bmVlQnc3QXRwSTQ3ZW83M1JoRzhiRzFCZ2J6RkphQkhuU2k5VUp3V1ZmaHI3?=
 =?utf-8?B?UjBrMzh6KzMwM2oxbUF1MEJIRWhXN1ExMFNTMHVrcVo1WW1pQVJIbXB1bTU1?=
 =?utf-8?B?SFRWelNwNXl4WkhGdjFXck9KYnB4VjNtUzBnVG1yNFBsdk9Rd3BPenVpcEVB?=
 =?utf-8?B?T0t2MlJFbENXbkVnQm5yV2FvWndBUW5ZTHIrckdFRFdVZHNnOWVYMUdPanNS?=
 =?utf-8?B?dFovZVdkN3dqeHIyM2FGUFBOeHdRdnJEREhydEgvU1dQMS94SmJhcHBOL3Rj?=
 =?utf-8?B?T2JzVXNJUmNsbkZTOFA5OXc0K0JVQzkxOUxWV3pUckY0MDNzaHhESnV1ZHpY?=
 =?utf-8?B?SG4rYitsd2ZZVkNPUWppeTJFdEVNdmtTdXg5QnhNRk1DK0swZ1ozYVpFaSs0?=
 =?utf-8?B?eFVLMUtKMmgvOVhraVR5Sm0rN0Jvb3l3N3dUdjhnZFN2WGZUQU9Cd2VxdFlK?=
 =?utf-8?B?RWNwWWsyTWFpZVU3MHU2ZmlTUzUzUUdXcVNNODFVRHhSeVQvZ1I2WmlvREI0?=
 =?utf-8?B?SWszeVZGMS9wNEp6UVpJTjVBMXRlT2gyZ0MrZzNBS3FSUzlidUtGRFNvOGZJ?=
 =?utf-8?Q?j/7RlK3xX/m9iCqiem9+zeeb3ZYfiefHz6zC9vi4X9cl?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 105869ad-628a-40c6-787e-08dbf8b6a622
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2023 12:59:16.0334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZtXSs9145kxchKQ4hZzor4p0ZmwgZq64zrI0ppw7Lx9hRZrj4Db7SOlDSb/Ea5y7pxABNafV/+134+MHBo4H5Q==
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

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBH
UElPClBhdGNoIDI6IHNldCBtaXNzaW5nIHN1cHBvcnRlZCBmbGFnIGZvciBSWCBkdXJpbmcgVFgg
R1BJTwpQYXRjaCAzOiBmaXggc2FuaXRpemluZyBjaGVjayBmb3IgUlRTIHNldHRpbmdzClBhdGNo
IDQ6IG1ha2Ugc3VyZSBSUzQ4NSBpcyBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdCBz
dXBwb3J0ZWQKUGF0Y2ggNTogaW14OiBkbyBub3Qgc2V0IFJTNDg1IGVuYWJsZWQgaWYgaXQgaXMg
bm90IHN1cHBvcnRlZApQYXRjaCA2OiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0dGluZ3MgZm9y
IHJzNDg1IHN1cHBvcnQKUGF0Y2ggNzogZXhhcjogc2V0IG1pc3NpbmcgUlM0ODUgc3VwcG9ydGVk
IGZsYWcKCkNoYW5nZXMgaW4gdjU6CgotIGRvIG5vdCBjb21iaW5lIHRoZSBmdW5jdGlvbnMgdGhh
dCB0aGUgUlM0ODQgR1BJT3MgKGFzIEh1Z28gb3JpZ2luYWxseQogIHN1Z2dlc3RlZCkKCkNoYW5n
ZXMgaW4gdjQ6CgotIGFkZCBjb21tZW50IGZvciBmdW5jdGlvbiB1YXJ0X3NldF9yczQ4NV9ncGlv
cyBhZnRlciBoaW50IGZyb20gSHVnbwotIGNvcnJlY3QgY29tbWl0IG1lc3NhZ2UgYXMgcG9pbnRl
ZCBvdXQgYnkgSHVnbwotIHJlcGhyYXNlIGNvbW1pdCBtZXNzYWdlcwotIGFkZCBwYXRjaCA3IGFm
dGVyIGRpc2N1c3Npb24gd2l0aCBJbHBvCgpDaGFuZ2VzIGluIHYzCi0gRHJvcCBwYXRjaCAiR2V0
IHJpZCBvZiB1c2VsZXNzIHdyYXBwZXIgcGwwMTFfZ2V0X3JzNDg1X21vZGUoKSIgYXMKICByZXF1
ZXN0ZWQgYnkgR3JlZwoKQ2hhbmdlcyBpbiB2MjoKLSBhZGQgbWlzc2luZyAnRml4ZXMnIHRhZ3Mg
YXMgcmVxdWVzdGVkIGJ5IEdyZWcKLSBjb3JyZWN0ZWQgYSB0eXBvIGFzIHBvaW50ZWQgb3V0IGJ5
IEh1Z28KLSBmaXggaXNzdWUgaW4gaW14IGRyaXZlciBpbiB0aGUgc2VyaWFsIGNvcmUgYXMgc3Vn
Z2VzdGVkIGJ5IFV3ZQotIHBhcnRseSByZXBocmFzZSBzb21lIGNvbW1pdCBtZXNzYWdlcwotIGFk
ZCBwYXRjaCA3CgoKTGlubyBTYW5maWxpcHBvICg3KToKICBzZXJpYWw6IERvIG5vdCBob2xkIHRo
ZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBHUElPCiAgc2VyaWFsOiBjb3Jl
OiBzZXQgbWlzc2luZyBzdXBwb3J0ZWQgZmxhZyBmb3IgUlggZHVyaW5nIFRYIEdQSU8KICBzZXJp
YWw6IGNvcmU6IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMgc2V0dGluZ3MKICBzZXJpYWw6
IGNvcmU6IG1ha2Ugc3VyZSBSUzQ4NSBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdAog
ICAgc3VwcG9ydGVkCiAgc2VyaWFsOiBjb3JlLCBpbXg6IGRvIG5vdCBzZXQgUlM0ODUgZW5hYmxl
ZCBpZiBpdCBpcyBub3Qgc3VwcG9ydGVkCiAgc2VyaWFsOiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUg
c2V0dGluZ3MgZm9yIFJTNDg1IHN1cHBvcnQKICBzZXJpYWw6IDgyNTBfZXhhcjogU2V0IG1pc3Np
bmcgcnM0ODVfc3VwcG9ydGVkIGZsYWcKCiBkcml2ZXJzL3R0eS9zZXJpYWwvODI1MC84MjUwX2V4
YXIuYyB8ICA1ICstLQogZHJpdmVycy90dHkvc2VyaWFsL2lteC5jICAgICAgICAgICAgfCAgOCAt
LS0tLQogZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgICAgfCAgOCArKy0tLQogZHJp
dmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMgICAgfCA1MCArKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL3N0bTMyLXVzYXJ0LmMgICAgfCAgNSArLS0K
IDUgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMjkgZGVsZXRpb25zKC0pCgoKYmFz
ZS1jb21taXQ6IDMzY2M5MzhlNjVhOThmMWQyOWQwYTE4NDAzZGJiZWUwNTBkY2FkOWEKLS0gCjIu
NDIuMAoK
