Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5E9C77E328
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245747AbjHPOAr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:00:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343526AbjHPOAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:00:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2059.outbound.protection.outlook.com [40.107.96.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACCD2727
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 07:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2YobW/SOD0+/PxC08siavtHifmsdy8TKOf23QodyNIFRrgaDzcyNhKfDufVtD1CPBh1SubS3KVZJ7tvkv9r1ei6wyKWCxgHFRYd2AgeSQG0HSL3vMpxITfPXNVcydT/EqwfaXwd2hH2Cc0k5Ugn3bMufzNQX2uBN36cm+mkNijKab7Lg1rChG84ECaR4+GxSTM1/x/beSWfYgYkJzogcCtVKzbIjyXwCLrnm9HtO84J0KVmWDiapqgZrSJaq20lYruT18NodYowfVSci6Y2UPLzTjXdgrMAckE2euY0vEdlHcLqYGXWX690DvhQJapEWvJLWEbt3m57qrQ/QV2/fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72NJmz+XB74FvVRRkdrQ8riTLnwKUXe6ZchF42+xFAQ=;
 b=BlvJf6SxbJmK6GCaVTaquplENTWr0j9osNRnDGt95+Oc5RP2YySY56JuS1v7kyPM6Qwzsqx5FygZ3liRav8lt2a6IS/d674dAx+ATBQFKRP9QYCiUDzuTS6c2fqfOU5BpdBFHR26//IEUkB3Xb4S5yjlRkhmxJo4ET6doSNL2lp0MioJbhNbZmaND4LiiiYRP55cu6Nq8qQGMgQGY+gnN8iKFcJtEtiKeUm5xMJsFRl4c53AuZz3++K3Tc0BunZ+DMnHohwVPeeaiJ1HrevYlCd+2p3lByJUoMR08Yp67hbbh6lZmLbwiSpse15lwO9D7odbFvqq5IKIYf4JcEu4sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72NJmz+XB74FvVRRkdrQ8riTLnwKUXe6ZchF42+xFAQ=;
 b=slZ1D9oqctUbA1DmEEvK8vh2Ns1a11q7UsFrlqUWlM7+OVv8ADIMDS/ItpZe1HcwioX54hN9MQzrXdcUHnG/XB1XzfvGpAMQAMeKPstBgSUNUTEBPPFeKYo/pgu4ZAPcgRmhWUn1JOdUlhwHE/ZqUiKs6y3lsdDptFZtnzL3+vlV/fNEWHE2IrVLIR1vTUGf0dILMOadGQZcz4ZUGFb20xYI4rR1UMwAtnts1GyB3vNAicHnYZmSCIaDUbyhJFOw/apTKRrHEHDCGMIipAVJPsUIPzcd+jWMW4Eiu9SqjgHTUXeFm4yKaWByQhXNbfJG6EbkSDqGyyvbEzo/Gsci3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8407.namprd12.prod.outlook.com (2603:10b6:208:3d9::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.29; Wed, 16 Aug
 2023 14:00:24 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6678.025; Wed, 16 Aug 2023
 14:00:24 +0000
Date:   Wed, 16 Aug 2023 11:00:20 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        will@kernel.org, jean-philippe@linaro.org, nicolinc@nvidia.com
Subject: Re: [PATCH v6 08/10] iommu/arm-smmu-v3: Update comment about STE
 liveness
Message-ID: <ZNzWdDbALA1HH47q@nvidia.com>
References: <20230816131925.2521220-1-mshavit@google.com>
 <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816211849.v6.8.I7a8beb615e2520ad395d96df94b9ab9708ee0d9c@changeid>
X-ClientProxiedBy: BY5PR13CA0001.namprd13.prod.outlook.com
 (2603:10b6:a03:180::14) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8407:EE_
X-MS-Office365-Filtering-Correlation-Id: 714fe536-06e4-4d2c-f661-08db9e6122ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lss5O/pGPg7p5T7Vt25ixMRkR+alrT5pVYsfdGN91xVl0s4TFONOG4gRGsyPpP2oya27RlXspWaOUj+zfIJcOaEJ7X+68k1p+juk4mH+NyC+Jj6C/PZDaTN90ip6FVenPYphxDG8QsZu4Nn59AOwV2U6e9ocQCkvvHtckI2Mds9UrVrOtULWBmw2zW9mZQCrZTGqNGuhny5ayr7rfDiQqzOodKovqYGMJ0+e/W8w5Aa7qEgswmiEAil2hCRxJKXJYgUo6b/GS1bRUyRxB59CvMreNhsK9ixX44qHlIcoPx1LjS5lV1QnSqlUrbTUG0Lo2uFu8gaam0avfVheY/EA5Eq3LgWgMw5zBDwLONwD45box2J9XPO3WERtcWmKCN4fQn1IoB7BNqz1dnir2McLJX3vYMcf6S93P86C/cNoyDvNllmCt2nQ39X/FNcfttRBS1PtS0spApoEuVRL1FtcJSYrMFKU5bds7wCWYatj+HPUdu56GUWVQObYUC3rsl50eXBDO8VRY4CEsYELOUwRUh3bPH16cK+d5oxEYdpyEz2TwtuObftf33uDLFiUVY1b
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(346002)(366004)(376002)(136003)(1800799009)(451199024)(186009)(316002)(6916009)(66946007)(66476007)(66556008)(41300700001)(5660300002)(38100700002)(8676002)(4326008)(8936002)(2906002)(15650500001)(4744005)(83380400001)(26005)(478600001)(86362001)(6512007)(107886003)(6506007)(36756003)(6666004)(2616005)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5jHBbAiLZ1T2ADoW5EY/CJZH16JiLkRt4UruzhRGH8v5yOpPdFlW3Ubbxt4j?=
 =?us-ascii?Q?mqzPpXDF60JMK7U+sf/ThFvOKH/t5CSS5xgxYnbMPG9w9+glUTf3nVENjyBz?=
 =?us-ascii?Q?Iex+3CmpG5szyiBrchUVcssFAytD8v7zGqaqkLSyr7x40CDptRyhaxYL9nKI?=
 =?us-ascii?Q?Kibn5UYDyn1KChGluOD1WiWnTCI7pFw02UY5z7QAGz24pj17rkELWQOdgSg5?=
 =?us-ascii?Q?ELbU0HPJCt4JJhGIX3nU0iyKKNSChzCEam+/ZVdfnrpuTV0aSoKLW8cnSGGb?=
 =?us-ascii?Q?qZ1uCl+7rZSjFuMJXC9ez9YdYnR+P11vATu0pfKm08wy3aF72YxvJ7GV3C3B?=
 =?us-ascii?Q?oEzepJcAg8MjckFzx2G8hUyBoNlnoQ80snnKCCqe8oqFutPKWGoaQ3Fj5ioC?=
 =?us-ascii?Q?xGPrSAWLl+q156obV1yiRrPqSAxshM9HtwM/WY1x9hypWOoVcA63tNTmcgCC?=
 =?us-ascii?Q?8kmW/0l/q2usY3mfn9FNpZ2CkoU5p/5LF4V8lyk9DL4a6IZT1jJ884JPpxMx?=
 =?us-ascii?Q?+22KNsxM06S7qXR3noU8vqSsOIDyslQR7L9gj+LYNe+84fg0WKYjr79Snabg?=
 =?us-ascii?Q?zB8Eh8A7sM6WtHL6FvGKAIaOXZcEwjNXyO3hQMcAY5oIgMIWEYNRk37U9dlH?=
 =?us-ascii?Q?yublQ9tf8z+WNCSM7ehaMSQobhVoxL2pNYgniG0wjpLz6aK6nKojxljAHfVR?=
 =?us-ascii?Q?lfrPmhB5H49V90MxL8oZE9BFKcSqxikIT7bgf6ycEiztL4bxL3nMR0eFoDmz?=
 =?us-ascii?Q?GQPBoTeAYrhMHSUGc6Ql5I3CyuWwNXUvwH9vLJYaHj14fU+7xdjdhr5YtriF?=
 =?us-ascii?Q?RPk3pdf6v+9Ui/uX7iWDlTZB1HQfigXJoyZGp3vkpStHYIC0rHIqWGg4Anjw?=
 =?us-ascii?Q?IZryOHCOXmgK+iOkRNWA0IZceSNedIVGFP7jx/o7ogqi/woKhMMY7nHatjG3?=
 =?us-ascii?Q?6LIkEq4jKZAhZ5EygRDM8Y5Ka0ao8JE++o9kgE7RBwi8SjmkBqECD9zIr5kx?=
 =?us-ascii?Q?AlZ9GS/zO1jFEAXf/pDT6ZGiLE+XrqrTbmVnIELN240aOgcDRMitYTg5NM6y?=
 =?us-ascii?Q?ey9Tk3aFAFHC7o7rmgUKVpBXqe24bgaXI+KJTvGpRy4qll2S2tyFS3Y1lLM4?=
 =?us-ascii?Q?Zar/tyaS8Tcb2fW3oQkVWalYYQuzfjcezoPSFsvx+MKcYN/KDRyEpulz3xgm?=
 =?us-ascii?Q?7cGrtd6HQ1uPIqxnzea0eSuxF+fiOVvAr0XfAnkFMmBvQj8P3kMbzoQmtelV?=
 =?us-ascii?Q?q2IUUfcMUvhklaWzOECH+VafHfOAek4DiUPL/Lo6xhKMT+cpbq+cwLQGbx43?=
 =?us-ascii?Q?bFm6sJ7d6iC9SMqeYiGv9aYURY80Eocyald4QKUXyA7W4FzgdzmRYA0VqyEx?=
 =?us-ascii?Q?gvMIIEoi9BlX+Oa2Ce3dx68gNXze5uC0O8TSY4+gxROqLqsfFGkfYOTZJuf+?=
 =?us-ascii?Q?h09oArVo8rugY2dtlWBUOczqJoUDvrBe6Otpn5BA+UMY/pMRJDFvdbJ/JT5w?=
 =?us-ascii?Q?WMh+BqLpTqbbWiJHp8lxeOa9DyP9k+htfBtAXMcXhGQA1wDt1PQ4wPDOZ3uW?=
 =?us-ascii?Q?VW6Ea6Xker3kxTIATdAasMOllO4Rqsq5S+RmdQEY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 714fe536-06e4-4d2c-f661-08db9e6122ed
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Aug 2023 14:00:23.9932
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QeyvAlfYyS+NXEfGz5hIRUK+2PtdxOkYR0BcLgdNAKOPO5Q8NC9gonhd3hu5zUyH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8407
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2023 at 09:18:48PM +0800, Michael Shavit wrote:
> Update the comment to reflect the fact that the STE is not always
> installed. arm_smmu_domain_finalise_s1 intentionnaly calls
> arm_smmu_write_ctx_desc while the STE is not installed.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
