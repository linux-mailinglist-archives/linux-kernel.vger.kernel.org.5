Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B1EF7FD75B
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 14:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbjK2NCB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 08:02:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232918AbjK2NB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 08:01:59 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10hn2229.outbound.protection.outlook.com [52.100.156.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6836C10DA
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 05:02:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cYt9rSirU2EkNF9en92WGHA2cO8tzaxx/SUCLupDLBwOYoBLI92Bnl6HIrp9/Lsw95zTKxP85Oct/5WAOBgywEewZQEhyW+JEVEBB2CUkj3ll1pXcs9hGuoBviGAk9KC3JIOd+HE/zoaKZRze6dp9lousj8ufasoBF2kOg0f3u9VXiFitUGyzmtZhHzTzxW2TWyyUs7Oza7xcj8TcFsRxVpNBLkXniA9slatLkK0MQPMVcI/n8DbBsHHRHzYFqfu7npVXs740EsOLTrUgobsx7B/ZY3AqhMpSYwsYwDuZOzXiyVRyNilkE0J77KVsC0XJiKVb+VMvslI6wXVIfi5jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0N1agJ95LI9KpyI37yJQay7dirxibEYTT6WlMVVyY5k=;
 b=ObiWRPDxpkDrcUv39dbh3wAeRjxJwKbSxDq4a5fasno384/lCBZ/sjKlS03K5gpLAmWPC7r7dU33DRQ4SoBaLj3L6KC3iHYGEUEfh8B2kdi7pAjbD3rhZFqfQBlKEXgc2CrVlt3zvyp1EGKUPdrzpQhmnCQ+7zPKafXrme0YuNW3XT/h/z41MK+0yQaIMmHEd77D411eStG8QOE/d8BWJ2CE0gaWa9g3+WTmdpVW80uZRWn0OBXZjDsysO81/VgTNgWpWnGJAUoYcjcADxdB0KkZl8lc5AyiVupO9gm4l6JSkWYynaMiBxrzgvJW9xyVYnwa5u+FoahJIw9uilKsQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0N1agJ95LI9KpyI37yJQay7dirxibEYTT6WlMVVyY5k=;
 b=m5PZBvOImykwDt+h9MGXhfXAVWPF3RaQdSbW7yKum6HwTgKRsCaITyyiqNjK0IX93gr7Um0Wu3W9//cMwE0ZNYshekCQEQPseHsJCE9+NslSPMgf2RWolWFOdECPpB8OTXuDUlAPGg+s/2LXnDXted17wtRfxT8wJHem5LKfzoIcOXl4lOw7TnyTLriD0F8hL7ivMVL3Xu761k/Zcu3qTt46i4Pgmen/QO5+Hl3hVnfAp0mkHSpI7W29A3u4CwGgqJdMtFGAvzgGew7CRpVdxJGK+QDna0ljQBGK+zTxDVge+yiUO1tx8H75muOXDw1pyMDOJbRNTPzTYRwV3tOOdw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by LV2PR12MB5823.namprd12.prod.outlook.com (2603:10b6:408:178::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Wed, 29 Nov
 2023 13:02:02 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::60d4:c1e3:e1aa:8f93%4]) with mapi id 15.20.7046.015; Wed, 29 Nov 2023
 13:02:02 +0000
Date:   Wed, 29 Nov 2023 09:02:00 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Saeed Mahameed <saeed@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Leon Romanovsky <leonro@nvidia.com>,
        Jiri Pirko <jiri@nvidia.com>, Leonid Bloch <lbloch@nvidia.com>,
        Itay Avraham <itayavr@nvidia.com>,
        Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org,
        Saeed Mahameed <saeedm@nvidia.com>
Subject: Re: [PATCH V3 2/5] misc: mlx5ctl: Add mlx5ctl misc driver
Message-ID: <20231129130200.GV436702@nvidia.com>
References: <20231121070619.9836-1-saeed@kernel.org>
 <20231121070619.9836-3-saeed@kernel.org>
 <2023112727-caddie-eardrum-efe8@gregkh>
 <ZWb_l7rC4QK8duU3@x130>
 <2023112938-unhook-defiance-75ed@gregkh>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112938-unhook-defiance-75ed@gregkh>
X-ClientProxiedBy: SA9PR03CA0010.namprd03.prod.outlook.com
 (2603:10b6:806:20::15) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|LV2PR12MB5823:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a6f9aeb-ff52-4486-0da7-08dbf0db6117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dDSaYA09OC41tkgMb4I3nvyuECVit6FiUDOhAOrqHSEfLIupBHgpfDgDMVYE?=
 =?us-ascii?Q?OWrvGGYoGfl5Dkixhk1vSPlt0fcQmpuLNoXF6Z1Ia95gMjYZ1vzAOIZ0uGo2?=
 =?us-ascii?Q?RW3178t4TcmftzLXgyyiarqMkAFGDfp1/CAB546/rv/xRYgAxYxWbgfxd/xi?=
 =?us-ascii?Q?vgks9KDlw5W4CA9nfx0TyhKTx5RiE77OiDGfQkREEpaFhqqiyYV5nUjsu2Z8?=
 =?us-ascii?Q?yNOW1Fcmf9d/LewLyFuQHDKz5qYAtaK27AbudnZfHYKxayiwXtlJdgmkqWnV?=
 =?us-ascii?Q?qGKD86sH3VX7lC9A+GdFRhBIuXETvYAB3ylXxlKNizp/1UgQx5d9lIl/cl4D?=
 =?us-ascii?Q?WwFWgO9DDu2FhvkNDLiwGpAwO/bESZAHWTNKKquhlOwh251HdkKjpK/VaIPX?=
 =?us-ascii?Q?32+0KG8DIAoUvqN9ZWxd5v85urMFht7zJ9/R9BBoT+OIYL+yVQAEHnD6fSdb?=
 =?us-ascii?Q?VEv6m9rFfvI25L1+RASZ4vX990DE4elW5nBzjb1CAE4NM/IIdcziF3ONMVKg?=
 =?us-ascii?Q?ExUrJcqoSa925crR7xaeUZTaHWAe+BXZSBE0EHOhJT5Ugf6xxpRPDEgVqIUC?=
 =?us-ascii?Q?K7G53thTs5cv7/ypLSQZ1XdeiR7HmNAama3UO4rirzxFUm6B7krkvPhlO2je?=
 =?us-ascii?Q?D77hexIYWa6bo5KHzLhFcLuJ2/fFpmaXx+l9vCaUNgz1gYoxYLyGe7nZCdNO?=
 =?us-ascii?Q?iWb12Mi1ubUgWhmr5nxVpROf4ez0m7ZJl3OZ+5RKAZnHf8aGbN/MYcTf3rlE?=
 =?us-ascii?Q?3oquSJZWz9RrxlAaC348J96hWWC57qvgDNO/ZZANntk0o2oJ/XLuRrL++EBH?=
 =?us-ascii?Q?0e1wlCRH5lDqVMgfRvEMG2X2RzaTc7PnsXkeaCdkMbPHlLIb7TA3Oiid+Ln1?=
 =?us-ascii?Q?IB9WeeYXUYwKHQYW0fsrC1Mi5dDPDtQfNf/+y0Vgmf4rQQ8UNMG7pOLi7kK0?=
 =?us-ascii?Q?sT34JcRSVYGHn/+07LOZmp5Vu6TX4vgIq/XFxXtDytgOnow6BqvUU8445IMd?=
 =?us-ascii?Q?Zx+d3Dr73Xm0sBQtVz+9lUuQEw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:5;SRV:;IPV:NLI;SFV:SPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:OSPM;SFS:(13230031)(136003)(366004)(376002)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(66476007)(66556008)(316002)(54906003)(6916009)(66946007)(4326008)(8936002)(8676002)(5660300002)(478600001)(83380400001)(86362001)(2906002)(26005)(33656002)(107886003)(1076003)(2616005)(36756003)(6486002)(6512007)(41300700001)(38100700002)(6506007)(27376004)(42413004);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B1+Vjk5nLZ3LmqcWWEfDZqqpjXv+4j3Zx02qtrWnaBY2d8/Z+VJJjz+m18SF?=
 =?us-ascii?Q?RYF1RagikUbWazjNJ3ByBiPxOeF2CM2SdRtpDR2d55KQBdqFzHLXOUM/8l2T?=
 =?us-ascii?Q?KLn+wh05mW35/93u2eHTETgy1dh14oJ8HG/3Y+JsPz5dG6Pfwtq6F6LNLT4C?=
 =?us-ascii?Q?kFIFO+vkzrKr8GC9g0L2wt079b0+/dKz5cELGPpPeBNA2+DyQ449pkv4riQh?=
 =?us-ascii?Q?GxsEjB/5az55CKdzEUvFR2lpE8jIrBU68ITsCt+wuJ1luQrNU92kr8oxu8eg?=
 =?us-ascii?Q?BjPdqlu60yG4jMxSFAG5LB0ynJbPcVnIdtGVlrNam5PYifeESMyn+xFY+Lkg?=
 =?us-ascii?Q?wFD6ZJ7Bt89N+FqTKLgaavdqmySi6EtGjNzNVPTBBvehJV8V89bfADZYdD9e?=
 =?us-ascii?Q?/WYgdgoCZPUYrkUT1lzabCaKk3aD4lLvqAjfApo3dOydN+yF+M9oAp6oYj0W?=
 =?us-ascii?Q?x/KXdlwk8aSPL9++63NMhTVfyGwND/HiTBlGJmnp2O2PPQMGhV3YdR6TBtwu?=
 =?us-ascii?Q?JKM5d5B9zAYPxUzc2CHP/HMxuZljbl8obOK/gDLfvyjOGRIoQUFQxfjWNlgu?=
 =?us-ascii?Q?ascK9SPmXkLNCPQF0YXfH7qCiLgOyL8imdq5HRQ7FZolWQ+aIWbklrQedyw4?=
 =?us-ascii?Q?eGmS5FRJX4h02X5vep/uw20tGK0CP3fB2mkUfttEcp55/nZjrBalR1eKVt+W?=
 =?us-ascii?Q?qURb9W5h0stEOlXTahK+kaOguvrQUr/uEDxZiLoBBLTpkFaq0POYykwFpqT+?=
 =?us-ascii?Q?zSxXrpi0cnMDZ2VMpCK7D1Pb/lwIClmWh7To9OH9ZRUtoHSrUOsT0RWGBZh4?=
 =?us-ascii?Q?e5BiPiuWs3UNw488ffegH65mWCOtw8zWCdjjQkMGNLw+Qn0hTJXvN6a+tcjZ?=
 =?us-ascii?Q?iSPpgDbIkrpZeILWHPU+s4PP7hAa6tVsMGS7aN46oHTPvEJP7aTcVNk/FO0i?=
 =?us-ascii?Q?5MEVifc6xAOCF5OwztcqAJnGsSrYAneWUa+BVRZuYgKuN+VA7CXUhUpQK2lc?=
 =?us-ascii?Q?7tT+17MZuPToQQA7h3haBR+KOugoHL1RWXOvNUa7EmThV5kPAu9YM9CHjx9o?=
 =?us-ascii?Q?kNJriXwLtryk18Bmm3JvgOJdL2zLB6ZXWiv/6kgNdThwIeozwfuqS0noSbOR?=
 =?us-ascii?Q?jIrdorSYQMqT2KVHVOhh+21rXh0FtS9UT45xGcM2s2yQbycUYdZJaKmVSOx9?=
 =?us-ascii?Q?mWQ6qYRddYL39INNwPm728zBtyBHvlGRjil6+AFg+vXaxjaXl/YjFWKIkfbD?=
 =?us-ascii?Q?8EXYLpzT6j1GO7aZhXabqNfE3hsDI6561+R3Fi4lMIecniVcB8Clj/+z3hyg?=
 =?us-ascii?Q?7ZycYQvuZyBTM7L2SeOSDkT3H1T2BN8KbzbdQxRY+L2z6ln5vO2X5VtX0bn8?=
 =?us-ascii?Q?xIBcsQF3Ohvok/mcYhYmYUGiAB1EK/Hy++H1Av2BHRUkVxhaQzUQ+lMZ5V6M?=
 =?us-ascii?Q?XB/qNcmQvwOZJYQu06JHsTU0Sh/GcyxG/6pxokZIf/KxQpOH3uRkZ7TeaMKW?=
 =?us-ascii?Q?CrjvwuG7VZvvoTlnj2IGHCRinYHARE/4Ej607V8lpS+CeDEjB5ixFncUwbgb?=
 =?us-ascii?Q?+4ijVEwn9g9Mp6Qs2EqXr9XIkStNq7INevKVJoxO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6f9aeb-ff52-4486-0da7-08dbf0db6117
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 13:02:02.1805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CKFKqajw746+wSK45vWS3DdxzKvxyuv7JZExB8ulkFI6tZ3VJE1Sju/7tPrZ1OYA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5823
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:20:32AM +0000, Greg Kroah-Hartman wrote:
> On Wed, Nov 29, 2023 at 01:08:39AM -0800, Saeed Mahameed wrote:
> > On 27 Nov 18:59, Greg Kroah-Hartman wrote:
> > > On Mon, Nov 20, 2023 at 11:06:16PM -0800, Saeed Mahameed wrote:
> > > > +struct mlx5ctl_dev {
> > > > +	struct mlx5_core_dev *mdev;
> > > > +	struct miscdevice miscdev;
> > > > +	struct auxiliary_device *adev;
> > > > +	struct list_head fd_list;
> > > > +	spinlock_t fd_list_lock; /* protect list add/del */
> > > > +	struct rw_semaphore rw_lock;
> > > > +	struct kref refcount;
> > > 
> > > You now have 2 different things that control the lifespan of this
> > > structure.  We really need some way to automatically check this so that
> > > people don't keep making this same mistake, it happens all the time :(
> > > 
> > > Please pick one structure (miscdevice) or the other (kref) to control
> > > the lifespan, having 2 will just not work.
> > > 
> > 
> > miscdevice doesn't handle the lifespan, open files will remain open even
> > after the miscdevice was unregistered, hence we use the kref to defer the
> > kfree until the last open file is closed.
> 
> miscdevice has a reference counter and a lifecycle, you can not have two
> reference counted objects in the same structure and expect things to
> work well.

This second refcount is hidden well:

struct miscdevice {
	int minor;
	const char *name;
	const struct file_operations *fops;
	struct list_head list;
	struct device *parent;
	struct device *this_device;
	const struct attribute_group **groups;
	const char *nodename;
	umode_t mode;
};

You have slammed us in the other thread for doing a poor review job
here, but none of us see what you are seeing. Can you explain better?

> > write_lock() : only on mlx5_ctl remove and mark the device is down
> > via assigning NULL to mcdev->dev, to let all new readers abort and to wait
> > for current readers to finish their task.
> > 
> > read_lock(): used in all fops and ioctls, to make sure underlaying
> > mlx5_core device is still active, and to prevent open files to access the
> > device when miscdevice was already unregistered.
> > 
> > I agree, this should've been documented in the code, I will add
> > documentation.
> 
> Just make it simple and use a normal mutex please.

A normal mutex would make the entire ioctl interface single threaded,
this is not desirable.

> But before you do that, please see my other email about why not using
> devlink for all of this instead.

We've been over this already, the devlink discussion is about some
configuration stuff. It has never been suggested to cover the debug
interface. This series is primarily about debug, the devlink thing is
a distraction to main point.

Jason
