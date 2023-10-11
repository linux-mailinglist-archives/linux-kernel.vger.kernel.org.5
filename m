Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 117807C5601
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbjJKN6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232302AbjJKN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:58:43 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CBB93;
        Wed, 11 Oct 2023 06:58:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nPWV6a64GFEZOSvW2teCciVfWf01FACXz9YeaZbyjxHlKgkk87srAVSvp7ZmOk8Pr1iirXvuvgqgw67jpOS/9r9g5ZssuEXsOIBmu8RCDrPRLjfQpIwTRTH0FzvOM7VXialinvzEDBIkZqFsbY7nqWjV6SIrJ7UqvE6FMVa8UEFOEw2o6AdNLLhxVft4AVAU+Lmh0UTT9HF8AZg+AfpzFWX6wdnSz7aYdGwXqybMazmYq9GeMWQXmzdl4n9TEc1NWuhZ8NYh1NclxRv4Ofz/dpMqPTLiaFDk9IhVSQTlIW2QFDi/fvasNWikvvM9vjqIcOexInKO+DpYtp8N7I5mvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=71xr+GQXY35SHTTv30uUNbCdAHhnu1YTq7YTGPjpb94=;
 b=QRvGfSSJ8ha6wWdM9FDWUZBPDHM/urN1uTgcfDxcPkIaGJlzSGewjimj1t6xRBrqRls7rRCn9G/oR/oKS3r1AH6EjAHab6atkwBSgayZIfRc/T0Jefn4HoUFaCvPGvhFVktDXjx9a+YOc2ubbQOrum/gZ09cjX23hCxSY31a2UAsemkl3g3Qx6KviiYW6cwECAOeE0gP4Cn4CunpfD5yeIGFFOSEtAIKrpmrCQLYByt4+vPYWpWHodnzNwiQESqPxWG5L2w220vGsLXkgWHga0QKfj6CkV+lStUEX04kBDPAD/FIEOUXtKMCWGhSR69PUQQDexfglkfDmdz1112mwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=71xr+GQXY35SHTTv30uUNbCdAHhnu1YTq7YTGPjpb94=;
 b=HabNCpYAhHYAFE5h94z+/HtYDxZDCIVtQrrVu6f7cn+KzqnlEnc7XAOTks68HuPKv4p5XOVCujAtvi66XBWIbpnZ9CBTaV3puCcdLX/jiibQG1evilsGtoPE5yo4YSslaUdte5qfhTYnXqBZwpfZlPV3rkdHj/e3pUxLyBdu9x3MokQzFbYIaWXH6a9p/YRiD9No2syfZtgy7v6ku3FQmcGEkOstmQqN9D7vI9UWbxXNsGCrU2+NKpJjy/YxS9LIQYG7qVUEMglm+QGp9ZBrUG2o8O3IvEcdn5HleJHN6SBCGl8Ak5l19mjTK1RzSE7I+Kr0dlzVySzxmHiL3MWYPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB8294.namprd12.prod.outlook.com (2603:10b6:8:f4::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.42; Wed, 11 Oct
 2023 13:58:40 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.032; Wed, 11 Oct 2023
 13:58:39 +0000
Date:   Wed, 11 Oct 2023 10:58:32 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Joerg Roedel <joro@8bytes.org>, Joerg Roedel <jroedel@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Nicolin Chen <nicolinc@nvidia.com>, Yi Liu <yi.l.liu@intel.com>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231011135832.GX3952@nvidia.com>
References: <20231011160357.292c84e3@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011160357.292c84e3@canb.auug.org.au>
X-ClientProxiedBy: MN2PR11CA0017.namprd11.prod.outlook.com
 (2603:10b6:208:23b::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB8294:EE_
X-MS-Office365-Filtering-Correlation-Id: 214f2992-5325-4b70-f79d-08dbca622c0d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vkzsihhFmbh9uO++OFf/f17HWseixMBlxFqQN1h3ZaYCOXCLIfFohyZRJDyymvEmkt3AMeJOiSI14/tE0C+F+WQvBQ/t3cCk9Q3HtFMkUF7Z58la90gwOnKmPJxPBQRMmbHtRTkg/EuQbRUpj2W5VRMLsPGssC2qQt4DOXpC4UtID6XLPt44B3k4VYCxvIBgvrZQugsjOEoqYNuyS9/8t+jz0STAjq5Qg+oKLmDdMgcdStZ35nC1FCDk/bocU2f8J4SWTbwyAEOSEyvJGPL5L4tte9DtDRi2UEQyiD+PS7Tg1An/91F/NPDhyAQcxRU9aUlmEXwGnj7y+IvK0MEga2fGXnqMnJ2nKt03Jn56iX7UORK/Di8OxBdWS95/vQ0FAe2Kq25H136a1WYiXPWoRZaKpxYCL4HJHw7q477BNRMwJgSzebnhPdZBDcAz7KBW2WYiC0yyS78q2hk/7+Vs66OjfVI+3piC3HXxoeYuupvyPvDvHrbL+bS5YcTvBczQn+NgcU4mGf2bBBNXKZaDmliiJF3Fad3rY0CZ+1eTsECvWGNvqejL1uNkGrWw3LMG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(376002)(366004)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(2906002)(6666004)(6512007)(6506007)(1076003)(2616005)(26005)(66556008)(6916009)(66946007)(54906003)(33656002)(478600001)(66476007)(6486002)(38100700002)(316002)(4744005)(41300700001)(4326008)(36756003)(8676002)(8936002)(5660300002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fD1MT1Jmq7MYmJWXSNEIRDkKynFnrpZyw+fpiK/wW7f1pebgWl1U2pVnXO6U?=
 =?us-ascii?Q?UzApjKBNpDqwj3PXBj5RiZRBrn+ymh0B9Im/ASSEtkcazJBznlDrkTytM2sP?=
 =?us-ascii?Q?Jg819aYTiYw9hl1DiImG7cltAJSWzpEcf+QLCwKZDNxxVlZBOpL36AIMl46Y?=
 =?us-ascii?Q?k6jrZCx9R2xv5C5ey6K5Zz2I/QcNkEcvD33N8rZmYlNJ6d8Gbgs/CtNiJDbQ?=
 =?us-ascii?Q?7848PmB9uqa/1+eYGbkUj2silKlQt9FFA3mN6EQUTWqNRUpzIe+Pfb+LS0hT?=
 =?us-ascii?Q?aHZUJ9gkGyeeQeYWqoCe9RT3T5ad2SsscBo2ssg95sTlC0sz1XIMJ8mTyno9?=
 =?us-ascii?Q?W2KLIxTepJ2HmzykppspjrQK10/dpaI5D/neFlMQoab3hPjCqF/dyn3jHHVN?=
 =?us-ascii?Q?t7eKnqqwrf9by+noLG0Y0ZbL7udKKip+7lTampAdfTOVE2xVdVrCNrtc/BWS?=
 =?us-ascii?Q?LNiNPnG0vhebTfA/lhmBbOLLwCbhA7TCXjmadOsDRvkmutdkAOcfYocbbtx5?=
 =?us-ascii?Q?baBydXNQKYbKCmYYL30x58S+26eFo6W6mH4lD9BCTqNxmxHkX+hRzJXAnKfP?=
 =?us-ascii?Q?q393Ku+6r2MNcxksCCa4qGqkONwTIxWPi2iHNZkxsBCLcRphSx9/oxt0DS92?=
 =?us-ascii?Q?f+TqH02XHT1XSBR+r3M9c+uNrn85hpxfk/+YSiR1YGOXzWMimC6DmqtOBCD7?=
 =?us-ascii?Q?n5tTtKWZDPiej6/76xz+lZW3HROMybiDOo4Kr6fiTjyva8m7u6z+4aWGspFK?=
 =?us-ascii?Q?hukcOk5kq1eq+XWJ+2Ma7wd8+L9dSPNFVt8f7OiZ45dtHKIEd0pslnKhu/Jq?=
 =?us-ascii?Q?10l1P4bUGUaTuWSeKIkMbzoCkHeHzAn48P76CbBWSxoG7kl7rEXdj3UdD0/s?=
 =?us-ascii?Q?JcNe+DDpiHi+4ufAAmLA/YzmhkHy21r8ovR5kFOwKcA4h5anRndtZyXGKMpN?=
 =?us-ascii?Q?tOloNhFajt9oWgm5ddGvLImeVsdFlnVU5+Xk5lhVr790MYHkFIm1LZLVqH3s?=
 =?us-ascii?Q?8S32k5TEyL/cgjSQz8BKAylUL3wrhDTHkEUNfm8Aax1bzqzZ7ycmsdCLf43i?=
 =?us-ascii?Q?TYuZvMg3L+1MxeGU8QGAsRVxXzqoWC7HwK0z/NLIBxQWtXSF9aQ3HZMjq8Qw?=
 =?us-ascii?Q?7CfpuYdWWcQVeRQuVDWdyjLWHFykqMxfZnp5WBhlCvTYL/ki6SFUVBklolyB?=
 =?us-ascii?Q?/Pk/IX7XEmC2diwiqhszB6fWsMiY5eh0hwp4XlGj6BTLcJpCymBnboTU9Dhr?=
 =?us-ascii?Q?bgQ8n9ygY11XkDD0+f2eyoHMKmIDwyWvTGQInPFw2510DBlnqWdkq/VYp9fh?=
 =?us-ascii?Q?vn2nFtZDSSUwnUFwgs24Ry7RQvWyUsZyBpzn4FywKpEc50KW6Zd0N7r+mEKv?=
 =?us-ascii?Q?eD1vYz4lTsmiiKv4jcpk8u+Nre0pmWiHQuXy/ghtYUsoeFUkhaCJb9iNrZ2J?=
 =?us-ascii?Q?4j/+p56Wll0FV9LhNEOqxfgdeW8kN3345Kt3DssjjciksjGha2PRjJoH9qww?=
 =?us-ascii?Q?U0K5OaxwlmJFni7St+y9ry3bPdyMpWdzja6fbGUECytK6HePmMYx25YTu1e4?=
 =?us-ascii?Q?mgKfZp6rRmvq7UYdD6H9hHlCtTsPnHEJs6HMF4/Q?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 214f2992-5325-4b70-f79d-08dbca622c0d
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:58:39.9093
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0lyhEMSfCo0j4q+0/ikwCjkXvS7GWt4m7ACCbClRLz3IWqHqUYDzPCuJtjwr0889
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8294
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 04:03:57PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> Today's linux-next merge of the iommufd tree got a conflict in:
> 
>   include/linux/iommu.h
> 
> between commit:
> 
>   4601cd2d7c4c ("iommu: Add ops->domain_alloc_paging()")
> 
> from the iommu tree and commit:
> 
>   909f4abd1097 ("iommu: Add new iommu op to create domains owned by userspace")
> 
> from the iommufd tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Looks right, thanks

Jason
 


