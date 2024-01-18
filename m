Return-Path: <linux-kernel+bounces-30503-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 87821831F8D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:20:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8D121F295EF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF04C2E40F;
	Thu, 18 Jan 2024 19:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nIJ4OqcB"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1737A2E3FB
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605631; cv=fail; b=MFIzvrWd7bMCnTfZ83lkIzpZ5vyZNVUxDvC222rgftNE6KLN5iVrrv8LYxyKcQPu23z/C7BHGfUnWLdag9qt+ooCXENxbr4vfhbR8JQiaAEKsNZZaeriNy3QLCf/SPxKpFUeBm6CcJL6LbifjN0mXqVUlXkRqQNJHPopwcEFyWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605631; c=relaxed/simple;
	bh=F0Spcl4uLnE7OwpIqnod1/cIZpC1aM1DuIxAxU7Db4U=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=rOR4HpmiOF0CD5JnZr7B8K/oQM4KmHJl9vBXEZ+MGux1xl2yHGLJ/tCR21WLAnqqNtLHCWDBmvLCku9/TsXqduhe+sM4aWBTudmlwsYu3sr4uuu6QxEclHBbwHmhic7LfKwmoUdF2t3SfPDjpJplkHpNO9tYnT1Tf9RZa9Zsjbo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nIJ4OqcB; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705605631; x=1737141631;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=F0Spcl4uLnE7OwpIqnod1/cIZpC1aM1DuIxAxU7Db4U=;
  b=nIJ4OqcBxbEcCJ4fsrKjCEmp+mEKGDhqXAOiZq9iVjhmIg+dS3hlokNi
   o2Ot/7NWxQaSDqLLZf8epYT8oNj3+I6SCx3AnAnjXGXFbaUTDBa0A1kLk
   Ady3Mss8f4iuvC7BMGF9/h0SnU/DSW1EGGCPbtqG4P0FWqv6v+KEmaNfn
   2a8DtzyEhn2TEBCPWVz+66ei25S/QI6O2aOcl6jROHCRJDxXVZKlPpQy4
   4i0t5zLKsiMRgm5DWASrcuCM+cJl2vdUDv4cePV5xJWU9CTfD6Kjt5+uA
   P8D+RN9/a0j8pdqv6b8bOwc+rhWYUdNKO+RUipeUHP8uxZZgyHHefQhYX
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="451394"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="451394"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jan 2024 11:20:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="788172163"
X-IronPort-AV: E=Sophos;i="6.05,203,1701158400"; 
   d="scan'208";a="788172163"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 18 Jan 2024 11:20:29 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 11:20:28 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 11:20:28 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 11:20:28 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 11:20:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SbESlDqEfbH69eftYidlMXCtIC1EiU/zyRHrqaG9sIUgxwkT5QjZXp+U0k/VED/kia4hcpNCzfiCwuDHDR4637VdM9vuf6nK0vY4GnDaGzz2Hw1NEyibMxJpmKIDME0r/+Y847oTxNc1FJ0lal5awdu46RenjTB6g4qOCRZV71M8+b5rXpe3bl76jkTO5kTQXH4EUeloGDXQeMPOX3f7MDtIDg1HGqs6rIw9r5fBNLc5zSnQIetle+cmmQGGU8ZpGgqtGpNmVi0PhUIb5GBd4rs92zOU0bW5D1EHjstagdXB+FavGu3wzxvxZtkbDfE3rYb2XeeiXkN8RQHtPMK7PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pjTKlYQikrCv1mXywcxKmObJqN2DN3HiL++5+sYKO9g=;
 b=hp7mMkVycBhTm+TYQdnURlElWPrkP7r6N+VXa8SjXpeh66DHDQeQFUy9padWn4Ts/rE9neHBwbmFNw4T1eAx+T+n6ZZIlQi/Cbwgi4hw+Tv8qP+2D1Gu3OsHyWhXo+eJnDPc9yc4hceBiU0nFSG8yXRVWnmX1KUatajBCZYcmpjzP3wndjDj5hg6e5o20EKVHDLocRSky7xW/bCM9XeLLwWlQ4VifhrDQNARX4DhCBKNrzUOWr5i1FuJfqBQpaQ4NX5BbFekSpnERx7ukU8hOGmvp1DDWv/RPjs66B0m87FDl8DSt6/osrxIRbkbsoO/O5fartiN3r4PihAeglOchA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DS0PR11MB8133.namprd11.prod.outlook.com (2603:10b6:8:15b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:20:20 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7181.015; Thu, 18 Jan 2024
 19:20:20 +0000
Date: Thu, 18 Jan 2024 11:20:18 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Dionna Amalie Glaze <dionnaglaze@google.com>, <biao.lu@intel.com>
CC: <sameo@rivosinc.com>, <dan.j.williams@intel.com>,
	<linux-coco@lists.linux.dev>, <linux-kernel@vger.kernel.org>, Joerg Roedel
	<jroedel@suse.de>
Subject: Re: [RFC PATCH v1 0/4] tsm: Runtime measurement registers ABI
Message-ID: <65a979f25c180_37ad294b2@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240118033515.2293149-1-biao.lu@intel.com>
 <CAAH4kHb9-7p0z2xgmofiCVkOUgXdkJz89qLPc1DuG0F_Wf4-Tg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAH4kHb9-7p0z2xgmofiCVkOUgXdkJz89qLPc1DuG0F_Wf4-Tg@mail.gmail.com>
X-ClientProxiedBy: MW4PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:303:8d::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DS0PR11MB8133:EE_
X-MS-Office365-Filtering-Correlation-Id: 979b18ba-641a-4044-e30b-08dc185a82e5
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: k5IvVY1vRWxE6XFvDwWntVOZy3XxCfM6Dnjq9cJdrcwyWWJMrNnDsQP7WsCKnn+ftypmIREwDWgAnCPsSOCzNPjVgR8aTDDJWBkCcL4k+OcZoi/3kjXSuYxM2TV4Azv6BwOUNsHeGAxOz7cjXBp0GGsqF1l20ypZPQhZgm+tHz6UtYdu0GjRTkxf1ApseBUmzBq7qNvRpmJ5MNxxSBefwCV9JLdn6uhLMsgL65lm/iBOPUxRoD4ABZ7UblYB6EKKquHbLagQwKZi1gxoEYky9f0t4gpxP8+gULRBj3CgckW/Jb3WlaDN8FflmrydGoLNTJ55VgJdENWR2HqDBxiC0RNT4G+Wzpef/yH+BpUwjf9blJyAXxnHX1QGcpxk/DXULbaja0wQgSAKpy87nB5UpYgeV+PAFmlT/8br1D49qSor8mJYrMlac53dQwzxXLw9Dgmk47CdElkLSqunuz5UaUQdG+9gmU32UBK1YcKThip5cTrNjN9Nm6zEHg75jaeN9TyH7G1RkehmVyqzABhini6sRqB0F/0c1n9ylVxF/qbnbyHAQoEtz8THjXwxkNJw
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82960400001)(38100700002)(86362001)(83380400001)(26005)(316002)(8676002)(8936002)(6486002)(6506007)(66476007)(6512007)(9686003)(53546011)(478600001)(66556008)(6636002)(66946007)(41300700001)(4326008)(2906002)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZTdDOXNReTFqU1dzdUVCc1lyR2llMmF1cVNCYklFYURNZmlrZzEzWlhrUU5o?=
 =?utf-8?B?VlFzem5DdG5VWDFKMDRVbVl3MXdOR2E5aVI5R3haVVJqdERXKzNkVGIwbFho?=
 =?utf-8?B?dmVRNWFlTVZqQ3NJRDFpWXBlR2Y2SC9HanR5dVZUWm4vU2l4VUpxOW1hdmNr?=
 =?utf-8?B?VTJ0ZW9GMk1WRmtkbTRINyt5WGI4a0xpSmxVamxFNkl3OU5UMDFLb05pREFu?=
 =?utf-8?B?MUU4VXZnZ2RieUdLbFF6SmNUTTZOb2s3WlVNMWJCM2hqZmp6TktjeWl5ck5G?=
 =?utf-8?B?SUVWdFB6RUdUSm82NER3SmxnTHFUbG1aZnp5SVJUS3FCbkZzMG9tMkJ4TThk?=
 =?utf-8?B?QnZVQ200TWMrdjB1QjdZbVJRUWdZTVdZejQxWGFrbFlId3lReXRqVkF6WUVS?=
 =?utf-8?B?dmRMYWtTWmNwSjBVMmV6UU93WkNxTzNtU0hoZEhwQTB3aDZZQUJMaDVuSjh3?=
 =?utf-8?B?UlBkRTZ2bVpqRkloVXhBd0U2Y3RqbGZ6WW1jS2s3QXpNb0FRTkV3WS9oZThE?=
 =?utf-8?B?WW1KQ2dRbGs0SEppcTgvSElKS0NEU2Yrc1JTR0pHeGJEWXRwZFp2YjZxL09X?=
 =?utf-8?B?b0RycVZOV3JxWS9yYlpON042NWNvdlU0QUNZTmJmOGhYV0Q0SThhZFFSdW15?=
 =?utf-8?B?T3ZZdG05T3lZa2J0V3pjdERQR3YxMHU3NlNFYUJ0aVI5WVFlMmxFYkV4Tmxy?=
 =?utf-8?B?QTZEeERiS3Zid3FWR1M3NXZOdTRVaCtwa1J2QWtUeW91L29EZUFJY1ladVU4?=
 =?utf-8?B?TzM4Q0lhWlZVUlRKajM2clQzcVAvZHUyaEhtUHFlSENBc2RCWE1KN1hrOFdy?=
 =?utf-8?B?RWl2NVlRVytaYmlDVTgzL20zRHpvL2RDakZobUttVmxSYm9pZkFULzl4WCto?=
 =?utf-8?B?d05QaXIvaVl1WUgwL3dON29rcUlwemROeDNxSktsY1ZMZzYwbzlEQk9OdGZV?=
 =?utf-8?B?WGpxMWtQeWhBQmJoZm1JMzNyd2s1R2FTWXY5MHIrNjNMUUVoWTYyNXQ0WU0y?=
 =?utf-8?B?OUltNkl0amVkQVpic1BDbktxVjdqMzdVR09ua0FPM0FaMFR3SUZQdDZqdXVt?=
 =?utf-8?B?eVI3Rkl3Mnh4ckZvbnhNZ2NRTFVQN2NDbW1iTi8yTnNaMUNpUlo5R29OUFRV?=
 =?utf-8?B?UG9kQjF0QS9qa1MrZEo4VWlSTGNkVjlRVm9wd1NNRm9ianh1bkwzT3l6aXJo?=
 =?utf-8?B?M3ZKYXBrQkZBSWlJOElWYVdyeGRDamsySHgrTmM3MGdDRkY5dlk4eG5teUJQ?=
 =?utf-8?B?YlRYZHI5cC95SUdsem0rQld1SVhNZEFTaHd5SmpKM2d0dEtLUFF5SzdWckFV?=
 =?utf-8?B?RWREdzQ4YXkyQXBjREF6YzNlOGRlKy84TXdoK2Fmbzc2cXpCY2VJOUVGUEhQ?=
 =?utf-8?B?MUttR2xqWU56aXVsQWpxb3RqNFIvb1d4eDdacEExRHlUM3kvaUFXcHlqTlVZ?=
 =?utf-8?B?RnQyZUxWOHEvV2Jjc1BRVzBLeXBmNWNnekN2cmtKUDRKU28vSEJRVnN4cVo0?=
 =?utf-8?B?RzhDckEwazBqczB3UlJyclFPeGtiMzRMaU95Vk5PaCttSC9kSFE3clhTaWFU?=
 =?utf-8?B?Wml1ZkJaMk1HQ3Qxajc1M2w3TFQydFhIUmx2Z3A5UE1VRGVpbnRsUmJCbXlt?=
 =?utf-8?B?YllkdWNucWd3bTFJVWllODZmaWFnMXFodm5hNUdzL1M3bDY5WmdpY1ZzdUJC?=
 =?utf-8?B?cWwzRFAreGxkMjR2dUdDSk52VjRNcXNlaTdlbDNEK2VyTU9kOEhCUERrSE1W?=
 =?utf-8?B?ZUtmQWgvUHZYS3hRdWw4S2VSbTdlSjAvL1B1c296QmpKR3dOUHowSDR2dmVm?=
 =?utf-8?B?d29jVXB6QnRrdU1WZUIwTm1ZVHhEL3FUVU9iaWRlVHlhc01Fc2lrZXY4ZlFU?=
 =?utf-8?B?bG45aUF5dkpCSmlUNmRlenZtalF4VytlNklFRmhCYXJGb2pIOFZFRDI2dzhZ?=
 =?utf-8?B?VDhBUUZXSG1UVmdaUUNhdUI4enp4cjFuTldPbW5QYUQwVEE3SGlVMzJ6MGpD?=
 =?utf-8?B?eXZpK2pQRlU0d1dIcTYwS2FhNFJ1d0U4ZDd5NitpSHE1S3JsVFpianVjMk9L?=
 =?utf-8?B?Y2tHOGZmaWtTRU55WnNjYmF5R1JyaXFSM2lHQnpkanJaa29DS2VYdXdwamdN?=
 =?utf-8?B?cy82ODN0RCtzTFpSanE0SzQ1R01hd3VyM1p2SGhsMitLNEdEUzR6N1RweG1h?=
 =?utf-8?B?MEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 979b18ba-641a-4044-e30b-08dc185a82e5
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:20:20.3238
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QtJbgLJd5mqdAd7fYhOGXJL0qpOsldMBXKtBML+LYalJXOWOSPxDUpZWZvDvBkMaLeK3fCWxWsQd4oOXxwBkIINL+A9ypfZh22qgZ4Qqqr0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8133
X-OriginatorOrg: intel.com

Dionna Amalie Glaze wrote:
> On Wed, Jan 17, 2024 at 7:36 PM <biao.lu@intel.com> wrote:
> >
> > Samuel Ortiz wrote:
> > > Some confidential computing architectures (Intel TDX, ARM CCA, RISC-V
> > > CoVE) provide their guests with a set of measurements registers that can
> > > be extended at runtime, i.e. after the initial, host-initiated
> > > measurements of the TVM are finalized. Those runtime measurement
> > > registers (RTMR) are isolated from the host accessible ones but TSMs
> > > include them in their signed attestation reports.
> > >
> > > All architectures supporting RTMRs expose a similar interface to their
> > > TVMs: An extension command/call that takes a measurement value and an
> > > RTMR index to extend it with, and a readback command for reading an RTMR
> > > value back (taking an RTMR index as an argument as well). This patch series
> > > builds an architecture agnostic, configfs-based ABI for userspace to extend
> > > and read RTMR values back. It extends the current TSM ops structure and
> > > each confidential computing architecture can implement this extension to
> > > provide RTMR support.
> >
> > Hi, Samuel
> > The ABI does not include eventlog, but eventlog is usually used with RTMR.
> > What do you think about how to implement eventlog?
> >
> >
> 
> I had the same question and deleted my reply. The event log in TPM is
> made available in sysfs only up to the point that control transitions
> to user space. After that, all extensions to PCRs have to be logged by
> user space with whatever chosen workload event log representation. I
> imagine the same is true for RTMRs.
> 
> What this patch series doesn't take into account is how RTMRs might
> not be represented in the hardware attestation, but rather would be in
> a supervisor service whose integrity is chained from hardware
> attestation. In the configfs-tsm model, tsm/report with its single
> provider requirement will not be able to interface with the SVSM
> attestation protocol /and/ the AMD hardware protocol. That may as well
> be okay, but that's a choice folks need to be aware of. There's still
> the issue of attesting a single service vs attesting all services in
> the SVSM. I imagine single service attestation will have to be
> abandoned.
> 
> In SVSM, a vTPM is a service that an updated linux driver will be able
> to get a quote from, and the same AMD SEV-SNP attestation report TSM
> provider would still be present, but if we want a simpler RTMR
> service, then we're in a little pickle with this design.

There is a good chance I am misunderstanding the concern, but I would
say yes, the vTPM that would be layered on top of RTMRs is independent
of the SVSM vTPM effort. For an architecture without RTMRs, vTPM via
SVSM is likely the only choice, and for architectures with RTMRs an SVSM
indepdendent vTPM is possible. For the kernel it already has a
vtpm_proxy driver that could be put to use here, and that would be
independent of the eventual SVSM vTPM driver.

I am using "SVSM" above with the model of a layer providing services to
an unenlightened TVM in mind. In contrast, this RTMR model requires some
TVM enlightenment to setup vtpm_proxy on top of this cross-architecture
building block.

