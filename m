Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1694A784130
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbjHVMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHVMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:49:40 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E531FCE6
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:49:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=faDhJjzSv8N7J1EdMSJsVJHR3aF/QOMPLL4Jiim+NzCESwfyC1TBBj8rMnCSggfqWFmQFaY0Z92oUFeqzJD3jzPSDWn8R5laI8rZF/DRwOCKx2MnM11AtbxDlCFqj+Xty8E6h5zHRkqH472knpomFLNrZ+umUUVC1esNUVjrupYCrw08gXYsraKv3p9P6KFGZF54ips+1YQV+ihW6Xm4v/0MHyIQQsAzhwN7kZcuwSngzvE0xdt82v9ih0V91OUhmya25Rs7jafUYhVL/Ea869BSEjd7w9te/ukNfNCDnJpObFQlzX15h7jr8jYdt5qVulbV0VnaCnCkzpliE2NwaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tXP+1CX2YXOjNpIHBx/SLOI1OAhFtDCz8IgFEQ+sqpo=;
 b=HHcJMwdWQbnc5COOAQOMg3cGJ1ZBmdXcLnWFwCh8CXVo1/P9E6XysUBWvI/rBCKO2aSLnQIrmrSxiGLw+E2L/C1AlMyCd7TBu8iUf6gBtRokZddjfzavcIoTSUhOnj/rObeYmHTGZ3HcAOw8Swx8nY+1r0gGnO1JAdsELAY8G0E6UD9SKu+hwihuSbAQTBh8SnLhtJiEuviOlXbGxjUocNXu+8Q6e1YFhIAq+v7JQG394cZ1qZQmdM/pJaB8WZvTurh8REpDYJQYpeCpdkxqziyeQz71XF0k1ZYRRak48oEjDLAxq2PHxju9HMhFeniZBGWnpignH5TWOnVbszSYKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tXP+1CX2YXOjNpIHBx/SLOI1OAhFtDCz8IgFEQ+sqpo=;
 b=hJZ/7eKWipGrV9MYj0yYXHQXcncTSrXD2rcYCFIM2WQ71Vy+EiqqeDrjbtzWhLbDwuIxou23cu+susYcdepAwKQNeBkXGe9hdCDns8+PDflofeVRYal8cxn0gQ+bAQO5iOFClg3HibODZzKMQ2vUEQBz5pu1a+L7U+lGR7V67conSWwrYRTZvxstC7uekBjAUkzm24AQjsEiij9fG64D7R0VvFzTDj/Z5tyttWypK8QVertDsGQ/e+3GN2kVYhTDjIeLvlvWWTPIii9ayj04iRxfLLsJPS5IjZ9Fz9jC7lKYZVmvwuQXOoQdRfd1L3Qrd1cCP7QnjWeJMX3Qdc8M/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH8PR12MB6890.namprd12.prod.outlook.com (2603:10b6:510:1ca::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Tue, 22 Aug
 2023 12:49:21 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Tue, 22 Aug 2023
 12:49:21 +0000
Date:   Tue, 22 Aug 2023 09:49:19 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org, will@kernel.org,
        robin.murphy@arm.com, Dawei Li <set_pte_at@outlook.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>
Subject: Re: [RFC PATCH v2 1/9] iommu/arm-smmu-v3: group attached devices by
 smmu
Message-ID: <ZOSuz+16JD5E0k3z@nvidia.com>
References: <20230822105738.1607365-1-mshavit@google.com>
 <20230822185632.RFC.v2.1.Ib87a2696f25414e0fc39cc22dc74e31a4415c2a1@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822185632.RFC.v2.1.Ib87a2696f25414e0fc39cc22dc74e31a4415c2a1@changeid>
X-ClientProxiedBy: BL1PR13CA0257.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH8PR12MB6890:EE_
X-MS-Office365-Filtering-Correlation-Id: 05061f68-e105-4b18-0171-08dba30e34ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8fACaFkMWGRvGDHEi41XzQQCWVuMtrgo5BpjQ/JSQLoypNv25soao5QEbFvgxBlCtW9mkq2KTAcBmGq6vi5Z27fi/qa3a+zHwYyJ5Pwt1bJqaNBzVajVlVKk3Hk11aFzAFUhVKvKwSAjLFNsiry+dEk5qjegD/fWH8BbzRyltxJzpcMWczBg2HTgtQDHO/B6MGrfO7S2QP7xDxOIs7qQPTR+bpDEZQckJCG7tMociR3DCfIevE73knNcoRIudKMy0k6C6MwFK+aq4CG/VgsUtsizG8X70LBwLfIkBQbi4lh2EhfsbVLqNdK6tLUKo0PfBI098vOEqfZ/kUeAGh2omvtznGwuwJKUkNxTLEwH8TJQ/s6/cSvsbQATMjPfx+pzwx7oAsjs8L8fyWD9qOWMyk2f3RJi68+Y8P06VKk5xYtYiDQky+Kzb4nbWKpNxtZdGhE3pc/s4D0vge5uY5ePA1kc0KagFNysievsHvctEBFWoOqrEia5GHR8qesx3WFGZZKSaql3+/YzxDEgGRlcPiHCkH2ipH/pViIhj4XQtX+brlW0yrt79UHoWJDPW6ErYJkQ0yIGlrqqQPJdkCBazBiav6HUA1n0T8NqegZGsF4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(396003)(366004)(39860400002)(346002)(1800799009)(186009)(451199024)(54906003)(6916009)(66476007)(66556008)(316002)(66946007)(6512007)(8676002)(8936002)(2616005)(4326008)(36756003)(41300700001)(478600001)(38100700002)(6486002)(6506007)(83380400001)(2906002)(7416002)(86362001)(5660300002)(26005)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1LkUZ05TMyB3aDWEZ+jxGIlgn6kFvy5WhZ6Y9eHYC8se7EeBsOjIKzss5WBA?=
 =?us-ascii?Q?hYxSvm9HTs/iS6rRnUVaCkAgznj530T+w0JHii7qehd2cwLQCmoYIl75E9AJ?=
 =?us-ascii?Q?3pDujd6oGXK+abywKUNSOQpzNHVyrk5SWEpbq09+170zJ6r1QQ9cjoNusvQ6?=
 =?us-ascii?Q?y/OtAiKi/uwDl8/yZd04kfCI/3XmyT3Br8vcJYb1bGJvjh5nWFKZ6+1J5her?=
 =?us-ascii?Q?UzfdOKN5jWhtK7K2vppjaAMy/JgVnCL7NQoZ4y/VftbwVdsBSFogcZwRMbRf?=
 =?us-ascii?Q?dbMR5CikZyoE+8stEDJdXDSV+5jTIx0XgmTJyexdCDzXGI20ctHIbh1u8cVc?=
 =?us-ascii?Q?ptzmWh4X7kmrzJJZQ4uxS3RIDex/in/CX11etiSARQ2r/RKdiESlLfY+QJVL?=
 =?us-ascii?Q?OiRCnsh+UO6OdLxtiXoOa06KlhSql1v2vY0UxGt+/5WJt2lkt/Zet7g7egt8?=
 =?us-ascii?Q?2EaE1vw4Ki0ixZk8bNl4GHHE57cF9DarWd3D/Rcfl4TxLEjYpydt2NQgShw7?=
 =?us-ascii?Q?Dpps28UP1DgZ3VQAZIqmGD0kco/xpFe9cKXzhuboOlBGtySdWWha8kB5YI8f?=
 =?us-ascii?Q?rCz9NF7Jj34zNIV5sVCFvinvWLXldVE0TWsTBwy6OD4tlnksYFitkHd2Mrmo?=
 =?us-ascii?Q?RvTs+LAY/N4M95VKPHEFf0JPueTdavmktOm8YOlXoTWEIfZPKWHqfrLUpBoK?=
 =?us-ascii?Q?2B7rN58yBhCT9EbR4/StrXD+8hJKyYhYvswV90pC6jPdi0+ickrriwsw5CEc?=
 =?us-ascii?Q?KveMLyl6XH4GGwixjF780ElV/qr0U+L3uUoFa4/Lf5zsFoKhd73JMlQ9mEIm?=
 =?us-ascii?Q?8CKCrrI1PQEDXB/d8nfQ9SzxEIzElM+8fexxV+sTA6UFtT/s3nskXqIv7idG?=
 =?us-ascii?Q?RjwKQK3R3d0rQPbxaM5AaIKkE0b0ECd3kbzWeA48g3cxztpbn2CdT0dsoFR8?=
 =?us-ascii?Q?FO38LLC9FKBZ1L3us2i3dI83I3rd8btKeXoGnakcpZ1l1pmYOIeVoSCo+nBc?=
 =?us-ascii?Q?zw1uIbA3sDM+Qek3Gfjxp98yYOKYP63N5lflUVOCktnveh7jImbwHnfQkH8/?=
 =?us-ascii?Q?OYxhSTZrWT7TaDoxC/D1WvxfZUpvBanVt9uQdf8AK4jMK9GpLq9kgSDB+pvf?=
 =?us-ascii?Q?25q2ATUaKDfKUn4pddGjFsm8GCySqatZRe362um980meET0S8KI4CHFD43k2?=
 =?us-ascii?Q?pSH1FQoqOjTDDbreLozAcZgNhWdLGbNbWZvo2PUQfoV+yNJ/PjbWCT17EjvN?=
 =?us-ascii?Q?nefGpNA+OvzV9vuBQZZGgUGEAdSWyqaoMndlsBv1vz2ag9JAQBTay10XOyfM?=
 =?us-ascii?Q?9Hso9O7j54P/xrUfSaatRqj5FIo2Bpe6D+eeEq5iJrZPCsFqIG4+9HvRE8bQ?=
 =?us-ascii?Q?nIwfYapt1/TltBEB4tkhSonSnH7S7hqbSq+UW9lR3TCqjQOpXwhcQzGji0qH?=
 =?us-ascii?Q?fYnWJMLIcBKoR+6a+WI0rbXOB8Sg9IOdOzBVfd7dRzx64msJCHqJTHUqMxW7?=
 =?us-ascii?Q?TvHDfrd4NiQZ9ZWPKXw+VFg21nlH3sX3E2HyVKA6TQ8ncXmsOC9XIwK4wr/7?=
 =?us-ascii?Q?uUFjcGPhr55WKri70ZAljjIv4B9PtmyGNc5rtf07?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 05061f68-e105-4b18-0171-08dba30e34ae
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2023 12:49:21.2951
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xa3yGy7UDpQSnlYHLlwNx7iYZQXt7lUYkb0FGYmpyhs9nKRPcajDbbGffJgGQ8r0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6890
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 06:56:57PM +0800, Michael Shavit wrote:
> Always insert a new master in the devices_list besides other masters
> that belong to the same smmu.
> This allows code to batch commands by SMMU when iterating over masters
> that a domain is attached to.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> 
> Changes in v2:
> - New commit
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 22 ++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index f17704c35858d..37b9223c145ba 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2382,6 +2382,24 @@ static void arm_smmu_detach_dev(struct arm_smmu_master *master)
>  		arm_smmu_write_ctx_desc(master, 0, NULL);
>  }
>  
> +static void arm_smmu_domain_device_list_add(struct arm_smmu_domain *smmu_domain,
> +					   struct arm_smmu_master *master)
> +{
> +	struct arm_smmu_master *iter;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&smmu_domain->devices_lock, flags);
> +	if (list_empty(&smmu_domain->devices))
> +		list_add(&master->domain_head, &smmu_domain->devices);
> +	else {
> +		list_for_each_entry(iter, &smmu_domain->devices, domain_head)
> +			if (iter->smmu == master->smmu)
> +				break;
> +		list_add(&master->domain_head, &iter->domain_head);
> +	}

IIRC you are not supposed to touch iter after the list_for_each. Like this:

 list_for_each_entry(iter, &smmu_domain->devices, domain_head) {
      if (iter->smmu == master->smmu) {
          list_add(&master->domain_head, iter->domain_head);
 	  goto out;
      }
 }
 list_add(&master->domain_head, &smmu_domain->devices);
out:
 spin_unlock_irqrestore(&smmu_domain->devices_lock, flags);

Jason
