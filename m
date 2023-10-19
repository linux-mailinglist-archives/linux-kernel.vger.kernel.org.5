Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1F47CF777
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjJSLvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbjJSLvt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:51:49 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2062.outbound.protection.outlook.com [40.107.223.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23319186
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dq/qxihtwjAqpGKWi3/YBQWM39ZQMd2h7wRaSzBn8v0yg47l4LPdylNohzyHgIuslZyW/OHT0pqXettHzILaLU+R939YlyBeKnzznc08XIetcaA9wChpokby2W3syIy+gdmav5Ua3lRyr92edD064+FKzahXoejNETcTpjHwppvDfElIJA+APWRODrFc6BpEeuGMrd4fhfAuZ2xhfslSFowEoGIf5B41dKlx18ru85aOG+YIwb7B8yq1Lqpf8xfm5r6pOaepGxWe+h2V+0r0hHXfWz/RWhmGO653VcCfT0VXWDHN0sIJVOISBguM5YY/eM2GX6X3xV5yPfQBk4YK7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Zccym4u0LkTxPoQ3YmXcsJpeK7yZD5ylo4Y573iBzaw=;
 b=knp2MpPhy66OE00NkYdlarMNyhGDCoPiuICd11Ppz6Y8PmL2GTrTeyP7pf6BIgx6M6W7tfOPl4XTVoUEq+7IOH/4rplzgYd2ONiyE/I/hC58HQRooq74x26QwfFmUVnXGeLVOBUQg0N+LJe8iKXeE8851/wkCTO8V5UxLhQi549PoHWSmtV/x5VrgMRx+PFJwCIAWOu30J8zX/j7TpUWiwH5p/RtHmo8wojbwNUoopE9uNZVE7Nem0Wupv6eSvhf+OMFSTsxN7Cy+Afg/dG2kQ+bXBOl48v7QPZu09WFwZu3k7GLOUbnddhlph2ZLnrWCGlRNfvoybVd8dBx3SuwJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Zccym4u0LkTxPoQ3YmXcsJpeK7yZD5ylo4Y573iBzaw=;
 b=AReQXoC4/62edN7Rh37qOihhS1ezQM5jfUkw6xeTpK6IYoNms+UqRAOFGbaWrPmOelNZd6fZTpGjelEWMf2LBDkYQI9p3o671NJRk4JgQHXqAxFdvW3XLZzJDf4B4zXyRl/R/D57NArh5nFO1S1KZZqNLwFu60grlOD3VYNEvMMKkUmjnDfn0kY+zcq602kPOcKc29RWVac4uE1HdmY2SOgMvcmGgt8oI3+j1QYQCrlZlB2c0ivBzdArnAPe2GAV3T6Jtup9yCW8CP007Qk68ENFiZJdeuiY10+Y5Ewrk+FGRSAFZo5PLjvpgGZ9PE8SvkyhmrBhtCUrTmI0GjOUtg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by DS0PR12MB6558.namprd12.prod.outlook.com (2603:10b6:8:d2::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Thu, 19 Oct
 2023 11:51:44 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::3f66:c2b6:59eb:78c2%6]) with mapi id 15.20.6886.034; Thu, 19 Oct 2023
 11:51:44 +0000
Date:   Thu, 19 Oct 2023 08:51:42 -0300
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
Message-ID: <20231019115142.GQ3952@nvidia.com>
References: <ZRLiDf204zCpO6Mv@arm.com>
 <ZR6IZwcFNw55asW0@lpieralisi>
 <20231012123541.GB11824@willie-the-truck>
 <ZSf6Ue09IO6QMBs1@arm.com>
 <20231012144807.GA12374@willie-the-truck>
 <ZSgsKSCv-zWgtWkm@arm.com>
 <20231013092934.GA13524@willie-the-truck>
 <ZSlBOiebenPKXBY4@arm.com>
 <20231013134541.GP3952@nvidia.com>
 <ZTEN_oe97VRWbnHb@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTEN_oe97VRWbnHb@arm.com>
X-ClientProxiedBy: BY3PR05CA0015.namprd05.prod.outlook.com
 (2603:10b6:a03:254::20) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|DS0PR12MB6558:EE_
X-MS-Office365-Filtering-Correlation-Id: 280a1eaa-b49c-4a9e-205d-08dbd099c42e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: g3WZGMMd/8KhKH2XMBvaCLYWSzRBfdg6qp05WMbOjQ2m6fPGa9mHsgeeq4/HvlcB7VooZyzKuJU5zRZwZh1wUgqN+Wkb9VEgB1GH/zcg7LZ2/ImQx7euR1sJyjh7xlNlI2WlKZKkEnUMF53glI51LcuoK6VOlk42kyTTAkKCIyc85ab3PMfKvR4+8QVZX56DO1Sa8Dj8ySIoPHhV4gu0jUL5jtfY2ITZKJR3Ma6xK9m7uK1XH6IIAGajN1HXReyDQn9Kwt+ML6En2MmprViv3bzTA4MGqrLFXeVN1+4UE6E3QX6+JNL2tirVZ74/Zx6IqNO18h3pgrZ6AE5jCPfVpMdN0l3PYPgSIo6qcrv+xXFktltGx+xMZmqo6A6AJJ0uLHhyRt8GcHt4xg9PhsoQQGGLGcx59MFwg/sVAiQjpYv6JzXA9Cv7zk+C62nNNyWHA26FId5BE8CMi//ATBH3jz8stW0W4f0RJ8348AfNKCmvZ70u+7micvSc5fFu0D1RMMcnlIXPZA3Q9Vzi/yNMquCiDO5ghFc1HvofBQ00IaBEgwHTlhk75J9LTgPNFcBO
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(396003)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(6486002)(316002)(66556008)(66476007)(66946007)(6916009)(1076003)(26005)(38100700002)(2616005)(83380400001)(86362001)(33656002)(36756003)(54906003)(478600001)(6506007)(2906002)(5660300002)(41300700001)(6512007)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pxg8H4qC/8pNWRqmkcvDWi3H7Sw8AnN0v0EjlLHAyzOT3wvChjwsCnS9jg8E?=
 =?us-ascii?Q?mCsMmhczhKT1Wzp5kq6w+2/SOK9t2SSoq3R4bMuZ4YjtAqsibDvq0xPf875F?=
 =?us-ascii?Q?p12A9H6zYDOEkUUxnQIHa0LXn9vsFMCKa2oQVPA+J9JElfiIEm37DyHfFTQG?=
 =?us-ascii?Q?JbHmNaiaiB1l9hOtx7CRnZdQ6cNLxVnwMdxkldQBvX4KEG6vf7bEUFucG9GE?=
 =?us-ascii?Q?OD3ECS5U3CzRPIz2Y7hx08bao5jrwXVYa25ttLc/iJC0TQZGHHkjhux1YCFg?=
 =?us-ascii?Q?JXMgncqJZRVRw4VVEwkfRO0Kp4H/lzIAXq8QK7zARyxhARNrNdhbofVuRXsb?=
 =?us-ascii?Q?tdt/HqZHpPjZ0O+wYHYyQXhoOtulOott87JX6DFuM6dKSQOyhn+VqZXj6Y8l?=
 =?us-ascii?Q?W1qWq1DPmhzvxn6jOhSMl14DqYNKj473ouJKNlGRR3sW9O0TMb+7FRUzbg2e?=
 =?us-ascii?Q?fyWb0mzr4pgHCywhK/xJkfJpSHiZd+NISeWrku83eAg1Y6Gesjhtm1XRuVs4?=
 =?us-ascii?Q?BZ7TliBIBr4TQZA4aaDWpBKhbqD4yby50MxwpfYo5/ViPK3CENw9W+Psa0b7?=
 =?us-ascii?Q?+HQFmosHsnOgsNU4HUwqA2xmlAVY5Ckhqh8Y9xJpXhDEQ9c4Dudqg6rWnWRU?=
 =?us-ascii?Q?ZnSkZqyWOIRfbNrfV7uWz6J7UX8BS5MiODBygM8OACQfCkyXBwmBDyZvZpPT?=
 =?us-ascii?Q?9DDVbcjrFP+v5rO71PCziTazFRRebS42FZEi6BbMjTPyOSWC3/RSAAeNDwuv?=
 =?us-ascii?Q?BZhU8gyUPgfQaPG7RlhZCRJippSj0jtrBHwOdMa91q4XLt4u/HqvTLk+PAob?=
 =?us-ascii?Q?8qPFZRNPV2V73OJohs65Zfub994Gpqr7enqSlj9ouMj9rMyIljc4ZbR5QQNx?=
 =?us-ascii?Q?Ieu6X6hIBCILJDTZ04zwxfybZ+uoEGuP1fj7WDHvpkuJwDoVTSbdaGsnQyxE?=
 =?us-ascii?Q?+Itm4jZKVlaAko/QltVbVltrwV8QpgK1wkLuQ355YzYwntiHYQosmyIgz2Hn?=
 =?us-ascii?Q?uH8DA70lFeTdRMWUd0QifjJnmzHHga3vJDOOu+D8hPJz5MOUVf+ew1Ubs+3u?=
 =?us-ascii?Q?8Q6ELzJ77rte2wOr7vknxzK4Pke0/90mH4WCtNIH+80WF244p6nMGJ4+IXFU?=
 =?us-ascii?Q?fVLXaFRItnHvI8Yhvr8wp4/ycQU0i5PT/2/kbgS6Y3H1Dmj4XJg/c5XIKxDN?=
 =?us-ascii?Q?NqW6G5CAuQ93JNSSC5xbTa7AXni8LhywwvTAB7Jv6Ay/1OYSBJeEdJS/NsH2?=
 =?us-ascii?Q?5cK63vEv/XivF7IomsX+rda/PnifPYv0pixMk/QZRBUSObLlTbrKmbMrYGJt?=
 =?us-ascii?Q?+F9UavnlIK7emsspNLwAzJIWerZQJoIfQZn8eCH8vfZMjpUktRWJ3Fx74td6?=
 =?us-ascii?Q?j6IvBe9WYtzzQLPMrtRjqu5cQDAiEvgE6bcMRkywDEB+BdBZ3u5SPm/uq/ka?=
 =?us-ascii?Q?8C6PlucdmjnaIuLfA3TYIungzdyVHSZqz8dOHgmdo0ZsgAETb4597E8vdWoM?=
 =?us-ascii?Q?A8QTZDqCohM9mvtW6gY66sO22T3AR8zqTXU7VlidJlEjlQkmDzy4usNAX/Hq?=
 =?us-ascii?Q?tjMERfRJjl6oy1d5ybbW7EDfRdZtIjlrmN08T+fC?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 280a1eaa-b49c-4a9e-205d-08dbd099c42e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 11:51:44.4617
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7RAwup1CoLBawp28Ajg3ZrylYvvbdF2s0Gj9nHON7r6551rkshY7a/VGPxzy1Sne
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6558
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 19, 2023 at 12:07:42PM +0100, Catalin Marinas wrote:

> The issue is when the device is reclaimed to be given to another
> user-space process, do we know the previous transaction reached the
> device? With the TLBI + DSB in unmap, we can only tell that a subsequent
> map + write (in a new process) is ordered after the write in the old
> process. Maybe that's sufficient in most cases.

I can't think of a case where ordering is insufficient. As long as the
device perceives a strict seperation in order of writes preceeding the
'reset' writel and writes following the reset writel() the absolute
time of completion can not matter.

At least for VFIO PCI the reset sequences uses non-posted config TLPs
followed by config read TLPs.

For something like mlx5 when it reclaims a WC VMA it does a RPC which
is dma_wmb(), a writel(), a device DMA read, a device DMA write and a
CPU read fo DMA'd data.

Both of these are pretty "firm" ordering barriers.

> > Unmapping the VMA's must already have some NormalNC friendly ordering
> > barrier across all CPUs or we have a bigger problem. This barrier
> > definately must close write combining.
> 
> I think what we have is TLBI + DSB generating the DVM/DVMSync messages
> should ensure that the Normal NC writes on other CPUs reach some
> serialisation point (not necessarily the device, AFAICT we can't
> guarantee end-point completion here).

This is what our internal architects thought as well.

> Talking to Will earlier, I think we can deem the PCIe scenario
> (somewhat) safe but not as a generic mechanism for other non-PCIe
> devices (e.g. platform). With this concern, can we make this Stage 2
> relaxation in KVM only for vfio-pci mappings? I don't have an example of
> non-PCIe device assignment to figure out how this should work though.

It is not a KVM problem. As I implied above it is VFIO's
responsibility to reliably reset the device, not KVMs. If for some
reason VFIO cannot do that on some SOC then VFIO devices should not
exist.

It is not KVM's job to double guess VFIO's own security properties.

Specifically about platform the generic VFIO platform driver is the
ACPI based one. If the FW provides an ACPI method for device reset
that is not properly serializing, that is a FW bug. We can quirk it in
VFIO and block using those devices if they actually exist.

I expect the non-generic VFIO platform drivers to take care of this
issue internally with, barriers, read from devices, whatver is
required to make their SOCs order properly. Just as I would expect a
normal Linux platform driver to directly manage whatever
implementation specific ordering quirks the SOC may have.

Generic PCI drivers are the ones that rely on the implicit ordering at
the PCIe TLP level from TLBI + DSB. I would say this is part of the
undocumented arch API around pgprot_wc

> > > knows all the details. The safest is for the VMM to keep it as Device (I
> > > think vfio-pci goes for the strongest nGnRnE).
> > 
> > We are probably going to allow VFIO to let userspace pick if it should
> > be pgprot_device or pgprot_writecombine.
> 
> I guess that's for the direct use by an application rather than
> VMM+VM.

Yes, there have been requests for this.

> IIUC people work around this currently by mapping PCIe BARs as
> pgprot_writecombine() via sysfs. Getting vfio-pci to allow different
> mappings is probably a good idea, though it doesn't currently help with
> the KVM case as we can't force the VMM to know the specifics of the
> device it is giving to a guest.

Yes to all points

Thanks,
Jason
