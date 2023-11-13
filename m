Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E3127E9C79
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 13:56:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230306AbjKMM4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 07:56:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMM4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 07:56:34 -0500
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2044.outbound.protection.outlook.com [40.107.20.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B1C1711;
        Mon, 13 Nov 2023 04:56:30 -0800 (PST)
ARC-Seal: i=2; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=pass;
 b=FaKTMKLRdyKC0J5r189RhJW0JpSny7PGlnWHqWjtGTO39w4sMw+1WZRue2mAUMGGCQ7OZNWt5uTB+AElU6xUFzS3CBOTblb1RLRD2UFo2f6syiYsXZpGmWwHtHmQN9yo4Y/G68WeW94cSwGdDi5MRJxGSArBhmJDEP+R4aVTXndzDBA2hfLTpjzTXrSMOAvC5enFN30gh3/Opt0dDBirc1IVc0MA3/T6R8vFq93J4mfKDu54WyT5KY1neIagBCklxJs0dIKeonR7pPvSutPvRvtDCotkNn50o0xOS8CqqbiXe4OVwZYLH5hc7i8T0HlUlm7/ouHp57VHqHllafEnRg==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YfeX/6/1Wchx+c2EN6LzimkjrpkSge6gcL6WWRjWMY=;
 b=UQ+BpSBfDlaLqJ8CRtAGcv79bdbjUp/qkGp/3EnBLdyd5I40+MT5sHc1lPk0q7VtL9vT7e7exHnkrH1kvGyp2rOlHqqbXVlU+HrnhjE3ZQzZFI578XIoQuCnvLEF68DCBzXOcEEwkJiVyPQyXVpn77wKLsEVwzUwL9B2t4UOQ8bvN5sWvxN5DcH+yzMoZX0xgQsTykzB1oTOXi94vmBOMtQ/4Bk1JlnvOochtlxXwYUIY4k9e/G0huO/8mDpSPmweXNAa4GEar7we0o0oBjWBlbpVIYWFj5xyqI1B4UE9epwP1CGekktHJzFPYz2UI8tJJOOkfsr23HPLD4jNK8upw==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 63.35.35.123) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=armh.onmicrosoft.com; arc=pass (0
 oda=1 ltdi=1 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YfeX/6/1Wchx+c2EN6LzimkjrpkSge6gcL6WWRjWMY=;
 b=vnHEwaGCTR5zWgQsUGlX+jJbW6C7FRI+zo1fNJJjjV+FoE66fdVA3gNUFLHZIptuFFMjbcd5nGo2nFSQzD8wivhpbdoqfKbiZUmcYcTHbnoKeMJ94exQZws1zDQYmooP1DU5zFgsWTd4Dz9V18XAxHRr8WQsdllqpOxARRQuBBU=
Received: from AS9PR06CA0109.eurprd06.prod.outlook.com (2603:10a6:20b:465::33)
 by VI1PR08MB5440.eurprd08.prod.outlook.com (2603:10a6:803:134::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 12:56:20 +0000
Received: from AMS0EPF000001AE.eurprd05.prod.outlook.com
 (2603:10a6:20b:465:cafe::5b) by AS9PR06CA0109.outlook.office365.com
 (2603:10a6:20b:465::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29 via Frontend
 Transport; Mon, 13 Nov 2023 12:56:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
 pr=C
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AMS0EPF000001AE.mail.protection.outlook.com (10.167.16.154) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7002.14 via Frontend Transport; Mon, 13 Nov 2023 12:56:19 +0000
Received: ("Tessian outbound e243565b0037:v228"); Mon, 13 Nov 2023 12:56:19 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 4b332d4df3e9a1c0
X-CR-MTA-TID: 64aa7808
Received: from be1eb2920814.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A4F2315F-5CB8-4A90-A49D-09B2D76B47C6.1;
        Mon, 13 Nov 2023 12:56:13 +0000
Received: from EUR04-DB3-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id be1eb2920814.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 13 Nov 2023 12:56:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7Z11Hlolc6YeRr64GsiQ6Wuk7SJSLC/EJBrjXGgXdUmqUdgho0lRCOfkbSFWad+UpCcGekFolyEP1CyS91Cue2oBZE1dPCNmCd9nwJuirXGCgQT82WzqaP0DpTMbrL13qg3xx6zIw9rKL27QRYTyIKw8yGexu6vBkyPRbWGQY3yPrRrwuO2o/NlHcUyka275nYqdkFAkjMLtdiCnkHUcvb9Z16N4PyS1km/g7vTjX85iGO1akJEGEzaEpwUvSRzlzjaH7dt6FY7+aRMKm/n7Zlq0DvMoPfJx4FIdggvGB2yw0lSkKsi46X7iP/CmbtkVIsDZCSHPlzCgL/ZGCksUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9YfeX/6/1Wchx+c2EN6LzimkjrpkSge6gcL6WWRjWMY=;
 b=nQtRx/qNbrVGfvkdFJhhcvqDzZnF9RCciObtzRp2JcTQc088gayLtj52OgEf2JMULmSX47jwqab5rEKM+upxBP8+UOTfT39zOREGic/U5Vh4HmYmXgGCVXQM7lvukYcuUkElmPlxua5O1AHBBYzRF25AdCSsElslvOoqtCbKUX+tU++3OHuch1nT3tZh5LXG0nTF4Qm/A9lxyOh4QP8eHO6gaGZWAbD+dXCH9GlF/El90toxzEEHITT4Ng86/bkCggElzOyotpvIIwJpyj8nIPB03g6bZgwQK9Nj3ZKBX/9XZkYXtj2veLQv+hH1vMJ+2nkz7u9U5a+JIJrPLviCkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9YfeX/6/1Wchx+c2EN6LzimkjrpkSge6gcL6WWRjWMY=;
 b=vnHEwaGCTR5zWgQsUGlX+jJbW6C7FRI+zo1fNJJjjV+FoE66fdVA3gNUFLHZIptuFFMjbcd5nGo2nFSQzD8wivhpbdoqfKbiZUmcYcTHbnoKeMJ94exQZws1zDQYmooP1DU5zFgsWTd4Dz9V18XAxHRr8WQsdllqpOxARRQuBBU=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from DU0PR08MB9656.eurprd08.prod.outlook.com (2603:10a6:10:446::7)
 by AS2PR08MB8902.eurprd08.prod.outlook.com (2603:10a6:20b:5f6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 12:56:10 +0000
Received: from DU0PR08MB9656.eurprd08.prod.outlook.com
 ([fe80::abc6:b931:ed3a:1901]) by DU0PR08MB9656.eurprd08.prod.outlook.com
 ([fe80::abc6:b931:ed3a:1901%6]) with mapi id 15.20.6977.029; Mon, 13 Nov 2023
 12:56:09 +0000
Message-ID: <2535571d-6fea-4064-8325-0f47d031c85f@arm.com>
Date:   Mon, 13 Nov 2023 12:56:06 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v5 5/5] dt-bindings: firmware: arm,scmi: Add support for
 pinctrl protocol
Content-Language: en-GB
To:     Cristian Marussi <cristian.marussi@arm.com>,
        Takahiro Akashi <takahiro.akashi@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
References: <cover.1698353854.git.oleksii_moisieiev@epam.com>
 <e9285b4377242e4d888391be987cbb99caf8c573.1698353854.git.oleksii_moisieiev@epam.com>
 <CACRpkdYW-xmejyOo9H9XSkcabvYgBqPvpjppvNe_RF6RLxyxKA@mail.gmail.com>
 <ZU2AP7leDcIZIN+b@octopus> <ZU5LFC23JaEidEGZ@pluto>
From:   Souvik Chakravarty <souvik.chakravarty@arm.com>
In-Reply-To: <ZU5LFC23JaEidEGZ@pluto>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LNXP265CA0017.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::29) To DU0PR08MB9656.eurprd08.prod.outlook.com
 (2603:10a6:10:446::7)
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic: DU0PR08MB9656:EE_|AS2PR08MB8902:EE_|AMS0EPF000001AE:EE_|VI1PR08MB5440:EE_
X-MS-Office365-Filtering-Correlation-Id: c5680cdd-4eed-46bb-c45c-08dbe447ee86
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 0xTimsXbNKGiwmUeI930kkO41MVYJUJjvd3Bj8we9DUztJl7kBI8S1GQSqvwo6Vn1kfVF9GWolctFURPJ8hPj6TdX2BypvFLWWgs03naABvsCEYIxR4t4J8cTtOvMdqFligd2CKQhDRJH+PDOYmsNQn3bLpSQTDiXFxSXs3rGgwkOsWpszEOEDx5Jqhg4hq1dOL9nBiP5g7PgSU63WBp2BnxPFamg7IcE4rhJk6xMUJ1VUJozOOyRKALYigYm8Kj0I2a5LXdbFXfW1+0FTmH3LsJzfyicn/G3t97HPcBmDkbH7JlCr4PhncINpO3MZmk05Dg0asJcTmrRQpwhnKhtvDxvYSgfCyMZhuTa5f04Mt+344V3FCwxzpkToo14CphVn5BHOPSCY8O1n4ZWpPFvpv/Vsyv4kadfkr5aSkiHOe+M3DMfzUNA5cTT1NsXqFr0G43BnRw4Yb2E2q3d1nUVzK3bCNUHdwuu2Fq2nW1mFg5LhDNY0j7Og4B9EGaClkuJiLA/BI6xI+zK/JbQ7bOGsGsSaNWJr7GEZFJVBTljkNs3Q87GX8GMn7/AHOM7J6vL28Q/kMVM6XtGZi3/vPuB87vvM7v1er3eYvmPFRQwLCpvFXfgSAY9x6U7+lIbLnjhFcwxOxSFYnNfQhB/pmY5w51i3aE0xUXZzu1qOGqCBs=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9656.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(39860400002)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(66899024)(7416002)(2906002)(921008)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(26005)(110136005)(6512007)(66556008)(66946007)(66476007)(316002)(38100700002)(83380400001)(966005)(31686004)(36756003)(478600001)(6486002)(53546011)(6506007)(6666004)(8676002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR08MB8902
Original-Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs: 7bf2bdd1-df5f-4e5f-7357-08dbe447e853
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zGDcSlH2DPuAbNcnZvEUuQS5KW/ZtbUefUkIcGkd0T5JJ+OHO96btPHHqJiIbNZFKPN8RDDvpRCqA+X5kohezqm/VRJRSz5JUir7a5FsFxCRu9E0aLhYWzhyh613lWtSE6k80zhcEEZz4lwFJRjB4Fx/S56jjV6NiUvt1L+oEdkYTSK6XzoxukUg5hKOdFoewYv0T6pvvNtJ3r8QNDnJ+NNtui9Y5F2Pvw0Gq4RkL6jJRPHB3esx2o1wiY0yPIHCw/D3QRAN1Hqz6b36DWP82iy+bx713z+erpf/27GAV7KCAk9DUaqzT5R6QYw9kK4En+LqOvDlc3sxuDxUcRqFdKRN1sbLcaGQhI1uGi+q0CQSHasi8knwBwXwVYF08QE0OvgPG+1DLyfyCXe+0/Ptv1fw/Kk+XPo/CBg42weaS+NcMbkpmB3OjZzefL8+QjolYtX4zBDm+njTNWV1rZGNu7vhbgsGtKUbLRwOwq9rKkwdfF3BwmD8Ow7inqtPQc9mPZdF3RaDUW1WC19kwS/kJxfUL0tLpQkPLRTqjTlL6gyV/wNLcuZMxsu7ZHjM8rWKKIIvYbDk6GFZFaANwJdZzlDubxJCTl3NKpLZa0WYqmI27KN8/wfpkrrjQFNMgF2Lc0EbOi263rW5/o4Y2TxHp5C3x42C9xtMUwKRKpTtoB0APox1q7RN23I5ezFCUAANcOHzUdEtnikcw4L4gDD+gNSz/YNWuXf5pMS7IXpfYXZfMvTvoH5YHf+NvpyeT+FR
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(396003)(346002)(376002)(39850400004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(82310400011)(46966006)(36840700001)(66899024)(36860700001)(2906002)(921008)(44832011)(2616005)(5660300002)(86362001)(31696002)(41300700001)(47076005)(336012)(26005)(82740400003)(110136005)(70586007)(6512007)(70206006)(316002)(83380400001)(966005)(31686004)(36756003)(81166007)(478600001)(6486002)(53546011)(356005)(6506007)(6666004)(8676002)(450100002)(40480700001)(8936002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2023 12:56:19.7583
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5680cdd-4eed-46bb-c45c-08dbe447ee86
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001AE.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB5440
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,FORGED_SPF_HELO,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 10/11/2023 15:24, Cristian Marussi wrote:
> On Fri, Nov 10, 2023 at 09:58:39AM +0900, Takahiro Akashi wrote:
>> Hi Arm folks,
>>
> 
>> Do you have any comment?
>> I expect that you have had some assumption when you defined
>> SCMI pinctrl protocol specification.
>>
> 
> [CC Souvik]
> 
> @Souvik for context see:
> https://lore.kernel.org/all/CACRpkdZ4GborirSpa3GK_PwMgCvY0ePEmZO+CwnLcP6nAdieow@mail.gmail.com/
> 
> Hi,
> 
> I am not sure what is the full story here, BUT the spec was mainly aimed
> at supporting PINCTRL in SCMI with the idea to then, later on, base GPIO
> on top of it, "easily" building on the PINCTRL spec features in the future
> with a separate series from the one Oleksii is working on...but it like
> seems the future is already here and maybe we have discovered something
> to be clarified...
> 
> Souvik/Oleksii can tell you better what were (if any) further assumptions
> related to GPIO on top on SCMI/PINCTRL, but the aim of this series was
> always to be just the basic Generic Pinctrl support when dealing with an
> SCMI server backend.

The initial assumption always was that GPIOs can be considered as a 
specific function. Note that the spec does not define the types of 
function and leaves it to the DT binding (or driver) to figure out the 
function descriptions/names.

> 
> Regarding the current Pinctrl series by Oleksii, I would also notice that,
> indeed, some "non-spec-dictated" naming assumptions are ALREADY present
> somehow, because, currently, the spec and the pinctrl SCMI protocol layer
> speak/refer about pins/groups/functions, as usual, only in terms of numeric
> identifiers/IDs (with an associated name of course), while the pinctrl
> driver (thanks to the Linux pictrl subsystem layer) describes and refers
> anything in the DT in terms of names: so all of this really works only
> because the names used in the DT happen to match the names reported by
> the backend server.
> 
> My test DT uses just what Oleksii exemplified in the cover letter:
> 
> 	pinctrl_i2c2: i2c2 {
> 		groups = "i2c2_a", "i2c2_b";
>                  function = "i2c2";
>          };
> 
> 	pinctrl_mdio: pins_mdio {
> 		groups = "avb_mdio";
>                  drive-strength = <24>;
>          };
> 
>          keys_pins: keys {
> 		pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>                  bias-pull-up;
>          };
> 
> 
> with a dummmy test driver referring to it, so as to trigger the drivers
> core to initialize the pinctrl stuff.
> 
> But all of this works just because, in the example of my emulated setup,
> my fake server exposes resources that are exactly named just as how the
> above DT expects pins/functions/pins to be named, because this is how
> the Generic Pinctrl subsystem in Linux is supposed to work, right ?
> 
> The difference is that the names, in the case of pinctrl-scmi, are not
> hardcoded in the specific pin-controller driver BUT are provided dynamically
> by the SCMI server at runtime.
> 
> And this is just a naming convention, between the Linux picntrl subsys AND
> the SCMI server, that allows the Linux Pinctrl subsys to map, under-hood,
> names to type/IDs as expected by the SCMI protocol layer (and by the spec):
> so when you will define and describe a real platform with a DT, you will
> will have to provide your name references, knowing that the shipped platform
> SCMI fw will advertise exactly the same (or a superset of them)
> 
> As such, personally, I would find reasonable to use, equally, some
> conventional function name like 'gpio' to advertise and configure groups
> of pins as being used as GPIOs.

As a general principle, we dont try to put naming conventions in the 
spec if it can be easily resolved via DT. If this is proving to be a 
hassle then we can "recommend" in the spec that pins which can only be 
GPIOs are named starting "GPIO". Similar for functions.

However looking at Linus' comments below, I am not sure we are at that 
stage yet?

Regards,
Souvik

> 
> Maybe, though, both of these expected naming comventions should be
> explicitly stated in the spec: indeed if you look at some Sensor protocol
> extensions added in v3.0, in 4.7.2.5.1 "Sensor Axis Descriptors"
> regarding naming we say:
> 
> "It is recommended that the name ends with ‘_’
> followed by the axis of the sensor in uppercase. For
> example, the name for the x-axis of a triaxial
> accelerometer could be “acc_X” or “_X”."
> 
> ...so maybe some similar remarks could be added here.
> 
> Souvik is really the one who can have a say about the opportunity (or
> not) of these kind of explicit advised naming conventions on the spec,
> so I have CCed him.
>   
>> On Mon, Nov 06, 2023 at 02:12:36PM +0100, Linus Walleij wrote:
>>> On Fri, Oct 27, 2023 at 8:28???AM Oleksii Moisieiev
>>> <Oleksii_Moisieiev@epam.com> wrote:
>>>
>>>> +                keys_pins: keys-pins {
>>>> +                    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>>>> +                    bias-pull-up;
>>>> +                };
>>>
>>> This is kind of interesting and relates to my question about naming groups and
>>> functions of GPIO pins.
>>>
>>> Here we see four pins suspiciously named "GP_*" which I read as
>>> "generic purpose"
>>> and they are not muxed to *any* function, yes pulled up.
>>>
>>> I would have expected something like:
>>>
>>> keys_pins: keys-pins {
>>>    groups = "GP_5_17_grp", "GP_5_20_grp", "GP_5_22_grp", "GP_2_1_grp";
>>>    function = "gpio";
>>>    pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>>>    bias-pull-up;
>>> };
>>>
>>> I hope this illustrates what I see as a problem in not designing in
>>> GPIO as an explicit
>>> function, I get the impression that these pins are GPIO because it is hardware
>>> default.
>>
>> If you want to stick to "explicit", we may rather introduce a pre-defined
>> sub-node name, "gpio", in a device tree binding, i.e.
>>
>>    protocol@19 { // pinctrl protocol
>>        ... // other pinmux nodes
>>
>>        scmi_gpio: gpio { // "gpio" is a fixed name
>>            keys-pins {
>>                pins = "GP_5_17", "GP_5_20", "GP_5_22", "GP_2_1";
>>                bias-pull-up;
>>                // possibly input or output
>>            };
>>            input-pins {
>>                groups = "some group"; // any name
>>                input-mode;
>>            }
>>            output-pins {
>>                pins = "foo1", "foo2"; // any name
>>                output-mode;
>>            }
>>        }
>>    }
>>
> 
> I suppose your proposal of a specially named "gpio" node would be
> another way, BUT it would also mean describing something in the DT that
> could be discoverable dynamically querying the server (while making the
> above assumptions about conventions).
> 
> Thanks,
> Cristian
