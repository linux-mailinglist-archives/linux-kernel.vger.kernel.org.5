Return-Path: <linux-kernel+bounces-1410-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0BA814E92
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 18:27:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 805B71C21527
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 17:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7B3D4F5E4;
	Fri, 15 Dec 2023 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FVpB0Rcn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E106B49F71;
	Fri, 15 Dec 2023 17:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702660568; x=1734196568;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DEs28JZ56AKLzE7D39b5v8ZJZb+zVrtJ7Xb7BiDjeTc=;
  b=FVpB0RcnqFxb1/whDAX5s/nppJcm9E0NdMIF6JXSfMkdbMWMpUHLWbtg
   3scbEKmcO9oxu3uqK1954CILWs/U1kbH7cQrGPqkrtHRKXshs11agXxpy
   kWcJZ6nBXf8xY9lxuC9+OU54pDlmg5rgRyXmsBPm0FJxoffInbhkDXeFo
   Dr1UPyurqaYmaVxBCtJD+xpfsoYwy5k2KhlhYeS7TbAFiz8zeshsJms2Z
   nYQkTLzEgtdDxVoIrvhmr/m3tOejrWhlIdiFW3B4ZTq4rV6edabNYd5JI
   CItSVH9O3Q4cihBZXqWLXzx2x3tmq5Bsa6aJWqJ9/gj3CZPiLWVJnoA3k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="2125407"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="2125407"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2023 09:15:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10925"; a="778328429"
X-IronPort-AV: E=Sophos;i="6.04,279,1695711600"; 
   d="scan'208";a="778328429"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Dec 2023 09:15:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:15:55 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Dec 2023 09:15:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Dec 2023 09:15:55 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Dec 2023 09:15:51 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c/OYjHRP2Ryhq1LoUDdQennYdcmJ6HrI60tcpHjyIhh97KLwyM7XYYOtoVvIOXd2A7gxQ/Z/fNTs3xiC7QZ5JK7wXWp1MAgkH1vFZ+bqvnRBMXXVwvhz1dgsklyJ8wXp0RjWNGTlis5+Ispaq7SK4CYqZcRbf6PhWTLlJDJbb28yHKymAtyI5VPZEERZYNaVK8VmBa3gbCa+VwZzoLZjliuXS5LJl0EbIQELLWz+DHqxUqBFDpnZoXo7t0+cXupROWorOIaaHyUY5ccUB5/og325Lq7Jg2hdnxcWhM1Hfq7zKWfj8D58KWAiPSobNwEvxxHb3Pon1CIV7rwp5Oe90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjuCmNsC69+LsHa/VWzYsVQlVTP7f1Y15UkHBYV2Dgg=;
 b=HR3XKYqHI+LHUZDck2TV8ry4CKKsd2y7HYPUlxkn3z7uDP6MbKL9dMyfLFEQ/WYhkHarZFsV8Bf9jmbTYRXDy9xxipZi3YACulRbVzqbBUcH66gWLG+SK2dIsxIH0vPlyhmNE7I6ZKpmDWqbsmLpNS0wym7jji+51itDkSeWmi00gWVnTTwAgFfmQaidvs5wUyb1rt349ud0llc2ZDpMD1xkUWKGJLgnmB1E3SyjV7SC0ypcGW8naffibY/3REPHAqfPTzB+F81N2q19+zlPVISHHuRZeHuTRi11YMejQ/pL2hmsPi3pObMDRrz+dkWUohrXOaMfljIV2BHlJzh8hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH8PR11MB6609.namprd11.prod.outlook.com (2603:10b6:510:1cc::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 17:15:49 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6362:763e:f84b:4169%5]) with mapi id 15.20.7091.028; Fri, 15 Dec 2023
 17:15:48 +0000
Date: Fri, 15 Dec 2023 09:15:45 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Vishal Verma
	<vishal.l.verma@intel.com>
CC: Dan Williams <dan.j.williams@intel.com>, Dave Jiang
	<dave.jiang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, "Oscar
 Salvador" <osalvador@suse.de>, <linux-kernel@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-cxl@vger.kernel.org>, David Hildenbrand
	<david@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, Huang Ying
	<ying.huang@intel.com>, <linux-mm@kvack.org>, Joao Martins
	<joao.m.martins@oracle.com>
Subject: Re: [PATCH v6 2/4] dax/bus: Use guard(device) in sysfs attribute
 helpers
Message-ID: <657c89c16d5f5_269bd294bd@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20231214-vv-dax_abi-v6-0-ad900d698438@intel.com>
 <20231214-vv-dax_abi-v6-2-ad900d698438@intel.com>
 <2023121515-litigate-finished-76dd@gregkh>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2023121515-litigate-finished-76dd@gregkh>
X-ClientProxiedBy: MW4PR04CA0317.namprd04.prod.outlook.com
 (2603:10b6:303:82::22) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH8PR11MB6609:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d02d93d-a17b-4279-75ae-08dbfd917b66
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4lKgr4hNix+uv0QftUqHH6a9U2u5rC/0AUu4/lms2+Gek3h9JQtan6mqgYoo+yjCkzU4unE3rXO2kvjldx9XaL0JpKwcRaYE8BEdw3lGxsEPQNB9tbf/Lh9fxgIdIFkg9J/o/G2CHsnqvwzv8WQHplQ2K/2s0/QMeY1NIa94hAq9mqLgSTTGOZJq99+AglzJ5sNqx3zQaTrgE3fXAps51vpnqqvujqsrbgveHJeF+/3VdkfXY6lDJzkgtFoNoekjodCcSBBtPiDwdyvTh/9CUEhGEQ5ZMRBBBk9SSbGP1KfbJPnedaqy8qfOjC+Uvz+P2Es3xjXJPFTNPoEwV9j/J1lDTvsUKJZ7gXXjV+Uq8327wTATT00sODL6ILBhCRFE8ns1jYQwx2svAhIBek4lIkZCOZbGIeG3QTMekn0ac11Ll2p2lNn5OkREuCRRU3S3Rgwl6VNyZxYih4+K88kC1SSBGtRODuP/td0n/XsRN6ruoPmH7NIO6uNQfQEb4ucwtyYO3lVm5XnT4tdXV31FttIr8Dl+JexunY5FhHOz/42fAC4Gn5VkIFNnLE+e/EM5
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(396003)(39860400002)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(6636002)(316002)(83380400001)(38100700002)(66946007)(66476007)(110136005)(66556008)(54906003)(82960400001)(8676002)(8936002)(4326008)(41300700001)(2906002)(7416002)(86362001)(5660300002)(6486002)(6512007)(9686003)(6666004)(478600001)(6506007)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cjcKusY9INUoNKQSbaGWTGvkfP98yGc1nNiF58oaXqaetg/3vwK5p6Mq8Qsp?=
 =?us-ascii?Q?HoQ00z/oAePYk9C+UQxHZ0gHYmuV9Xn0H11ZxxW1TxIuIvggvCwJhZmHkehR?=
 =?us-ascii?Q?8jc34Ax0Zy3BEV/KWiARkGpWrv2hBSJPGmCbA0+gUoXIqBczHCpezfCwDmk7?=
 =?us-ascii?Q?HL7+ky9TBAj+/elbn9es9hqPgBegXUJ4tkWONjZT62U/b09NPUHrwUW2vlkL?=
 =?us-ascii?Q?qLQ+X4NuQKIqHTbwPZHCLsMupFjCwXJgn5WXsFb91pCclHxgne9jVBYZcoul?=
 =?us-ascii?Q?RITyul2XyIyCfMmZs8OtRxXYuxTtyxrHvg82RLT03+/gMd+oFGAnLJXNzsfe?=
 =?us-ascii?Q?EzS55paeuyAqbo1adypovJO+Wh7AYliFaM8i9LeNIPKd5UtnkwB7ZdFf5VrJ?=
 =?us-ascii?Q?0bwRMBy03ZCb2D32j/KZuNMScRKMKHo2Vmx+GSDPQYp/30qIWEM+W3QEsAhb?=
 =?us-ascii?Q?xe2XbLzkN3pEiy1CuKtaAypX3q/BU5iG3g/vh/S/dEo2KYhzgjLWnC2xRW87?=
 =?us-ascii?Q?LKKA0I9avwPZd5odvh2jBP/f23MD/7V5WjP0DCPOayk6/bN6jusyNqeje/Z2?=
 =?us-ascii?Q?8Td3w0T8Osom0XWQe0ngGEuv9eNlCntQc1IA6RuEmVwsuL68MOGKTV4rQoZ0?=
 =?us-ascii?Q?h0H6/r8H4icWT3FBRc0w06mvQt6VR4XAoi0W5tfnVR5Dh57K0mXxMjg7fqhl?=
 =?us-ascii?Q?y2gztMM7lnmWRHaeGxhtaum4uIumm3rG8NJUOqr2+eMV+kIR5bLPw5LoICCn?=
 =?us-ascii?Q?eMz6BrtJ/nZOHLT90YwMLhyNXQENnouBFI1y1L/Wyy+Cg7d4pJrqqhyVcpGi?=
 =?us-ascii?Q?JEX6XGS06EYlpNA/qobwHVNRP9iQfQ/OIKorgbV2nMoy5jNlRJoZuEbIf0s8?=
 =?us-ascii?Q?xPTWvyU5gzaP9rXi5EByfoUyK8kmj/zeeXPBvygZFDa4l8cd0gBYlaDstmKP?=
 =?us-ascii?Q?FwmB0T1mOA6OZeQ4osy4qDzDyV0HLHajBTEt+CmTRW5NuOjSZyeURS78RGIp?=
 =?us-ascii?Q?aw8F6T4psF8TmNe6Ao5LNkoDLcNa+dUXyeVDlrRoEJBWNxwAJ2YewQvNWMft?=
 =?us-ascii?Q?hNzzLyMnbxXOmJMOR8amapT/XOdKivPNXmOilZO3bODRD140BV8yYkN2y4Gh?=
 =?us-ascii?Q?g2P1pr6OoiwDfVWfRFyicl/WaaBqo7wodHecrTI8qZz5EP92wO8U7OnCP6bG?=
 =?us-ascii?Q?BwXiInKecF04idn7Ii+iJJVejKzhLiyenj87OLt2BxLEbgDvC/1jOyn5nd0f?=
 =?us-ascii?Q?x1w7eQc9NAZ7/mRyh8UXwAx1VsQTmsbzToxuyMTZjPVqA4aMseJbcsJOAluH?=
 =?us-ascii?Q?JL4KMjCRz5BZwS4xRW8Wpwz3jD7eJxP73eHbK56uVdCFTPGo+2GWrg0NmhUl?=
 =?us-ascii?Q?KoMM60nUBAgDQk+KounanyC+AJq1RU6P4r8CMgw/2LjrfD5wnbMaah+R0LgK?=
 =?us-ascii?Q?amMBkoBmpvZanzAzI9QkFZmYmSR3MXXhXRk6xQVkOrc1Glvd+/c3hpJCIglZ?=
 =?us-ascii?Q?SvgdrXk/6sKa/CVZwVx+Oic5JZvE9UphuwVZ+AZssLHeUA96TqNiKYrR1jNm?=
 =?us-ascii?Q?dmgUdUPYk74Hr9cnYrmrsYMX7q0Zk3ihaTlqBJ0v+v1EDDRmVCTDxOHc9AnA?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d02d93d-a17b-4279-75ae-08dbfd917b66
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 17:15:48.6873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8CGU+kjtSpxfJTBdAORZS3pBs8fsuY6lAwJaRKjUc63iYQtj/N4PL4Oz7LsDv/ZJu9MbrYYmLOFNhUCwTfmzgeBTAihUp9tMocC/oFwcOnQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6609
X-OriginatorOrg: intel.com

Greg Kroah-Hartman wrote:
> On Thu, Dec 14, 2023 at 10:25:27PM -0700, Vishal Verma wrote:
> > Use the guard(device) macro to lock a 'struct device', and unlock it
> > automatically when going out of scope using Scope Based Resource
> > Management semantics. A lot of the sysfs attribute writes in
> > drivers/dax/bus.c benefit from a cleanup using these, so change these
> > where applicable.
> 
> Wait, why are you needing to call device_lock() at all here?  Why is dax
> special in needing this when no other subsystem requires it?
> 
> > 
> > Cc: Joao Martins <joao.m.martins@oracle.com>
> > Cc: Dan Williams <dan.j.williams@intel.com>
> > Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
> > ---
> >  drivers/dax/bus.c | 143 ++++++++++++++++++++++--------------------------------
> >  1 file changed, 59 insertions(+), 84 deletions(-)
> > 
> > diff --git a/drivers/dax/bus.c b/drivers/dax/bus.c
> > index 1ff1ab5fa105..6226de131d17 100644
> > --- a/drivers/dax/bus.c
> > +++ b/drivers/dax/bus.c
> > @@ -294,13 +294,10 @@ static ssize_t available_size_show(struct device *dev,
> >  		struct device_attribute *attr, char *buf)
> >  {
> >  	struct dax_region *dax_region = dev_get_drvdata(dev);
> > -	unsigned long long size;
> >  
> > -	device_lock(dev);
> > -	size = dax_region_avail_size(dax_region);
> > -	device_unlock(dev);
> > +	guard(device)(dev);
> 
> You have a valid device here, why are you locking it?  How can it go
> away?  And if it can, shouldn't you have a local lock for it, and not
> abuse the driver core lock?

Yes, this is a driver-core lock abuse written by someone who should have
known better. And yes, a local lock to protect the dax_region resource
tree should replace this. A new rwsem to synchronize all list walks
seems appropriate.

