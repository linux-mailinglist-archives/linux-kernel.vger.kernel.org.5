Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2F17D74CC
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233233AbjJYTvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 15:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229548AbjJYTvr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 15:51:47 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEFC18C;
        Wed, 25 Oct 2023 12:51:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JquuV03sx7Anr6f3GPlfTgF7WgP/iTUy3guKO/877fke4xAPovqViI1jOpFRYoH9+0rnfKZoc4hwkzwqwqXlxOu+AZH3T5olXlo6Ms353D5q7Vb+yZplcn3qqKy+0juUPxZGeoWJpOdQuPXdi2WdHrSsqg8LsSFJID7fAfjFlM/1SYBiYr3KS6t2cKdP/ilJogoWpjnig5jcD6pNxIR08J4BIgRd15wZfuXZShvoKW5oWpvXeOv1ZjyswKkKA6DwxL69RFRHjvwlYAvX410le9xQSa1G9DZ52s156pNrCtHhaAAAYCjtdmy2iZy0pJDlz5gSAj5pD8BPWO3ez6rnmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7jaCupvYbix3cEDiqwcLWypEDWYaUsfqdRNPOEwTU14=;
 b=dSpQsjToneGaiaXDEOgG4qdoIYmQB8Dx7/yF7B1+nhFUG2Jn8xacBbGWWSYA0PXhKw0lV2MKAjG4yWM6kC537ALwQqmheeMbG/sRxTnkhZPMXiiRwPFKTyHbIvEaLEFxsWOPGlcGabPcc9M38HcsIgR3NzYm79EmO2qJfmp112YrjOjwRa7n+k2/66B5B5dCEx3t0QFWfzGtiHXzfkUSVwzgVfWRUPE4lenqklt4bV3/Vbv6fPv1H9ujlllVpIduRMXWhu9NLIOdYl7EcQSTeF4V3MS3m3L4Il7Rti61j/R4Zt9oG7c1DMutLep/veK20u3pvueHgxK45zsig2MRNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7jaCupvYbix3cEDiqwcLWypEDWYaUsfqdRNPOEwTU14=;
 b=Yhbu1T10mlBvG0tlbJ5fUya9nO5Ls3aqiHEBeJ38m1TlR6iFgGjK1atsynzZC4JNANvFooi1IHDRJb214ch187WrovzfrsiNzQrWR8t/MJDbtMuoSQeOgmj/Nt8JWjJXCAPs8LwGra5UkITs2sK8DOQM/BQ4so1jbr8qMK1tC/4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by MW4PR17MB4793.namprd17.prod.outlook.com (2603:10b6:303:10a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.11; Wed, 25 Oct
 2023 19:51:37 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::381c:7f11:1028:15f4%4]) with mapi id 15.20.6933.014; Wed, 25 Oct 2023
 19:51:37 +0000
Date:   Wed, 25 Oct 2023 15:51:33 -0400
From:   Gregory Price <gregory.price@memverge.com>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org,
        akpm@linux-foundation.org, sthanneeru@micron.com,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Wei Xu <weixugc@google.com>,
        Alistair Popple <apopple@nvidia.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Subject: Re: [RFC PATCH v2 0/3] mm: mempolicy: Multi-tier weighted
 interleaving
Message-ID: <ZTlxxR0ntEzBPwre@memverge.com>
References: <ZS3jQRnX4VIdyTL5@memverge.com>
 <87pm1cwcz5.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS33ClT00KsHKsXQ@memverge.com>
 <87edhrunvp.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZS9HSIrblel39qrt@memverge.com>
 <87fs25g6w3.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTEud5K5T+dRQMiM@memverge.com>
 <87ttqidr7v.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZTfjqoEZXQWs/rxV@memverge.com>
 <87lebrec82.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lebrec82.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: BY5PR13CA0036.namprd13.prod.outlook.com
 (2603:10b6:a03:180::49) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|MW4PR17MB4793:EE_
X-MS-Office365-Filtering-Correlation-Id: 63f13c64-d370-47b1-7f3c-08dbd593ccd7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 24ZXxqctjNfkJwqzRpCJpbqOM9S7g4tjszwmcoC3ugMxnB3CTzAknaRnBnBJYUzdwo2KmNvttyXcvuwxBqX2mJTlpcOhaUDU7H08jZbYIFJJfhYA/v+5b1riYrHAUcqNdro/w9JC84CdCmPdZa8dWQ2IFOy+s6jaFJlgEtqcWt9132mXtp7zN6EfbW3He0LAVDR1JmHIuIgsf+RBYAdMFYYDlsR9IjyrYEnd9oMkGtX5gMs5P2/G0Azad7fd+mfjEEWpDnirV2T37ZTgfSS9FiSRXG4YH24l/bm2exM2N1Oa4vje/7VKulwIs8Nf2KU8HkU5z+2Z1PqWJeFUE6ahCKh/Xm3yettOgIHePip5oBUpc+Q/tWs1HfpRiN7gkaRwMKqz91kguh92Q737d4D/OtD6DEKes/vIEyjSk4tlZwy22BYE8a22Y5s78yW2yAuATIpjnERWBDJlwogStjXogr+4TiUR3yXtLoa4I2Mir3iWeHXm0++YJi/qpQRaYaONchpRIt6HPUCnn+CjByNK85Vl643iLFBXhLcy7w4ZvXzjR10N8hlqSzcjdSf+6GQg/gGjblxSWa0b1A52nc7mBajm9s6VFCckNoXJ1LJLAElIJ0HfbjL+GuAr50N1Cl/r
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39840400004)(396003)(136003)(346002)(366004)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6512007)(6666004)(8676002)(8936002)(6506007)(83380400001)(26005)(5660300002)(41300700001)(4326008)(7416002)(2906002)(6486002)(44832011)(478600001)(316002)(66946007)(66556008)(54906003)(6916009)(86362001)(66476007)(38100700002)(36756003)(16393002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uI8ZH1v1IyG5QbE4uDCXACfjYdYK+ZBbxlrd+KA1r7ewsV0fSLAiXCqEbNVm?=
 =?us-ascii?Q?8OGC+IQhe5Q1BA4W9h97LA09FGFFZqiI01/bqqhXna5pae6b5Z87BiC7CeHI?=
 =?us-ascii?Q?6yZWF64wJyTkd0sz8XL1ayBNxlp/fEjzyS00EnIq7qKMYfarih1TMB+o9mu4?=
 =?us-ascii?Q?/s/mBo+AOsvR7ayyW3iq4EEfZdmZ4tgCCOdcvTZCtimwBCpqi6Qezaw00asQ?=
 =?us-ascii?Q?WDz2AHmvbo6Mr4R2zW0h3PjMoEpBJ1qX/xddUPOvZJJ/9hOOTOemjLSlTR7/?=
 =?us-ascii?Q?pT4MK7usromOm88y3RSDGJBoHZGDqYF7ywlZYKJOGNgC/5d9GkLYpHL+IIV0?=
 =?us-ascii?Q?VyIedp8PycyL/AFn1VcuD4Ct4NrEjjoIfjz6DvvUfjQ1oQFVi8QI4FnwXG8w?=
 =?us-ascii?Q?Cy84D50mRKIk5+cPeTH6oaLPNOQl1uB+kskC+6h9oLoNRiJWJFe14dr86qJu?=
 =?us-ascii?Q?udPAv31HXHWUD+cCIrir+kfauGKq3BVn+pvVG7BZZGvgVTqhskdFQmGejGB5?=
 =?us-ascii?Q?XKQIDRmJ+dutOdP8CFHCnp10KM4+NByeSd51IZ3ssxo/TUgaIuPL6r7MBbaP?=
 =?us-ascii?Q?O6hosXA7fT0pjUrpE3pHIGaS7u+RDs8TNYzgFQTnsV4YjIBjEnMajzCTIaLT?=
 =?us-ascii?Q?KucwSqw1mTBi+ztDlzwG8AlP7bA06rSFXEqEpbOhzBKiuK031QnWFFv3kCI6?=
 =?us-ascii?Q?5Y8gr9GvofCooREd+/JVQiI9FGLpJ5MJo96NWk3e2v7bCOGBNZP1dIOdz69q?=
 =?us-ascii?Q?FQYfRYeVJzYQfHd3fB3/RGDV0o3zhsE8FskhvHWLYbosmyfhGMnl1L29OazS?=
 =?us-ascii?Q?LICMq3b7WZNeSUeZmPSMpMEnFoGdLjTr5+TBN3mxzt5HB9qsAcFNMVgsuUWS?=
 =?us-ascii?Q?o5vQzTpVdheK03EiV3R8T0l7bDRJ3GGvGSFB7dBqdBI5AYedqqs7PQJeZ6Uh?=
 =?us-ascii?Q?OogHX1+LSHB2tSe2XGsBOYiX4aem+9flnmao8LmsLB77mx+4UCnTppOnffoC?=
 =?us-ascii?Q?EtXWebVDMdLyHuz/S11oX62ik7vNW9OkXy1AYrY/sYDZoTHKwN1TLfrVthje?=
 =?us-ascii?Q?rPiQgMzE2BU6ivyZAZ8EyqmJN8eCg8nNFefTG92YaCH+14+OyCwhYvRH1rUU?=
 =?us-ascii?Q?LzC0wMhJGpNUQbs7NWXwq96kca1sb9CmJAv7wMagybNMAGkufrhwTP/sdGiG?=
 =?us-ascii?Q?6FE4ZULIIrKD5SDYb5+L8jRmA6/Ro7nnSrI1Z+gVryeZHdkGpu/C/Ze/TT/Y?=
 =?us-ascii?Q?3KlYQhovbLySLunWw9YU4vmUU8VDP8onhryKfzaOKut5E4die3zV126qw1TU?=
 =?us-ascii?Q?bWaiBFpYNI0gNkRVvvWt8GDM+aBrIJMytzrt5WLSVfdzgQdkCcNZoK5gfyYD?=
 =?us-ascii?Q?tuqVUy//Lf/Tmg4YKnl5yM3jQFsGDmFK5hHzQXSNdImAwIgxtcLdiF05E18d?=
 =?us-ascii?Q?xQv7tfmngeN7o11yItIgv+2+LHkG1DDq4fnOYncWa4drSNh8brniRvZdQbkm?=
 =?us-ascii?Q?dh4KjZcen3rToax7ed1kPZ/NS+NWxMTTg8nSu+YUdOzd2BEZtRdM82Dw9bqq?=
 =?us-ascii?Q?ZL/xxolUOV5y4+EJvan+ys+jV0Hn0gpchGJRitUU+ZcnheHNTWaG9vMPzHO+?=
 =?us-ascii?Q?jA=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 63f13c64-d370-47b1-7f3c-08dbd593ccd7
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 19:51:37.8394
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6iAJZSqwk64oVX4sP5wkFnJTXeMHpnC7EfLHNvpeBLtOoiT5w+gdKw7brYC0vagowrOEuFBO/IOcmo8l9b2Miuk7zk6jmm7CWDLcoEvvzbk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR17MB4793
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 09:13:01AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> 
> > On Mon, Oct 23, 2023 at 10:09:56AM +0800, Huang, Ying wrote:
> >> Gregory Price <gregory.price@memverge.com> writes:
> >> 
> >> > Depends.  if a user explicitly launches with `numactl --cpunodebind=0`
> >> > then yes, you can force a task (and all its children) to run on node0.
> >> 
> >> IIUC, in your example, the `numactl` command line will be
> >> 
> >>   numactl --cpunodebind=0 --weighted-interleave=0,1,2,3
> >> 
> >> That is, the CPU is restricted to node 0, while memory is distributed to
> >> all nodes.  This doesn't sound like reasonable for me.
> >> 
> >
> > It being reasonable isn't really relevant. You can do this today with
> > normal interleave:
> >
> > numactl --cpunodebind=0 --interleave=0,1,2,3
> >
> > The only difference between this method and that is the application of
> > weights.  Doesn't seem reasonable to lock users out of doing it.
> 
> Do you have some real use case?
> 

I don't, but this is how mempolicy and numactl presently work.  You can
do this today with the current kernel.  I'm simply extending it to
include weights.

~Gregory
