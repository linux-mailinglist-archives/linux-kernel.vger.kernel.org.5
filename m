Return-Path: <linux-kernel+bounces-129222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 584FA896749
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D59E11F246FB
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A955D467;
	Wed,  3 Apr 2024 07:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b="FqJOmwL8"
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0EA286A6
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 07:53:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.158.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712130798; cv=fail; b=cijXEmmI/R6HHZ97DtAviLKRW8rSHSmjURGtiSlqlELagqWZhYC4xN9Nqds1LIJAV33QpykD3QrCR+cmA2vfychKUA6nubUJ8xs+dwU//REK6fvScrF3oFb3roOsMh4Xxly2/SUnO4f+Ug6XKLP9OryOby43A2jqqxF+Hw6VsmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712130798; c=relaxed/simple;
	bh=Zvsv3cIZkzme1wcd+Ko33r3rj90BSLnCQH0j+c9FmdY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AEfe3yCGmcz0j7W554M5pZxhmaWSh+eMcEta1QzFY/4155R/o9b4PrS7QCqt1Oi8zZj5UQTeOaw43eRI4R0lG0wKOco7iQVUvQgwbjn3lHs6ipggkYggR+7mxsngB90j7cB7RvaITOsgHe5V2baCbxy72YQZswAzd/rohKLaoYo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com; spf=pass smtp.mailfrom=fujitsu.com; dkim=pass (2048-bit key) header.d=fujitsu.com header.i=@fujitsu.com header.b=FqJOmwL8; arc=fail smtp.client-ip=216.71.158.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fujitsu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fujitsu.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1712130797; x=1743666797;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Zvsv3cIZkzme1wcd+Ko33r3rj90BSLnCQH0j+c9FmdY=;
  b=FqJOmwL8FSCbVEHkYMW5rzUY3tu/m75V95J+ETeN+H6rD2KG1uJQSapq
   eI5TUMGksnZ1DoemIlJPCUN5Umt3yOR/n7dQenck+wpZKU8nocf+QEDJH
   zYfd12H0ds/+sd39Wz9T/TYmb5szc1lMU8NuniG3tkQenpIASG3mh/pHH
   oKj8ZOsTvxtRdsdPKCNe/iT64KpYJhwgU2qEDJ6Z7VX4oYKqe4xH5pnG8
   eFXM5PuGNhoRIjFEMXEO+soPbOxd93feXE98I6xkDraQUWZj2JAbZZTg7
   87zqSVK1EFSqVNFMIS1UR1iAT0Pc/e2AF9v2rVdEmlSDf+HaDwZ+OMb+I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="115353013"
X-IronPort-AV: E=Sophos;i="6.07,176,1708354800"; 
   d="scan'208";a="115353013"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 16:51:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mvso8oB0n509rm3uMr3min7+28l2bCX4MgBfwa5ioDAojE39Uh+BP1ixySooLFVs03qcOc4f5VFONiFbHHZv8jGtwUTmyD7XjS5DCAH2YexPRBtbWw0xWRHX9oT0X6+3Lk+abCbPYrHYoS93lAo0UBqGpsLUNNC9e6ZZoJ4hJ8Bl3Dg96zuHXQab+FgJR1M83P5+51adI+SLAwXHnRxhz/H5Mklb5M2HnVXVkx0ozOEDLwW2vkBie/JWe9agcEs5J8rjqbbYsPLpSi7hJRD2n88Llql0Lx6rXU95HCDOhGADvcNerU51jKL/g0uFambH2R5M5Da43Pr1q9eps2OODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NP+cIeD+bU0Uzmh0gYGArEN5c3dpuhrDeyaBMQ8wZoI=;
 b=Xst4QdHqPKzA0YhMO2YdOvAqLHTMRN4VPGkGhBvIw8IhAj4bCLL9+EA6uUq+phoinLyfkMyBm4aLRSRhie/2yA2O3lwrM3KIn+cypFAhPZ6YhFqnXoPdJZ7MopI6tdgCNgStTOR++XAwuQ0wNtBD9cpNCuJKJpEpDPH76e2mYY8cRVYahfbaU3QIZkpJQwL2dUuE/HC4rgiS4ovLPciOhJyaXeggqWE5oQlXlqrvmRLdwQPkURz5wLhA+7gsOgZ218DXdYUcm3gOTvn5bYw4AzDeza23OWd2rSU8KOHfaldAUx35QXI8JTSjkuCTzKLxruh45uzjzZilVBTL0PIbcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com (2603:1096:402:3e::12)
 by OS3PR01MB9563.jpnprd01.prod.outlook.com (2603:1096:604:1cc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 07:51:54 +0000
Received: from TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19]) by TYAPR01MB6330.jpnprd01.prod.outlook.com
 ([fe80::2f40:de1f:f497:a19%7]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 07:51:54 +0000
From: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
To: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: Fenghua Yu <fenghua.yu@intel.com>, Reinette Chatre
	<reinette.chatre@intel.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, H Peter Anvin
	<hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com"
	<shameerali.kolothum.thodi@huawei.com>, D Scott Phillips OS
	<scott@os.amperecomputing.com>, "carl@os.amperecomputing.com"
	<carl@os.amperecomputing.com>, "lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>, Jamie Iles
	<quic_jiles@quicinc.com>, Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>, "dfustini@baylibre.com"
	<dfustini@baylibre.com>, "amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>, Rex Nie <rex.nie@jaguarmicro.com>, Dave
 Martin <dave.martin@arm.com>
Subject: RE: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
Thread-Topic: [PATCH v1 06/31] x86/resctrl: Export resctrl fs's init function
Thread-Index: AQHae7AYRYO/UM8BFEeS9WQu6+6TtLFWO+OQ
Date: Wed, 3 Apr 2024 07:51:54 +0000
Message-ID:
 <TYAPR01MB63300666A8517A5A141F9B5C8B3D2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-7-james.morse@arm.com>
In-Reply-To: <20240321165106.31602-7-james.morse@arm.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ActionId=ff57b332-9edd-4506-b2be-a3c2e689e131;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_ContentBits=0;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Enabled=true;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Method=Privileged;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_Name=FUJITSU-PUBLIC?;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SetDate=2024-04-03T07:51:10Z;MSIP_Label_1e92ef73-0ad1-40c5-ad55-46de3396802f_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;
x-shieldmailcheckerpolicyversion: FJ-ISEC-20181130-VDI-enc
x-shieldmailcheckermailid: 0a2f9632933c48528c0447955acd23f5
x-securitypolicycheck: OK by SHieldMailChecker v2.6.2
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYAPR01MB6330:EE_|OS3PR01MB9563:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 nc0wwkJ95452e+6Ah5F6SCtCJUzwHmuG1rt/Dizx4xPBnwZI0m9RVpCaPXsfB3hGpQ6n1l8wv65kCNUJ1v3vhZDxm+7HrPbDvSQkuQEgkpwKgS8RbRkFoWkFNzg/8XfEBFVsI5WV5DdCxwu5YMexf0h+Md2dI+qx37ePGsGhWzEnGfNg/lgFwfTzjyp0oI26wutT43pIUkFTmbkiDZqI+bozxCUfFfAbNQqP788qZVsRQQeSSRzbNB73MMiY3X5kbjU1EKkgg7tuF+54zaeRrasMXZoID0oS7keSG2F3DZ0PV28Plu0cUJuG+GJi/3E56YMK3dtD+URi+wYLe6Nson7k1JUyV+TPNclCgbCFstOkcZJeowFpYG9uazGCcvuOffUlMki1gFH4FNWstNmUWB52ehcV1xhAVQDO+07/xpN89QQr1wR5U5oYXPzOGyzhgR/QqOdB/+phpBEjfOw9EHEzM7PYUuSj046wsf2JaCdNOm1TVHZRF72ik1GjyfHEg+t5VUmkIY0o6DVMsIO16Hhqa6JEIw7W3DP8G3J8QHmqOGHbbtxzKtlpENlnP0r0hlEDlduF6GcZN990V3Wg0fdEbULOOBjvE2+UnQsEZGLfcGcMnSS2L9QyJlSHlKmrxKNkKigt9fgTz0b6KfRKqMi9rdwz3LKFsCDJfZmmK0vpPVeeCkivxG2pQzgnSGpxtMs6lzUurYCk6W55HF8NMA==
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:ja;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYAPR01MB6330.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7416005)(376005)(366007)(1800799015)(1580799018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-2022-jp?B?TlhteEd6UUsyaGZ0bEVLZ1JaR0wyK01xSk1aOHpLRVIzaUExZUdxQjdY?=
 =?iso-2022-jp?B?TzU4L3BwUUN5TTdIeCtqQmNValZOZ1hVd0ViUmlhSjY1bThLTXVGdnN3?=
 =?iso-2022-jp?B?bXhUc1NSVnJGbFJCSkh3YjBnVGpwa1A3elQyajUvVUhmc29lUHJtdjFz?=
 =?iso-2022-jp?B?UEtqWFlubTYyY01DL244ZElrRG5mVG1ZUUNmdkU3Mnp4OUVDeWxtTFN1?=
 =?iso-2022-jp?B?WUVicm1ob2pSS3FSRzJma3E4MDZMV1NrOXNMeDFXaDZXeURTc1MzdWZU?=
 =?iso-2022-jp?B?SDRnL0hUYUgzT1FaVnNpNHQvdnpZOW9ZWkNJZGw3TjdUZzBiakExY3Jh?=
 =?iso-2022-jp?B?aFhXY2UvVVpXaWo1OUNsbUxIWm9HRjR0aFB1S25wK3pMZXd1aGRVOFAv?=
 =?iso-2022-jp?B?bFQyRUhVV1hyaVV4cmJ5WjZaOVhwd1dISU5hWmJmbFBKM3NPbE02Z29U?=
 =?iso-2022-jp?B?VEYzNXdFV2VFbnZqbGdtQmYvYzIxcEJ4NDIxK2pFT3JVcUVHMkwrZkxI?=
 =?iso-2022-jp?B?S3ZTbThBdmNUZFBZVjFQa0hPMGVxL0NTRUQ5cmJJcmZBT1ErYVcyQzdS?=
 =?iso-2022-jp?B?d0ZwQnlKMW90UG9XYjVPVCt0Q3NIQ0FteU9BWEhRL29DMWpYUVdaTVpK?=
 =?iso-2022-jp?B?Ri8vd29QN2lYdWZISzNQMXFRS1RZSjA3dmdXc1FpMGdpSmVNVTZDd2RL?=
 =?iso-2022-jp?B?SjdmQllaRFBzY05GczNvRk9kUjhuaEc1WGlOVHExbS9tdjh6ZWZwdXlN?=
 =?iso-2022-jp?B?M3E1QWpBeUNmYlZtbkE1MWZzS0hkRnBFR2dibVBXNTVTaG5qL215Z1VI?=
 =?iso-2022-jp?B?Q3VqQXZJTjA3WTRiWVNjQ09qWGpMMiszelRzdnFqT3M5NkVoTkpGR1Vv?=
 =?iso-2022-jp?B?UEg5YWowRFFHSTAybkRmZTkrT1g0bWNuWks1SzZKMDRqZjVLKzV6ZVNw?=
 =?iso-2022-jp?B?dXY2NmdlUjZPRFFkMEV6ZFlHelFTQ3JXcHNnNUF2SElKM2ptYWdKUGMz?=
 =?iso-2022-jp?B?RmFQakQ4OW5wTmVEOVlLcVlzU0tYRWhTWldaTWd4N2NyQkM5akIxQ1BW?=
 =?iso-2022-jp?B?VXNva2sybmNZWG9WbUtsQTlIVjdpSzF2Q2tTRjhnek1zeElUT3QydWdm?=
 =?iso-2022-jp?B?OWRTT28vUDRKSkV5QnpLVW4wUWdGN1FkL2g5SkpIVVZXY0FudCs4Q3Fj?=
 =?iso-2022-jp?B?OVpBNEJkWXBmQ1NnTVVUbDBVMmRiZFF6a0tUdjUrcGQ2REdzd1pDczIy?=
 =?iso-2022-jp?B?NVI2b2h5bVoyZnFPZksvOEsyako0Rk1wQnd2d1FaQUoxSkhBWmRtK1pM?=
 =?iso-2022-jp?B?R0E1cS9EK2pJNVlmaFFhakY1QnhrVEZzQTEwdFdTWDh0RnJwZ2VsRUN2?=
 =?iso-2022-jp?B?THNDTGxEK3dScm1MUVhpWlFhWlRpNjV5U0haQUJ3djVST2JyWTJWUXk0?=
 =?iso-2022-jp?B?ejR4ajRvd2NjYzFUOStHZU0vMmxQZW50V0lSSVlSRElPMWo1MTdINnBw?=
 =?iso-2022-jp?B?MDZ0UXBJdytEZWxrd0FLQzNKZzltNTBIbVdPajd3eUVKS2ZxSU1JZWlv?=
 =?iso-2022-jp?B?WnpVZWtQbE9kbXR5TE9URGxNUGhjTFBtdENZVVEwcDlSR1hsbjhGZ2xB?=
 =?iso-2022-jp?B?SEIybWZrZ04vMi9tK1N4Q3lsaTZVc3NYYWRaRld0U0E3UXhwakJlS1Ax?=
 =?iso-2022-jp?B?ZTNYaVJoZEdWb3Z2Mk9zTkV2dWZqM3dYbStBV2hmbUtiVjduL3BMeFRv?=
 =?iso-2022-jp?B?NnRHdytRSHVjYVhyZkI1Qlh5WDZIOWV1b2hiSHpadXE4QkxrOVlJN1oy?=
 =?iso-2022-jp?B?azN6NzEyWUtBcEU4LzBwTlZzVzQxUEdINzhhQWwwWkpKMUZuRGlqRXA2?=
 =?iso-2022-jp?B?Q09Bd0lzMVlJampTWUVLTndxR3JoUXVJTEovdStqL09nWGRpTkg2bUd1?=
 =?iso-2022-jp?B?ejBIOFpiMFc5Y2tuaXZQdFhhamlmTEY4NHcwTjdIbDhQL2c4cmhQTW8w?=
 =?iso-2022-jp?B?U01NQjRoaW9yRmE2VkdZN09qbHcveUF0dTJHcDRUaHFhdXBJa2xFSGs3?=
 =?iso-2022-jp?B?bWlFZGE5bjRvVGdxZzFHUnFqcHpWSFduNUpsWHAvc2JVajVRQi9tZ2sx?=
 =?iso-2022-jp?B?SmJJV3ZpLzZXY0N3UGR4bjRnLzc3Zll2cVNMT1JIaDZCL2VrZnZvZWNQ?=
 =?iso-2022-jp?B?NWFwSDBoazg4aVdFbHhGeDRHcC96UitURzJlVmdacnV1eW5tR0VaQXVE?=
 =?iso-2022-jp?B?YXJyWmNtdUdQeWZsaVhWUG85YlVudFZabVVlQVZDTmsrcTZZUVhrNEda?=
 =?iso-2022-jp?B?TzNBUkNWZTFKdW1KQlVoVEZhaHFEdUMwMmc9PQ==?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ne19u2HO819hUwJZ+wh44d52nX9/Kw28b/gVlZBXnBVSKUpTY4nsHFIaAthFX2T/oCojJuSJVB9BvT4GHldnCWyq343BOJ7Dtq7CwcyHK4P1u+726/G3l7ToBBkY9+++/1LB5mOfwsIvuifiaEaNrKdlA6M8I1NopaoVVY1qdQddNyUnR0X4WYjMZMKq+8JLFokT7aAS5pLinp7s78bLhug2nIv3ajXVbmh4OCWE5Q6ItXPZpVLF96r43XDg3Hb4UKoG+AeD/oBYSSt3XWv01/PeOAaFS7pbxEKopI/pRpul10tBtfiKwlqxiwD5KHsk+n6nGcC19RFC77NSsBgWB8qFOhpW4bLzNQiwx6OTwP5LAR+ECUlOakvZKAHvPTRi0SoWgnwvUQdNprqJ72HKepdAml8EvYwVSWOF8yXL/HF0TmV2eQFEoiMYwRSj3nW/Uxf67CLGv6dZUQ/UKgt87tDdvQMhH3Al3nvmeJan5YnVv9JE7IQudWTsaHZgpihy5oyxdtMmrYDtxl5ZRro+IkTCpy1qXAiG/UgUTMMrhwZqcmhGGHOXAgy1g1xwvdqmumonFDhcII7DMTIuHuA3QLbSgpW9L/b0mUMDOoqcSDaNBPTXJgdSLlVjhO+iQzYq
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYAPR01MB6330.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06349693-4b1f-427d-fbea-08dc53b2ee41
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 07:51:54.5721
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkYLFWTmVNJngfCFp8JwKBcriAz8ja/cRKNoGjWOnAWEbuMycQeP9PtBe5AIWoIDmI9xNMwJqeDMhX6HHQkH3XiIr7SjU8rDN6hL98+2/Z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB9563

Hello James,

> rdtgroup_init() needs exporting so that arch code can call it once it liv=
es in core
> code. As this is one of the few functions we export, rename it to have th=
e resctrl
> in the name. The same goes for the exit call.
>=20
> x86's arch code init functions for RDT are renamed to have an arch prefix=
 to
> make it clear these are part of the architecture code.
>=20
> Signed-off-by: James Morse <james.morse@arm.com>
> ---
>  arch/x86/kernel/cpu/resctrl/core.c     | 12 ++++++------
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 ---
> arch/x86/kernel/cpu/resctrl/rdtgroup.c |  8 ++++----
>  include/linux/resctrl.h                |  3 +++
>  4 files changed, 13 insertions(+), 13 deletions(-)

/fs/resctrl/monitor.c
746          * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are specia=
l and
747          * are always allocated. These are used for the rdtgroup_defaul=
t
748          * control group, which will be setup later in rdtgroup_init().=
=20
"rdtgroup_init()" is still in the comments.


Best regards,
Shaopeng TAN

> diff --git a/arch/x86/kernel/cpu/resctrl/core.c
> b/arch/x86/kernel/cpu/resctrl/core.c
> index d07eff7d6750..b4e7d655e242 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -938,7 +938,7 @@ void resctrl_cpu_detect(struct cpuinfo_x86 *c)
>  	}
>  }
>=20
> -static int __init resctrl_late_init(void)
> +static int __init resctrl_arch_late_init(void)
>  {
>  	struct rdt_resource *r;
>  	int state, ret;
> @@ -963,7 +963,7 @@ static int __init resctrl_late_init(void)
>  	if (state < 0)
>  		return state;
>=20
> -	ret =3D rdtgroup_init();
> +	ret =3D resctrl_init();
>  	if (ret) {
>  		cpuhp_remove_state(state);
>  		return ret;
> @@ -979,18 +979,18 @@ static int __init resctrl_late_init(void)
>  	return 0;
>  }
>=20
> -late_initcall(resctrl_late_init);
> +late_initcall(resctrl_arch_late_init);
>=20
> -static void __exit resctrl_exit(void)
> +static void __exit resctrl_arch_exit(void)
>  {
>  	struct rdt_resource *r =3D
> &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
>=20
>  	cpuhp_remove_state(rdt_online);
>=20
> -	rdtgroup_exit();
> +	resctrl_exit();
>=20
>  	if (r->mon_capable)
>  		rdt_put_mon_l3_config();
>  }
>=20
> -__exitcall(resctrl_exit);
> +__exitcall(resctrl_arch_exit);
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h
> b/arch/x86/kernel/cpu/resctrl/internal.h
> index 9048bd32e86f..7c073298aabf 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -300,9 +300,6 @@ extern struct list_head rdt_all_groups;
>=20
>  extern int max_name_width, max_data_width;
>=20
> -int __init rdtgroup_init(void);
> -void __exit rdtgroup_exit(void);
> -
>  /**
>   * struct rftype - describe each file in the resctrl file system
>   * @name:	File name
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 18f097fce51e..1a49c9918f8d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -4116,14 +4116,14 @@ void resctrl_offline_cpu(unsigned int cpu)  }
>=20
>  /*
> - * rdtgroup_init - rdtgroup initialization
> + * resctrl_init - resctrl filesystem initialization
>   *
>   * Setup resctrl file system including set up root, create mount point,
> - * register rdtgroup filesystem, and initialize files under root directo=
ry.
> + * register resctrl filesystem, and initialize files under root director=
y.
>   *
>   * Return: 0 on success or -errno
>   */
> -int __init rdtgroup_init(void)
> +int __init resctrl_init(void)
>  {
>  	int ret =3D 0;
>=20
> @@ -4171,7 +4171,7 @@ int __init rdtgroup_init(void)
>  	return ret;
>  }
>=20
> -void __exit rdtgroup_exit(void)
> +void __exit resctrl_exit(void)
>  {
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> 2b79e4159507..f6a4b75f8122 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -325,4 +325,7 @@ void resctrl_arch_reset_rmid_all(struct rdt_resource =
*r,
> struct rdt_domain *d);  extern unsigned int resctrl_rmid_realloc_threshol=
d;
> extern unsigned int resctrl_rmid_realloc_limit;
>=20
> +int __init resctrl_init(void);
> +void __exit resctrl_exit(void);
> +
>  #endif /* _RESCTRL_H */
> --
> 2.39.2


