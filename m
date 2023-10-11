Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BBF77C5A54
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:39:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232206AbjJKRjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjJKRjJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:39:09 -0400
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2088.outbound.protection.outlook.com [40.107.249.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA028F;
        Wed, 11 Oct 2023 10:39:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bDevMVhDvbc6kRDXNzrXcRpTHkgmxe0U0G7UE8Ia2IVrJSEnAb4m8LGZUcTQ2fCFRVtjf+US+3J1Si2ovXzJKBVF4vHUm02+kcPjmhMfAq6TpmzQ5o92chlorUDeefCJ/n9F6RN4NUzRRF9di+0/EWZqdzroDuGxZSfPHtGs41sLRKP88nYYFQinvUkaT9vE1oo7YG47sXny2AqqR6ettUNWodZWx4yziYC5QWRBytus64KgmItm0dLwR8RtmR4pLuQLmIZuIWH6OH5eebQ/h0mIaBpkEv7BKtOCb2hbVrRvJVnMvsG9302R63gEadWvxLncXaOS00c0A4MJRaUXnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q170O49BWb4vWVIGCynhtqlpm6sOEHUx3HPMx7DxdIo=;
 b=TVHIvyL7Gc2el+3aBock9CMshXY4fw/TwV80oEYFawNAlAWh3tLV5+BLMdecVWkQBE9DSFQl2HNHZlNWIlZ8cNOr0oMqz/3VQWzOpbXFb+v3B5xh95npzzPP9N2Bj7I6+AQgweohGVRYCbB5fQOK5Drzp0UIwLuNVxYHzzkLuVrdSHhuw5nbSveOln4Dk/eVF0HMMjNGRFljs1dUr3e/ds1IH/vbQobnMtAWh4Jx80mPqerrjsmrpxyVYdcXzouedXxqVvR1La5azlH9aAuQoRPHsVSuxw6ix1/Ofzpe8leI4COH5mIhTzLfd+tZo+PEI1/Dj7y6pEUitvIDy8TbQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q170O49BWb4vWVIGCynhtqlpm6sOEHUx3HPMx7DxdIo=;
 b=oDg+nq97Nkkck+PnQufrfUKg9axHwegqUeSa2ayw3lyzkT7282EjMeLhQeF+5Ktqi1qJcCy9hiu3miNy3m0k8lime7c6K59Q+uzfMFXknqlX4dh2DW3/Cahiglmxw62OtZMTnJzFElblvtrlJnLT+yuhb7vKaVohi1duKEgXfoQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by AM8P193MB1187.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:362::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 17:39:04 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 17:39:04 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v2 0/7] Fixes and improvements for RS485
Date:   Wed, 11 Oct 2023 19:38:22 +0200
Message-Id: <20231011173829.10508-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR2P281CA0093.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9b::18) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|AM8P193MB1187:EE_
X-MS-Office365-Filtering-Correlation-Id: 064ba462-99fa-4ca0-2688-08dbca80f664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: p6ZJ9vlgFiUtQej6AWxdefWRb4rlUL6nAWxjLIWlvYg92zFMXlE6ttfUmWPC7gPZpBwQzk2xV5qdlPS6zQL8Jbs4AxfKqgSRHpeKuDk2unR33X8LjYA2+rWGvgDnqn/gP+6qcPSW9WrNa/z83022VO6PnGnneFyWyGgv5N2tpPPAeKwoeWpNmlL1LgYLV3cVRYRTD5Xsy2Y4j7Lo6CsufXpWZCT+ZT2Md9KtaEDAaLqPJ7sSrnFCU4WlzazsZkQo6SpTTDhIAN/j4xViivS+tuSJAI6vrWmjCyl8Bb3IgU7/47lq6IUCrgLR4njzrjA2MVp44rG0M7nYcJOa0DnE/TRtxde3Vqe3IxDBZGUblt3lH+ngivzsTLXsGfyu+dmVG276FEG/ZHjL5ZI/uoe1pF9Sh0i43cVLnuEIhTYoAiGqfqWwDHdQX0poDeDQnEZTHp6qEtKIgJh9abihu1SCurAmgCPKxa8d4jFfCFD1GGP0FFsgvw9BUb7NOK8XbIRG6lTs5xdcniduKosRFy9VKFNNkbcT9ZNZCrmUH5JpaoNiNTO0P5lRga6M9JGdWaN1
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(136003)(39840400004)(376002)(366004)(346002)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6666004)(2616005)(83380400001)(6486002)(478600001)(1076003)(107886003)(52116002)(38100700002)(6506007)(6512007)(66476007)(66946007)(66556008)(4326008)(8676002)(8936002)(41300700001)(316002)(86362001)(7416002)(2906002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGRtWGdDTjdTYTFBeDNuY3BXQnZtVG9PdEhyeEEwSW9OMHFTSTA3TFBSL2Ra?=
 =?utf-8?B?d3B3NmRoRGFCbGdyK0svamt2Ri9DT0FBL05zOE5UbXBPWHBZUHlvR2NtRjRH?=
 =?utf-8?B?Q3BwQWFQVkJrdVFWeENGZm05SzZ3T0JWamRuN3FsMGFUTTRFZWdObGc1Z2VL?=
 =?utf-8?B?RUFXdmV3aDB6ckVaQStBU2VQc1hNS1l4QTJVbVdFdHhlRkZuUFNxWlpCeEhS?=
 =?utf-8?B?UVlTRWFWRXBMYjg5cXBDa2pFL2RZMGxLdkMxWHFFVHJhWEY5bGo1TE9OUC9C?=
 =?utf-8?B?WFFlWXJIVkUrSU85RVR0WkthcDNDVmRrSnpTb2VDc3ZkZjVLU1I0elc3YzBR?=
 =?utf-8?B?am42VzA0VmR2WjZ2WGpxTzJJbnAzcFZJRnIydkdvLzdyQU9HdDlKMGV5cVU2?=
 =?utf-8?B?aExNTDJDSmpycUN1cU9PakcvZ1RINHpGMG9MUC9PRFdSVXhrQ1NxdHM1SEp6?=
 =?utf-8?B?M0dWSUViVStPanZnNzlHTTZHQnFKQTRxckczSnIrRVlpOG9PclBDT3AyQlJF?=
 =?utf-8?B?VlB0SnhEV1RIVGtrc0ZlNTZDcDlTL2hHaktlVFYrbnJud1Z4VEdlSUZmNW8z?=
 =?utf-8?B?ZzFtVldLUUl0UGRTM3Z2NUlpTk10M3dLVTdRZmZRNzA3VW1nenY5bXBuVC8x?=
 =?utf-8?B?eGc2bHlmenVFSVM3SUgxN0ZGdGFqa3lLeThobVJMMmVQWXMvQi9pQ04wZDF3?=
 =?utf-8?B?dHM4NloxdHE3Q3l3bzM0NzI4L01PQnRDdjVYcE5BNDB2MlpLNzFyQkRkM2dZ?=
 =?utf-8?B?cVo4WDM2b0E0NDVHQnNNcXZFUDR3Ky9XejlaeFhmRzNVYzVXbGxsZk9tVnRV?=
 =?utf-8?B?ckFzWWxjbGdyTVNUOFRNTmpTZktEcDlOZ0ZsdUxaRHRuODU0QzBHYmFQL21Y?=
 =?utf-8?B?MzdzaWFRT0NrQi9iYi9iZmVCQmtkK1g4ZmN5UlZTUm1MYWhKZUVLRlN2MkJj?=
 =?utf-8?B?QXVYVVlBMjR6ZXBielFHQmJZS1RybFoxazE2VDNyU1ZQdVRSbkkzMlhLRlMx?=
 =?utf-8?B?U09DT01XYlAvUml3eE40NjJ4c0dOT29FWG5UQXc2TFNGVmE5cCt1VjNodGw1?=
 =?utf-8?B?OVlyalppbkxqRnZJMUwwRk9ZUEZMSU5ndnhJais2Y01ISEd0c29IQkwwL1BX?=
 =?utf-8?B?dCtoemRvd0ZadEw1Ym4wVk5QQ2FlcDVadUM2Mi9lNkhuaEpXWC93a3lXVUh5?=
 =?utf-8?B?eGRCTlZXdUhDMzN4YTNwL2dPRk45eGdwSFdtZnFUamJqbzQyNVRaR1hmNWFv?=
 =?utf-8?B?QTB3Ry83clZ3cWNqNXF1dERZcUlJUkpFeURHYW82aWx0dkxIS2RnN1IvVnoy?=
 =?utf-8?B?QWtpemVJdFZwV2h3VXJTUkxURnA1WW1ZbVBrNCtUMjlsYms1VFRjK0w2eTda?=
 =?utf-8?B?WDl0Y3liK3cvdklTcXliMmJ3ZnU1MENleTdYaVl6MGpaUUNkVlhwNUZnWk5V?=
 =?utf-8?B?UFhJUC9ObU1kVE9GTGdpV3crT1BxVmtoWExiWXdRNVVYbkduVzN1VFdKTjNJ?=
 =?utf-8?B?ZitKSk5LY28vYS94UUdTREFGUkJUM1ppNmc0M0dReTNYRWN6ZGJKOENYNHFp?=
 =?utf-8?B?ZWdYVmJRMmVzZDdlSG5RTDE5YTRSTE00dlJqV0pjeHZTYzFsOWp0NWVYbG9m?=
 =?utf-8?B?b0ZMcC9lczRBb29WaFZ0UGkxeHI1WkRncEZ5bnJBVWluaDZIRWp2N1hwQjZi?=
 =?utf-8?B?eVY2QmZFVzBLNmx5bXRDdHJPUFZ5N09DdGt6NWJ2b3liQ0JhWUthdG1lSGIr?=
 =?utf-8?B?OUxuRlBGMFJ3Vlh2U01Ub0htVFVQMitHWFp5VUJPT3lqa3NTSlduUnZ0ME5p?=
 =?utf-8?B?Q1BjY3ZJQXkrSnRnQ2E4Nk9hZFNOOHU3c0JDcTNBYjBSc1pWRkIxUC9SWmVj?=
 =?utf-8?B?SENSRjNDRzIxSGdZYndzVmFkRTVacGM3ZndvZnkwdk1FZmRjcWtxZiswbUcz?=
 =?utf-8?B?ODdhVmVNaS9xUnl1d2tSMGZoOC9XNVBCbGRjM2FMUkhZdE5udW5tTmdBSG5q?=
 =?utf-8?B?RFVtWTEyOE00MlRSWjR4V05LdHNabUkrSU15a3ZxUWV5aUtKRlozWThwMVRS?=
 =?utf-8?B?R0tRcXdYNlZoSVpuMHFOc0JHR0E4TWIwemFoVVFkWW1kVmtObzRTNXdwRVY0?=
 =?utf-8?B?aWZwNCsrRDlFSXY2YnRSQks2QXl0OFhBbVkvS1BGVFA0cS9odXMvWGx0YmxW?=
 =?utf-8?Q?hZC6ji64DjRN0VlsP4MnO2i0/LsmHgpf2COKX7Xu27fC?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 064ba462-99fa-4ca0-2688-08dbca80f664
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 17:39:04.3886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kV8DmyrLEOxoyxJdHJik5aiunok/Cwe/CFAR8SmdYIBHguwbAVEIkiiN2L71UdTQsTZSWeylBxpZtuJ6a8rcBg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P193MB1187
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhlIGZvbGxvd2luZyBzZXJpZXMgaW5jbHVkZXMgc29tZSBmaXhlcyBhbmQgaW1wcm92ZW1lbnRz
IGFyb3VuZCBSUzQ4NSBpbgp0aGUgc2VyaWFsIGNvcmUgYW5kIFVBUlQgZHJpdmVyczoKClBhdGNo
IDE6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxvY2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBH
UElPClBhdGNoIDI6IEdldCByaWQgb2YgdXNlbGVzcyB3cmFwcGVyIHBsMDExX2dldF9yczQ4NV9t
b2RlKCkKUGF0Y2ggMzogc2V0IG1pc3Npbmcgc3VwcG9ydGVkIGZsYWcgZm9yIFJYIGR1cmluZyBU
WCBHUElPClBhdGNoIDQ6IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMgc2V0dGluZ3MKUGF0
Y2ggNTogbWFrZSBzdXJlIFJTNDg1IGlzIGNhbm5vdCBiZSBlbmFibGVkIHdoZW4gaXQgaXMgbm90
IHN1cHBvcnRlZApQYXRjaCA2OiBpbXg6IGRvIG5vdCBzZXQgUlM0ODUgZW5hYmxlZCBpZiBpdCBp
cyBub3Qgc3VwcG9ydGVkClBhdGNoIDc6IG9tYXA6IGRvIG5vdCBvdmVycmlkZSBzZXR0aW5ncyBm
b3IgcnM0ODUgc3VwcG9ydAoKQ2hhbmdlcyBpbiB2MjoKLSBhZGQgbWlzc2luZyAnRml4ZXMnIHRh
Z3MgYXMgcmVxdWVzdGVkIGJ5IEdyZWcKLSBjb3JyZWN0ZWQgYSB0eXBvIGFzIHBvaW50ZWQgb3V0
IGJ5IEh1Z28KLSBmaXggaXNzdWUgaW4gaW14IGRyaXZlciBpbiB0aGUgc2VyaWFsIGNvcmUgYXMg
c3VnZ2VzdGVkIGJ5IFV3ZQotIHBhcnRseSByZXBocmFzZSBzb21lIGNvbW1pdCBtZXNzYWdlcwot
IGFkZCBwYXRjaCA3CgpMaW5vIFNhbmZpbGlwcG8gKDcpOgogIHNlcmlhbDogRG8gbm90IGhvbGQg
dGhlIHBvcnQgbG9jayB3aGVuIHNldHRpbmcgcngtZHVyaW5nLXR4IEdQSU8KICBzZXJpYWw6IGFt
YmEtcGwwMTE6IGdldCByaWQgb2YgdXNlbGVzcyB3cmFwcGVyIHBsMDExX2dldF9yczQ4NV9tb2Rl
KCkKICBzZXJpYWw6IGNvcmU6IHNldCBtaXNzaW5nIHN1cHBvcnRlZCBmbGFnIGZvciBSWCBkdXJp
bmcgVFggR1BJTwogIHNlcmlhbDogY29yZTogZml4IHNhbml0aXppbmcgY2hlY2sgZm9yIFJUUyBz
ZXR0aW5ncwogIHNlcmlhbDogY29yZTogbWFrZSBzdXJlIFJTNDg1IGNhbm5vdCBiZSBlbmFibGVk
IHdoZW4gaXQgaXMgbm90CiAgICBzdXBwb3J0ZWQKICBzZXJpYWw6IGNvcmUsIGlteDogZG8gbm90
IHNldCBSUzQ4NSBlbmFibGVkIGlmIGl0IGlzIG5vdCBzdXBwb3J0ZWQKICBzZXJpYWw6IG9tYXA6
IGRvIG5vdCBvdmVycmlkZSBzZXR0aW5ncyBmb3IgUlM0ODUgc3VwcG9ydAoKIGRyaXZlcnMvdHR5
L3NlcmlhbC9hbWJhLXBsMDExLmMgIHwgMTQgKy0tLS0tLS0tLQogZHJpdmVycy90dHkvc2VyaWFs
L2lteC5jICAgICAgICAgfCAgOCAtLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9vbWFwLXNlcmlh
bC5jIHwgIDggKysrLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDQ4ICsr
KysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc3RtMzIt
dXNhcnQuYyB8ICA1ICstLS0KIDUgZmlsZXMgY2hhbmdlZCwgMzkgaW5zZXJ0aW9ucygrKSwgNDQg
ZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IDk0ZjZmMDU1MGM2MjVmYWIxZjM3M2JiODZhNjY2
OWI0NWU5NzQ4YjMKLS0gCjIuNDAuMQoK
