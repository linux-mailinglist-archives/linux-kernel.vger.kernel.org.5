Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 226B9770903
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 21:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjHDT10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 15:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjHDT1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 15:27:23 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2075.outbound.protection.outlook.com [40.107.212.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F59E7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 12:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RevsPvuqKvIxwdOTcRPfiF70N7JLKg+51sd9WwuetsuJczHs0AQryHjJy3CG+cH0TQQukanVVWJ6f2uDnl6I4LYMvqppRhumAZDefvYZ0eO5NBBDqC67Tf76/mZf16K9skYqTb51CbeAXs8vo+wIAnOSgjvVlRXSPGxGgstxCtn8LdHC9kB6Wf02dTO3NkOSRNl/N0hzGYxGUpYLYeVmGEWXjaWXM3RcY0uz0zWISl/4z2iMvMfWxdtcOcxIZRAWzMIVA89bVleqvgfri+hnC+525fRgDwHC4jYCavnPMvmWugIZAivp9H59jse1B+2bOH4tEBANicd4NtX658FaOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uud7mlWPAT/2tZM6C+tGRL8gFNX/ii96HjMqpBrDJBg=;
 b=Hw7p3940c6phJ9UiH5Dtio2+HI4t4Wi1t9hLzxNUdGhPwqROYXB1nklGCLgJTq6OhaZBs1zaH0l0YhT0auqzTMeK997WCtrjjepWnN93EBp/14fDJL4EkbEwh4qKcKmeuvyNoWZ0w33GYGtNu0hyJwbT5iStYXbK9AJDaEx2J2MrUvKneVZ7CPXuwJA/xUsyw6r0LALmse8A/DpBZM4eHxxNTIz3maUP+XdhhI9y5HwVbVZQ1lzBYnjc95RU1C86+xIfzxBJ3T2wkFJmU6sE1sSRshdR3VZoc5sBuzXK5JzqmW52wnceGX0+E2ohYy0QAOgTqndsM2oZ9nuHpo1u/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uud7mlWPAT/2tZM6C+tGRL8gFNX/ii96HjMqpBrDJBg=;
 b=hTPftgjmkYqru4/g1SPwedbvQ6RLnw7WdU+R29HLzKHt2dXW0d17wZao2xeXaXk0uBWR6z3N97rXUcBTYT8T1sg7zWbeDCe7rbqQB4SnUk2+/3rupi5oEF9yx4wfQHWJZPuo3XkfsuFJLhjU37uOWPIKUH5P3UB2Vuz3xZ9NbqGCpi9p7BSNriIeCIlo9dwVC1veu4F+JJLdBA9ud0K3CEX/uodL93AE1SdDm7owRBmBCpoUbKwd/er2HziqgHZgiWMjDCzEtD7CW+ybB5t0D/O7eM/kQLQXIfegj+q5cAWwFdNiyBOuyO6LhnQuwPro3fEnlFqcpPVxXpsry5Hd0w==
Received: from DS7P222CA0013.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::22) by
 LV3PR12MB9440.namprd12.prod.outlook.com (2603:10b6:408:215::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.47; Fri, 4 Aug 2023 19:27:21 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:8:2e:cafe::65) by DS7P222CA0013.outlook.office365.com
 (2603:10b6:8:2e::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.21 via Frontend
 Transport; Fri, 4 Aug 2023 19:27:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6652.19 via Frontend Transport; Fri, 4 Aug 2023 19:27:21 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.5; Fri, 4 Aug 2023
 12:27:19 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.37; Fri, 4 Aug 2023 12:27:19 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.37 via Frontend
 Transport; Fri, 4 Aug 2023 12:27:18 -0700
Date:   Fri, 4 Aug 2023 12:27:17 -0700
From:   Nicolin Chen <nicolinc@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
CC:     <iommu@lists.linux.dev>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <will@kernel.org>,
        <robin.murphy@arm.com>, <jgg@nvidia.com>,
        <jean-philippe@linaro.org>
Subject: Re: [PATCH v4 3/8] iommu/arm-smmu-v3: Encapsulate ctx_desc_cfg init
 in alloc_cd_tables
Message-ID: <ZM1RFW7QyPLoDcDX@Asurada-Nvidia>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230803003234.v4.3.I875254464d044a8ce8b3a2ad6beb655a4a006456@changeid>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV3PR12MB9440:EE_
X-MS-Office365-Filtering-Correlation-Id: a0323eb9-3861-4fd0-120d-08db9520d2d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dt48cB/pAyRRnOxFBq88jHOQHJNxDRxVeoK+GcCe1Wj6RdMClApd6p5tHl9nu4bWFwYBVPu6OsTTaaNT1mDzIAyHyHYygerzXD+d/aymccflE8GVE8V1FJdPT0x2CBnjFcAChIBjvfP/9OWAwaZDOuq/ncyXEdKQ05NXcJCYv0RGEj3PiHDmEUHJHmcqyaaFU7RI4S9Oeg4RdhHuywEaaocwV6SfPX/3WIoY2Ue+12N8lX6TQrdMcUwlpMq4Lqcw41b8UEJVmTMLTICkt2QCQ5i/BnknQENbRULcnlZasbqpy/0RySd+JHv3Jww8WwcPoTdkkyEQrFIejrXPPykE85cX3c/MwsBxIvT4+0d40MSB9oDFKokaUSGj5iK8hY8d8GpBPUPC3uOTz5mRCWB9khWa1kaFVA0/ItCK8toYU/AfD2k3VS6Dxd+EqBkNtQErSWRMusY5kqVGZDNZHR/cc4dGa9PdyR29kPbR5UXFV/Vv6rhCt3l6K0RVNGplaL5Jbitsz6/gYWhg8UEb+W/+Hs7E8XSn/zfUVmjRs6nouEc6Xvug/wGO0G4q1RQfZz0JvJDGLi0MRYi2NsrGKXsl+fYRP0rXgeBWkJiZMRBjGij472OJUJmfTnIQ6yOPJ4ViA0BvOR4C2xUqF8nI3p6WfTTptT0MvBciQw8NDaDTQYkr5/UzNk5D8m6BcyheM9Yo5fzGiPevQYXKSEK7p7Kg8qTYdIbzywzFGVAp13Pq173EjLmsPj55cGKRNrwAil1w
X-Forefront-Antispam-Report: CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(136003)(376002)(396003)(451199021)(1800799003)(186006)(82310400008)(46966006)(40470700004)(36840700001)(40460700003)(426003)(336012)(26005)(47076005)(8676002)(36860700001)(2906002)(316002)(70206006)(70586007)(5660300002)(4326008)(6916009)(7636003)(41300700001)(8936002)(4744005)(9686003)(54906003)(478600001)(40480700001)(55016003)(356005)(33716001)(86362001)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Aug 2023 19:27:21.0987
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a0323eb9-3861-4fd0-120d-08db9520d2d8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9440
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 03, 2023 at 12:32:31AM +0800, Michael Shavit wrote:
> This is slighlty cleaner: arm_smmu_ctx_desc_cfg is initialized in a
> single function instead of having pieces set ahead-of time by its caller.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Reviewed-by: Nicolin Chen <nicolinc@nvidia.com>
