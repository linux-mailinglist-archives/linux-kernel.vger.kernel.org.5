Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF3F5790225
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 20:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbjIASkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231890AbjIASkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 14:40:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2043.outbound.protection.outlook.com [40.107.244.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA2C0CD8;
        Fri,  1 Sep 2023 11:40:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A+3N6xryE7ezi/gFtA6INzeQegVhb0Zqi9sOl95+NoqtgHWLFkCeBZ7Vj8IveYI5kRY0w9P/jEXdCUUcFSdbVd0JWbLPseMw19SsTch/g6yuEyi8mlgvxBkycP2UsUueCnkeXTRXoF9tAGcjE8H/rP7Gksfrrh7Tlo5108TkyYC1ygkVy3BO2E7QNox6vM+LJgXnPxtoVdIYkOtd1o423jqKVRqeBAZEkAstAPRB7zzpUaoRTk9Ivm5fr6XkrB3UL+BOCGRgF/3cIKOwkCFE6pesCoyQkz9OYc/vEY55XXFvRACG3EGDr0SC3n/pwxK1Jesf4VIaGtaf4IVgjW/3jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7Gpjr29+yBVsKSmKjYA1YBQILtopQQnHonYEZIU4J+s=;
 b=HPZ5IH+mx/bkfhcn73cdAVKYyPt1RA0Cvo1Oea4DQEA/ukoctM3RsNku8HcRyl2HUANkjkzuHvjZGMmihj9rn0/pNYIIpLmfYQjzU1d4n9q+4EjD6Ka26D0WCvkvc9wmy44TKkNdEHiDroZW0mI55YKxp518xeT1y70NwoqkYPbXVgLj9TxVD4hWmRAmg7KxRtVwRxuYuUfEYeGj5S2reRAJczG5oTw3y856TsjZ6/Ha06u9d/Av5t00YqsCPxkikDuWh1EIX9yzznHYjeTLdthzNmFC+PS14N4wMFRMyyg33f6nHe5mFp5oivH8gfYChSvXsDdluvGS0LYXfymSUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7Gpjr29+yBVsKSmKjYA1YBQILtopQQnHonYEZIU4J+s=;
 b=F0rUI5xiLJep7TbSxONmzW9nWE+a70B9uQ+CAZfOwgq2TtnabznramrxlxDpvvjLekrQhbpkrS7na50WAZcI6nJVjmD62BAaWUlvBlwDvzsue5DvZWzUjS1FZTlH1YOGEO1bTo5zhYNuqaQ3d//Y2/Yq4zok8LVm0xTikxafl9spYyW8TCBKNf5LsdmsNThg8do1FcYcZsCL03GIJW1LPxdPqKHOoflUwGBPgDn/CQF519U8qsHIs3liih8M/KhLY0Jnec5JlTFIS7Qxxj6drxRx5pi2phrxax818oAdxgEvgBMuLfietxmLl4ku4ogAT22MuuGeV+TXTHQNPbF3Xw==
Received: from DS7P222CA0014.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::34) by
 LV3PR12MB9096.namprd12.prod.outlook.com (2603:10b6:408:198::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.23; Fri, 1 Sep
 2023 18:40:07 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:2e:cafe::a0) by DS7P222CA0014.outlook.office365.com
 (2603:10b6:8:2e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.26 via Frontend
 Transport; Fri, 1 Sep 2023 18:40:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.20 via Frontend Transport; Fri, 1 Sep 2023 18:40:07 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 1 Sep 2023
 11:39:56 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 1 Sep 2023 11:39:56 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 1 Sep 2023 11:39:56 -0700
From:   Jon Hunter <jonathanh@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <patches@lists.linux.dev>, <linux-kernel@vger.kernel.org>,
        <torvalds@linux-foundation.org>, <akpm@linux-foundation.org>,
        <linux@roeck-us.net>, <shuah@kernel.org>, <patches@kernelci.org>,
        <lkft-triage@lists.linaro.org>, <pavel@denx.de>,
        <jonathanh@nvidia.com>, <f.fainelli@gmail.com>,
        <sudipm.mukherjee@gmail.com>, <srw@sladewatkins.net>,
        <rwarsow@gmx.de>, <conor@kernel.org>,
        <linux-tegra@vger.kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH 5.4 0/3] 5.4.256-rc1 review
In-Reply-To: <20230831110828.874071888@linuxfoundation.org>
References: <20230831110828.874071888@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <4388e8cb-2ecb-4667-ad7a-0d79eb381c2f@drhqmail203.nvidia.com>
Date:   Fri, 1 Sep 2023 11:39:56 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|LV3PR12MB9096:EE_
X-MS-Office365-Filtering-Correlation-Id: 69223100-08e0-46a5-7667-08dbab1add55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Ux+7y70gpteVY6v086OQialvByBXoLFGC/r364embLkSV3TS+9xJxhW9jJkqbdoOnbna+gBwAp0uyRMH/BdjV7R91kyhjiz3tO8hc0oxwYzneoBNY5082At9Tkr17V5jUzqp53A7Dw8Rzc7syk3CnnhW3cNkLWEJtfkiGMhpUp2YdxtdtkZXAV/atYxe/b4P0YO+gyFV91Xw+CrjpFrWdam3qStVuex3Qp00aJ+HfkuVYruR47Ii06/mi6BC+FxzDbJnQeFlI+2RYAZY7PmMUxyO9310OAJz4U/14uXGKafB1LLfTxAX1M5XFYmb9PZh59tlFozy39E9S5vFc+i0BCLzxFIOVNrx1NEMdfRplePwbk8+ohcWa2KZ/eHvixFPx1p9GD+m1wNjG3Aez432tnNUaP4tqdUe0ZddrMcIPo7UPmWJhPA5fw8YpM41T+kH7KXWYnsL5M5nyfwsYEK5eRDenL/x7Iiv5XbdtL0UJT1dERmaXuDBZaAD+9hMYncZmsUD4kkaG4n3bK8eW7wch1cMcJrTYMQQjE2+lOkBsLM9jbziiq5NpZFShI0up9JTUPY5WdWU3QE5uzgW2110vB3LnuF9uoAKFxewyxLsuwEGsicNRPbvtua5XvIOHgFDiq2er1upoH2PQ9J6rbANEjbh9Flp9xA8Guu1sQErhrmMOmIqDGnBOEFrEENF/WwGj53PvW1DF98HBORDdNzgKGvYWBb3R9tU3tKOqiwkXfSsB/8GEBr8nn5dZJ7KmMGTLzXXxKaAVavJeZy8T5kTb+smaZRktSfG8taU9m4vVvQ=
X-Forefront-Antispam-Report: CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(186009)(1800799009)(82310400011)(451199024)(40470700004)(36840700001)(46966006)(41300700001)(40460700003)(316002)(7416002)(2906002)(82740400003)(426003)(26005)(336012)(356005)(40480700001)(5660300002)(7636003)(8936002)(8676002)(4326008)(6916009)(47076005)(36860700001)(966005)(478600001)(31696002)(86362001)(31686004)(70586007)(70206006)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:40:07.2515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 69223100-08e0-46a5-7667-08dbab1add55
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9096
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 13:09:54 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.256 release.
> There are 3 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat, 02 Sep 2023 11:08:22 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.256-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v5.4:
    10 builds:	10 pass, 0 fail
    26 boots:	26 pass, 0 fail
    59 tests:	59 pass, 0 fail

Linux version:	5.4.256-rc1-gdace6640c652
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
