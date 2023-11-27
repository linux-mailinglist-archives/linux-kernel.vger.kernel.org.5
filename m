Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9BC7FA8ED
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjK0SYm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:24:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0SYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:24:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2082.outbound.protection.outlook.com [40.107.94.82])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE319D
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:24:45 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AganCKeLma5OF3Vlk2NMEH37hjIDLMcu8wd1rKYgr6eAGkcrWVbtLx7Gdj0fFGO2chOWVCPpFQVYvu5aTuZOSo5p35toAOR2finF53QTTPMT8ocV3GhU39/hrdRKuohnFXC8x5qtS6Q183er6V3ArSzAHMq9YGm+dWVKH7Wn0y/BoNxXIuN0si2XANY/XTEmcjXbPgcj0YQgW8O3YKcZKJmUf/+ISrWuf1PwAr7eyxgyiHTV2gTc82ThLdQTmlKUP0TcYr/xwKaDxBZz93hRvdF4NbWRPyYyu4BInTa4Yvso0p5cAMb0Bnaff1YThR+hPuos5d55yCF2wJaK929/6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L0M4rJBG78WTscU2wCu9LDRFgV813XbhwLbQ1rWo3rA=;
 b=C+tz+fJCenK1h0xnYqiD8flPE1b+6YtTxCy3J6MH/FeDjL5sRy/reYRV6xIinkVTS2Aa5SKtLNAlORehtJTvx+K7Y7LrilDEfErUpdKKNlV83n6zd6DhIo0I3Bjb+YPHZ5skPPZiDqM0noKvsS6z+HtHamYdkpvYEpSoNOj942u7Z7J2t47vyr77Dxyljws4Yu39yPz4U5ZjQe3uZ24H5/1R8uCPJScnj0DDzuCnPd2ADScgVzHqDQTvE2LElxtAN8nPIzhEhKk97O/5ynBYAVfEd6U+kvO/3TW1fAWMD8wq9Q+JN/6l84tVVAbPB5LvZ2wA/+YTl7rvGWJulDl8lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L0M4rJBG78WTscU2wCu9LDRFgV813XbhwLbQ1rWo3rA=;
 b=t7SnkELpCQ9h/wbcPdgqGA3zsUweIdY9hPExJnOcEzJJNPXKRCp8JbveqVCpJYPVukHYnY7UsAhXUqluWg18m/NNxEqCaO7yQWtn93AjDQhOpmR2nnoy4y1ipmWwYM0joqn4VI5TBDDZt1z9MB1UqE5FFxQg0M1d0r2B7uiA++mtQLHquaG3cPrrIM3dERq+5HU1AIwtHe2EVPMDFBvLLgBftyMB48tHKXHx5vMZEf9doMUq/+1gCSzuABuZ0LOLuRUjYJwxeI9ssv8h9OJLed9y7hCi56YhZ7Masaz7wu89GOl7POxwvDo3kB3y3N9J1KTKXtWDx4rKEp7ewCWWhg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 18:24:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 18:24:42 +0000
Date:   Mon, 27 Nov 2023 14:24:41 -0400
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
Message-ID: <20231127182441.GA1170207@nvidia.com>
References: <20231027000525.1278806-1-tina.zhang@intel.com>
 <20231027000525.1278806-2-tina.zhang@intel.com>
 <ZTtixEgSkBI-TRro@8bytes.org>
 <MW5PR11MB5881E07803D25E3588FFABB789DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <MW5PR11MB5881463F11D86198291EB52989DCA@MW5PR11MB5881.namprd11.prod.outlook.com>
 <20231027112013.GT3952@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027112013.GT3952@nvidia.com>
X-ClientProxiedBy: SN7PR04CA0188.namprd04.prod.outlook.com
 (2603:10b6:806:126::13) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH3PR12MB8331:EE_
X-MS-Office365-Filtering-Correlation-Id: 83ec6a59-9fdb-4226-058f-08dbef762008
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bsbxZp9bV2+HYKHo1H36ukEH6EbgYDHf9EuKmcNqQRuDW7aLA4iSyXR+U158ii6+B5DJutGJiBvhDer8sxSMij+JUDq9hPw2IcUMyGTnEv09fNrJYWFFxsylwRMq9FeK9Rz/3GKxzABmtTxrYs1m2CKDvRbnD50VHgz2UrVWGks3mJ/IcMfN3xlIezQLaZCVLl4n+vOKJ9OzzzaetgvUCtMXl4swIS7H4JSiBOuoJbvRG65QjsMf3L1lXtzNnFIAf+LJeFGHNCoXrIE5RRCFiKlE6zvgD38NNOfZ5cOYY3pBR7R2qbSrGG1Y+sbiXzBvsEHNFPygXzN28yfrDBXs73Q9oRjlDliERX7UFTzGDUZIC6MwShmxGsbwsP+NzJ9Jgb/mJkiVPVL569aIAHPR+VUT0O7ybfNlkQRThZi12NCUP2ApXdvnl3EYuoFQXjCis0N2Vng/5g9Xy1Vl2AjYY/sdq+s5y3uT9kygP3YA9K1C6xTISrBexF6ESm2mSKLlZ6pgBQMZF/ir6SDAIsqZMeKlmlMT1b/osYX0XnnMX8SUpX80W+qaaEaJrOc1gV6Cw04o8ucgXOrQQDcKuBEJOYCuVlzT1wo0mXyhGCt3L/E=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(41300700001)(33656002)(36756003)(86362001)(1076003)(5660300002)(7416002)(26005)(2616005)(2906002)(6512007)(6506007)(8676002)(4326008)(8936002)(6486002)(966005)(478600001)(66899024)(66946007)(54906003)(66476007)(66556008)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IeTINm29GO1z2BTUPbsSKD7jkYJD1fghp3TZafctDqjJdcwioAgQu9tXU5cw?=
 =?us-ascii?Q?p55NTOz+CriwKpls4dkm636vVO2e0bU5SZVAZFe45gI/b6TlDNoqxWspRa5A?=
 =?us-ascii?Q?YkYkHNLJH4UkHdAPE3nEriT2SZ7haL2lKigFb0KAG86FMmx5lxpPHazhCHpI?=
 =?us-ascii?Q?IDvpAnlYZfHBUxB58bq57R1Of5lDueGv4IVZ6Qaun/iTxk6Gmqc+1Rn45hvA?=
 =?us-ascii?Q?s2UE25XY3Lh6PXUpHkvYRkR+sw023F8pmJE7cH2H7huSCShqHwz53olpsv3F?=
 =?us-ascii?Q?4x2y2K9VtcaYkLEGzCcbjVgbTowqtABNYdFaGu5VuL3oO950ObEjhM1ljAvw?=
 =?us-ascii?Q?LYq5/3g3+VH1HqZ5Xgqy8blfFHttgfc0Xz7JGEt1EkXiBe05KK9sVfrfVBCz?=
 =?us-ascii?Q?xgPScWPrezMnW8lajROZaqC6IIc4c9H/t8OMkdRbfuCozaieWz2cYHnB7O1a?=
 =?us-ascii?Q?ztGaoB7ZIbYWP5PkXHHwb9Ne2HCTpf3Gior2uGDIr6FfLpyri7hnZQ6myQf4?=
 =?us-ascii?Q?HAISYvKMT1lCi1QMb7Gp78RqnWTU29lUcGmuFR9VnLoHGcZHKCIFYZvRQQC+?=
 =?us-ascii?Q?a4sjnvneNKBa0RpYHmtZG0fz0HTZ8rRaQMbdY0w+yFwaM99ixqjdlJShQMv/?=
 =?us-ascii?Q?kGiDGjVdzvjvuygpwTGvLoyYlEOG31BLLko1YRv4SSdWUQBf+0cEMC6EchmN?=
 =?us-ascii?Q?mxzrs6TqxUJ3LvDhCwofHDPx4RIPzMB4RYGRqLWkkAhfoiGFuDxjMh5uzwcM?=
 =?us-ascii?Q?3wzR4qu2jHUCVWbf57Yac2msUPWNvibZRf9ZOxKGj+23JSm3WQ/pAVrmK2Pr?=
 =?us-ascii?Q?7apjQdy6yMr5dkQMZo5JKayttD4AFPJ17/g3TrnRfNl/1kXnpQZ+ktheL2Rj?=
 =?us-ascii?Q?bswSWqvSoBXf2rRW2pEfaCDW6CfWTp8dyqSC6FVUrHdA1EanYU2iYIQteGZZ?=
 =?us-ascii?Q?SOpO7axu9vuU08ZnNSwkiarccVODX2eJmXJW+QhthmeTl0noYIYL7twHxsef?=
 =?us-ascii?Q?O0UQxtLXOVgewIl5TJDiTXis9Jfafz0EqFQtDnSdE3FBhIaHkyLk13BldiOU?=
 =?us-ascii?Q?j7SsUXcAE/R+HbjhTKcM0ldDNMz/r9c9t8z6yF0pyMM41ecNMtHqzkTxq+e/?=
 =?us-ascii?Q?rxcVD8p9TbRE5Nm9+33oQ47pQi4cqJHkFV/4BIWjdmFrVghCb2NUtwse/tL0?=
 =?us-ascii?Q?PhyD85PqXawYoj/wUmFAmQLG5ezYPsh8Ize79d5dC3nnzPDhQO+hzxL4CjAG?=
 =?us-ascii?Q?tE+zTB6dlnnyuJLOUKNPKU5sgFW2bBETqIAV6wbf+hM2mqcQIJNgLqQmPXPl?=
 =?us-ascii?Q?u255meFOiJII8jfDSnoSkp3tCIy4LK7eGQ0aCzAWbtU2W9Rv5wh6jnDOVOIf?=
 =?us-ascii?Q?hLGfYpWvASaqDpPftUHXXWp5gsSJJ4nJA3+IjvQRIc7ZNroR2D/Ec42iIT8J?=
 =?us-ascii?Q?E7CLmoiKXk7syuLWORsyzxGj4SV25QKXueXdHkzE5pIScUg595NwIXr0UJ8K?=
 =?us-ascii?Q?eOtUSEL0F4SvhV/Su4fayTYesweBZDhRISCiIKlZlJ0rxEmxBWXfaLrgguOC?=
 =?us-ascii?Q?PzQ4nc3yuyMh/c154zs=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83ec6a59-9fdb-4226-058f-08dbef762008
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 18:24:42.7094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JE0cIE0N7YLik1qUc40gCguX4WD5GPxwMU4lA9j8icUus4vGL86cMyMdBL8dM5sl
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 08:20:13AM -0300, Jason Gunthorpe wrote:
> On Fri, Oct 27, 2023 at 09:14:17AM +0000, Zhang, Tina wrote:
> > > > On Fri, Oct 27, 2023 at 08:05:20AM +0800, Tina Zhang wrote:
> > > > > From: Jason Gunthorpe <jgg@nvidia.com>
> > > > >
> > > > > Linus suggested that the kconfig here is confusing:
> > > >
> > > > While this patch looks decent to me, you forgot to Cc Linus on it. In
> > > > general, given that it touches a couple of core files, I'd like to
> > > > wait for some more people to have a look at it and not rushing anything in.
> > > Make sense. I'll CC Linus. Comments are welcome.
> 
> > Can we separate this patch? I'm thinking about CC more people for
> > review. At least, we need to CC all the reviewers of
> > https://lore.kernel.org/all/20230506133134.1492395-1-jacob.jun.pan@linux.intel.com/
> > to this patch. So, it seems more reasonable to separate this
> > patch. What do you think?
> 
> I think that makes sense, let's go ahead with the rest of the SVA
> series and we can do this next cycle. Bikeshedding config names isn't
> really critical.

So this didn't make it even without the config change :(

Can you please resend it again and CC the right please please. This
needs to go into this cycle for sure

Thanks
Jason
