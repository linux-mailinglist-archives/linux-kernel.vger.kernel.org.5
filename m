Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EBE07902A6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350682AbjIATvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233176AbjIATvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:51:50 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2050.outbound.protection.outlook.com [40.107.93.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAAC210FC;
        Fri,  1 Sep 2023 12:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XiJzl9bebCvKScVAqShZOOmC/ZYkaVg8WrViiAkcW95cER5H8j1KxDkVSXke4sa0g6YyVhMZH4aNyGB3nB+tM3Imp8IDpEeuYjSIGSHe97FboM7I2agsfxvymF4mPDlZeYiVW9bz9jCBgz8qkq2p6FKDjAPQhx+cHrqHDtUNpJSG5LTTmfGmyJjouGQHomjedQUuGcldTDklBBz7knQUlrZgo5HuzPIsXj77mxqTuKTuxiMhT+0X2hLNAy1lCW8+e/81XVGwxpmlC4sYr+XKAoVw3WEDBf1QlyuigwoI8zUcp3ZF+nQ62AJgNoWoSl6GZLa9gR/5GOviOgfJzfKD6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q/GXDsnztKM5APf05O7K5f5tTtb1jyQOw8Wo6Txpfcc=;
 b=MuUkCXnCGsPJt5r2X4eVKbSvdkF7yigUETp3TvALoajkKu7TqrrDfzUNz6DImJvf0XV8eZ1yNHA506Dnz90VSZUTyNVnWRpcnoTsoQBOzu+82NUUZjyZZf+vBizA8sYRjrNj4eGNs38jVf0u++RswusdB8qH00NE68a+zAz/vNl6cwkIa1nclY2G2dANvXAxZ+EikUZVl2Vqn4UzzHijBw9BfY7gvPMPZgbRdhJb03fcmWw/TzKL5WsVCvRpMq+hKqjRbe1964BN55bw7dDvVbVuIvRCjeqrhwp58km9XsxUwIeTh38M1EMsZYuQxu83QnhgWhhm/OSZIixgNORjTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q/GXDsnztKM5APf05O7K5f5tTtb1jyQOw8Wo6Txpfcc=;
 b=mFH2heEhx6ZsAN9zopB+hAyo6V9erAk40Bcw27MSZr3yEHGfaf1xtrN7oI3rL07EEoy0r6SMH99XxV3Z9GBsJNWPyQM0by7wjFmCzwJzDB5V2f5ztW9YM73eCwWKmmdW5NUbMj5+5l+Whlv3OOs1jIeBkC0BEt+RMtWrKQ05VVmJQ3u/BjMmgl04MdXwv9Cv/Wno9qHHJ9SGjhLK9LUMaSan5OKqfiCpTslrBGRZpxb6dVNUbqh0jU0MJvbBvjfnZgpoeDRUzS2A8agsaH0PV3DNNjenCXaM+v67Ciz1jWzEdGAwmSnVoGbpJAeSKhZnD8UJa9yfkS0FhUCfNkmusw==
Received: from PR1P264CA0083.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:345::14)
 by CH3PR12MB8548.namprd12.prod.outlook.com (2603:10b6:610:165::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 19:51:45 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10a6:102:345:cafe::b) by PR1P264CA0083.outlook.office365.com
 (2603:10a6:102:345::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.25 via Frontend
 Transport; Fri, 1 Sep 2023 19:51:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.17 via Frontend Transport; Fri, 1 Sep 2023 19:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 12:51:25 -0700
Received: from [10.41.21.79] (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37; Fri, 1 Sep 2023
 12:51:21 -0700
Message-ID: <b61b16e6-962c-67ef-f761-d355bbeb16d3@nvidia.com>
Date:   Sat, 2 Sep 2023 01:21:13 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Patch v2 1/2] cpufreq: tegra194: save CPU data to avoid repeated
 SMP calls
Content-Language: en-US
To:     Jon Hunter <jonathanh@nvidia.com>, <rafael@kernel.org>,
        <viresh.kumar@linaro.org>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <treding@nvidia.com>, <bbasu@nvidia.com>, <amiettinen@nvidia.com>,
        "Sumit Gupta" <sumitg@nvidia.com>
References: <20230901164113.29139-1-sumitg@nvidia.com>
 <20230901164113.29139-2-sumitg@nvidia.com>
 <cff32150-36cc-0f33-7629-4362baadf582@nvidia.com>
From:   Sumit Gupta <sumitg@nvidia.com>
In-Reply-To: <cff32150-36cc-0f33-7629-4362baadf582@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|CH3PR12MB8548:EE_
X-MS-Office365-Filtering-Correlation-Id: b1722d9f-13df-4297-72bb-08dbab24dec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E0OjNuo5M0d1rJUAjdUi63UYYw03zJcM/LPHAd2icsqdRxojCKapqbOThqeAwx3dziCEE9sYza3a65JQMxPtNAXTxznyhavN23Ee0Wgc4IHKTPatC9aWd6fCaLfvHxZNK7F7cFnveYbavDj+M65maxx8vk+yJhUm+BMVW+9VTTdzFSBnSe2gkfjuZH0m3Eefp7/fprrvdOrmlrsZ1+ALKN0QM1Hg4tPbrajK0FUxhc6Uq54mLhRTKQ5wO8fqOL8xoPTfnscgO0RUK7btcYnNYnIlND00lPWwJaUFbvFoFgnSIyZnlxY8xq14Fe5uezfy7KflIIDFxGLLwzJORO4VhXv6W1qxbwAZA8zNJbsXRmGz3AO8X+wFJzqnRO5lMV6Fqvuy2LGcpNr0LI6HerAOpMaxXM5dm8aNkKwmlkQITmMwrNxZeU27O9pG8lNU7Q+nBNVYAsFnyUFsabm1AszGPOlouLCh31xkQN3Y8qwVHMe/0EN217/kK0kBMlyO9fr35eixyXz8kuWULoTmyZgEZiyOXvrqHvMVZSzLv/xN1s44EZBvDnDT9dTeTRd+P3nYqdwtY0yb4YfPAOpInZpnxu+hdMUjl3RAXxGl38dzkN0tc6ifE7fB5uKYN1sHX/uOoUpHk6CCQYGQVCcOeyG/NhonbW9peIFs0fvt5k8ofP5Uh8k591FO5BpG4QsiTN3teiwzWfpxa+cTerZiivrt8iL0irp81BuvYb1F4pGv4pfFBpV+tsodxcdE9mUCCgIxRjnrvOXafo/m9Sw06SpAOQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(346002)(396003)(376002)(136003)(39860400002)(82310400011)(451199024)(1800799009)(186009)(36840700001)(40470700004)(46966006)(6666004)(53546011)(107886003)(478600001)(83380400001)(2616005)(336012)(426003)(26005)(16526019)(4744005)(2906002)(41300700001)(316002)(16576012)(54906003)(70206006)(8936002)(70586007)(110136005)(5660300002)(8676002)(4326008)(40460700003)(36756003)(40480700001)(47076005)(86362001)(36860700001)(31696002)(356005)(31686004)(82740400003)(7636003)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 19:51:44.6501
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1722d9f-13df-4297-72bb-08dbab24dec8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8548
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 01/09/23 23:28, Jon Hunter wrote:
> 
> 
> On 01/09/2023 17:41, Sumit Gupta wrote:
>> Currently, we make SMP call on every frequency set request to get the
>> physical 'CPU ID' and 'CLUSTER ID' for the target CPU. This change
>> optimizes the repeated calls by storing the physical IDs and the per
>> core frequency register offset for all CPUs during boot. Later this
>> info is used directly when required to set the frequency or read it
>> from ACTMON counters.
>>
>> Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
>> ---
> 
> You should list the changes you made in V2 under the above '---' so it 
> is clear to the reviewers what has changed. I believe in this case you 
> simply change the subject but please clarify.
> 
> Jon
> 

Yes, only changed the subject. There is no other change.
Sorry, forgot to mention.

Thank you,
Sumit Gupta
