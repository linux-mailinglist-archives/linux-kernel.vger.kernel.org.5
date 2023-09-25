Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9ED7ADA33
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbjIYOm4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 10:42:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjIYOmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:42:55 -0400
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2070.outbound.protection.outlook.com [40.107.102.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F58101;
        Mon, 25 Sep 2023 07:42:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4ou1ETS7GeQPgV4OnNo2Yen3I73IMKlzXBCjTwlMgDBkucdfSPUFc7Pqu5rg/RNJplIuoHZuWOkOZRSEQ6ZrlWGFNlT+7R1WHIRVb7dfUz06v99KZyBWNG59OQst7/QrjHhWxSwocf2E83zPnWXs655qkXch/EMxKBdeuJC+jw/ypD+8cjCblxqMgZwguxZxV0v6mfNqYDuuy+J4hUh/rYlzOC4/B+F+sgLoXiA0mJ7whHwpYpGaTEfOWGUBFPrnUzqzmoUA83t+/QZBt+tB2FLINJ+JNu/gQZisb41mktRkf/G7gYgXllGckHjZVD7V20YJTWfNssLcBhzjIkcbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LyllHnJEB7RQZ70NaFJPAtYlATXRgWs83bRdXCVdKxI=;
 b=KlWI/8//SteEkKt31bDGi3Mt6RE5ZZgoAlLz1XlVPEJUndeuJWBhJvLTPh3il/Y3jb1bSyZ172yEjS1E1I7Ny3p5sXLfVrzoN1otJY0TqvwndOmYmx78d3rRXMVhAts6SaG/koEIlAkcsxajq9XYGge1lGAZm8/L6ErwytrBdTaSG7zneGPtagHnZ3VEF0uxaVoYRJiegdpUjXMLLyie7ANBc4V2csxob+5dvRhBLUmOh8QxEkn0f+TkEbf7jW4fEKQrjyecDKspW397ElmZ8ngtkVRx2tv7wr2mARRtzRsttyki1aF7E1NaSCB79Teiw5YW3znOyDNzQ7IhVbwCMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LyllHnJEB7RQZ70NaFJPAtYlATXRgWs83bRdXCVdKxI=;
 b=VRIHKVKJlPrheXbBy3MnVzqxI8hmI2scUHh/F7a20geY67Nyk6SulwVRJFvmu7GQXj8e+abhoVyw6Sp7o9z2xod7/J8PoDWq1YghXhXafBjiumcbzJfVONghgHred96fq+kRHUi37ooYiBPg9VpWm7GmQgyWcNRUHJ9b4ib0r0TbuL3CFtVDwpyQnlLWsrJ2AVJsTJjQ0En7SGKY0NoiRYBfABH2pmeR8ytIha1tYXzgV/xH66i7G8tMh7+sKVrIa94XuLG08F7fMJ+AP6F8Kz0FgZdwy8+/WXWEXMoT2a4v/XKt52veeNwZNlT1QFsF6Kj234jKwDfIM9Sgcnil9w==
Received: from MW4PR03CA0238.namprd03.prod.outlook.com (2603:10b6:303:b9::33)
 by IA0PR12MB7531.namprd12.prod.outlook.com (2603:10b6:208:43f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.23; Mon, 25 Sep
 2023 14:42:45 +0000
Received: from CO1PEPF000044F3.namprd05.prod.outlook.com
 (2603:10b6:303:b9:cafe::8e) by MW4PR03CA0238.outlook.office365.com
 (2603:10b6:303:b9::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.35 via Frontend
 Transport; Mon, 25 Sep 2023 14:42:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000044F3.mail.protection.outlook.com (10.167.241.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.14 via Frontend Transport; Mon, 25 Sep 2023 14:42:44 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 07:42:31 -0700
Received: from yaviefel (10.126.230.35) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 25 Sep
 2023 07:42:29 -0700
References: <20230925085318.1228225-1-nichen@iscas.ac.cn>
User-agent: mu4e 1.8.11; emacs 28.2
From:   Petr Machata <petrm@nvidia.com>
To:     Chen Ni <nichen@iscas.ac.cn>
CC:     <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <izumi.taku@jp.fujitsu.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fjes: Add missing check for vzalloc
Date:   Mon, 25 Sep 2023 16:40:24 +0200
In-Reply-To: <20230925085318.1228225-1-nichen@iscas.ac.cn>
Message-ID: <87r0mms4a5.fsf@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail202.nvidia.com (10.129.68.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F3:EE_|IA0PR12MB7531:EE_
X-MS-Office365-Filtering-Correlation-Id: ef323bfb-c31e-46be-dab1-08dbbdd5adec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yi7VUzGbgmbBuvKu7HvM9mxES6pfP5wE4pcRTgQ7UOLOiX9FmCM/rxVLUVD/Re5LyPJa2X52/P1WgJRo0pinqC4YzJftKbj/nxINt/t6nO1Ajol5O2D5SAp11fcCYRPO3zSj9gMt428QWdIjo72rTxxTVOcET239n65jsEMtYNTpeVbqol9yOCfBdmxvhViauqekajeyXparJLR2v9iTWRGSqh50qktfaiiCLy33PstT3PSOxQvZuVabAgo1t7qjQa6bKcANJnjG/Sx+nQWfXDl0PAsp+NLhbm4WXihGkz4ctvcx3KXQ4Jtnd8/098MQYGwP5vjExnT0rUTVDrFKZvnNu8o1a2p7iVpoc6aTZtQ2gc94rwFxUFqZZHY3TdNrxBGHr+7kSkP1MDPWyW/POyF8tFbqVwhEhtmfHA9L4OmepHJMBv6NQ0+jAbkQQTQOV1ozPH3kWR3qSJKw+86M/OWGe3BdYmlMx4ouYcxnfua3BdqpRrEZCmTG3lRL10Av9Gtxt+q7VaA+aAUHcM6VxWkgisbLl3CQ2L6Iuf1nO9M2C5D1nzFbGtrER40V5IeRyYiGylgc725ZcVnp551Sg4WJzEJGMeUxLTiGS5SAo4g7azmrv1D7k19uIeTtLGqPoEQbhEW6hHndVxzK9XjNWjLG44RbBYFJ+uB24aebN1pqkNPr83M3zvXO4hkfHvE7H168WeXebQrrphaByMiqpqk/4CqxJVN/v4DN6dM1iaw=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(376002)(136003)(39860400002)(346002)(230922051799003)(1800799009)(451199024)(186009)(82310400011)(40470700004)(36840700001)(46966006)(2616005)(40460700003)(36756003)(86362001)(356005)(40480700001)(7636003)(82740400003)(36860700001)(16526019)(26005)(4744005)(2906002)(426003)(336012)(6666004)(478600001)(47076005)(83380400001)(8936002)(4326008)(5660300002)(8676002)(41300700001)(70206006)(54906003)(6916009)(316002)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 14:42:44.5784
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef323bfb-c31e-46be-dab1-08dbbdd5adec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7531
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Chen Ni <nichen@iscas.ac.cn> writes:

> Because of the potential failure of the vzalloc(), the hw->hw_info.trace
> could be NULL.
> Therefore, we need to check it and return -ENOMEM in order to transfer
> the error.
>
> Fixes: b6ba737d0b29 ("fjes: ethtool -w and -W support for fjes driver")
> Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
> ---
>  drivers/net/fjes/fjes_hw.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/net/fjes/fjes_hw.c b/drivers/net/fjes/fjes_hw.c
> index 704e949484d0..3a06a3cf021d 100644
> --- a/drivers/net/fjes/fjes_hw.c
> +++ b/drivers/net/fjes/fjes_hw.c
> @@ -330,6 +330,9 @@ int fjes_hw_init(struct fjes_hw *hw)
>  	ret = fjes_hw_setup(hw);
>  
>  	hw->hw_info.trace = vzalloc(FJES_DEBUG_BUFFER_SIZE);
> +	if (!hw->hw_info.trace)
> +		return -ENOMEM;
> +

I'm not sure, but shouldn't this call fjes_hw_cleanup() to mirror the
setup() above? Also only if ret=0 I suppose.

>  	hw->hw_info.trace_size = FJES_DEBUG_BUFFER_SIZE;
>  
>  	return ret;

