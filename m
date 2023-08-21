Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE94878284F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 13:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbjHULy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 07:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbjHULy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 07:54:56 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2040.outbound.protection.outlook.com [40.107.223.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C18115
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 04:54:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mdDlEZeNiq9rxb2/mW3v/nd2KK0syOz9O9S6YCp4HOQ13Z+yGgrqCYTSuTiXn8fsrcSm8yeA5kE8FOu8ka2eJg5ksqMZOMxF0zbmYZNbzpr5KKQNDT899LyyIPAO9vRm9Sk+dPQb71AEt4aMqD5wKmtrMfCdEUtJtvSy9Z/tazYmKVDqgHVrDHZ4LGipUNYht6EmgpBnbgy00PSNQe0Tw5Tvf1fs8o2WECQmkVy7PCIMGCTsr8vm2yUwCPXhSRFglqD/zElUIBD0+fPaHniOi6xFZuVs/ixSsr9Rghevouq4kFk2gIV/lQM1tw6tjlEzAcmQfZrXbfmaUMt+soUEqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPCjdg6G5GlRahv5dFok27QTHrcNBTBezZCaIlx1xow=;
 b=gOyB2byhPPHlk5bNv2Tb0KlmyySGZea1OHUSA0RYYXXIJNGD59r7O4ICKTDds7xgiGI199xbP12+kFbgZcqTOKhP5Wu6kOs8hzKBbMRVQg02o0VnswOtAj+uRoB7/fLp+/HDpBYyGtk0B9mvMvpW9f4x7LmtGtyr0mHAFMVpdwJrF1Y5k51lk5mLarQoKNEeEuqqL8Z1CouT4nH/qsyyOfmp/QAVIzC/vnKNfik2tkGQiaDeuqdptR2PhCd89oLWQvfl/+usRGsRuTTLfzoF8etrfDVPomLRT7x67Hq2Lo8TtUrXF+8M15r/X3ZYHzHrOlBNXoPtm4qJRJGQVG7p4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPCjdg6G5GlRahv5dFok27QTHrcNBTBezZCaIlx1xow=;
 b=n9UiD/DEWQ86jN/YhgeCxvDtnW1fCXt5ke3M/lu1c9YZVNR/7YDfTb3z8EEzGQN3KxukhtZqistVxXcow2kjlN+05jDJx3qBacmueSgyZT8oszl9Dc84cuUhjdg0yC2oZ3hl8v/gM0cps90htGr8DJ1c+FYHFk+/lzmG7cCpAliBqeeDo4kFEBlH+lxrqR15HJGLEAiVIczcIZOzpad8SAv/+y8XAAshu8g4hTW2zOg0rQbyYSMP890lUUcZCy9iF4RA+4IjFbhSKkIvnFlDmr3sxlu+MMYVuJbvG8QIcPl4rMVQgfSp1STYQ0+QVTQgqbU9y6cUTf0z61uyYUrbKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by PH0PR12MB8821.namprd12.prod.outlook.com (2603:10b6:510:28d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 11:54:42 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::5111:16e8:5afe:1da1%6]) with mapi id 15.20.6699.020; Mon, 21 Aug 2023
 11:54:42 +0000
Date:   Mon, 21 Aug 2023 08:54:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org, nicolinc@nvidia.com,
        tina.zhang@intel.com, jean-philippe@linaro.org,
        robin.murphy@arm.com
Subject: Re: [RFC PATCH v1 3/8] iommu/arm-smmu-v3-sva: Allocate new ASID from
 installed_smmus
Message-ID: <ZONQgNh6qarqgA+f@nvidia.com>
References: <20230817182055.1770180-1-mshavit@google.com>
 <20230818021629.RFC.v1.3.I326c62dc062aed8d901d319aa665dbe983c7904c@changeid>
 <ZN5pK03Drao/egeF@nvidia.com>
 <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27k8F0ZLy=RA=WhjJ7+C9JMHRRnKs=4W4pJMNmxrMEXxw@mail.gmail.com>
X-ClientProxiedBy: BL1PR13CA0137.namprd13.prod.outlook.com
 (2603:10b6:208:2bb::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|PH0PR12MB8821:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd7a99d-868e-4490-b6db-08dba23d67b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xxa61HHch5ycapu3nhn4aYW0abI/or4nb22DhUB2pH1U/V7lKVVE4gu1kIh/xkir7gAC3rY5YSGk9sKw1lR73Ezhb+UzxHBQgdv80pF0cxCWeA626LSEGgNahzLn1vHYAUqi7mDX4l1nkpYfB/MaEtaxWPv1FtDsW4Gh88dnqFYiJcyLeDLD7W4eJpgPqediNip8yasji0gjgitu7AONBJ2zIziA0nglm3/fJzUEfycrJ6QWIz2nk8AO+tYaT3NMd+IVkbf+05IDjBwPEGiWwp+tMXTx2JBeVE0xxjnFbW+Lwf653hyS6EfCjs4A1lxe41+BRIrP7K7noWoGRDWz50Y7q5XHukJl9eOT7850GRUmUK3x5Z0+viB/U2LYZH9cMauOX2FpakijexU3Sq2FX7ito6+eCTJZeD8VulcOg3/XS1cGItu2G4ycYPYey0BakK3hgiJH9+lJXYQYAicEipG08JMpTzWLlbuJ7tM5MjjjSzrlxaWYg25TKsNoU4HiryJ43SSx2Yn+/JLZXvvvGv6UTZqyAaV97WywsRdERWfytK3GXJmN4V6RdP6/3B6f1Z6w0G3RQ+K0f7RY2iGKYLKSFWZWCJ//CIPTliw+mm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(451199024)(186009)(1800799009)(2906002)(53546011)(38100700002)(6506007)(6486002)(5660300002)(26005)(86362001)(8676002)(2616005)(8936002)(4326008)(316002)(66946007)(6512007)(6916009)(66556008)(66476007)(478600001)(36756003)(41300700001)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eE5lTXBldlIxbXFENW5wMyswRGIrN2V1NDV3SmtqUGczYkwxWkhjNVNRSnZS?=
 =?utf-8?B?alNFQzMrTGhNTmtWWlZRRkdLOWxtcE9XYUpzMHB5WkdWSHdJdHdNb1RjeEJs?=
 =?utf-8?B?SE5xY3dMN3N2SEFSSCsyS3Zpd3R5M1FxaitmdFFUZUxPeEZLWSt0bjFzYlVH?=
 =?utf-8?B?U1V1c1JOT2JiMnUrMS8veVdWelZnbVBSUi8wcTN6MS9UWWtaV0dOaW0zMXcz?=
 =?utf-8?B?NTVpVEtzMjF3dUlTS1ZuMkxEV0NocHdKMHFhVFV4QmdQdEoydjB3b2xkajEx?=
 =?utf-8?B?UXExZWQ1RTRLTnM1KzUzUUQzY3dQNDNQQmpRdU90SGhDSjhWd0tVWWdaRmJM?=
 =?utf-8?B?UFVJQi8xd1dFT1BEQ3paVm00RkRWU05kZGlSQUxFb3RubHluUVZlNHlFNFJm?=
 =?utf-8?B?K0Q0aHNNZ2xySmJZSU1EaGJ0b3l5eTZqS3hpSG1DVFBPYW03QWFNOFVCUzB6?=
 =?utf-8?B?TnZXbEFhNzlNQ2lTMEt1N3U4RUlsaDZENGMyN2Q3djBpUTZEYmkrTmJuZkFM?=
 =?utf-8?B?aDF0NHdONktjS2xmcDNFRlVtR0tReVNMK3Vrd1FuazNuNnVIQ2pud2c1dlUr?=
 =?utf-8?B?dmQ5c0c4S0hMUmdkVll3SE5aZ09lbUFhMmV5ME1yeGdlMndLSTRRUXhxdm1S?=
 =?utf-8?B?d1E2U21YTzdjamdTcS8xTWVKYmp6OTlaZDlrd1A4SjZ1OFRPMVZHd21mcUl0?=
 =?utf-8?B?TktGS3pZbGFEUEFvUklTenNjNHU3SE12T1diakxRRCtwdTZmb2dRekhLUEdV?=
 =?utf-8?B?aERjcnRCSmpvc3FVS0REdnQxd2o2VlJjbmt5RVdTNzQwZ3FrUnp5UW5jRUpj?=
 =?utf-8?B?bDBYdlBTeWZUbTNZRElvaSs2T0w0SEYxanlSQjNYNHAwb3RKMVdIWFB6b01L?=
 =?utf-8?B?czV0M2dvaFFEQmMxeCtvRGR2Q1FvV1RPQnVPVmN6VlJHSVhzUFdIOWUwcGk5?=
 =?utf-8?B?V2J4SXcyTDV0Mm9RWE1yQUJNQlNWS2VmUXpWVWtkNTlHVkNTOXBOUkgwczVY?=
 =?utf-8?B?d0xKdnZ1Z3c5QStldTdyRXFMUVJWN3VIVHh2R1ViUXBGbGoxTjQvOU16RUJY?=
 =?utf-8?B?YVZCRkFNTkk0YVRzVHp1b2xaemlUbmpJd20xODZHdDBNOTBiUlhSQlVsOTNa?=
 =?utf-8?B?WWkrU283TlRXNjUvUWNTTlZLcWhWU2t1ckhjZzVpaVhUbjllcUtER24vRGF2?=
 =?utf-8?B?ZnMyOU5qeEQwT0xucHRHdEVHcUlrQjVUR2swZlFUZFZ2MjFJenl4TDloZXcx?=
 =?utf-8?B?Z3NrRWFMcDdoQldmZExxdGx0cnhvNjV1Vi9ZdlpUTXkwOE8vQXZPMnlXOGhr?=
 =?utf-8?B?MFIvSHFsRE9ZVWEvN21xT2xsb0dVNEpLZTdiZHpabTcwT2FFNDhGUEh1aVVu?=
 =?utf-8?B?bit4VUprSTRpMndHemFqM3pSZjdpTTRLZHRoeStTTW9lSGVhR05jTjI1NHI3?=
 =?utf-8?B?azNMTUQzVCticjNTM2IxME4xcmpMOTFTMWEwN24vbmw0VGxXSWVWc0oyZUdL?=
 =?utf-8?B?TmpFK092MGM5eWNkS2RGNmFHczhkcWpNUEh4cTFYbnFOMi95bHhoOUMvTnZS?=
 =?utf-8?B?Qkpkc01vT1BIOEZQOXpaOW1MWStTbk5LSGNiZGpTU0hZdUN1dFBNQm5ueHZx?=
 =?utf-8?B?bXJoQk9ZQ3BtQmdCNkduYXVBMDlTa2dPa1FWMXFYQWRTTnRESVRRYW5aeTlQ?=
 =?utf-8?B?azFUWEZWWHpwazQ3WGZ0QWppMXFpbmlObWFOa0V1cmFkbnh2L0h6OFRSSFhD?=
 =?utf-8?B?VU5rSktEckNDQUxTelJVNjJRUndWbjEyVGNRTERESkNGbDAyUmw5cjZPTm9k?=
 =?utf-8?B?MUg3VVZPd3RNalJaeHFmUmxxWVRkck96UzNNVDc1K01NWTBrdEJGb084bTB0?=
 =?utf-8?B?anNWQndHejVSU0ZPSUFHMHV1S3lXbERwK3RzSFcxMUJBSUZoM1YrcmZVMnc3?=
 =?utf-8?B?WWZPUXlVZ21vQjhIM2pLays1VHhMMXcxL3M4c1hZSS9CVTBBeTdoV0pZQ2RP?=
 =?utf-8?B?RjVXWDhMUVRlV0hEZ1RFalN0ZDgxa1BBK0owWnh3YWw1eVlGdGFPNnUwVWxh?=
 =?utf-8?B?dGVzdDZmNjhRbGNZWm4zSkM5TWRlNzBBdi8xSGx3OUczNGRWcWY1aG5HenNz?=
 =?utf-8?Q?AUDQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd7a99d-868e-4490-b6db-08dba23d67b3
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 11:54:42.1773
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UrcjmZKL0oqDravLSPxy4eIRSYIoKSxMC8IaUcY3RjcSwn5TRzE1pHW8vpeEyfT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8821
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 05:31:23PM +0800, Michael Shavit wrote:
> On Fri, Aug 18, 2023 at 2:38 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Fri, Aug 18, 2023 at 02:16:25AM +0800, Michael Shavit wrote:
> > > Pick an ASID that is within the supported range of all SMMUs that the
> > > domain is installed to.
> > >
> > > Signed-off-by: Michael Shavit <mshavit@google.com>
> > > ---
> >
> > This seems like a pretty niche scenario, maybe we should just keep a
> > global for the max ASID?
> >
> > Otherwise we need a code to change the ASID, even for non-SVA domains,
> > when the domain is installed in different devices if the current ASID
> > is over the instance max..
> 
> This RFC took the other easy way out for this problem by rejecting
> attaching a domain if its currently assigned ASID/VMID
> is out of range when attaching to a new SMMU. But I'm not sure
> which of the two options is the right trade-off.
> Especially if we move VMID to a global allocator (which I plan to add
> for v2), setting a global maximum for VMID of 256 sounds small.

IMHO the simplest and best thing is to make both vmid and asid as
local allocators. Then alot of these problems disappear

Jason
