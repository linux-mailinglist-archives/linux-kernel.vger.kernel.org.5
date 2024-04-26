Return-Path: <linux-kernel+bounces-160511-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43E568B3E78
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE23F2812AD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222E315ECE3;
	Fri, 26 Apr 2024 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KHlbbuDZ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88987145B0F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714153262; cv=fail; b=AyjDpqpG9RPFh88t6ooekyheYjBGJoRc8Q3Y7KR4Z7xrTnqpbCn3CwSXmbVH+vgbHerpNmpwmQhqW+Rubm5wAmChSTemB39kIHciIFZeC3QD+o72BycNv64kKJkObOY6eo/jRDysOeuC7GvPPq0QfdNXdnHuVEIHdD6+NcuVUQE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714153262; c=relaxed/simple;
	bh=5h8y3/E/Yuh+ugHtp97ezubkMnB7W05hEgKlJKADkwA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=mSWEmjaBGBZeZC50y/qz/mVfsU8MdnXCkma+yQBTAWAbbXFVgr4dgqF3c7xmB1o88hX4EERZBv5SvW9T/JG8+Zbd6WuDcmI2CeK78jL1nMbygq/sLoqkhZmdJB6HaK2+dIHABfhrvTHY91yUzjqnLu22kBMWhjqTP01IEnrsN+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KHlbbuDZ; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1714153260; x=1745689260;
  h=date:from:to:cc:subject:message-id:references:
   content-transfer-encoding:in-reply-to:mime-version;
  bh=5h8y3/E/Yuh+ugHtp97ezubkMnB7W05hEgKlJKADkwA=;
  b=KHlbbuDZLkTjXgPxdI2JJb9C4t8GUyd/btydCPuQtlCjlKV/PpMOV0VQ
   8aKt9dpAZnRo4+7+kLdEBRAhkw+DEn2djSyw7BWlOPaF6A3jrUuIQlVMr
   gyVrA716YOv8p/PJJN9EdDO3eaRNXh8gB5KCYPvaAiRKKrGzbJ6njFPa2
   h3x1BTkBNiURyx3PasS4ytJ+zuHu3886e6v3D5BIIECPUm1UwSrKC2R+P
   qBHgRkquyl6yOWyaJaGyDAZtydejZxMzmHavs+u6lW6ObjFuV5oWES2zq
   4fu5uHbW1ju17FOPfRoVApxADqqzajY+wgjHNiywnntInkTqXUeQoOic8
   w==;
X-CSE-ConnectionGUID: on2kTK1dTia0R/fYS6yk/A==
X-CSE-MsgGUID: 5Kq7xTYXRBquPuBpCEh9Kg==
X-IronPort-AV: E=McAfee;i="6600,9927,11056"; a="27413452"
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="27413452"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2024 10:40:59 -0700
X-CSE-ConnectionGUID: sBUK2CWFTIeEt48/t+pxgw==
X-CSE-MsgGUID: nb4LIadmRyGN2q+zujv2/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,233,1708416000"; 
   d="scan'208";a="25889433"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Apr 2024 10:41:00 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 10:40:58 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Apr 2024 10:40:58 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 26 Apr 2024 10:40:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 10:40:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bNUmd7oWKmPXqA8zYuGCUYJGhRtNKEclJWnyBMhkP44+kGXj2LvJp+POPIn8X3waEs51CgEUU8Nwshj4AExJyv3SsCfafmNfuUjWcQrfJ4ZconmHocgpLU8seCLDJE7CjTTAmra64233jgViYaBU6Bt7NY6nAZwjWxKVwrs9M/TYLVn9C9i8tiabWcuucfUlaGnA1zblxObf0yg49a3CNB+DE9Rz+K9Meb5LNMRrmHrZ6MYsAiXrMyMoDDpTNjhA9yA+z9hDwbh4XGXjkl0RDEtzIYj51YSL4DE/Xd2Pk8/sRz5XKunmDR3buBt5oRJW+uB6CrItJO1lcgQHTKqIQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN0rOotNNtCZZsTCqechESJ+PnbwvTSp5qUOEGCNl2c=;
 b=a40EPPeeSixhTJezfzJpHdVGdM66TBQnPzKgJ9b5wcrxPafMHSGu74fxnK3+qM4+NXMOUv/oTouIpUnjOdDrp3ol4DMXpAesmJjaVkQhq9tDh533qw0M1uVb2Vn4WSfwojGyPqk3qvpY554T5Id2Wm0BbcfzV0Cvla+iic3pcGosKtD2rnzM8/gWrjJ9ZArcCJ6V8B7WzWRq3Z/iR2KgVX2D+X9M/tDCSxpsIfiJDPek/wYfqMZlN7/vUzW7MtCePJOu4XrUkCLQtoji+QOcXqgKEjixUdiBT24Mddk3su54lO4NAHW1OOueiCPtfMHaP4nY43JVsXE0a/ULFqC3GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB5056.namprd11.prod.outlook.com (2603:10b6:a03:2d5::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.31; Fri, 26 Apr
 2024 17:40:56 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7452.046; Fri, 26 Apr 2024
 17:40:56 +0000
Date: Fri, 26 Apr 2024 10:40:53 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Lukas Wunner <lukas@wunner.de>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: "Rafael J. Wysocki" <rafael@kernel.org>, <linux-kernel@vger.kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Dan Williams <dan.j.williams@intel.com>
Subject: RE: [PATCH] sysfs: Allow bin_attributes to be added to groups
Message-ID: <662be72549aaf_db82d294c7@dwillia2-xfh.jf.intel.com.notmuch>
References: <e140f6bf8dc99c24cc387f7ac3c7908c8830587f.1714030457.git.lukas@wunner.de>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e140f6bf8dc99c24cc387f7ac3c7908c8830587f.1714030457.git.lukas@wunner.de>
X-ClientProxiedBy: MW4PR03CA0115.namprd03.prod.outlook.com
 (2603:10b6:303:b7::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB5056:EE_
X-MS-Office365-Filtering-Correlation-Id: ba7a0f48-43ae-4216-20d0-08dc661806d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: =?iso-8859-1?Q?JjDcj23bN6aCtywUnfBe2S94jjqo6V/wn3ThG5/tXSakL7IeEbdDgEHcs1?=
 =?iso-8859-1?Q?SMqAbBDHO6KV8ZqEElLaoy6vM/i7q8YnCdy6K5ecKd22npIk+W9e88+/AH?=
 =?iso-8859-1?Q?kS0j0TkXcQMnyQGhThDpDohS+lvQ37CnMGS20+PXjTIepm8RO2Q0TivcWr?=
 =?iso-8859-1?Q?ikx8N231XqvfQXLsTdvp1REew3Ggv5qqXZS+/9XE2NcLEfmMOtXEDBitww?=
 =?iso-8859-1?Q?qTBiWRcmuLEUMXMqF/t6/Y5v7SrMjCtRea9/8vQNUelB4CFz1MVr3ZHuE/?=
 =?iso-8859-1?Q?lqVfP6YNRRYhhgOk82odH+EvoQpBlQtzQ8sZlDW2F/12qDAfVFQJTyWAne?=
 =?iso-8859-1?Q?IQKPUXcmTHJLAM2wb5PtQnDlYJn+R0uYv+If8f5UyijpAGYigeGPqVDLqM?=
 =?iso-8859-1?Q?n9Cmi4RLl89EvBLnLFs8RjrXfVJRaNYjXDue3dEbvjOW0gc+PTNKPTtdzf?=
 =?iso-8859-1?Q?O1gpPrgQBhAMOUtjKrg1Vsd1PN0q2x/vaiQGvHauXjoDjV/qvvGGyo1kPf?=
 =?iso-8859-1?Q?t8ab1VFy9+15gyPx/mYHfjPvB8+13//764hCAtm2IhXO+BDsPL9fmaRgw/?=
 =?iso-8859-1?Q?tojMZ8MhUGWWDAmemPWP3gXqXUGZ5mWKtcuvq/1BR5153r8ONW91rMTR07?=
 =?iso-8859-1?Q?AuCUVbZ9RdQvoORl9xy/VqLQ7Ij1fZ1WdhNT1jZ5tzXE44DLse1ZNzT/ZQ?=
 =?iso-8859-1?Q?os+Z5dxwSdoCfer7Wg9C8krtaYrySIHHHiL1nhzkASpp0WnenuNFeZZtr3?=
 =?iso-8859-1?Q?PcenMiXJ4DATNzGG/+p3yxAbw0upetO3KkokuIen4tA0MjoB2gXCUsoKOo?=
 =?iso-8859-1?Q?IIHJKb+sTp54/TR7+TxxDUuTFm2hQbtG2c/De6mmvZppVvbcWx2CQcHcqk?=
 =?iso-8859-1?Q?qLvSE6nnVzBGYOCYwfzAO1eL+fX4wcTCcCoJTWcyZEpuXwM3xKiwmXNULL?=
 =?iso-8859-1?Q?JYK5gwDqMJ7l4uQX0MhthON6NfEmZqG7EgY1ySf4DG6AiIGqPGvAqYgZMr?=
 =?iso-8859-1?Q?b6WFLqNZgyBYyB/SRbEw/MgwFiwRiK+639TNMbFQIBryXcNkFrG6WodIPl?=
 =?iso-8859-1?Q?7Msn0e+jVAadTs774GXygnY/XKn4S4bII0OToujKYT40PUkOk81Br4WbcG?=
 =?iso-8859-1?Q?VFikx4Yxp0DdJqkVdLuoFYKkMG/LnNxI1Z1hr2RSQ/UYhJ3m/orBeYo+Om?=
 =?iso-8859-1?Q?QJ+B0nmP3qUldwCasnYD3GgkPHY0fa9+ks+zIuiQVU0tBcZxBHAZ7XSUVg?=
 =?iso-8859-1?Q?IqEcaUBfQ6HJVjql/dQY/YYKMtDtDxSI+8bPztUAA8uOUF9FB6+dlWzKiq?=
 =?iso-8859-1?Q?DOSkbBqnUKK0oc7EconEIcD3CA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?wIgJQZB3bUFvwz0ChlUJ8EvcFp3qvVte+faOS+7b+JGyBB2fWEQU2iTh8B?=
 =?iso-8859-1?Q?12aIG8pkTjYgAOEW6pn+2sjbzrWYUHwfAWfNZAEecmMXfZ4+9dldF5EvxY?=
 =?iso-8859-1?Q?Cj9/n6z24XqYfzryVhbmZFsL+NIluTilPlaWZWiHmR65BCKRLI/jHF2NZ4?=
 =?iso-8859-1?Q?+SI5o5obgTPQHLYOplv8iNUN1Y617t+0ETOKLShVYfyrXWYyTC/SAhSwK2?=
 =?iso-8859-1?Q?/o+3bjbrCsSucojIXN2z5Y+qEkJajsNw+UgsRiz0/SVqqnhK4z/+E0vfMj?=
 =?iso-8859-1?Q?gHI3vWTIjtrUDRtyNAtYUi6DXapEgZewTAHpLn42kRcBOwlhB6kYF+ih4Y?=
 =?iso-8859-1?Q?K5ltxlZV9E9kQNkfXMajkE3PSM3D/bxhynDJFa2Uxj7/iQRu4I/vN35tLO?=
 =?iso-8859-1?Q?N1L+Y6URle2SL/5+LC/UG2nnls0Hx7fCsY/pxDofF+izeAFDDBL8hjeOSJ?=
 =?iso-8859-1?Q?p9S34gimfW+xWx5+ggn1L5FTSWADlU2yEl8mPZ1F+i0I3FdsWFneWOm50V?=
 =?iso-8859-1?Q?hT/Sbn4lMV/yGlNWxc0Io1HK3v6dRb7b1DoyawccnumrPXCoh17Cg2X2Y1?=
 =?iso-8859-1?Q?+6+4MZj1XeZE0W7sI3dorzgr/Ea2Nr0GWa/NPvCZKAbQJx+jKIW2Z2wmeo?=
 =?iso-8859-1?Q?3ARzC08Wn6zvDnRBm9CCpymPosiFWGPp50oXAuVh+0T11umM6youjDRsdl?=
 =?iso-8859-1?Q?MBCjchiunRyTpiEUp4FAmkogLvE9KTrkhjfE9cM5efkge8qMifFAlgES7D?=
 =?iso-8859-1?Q?O8oMwCDP4Xd3upT6DkQ/onb4RbxsaJrC7AAvBYSZnyxFpmwbxKSqZo2SHY?=
 =?iso-8859-1?Q?j///9BFKy4McnjQXWHWUjp9z092QplAXlXRithbT5NGV8KV59m0L3pmvWw?=
 =?iso-8859-1?Q?h4BNLTWCKhf+RAokD8L4Q9sqzS196L8YgXiOLORfg0sT2n+rr7mfq35XNn?=
 =?iso-8859-1?Q?f0Wz2+Fe5dtxLbYsBpu32qvY0CZO/frMcO3q4JwL+v9ztrSxsqMNpqvZ9M?=
 =?iso-8859-1?Q?HuKXnGN4AVhLvVbrH/KWCRjtBigqXziZxaZkHIDxspzZGbhVcfrrlbc/j6?=
 =?iso-8859-1?Q?uyEEYDioGeQLHOVHlc4HKVqJbrehBZs7a25AiaqZnDJnYqKqLKCHRJHuj2?=
 =?iso-8859-1?Q?pqvHDoVivrjQBbCW/b4gLZLBOU6I++2gU+xwFfDdfvvnbgbd5e008WcJi3?=
 =?iso-8859-1?Q?mhJbHTJPuITlCFQ+ABqumiYLR00XMqyQZ3DH0sMVS8Z+7z3F4HA+XxlLdO?=
 =?iso-8859-1?Q?Bh9OwxI1Z8rnASJs7eR9ZYosns73NpzjVz28llPpQiJYo8EBhONYzoeomY?=
 =?iso-8859-1?Q?LIpULYd5nJDX6Dadqspj+6G6kQYa58L7U1VGILKx3JDgomE6Jvzbc22azN?=
 =?iso-8859-1?Q?gsVN9jZ0XC8PxIm9yr5vhGmsSJexqdQhGxBhFNCSuhbb3y/xLOwsLcTOT9?=
 =?iso-8859-1?Q?tSGr/1CsnYW1kcEFotOZ+wnT18DvPViSsdVZpnOXszVMYFIu4Gw0He9n8h?=
 =?iso-8859-1?Q?d7IZml6yTI/0xjKTgobpGRqXSxYpqibxJCgjQQkMho/u827ny+rF5QlTb1?=
 =?iso-8859-1?Q?EkfdzpvONSoEtm+THiICYvMEkA3Wq5KCY9HX3ea6YS8OTPmYeUGhLox8p2?=
 =?iso-8859-1?Q?1XVZ+v6l2fJ6djMfUcLHHXGLBKbx1NI5lTuxEyBd4Ra0fqKa48C7ED7w?=
 =?iso-8859-1?Q?=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba7a0f48-43ae-4216-20d0-08dc661806d7
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 17:40:56.0868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sTEZmxhOChJeKrkNtJgwbf+0grDL6przJRzjp16JKLvUybEIeVQ4Up+cs9cGJylXVev8PHYowEfxK0k16UpxMoioKSUQU7FstaWiIMAMcPA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5056
X-OriginatorOrg: intel.com

Lukas Wunner wrote:
> Commit dfa87c824a9a ("sysfs: allow attributes to be added to groups")
> introduced dynamic addition of sysfs attributes to groups.
> 
> Allow the same for bin_attributes, in support of a forthcoming commit
> which adds various bin_attributes every time a PCI device is
> authenticated.
> 
> Addition of bin_attributes to groups differs from regular attributes in
> that different kernfs_ops are selected by sysfs_add_bin_file_mode_ns()
> vis-à-vis sysfs_add_file_mode_ns().
> 
> So call either of those two functions from sysfs_add_file_to_group()
> based on an additional boolean parameter and add two wrapper functions,
> one for bin_attributes and another for regular attributes.
> 
> Removal of bin_attributes from groups does not require a differentiation
> for bin_attributes and can use the same code path as regular attributes.
> 
> Signed-off-by: Lukas Wunner <lukas@wunner.de>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> ---
> Submitting this ahead of my PCI device authentication v2 patches.
> Not sure if the patch is acceptable without an accompanying user,
> but even if it's not, perhaps someone has early review feedback
> or wants to provide an Acked-by?  Thank you!

On the one hand it makes sense from a symmetry perspective, on the other
hand the expectation and the infrastructure for dynamic sysfs visibilty
has increased since 2007.

That is why I would like to see the use case to understand why a
dynamically added a bin_attribute is needed compared with a statically
defined attribute with dynamic visibility.

