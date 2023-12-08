Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF45C80A47D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233521AbjLHNej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233493AbjLHNeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:34:37 -0500
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7407D10E6
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:34:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lKkSO2n3p6FPh09R2pDKFnAOU75IpeKZkiVPs2simSvNq66HbeDWNFUw8Ku2O1ttDmYopgOlsyACOHp7lXiTVjWp8gjqbWjAnPRmWcpmk0/WfTwifzp6sM7/Fz7ehI7ZK72L+OOYSMKa+dHpkr2SNQsnrekgVMBGWVn+B9KcFRI1+HWSDqd4yEST2xuEwRvCaeSbhBMcl4HGCbfDCkvzKCpyaWjqPOaUaf5de76v/ud+A+pnnY/b1fd0IaKhTCH9zi4h4P7vkSA/LATLzKLcfLt35Zl78h+jUvrEnU1wwZxsEEUb1ShCQy+DH3RzM7BCnDNqXt0mMB3n4bPqbhwUcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1FaUx4AF90S/ePZ/PCw2vzKAgwKS5kh4sxcjUsqCQ8g=;
 b=Zl5J6uLuQ+ncf6S63Ge9P8zi0qzthb+3sIasReCraADC/rx4gQFk/BIM3KxuGF6ibbmGqi/3hl0JQiAumbs1fDzgAdfs7sJfEiERXshrZlNTpXNWa9KHEkn7LHao29DcuigCgk3bdXzIquqiYNCiRGlsBeavOyx/YOZNpdhnupUN8w+Wc+OTvgiut9xVo8PnUpeuCjPJAvZfU1CbL6KFzSbfAzLEryLt9O+mxlKXTzknxvb6QBHJuq1m6Ozv4z1FDuTWBck3vlQSAxiunutuPC7/1AtGkf90z1TRcBA0IAU0N+78Y/J+YavYpeCQNPVUt3aw1wvuiEsZiMv5QUdWKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1FaUx4AF90S/ePZ/PCw2vzKAgwKS5kh4sxcjUsqCQ8g=;
 b=kVBXFL9TIXJQ30Td7IOe0BuOF1ANK+Ms8+m5+lwdtJailOSq++R+etiVbAq6IgwTI5EA7ot0My/PvjIQte7ta+k+zEVb28Bgba9iQnmcfA9JCT8dhX9WcrlrHgrgVMrN/lD9TG0svzfezf5syfr80P4vpgg4f+k5jcCH3X3KQn8zwErfnsAvhonJp5+gml8Ay56VGwguoB9Vc8vaHpj03/4XZ3vN7a9oGTHBJKTDZU34jiZ+WIKrlcACYgH0espz8i/FsPWai0BrQQJg8wWKdL/P4llZRz7Ltq1kSiyCjW2qZuMSf5Zo1hZsDnbcwkH6QrK/XpqjbZHTHyxpLYCr7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7409.namprd12.prod.outlook.com (2603:10b6:806:29c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.28; Fri, 8 Dec
 2023 13:34:39 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.038; Fri, 8 Dec 2023
 13:34:39 +0000
Date:   Fri, 8 Dec 2023 09:34:38 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>,
        Aron Silverton <aron.silverton@oracle.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Ahern <dsahern@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231208133438.GP2692119@nvidia.com>
References: <2023112922-lyricist-unclip-8e78@gregkh>
 <oxtcvxwbj2hzv4lxnxubo3hoxn7diyzhm2oj3tsw2toxbc3og4@ddglhm6r3oa5>
 <20231204185210.030a72ca@kernel.org>
 <fgalnohzpiox7rvsf3wsurkf2x3rdtyhwqq5tk43gesvjlw6yl@i7colkh2sx5h>
 <20231205204855.52fa5cc1@kernel.org>
 <kakenvblxlgrkjvcrwfflnkm6n5fpxgr4qifwkdttjascth3te@57us7mblobjz>
 <20231207092329.3ec04dca@kernel.org>
 <uedlocmp2guvvhgxe2cjrjog3qf6pd7puj7idpygxxpjrnnj2p@nqmg66juf6xm>
 <ZXIWzBxR3S39Snn3@x130>
 <2023120832-vegan-trustable-f89a@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023120832-vegan-trustable-f89a@gregkh>
X-ClientProxiedBy: MN2PR11CA0023.namprd11.prod.outlook.com
 (2603:10b6:208:23b::28) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7409:EE_
X-MS-Office365-Filtering-Correlation-Id: 295b9fdd-18a4-4e0e-0c40-08dbf7f26d32
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZVvugWFzsJiJgJ1EAl+bJP3dg8efmZne12EptDyuVFyXZlQsIyqknrs5VTZG0VmxEOWyxvzqSvW11PHytiZAGRv1irZXty1C5brL8XXD4EMgFoxyOaqugegB2E5nzYDiDtmyYrU5pYjhKsBSqgjpFk9dCM7zBNjMbX7au+UGbzSUfVDaHyXd5Nh+kDiLvwpFG8wj+ka9rSLUz725SnHhhZHFIvXG6i8R5a42Lau0ngWqf7KyzigFEa335th/PokTHDjjE/fdnOHQV5ukAhA2NceujrfPgqMsdDtKboM6znHms6dTP2MWDh+8hBFgq45zzl9i+nwjqmh4GqOH/PPdRzQSWN2ceAsSVfah8H+V6bQVA/wBJ3VNV6Cmv4FunvrFTW485zURjf4dyMxQzRzobIfbMZN++R5gdhER3YrybXhCfNRIG6gxIqVwm869ova0waMGMeFZJlhrJI1Qf3l+t/ki3FDgqSaJeByWWl6uRz2ct7E79RDOUDraAZNZL/5Tn3E0UJSGUn+to2Q3FRN8T2hsWrOutoafs4O5V9hCAcAWk9zGwAyyzWFM++VY/CO8KKSsWJe+fpgNJUkY3zoxr8xqSd6s/KIQAySrgUJ+jmNheLZROdaMiATWujg70/coQKZQcxuXWjo7NNX3IJxfSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(2616005)(6512007)(107886003)(83380400001)(26005)(1076003)(66899024)(41300700001)(86362001)(8676002)(4326008)(36756003)(8936002)(2906002)(33656002)(5660300002)(54906003)(66946007)(316002)(66476007)(6916009)(66556008)(6486002)(6506007)(478600001)(38100700002)(42413004)(32563001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yvhYLSaU2jyblCZjQYQarcCeB7kSnzP4jkQMN7zYWgn9lLQ9YyPZwVKVnaz1?=
 =?us-ascii?Q?Z6i0F/CpqTzeEVvVx9Dk/Bl6CQk/P/GDvJ9vbEwoWgFSd3ublpLTrR1oEFVz?=
 =?us-ascii?Q?ojWUIsPlOP70LQHPB5Mwvwoe8t50XQYq2nI10IOnCAlcjqTbywd08wrLX238?=
 =?us-ascii?Q?s9RiPI5eLFiy+15GKpmFRHov+2kvPiEGGZcL97neX43EynD7jH298JZkUY7m?=
 =?us-ascii?Q?QkFdHuqWhSMIF+L17bhK0ShwLD6a1uQpzznsOhWfCX3GRPFHWiD14IZLa4i8?=
 =?us-ascii?Q?9u0QiJdHz2zw0hk3o2Gt1tHdX6GTEQ4WnsVhAsw+VaU/OQ6dvAW/amtGHIar?=
 =?us-ascii?Q?radYPLNj5CmG+Xbf4r548CIgOl+Onn4jukTeZEcnzIZgHh/lS9BFwiLhIF+J?=
 =?us-ascii?Q?D5fkw7psy27h1MeRmCmZQ4cjU+LgEaEBU9BdOdGadOJ2yXJLUcSgDFNrhFZ/?=
 =?us-ascii?Q?B6VXdQNa5bt9KiEm0/5RjLtzNU8q4f6F4y5gxu2lnt5R7ySFqHFHmep8Mtt3?=
 =?us-ascii?Q?/Q8xaInXObbJzxD9OHVanEcWR50UUpXw9fpbtKuBPfS8zIAdR7KA0kWyRqnY?=
 =?us-ascii?Q?4qCdFdCxxQR7FHTq5UIuJYA2DPijI2tM2yWLPJiObH/pw4REUCs9c/Do7REs?=
 =?us-ascii?Q?eLC1NB62l+KuRShJWS21D91vFki9w+3VnQfYBVwJ4GuYPgkqUYiorR91YuSY?=
 =?us-ascii?Q?q1d09ok7Mist43crZVSfw+cktu/OsQHkuxYEBViX37zRqqQj02LWTdL9P4zD?=
 =?us-ascii?Q?7VKAZHiqA2/dhimMlpiNjSdTAs/Go3cXKhywBwq+eaMe9eO/KOInV9SrplE4?=
 =?us-ascii?Q?tXWC1ZZor1cnQ+dP+mRCZMUs/IdxWLoCitbbja49L8cPruDDwTmQD6FNUe2U?=
 =?us-ascii?Q?nZB9dXcZRt7Ve2ucSzvjKBXBVwFG9R++m3nLwlDGI354xfvcEk1YQ+qTcc1P?=
 =?us-ascii?Q?8utjJspTwXeoNcm44mdhu/WNNEQy6aPo0fBpmpfcVfS9S1fF8w4hIemoTic0?=
 =?us-ascii?Q?LIRjpB4LhswOxu+8204iqsQ2w5ZzvvYTntRAeEAD6aDCyPrHCtlPiQBwp2XH?=
 =?us-ascii?Q?xZF5GHahHWdtfWxipJJR89zD1/OFUyKoZf3vxWpmRe682rS3VJa+Lz6564Yk?=
 =?us-ascii?Q?IBHUE/hoiECnC9z+5Ce0TwOgnFWz39FGZisQvm5iw3gIq6UsWikiGyX9I+SW?=
 =?us-ascii?Q?SYcyB4YP+PXhAYNIO4npwZelYO/wgzMqlKLh+fSnPxLrsFC6h/DyCzKYES/h?=
 =?us-ascii?Q?zJ+7tvNtJp6SuI76/TQBbKmcviXq7TYNb1XJrmY5SI9weJipMxOp2X46vuRa?=
 =?us-ascii?Q?7lvz101shN86Z4M+n4ZTU/CLSMNrtcGn0KyvXR5KelPGfxqq1io/8LZVNsvF?=
 =?us-ascii?Q?btZVMqPEhDMr7rlQo3yTy13kB7w4vjwPCMBDNx5aCQYwFMOGUsZPoNDrJ+zN?=
 =?us-ascii?Q?dba52/ssLcvoLJS8S/nVNx0E+W/LeLpFFMTS7EebhY3hKW+UVUc/z/yYSJIu?=
 =?us-ascii?Q?sy0zw3sn8gJYtzpc8RPq0fKB5QFJdc1zxlfOUbaW1BEQnhoIIKMY7za/IEes?=
 =?us-ascii?Q?MASN94cnHxF8OqAM8aHwX0nUt7NeStvD45kKQhEG?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 295b9fdd-18a4-4e0e-0c40-08dbf7f26d32
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2023 13:34:39.1118
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3wAcyKPwQK2tYCkpUICUNPLJWFfyNJueNyejPJOk8JWWmYwKFplQ4aqWD7H80v0v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7409
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 08, 2023 at 06:29:29AM +0100, Greg Kroah-Hartman wrote:
> On Thu, Dec 07, 2023 at 11:02:36AM -0800, Saeed Mahameed wrote:
> > I would like to add that debugfs is usually used to expose the driver
> > software states, as it evolves and changes with the driver code, but as I
> > explained in the other email, it's clearly not a good solution to expose
> > arbitrary objects of complex devices, that require interactive and
> > selective debug interfaces tailored to the user use-case.
> 
> Why not?  Remember, the only rule in debugfs is "there are no rules!"

We already have debugfs files to issue RPCs. They are not secure and
not lockdown compatible. Few users have been interested in this, Aron
does a good job explaining the general perspective I've seen in many
places.

Users want an in-tree solution that is compatible with lockdown. A
solution that works for all the mlx5 deployment modes (including
Infiniband native without netdev) and covers most of the functionality
they previously enjoyed with the /sys/../resource based tooling.

This series delivers that.

Nobody has offered an alterative vision that achieves the same
thing. There have been lots of suggestions how to do small little
parts, but not everything together as this does.

> Well, there is one practical one, "do not rely on debugfs for any
> functioning system properties"

Jakub expressed additional "netdev only" rules for debugfs.

  Read-write interfaces must be constrained to a clear set of commands /
  settings

Which I think is what Saeed is reacting to.

Jason
