Return-Path: <linux-kernel+bounces-78970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B053861B78
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 19:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA80828C405
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 18:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FCBD1420B8;
	Fri, 23 Feb 2024 18:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JukQ9Gib"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D637F84FC7
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 18:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708712540; cv=fail; b=RbqgR6U519aa+tVtaRgCUBWRTpz3QffvQ6sDMiSzhz2Y7+f2VqQ7FClEMXkhVzCmpfGXt+O1N4TxQwymn3aEw/m14FMuRNSRcQTanBqkmFmzA/z8of0A80teg9ElpNYbzXheSI0i5xPOFzRLblq5IyjLxMtxqYCjVqhq1eICiaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708712540; c=relaxed/simple;
	bh=pe7BzCKU/mrh9j0ARzqPjLstqNZZhgipC8f5mAaVAZ4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=F+0X2Lpsz3nml2qSrhi1ohAg6dgLGS3gPWWb6pzdL/SDafeW5FTtWfJ+sJY0HeBfoGitQk6NMGyyjGUMPhfz8j9iPSH/6GmFsggfbeJpziwFQyUK1Ccbobg98Rnogwa9EjxFpwdAs8U4y01M3SQD33XxNUmY9Alb2KqAFhqydG8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JukQ9Gib; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708712538; x=1740248538;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pe7BzCKU/mrh9j0ARzqPjLstqNZZhgipC8f5mAaVAZ4=;
  b=JukQ9Gibd+8HywOUHXJ2Sgg4FM0u2dNieP4X8FLaCvcetc56YiQefazy
   h/oijP248lcyjJ3q5gdJjh4Q/fSsv0A3fjZ+v3L+6A9iRw/I/iai2ZuPV
   pljNT4W+ER12zXLBX24keZVRkyLRTQYBiDP1KuqIcWnVrCGE4WZOdUn8z
   py/+srLZ7Gp/CnQBSu0WdoMLfQnodkx0/4FVwbnx8AUjVBoF0LAS0rqHc
   YCTiKjAPW7jefPYrvmMwlxcgJZpKzMgnO+KcgHqf0Y6/Vtb2iiCDeKBrD
   btPa8paR9znooruE2V3tbsiLAGsI/LkDwyh8RzO8UDUZidex7+ZPhlp3/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="5989147"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5989147"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 10:22:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="36754889"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 10:22:16 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:22:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 10:22:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 10:22:15 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 10:22:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=crsIjH3uGAATzFUCvrBygjjEcnw9xmubQW89wZxRiRb+w0VqHpLa/RY4Dx/A7UC82jMOwrJ54bg3xhio/z+3ICYHnKG6rbRxLUB4cecq7IFUzhLsEbWXPiMcTwW2s4gv9ypLmgm/L5lrh2BNWoEf1e3WkD1QThdS39UQ+9ZR7xjCHbND1oeX1l3Kf9yVvbkTJsA4wfNDVYG68XoQPj5oC0tyksaXx2u74Rszq2OLbuZbAIZJE898IMr63XxHxBBRNAZ3piOqpWX/X7/WtkK3kCmXHHNV3Ur4bUMk63Hh35dWRlOBXeqpF9z0b4NM2qI+CD30cDBs4PzFXqD6sz/4Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evxwSSszFVssjRTX/mw91yOO7PGbjBvkMFNO13Jx8cc=;
 b=YOZ8BWYo1W/Qmb6jxLKiiWUY0uvgfznjXy61pOVLww/lQ3+eV7LVc6V8T9hsgDFf9kNnjiLIWdNlAreLKi0Hz+Bfj3j3PqcxOlGlqnYscTKUemBQcen6KcDEgbGJtmmhnkozrCXTcEnHVsLbv16NP+WMoHmDmUl+hnJGP+N4lmdD3HImYxfxFZzMXKYYnjQcCIiUfdcF+7bzTuO45f8GP7FJznwHSH+FRsxAAg/b/o+w2ynKRFl9EnEYUDomCDOF9qija5Sx4bziAtxTRela13yPZgHGWcUq8Doh91nLtA74QpD0CmsWvQIN80AidISEVh3MIstxnuB8EntNjotWvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6424.namprd11.prod.outlook.com (2603:10b6:8:c4::8) by
 CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7339.10; Fri, 23 Feb 2024 18:22:13 +0000
Received: from DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021]) by DS0PR11MB6424.namprd11.prod.outlook.com
 ([fe80::b263:53b3:c993:3021%7]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 18:22:13 +0000
From: "Ruhl, Michael J" <michael.j.ruhl@intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC: "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Thread-Topic: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
 names
Thread-Index: AQHaZnZVyb+ntBY6PE6Aidjrz3mClbEYMnAAgAAJ6SA=
Date: Fri, 23 Feb 2024 18:22:13 +0000
Message-ID: <DS0PR11MB64248E0C15C0B86A1CCF945BC1552@DS0PR11MB6424.namprd11.prod.outlook.com>
References: <20240223163516.796606-1-michael.j.ruhl@intel.com>
 <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
In-Reply-To: <ZdjZCrpP52Hfbs6L@smile.fi.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6424:EE_|CH0PR11MB8086:EE_
x-ms-office365-filtering-correlation-id: 23ecfc97-8707-4ceb-7b90-08dc349c5ba5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PzTDaj6TafZQjw8Q479q4rYc2dQnBRoBnZZsIpKPizOwKXabCZal0hxdFWAtvDyQD2meh7+p2Kz1WGfcMFMn/777zp+N4WXaoV5fvcKxadJE6USqEx4fya6+y8AbRpzMc9jkU5CYHC84FLg+klZcZ03ROLcvcpCJ2M+aMHCCUtCotRxBSFercHGNzV6II5z4weYWmDAO47xYX6IJ0mScBEcO/X7aiIzHdSeJcKM26dg+GUiMA18v9yxzXdZQFfByoudzA5PPXJ/aRrUc1xdzBno2Ff3EkyxSFecfTcEDOpmT8ymcs+fY8PKoSibG97vu7FIQVfAKAa2EeDB3FQJ57qhF4y3vfoAmssK/EQKVBTSbtXydqClxrYgcObnlOmSUmyYcZEHr/FrflOgYU4g64Qw8nTJmAQ7O8Dw8Mt+3vDHaT/mvtckmWLupvIUunQ6cfJtyONDRXreToG2Ih7iddpXCGs7ZS4FoEsWGhnzj0/MXmuguVoYyZINS+hSxSr7fpfxoHfUjePloIRapmBZA2JLqN+esx0G80R38VqBZfMczoHDvBp47MaT+RmAsZ8ICAqDWIfEN1jxo+TPFbSwMd+qX7K9Efq35i7iSZDc+eeU=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB6424.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ugtz+XV0Iv+G+L5YYRWsFIZs45dMzqpcDEEngR0cRbFKSHcFTFzj8qZR3PFK?=
 =?us-ascii?Q?X3Zcpze2U5EUY9CsEHHXbgexVhwP1KO2uSC18mSwjg3JgY1gvUAivm8EYr0g?=
 =?us-ascii?Q?J+4VPWQ0hPez5RM5JPEAQHQISIvI8UgSzwKZV0CnB8uPIre+N7MaNUayZT0E?=
 =?us-ascii?Q?vf6Yqfval5PaVpaMehRdfZ33ZIxAArjMb+dCraLGxv6sgizk2ns2Ttmn1swc?=
 =?us-ascii?Q?w4z1qluNfEPnVfTN866uU4CthmHFSPITfzgnCwSsEbafLevrU+dC0l9aP+9g?=
 =?us-ascii?Q?bZj5dCVEV7lcdduG5M+BgvlBcIm5HOr13mT24i6X4vHQVKE4g7HChcTCixJi?=
 =?us-ascii?Q?9O+1QDRntUDYXZO7k1tR63EAjndT4BRScXMU1vdJConKLHuwToy0uZXEoDj+?=
 =?us-ascii?Q?p++n84djEa3d6uRzcMp+UYgg/IGKnLl0/njDhLQ43W+A3yvKI4Mj6RAPJti/?=
 =?us-ascii?Q?ALxFa9X/5USHJG4szropMkbNmzDsN4GIV/tObjXRqCtBksaRHDpjiQxMV9QY?=
 =?us-ascii?Q?+pBrko/NKwnlGKCUNNhdKYqIz9HyNFZj8nFCSyiZSaFRr740QaUqgd2FUNEy?=
 =?us-ascii?Q?PDxGdxfC5/fE3c+vvxkoJWbs/VeUlG8hnVDr50fEEf30LmmVCPyS5a2Ctk1M?=
 =?us-ascii?Q?flPL3Lc2/T6ZNyCJS/wo7opgFV+XiodA94QMBrvMIRWp8PS6YpScK0KxvaYq?=
 =?us-ascii?Q?shgDQbPbQFapQyyT2x7h7SRAjlBYxCpQZdnTCL9onTDhTpBYixTZjw+dQZEo?=
 =?us-ascii?Q?IBI0ZcLAhPGX5eyI2K3oSFWU0IrxevdkvKI3V/Ij9jh9LqJmWfhBUknebieE?=
 =?us-ascii?Q?rEq6EszenQX2g89Bu0Q3KT7qiD7eY1DJ7AYvQNMYNLaavywZxlXAgYj9SgX8?=
 =?us-ascii?Q?VUgG1cNQvzlRKpGSc4aSUvkZ7N5iGzpqN5ZXwniNRtnCF6DBN8+bW+Veis6d?=
 =?us-ascii?Q?eVIW7cuv5x8INKUHtQOjHMsKwASt6hseKfp+9p6w7j8+xblZ+KVBgycDsayF?=
 =?us-ascii?Q?3liLDBMNNAjQKC+pCZSlsEHAKdmM8WiW7+eLW2ASml6w+70VWio6OSSUpxBT?=
 =?us-ascii?Q?1Ze6mHJpLkBOIp5hJj4MrAv8Z2RQCMK8eEwL6kOkrAiYugP3nRWmosIc302K?=
 =?us-ascii?Q?vjsxRBOQ1pks3pGU8W5E1Zzqd9E1Tfg50vx0n0pDVmWa0NnzjgUHFzCtmwfD?=
 =?us-ascii?Q?yW0Aw7c5bnLVmvffYatdVmGEDl2bn+54UK1U6gF9RTVl2MdgqLdscRHEGZZ8?=
 =?us-ascii?Q?FMbrg119tzfYvirHqq38Rf6vCAIqGJ/JNpJ6TKa2IdOiYrfz/+Fsfhbc46/1?=
 =?us-ascii?Q?d5NisjJ33i5uK8rly/ys4aE/A6a0m8xLAIS1HpA+cuc2rjXh1csctz/KCAfn?=
 =?us-ascii?Q?UnfZT6zbNH0cVuOI4wEkdsWUuMHnOifMOs/hSXd5s5QqInQgvlNbA1GVHYiS?=
 =?us-ascii?Q?14z2thGKPrz5Dg0c7m/OIFGi0+X5uWXjFJzTjo/l2yYa7paJOjnK7wZiz+Np?=
 =?us-ascii?Q?Gs+vKWfT2jNhstLVUuM43XLiQy0iVAbYChc5cUIMHtrnnnlxrzo+zI9IaCvP?=
 =?us-ascii?Q?8zBh1/TFRx1I82kA4ZayDENl4CeL+7cDQM/iwuAt?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23ecfc97-8707-4ceb-7b90-08dc349c5ba5
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2024 18:22:13.6736
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l0VGA14YH9BywewEUBYndjerRVnysBcIBuQwawXG9ViS5REd0cAteljwj5bhmVMaIOGye+oU8yZ+jU+mWhRp+tRHmrX0IO+Rmq6YEOlwV+o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com

>-----Original Message-----
>From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>Sent: Friday, February 23, 2024 12:43 PM
>To: Ruhl, Michael J <michael.j.ruhl@intel.com>
>Cc: linux@armlinux.org.uk; linux-arm-kernel@lists.infradead.org; linux-
>kernel@vger.kernel.org
>Subject: Re: [PATCH v2] clkdev: Update clkdev id usage to allow for longer
>names
>
>On Fri, Feb 23, 2024 at 11:35:16AM -0500, Michael J. Ruhl wrote:
>> clkdev DEV ID information is limited to an array of 20 bytes
>> (MAX_DEV_ID).  It is possible that the ID could be longer than
>> that.  If so, the lookup will fail because the "real ID" will
>> not match the copied value.
>>
>> For instance, generating a device name for the I2C Designware
>> module using the PCI ID can result in a name of:
>>
>> i2c_designware.39424
>>
>> clkdev_create() will store:
>>
>> i2c_designware.3942
>>
>> The stored name is one off and will not match correctly during probe.
>>
>> Increase the size of the ID to allow for a longer name.
>
>> v2: Removed CON_ID update and added example to commit
>
>Usually we put changelog out of the commit messages...

Yeah, usually put it in the cover letter.  I will remove. I see your script=
 automatically
does a cover page...will use that format int the future.

>> Signed-off-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
>> ---
>
>...somewhere here.

Ok.    Will keep for future reference.

>Also just noticed that you forgot CCF maintainers to be included.
>I'm suggesting to use my script [1] which harvests more or less
>adequate list of people and mailing lists to Cc email to.
>
>[1]: https://github.com/andy-shev/home-bin-
>tools/blob/master/ge2maintainer.sh

Using your script I got:

To: "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>

My list (using get_maintainers.pl) is:

linux@armlinux.org.uk
linux-arm-kernel@lists.infradead.org
linux-kernel@vger.kernel.org

They appear to be the same....

I don't have the plain text part on Russel's email (linxu@armlinux.org.uk).=
. Is that what is missing?

Not sure what CCF is?

M

>
>--
>With Best Regards,
>Andy Shevchenko
>


