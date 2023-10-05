Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB257B9E30
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjJEN7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 09:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjJEN5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 09:57:12 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on20600.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eae::600])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F45C2573C;
        Thu,  5 Oct 2023 05:00:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gHg6SBs6bInKaWVxFYNQkQTzRJ3mQkk5Sh2DubRapnLcrgXDSt7kl51Xz3vNvlzRiew65QQZCqeE+LTMEevP2J+wstXVMaHluxuzEvPEXhPW2JGuJufrwdmwYdg02yJYLuLOhE9dwUIiGmF3M3g0IY666hI5FSfrnnzTjTlnYcnZ5EJGu8fhGPBmeN74I3Fk5dYpQ7W7xdh9wDaC0WqLIj+Qf/NqWqxGkpOCRCfF8D6cDv5hrA7ROrmqCWL1b6iR8btFBo67ptiimSXPlc4H8fmguWSt9/Ijo3VgDce2CgPzkyitTu4f37P8zqSCKyBoeQRdYy2hhf7Pxq1LxbxptA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AV2OcLKm46pvnpIVWK/ZyVVyEmWOXw715TcNwo1l6+g=;
 b=nzEAmjRVC+mVbpv4xM5N9yvtibJJ0jW7XKa6Z/BGkb9I3h0GlepMl2OV2kPh9Uc/SCBUu4X8+v8PlrUU1PwXbTn9JCMwUhtfcJjoc0SWeXkh9ISS0LbIP1scaINHXF7uL8tRfnqumTztQV8BFgPMRboBKowL/c/OLQH3ckKYmtB4cPa0GtxgrSgLhHZF7SzBWMacp7kVQdLZJmLHcc1v69LkK/Lejb3AFF8HzjGTKT3Fopenmdpqu+yjH8fVM+hy+X2BN3VepVTkgalp2w+AtopOkl9PDStxs9fi3l0CzukvXFw9+jYYXmIqEJ5sONuibbwLhciJG1jwAMvd3iYykg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AV2OcLKm46pvnpIVWK/ZyVVyEmWOXw715TcNwo1l6+g=;
 b=RihbcXIYnWrUeV+hf990ej1njYSWVV5RR7XdqZRQgYdjLAHpTj3qdPBFaEbYgdSw3kGLC4Lqb6htYkkXpWC6UjER4wa3IsnClrY2c+ai+thJdJv1uDmkLZCdZ4GoPzYkFzS+jvqeh2OJUSa4k2F+Zdz0lX6S5HGx3HYmvQZb/CY1UuhYJcN5B6zhxmYwgvBA+PML3/GF00+Za+2P5+Ej3WI8l17TcK/0g9VIyBXwb/8pbssbhS49fjjU7EqhlexOYdRPMEmQznU+uk27aPYCbDQnyyfkcbS/Nh2Lp4kg4+rnNVmfTk0Jj8XYT6tIoLo5V1cTETarhLnbWDoZKaNtgA==
Received: from MW4PR04CA0359.namprd04.prod.outlook.com (2603:10b6:303:8a::34)
 by IA1PR12MB7712.namprd12.prod.outlook.com (2603:10b6:208:420::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.29; Thu, 5 Oct
 2023 11:59:49 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8a:cafe::54) by MW4PR04CA0359.outlook.office365.com
 (2603:10b6:303:8a::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34 via Frontend
 Transport; Thu, 5 Oct 2023 11:59:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.9 via Frontend Transport; Thu, 5 Oct 2023 11:59:49 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 04:59:40 -0700
Received: from [10.223.0.138] (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 5 Oct 2023
 04:59:38 -0700
Message-ID: <312bc0c1-94c1-dea7-917a-079381634f3a@nvidia.com>
Date:   Thu, 5 Oct 2023 14:59:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] devlink: Hold devlink lock on health reporter dump
 get
To:     Jakub Kicinski <kuba@kernel.org>
CC:     "David S. Miller" <davem@davemloft.net>, <netdev@vger.kernel.org>,
        "Jiri Pirko" <jiri@nvidia.com>, <linux-kernel@vger.kernel.org>
References: <1696173580-222744-1-git-send-email-moshe@nvidia.com>
 <20231004163929.70977d05@kernel.org>
Content-Language: en-US
From:   Moshe Shemesh <moshe@nvidia.com>
In-Reply-To: <20231004163929.70977d05@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|IA1PR12MB7712:EE_
X-MS-Office365-Filtering-Correlation-Id: aca490a3-180d-4aa7-4264-08dbc59a93b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3wCUfz70q1IDT8tWDppxXecPtwT5qeVe1qVJrObkJ35UUOO+Kf21utZSNLiv8j0cGQ/XH6xGeT+Yy+Kiy0I8FX50GrbnDJqqTA8DdwX3zsp9EXofwA/+ndy6SKZdquBNT70qoPvDtA02HXlJE47wqoG+MIGCc11fpaZjrEF7/m44jS6GG1QOebTwoAeMgGzMShUCanA/RQXGXUXU2UBgJ9nxFuaSkvA1K7J5N7B/4bZ7SzlPZ8zP1pX/9njB8qswmsxS8Ems1unjKkcnt7JB4O8TfxvRFzslbr5ZdNqiF6SP0YXPm8xqjJPFJ0FbzQG4s0vUCRNdew+gxmmRHDvK/ahNn1irDXwlLopJqddDRfK6G63fgiAbi8W+75fe5lktJFt8oi8Jo+meafqebYgXmz+8lC5ei93OEjYUwCaCtkjd5sBHSVfLh2W9egL0gxxysTeR51XLDlSZIw40rfLKlB4XEjicwx0idjejN8YV2IxyRGqX9MbE5eGqc6TXgfZL2NRdY00iDy1rSkTM68x/nq8YBuuk+RBjJAiLwcdd5BXwTfK/tQunZ4D0V6kN6tzeZn3Vk+TPrgdK9nMy0QP+275OqO69JyTFT2aUST7rknCBoYwbaCvc2oIwbWOAPlTRERaQRpPoiux/NJNv4wR1Wn8EROBgnZAFjNj20jVgqjKEPpV1B3BMKyCN5TsoDdJtP5FIgooL6erSpRjzu6yYVeoJqgWxdKsIxIz4wt01b0LZzwoS2O17tnesvBMzLly4WohCJw6BdvOhK5FT3BL5pw==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(136003)(39860400002)(376002)(230922051799003)(64100799003)(82310400011)(186009)(1800799009)(451199024)(36840700001)(46966006)(40470700004)(40480700001)(40460700003)(4326008)(7636003)(8676002)(8936002)(5660300002)(70586007)(54906003)(70206006)(16576012)(41300700001)(336012)(356005)(6916009)(316002)(2906002)(6666004)(53546011)(426003)(16526019)(2616005)(26005)(36860700001)(83380400001)(47076005)(478600001)(82740400003)(36756003)(86362001)(31686004)(31696002)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 11:59:49.5753
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aca490a3-180d-4aa7-4264-08dbc59a93b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7712
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 2:39 AM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
> 
> 
> On Sun, 1 Oct 2023 18:19:40 +0300 Moshe Shemesh wrote:
>> Devlink health dump get callback should take devlink lock as any other
>> devlink callback. Add devlink lock to the callback and to any call for
>> devlink_health_do_dump().
>>
>> As devlink lock is added to any callback of dump, the reporter dump_lock
>> is now redundant and can be removed.
> 
> I love the change but it needs more info in the commit message :)
> 
>   1. what exact / example but real problem are you solving?

Sure, will send v2

>   2. some words of reassurance that you checked all the drivers
>      and the locking change should be safe (none of them take
>      instance locks in reporter callbacks etc)

That's what I checked, looking at the code, I didn't find any devlink 
instance lock through all drivers health dump callbacks in current code: 
bnxt_fw_dump(), hinic_hw_reporter_dump(), hinic_fw_reporter_dump(), 
rvu_hw_nix_intr_dump() , rvu_hw_nix_gen_dump(), rvu_hw_nix_err_dump(), 
rvu_hw_nix_ras_dump(), rvu_hw_npa_intr_dump(), rvu_hw_npa_gen_dump(), 
rvu_hw_npa_err_dump(), rvu_hw_npa_ras_dump(), 
mlxsw_core_health_fw_fatal_dump(), mlx5e_rx_reporter_dump(), 
mlx5e_tx_reporter_dump(), mlx5_fw_reporter_dump(), 
mlx5_fw_fatal_reporter_dump(), qed_fw_fatal_reporter_dump(), 
nsim_dev_empty_reporter_dump(), nsim_dev_dummy_reporter_dump(), 
qlge_reporter_coredump()


> --
> pw-bot: cr
