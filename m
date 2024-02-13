Return-Path: <linux-kernel+bounces-63505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B873F853081
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 13:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3101F28CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 12:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640823AC0F;
	Tue, 13 Feb 2024 12:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="nXqEdwEt"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2067.outbound.protection.outlook.com [40.107.244.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701731FB2;
	Tue, 13 Feb 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707827435; cv=fail; b=Kp86DjO6EVwXnW0wUDoyKvfM4Bevs4bc8fYF3CABrG3fNV1DusCbJHYj/YE1tnn2S8ZGvrQhORbwckt1KqxagWPa1pY+Gt3PfuSgzEEh1OFQFlYrZKa3IzuU0EMEtU9kS04vWe24Mn0nq0/b/I3ULxCQUarisfA/LNa5HZ2AFGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707827435; c=relaxed/simple;
	bh=xKo+AdG5Am7xzt6epzA5VQ1oUMgKYnZwyRxXqN5SVt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CFL8K08+TuzezBCq5v0TPO8HPNseQxQIghQgRZTO4xUXz3kCGYf/nzwoULsDE1KN6RbdhoDwgnmYQtKJ4gXA/ZZvcU0I+vEzYGSCffAVbVnpvvWiEhWyc/71bpBdHkyqI6LvgHVPC0T461RlizPxNgJf0a+LbvK2p3HxdDWAfAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=nXqEdwEt; arc=fail smtp.client-ip=40.107.244.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1HA7N3/tLULZic4viM5wwEZ2mcGyEKhTFVlSONydephQZ0Sn/YBGLDzxEJFDj1BP8z9ag1MJZ903EqXy+XbLUYY6PPntNdZ8TmKvQCQFLpHwAN9SymGbKGHBUMe26rL7xc1v9bxamFZesclit2tIFiNxMsGaCa5Ay4EZSnh88jXkptE3dAWMn27e58jrv2uV6V5JHMA4pldtPo1OUDjdJhHFGX57QsyKRUNk6fqgIdoOr3uxbCZ2Vcxyc48K+wHGfiQSwGfklJkdD0x+3tq6w0NPNkeiH42QOW/Avo1RHKoT6+omKFK0l33NKTfCFfPqGHsHqmWzIRjHPtpmV+ZBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KZ7Sf02XGEv7XaMz6jGimGp8y8fkhX3A5Bztca3Z/NM=;
 b=O/+WEEbCInZobnNaw+SGeYlgnn7Chlc1jEGuUpHil+55nbrElfTLfYKLHGIVepL7jIFPm6zxW9B4vB3N0DKafTEA+kmJOuXO5hcHTdiD+W2Vx3JL1bqrK4xg3RAcuYzvLynkWvIgUvtZf0XOCtVYwzng4UclolZuDJnkjnuRivfrv+zaRaScOuWbcF+qmdJDwzjD/MAGvFRURqDYhjWmP/agFL8/JNSn4+0tR+NmmG+OBddfJ07o65XKiJBR3utyG6qhbi4HsyF8FvnLk2E3ckTBYUmW/qzMyHtcT+7RxeZLunOctgYQN+PqNzDiaJWyA2MrWxy7YF60dzvp69xR8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KZ7Sf02XGEv7XaMz6jGimGp8y8fkhX3A5Bztca3Z/NM=;
 b=nXqEdwEt8iDo6t4eI6ifTUdGHo+gUNmM4Co2hDJYOrL3Gl86F7VUoL/9QBWP7dw6uSYH2MlOXt5wwCkIT5Ueq6GLaNm9EgrS6nnBhHjwQkG9HYPrdMdab965vTi9ueZaR0wRtFRxWg+jfG2kRC10q+ngUHSuFRv1xYOLfMrOsn0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8750.namprd12.prod.outlook.com (2603:10b6:930:be::18)
 by SJ1PR12MB6315.namprd12.prod.outlook.com (2603:10b6:a03:456::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.25; Tue, 13 Feb
 2024 12:30:29 +0000
Received: from CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958]) by CYYPR12MB8750.namprd12.prod.outlook.com
 ([fe80::9d:17f1:8b3b:1958%4]) with mapi id 15.20.7292.022; Tue, 13 Feb 2024
 12:30:29 +0000
Date: Tue, 13 Feb 2024 13:30:24 +0100
From: Robert Richter <rrichter@amd.com>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Ira Weiny <ira.weiny@intel.com>, linux-cxl@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cxl/pci: Fix disabling CXL memory for zero-based
 addressing
Message-ID: <Zctg4Lx_y_hbChUW@rric.localdomain>
References: <20240209193451.163564-1-rrichter@amd.com>
 <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65c68969903b1_afa429460@dwillia2-xfh.jf.intel.com.notmuch>
X-ClientProxiedBy: FR3P281CA0009.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::8) To CYYPR12MB8750.namprd12.prod.outlook.com
 (2603:10b6:930:be::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8750:EE_|SJ1PR12MB6315:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b94c4b3-4cbe-4c27-c6c6-08dc2c8f9054
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	14cbifhFSQ12XtHB2Hcig6gZ2uWy/0MOs6xaGuOfk3W+cPMWTglEFMg/80xHQKB/73oqa1RqfDxntkNkU/Pt+SabMpoAETPdnE+MnfrmNgE3KO4d9FVDwNNDASqqXBcifTE1f/aT/Jtc6xxyGYkC+6zyl7ZZ+ytGi690rc5X9Z9VG8scFw1ngEvCWILt2CzSzNU2A7kkbHKYHe6GZ01X7RsUkI1iV2hPzLnKHvqXH00hcR8nrA98Tbgarv7n9cn+1B4RxzpLKs8mP5gtyh4so7oHWYZ1oGGDh9TJDsGKiuAvzsgMPuBtEX5aftdMV8uXngqjpqu7Ggy8DpkWjZa7a0ccyxjI4k2euUhdasbW9k8NqoK5f30vt9ajpocJr+lIACEyKJ7zPGVwkfT6Itp19y7Y+sEBQoSC7fpOiTViqDve6Y238wO3IUKN3rzZk8GDtnt4jhFnZ9rFjocM487PtxNVKbc3keDMKIsmaHD8yPhII1c9tdAXuxtAPoHD+21lxbaMN4fHlVqLsw4YDOiXsu2FrKSj51ZIZhsb8eBrMROYvwvnmNFoUevlniWyIEqW
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYYPR12MB8750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(136003)(39860400002)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(6486002)(9686003)(6512007)(478600001)(41300700001)(8676002)(4326008)(8936002)(2906002)(5660300002)(6506007)(53546011)(6666004)(6916009)(316002)(54906003)(66556008)(66946007)(66476007)(83380400001)(26005)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?vtJRLDTXdhC3OioZbuexmv/zyhb8z06nQ6pVd12YSp9UdJVf5PGFwdkOhIXQ?=
 =?us-ascii?Q?H00ZrZsh3D7rO4X3iTzyCyCCobpYxSwaOuKgtjHD+iqx8A9F6NKethY1OymR?=
 =?us-ascii?Q?AY6DVTIIRO0dB7XsStAoo5LXoBh1h7qQNH1mFT38tZjPrmYb3dHhJ6BiSDXx?=
 =?us-ascii?Q?6N5kLGImwIYU0lXHjbSqqj3jFhHx4pwqRcIdVJV6lVZviLcC73k0Qxd8Up8W?=
 =?us-ascii?Q?CohX/0LNlgHaNiwtjH6KWMlYrB8dsfKRM/w/RguX8k6XMw3j5KkE4WQ1bKrY?=
 =?us-ascii?Q?UjJNaub1VF6jkumV2Ja/fU4696NgOF+iAIoT5SJL+E0lk3fEVqKf984YchPR?=
 =?us-ascii?Q?LmzaYiSbeaFcGNPwPuMtbeT9m1lH2DeX6JhZE459mtQTjVOJsMNu6+zemIJH?=
 =?us-ascii?Q?PFswPGHid0Uy/QXFmkQ91yE77GULBbJ7vM6ncPS2lRwzRhbSYb5Aq+BX9S5s?=
 =?us-ascii?Q?0lPIBgiCHb6m28wJdlMI/wDnx1ajdwJxWrHrpSvRVg7KLgUALLxHk070UjlM?=
 =?us-ascii?Q?9Wb55RExMJsYkuy283rcadSmYwaS2HUZ7QRKGGBeXerID3Zby1E/uSfDQKJf?=
 =?us-ascii?Q?Pb9x5Jvp0avGoURIHV9KNCu6c9MX87CLwQMC9grP7p6cx79jTn1QynYlkTFB?=
 =?us-ascii?Q?gGz1f88GEROg9M2pXtrDoUG/b6NfcVsMLlxFboBHewDl91oXQyqnYLdoQTBP?=
 =?us-ascii?Q?62RY4Yr4oc/5mZYC5aLomqPr6RNptBLEumdkRbTMiu3OY9kFEkZ9UAdToFcu?=
 =?us-ascii?Q?g5WYztrNzPVfsA8uFC8H2fj6udTFMXF8vqIi75vAROQWlnVZju4XzuenMjyc?=
 =?us-ascii?Q?tPAgroTnAR2H+cdj99cx0BDX9KwapWyQQVSC3I4pivhx0urezcwIiuMpMt5l?=
 =?us-ascii?Q?sCsZ0GC0RtbHWj8EtXgrQe6NhK6bJ0UPzH+9iXKNj8Vwfhn8QXkjt0ctzmYj?=
 =?us-ascii?Q?gApMiL602H86Swhcp7KrA2iQzHUorwGT4MuMnw//9AMzuGFn4ZwAFFdU+/dS?=
 =?us-ascii?Q?RMbTd9BFZuFT9TeVUscMR5e4djLQsHtVwdqpBhGPB3DVz8ddlvt9eXIV/Izv?=
 =?us-ascii?Q?b7SmZPLq1zl+U0shkGTPzlueyabUoWoVzHTwh9fmxSNpk6Zm7zTp1jE3Gk4G?=
 =?us-ascii?Q?oLjclyvEPGGG5OxQ0cNfH2bn3Xu2mSyMzRpsCWLShc05MtBrDYuZPCjNn92K?=
 =?us-ascii?Q?BhOtWZxp/+RfU0GTnuM6qVunVpllzlm0F+JB27QeRg6bsiatk3Ca5vt7qvhi?=
 =?us-ascii?Q?oBGh6wAXJkaOejT+xeLKOT/9h2ZO9K4+n4eb0phLJDOYUBmjsyG30D0BLLEi?=
 =?us-ascii?Q?9RvSlj8TThIyXbhDBmc1rE43D5Yp12EBvmlTh8XxCfGXyIPeduNBRo/kuZkj?=
 =?us-ascii?Q?KclIVBy3gysW3oZi69+LpvxuemxZpf+DdXiquLIHZGG/HirZfK3UIFczTsX1?=
 =?us-ascii?Q?gxbpyK26XwljavWXN6AuajCpgF3dpD98I8CibkOAgrvk1pkhj9PQE8GW2Wb9?=
 =?us-ascii?Q?JQ22/6AI3sWZ+fO1JpKA2pNrfe7xkOHn3y2rKSHmWmPaBT9oC+pe0wwGHVG8?=
 =?us-ascii?Q?ezrHCl5GLHbpAkCLNTobz6SL43NNfgFTMxWNfPMo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b94c4b3-4cbe-4c27-c6c6-08dc2c8f9054
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2024 12:30:29.5925
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9XsgxxJ4cncVeIm0pFVpYjdEg8puqd04NTpvOj4M/vZj0Yp0quleAyHlRvrbNiPEnEOzCQC/xfDBDcCP1ZLXTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6315

Dan,

On 09.02.24 12:22:01, Dan Williams wrote:
> Robert Richter wrote:

> > diff --git a/drivers/cxl/core/pci.c b/drivers/cxl/core/pci.c
> > index 569354a5536f..3a36a2f0c94f 100644
> > --- a/drivers/cxl/core/pci.c
> > +++ b/drivers/cxl/core/pci.c
> > @@ -466,6 +466,18 @@ int cxl_hdm_decode_init(struct cxl_dev_state *cxlds, struct cxl_hdm *cxlhdm,
> >  	for (i = 0, allowed = 0; info->mem_enabled && i < info->ranges; i++) {
> >  		struct device *cxld_dev;
> >  
> > +		/*
> > +		 * Handle zero-based hardware addresses
> > +		 */
> > +		if (!info->dvsec_range[i].start &&
> > +		    info->dvsec_range[i].end != CXL_RESOURCE_NONE &&
> > +		    info->dvsec_range[i].end) {
> > +			dev_dbg(dev, "Zero-based hardware range found [%#llx - %#llx]\n",
> > +				info->dvsec_range[i].start, info->dvsec_range[i].end);
> > +			allowed++;
> > +			continue;
> > +		}
> > +
> 
> I am not comfortable with this. It should be checking a platform
> specific quirk, or similar for the possibility of HPA != SPA. The
> entirety of the Linux CXL subsystem is built on the assumption that HPA
> == SPA, and if a platform wants to inject an offset between those Linux
> needs some way to enumerate that it is running in that new world. Yes,
> nothing in the CXL specification precludes HPA != SPA, but Linux has
> long since shipped the opposite assumption.

this check prevents the memory from disabling an enabled decoder. So it
just keeps everything as it comes out of firmware.

Can you explain the motivation why active memory is disabled? This may
take system memory offline and could lead to a kernel hang. The same
could happen if the CEDT is broken or just missing (it is not
mandatory for 1.1). Such systems just die when booting. So the check
to take memory offline should be changed in a way that it will be safe
to disable it.

A platform check would fix that only for certain systems.

Thanks,

-Robert

