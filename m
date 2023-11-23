Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB9A7F631E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 16:37:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346162AbjKWPh2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 10:37:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346139AbjKWPhY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 10:37:24 -0500
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2074.outbound.protection.outlook.com [40.107.15.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BC44D5C;
        Thu, 23 Nov 2023 07:37:31 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=btQRfktGYIydjd9iyvWgPGViA8w/6OQGnrWamkG9c0mJAZklPZlmbk7kxQCpvsps3gf/iieRJSv8inN1dkkRh9XKFnW58Id1tTR0WEocPMPAfHJVGw2vX0+Fk2TWjayhXM3MLkYg5kuQple+Ejj01OYdMX3nV/xn/bququNzAEIUdZ2/U5TP2e9stgVAvFPrJUgXdxBOCNWA8wjIXBsnpO/e/Gdt6SoEnutMY6kaOROKRi4HPRIXQXcGmbhMIOU183yVO7yVVCQSopnHNJ7BvST0/vEWwMlJCinUmVubt9/xk7HJlkRrWm/D1xls6+xRXQ4naCc8Ra6/z885vOo0QA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/O1E0BPBEC1ZHg2m5TDbwK2fzyCXbIheULNNnxOFhzM=;
 b=IeIV2vIrh4Qaw9nJ9v6YmsdcCq4cjI2AcxpaVWks3AuD+dIu9C7zP+VMNofD0yFrNMgzwlAHh7r+ekPotLlFBprHqOomEz5FZUSpL3jysd4kYpoCE3GPUDXL8uwyJT32Jx3/i5StbUjZ6mMQvbeLfGf+c5dv54NZu+ssFCWZuM1aS0bdWm5AE5Om+oXbLDn964pYzI1nUyn77OSqadgVef1eht7fhDV+XT3iw0dDJn4UAgvp+8FBPQg+SC36m1M6vLMWeJuuEDD4srHCLMo17tzggT7eoV5vxqkrZkaicoBkmySLeFO8RfwMp+0NPBY7z04PVX2jVuJzest+wTPuoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/O1E0BPBEC1ZHg2m5TDbwK2fzyCXbIheULNNnxOFhzM=;
 b=DnpwOjRdjB1kK0uS0UdebgB9M15vntgW9GofyVlpG6wxWzDNpK/AvDyOugt3dP8eFVpU/3Bm7ZJ3GTrZmqDk+b1VKjivdKNUWA+hwO8vLHMoyxMQJwF8qDLdngksG0oW92QR59lbZZVLcgGiiyd+9gxdtolwCMXPIWymP6kMHs0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VE1PR08MB5599.eurprd08.prod.outlook.com (2603:10a6:800:1a1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.20; Thu, 23 Nov
 2023 15:37:23 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::6b40:1e6f:7c94:71dc%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 15:37:23 +0000
From:   Javier Carrasco <javier.carrasco@wolfvision.net>
Subject: [PATCH v3 0/2] usb: typec: tps6598x: add reset gpio support
Date:   Thu, 23 Nov 2023 16:37:00 +0100
Message-Id: <20230912-topic-tps6598x_reset-v3-0-0c2873070a77@wolfvision.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJxxX2UC/42Oyw7CIBREf6VhLQZun7jyP4wxlN5akgYaQKxp+
 u/SunShy5lkzpmFeHQaPTllC3EYtdfWpJAfMqIGae5IdZcyAQY5ExxosJNWNEy+KkUz3xx6DLQ
 sURSiwKYqBEnTVnqkrZNGDWlsHuOYyslhr+fddbmmPGgfrHvt6si39oclcspo3XSKtX3Fa8HOT
 zv2n89Hg4Fs1Aj/kCCRGEgOCKhKJr9I67q+Ad3m0rkcAQAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700753842; l=1454;
 i=javier.carrasco@wolfvision.net; s=20230509; h=from:subject:message-id;
 bh=maSGGdCBegLJdGyRin2n6My+ZRfJxyU4BRrlYBoJEGc=;
 b=jNQgIV/li+8ahuupsTT5v2CTxE920xOhbLzZvzMJLL2ofwFpS9WtmeALRzZBQL6hen9Vu60wC
 GSt+39JlLJRB5v+EOtYpXkKn8kh50pbGekt986J55VzfCRZScP4o7Bq
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=tIGJV7M+tCizagNijF0eGMBGcOsPD+0cWGfKjl4h6K8=
X-ClientProxiedBy: VI1PR09CA0156.eurprd09.prod.outlook.com
 (2603:10a6:803:12c::40) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VE1PR08MB5599:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd4e5ae-6e19-45ac-28da-08dbec3a1663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Up5CaTX9mBcWwzAG6JrviLrpx1Rz5dflUKLsDXMJUcwooDhN4m5pM89N2m9ccNKPXqN7BWtCzgk9yJ8YYjWsuHpWqAjXZlqhJgrD6JQeAQKfdK0cJRi5qWzaKDlUHZL529MxxFkTEf4k755NkEKdzJrWIVE7RaXqBtJw6oUN293va0BRpdRLh2v9P01zCzpqTh/c3Gcdh48TohxOZXD0CA+ncKsxcXLyWhTCeJwz2YSmXdqsne4Xged0uA/WPH4Tas04UXv/S4i4xwcZkHza+z5o0MvoKIOyOB97dq/Cc04cha54747I1f8D+PMd6qRjd2FCREYkPufTj4HmoJyyxepYp6sNGzXWtKW5X3C3FKfYegcCPecOurP2T6t4WVZVRoeDkCHtXbG1V3LSSmI/rt02eJXbtK3XakbocJaimEHBNbUsl8ixrG02ZmXl+hq6/nOVq6YxXeg8QFgGMVy+XC2IIf3K6xiXAic4E/OcJknv1SKS7GUEBXvzPx9WDUFnrl4pGm2TDMSj+0PDmflwP0co/srUitt+O9s4R6av9kNkNds3dpiCkPIz3SliOFNGMEFFfFEXoLoCXLEXrEm17LmOl87ciWdSgXcctAqRxaY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39840400004)(376002)(136003)(366004)(396003)(230922051799003)(186009)(1800799012)(64100799003)(451199024)(86362001)(44832011)(5660300002)(7416002)(38100700002)(26005)(83380400001)(6666004)(316002)(110136005)(6506007)(54906003)(52116002)(6512007)(2616005)(4326008)(66476007)(66556008)(66946007)(8676002)(8936002)(41300700001)(6486002)(38350700005)(478600001)(966005)(2906002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MG9Yd3ZST0dTRnRieTVMR0M3eDlnak1qb2ZYV0NibEFPamJCUncvLzZUYTBt?=
 =?utf-8?B?d2xrOGx5QndndzlLbWlLV1pFSk1wQWFHOTBjRkMvUlJGeGQ1a3E5bjhyVHA2?=
 =?utf-8?B?WjFDQkpzU2RxZlo5cGxxZExZUzFoOXlLRi9iQ1gzbFdiK2RNc21nVFA1MjRi?=
 =?utf-8?B?S3ZocjUrcW1hSGpXajM0djZ6MUc0Tm8rNHBwWDNDY2toQW5WV2g3NUxENmtl?=
 =?utf-8?B?RjFqb2hKVnFyL0t5R2pZb2N5Vk1ENjdwamcyYzlucEtqZ2xoUVJhcUFabzlG?=
 =?utf-8?B?ZWU2VU56bzZ0cUdIQjNRaFVaaTIvRDlkUnZURmNneGh2cW9kRHZFWnc4MW8w?=
 =?utf-8?B?Z0hEQktEZk0wSENpYmdiV2lBSFdoZFA0dllUTlZyNHlWa3RhemlYL1BwMWZO?=
 =?utf-8?B?R0QvdkNmVTZXZVdwMGFTWU9rRGlIZFk4M2E5SzVWZVJVQ2RDQy9RNWRXMEZm?=
 =?utf-8?B?bS9HcWY0dDRZeGJFMnV2ZHh3aTgzTXZWVTNWVG9rYzJhVkxPcVdiY3FIL09G?=
 =?utf-8?B?SnpVYlVCc1k5YmRDT3FnVEtHVksrU0VVZ0dDT25TSXBoRVNwYmtvZmNhYnoy?=
 =?utf-8?B?Mm1jbUMrZXJ5T0JCQ1MvZHg3T2xDZVF4SEhqdnNtdzZpbWtFbUNxenI5dy9W?=
 =?utf-8?B?bC9nYURZc1dLdDFtYTRDUXVwRzUzWWlZVmY2M1oxa05Vd2JKS05GM0hVemlj?=
 =?utf-8?B?dGFUOHVTT01EN0xlckk2UHhiMFdJdmlTUDl6VTlOVHREM0V0QVBNTkw5ckVN?=
 =?utf-8?B?NjliQUNNRHNaU1NYWDVzVlErZ21OUjhYdkMyb0Q1RFhYTUtvUWh1TzhGME5k?=
 =?utf-8?B?YUgyRHYrM013bmJZYnhZQUhnclpidVRDYnJydStLajl5WXA2TnRNejlxUTRR?=
 =?utf-8?B?MnhueExZbmhhcHVHSm5ENm94V3g4U2tXYXVEQ05KUWlDaXpLN2Rvd2lqUFB4?=
 =?utf-8?B?blQwNmI3T01Ma3gwczkzK0xNYm0wbGdtdUREMVJVTG02R0hVZm16MEVwQzFx?=
 =?utf-8?B?bmxvV202eWcveG5pUEdqdjBHT1hpL0ZjcnFqeTNpTmlwNkt3em51OEc0di9w?=
 =?utf-8?B?V2p6M1RZdWgrVzVnT3YxamZ6THdpdUJPUTV2cEVqR3Qwc2xjS21KZnlFQ1FM?=
 =?utf-8?B?aDkyRXlXdDBSQkVKMGNKUmRFNEo1Q2JhMTlKaFJoSDVPQWtNQUZSQ09iUFRY?=
 =?utf-8?B?SXVEN3RuTHhMS09Ydm15TDFTcEtrVmRoUG9CV0lXN2gvdDZROGpsbHAvcVlE?=
 =?utf-8?B?NTNiUzVNM3M0VFBiWHZmZG04c3d4RDhQOFpvSkVSRFBNb21ic1JHaWdoUzhq?=
 =?utf-8?B?K1FaMmcwaDIydE1Eay9yM2JneXZxNWxhQ3V5amcyMUdYVEd1eGN2UkE3TzFN?=
 =?utf-8?B?ZW5OTlZpUXdqZ3p5MUhXZHpicUNOYTk2QUFlbE01a3JrcS8wY3N5SEVXRkd6?=
 =?utf-8?B?NVRXRlY2U0dIb0VleUN1elZqYVZWMXF3MzBjWTh2WFRjbmRtZmw4b283ajMw?=
 =?utf-8?B?NDFxMlVTK1kzUlRhRDZTU0ltTkcvdWRTYW5YSEw1b3BQZERqbURrd3ZBQ1Rv?=
 =?utf-8?B?QmJjZmJOMGZRWVp2SW0zaGRHWmw1VE9EdFNXOTlnZHIvWHF0NHBzdWpIYTJJ?=
 =?utf-8?B?blhIRGQxMTZ5VUNyZVczeG11S3M0dmtJaGRmc2dnTmVMOWpDOG9aZHJnbTJy?=
 =?utf-8?B?dmk1SFM5cm5LcGhJYnpWNWpOSTdPS3Z6ZlBOaEhiSUcwdHRCVVZpREttRlVJ?=
 =?utf-8?B?V25FdW51cVlHMnV6OGNzQ05kdmNLVXBkSEdsSkQ5S1YxL1hTQ0F3YXlheFFV?=
 =?utf-8?B?NGFZOWVhanV1WklQT2xJWUIyakh5RDZjY0FUWUQwWUpkOGxGZEd4bmt6NG45?=
 =?utf-8?B?R2NKY2pxQWV0YXBmbTlCeFNKV21xbGl5M05OVFJleEdZMGNGdm9ia0tONVlz?=
 =?utf-8?B?NVNDQW5uMDZkdEJIR0VyNzVkUVNFL00vRkpHV2VFSnA2aFRUZGFJc3Y5WGkr?=
 =?utf-8?B?clVObXB2QjhJZkZwWUNoU2pFTHRKdlloQm42ckVkMlhwUytPN2t3ZlhzUlpQ?=
 =?utf-8?B?Ti9WRDFueitGcHBvdENNZlZLMHFHQmFzVG1Wb1c4UzZLVWdZUnN4Tldad2lE?=
 =?utf-8?B?WTFWZmJhc1BGZVRuaEpJTGN4NVJYVkk3ZFhJekkvWDN3ZXpPaHhLb0V0Wkxt?=
 =?utf-8?Q?6B2OI7llP53PlATymh8uoIA=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd4e5ae-6e19-45ac-28da-08dbec3a1663
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 15:37:23.2710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KlnLeQqEqGYRFVFwEVsngvo5KH0xI7bEvhKSNX6ChPj5JrZ2P8t2WkaE8lcQ6IVOjwuK7vWC2WHB85i6uvWuBwub9/AYHC9Co4YYnUwRon4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR08MB5599
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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
Changes in v3:
- core.c: added TPS_ prefix to the setup time definition for code
  consistency.
- Link to v2: https://lore.kernel.org/r/20230912-topic-tps6598x_reset-v2-0-02a12e2ec50a@wolfvision.net

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
base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86
change-id: 20230912-topic-tps6598x_reset-55e9494e8649

Best regards,
-- 
Javier Carrasco <javier.carrasco@wolfvision.net>

