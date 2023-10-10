Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC5457BF803
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 11:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjJJJ5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 05:57:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjJJJ5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 05:57:34 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2083.outbound.protection.outlook.com [40.107.220.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C5AAF;
        Tue, 10 Oct 2023 02:57:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D5f4OfD5EKFDnVoaK9LWhQCcJwRcfFtebOiSc7Uv3DfPZei0kA5ilYxBj8Umeu+yPTZ/MuGYYQbdQsrx8svlilqCfgbyklXrZCR6AtwSamKsci1yO1yF93VZjCnEG49hm1U9xCYZqHDWol6MBKnKU/laJQP0JHlk6IkYWZ55XK3BSDCkO1hidZokGrgGLX+LCmfC06OvMz2MxXXrjnN7PUq0jha95iPrn5M7+hHMIiW8RH21rc+bqo6k2d533Oo1gXMIpb/aQkek6UZFVFh9uqEXBpCGxWti5sE3TQRURxK+MYBkqrbIVVzfNW3iZE5pF9YrJ1r/uKiFPLtm/wz2rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PtiitAn9nN4jvj+ztEamghIzZgWZVxEMU2r6TMg2Yg=;
 b=IiQqNruv6XzkgON2oohyvwP43lK6kgt1AyYGMOSyFi/5/5QT7v841F3U5Ta8b4DWA9NgXwrnkRaJx/YDWQ3pFWmd9gTM10Mp00mGt5G622S7UDqp17Au8VGT7KE0z3aU0ie2VeCAQzjxkO71dmWkICQ/LVo7tSs1v/wcmg8P1GFDvFIHM10TZ2wudj+5Y/mgr5YO8lTZHEKCyawJwAw7l2iVmTosd9zlkkYWHNlCGk5N0cyYc+WiCaeU2bwaqf4z9gVvmW2fQlKxN6MkPGqL208m8b9VZ3CrMsn+nln5U1tKTS/3VMB21cj4OEjT93h2OzaViGd8Yq70wms3fESztQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+PtiitAn9nN4jvj+ztEamghIzZgWZVxEMU2r6TMg2Yg=;
 b=YcUe3+LGmZxRQR/KOwLEz+Nlh3sebgXsyMOEQxZiZ6Q/jM50qYIYUvDD+Jh5YkFp8/5xAs0zC1bKim1wJLjqEAUlQasfSER6RQJsu7X4s9knI/7sgp+UmHpYGpmBmK8EKyWma1ZDkYRjjAdiyU4DiY74duRgJep3VSXfzHNwfcsJNTOddeyT6VlKsFHsgKDO+UDnXHKwVr61u8n+InIsEMgjB3wNofqRe1NLBM3/u58bd+RsuC48z6qlz39Lkz+r07DlbeeE82TVe1KIcLdAXOeY9zPrOJoLKfgG0Y9ko+jF2XExPZRntqf6LG58s7fkqPWocrIHSDVgyYHOxdJlWA==
Received: from BL1P223CA0030.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::35)
 by IA0PR12MB7749.namprd12.prod.outlook.com (2603:10b6:208:432::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.41; Tue, 10 Oct
 2023 09:57:24 +0000
Received: from BL02EPF0001A0FB.namprd03.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a1) by BL1P223CA0030.outlook.office365.com
 (2603:10b6:208:2c4::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.37 via Frontend
 Transport; Tue, 10 Oct 2023 09:57:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A0FB.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6838.22 via Frontend Transport; Tue, 10 Oct 2023 09:57:24 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:10 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 10 Oct
 2023 02:57:10 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Tue, 10 Oct 2023 02:57:09 -0700
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
Subject: Re: [PATCH 5.4 000/131] 5.4.258-rc1 review
In-Reply-To: <20231009130116.329529591@linuxfoundation.org>
References: <20231009130116.329529591@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <7da7ff71-030f-44a7-8a0b-19f2998b8a55@rnnvmail202.nvidia.com>
Date:   Tue, 10 Oct 2023 02:57:09 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FB:EE_|IA0PR12MB7749:EE_
X-MS-Office365-Filtering-Correlation-Id: be043fb2-5c0a-47cb-fbc7-08dbc9774d8e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nrrG1dqTwz1ubosGbxFCkU2tPtgyBF5Kx7iQKOpjwPlQGCPIzEM0sp+8nPXQ5ENqu5BEZw6RR/MdZeveXwNJXwAruxCDn5tPJZRxMnM4mqyjzOLNVsOCxl9cFUNaOhbe5xZwE/LEZWrJALDozkGLyIs/8BTjhbYCB54PfxE2kLJgC0ftqXSGhHvipAc+B0zGd5kJRHvMQHLkPItVNqAC89D4pS9s6u3dNTBJNFTgb0iiRox8BY6SPZ6y1LAtq5ypgxwXUyT1nS8VqHQ5w6JSYC7a3yFKNlpwqgYWQ+FMa5YHyn72F6xuXPd27RrX3F/ucQdgYMnGyrJ2YmqxBwoLgcNRLhUVjN/DEjn0zHZEJdiuGl3siAc0klK2rHsi5ykXCOJ5IJlXLrFAUHTY0KPjl5RBiR278xAWq9RMAcK9WXYPZN+vyHFIMKvaPJiBj3sB+DzDOOu6Xvt/b+TNIvgFx5RoI9mc+6zrr0habtE+4lH3/Of+Uezi2A5w4bBs7Hu92YPZH+6RenVtT+V9cbAVWPLUWcV+ZEzNPgI6V8iMJB7vrnfZ38Y6MvPRipI39YwJLX7Xcn+3XDfXcpboV9HERtVJ8Ry4/32dwBZx80/OlGvUElHXl462CX3+hptzbLqxuz5bg4AJ0sfYaxAliafsZydOrMldcaptt3HKM88OP6+PJktAUauRLsH0DZIwSM+EmIlhpB41swqCmMfD6J6JAIz1a3nbdWlfr01Y7WC28umpU0TtDnye++Hg6FT53ULKgWw5xgkDvEmresQOHqP65YpMfoOy/5INBEEpkXTT1o8=
X-Forefront-Antispam-Report: CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(64100799003)(1800799009)(186009)(82310400011)(451199024)(36840700001)(46966006)(40470700004)(40460700003)(478600001)(966005)(47076005)(426003)(336012)(26005)(7416002)(2906002)(5660300002)(70586007)(54906003)(70206006)(4326008)(8676002)(8936002)(6916009)(41300700001)(316002)(356005)(82740400003)(7636003)(36860700001)(86362001)(40480700001)(31696002)(31686004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2023 09:57:24.0377
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be043fb2-5c0a-47cb-fbc7-08dbc9774d8e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7749
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Oct 2023 15:00:40 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.4.258 release.
> There are 131 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 11 Oct 2023 13:00:55 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.258-rc1.gz
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
    24 boots:	24 pass, 0 fail
    54 tests:	54 pass, 0 fail

Linux version:	5.4.258-rc1-g9209af362e00
Boards tested:	tegra124-jetson-tk1, tegra186-p2771-0000,
                tegra194-p2972-0000, tegra20-ventana,
                tegra210-p2371-2180, tegra210-p3450-0000,
                tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
