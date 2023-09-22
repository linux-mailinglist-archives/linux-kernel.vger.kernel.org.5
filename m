Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65537AAEA7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 11:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233075AbjIVJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232885AbjIVJqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 05:46:42 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2056.outbound.protection.outlook.com [40.107.244.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80882CE;
        Fri, 22 Sep 2023 02:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ATle1Bv5TX45s2gSmDBlgLqaYDGP/ts6n4uvO3GHI3S2kDErjo9Ygj0xpflfgpM5NarZ7BOPH6Q1QkglYqJ+wAJLPNouVyFxMwm2GanN8PtnngCCGcE/BeM3In3ZX9H0gNmilAnUBo+LOnbv1EmyRhuVnk+cDtOkI2REEVvYBU51t+dyDzvWZNLhP3PjPXroGemUlrce2xNfeHZuYcYiTFw08Md/0xk0hMWfB2uE1kNskr0T6QE3j7rt9BzGeXsO6I/Li75jiS7LWyx21vuIK3EKRFF1wO5+5JnVr1xvdNjxUI0aouikT7TeR7Tp6bjcVqDcLJyfHs6j01iAWrIaSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MGeU/czDczWxhLA0FbMy6UaqOt8NdjwX3SnxTIV6T3U=;
 b=fEXFhivBkC3Wuve/FQzqBMkE2QT7OcTlElsPw4be3FMi64OXHjpvu/TUmXkTOOi6HL3qBKRLW/133POaIjXABurBnFEShZImzg1l2P8xi4jxBWoKnsrOe3i0x49nw0JqMjNap9RRKvPY+82otaEmZEYKj4hUUVSJASFVRQPbS/UUDFpuwYYTlIig1WVbVH+yG2L2+a7KjyMPzPKle7zIX4Rtqk+XRG9wGiOh8ac/u6bULxIbZznhJGMZ+jq28s7uYqV/ERc1rrN9tvafYcHcLzXqkYPN8YaeM+Ow5CYMsy3Z1sIhX5NhjFqawYvvUj6WacRcI5jYp4zIHMZNLgnGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MGeU/czDczWxhLA0FbMy6UaqOt8NdjwX3SnxTIV6T3U=;
 b=X13Ac+iyqlYSjtrK8AtHTTlIz7HzSqQli1mX9clJPIuX8wGsUWhrcUZ9dBw3cP26YvWknuSibZKnKtaG2dvsfo9vjYlKSXQQa/5zBpCav+SaJhtl79/RGH3YwZPkkcsnaK2uVho9s+qQHr3WTjM7tj/saaXdwcvYyMb6OTmhXAblTfj7PWg687aYHvE4zOrapEVgstcAscaFlFLPRdrd8hvi6aujfdMBqJImQhNpoxM0Mko11qePvd4SH1BMGqDF+D0fPx1GZBrT+K719oxkBbqYdmg8DmOscl8EHHVUBFGY4H3o05cC0idn0HaMf7Xs5njVtV0Wggqg6CVTeLnxrg==
Received: from CH0P223CA0004.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::14)
 by SN7PR12MB8771.namprd12.prod.outlook.com (2603:10b6:806:32a::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.20; Fri, 22 Sep
 2023 09:46:34 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::26) by CH0P223CA0004.outlook.office365.com
 (2603:10b6:610:116::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.34 via Frontend
 Transport; Fri, 22 Sep 2023 09:46:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6792.19 via Frontend Transport; Fri, 22 Sep 2023 09:46:33 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:46:17 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Fri, 22 Sep
 2023 02:46:16 -0700
Received: from jonathanh-vm-01.nvidia.com (10.127.8.9) by mail.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41 via Frontend
 Transport; Fri, 22 Sep 2023 02:46:16 -0700
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
Subject: Re: [PATCH 4.14 000/186] 4.14.326-rc1 review
In-Reply-To: <20230920112836.799946261@linuxfoundation.org>
References: <20230920112836.799946261@linuxfoundation.org>
X-NVConfidentiality: public
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
Message-ID: <f78f779d-39a7-491c-a2ab-8d1157fa00cb@rnnvmail203.nvidia.com>
Date:   Fri, 22 Sep 2023 02:46:16 -0700
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|SN7PR12MB8771:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d865f68-31cb-4a48-c37f-08dbbb50ce59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2X+UW8/iUWH9sEyKWoySLskdcXWZNd/q5KKr3zS3HU5XZfNAf7zF4ghJIiArY8qWHNat4t2dY1Bzv+3qC+YD0y1ItEJHJATFyKynTgCC25qfTwkqAre/2hBfBLKHyzP9ZEZFzWbmsS2jiSwfbj1UtWgL0J0cjbrmedcJkdOCVk+i6TOkCh8R1usX1qF8RjvuNkbfNOOdWDzZyUYy9eFbH8eNGdxAOD6USs7w+rywejm6lxwWp39dcON8qOa/lBOmJcH3Hj7qSaiWA4U4L6j0OpqINbCuAnnEHHRyYGHugYmCYqQfKCnk/koJpsLLUi9wL5HzsJwDd+oRmd9GvAgRTao7dz2stTLmiBa1aTiLEy3PCBUGDVIR4NP9KHRYGz1Zdp9y0DfHZSzYN81j6KFNgIBP2fApxTiVqCTQlFhBx37awH8qPL4edxpVQSuIwJW8u1BPRPpBbnQuS+D4ll/gdNApJEd/uL5Dk3JewKSeYPv6PkPQ+9NaSluacJ0J3Bto/NDfI5wT3x7VuKaUNWLQQZDpNmjR64WqrVkCSVqGXQPa1ELoHcJJYkscCCJlpF/QtsWKColZIQT5BRUiIiULTqfcZIa5+hSjho7rxYIlzX8hRpCNIAxd3fg5GbinNnfOdr6nALVhMsU818j1v88fUr1cTcT1odsFOFTzqw+oeY+YP40QSkBlc7kp3GBTawqW6+fAeCYBWmpnumjB7lR0iYrcAEkw1i1waDB6jJxqHM2sfFMUR9vB1Re5qqEtsp17GOrry404r13WmQteyFGdRk4ooKT4vhw+Gd/MArA9w3VLSrBvVNSNcwWU2sZe8DNa
X-Forefront-Antispam-Report: CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(39860400002)(376002)(136003)(186009)(1800799009)(230921699003)(451199024)(82310400011)(40470700004)(36840700001)(46966006)(70586007)(316002)(47076005)(41300700001)(6916009)(7416002)(36860700001)(86362001)(31696002)(5660300002)(8676002)(4326008)(8936002)(70206006)(54906003)(31686004)(2906002)(478600001)(26005)(40480700001)(40460700003)(426003)(336012)(966005)(356005)(82740400003)(7636003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Sep 2023 09:46:33.5261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d865f68-31cb-4a48-c37f-08dbbb50ce59
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8771
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sep 2023 13:28:23 +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.326 release.
> There are 186 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 22 Sep 2023 11:28:09 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.14.326-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.14.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

All tests passing for Tegra ...

Test results for stable-v4.14:
    11 builds:	11 pass, 0 fail
    16 boots:	16 pass, 0 fail
    32 tests:	32 pass, 0 fail

Linux version:	4.14.326-rc1-gdb587d473a47
Boards tested:	tegra124-jetson-tk1, tegra20-ventana,
                tegra210-p2371-2180, tegra30-cardhu-a04

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Jon
