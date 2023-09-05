Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D982792B45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:03:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344133AbjIEQua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354558AbjIEMiu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:38:50 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2070.outbound.protection.outlook.com [40.107.223.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF061A8
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 05:38:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mydg+ucd6cqOryTerHZCS3kDMC3rMKTH0GUu+rne+QX49ZfO7uufDDpRnT1YO5aCioZRJXZ4MZDO711MVhBtL2fFaxTutR7puzpfamLggF3b7KqXsHjVZVmgkg2cZSo3C1aYbMpn4IPGx8IWPuxuL8cuf4Uo2hPoTJutYorfzsMfRxw7ECovTKYZLW7MG/GB7nVJ+PZqXCAxVZqbxgkfubQFXaZiEVRcAJKjm4CEUHy/qx8QOHGe5+5tnloVTGmMe4++A2HZWVSIp2QMKYS67fNCDTu/Lz8d6Um6c04dc9ftA2WPzT1VaUUwoJeBW+teUI3BEkQ1I/w6WueNKpcUXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FdWFJ0fpfpgCcspKhGyJls9HdrGtV60EuZiyNBaswMg=;
 b=SROvdlZ0d1gDLqoLZoL+rVas2Ao6pRaWmiNXEBUlt2NlFnNTAp0rpRg7lShDQ1R9mwFEX/ucaKWCVaI7QbAHgMXI20gvE4psKS/OwWWxiA7PBsvXxWYxS0t6r+dWLTsrtcjK2ITHEZa5HbcIopidZFYu1fqBQBWNnOFG03SArnhP+zyEhlBN69TSoJCjtj9gHmyj5rAvC4Je53+FlYJwScKPBYwM5EqK36EplmdPwZUfKVCN7lUQFQGLLXcK8YfkHb4SRWBWrYiIoaoxq5s3yfUTuxneLvfWKDNjpVHj9XAwFp7RuunjL9QGk6z7mLLJkYtxzpPdzh1keX/9bt7WhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FdWFJ0fpfpgCcspKhGyJls9HdrGtV60EuZiyNBaswMg=;
 b=YEnKvwgiaXoHMT+1auTNCAtgRDiNOqleMjSz7kdYdzFD0/DNvowsgmXDq7ckUDkevcm/xQO/pFE9io1sNOm7A/XhI/+9HoJKqMQPD3L/1dnK8UZ6ov+zhVz35ZQdbDGkxcwXOqTbvLYUBgTOuC+q8cL4/ZaEtuouequ+l8bCDhd1cBuqqKEuNFDK/+NjfKbNebxmG+uDh5Ah502oX+Ar+Dcbi9AarjkS/zQY0/Os/u6iXfh3T4jAP84dTOHeI624Ra/zVqBEkqxDMP/77EMN36Mks/dviS2mjGh2LfbQZAna2AP5xOnrYxY8HgpWuIMvLTWZfZPJWlnvcyz8G+UQwA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CYYPR12MB8854.namprd12.prod.outlook.com (2603:10b6:930:b8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.28; Tue, 5 Sep
 2023 12:38:45 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 12:38:45 +0000
Date:   Tue, 5 Sep 2023 09:38:42 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 2/3] iommu/arm-smmu-v3-sva: Remove bond refcount
Message-ID: <ZPchUhnSFjVpkKCe@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
 <20230905194849.v1.2.Id3ab7cf665bcead097654937233a645722a4cce3@changeid>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230905194849.v1.2.Id3ab7cf665bcead097654937233a645722a4cce3@changeid>
X-ClientProxiedBy: SJ0PR03CA0261.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::26) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CYYPR12MB8854:EE_
X-MS-Office365-Filtering-Correlation-Id: 94b554d8-8b89-4573-3d49-08dbae0d0b51
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: f2QgZtWMHcpLBGjJwcR/zSnb3qbbs+vO6mmYvk6t0CQA/dTKIA4WooEeK/ssGlPGiySHgiL+P5cWFeit9CwoQXRtpjETkAgpVKVmEFV5/IXcNv1bkgdr4MuDJ0PdG75I2F2EWzdlEV6j/y4GumM6YU9kD7Dke5/p+LyIuj/Dlhcr3UgsbbqDfOEGE7H/vLcjT+mL1XcBweAfP5qwLJg+3lsansrSTduUldKUTnh5oxKmv02ikxkJIB2BXoGDxLg96VA6nDQ9OYAkC9FQoAvDuoDosK+t60c4bq3N7dr6nJxHKJrHVskq9mp0LQrXPZaG0VbER+2E6EHjXLlwBRGgxbY2nU0Jay/ElALUyaGKrL3crHIwzUxamAnTlwOFojRvtwsIRXodQBcnc1oXBmFmI0vAwnX8YF7rc4N2nvHTcFAlcUrBB5DTS/knJVjoQ+8RijzVM3t229zBNx/XdoXWhW8/4WAVsNOAom1u/5zzIZcAjGJZXr4MdvUtLK2ebyLbRGqQRJLSwrQ+eexoH7UOejJEM2LyWOjtxc0g+zDa0kmkan8MGTsdNt0j4ciotRPD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(376002)(136003)(396003)(451199024)(186009)(1800799009)(83380400001)(7416002)(5660300002)(36756003)(86362001)(41300700001)(38100700002)(66556008)(26005)(66946007)(66476007)(478600001)(6506007)(2616005)(6666004)(6512007)(4326008)(8676002)(8936002)(316002)(2906002)(6486002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rOY9orwP5lVQp80/MgmWDR54PYj26JXVc3X1OGHEFk4pvZUhXmQq/eEQIvaB?=
 =?us-ascii?Q?u0Ytv/s7mWSHa+ICpgDDdeTXIhstvJDVMZJCukjnDRUFO9kmlMMgi4FNJcwq?=
 =?us-ascii?Q?3kEQKhQ8R6ldjD3Jv+lAK43Plzmb8bZuUNdxCHpetMmx4EAR1plA39kK70iS?=
 =?us-ascii?Q?4a6vs7x2B4DDCKIO25MqoYDB/or8D9ZUdcxnNaW20gy2FlO0HRRBMFhcOl92?=
 =?us-ascii?Q?wIcQqYfuq4l6DMDmVhkJ143o1pfzWXvepEzgYBSji1cxlc4axKdcqaTHsuax?=
 =?us-ascii?Q?069kII5gIEkPnupdY1IEUgfBLN4EyC6qR28pYQ1Y44kKZoblKoBAfSfVOWoX?=
 =?us-ascii?Q?Lgyorhmgusq5FBOlaDeD8GW45OAAtz8FbHnM70MC0lPS7lmucIVSr+dETUJd?=
 =?us-ascii?Q?lU87/4A0ePUypKgJsQCSsSKdRWZ0nfsOs79B8DHwlPpstyXSJWQi97VdUKqY?=
 =?us-ascii?Q?qP+e8mbXDK2ZYjCsOOrffQX2rIj6KhZ709a5/h4cjLC5Mh1niPmAIUtAj+kJ?=
 =?us-ascii?Q?tbhhud0g3kPD+JKuujyO59MaYEQaoA1ptGADeiK99lc/sonG7JDBh80IIMQv?=
 =?us-ascii?Q?fMok5NJbNFyi2mPk6ZSVkx3RN5rpruasADLBAlRVpYtWqwBnGF40RcQk62fH?=
 =?us-ascii?Q?IAMdNmX1rWTnBh8ydEM3jH2WFnzFEdk5ftd3CkEIkXwUXgo3ssZ2osHPXn9I?=
 =?us-ascii?Q?msLuCexOJwmXN8G/UQJruzMC/sITdIDMraenLXs0IM3hpjtgyDU0y30CnF0K?=
 =?us-ascii?Q?yT0QfP3gDlMOoTmJ3W9pYpyTF10DCoNiOZMIYWlCWjUFYRKZwh3cn96RVlY3?=
 =?us-ascii?Q?NaR3+l4ndiXrA+tRb4P2O8BgoUrt7HQl7eUyey1ntD3f2THubCpmLw8YoQCZ?=
 =?us-ascii?Q?4YVgkBB9x7va7N1jbBgbi2MuqQgnY4uSRPXW13WJQzHGKl2TzJETjcLpYYMY?=
 =?us-ascii?Q?Nl3PLqkVDPpymRtCTDAJiL++aAzszd18FLeKHZT5LMJz2CGjUiUHFn+PZ1gB?=
 =?us-ascii?Q?dEvnlSTwxPHMkczzQQP8gqn0dVlZUg5a18UrAg2983r2LwChRoMXcEOhdeiF?=
 =?us-ascii?Q?8nruQ33VDr365QVkCnawVXhEhW9qP/ImNUk2YhYrWuxHHMT+WxU3BKQixWtY?=
 =?us-ascii?Q?ZQ2vFJY3bTGj+2mquBpzkxfnO7MZsjaGr97EDswplsp54NUHKvMHN3VsJ91j?=
 =?us-ascii?Q?7yQrarYmrSAFs/HsIrvcZ8oUdH9ycXGAGWpsV7jOjXRIxVrl1nh/Zxb/V4wg?=
 =?us-ascii?Q?YzlnAtddsoaBkwt7xcY8ieTZBjyY0GuDwDa4MOTAn5Cw3CJv36e19+XkEzjK?=
 =?us-ascii?Q?L2BhiUvX5Wcws8/5lvQau8YtiJ/REh+v6FsCYcFxatxaHVFsRWRxTnWVB00y?=
 =?us-ascii?Q?882ThEiNkPd3Yp2DRBXOSgrXmSDWp34D3VANbGd0vAz1+eIBoUboejdRlZ/+?=
 =?us-ascii?Q?CIAsXGhpvzxA1fi3t2iXzfQa9T2bhnz5TS/LjuzOmjbO6LB/KhmTBN0XRKT9?=
 =?us-ascii?Q?uuhFja39823KWn90HOrXtuyfsvE0I9MotObrz2/LQbGsZuMSVhMd0ccd89/A?=
 =?us-ascii?Q?xb1lQ0aBCpQvKQ7YigLP5ajBd2kUU2c8Xkx2jJOC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94b554d8-8b89-4573-3d49-08dbae0d0b51
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 12:38:45.1957
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VwkIhlhV7LrzO5WlwUlmcKyIznFRcJNBMwRu7/8cUECOhEfxFxjMsDhEUYQkwoUO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8854
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 07:49:13PM +0800, Michael Shavit wrote:
> Always allocate a new arm_smmu_bond in __arm_smmu_sva_bind and remove
> the bond refcount since arm_smmu_bond can never be shared across calls
> to __arm_smmu_sva_bind.
> 
> The iommu framework will not allocate multiple SVA domains for the same
> (device/mm) pair, nor will it call set_dev_pasid for a device if a
> domain is already attached on the given pasid. There's also a one-to-one
> mapping between MM and PASID. __arm_smmu_sva_bind is therefore never
> called with the same (device/mm) pair, and so there's no reason to try
> and normalize allocations of the arm_smmu_bond struct for a (device/mm)
> pair across set_dev_pasid.
> 
> Signed-off-by: Michael Shavit <mshavit@google.com>
> ---
> Note that this is true today because iommu_sva_bind_device calls
> iommu_get_domain_for_dev_pasid to elude the iommu_attach_device_pasid if
> a domain is already attached.
> But even with Tina's patch series where iommu_get_domain_for_dev_pasid
> is no longer used, iommu_attach_device_pasid also checks whether a
> domain is already attached in the group's pasid_array.
> 
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c | 12 +-----------
>  1 file changed, 1 insertion(+), 11 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
