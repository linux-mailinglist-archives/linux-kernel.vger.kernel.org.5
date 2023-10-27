Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DFDC7D9663
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:20:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231519AbjJ0LUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0LUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:20:22 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2074.outbound.protection.outlook.com [40.107.92.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1334129
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:20:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EcgGHVtNCCs9sqh1qeU/osLyG6BbYm+GxnszkmX1ZFotL3PWoGY/L2TuegruKEFvpnT3YDIImyMLaiBd4+itGFwZo1D8bn0J2pktbMw+5MZFj6ckjbz3HzBXBfLW89jO1bNDbPltWgkv0MJJ7wBojVpzTZfbLRerr5RcF9/eFF0C1xf4ZUlNx7MmSuw9Hj5Y7krqtf5bXpAwBQm8glCxzwhfc8v4gbCKoewN2sjt44Wl7qBadv9MkeudB/FtZpSStY9fLoxfzt7J1zNWVJdO0+Bh2F8bL9HdbtJP2i6FJTRPXyxzAzsOEY15DPBMfR3KeFgOB0TnL+AWElERJ3W7Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TR6zTnnP/7DpWxL/JlA8wXQ8nnCofJrYxj0bpLtqLC0=;
 b=USLaABJi+/Jr4BkU6Gdwr4Ct7mHJO+6aaFwzS+l/LPVPtARdyOzwx3hUahRMxrNw91gmKKDW/+1V1vO3ETqvIzXx9oS+DJj3npbqg/2VujYpQojaAEIL/LyaHVq9M+B75V6W8yPdtVbO1u4RaDPt2kTvVnrnW36HIKE8Rg/mhGWvNEUgJa+49mirnTYZyoUi+NsMS+TgMyiX9eHNpl6nuK5xcyhQOPgsqC0DwEkTuAd6tiCMQiNnjNU5+vKS7HOGCidiTZeaRqeoz35uvgR/omzV8u+JdDKiF9Fuebj/edHEy7Pq2i33nMdhCrRKXw0sEFm9HzIJj/r+ptX1FyaaiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TR6zTnnP/7DpWxL/JlA8wXQ8nnCofJrYxj0bpLtqLC0=;
 b=j2U6vEBs1rYymwAwaCBQ3Ny85EDnannkhHv5tkaFLMQlGVHQs0ja5+qBrpLDh2N+QtuwOPSgnh9z/jrraSfyEHIwBRokDRlGnQgW+FCaRocBXE2GFFO85jsuuD8BrdxhEErmbBmP64Awe4Bh3+oJLqUj+nMxtF4E/w8CD4ySsqVTyfPqMxxLXvyLh3SOEy0E8+dzxriAWkOk8XqYx1fEfw3WlW7Rmo7YW6aeGXLxhqyWsWcR3glsKBBgBQTlMfH0IJHKv9je0618kS6QshSO2R5cKkwir0cp0inpt1d43Wi8QqwaIczJpkoDV+URT2ZzKZQo7xEh0cH0LnNC+oKb6A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Fri, 27 Oct
 2023 11:20:15 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::11a1:b0c7:7c88:9480%4]) with mapi id 15.20.6933.022; Fri, 27 Oct 2023
 11:20:15 +0000
Date:   Fri, 27 Oct 2023 08:20:13 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     "Zhang, Tina" <tina.zhang@intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>,
        Michael Shavit <mshavit@google.com>,
        Vasant Hegde <vasant.hegde@amd.com>
Subject: Re: [PATCH v10 1/6] iommu: Change kconfig around IOMMU_SVA
Message-ID: <20231027112013.GT3952@nvidia.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com>
 <ZTtixEgSkBI-TRro@8bytes.org>
 <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <MW5PR11MB5881463F11D86198291EB52989DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <MW5PR11MB5881463F11D86198291EB52989DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
X-ClientProxiedBy: SA1PR02CA0017.namprd02.prod.outlook.com
 (2603:10b6:806:2cf::23) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: f59af3e8-bcf3-4b47-8389-08dbd6deb190
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Bp5amjY7ORYkdjL/yWW/dKer4ZiBnZSOW58MRfEO26H1geGLqZFeUK1BEhpoVAHQlbSBWTPtqZIvMjYkoBtmQzjS8E3gHk+rUYKreVgbY9A60SDHp+jcA0Ok/t2SLl/T/UeAFQoRsuea3RtK7LgdK2XCzmHliTDQcqwfYeHyHJk1nm5lfxOmrwk0o0OmN0yC+l+KVxiiUP3IiYcKJA0MJsiOagziiNUCFw1V9dw4Fdn+WgHSze9neqcnYhMkNw6+X31q4HTHDj7cdPZRDwFm7Om8uowyDqG9D/uAQe2PXBgrX0386+hJYhtZBqw5XUlAVBTUGI6ewlQ9ZprJWKLS5N3tZS20FAVA9fxDMVAfWgEAiNoYb6BNnYX2JiB6Z/xYrlZXJ8lcITQqY+v9DBkWP3onjzhAaDmchxN98hANrZjfecYfkunn9oq618P14a/GxWpSBqlqi54iGl2Y4aPqHnA85ygANm85+HWCN8gvbQx1zzgnft5ixldnPyWOzsEy+4bUIlEKwy4e2Is7ipWTzv4sNPkw9Kvi5omYJRE5X5ZHw+b9XLRGAnrnhS5SEPreXynP5OnccLeljfYtW/gHuQXg4VRh5NUuDkdrmk2Tj9Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(346002)(376002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(6506007)(5660300002)(2906002)(66899024)(26005)(1076003)(7416002)(36756003)(4744005)(2616005)(86362001)(38100700002)(33656002)(6512007)(54906003)(478600001)(41300700001)(6486002)(966005)(66476007)(66556008)(316002)(6916009)(8936002)(66946007)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jWh/aNs+OSWDAlNHzSJ8OpKQtPR5RMu8N/SehMntYsSR2i264WMxuAVpdrqJ?=
 =?us-ascii?Q?zq1BY/6OEJFZRbu8QEVnRSwR4/b/TyDrKkz8MuDF0ohn7cwgDhLUtxpQJeCG?=
 =?us-ascii?Q?kQTeEWLTSC8BTXiMdIp9wC9d6V2Kji0jm9L413iF9AgnD3/Uzidy+WmVZewc?=
 =?us-ascii?Q?YDBwlSJ6z9hIhBy1me3ct/o04yIHc8FqwxBli+tPVGMVfdzOzj+lfNSNow7p?=
 =?us-ascii?Q?SgscmIzN5FPB16TnvuE9+qkKHnMYBXkkquf/M4qir8YAmIhKFxLu45bCPOLn?=
 =?us-ascii?Q?3Pjey3xt3DXWuIs6pto5grO5hzFH0GvpKvvjvrUqhNLVOVT7nku+ZHO/Td6f?=
 =?us-ascii?Q?+sYKoOxSmjE5ijYqMGb9ZR1nIZ1DU+qeipc3yT2CUdBbI8txQuY5CFG0NpOq?=
 =?us-ascii?Q?k8whuluXUNyF+DyDOpQuehEAAmIiK5qKTicVUINROnaMw6tzli1p4Ra+YhQ3?=
 =?us-ascii?Q?wsTbPaD5FQ1HYc/7ZNMCO5TKNMQ6SlDP6G36BJjLFLJ80XYHlhFxAiKdBzHL?=
 =?us-ascii?Q?Odnb3CCCYbM5jqKIby8IoAD9Gcy9YLjI0LbBe4C/vEejHmEHxARGbyDtdabX?=
 =?us-ascii?Q?vxU1ipawPowAAUmw9IqvQG+7sekNVQaytUHVmh5St4rh9ASZGCpRjXYUjjYt?=
 =?us-ascii?Q?/O75zZ9M/Lc9pI8uiEhAk2cUaRxNmSU+yiVvD+kHm4zhJwQm3sLEw7g7UHsr?=
 =?us-ascii?Q?RJBFikBi7KmXm8JlYm3z30tFedftQrK3/B81WAq6T3Ng9QECWjfaeoEM1ca6?=
 =?us-ascii?Q?zFIb/0skRYUwyzNdsWbrOrMo2eccauV++c0QcU75m8g+EUxP0ofES1fOlju6?=
 =?us-ascii?Q?2umPMGx5zbbakA8KOo9sRdektH1SkPBJ74/+TwQKyukM82aUuDKmI9e++32T?=
 =?us-ascii?Q?P+MHRJ3BzC+zorxBHgpUpJ44xSGvTx1IIGk4itX1J3xc3L7QC0OfYKGd7LTH?=
 =?us-ascii?Q?UNA3Z99O2HH+SrLl8xU35CaheD9KG4JmOHZQa0nv3Dyu8cuZuMbInShnv/BT?=
 =?us-ascii?Q?+ZHSr5uiRKayO7+0PsTGsgZsRUKpsmtsBhLzBTLsdi584Upazf/gz6RS7ZCw?=
 =?us-ascii?Q?4Ogx4MzIqZdIHGsn/HOTK68MbwKfTc2741qR2s/O1qN9sqB/WE8BxTUiTtbn?=
 =?us-ascii?Q?/ZgNWMY6DLqb7oeTM38iqH9TsmlC0wseFS25Y4HjEnQ1gXUlN6MHh8nolaf5?=
 =?us-ascii?Q?gu+6YlZe7lvOXqGk38wMneOB+Y3+pqt+SrEuv9xsB+sPUVua2A5AszugDPhh?=
 =?us-ascii?Q?FrwncVI/j8ZsddzRFDg4SA2iJbdgbXMOGocjubkVQPEQnL78i6JqOMjzXVvj?=
 =?us-ascii?Q?vilRQl8438t0vQXjWe5/jwwocVd7Ou6SvnEgMXvIKVsDod6KSz7cIQ+gpX6U?=
 =?us-ascii?Q?fFu1CVtVmHnU0kXaPm+1K2RXjVbZGmOxW8gA0ZliOAaXXssw12lF2LpdZ7iz?=
 =?us-ascii?Q?l2spU0zRPLoB4w30cDJC3Y93qqgRApoFSTBAgEfzazZxa2B6TSHbsFX89qbL?=
 =?us-ascii?Q?1i1yrN26nXtOlBsI3oIL/FhcL99Raqnzks2jlQe5e2MP7sibhvDiZ2w79JXV?=
 =?us-ascii?Q?2/+uFUwij3YPN2qHXG66Qj9MBE/1rz8Fk+LnauGV?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f59af3e8-bcf3-4b47-8389-08dbd6deb190
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 11:20:15.4371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G2o5X7x3waHD72R/mdJCAmvLTswTTNZ7vjRB/Xf6UOXEdpJaHbBtdj4bjPV/ZeUP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 09:14:17AM +0000, Zhang, Tina wrote:
> > > On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > >
> > > > Linus suggested that the kconfig here is confusing:
> > >
> > > While this patch looks decent to me, you forgot to Cc Linus on it. In
> > > general, given that it touches a couple of core files, I'd like to
> > > wait for some more people to have a look at it and not rushing anything in.
> > Make sense. I'll CC Linus. Comments are welcome.

> Can we separate this patch? I'm thinking about CC more people for
> review. At least, we need to CC all the reviewers of
> https://lore.kernel.org/all/20230506133134.1492395-1-jacob.jun.pan@linux.intel.com/
> to this patch. So, it seems more reasonable to separate this
> patch. What do you think?

I think that makes sense, let's go ahead with the rest of the SVA
series and we can do this next cycle. Bikeshedding config names isn't
really critical.

Jason
