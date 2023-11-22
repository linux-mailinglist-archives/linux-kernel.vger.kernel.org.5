Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 869267F5080
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344312AbjKVTXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 14:23:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbjKVTXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 14:23:01 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF35C1;
        Wed, 22 Nov 2023 11:22:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WpkqDqNVFjLLoIoGdeudqbe6F+3xbkm6CsLOJRkoX7pvFJlUhgtKa5Su+2PAH+lLf12ufyL7jdNiXICG5urqkePwHDi36L0uUn35oRq68vHTku8zeQDMqVqvpxuhIbeGc3Dv2pe7JLNHzgOF/99+tVvqY3cmh8J1/JCvMLdTa97YU/qn6FXZ29/EB04nMxw4ShghaLe8kn2cs+ZS0eBXDcl/JOFCVL4aJlzDrsGYuh2C197GyjZUtoCyCG/1ZrwDxOBjpIL49j3lbXAnQ5Y7QGbhtqYj9HKGm7csaro2S6GAbtrrRV5sMbaEeugB6Pb7AW7Vy4qe0G90I3zd3JuWXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJJQOVXO+7jjhb8I4eHUI+figkBgp21XwARtBsqsr+g=;
 b=dHZC2koXBBL399dQBf0j33Rll1n7tMTkjEZXao661yTDHDNUa81t29vJP7ST48X4FbYCa/rIJOMND2++v4BIoDn2jEKGLxsT3Yvs7u3Ut4WY3cIyoFRHyfu+ml8f41IwOhGqQnsoDhF2mUQlkJEBvnXiOvIp57JOJWI6xlvN1XjelhZBWToYjkuw7APmsGB8ZbYNDvuHzxh7w4yo8A5y1GChPuHlZUxaaHHULSrE+t9xub+wBwBxQEUwslZ5zoxYwiTb0iJHt4ZPoiP0kOgHp1vQaLa1jIwZisAjxPEBU1NAdI3+4m/6yKt4iStCCklVWcXhY2k4fhBhRJuDVd5xMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJJQOVXO+7jjhb8I4eHUI+figkBgp21XwARtBsqsr+g=;
 b=OW6xettQICzT08FE9ZfsxVBOP0YCKulFnXdKIbgzjtWsD5IW8ycXqBMjQWMKVxZD7YxTjw+nTt0SpnC03fWKpLEaMJ2V1ActbzoXp5U29UU5nmbzY1NE/vtTMe4HZCI8B+07AkxS6DYaFZJEOVqHBZ+BMU3/Bk4wGWHoDnqqCP0HFmzumCLjV1NhPyGUG8MT6l30eekIAtVEUyXlgGOl9+Cky3VJvX5XqjgQSv7fhqoSPyN/lz6LWuBS3wfpXDPBE3AevfiI0ATJjSuQKE65fdD7Hr5AbAKGul06sI5/o7BWTTuRTv8hHuoJcsDkwMJDg8FOxaK6gS6P+CTP9Ze0RA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB6652.namprd12.prod.outlook.com (2603:10b6:208:38a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 19:22:51 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7002.027; Wed, 22 Nov 2023
 19:22:51 +0000
Date:   Wed, 22 Nov 2023 15:22:49 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        rafael@kernel.org, lenb@kernel.org, lpieralisi@kernel.org,
        andre.draszik@linaro.org, quic_zhenhuah@quicinc.com
Subject: Re: [PATCH] iommu: Avoid more races around device probe
Message-ID: <20231122192249.GA399352@nvidia.com>
References: <16f433658661d7cadfea51e7c65da95826112a2b.1700071477.git.robin.murphy@arm.com>
 <ZVZL9kZuVsb9VPnM@nvidia.com>
 <2023112238-sierra-chewable-86fc@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112238-sierra-chewable-86fc@gregkh>
X-ClientProxiedBy: DS7PR03CA0057.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::32) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB6652:EE_
X-MS-Office365-Filtering-Correlation-Id: 02916b17-a80b-48b1-df09-08dbeb906b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KtsKvXH5kQKYO4BTcZIONJtHMIIGeEekhomv77sdvIQksMyLEp3KKV/bay6gbpmfcBQGDiq2lj/+R0t42Y2i7hn/PaDKUfSMrp6bA/gIg0V3Lfyy5ISn8YU9tqoErwSkwhB0J7fww2V4vd/Lx3BMRaRU9U1P2DvYy/7kE5Pv4tSQwglxU9dL9Ec/SIKqhy7H3xJ0sOAmpztxF5ca8Y5hxVJ0dDcRoi/zBpHIBQzVFGYTBp5WW4L1b/sNKmOOaZCEZBP5pLXYwK3hS9CKW4pT0dxaBLOjJYUSc1Djtsah26WN6yiJIyfv2pZ7rJnEdLbV9l4FIW+Ykgbsq991aE70vpHVUTXsrBrGZQQFM9lguYsoqf10DATNA+82ybEvmF8dUyai4eQqcsiWCUOSz5CHxGcUGymL/IPPFUlBdOWef/XO1R4qH5AVys3ZyOQDbGcn5uvDkxLjWw/AMLZqWkQXyzUzps92m02DcVVdfSq8hfEpO4b+mTko4SgXgl3IksZpZom99XKnty5awAxbdZnUbXtATWNv1TDsfKqeVg4I76wLhJA6TxfPQ45pgO3odCh++du+2Kd/FbXTHPBHB/tYIYWZDVZM8KhRw2Frd+TuMkja0NL2VK1ePvgejf9dT00t3amUhJjrD3TC0Ox/LD2++iqJCo/pWFfr5ALaSRiyLr43Hni3xaZdrwikkv/0yI++
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(39860400002)(396003)(376002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(86362001)(38100700002)(33656002)(36756003)(6916009)(66556008)(316002)(66476007)(66946007)(966005)(2616005)(1076003)(41300700001)(478600001)(6506007)(5660300002)(26005)(6512007)(7416002)(2906002)(8676002)(4326008)(8936002)(6486002)(83380400001)(27376004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EPZD3qzJ7DYFvyfskpBc5dDD0GiPQtd7xpb0bbfO6G7i28np4WODqmdPKwgs?=
 =?us-ascii?Q?nzrjDSxxo+W7Ie4hpKWqLMbuh2z0/vImLZTvY+xZxjDvCpklqvh6qnT16/R0?=
 =?us-ascii?Q?auIX70k9qr3031EGoiqA4X2W3RnLvmNxWjc0vzzpGaMGqm1nquW33ZX/NYIK?=
 =?us-ascii?Q?gYnIXoT9r0F2wtJeimbiFMzUG3RCaFQtKUcVa/LSUNTr53QKHShMkAgBtGy0?=
 =?us-ascii?Q?u5i3KxRB21ujv0lnVcXsaOFFh93ia8+9EP+iL7QyUpVl3Vyq/hadc3ISPd+h?=
 =?us-ascii?Q?YXLPgYrlHAOKY7jSpU3a8uLOX+86Ei9wz/bXkBIF+JBIY82qeJgTzye6isoe?=
 =?us-ascii?Q?ovQZL6UlPOMpUZcZ8BZzmIUJ2olIMHRKPHQmTlDkf/sbatRuO7sJxNHXsfrs?=
 =?us-ascii?Q?eb09hBSw0eWRIla2Bg+qv+AY2wlpvT40g6JHf/T+iUHl+tfaWSzk1jb3D+QE?=
 =?us-ascii?Q?J6WylsCVd3t0hA1x3FXhtkmVCZUMSIjOELE2Hg1dcJL8r1p3GOx0nXOsGVF4?=
 =?us-ascii?Q?ozEHrSn3Wv0pbsZPkgBBKgnIHcN9F+jQ0UEjhfST8Pj+Adxkl+BMR2ihaG0w?=
 =?us-ascii?Q?H+t7NxyhwXsXGug4+Wa6dsVewks4mrgJCkrVsGp83NrEQt+WqZbpaDyZQb41?=
 =?us-ascii?Q?0gJwbPSJ1B54oTpzg19w53E6L37dPMD0BM1/dLDgOK73s6qIvn20/xRIDvds?=
 =?us-ascii?Q?i/9QQ/S4MzCJ8Svw+4dm4YlpjgzLLCFQxzlMLemk/v2WvJq2QmjUpJGHDRDK?=
 =?us-ascii?Q?VXE5mu555ur2j/L+cGf5uFIiEg8iuUtNPJ0W4LapG9/M931hjMQ/BphYPlRu?=
 =?us-ascii?Q?KMxFqx9wXrKYw6hFzYDNOLF93UTL7hoq4vrYMu4F29VtPTTb5KZTFZAILAU/?=
 =?us-ascii?Q?5m65/t3KrIaqaCYQbaImjuYhrBREFFs+HSTwZ1c2wFC1eAhRHi574/fWNv+1?=
 =?us-ascii?Q?BaXo/iwx84lL+z3VVnSAsJyU4YTUpUoQbhBgFka+YUIuG4dlYlVWN7Y5oUkk?=
 =?us-ascii?Q?K4ujryuFpvjaaK2F53UU6VBK2tdzL4tQPClTRKUpJ82PTASyOzzjVtzDLyMx?=
 =?us-ascii?Q?4Ssb2ZSzdulkby1xSwB1cetktFRN8KiPj8oJ0CZIb9YI8fpNYCmF0KPTTwC0?=
 =?us-ascii?Q?aD0DpLws1HXmZ9mkc1bam6s6gIqCa6KXgCWsEmOL96vuCAVKJzY73HMlB39/?=
 =?us-ascii?Q?Y69yG2S1hQSbSwsHSdWVy/Qmq/Wd6WKUHCheyTFwi5hKknV60qFGCSBmbehB?=
 =?us-ascii?Q?b0QSbyHW35M2oW1lYaIkn3aFQslBO0OYovRCAJ6rsqXTaFG18Sp4W4glG3xE?=
 =?us-ascii?Q?hvkb4PNVNmlxfGuA1E5eXAUvQD6dX3UVdt4iKugtQblb/IcIaRESdm6SBXO0?=
 =?us-ascii?Q?LuAKN66JUZRy2A5MS+iye84TNcAW4g+zlnGjJVjC5BXiKTd0bzNt+7ajLFOP?=
 =?us-ascii?Q?U2cMS9+tmq9GlTgDr4ZjZ43ge7jEVSVrcjq3EK87xcrxCN8jHfr9D4d7J3jU?=
 =?us-ascii?Q?7XyR8TFNcVDOwd0pSRKcVjLezIxXyUqS1fcfLn2DuQdDjmYTJdqQPTN7jCVp?=
 =?us-ascii?Q?m8TY8w7oj3tdhGRycn4iGaZwNLWNh6TjByVJP0J8?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02916b17-a80b-48b1-df09-08dbeb906b47
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 19:22:51.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZEcaEc6bvk0w+WJcWzPB6yOH190+KpJwxfzUfNnsEJzUsw7NSdhn8RezrUh4yJ9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6652
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 02:44:53PM +0000, Greg KH wrote:
> On Thu, Nov 16, 2023 at 01:05:58PM -0400, Jason Gunthorpe wrote:
> > On Wed, Nov 15, 2023 at 06:25:44PM +0000, Robin Murphy wrote:
> > > It turns out there are more subtle races beyond just the main part of
> > > __iommu_probe_device() itself running in parallel - the dev_iommu_free()
> > > on the way out of an unsuccessful probe can still manage to trip up
> > > concurrent accesses to a device's fwspec. Thus, extend the scope of
> > > iommu_probe_device_lock() to also serialise fwspec creation and initial
> > > retrieval.
> > > 
> > > Reported-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>
> > > Link: https://lore.kernel.org/linux-iommu/e2e20e1c-6450-4ac5-9804-b0000acdf7de@quicinc.com/
> > > Fixes: 01657bc14a39 ("iommu: Avoid races around device probe")
> > > Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> > > ---
> > > 
> > > This is my idea of a viable fix, since it does not need a 700-line
> > > diffstat to make the code do what it was already *trying* to do anyway.
> > > This stuff should fundamentally not be hanging off driver probe in the
> > > first place, so I'd rather get on with removing the underlying
> > > brokenness than waste time and effort polishing it any further.
> > 
> > I'm fine with this as some hacky backport, but I don't want to see
> > this cross-layer leakage left in the next merge window.
> > 
> > ie we should still do my other series on top of and reverting this.
> > 
> > I've poked at moving parts of it under probe and I think we can do
> > substantial amounts in about two more series and a tidy a bunch of
> > other stuff too.
> 
> I agree, it's messy and acpi should not need this, BUT at the moment, I
> can't see any other way to resolve this simply.
> 
> So here's a begrudged ack:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> and hopefully the larger series should resolve this correctly?  Can that
> be rebased on top of this?

Yeah, I'm working on something more along the lines of Robin's desire
for a full reorganization.

The existing series has been tested by a few people now. We can decide
which order to put things in maybe next week if I get the new approach
done..

> Also, cc: stable on this for whomever applies it?

Also please update the commit message, the text from here does
describe the race:

https://lore.kernel.org/linux-iommu/11-v2-36a0088ecaa7+22c6e-iommu_fwspec_jgg@nvidia.com/

Jason
