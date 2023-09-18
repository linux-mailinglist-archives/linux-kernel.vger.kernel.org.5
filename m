Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9648D7A47B0
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 12:57:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjIRK4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 06:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241208AbjIRK4Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 06:56:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1FCA1;
        Mon, 18 Sep 2023 03:56:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ePoBHGTuXULKWukkS1BR7legDN1EgJ1/cVIzDJt6rolgze2KFM77kC/ygVWdhQ6xDlYsDX5O8RTbM6dYn2tiEB0dAXT/7c/plYojNAGJKtk2uq/C4b+ntGu52rhL5iRUl/mNS2z8EyJ8JFh+8JYSyTRnKL44IiZgQElHH0yYUCoSl0ArSaLkzDkaU01naajn6gu5pziOLWC5vt9nuQcrRkM6hdjBLuQg53gRtLzGFk/gTNnttuNBd/G8q1NgGQawA5RJILGYhv3L0XAvrzLrl5Z8tTzs/EfIQen035ZeC3BN807TJXlcjQvpPOpTDBiUmxra1fCovzyg3V+OATpVTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QdevCE3bKD/hUKJ9YjNcz54Op+c4zUj+G8RM4TpL7dk=;
 b=fV0GI4cecOn14TIWBkgZSCGc1qt9pF2bmuMvSyRfJek+hTfbGVEsNPDtvHlmxOi9wUJQE4jglmbvVSXE+sVzbN1Y5NAA2bjM+secZLu4anUV3O2JCbVzUQXv2RbIkt2IxSwtAE3ZCxvIvlYbLbEoaEaASiUyju8cg51Lkw6U0+l1YyH9zAhLe0w+cFcBOQ9YXKQbwWgE7j+AOpk75U9scjYV6JGgdMo4fT0SvMOF25PH1YPWaU1P9+sXTU9Ddh/h6a8vEp4rSBJ/LjULVplp/r/AfvCzwOPYHnk/yz7pWRfkyqBJ6+8rGIOQMiABgXcIMOypm78LM8ShfwpS9ngxdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QdevCE3bKD/hUKJ9YjNcz54Op+c4zUj+G8RM4TpL7dk=;
 b=PMyWhIdx4MV8AKluzvRSGrzjhz8JAPB7lGBKfKhcsJ12wJtZriFrcf772GGAIkZsqw9KZsjP+9QCtLvr+JqRAA+Payc/IUHq5DSYRRddlZEjEKLVBrWKA9Rq4mcS34xMAv1kEtpDXqh/gVcX8OgZEG5odBuT1mNsJSpoqXVdt+U=
Received: from MN2PR06CA0007.namprd06.prod.outlook.com (2603:10b6:208:23d::12)
 by IA1PR12MB7638.namprd12.prod.outlook.com (2603:10b6:208:426::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Mon, 18 Sep
 2023 10:56:16 +0000
Received: from BL6PEPF0001AB74.namprd02.prod.outlook.com
 (2603:10b6:208:23d:cafe::a1) by MN2PR06CA0007.outlook.office365.com
 (2603:10b6:208:23d::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27 via Frontend
 Transport; Mon, 18 Sep 2023 10:56:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB74.mail.protection.outlook.com (10.167.242.167) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6792.20 via Frontend Transport; Mon, 18 Sep 2023 10:56:16 +0000
Received: from [192.168.137.2] (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Mon, 18 Sep
 2023 05:56:15 -0500
Message-ID: <2eaa2e1d-b6cf-4032-af28-5e8f6428e95f@amd.com>
Date:   Mon, 18 Sep 2023 12:56:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: xilinx: Apply overlays to base dtbs
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230911214751.2202913-1-robh@kernel.org>
From:   Michal Simek <michal.simek@amd.com>
Autocrypt: addr=michal.simek@amd.com; keydata=
 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
 3i3l5DA=
In-Reply-To: <20230911214751.2202913-1-robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB74:EE_|IA1PR12MB7638:EE_
X-MS-Office365-Filtering-Correlation-Id: b3110abc-bf40-4ff2-1a0f-08dbb835e206
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: B2GPGTlNrktlbCtQfmWSqv+y2YPbmYN+fZYd+Nh/8Lb22gQjJeiT5FwwOGMdkRDqKf39Wh91p1lRK/m3SgRTLQN8n5KUFthSkn0U59CpkTxsdjFaBkNS4INFh1aMClNb5kg/d8HbF7qxAt9dXn/wnuyO6VvBsiPdZCZKoHPeGyscHI0fZlgA9WuKKULmzQNONNaERniS8A/Has2sNiMef18C46FJfVQ7Sy1OGqyw1WpuL61PnPLpk4PQyv/kJviX/tm1Jusrc2iu+03O7zEUVmVv3lnVwQ2FeYS9gfgYKvV3iTzZ9aYYtOMB3aTe8xxR4PmcaRwouQVyaYfUgdSTgW3r03l5xtpGiiiUrU8WErXq6v59aZIj45i/bsB7+YFZ3BcyozOh6lQeOd2JRGyHZe2I0j2lp9TTNp21yYmrIZhAwqxWkYDwzrWIjzv6jizcZTx0CG8b+Wn/zni4d1gChhAd2DVSC02DlJYn8kQ2FAde0DncbazF4zCBFw9KSoluodKbCWDYPUyUDxiy2Wl/YDupQyTRKkD1Ik9HiDcHeOZItNx6U1YLLtwbdaERAwzCkxAGLjmw1RlTapmjxhhi17osZPJk9Rc6tiMjsyN4/tErun1JRESdVqvUZlfqC1xpZXYk/zWV3+jVKeVwisVJ6dnO2PGWCepfNmGT2PjipAOQNX4sY6wR7XLVSA37pG0v2yLv6c/ZcH9uVdAF8WB743t7iHCjnG93VBgJqTizBEuy2ghutMpmEQ28v++KAFtCbKTSdUazlbS47iLdmKIbCoN9yvWRSMH0BqIAY21I/OoqSWJvendE1xPFbIVjZDo5
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(40470700004)(46966006)(40460700003)(31696002)(36860700001)(2906002)(47076005)(36756003)(86362001)(81166007)(356005)(4326008)(8676002)(40480700001)(8936002)(2616005)(5660300002)(31686004)(26005)(16576012)(70586007)(53546011)(70206006)(54906003)(110136005)(316002)(426003)(41300700001)(82740400003)(19627235002)(336012)(478600001)(16526019)(83380400001)(44832011)(6666004)(36900700001)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2023 10:56:16.7416
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3110abc-bf40-4ff2-1a0f-08dbb835e206
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB74.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7638
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/11/23 23:47, Rob Herring wrote:
> DT overlays in tree need to be applied to a base DTB to validate they
> apply, to run schema checks on them, and to catch any errors at compile
> time. Defining the "-dtbs" variable is not enough as the combined DT must
> be added to dtbs-y.
> 
> zynqmp-sck-kr-g-revA.dtso and zynqmp-sck-kr-g-revB.dtso don't exist, so drop
> them.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>   arch/arm64/boot/dts/xilinx/Makefile | 9 ++++-----
>   1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/xilinx/Makefile b/arch/arm64/boot/dts/xilinx/Makefile
> index 5e40c0b4fa0a..1068b0fa8e98 100644
> --- a/arch/arm64/boot/dts/xilinx/Makefile
> +++ b/arch/arm64/boot/dts/xilinx/Makefile
> @@ -22,11 +22,10 @@ dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA.dtb
>   dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA.dtb
>   
>   zynqmp-sm-k26-revA-sck-kv-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revA.dtb
>   zynqmp-sm-k26-revA-sck-kv-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-sm-k26-revA-sck-kv-g-revB.dtb
>   zynqmp-smk-k26-revA-sck-kv-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revA.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revA.dtb
>   zynqmp-smk-k26-revA-sck-kv-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kv-g-revB.dtbo
> -
> -zynqmp-sm-k26-revA-sck-kr-g-revA-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
> -zynqmp-sm-k26-revA-sck-kr-g-revB-dtbs := zynqmp-sm-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
> -zynqmp-smk-k26-revA-sck-kr-g-revA-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revA.dtbo
> -zynqmp-smk-k26-revA-sck-kr-g-revB-dtbs := zynqmp-smk-k26-revA.dtb zynqmp-sck-kr-g-revB.dtbo
> +dtb-$(CONFIG_ARCH_ZYNQMP) += zynqmp-smk-k26-revA-sck-kv-g-revB.dtb

Applied.
M
