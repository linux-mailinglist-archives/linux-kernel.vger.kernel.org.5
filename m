Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90A197C8723
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 15:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbjJMNpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 09:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjJMNpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 09:45:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2050.outbound.protection.outlook.com [40.107.223.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7168BF
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 06:45:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjbFASXYbGh8IuB7zprPxIYLlrm6mY+nRHpjRl2uyNDNw2rOyUHlHxCw3czo+bbWqEsYVI0yqIZopOg/6fWwDZp+9kTikvW/klgHqtbTIqYDZbEhENeTiqpYiozDQp8P/oaXpY1R2edX2SkRoHGc9Ou9t2Oy5YxevB6OnZeukGuxwj/cqIauUmaqDfN/fDmj5vXH+xFLGDg9IzdN6f70diY3hH8QqZTiLJDGwZBWBYqOz23/XtKW0bXGgLVxaBEaXm8Vo0cwdpiAYV4nCwtDQncwafhQr7nE6IOahwzynDcl6wnV+elITtexNNZW0U6XMweLm+8NHC9l5dMTddKBKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zj9tC7HJY34JeQwMpdykjQOCcz+84Y+6fMYXoCbiHHs=;
 b=Lis6m1o+mD1fFqL0ZPWI75l1K7DfZXb2a5i5QXjIEJA8PO4PtQzBYxop6zZKLsG6pXv0WYbRKuZMpfxoZUk5x03bwY2UVaBXw5T8+3UnYS5PZ4RjFKdcyfI7HziTl3CesgGufWAVpgumUtiQryQ1QBMfdenROweYZrvNONc1M9h49Qxii8uRk+1Wbq3QUn8VHLDMB/kh+HVHInYc1vifW3ezzy2EmfdqUz0KAR1fv2Clsiif4klyX6nQD/VggfsKSoT+4xxyVPhbKlX/Gu7amntCmy4GhLj5cbbfg74NI2y7AzOIL63P1nzV7d555fivcX1qWv+Nm+YGVaUogzsrtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zj9tC7HJY34JeQwMpdykjQOCcz+84Y+6fMYXoCbiHHs=;
 b=rM1ky8YWWIza891Z25K0LtSdHHXRL2xQvmincihYArW/xxeU5khSxPsUsoXDHMGKvWNqGLtKu2qyAnK/jNkny22Kg3yPJ//ekPw1XfiytERTd8Dzo5Hhup9Y2LJmWfeMafV3CRvf4kJ/g7Hedul7b3VVHeZGNOLLwL+5C/KzO1ja3Va9E3KTLJC4t4gA/v8tHOj8MCioR7Y0bchw+eXjNueJpgqykowMJVq1s+3zsUmV3tnxeHtQH0GEYGPLlSGaFgUEj6ffsvCPFjVzdINjK18cCvO90zpJl6hFeV2kFckOk5r6wKUwjs0AYBUR8tR3Nl6uYZN33annN/XLl1iVpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SA1PR12MB7039.namprd12.prod.outlook.com (2603:10b6:806:24e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.45; Fri, 13 Oct
 2023 13:45:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6863.046; Fri, 13 Oct 2023
 13:45:44 +0000
Date:   Fri, 13 Oct 2023 10:45:41 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Will Deacon <will@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>, ankita@nvidia.com,
        maz@kernel.org, oliver.upton@linux.dev, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <20231013134541.GP3952@nvidia.com>
References: <ZQIFfqgR5zcidRR3@nvidia.com>
 <ZRKW6uDR/+eXYMzl@lpieralisi>
 <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSlBOiebenPKXBY4@arm.com>
X-ClientProxiedBy: BL0PR1501CA0004.namprd15.prod.outlook.com
 (2603:10b6:207:17::17) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SA1PR12MB7039:EE_
X-MS-Office365-Filtering-Correlation-Id: d725e508-9ce7-43df-3774-08dbcbf2b247
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vGhhVrrwe30MZUZe1Pf82R+xk5w+bE18ggmRxkheIS+pRaBpbvvHVgRbdIPs6rrUEYSUwtLd6cwTAsOdxYxHc+Z3mZqDTCf/yFfhzId8DiYtWT1VB3mn5jA12xuPfHkOU9Gsv+N9uLjUbNUb1jTiuWR+frVeiXTc3zlnuwzUeGYWPUE+/1hZ14dNNUz3uKOetxIkasb1ZFBGBWlihEJ18iAtkd/qEpui9Gj/FITahyXtCdADdghJyic/4w+xbxUSkfyiqt+dSjR1mIfutDzMvCRbn1hEu7So4uSNb6PVBdSrkuoo5P1mw4DI/M7OvePvevQZ8CHz+GVq69gTu2Ga++XMaNCpa2X/CorB3BDm7Y8OQdhRu8LBYOLmksxyOtjAZ+zF7sAxccEaeGwsnVx0HPFA29k3xJrgtG9Pc4cEeOsKUS/z3EbFHP+GwRVuEmlc28sKtBOHSJNaAAgojC/PihjMjWyNK+wUfL+VrNUv7Q8G3qM0J4ywuQYij27McXLlb9/wo9TazXR1YrpeXL02kYWQYCzBLqQLgAwe1zycIVEcr8LBR+FRCczPeNG61Qqi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(376002)(366004)(396003)(39860400002)(230922051799003)(64100799003)(451199024)(186009)(1800799009)(2616005)(6666004)(6512007)(6506007)(1076003)(33656002)(86362001)(36756003)(38100700002)(26005)(66556008)(66476007)(83380400001)(8936002)(316002)(8676002)(2906002)(41300700001)(5660300002)(54906003)(478600001)(66946007)(6916009)(4326008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qDEdSY7+scZs+f6xHW90ntRg/00uqpMc4Drxz0NtSF0mW1picpIhEWR5Mbdd?=
 =?us-ascii?Q?uIpwMwoIoG9gYCFBcahIrI7qhzTZqx58ALaOuTUNf48FGI2ufBKvWG5nbqBo?=
 =?us-ascii?Q?xWuW0Is/wXw312ykg2i49kGAXyp2Q30IH2vdsQVJy8M/ZgEcWNm7ur4cUFO0?=
 =?us-ascii?Q?FMBS2pDc7w/Ttt16cgLapJtxoodLZcgWdCaLT3hyrJM+JSdnOFnMD/eOcips?=
 =?us-ascii?Q?l1bbynqiEsbGU5fU6O0D7ZeJINLFAxgZA8imc9z1yjXvqE74G6IdymhHuNxk?=
 =?us-ascii?Q?pv75CpUBz2AL8I3qlgsVFluQSlQ0mPYkDA805XuYIkAciglyhc8hg5dt3yA3?=
 =?us-ascii?Q?qDQgDLYOY7yMZ4WTqE7bNHMC1gJnH3qthKDpTrJKWeko1bV1FToLQsrjiqpr?=
 =?us-ascii?Q?lmSpdxTHO2BOKk8ixRs3Wv0LrKw5x1SSVtVG0E3rEYr/PvuWCiZn/ycvhyzO?=
 =?us-ascii?Q?Wg5p6uZLYGZeFb2cVjyci+sSA93maD0+73GItHFCbiZ8s7XMTobMDqmK7lFm?=
 =?us-ascii?Q?NxSaSPyV4lyb90wH6dK0pKF4/v2fGgDwTbc1Q2nGPGRRCrfwYsecYZjLa3ZA?=
 =?us-ascii?Q?OnPPoV7xBcsmMkG7dv1F4yHQvYHgRCg6L1xbl3sN+5nnt+UerOq5ji1fQ6+L?=
 =?us-ascii?Q?AIJAuCHUDSH9a1QcHtw/kYo1t+4n6TF5VDasBHSINhiVVbT02p831nFDKm0C?=
 =?us-ascii?Q?EKhlIQRE2VD2vA4Mmy2AkvEssNRZWQtQm31z7byjLYQHM/idyUhHUpf33jT/?=
 =?us-ascii?Q?L1L/lXVymVxp+NDdyUZZ1PsKn1Vsuew6XxbP+Q923DGERkkkOjrmglwHEIVW?=
 =?us-ascii?Q?vy69QqQThXSCjPMKodxxgKovjvn0JDoe3nai8M4Swj/Y5CSpfXnNfpw7yFuF?=
 =?us-ascii?Q?sHhr+u9hu8kjpjF0cNXs/Mj6ILCQMsxjBQAP0ZMGSCCVCvn57rVJeAx8HQ/p?=
 =?us-ascii?Q?bwxycaeSOQwVVDUbFaVyuScQps6wYiHIbfLqYABTNmvDhuSqlYgq4+Zh60mM?=
 =?us-ascii?Q?I8u59AI7EXBnk79xejoittRqPcFDbRXTbPqVrIRx45tVI8atknjDcdGTTu3A?=
 =?us-ascii?Q?+Ee+W556HqdzinvrPO2+kYqCLIZJRhCVCypOrzYQpC5pmbpAoj77wMHIMjH+?=
 =?us-ascii?Q?drgbQ5bCTfLKgRc/MSVl4OdVBNshs2eyPgxcqzJp4yXvcWLuML3C1fV9NXiQ?=
 =?us-ascii?Q?FArWnYpF4czwb4uzf6DLDF3K12NS8cyU9PaCfkPlialYDjfvRMsW4EwjDiV3?=
 =?us-ascii?Q?cTWwcdLMC4nYZUx84det0C3XUcGPTfnnf5rXPLCny7lfewZVWOEraBB6g69s?=
 =?us-ascii?Q?87Dzr0UHD4EcTPYm9sSHsdcSFzaizpjmh5cWJb42RPbkiqK9EeCKSSfA5p/L?=
 =?us-ascii?Q?bTPTM6+hwTPHQ+f76HU6fH6ST+vzRXaBXh0fYt53tvibAWQ6oVhahtPPZloO?=
 =?us-ascii?Q?3y+hyjT1DVMctkw08MP0kU4d0aV/Lo3GKJJHrshLAzrg724cgQHvDLrDvM9T?=
 =?us-ascii?Q?OiTmjKLPKgicdTtCPgP6nH4kWGS3fYN6f9VezRYEthDGiGQQx6cGJJWjHaT3?=
 =?us-ascii?Q?P17r6rH6+lMGBy79sjA=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d725e508-9ce7-43df-3774-08dbcbf2b247
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2023 13:45:43.8223
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wUvYBeYgtxLvcYgniw6CstdGUMv0/hOZlo5NRXz3FtK4y5PggQuK4zBrYkIQi4cM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7039
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 02:08:10PM +0100, Catalin Marinas wrote:
> On Fri, Oct 13, 2023 at 10:29:35AM +0100, Will Deacon wrote:
> > On Thu, Oct 12, 2023 at 06:26:01PM +0100, Catalin Marinas wrote:
> > > On Thu, Oct 12, 2023 at 03:48:08PM +0100, Will Deacon wrote:
> > > > Claiming back the device also seems strange if the guest has been using
> > > > non-cacheable accesses since I think you could get write merging and
> > > > reordering with subsequent device accesses trying to reset the device.
> > > 
> > > True. Not sure we have a good story here (maybe reinvent the DWB barrier ;)).
> > 
> > We do have a good story for this part: use Device-nGnRE!
> 
> Don't we actually need Device-nGnRnE for this, coupled with a DSB for
> endpoint completion?
> 
> Device-nGnRE may be sufficient as a read from that device would ensure
> that the previous write is observable (potentially with a DMB if
> accessing separate device regions) but I don't think we do this now
> either. Even this, isn't it device-specific? I don't know enough about
> PCIe, posted writes, reordering, maybe others can shed some light.
> 
> For Normal NC, if the access doesn't have side-effects (or rather the
> endpoint is memory-like), I think we are fine. The Stage 2 unmapping +
> TLBI + DSB (DVM + DVMSync) should ensure that a pending write by the CPU
> was pushed sufficiently far as not to affect subsequent writes by other
> CPUs.
> 
> For I/O accesses that change some state of the device, I'm not sure the
> TLBI+DSB is sufficient. But I don't think Device nGnRE is either, only
> nE + DSB as long as the PCIe device plays along nicely.

Can someone explain this concern a little more simply please?

Let's try something simpler. I have no KVM. My kernel driver 
creates a VMA with pgprot_writecombine (NormalNC). Userpsace does a
write to the NormalNC and immediately unmaps the VMA

What is the issue?

And then how does making KVM the thing that creates the NormalNC
change this?

Not knowing the whole details, here is my story about how it should work:

Unmapping the VMA's must already have some NormalNC friendly ordering
barrier across all CPUs or we have a bigger problem. This barrier
definately must close write combining.

VFIO issues a config space write to reset the PCI function.  Config
space writes MUST NOT write combine with anything. This is already
impossible for PCIe since they are different TLP types at the PCIe
level.

By the PCIe rules, config space write must order strictly after all
other CPU's accesses. Once the reset non-posted write returns back to
VFIO we know that:

 1) There is no reference in any CPU page table to the MMIO PFN
 2) No CPU has pending data in any write buffer
 3) The interconnect and PCIe fabric have no inflight operations
 4) The device is in a clean post-reset state

?

> knows all the details. The safest is for the VMM to keep it as Device (I
> think vfio-pci goes for the strongest nGnRnE).

We are probably going to allow VFIO to let userspace pick if it should
be pgprot_device or pgprot_writecombine.

The alias issue could be resolved by teaching KVM how to insert a
physical PFN based on some VFIO FD/dmabuf rather than a VMA so that
the PFNs are never mapped in the hypervisor side.

Jsaon
