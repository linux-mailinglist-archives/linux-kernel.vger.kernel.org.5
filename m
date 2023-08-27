Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C809789B94
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 08:45:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjH0Go1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 02:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbjH0GoY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 02:44:24 -0400
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12olkn2014.outbound.protection.outlook.com [40.92.21.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7A4B197;
        Sat, 26 Aug 2023 23:44:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wd7e605dm7MVBf9tRxwRnkkt73E6gFvFGKYoRr+VkQchUCXNFzFmVr3GuzIfsoZtt/jSEFbt0sglGB2I4R1FrmabUyO8W1w3l/y02HingipnOpJFzAH6W+j5XSrgX2j8QFdk7WdcR2SzuZ5qDluIkwX5NywyXEsi91eOunLmbjI+yDwHFpuaUZnrv/+BX7jo8SXuEHEqvFxP7xNJ2wb+2xblIHjVWda4C6o5YpkNeZbu7SQeKnyqM6X0itDkPAAP5uTzmtXau8bIIWB70plZ3CW3nI3j+l07C8VltVcSkzWUwqF4TZm/9BZdXxbfrT9FIz6ZUVLxZA4jyXLBDQFT4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/nd6LL+gkb8O7N4oR/KO+bRTvndC6Qs0ftYAJUeqd0=;
 b=EtAtp8slAk8Dg0p0matpWlBKVnkS4V6ZaNBrsWin7tTK9wLRCmWKUto1h+5kq0gu8CE3oSbqQJIoAoRDH9XHydceR5CruXU9RN8KaVPxq6ebqqIQ/uAsvV0RxDXTlqmi3hp69ASIR3NrhGvK+uxECvjB0zFUT5d74HN1KkLm8WnZMHhHBKF3HftKIA7a1FU5ct7sr0nuEROFWKYxIUU2AIb4yMJskgCkKL8auzwyGyYPa22RAgl7b/nsjwDM8iy4Lqy2xIzt22lx28VaWpjW2+zLb9hfRGhM2HyogmN4Ladn/2gYULKYisScR0n2gQ0Udq0+YuQTiHCvtd0CKh0yNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/nd6LL+gkb8O7N4oR/KO+bRTvndC6Qs0ftYAJUeqd0=;
 b=EeJ//cjVzC0Q4SmmW7Uno95vcEMxvC46sCJmv07mhAs3gLa+WY69gFzF+a5PYqNs4V+I7Y4VD5rfFUzQ44+3G+Sfl2C0L/+l5eNsQmvNcdscYqlcmPhWyaptqYNXrxF2piSPFPbLxQQ3YZdMGx+qMlXFKPPGJ4uG5LW/orVVaqom0O2673d2INfZUynEPfbSs0IhadJvc2e6yoaS2HsOMsPaHTCP6inKtdwS4c4ArCZHeGGRxu1NN8b2pvzyi5lIGNnYT0QduWuBvq0000gchyOGm+/T0n18BDqM8LPhRZA6q5re8PeZH77LWbYhw1R5w0thbAm5wcMNN3zAUQHHOQ==
Received: from IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
 by DS0PR20MB5757.namprd20.prod.outlook.com (2603:10b6:8:136::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Sun, 27 Aug
 2023 06:44:19 +0000
Received: from IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f]) by IA1PR20MB4953.namprd20.prod.outlook.com
 ([fe80::cbad:4566:1f3e:4e1f%4]) with mapi id 15.20.6699.034; Sun, 27 Aug 2023
 06:44:19 +0000
From:   Inochi Amaoto <inochiama@outlook.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Inochi Amaoto <inochiama@outlook.com>,
        Heiko Stuebner <heiko@sntech.de>, Wei Fu <wefu@redhat.com>,
        Pei Chen <cp0613@linux.alibaba.com>,
        Wenhan Chen <chenwenhan.cwh@alibaba-inc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] riscv: dts: allwinner: d1: Add PMU event node
Date:   Sun, 27 Aug 2023 14:45:01 +0800
Message-ID: <IA1PR20MB49531D5F6612A5FFED734754BBE1A@IA1PR20MB4953.namprd20.prod.outlook.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-TMN:  [eG0EICRNxrDhs226+QL68iyFWVEBi3em0O6KXS/w6p8=]
X-ClientProxiedBy: TYAPR01CA0019.jpnprd01.prod.outlook.com (2603:1096:404::31)
 To IA1PR20MB4953.namprd20.prod.outlook.com (2603:10b6:208:3af::19)
X-Microsoft-Original-Message-ID: <20230827064501.392205-1-inochiama@outlook.com>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR20MB4953:EE_|DS0PR20MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 38bbe6e6-88e3-4ec8-ee1e-08dba6c909c6
X-MS-Exchange-SLBlob-MailProps: cn60g5V53KNKBQSRra15jT4jAkk0OqZJ1BeJTn3sqKn7TtKOvZ/DsauzV2I3NaGLTdkcckoThhvU8zSAaAR8bmriPfM3+Zj9aIYyTDgUIksUgNocMqi741hmn05F49P3nNiCO9rN/McT8ot4L6YAiy2VqM7WpCUDc91TojAL4krzVIjrxOe0m7EfP9FbsE01GiO3jJJoccdADXpBNm1xK98OsfPdbs7EWWEhi7sbf7nk7Ru+DU2ecp5IMlxUfZTC0kNr4bnBh/HFCyKoPHyrycz6LScpZYL2am7KqSLuhvzH1sMLwDKfaO98aUDFB5jHu8NON+On8O5rPsHBfkwN0Lc2uRMNOF6QyjMP2OX+yGK45lvKcQjwjIb4d5qsOVigWQKI0VrCW8lxS5mWBCraCsDIsyCIwlTpJ9guepJJ5LfGRVCCZZsPZq+y4z2puBE8SRA51PdCczukm7TbLHJ/MRCWRsoXtIni2uvh8Sw9azo4fPiPF/NcmAKDXdApgrQgE4RLgnQZtv417pPTTpjwklaLJAOyuKrpMAYmVJjefJlD6Q1ur0rWJC9Lcsi4wLLfTVgOwFCjVh1pcBqXj5cx0FtqAmFbgSJYQou5xIq1CvRttWhtHQtvW7WAqavl5GWT4MER39LU8+CrrsRfTfwTu5XIY0iJ0ZagtjIctbHhnQyeMxAHNj/oanTA1tRAQB7OFjrCJZk54M6k7koVjWn2RNL/+F+391SFXLiF5woWvaQOqnmBp6vHlTXed4hNcS0SAxYzydHpbEVMe+oVaZr9qXnIiPzGHf07uBBigZmN5rd/bWB2CPEW3LD63l9fDmJphg0SCTKSGO6PQ86V6ATdsT8NzbKdH63jLn6To1CB55lHBGmCP2qc1A==
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z+4PVckAU75ln9D4VKm4ee9h9IWXyxs+6QmChDqU8Dl9nUxNEM6wKZ3o9okoOOg4gzu2cuBuDFYvaAjMw/NQmWrId9AOf2vnyq0vNjKOGigSDdMQOGM1ofzEoqABrOW93ZIF5KJeOVcxJBapZW/gRr19Ac6DhvhrMTk7JeWvyMKskdvYrzl9yu9/WB/hwNlzbbaX9lzEazdFm3H7TGqMfqme6oWsbYKKWjH8Bt9RbxsRoYgZdOyypzDbrNZZKHFIcSjFxpYns8flcOeJUFGK/BJRuCKbKvahs+LSjKGn+WVf00iIN1aymZKanfx7Ydn+7+E563Iorcf9Mvpr4D8OSHjKb7WPLnwUZTvpfetIBX8k5ohxAXjRNrmNT3TD5y7zq16KSgx27YiZpzNHXajG39xNxA2FljN2kWkmnuQ7Tlokl8AiSXilBcp4M2NNnxJOAVRSJvtTxpS5fNfDPD0T5iiewXup0PRWyUtZoYN5oVMUTrbGGIhUYoUm1oXOq/Pi7vWjxprbkFESaKeFD+FHBmv8PwUTAhnMJ93gM7cRlUC2+dBrkxjut8RI7fd4/ohxozRIDPS++zWENlAuECXtnNe+WemCMuiMHGTrH2LaPio=
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e+GQruzfxnx/iEKhv3qkEhJbVCyUeSw7IQnDgXQHe5NMMcedAtd8vwU5PHgq?=
 =?us-ascii?Q?lzDz/tK5YtvaaUkNH12EuXJlnN7ixYtuY0qIwrdOpcWeDfeoPmwL5VAV/oDm?=
 =?us-ascii?Q?R+d1fQPTMg41lmbwlOz1OlmO2VOuUvwZKjfshiy7O0hJ3QkSzoXs+HeDPlqX?=
 =?us-ascii?Q?ukiYnjjHMLgTf4M9Va+Fnm4h1ypYaV8/k9lDE1QmIq9Deu5NXYJqAarmT5rH?=
 =?us-ascii?Q?4cQhMxAxWfCZuyRrggl6Aqr9LDx8CcD/iT8qSMYyESBavPtiUIrhlhpYdCP0?=
 =?us-ascii?Q?QzxeihvQs+EpirqMAKatTYX1wtvN2tLSOvJpHKGxPYu08BAETsaJMATb6bmw?=
 =?us-ascii?Q?vLpJEX2kbr0VaQ4QTKBSAPZT30RItZSMFAsR3G6JDhVExBKZcvg6/AdJCpzy?=
 =?us-ascii?Q?V4hvci/JAou8DUU2XsPcwwhVky/cMYhR9WGZEYKvyKVjBrlHU0EXitW18HzN?=
 =?us-ascii?Q?KQjR35JWKbJEFZ3tyA4zUlhUS8H6cT91Op2YDKmrA6bNLemea02oP714xRfK?=
 =?us-ascii?Q?48O51MwS93AaQhl9CrvVaurY/9HYYCAIRXJQlc6u4G1Tob8uUou9tETaKFKi?=
 =?us-ascii?Q?kAemgzpWY4n1uzBN7NmSP60/Le7RzC9cfxlbK+F19gSapgvyBrfBtVsU9dis?=
 =?us-ascii?Q?Zl/keA2BA93WVjvvSXZRMqmpbzPVLe6aRP6YCCyhJU0uVgDebqvmC5kQS1Iu?=
 =?us-ascii?Q?Z9r//JGshFDwbUKHdf8b9wB80V7UDbIfFICxEPlNdI99sWJQAj3lw6f2BeRG?=
 =?us-ascii?Q?+bx5lIixsclPCCvtrIcR5WUkk3eXieVnI09znCu1ZcGKmatKa9XSjtRjnhqS?=
 =?us-ascii?Q?iuGS7crVH2lTe/UekcvjVgjwPQoXwe3P24M3A5EJJ5wDPtHEyh3hKZOHOUcg?=
 =?us-ascii?Q?Dr/uCX2ZhPTCxPXnUV/IihohgHlGiXSz8O+T4Vb0Ze+az0k8KOuyK57qsKga?=
 =?us-ascii?Q?fIj/rb4wT8Jo+zTxQrlNuO51RBcz8JYzibzmAnUbLaOXynfDgB/UrDCphFh/?=
 =?us-ascii?Q?MYWhMtZxgkFLpyNktpRAppDzkEo18QG2LVIGk34d+aRb8UUVC29l9rSFmPSf?=
 =?us-ascii?Q?AG7u4J3m5khvr/Q7471zTVrfyOx8s8339d+Vv1RePat8XN2Y5zzABAcfw67b?=
 =?us-ascii?Q?dDjgADPB1kVEF1UxLZkPHimrWUbFx1EYY4eRbVIC9QYvhUrPHJwm98rtu3jT?=
 =?us-ascii?Q?7O8o/T1IHFlif6vRFokVK8q9WIR2pLHvfFARzpUoHOjnjLYro5CL9RUCFsU?=
 =?us-ascii?Q?=3D?=
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38bbe6e6-88e3-4ec8-ee1e-08dba6c909c6
X-MS-Exchange-CrossTenant-AuthSource: IA1PR20MB4953.namprd20.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2023 06:44:19.1476
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR20MB5757
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

D1 has several pmu events supported by opensbi.
These events can be used by perf for profiling.

Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
Link: https://dl.linux-sunxi.org/D1/Xuantie_C906_R1S0_User_Manual.pdf
---
changed from v2:
1. move pmu node from /soc to / to avoid warnings when cheching.

The meaning of T-HEAD events can be found in this pending patch:
https://lore.kernel.org/linux-perf-users/IA1PR20MB4953DD82D0116EC291C21777BBE2A@IA1PR20MB4953.namprd20.prod.outlook.com

The patch above also provides a example that shows how to setup
environment and use perf with T-HEAD events.
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 8275630af977..ed981af63b55 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -73,4 +73,44 @@ plic: interrupt-controller@10000000 {
 			#interrupt-cells = <2>;
 		};
 	};
+
+	pmu {
+		compatible = "riscv,pmu";
+		riscv,event-to-mhpmcounters =
+			<0x00003 0x00003 0x00000008>,
+			<0x00004 0x00004 0x00000010>,
+			<0x00005 0x00005 0x00000200>,
+			<0x00006 0x00006 0x00000100>,
+			<0x10000 0x10000 0x00004000>,
+			<0x10001 0x10001 0x00008000>,
+			<0x10002 0x10002 0x00010000>,
+			<0x10003 0x10003 0x00020000>,
+			<0x10019 0x10019 0x00000040>,
+			<0x10021 0x10021 0x00000020>;
+		riscv,event-to-mhpmevent =
+			<0x00003 0x00000000 0x00000001>,
+			<0x00004 0x00000000 0x00000002>,
+			<0x00005 0x00000000 0x00000007>,
+			<0x00006 0x00000000 0x00000006>,
+			<0x0000a 0x00000000 0x0000000b>,
+			<0x10000 0x00000000 0x0000000c>,
+			<0x10001 0x00000000 0x0000000d>,
+			<0x10002 0x00000000 0x0000000e>,
+			<0x10003 0x00000000 0x0000000f>,
+			<0x10019 0x00000000 0x00000004>,
+			<0x10021 0x00000000 0x00000003>;
+		riscv,raw-event-to-mhpmcounters =
+			<0x00000000 0x00000001 0xffffffff 0xffffffff 0x00000008>,
+			<0x00000000 0x00000002 0xffffffff 0xffffffff 0x00000010>,
+			<0x00000000 0x00000003 0xffffffff 0xffffffff 0x00000020>,
+			<0x00000000 0x00000004 0xffffffff 0xffffffff 0x00000040>,
+			<0x00000000 0x00000005 0xffffffff 0xffffffff 0x00000080>,
+			<0x00000000 0x00000006 0xffffffff 0xffffffff 0x00000100>,
+			<0x00000000 0x00000007 0xffffffff 0xffffffff 0x00000200>,
+			<0x00000000 0x0000000b 0xffffffff 0xffffffff 0x00002000>,
+			<0x00000000 0x0000000c 0xffffffff 0xffffffff 0x00004000>,
+			<0x00000000 0x0000000d 0xffffffff 0xffffffff 0x00008000>,
+			<0x00000000 0x0000000e 0xffffffff 0xffffffff 0x00010000>,
+			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
+	};
 };
--
2.42.0

