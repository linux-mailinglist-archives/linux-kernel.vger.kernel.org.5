Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D14BF7FC162
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbjK1RwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 12:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbjK1RwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 12:52:22 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2232.outbound.protection.outlook.com [52.100.156.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0717F1BE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 09:52:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HkOo70mQtck5/pc7bkaKkyu08z7gNocteTefwR2ymCtdEQP8jfDA6XLUB6eNeBtGC2E3i2UHMfSvU3idzijYl/Cs3f2hSQySeBOZ2kLIGcQyXQbF/whSNryc5Zy1LMukoo6zei6AEk5TXOr+4seB5PVk3PBhUnM9+7gZhC9t1swMxCm3S9ZZejl5mtZehzwH/qMemFm498r7C2go7rZvLOQzmz9xfyPfZFy/B5D7gfytZJTbZ5zq0rvvr4s0cbZbbSYkmUO0LKF1RaOJ7Na3Qg7FM8QR2XKzOpmY4ZjaXXi+WbEsVpu+2zVWHLugXfzLbZNvT54DJ97QRhnReA9FEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yOn2B84+PYWoMYlTmAqEpojDnKX+ATO5lHPhvUcD3Qo=;
 b=jGKV3iUFvLI01cJty08O6yTsotMOdV4uJ178AQNoHERkBFjce/rtei3Nv/bfg0cxYu7x6MBNTfTQ08PGBkXgwL5aCzVYoHx852vsyLRznuh/mKy0VkIQ5DJzLPTAxFlsxGux7Jo+q8AS3T1/qXKOPZa7Ud78HsiW4MoxDsxJGRi2zmfsP7S1L0UaJ09GU7tU5kaG4W8P9U+WrlGL2mxJyb/Yxmgtey1fpbSnfSyNlg9kzdiAJe1lXxjVWKDXbF+AEVD4hW6okXgujJKOgBAr72Kit+VUOJLuAX6KX+BU0RWlSK+Qqsvx/Tq/TValn8E0hHyXT+g9puMmh4olzoOgNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yOn2B84+PYWoMYlTmAqEpojDnKX+ATO5lHPhvUcD3Qo=;
 b=KIjB6tdmuZZrds7x/BbQPx3L9UZiWFmIhi8eO0ODXiz4ZX/O26AJ4CBKawMbkyecyuY7BPzIpp2INnZL16JVAUtCLVktgBb5FxGLF+WjoZtdBnDrVnish/gHYjRPVK5ABH3WVKiqGKIUQUpFonGVnmFii1q6fcz6s6TrmIHLSFUQij2fwNnxI21DcJqhQHpKCwUBKLp5BF5VSWWP156n99ApBWVsMmgJk76p7b7ooxVzyOSR0Hi6AjBDtMD3XjQFlzIlsR5fXoKt3s10ToKmqwlRy+jvoKb79LXVCwD1PqAmtx+l+1ZNMT9JlAp1tmTs5iK/8y9IyEJMgc/PoygcdA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by CH0PR12MB5372.namprd12.prod.outlook.com (2603:10b6:610:d7::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.27; Tue, 28 Nov
 2023 17:52:26 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 17:52:26 +0000
Date:   Tue, 28 Nov 2023 13:52:24 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     David Ahern <dsahern@kernel.org>,
        Saeed Mahameed <saeed@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        linux-kernel@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231128175224.GR436702@nvidia.com>
References: <20231127144017.GK436702@nvidia.com>
 <2023112752-pastel-unholy-c63d@gregkh>
 <20231127161732.GL436702@nvidia.com>
 <2023112707-feline-unselect-692f@gregkh>
 <ZWTtTjgBrNxpd9IO@x130>
 <20231127160719.4a8b2ad1@kernel.org>
 <20231128044628.GA8901@u2004-local>
 <20231128065321.53d4d5bb@kernel.org>
 <20231128162413.GP436702@nvidia.com>
 <20231128084421.6321b9b2@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231128084421.6321b9b2@kernel.org>
X-ClientProxiedBy: DS7PR03CA0177.namprd03.prod.outlook.com
 (2603:10b6:5:3b2::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|CH0PR12MB5372:EE_
X-MS-Office365-Filtering-Correlation-Id: 62219588-d2cf-4f0b-44f3-08dbf03ac81e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?e22OH89CkAKGc4e7+nl5YR/s25Q+jSj+VTPG8vhdk0WN+nbEZTVj52AqITDx?=
 =?us-ascii?Q?63AWFXP9xKXOcqcrCJkipikOllq2POJl4bhH66JKGiEzQh1DUWekCzjF2gq1?=
 =?us-ascii?Q?U+IxwQpXwwyLKf3DGLI4gPeAHooqWWgfc+gQDcydg9JBgKmGbQHCY/YEilJa?=
 =?us-ascii?Q?GclRduXcdVngS4d1FddBqKukhOVmFg4LwYypzZ+QnIbSdSJrgmRRVnJ/fI/j?=
 =?us-ascii?Q?e4m9iA5eDTCIaIwCl66H9IGwieyoha/4d75gvny3AOO2w6cUn8xK4zi03LNf?=
 =?us-ascii?Q?IpMJFM4vdW5ocP0zc2jpKDY5SDVc8GYrf2pJRC1cyGFMlNEZ4YEhMhBLZ1bd?=
 =?us-ascii?Q?W0LhgIyp6KAW2qHno0rGMN2hWDhi7uVf7cc0zd1co6lQrRoNbwyOgcCzXyKN?=
 =?us-ascii?Q?uwFHOkIavukuN7r0EQpzBgWEW0XRCfNI66Szbwhp9rPxoVcXy8iu36HgN2Bg?=
 =?us-ascii?Q?AeizAvmavgcOptz36ygIwnAa/xvRQm1cX2AXS5+ImAFg3Wp+WmKo38r318Ma?=
 =?us-ascii?Q?h4XnduyYrWrmjjHAY2Z/7FIVjQgzDJ13bpLsL+32+7H8jxEGKY77YB0+Z4we?=
 =?us-ascii?Q?e24TtI3eqQFnRlHgh2t8xAtCDoY1XFTPA7SB2tA30wPKDz/6GWh0JW8/FIIV?=
 =?us-ascii?Q?r74UwjwsYe4eGWLzjTpm5UtC2MDZAfUtle5SJ6UIzYlyV8c1HJymyrKzB1U5?=
 =?us-ascii?Q?WWI64lLJtLayt7faE/9+u9yhd/vWAz5PdA1zD51ZEtVohpyYVcCVColIULHP?=
 =?us-ascii?Q?3SJ5Yw1BqkVS/PkTRZljKHMZ/F3eNVmDXCYJoUctwfa6zdrzkVR2Fnuq5YAI?=
 =?us-ascii?Q?FQlde6X7Djl34y5VG1sSzazDO6+vqO9OCyepPM9YiiXEBw8yEPoOyN3I5cO6?=
 =?us-ascii?Q?AsMYIha/TwdMm4NCx8Sa9Nsj68umuc3JUO1qe18oemCtTE/uH4JUhzKbedXE?=
 =?us-ascii?Q?W3pgWLNNKppPfCBuD6dk5qOBaq/swVk1VgO9s1qPId4fsONO5NF0h4shpSx3?=
 =?us-ascii?Q?cIuM4pZvrC5RWuduinEu1dcfu/JIczJOhEYmmy5GcA8uTGdOCf7FXB5hy4ee?=
 =?us-ascii?Q?QN9cads8?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(39860400002)(346002)(136003)(376002)(366004)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(38100700002)(33656002)(36756003)(86362001)(41300700001)(6512007)(6486002)(966005)(478600001)(6506007)(4326008)(8936002)(5660300002)(8676002)(6916009)(54906003)(316002)(66946007)(66556008)(66476007)(2906002)(26005)(2616005)(107886003)(1076003)(83380400001)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jpXboJc9tY6cqpCmM/yxyi+F0l+DXg9Ti3HEAw4/HM0wSM1oJehcRw9jaGob?=
 =?us-ascii?Q?ZJOjH7fqgDW3JGiC217v1rMQODX2kv6jifYJFs65BevRyaanG+WHYCSkeboE?=
 =?us-ascii?Q?MejtS4iUOCva9tRYMq/w7eQ3EAT617Bsh63Uz45scB8V3bWbOrhgluUeVP8G?=
 =?us-ascii?Q?gDKtujS2GDjy5egky5gXcnDH2yTuqTCe2QjRf2jIAS2Zl/15kpU1MMMiXqkX?=
 =?us-ascii?Q?cyGO6wj9J3D/hEEpTmL3ha++0HbGix1ngkodHb5DjwXSO7H3kx0VmKlH6pMd?=
 =?us-ascii?Q?mbtp0ID1qGLPkPeiPiqJJDT/Z1d+2dkEeu6p537gQuWMmciuW1wOo3yoN5XH?=
 =?us-ascii?Q?+yURbpdVsHkQoNZlC+4W4H22CqPNrfCXXL/0ku9JLMkc0Ak6a/gibsup0wU2?=
 =?us-ascii?Q?Zgr3fiDOHQF1dy2ChsLfaLQP1gynpmFsqEYPUTEDLUe+DvLwnJ+JTgBBrXLE?=
 =?us-ascii?Q?nZI1ESC59A6vEaUFe4bb0tN9zrPWej8j6JMadEqvKDejRfNCC1bLl77BEVP9?=
 =?us-ascii?Q?PAHZMXHoic8aXQdkUe8Slx7Hu/a/vYP1iYnemadFkDOK+xl2RQs0iBNG7i/o?=
 =?us-ascii?Q?wytj38C39FO3UMydjWW8sVLbIUFFlxbKiZpObZUQfCrOAoNH2/cArhSlolfA?=
 =?us-ascii?Q?9BF+tvywY0GgUxAK6NDnobpwQwJSgg2DH/wxt9P0gkDqzjU1Sjajv02pmtUB?=
 =?us-ascii?Q?MHIVXPkZLR/h0xQNy3LlWtdCh57/hjc2E7YodznDLb5h7DTJAgbjXIV0W4Lc?=
 =?us-ascii?Q?oFu9vn+2/7ntMFSW0pkF0+Y93rmeRONhLoK629XsWpS2rypSMaBTQ9SR0Smf?=
 =?us-ascii?Q?hNkw2tL9CD/y3hmvyojoOcd5TKvEWbRolqNgqIxvQ8WVgGDMl/D9GdvHTkTp?=
 =?us-ascii?Q?pcHAhvIVh4oUc0JGmojyowhGZqjERPAizbIrW/CdyrNzBU1KP+Wmpy76o1jx?=
 =?us-ascii?Q?C8XAlBF3mTz2FEHYCXqYKZe9GAY7ZO3enTXVYBuH5cvbJmC8LfTCwZGRk+68?=
 =?us-ascii?Q?6YCHym0ZHIOHBf4aNkg+oBQbIgVn9AmuQdmQz93ZEOA6byRd4uqen97thWF6?=
 =?us-ascii?Q?NccW0XKhuiXtDikEQvqTXX0CgzSePKhKWod7roPC0X/yRQy5E2DSR2kJb1v5?=
 =?us-ascii?Q?sG3rkBAH5g6dk3RH3PM3rrV9v20t6QEz3Wed1zmw5qqkFMB95ZpoFdUSCbD2?=
 =?us-ascii?Q?KESFON6PM0aErIn1t5YzWS7tabKANk1UQ0P/pI+XXrImOcYvXCqzKHMzVfhC?=
 =?us-ascii?Q?IB7g1S/UitjofN5xIs6kO9TX++L8SqjukG2t2BazQE4BPwxeLz/RXB+K1bEo?=
 =?us-ascii?Q?Ws8kmI/x7aXUFSovy4qEDlei0lFmtengDB0bL2IdQUSWfyfiYSIa8lr/HAqg?=
 =?us-ascii?Q?XH6eY3lCzXsemZWmpJTNFZTtXMJbjHVOlmxtDr+G2eFZDOsyolPuKwMTFvNS?=
 =?us-ascii?Q?NvsPhP+LrmbZrB/zZ0VvcH6KkZmKLn89cJw5N2/wHbQzA9SKylVSCO94OKrQ?=
 =?us-ascii?Q?ySbHnBueEI/+gIJMG8P6GhmohMu9+6Ry17zowsLP/TE7LNVeEd/yBFiFGmkv?=
 =?us-ascii?Q?C23oZcCYL7Vz9Les4fijx0jHE1LAS+FYou1B+yPH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 62219588-d2cf-4f0b-44f3-08dbf03ac81e
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 17:52:26.0293
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6wFBPEgquZ0OQ4yyUlJfs6kllUgxtFrX3Wx4cMJcz632aNI2/u9eeO3LUsQl1FpU
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB5372
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 28, 2023 at 08:44:21AM -0800, Jakub Kicinski wrote:
> On Tue, 28 Nov 2023 12:24:13 -0400 Jason Gunthorpe wrote:
> > You said you already rejected it at the very start of this discussion
> > and linked to the video recording of the rejection discussion:
> > 
> > https://lore.kernel.org/all/20231019165055.GT3952@nvidia.com/
> > 
> > This session was specifically on the 600 FW configuration parameters
> > that mlx5 has. This is something that is done today on non-secure boot
> > systems with direct PCI access on sysfs and would be absorbed into
> > this driver on secure-boot systems. Ie nothing really changes from the
> > broader ecosystem perspective.
> 
> The question at LPC was about making devlink params completely
> transparent to the kernel. Basically added directly from FW.
> That what I was not happy about.

It is creating a back-porting nightmare for all the enterprise
distributions.

> You can add as many params at the driver level as you want.
> In fact I asked Saeed repeatedly to start posting all those
> params instead of complaining.

That really isn't what you said in the video.

Regardless, configurables are only one part of what mlx5ctl addresses,
we still have all the debugability problems, which are arguably more
important.

> > I second Dave's question - if you do not like mlx5ctl, then what is
> > your vision to solve all these user problems?
>
> Let the users complain about the user problems. Also something
> I repeatedly told Saeed. His response was something along the lines
> of users are secret, they can't post on the list, blah, blah.

You mean like the S390 team at IBM did in the video?

This is not a reasonable position. One of the jobs of the vendors is
to aggregate the user requests. Even the giant hyperscale customers
that do have the capacity to come on this list prefer to delegate
these things to us.

If you want to get a direct user forum the kernel mailing list is not
an appropriate place to do it.

> You know one user who is participating in this thread?
> *ME*
> While the lot of you work for vendors.

I'm sick of this vendor bashing. You work for *one* user. You know who
talks to *every* user out there? *ME*.

User and vendors need debugging of this complex HW. I don't need to
bring a parade of a dozen users to this thread to re-enforce that
obvious truth. Indeed when debugging is required the vendor usually
has to do it, so we are the user in this discussion.

You didn't answer the question, what is your alternative debug-ability
vision here?

Jason
