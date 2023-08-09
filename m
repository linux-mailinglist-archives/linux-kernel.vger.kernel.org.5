Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD2D776354
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 17:08:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231834AbjHIPII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 11:08:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229791AbjHIPIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 11:08:07 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C031999
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 08:08:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNT18w15ekLARZmQ+D/OcxN7VQJKMtY8JPXSbIgdT7xaP9S3q9x/h4UkgSVkDqSiK2o7A2R3KGEqD5ZCgi05Br0h/muczMoCuxdG/2iJbXc83jHH3Yzpphti42GRJGIBJNyB4guQmo6Ze6CEAem7wD7SfoAiBlWzd+UxFqA8Apr49/RqtQEl1eqZAS+QLYdvisaqRt1KFIvyOi0k5OrKGNs6n4jlhNKM0wp8IpW2qHu0rIUZygsR4k+ptuEusRoQ7E/Q11+yz9kdZbeLgvI209T+TfJAgKE1etEKecMVmjnuVZx8qzG2jh4983Z+lPDmGF97muXKeOlnSG6aLJd15g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WqDoyj2TIORHLt7iqRS/7RkcUqM1gEyWob2hVE1vaps=;
 b=BMcMVdtg5fMBuzUxVL185wtThr7waGC3QtVLUBzuSxMbkO7D36voKjPZHSsmMym3R4OZPWHM16Ry5mbzD4PE0td0Pl7dqQCj8SFxE01pln5+lDHVlTNluxiNgn5aPP6YZJXYNM/keWKez3Y5UvPY4FjK+3Yge74mjQnJdcyNhZSVj/qmzdqwOkUS/6FlJvs8U/U1oD6uSh4245i9DqdD0jookVEdqXmDjwgqr80HzfkuhSjHiOeSJ/HHzyQYEo5SoFw5FonQcjVu+5IjDaM7vVA2iOKJYLJ29FVdp/XZUN5n9twrn31IrSg2wTg90e2KX5NZ24D5oSUZz+o6fAz9/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WqDoyj2TIORHLt7iqRS/7RkcUqM1gEyWob2hVE1vaps=;
 b=myOsJSq+TDtWIuYtaWjpfSFZd3k7tKVRIUINX5uFH7KYCQGqhbGY326cFVvNZOe9FtjVsonvutEeeRrh+PC4kvHeq8RrKPF9Znv1neSZyGbT0OL28LLkLN9OfIc2LHXdqQMpJY8yYfbdsMonI+Mg/EZGhO8rLc75PHbZJ5zMewPj9IrjQcGQyfaHN9whGtPpkRx8+vCMRHD/yDqQJsYMh0NqrKONr85EC3QnPwcKd7lxaIM03bXNJV39giftUnLzXzAqQC9UxqqCYYND9U3phcy8gPrHgtmdQ7KPdzNte8Ho4GK2g+Esr2dKvo+JD16QWxdVGBJhu9B0nn2hDsl3vg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB5120.namprd12.prod.outlook.com (2603:10b6:5:393::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 15:08:03 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 15:08:03 +0000
Date:   Wed, 9 Aug 2023 12:08:02 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Will Deacon <will@kernel.org>
Cc:     Michael Shavit <mshavit@google.com>, iommu@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v5 2/9] iommu/arm-smmu-v3: Replace s1_cfg with cdtab_cfg
Message-ID: <ZNOr0ggoO9kXHJWl@nvidia.com>
References: <20230808171446.2187795-1-mshavit@google.com>
 <20230809011204.v5.2.I1ef1ed19d7786c8176a0d05820c869e650c8d68f@changeid>
 <20230809134941.GA4226@willie-the-truck>
 <ZNObxeogswAYyDQ5@nvidia.com>
 <20230809145542.GB4472@willie-the-truck>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230809145542.GB4472@willie-the-truck>
X-ClientProxiedBy: BLAPR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:208:32a::9) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB5120:EE_
X-MS-Office365-Filtering-Correlation-Id: b08b491c-545b-415e-8db9-08db98ea6db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NyVuxgtcCWsYVxIf2J0wKptNFj5zwXumz+Rg4Dh81ud70lHE/CDLway9XMOLgJRYih6UuUb+mPUY/25Z+2QLa8DoYFEJWA3gHb7DMSoZ84XZJvgAczzn9BPUP+5YzlN0hMJQdfDeiYHWbLoeRZKU03PyBm9KqtQtO3o741Mo9pLrm4AgYnJb/IqbYEvIanH4fvI0TqfER0U0DE4z9PRyVARAyUDYS/gJJriX+5ygqYPumQdskkbDW6ewdekPRqtWntiAzls1AnEbq54UhtvmEdVTLdIQxu+gdkDDF9JzTKFfgOoX17LlrmZ5ZxL2LbhZeyR0+os3Ozfn9/F4ErbSdZXZNS5cCLoPWfvhYhVuhb9G1L9c9l4JMcFkeQWt8PWPTl49UimhQ2SEgJzinkP+3+YJvsGF2t6o/Zv/kvjsbo28IT/6mOrQwBkokNKQ/8BMsEHWC1HACC/eHM5LCUloJ/5GWaabHWZ69sumFFpD/sN7pDumcdhF3kOFiLeG+SpgwvTvswpRT9ewa5ZG4ta2TOKSKu1h4RXOV0OrZU9VsvxYcSpTIyz0nMhhgQxvEiOoKrY8fkpobwyC+C35eecgAtb58zZrsGEuMHs7JCTNXew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(366004)(346002)(376002)(39860400002)(451199021)(1800799006)(186006)(26005)(6506007)(6486002)(6512007)(478600001)(83380400001)(2616005)(316002)(6916009)(41300700001)(4326008)(8936002)(5660300002)(66946007)(66556008)(66476007)(8676002)(2906002)(36756003)(86362001)(38100700002)(473944003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Pe15e7YEJ/c7dAMbZpT/sQxsGMzlCqvDZUHjvz6d66EXTY9jT+p5EcVf3JEi?=
 =?us-ascii?Q?1+IewHXH4ozqQcOJXLTSqgPPAxySzTbLje6suB8ihePE30JUOcpdM1Uu0qDQ?=
 =?us-ascii?Q?zTZv/MJ9LZwqxRQvBP1orBTow5ZfJ5NEXSe2dak7Huo2gjRT1Jg2YYMMwkZ2?=
 =?us-ascii?Q?TOdbkPiaNZMUne+v0ti5cnbKwy+SB9psxc/7kdwdNi6Oenrio0OpOkCb/PQJ?=
 =?us-ascii?Q?P5zz8vRKLP5QzgHYsRdmN+gEs/jEwknHwz4kUZ3yrksl3P0f4G95uPyfkUF0?=
 =?us-ascii?Q?Ne5M1LzgQta3o5etojnKqaypgG7AqGTOhFYC2r509UQ7GNE7MLZ3oWtsYQGb?=
 =?us-ascii?Q?BnA0hb0oXIuST8zLt01CDfmnkKVUSzjID21cwcMkOpLdSpbpFRAqYYbl3Nfp?=
 =?us-ascii?Q?kgdMroqtdr90mct7xDoR8Y2uE7VyytJwCRKEzLBIDIXqVwuPPq6ClTP+mdOP?=
 =?us-ascii?Q?nwtGJeAeebBNBtVFG+NDCSY5rD3Fd3Oyqm68tM7Zl2A5CcJ3Z3RDv8jLHvi8?=
 =?us-ascii?Q?ak0jipUaOA0ToMQRqRE7BsuLdRwRCyQpQTMOEnMs6oQLPzsvJv2VUkyHxfPM?=
 =?us-ascii?Q?ED+sl0tn76WQJ13wK8a8veZstmK3QF9rUHaFfIxY0GAPnkHyHogdFTk82cPR?=
 =?us-ascii?Q?wNL6WMcV0L3XuwjQNqnaBFRnRD69mKp0AH4T9iJWt2RzG9VXZdHUQTLdjfIp?=
 =?us-ascii?Q?kDZKmYrpVd/oYEB+xlzf94K3XaezIVS//4uehiETokZ+v8kimmwB5UD59n5Y?=
 =?us-ascii?Q?m+ClE+RYxs29bZUmdv1+QfMjMHrb9p4OVntRx39ckPbb4qc8BUU5g6MRRjkD?=
 =?us-ascii?Q?Ay1S4EmfQNOl2CLt3otA9clbNm7lGcB1DJEhm2CMHZj7UW2JRZQF5Q0/fGcM?=
 =?us-ascii?Q?4VU8EQrt8txdTVcVVtnrnaOENWMnN+Rw8doWjlCXz6jB0FK4iUzsL5B0E9C1?=
 =?us-ascii?Q?TCgLFkQdLrfzfWDlxLm+EDFiWojtryNB5dDzJAMFgxenER1o797dAXZ6083F?=
 =?us-ascii?Q?77XqRPY5Qq5hzeRQwjYwsDJf9FON6mI/rnJ0Dz2roLvKl5playfO3DzTyflX?=
 =?us-ascii?Q?RtmvHWWfd8TwHOu5ODLqD5Hrp8lce4/Jyr74RvA7V0wRTkz/WdURTQQ4vBFj?=
 =?us-ascii?Q?K70HMHC+YfFJIddRtUWioboxZm/VWwKXOyOX1j762jZ0PzcTcqIpdzWsdqYO?=
 =?us-ascii?Q?VRUr7GqwuQeowP4tMkJ6+KsPwZb98tPGSBq9T7k08KmxswEb/ICCy6j0m86k?=
 =?us-ascii?Q?3uZNtbE+mEvsIb4jTS0PzjNCklMzSp3H/U2pt3muYEP4j/Yj2e0J85h4wVu0?=
 =?us-ascii?Q?vn7/HvuvDDEBRiT/zp/lPyMjFmB6QgMQGgdN/RoRernE6rLlJs/E5aoju+UT?=
 =?us-ascii?Q?3Peu8PgCfxslQ52blzJxUSm6KiYoGBZEPK65QPAgJJmw8ROYAD7wZgojcOd3?=
 =?us-ascii?Q?bvl5XzFTxe35l8ZMj5+PkSxXuTU3n1OMOvTpgrwMZHIsS/F9Co402lxe+tGo?=
 =?us-ascii?Q?0x13KGGQiJV+r4eWE6LJtmkLT6ngl1vz2JoUrV6leXkdEu37/LZ2K+Jk9d0y?=
 =?us-ascii?Q?/lPNUlM6uyOHCnnNmirKiiEMULaaLh/qP/B2fuzS?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b08b491c-545b-415e-8db9-08db98ea6db6
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2023 15:08:03.5030
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tnj3IXQbT4TytpNPCgaH21QpNWhwTlgrKjCd0OtvRg9UbwP0kUDNvFcKgu9BdHAT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5120
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 03:55:43PM +0100, Will Deacon wrote:
> On Wed, Aug 09, 2023 at 10:59:33AM -0300, Jason Gunthorpe wrote:
> > On Wed, Aug 09, 2023 at 02:49:41PM +0100, Will Deacon wrote:
> > 
> > > > @@ -1360,10 +1357,14 @@ static void arm_smmu_write_strtab_ent(struct arm_smmu_master *master, u32 sid,
> > > >  		    !master->stall_enabled)
> > > >  			dst[1] |= cpu_to_le64(STRTAB_STE_1_S1STALLD);
> > > >  
> > > > -		val |= (s1_cfg->cdcfg.cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > > -			FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > > -			FIELD_PREP(STRTAB_STE_0_S1CDMAX, s1_cfg->s1cdmax) |
> > > > -			FIELD_PREP(STRTAB_STE_0_S1FMT, s1_cfg->s1fmt);
> > > > +		val |= (cd_table->cdtab_dma & STRTAB_STE_0_S1CTXPTR_MASK) |
> > > > +		       FIELD_PREP(STRTAB_STE_0_CFG, STRTAB_STE_0_CFG_S1_TRANS) |
> > > > +		       FIELD_PREP(STRTAB_STE_0_S1CDMAX,
> > > > +				  cd_table->max_cds_bits) |
> > > > +		       FIELD_PREP(STRTAB_STE_0_S1FMT,
> > > > +				  cd_table->l1_desc ?
> > > > +					  STRTAB_STE_0_S1FMT_64K_L2 :
> > > > +					  STRTAB_STE_0_S1FMT_LINEAR);
> > > 
> > > magically know that we're using 64k tables.
> > > 
> > > Why is this an improvement to the driver?
> > 
> > Put the above in a function 
> > 
> > arm_smmu_get_cd_ste(struct arm_smmu_ctx_desc_cfg *cdtab, void *ste)
> > 
> > And it makes more sense.
> 
> Sorry, but I'm not seeing it :/
> 
> > We don't need the driver to precompute the "s1_cfg" parameters and
> > store them in a redundant struct along side the ctx_desc_cfg when we
> > can compute those same values on the fly with no cost.
> 
> But the computation isn't happening -- the STRTAB_STE_0_S1FMT_64K_L2
> constant is hardcoded here. 

So it would be hard coded in arm_smmu_get_cd_ste() because that
reflects the current state of CD table code.

> If we want to use 4k leaf tables in some cases, how would you add
> that? Such a change shouldn't need the low-level strtab creation
> code to change.

You would modify arm_smmu_ctx_desc_cfg to teach it about the different
format. It would gain some (enum?) member that specifies the CD table
layout and geometry. arm_smmu_get_cd_ste() will interpret that member
and generate the correct STE for the specifc cd table.

It is a standard OOP sort of practice that the object self-describes
and has accessors to export its internal definition. In this case the
STE bits are part of/derived from the internal definition of the CD
table.

Jason
