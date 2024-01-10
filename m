Return-Path: <linux-kernel+bounces-21605-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C7F8291C7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 02:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFA13B23C8D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B0A3EC7;
	Wed, 10 Jan 2024 01:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dSn+cAcY"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2715645
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 01:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704848957; x=1736384957;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=ERb4Ur1CXrhA9+w/Dn0YRmcsz7QKDNyvkiyB0dtQv/4=;
  b=dSn+cAcY1iXwGQhhEzrBtyv0kuPQB92klEhJpu13/bU2+Raq5CXQDeKH
   H7MO0MpCs/pruAw9uSK9E+blVCdl91nIR5VFayM76EeuQMlW5pd4898e9
   DzxXiqq2uoIrCvw9IOIN8KyajcSxvG6RcaHQ/dP5zSeCsf4uN7f+0SMg8
   CzeviA7XoQfbimiWP971DZAnEJMFMQ0EQHSMxtyXHND/u/ABrgXF5gmJP
   HZnWaYrtH5JepoSXsNVMF9BO2rj2NDxNQklYNR01OBCxFq7mDBbFnVPaf
   UmxDHiauNXV+Lu56dMeCSgWldSbQgmUEq22ZOChL31TfoJJFR3P7EH+M/
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5739605"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5739605"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jan 2024 17:09:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="955182968"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="955182968"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Jan 2024 17:09:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:09:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:09:15 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 17:09:15 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 17:09:12 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=epzdXrzXaSkTRGKBPFZUgOyNGpQP5mMpUmx3I+auhvW9el9HJ5p6sxmSpSQzms7QokJpCulwHitTQJh9ivt0dgTtMGHXb9qYRcmy8xUPvLkuyBZOQhsIfVvkwZR9mAZUYangS/iN0H9+76rAvL81usR1Jt+huO1fxbwFzpo/U3qOOX948PSB5I9xAMNNZp804/WLkn9Nr2w0ib5xWhyWc3e3RglaP4MOvKmbMrQOGXawuq0owoU41XjpxDVPx7OAsgmgjvZGwVYCkPOarOJcWGVvjWD6zMw8V+x3GQsNhKb4tHpqj8jjdR5PrmwHnrQAqgGVQdujEYVKDa5+VarevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P6HlNC0IVpEWElFtwMX9ShTjq50OLx0X/drsp6xg4i4=;
 b=IqVL6DzOZ8XRa5z4Skqg+1PlNkRDi/QnhW+0QKSYUrTF7nPAPUg+5dXd9YdQsIEQgpYF6q/h0EJOG/94hEIQ447Q3Ckc83JltjsbFHKWRDQJGxVm15f8V/lBNzzv89dVhAv/bihrtqGdJ0Nyv9tQdHNis3+IAuDlCRbuXfbES6NERXHcBAEaeN7z6gcLFNDeu7OUs7QqlGIqeYWGDLJAbiG0/DY1+zr1ObFFdzj1Ro/Jt6dGAiPhzQAY1TkRMwh8jU7n1MICRbrgwzC16Sy5u0UkybREFSiDrpxEx0eIdIlha89Gvq13gMQstLbmSzdkMl2a8wKyVeWwFtJakBb/Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by LV8PR11MB8559.namprd11.prod.outlook.com (2603:10b6:408:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 01:09:10 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::b870:a8ae:c4f1:c39b%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 01:09:10 +0000
Date: Tue, 9 Jan 2024 19:09:07 -0600
From: Lucas De Marchi <lucas.demarchi@intel.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
CC: "Paul E. McKenney" <paulmck@kernel.org>, <linux-kernel@vger.kernel.org>,
	<intel-xe@lists.freedesktop.org>, Jani Nikula <jani.nikula@intel.com>, Nathan
 Chancellor <nathan@kernel.org>, Masahiro Yamada <masahiroy@kernel.org>
Subject: Re: [BUG] allmodconfig build error in next-20240108
Message-ID: <3y3zlksbuvjx3wtlv2mrywpnofkpamcsygxqtnseblpcdcjewl@rjsj35auh5ix>
References: <45ad1d0f-a10f-483e-848a-76a30252edbe@paulmck-laptop>
 <20240109095757.1313b2d9@canb.auug.org.au>
 <341a4955-0cdd-48d0-bfbd-cc6f6f09df37@paulmck-laptop>
 <atbx7mspjbymkzgstk4l64qz3uky3wpmx4isrfg3ixgtvebdd2@cktpe4ejfk7k>
 <20240110081155.48bb0cbd@oak>
 <d61dfe52-9567-4f62-98f5-5c1e00cb4708@paulmck-laptop>
 <20240110095822.3ba3d979@canb.auug.org.au>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20240110095822.3ba3d979@canb.auug.org.au>
X-ClientProxiedBy: BYAPR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:a03:40::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR11MB6139:EE_|LV8PR11MB8559:EE_
X-MS-Office365-Filtering-Correlation-Id: eda7fabc-a767-40f0-df69-08dc1178c09e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FQKaOKsTiolaZrJ8lLRDPfiDTbPwF1ypK/TqLm5WoS7fczYJKfMlpO38OFBsSNCk2x8ns6rEdlSH/0ktETBVDnF90ogAkHExV2OOOFO8detJUQSKYsQatE5bhdV/LzI4gpXqXHld/Jg/IYc5U5VUm9UTJ57Ml6R9OeUH2nGpVHFrUom1ZSvAG7JeeVBwpnUJ9upF57Hg68rImxnzIokmW5s4zpXTbKBH6Jr3cQw0LhVDuCnwHhRRd4gQoLLTEWo4gI9zNry3qpZYjfN/wuOriExtk91sz9nID5xLFxmaHlGmDkEJwxq1psEnvgZtl7WZvYaJPAS63fX8He+aoymljij31kyi58bfvyAKcSxcvbfmG5KNF7kuzaVr2GnHLPjMtapu/dcFDjEeFHInGlYn1w+1ObbiU9E3pKjKEoEj+Q2BOfN9b3VghnNXJZ0QpQw71ymwb8aAXYdi9MUqYYeMF25kYY36Fd5VndEl7ewtzoRChxhcV8oT9Tx9UgszmEl10wliPjKKTC1iqB6uy2xpmygP9FgRwx6VOMfBvJ5GZ0Z5Y53Hif5LKf9nly1Cro9sAXLe9Bxgh9OTH2G5zdZunoUfzHhZfaoPry2qgZid1PnRah8hbWOTdgU4acr9FJ6k
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(346002)(136003)(39860400002)(366004)(396003)(376002)(230922051799003)(230273577357003)(230173577357003)(451199024)(1800799012)(186009)(64100799003)(66899024)(4326008)(5660300002)(8936002)(8676002)(2906002)(41300700001)(33716001)(966005)(478600001)(38100700002)(26005)(6506007)(83380400001)(6666004)(9686003)(6512007)(66556008)(66946007)(66476007)(6916009)(54906003)(316002)(86362001)(6486002)(82960400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?lKguMuOJcqDDqwWxKZjgK+sF/7jRFz8o9nBKAHhOVS59ZS3ykjh+Y/EwukO/?=
 =?us-ascii?Q?MXMQEKsMYQqQtsqckJ8bb98v1YKBVJ3TyUycpZ/5d1j0icay672n3av6V8VK?=
 =?us-ascii?Q?VByzZtyHfmGK3b8C+0gxVd92ep0+9pvDAhhXuPlOeDmXAXCh7dtftlbJ8MBw?=
 =?us-ascii?Q?AgIVG0vhwUOGNnVo4N2obwIp8/cgncaeQeBSiT4MMbIT+r+C/zAWhEu3gA0+?=
 =?us-ascii?Q?197cF/V7r1sc6VxYnFO/CjBpv4vnfX1F8rY+wuUzuKHmXYkOaX1SNIcdNl5y?=
 =?us-ascii?Q?6MW7xtBS6bNejTPp/BHu4kvcG7HWwNeyzb7UYqQ15Mwoome4G7kHA+iFcuiB?=
 =?us-ascii?Q?hefuMc+m0blJYM+SEQ24gtC17sOnW03MdrolSYbLYqIg4fpbIEQ76aveLoop?=
 =?us-ascii?Q?165r3QFMjqIF4oKelgNG7PBbhNg7x6AVEgAj1PHsVKHSnDjt/uMW3hYzZnm5?=
 =?us-ascii?Q?Gy8RVMlhYZihAJy8gqOlt0SjHPrJ8V5Nu3szrwP+gGtOLQZn/eYiR2NDMqpg?=
 =?us-ascii?Q?4JpWeYJNTbLkV12EVs5L7Xxnxqo6HPYUscYiETtFubePa0PtwtUELY6vPG7z?=
 =?us-ascii?Q?GeWqjqQ6pntxYKxOEkJCwYSApjNshMb49aMNB5nlLwI87RuFNkQ0Nq7I4jg+?=
 =?us-ascii?Q?0LKHyMyIZ1NxOD+4pRvapjofXNCTHgVwJ7dK4BB2oE5IFUgpBVKdnjkkLcf+?=
 =?us-ascii?Q?E2cNeqIe8ZO9hZhLkmzURg3KIjS9mfHfacKvFNvKngB+hPD6Um5RrS2n2wWR?=
 =?us-ascii?Q?CQLBthgAy5zYY0tRpdQtwfcZy+PY/yjluOZOv2/Md/X9uwp9IKvLuko4aIHd?=
 =?us-ascii?Q?oVK2CeZFF6Xbzz1UzMotClAyxV0IlqPK+2k0PhGr20ImdhjCLr+IVD4w1h/k?=
 =?us-ascii?Q?f+aEPezMTAphGIVqd+2q3xaU80Mh7LuJnjC/79tiIOisM7OojNZk1VbZ9ta1?=
 =?us-ascii?Q?C4BXu2bJYoCjOfDG5XhZXimKLy13qvQEQaZuXcv+BihDyGxaFZzmkk7Bjo7W?=
 =?us-ascii?Q?dqAB3Bsqxnxo59nIE2FzCBm8LI7kHBGXobTvCssoh1pFZ2OHMyAunedIqq/u?=
 =?us-ascii?Q?9Brajaka3ljVH0++zCSd9tFWLm6X1l32mc2XuBOzKH15RPNugq6364McAVPR?=
 =?us-ascii?Q?h9KMGrMgXSK7PVcGQR/Ba70PnNjFYOCF8QOhbBBgsRzpYmhLIFsUuLPpCj/n?=
 =?us-ascii?Q?8bJUICE2xojicm5sgGqeTOqL+92VoEZY+4KYVJ/9tD3ocPt2n/H+PmJ1vDpY?=
 =?us-ascii?Q?ZFIWO0lWDQVNrn7LoKFdVQTsHOpcDFrZ5Ce4nnlfua1NyTyFuE+R3+Rx96z2?=
 =?us-ascii?Q?DZvUtfgh1Sqxuzr5OAdPeMebXLxQ44Bjg8ouKaK/tphuhLBXBBAgBzWdKV2b?=
 =?us-ascii?Q?W2tiPy0ODEfYrjGxBuUtmGtpqFJh9VwjQYC/o3l9G3LtlntUCBthCrNNV27e?=
 =?us-ascii?Q?XUZ/3KDgwyyhNMPL38YBqytctMlCQQiCz6zeCtTpOdA7wQ2bo3oNu0D4FfTe?=
 =?us-ascii?Q?aNLf+2LeNtenJA7i+QGueq0/PJ92Fs/v7VFSziDi892kfHIwmmw3AWvZjSRT?=
 =?us-ascii?Q?lwyesGSm5LP/zDmpbBDhymVuuyHe8Sox2C9sc2jJg/SGnZL1I3uZgXMU/Xyv?=
 =?us-ascii?Q?dg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eda7fabc-a767-40f0-df69-08dc1178c09e
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 01:09:10.7149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Iic2YnbDyah0YoVsCtS8thWFMhua3n3PGBEewGGM76RY2ilKi+5U5ncmKc9Qp8/cx/1u3+cax1m4E3wu39lL2jkUhCZ2RvhBkQTfG/paCPg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8559
X-OriginatorOrg: intel.com

On Wed, Jan 10, 2024 at 09:58:22AM +1100, Stephen Rothwell wrote:
>Hi all,
>
>On Tue, 9 Jan 2024 14:45:56 -0800 "Paul E. McKenney" <paulmck@kernel.org> wrote:
>>
>> On Wed, Jan 10, 2024 at 08:11:55AM +1100, Stephen Rothwell wrote:
>> >
>> > On Tue, 9 Jan 2024 10:58:40 -0600 Lucas De Marchi <lucas.demarchi@intel.com> wrote:
>> > >
>> > > On Mon, Jan 08, 2024 at 03:15:23PM -0800, Paul E. McKenney wrote:
>> > > I could reproduce it with allmodconfig and gcc 11.4.1 from rockylinux,
>> > > but not with gcc 9.3 or 12.3. Also it's not reproduced with gcc 11.4.1
>> > > when using defconfig + CONFIG_DRM_XE  (even if  -Wstringop-overflow is
>> > > still added).
>> > >
>> > > I don't see a bug in the code, even if it inverts the head/tail
>> > > convention.
>> > >
>> > > Searching around showed this which may be relevant: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101854
>> > > At least I can reproduce the same issue as in the snippet provided
>> > > (https://gcc.gnu.org/bugzilla/show_bug.cgi?id=101854#c7) with the buggy
>> > > compiler.
>> > >
>> > > So, maybe the best thing to do for now is to disable -Wstringop-overflow
>> > > for gcc < 12?
>> > >
>> > >
>> > > ------8<-----
>> > > diff --git a/drivers/gpu/drm/xe/Makefile b/drivers/gpu/drm/xe/Makefile
>> > > index 6952da8979ea..0433a3c6cbfd 100644
>> > > --- a/drivers/gpu/drm/xe/Makefile
>> > > +++ b/drivers/gpu/drm/xe/Makefile
>> > > @@ -17,7 +17,7 @@ subdir-ccflags-y += $(call cc-option, -Wunused-const-variable)
>> > >   subdir-ccflags-y += $(call cc-option, -Wpacked-not-aligned)
>> > >   subdir-ccflags-y += $(call cc-option, -Wformat-overflow)
>> > >   subdir-ccflags-y += $(call cc-option, -Wformat-truncation)
>> > > -subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)
>> > > +subdir-ccflags-$(call gcc-min-version, 120000) += $(call cc-option, -Wstringop-overflow)
>> > >   subdir-ccflags-y += $(call cc-option, -Wstringop-truncation)
>> > >   # The following turn off the warnings enabled by -Wextra
>> > >   ifeq ($(findstring 2, $(KBUILD_EXTRA_WARN)),)
>> > > ------8<-----
>>
>> This I did, thank you!
>
>Maybe that line "subdir-ccflags-y += $(call cc-option, -Wstringop-overflow)"
>should just be removed as the setting of that option has been moved to the
>normal C flags in the top level Makefile (out of Makefile.extrawarn).

yeah, if it's part of the default build now and not only with W=1, then
we need to sync again.

Ideally opting in to extra warning flags should not be done via copy
paste, which would avoid this problem. However there were some
issues implementing that generically and some push back on making
W=1 options automatically propagate to default flags in
subsystems/drivers as per https://lore.kernel.org/all/20231006174550.GC3359308@dev-arch.thelio-3990X/
which also makes sense.

Cc'ing a few more people involved in that thread if they want to add
anything.

Lucas De Marchi

>
>-- 
>Cheers,
>Stephen Rothwell



