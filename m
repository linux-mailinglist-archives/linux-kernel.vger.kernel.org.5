Return-Path: <linux-kernel+bounces-59972-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EF784FE07
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:58:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 23BCB1F238D9
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 20:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE91FBF3;
	Fri,  9 Feb 2024 20:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GR59OxEP"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE4EDF63;
	Fri,  9 Feb 2024 20:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707512304; cv=fail; b=dsJxgWqYiHznVjLKwskHpnU+H5Qpavv1ZFJbmz8KTFYrs8CGOQcDT/Aae3GoPucWsLkL9BNBzi9MLwkYJCS6a8dYNAiRR8lKZR62crQ+HoXlY9/8BTxBL17CNioPLER8kF97wG2XEqf6Hw/7hbvXeb2WNRMimwPQUhvpIUVHtC0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707512304; c=relaxed/simple;
	bh=7l3yCLojRhYlK08XCP0TGsXX/tTt3jQJSwzfBfSuR70=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=C7wFX33HfS2QFaZyITM2L79T8jDw0Zg68fseK3eNASxlt8oidk1sZcDnpGuLla2W31Qe7sEdZ3atDo9q2dLJcCb4sBXwRotphQ3xmwS2f35tso8DEIfUQCKKD47wUbVPg+IGzbAHphwkRX7XHTNnaUczTq5ZUZX/fgWwBiu1dr4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GR59OxEP; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707512303; x=1739048303;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=7l3yCLojRhYlK08XCP0TGsXX/tTt3jQJSwzfBfSuR70=;
  b=GR59OxEP9FAKDTcCerc/+WyoNIJ+lbNnNGuvMPf1+SIaTD0CVnWvLdC7
   nk9vZKpxR72Hz8CxPJa+SU8vn8DJJ23lkOdOi9fYq8fXngcnXh4EjmawT
   4cTMeLuV3FQsAgBNssTaOMH0lJGlFic1nWtbQ52K5RmawjRDM3VxH4sLQ
   isncUUV8sJjK36rBW/xocTrzlDVF57ZFxaoFmeppEQ41nJt+6neNaDUxY
   QhQC2CQvwOyW+JnV/mVfWGM5TaDpYnnwnbJWFBBb5IPNaxBQhkvcgbxJc
   WTEudajyr8tGHkCeCxQGVKfnre3j2S3Gn/NdZAnyBIKuwVeL6dmk/VuZa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="1380642"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="1380642"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 12:58:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="6680542"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 12:58:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:58:21 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 12:58:20 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 12:58:20 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 12:58:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dvtmaTpUzWGttXGeWqA7UFsLtybco3Co2OEtKuXt8iJ/YF97GNTw3l5gA39Pw7Ur1yAv19xgI4VDBHSG7wqeUSuh61lyUDzcwXN2gZgzQKY/ZFG/UIoTssygLGKMV0qIXCFIFBVWbEvctbVPk2BxjJwy3qtkLFSCR2UEM+/XJExg1xpqxYfe/A/p/MVz2fjiXCwEKu12+m0NXiSEIIbWLqayBzNHwY5MvNWhEZVDibMARoaecLOTFg/OZvI5vt0PPG1+RGUGyA61WT3faaVmjGQftJIyrco4mDqm8ImQ0O0G5zPVmySeCKTmf3p0WemPGpNyf1sMVNMv3z4o8u0Rhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8i/RpuroYJNanEztSCQCdSIhHWFSwSNIVM0Xff/dqZc=;
 b=nIolEBk+lcALfg7A1eMeW30Dz9aoU3eoMN6BhmTrs17/OYGTUn8ZKyKmAhO5eB9S6D+BHWaDmw8ds+n195aK/YxUR6324wXGEcGG1LGCpRiUAq9Vojw5IlxNOabzD1C1OUzuRZBub6pN31IySyjfNtDX9kUUOYU+vQGN67D0VGj2t6JOhnVDPMe3GyMM8IvfhResz7FH/K2O03uby/Ub22TRV3YA0FTn4zXKhWsN2WfxZjqsdAskByb8ulHjLMRZBeYdJ3fQ7ChwqBehLeT18aejeqi0J9kKolpc105u5VlHuF3sQM76BMWdVEc9DphTeGZ4MYVJZcc8LmRbzniANg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Fri, 9 Feb
 2024 20:58:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7270.024; Fri, 9 Feb 2024
 20:58:12 +0000
Date: Fri, 9 Feb 2024 12:58:09 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: James Bottomley <James.Bottomley@hansenpartnership.com>, "Kuppuswamy
 Sathyanarayanan" <sathyanarayanan.kuppuswamy@linux.intel.com>, "Xing, Cedric"
	<cedric.xing@intel.com>, Dan Williams <dan.j.williams@intel.com>, "Dan
 Middleton" <dan.middleton@linux.intel.com>, Samuel Ortiz <sameo@rivosinc.com>
CC: Qinkun Bao <qinkun@google.com>, "Yao, Jiewen" <jiewen.yao@intel.com>,
	Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-integrity@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65c691e13a50d_afa42948a@dwillia2-xfh.jf.intel.com.notmuch>
References: <a255bc36-2438-41b7-b304-bcf7a6628bef@linux.intel.com>
 <42e14f74d3819c95fdb97cd2e9b2829dcb1b1563.camel@HansenPartnership.com>
 <1557f98a-3d52-4a02-992b-4401c7c85dd7@linux.intel.com>
 <85b7a4a679eada1d17b311bf004c2d9e18ab5cd3.camel@HansenPartnership.com>
 <b8140cc8-a56b-40f6-a593-7be49db14c77@intel.com>
 <fe1722c3618a8216cb53b8fd3f1b7cbb6fdff5a0.camel@HansenPartnership.com>
 <65c2e4aa54a0_d4122947f@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <22088ed3-51a4-415f-932c-db84c92a2812@intel.com>
 <527da630-4952-4b1d-80c0-5a87997ff9fd@linux.intel.com>
 <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <332775d7218843d6cc168c963d76e6841eab5d5b.camel@HansenPartnership.com>
X-ClientProxiedBy: MW4PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:303:b7::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB8428:EE_
X-MS-Office365-Filtering-Correlation-Id: 790fc770-f369-4921-9eba-08dc29b1d3a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UeXN9FAon+H+hsftcbu6gJP1iPsOeC+GkIs8De3wfCk1qorgrUbK1dm4KxBupBNDYG79Q3V0cy4aZ01uoqZ4eeBkL9ggen5mEkgHSX8v8qRiIukKyV++z4QrqSV4268yL3dL5GOp9sIPlU8fQMa0q9NLTw8m6DrtU3fafZPTCoRMPwkLMCG56dK3um5/bkxzXAJ7EfIsa/9BuROX/bTvrXHnWkarahvebMcfVaNxk4dZP9ugkPdhvF21aHIMnyWv72AmkPoQxmhpt/OZEV3lR4aCiCxPRuhjFnExfPuJ8DB7uKAkkNo62cGgr4UnAqNFw0DGbo5jwi+64/DwoYD1/HWP9zrev77WKyygVCue10lmnGm0/nrCTZadZcM9Or0wzGib8noH7Ikqny/fsFA6/Zbv+/di9KunpD0ryOYKKe2Fm/JimkMT/D+Uvpfu6lwWS48foFk6rcE6DB9jNLmRFxZug4qimWaucwJhxW2EnKs+vEW0Dj/W+xmoH4JqSl6MD4i1IS43v2vHz81sHkbs6wIFOnIiSn0f9DEuKQ2DiBGWV/8DsYUGYqyD+K3EsNtr
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(396003)(346002)(136003)(376002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(41300700001)(6666004)(6512007)(6486002)(6506007)(478600001)(53546011)(26005)(9686003)(83380400001)(5660300002)(66556008)(38100700002)(110136005)(54906003)(66476007)(316002)(4326008)(8936002)(8676002)(82960400001)(66946007)(2906002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?9Afovn+I3jsRmE6YpiBe60UZVqAKeITviKerVasj1unBkfu4hYPKnayAry?=
 =?iso-8859-1?Q?pj1NU4zvbGcQMbCPUepd6Z9YlpjPR6O0Zs8l8lAJYYlV43RIL31PbT6Aup?=
 =?iso-8859-1?Q?fnRRkQ1kpbUunNA/visb86H1I5UGkDCM1HHJ0neB7KFeKSA6n1jUs9x1cw?=
 =?iso-8859-1?Q?jxQvtfUJ/CeCl5Gv5MGgdhzeywj206Tts2JBQmXpq9jHn+S0IHkm6y4iE+?=
 =?iso-8859-1?Q?g4r9jMG3bKrtDu0EOl1hzFu+YZ+H1l9zULtQqhhyajxIrD3WKebp38Wkoo?=
 =?iso-8859-1?Q?XlPUkonntwNaeWQ/rgJH4XSx2D4eBeFJKnB38nwwy6rosVUpai98K8h59o?=
 =?iso-8859-1?Q?wBxQlJoAbJSUMI/UQTyP+pL3ELR+t+Q31jEE7zrV4i7tk7otdYuWHSSewR?=
 =?iso-8859-1?Q?n4p2iN/73Re6jI14vOt42G4xPvTxydM5eHqUXG0AshLm75cGZh8kkUGLEO?=
 =?iso-8859-1?Q?9xAcqONwa1K6hFKjyOT+OX29Vo5n3J870EWqcInqOI2ParK2UgEeosHMCa?=
 =?iso-8859-1?Q?qNDSM31Yxj5Cm/I7O7d3yOy61y18Xu7uogPh3PYKrvXjxSklhBXP8myD6l?=
 =?iso-8859-1?Q?/ZzKAlAI2cktNzLOBXBC9c3AT1XwW+SHxeUQHHW7PAkSme+jQGkJkbvRbr?=
 =?iso-8859-1?Q?3f7mZdPnz8Ss6RcLKjtP/Rgq37Dj/KnIM6IulkNoBuypi7DK29nPxjtmls?=
 =?iso-8859-1?Q?f2ke5ix3JRSdfnKjH+bytPIk+hR4uk2Z9DqNdbzalS1dipobb/R72q++M6?=
 =?iso-8859-1?Q?snL0tJgF8VWTVFWvUVvzNMSJZkbaZ6l5EKDr8nrBo0EFqDcAxIAD+a9ZXR?=
 =?iso-8859-1?Q?DAXDAJ88yqDf4fRqqjxr06vkOwEXUdo25j8MHXwWd7u5CdmGpCglh1kMY6?=
 =?iso-8859-1?Q?k/uk62z8whQKA/lvG3Qa/uRl5oEoDAdaL2rVvlJX1cN/UfIWjOXUZuVLiz?=
 =?iso-8859-1?Q?5/qlWu7BDs/HM/nEEICSR5h0kMXJEn7WdMN7UqfbFSrdFMswxyPevNoiiW?=
 =?iso-8859-1?Q?cj6KRXIcOKVbnM+xJg9q61SCEQobng8RR0DzGhDZixpxRh1g5MJyBRti8W?=
 =?iso-8859-1?Q?DXt1ehkb3d7Gc17bxTSoKSh9Wf0VxqLL8gmX+9aDw3u3oMSPCIRLkBDUwZ?=
 =?iso-8859-1?Q?yVEh0LEjDRR/q5o3ApA8/7ykQsA/7DXhkyVmWtGhJfd/s2EjNn3CbgS4ym?=
 =?iso-8859-1?Q?D6B3jKb8sfGzJCEhgUsU+HZU8JHeZ5DqAifa3BzhJsT7wArX7g81IsF/LC?=
 =?iso-8859-1?Q?I5URyL1jIyeVO2GQ2brkuociDmi9nfbhQCz7Vg/7ldDzuGO+GnmWH/w7m/?=
 =?iso-8859-1?Q?ovH1+3bMXCFWI2uRyLX9iV7NJJIorYLbSRRPlx31dtDaifytcjrGiEt9BP?=
 =?iso-8859-1?Q?mzkQghftp3w39aWIOgHonqjLzT00n1QaoniEhf5StSLyRSgNgJ7YUVmN0w?=
 =?iso-8859-1?Q?lT4NqHXD3vMamjpx2ZLnQQ5fsoT8FNrKUcwZZ1e0VUUJvDzWfEBmiNiAgH?=
 =?iso-8859-1?Q?5zzLdintf0a1urIUSOw+sNMX15yyDZJFOIklGxTeHHiK3yZeTSHl5dlZ7G?=
 =?iso-8859-1?Q?yAE5pjjq53Sa6wKgrrQvFbj0SbjstmgniMQnSaBYXFxTsQKcgJ58a8wfdP?=
 =?iso-8859-1?Q?P+g2/dAi5V85vrwjB41M0+dcBUhKWqZsNL/L23siGH/phcjV7892iC1A?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 790fc770-f369-4921-9eba-08dc29b1d3a0
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 20:58:11.7714
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gU07aZeq4u7amzvbAJZlBduNZR0d7nQJUJs//Y6WW3ouUCD4H91VGKvKsbNuX0BfPQCLGHeuU/EvCZwFAJJyq3fv+VWWes8ix0MeV1A8Q/4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8428
X-OriginatorOrg: intel.com

James Bottomley wrote:
> On Wed, 2024-02-07 at 13:08 -0800, Kuppuswamy Sathyanarayanan wrote:
> > 
> > On 2/7/24 12:16 PM, Xing, Cedric wrote:
> > > On 2/6/2024 6:02 PM, Dan Williams wrote:
> > > > James Bottomley wrote:
> > > > > There isn't really anything more complex about an interface
> > > > > that takes a log entry, and does the record an extend, than an
> > > > > interface which takes a PCR extension value.  So best practice
> > > > > would say that you should create the ABI that you can't get
> > > > > wrong (log and record) rather than creating one that causes
> > > > > additional problems for userspace.
> > > > 
> > > > Agree, there's no need for the kernel to leave deliberately
> > > > pointy edges for userspace to trip over.
> > > > 
> > > > Cedric, almost every time we, kernel community, build an
> > > > interface where userspace says "trust us, we know what we are
> > > > doing" it inevitably results later in "whoops, turns out it would
> > > > have helped if the kernel enforced structure here". So the log
> > > > ABI adds that structure for the primary use cases.
> > > 
> > > Dan, I agree with your statement generally. But with the precedent
> > > of TPM module not maintaining a log, I just wonder if the addition
> > > of log would cause problems or force more changes to existing
> > > usages than necessary. For example, IMA has its own log and if
> > > changed to use RTMR, how would those 2 logs interoperate? We would
> > > also need to decide on a log format that can accommodate all
> > > applications.
> > 
> > 
> > IIUC, CC event logging in firmware uses TCG2 format. Since IMA
> > internally uses TPM calls, I assume it also uses the TCG2 format. I
> > think we can follow the same format for RTMR extension.
> 
> Just to correct this: IMA uses its own log format, but I think this was
> a mistake long ago and the new log should use TCG2 format so all the
> tools know how to parse it.

Is this a chance to nudge IMA towards a standard log format? In other
words, one of the goals alongside userspace consumers of the RTMR log
would be for IMA to support it as well as an alternate in-kernel backend
next to TPM. IMA-over-TPM continues with its current format,
IMA-over-RTMR internally unifies with the log format that is shared with
RTMR-user-ABI.

..but be warned the above is a comment from someone who knows nothing
about IMA internals, just reacting to the comment.


> > I am wondering where will the event log be stored? Is it in the
> > log_area region of CCEL table?
> 
> IMA stores its log in kernel memory and makes it visible in securityfs
> (in the smae place as the measured boot log).  Since this interface is
> using configfs, that's where I'd make the log visible.
> 
> Just to add a note about how UEFI works: the measured boot log is
> effectively copied into kernel memory because the UEFI memory it once
> occupied is freed after exit boot services, so no UEFI interface will
> suffice for the log location.
> 
> I'd make the file exporting it root owned but probably readable by only
> the people who can also extend it (presumably enforced by group?). 

I assume EFI copying into kernel memory is ok because that log has a
limited number of entries. If this RTMR log gets large I assume it needs
some way cull entries that have been moved to storage. Maybe this is a
problem IMA has already solved.

