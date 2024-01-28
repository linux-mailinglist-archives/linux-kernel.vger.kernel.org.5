Return-Path: <linux-kernel+bounces-41893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0128983F93D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 19:53:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 269D71C21460
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 18:53:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654942E856;
	Sun, 28 Jan 2024 18:53:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeggzBRz"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AB12E62A;
	Sun, 28 Jan 2024 18:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706468029; cv=fail; b=WSMB2KXCCNKmdATU0fUkvZSAl+h8/YVfdFVCl0WqH/be3Kz46ft8uRBD7un/NHfRLYBJDzVEGYd4QI/p3eUZx4vnrqBmKPVQ2e2Phr5WtvKp94nzFpu9nAeCd/nQ1GVMcqoxGQAregQQI1sg7zveMlKd9ViFSoHIjwD2MWhlsn8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706468029; c=relaxed/simple;
	bh=ZJ3wU+GH5DH++aVB0vwP++L2auvXT+T3d3ySEiUt8uc=;
	h=Date:From:To:CC:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=g9xGk+pmSzsu4O1ddh4/WPrjJKRhoaUai4f1MQ23ceuJ5KD98I4R7i8HE7p55fbcJ73VPdzaJwnfgrZmG47nZfXCPV/Wez2EMUv4pyK526+wWCbxKMemfY6tQDCFY5C6AMUAEMWohe5ca8fO6TQ6alhZdkSF2AZAM/MENPwUlMA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeggzBRz; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706468028; x=1738004028;
  h=date:from:to:cc:subject:message-id:
   content-transfer-encoding:mime-version;
  bh=ZJ3wU+GH5DH++aVB0vwP++L2auvXT+T3d3ySEiUt8uc=;
  b=VeggzBRzZonyJdZ98GN/Pt7JdGdYXMhyv7HrvnKMuTPikz1tbtoOIWQW
   4VsCGRm9TrBoMo3yPzajDXBM+fEcKaaP5PzIOFt9Cit/DivjzSLeagL34
   rAXz2Q7szIyn/2SA/EG1rqi9EmdFdbrWAHDOJTv+xNicFI8cOGkyM0wsS
   gog/rhNGnSlZ7qUqozcBnOdBtKDq0mHmZCBoBKii8jWt0Ck7nhSpA5H8/
   nuXoSOnR9m+y9jMocH6YJvoJ4BINhUVPj5iKkKilssBwo1ZQPfok+32k6
   E5Mw1NhI5kToyY5kogox8vgQy5V6mONmNKET0t/VnjvHCJoz/GdQVZwv6
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10967"; a="2687247"
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="2687247"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2024 10:53:47 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,220,1701158400"; 
   d="scan'208";a="3144601"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Jan 2024 10:53:48 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 28 Jan 2024 10:53:46 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 28 Jan 2024 10:53:46 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 28 Jan 2024 10:53:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mSJB2iVA220Iq9ng5PZOcDcO63l4K79KKkSwsmmh4PqHM6AEJOLsqYNktrp+gn7I5m5NHJgYkTf9CWzxkuZKZqydaG/JgKrUS9YdUAijqUwD30qfq09zS7CW4eAwtJvB6aGMivMp2a+Vghnsh+CUm83fYdFnOsUACAWIfDp63NMnGSuq9kweBxkv4wccbKVQG2NGK4qUvqwzRZNJ+EsIarD6OvQr5b1UpVmQ3QTtjE0AKAHBHf8LPO8MeLEYqo7sw+wfYe1F3x5cOdIdh9H3bkytHv119W1SzvkFC4OXuqu+0QorEJz7RKKtrpkfwDY287c0VCOr2gSWegmm9F6Oww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=foTnuLMcpPdBRWMoGCxJ9IIR7JfJsnYBdiI1UY2TSEk=;
 b=RUwfxCKrE2m2gBsdQ+jF36wC2rUSWGgQjS+3+eTmTqQ/VXkE27T1DB7TtJppmNX1wQgfRhkXxqiwYl+Hv4ROAGN8c/3filpiAVQn6Q5oKGAXUq4D899PY5Mnvz3BMJKQmpMQ4SuZmKLPCIWxhUs3zajR5KtQJczmYe7o6J3x3EAYYXowQGX16m712UGOfSMcYybUJVwp3YENUWUrmc3zmVTh4QAZfd5MVWt1GSdK1FfmaFFeE4xj/b+Egwy/4o0OOyPq/CpS3AEGf/twsIsAtIjIvseCDToTLVEm5a277y2/07piRpbB1vimtIX+FRXHFR4gy/iKEkP5yxWVpBFPEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by PH0PR11MB7471.namprd11.prod.outlook.com (2603:10b6:510:28a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Sun, 28 Jan
 2024 18:53:21 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Sun, 28 Jan 2024
 18:53:21 +0000
Date: Sun, 28 Jan 2024 10:53:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: <torvalds@linux-foundation.org>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Compute Express Link (CXL) Fixes for 6.8-rc2
Message-ID: <65b6a29eee7e6_56723294ce@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P221CA0002.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::7) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|PH0PR11MB7471:EE_
X-MS-Office365-Filtering-Correlation-Id: 701de63a-c89f-422c-b512-08dc203265ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U0m25GmhzLNtL/9BuRDVN0JbS9RpwfyVsgj9zntUx4C6grdZCPtNRoKfFzEYjfQFfv9tLLOjLeYivDNdrlZqJR3sftQgMnBtUBhgVWx/BwwHzMU3AdXlduhgylZunwzHpCm9gjWjaL0UAoLwDOG12xvQ7ayeRK2CIKxwtdG2EbnYb/+rVBp1oHkDgG9tl9zPykYV97Cw3+A9ANkiVvqmsxSWxUqU54P3G2ctuVtUzNvNjRmqrYOkRpvl/sI8VtYXUHsE8g0M58erfh7ji1ScN/0ncsW6DT+5gz3D1SWuIQEbZEWQkEBZW3isHhibanv8NcD6JcRNUYi78Yj8hMd/uXHCTUpI8qXb4/KwsRHbbvv9OLYC2T2lAMngA10QEAX0tJ1LntAaMbSiz7HCkjqhBHmHALmECdZf8q6m+tsRonB+sJRprwSOJ+tAyksQWsXSrNY35ODUtw8gtb7OZ2l+51gDpv3+mg9LvSJi+TgOsJXh7RkhOEUDlawEsG1LpmJKYJ3TWws75nfoHIa1HyNU0FEC2CHorOlRBlBvmYdscd3w3oMS2gyy+c8wLOmQA3B8VKmNfmlE0CBcAbSERTp+ov6uXoIS1PCBDhQRjXRibjtux8U8CpRgcGYSJ8Q0lyfv
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(396003)(366004)(346002)(230273577357003)(230922051799003)(230173577357003)(1800799012)(451199024)(64100799003)(186009)(66946007)(66476007)(4326008)(66556008)(316002)(8936002)(8676002)(6916009)(26005)(83380400001)(478600001)(82960400001)(38100700002)(6486002)(86362001)(2906002)(5660300002)(6506007)(6512007)(9686003)(41300700001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZmtHSkVucEVOVll2azc2RmRyd0ZpM3NKeWNyeWNBWWVpeVZKSk4vWVVNWmMy?=
 =?utf-8?B?ZnhGMEc0MEVNRndGNWNWbC9vYnNaSkRkc01VemNLbWVJR3RTWlRNK2RkeHV5?=
 =?utf-8?B?MktxTldvQkJGOVpiVkxpbFA5ZDRPdkJNZVB2WmtJQ2cxdGxTQWsvSCtoQm5n?=
 =?utf-8?B?aW50QlpoN3VYSTk2b25YQ0Rrbmsvcm1IRUI4SkQ0b3IyQVJ4dTF1VHlzVlg2?=
 =?utf-8?B?aUJlTHY4QjBFcDhSOFk2VkNmNDh0NVQ5M2MxZTJNWGZLUmxUUXlyN2JZRkph?=
 =?utf-8?B?TFRqeHZMT0xrZFFPMnlTVWdJQzlKRW9mTjQrRXBvYWVnSkM4cS9hckx4TkhL?=
 =?utf-8?B?NHBJS1BxRjlYbm41OEIvZUxpMktzbnc5Q09HWWhhanRIVVhVTVFURUFHSUtZ?=
 =?utf-8?B?b1ZkcmdNUUNYWStBMmtSMVZjRmttRjZXVEpBM1F6Q3B5VFdyQ0JtZU14cjd5?=
 =?utf-8?B?S08wWTNjcWtqdGNWblBUK3lCTzgvdDJhN2ZZbGVKUFk3ZDEvM2dzNHNjL2s3?=
 =?utf-8?B?d0hzUFVJRUIyMUozcHlWYlhRVFd2MWo3RWlQUmwvZWx0blJSU29HWUd5aXdH?=
 =?utf-8?B?OFZWRGxiRGt0MnNLSEllblBPb2kzQ1Q5eUh2TXBjd0p4Ui9uRjREdlVhU3Ro?=
 =?utf-8?B?M29vR0JnRmFNNFdTNGU0TzlBVjUyZFlsUlRCNU8xcDlWWFR1UitBWjhQVUhL?=
 =?utf-8?B?TFExT3lUcHphYzRrWFRJSTQydjRkL25udjB6NndvVGxCaGZXU3llV0prak0x?=
 =?utf-8?B?M2hwRlFrR3JTQ3E1UEE3ZVYxejBBRHpzMCs2RnEyK1R6Slk2ekE1M2YrV1RP?=
 =?utf-8?B?emlubUVZQTBFcUdteHVDK1NCSzVaN2s0ODZHL2tKejlMNmZOTWt0WVljWDNK?=
 =?utf-8?B?NTBZZ0ZKYWdtWjZCWU1ic3A0UHgrMFlFQVUwL05lOXA0Tjh1VWZIUkhWa2pn?=
 =?utf-8?B?UTdHRnVicDhwNk11eGNwdzAyTlovbi9BSUtGbHNobDZUM3d3bFl2L3RZTEdC?=
 =?utf-8?B?bzJEeVBBd2E2R3dLNWZybXlULzB6bmhaU1ZhaWRIQTFEdVRsUkFuYi9mdFdm?=
 =?utf-8?B?SHRUWkN2Z2J5ckROZUdaWmJMd3VvRFRTSjROWlhuUGg0T0pzOXUvWHl4SXVE?=
 =?utf-8?B?d0VXd3VNKzZMbEx1Y010akd2YnZqWmswaGRVQmVPcXN5MGtXOEVmUE1NSTlm?=
 =?utf-8?B?cS9kR1M2cjVDNEJTd0pnYVRFczlsRUUxcWR6UUl3VHh6bVFLYUt4ZmxQNkJv?=
 =?utf-8?B?Q0V4Y1l2NFdzczBwNm05bGsrcDcwWVAwdXhIMDVJb2MvTFdnaE8vN3JiOU82?=
 =?utf-8?B?ek5UWFVtQWl2TnQrb2tHNjlGMnlPUW5xQUJYV3BKMlMrR0FWQkhyczc3QWVT?=
 =?utf-8?B?UklaZ3krVmR2WlpXOTBMOVZURkwwZFRlL20vbFBNTnM5R3Era0NKVmdKcVg5?=
 =?utf-8?B?MmpPRFFMUGtSeHkyeHFPV050dVl3SHMxbFRIL0dkem1aMVBVaG9XeFZ6cXoz?=
 =?utf-8?B?aTRCU3lycVRSK1MvNDZXQ3FNK2V5ZmJHMHkxQXRNd2hpSnFlZGIybHBzcTZV?=
 =?utf-8?B?MHR5MFQ1Z0Z5amduKytMRXo4OU9ic2ZTeStRVDBrU3RDQks0b2tMTlVXSWhv?=
 =?utf-8?B?STcxZndWLzNRNmc3SFVBVE4zV0xvWkdOVUdRZ0h2Q3VvN2tidkNxa016UWdl?=
 =?utf-8?B?NzdodkZhcE9WSVdtVklsbGFzbDhCY1ZVVGtSRGV3aS9nSnpFNWduRWlkdy9E?=
 =?utf-8?B?WnB0NzFxTnd6WTduSFJpY3ZaOXN0ZndLQldLWm5TRFNtWURqUEdlQUZNOXVv?=
 =?utf-8?B?RWtPNmNnc1MyVUovaUJUbGZwRFlXdVJrYWVwa3hxd2UwMjBOVVp5OWw4cGt1?=
 =?utf-8?B?ZGRkcG1kNTJITHBycGlzOU8yRmVVemhBNTZkSU0wL2FjWUpxeUR0WkZab0pM?=
 =?utf-8?B?R2xWU1lzTXdwVVorZXpTZm1XbHVZcENHSW56OXFjSE1YbmZheGsvQXBsR0Qx?=
 =?utf-8?B?eE16OUs5eWxnMlBRb1RMOHVJcnhUanYwZ1MzeHV6RytPbU42cjByT21KL2Q4?=
 =?utf-8?B?a0FyUnUzWHNjWkJOaE53VituTm5KTTBpbmFCK1RrQUE5U1ZIaEVrVkx3TTBy?=
 =?utf-8?B?S1FJbDFZanQrOFNpczFFSEYvU1hScjl0ek10N3RsOC8zbVRiS2dvS3pFQjFl?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 701de63a-c89f-422c-b512-08dc203265ce
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2024 18:53:20.9506
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yJiMLLLSRFnDivLACp6anBPLXvXSMHl9e5iI+5CB54pxC+IPlpIECPu2aLUs5lgE484EIJSfUtVGeVvdOtmN3z+olW2Trrhl7x7Si8Ij8I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7471
X-OriginatorOrg: intel.com

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc2

..to receive a build regression fix, a device compatibility fix, and an
original bug preventing creation of large (16 device) interleave sets.
It has all appeared in linux-next with no reported issues.

---

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/cxl/cxl tags/cxl-fixes-6.8-rc2

for you to fetch changes up to d76779dd3681c01a4c6c3cae4d0627c9083e0ee6:

  cxl/region：Fix overflow issue in alloc_hpa() (2024-01-24 21:03:03 -0800)

----------------------------------------------------------------
cxl fixes for 6.8-rc2

- Fix unit test build regression fallout from global
  "missing-prototypes" change

- Fix compatibility with devices that do not support interrupts

- Fix overflow when calculating the capacity of large interleave sets

----------------------------------------------------------------
Dan Williams (2):
      tools/testing/cxl: Disable "missing prototypes / declarations" warnings
      tools/testing/nvdimm: Disable "missing prototypes / declarations" warnings

Ira Weiny (1):
      cxl/pci: Skip irq features if MSI/MSI-X are not supported

Quanquan Cao (1):
      cxl/region：Fix overflow issue in alloc_hpa()

 drivers/cxl/core/region.c     |  4 ++--
 drivers/cxl/pci.c             | 26 +++++++++++++++-----------
 tools/testing/cxl/Kbuild      |  2 ++
 tools/testing/cxl/test/Kbuild |  2 ++
 tools/testing/nvdimm/Kbuild   |  2 ++
 5 files changed, 23 insertions(+), 13 deletions(-)



