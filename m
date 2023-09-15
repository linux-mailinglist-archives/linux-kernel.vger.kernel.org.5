Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 741717A1E98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 14:24:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234849AbjIOMYF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 08:24:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234600AbjIOMYD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 08:24:03 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2077.outbound.protection.outlook.com [40.107.21.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EA1EC1;
        Fri, 15 Sep 2023 05:23:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cr6jPuqGBA8lhHVGqv1ciIKr/GcQKY6jP/lETo826SMll6gInfhtD1vBD6t8kMYZfM23FzGaBlqN1tt/8g8I6g4dYoJkm/a5VxyxbzVMKHQBpONPNnkwHe+Q//Rj2ypzAglHSLPx+f/BjIkFhU9ugz++JYt4k/G+cOzOtNV+DR+krM4Q9kejlXXo6BKvQ77ovJVhiMDOUYXRxOrdG5kSFHy3YlrY9EfjdsZ3rmL+YwqpbmvytaBFos1TWgVr14xKyWV8d5Et4/qu8Ff4a0rhNX5WEbv/Vzt9zITpzAR+6mDw4xlDsX8xA1dVpZ7wK9Smo39pMxLNcbX3hd4ceISu9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Up8UESIfsbWykAWu61O2Utmvi7V24/DRrJG97Pbwxnw=;
 b=R7kQlP+0to9joMnk6B2wVFOvX+s2zpCb5SeUPf35J14rQQrykG4ivObbtXS5OEyF2rTTRQu/YK3pF5+rttHQPFqrphgP2lv1nyOUNJ/Gqx3xTvcZlQmf6YkV1mcx0qW+ZZG404OpAdGY5wZQZN45KGv9XUnuchQ9KtgPxb+FA0cRmcUtPkTUFuvwxnVNVVcsEoGUQ2tBDuml6ArqNa1h2pELW6rkYGLHGK4oHaGVIjFGF+ilZiYWjiegAFhzO6LwK+vvb/X/wUA5iUfzqZ/1SVVHTAErRXVnqFgkzeVsHoWxIduDg0+qBz+I9knN6kGqEDAIGtCsjtx6H0yUsFILlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Up8UESIfsbWykAWu61O2Utmvi7V24/DRrJG97Pbwxnw=;
 b=Dn0pDYJ4QfhRgd4I6QlwTkFzMndkdU6OFDNswbJARdJskxjqO6cr64YQ2Ebl3W1vJbRa5G2YSO2WAw8jQiEg1vgrahCvhpI7/JwwllSBDKNO7h2fc6grp5vUeVEJD0w40QsnCLFhcTLR0Bh+NVzY6KXj16iQcoLojcnacyiPcrs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by PAXPR08MB7623.eurprd08.prod.outlook.com (2603:10a6:102:241::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Fri, 15 Sep
 2023 12:23:56 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::bc92:216b:11ed:db63%6]) with mapi id 15.20.6792.020; Fri, 15 Sep 2023
 12:23:56 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v2 0/2] usb: typec: tps6598x: add reset gpio support
Date:   Fri, 15 Sep 2023 14:23:47 +0200
Message-Id: <20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANNMBGUC/4WOQQ6CMBBFr0Jm7Zi2AlJX3sMQA2WQJqQlnYoYw
 t2teACX7yU/76/AFCwxXLIVAs2WrXcJ1CEDMzTuQWi7xKCEOgktFUY/WYNx4rLQ1XIPxBSxKEj
 nOqeqzDWkadswYRsaZ4Y0ds9xTHIK1Ntlb93qxIPl6MN7T8/ya/9UZokCz1VnRNuX8qzF9eXH/
 vf56ChCvW3bB2jX7cnSAAAA
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1694780635; l=1249;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=JsGXvFGvXTCxZgM4m9tA38S1F/sf1ms2d0xxQc4svcc=;
 b=UEXO3hZAX7OqZcHpjpoSPMDoJslA8wkFfeBIuZTGe0AZ0xwNA5D9NQxQgRXlWvpVk6jz4SGAx
 m+KCspQgC0qBt9YhsSJKiFDmSe20g4N203hcAbUM9di4Dx7tzv7lZLt
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: AS9P250CA0001.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:532::7) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|PAXPR08MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: c1f086b1-5631-48c4-7447-08dbb5e6a187
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DBna5nJoXo5CFtQ/CUBV2QRz9ebJ/p7o3rOuJBQN9QNpvbYQg8po1eEoO5D5sZ4gLnNVmNObvhvDRrxQ9XWKD2WzeDOjSsyyxLruPVsCmVutOZEO14Y+8leFrRcqdB2JWF+MFDyNqqGA0c9O4JCVd4y8oZUIbUJsNej2ZdTekpnIGfXDcfIvp4Gw+oCsUr68MusUT+02kNgFnR9D7tkF6KJwFW1Rf/guhHcYwJzEkr/0VS8/HGTcxBqTSioerP6nzFjAYzf6B6vqdVukxp6rANNxf96CRN+cX0aRbeeJqnxmk0bgkdn0bnbSMctvxupUWwnqsA3A+9fvcpz2Yl8G5JhRlXOK7P+N2vlAFzJ/aZQUUBlYxQPnjmjWbyEMfq/Bj/4mA2ufk4R9GW3PQJdJ0Xe+ewZCPXeesoobcL19wCjYk7eO2QZEInDxui769s+igaxpqpe97kTKiJlfKzmtSkQu2nFduKLPmCP9Vr472V3HDb8KEQCrYcF4BHux+g5lRQCZIaBr1CePFyel5kKf26JQvxob8Nf5evuaTqiUMDZukuB9/GwHcc1Zaeq+4Vo70xieerhEuGR5KWgxE4kgfQlUSbkT3OnEk+1d0SLVIXI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(366004)(39850400004)(396003)(186009)(1800799009)(451199024)(6666004)(52116002)(6486002)(6506007)(44832011)(6512007)(966005)(478600001)(2616005)(26005)(2906002)(54906003)(7416002)(66556008)(66946007)(66476007)(110136005)(4326008)(5660300002)(41300700001)(8936002)(316002)(8676002)(38100700002)(36756003)(86362001)(83380400001)(38350700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czc2ZUtZU3hBV0NjSzQ3YlJHUVpJNG9WOUtmS2RsV2VadkkvTUZSdVN0Z0cv?=
 =?utf-8?B?dVptcWI5a29nSldyOE9XTjdyWEh3dFZCVUxkZ2lqM3d5d1REZXZyUm9QSGhK?=
 =?utf-8?B?UEphdDY2YVdmY2xhNUdMaXZvSmpCbEpERTA0ek13dEZ5cGM4NDlCY3JpaWdY?=
 =?utf-8?B?YklkSXVRWUNlWDdZR0FhWStCLzFRVnBkVkhKTnFmTWE1NkhTMUFKbGlScElC?=
 =?utf-8?B?VlBtd3dDbE05UGcrcHVKdHBLRlFCK3B5Q2IwMm45MVhyV1ZkUTlDNnY1V1ZK?=
 =?utf-8?B?M21YOGQxb0srN2Z0MnM0Wk9VUDJzcWFIaFl1cWhiK0h0RWFCM0JwdlAyYUs1?=
 =?utf-8?B?bEFHa3pmUG9wM1JIQU5xN2F0T3FoclhMU2o3L0lzQWZtNW8vZXFEcDk2V0hz?=
 =?utf-8?B?TmVZRTRLSVA0OXhNV3BwcHF3cjNaZEw4U0QwZEtPZFBOV1dZZDN6YmRpTzFw?=
 =?utf-8?B?ZWVNN0VQMlFITGlRak5nbWR3a2pvSEJKU1UwVjNQMHJmeUpmSTJoNG9hZnNp?=
 =?utf-8?B?eC90RWQ2OVUyZ0c4ajNEV3NhbGNITTBaenJrZndNOFVXR3NpQ1dwc0h0d1lh?=
 =?utf-8?B?a0k5aXBRaVZqUXYzOC8rWXNsUU5lVTNGcXhyVGVPN0JxRENKN092OVZ3UllG?=
 =?utf-8?B?T3lYbGl3dmNwM3ZPN0VNdHlWd1dpTXg0WVZuRC9iQkEzaGdqNzFRdjJwbld4?=
 =?utf-8?B?NnlpNy9TZnpqMmUzajNSdUlvM0J0UFdEWTRUTFVmSGJ0UDBuc2FDUXYrZlBy?=
 =?utf-8?B?ZzBSWFB5VGtLVXUvc1A0UFd2RVNmL3JnSkVvWDYrZDZlb0FsTUhsNXYxRXBK?=
 =?utf-8?B?U0xxU1pDZ1RlYVlRdHFEQzZsekphdno4N2tJRlV2d2lYM3REa1NIazA5SEJH?=
 =?utf-8?B?QW9uOWZHb21iejI0dWZBcE5RU0hFQSs3dE5tOUgzMnIrZ29HREV5RWo3d0ll?=
 =?utf-8?B?aWx2cFFNdGp0bUZnd3E0Qk16cFR5eS9LbHRoOFVYcXQ3dUpZNmh0U0hIcVBZ?=
 =?utf-8?B?dEFtNlFzWEFtblRiVjJmZjhtd0ZhNy9TVER0U0Jqci9UL2l6bkI0RVVlajJs?=
 =?utf-8?B?a25xOElvRW9pNHJjMlZ4cjhTelVSK3hOVUxCUWNTRHpPZ3AxNHVpUFVuWFJF?=
 =?utf-8?B?aUFyUTBtZ2RxcFBSZlJDUkJJUVU5TjZOYkIwWlloY2lLaUtyQzNabEN3ckNn?=
 =?utf-8?B?TndrcHMxMlB0R2lyVWpXM3lGcjFKQUZQSjl4YlR0ZStpVzhKdk1jR0ZzY1Ur?=
 =?utf-8?B?d1hBOEhCU0lKM0VzenlaVWFXNjUvdUlJUkhkb2JiRjhSUlpCdEpIRmdDckN3?=
 =?utf-8?B?UUlrNWdXSzJJWldIVXF2OWxvcE5mMGMvMUplVGRsNDJGODZlRVN1UXJqNXZS?=
 =?utf-8?B?eVNKOGtaa1F0WDI2ZHprcDY2SEg0cUY3TDZEVDRUeVo3UjNJY1ExWXVQNlFP?=
 =?utf-8?B?LzRrREZLWXJoakVKN1YyNVB0ZmlFdnE4VXl3bFd3WThCcHpuZlF2QzNYczhS?=
 =?utf-8?B?Q3pCRTFPY1JaNlh4Q1NUTE9EY0R4alhLMWhaVUVkZ3B6UjRFWUV4ZzNnYllQ?=
 =?utf-8?B?aEJUZVdDaDQrNm82dG5VdUZsWFovNkZ5c2ozY1pGVE5BVklRdTU2RTh0cDBP?=
 =?utf-8?B?blBaL0tyTGE1cEpCd2tobHZtODVWdWdRTHBQWkZkb280UVFFWHpPV0J1cm95?=
 =?utf-8?B?aTNENGVFOHFHc3JHNGRmN1kxaExHcE9QRmZ6SFBQbTJaSStHYUdXNkp3QXJK?=
 =?utf-8?B?b3lab0IwM2U4YjNZUGRiZU5aaWlOVDlWaEVkOWVud3BpOGpnK01SQ0ZycWl6?=
 =?utf-8?B?aXAzVjhhbnVSaUx0RS9pWllWcTVYQzBnb0VPWU1hZGxEdERJazBHdjFuQzhW?=
 =?utf-8?B?SkpNWG56dmpmczZhVXRBeUJEVjBjQnZKRnNzL0EzZ2JZZUgrbmlrZEdlL2tl?=
 =?utf-8?B?U3dxWDNpUXdtS0hLc0pQbi9lZHcwV1ovekdtaUNKQkVieENYcDFscjZVa21X?=
 =?utf-8?B?emZsVkQvUVZYdFhDaHVUREdZTTNHQ1E5dzdIajNGZmJCY2ptb0Z5TEQwa0dZ?=
 =?utf-8?B?T2k2UDhOWDFIcllST2tzaDNDa2lDbVl5dGRNaGRRWG11eHE4czRiemdMQVl6?=
 =?utf-8?B?YkN6MlplV0hBZ3ZwTGV0Z2YwME5hZzdFV0taZ2p1RVh1WW92VDllaE5lSzNi?=
 =?utf-8?Q?Ej+dpiuTd5o56XjgHTKFxJw=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c1f086b1-5631-48c4-7447-08dbb5e6a187
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Sep 2023 12:23:56.1242
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNUdXt82fUAdRT6KhAgo2Am/sSQXrmmW7UDlvxL0889wTRGF++HVnZMecmcHwTlXGnEB6CCwsNLuinMna2TOCddgpUXRhHWNXCOed61kC1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR08MB7623
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The TPS6598x PD controller provides an active-high hardware reset input
that reinitializes all device settings. If it is not grounded by
design, the driver must be able to de-assert it in order to initialize
the device.

This series adds and documents the reset signal management. It also
includes the basic reset management for initialization and
suspend/resume control.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Changes in v2:
- core.c: minor coding style correction ({} in 'else' after 'if {}')
- ti,tps6598x.yaml: reference to the device instead of the driver in
  the commit message.
- Link to v1: https://lore.kernel.org/r/20230912-topic-tps6598x_reset-v1-0-78dc0bf61790@wolfvision.net

---
Javier Carrasco (2):
      usb: typec: tps6598x: add reset gpio support
      dt-bindings: usb: tps6598x: add reset-gpios property

 .../devicetree/bindings/usb/ti,tps6598x.yaml         |  6 ++++++
 drivers/usb/typec/tipd/core.c                        | 20 ++++++++++++++++++++
 2 files changed, 26 insertions(+)
---
base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d
change-id: 20230912-topic-tps6598x_reset-55e9494e8649

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

