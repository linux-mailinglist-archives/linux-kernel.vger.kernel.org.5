Return-Path: <linux-kernel+bounces-122545-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0066788F93D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 08:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B2E4829206E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 07:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AFA51C21;
	Thu, 28 Mar 2024 07:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kzdZTdl4"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5075529CEF
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 07:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711612503; cv=fail; b=tOZvT1arz9efVIBR2EazOfSgvMkn7CfwTmxVZCqzSI+wtyoJHB0Jn6SmmNCOjniN/K30HCVwWk5tETX1BkgfftY+ncJ267LGIx/dkvnqXYdvDEb9rtwCL+n2ZkDjYVx4t+dSHmlbPI/diAkr/GyDGSdyhdv8LwYgCKXUGjpo5QU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711612503; c=relaxed/simple;
	bh=gAE+pqa+vhT16dTI3N5gfuaTkITjOp6ALK3k2YkPjVQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eD0jCDHe6xaANULUB1erjEiQV0nkjmQWILQ1hZMqlElAxaGB3uQztlp9MJR8Q+Rr7fMBLu1PPZa7sZicTNQXsrv5i8lgm1jU1wQhIogB4AWM63GjX2SF/T5UegF0deonoYFUixoYeXuXzoyOCeE6N0S8j3URsjn9OD9jF11Sddw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kzdZTdl4; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711612501; x=1743148501;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gAE+pqa+vhT16dTI3N5gfuaTkITjOp6ALK3k2YkPjVQ=;
  b=kzdZTdl4ey8SkqGRvVbFpTsXXpM0z60/HF40IH+mrT09LXsBrQq+jC2Y
   r0ZmgJVvrnuUoWwEncexUiN58/bXSTUoXPNCbqlfO8QHDdr/V4u33Cysy
   EUhx2m2a2R9rmI1/YGOo7RWV9i6PD/yGiSbzMnXIsTbB+wCXo4DrAzXLH
   CULKqX0udvzL9aJWOLgZHIIyNcqkwU+0nj1BHSk0jWbClALSbPkDvISxQ
   YrkHIB+DQMmA36GVVGldVBgsnY9vhWorETmqnL7Ng3Juxs9XgYzQhAjNo
   y8dYD1f7idPvDKt1IFfMxPvkyJJE1mSzHwUXTN+yTkC0mborPF3AFGKHL
   Q==;
X-CSE-ConnectionGUID: XGBXDAxOTYCIMTGiYItl/A==
X-CSE-MsgGUID: 4kq9Yd5YQqCybx8lXMGqjw==
X-IronPort-AV: E=McAfee;i="6600,9927,11026"; a="7349938"
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="7349938"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2024 00:55:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,161,1708416000"; 
   d="scan'208";a="17014744"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa006.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Mar 2024 00:54:57 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 28 Mar 2024 00:54:55 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 28 Mar 2024 00:54:55 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 28 Mar 2024 00:54:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaY0T/eJEnFjLwkP9z/LhlMYGt8ytqx3uaZeaOVuuAr17TE17jiHv5SnQQCk8wCt0Iu1xpKt7Lsypy2w/MrOp553qlY6J0coVl7FbXL8Yy6p3WyJOTtcSk2YAtwyrJdzFfXqgUSLPCivd6vWKQcfF5IKtrsvxbzjTXkuSOsjq7KA+8fs0DZjF7Uxd/tfAgeX2hUqq2NCF1DcGJFDH2LtuNbMBUvayuouuOkZQZE1XD+ddTfSQiVRFkkxTJKCpEeWs2oPMeHqDy6FTMhV4ZFO/nYMALhtXKqN7CpnWkRKP5yA/fHnCTJvZU6xjIkkFRNdpfEosOLRXX8g+kTNSgVFXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iIxllVplx84Hy+2z0XVgTCohTbqw1tFzcq/zjNtlwyQ=;
 b=dQl0NHwIp8DRwmYuKCMzkim1wSkyJOo7y7NjHj8fFa33c2uVZUIFBT+/5zDSjJYdMwF5StcTMZfhl5v5CZ26M6xZahuiVlN7HPuDIZbCzt0Mgrb5U40zQdyJlcivFJg2a68bNhv93Xulou7yJwLDqhlUDTGyTdA7Y2y4SE5IwtysgD2SencFSUq2RugH70wBUCH5Ob0nVRIjNbTEIH5xbwR1OjOmRCLIDE7ZMUxPlb9ur3ACVk6u5qysVztWo80gA6xqM/0Gk/SVx8xdlK7FWBx7LRG17ZCJOzcXO6i7Ylnw3j1Gk7Mxrc7p3u4fxm0UJnnheYlBhA+ROQGW6wu3jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by MW5PR11MB5762.namprd11.prod.outlook.com (2603:10b6:303:196::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.33; Thu, 28 Mar
 2024 07:54:53 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::6c9f:86e:4b8e:8234%6]) with mapi id 15.20.7409.039; Thu, 28 Mar 2024
 07:54:53 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>
CC: "Zhang, Tina" <tina.zhang@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 08/12] iommu/vt-d: Use cache_tag_flush_range() in
 cache_invalidate_user
Thread-Topic: [PATCH 08/12] iommu/vt-d: Use cache_tag_flush_range() in
 cache_invalidate_user
Thread-Index: AQHaflq3Y4+ZqXyBVE+xBvABX+dcELFMzT8A
Date: Thu, 28 Mar 2024 07:54:53 +0000
Message-ID: <BN9PR11MB527607AB4F81EF2AEBD3D7868C3B2@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240325021705.249769-1-baolu.lu@linux.intel.com>
 <20240325021705.249769-9-baolu.lu@linux.intel.com>
In-Reply-To: <20240325021705.249769-9-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|MW5PR11MB5762:EE_
x-ms-office365-filtering-correlation-id: b79effbd-6487-4629-09a6-08dc4efc5a3f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kugVOeu+EP/Gv5snFkwgOShGxGI01DE+sQxw9sKSxLb5ZXLMsgsXBBm+pUEwN9H+Gkaj2ixwY3vaXp9wMTXB/lhpEVWVUeZMRKojzygMyye1Z6i21Tzn4NwgBKG9/qqmoUZd9kQ/H+QTiv9COO4THv/UeFilPMmrxjE00+iW0yGx8UMpw1cRTZWVPMC2lsDh0eZOJzWns4+mcMakPUuOyZiPVvJRi3K7t6qZaMkbuS7DVGu8zkdrTSxtIM5QoBZ+gSHCQHvcTStmhXZFA4hEZbJxgSM4S8WeUE460eQV+Yo90KK3i999Hj8p+aXx/GdTOWsIHPpu9zv0W05yoh2243e+aRMTt7SoCtn/cP7ZdYhltVMRhJTse3/pkRPO6nekNlm9sul1ri6X6Mwj2K5VwchiDHD6N0lah2npjHcmxP6lRSBjH7OkgwNDhtL7QUGM55TUT5w8ZckJfkc19tGnQS20i6/Q9oErXsbE/voDBXWE/LPwuKkI8osQo8RlqvHP9/3X4zHoLGa+4wUTUMS/6CzIVPWHK22XlwGqZLTwavq/YEjb+ReFgWs8O51GD/vl0nGvHtLjbWq700JvgOwca53IoF4WCFCyKB7JlUfNrFV3fG9QZStTUhMnd3JTtqlcTppXYY3Xk2csNOZmtaZwrljfwRqJqQuKK/EvSgPJsqWqUsMCofhnL/lnVSQFAEhYkrFA8WVAJZOeaMqEbI7K0C8F41Uiw/WE7HUat4ida8w=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0RXSpNVeWplwvD829EoDgfarA+knuex6OsBkQpwXUvVNiKbLovmAj0M8QR9T?=
 =?us-ascii?Q?R91hrEvkoi7XhJdlM6gaw3WH3IHfvvCnlsX9bIqWQyK0V1ALvLcXL7H/ithh?=
 =?us-ascii?Q?xVeINYiTxcGWJ42DZs0fZUc6Boot2HAVJL5G4hnsSgg9HOg9zecXM4K/CGRF?=
 =?us-ascii?Q?iTyjIJoHrxrHQvsj/RJCSCB6kZkoIiHaujiEjKGeO741DmfwYDi5/LW/6US9?=
 =?us-ascii?Q?ARC8cWXa0E7THrF2Gqf2J3Fj83ssglyYwSCvHajad0IAM0PW633MHuB2hMdZ?=
 =?us-ascii?Q?tOJz6SDT7NEMVKthwgQIT5sNBqArZ0uLuamdLMtUjuTQTdcTPIM9tq2kIh1u?=
 =?us-ascii?Q?4fgbZdNX4GIXpBYGsaPa8nD4pJwDviLCxKuLK6ymjjuQ4bEotdA3pe3h5ftm?=
 =?us-ascii?Q?lctKbuMvxW6ZJWdH1AxTQbZ194ZP+1jZkuhgJZAmPpKuNHIjSdOHiu/L+BjX?=
 =?us-ascii?Q?oLIi+uMd1hQF77sKA6E8pr787DdV+aKDjCYw/MXL/W6MFgYwQYP41JZ2UVm5?=
 =?us-ascii?Q?+5ypfujaLcHu3yJGi8iuI+1FlnR5K/FaWpW5nEaynisM9oB7YKzsP1UF0Soc?=
 =?us-ascii?Q?mLMxZ5KA/3BwC6AVVIQvV31McGsYtWzVl/zezwTVx4Ud3HPeZ3iT0xbTI+BB?=
 =?us-ascii?Q?uRwqozbV0M3o39IqBAtIQr8ZzB+PktUqgd6eeqgmdjERz2zHt6x/aUy63wUX?=
 =?us-ascii?Q?pB4J2d1DUjYLRY7cav9abaYOeE2o71ctmrmGaIojTyPcquxIoiLU9Ztcw/4z?=
 =?us-ascii?Q?HAH2bSIiL/VRfr/JzjGtHQ8/+ujYA1FBrMmWY0VuDtOyPTLoAh3z8BtPRVZ5?=
 =?us-ascii?Q?nsfi8Zwh75Wh966emfL6FMs9XNUR4r8Qh8dqWDudTl3hSOQAgp/LpHp8YHa3?=
 =?us-ascii?Q?8VWvqLVl4e8MQmm5CH81Dg3qnyzlR8No+rKDTyMEU3B26v5Xzkb2ySxBkgWi?=
 =?us-ascii?Q?kKLRlzhRIcsZmyBFr/8evA8JtbX+L+hhalLiw7bdFxvJtLXlfiu1/7Nq3Eeh?=
 =?us-ascii?Q?+bXsDTdfU2NIh9buABysOynlLE4lrJVFTPkeGh1dA0m9CaSLti7KOgB6daMq?=
 =?us-ascii?Q?awPKx4B3CFZG+sCAQwxb6Q7fio77+gkIizP8iJXmRJeQTu6ywaLqhB5ANhc2?=
 =?us-ascii?Q?T1qGLDkC+gGM6zt8b4lHyzsSV78T48zhpfVgMQRaezQR1Uofe/MCoKAcOmIr?=
 =?us-ascii?Q?F2gonHGxVEsGV7Wua02MxfEP7PMPnwcDrZOVDnYPwrY17giJ6x7PVvTfMPfy?=
 =?us-ascii?Q?KbtETM9S7NtP5a8C6mNuyGswRQrMJBn953mn+xBv2uUsQLa3HPR8ZFsHOwb7?=
 =?us-ascii?Q?kjCS6M5Jf+wc/k7UDlfbmkXlAUIwL8hWG83fyKyNG3ITVmOSV3H+M6wokuqg?=
 =?us-ascii?Q?LQKH4NZXEUGWSPvIP+O3nBNEhW9IffsE62yuyXPM/+jelPwqofRUapHLxWTe?=
 =?us-ascii?Q?FkL8lIFXrzgsf8sf1TqYLslLf1xFdps0shmdM2GCyi7H7Gl7o/IQRk8Pkg5i?=
 =?us-ascii?Q?0q92vdnYMXT1iVyCmCxh+UPVeDXdzwyXZD3cL7krMETzOep6BZQMD8iIkUjr?=
 =?us-ascii?Q?MqULyub/8eLOODgmATMUkCVW/eKpXjDF0lBfNYEb?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR11MB5276.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b79effbd-6487-4629-09a6-08dc4efc5a3f
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2024 07:54:53.2367
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ORqZH3KRm5EtEL6hCmObhTuhu6bx4piVze5DXAliukZHwEwRAW0jpCmYqz43WSHzEqo0yQyKFQeG0nDSIHbyjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5762
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Monday, March 25, 2024 10:17 AM
>
> @@ -166,9 +122,9 @@ static int intel_nested_cache_invalidate_user(struct
> iommu_domain *domain,
>  			break;
>  		}
>=20
> -		intel_nested_flush_cache(dmar_domain, inv_entry.addr,
> -					 inv_entry.npages,
> -					 inv_entry.flags &
> IOMMU_VTD_INV_FLAGS_LEAF);
> +		cache_tag_flush_range(dmar_domain, inv_entry.addr,
> +				      inv_entry.npages,
> +				      inv_entry.flags &
> IOMMU_VTD_INV_FLAGS_LEAF);

the helper requires an 'end' address but 'npages' is incorrectly used here.

