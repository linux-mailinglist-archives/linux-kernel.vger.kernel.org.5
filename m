Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC567D71A0
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 18:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbjJYQWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 12:22:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232042AbjJYQWE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 12:22:04 -0400
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2063.outbound.protection.outlook.com [40.107.21.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E5292;
        Wed, 25 Oct 2023 09:22:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A2A5/dIqGUi8RpkHfjaP+0v821IMnwUpJ7AcOe+Us/58TheZyhOYxXWlBRd7mWtx3rSpP+TzWQcMEAkApjLBK5TyUy5W9AlH9vHv9s9RAjGUz5aQM2jNvdiIp4YmOfG6ldsvldTldXEeoandu+cWuOPoD6x5cG7C+I3EFoeANKX1yLx2cEgfn8kLjCwCfNMlJ4uAbP3VgIYBPDS+0Nf8BnpzVLOa3hGBsYfRq7MrL6ovQhwPu97LUkzpHq0NYH/wf46JmX7zX22LXKVzep9n98SmHXWEKm/z1rsc0qbVfvAMnbveH5TYkltpZ+l+XvpY9pCfAxu0qFZZthiV0O7ylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrC8eF7WiRM8JiZT1s1xDX0aDUytE4QhAcEL81Qt598=;
 b=R0kU78ZQauxaPErXWPtYYh9PkQYScwTQQEKNr8IfW9wNbEn/YRagp9Euj7NhrVgJQbPvePXdiI5eEaRgzwzk5rh62nMaXndKV+mqlxvyGoFVT54zGlTEVVYkgnSFaZCVqawGTvwDx/gVNxiJXnmwDEBNRZRDWvX4OgExdJWSqfS/nRhlPdZPvhVHnWz/IrzeXLTCfg0frv2gIkMt86dpd5BLvwapzpl6wUv1aKNZGmNMBlikCwTVQrrwLrrQQP1EdyIga+rS6iBxv08/j2Ab2xqNR8yVsJXQ+/wKSTM8LaMnDWDKf/3zSYo1NWWP2Ka8YrT0lufcrkiB/PGrEDBfeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JrC8eF7WiRM8JiZT1s1xDX0aDUytE4QhAcEL81Qt598=;
 b=wcrYviDFzszSPY3dDksiuuL4yW3NN7qhTD7Zix6rjyujKoqMRCYR7w7xrBRrBOR6cXGm+L4V7TPK3PiL74fm99ewJf6heNuBHeu4GzSKzOCFIM4HioyH0hIefO/rxQnN2+e4k+Lt7hibNyzN/kUAXBYrkisb3koQxIUCcNuaqSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB5376.eurprd08.prod.outlook.com (2603:10a6:803:13e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.19; Wed, 25 Oct
 2023 16:21:58 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::a309:1d65:f5fb:436b%6]) with mapi id 15.20.6933.019; Wed, 25 Oct 2023
 16:21:58 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH 0/2] rtc: pcf85363: add support for high-impedance output
Date:   Wed, 25 Oct 2023 18:21:53 +0200
Message-Id: <20231024-topic-pcf85363_hiz_output-v1-0-50908aff0e52@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKFAOWUC/x2N2wrDIBAFfyXsc4WotTT9lRKC2ax1Iah4KaUh/
 17p4xyYMwcUykwFHsMBmd5cOIYO8jIAehteJHjrDGpUWo7qKmpMjCKhuxt904vn7xJbTa2KbUK
 N0hlLZoLur7aQWLMN6PtDaPvex5TJ8ecffM7n+QP6+1C0gAAAAA==
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.12.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698250918; l=1591;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=XjwGgbXrx1mUyaQvBZ728qJrCqgOeL5FeWgo0RlMqzc=;
 b=lswYr+e0BJ1oZsa3won4ihKqyVSixSPe/9E38CCiZnYjeSazEUKL537jnvHdRiZRIrl1lPLU4
 TR/ydAyMC8lDjSlKbX34LfUv+DTVhyAr+E4cInBpTHJgzloIec9hbMy
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR0102CA0040.eurprd01.prod.exchangelabs.com
 (2603:10a6:803::17) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB5376:EE_
X-MS-Office365-Filtering-Correlation-Id: 30929798-2986-494f-3c58-08dbd576832d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YHc+jjckdI4yt8sWLZi/vIv6aJBogbZsBTai3ZAcz9Q6h/KnoUaqqvV0kvA44N+/fc96v2GUfnptgmgCm+R05dvLADN6iB9Bx5C2ZsncMZZymeqyIq6GpjcgIllVZJzw+U0UuwD8JdNjdI6ro6dz5R3CSl12NRNo87jYvl0F58Q2zrp2I+WyspMwBwggLyoPwu+QKA5bF+/ghBTzsMo4kTqN8hy8gA8Zc5AmeBo+ooX87QwV4/Z7RnrYOzGyR6t46n5FB6mxsYkWHM1QJ1BtIWa37oY54m1N+mgr3QumX8Pqy775rrjMdTfecIWGiyhGd0ySJKKLOK29TmGSP+F2TdvvmMl31Z48v+uPjCyaxupgPGdAaEJsmTn6WH3RD3D+TCWgTHmHsHawpaHo7VobTeVu0jZZLVUoUwANn5KRkECIyaE1/pfekBFLT0vpKTYIXHEPnpq3K1wOhwYRS5Xs3mLu5YE6ON76PYJdy1zIsmpgp38vouOqy1y7yH5nXKKW5Q3I3IaFxNtYqtvQi1Hr1pBXM+5bgrooAD4JzQ17mKBbfet+D6bYnICMfAdZwpuN88YaGG29tsNxH4hgxxt7xAMNftPguvMhj2pJT19BldiczZR7gG/Rp1Fml+4Tk8SU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(396003)(376002)(136003)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(4326008)(2906002)(8676002)(8936002)(44832011)(83380400001)(6486002)(107886003)(52116002)(5660300002)(41300700001)(6512007)(6506007)(86362001)(316002)(110136005)(26005)(478600001)(6666004)(2616005)(36756003)(38100700002)(66946007)(66556008)(66476007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmdtMkVqRlpaeHJRczdLSExqTjVBVXF1dDJ6VmthUWxyTWk3YjdValpGQ1Z3?=
 =?utf-8?B?T2UxOThIYllqa2lLcGpKVVVPV09SUEp1VldRZ1JKNzU4Y0RwUnE3U2htaGFW?=
 =?utf-8?B?dmprMjRldGE5OHZhYkNocE5seXNVNkFiZGJhNGNpM3RYMDlBQnNPMHkvZEQz?=
 =?utf-8?B?NXhCd3NLV3R2UGpDMVYxeW5WVFNZOVFIenpBK2tCbWRXTlFsM2pvZXZZdSto?=
 =?utf-8?B?T01NMDBIOUlnWE1sOThNamVMcENZRjFsa2NKY3RiNGJGM29iaTFNNGVNdEJt?=
 =?utf-8?B?NVdLMHNqb1JUYXVlZzhlR0djV01QUXAyYkphK0dqNFV1WGFzY2xYTnhpTGc4?=
 =?utf-8?B?cnkyMGRXNHI3L1VMUmNDU1Q4RUR6NGd0bnR6c0x5dDlQL0ZEK2l3SytvTlZY?=
 =?utf-8?B?WVRaU0JCaU5DVEpiMUNDWTlLVEg0c3VrRW9aZWMwaGo0ellhV3Bvei9zQmR5?=
 =?utf-8?B?WEdHTlgzZktiT3Q2ZDNkKzRiUmZ1TUN3L2VzQ3E0M3JvWE5WSGNmTEJRZ3lN?=
 =?utf-8?B?MzhLTmczYTNTVWJVbE1sOG9mcC9oL0dudFZRaWhkS1pzYTFlNVR0N0Nld0VM?=
 =?utf-8?B?bEcvS1R0MjJKSldJNjYyMjEzN1dSVzdLbVJDdUMxcE1uUnZ3aGs0Sit4eDVy?=
 =?utf-8?B?d2k1SC9iTkthT2k4TnJnTmhpYXh5VWt1YUpkU2l6Z0ZBVVVJeDZYN3Z6WnZM?=
 =?utf-8?B?LytqNU1qaUYyUWFGYUp3VlQrbTBOMTZaWVJ2S0pleXFYdzc3UnZ0VXBWSzc5?=
 =?utf-8?B?YUZoQ29yNkhVUm5CeFhITmtML3BaTkxralFRMVB4N2tVWm14TnNkZXA0MVFW?=
 =?utf-8?B?NDhnQ3RTSjc3c3pqRGplVmJXSk5pdFRLNWt0cTErQ2VmNEFkTWlvdVB2N2tj?=
 =?utf-8?B?aHpkVXFIMlZyRDltUEdaNWtzY2xGb1BVeDNZeDE4anM5ZTZKTHNUNTdtS2Iw?=
 =?utf-8?B?MkNTZFFvTGVLUW9kTG8wdGFLVVNTeVluSitYL205V09Ld3U4WnVhY2ljNWhj?=
 =?utf-8?B?VFR0blFkcWtrYVJwYXU2T2F1UkhvSDJrODUzL0NLSDJMYS8vZEhQV2xUOUVF?=
 =?utf-8?B?eDRKRFJpTVFwMWVVbnp0N0doOXBnUTR5aWJ2SnVORWM4QmVXR3o0aXJQa1FJ?=
 =?utf-8?B?b1pqMXc0NW1XRFM4UmhqaDF6aGYyVmxwSmNvT0Y4a2xUbGprZW1JTWlYc1hK?=
 =?utf-8?B?aFNyTm5nVGhxNE45UXFRTkd5TVhBcTUybGtPMXRWTExONWtQRy9rWThlbkxj?=
 =?utf-8?B?eG1ZUG91NUsvZE1ZYVlUR1dyOEVDTUlmOGZHTWJIdUMvcWFJTERaZGFVUjBz?=
 =?utf-8?B?QUozRVpqakFDb2JMYmNUa0VwMStRNFhheDd6bllmdmxhbk1LcEN2VWZPcDh2?=
 =?utf-8?B?VllEODAwQVc1VzE5eStWT0VrVUhiOG5kOVpzb0lxeUtSZmdvRTlhZzJhVmZQ?=
 =?utf-8?B?S21NTUx0enJKNXcyTE5KQ2VCR3JNYUZCa28zbjdFVlFHM2Y5UTZWNkd5TDJr?=
 =?utf-8?B?aUJwMWdEbHNtNmdHdS8rR1BGd2Q4b0hjckl0UE1qTTZOWUdrT1o2anY4WEdQ?=
 =?utf-8?B?MTF1OG82WTNtZENIeVJBWnFaY1NRRUVVd2owQnBDNnFNYjNmblpFNzg3L2U3?=
 =?utf-8?B?WTNWK1lVZURtNVFGOGtIYXBiSFYwN0FwYXFWbmNCcXE1UXFrRnBRTitrbWdu?=
 =?utf-8?B?Rmh5NkhaVWtrclpVZ2xUQVVpemMwck5ZWDYveVZXNTV2MUhHVk5vbGkvcmZ4?=
 =?utf-8?B?SFVoVnJVcStpaXFXMjRud056NXMwOTQ0Z2tXN3YxMVNZamxRQndGYmNMV3Jk?=
 =?utf-8?B?K3Jxam5VaGd3cDZWbmhqcldDeUpFdXMzd1dCU2VwZm9oRXd1OE51UHN1TWdz?=
 =?utf-8?B?Rmdqc1NzeEVCNVhibXJDTlRNT1lRMGlOU0hQN3h1S3hzTEQ1Y2Jra2RzbEFl?=
 =?utf-8?B?SlZGWFgzejhpMlFFNUFuOWpHTTM4Vm43YVhFUlhBRncyUG1tMmNHTU9BNW14?=
 =?utf-8?B?NThHMG9vRGRFL0RhR09WVklZbmgyUzgyVGttc2wxeENPOGZRTzhNck5zRU5o?=
 =?utf-8?B?WUxLMTRlUFJQdXlGaXM1ZWFOUmpSdGlEV1dON0RTOVl0anMwLzhOd1EyMENP?=
 =?utf-8?B?eEtjemR2SHIvSkRCMWgwWlMzUjc0MDdKTGtjcTVZNzlBNGo0UFphb0MrZUVX?=
 =?utf-8?Q?Gww1TNgyLn3UWdHNTyP5MdA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 30929798-2986-494f-3c58-08dbd576832d
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 16:21:58.7811
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pgQrPyE/6JQy2uybdRU/Bc8nglSxxIl/U1amveWUujE65j1sDNAn1Up00Jnl714vYEeNv4Kd1poweivWoBsib+aBMLClqsDq2+nUE7iuxjU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5376
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the high-impedance (hi-Z) output mode. The
current implementation only allows two output modes: output clock
(default) and interrupt. In cases where the output is only used in
low-power modes as a clock source for other devices (PMU, PMIC, etc)
or the output is not needed at all, the hi-Z can be used to reduce power
consumption.

To model the hi-Z output, a new property "hiz-output" has been added and
the following cases have been taken into account:
- hiz-output = enabled: the output is not available in the design and
  must be kept in high-impedance mode.
- hiz-output = sleep: the output is only required in sleep (low-power)
  mode.
- hiz-output = disabled (default): for the sake of completion, this mode
  ignores the hiz-output altogether and acts as if the property was not
  defined.

Any other value will trigger a dev_warn and the default value (disabled)
will be used as it is done with other non-mandatory properties.

Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
Javier Carrasco (2):
      rtc: pcf85363: add support for high-impedance output
      dt-bindings: rtc: nxp,pcf8563: add hiz-output property

 .../devicetree/bindings/rtc/nxp,pcf85363.yaml      | 14 +++++
 drivers/rtc/rtc-pcf85363.c                         | 62 +++++++++++++++++++++-
 2 files changed, 75 insertions(+), 1 deletion(-)
---
base-commit: cfb67623ce281e045ec11e3eddb1b68b879b53a1
change-id: 20231024-topic-pcf85363_hiz_output-d9c3c1f5ae59

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

