Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58E62754840
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 12:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbjGOKnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 06:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229824AbjGOKn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 06:43:29 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2110.outbound.protection.outlook.com [40.107.92.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BFB33A84;
        Sat, 15 Jul 2023 03:43:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NshBX87rr7ui+Mr4VbRP8oLQQOp6ylWpWsDeqLHPr8dfY+YSrTOC3m0kdWTEmdgunE7qGipTbmecvTEzMSkHeltblGiWcnq6UQBXwAM8TayS/LmdQzBkzlhyn/GhPFSMvszKB+611Fg1MRvw3nkJ+OqYYvy91Wb2lbymwvPkQogivPC5iLAXtJyqgtKWE5/tbB6jzJgyUs8rUxqpqXWjIcsDuTZJo4lHu1J6xDitL34DhQAIxGdyYRF9fKeQx+RoH5EKemgvGhzy8AnD6LN44XweWxuYlBQpN/WBCcoNVCxPf3K+aFHWN7T7Q0pafhmFk1JNyUWX4tjkwQ2GwiBLxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wyqpeDwXxTXC7rmZQ4lq7ezcp5ckfRrAVwaX16JV1l4=;
 b=DjPqOnJ4M4GxcyJ44AQ8fPaRMeKYZ2q6mPksZt5cftluiG+z8+DlQNuCJgW4y4vsm8gPSTRDLelM6n3ysBA4H6TLUa57xg7nSGgw1+ZBQhj7eiNvQwhNpT3PsBUlm8+1c78GgTdK0RxFmvRYBTYd5zL/g0ZQ9pnyEDTdnlFYS0vHyQMWEZi+CqrYxXHrjKXMKFnsqJqWTjnv5qT9kULo6JyhYs+if9IbiZo1aedQi/yH60h3Ae1sPXhylGTp+7V7kNAYnw8WTTCLzCYm7fZ85/V6unI0/Fp4nkg0E72gLaszabAoqtkOj8klhf3ABtJPR3MjMq4hBN65LorhxhWt1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wyqpeDwXxTXC7rmZQ4lq7ezcp5ckfRrAVwaX16JV1l4=;
 b=GWVOX8DaudvqBuqUPbM0ZzG2dngvhxEn5Ik4cI3zFA1xNClF6afgaFTFmrycpLgO85aSbbdSGCyrJh1HwFdtL4kw059kvIXv7m9pmy3vTn2keHM6X0Ss1pRCji6qP9GX6BiA1GH0R9x3Y+cNBthjZ03QuvaF6mQ+mVA/iITgr+g=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from PH0PR13MB4842.namprd13.prod.outlook.com (2603:10b6:510:78::6)
 by MW4PR13MB5838.namprd13.prod.outlook.com (2603:10b6:303:1a6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.27; Sat, 15 Jul
 2023 10:43:24 +0000
Received: from PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470]) by PH0PR13MB4842.namprd13.prod.outlook.com
 ([fe80::d23a:8c12:d561:470%6]) with mapi id 15.20.6588.028; Sat, 15 Jul 2023
 10:43:24 +0000
Date:   Sat, 15 Jul 2023 11:43:17 +0100
From:   Simon Horman <simon.horman@corigine.com>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Leon Romanovsky <leon@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>, Ma Yuying <yuma@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v3 2/2] i40e: Wait for pending VF reset in VF
 set callbacks
Message-ID: <ZLJ4RQlmTvOS/9+d@corigine.com>
References: <20230713145755.1629442-1-ivecera@redhat.com>
 <20230713145755.1629442-2-ivecera@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713145755.1629442-2-ivecera@redhat.com>
X-ClientProxiedBy: LO4P123CA0675.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::19) To PH0PR13MB4842.namprd13.prod.outlook.com
 (2603:10b6:510:78::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR13MB4842:EE_|MW4PR13MB5838:EE_
X-MS-Office365-Filtering-Correlation-Id: ba53bf20-1cab-452b-c46b-08db852050aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2x6MdjYWyNXmRqUED9tO99orf45ovJrQVuCHy2qzR5Zi5DNp3mAkXg7ZPqAMzFmS9L/JxsrYuJXnZFYmQFnRYqPzn+VZyaRIq6VCY0tlsZOzpr88jH8VNs37FcyOotB81OxJBOG1a+K5I9/baeUxu6zV0Bd1Av23RxNGe0e3fsbh+EdgG+ZknQYFDrWpblFIC6PbcuHYg2abhZiTVZBkHqX0ACE4FspQRGzpZgr9de22CWHy3tgzktsx+YMoAg8KmPo6ziXDFRGrbgz2uAa9il++BhKHUoBWdmSrNEJUwgowjgFkAaXMxRJftAnW3vldlqt44m0pkDXO9W4C5xljSyEmE98+CyNaP8pu8TWpH+ftlzPBiIfSpBEVhOXcEBP3S7z4LEfF9Z9lI09a1hLbshzs8BfBvykAHa56AtHBLbVFlW+MCVq2ufR+0y8JL80nMC5WveWPTHRhCUwcIpRMTTCHTRHQz0rOosO6+Je2/ZtjcxpGl9CXB52EvG6tZDHi018nLo8ltQTdtH2KENnjwUy3I09d6FvX4qvpGCjIghZVzcabMyo+uEVb4OARekhRb+lzDxbDQwF9ut/77Jq7pqBGKDVunm5QUdP6OZzqbdo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR13MB4842.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(396003)(136003)(39840400004)(376002)(451199021)(2906002)(2616005)(86362001)(36756003)(38100700002)(186003)(26005)(6506007)(41300700001)(6486002)(5660300002)(6512007)(6666004)(66476007)(66946007)(66556008)(6916009)(316002)(4326008)(8676002)(7416002)(8936002)(478600001)(44832011)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?oKfYEmG0YZXYboczMPI6Er1jAJV09yxbjrpIuKruYMr1B3pREt5fr/lMQwih?=
 =?us-ascii?Q?so+03moSZNcRdWfWDnBgvxS/2qYBjS3v0llqAbZ3maZAdrKvzzJn+D10Pv6a?=
 =?us-ascii?Q?BT1zxPpIS+9Vi5THT+dWN1XUFC8GpCx8ObaHoTVTt0eUU4cl6ujUrpaWnglz?=
 =?us-ascii?Q?Gzca8eTYNMDFLb2q+y3mfOLWkpEo4K7UYuFV2yLf5mY6pEmd2giSa6PIsobT?=
 =?us-ascii?Q?nEwWbA94D/EkovKyv0XM6Ofw9vxgRaKbQTfebqii0BOVIQqh5q6dBIYyxtYS?=
 =?us-ascii?Q?7GOOnIRJ3FEwpQ58hc7hmndHzqfruTl1XTRkrpH37KjoKUl01GAKVm/aaJpY?=
 =?us-ascii?Q?AqbWMjAuVMcZzy1+cCS9iF85DazI0nggJk1+G05gT5x0En4OxBKDtvg+kTUj?=
 =?us-ascii?Q?gSml9KcalSP+NnEkUWgehwID61n4GNnDJaGa6Ct4hLmUJB1v/R7R9YwqQA+u?=
 =?us-ascii?Q?gtTOwKiYGAlMFVbieiwDLBdckhoHCY/9P/UDZw2fuygmuvaqw/bYVrEmz00+?=
 =?us-ascii?Q?WRPIjEpgv8WOgbDumi9mg4PekhN+7tZWH4TF/a9tZ6rbYeNxjYgvcgymiPms?=
 =?us-ascii?Q?Th3daEl3tIvXdfbgSl1JuHQdmOryxWEi2VZ1+VG6QE9z9qdsrVfllGop/w6N?=
 =?us-ascii?Q?kmr+ps1GwQKBko3Qxzx3hVhGwkRLLhWuh47nwdC7ETfaAelHXab7Fg03J2+P?=
 =?us-ascii?Q?jBm1huDy1zfV1TCyADGSt1b9rKCBFZzrceCzIh9a3Byo7Z6BrwGxoN1oHrsL?=
 =?us-ascii?Q?SHlFF3d75950sJbQ8panogaPHJjx67wCmxd9lN6+TNoOFdEc/zEIxHxHOf+k?=
 =?us-ascii?Q?3uCtM8K8I8QnFA3gr8pl20AuqfywmrwFc0RCqa4YIxOmx45D0LC+VeEh4aqN?=
 =?us-ascii?Q?7btv1nwp866I8I/C8yurSAZD3DrD5tMZHCtOLApDJLw60hKhntnbHnZf782L?=
 =?us-ascii?Q?7W1ELXgQYlugf74EU78u2qoqRiE1mvIx5vTES7cM12VT6KScnK4LCn/J2Zvs?=
 =?us-ascii?Q?FkPhkPpQcOoTWMhHyAkEruwaO1/3ffmxXq8OSwuWoE4lWqqg6qlIEh5sBEdG?=
 =?us-ascii?Q?ywKXuf51Wq7LVeulQ0KUzRoIF2iHx0cm7YW9iom46JTtkNvD323GYXN9zApZ?=
 =?us-ascii?Q?GDTo2oob3Bg8JqAN0J7tv+2GUkCf1h8ub8wN5ni78k4HX+nZ/OW8d8pPSldY?=
 =?us-ascii?Q?ks9IQZDk8GMmYoDaW45nCbRmyeY5aiOyfvffTy9ptOy5pPtbdOsY4FciLEAm?=
 =?us-ascii?Q?uPVAGxmPmHmfbe/JoE3qHSYrelQY9FSxknDZu8MY7O/TNEZk1KSpmLYQP8iX?=
 =?us-ascii?Q?n8jCVBzuV7LIBbnDn42Ff1na6VrPFzLcQtL/Nkr+TJsnxTbut7vWbsU0+agW?=
 =?us-ascii?Q?RcGTnJk/Ktwn2aa3pERcIDgjnf+JjND4bpjYAdK+cyzNY79ONL5kAHK6vdTa?=
 =?us-ascii?Q?5yfjc4DPDNVtSZBQsm1FIC82sF/eOGNzSjZHz0ujjXmqkvFjdYPWAOU3NOqI?=
 =?us-ascii?Q?B0Kji0G6HXZ13POAIEbRWo2upEvOUAPavkP9+URz/dMYkUyvGODZssT4ecZJ?=
 =?us-ascii?Q?3BCWIi9bIXBGm+Q/AOzxr/E7Smgz2CGvc46Sc/cKSkC4vJmgbskQFHXv8sdE?=
 =?us-ascii?Q?rQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba53bf20-1cab-452b-c46b-08db852050aa
X-MS-Exchange-CrossTenant-AuthSource: PH0PR13MB4842.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2023 10:43:24.4512
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IheBml3MqURAgReKqNj/qc0qj+6n3HViV+oR3NeRlkgSZ0dO1uhy/OhRg8jB9qVJtaF3ajPpLtjYilNiIxEyUUbrYADhpWQNoff5NdsPKEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR13MB5838
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 04:57:55PM +0200, Ivan Vecera wrote:
> Commit 028daf80117376 ("i40e: Fix attach VF to VM issue") fixed
> a race between i40e_ndo_set_vf_mac() and i40e_reset_vf() during
> an attachment of VF device to VM. This issue is not related to
> setting MAC address only but also VLAN assignment to particular
> VF because the newer libvirt sets configured MAC address as well
> as an optional VLAN. The same behavior is also for i40e's
> .ndo_set_vf_rate and .ndo_set_vf_spoofchk where the callbacks
> just check if the VF was initialized but not wait for the finish
> of pending reset.
> 
> Reproducer:
> [root@host ~]# virsh attach-interface guest hostdev --managed 0000:02:02.0 --mac 52:54:00:b4:aa:bb
> error: Failed to attach interface
> error: Cannot set interface MAC/vlanid to 52:54:00:b4:aa:bb/0 for ifname enp2s0f0 vf 0: Resource temporarily unavailable
> 
> Fix this issue by using i40e_check_vf_init_timeout() helper to check
> whether a reset of particular VF was finished in i40e's
> .ndo_set_vf_vlan, .ndo_set_vf_rate and .ndo_set_vf_spoofchk callbacks.
> 
> Tested-by: Ma Yuying <yuma@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <simon.horman@corigine.com>

