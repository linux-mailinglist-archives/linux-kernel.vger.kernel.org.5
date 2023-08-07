Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C6773307
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 00:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjHGWl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 18:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHGWlz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 18:41:55 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2047.outbound.protection.outlook.com [40.107.244.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4445F3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Aug 2023 15:41:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oRxe4Rq6BLmjeZQE0N+6jYqzvB1IZMOiUDnb0nr5hg+vR/r/cSNqQpdjABKn97YTHQM/y8uz8UAsq0np2CgGrwcuuEzaGE3S7Mbi//pjfiRx8hCDmB7cMMfhPry3AWlhX3icxyzb+LKiwPr1eDmpFWon9EyZVwdPNzLUHM0r/QUIblNQXGRs/zAYoDxVHI0AW4XN9bkpR1dhxH0qwK78ym/WrqKszPuOsse7m+iAM1ozRTW1DYZgYAWzetD/lVSHK34XotsLmzfN8E5F0mEOIxK4oPh/0b+4tQf7Gt2+yVd5xoLvu0RJi1kTYYwj5Ze3DlWuebLZeOtk1dTBr/IJtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hvWrSCVJp3mXWnKm5PE/k0vO0RWOw92OF7eLvNa0ToY=;
 b=ip4FqMSx17noPSgyMvXtIZiSWtxe3k6h496UHPXuUeiG1OBZtH20Bw/Jb0M1qb301pfvLNyA0P2wrGvt0VSvfq7olgcHvfB5/ZtYKdF/q3y1UABuB7W0jjZJG9S4hvCeOKU+qotF6hAADgdQNk7nGv2+OaMgYYogQIKQl/ptOUyTSKmb7HiBQ26AGjJLvv3XqS6MQmcSaq2/CsGGPJiGln/PnE4UR/vF4yWkdHn9lR+XSruAxFAZWAl9ElOHvPiGOerUiZs9K5aWSrBfPbpWro9ACIl3ESZd2GWVNHf5aZdMrTd5luhKv48TITxghmQwv2UfMXiZDmxqqcFdDvFZKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hvWrSCVJp3mXWnKm5PE/k0vO0RWOw92OF7eLvNa0ToY=;
 b=fjRUvlTpLibNpZWZ2DHXEXe78wFe9vd+5VRIRNTGY5I1J2s6U/+E9RmkN4AuLh8cllp01pZqHNVsweq3E/j2smkn2JnOSSCIKUkbSU2ACszI3/m3L+9j549h0WJfYeDinwd6aRcn30DG7pMsM8jMUV4Lclp51NgWbetPEstVSBbEZrl4vvZE/TSR5hibKCHsmNFetiMcRb/mmQNCu1keMR3/KdnWhTuLpt4boneN7OiLllYc/V5G0EXiUpr0iYdTmj6SWL6m7XLKjZa9SNzys2gE186OBDRqX1sOHEjKIhxUlspBMigXR97yfyEbD7+ahPxf5IkJnqzyELLCtfu19A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB7201.namprd12.prod.outlook.com (2603:10b6:806:2a8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.25; Mon, 7 Aug
 2023 22:41:48 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6652.026; Mon, 7 Aug 2023
 22:41:47 +0000
Date:   Mon, 7 Aug 2023 19:41:49 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com, jean-philippe@linaro.org
Subject: Re: [PATCH v4 6/8] iommu/arm-smmu-v3: Move CD table to
 arm_smmu_master
Message-ID: <ZNFzLfemo6joVcsI@nvidia.com>
References: <20230802163328.2623773-1-mshavit@google.com>
 <20230803003234.v4.6.Ice063dcf87d1b777a72e008d9e3406d2bcf6d876@changeid>
 <CAKHBV26OsQYRCifuD0UjSf5uqcvMSK2tizjFULLv8DTdz0zD2g@mail.gmail.com>
 <ZMv2WJX6b2UBBelt@nvidia.com>
 <CAKHBV25fCOE3pVysLaB2e67G0Be3FdWLKb+ZsmbHg8CyPpwo5A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV25fCOE3pVysLaB2e67G0Be3FdWLKb+ZsmbHg8CyPpwo5A@mail.gmail.com>
X-ClientProxiedBy: MN2PR05CA0037.namprd05.prod.outlook.com
 (2603:10b6:208:236::6) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB7201:EE_
X-MS-Office365-Filtering-Correlation-Id: b2c0b1ca-0aba-46c6-c0df-08db97977bca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /B7ztJ2XL8J54nqv9oVUNtsZ80luCQsfsK5n0ZNZGwcs4AWSOARlHkQR7fakuHf0TT6YWlZP39oGqjMkan9JzF9Vidp/wZaSSZrXsIfvZwzVcix8YFPKMLaBAsHq118bsCi1lGE/GEVGuO/dmUEgaQwQ9CbJMuNJjiyLPDFkcWXc/9xH+Rv6VMkhyRaJYFQN1Y9bLObEh6l3LwSqHT20DNBvEXTvOB/IwvO5FVBCN9gJgShqwYSCr3kpCXqF4g5MWo0l56LL6/T4hfni8MAUR7A09Inr1Qayjl5wThSh1s/kJTyfuiA0k1FB+JKEf+mWAUeYAEO1qkgsbGPBzwznjkTsG8zamrvUTJevQZoy+AlDhjp6V57BI2tPrH8MK0BWskTvsloaXETWR9Vs4XDPWWPI5voAMDwx7guOnVnUPequno94hc/KdfL4wzV8Yl8LyT6YcFyOUYZVtNTP5/V1B9CzSEmeOQ452Tm3ctX7/CXlJEj9pBYwrCCk+EjSIoLn9GRanDPLXLZFYRGJeMJ2xKA1VnrDF91R+C5EkisMcZ4dvQ1T8wpyzBGsysJFjTF69w6oxe7tQNS17ZgytZzTmfQSXXSX9Wccp/xKhXnzbBJjbFglfgg30wGyrL0kQbUA
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(376002)(396003)(346002)(136003)(90011799006)(451199021)(1800799003)(186006)(86362001)(41300700001)(53546011)(478600001)(6506007)(8936002)(8676002)(26005)(6486002)(4744005)(2616005)(5660300002)(36756003)(2906002)(38100700002)(316002)(66476007)(66556008)(66946007)(6916009)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a056S2xtV2pNdWpVdW1zdXNZbFFMVUNyVjhOaVNXd0t4WDl6RVdvR2ppYitt?=
 =?utf-8?B?VHFla1lYRXY1aDJLejZQak9kcUJJcjZvQk5EQWpwOWEvTHpXM01BMXAxdkFk?=
 =?utf-8?B?S2VwaitseXlCOGhHOE9hajFTOGsyN1h3VGp2SU5ycjBNVEMxUkdYUFRkM2RP?=
 =?utf-8?B?VmdnWlFzZXByeFNLSnpZYk9MeXFHMitTcjkzZ3ByNGNsU3VWbW1HYmVnTHM2?=
 =?utf-8?B?amdFNUt4WFIzajNWWTBLM1hyK1JkYWwzVkVWUDdlN0NLOWQvTW5nT3hYR0t1?=
 =?utf-8?B?aXRBMUVCQlRtRThYMGJ6aS9WNEJEV21xNlBaSTA0Zktycm1ITWNQY3VnZ3BK?=
 =?utf-8?B?a2cwRCtWQ1BuSE10LzVHSU8xallEMWd0NEF2OFZza04xaDFCbXFXRENFc2tK?=
 =?utf-8?B?SDlsWkxWWHQxdzdjUWFzZDdrUUltYlBrNFQzeXhnQU5uSzh4cmJmcWIyaFlm?=
 =?utf-8?B?aFhIN2dwUjJGYTNqR21TVTJRSXp5V0M0ZUNPS0s0Rm56NXVtNU0yRWl1T0Z3?=
 =?utf-8?B?aGpSY3ZUV2twbmVucEZ2QmxXZHJ3OVZWYk9Td0U2M3RpeU94T2JGRmwyYnl5?=
 =?utf-8?B?TXdELzVtOHRQZVRSV0tFZkZaSkcvT0g3ODd4N2tvUkdZUHV0ZTJMcmIvZUhS?=
 =?utf-8?B?emdhUHErUC9MS2FTdTNTR0pmdHlMK0Zsb3NFL2VEQU81S2VnMU1jd3pVWDE1?=
 =?utf-8?B?RW1EVmNMNUI4V2hXRnJFem9FSVF2VnZxcnlaMS9hek5RTDlWcHovVlovUzFE?=
 =?utf-8?B?MjdEUmlsUzhUYVdOdTVwTVNkeUE0WWI5QWZQMkRWWEVxRlY3MUlPakNoOTQ4?=
 =?utf-8?B?cGNXQlZuK0IyUU9RL3doMmIyM0F3MkxMNHlod0VXSkZ3RmxCT0RtT2NVS2dE?=
 =?utf-8?B?ejUzaEVPVG5zYWdMTkw5ZERNcVZ4NU1GZSt6SnFnZ2dyb0Rzd3FrZm84cW90?=
 =?utf-8?B?S2dmZ1BTbDFMdjNnN1AzdTFBZmVic01rL3h4M3M4WUxnNlNBY1hPQVc1eUJD?=
 =?utf-8?B?dVllYklkOGllbDN4VVh0T2RxSDVIQ2NVcmdPbEN6dUY5c1dLQkpjWUhrSk10?=
 =?utf-8?B?Z0FTK041d1hFZXNNSDNsWGoycURFY0Ixb2cycXVGMFBlWW9kK3lSSndyelow?=
 =?utf-8?B?ZFBQKzdJdEFHSFdReVh4YklMbkIvR0ZZODgvK25WYXpXQ3R5ZWh0S3hhS3Q0?=
 =?utf-8?B?N29id3U3eTQ4TnhyVlR3WHppWGFFMlgrd1NwcHNQVVNxZUJqOUd5NnJmTGJp?=
 =?utf-8?B?b1hsNnR0dUFDRFUrVjZFQ2FNQm1IZFJJOWdmNitGUk9UaW5UaUpXTm9xQVpJ?=
 =?utf-8?B?ajUyOGxlSDA3cUZMTElnNHVZNzhqd2MrQWdiNThwUmVKc2krcXM1Y0ppMHB2?=
 =?utf-8?B?aGFXYWtTU282akgxZEhhSXRsUlhQM0ZVNnlHdWZReHF6NXBwUFNwVTdiRlcx?=
 =?utf-8?B?ZysvRUQ5ZVFEaHJDOThEbmcvMlBRUDFMaTEvR0VDa3FCR2pxajRLOUFOZWZ6?=
 =?utf-8?B?a2NHODAwQ0pVY2I0RXJsOG9UamJDNWg5R2VxOUt1bTdNSHhlNkZiU0NJZzVP?=
 =?utf-8?B?eXJYREplVjRmeDB1bUIwWFZSdGdtVTRISjd5bE5zRW12SjBaeUZHdG9CNmtN?=
 =?utf-8?B?SXVsRllhQysreTNvZlBtczNRRDFGRDlkODB1RUtWQ1cxUVBUSktpWmNhS0sv?=
 =?utf-8?B?VmlPQ2llaWlJemt0R283b1k5RENVY3pOWE1VamFOcnZMSkJndFppMFI3dEJx?=
 =?utf-8?B?U3VkQzFUUE9SZWh2NlZLbG9QT0dOSlpCOHdlVTh0ZDdMMFZFa0hSb3BET0pM?=
 =?utf-8?B?NlN3YlEzeHhhQzVhcDVka2d6Yy9MaGVIeU45VlBFWXBRY2VNOGMxeXBkd1ZS?=
 =?utf-8?B?UWxvYVpEZWlvN1cyOVdJY0k2WFFMOFpYVFgwZ3Zka2RSUU9jcklXMWRIVTZO?=
 =?utf-8?B?czBzbGl6VmRySFhEL1BMRmJaTzVmRGNMOXQ3WFloRXpma2tWTWZBS3JBazI4?=
 =?utf-8?B?UkFlMGljK0UyVUpiWEZZc2w5SUpjTUIrVmpQczVwa21RdEFRQXJyOHVVWkFa?=
 =?utf-8?B?K1J1ZGVLNWdtcWwrK3B6dzlEY29HSWZ2TjFBSG92eDF1aDFwanFpSjJmQm5r?=
 =?utf-8?Q?i3Ks=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2c0b1ca-0aba-46c6-c0df-08db97977bca
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Aug 2023 22:41:47.8059
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpmhhIW6mQcXf2Y6RnkIBG8r8tC9+HIQytuUOvD/LxrrU1JK7hZDOb3NhzwysRt+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7201
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 07, 2023 at 08:19:44PM +0800, Michael Shavit wrote:
> On Fri, Aug 4, 2023 at 2:47 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> >
> > I'm not surprised, I think arm_smmu_write_ctx is a little too clever
> > for its own good..
> >
> > I would have written it by computing the full target CD entry,
> > extracted directly from the domain.
> >
> 
> Yeah I was considering making a fix to arm_smmu_write_ctx instead; but
> clearing the CD entry on detach feels like the right thing to do.
> Relying on the 0th CD entry being re-written when the CD table is
> re-inserted feels fragile.
> 
> Perhaps re-writing arm_smmu_write_ctx could be considered as a
> separate singleton patch?

I wouldn't touch it in this series at least

Jason
