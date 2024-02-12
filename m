Return-Path: <linux-kernel+bounces-62298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87403851E39
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 20:58:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 398D61F23964
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 19:58:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284747A7E;
	Mon, 12 Feb 2024 19:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HxrEElS4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8CB447A40;
	Mon, 12 Feb 2024 19:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767875; cv=fail; b=A8Gc5ziP13s5VV+ccqOjFNC/oFugcGrO5HFY5TsPqwH9bGh7T8VR2sAqR9DqjclzD7+EoANMgq3msQUSxPW0ldGo8NfPrAHe+VHxdZPfx+QmHN9HaW3DB+BjAGsRwzA1NJG//uQU7TMDWJCyDO+tu3eaqnoT95Zk1/emfHCHlj4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767875; c=relaxed/simple;
	bh=U7KWXFbr6orrO1Kl3RnxXl8QFDe4+tVWotIwjJoH9O0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LVo2XdSoXN/U0rxvN8O+mN5Cm5QrZ3OvUx6vprza6EVipPk9kGvdp93wz6h300tQPlm4F/Z2w1WtxV+oevBGKXvIvQg7zRPPQ6w2Yu/p/SA+LSPDsUc4jRCvd1X5URsW3OqrmNiu8PpuTfuqHZ7ISe0pETLmOrmQLEC1zjU/8Yo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HxrEElS4; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707767874; x=1739303874;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=U7KWXFbr6orrO1Kl3RnxXl8QFDe4+tVWotIwjJoH9O0=;
  b=HxrEElS4DxFhCBzQ9xNURLxbuYTVqIht7Vy8Jtmc3kuF+yeFAE0yCH3R
   hQAJUKpT0k2nS0y015y3wqp8GdcHdWb4hOVywdCRTyabPFdb9YAEVFugl
   v7xUQeyr7xGkkH8kaLOlxG6xPiIqQ37Ez4zDOVxTQp7c1GqP04Klk1S+P
   uIyPQgTIIgD/hqfoWmJykE1ZPz1naXqNvQ0BTZUIkWbhVT3fqiyi+drJ4
   Wct041oxk/iYzBRA1nm3JwMVUkPcqCDIYKCiuKMgQm7V3L/GnwxPF+I4N
   V25V9uqz9CBlovboTq6yidZVGKAtXUTDpt/j17XvPUoiw/hD/7qmPFa0n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="5537417"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="5537417"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 11:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="2637432"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Feb 2024 11:57:42 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Feb 2024 11:57:41 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 12 Feb 2024 11:57:41 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 12 Feb 2024 11:57:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QZJxZ5kLX2BZd0pn5l4DhXPk+U7TYNDqDPWNpUQfotC/kHKcQOe0YJrL165nu3LJFbQ0FBdFTeLMy3KDOu7g1zCXnwcBOe/P79o/HOf/7UXKB8TlEJpQ2Wl1yjTN3n6Dvjf3U0swpbw8dyqcDuS4cldAi6lOzWkOU7P1Thb7uNZQx4pS9oySKud2p46IsMm3jorjPFMGkPypKGC5Ob5X2uhlQTKryFs+3Kd1TS0r8I0UGRjmBdknNFSuIKP4mo43JyiXadFkEKhU0X6CF2dOIDPIRPEErBSllTecOnDDKduGlkVBvuLFuE65yCWhk5ocffql0RTo4DQyrOsL6aF7xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U7KWXFbr6orrO1Kl3RnxXl8QFDe4+tVWotIwjJoH9O0=;
 b=Aw3GlRck+4SdcVSPACfVTxJCZA4D5B+iKaNz1sSlDwtj0HxhGLLPRYOmBXBC1WZfBqfuQEfeBAJOxSGAGzjaBGCvrlyzxkho8sDMMbn6pW3VEqihhQzJbYiFxc6Q8aL9nN7dQMehC88PutptylKm5DeXaIR24YavwjWS4jowSi58vWAwzurqLaO8rGqyQc6/S1uk06q2ES++oEEm14HhTyrtWPyrKTXmkrVqBq4Ou+fXPt7780hXi8Wm5pkuw7lOle5t45C3P8QI9pPAllUzmUzMl4nF1aQy/0cQEVpfZhz+D0kQHz+057kV688SraFxRygHUTXOncEV4SoV1mrpmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by SJ0PR11MB5183.namprd11.prod.outlook.com (2603:10b6:a03:2d9::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.34; Mon, 12 Feb
 2024 19:57:40 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::7103:9cf7:fcc0:e802%3]) with mapi id 15.20.7270.033; Mon, 12 Feb 2024
 19:57:40 +0000
From: "Luck, Tony" <tony.luck@intel.com>
To: "Chatre, Reinette" <reinette.chatre@intel.com>, "babu.moger@amd.com"
	<babu.moger@amd.com>, "Yu, Fenghua" <fenghua.yu@intel.com>, Peter Newman
	<peternewman@google.com>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>, "x86@kernel.org" <x86@kernel.org>
CC: Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
	"patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Topic: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Thread-Index: AQHaU8qTZyE779HfV0Os6ryGu61IgLECMYcAgAT+mYCAAAHnEA==
Date: Mon, 12 Feb 2024 19:57:40 +0000
Message-ID: <SJ1PR11MB6083036DC25D4FA55B02589AFC482@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
In-Reply-To: <642f81da-669b-4057-8b97-2894dd57842b@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|SJ0PR11MB5183:EE_
x-ms-office365-filtering-correlation-id: b353f958-b9f3-4e7b-212b-08dc2c04de63
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D6cJfM6yIVGOAdpGGTyoYcbSZEkgwrtGsMFGnh36m0/Q4ZwB+PVKV+E+GuzopU6d0tiSFTo9VcHlLZFG2apxkxeNvj7MDr5mhN0mB4q7Zc2TNn6DsVphxSKPC4Se0nbpM4xBjdbIjbkXIVADHbeci9dDot7wc0EdQUo6/+oCInBvcghHLzS1vkc+/iDdHJ/1RpmbpUQSweWkw2WBeeTwVRHtw/2y5pWsGgvVTLcGuFX++SFzT9ab42MUmWr/verqhHT+wUWeE1aeoNcXJoTi/qozbUGeiycb+1UrJwTaZEMsd9X6nX9OzZFdSgTmjhDsRNYD+eak7hRSIGJC76Rzp4OpClP7YCSjXhTiLYJVGVVmSs9BL4vU1RZd4vdDBEgj8QTLJP6gYUPI1iDSsernSpAAxBINRpqMkSUP+7ip3ZQgUJ2L8N7epKa82Dafjzxlk5ydNXco7XTnn1gGC/zzR/5AC5mOAY7Vvhuu12/NAkQ8oVkkz4cSt1PsMQJm4Tnk7kcnWjjtf97JzxJ2zB2g/1xc1ADjHlDcFHFnMRHibK/pGj2A00lCwUMe1Pk02de8xO56UAOHF3i4sNbSxEaSVvI7grEReJ959bZfZ9oxnnuUumU185KY7Vu1EcTpVdB8
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(366004)(346002)(376002)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(38070700009)(26005)(41300700001)(66556008)(8676002)(54906003)(4326008)(76116006)(8936002)(66946007)(6506007)(7696005)(71200400001)(110136005)(64756008)(66476007)(66446008)(478600001)(316002)(122000001)(86362001)(52536014)(33656002)(38100700002)(82960400001)(9686003)(4744005)(7416002)(55016003)(2906002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Znd6RWs4aWhOUzRQeHZ3bS8wZWo4VHVDVVdlMzZDM2RIRHA2dW1MTnZ6VTJz?=
 =?utf-8?B?MitGM0pxNS9Xd0IzNEVySWRZVTNXRHFDY0N0ZHBjN3BSRUxONlorVi9RN0pm?=
 =?utf-8?B?eDlhem0zRUJJWVZCUXhvNHFoR3dUMkZPdnd5TElwZ0lJVG1DR2V2ZEVMeVFO?=
 =?utf-8?B?MzhjbVVScFVzdFhOYVBuVnJWMDRJZFJmeUladzZmelpUVUhJSG91M1dmcDQ5?=
 =?utf-8?B?c1NKOGhIQnlXUHo0VWo1T2crOXp0UFVPVENKUVdndDRvWlduTnRId2h3eFk0?=
 =?utf-8?B?bndQV2FSVitLVEsxekkvVllFcFFkK3dxK2hlempEcDZhQlJRWlhHNlNzelFK?=
 =?utf-8?B?VDhXT3hDOHRQb05GZnpNME01MXNLdDg1eUNPa1BydGNXejRDcmlNc2NsZldH?=
 =?utf-8?B?NGxic212bCt5OWh2SDhRdXJnZUxXZ293WTUwY3pJYnNXck9ZbkNjS1RKRWo4?=
 =?utf-8?B?L3UwTDcwdlVnNkoxYzN1RlN0QTFVUDRrZzU1aWJTUUY0K0dYbG9BeGppK0kz?=
 =?utf-8?B?L3lDcTQwbjl4TWdPTWIydUJLWnRySFBCb3BiZGtndmpmRy9BYUV4Z3d5NkVq?=
 =?utf-8?B?NTdFZXU3dS9iWnF1cElMQUp6OW5iMG4renJUaCs5S1JvQmYycW5iTG1aNnA1?=
 =?utf-8?B?TzlMRmZxVEpDNUpzWktFbXU3Mk9KeEo4UWpZdnBYVUZKaVdNNXJPZnZNL3I0?=
 =?utf-8?B?S3ZUZUo3TWcwUUdPZHZVZnhQcDBFdDdZbkRvNlQrbjhRNGVZS2Z2Y3FJMUhV?=
 =?utf-8?B?eHg3WkMxODVuK0s1VC9mclBoM2FUUGV4RnBQcElBMXhUWnllVlVsaVI3T1Jk?=
 =?utf-8?B?MVUyT3B4bVZDekJhYU1ORkJrcGxPVU00YnFkNnYyditBSlArdGtBd0lTQ1di?=
 =?utf-8?B?cFdBT1N0VWV4c3BZRkJjWUQvSnp6WU9laWY5R1BEd3lQTkw2SUZnQW9FVFlY?=
 =?utf-8?B?VVN1dnVKNGN6WWh5M3ZhN1hoRGs4TkJTOEVhMmFvM1VWK25DZzAxQlBzeWpP?=
 =?utf-8?B?ZitWZWh5c0hNOG9qVm5wQTg1ZGlyL3FEd2JERHB1MmgvNktKUjhQSzJPQWtE?=
 =?utf-8?B?SEdkdXJXdkttdW9WMGJ1bytlRnBkUUdYQlNRYWdWOUdHSFQ4UTVZb1ZJTU9n?=
 =?utf-8?B?bFY2STdLWlo3TndscDdyc0s1RkZTYUYraTVlbXhRbjVvUU16ZWNXd2JlVnlz?=
 =?utf-8?B?bVZpcTdJU1h4TEczU2JtbVFpa2h4Y3lOd2FZRGJ0RGhDUUsrVVduTVdaSTB5?=
 =?utf-8?B?WUpsL2RPckJ5UTl3dzRmeGdaTmJZcWo5cytCMWQ1QUp2U1VudmxCaG5qWmhY?=
 =?utf-8?B?UEtFZ1l5QUxEL3hjRWN2ZEVkK1RhU1BsY0ZIaUpBemFmcndSMjFrb2hCN1BF?=
 =?utf-8?B?NmVGZlJPeitsOFlUWnovUkNNZUN6cWRXZEZBekxJQ0IyQ2xWcVpheW9Zczl0?=
 =?utf-8?B?bmx0SkdFRmRGSVFKeHU2b2tucGx3T0dJMm1LNWhUUFNRc1R1STBhb2dUaUFr?=
 =?utf-8?B?Wm9oanpPSElUaGhjdDM3U3RBWnprTkZKZWxOeEtiYjdqUXBFakQzTE43VlFM?=
 =?utf-8?B?STZZMlpsUUxPalVpb3JLbHhxV0lRZG90Sk9EMkRTSmJObGdMWmtZcHIwRTMy?=
 =?utf-8?B?dFFjUUxYa1VhWnNma1ZrSjcwRXhuNzZPMGtEYVl5aTJudnk2RkpCalBudm5r?=
 =?utf-8?B?Mm1Ud3V1bnIwQlV3V0tYVXBoVzFTeVdsTVE4OWJwWlArbUpONEFrUTFEM3h0?=
 =?utf-8?B?TVg2aWlreHFZZUJ1QkpIZGY2VXgwWnl1SjlYRUU5WXl5cWhRS0M3b0NHU2Ri?=
 =?utf-8?B?OW1uS3I2RGNQcitZSGJuYW5zYzEwS2toV01qelExWXo3Y0h4KzVKNHRLQXV4?=
 =?utf-8?B?Rk82ZmJwZVlCeFVLcUw2ak9FVzBHNER4RWpjSVpBYUdXK1ZUakJlT3FkL0xO?=
 =?utf-8?B?NHV2Z3VWek9kZHJ6S1lYSkNOYnMrWUpjRDBGd2MvRENnMmIwdSs3Q3J4Y2NJ?=
 =?utf-8?B?YXB3UlE5YjZ3cHp6bndkeHJLTkRLODN6dnVmRFFtV2g0cHUydm5WVVRMV0JU?=
 =?utf-8?B?VjZYa1pJdW5jNnFVcFJjN1lqMyt2dHFXSVEvclAzOHJBN0JId2czd0RsVzJF?=
 =?utf-8?Q?bfnckReiFNa2YdVbPKAwiTnrX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b353f958-b9f3-4e7b-212b-08dc2c04de63
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2024 19:57:40.2016
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lZ6Q85r56oQUdUIWOES0f8TgbRNQldGNW6UWrgjozieZ4KN7+xsEmlFxCnwIppaZQuIiMswoTdLy+0t6pJ1wiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5183
X-OriginatorOrg: intel.com

Pj4gVG8gYmUgaG9uZXN0LCBJIGxpa2UgdGhpcyBzZXJpZXMgbW9yZSB0aGFuIHRoZSBwcmV2aW91
cyBzZXJpZXMuIEkgYWx3YXlzDQo+PiB0aG91Z2h0IFJEVF9SRVNPVVJDRV9MM19NT04gc2hvdWxk
IGhhdmUgYmVlbiBhIHNlcGFyYXRlIHJlc291cmNlIGJ5IGl0c2VsZi4NCj4NCj4gV291bGQgeW91
IHByZWZlciB0aGF0IHlvdXIgIlJldmlld2VkLWJ5IiB0YWcgYmUgcmVtb3ZlZCBmcm9tIHRoZQ0K
PiBwcmV2aW91cyBzZXJpZXM/DQoNCkknbSB0aGlua2luZyB0aGF0IEkgY291bGQgY29udGludWUg
c3BsaXR0aW5nIHRoaW5ncyBhbmQgYnJlYWsgInN0cnVjdCByZHRfcmVzb3VyY2UiIGludG8NCnNl
cGFyYXRlICJjdHJsIiBhbmQgIm1vbiIgc3RydWN0dXJlcy4gVGhlbiB3ZSdkIGhhdmUgYSBjbGVh
biBzcGxpdCBmcm9tIHRvcCB0byBib3R0b20uDQoNCkRvaW5nIHRoYXQgd291bGQgZ2V0IHJpZCBv
ZiB0aGUgcmR0X3Jlc291cmNlc19hbGxbXSBhcnJheS4gUmVwbGFjaW5nIHdpdGggaW5kaXZpZHVh
bA0KcmR0X2h3X2N0cmxfcmVzb3VyY2UgYW5kIHJkdF9od19tb25fcmVzb3VyY2UgZGVjbGFyYXRp
b25zIGZvciBlYWNoIGZlYXR1cmUuDQoNCkZlYXR1cmVzIGZvdW5kIG9uIGEgc3lzdGVtIHdvdWxk
IGJlIGFkZGVkIHRvIGEgbGlzdCBvZiBjdHJsIG9yIGxpc3Qgb2YgbW9uIHJlc291cmNlcy4NCg0K
LVRvbnkNCg==

