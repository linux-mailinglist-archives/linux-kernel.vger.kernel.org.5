Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACB57C5B14
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234878AbjJKSQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 14:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbjJKSQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 14:16:15 -0400
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2041.outbound.protection.outlook.com [40.107.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9C6D6;
        Wed, 11 Oct 2023 11:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HjIY0ptr51IfPq3ZBnTZsY7uKrBIhj4tEtj555N/YouOEUe5oqodj2Pc0hkOuZ1YqHhvdJ/LRpSCIhxpyUa4ZQOUlXn+LitUnnU7UZcvqgE9j7OjaRixMVOsgxlEU8FEBqtyqtDGbePiUpD0ChAJzfFUGLNJz2oB72oCzqYqapiHjALkGcoOGJx4F2D1YK47RTuR8vm4u09Mxx2GaGKClEWGNapzAscVS1fo/gI+DplfLB3rwf9MMejvkP+G8wIRU7WdfS7NIyFLRRWiWQwXt3YoVx7B8zXqjtTsQJqdMC4RtxLiS8LRz4hvjfRs/fPnY2ukqVOeOPWFt6uZ2sF3Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wmRo/AiBz8nrN0SpKkVMVhPBADrDyRF667kWifwwGAc=;
 b=Q//I1bPlQWcJz+4E2FYnVZbql6zk6yjLwA5bChzsd0OGs5q/36mjo5mf/I6YKuFKEtZdQX0cHMVOB4iNI0C+IDqVjs3hr61NUQ+HBLDkE0jrD5ONY5ZLaEeLkJ+3buZRyU4B1qaW8U1WYQjrGNzySZNN7Vjp/WX41L9RCjzg+LYYwBd9bGHepxBDCddWcOSV2OqhfSnQlDP+W3w2F9fCbYEGTp9PA36Cv26Gjqkq0kurKdTd3AkS5PpvitbWfKQyRRyfDsZISTauPTCBZMeWu/Ceg+uXhZ+FAiV4PW4Fx88OTykYQ/q737VOZJNrRF7QZbftltdWL/IFBj41Cka4og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=kunbus.com; dmarc=pass action=none header.from=kunbus.com;
 dkim=pass header.d=kunbus.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kunbus.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wmRo/AiBz8nrN0SpKkVMVhPBADrDyRF667kWifwwGAc=;
 b=i/d5R4pei7M2JQ4pDIl7T5p8ZI1+LUIQmqe+K5nSu3Dx7DjQnDPPjHPj8HXwmQ12qdsr1DnjPBCqwfv3mHDUJhZTXpGdcvGq3kTGGvBmGBzuCxOmlVI6OuEAwds7Mj9/hZoJBxhh8RwXmJut6ZT7bqlv4WFjPcjqqJ654I79QgM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=kunbus.com;
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM (2603:10a6:803:4e::14)
 by DB9P193MB1497.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:26f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Wed, 11 Oct
 2023 18:16:10 +0000
Received: from VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59]) by VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 ([fe80::550d:2425:c0ed:3e59%3]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 18:16:10 +0000
From:   Lino Sanfilippo <l.sanfilippo@kunbus.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        ilpo.jarvinen@linux.intel.com
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        cniedermaier@dh-electronics.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, LinoSanfilippo@gmx.de,
        lukas@wunner.de, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Subject: [PATCH v3 0/6] Fixes and improvements for RS485
Date:   Wed, 11 Oct 2023 20:15:38 +0200
Message-Id: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
X-Mailer: git-send-email 2.40.1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-ClientProxiedBy: FR3P281CA0163.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a2::9) To VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:803:4e::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VI1P193MB0413:EE_|DB9P193MB1497:EE_
X-MS-Office365-Filtering-Correlation-Id: 95bf9921-62c9-4a40-e0f9-08dbca8624fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6HD+fKQtvHy9cBlZ3lQ3L8C4Jib7L3Ge2EkNVwzmE7uODRo0b+YUl02fdICFTQo6B9CqXb7CE9lLwRNF6bn9ssO10wR1wDNYZcrzOzY8B0j9wZmrhx9X1mvY4U+yTZ9PiXr3n2Lp/I0tytX11JvYuIiZMbCviII4U/FvbFPxoO9ITE5G9cGZoitMlFfPn7+bZOovTqafdOixbeoJ1Vm5hyrAUl3o8BbqjMGHVrYbQExWRKe8JsbXQh4TOGaOcyqAMThKaS/LC5sRlL2g0Ap2PuCx+fnS9ssVkBuaYKZeZzRRGag9V4YrCgv3V3goDCEBZ/4kb1Ndc2jLn5kGm0OtxUi1esJYzFW9AILMpkhb4RwUqIFRhwg0cA0y0O+SCfWbZ6dWVooKkI8xKFeX7t9icLos26RYn5Gfj3Chnv0unAS4lVs7RgTu/atyFFwoGs1M4h/5QU934WxZMPSAECWdVzeVxCkHxJ4rBuCKyCfj26T3k9R2FRwf4tBFhbx9r+DFjfULCEjA2C8oeUz1x/zmEu/jf77cIECr758GD6nkmfrGU/rxAQuxQejVp4uqysM8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1P193MB0413.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(39840400004)(376002)(346002)(136003)(366004)(230922051799003)(1800799009)(451199024)(64100799003)(186009)(52116002)(6666004)(6506007)(478600001)(6486002)(6512007)(38100700002)(86362001)(36756003)(2906002)(5660300002)(7416002)(83380400001)(1076003)(2616005)(316002)(66946007)(107886003)(8936002)(4326008)(8676002)(41300700001)(66556008)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TXhhbEUrTWQwaUZPUkFWZ1Z0aEw1akpsQ29mSnI1bFJ2bGNWdlR5QUh3bm9z?=
 =?utf-8?B?ZWprNUNKWHAyWU5rRVBDVlpFdzh2OGlnK3pRR2pQVE8rdklTcU4vV2pGYU1D?=
 =?utf-8?B?eXZRTFFxTlBTUGo5M2h5dUZyN1FrNFRPSVdzYnVRUkh3aGFkNDZ3bUFEVm9Q?=
 =?utf-8?B?ZWJwVldwd0pnSzRZUUNVT05lajlIUlRxQ0hXUmN1Q0dOZ29lVEdiVHFJOXpw?=
 =?utf-8?B?MlF6Zi9GNy9CZ01mZVcxdlRTMWlnWnBoZk10MWNuUHZqZktldTM0cmZyQlYv?=
 =?utf-8?B?RnhuWlVjVXVMcWFaUTVaTlZ2dGhnZis0UUtSNGFSd3JRRnBpbDRzMlhpTGZI?=
 =?utf-8?B?d3A4UjRqTVJwalgyc1BDZko3RHlRR29uNEIrSTNaQVk1OHBTb0tLc0RzL2xW?=
 =?utf-8?B?N1NUVTRzejBuVTFJTmZQb3I3N25wR0NDbXowbW02clFKNGFELzkydjdTSG1a?=
 =?utf-8?B?TXh0d2JJazR1c0NleWdnWTZzRWY5MFlobmhLbWdHQVZmSWxidFAvUmJMUVJS?=
 =?utf-8?B?NW9DU1ljK2hSL3lOcitCYUl3TjVnLzlRdWlGdzJlYW8yYVhaN1RMd0lWZHVU?=
 =?utf-8?B?b2p0MlZ0emFUbi9LVWVZQWR3M0hQZ0F2a2czSG1rb1cxMlZxZWY5TjZHeVpy?=
 =?utf-8?B?Wmltb0VXcGhoTUQ3Ym8rVlhhTXkvSGw2Mzl4RVRlM1dyYjdWSGZjZkVISEpi?=
 =?utf-8?B?M2pKeHJnd0dUc3A1a1hEa2I0ZW0xekFGRi9QVVMyNzgzczZwOUJ2cVFFTGNo?=
 =?utf-8?B?VnBMNmNRN0tVTWdPb0NONzFvWlJRMitLbVdqWDN5UERNOGlTNCtOMXJjYlpx?=
 =?utf-8?B?dWtFVmxzMmQyRFYvMTdOa0NVR0F0RVB4QjFnbG93RXhtY1hsSXV2d2h0VitC?=
 =?utf-8?B?TEw5V3NWdTdINmdCa0dzWHFlcmxOQWNhTjA3Y2JtYmpVUzQraHFzYThhL0k4?=
 =?utf-8?B?WUZIY1VTR1RBVlozRmNxenk0bngyTlVyK05LZG8xaGhROTh1eUJrRlFJZEVh?=
 =?utf-8?B?VllCNFU0NUQxQ1hiUjB5NHpxYUdGeDJPdEptQ0xFeThtQ2Vxd0hhdDFRTCsw?=
 =?utf-8?B?eGZERldFNkxObVJHSWFkQktnbTVWbUdFVnpsWXpSQlIxVFI2aldGRzJMci9l?=
 =?utf-8?B?Y2Jkc3FPazVJOHF3K2tnalV0N1lNSFVCQURmWXJDTC80TE9QY2pZM2JVRlJ3?=
 =?utf-8?B?cTl4d0pnbkFBaGIraVd4ZHRvMHQ3aVNEZ1ZCTUdHYng3bjBWbmZTdDBVeVZH?=
 =?utf-8?B?T0huT0FIVjBrRzVPTmtOYldGajlLTVhpNHgzNnIyVEdERHNOT2RLVURwT1Vm?=
 =?utf-8?B?c054UkhxWWdZZWc3SlYrOHB2UWp5MTBBRC92U0V2N2wvYXFoZGZwYTFzS29U?=
 =?utf-8?B?SlRrSlIzRzVXbWRvN21oV0IrK28yOUVpaW8zbExkQzRyOE5BVkh1eHVNS1M1?=
 =?utf-8?B?cjBmcjJqRXUzd0daSERhYTB0b1VsanM3cm5mQVU3OS93UmNSa1hLWjkvYlJV?=
 =?utf-8?B?MzVBajF1VEtuTXM0U2ZyNnB2T2QwdnNNMEs4SFFxUzVsVWFzcFZOUkUwTS9N?=
 =?utf-8?B?NHVVZFBhS0dEcmpYSjVHSDlvTHVjVGd0RllnbjZ4SU9ja1VTbHNMUmEzZzZt?=
 =?utf-8?B?TnpsTkpSbVhQMGJwZTlIOHdwOUczdUk4bjcycTc5MnhpK1U1bE5EY01kalRZ?=
 =?utf-8?B?dTBYVnRZZFdjdndKWjlDVUJqQkZ1eTdWa3pkbTh3Y2ZPeGV2S2J2NldKU3pL?=
 =?utf-8?B?bnovS2NlRGxjTFZWVEU2all1ZEhpb1A1Tkp6SnBpbzdjK2Rndi9aeTBTNFRh?=
 =?utf-8?B?cG0xS2FRRjNXZmZ0UXp2NERJRkJ5RTZQMHNCR2lkT1ZFZ3ZMd3p3dVJJbXVR?=
 =?utf-8?B?NlJmWXlpbWZTMGRkRTZsSWE3K0RJVXJWdkQ3dHpmODJCbTZQaDlWdnRhYmJk?=
 =?utf-8?B?NDBuNXFkL1M0YklPZVhhK3Nia3dJcXZubUpDV1Npbnh3cytkN0E0MnZEc0NV?=
 =?utf-8?B?cG5rWTU3dmEvdDYraTFEeVBadmpIYmJ6enp1OVlvZ2llTGtobjVwaVIyYjQ0?=
 =?utf-8?B?MnBSM2ZQaWhrNFlwMUZpRjFoYmYrL2padm1WTkxuclhhYVNsVEpURTBUbEVI?=
 =?utf-8?B?cy84MkFyL0VNRGZ4L0lBUGppeWJ2cDdYTDdBays1ZXNkWWk5MTd4a1BMRDlj?=
 =?utf-8?Q?ICD/gRIoZrthqliqBOifPn0P1CA74xdF05oIY/j/1by/?=
X-OriginatorOrg: kunbus.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95bf9921-62c9-4a40-e0f9-08dbca8624fe
X-MS-Exchange-CrossTenant-AuthSource: VI1P193MB0413.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 18:16:10.0448
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: aaa4d814-e659-4b0a-9698-1c671f11520b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UBrgVm7XJgHyLJ7iWXSDKkGtMdkfIZptRhjkSSlXJnAF3mI+Ou+5Vxc/Y3A1AdWK8DrVvJm1ROgpcctHRbLNAw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1497
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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
IGFkZCBwYXRjaCA3CgpDaGFuZ2VzIGluIHYzCi0gRHJvcCBwYXRjaCAiR2V0IHJpZCBvZiB1c2Vs
ZXNzIHdyYXBwZXIgcGwwMTFfZ2V0X3JzNDg1X21vZGUoKSIgYXMKICByZXF1ZXN0ZWQgYnkgR3Jl
ZwoKTGlubyBTYW5maWxpcHBvICg2KToKICBzZXJpYWw6IERvIG5vdCBob2xkIHRoZSBwb3J0IGxv
Y2sgd2hlbiBzZXR0aW5nIHJ4LWR1cmluZy10eCBHUElPCiAgc2VyaWFsOiBjb3JlOiBzZXQgbWlz
c2luZyBzdXBwb3J0ZWQgZmxhZyBmb3IgUlggZHVyaW5nIFRYIEdQSU8KICBzZXJpYWw6IGNvcmU6
IGZpeCBzYW5pdGl6aW5nIGNoZWNrIGZvciBSVFMgc2V0dGluZ3MKICBzZXJpYWw6IGNvcmU6IG1h
a2Ugc3VyZSBSUzQ4NSBjYW5ub3QgYmUgZW5hYmxlZCB3aGVuIGl0IGlzIG5vdAogICAgc3VwcG9y
dGVkCiAgc2VyaWFsOiBjb3JlLCBpbXg6IGRvIG5vdCBzZXQgUlM0ODUgZW5hYmxlZCBpZiBpdCBp
cyBub3Qgc3VwcG9ydGVkCiAgc2VyaWFsOiBvbWFwOiBkbyBub3Qgb3ZlcnJpZGUgc2V0dGluZ3Mg
Zm9yIFJTNDg1IHN1cHBvcnQKCiBkcml2ZXJzL3R0eS9zZXJpYWwvaW14LmMgICAgICAgICB8ICA4
IC0tLS0tLQogZHJpdmVycy90dHkvc2VyaWFsL29tYXAtc2VyaWFsLmMgfCAgOCArKystLS0KIGRy
aXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgNDggKysrKysrKysrKysrKysrKysrKysr
Ky0tLS0tLS0tLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zdG0zMi11c2FydC5jIHwgIDUgKy0tLQog
NCBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCAzMSBkZWxldGlvbnMoLSkKCgpiYXNl
LWNvbW1pdDogOTRmNmYwNTUwYzYyNWZhYjFmMzczYmI4NmE2NjY5YjQ1ZTk3NDhiMwotLSAKMi40
MC4xCgo=
