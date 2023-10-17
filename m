Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C62D17CC91F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 18:53:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJQQxI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 12:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQQxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 12:53:06 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2505294;
        Tue, 17 Oct 2023 09:53:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fQhvO2IPnl9BeeyjdQ4c8ktjIcZKYNQL5HIN5ojFn4IGozBUWQwNAyMj2oPyEhaGbpquomLowqZxLxUWErr2sGvbjyZ9Evqibt05ybtEx3sKfW1zN9BnIf0Qrlz1IG/p0yzk34xlvfVCrGXc/yhcDROUuhwPXStcHgG09qiMgH0ntIwqCScYUdnwtUmkfsDSz4vQKXsk9Ay3uTJifKLyB55fDcmee0CsFZjdmI/p9JctPZ3urX95Ltb97VAaPlUJsI3ugzAvzS1/B0jWVE2brFRVb1OKu8twZ1mNtzN0onuvYru2e0TGq6NLOjDz43O3cCflsaH+fOsFX9YBUwfYzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yq36ljxrv1QIlkujEr09NhyLj50waM7FvZRYatpitn4=;
 b=L/rgSqQ+4SEG8sMNXtvZMyfZ6pnyXCsyVLtwxAvV/EtlCQZjfAyvA7/4ohPPXWWTXgU6HGcYX/CJVP7/LsUkpvsT8MiQmMDWF5I0H/7V4WAUAwSKaNvlzdZmEjzmfEdq5xz62zuHbWp8jnCZZPPPrPVEJh16fgVjOz5O33PFM6EXh+NKXOIKb3Rxs9odVaX6el+xj9LMkS7IW9RGmpe7XoG47bWb5K2Xc/0uMrHR713KXWbo7zz0JdiiHR0booy9WPeKB+JVSUada2TEIWeJHehxQIZ+Td026F5TP8K32xrFyIv+rVEuxCyxR8d/NjoH/3obncw8Rr1jukqgU+qOtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yq36ljxrv1QIlkujEr09NhyLj50waM7FvZRYatpitn4=;
 b=N/UlntXdD6qdHqYON/Npiwzqi/MWqMbkX5J/edkMN1M/7mAdFoXayjMcJaT3aQJi04K0roir+jUdZYQAnlJDuNdkRn/wbEDCB5qdSc2CVrcLRjbZduamrAz6jUCQ2+tK/GGNDUs5yYji4Psemhauwcg5qLSYJG4D0VuMDPOHve0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 PH0PR12MB7861.namprd12.prod.outlook.com (2603:10b6:510:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Tue, 17 Oct
 2023 16:53:02 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::e31c:de3c:af9d:cd2c%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 16:53:02 +0000
Message-ID: <97473ad9-c9c8-450c-bb1a-ad72dea0a5ad@amd.com>
Date:   Tue, 17 Oct 2023 09:52:57 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/11] pds_core: devlink health: use retained
 error fmsg API
To:     Przemek Kitszel <przemyslaw.kitszel@intel.com>,
        Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Michael Chan <michael.chan@broadcom.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        George Cherian <george.cherian@marvell.com>,
        Danielle Ratson <danieller@nvidia.com>,
        Moshe Shemesh <moshe@nvidia.com>,
        Saeed Mahameed <saeedm@nvidia.com>,
        Ariel Elior <aelior@marvell.com>,
        Manish Chopra <manishc@marvell.com>,
        Igor Russkikh <irusskikh@marvell.com>,
        Coiby Xu <coiby.xu@gmail.com>
Cc:     Brett Creeley <brett.creeley@amd.com>,
        Sunil Goutham <sgoutham@marvell.com>,
        Linu Cherian <lcherian@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        Jerin Jacob <jerinj@marvell.com>,
        hariprasad <hkelam@marvell.com>,
        Subbaraya Sundeep <sbhatta@marvell.com>,
        Ido Schimmel <idosch@nvidia.com>,
        Petr Machata <petrm@nvidia.com>,
        Eran Ben Elisha <eranbe@nvidia.com>,
        Aya Levin <ayal@mellanox.com>,
        Leon Romanovsky <leon@kernel.org>,
        linux-kernel@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>
References: <20231017105341.415466-1-przemyslaw.kitszel@intel.com>
 <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
Content-Language: en-US
From:   "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20231017105341.415466-4-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH8PR07CA0026.namprd07.prod.outlook.com
 (2603:10b6:510:2cf::21) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|PH0PR12MB7861:EE_
X-MS-Office365-Filtering-Correlation-Id: e52088fa-a18a-44df-c4ab-08dbcf318683
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QYRjc5pfL7uQ8wsmhhPOzvJY+JZLUtGDetsj9wkq5Y53pxeD/E1Vm9SHH5J3fYHcCljs3dDj20uZ4J0psm7kQTPq62ROL1FaF/AjfoMUWv5/lOdqxf187BS8smDWVVscsHJjVjTEnkU/rW8PX+VhWlSl1qC+j8AHiJvDZvLdjo1x0hRz/oH4xKb+UCnfvLubbASUIvhB2NvCMHRG6eF7iRZYohsonjl5YJVCdgxNiIA7503SuQyseG5c/3AqaZBBGgYakTxfIj/w1boKDiBHtO93yXn8rPvhu8gEhAd4qRII4fHR1+qbBGN6Zwd5Oc2Ee44W8lmnng3oSFsc6LEHbrs2Fe35qZzmsuP+Qmma6UQMrgJOJ8TF6EOa1GxPgRqEECc3eoRdM9HgKe9auF8n1/FwTlhYDAnFhCAYyx7jG9C2elCnJ8QpYSRt9/50dgskIrpT4k3xZh6JdIs7LrTq/E8kqVUAwVbLvUYx9dSiiy9tr5TIxjzxpK9lIz+Ib+cGu0K12aC4D4C9q54O6v+oi7mUAKfb0Z/o8bQUv25ikL7thdxnMFbQfgRW3V3OBuvtYnPfm7VaWCPwLEnRKw+vRD0VDW/OyYWnCVGeqYo5/DeYmlXDtj/6CXXTRkj3/bbuC6LinnK8LbcMTIQLU4Rz1wKIIYW0UKMz1fOT+4BUMA4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(53546011)(6486002)(921005)(6666004)(38100700002)(83380400001)(36756003)(26005)(6506007)(2906002)(66556008)(54906003)(66476007)(316002)(2616005)(478600001)(66946007)(31696002)(7406005)(110136005)(7416002)(86362001)(6512007)(41300700001)(8936002)(8676002)(5660300002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OW40QjN6dVkrWURscTV5ZUpKZ2owejZ4RThDbWtkOWlwTXVpSDBhSGVBT3Ey?=
 =?utf-8?B?VlNQZDZUdC9WR0o3RDUvTHZJdlhNZXY2QklCbmZqak1BRW1sNURKR0RuTXM5?=
 =?utf-8?B?K2JDQTcyTSt6VGJhT0pKTmU4TktZWkVqR2JOelVTOXBlb3c1NGk5czd6anEx?=
 =?utf-8?B?K0E2NWEzQ3R6WEVLRVFlSUgwS3kwK0JEWXUyNkM0QWszWVNaN3Z2QjFoUFJ3?=
 =?utf-8?B?SHVpVnBTMjNDWXV6VldwdkVMTU0wcHBVUHg5QlNXMjRRbnp3L0NtN0dyMWNX?=
 =?utf-8?B?aUkvWDc1WEFYSkwwK2czd2NROFBFN0cvVUl5blN0bDBHK1pnOEJUU3pFWVd6?=
 =?utf-8?B?RUFHTXNXZ2NQdEg3VXRpa0t0aE1McTZaZjhqWTgvRittLzFFWVB0UzR3b2Fh?=
 =?utf-8?B?ajQ3aU5kcEFzMm9penV1TmVwR0hPOHZRZlNaTm5mdUlSbWdzUmxqWkpoT3ZT?=
 =?utf-8?B?eEI5MTJPendKRU5NWWx5a0kycTRadW84SFp5L2JPdjVyK2V6cVJzSW0yaW0z?=
 =?utf-8?B?b3htUmtLNFJtTng1YVIxZm9lek8vd2k1WU13YmhhWG8yUTMyVmhCZzY3aXcx?=
 =?utf-8?B?M3dMaVZJMjdQVjVkYktnZkZtRnFKNzJlVUNnWVU1TTdHa0pNWkFlVFpkYnJF?=
 =?utf-8?B?TEMyQ3pwZjRIRDVKTElpblJXVHI2REU4aVZ0bTR5bjdtMUtVOXM4UTlnajZL?=
 =?utf-8?B?Rlhkb3gxTmRxZUdXcnJmeGQ2dzB2eVRPc0lra0o2SDFmc1oyNUtNVWVCakpZ?=
 =?utf-8?B?SWFSY1BNRjZLbENweHh2d05SUE1tMHI1ZDU1OGlubEt0L0xwNDdCbU12cnhE?=
 =?utf-8?B?Z2NIUjNuODNxOGtPSU9LSlBHRjRrbDhkMjJhSFk0UUlvWjNzMFlPOE1wdHlK?=
 =?utf-8?B?bHJRNSs1RmJ0LzdrZDdlNDhGaGJoOFJucHFVRk8xVlZHd1c1VXZpSHE5eEJP?=
 =?utf-8?B?QUc0K053UTFYNDdibjRRK3ZpdUJJVGQyZlo1bHRrbzV2RlhMREtKdDN6MjJM?=
 =?utf-8?B?RzA3Sms2citjMjAyU1hNSFRIQVNmK2NBZHVSWDJPRDRNVHRJVnhtRklpZmhZ?=
 =?utf-8?B?SlN6M0xic0MreVk1RnVGclgrdmRmc0xZaGpNVHVUY085WnBOYWpwaVpWYVJ6?=
 =?utf-8?B?MEVYZ214TEZUb25ma2tkWU94VmR0S0V0ZWllcllrcU9XTUo3TFcveSsrcmMv?=
 =?utf-8?B?dHgzM29rYkdQMVZrQ0ZLOUNTNU5FOUd2dThVcVpRa2VtYmJlZmY5ajZRK1Ur?=
 =?utf-8?B?MWZkVElIdTJNbWtVVTNRTTkvQWFUYlNtR3NQQzI3bW82eXJ3dlB0ZUJUSlBa?=
 =?utf-8?B?NC9ZZkRnVlRjeWV4TURlZXFhWUQ2S0pZSHVBQmliYk9CbUNvc3JqTjRQVWFJ?=
 =?utf-8?B?TzlaZ2o0RWZUUWxjVkVsVnZSNWlQbWhSdXg1R3ZOT05wNGZmRXROTnMvQW5C?=
 =?utf-8?B?SW9oNFVUbGFoS2F1OHcxK0JNQ2VobW1YbmZDdCtyT0ZZbEJnaGRLbUpwU0I0?=
 =?utf-8?B?bDBXU2p1Vm9PU2owVlVmMmlidmFnTDJmMy9mZDA3a1psbFEwaDBMekxOOTZ0?=
 =?utf-8?B?eUNxYVNMTUFlanJPK0g4dHROMGxETUFMdlRvOTNEbjdtaUFYY1ZSU0VXUUdi?=
 =?utf-8?B?bVV5eDVvaEdaRy84d2xGUTdkcGZMdXNGTFBieUZpNnJGS0tJZVUveFJUaVpi?=
 =?utf-8?B?eXdpR2lLUCsrVFVtOXBnbkMxY0EzVVA0WjkrcXNsV2k3dlB5djZrQ2hhZDJ4?=
 =?utf-8?B?S3doVFF4SlNab01YKy9uSmtuczVCdCsxQTJCNnpHSFUwQjR3VmZueGZZbldF?=
 =?utf-8?B?cmJ4L2pvV3dDdmVNY0xGUnVGTDl5TUE4QnhwT1ZjbXUzREJRYWRsWTgrbk9U?=
 =?utf-8?B?NEFNalJIQzhuWEUwaTJVV1J6SCtoS2gzdVBLcVA2UHFSZkRrdHZPZG9aOEV1?=
 =?utf-8?B?M29iRldaaUpZaDF2aGZMOXcyZnBMR256aitTbFd0ODlJMzc5VnAycTd5Qlpi?=
 =?utf-8?B?R2tUTjdnV2Q0VW5ZTzdpUUM4V282QlM0ZWlKRm9lZjFndUNFdzdjeDJONVRj?=
 =?utf-8?B?cmZCV0dOMmRHa3NtUG1reHp4TWp1alJBN1BnUUVFSHRLTEdpditWb1dXbllB?=
 =?utf-8?Q?MPQt9mk5+fhlnv2q8mQKFZSsE?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e52088fa-a18a-44df-c4ab-08dbcf318683
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2023 16:53:02.2742
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jmBHwB8AGJVWPtfDQ8g9nErDbq2EOJ+NgrwWtWAAbkRGnKGoRe2Yt5oSogrIvYqtJJhV97RezEpWwu7/c2MyrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7861
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/17/2023 3:53 AM, Przemek Kitszel wrote:
> 
> Drop unneeded error checking.
> 
> devlink_fmsg_*() family of functions is now retaining errors,
> so there is no need to check for them after each call.
> 
> Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Thanks,

Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>

> ---
> add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-57 (-57)
> ---
>   drivers/net/ethernet/amd/pds_core/devlink.c | 29 ++++++---------------
>   1 file changed, 8 insertions(+), 21 deletions(-)
> 
> diff --git a/drivers/net/ethernet/amd/pds_core/devlink.c b/drivers/net/ethernet/amd/pds_core/devlink.c
> index d9607033bbf2..8b2b9e0d59f3 100644
> --- a/drivers/net/ethernet/amd/pds_core/devlink.c
> +++ b/drivers/net/ethernet/amd/pds_core/devlink.c
> @@ -154,33 +154,20 @@ int pdsc_fw_reporter_diagnose(struct devlink_health_reporter *reporter,
>                                struct netlink_ext_ack *extack)
>   {
>          struct pdsc *pdsc = devlink_health_reporter_priv(reporter);
> -       int err;
> 
>          mutex_lock(&pdsc->config_lock);
> -
>          if (test_bit(PDSC_S_FW_DEAD, &pdsc->state))
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "dead");
>          else if (!pdsc_is_fw_good(pdsc))
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "unhealthy");
>          else
> -               err = devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
> -
> +               devlink_fmsg_string_pair_put(fmsg, "Status", "healthy");
>          mutex_unlock(&pdsc->config_lock);
> 
> -       if (err)
> -               return err;
> -
> -       err = devlink_fmsg_u32_pair_put(fmsg, "State",
> -                                       pdsc->fw_status &
> -                                               ~PDS_CORE_FW_STS_F_GENERATION);
> -       if (err)
> -               return err;
> -
> -       err = devlink_fmsg_u32_pair_put(fmsg, "Generation",
> -                                       pdsc->fw_generation >> 4);
> -       if (err)
> -               return err;
> +       devlink_fmsg_u32_pair_put(fmsg, "State",
> +                                 pdsc->fw_status & ~PDS_CORE_FW_STS_F_GENERATION);
> +       devlink_fmsg_u32_pair_put(fmsg, "Generation", pdsc->fw_generation >> 4);
> +       devlink_fmsg_u32_pair_put(fmsg, "Recoveries", pdsc->fw_recoveries);
> 
> -       return devlink_fmsg_u32_pair_put(fmsg, "Recoveries",
> -                                        pdsc->fw_recoveries);
> +       return 0;
>   }
> --
> 2.40.1
> 
