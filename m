Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 957237F3685
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234236AbjKUSwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbjKUSwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:52:41 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2073.outbound.protection.outlook.com [40.107.244.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB74DB9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 10:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UosOhunnEBsL8omriu5o2UT8wl2TVmfIk65vk5vZZLZWg5/RwYuInq9UxEIB8J5BcDDfpPwwUAIw/JvjDIAqLsZ/BZD2sglMNPzkNSugbNN9bVwDsxQiePH1MNmTIsaIpJaSgbDHjf5KkfQgT+Ws72kJXtEaUYIixrtqCdg+v4VySYB168KkHc5cDO1DyBl2JJ+blNtTnZaJgwPRauZdY042pUv9MRY/tgZbBj33GoxhMv5xDdWXRaf5VSwMn25STMzNH+42AvDfF+ORi0HCgOH6E40aSPl7hZtF1nmHv25z0BkmLWW3kOLq29utpiRmvj5Zadc83Zh2B44joFTILA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=23xIg7dLtNcZmUMLopm4+LU3pFjmnJR9AT2GcFOWrfg=;
 b=YgH2sZju7NfKNM5cq8RAV+YwF148RovM0laeYp0Te/nqmW9GDU9VV18xQY6sBCPQlRY+1VKrqGQag49eei5rAvijUebW/UCabvrl9tvhSglRrBhZxcRAU+5XsXem8Dvtj1nyRQZ9uMEexQlAEwunSx9mV23/nif34GjWYxTqycD3iFdbtWsm5b9PsH4y9I1QErjk4TVgvDo7bxqN4ag5KjP5ocLIZP6XX0d087wEHsj5aiQmcX+TDNvmi+menQ1SQFdsd2ehpBLfItcy2byauEwOwtI9HwrAnunBQpOrBq3m6lLtvgTjQlPUdKPt+smHrr38nuoX/14EVOZlzbmMLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=23xIg7dLtNcZmUMLopm4+LU3pFjmnJR9AT2GcFOWrfg=;
 b=BneQCk7OQkP68TZFaC6kHkxvKVqIWoIUoR/2Vhl42QcUUFuTuInr691lMk8Jyxx9Ckq2II7hiZOAUe8bDJl2ph8qMf0RTI2mvQiKN9qPWW1U/lBqdw5loQEuvDwOcz7PjyJk5ujmsAWl8eI7P8/w0QuoMbzlPW0U7DIb5L2rMiO41uK371l2lvJe45F+Za+Wcic55DJ1jM//jCY7bxKmSfVXkBNolcP4sYC9OAYOWcplOMT+97zi/ksHu/FXmQaN75Qdxqi/sjkUdup6GXfBrzKvM0b9PJVJkWuEJAC8ItgMQ5Q9xUPdAUiL/X37h/0zLl2078FnUnI/kd8SEJXRiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8368.namprd12.prod.outlook.com (2603:10b6:8:fe::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 18:52:34 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Tue, 21 Nov 2023
 18:52:34 +0000
Date:   Tue, 21 Nov 2023 14:52:32 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     joro@8bytes.org, will@kernel.org, iommu@lists.linux.dev,
        baolu.lu@linux.intel.com, linux-kernel@vger.kernel.org,
        jsnitsel@redhat.com
Subject: Re: [PATCH v6 3/7] iommu: Validate that devices match domains
Message-ID: <20231121185232.GI6083@nvidia.com>
References: <cover.1700589539.git.robin.murphy@arm.com>
 <097c6f30480e4efe12195d00ba0e84ea4837fb4c.1700589539.git.robin.murphy@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <097c6f30480e4efe12195d00ba0e84ea4837fb4c.1700589539.git.robin.murphy@arm.com>
X-ClientProxiedBy: SA1P222CA0119.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:3c5::18) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8368:EE_
X-MS-Office365-Filtering-Correlation-Id: 2087bb5d-c438-4556-2d36-08dbeac305d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: G01uGirUKoBmTFngwELbFichmgu2AVfDpN0gwsW91xXwb/TcOXwnc2cZwe4I8uKpqvxoEhtkz4GuQjH+Dkct60y5G5l4BU+DnJmCSZ84EGbOe087Mbj1zj1iciKd3lf6wdOwSN4+h4aftwa+6pOBkGr/HKgmjYW5PRgmSJV5AsuPUG6nxDAy6qDaO3FLN1eziNmZAkFurVshQ18soawJWHAyJvArM0ch1ockCCIptrx7kHSlYC73Up0eMj5U0EFbvMwrkTckbnz1k6MaosBo+5y0p7SbUeuY9Il0AiG9UvX0uquvwC7uM90lO24J6ZJIOIjjgLddFly5EDSOxh+1LsRdo44Xk5O5CzasZctS71UH4Db4ZXXt1D35Q7MhqgEUcg+7z1AP9+8lLe8yf4eDAFCXH0bbrNZ9voFrZ4SsA4vytr8vXRi7AqE+52WsVNip9grPo6C+xRAXUGIJiGiEdfZcq7GKNFeD6C2bQmr0PBxbXuWkAkjg5b1BxRVdO3aiYc6/tXr/SYwXEfq/UthRzorWONHJ7jmfGYU9snBJUO7GnwH1H6cQRLjZfe5eS3/8
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(39860400002)(396003)(136003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(38100700002)(66476007)(6916009)(316002)(2906002)(5660300002)(8676002)(41300700001)(8936002)(478600001)(66946007)(66556008)(4326008)(6512007)(1076003)(6486002)(26005)(2616005)(86362001)(6506007)(33656002)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cED4UDMIR9w88RvdiukQzTQDIet4viiwtT/RjZeGxcRZVdF71LuwolMqHah8?=
 =?us-ascii?Q?YltaO3RTrkTxCBbRIVWMH4Oo8mIir6Iba0oyUEarUwe1/nyEELLYAVqKNdCM?=
 =?us-ascii?Q?+tAJ3JRtHocKn4mLG/EHpS9iQjOBQTrYn1nNr5HvfAnCzW+DY+Zv+m7Y7YpR?=
 =?us-ascii?Q?vJlyCY3tiz8kunMGeOC7PSKealNQZlF1ag9adi2X3g1LwrFXQ9KxFqe7SHPY?=
 =?us-ascii?Q?sJVWkmv5YUHLp+VpfgmzU8Q9fyXLx4gqJSLSwpcSsy7zSv7HScBp+DJZ+vHV?=
 =?us-ascii?Q?XGUHZWhj0oqE1h4GQYZpsw/ZzE+jlHf2Jsr7nxI1xyNk/kg9ZVrlwQSOFmda?=
 =?us-ascii?Q?XZy68ql0/QDFTs2OGiysz3JVdXEnT33bs2YGspDDb0nHJ0SbS/8C9HOE1+J7?=
 =?us-ascii?Q?hJqnDHrRCUHffPlZ/R3O6U2IbTY/ukPj5wEVBW2oXUx7BcOFetxr55+TwX7d?=
 =?us-ascii?Q?0Z0mrv8I+vXM+b71DfjleXDBrJ+8aL5Cq4VfJBcZ5RC+3TIhLuo1623yWh9U?=
 =?us-ascii?Q?82CH+GgvhtuhYHgAGHQJrjk+Xv8jg/uNdttIfUWJ9m+18cx5Dr908UU3SW/P?=
 =?us-ascii?Q?t0mN5NVC4XSh1Eti504FkRYgafhQIrqbm792IfAOsgQs1MabUOr9di02q+NN?=
 =?us-ascii?Q?ZV3VTC8fQnY5+OQ5Q+EFY8dx1nhd648MEQNZ9LXyivUhqj3P/kwAlGHfqCfk?=
 =?us-ascii?Q?PTCaJBy1Jv7q5vDIHPdsRA7rtgmv/F1nB37sn6I9VXsGWX5AuIzB4xTU/LJZ?=
 =?us-ascii?Q?R+hLkx4naCL0TYxg+4po4evEgKtN78bpwPlBQ6IrPN+xaLSqcKASnwOIwA7o?=
 =?us-ascii?Q?QXppmHUwQ0NiNwnc+KXadfErYSKTdRMylkJvtKbd26py68r46geRb4Mo9xom?=
 =?us-ascii?Q?ttaVJ0qgnQ8G+HuKwmmunl9ikiBLIb3uFVb/InOT6z8jE93u8kZ0/jHE0pXD?=
 =?us-ascii?Q?Am0Ik8L7vKBN4otQdU1RzGY+2eORFzXBQPrF7GTmkeh8+B/A/80lHErmdF8h?=
 =?us-ascii?Q?hfS3OH3D9Y+FNHTeqA/9GIVIRqdn54jkSubvBODA0pRSPKMdYP4zuCOIp4fp?=
 =?us-ascii?Q?XzrrKGBO4UyQJ2Tu8bVy8LBkTPypgBc6cpGM12PD96iuoS9XYyK1jn7l0Jcc?=
 =?us-ascii?Q?JSRh5t/S8wKfDN977KjpMwtbfrE7gKkVER//d+YmycRLLJbBEix+E4U1Kf3k?=
 =?us-ascii?Q?XEvtwe/CzbKVlwLlg95bMDwxK0+bnnH6jv8jaVhAR3ovZGsrFf7QqixFl1WQ?=
 =?us-ascii?Q?AsnFvuFRbRvJLpLksOrPOTz6Kwiu20lTZpUBpZTv5nO6JaYDxQVB8zSuML+K?=
 =?us-ascii?Q?Mi2m0oDwDb71xtpQmoDJob7YUqVZshziC1wC8JhEoH3IVaMQ2TCnjXzbT5d2?=
 =?us-ascii?Q?l0KUykHI/clnM7MDSzFPq7J1XB9Cp2/d5T+Nn5BTF/gevJtc/1pjot7Hpvst?=
 =?us-ascii?Q?Hpm5AonQrWlw2sL76Fc8tNtrnVnxjN8GGNQvVOa+gn/Sww4ohlnUE5Bh7G4p?=
 =?us-ascii?Q?n4lhEtUOmpTvtPzkaRS61E7PLMBe2YutOts2gXuCepjRPUr5DNJlGGmwHTOP?=
 =?us-ascii?Q?nRHAD6p4B/KQYCIuR9pBn7Bq5zDWxd15Cc/S+SLD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2087bb5d-c438-4556-2d36-08dbeac305d4
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2023 18:52:34.1457
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZT60stN3JYEmujBprLfCJJeF3RwvKGC5A7W4aBflXHPsXS18+jGwbjT26+ogdTGV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8368
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 06:03:59PM +0000, Robin Murphy wrote:
> Before we can allow drivers to coexist, we need to make sure that one
> driver's domain ops can't misinterpret another driver's dev_iommu_priv
> data. To that end, add a token to the domain so we can remember how it
> was allocated - for now this may as well be the device ops, since they
> still correlate 1:1 with drivers. We can trust ourselves for internal
> default domain attachment, so add checks to cover all the public attach
> interfaces.
> 
> Reviewed-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
> Reviewed-by: Jerry Snitselaar <jsnitsel@redhat.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> 
> ---
> 
> v4: Cover iommu_attach_device_pasid() as well, and improve robustness
>     against theoretical attempts to attach a noiommu group.
> v6: Cover new iommu_domain_alloc_user() sites as well. I don't entirely
>     dislike the idea of tying this into the domain ops, but I'd rather
>     do the simple thing for now and revisit that in future, since domain
>     ops also deserve some other cleanup.

Looks good

Jason
