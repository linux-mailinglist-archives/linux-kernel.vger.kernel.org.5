Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98EBE79BA75
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345793AbjIKVWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbjIKRUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 13:20:12 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2057.outbound.protection.outlook.com [40.107.93.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2179E1AD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 10:20:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gjY14FD/lfTO+vmI4Zx62eH5KjCXqYG1ArM0mZSZrX/JX2CRMp9wiSIRuz9QY7Onx2Xd1MjNrN1up2I5H/+3ita47v6mcymWW/atbXHn4OYQKv6Hegoh8gFFpQm61ZoUKAPYtlJb3C6l/17oHt1zLoB21WfG37Wns+Uic3CzRlESbroZimOq1+a3d9l2svnT34bntBjLZ46S0/+Je0a4UHsV+OGHC/R+Mk8RF7F+/xVn9dItzEDMD38b/9mV4kmvFNrG2meWLkjxQjbNrMdkZYtK/hbRIH0oeAdXU09XW2IVwb0f+4Ddhj9pvC2/5lfXSeQcyIcnjAyodL8ZXsScKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSLzcwU9wk7/r2R/C7Lr9Otxe/5j0fnLjX8ZrDflZdo=;
 b=GtUDNJ7a/H94Ik2Cw/R1m/Po0ELs/SajvG4ePnD3u6sI9FuXc8yA4oTqZ+Qy0a7427GVVq3P24pA5ufPNSi2PcSzvqOcSllAo5GAM6yshZUBGtYyIBnRCs7eWdGbIWNFAntrFEWEYoo2TygzWwgwD8vV3wf5Iy9VQebz40GrVFbnI/iqhNP5Nx8tuEvFt7x5LWcP36t2Zj+tFPcmaLZJxzOOwvHRtZ//uPP7Cq7lkh8+pjfw540FHNYl/Ta3tzSzUyblycIeMfdhV9estwZtFxWkgIL145VgFwQaFkhYZIdrGBnZ/Y13VLSyOEwSS4hKpR9wRbh4f5lQmR77mK81Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSLzcwU9wk7/r2R/C7Lr9Otxe/5j0fnLjX8ZrDflZdo=;
 b=Qk0SG/xXQQ7DE1GRBrMkr6HkgVq0OAdECvdldlXXNNaf4IhEhgk0yYcqF+va14fpd32Uc2zJEi+zdHuLV5+Ttn4oV7PR6a2wuzJ22gM+Txt2d/zWjpEPcnIEwbQKGYGxPcS3pNBr2uqWS1A2UefR+luBH9bEubz4Yb/VPOIreEteWG6U8SX2b32mp4euMuqQG5AbgaWsvbhnhv+55RWS+c++DuFQu4OIiWnNezqEq3ing1Vu77CTahUX/IYrBweb7h+fjVuTFJo3LgCuIFlDFWMR+QT9cPhiyFd1ohrrca/+WJxdjq9dG9pgHkGl552F9tzUDhgk1nv+yuQAwl615w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6578.namprd12.prod.outlook.com (2603:10b6:208:3a2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Mon, 11 Sep
 2023 17:20:04 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::faf:4cd0:ae27:1073%6]) with mapi id 15.20.6768.029; Mon, 11 Sep 2023
 17:20:04 +0000
Date:   Mon, 11 Sep 2023 14:20:01 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc:     ankita@nvidia.com, maz@kernel.org, oliver.upton@linux.dev,
        catalin.marinas@arm.com, will@kernel.org, aniketa@nvidia.com,
        cjia@nvidia.com, kwankhede@nvidia.com, targupta@nvidia.com,
        vsethi@nvidia.com, acurrid@nvidia.com, apopple@nvidia.com,
        jhubbard@nvidia.com, danw@nvidia.com,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] KVM: arm64: allow the VM to select DEVICE_* and
 NORMAL_NC for IO memory
Message-ID: <ZP9MQdRYmlawNsbC@nvidia.com>
References: <20230907181459.18145-1-ankita@nvidia.com>
 <20230907181459.18145-3-ankita@nvidia.com>
 <ZP8q71+YXoU6O9uh@lpieralisi>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZP8q71+YXoU6O9uh@lpieralisi>
X-ClientProxiedBy: MN2PR10CA0021.namprd10.prod.outlook.com
 (2603:10b6:208:120::34) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6578:EE_
X-MS-Office365-Filtering-Correlation-Id: 22851465-98ab-4bec-fa00-08dbb2eb5679
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2fUVj3ayg/FDfkMw0xtAbiEoKfEwkIEG5opORrv9GRShn7CY0EQSCDfjoSTqyHLuPDy0jWMamlyh3XXdb4Ky6GFHFLoX3fzZ/qR2uQYv2OU1i/jnRGj2lP1WzMnRuMLKYlVC5CT4S+sF1v9S0V9iSgWO6a7ZCQH/yxcWhLAk1hqeFZWY7Se/M5TSo7Zee0PRpPMMmMbGKOvTWpEG2oLXO9cKpQxRXI1FsUFuifub8DwFUDjO7HDfGOYGmwFKWJVQebHBmw4qoD0ABQzfkXLnkQoq6dPmdLuSmEu/DlEnzG62uLz753INUzspA/55WZvqJyF6h/FqdNuPw4hQY6AQYXRjGqPKvdlZJyNH4vEeoIjqWpnhOedXmMqNN+B5UnsWdg/8vj3q1d4r7pUYtlfWdTL5Ip5b/FNYvqRBfLmFAChtQrqL2ZHbWrh2FeQwdrni7HYGUxi8AKsWJY/C8Guaw8PjmUfiS648QPYwOPrXXQYATA6uoXs8SGOyhy4GweB4+/Flj9CXlUZwBu+w3XtI9F/0XnCXnIb4/Bk06KRqrQmiuiRT2PDtcH4UGlQSi7Fk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(136003)(396003)(186009)(451199024)(1800799009)(6486002)(6506007)(6666004)(36756003)(38100700002)(2616005)(478600001)(86362001)(2906002)(26005)(8936002)(83380400001)(6512007)(5660300002)(4326008)(8676002)(41300700001)(66556008)(66476007)(316002)(66946007)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EOuIMjZtth8mf6gIpALd0cB5Mysi5XfraPOknia/PbkjD4tGtEjnr8WGdxXz?=
 =?us-ascii?Q?etV17fNjc9T6VJyS7qc0rAZnez91XR66jgrIdM4wrgiKd0e9hbfXamAhKgYI?=
 =?us-ascii?Q?UIMQXLMin8Itq4eGqlZm1WFLoXOXQoaUs9Zeo7rYtYJZp2Q+0wa7NAnGifAP?=
 =?us-ascii?Q?tqaRph2ALZjzVMSFzPxqjrewQR6yvB/xrKkKI2gTGZQXKWrucOuduTV3KMPY?=
 =?us-ascii?Q?PeLf7YM8RIqH7EyBI1K9JqQ8GIRDXipp3h1aqOGALoqSHDGHbh2rdJHSw0tx?=
 =?us-ascii?Q?pytcXu3B1ztGdAUPSdQvO1SV72uK03BL70uAPw7T0MXSUUWPJYXRPPeaNt+F?=
 =?us-ascii?Q?x4mRlLv1np6+Tj9yXeyUSwZN2ypVjwqxfS4kQ4Mhv0vRIU0ut7B1IGAsz7Vl?=
 =?us-ascii?Q?7M4kKk8bXrqUfFEozlghCTsGVDbK0nZ34pTEQKgIgCK9NHzrk8oEd05Hgowc?=
 =?us-ascii?Q?4X3zkE/hxybURTq2Pa+jmX9WpS/uMlMUIso/igWAHgWGy6TyF/DnqZtMdu86?=
 =?us-ascii?Q?zTvco4vXWWnSazpp75pUFuD498m7jAF20berJmOKVWRog8YzaMlZ0UFN0jeS?=
 =?us-ascii?Q?B92VfUl5wZ7ilmzpl96KfrvcM1ZMe+x10eWNnlqY9auwh90OISVDG5WrqNPn?=
 =?us-ascii?Q?Bbq+jkVm/iWQykZ2/MpWY6RZ73wa3QqbdR8/AWdEaT6mnrlnatsvqpyUzwln?=
 =?us-ascii?Q?mTI4HjGtvbzT6d0hKPxjRPHag5XnXfpLX87R3mM0FqquX90BmRnHKfoMTIwW?=
 =?us-ascii?Q?1fkx0NkxaCPtAIHDDZE8hIn8hBpvrL0Oi8yKvH2Hz+G4i79M6wyilh9Qlvpu?=
 =?us-ascii?Q?FssogJjAvVqn9fp5QK9DiV9XjCCzECpXRXSxX+gw0gN6bfdtOiuRExqe9RNc?=
 =?us-ascii?Q?f4GUwrGNR+hjqvFsQ00rUtlOqcsmb5WskjIaaA0NJ+9xfZAvyWPA7D03Odsx?=
 =?us-ascii?Q?T46Xzy55EcaFMWquLtH6XfCxsWsOuVQaIJ1p22JIOVEqYJM/8RGqNEj0CDKm?=
 =?us-ascii?Q?ygOeEYBItUOMo87uftfVnQ6JC51vdoFWKked/tdKrvSCNS8DpPmJazds4pyC?=
 =?us-ascii?Q?RZpLK64Vqy9zk0H8rAIoFUzYTjsJTU9bUEN4QJWDH7uVsfc9pgk5TFzK4fx9?=
 =?us-ascii?Q?FVMRy7T9tIPOsYNqHeeQk60OytNT9COPdr8BxtQ3ekvjpMK85CIUw/+g0wfs?=
 =?us-ascii?Q?j3GmrNtXAGV2x7zd4HssNg6V+AS755FeNEATTsizkgQSghaZE3Sxl54tWvOJ?=
 =?us-ascii?Q?WrwHh1TlmW+LABTaSo6GSWTudIETHk1YMa5vjJO1zDkMaEFHjMd2by9VZ9vS?=
 =?us-ascii?Q?21yA1PgObjRqFZZY5EPUPI6T75nZb0GjisZjYf4zsp7ADRgLZ3V9MmSAN0GE?=
 =?us-ascii?Q?MFGMdN4l+3dyf2jKeFWkHRqdEMUDXDej54UkUe+gI/q1zdQAUGQYNBccAjXy?=
 =?us-ascii?Q?Fd6rxhAIGSMPZ8sfF9ITy62vliqz2UH/l5m6kG6f1tQqQvVqd891e+U2pGXV?=
 =?us-ascii?Q?VumQgA9oOyJZYxLfZt1DThSIO31tdw2WylLJKCrdb6dKiOCJG9S7ilCQTihH?=
 =?us-ascii?Q?J3sh/+uOQVwz8KtKbBhvcToWJ9STHVeVZrwjdvtY?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 22851465-98ab-4bec-fa00-08dbb2eb5679
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2023 17:20:04.4710
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gBOiQ2GDF2aCZnHXfH8/T/MIoKQTys3BLRESbbPvA6B1QTAPBOUhsRy0RVY/kCKH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6578
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2023 at 04:57:51PM +0200, Lorenzo Pieralisi wrote:
> On Thu, Sep 07, 2023 at 11:14:59AM -0700, ankita@nvidia.com wrote:
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > Linux allows device drivers to map IO memory on a per-page basis using
> > "write combining" or WC. This is often done using
> > pgprot_writecombing(). The driver knows which pages can support WC
> 
> pgprot_writecombine() ?
> 
> > access and the proper programming model to generate this IO. Generally
> > the use case is to boost performance by using write combining to
> > generate larger PCIe MemWr TLPs.
> 
> First off, this changeset does not affect *only* Linux guests, obviously.

I think everyone understands that. It can be clarified.

> I understand that's the use case you are after but this change is
> targeting all VMs, it must be clear.
> 
> Then WC and mapping to PCI TLPs, either you describe that in details
> (NormalNC vs device-nGnRE and resulting SystemBus<->PCI transactions) or
> you don't describe it at all, as it stands I don't know how to use
> this information.

How about another pargraph:

 KVM prevents all VMs (including Linux) from accessing NORMAL_NC
 mappings, which is how Linux implements pgprot_writecombine(). This
 prevents using this performance optimization within VMs.

I don't think we need to go into details how it works beyond that it
requires NORMAL_NC.

> > Allow VMs to select DEVICE_* or NORMAL_NC on a page by page basis for
> > all IO memory. This puts the VM in charge of the memory attributes,
> > and removes the KVM override to DEVICE_nGnRE.
> > 
> > Ultimately this makes pgprot_writecombing() work correctly in VMs and
> 
> pgprot_writecombine() ?
> 
> > allows drivers like mlx5 to fully operate their HW.
> > 
> > After some discussions with ARM and CPU architects we reached the
> > conclusion there was no need for KVM to prevent the VM from selecting
> > between DEVICE_* and NORMAL_NC for IO memory in VMs. There was a fear
> > that NORMAL_NC could result in uncontained failures, but upon deeper
> > analysis it turns out there are already possible cases for uncontained
> > failures with DEVICE types too. Ultimately the platform must be
> > implemented in a way that ensures that all DEVICE_* and NORMAL_NC
> > accesses have no uncontained failures.
> 
> I would reorder/rephrase this changelog as follows:
> 
> - Describe what the problem is (ie KVM default s2 mappings)

The problem is that pgprot_writecombine() doesn't work in Linux
VMs. That is the first pagraph.

> - Describe how you are solving it

That is the middle paragraph "Allow VMs to select DEVICE_* or
NORMAL_NC on a page by page basis"

> - Add a link to the documentation that states why it is safe to do
>   that and the resulting s1/s2 mappings combination

AFAIK there is no documentation beyond the combining rules. Exactly
what should happen in various error conditions is implementation
defined. Catalin did you ever find anything?

> It must be clear why from a legacy standpoint this is a safe change
> to apply.

This is why:
 
> > Fortunately real platforms do tend to implement this.

It is why it is safe today, because real platforms don't throw
uncontained errors from typical PCI accesses that VFIO allows. I think
the conclusions was it turns out that is just because they don't do
errors at all, not because DEVICE_* prevents it.

> Remove this sentence, it adds no information for someone who
> is chasing bugs or just wants to understand the change itself.

So, if you hit a bug here you might evaluate if there is something
wrong with your platform, ie it is allowing uncontained errors in
unexpected places.

Jason
