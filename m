Return-Path: <linux-kernel+bounces-22507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18E99829EC5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 17:51:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817A41F22F54
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 16:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7A7F4CDFF;
	Wed, 10 Jan 2024 16:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R+QYt+5R"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE470482DC;
	Wed, 10 Jan 2024 16:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1704905494; x=1736441494;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=GQlXF/KbaRxCz/3T2QPcLjKwhqBdOi6wmxIQbLVfr3k=;
  b=R+QYt+5Rx3F63K6JSEAO4GcWZM/EupKgDzApweZAKKMZs3JqAiQJ4piY
   lZsLXngwf/AZDoznbS5f41uehV0APJwmcNTMssNTCEpRk3ZefU2lnGgcB
   d9Mj5Fvzv9tA89jEwzmJFk9Cn4gio6lNJM6wwTa0aSqEQIl1XjQMUh2EL
   DGVIu+J5bnIWALbVRU1UI9TFJLkBgEno58HJEJAbokEi/WVlm7HZGt8W8
   pRs4fdBkEyyTLEZs1zQ556I0MNXzoVzcsagPQoNB9j+vxc7cOCJbwjpEU
   rt+/kIOA2nFz6pD/4VJOZHvSOqD7mPmgBgCJZkKmI8Ae6aATAL28FM4YA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="402353389"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="402353389"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2024 08:51:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10949"; a="872700359"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="872700359"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Jan 2024 08:51:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Jan 2024 08:51:31 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Jan 2024 08:51:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Jan 2024 08:51:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=juAdExOG5pzC1PyO3GVBuRNaiq4/VmwFw/ZlhyWPiXpeJB3JvtWEM/TDxzq4n9NBBJ7OYlvFDDWI2N+/Sde42cqSB/FzJaFRKJWX5cE9a3fxuqvvHAwMbqR0vnsJp+6zuatO6so28BF39dEKYkbKc1KBV2OzZ521kHZmWQ993dCtZ0mFgM8JTdyyCZ+WSGlwzSZmAbmNj9SqKUeSaXN6t+3U65FJ9ltpAFp32o3TaB1Vqq7Aam3LhnANEMoHRNAeGtcGMGbjksuPzTKlQZ7V10awYEb+pV6CtSwSJohD8VVVfORpeavHNcY2p+/B5dEmmPWo52uv8Crzxn+b1uCWlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TV9impBd+TMnBjW/ECe25ufIJJPpOW5dg7yDKHdoYZM=;
 b=d1J7BANrpqT+LsHqeDhccHWykrqcOxIQNeYFkKhVMMd9wPm8FlZg3rZ31vWGzOiqyvSDKZxphN7dhQXmzGc4or8Q5INiXrD/LtMrzB42hUFp4Am0qQUzg2guLiXnTsZHVcqZevsT9lvaI/lsloa1GIfhGvMt1sHqrMiU+E+Bj/gvPf6DAFs3AupGnPTTvkOUjZvlm4FgiMjzBRcTo2jIvkPmwoG6eF8AK0AxXfaZD57twr5YDYPWqdb7KJUVTgT801OJploqOHGIVTXFcz0AahkNpke1/MYMs7NUpRe+ds2PFKZZKUfKTErLsTh0SPuXq3DWvZILVaEYKTpECZPv4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by IA0PR11MB7695.namprd11.prod.outlook.com (2603:10b6:208:400::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 16:51:28 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 16:51:28 +0000
Date: Wed, 10 Jan 2024 08:51:23 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Alison Schofield <alison.schofield@intel.com>, Ira Weiny
	<ira.weiny@intel.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Dave Jiang <dave.jiang@intel.com>, "Vishal
 Verma" <vishal.l.verma@intel.com>, Dan Williams <dan.j.williams@intel.com>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] cxl/pci: Skip irq features if irq's are not supported
Message-ID: <659ecb0b70b8f_a3379294e9@iweiny-mobl.notmuch>
References: <20240108-dont-fail-irq-v1-1-4407228debd2@intel.com>
 <ZZ3W5q4UzvLJ9kG+@aschofie-mobl2>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ZZ3W5q4UzvLJ9kG+@aschofie-mobl2>
X-ClientProxiedBy: BYAPR06CA0049.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::26) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|IA0PR11MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: de4f034e-7f37-4cc6-7956-08dc11fc63c8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2yTjwboNNd2wkPf4BTC5EAAcohxXmzCU5s8lVTmx9FZa/Bj220HUb2rVd7uU/ZaAUsG7PvfkFHBTYIxWmiM/PRErT5bmOiH+BEFRzVfzek8S1t8cBd7O4kaxx+DfCXuXtNNNFDM5v7DD1kYng4CAbJFG8GyD2B4TnvuNWm+564eSuIYH0YrxYNfWxzbRAQ72MajVk9Zjfm0e6EFnh7NJEujhrMux6XK6VKkiLF0R3Jbju1bmgq+5gtBk8+Osxj4Pe+Yqhpjw0FDvJGy/Ap4wcsphOhkT8pQSewySmknD/ZT3WNtbA+qm6X5D8F5/CbiZb/hERgYI5Kma0mDi0nD4nIoJvQcbGQSXlJ0AZb1VejkBM6zPm8q4w2ZkeCXW6MT+uQeNpW3zp4E9OSqHiFUlRpQ04MD42yarjA5Yx3/UctXyisbWLY35cXeIb6I/Pdo6oEDXJDg6cYbJ8NXtakI/h801h3EI2b259Xot4neTm3QB81khCzhUob0E/BSzN5D7xgkdFI+x+fbI6UwiZLvioPfyQS7bmX+hR0tUJQXvODzg7QWYQtcyAL0ytYFE804p
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(6506007)(9686003)(6486002)(478600001)(6666004)(6512007)(26005)(38100700002)(82960400001)(86362001)(2906002)(41300700001)(5660300002)(316002)(83380400001)(66946007)(54906003)(110136005)(4326008)(66556008)(66476007)(8676002)(8936002)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BNKr944r/v31aV3/Ahp1bFKRGETldpCY2iZsadsJ5zo3ULWcfPLU6WWPafCA?=
 =?us-ascii?Q?AwSoZqAIKM58AMBifNU34iB6KUKTATP9QSQsTvuFIFdLOFrNukQMkj8XvhPL?=
 =?us-ascii?Q?yiBLw0jF3iqyx72402OMFB7Cz6TrF9XlbfFNkZhCM12dXPFE/xVe+jFA+Mze?=
 =?us-ascii?Q?2pHxNZ0d7NTJQ1bhqiMQs+F5CUVMmoZytzoGYdDDpJC/IozJat2Md6+5Wbrz?=
 =?us-ascii?Q?F0//qE4r+lT5i7lLjXF8LfmazINyoO7MG8mPOPwIhu8oApRpij750W5KVGLW?=
 =?us-ascii?Q?BiJVMT6Oza1RLLE8zTje6YeWDEfFHmFshjQ4nBhwhNNiBuMHC/HfyGsD7mJr?=
 =?us-ascii?Q?P2mA612Vu1Thl0lSsT36dhKhDXdAbKD1frnVvQWIYISmGhF8rixFR6rogPtJ?=
 =?us-ascii?Q?RBFUE34UrjSXO3onlSE7GfnkX22pqZu5nUtXpibEE6XyDtJAe5poowuBoCqn?=
 =?us-ascii?Q?ROECLVpAY5f6edfxILqsIeDtIU75N4LEA3dpwUaR0dSovCeLnJJZClClVyg6?=
 =?us-ascii?Q?+xkXLRtQ+0DStCqhlbFqlljuZX6JXV28RPLDhpBdc2htXQpD1m70mIoJsPYR?=
 =?us-ascii?Q?+B1YswFoAT9UAaWk2EFvJh+cXvnYvXIZobjs7MZJeTw5hLDLoz11MxjJSBpx?=
 =?us-ascii?Q?GUIBcfYw+qVx6vjljn2R0HXEGkqj38CW7oGiwUAKAo77vos07bQrGVdXO489?=
 =?us-ascii?Q?0tu0lW+OMvnC+2e8cF9v3xRgDP6MeWIGS/h2XR0td14USyhvVf8aPPvLwRRF?=
 =?us-ascii?Q?9AqU6SjpuT3i9jFPgDdvwfOuB7+nOhocfXBGyexAA3N6amXFESJEmTcIFOgu?=
 =?us-ascii?Q?QqjGPuOg8BR5jxrw6N9m2WOzMtRv+GYurgPpnZtLdn2ekA3HzhgbSq/eXY8C?=
 =?us-ascii?Q?SrFLdJpRfCGD2MyeNi0bX/wiWFCaK2yM23q1fbaztNo5IpWrxGRggkNMPN2y?=
 =?us-ascii?Q?eyuIhYCfvVfWqoow5OGv4P/vNxLsPjquO5j0LuL2+Hlg/yALNXfn+GTsMYel?=
 =?us-ascii?Q?+vya4qFoHDfb/VqncdECNiYjpYoHDXMwhmJ0T9r9tEY+s9YWQbZk1gTUo8on?=
 =?us-ascii?Q?jHtKlikMXCfqAIVWbGr/NYDRqpW4HJe61FbudvXe0fA2G8vw5e1tOTazPPsx?=
 =?us-ascii?Q?f1BUNF7VkMOXRj1zL8l/gQS16CK21rSnwKERG+L7QbT3At1a8ZG/Wf0w/p7Z?=
 =?us-ascii?Q?uRgfSaI3BstK1SDmy/akajN2gdLnY23vqYjx0naN3eqm8fz2k4yKNRjsXemS?=
 =?us-ascii?Q?mgnFPotI0sEFkZXn8NsKt6dpEGAwPh92rD1YcY01BMKygO2RrqJO4Tqe5grk?=
 =?us-ascii?Q?Lp65Qz0eol+loYObwfzeqLceEhly3GhqjIR+HWWR52g671NbJ1w5mQz1AI/o?=
 =?us-ascii?Q?WBrmiWybWZKhj2BshXtfZtaa8LB/D6N3lQvHh46KtmhRsl3pxqLena9E0VRj?=
 =?us-ascii?Q?jjUlwtcQvTz/Rg9wXLSglctLknFP28qOdDaNh9KLfouSNGL1fS5fI1zNskej?=
 =?us-ascii?Q?BUsQnaXfSyiE+kqgRXQdSiXcxNMnTr1retS0uu7r9qF4o67dblM5aAPKCgFd?=
 =?us-ascii?Q?Vuucdu2VDGBOR0jMbdsPmtvXZ415TewEzI28pr1a?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de4f034e-7f37-4cc6-7956-08dc11fc63c8
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 16:51:28.5426
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dU259ULK+gZTIk6FrPbeZ84L3c4qsD6mUpWBODoP+FU9YSTSpX7A67VY0ojbZry88s3tObp/SO7Xrk4XOvYQPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7695
X-OriginatorOrg: intel.com

Alison Schofield wrote:
> On Mon, Jan 08, 2024 at 11:51:13PM -0800, Ira Weiny wrote:
> > CXL 3.1 Section 3.1.1 states:
> >  

[snip]

> >  /**
> > diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> > index 0155fb66b580..bb90ac011290 100644
> > --- a/drivers/cxl/pci.c
> > +++ b/drivers/cxl/pci.c
> > @@ -443,6 +443,12 @@ static int cxl_pci_setup_mailbox(struct cxl_memdev_state *mds)
> >  	if (!(cap & CXLDEV_MBOX_CAP_BG_CMD_IRQ))
> >  		return 0;
> >  
> > +	if (!cxlds->irq_supported) {
> > +		dev_err(cxlds->dev, "Mailbox interrupts enabled but device indicates no interrupt vectors supported.\n");
> > +		dev_err(cxlds->dev, "Skip mailbox iterrupt configuration.\n");
> > +		return 0;
> > +	}
> > +
> 
> Commit msg says dev_warn() yet here it is dev_err()
> 
> Can you fit in one msg, something like:
> 	"Device does not support mailbox interrupts\n"
> 
> Perhaps skip the hard stops. No other dev_*() in this file adds them.

Dan had comments on cleaning up the error messages.  I'll do those.

> Documentation/process/coding-style.rst
> 
> Spellcheck

Thanks.

[snip]

> >  
> >  static irqreturn_t cxl_event_thread(int irq, void *id)
> > @@ -754,6 +762,13 @@ static int cxl_event_config(struct pci_host_bridge *host_bridge,
> >  	if (!host_bridge->native_cxl_error)
> >  		return 0;
> >  
> > +	/* Polling not supported */
> 
> I understand this comment while reading it in the context of this patch.
> Lacking that context, maybe it deserves a bit more like you wrote in
> the commit log. Be clear that it's the driver that is not supporting
> polling, and when if or when the driver does add polling support they'll
> be an alternative method for processing events. IIUC  ;)

Yea I wanted to make it clear that polling is an option for the driver but
it was not supported because I don't anticipate the need.  But should a
device come along which requires polling (ie no irq support) it would be
nice to leave breadcrumbs...  but...

> 
> 
> > +	if (!mds->cxlds.irq_supported) {
> > +		dev_err(mds->cxlds.dev, "Host events enabled but device indicates no interrupt vectors supported.\n");
> > +		dev_err(mds->cxlds.dev, "Event polling is not supported, skip event processing.\n");

.. here I mention polling not supported which is redundant to the
comment.  Comment should be deleted.

> > +		return 0;
> > +	}
> 
> Similar to above

Yep will clean up based on Dan's feedback.

Thanks for the review!
Ira

[snip]

