Return-Path: <linux-kernel+bounces-85405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73B9286B575
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BFC2DB277D8
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407943FBA8;
	Wed, 28 Feb 2024 17:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YdWYNWwV"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8164B31A81
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709139737; cv=fail; b=MGpiLZX+UwwyV0/y8Vr6yv+Gmx/+jlQrzQqvJDnVXI02WLCZD3emlNwlkukHlm96oh19yNEkYwZHEFyqlMPgwf28gbgsrRI9qgT9E+vn7xmey/A++SnzOmu47utTexKC7XTDxHpbHM5LvhZ6F0JNNUUr9OhWIJoHxwj/iIEsZl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709139737; c=relaxed/simple;
	bh=uGRN+3oaFxU0Y3epI2c07RXh8LIuEYCAmFHVSNpi2bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K5oGpP302LuhX8mBfHCmYRswUXCFiE0XsbJubsaT5gEAXBkl3X3qbYpADs6Ghk7WYazLTu3y2R98jD3QDf9a7ySpFsQfKDTrNeeJvxpFJ6QDXcGklw+YSko/rQn98FwDZFVlWxvhz8LAnlbHD3xJFgfMHY1aNVK4rMGP1a1Go+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YdWYNWwV; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709139736; x=1740675736;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=uGRN+3oaFxU0Y3epI2c07RXh8LIuEYCAmFHVSNpi2bM=;
  b=YdWYNWwVc6yAZ90qgGy2ajvBsqVmsYMG5IqOZu2ZmFwHkoyOJ6ZgWYla
   ZR0PtTdIMIJ16qB5lpEwTbrsxT1Kt/XpjUf33BTKGoq17L0bN2Z5jfRDy
   sOyxYnDEhRF8HR9fbGT9IIhxhCglnDTByUeOOWwK3sm3+rFqj5v7r+lZw
   CjZP4oIdGNFjfXFCX+gbpY4nwtnHRN5yP8ZodRVuvGSs+9AGsNHh9PlGG
   QyA6Ql/5tKUaQLvrlNpXi5ys+OO8O/gplKJAO0owGdbnSKf7FksbJUHQO
   1LNukS7p2XVGBQh4DVxMZtbE/50K40urgbEY107+LXi5VH9s4EyiR68Lj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="14700599"
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="14700599"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Feb 2024 09:02:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,190,1705392000"; 
   d="scan'208";a="30680610"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Feb 2024 09:02:14 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 09:02:13 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 28 Feb 2024 09:02:13 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 28 Feb 2024 09:02:13 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 28 Feb 2024 09:02:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LTACzmRQ2E7W+RtHiFJ4jOgJzhaBR5x5Yo+8xYJJInRFGDXKeogKsQhvm8/fEYJzt6+LGSpTNqdtT6oTDrKM3Vyda11MycWMypLS/cN6xMieoLmGhp1aXo1JKiLDbaZQ/ZboGJlZCT8cB495R7UXideS586jzw+FIi+X9ns/fPA9dPb1CvsqJA2P7cBXmLz1IWhydiQrAdcMUzvnYW5wvHGdB6GSAlXhxKAn8IAbppUTMU9mzr7b2cIEA3DNu6pNsTJexWkbdgRrWiGGvRsPwIFFA1TyITnijf6FXuaBa8JYDQ60xj+U4q7OGqBxcVckkdPRblDC7LbQHU6QJ7ywdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uGRN+3oaFxU0Y3epI2c07RXh8LIuEYCAmFHVSNpi2bM=;
 b=QRWtXFX0le9vss4+CHIjaAZex03nL39ucZTsrb57fxtU60d4/8eLGflcBL5rNH0uqHWQKj7p9sU7CILcqqEriBHWaBDAeo82Mp8SMWCFKnC013LsIBwK/rJOQlZPgpDMvLCY3UPMJkfIYhAWtjn7LqGd2NVsUl5psFbH2RdVZdjpv82iEs+cohb+HAiFVPQ0SEVvE/8ljS0Uw8N9kngKHT7KMQtQCP5Nci5SlllYTlGmSehd+myuverrL00bcqcF0iyd1vVwdJQnM8FGAr6yZK18blBBUmjleNQmthNsdPzxWC6RSj9WfwUY5R4JHyWBtetIEMVMTJTQyqAR8ugCzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CH0PR11MB5444.namprd11.prod.outlook.com (2603:10b6:610:d3::13)
 by DS0PR11MB7959.namprd11.prod.outlook.com (2603:10b6:8:fd::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.20; Wed, 28 Feb 2024 17:02:08 +0000
Received: from CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::f061:a0b9:4a91:b27c]) by CH0PR11MB5444.namprd11.prod.outlook.com
 ([fe80::f061:a0b9:4a91:b27c%6]) with mapi id 15.20.7339.024; Wed, 28 Feb 2024
 17:02:08 +0000
From: "Cavitt, Jonathan" <jonathan.cavitt@intel.com>
To: "Souza, Jose" <jose.souza@intel.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "intel-xe@lists.freedesktop.org"
	<intel-xe@lists.freedesktop.org>
CC: "Vivi, Rodrigo" <rodrigo.vivi@intel.com>, Mukesh Ojha
	<quic_mojha@quicinc.com>, Johannes Berg <johannes@sipsolutions.net>
Subject: RE: [PATCH v2 1/4] devcoredump: Add dev_coredump_put()
Thread-Topic: [PATCH v2 1/4] devcoredump: Add dev_coredump_put()
Thread-Index: AQHaamc4/LAG7+PoyU6obycPRtLU1bEf+oEA
Date: Wed, 28 Feb 2024 17:02:08 +0000
Message-ID: <CH0PR11MB54448969FA8ABBAEC9F44161E5582@CH0PR11MB5444.namprd11.prod.outlook.com>
References: <20240228165709.82089-1-jose.souza@intel.com>
In-Reply-To: <20240228165709.82089-1-jose.souza@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH0PR11MB5444:EE_|DS0PR11MB7959:EE_
x-ms-office365-filtering-correlation-id: 6e41821c-f767-4420-7dcf-08dc387eff85
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EJo3x5rjrXY/oamkjb9/RmudHt9cCdJ9ct6JKHsRcasG/CRN8H9MB3G9nTREdwubawuY3EjT1JVIne9IRXElW1+++Hd7OfFFS/iBDZh6UBCriwI6BHcTeVisqYvVzE1DLaaSLBC+Cx55cURDhF7PJ1Hv+p/QKS45oNdt7a/+nJQz35oYE40eNrabj07sAJB8nPzrm2CmOWpsAu7FcIrMnswsjfoCLlZqqYWlwIcN6xUfm/lgzSmI+f2ZHcZMMXJ4AfDlG2TMR0he8olPAIzNYFUYBV7c6Ji+SrYLBX343E122uOyrV47IIqON2DCMN5Rx7AEjIbzmomn72eBcwMxrdbx5OmbGXnWL8lU7NfXlHQ9u1pHIoz2bCkqHOvITLjbyMKdkSQ8Jr2In6eMNCIC8y0fz8iWkuKgWlt9eZz2mr5kHXGG6BrETKxsCSZJJ/+lVYyUHktidWePMS4TqsEBkfrvtUrB1mZ8lN4asaa4+FHWD1smcjj6CNYEvhwOeKffxbYTjfihg9HIexTN7aIjW92PW6LRYk8aFNH6G2pZmWZT/l4XItlvwHUYoC4H3us/8NybmzzYSWgH22V/p94CCuLOv5Zl3qM6as0Z6SBDY2qybeItHrqETs/jT7giAjCb+sNXg3dsJSzfI/GEU7xovAPV34N4HijQdRYRRck08ms57j2RXMcX72rDqwvkBX0fX2XeyDI8vMztd2VdQD286/tb0mdirlAhjlHrTEQAZmY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB5444.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?anBhblpwQ1dLMVJOTzJjRkhhSytxT1JCODVpam91MFU4cHNVODljdVFiYlZ6?=
 =?utf-8?B?VUhtNWRPMW1WbGd1VnNDVkx2c0NYanMvUWRWb1BpaTV1TlZueFZTTFR0aDAx?=
 =?utf-8?B?QVVJTEJNUE1laFU1SExwVlZVQ1RaVmFTOVV0aFJKekIrU0FyVEtrVkNxZHNZ?=
 =?utf-8?B?OHJFWGZpVVpRZkl4RnpiVFJXWmFkT2h6aEZLZGNPazEzV2s5SE9Hall6bXp5?=
 =?utf-8?B?eHNkZGVOcDR0OFl0ZXJ5RGVWb2VXQys4YmJtS3FZVTNUU3RFVVZ6R2ZUMGxr?=
 =?utf-8?B?TkVJcFd4YllHWE1VT2Fwb3dKSmZVQVh4OFcrSUQ4RmZOWjU1QUVlKy9qdWJQ?=
 =?utf-8?B?OGNpckowZnNJMStuTlMwMjBuWUw0T0ZSemF5NHRmSDRsTGJQTm1vSkpDMFJs?=
 =?utf-8?B?cTdNdU9ncUg1a282ajgvYmZvWUluMGlFdmNCVlJ6QjU2Y3kzY3l1K0Y2TE55?=
 =?utf-8?B?UFFxTzlMVVE4WC9EQUtKdXFHSjdpRDJGOGtqMFB5c1F4L3dpcFJFMEdZL1NU?=
 =?utf-8?B?SGFqQ2dvMXVlWUdiMW1QU3k3MGV2WlVXSXJyd25tK1A4YWoxbndxa09ycDdk?=
 =?utf-8?B?bjFtUHhJTkh4dlJQQ3M2WStkNUF6aUphci9qelBTZ0dmeXBpSDhuMU1JMkdX?=
 =?utf-8?B?eFhud0JtUUNsZVFsMFhUTkxIQTNuN2NnRXc2WFJrMDlVUmIwNkpzakx3TTZo?=
 =?utf-8?B?V2Q5TTVXN2t0MWtRSzgwSWw0eE5jRFR5UkxqMGp6MmxKT29SSHVuVFd4UWdD?=
 =?utf-8?B?cGNxVWcyNlBDOE16TnZHb0ZyZjg1dUNOcnFHZE1PdjJBalVUeHFJMlhTYnZ5?=
 =?utf-8?B?OFNOYXpSVHZCc0VKQXpKTExVa2tMemxZS05mSHRIS2pnYWV2OVFCUjJmZ1Y1?=
 =?utf-8?B?YStHRGE0aGdEVFpENmF5bjUvZTEvS2RzY2dJL3VNT09nN0poRFhRdXQwZ29G?=
 =?utf-8?B?V0lPZEpiOVV3YUkzT0c2dVA5L2lWdGpLOEQ3ZHpLcm1VOHdSM0tBSUlUM3hl?=
 =?utf-8?B?MW5tMDZWc1lvd0w5TEhxc0JnbUVzR1BGanNQUllkQzlrRnVRbDBBUVJrSW56?=
 =?utf-8?B?TCtBTC9iamxpeFdtaFNjU0RpR3JGTm1ObDFUaFlBOWN3SjhXMkFrbnZteUNC?=
 =?utf-8?B?Q3hxMEp5TzNlTGZIeW9zU3N4ZnJ3Znp2Rm04ODk1Zjh3cVpaZ04zektkVnkv?=
 =?utf-8?B?MHgrSi8xMFdUYlBDdWJjbzFISDc4RW1BVVp6TG1UUk9SVEZnd3UyZ0RBQnN6?=
 =?utf-8?B?aVNuVVErRDFuaGZyRVFsUTd2c2p0UzM3cytGVkFLTEFnVGd6T1N6WlN4WGFh?=
 =?utf-8?B?YkxUV3E4YzNhaUN1YkcrL2ZmQ0FDUS9vZlFSclp3ajd2QUhkdmdQZHpCR0M3?=
 =?utf-8?B?aCtwUkRBOWdlb2dnRVpDWUh6OFo4azRkNlFud3lFTDF4RGNONG1ZUEthdDR1?=
 =?utf-8?B?dmxWRTRsMFd1bHZVWjd5UU9VckV6d2RXK2tFQlRxaFpoNjVBamFnaklhTU9z?=
 =?utf-8?B?VnNIZU9nYXZOQkhvaWNqa3J3dVhkT21IT0VDUXNmQ1pXNjRXZW9ER3dsS0pL?=
 =?utf-8?B?VUNURXhJWDNLU1RXNXNnMFRER09pWi93Z0ZZRksxUjBMcVNvSG90WkNjRE9i?=
 =?utf-8?B?RnpIQlBncXVhc2xRREVJVUEyVmhTc3VTancxUVdIcldZMC9NTklnYzIzQ3M2?=
 =?utf-8?B?b3RSMkxsb2tYWHFwbjR0UHErN2VMMU9XUUlnRVhmS3p6a2lSUm5QL3Ewb2tX?=
 =?utf-8?B?bU9XaDliYURNYUJpRnNDV0M0ODYxQWlqY2Z6bGZpZWI4NGdEcyt3dUNvcEwx?=
 =?utf-8?B?SzdIcXd1QUZEOXkzTWZiWi9JclZPZm5ycjRYd3BLWE1aSEtqME94M3A5MGtO?=
 =?utf-8?B?QlZCUGNySVdKQXg0UWdTYzgyRkxOeEJMbGd1STBzTTQwZWZ2Z2hkbmJuZFA5?=
 =?utf-8?B?Q01iUnMrQlJHTmFmenB0R0twNUZnUVd1anF1SXp4aExreXhUSmllWVBycFZ5?=
 =?utf-8?B?UHNqdGt6MzRVQnZ0cjZzMmY0aE0wbEZkYjR5MFpUU2pTNmNzaVhzM2Y5YVVY?=
 =?utf-8?B?djl2NVBaM0tYTEhyc0M0aGdDZFJCTGhZbkNEZWtUdHZsT1pHUlBMM1NabVc1?=
 =?utf-8?Q?Ux+R4eSQcRQ3budzmy+oOrEHp?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5444.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e41821c-f767-4420-7dcf-08dc387eff85
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2024 17:02:08.3383
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6sqF2UjknqB9gNalgpCDaOwl20yojyUdTjcYOBG56LkLDitymIM0uxs9ZlzMye/xwXVSuNmpsDYFabeV8Zw+blpDHPhpuT0K4aBZx7/9M3U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7959
X-OriginatorOrg: intel.com

LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFNvdXphLCBKb3NlIDxqb3NlLnNvdXph
QGludGVsLmNvbT4gDQpTZW50OiBXZWRuZXNkYXksIEZlYnJ1YXJ5IDI4LCAyMDI0IDg6NTcgQU0N
ClRvOiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBpbnRlbC14ZUBsaXN0cy5mcmVlZGVz
a3RvcC5vcmcNCkNjOiBWaXZpLCBSb2RyaWdvIDxyb2RyaWdvLnZpdmlAaW50ZWwuY29tPjsgTXVr
ZXNoIE9qaGEgPHF1aWNfbW9qaGFAcXVpY2luYy5jb20+OyBKb2hhbm5lcyBCZXJnIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0PjsgQ2F2aXR0LCBKb25hdGhhbiA8am9uYXRoYW4uY2F2aXR0QGlu
dGVsLmNvbT47IFNvdXphLCBKb3NlIDxqb3NlLnNvdXphQGludGVsLmNvbT4NClN1YmplY3Q6IFtQ
QVRDSCB2MiAxLzRdIGRldmNvcmVkdW1wOiBBZGQgZGV2X2NvcmVkdW1wX3B1dCgpDQo+IA0KPiBJ
dCBpcyB1c2VmdWwgZm9yIG1vZHVsZXMgdGhhdCBkbyBub3Qgd2FudCB0byBrZWVwIGNvcmVkdW1w
IGF2YWlsYWJsZQ0KPiBhZnRlciBpdHMgdW5sb2FkLg0KPiBPdGhlcndpc2UsIHRoZSBjb3JlZHVt
cCB3b3VsZCBvbmx5IGJlIHJlbW92ZWQgYWZ0ZXIgREVWQ0RfVElNRU9VVA0KPiBzZWNvbmRzLg0K
PiANCj4gdjI6DQo+IC0gZGV2X2NvcmVkdW1wX3B1dCgpIGRvY3VtZW50YXRpb24gdXBkYXRlZCAo
TXVrZXNoKQ0KPiANCj4gQ2M6IFJvZHJpZ28gVml2aSA8cm9kcmlnby52aXZpQGludGVsLmNvbT4N
Cj4gQ2M6IE11a2VzaCBPamhhIDxxdWljX21vamhhQHF1aWNpbmMuY29tPg0KPiBDYzogSm9oYW5u
ZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gQ2M6IEpvbmF0aGFuIENhdml0
dCA8am9uYXRoYW4uY2F2aXR0QGludGVsLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogSm9zw6kgUm9i
ZXJ0byBkZSBTb3V6YSA8am9zZS5zb3V6YUBpbnRlbC5jb20+DQoNCg0KQWxsIHBhdGNoZXMgbG9v
ayBzb2xpZC4gIEFwcGx5IGFjayB0byBhbGw6DQpBY2tlZC1ieTogSm9uYXRoYW4gQ2F2aXR0IDxq
b25hdGhhbi5jYXZpdHRAaW50ZWwuY29tPg0KLUpvbmF0aGFuIENhdml0dA0KDQoNCj4gLS0tDQo+
ICBkcml2ZXJzL2Jhc2UvZGV2Y29yZWR1bXAuYyAgfCAyMyArKysrKysrKysrKysrKysrKysrKysr
Kw0KPiAgaW5jbHVkZS9saW51eC9kZXZjb3JlZHVtcC5oIHwgIDUgKysrKysNCj4gIDIgZmlsZXMg
Y2hhbmdlZCwgMjggaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmFz
ZS9kZXZjb3JlZHVtcC5jIGIvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gaW5kZXggN2Uy
ZDFmMGQ5MDNhNi4uODJhZWIwOWIzZDFiNSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9iYXNlL2Rl
dmNvcmVkdW1wLmMNCj4gKysrIGIvZHJpdmVycy9iYXNlL2RldmNvcmVkdW1wLmMNCj4gQEAgLTMw
NCw2ICszMDQsMjkgQEAgc3RhdGljIHNzaXplX3QgZGV2Y2RfcmVhZF9mcm9tX3NndGFibGUoY2hh
ciAqYnVmZmVyLCBsb2ZmX3Qgb2Zmc2V0LA0KPiAgCQkJCSAgb2Zmc2V0KTsNCj4gIH0NCj4gIA0K
PiArLyoqDQo+ICsgKiBkZXZfY29yZWR1bXBfcHV0IC0gcmVtb3ZlIGRldmljZSBjb3JlZHVtcA0K
PiArICogQGRldjogdGhlIHN0cnVjdCBkZXZpY2UgZm9yIHRoZSBjcmFzaGVkIGRldmljZQ0KPiAr
ICoNCj4gKyAqIGRldl9jb3JlZHVtcF9wdXQoKSByZW1vdmVzIGNvcmVkdW1wLCBpZiBleGlzdHMs
IGZvciBhIGdpdmVuIGRldmljZSBmcm9tDQo+ICsgKiB0aGUgZmlsZSBzeXN0ZW0gYW5kIGZyZWUg
aXRzIGFzc29jaWF0ZWQgZGF0YSBvdGhlcndpc2UsIGRvZXMgbm90aGluZy4NCj4gKyAqDQo+ICsg
KiBJdCBpcyB1c2VmdWwgZm9yIG1vZHVsZXMgdGhhdCBkbyBub3Qgd2FudCB0byBrZWVwIGNvcmVk
dW1wDQo+ICsgKiBhdmFpbGFibGUgYWZ0ZXIgaXRzIHVubG9hZC4NCj4gKyAqLw0KPiArdm9pZCBk
ZXZfY29yZWR1bXBfcHV0KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gK3sNCj4gKwlzdHJ1Y3QgZGV2
aWNlICpleGlzdGluZzsNCj4gKw0KPiArCWV4aXN0aW5nID0gY2xhc3NfZmluZF9kZXZpY2UoJmRl
dmNkX2NsYXNzLCBOVUxMLCBkZXYsDQo+ICsJCQkJICAgICBkZXZjZF9tYXRjaF9mYWlsaW5nKTsN
Cj4gKwlpZiAoZXhpc3RpbmcpIHsNCj4gKwkJZGV2Y2RfZnJlZShleGlzdGluZywgTlVMTCk7DQo+
ICsJCXB1dF9kZXZpY2UoZXhpc3RpbmcpOw0KPiArCX0NCj4gK30NCj4gK0VYUE9SVF9TWU1CT0xf
R1BMKGRldl9jb3JlZHVtcF9wdXQpOw0KPiArDQo+ICAvKioNCj4gICAqIGRldl9jb3JlZHVtcG0g
LSBjcmVhdGUgZGV2aWNlIGNvcmVkdW1wIHdpdGggcmVhZC9mcmVlIG1ldGhvZHMNCj4gICAqIEBk
ZXY6IHRoZSBzdHJ1Y3QgZGV2aWNlIGZvciB0aGUgY3Jhc2hlZCBkZXZpY2UNCj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvZGV2Y29yZWR1bXAuaCBiL2luY2x1ZGUvbGludXgvZGV2Y29yZWR1
bXAuaA0KPiBpbmRleCBjMDA4MTY5ZWQyYzZmLi5jOGY3ZWI2Y2MxOTE1IDEwMDY0NA0KPiAtLS0g
YS9pbmNsdWRlL2xpbnV4L2RldmNvcmVkdW1wLmgNCj4gKysrIGIvaW5jbHVkZS9saW51eC9kZXZj
b3JlZHVtcC5oDQo+IEBAIC02Myw2ICs2Myw4IEBAIHZvaWQgZGV2X2NvcmVkdW1wbShzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBtb2R1bGUgKm93bmVyLA0KPiAgDQo+ICB2b2lkIGRldl9jb3Jl
ZHVtcHNnKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0IHNjYXR0ZXJsaXN0ICp0YWJsZSwNCj4g
IAkJICAgIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnApOw0KPiArDQo+ICt2b2lkIGRldl9jb3Jl
ZHVtcF9wdXQoc3RydWN0IGRldmljZSAqZGV2KTsNCj4gICNlbHNlDQo+ICBzdGF0aWMgaW5saW5l
IHZvaWQgZGV2X2NvcmVkdW1wdihzdHJ1Y3QgZGV2aWNlICpkZXYsIHZvaWQgKmRhdGEsDQo+ICAJ
CQkJIHNpemVfdCBkYXRhbGVuLCBnZnBfdCBnZnApDQo+IEBAIC04NSw2ICs4Nyw5IEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBkZXZfY29yZWR1bXBzZyhzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCBz
Y2F0dGVybGlzdCAqdGFibGUsDQo+ICB7DQo+ICAJX2RldmNkX2ZyZWVfc2d0YWJsZSh0YWJsZSk7
DQo+ICB9DQo+ICtzdGF0aWMgaW5saW5lIHZvaWQgZGV2X2NvcmVkdW1wX3B1dChzdHJ1Y3QgZGV2
aWNlICpkZXYpDQo+ICt7DQo+ICt9DQo+ICAjZW5kaWYgLyogQ09ORklHX0RFVl9DT1JFRFVNUCAq
Lw0KPiAgDQo+ICAjZW5kaWYgLyogX19ERVZDT1JFRFVNUF9IICovDQo+IC0tIA0KPiAyLjQ0LjAN
Cj4gDQo+IA0K

