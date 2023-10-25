Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8B97D6B23
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343843AbjJYMR6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbjJYMRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:17:50 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5735A13D;
        Wed, 25 Oct 2023 05:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mH4i2L42tA303/Qlt+MYxktz9k1UwDqRp00xXNsiVTePwl9WAybNPyFGP7UNZ2cR045VEsC6x9lNFm4CCRuptCBl6JFiI5jUD3tDKJaqhw65FDLsMrW8xQ3SpnKSRxuMw3RN//+GdR4YqgcavjMuee59J0SRx+1Eq4AwjwY24chxMQon5FBntZNpfPjktagc2viTXR+Dzn6YBpQJy5IWqg+30ur6qTbWLKgCyoslwwWQk0U+eytHWrPx23vavUzQMJwrPZZQkpO60OO8kODKvGOWtw2Os8Sa86Xo1KnNQYfRVyAU7Jb60VnxEmHlVmvF9qt2xX/tS9Gypduer5D40w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnf3r+Rbps9XzCcfTWeZp3qmY+YKYvaFApFr+G+/KkY=;
 b=ONZWBzk8mUO06Ii5Yodstu/MfJWDz5dK9HysJ8n+w/YkR492Tb62bmvCZyBm1TE1CgKTevXNkVAzwljMwWm43n9jM67O7SJ/kvAH4JQAIjJsNwVs6oebNUni3zW/SwHKFw9vR3CbNEDotn5L/eg5jUzuZQCdex98JQ9GgBBMALIcWscNDyrDRJT6Gnj8b5lzjRHGRnGrhWbq8QYq2kEefP2FLI7kkkEJYDeKNN7T/2f+PDM8mSoK96/me6srbVgq9A7zXOmKjR9kktKKHXzaE4VMG+zZELkQqPZdr0D+78T3O+CDhYyQQe1GMixDHmr0rQnRBftny5R9CA5CPA1Rzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnf3r+Rbps9XzCcfTWeZp3qmY+YKYvaFApFr+G+/KkY=;
 b=AEJz42xaFx1IwhV6zd2mjkv+ItlSHszB9ewf6ExeTQO7Usj6OsRiS/b0PUbP8zy0TlWP7sfj3bllndetur4Vg2sHZBtnTDI4I/isTSJyGh7+MDc21ln6boaHHbsWoo5vTnmDuCaewXew0JBSlLSBE1K/i1NAeVF2NloxsmI3CyJDRFNve41EW610pAEvRn2pPeQaxD1eJbBUucqFmhjAAa9pgt5BTDmVZiz7mc9cfMqkC6JTSMQ+IvF+Tk62kErgslKr8ZICOID4+24RX3nMZnWRdJDGrE+BtL50ndM1WIg0OJA17GPtg4RlmEH8ociH49VFJCxQQN3yVXuSXUw+mg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7645.namprd12.prod.outlook.com (2603:10b6:8:107::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.23; Wed, 25 Oct
 2023 12:17:46 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Wed, 25 Oct 2023
 12:17:46 +0000
Date:   Wed, 25 Oct 2023 09:17:44 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Baolu Lu <baolu.lu@linux.intel.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Yi Liu <yi.l.liu@intel.com>, Kevin Tian <kevin.tian@intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
        Joao Martins <joao.m.martins@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the iommufd tree with the iommu tree
Message-ID: <20231025121744.GD3952@nvidia.com>
References: <20231025153455.283c5b12@canb.auug.org.au>
 <20231025121212.GB3952@nvidia.com>
 <617cc452-2d31-4fe0-a808-a980baa43056@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <617cc452-2d31-4fe0-a808-a980baa43056@linux.intel.com>
X-ClientProxiedBy: DM6PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:5:334::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7645:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2524b5-597b-4eaf-b951-08dbd5546575
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tLQOGkRyCp+Qxq/fwrXknNmj4VuvS3SmZD8xB87UzuIpi/Vrq9m1ZPk+T39FdmRa6lNM0XhoR168E39OesCUPhpFIP51iKC/Rwul7G8bsMsZ4WZ46SDNgOF0Z2ZULDBkaPDotzZGlqU/5qRzzLb49LhNyuAh/zbSaGMo7jPaqxuQm0Qzw5Tm15CKTK0pHaXUA2+WFO3Td2j5Jp7oiqUQFObXVm4JLEZEAevLfTpyk28q2u7tNdQhSWYIG3JUTSv5RrdwSdsU3kpsdQEyYpC+CJOzz/bEz7qrSueE+BeKQXtbBOEy/5vnGzhNQ/8xLOx0RJv8qrRLpl+4bdIu0rAvx7Vv06BnYnCzl7klt8FaK1F5Vk9hQsO+kNgbafKRXg1gMcPTuA2VRiZtoWx+c7WWghVBD5jSX8wgBkCd4hb5xpVR16g2HZ35WUda0tzdrQZkfwdD+ZENdHX58mDZozWfXrQ6WisXRj0CBsDqKMe3tmxaxgdNbHjx/o+cpC362nPRrwbTU7po528Cow2v015a62IQFykBkzsWZNV77T/yWsUUhB2B1lFKukGhjzMGcFj+
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(39860400002)(136003)(396003)(376002)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(83380400001)(2906002)(36756003)(38100700002)(86362001)(33656002)(7416002)(6512007)(316002)(5660300002)(41300700001)(6506007)(66556008)(4326008)(53546011)(8936002)(6486002)(8676002)(66946007)(6916009)(478600001)(54906003)(66476007)(26005)(2616005)(1076003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVVYWXdpMW1TWXZQdFRzcExyaDgxWlBuRzU2d3lDRGYxaEY1WGErR1Y0UE1I?=
 =?utf-8?B?cklpa0RlR1RnZmhMTzFWNEE5ck9YcXRnVTZKYWpENmtGL1d0SVpZSlFlN1ho?=
 =?utf-8?B?N0pBSkxZMDlJVUZOMk5aZHhiSjVjcmtnVURwZi9hcjd4aHdVNjR1NGRrVTlP?=
 =?utf-8?B?WDZ4M2RzQ0FhYkR2L1J3VFptOHlrVWxtZTRpb0k0cjNlQllycTNpM1oyUEJE?=
 =?utf-8?B?WUFqM0ZCaGJVNEF2VElwREViUWt6bUlBUUQrMldYU1FoNUFQU1J1Y2xSa0VE?=
 =?utf-8?B?aDFocVFjTnZxZTU2TE5DdTdxd2dmUXlyZGU2b2pvTVRiRDlINC9YdGkyRkZQ?=
 =?utf-8?B?VkRCYzJic0VPYnJoM1c5ZGFYMkNGRTFrQXpQRTdvS3VWdy9VT2ZmM01GNlZZ?=
 =?utf-8?B?UVozMnUzM051bnRvRDRoTDl1VkFsTTQvUVVraDc4Szd0SmhZbUk1OFpxc3lv?=
 =?utf-8?B?NjhmU0lXVGJZU1p2T2lXTEdsSk5lNHRVM2pDa0dORDJZcy9RcTJUM0tENnJi?=
 =?utf-8?B?L0RYOWtjbC9kVGRkWWYvaCs0Zk55WWNFRkx3cDRPQmt0UmNkbFBNdDVWWC8v?=
 =?utf-8?B?N01wNENLc0NJUmFyOHlSL2t3djMyTGpPNWl5TWVJUDA4M2lCQmFyM2wvS2dC?=
 =?utf-8?B?bjFmMGI5OFh4L2dPZnpZYm54YnFVQjIwd3g2WEd6WGxOZDZLdDRnVWJZcW9X?=
 =?utf-8?B?NDg5aXBrUndXSmIvSTkyL1NnRyt4R2tuamZzdzVLbUorR2Y5Y3gzRlE2YUc3?=
 =?utf-8?B?MDI3L0JDOWhsNm9iV1FrRzA2UFkxNk4va0N6a2pUY2Z6MTV6YUt1aDNnYytV?=
 =?utf-8?B?eEJ6VmxmT0w5T0NybGZGNTEzeDJjRkNQNXJPUTJYdlA0VHJ5UFYwQklHRlNm?=
 =?utf-8?B?TStGaGJUTUN5Qlh1bnVWaFJzMTlrT1lmZk9Wei83UmZwOUx5bWpjN0sxYzQv?=
 =?utf-8?B?c3YxQmlZd1VLV0FIcTJBU2JzMnNhWWw0cW5JemY1RUxySEloQzI3WXF3TjhN?=
 =?utf-8?B?U3RGeC9XTEtpUVFjb0pDejhnSTRzZW52bTRpc1cyekdsRCt3RXhkTncrcTl4?=
 =?utf-8?B?M0l5VUxKQmJBVWNuZkhFeHErRlQxOVgyODY0N0tVNnR5U0NQNDd2ai9BYnhM?=
 =?utf-8?B?S0dkM2tjc0l0ZWVoREZBNEZNaENIZ0xDNHhaU0VoUk5NbUZoNjdOaGdBcmIv?=
 =?utf-8?B?T2syeFNnODkzQVBPT2FOc09sbFp5dDFBdzVRaEFZSDVSb0RiMlJDd3l0Mzha?=
 =?utf-8?B?d0lnTXZzWUExQlg1SDZYNkx5enozQlhUYUduZS8vaUpTMFpXKzNCSlk0SEdG?=
 =?utf-8?B?aXhld1ZUSkJ1ZU9JclNxUmVmOFBYTVNvbUdnakNDbjBsSS9jYUFoVHAyVGVa?=
 =?utf-8?B?KzZDY0U1YlFoSWJrZzlSK2RSejdnT1dSbHNTMXA5MUJPNW9hM1NZZEh4endY?=
 =?utf-8?B?VTQzTlRZY053TEZZOS9VQkJudGN2WlZvMmRvTTdBZXFQK0JXbGFuVjUxUFJz?=
 =?utf-8?B?Vk4zNTVtZnc1dkZnMWhYTWE2T3V1V2dzVEZZck5UazZ4VWE2WXhxajJsRXNm?=
 =?utf-8?B?STBhOFMyblp3ZU14UVZVamJ4dFpFcFdNQkJRaS81WEt4Q0NtZXUwNi91cnFH?=
 =?utf-8?B?RGREK0U5RlZvRHcvYS80SWVzK21FRXBjT3dlQkR2U1NLUGcvUWc3QTBDb0xK?=
 =?utf-8?B?ZHU5ZitIdkhnOTcxVFdFYzhjcm1FREpkZFJUdEpzN3I2Y3B5cmt2WTkyUDFX?=
 =?utf-8?B?cmJJWXQySkRZN0ZXN0VWWlRON2JYS2FHY2dJVkd2MVArZWNob3ZiUHYwdWRN?=
 =?utf-8?B?WUlUT2JLWkMyTDRXN2t4N2RUVWlCcVNKY2ZIcElPNC93SkZtNlB5RDBGdzJ0?=
 =?utf-8?B?VkVnNDFYTzA4ck5JOXlkKzNqcEYzajJCbXFXOVFocktXZ080Q1lzWFpnd0tm?=
 =?utf-8?B?SGZXdG1nTWQvckllK2RoWmZrUVJqNk5wa2VGSWVoOEhRc0hMNHBwUHBlUXh0?=
 =?utf-8?B?bDRyL1MxT3hRZWdCVnhmUis1RHRLRHB6OWJzV3lLayt6NFBWaXJaQ1YrUEp1?=
 =?utf-8?B?WHNNMW5kanFuckRBTElPWFFxc3RmTnVneEZKdU12MHFMR0pLeG5yVmh1b2lL?=
 =?utf-8?Q?/EOJgsk/I6IeYyLzbArmeuPs/?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2524b5-597b-4eaf-b951-08dbd5546575
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 12:17:46.0313
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oFdowPtqCKT4Lc6DOBGl4MqHzaZKveF+tRMkYMo5YUjDmPIDynKBM/rqfPHzOYZL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7645
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 08:16:16PM +0800, Baolu Lu wrote:
> On 2023/10/25 20:12, Jason Gunthorpe wrote:
> > On Wed, Oct 25, 2023 at 03:34:55PM +1100, Stephen Rothwell wrote:
> > > Hi all,
> > > 
> > > Today's linux-next merge of the iommufd tree got a conflict in:
> > > 
> > >    drivers/iommu/intel/pasid.c
> > > 
> > > between commit:
> > > 
> > >    c61c255e114c ("iommu/vt-d: Remove unused function")
> > > 
> > > from the iommu tree and commits:
> > > 
> > >    f35f22cc760e ("iommu/vt-d: Access/Dirty bit support for SS domains")
> > >    cbf8b441ea08 ("iommu/vt-d: Add helper to setup pasid nested translation")
> > > 
> > > from the iommufd tree.
> > > 
> > > I fixed it up (the latter added a use of the function removed by
> > > the former, so I just used the latter) and can carry the fix as
> > > necessary. This is now fixed as far as linux-next is concerned, but any
> > > non trivial
> > Intel folks, this is not nice 🙁 Why was the first commit done at all
> > if the nesting series needs this?
> 
> It's my fault. My apologies for not realizing that the helper would
> still be used by the nesting translation series. I will be more careful
> in the future.

Can you send a revert of c61c255e114c ASAP to Joerg please?

Jason
