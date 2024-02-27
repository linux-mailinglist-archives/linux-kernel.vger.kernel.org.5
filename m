Return-Path: <linux-kernel+bounces-82805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D648689E2
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47F391F21E26
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBF6254F83;
	Tue, 27 Feb 2024 07:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GD7butdJ"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5264654BE3
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709019179; cv=fail; b=oZiJeZTE9ZkxsWI2tTqXiFCctmaCy2khMzi7+a4bqqgbCRBlzxxGcSC6NJKErrrEYfexKcGRtR6wqYLpe+VSDASZkmwapHnF2/+T5dVVHCTRFw4WbQfqTbNGB60ZhxXYLJCueY7tjZrnbNvL8hgYcgRnUtxyascuHwszbQdpd6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709019179; c=relaxed/simple;
	bh=kpzYoCxQeEGyhi7NySB3mO7MVK2/nAc7owPS6Sg7H4U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gw7aeIogOaFZxo84XmEJjX25z+2fcScN8QCrnvN8PUPQ8+tRctRrF5Dyr/Usg3EwOq/diKZAJV5vEs0N9/8aOcsvbhi87Hll4ojLltmbpl0sr0+FbTNe++5jUKmSCcvL2iINZWc1zT4K8dShvkTlz/x0IOVNljQ4dHb2TALS234=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GD7butdJ; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709019178; x=1740555178;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=kpzYoCxQeEGyhi7NySB3mO7MVK2/nAc7owPS6Sg7H4U=;
  b=GD7butdJ8mxTpRD8JnE9yIi7n6iJetPZQFhuGyLRSdW0Tv5ByLob+xYX
   uM6mbLt3FV8twze4r64BDp1g11fR9kbfYXHAhkX783gSEyR1lY/WIFmxi
   5BPpfwIVQR4/P5JI12u5dVnz5VWE5qhK4V28NAQ84wO2uIn2iM6MztDcT
   P3CpdXxIocZSUCNnwEr4t3rniONmQ1TinIooqWtB7u0veiAb/hMX6MlFw
   NtbD5Hx3AdcxUBgz1NqRw7g+aTs1zPt4oPphLGYPvvztzr/cDRSwi3dgz
   wjKfa1SpkeoDKbFhtpN4fhv4wbGRhIdD+jaDe8q8WUYdzW2GgcF2Q58hZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10996"; a="6294753"
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="6294753"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2024 23:32:57 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,187,1705392000"; 
   d="scan'208";a="44444955"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Feb 2024 23:32:57 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 26 Feb 2024 23:32:55 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 26 Feb 2024 23:32:55 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 Feb 2024 23:32:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BnXeOoAsnlgZteTbArha/n9Yd2mNTgfLrLpUOHDN0Qm+YZmp72SSY5w0Mjl297oh7U73SMPCwG/zvE+nt609DZ8uBQLqW4bBA8rL8rjNXE7fuvnQw2YKijG5RjXetumNLuul88WIgHXUVED0aT2m3ezdRuVMvz1sW6tNEhsaqmTbL0QR80dJDSI9owOIgW+wf+4+Zqc6wPEvy5rdylPMWKxhVsOlHfwqF3Wj+ppIn8+OKv0cA/3dLnEDz1xQPbw7oMoS9woc7/mpC1ytfLpdFjpEzPrKzTco8hxtD7RmqZXHUdpPb2+jpYnbU2fSqvLtCT8D/W9o6rrl9LDyEhtOQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rb64909GqSCsgl1ufqkfDIxArnkwYrlofzQM7+kSUs=;
 b=LY0VPJWUz6+igLdkJ+34+47s03HNrnczHIPKNXdBY9Brb1CrChHgpHnr4aj7PvmLmOTW46t/dhl/Sq2DZvN7N8YuLSrWIP2/IYwJDDPQTH2H195FfZX/tx/Cee5MHIYqJadZ4KjCikFdqw8t9EnAmwaYq83yNijUmekU6tNMfiFWMsME8un+TcW0caGmuHqsIksOBk9oiGkFLPlI5RTWnUEQA/PMxZcyuxyUTSbfCkQs2iUl9bFWLWtR5vzuTqfsBt5xd9/hQBEhjyjWA+NLnO2vSi4yw/8hqOf90bLU5A3lzvxdrkkwyLYZVwcO/m+fs8Fr50KqVk0ajnXPg/f8tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BN9PR11MB5276.namprd11.prod.outlook.com (2603:10b6:408:135::18)
 by SA1PR11MB5802.namprd11.prod.outlook.com (2603:10b6:806:235::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.22; Tue, 27 Feb
 2024 07:32:48 +0000
Received: from BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80]) by BN9PR11MB5276.namprd11.prod.outlook.com
 ([fe80::b0e3:e5b2:ab34:ff80%7]) with mapi id 15.20.7339.024; Tue, 27 Feb 2024
 07:32:48 +0000
From: "Tian, Kevin" <kevin.tian@intel.com>
To: Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, "Will
 Deacon" <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, "Jason
 Gunthorpe" <jgg@ziepe.ca>, "Badger, Eric" <ebadger@purestorage.com>
CC: "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "Jason
 Gunthorpe" <jgg@nvidia.com>
Subject: RE: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Thread-Topic: [PATCH 1/2] iommu: Add static iommu_ops->release_domain
Thread-Index: AQHaZhfWSts/o3gWZUiBf2rMTcLEo7Ed0cuA
Date: Tue, 27 Feb 2024 07:32:48 +0000
Message-ID: <BN9PR11MB52766C0E58E2CB6989E0EB608C592@BN9PR11MB5276.namprd11.prod.outlook.com>
References: <20240223051302.177596-1-baolu.lu@linux.intel.com>
 <20240223051302.177596-2-baolu.lu@linux.intel.com>
In-Reply-To: <20240223051302.177596-2-baolu.lu@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR11MB5276:EE_|SA1PR11MB5802:EE_
x-ms-office365-filtering-correlation-id: 90ed2886-9e5e-489c-64bc-08dc37664c24
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmVlXPlhkPnNwWPtqitaohujv890UKdM0cuCFXEGyDXxbvrQRiwQDyHvygEG/GOf2rlaK/DqUTQn66XB6aTyiKVFhFzSO1HIOeEG9XTf9OxIAQfblqTOlZJx7rT4xBqIkVkOo/aV66FPeYl9bWYCMxXdBQiIkVJjIj7pG2RQeBibasE2XPw00A4vcr11QucnWBjU205QlFEMoLsLQdxdS/ORd6C1dv+50EznSedvMcWQq4urNTviy7enp1eALCiRC+n9B9Hmb5LPT3mnYnvuT1pgJBWz0WmHe73J8vqc7CdglP5/isZbk6uX/elpTQWEBgkGFlY/O7NNrvEDgXfOZJonzS6ApD9b7/lmuTSOO9ryrYl3ProuzJ/c+gnQ0ORAsLp0puhwbkIY5J/OwBBfpKeSxqNRpedvAhuD71tEHMO6pG9FRe3koYMZX4x7+MKNS7eREzaRzHt5RC0jIQ5HIeRzAOXn9MwANEyFOpeivjXXYvaj9/kiGTAX+EoXDneQ1U+bmhtBeyq34cVot1eLDFZx3gHYNxvpMttV/EB6+1ol7fybZjhSOQm/5xlFTlUGfGkHdw84P+3qWGJ3a5VIn1GzgM5YN5CoQFFAvOLl/uUr99wNotL2sNvTvtwG5NpSR89JFZLHF89EAJL3KuK+Z3QojjShzXIKH20vJVLLS3tFuJpRrDT23fSJLANr7CRH4RDuesOvLU+a8/ppCz5yLA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR11MB5276.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Y5FBt1X1tBTlXk8FjEvx2x4W+56nGbsLa7adV8AtGlfDmNHSNvou7DLky9X2?=
 =?us-ascii?Q?B8QlwXe/LSksxaAabeiisy3V+AHWI8OmzAvtCAvHQ7r3gA1YB6qoiP3yKt6O?=
 =?us-ascii?Q?rOBttI6fuR2E0Uw/zvHIkLU6Cb+ONcICl3eb1eRO09Onpk/AH7HT22bnFzmc?=
 =?us-ascii?Q?xKrEfYgMb/srNgE2+EiXAwS4bEM5AudXRECFOUh00VRTReX726QLhQMHyexo?=
 =?us-ascii?Q?trxIyrUOmDcva83jVRQoMO7re4RyQRPAKOJY0pHtP9ABStzDWfdEMt0CC+EN?=
 =?us-ascii?Q?hoDlHS3lUEAWuOg8ILnuG5lh6EIls0lh2Nt4t7ckTogGiZMwmG+QhecWDawx?=
 =?us-ascii?Q?7VVOYOWVv3rqwgEUpC2YT9hNQ1v5e4Gjexs1VWNx3q2JjLCwp5PhBMRbMOeP?=
 =?us-ascii?Q?TR6PR4VDI80yGVTfIZNUqNqBdsvSxIHC81hovLPXIOunw3D3RC1OskTxDcH5?=
 =?us-ascii?Q?3xrFnG4QwWPgfS484wGKR6lcDAa73oZt1Y97azYuxs4H3EKfBlMUhcC42KDX?=
 =?us-ascii?Q?0hP/lXNDpZZG4a65uIVxJ57nYYoZ8BNwbrqEEH6j09DakyRh+DKrvei//6vI?=
 =?us-ascii?Q?Q9uHQE+4iv8AIrVJBy+mnOPmWi6He0HP9f89oIlUFUP6etU4GLRrKsWfzEVB?=
 =?us-ascii?Q?VSv40Laez6YOFpIER4T3A2k7OCGn+VXlYR/adDrN5/YTa3DodnZoOzmNpEqm?=
 =?us-ascii?Q?NDaVcUMJxqsU5ICkkTQC+C5GaiKpzxnd+52WmbHIlioDEkp6RSCgJ4R3332A?=
 =?us-ascii?Q?yyNJIvhlajPCVMNqZMkc/BHEVJHIgTKi6QfqnSB61MS5JuCKlQBZkpsNTC0L?=
 =?us-ascii?Q?6mbb387U7cKpaVO8YrW8Jxk77gdzDGz8EzK5DHCcELtlKU9xg3oGpNffuDEE?=
 =?us-ascii?Q?q7D7s0ecJkq2+DOejCe2g0eR3pRf8pFVGiG0/Kyht3oYXB3q7O7xtMewC5fq?=
 =?us-ascii?Q?dC3/+i1Rh7O3oEqZbrTALv6/KapuRul18FPY57QA9R54RLpPFiXE4+LgY4PX?=
 =?us-ascii?Q?+iPayfBeU7Y5SSvvM050u6OPwamYLtlN904sy546ex0GiYfYHw8kdbUTxffM?=
 =?us-ascii?Q?MZCKZB5fVuXQYRCZm+QzU5nZXkenNQwpmWcYwLgqyIS9xzhJ6Cg8cd0cBis9?=
 =?us-ascii?Q?FO82+nVoCyLp8VTOTCKN65PTxKJ/DLYyQPtWPHb8R19o4RBb5Bo63ctcM0sP?=
 =?us-ascii?Q?Qt63x5Hv0wRao8C794eO+oCkZ5vf9yOuVvJRsFrXT+YyXPNDrszEHIuu+lzx?=
 =?us-ascii?Q?T9pPpeULJq57aIn4dwdYXwBP7AaNh1ycEtMneYvj7ZhcApH2/5zEURvlrwv9?=
 =?us-ascii?Q?oBBWe3SqTqpY2J5olk9TI35w5REYRXy5jrHfWDHYJ4vASQc+LhAoX6cEws2J?=
 =?us-ascii?Q?glkl2mu06cfudds/6TdRCvOFHjpw2v2l6O7lGjm6YbSkShmSGsT44G0q/6yx?=
 =?us-ascii?Q?PL4vYA4z4hI7lA0nANPJA6TZWVORckfmkZftwnozj7tE72nMmvYcaG22OUVV?=
 =?us-ascii?Q?cSnsyHs/yOiJO2SOXSCKYZ3LjQjirYEu1y8Cwcq+UPWmqkqN3fEnFHH4CHxP?=
 =?us-ascii?Q?izR6p1B4+GtN/lKbyF9qqaxucMCLK7Mm61Flb/Cv?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 90ed2886-9e5e-489c-64bc-08dc37664c24
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Feb 2024 07:32:48.3057
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Fm7Yaqmp+qAO+plLO8kjjtwRdpiW11Mwmyla6X74zHypG1SdPHaYv2P2wtAJaDdKu3SDaxJdUrDusV1bXd+0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5802
X-OriginatorOrg: intel.com

> From: Lu Baolu <baolu.lu@linux.intel.com>
> Sent: Friday, February 23, 2024 1:13 PM
>=20
>=20
> +	/*
> +	 * If the iommu driver provides release_domain then the core code
> +	 * ensures that domain is attached prior to calling release_device.
> +	 * Drivers can use this to enforce a translation on the idle iommu.

'enforce a translation' is confusing in the context of blocking/identity
domain.

otherwise looks good to me:

Reviewed-by: Kevin Tian <kevin.tian@intel.com>

