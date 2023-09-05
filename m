Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49B26792902
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350561AbjIEQYy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354692AbjIENeZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 09:34:25 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2041.outbound.protection.outlook.com [40.107.223.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8C42CDB
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 06:33:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EjIFpPa/r1RHzldWqH7bO/PYw3r5y4DfzPyaEsawPf2wM+fkFeVBrUHELKXj5uLKg2JB90oLujWuU8B6mqZmxP3aJIKoRf+2/Mx92OQSVP0zENJ1azJUc2CKpQHPH37ZlsU+PxPh5q0MCpNk3Q4Cm5n/OPYdO2IhcZMf3pk2ypTsZhdr2D62h+NjG2zntrCG8HBqoIfcUUdR0MwSj18xRW4J2Mn5YIieQdkEbHZnM1eiXqD+jutGPfk40/70Mr+b3aCib/5aHVZPUTFP+YldIhAsRDjQyjSqHosZwxGyxmEtBNvykBohgbRp7T2jQWRzUL37c0QVWslppMLFTUvISw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0UPVsC3RnMyxvFclXyG7BEvYpRt6OXZqAM51rx7At7Y=;
 b=UozWpcZAxXDg6azRVsvyMcsdev+nRrjwYBeEznSuOa/06HWN1j9DLYpXWZlR5LjbxeqLNIhm359+siS8KUUPJEBHQtVfrESItdok9ht13aiCdTljqnxvMboNDxzSd1ZwfFoALsZ3+KiMDnqcYW5HLnU7q81sYvigFzVyPJOIh9asVsKjPXFbfX2WchmUPis6rr2Ml52jiexrXiqf0j9/Tm5MZGFovLusJbUdbvoLe/FpXyLeuDvbZhqc65Ts3cL8EcelKi6a3O1kSApkdRS6ENYwz7TE/mj6LYlskR/lpPkAOfX73LgmgOk2oTXmAVKGVnR2GDoDyiIfZ1hsyC0Pxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0UPVsC3RnMyxvFclXyG7BEvYpRt6OXZqAM51rx7At7Y=;
 b=qHWLmBpC7rWhN92QLZiJ3Ml1aCGDq3Zv0+OVlrzsSXyNpZrUAh+2qoIyrSvWq798PPuQggjOaf6rIJ0dIIcUjUMhVtEPpCoHOijYeN/Q0LE79Fz4otu3MpaDgN4yAdBJ9sWH8fAVWIm4RhTVztRFxt4iqrFYrTPgkTpnp5vTOALRWV/XnWr5l1J3GIwU/WnZR/6GLBtup5GNBQdtJJpZW4lJ960FDVDllWVhvdGisDZbCvzLIdExqpH1oF+gXszbRHYCAZEPezVvSGUaHkiKdxJG/od6WO5BMogv4ESN8XWHWWMTdzzuNyTFL4UEB6QKg9QP+7zQCY0ds/zE3OEFMQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DM4PR12MB7623.namprd12.prod.outlook.com (2603:10b6:8:108::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.33; Tue, 5 Sep
 2023 13:33:01 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%5]) with mapi id 15.20.6745.030; Tue, 5 Sep 2023
 13:33:00 +0000
Date:   Tue, 5 Sep 2023 10:32:58 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Michael Shavit <mshavit@google.com>
Cc:     iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, will@kernel.org,
        robin.murphy@arm.com, nicolinc@nvidia.com,
        jean-philippe@linaro.org, tina.zhang@intel.com,
        Joerg Roedel <joro@8bytes.org>,
        Kevin Tian <kevin.tian@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Tomas Krcka <krckatom@amazon.de>,
        Yicong Yang <yangyicong@hisilicon.com>
Subject: Re: [PATCH v1 0/3] Clean-up arm-smmu-v3-sva.c: remove arm_smmu_bond
Message-ID: <ZPcuCo7mapUN0kt5@nvidia.com>
References: <20230905115013.1572240-1-mshavit@google.com>
 <ZPcgkO7omYremwyV@nvidia.com>
 <CAKHBV27wi53xtDK4JzM6xH0OB7Ps0A8SewN3A0OJdpTuT2856w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKHBV27wi53xtDK4JzM6xH0OB7Ps0A8SewN3A0OJdpTuT2856w@mail.gmail.com>
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DM4PR12MB7623:EE_
X-MS-Office365-Filtering-Correlation-Id: bc61cce8-0979-4cd7-bf12-08dbae149fd2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: msYdgdjJOH7V56A/srtbyhgaW/FZxGKHg9tDL9vDmJlmAjdqD/K+Ajo7Y33OIpDjuGyIzDjDkBQgG3QvdcWisytZyleUESQ7flbcF5zFbbF3UUOfd/SYL7W8IptW90DldR+8VJz4OTzywA9dt6/ABL0o7JbC9li9bPSGUcR5buBSwIQGubQQ91eDdZcdpioHdkxy7Otvp2WWulQJSQtYN1Iz0hI3zrqJbV/5d3O0fd04wFEVXFjUs9CBva2zjQTJka1EabeyNSNduoyDgTHccVOj6HtP3jyLkh2ga+E4JyL+jSEzPjKHhA4c1uzrLMAz+UgSXPhfDm2ajUFdv7mrlHcxwmMI+MFl7nffo8mM2h1NhUODUi9ECmoDQX2UzX1FKIB9qJYliTo1RzIxapMpXUNJBm1vsP0oVknSDzvRdEIdwzia5CfE2/4EKCb5K72d09MT5o0T6sPTYvDabMDhVsSHQzt6LGh5M6rMuhovr4JQLK+HV8ko5iG2B5lD9sJuFBidU5Zmt4+7QrfXOMD8WpRYKy4ioCvI2uyJcp9NtHNtCw0eHenovYHMe5Tftn58
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(136003)(366004)(376002)(346002)(451199024)(1800799009)(186009)(6512007)(6506007)(6486002)(36756003)(86362001)(38100700002)(2616005)(2906002)(26005)(53546011)(478600001)(66946007)(8676002)(8936002)(4326008)(5660300002)(7416002)(54906003)(6916009)(66476007)(316002)(66556008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NUJacWRYLzhhWC9iYVpQVklxMTZBV3JVMVJXWWoyblFsZWZSVk1LM1UvVUpt?=
 =?utf-8?B?cU83ckVESTVXQWJtSDNFRHRwOEwwVFdRV0xvZjBIS0ZYTGZuMVNvQ0VNMU5s?=
 =?utf-8?B?ZjJ6QUlBam5lSEZVcHAxQTY5TFUrWWhObEZSaVpvdmRlc2J5NEJxbUdFSVpy?=
 =?utf-8?B?WG0wVndJM1FzOGEvaEp1ZU15eUNZLzFOUXFaejRUY1VIdDd0VzJ6MXFoRTkv?=
 =?utf-8?B?eXExSnF1U3FxcGdERVlsbjk0S0dEWXU1RGJOcUw2Y00yYXFrSDBOajZERmd0?=
 =?utf-8?B?dXZUMGtxTlVlK0lXbCtMR3pvVmNFdDkvQU5EYlRiVDVUZVVuR0ttU0JsMTVW?=
 =?utf-8?B?aEduQkN5QzBGRmZuUmJ3VHNwbTVoMFFMMFA1QlpxVzBreTdsRnUra0M1UDFO?=
 =?utf-8?B?YlRtMmVnSnI1NHpZclBGMlRaa1FVWlNFbTBDNnJ1Qk94RFlzZmRjVDFZeHE1?=
 =?utf-8?B?ckppNkxteTZsYVdvc0lpMEt0QWZsZGVzWGZwZ2dScFV6SGRrelRWQ2xJYThP?=
 =?utf-8?B?N0xJS0Q0SVFndzBaNW1tVWhlMkVHUzZVYmY4SHQ1NUg2UXBwYzFsWThTeXoz?=
 =?utf-8?B?QXRJSk4yb3czeVcwT051NVV3MksxM2lXZVNmRHNCVlc5TERlcENUU1RzU3ZE?=
 =?utf-8?B?OHdhZmNEejliaGlrL3haUUt1d0p5TWJNZTJxUXN0SkZPamFWNmRKSFJyL3FM?=
 =?utf-8?B?a09RWkJhQlNIYXhmWU1mMFlUWmoyUG5NaFB5NWw3VXY4clZ1Z1hiTCsxWS8v?=
 =?utf-8?B?SVZydUU5aDc0UXdQWW01UEJiT0h6TXpZYmFYRjI5RVhIZmd6OWxBZjZocEtm?=
 =?utf-8?B?TG1OOHBHZVFVS0xEVG1DczhXQkg2dnk2M3RoaUxhY1B0QzgxU0Uxd3U3NUIr?=
 =?utf-8?B?QUlSTHdSa3ZBVENJdFdQK2hlQm9CSnFLcEtxajNvbGp0ek5IOWRManJHU1R4?=
 =?utf-8?B?anRFdm5hT0VhRHFuT1lMb3lnRXJyS1c0WjRnNndNait6MHVDQjJiRWtTM21Z?=
 =?utf-8?B?TVI4YkMvdVpTdUR5Z0FhYlQwak5SUDBtaWtxZ1EyS2duSWc5Zk1zbGJDUTZy?=
 =?utf-8?B?ZlFYSHU1TGNpUWp4RHBmUmxLWWdCOFErVlpreXZJeEd2VEs5VEhRSGp4Umh1?=
 =?utf-8?B?ejZLQVRTSEtpSCszekVQdm9HYWRNN0k5M0w5TFNyYUl5OXFRMnlId1J0SUJJ?=
 =?utf-8?B?Q1FNUVBaQktvUXpkQm13bG5wYk9SNTIvOWd1c2VKOWZZUWYxbjUyYmllMFgx?=
 =?utf-8?B?V2tTbVpxY0daV29jZDd4T1RvYjdSN2JrZW92ZjdpYXZiOTB6ZjFuSUtUeTVS?=
 =?utf-8?B?SkdLRVh3YW15RUFJV3UxcjN5Sld5VDJUVWh5U29ONlhtWWhWam5hYmZTWEt3?=
 =?utf-8?B?MFVFV2NvMDJaOTBROU9DQUhkR2NpL1U1Q2VSbnBYRGRhOCs0cHgxcUg4L2Jm?=
 =?utf-8?B?RXpvWnFCYU1BM2VlZnpxMUR0c05QOGRjWHp2QlJaVGkrM3ZDM2k5L2Jjc1ho?=
 =?utf-8?B?VVI0Qy83K0hrVFZVVFJaQ3hzVzV6NEt6R21vQ3ByV2pJWGltb0hlL25VV29u?=
 =?utf-8?B?ZWJFc01kajJqOWNqM1J4Q09VK0NBUUFkTXd6Q2FBSWJtRXJUcXZvKzhzR212?=
 =?utf-8?B?VmEzRElDbmlpL0RsRDNyMEs2b3NHUjdVbmV4dFBtaXVITzRoNVhhRFFRYzZz?=
 =?utf-8?B?UjlxaVdTRlZ2eW44cThUZWFLRmpPUjFjbE1lSWlXNU51WjkraXlReGg2bTE5?=
 =?utf-8?B?WVpUd2JMTkJxODdlbVoyekRqbHBuSkZUUWV3NHFodjA3WDM3eHNSMERBYWQv?=
 =?utf-8?B?MGJHZExENS9uNlRiQTRBOGRxUFh2UnNhWVlHUUJZM1d3azBDbVMwVDg1WnNs?=
 =?utf-8?B?NXJUYzQ2WEdSVjM3ajk2aUtaQlNnUTJNL0IybVIxWU9uRVhmWnVON0xvVm9a?=
 =?utf-8?B?U2hoM081aWZTZHdYOHlPa0JUTUtxUzdhYStYQ1Iydld2YnZEdVNMbnd3QzVq?=
 =?utf-8?B?NFJEOXhCM01sNlpOL0w2WDljRVE1ekhMRmRsUHVMV0NGVjEwRHpwSDRpWUNp?=
 =?utf-8?B?L003SGNEZTR6VjBJc2NBRjZtMXFER3B0eC9iUll2Q080NlBiSDk0OGdLRjVZ?=
 =?utf-8?Q?vJzF/a/5JkIOB4xhCknLFfZJD?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc61cce8-0979-4cd7-bf12-08dbae149fd2
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2023 13:33:00.8417
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2kpXa5Jyo3r9uixw9hF2DSKb6bnLw7RbBCIWHsGKM7IszE/TdCG796AqO4vR6+qm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7623
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 05, 2023 at 09:24:22PM +0800, Michael Shavit wrote:
> On Tue, Sep 5, 2023 at 8:35 PM Jason Gunthorpe <jgg@nvidia.com> wrote:
> >
> > On Tue, Sep 05, 2023 at 07:49:11PM +0800, Michael Shavit wrote:
> > >
> > > Note that arm-smmu-v3-sva performs a second level of normalization by
> > > mapping multiple bonds (now SVA domains) attached to devices with the
> > > same SMMU (if those devices have the same RID domain attached) to a
> > > single arm_smmu_mmu_notifier. This is not affected by these patches.
> >
> > Ultimately the notifier should be per-iommu_domain as well.
> 
> Speaking of, I'm questioning whether the multi-SMMU domain patchseries
> and Tina's sva domain sharing are really prerequisites to get rid of
> the notifier sharing. Is anyone really depending on or taking
> advantage of this?

Currently I don't see any in-tree user of SVA on ARM except for uacce,
which seems to work with only one device (HiSillicon QM).

So, yes, you can probably make it slightly less efficient for a
time. It will be functionally correct still with multiple registered
notifiers.

Jason
