Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C2678F443
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347454AbjHaUsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:48:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347445AbjHaUsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:48:17 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2129.outbound.protection.outlook.com [40.107.92.129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623CD10C2;
        Thu, 31 Aug 2023 13:48:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RwQLJb/VPiG71RcHmYPhi6Ah/ST2zBULxl2t3ModHW2z1WRkzYKQzN43ngDbmBL7c7B41eccLgHQibZE0jFbNd6wO3u4I9y/MgXwo7Qm82cT0FNlG1xf4YmE1wdsQOeLCJmP6huh/l/S24dv91T+ULIikbFkb6IwjTXwmvYn+19jGKlvI/6nzlMvrB4ZA8xnvJxX4BOtjAPODKNFBTAUyCtRTf0tCXfkGUDk3wBwI6kGHfIS6iBKLdvGhN7XL5DvgME0ndx12dDyAPgV9YXxL1Y4ujE2AOObqGc5Y9JIjMp+rFIzbUxpCSg4UJu1VW97pcwMeZDy/ejvWM4h6dFCFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kczohxve/CA2iyM4ezs+DYf+LoHquHUocOiOsP1+BT8=;
 b=DZmlEptaIX/pkZXzlAIo2iZ4Leu2CsEMA31GEOaf+CfPF0ALx043EjZ5mOtZwxKA1Ir00oFW9ztGK1CV2j0rJj+McrzZGtq83XHc+HhuPJzCF5D8/50J1rsoHv6o4QgZD4peP658Yd2tnPtfi+JKYC4t9NR7kqZLr5quHasFgJq+GBFbifT5c8Pph1wyLk63bbanh0NFe05YX/XM8p4p46wV+LmJY4jABz+oTgW6pS8xrh0PDaIOc5WVDoz2DnfrP5DjfioL5p0T2yaSHTn2gBCpstV6Y+gFU+z/Hu28rDOZk10jq7bNGQiEpqFrcmo2EiDsB+bpqy3DNI8osfOrvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kczohxve/CA2iyM4ezs+DYf+LoHquHUocOiOsP1+BT8=;
 b=iEnXuAhB8BHA6GBfO7TjFU8mCBKS57ZoXgoJUX6dmdHqDcDm0XSy/4uopOyhUwYeI/NXehbQtcbUxfbF1pJIRXROEwHs1gi/VnlBpquoK5bQSVLrhlVVHnwPt/3E1a9ShMuUk9ke3Inn54VKKViHL/5V9C1aeIHav2WbY/1EjPI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from BL0PR01MB5026.prod.exchangelabs.com (2603:10b6:208:6b::11) by
 SA1PR01MB7328.prod.exchangelabs.com (2603:10b6:806:1f7::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.18; Thu, 31 Aug 2023 20:48:06 +0000
Received: from BL0PR01MB5026.prod.exchangelabs.com
 ([fe80::7cb6:610c:ffbf:2404]) by BL0PR01MB5026.prod.exchangelabs.com
 ([fe80::7cb6:610c:ffbf:2404%4]) with mapi id 15.20.6745.022; Thu, 31 Aug 2023
 20:48:06 +0000
Date:   Thu, 31 Aug 2023 13:48:02 -0700
From:   Zaid Alali <zaidal@os.amperecomputing.com>
To:     "Luck, Tony" <tony.luck@intel.com>
Cc:     Piyush Malgujar <pmalgujar@marvell.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "xueshuai@linux.alibaba.com" <xueshuai@linux.alibaba.com>,
        "benjamin.cheatham@amd.com" <benjamin.cheatham@amd.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "james.morse@arm.com" <james.morse@arm.com>,
        "lenb@kernel.org" <lenb@kernel.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "jannadurai@marvell.com" <jannadurai@marvell.com>,
        "cchavva@marvell.com" <cchavva@marvell.com>
Subject: Re: [PATCH v2] ACPI: APEI: EINJ: EINJV2 support added
Message-ID: <ZPD8ggCD794f54VR@zaid-VirtualBox>
References: <20230504133224.2669-1-pmalgujar@marvell.com>
 <SJ1PR11MB6083A266C4A869FC9AAA5A9AFC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SJ1PR11MB608326A6AC3FFE42699DDB40FC6D9@SJ1PR11MB6083.namprd11.prod.outlook.com>
X-ClientProxiedBy: CH0PR03CA0305.namprd03.prod.outlook.com
 (2603:10b6:610:118::7) To BL0PR01MB5026.prod.exchangelabs.com
 (2603:10b6:208:6b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR01MB5026:EE_|SA1PR01MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b58b2d1-6d8e-48be-f9b4-08dbaa6393af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LUu+ZHn/JupwcLEhwO+Q2AXC+Lbe4/bRh2GY2ChJL9ALJAqPuLtyANOuVb+bvXOzSglUQP6EoIIY5CDUKrffpIxNiW6MC6p0E5wPsus+cWcmCUGhmU9lswLWVmD+XHYWVxRW14nIjoovzq2RX89i44j1l4KS2zQ/a7qd83Q5djHCc0HkKpC5hrsZtvGbGI3wUyuuVE6VVXNAgEJb1OKHV1pPVGcpm4+/9vwjWZfRyXdvxqEu9tlEC4JtjMk0RUPxVX4W4Cg0GNa/Ml/ml8pFwTEd6c78KjOXRaPFiUS5iVZHU8bTnN7rCnsxlEKFHMNEkfzZxQ62HjhnsAxDtdZ4AQw8AJhrDZgnMFee3BIJCo4QWYZzOVuKdI7kRwyv7U2fqd4HFwCR/IrQGfb2o/i3HLMmqy43Y30enl81g88gRljbdnms5tt3n/wpVvRvs5mubOKXwiNd0kAF/II4nEjJ3Av1unI5Jx/jzhfC9KbhSVEaJi2CuU6Bsna3p0/IU0l3MtQ5STz9huo/yAcay/jetpz0+cfIQ/dkLIPZDkj79kFW8o0C3HQtWMZoovqOjnKfyDtEmPRiRYCIEA2Wn51JxGWqN62fO9tqIP93Z6Q85dI4Xm96aZg/91G/zxSb6ciP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR01MB5026.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(39850400004)(346002)(136003)(366004)(186009)(1800799009)(451199024)(8936002)(6666004)(52116002)(478600001)(66946007)(66556008)(6506007)(6486002)(66476007)(54906003)(316002)(38100700002)(41300700001)(38350700002)(9686003)(6512007)(26005)(5660300002)(33716001)(2906002)(86362001)(8676002)(6916009)(4326008)(7416002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nTJ1y+t1VmJSo4N7moXaYeo/zrKKLZnTd7o4NSutVSinn9fV+Pa4r3OimZnq?=
 =?us-ascii?Q?3agtbK04x9PN0Gsh44cMsJCrsekQjrcf1h2JhO4MUZdJeeIwoWZMOEdltuCL?=
 =?us-ascii?Q?p5FayQJ8ahmUCL0vNS43J9m/XluOb4wgM4UH28X0Wrrvlu3tnKBDL2AyCGt2?=
 =?us-ascii?Q?mspSy0+baUlgfik84MSaEqaf9u6vWcAkYMdKl1HmMOUUjULawE1xg7sSudgA?=
 =?us-ascii?Q?pA/x/69vy1PsKejfB2p0dv0JNVPel1NZCJVIl0+APM6I4bEgAJ2TG5Em6lhi?=
 =?us-ascii?Q?is3o2ed+xOwI7hXmrmjX5xFFSywSUnCb3BQEQrIOsmObKJhhBqarH23fZ5Km?=
 =?us-ascii?Q?3LsyMsMcZPqIH96XtvY8Kik6htrtD0YuAb9UxtuWMUnU4hEG/8s/01cKTbIh?=
 =?us-ascii?Q?FeFZ6ssbAQv21BwdUzcCbHvO/z8gmRu3EDM6g7evQhXlMGzAGK/zbfFdNuj/?=
 =?us-ascii?Q?50ACyUmzUdzmevAYDxlltZRAIGubgHMJpVD5/kmoUHWM/hbUxhbiU/RwO6Fn?=
 =?us-ascii?Q?vXYOIuHhMaQz90dmmQsRb3ovJuALNqeaAC6YX7K9NvX5Ms3Coy0gE1fPrA4w?=
 =?us-ascii?Q?WWrshnxsjPqUZenePpxpbdeimNcwIqNcbP1WLg6HLYeszkXZouN1BeiI3u9m?=
 =?us-ascii?Q?TYUjJneBBPUmuH33Ecd23bDV2eg6GlQO1jAmDv5YbusvkbX2FDxjlrQmXrdE?=
 =?us-ascii?Q?4k2Y4JPD3I30m56c5CDbzgLkv519Dqyt7W1ckuiLiTOjrf/tkA8rqJiv0dH4?=
 =?us-ascii?Q?7uIlmXDAcyl6lf1Vlz9WScyT9ddJjesuwB8qZN7HnXVsdRlLFL7QdYngfwMp?=
 =?us-ascii?Q?qFszqkFQ8eLcrJVEyxT7S43Q2LQ59mGUhQHFx8j4n8LlGV1+ROnrpKgdq0SR?=
 =?us-ascii?Q?ltbtIawWOfOtySzj9x3xwavYoLhB6Tsx8zbQ08r+O+xDuZWw+0jUFAYiAU6/?=
 =?us-ascii?Q?osyNvhcKD74RbMiFBI+U5Nr1KN3jNpWHqHAP2luqltIzJ69NR4pqn/CdfyAJ?=
 =?us-ascii?Q?znmdc7EGa8SbJYDLDKAEZh7WLRh5IQkuIe0kys5qTNPp1A0JlgwExfw7VtnG?=
 =?us-ascii?Q?tHP7gFgR9qLejTib5kqzM2aeVFqQ9eHdvD5IXZ1zJawIFcLE2ZsZjBGqxBew?=
 =?us-ascii?Q?bFdRiCaB0VqS/R444DVYbTm6hrFo/8un/X5XqVVkaiGWFFVz6qPKDGxkI9hH?=
 =?us-ascii?Q?3srSAxBalglqSK4uBMwWZOZZTjUL0S9P9P+vRhA5KSnvIbWPvt5suZGa3LYm?=
 =?us-ascii?Q?WDxy3wyleldgoYEbasCHoX7VGtAHPQD5ONRHs+FqZ7vzMucGsF3DFyYDF9k0?=
 =?us-ascii?Q?RwEWfog0mQ5Fgef0XBjIwlCSGcjBuZx0x/I/wAo7pG7667Lq+RkrXDKjX1Mu?=
 =?us-ascii?Q?oyMI3rhCqv6kc7nhkeHbk5BRHEpiOzs+OmlNxVaWfL+SKH+7q4/OXI2Wvq2b?=
 =?us-ascii?Q?h4ilsvfQh7p8o1QCMtvwoBLtpC3KpKvfpg3opRaJAmlHHmSZ1FV2Hg4JpdOr?=
 =?us-ascii?Q?KY0J+EME2eXRupxaAjxdqp8635RWd/VJo8pk1nDmKXnqelHEc/D3h/8x88J+?=
 =?us-ascii?Q?qGW91+GlVeZP4EBN083kZRNRZnxlIzfBUF6RNFpAEvxN2Lkfa3uB2xe4obnT?=
 =?us-ascii?Q?7lxR39mPY4HaCAetUiCbqcc=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b58b2d1-6d8e-48be-f9b4-08dbaa6393af
X-MS-Exchange-CrossTenant-AuthSource: BL0PR01MB5026.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Aug 2023 20:48:06.3065
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ9iMJY3gB0npcqjqQEgqi/dIy0pHCDKb4oftsQ++vZZhbWk2vzzlBV9HBU/uHyNu+H8Rqj+PbuPZmt1f51cNG0pI35ENfrlRqufhsW5CfLG5ROt1mi+Q8FVDNJv4+TN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR01MB7328
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 04, 2023 at 09:00:51PM +0000, Luck, Tony wrote:
> > +An error injection example::
> > +
> > +  # cd /sys/kernel/debug/apei/einj
> > +  # cat available_error_type         # See which errors can be injected
> > +  0x00000001 EINJV2 Processor Error
> > +  0x00000002 EINJV2 Memory Error
> > +  0x00000004 EINJV2 PCI Express Error
> > +  # echo 0x2 > error_type
> > +  # echo 0x5 > flags
> > +  # echo 0x12345000 > param1
> > +  # echo 0x2 > param5
> > +  # echo 1 > error_inject
> >
> > Is the expectation that platforms that implement EINJV2 will not include legacy
> > EINJ support?
> 
> I spoke to some BIOS folks here. They said that the ACPI 6.5 change is an
> extension to the action table with new opcodes for GET/SET when EINJV2
> is supported. The legacy actions are not deprecated. So platform firmware could
> support both old and new injection formats.
> 
> So I'm going to double down on this:
> 
> > Maybe it would be better to change the top-level directory to:
> >
> >	/sys/kernel/debug/apei/einjv2
I also think this is the best way to go to have EINJ and EINJv2 supported.
Is anyone working on implementing this? or should I give it a shot and try to
send a patch that separates the parent directory for EINJv2?
> 
> and say this isn't a "maybe". The EINJV2 interface files should go
> in a new directory. The old files should continue to work (assuming
> firmware still enumerates the old available types).
> 
> Simplifying the interface for EINJV2 in the new directory is an option.
> I think we should take it ... the "paramN" files that mean different
> things for different injection types were an evolution rather than a design.
> 
> -Tony
> 
> 
> 
> 
