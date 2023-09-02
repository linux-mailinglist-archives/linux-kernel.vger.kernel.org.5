Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46283790826
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 15:55:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbjIBNzP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 09:55:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjIBNzN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 09:55:13 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2059.outbound.protection.outlook.com [40.107.244.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0125F4;
        Sat,  2 Sep 2023 06:55:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RpfEC0Zg0wCKCMxo8HOsiC1M5ZVrhBvQm5N2FB+ImvkufoT/aAw2UhetcJiGwxI2XoGePiK3TVw+EtkubcbzjTebETOhfOigNihYos7qFS8StUe00+Zx4DL0Mcut/2/Us0MnO9Mlt+BUlafh2ZX4zWCgBC/VVcF91qId3JIh5svT7+HaBDWQMsnkLg7mX6yhGLtL6ye0MtBI4osSYb9eTWYefTDI/ZBmG3Yh/D4kWh6LDm78Eo1uK2Y0OVjY3OpaAqxZHI4DHVbciXzaUbxJLnSRfLVTiZt8ZlhGI75RoTf3ue1/73nnqrX29jFZSG8CrVD4UCjb2SHZ2ZCarY3k5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C55BoP7PqGqrjo8BGDORfM10msiQ93Xd52S+IEmJf3c=;
 b=nqe6G41pKK7KpDirMOkpyNE+0zLnbsKvKyLS8ihK8X/UT6/Kasmu96+ozlB5MPmrhVtzjTkDH9usP7m/rcioSO9s9HdpFLUbHe5+rpLZWHsLrDtImQFz7XR6j1eKH2kPVQNGyyzvpi62zrTT91BXoQm0DOzc/Mb4BRvfER4gcb8WWloyT4gKBZc9EWSLGIwFRixQu/E4YrXS9tcgf3R1vMoBAqjnsf4FlCes0/K15UMutKd0U7NsHXoGBC7Dp8t2BGci2jpU9GGrb2+3tdL88T8SbXVS6NIXed9h24vHfb4OXvBHj2m65Rv2JlyH8meWM+DeEq4z/SSXdG8KOcbbRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C55BoP7PqGqrjo8BGDORfM10msiQ93Xd52S+IEmJf3c=;
 b=OrDSMGr4QeJbWCKyHuz5dzm0/18Q6PV6UePd93cglk3cvC+sPJJ2QQu44hPOaFmlN8leiBl7wVbQ4u5h1dIMJzv3Xe0D3IuQKMmlBqSxYnxfiz1FF3G8q137OdYp60sL+MYfcZ8U0gWOPc0JxeoUGG0UePe1JkU4eQsJm9cw3HQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB3657.namprd12.prod.outlook.com (2603:10b6:5:149::18)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6745.27; Sat, 2 Sep 2023 13:55:05 +0000
Received: from DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8]) by DM6PR12MB3657.namprd12.prod.outlook.com
 ([fe80::1dc1:222:24b8:16b8%4]) with mapi id 15.20.6745.028; Sat, 2 Sep 2023
 13:55:05 +0000
Date:   Sat, 2 Sep 2023 15:54:58 +0200
From:   Robert Richter <rrichter@amd.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Terry Bowman <terry.bowman@amd.com>, alison.schofield@intel.com,
        vishal.l.verma@intel.com, ira.weiny@intel.com, bwidawsk@kernel.org,
        dan.j.williams@intel.com, dave.jiang@intel.com,
        linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
        bhelgaas@google.com
Subject: Re: [PATCH v10 02/15] cxl/regs: Prepare for multiple users of
 register mappings
Message-ID: <ZPM+sp4LJy2EjByW@rric.localdomain>
References: <20230831152031.184295-1-terry.bowman@amd.com>
 <20230831152031.184295-3-terry.bowman@amd.com>
 <20230901101527.000031ba@Huawei.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901101527.000031ba@Huawei.com>
X-ClientProxiedBy: FR2P281CA0056.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::7) To DM6PR12MB3657.namprd12.prod.outlook.com
 (2603:10b6:5:149::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3657:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e4acc76-7134-46b0-4bd3-08dbabbc35d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dp3J+cmdNr/2vu8LDmr5Zo/L95TTzf5J3PwuPIGZTvQW37lVKR+uaqjfPhBIV2UNVxvWOS+6A0LEkrruIBrD5EiI3wUsNOt3coGQRkhfvEqkJiTrKH0n23TUbiZZB1w5fV8F1K+oUB+D0ynWY4Z5TA07h4Qd9SC7R1V8yIaL2ENzX+kJRh4rKRfUDMmbfO9T/VSo7XXzN3jz2bHZaN23z/1OKFbIL4vhU4NA0AOe7y4j+qHJ4yNuBG/HOKTmZbFr2QZgxZ6VcNdqW8EjpVI6fvsryUkr9EkNjj3/ov34qDFQrVgpsNSxpo12hRDFZpg85NMgAECZMi3EYu2zx51kcKkK9sFRlR/Cb9SL/RguvJSfLCcJwxvLC9tptaGocaOeDdPOfC8mXRXl7RF+Px2nm+As/xRBS6Cj750oM5qPMpC+lPolsgNXuSwiBMc4W4qZ4KAlRqK8ctn1ieSlSMsfUXfFM6uKd7q4pq6052XNNGdehyYs9aq5Yim1vW8fVdYcqGkKbF3vqHi2loiDAQIrbZamg+ZijF/iA2n5TP/vgyFOp5uxnkGjdG4XFU6qG0H5RW3qdYPEvSQjzuEF8xC+xJDzfnPGukAZ+TwvmlM2+4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3657.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(136003)(346002)(451199024)(1800799009)(186009)(6506007)(6486002)(9686003)(6512007)(6666004)(53546011)(83380400001)(478600001)(2906002)(26005)(6916009)(7416002)(41300700001)(66556008)(316002)(66476007)(66946007)(4326008)(8676002)(8936002)(5660300002)(38100700002)(67856001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vfev4DL2UkwhyJupXr6ArlmCpIT9PLne8WznqY1YWt8SSQrkdHpiDPNH24Q6?=
 =?us-ascii?Q?ad1h1RCDT9gp837lElpJvovt9ZCaciRuCPjfdOELcNkGPTsxoDIBQG+am225?=
 =?us-ascii?Q?gVbo1bqCW0hxwqtCaM6nQ++4XQhaQv9U3tPOjlnE6cXh4nSg/SCKl7ezUCXz?=
 =?us-ascii?Q?5J+oIWvao6c/UqKEp5NIuzzbkgVXWQ8SW2Uj8I/4Nkn9dx3J+IHKFQYdlsvK?=
 =?us-ascii?Q?+ehO2nFmCqQJy6i0wdGtqkmZ7k7fDx5ic44jo4GSljhpYAXRSK/h1ebwvdXG?=
 =?us-ascii?Q?nxoyhDHiGPDV2DYtaLYfPSu9iTtKfy6TEUaNHwgSwbnik+845hRqIIPobr9A?=
 =?us-ascii?Q?f/AkOIL2NCrNEnCjyx6YxpklM2/WAj36YRCvd0N8sP5KWZYjLJQmMPM2qsL8?=
 =?us-ascii?Q?CjDZACiXiqEFgAvMBQDta8855AxPalHtTYQKGlrIEdK+cmjRYYCjhcNatmEu?=
 =?us-ascii?Q?LFUNrkCV7yiisYZOQ5hOsXgFjCxiuj5ESMEkvKfVW0Ft2B+21QbzuW/NEYHT?=
 =?us-ascii?Q?nd6bLYegdaS92FipNID4PWSVpW/bOtzhJUHtKBsVFeNFb/IugRk5yXRRAyDb?=
 =?us-ascii?Q?1yB7xMVJGYHpBZdSnj6TBAJAs7BvWOSyoh2snXQjN3DFvzLdxI5GHJcw5OIO?=
 =?us-ascii?Q?n28pZpsb3/llaSJsQp5fjC2UuIvtTM37rP4qkIuXDA+muXc7wHF5F46DXyJv?=
 =?us-ascii?Q?RhHTJ/TzEu3Arvi9XWEwI4WLciWRYr8ekbmZ0MadQVluQgZoCtMY3GNFHWR0?=
 =?us-ascii?Q?vQsvnaGw+rmDyhzz7nvkj722bju7F5ox0A0X+S69J9LQe78sMmx9LejvCXHg?=
 =?us-ascii?Q?gRTPJ1A+2pmFX+qDHuYmW3N5+MtYz6O3IkA3Rkg6/wHmmCxcISxFha5/5wZo?=
 =?us-ascii?Q?aJBhFBnuNLj2zeyIAd1FFFA6xbqbyX0n3YXZ2tH3/0Oj/lMz1njGz3Qf6a9F?=
 =?us-ascii?Q?f6KoLlyuMH9YR1sy1C5AbEkOKQs2gjYAT6lJ3oOxO95NYAak3CGq8eE6Npot?=
 =?us-ascii?Q?pjGfOTGvyQxXhxeweGc5KmjSksIjem6hedjfn8kvA7wXe2Gf4fMwloplBz6g?=
 =?us-ascii?Q?cknrDKpWsOqpKjD4aKRX0s7DRNiHhG9Z5896/3G3YtN3iQWfM8GzzVrXIBFk?=
 =?us-ascii?Q?b0ucqzsYYJlDWkjGYNiNo9c0cDgKFfsudrjpqJ07O/S8rdtWUnqe86X5sRAv?=
 =?us-ascii?Q?5fTynliWcSFKIdqhPuAFqVfD6Mw3lp2q1IcE0TVssmKuT9+mEj31u5IhZp42?=
 =?us-ascii?Q?JZ1FgZl8AIyErKbzZI+fZAt1qWOTRGKlA6L+dSlwdiWEATWqpXQX54tcD2za?=
 =?us-ascii?Q?oCsCfa9uAkMgjD0rDLNhzubpd0BKQCd+FVBBC7Qe7TQPB0Jn17WOzRCaipgc?=
 =?us-ascii?Q?xQoHQr39vFnXibYRJ3llWLY1gMeLgpLPWhqT4kv0uu7u1Z4Yr2v4jCL6/j7/?=
 =?us-ascii?Q?gLO0gWblM29/WNmhEC8FrcCbcq4OO8xx6U1DMBjSSTq1jabD6GsZf454vBPu?=
 =?us-ascii?Q?32D1ou2I2fi9CscHexguJG5pNhoL/UTXCBbHDOfU8nW/myhFDBfTuL69Z4xm?=
 =?us-ascii?Q?VKV2/n3gQhKlnBCoSh4=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e4acc76-7134-46b0-4bd3-08dbabbc35d5
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3657.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2023 13:55:05.1522
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgaZZaGdsUO1vf+X9Yb/5IUh6b00V6E/bnR4UWNjsmfDm1T7gxCfsxrealVlpvKVhWQnViB/eaVrTleWdeuABw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.23 10:15:27, Jonathan Cameron wrote:
> On Thu, 31 Aug 2023 10:20:18 -0500
> Terry Bowman <terry.bowman@amd.com> wrote:
> 
> > From: Robert Richter <rrichter@amd.com>
> > 
> > The function devm_cxl_iomap_block() is used to map register mappings
> > of CXL component or device registers. A @dev is used to unmap the IO
> > regions during device removal.
> > 
> > Now, there are multiple devices using the register mappings. E.g. the
> > RAS cap of the Component Registers is used by cxl_pci, the HDM cap
> > used in cxl_mem. This could cause IO blocks not being freed and a
> > subsequent reinitialization to fail if the same device is used for
> > both.
> > 
> > To prevent that, expand cxl_map_component_regs() to pass a @dev to be
> > used with devm to IO unmap. This allows to pass the device that
> > actually is creating and using the IO region.
> > 
> > For symmetry also change the function i/f of cxl_map_device_regs().
> > 
> > Signed-off-by: Robert Richter <rrichter@amd.com>
> > Signed-off-by: Terry Bowman <terry.bowman@amd.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> I was ambiguous in reply to previous, but my RB not valid here as it
> stands.  Just replying so that doesn't get lost for v11!

Yes, sorry, I wrongly assumed it here. Will remove for v11.

Thanks,

-Robert
