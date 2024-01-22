Return-Path: <linux-kernel+bounces-34239-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A08EF83761C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 315321F25A3B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C21CFC19;
	Mon, 22 Jan 2024 22:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kar1LACi"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3C1FBE1
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 22:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705962753; cv=fail; b=gg2QPRgrlPgx+5FzneN2b/7Y5vkNhrCibPsEKDjK+H9BkqaIhuYBaI6X0qcaqaYOSh/nHY+qFyQnPvxh6tS4A3aBlICty5DRiSStq+MFi5XLrF8ofj9MqKbAd0Eg2vnnRjffZywt0lse1Z9bPmM8dx14ca8MtPPcKppQw8tkyQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705962753; c=relaxed/simple;
	bh=IXXwYwo796McW0RlN/qfRzT7lbO4ylxBwClMgZ/LwHk=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ZgU7LsyO25BfUPNsWsqnlWRIX1h/eQ2Tc/6pha3LM6jvxsFdNbmTeyzDyQQzi7ENKKDzqBeAGj9dxTv7tqv51zPeX72ejQGXb7aaI5nRCwu9jzgg9Kk9WnoZ/MT4e/NqpX9akyzmKtWsp5JxBIQEwYAAL1eX9HD5kOkCXdL7HRg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kar1LACi; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705962750; x=1737498750;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=IXXwYwo796McW0RlN/qfRzT7lbO4ylxBwClMgZ/LwHk=;
  b=Kar1LACiQEP31oKp23fnMA2JOZQ1WuYqKw5vVhZaKnbdpabnjPwuB1kE
   LVgBSDpSySvpntsRD3gJn8RpeUb8vyHEZxbZDmI9J0XlB8GN4EpBGqoXN
   YPofzvO4Cglfk+9KIW13IV4fUih4/4RAOTvIGGUBj5FZZZulIHc71Zf2O
   c+Xlrs1M4hHu+wHdts7C31P+en2dwCChNjuSL4IjgKZzk2dnrxRC0c4LC
   zbXSkhc7qVg0WbRLC8BrqpMurYj8xueZmeLawv8gSzzNkddZ/RXrCFox7
   1wS7BWoBbjp41X9kllJemrdb4oesvxn1qPQcDapOiHTM21enBzITNSrvI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="14689634"
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="14689634"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 14:32:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,212,1701158400"; 
   d="scan'208";a="27797829"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Jan 2024 14:32:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 14:32:15 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 22 Jan 2024 14:32:15 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 22 Jan 2024 14:32:15 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jan 2024 14:32:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k3bwQ/zFGTxZGYnIpLhfsYIJK7EMrVJQ0CKLBFD6+hLCuzb2CHZAMv06W2phaIp77DCBG/RwP4lSGz52GCD0pG7Gop6hsP0TodDowhfd5xGgRjlFvry/IWDqaQCRcYRC6PYwIbN9JSvS7fFYyz3f5KITLsfeciKVhhBJPeJzAw2/DUk16edpdv25cHLSMGKQ4v4dNia0ozBodm5dSUjs5c3oJqgQ50e37IFm3DsDOBxB9x5TyY49XhdyWbv9jvZX1blZejZZqJ9ifAZFCkLuDpaj6EldZRSNJdZvVruMMbhZ+Urzs28NERSuovsdZKUk6TdekQ9ShPKSOsToZzsMow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UM5gKXb1s54sfUNfDz4T5vEqdTd2xXjvC5mkkocvhHQ=;
 b=g8JgOGRZQBcwQUKyQDFNEvFSD9fiQpElHhX1tZlBUHcRP18iFs7jsUIDZ7f/FWZYXW2c7DMT7EUXdKd17yUfhlzJfMEO+GlbJyIoQykNeBJaZcqcai8VK7R4ovYe/Q4u5/wWm/neAON3iijp3k8esJLeS1kjqnRyl1z/plNl2lqSRRX4CmKEFaLTbO3O2K76uspQQBEjfM95LBNQDM4b4ISzueDBwRvAqGBGuv+0XZIrGhVaMGG7qtBFTEGeh147irKv0QnhPAc4pm6htwedPar+q9xz21BCP/VgPZ5jIUQ2AXsJZ1vNkVaZi+Hz5p89ybliw/lu0vwa1TxhRoTEPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by DM8PR11MB5688.namprd11.prod.outlook.com (2603:10b6:8:23::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.34; Mon, 22 Jan
 2024 22:32:12 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 22:32:12 +0000
Date: Mon, 22 Jan 2024 14:32:10 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Xing, Cedric" <cedric.xing@intel.com>, Dan Williams
	<dan.j.williams@intel.com>, "Yao, Jiewen" <jiewen.yao@intel.com>, Qinkun Bao
	<qinkun@google.com>, Samuel Ortiz <sameo@rivosinc.com>, "Lu, Ken"
	<ken.lu@intel.com>
CC: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	"linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v1 3/4] tsm: Allow for mapping RTMRs to TCG TPM PCRs
Message-ID: <65aeecea827f0_37ad2948@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240114223532.290550-1-sameo@rivosinc.com>
 <20240114223532.290550-4-sameo@rivosinc.com>
 <1bbf8d3e-aa94-48c7-a1e4-76f9eefc4af7@linux.intel.com>
 <65a72c305291f_3b8e29484@dwillia2-xfh.jf.intel.com.notmuch>
 <5539c533-37b2-4b12-a5c5-056881cf8e3c@linux.intel.com>
 <Za1G9I+tYuIL9ser@vermeer>
 <CF3D8DE1-AD47-4A77-B8BD-8A12A6F7E9DB@google.com>
 <MW4PR11MB5872F46A2089C8C2D8EF7A008C752@MW4PR11MB5872.namprd11.prod.outlook.com>
 <65aecbbce09dd_107423294b7@dwillia2-xfh.jf.intel.com.notmuch>
 <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <c3b99264-233b-4997-9e20-c4c2693b8cdc@intel.com>
X-ClientProxiedBy: MW4PR04CA0150.namprd04.prod.outlook.com
 (2603:10b6:303:84::35) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|DM8PR11MB5688:EE_
X-MS-Office365-Filtering-Correlation-Id: c0458caa-1637-4941-6d0d-08dc1b99fa70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wF3vp4LZiDJCo4PUqf0+6X5YscnR4iIIGbXtRvB8AzLZH3JTSdHAuGHVXKMcg1JDcUeT17VViLZQXMysNNW1zeWTrdiXR0McNw+MqLeNuWla6MPG6d3eeENJ7vuX4LKp2l1+3C9N5dhcIg+o4HSsuBI2jN2ZZH2nqKki+W5cDLVe5SfMAfkhSNu/DV3BTd//bOj7c83dgmPEJ8nnweXeE0tWLMy3tvkcadEh4jYXppCr2D/hNpmVrIVROuqr7y7JpgFLwBMPwssODNUwwXClbUnlR/KxI2bmhIysgB4hVskt5jZZmKK8HfjTVhZFLkHMY1CT8/7T+WECIXUbfTiFuibxrx9/L/SGWpMsFYIkiEiajly3Zba4QZOMjlnezSInNQ52TVV/mm0JH46NMJ3S0AIqes2G0paZVccp/2C6zPwN7jmuKGM6r5Pch6HvWIKWR44gryrWZ34ybZW5xs43kVuzArrQW9iXwBmRT/YU4+6fk+r5AWqUMzxRptzZzM3SKJhmcENNRuFBYnTgvTqxBhrgffoXci9CwnyHlOw15Z8tN5InvPgiaRXsAJ+WjTL2
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(366004)(376002)(136003)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(26005)(6512007)(6506007)(9686003)(38100700002)(86362001)(82960400001)(4326008)(8936002)(8676002)(5660300002)(2906002)(4744005)(41300700001)(6486002)(478600001)(110136005)(316002)(6636002)(54906003)(66556008)(66476007)(66946007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Y5iwfMkAXAFofvUVpnPTs3qkVbsUwj8vlr/l2qBWFMdfY44ANLRithGL++Wh?=
 =?us-ascii?Q?8JgOSdyoDtgUCmYOHSsawqjKPxfaGIAQxkrjkxnjhnoqtqh36OAmFmj8IO8y?=
 =?us-ascii?Q?03muBDdLQbi7UshjFOOEOv4nAHk/qtYTpFKEgjLJGuqKTlR5K8azbOY5WHVp?=
 =?us-ascii?Q?ePQKbv+a3Tw+NtlgZY8nD+bks5rWiBX6YV8b3k746RoTcF2Xs7+5R9D5ZPY8?=
 =?us-ascii?Q?AuAPNPLtmV4PJtrcqndafAEHL4x6qcb2uYI/Z5saRW4Gry+2U1r5uw/EN29D?=
 =?us-ascii?Q?pKeyrIlOKFy++XfkHYmyLdKG6mofqyiOwu7Vu/0jVM45v2E+pHwqLeiwwk5i?=
 =?us-ascii?Q?J4WuwsQSZCcQQEN9HzYKYCNSRUp7MTUs+hUJWCPsKs3QOXlSUIk/ub2rB+s0?=
 =?us-ascii?Q?bAu1ccbktODlF9Ll2PlA/LS0o7Xu0IEnPpDdk8B8sL/ROWjT3/dJAJy0P7sN?=
 =?us-ascii?Q?FogMLulYy7C1cwiCizlOQaug8UY+txCEp7/szjAWugRmXs0sSnHvNmt3sqrH?=
 =?us-ascii?Q?Qb8KCb3edSm8gttwAvCBVf1oJ9HCl+3TrhuYt0J70sRb5/xcNUqBUZooPUM8?=
 =?us-ascii?Q?lfZdPOueHSPgGisCKTloUY+lBbJ5T7WjcuA3Ez36Vi7oXX5MbLf/2kxmmmlz?=
 =?us-ascii?Q?KHOcRXBRQQ7rwXTHb9WjWUce6NjXHG4qOu+f4WcOVLZUDeZ2LNcr87kWnT9O?=
 =?us-ascii?Q?X54mVxYqA+c7VP1FHIjBSeWv+TjgAj/HuMmGLzIMVIdpL2CVi2uR3/10Fo4G?=
 =?us-ascii?Q?6ikF+esS1DRU3RPbIZyHyBs6J5g3A9heXeq5VjoGkcVnEHsSluvccSMfm8gk?=
 =?us-ascii?Q?zDynD+XPwTZ4YBQGbnMN2PMvyfAey3/r11VHSHP29RVmkfE1GnNZsiUkFjXg?=
 =?us-ascii?Q?5NyoZdYMfK7lH2rBDDesZQO0dqB714etiaPQuxv6L9pPDOwk4Y6K+gej4+pc?=
 =?us-ascii?Q?UiFJ0aYbHZtv/F7k1YhNz5PyPtaU+qKxkHnQiD4OS9qhO9V2Oc2gZjFpXxQO?=
 =?us-ascii?Q?4itQUu0ENU7hoZPx2Fy/U9tDKmU6arHGnBFKXE/UZvDgWaOmeUStZUPeF6+l?=
 =?us-ascii?Q?VaEDtRqvoNQpazQv2QY7WK2Tb7Efi8e48DBA7EVpLm9fPp0VDeUq3O2FaULk?=
 =?us-ascii?Q?tYI8D5kqdry3xPJg7AZnOkyhA+3OalAXgbLWZOkP7tsRBz6JKH0c3ZzabR9k?=
 =?us-ascii?Q?GRUIiq6jcwji5vfXmE1X8gpM/F9NkWAlEW4pFBplwhYUaNDHKA3FpkqHJuuI?=
 =?us-ascii?Q?AT5f0VjRso5dqDaFqsqsuHMJ6DO+pGHT2X5onAhWIjfk/Z80Ggx1ivaWtzJw?=
 =?us-ascii?Q?Kkq3S6DYanYBj5M+EZ7PMAIkDZGsw0BnbpDktrxbykHjPi7NlHpBHADIxThW?=
 =?us-ascii?Q?AqeCCfTO6qqCWtfnT9gs2QeHqCf1G4Lq6MjhqNKyI70Z4XLY/Y130jer3Yxs?=
 =?us-ascii?Q?Q8OUgUWyPvsBkVuYu1d1GEU5vVt8EiyJnjVSNNKi1qkX6MIAr607tDGDqDDQ?=
 =?us-ascii?Q?clpDbjiE4J8SPYkz/S/+u8EBBooNpEz9StqENwoIaJ+RBASJKjEn0b9SfgXs?=
 =?us-ascii?Q?WGbGMoSV/z4ZL4kNyTdS0vzrFoPBGHiX2ZC6PgKyWHXY2p1M7gtBnUc84OfC?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: c0458caa-1637-4941-6d0d-08dc1b99fa70
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 22:32:12.6655
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: u0FjynvevfBi20NXaeWx/MJF6sWV4E+3XP1Q9woSWpKI/Hd0nM+PtKnCLLX72RIUXAwzfTCPvPR/drHQYTTp0LgNRVaXTm2Mzcevrkm0E7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5688
X-OriginatorOrg: intel.com

Xing, Cedric wrote:
[..]
> > So, yes, the mapping should be allowed to specified by the low-level
> > driver, but at the same time every vendor should not reinvent their own
> > enumeration method when we have EFI for that.
> 
> Given PCR->RTMR mapping is static, I just wonder why it needs to be kept 
> in kernel. Given that PCRs can never be 1:1 mapped to RTMRs, and that 
> TDX quotes are never TPM quotes, applications used to extend PCRs would 
> have to be changed/recompiled. Then wouldn't it suffice to define the 
> mappings as macros in an architecture specific header file?

I think something is wrong if applications are exposed to the PCR->RTMR
mapping thrash. I would hope / expect that detail is hidden behind a TPM
proxy layer sitting in front of this mapping on behalf of TPM-client
applications.

