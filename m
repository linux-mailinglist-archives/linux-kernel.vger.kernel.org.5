Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F10F752673
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:16:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230309AbjGMPQP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjGMPQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:16:04 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED59A2;
        Thu, 13 Jul 2023 08:16:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689261362; x=1720797362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rBsqX3x+bQKkznnra5U+L/60IJTiKR3meICfVqefhfI=;
  b=UJl28Hm+KtgD0iuuNcJgdhkf8hg3NFrqruXPaUlIGlHxEbMMB/8+vAkL
   Pg12pvfb/dpoq92FnkECD8WR8cLNA6UDLsGjP7xZ+Z4SnxxGWNrvZ/yy/
   vbJ9nj5DTw79Qfdcidz7XC+2gwJgqj8955ZjkSpQ14Ngtf5v/WAkQcQfv
   Pek+q3qd4KRLUor4WfKLbSakXtFpPQM9psPhFQ0z/MEytojhqJWaDQStf
   g5tEeVmCE/y/BAN79egbZP9ZPkFENFw3HhkNWrUSIrCUz48I15Bi1jchd
   SKzbUTWBfOY/RX3KFRSA8ry/eeWNaL1eh3JwNMYmIEuWOuqM8t9Bn6ZZY
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="396022289"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="396022289"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:15:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="757199859"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="757199859"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga001.jf.intel.com with ESMTP; 13 Jul 2023 08:15:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 08:15:34 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 08:15:33 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 08:15:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 08:15:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MucwFoIGymPt7gg3ajQeRqFMPrMBKczFm+UQbY0L//kTLYP35Q8+Q+FbDlkyXvDLjdVSlOHBJl2m4F/EvvNiBOfWe2EfRLHgPKm1x+9yUv8zFfmQnyj6rQJHtqq+xj3NfgpN//VCfrizoIjhOgOisc/QRd9FLhb3d8LrqMyeAbEfrYQi5DVKI4T+tAfimVYVDDVLv30YG+3rWQwrchEaGxYLw4SLaLAdhWCgl76ovb8EpWGdUfiDhw7pNO+HGEfuYXvTrlWH36H8Kg394lsjI9xEXzaRkQfVnIBEldPmR4eWHXbz+9Q2UQalE4Kq6WBj9HoBo7m27aKyOJeLwDVmgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rBsqX3x+bQKkznnra5U+L/60IJTiKR3meICfVqefhfI=;
 b=ggOJv+LKHKGh6ADz13Z7zTAcAu3BAddqzDuk34K9wc5FXOuUnutecD0HlGrLaxr5UBj6zs5SYly179+QV/m90BfjYtRR6Dv0R/I1amyo5CNZM7+rxmuks9llug96undRze28xWHjypvZcINZn98yF466YZBlWYZ+Rrw6jrNnKGQTPhroBO1iWpYwXGu6X3OXALYrC0QAdnhRdur2Tsl4yP9KXa1SATTECjPJWHvd65xgA8QaVOh7hUvL51Z71KMDBEtz7uz8G1I5wYAmSxq5xsJu01wa4JdV++GYuDv7aUbsLD7eZYupR6RD8aRLDaT0ZOzcNWv4J2KQie9ZnKgxkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by SJ1PR11MB6132.namprd11.prod.outlook.com (2603:10b6:a03:45d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:15:32 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:15:32 +0000
From:   "Verma, Vishal L" <vishal.l.verma@intel.com>
To:     "david@redhat.com" <david@redhat.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "osalvador@suse.de" <osalvador@suse.de>,
        "aneesh.kumar@linux.ibm.com" <aneesh.kumar@linux.ibm.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "Jiang, Dave" <dave.jiang@intel.com>,
        "lenb@kernel.org" <lenb@kernel.org>
CC:     "Huang, Ying" <ying.huang@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
Subject: Re: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Thread-Topic: [PATCH 3/3] dax/kmem: Always enroll hotplugged memory for
 memmap_on_memory
Thread-Index: AQHZn9Tstvh84woP/kqwvI9d+8RyUq+ND9wAgCe4+ACAAA4cAIAClJOAgAAKogCAAIPpAA==
Date:   Thu, 13 Jul 2023 15:15:32 +0000
Message-ID: <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
         <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
         <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
         <87edleplkn.fsf@linux.ibm.com>
         <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
         <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
         <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
In-Reply-To: <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|SJ1PR11MB6132:EE_
x-ms-office365-filtering-correlation-id: dd7b1734-8276-46c8-059d-08db83b40002
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CgYQm/FVOav+eVcZnI0ABY0vOk7H3udP/o8hLhTVMdwnXkYqOoTbNFWdI6YeIG07YDu1D0JkjmXY1CJ6lBRzEtBiZMJDL+yDSS0Dgu24qbWxSRTZSKvsSS6TWIAScBwHgSgFTDUCO9KE+W6iOl4M2T0df6ZbtBLz99V6/ub7yQRiSIJibh/5zJ0w5od9ozwuHjQCEnEUo1hF073+kkNWmGtjCdEtHdPCxkDGiYWti2p6UCn24i+7anS9HltPgPDmOdmDPdd4q8rpAzB7WQi+lAuFWXYRmratu+j3i6U4GXi4MYQRIHJ/hlORA+PaGR/URSnj99MCXlZD8H8MVizbVx8MF/YhDVcmdu5GrFBnhiqW+jItVvwOlCbRwMMlDvqxMcNkDwX/PnJV7Bmlcx+LcWW1SXERov1qsRyK9pB+bBrIryFivGhiHubx7uEzw45XAHD3TevrdFZB0cLMwThrpY+9CCzo0d56hcCDP+Nvx3WkMQYxC62MYxWLqr2uiAdBJIud6agamiroDG+vvoeZssi5h5xJXSDMGL/AyA98URi0BeRpNcKo42pDqo1X85Kom29PfeSBdZneC04wDB+QwPYHJmjtftFMAJJa7pR8U+qCzYCpuhfnKua2t71uVznISvz5VkiQdmLVkBIBjxAf9Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(136003)(376002)(346002)(366004)(396003)(451199021)(6486002)(6512007)(71200400001)(186003)(6506007)(53546011)(83380400001)(36756003)(2616005)(38070700005)(86362001)(921005)(82960400001)(122000001)(26005)(38100700002)(4326008)(64756008)(66446008)(76116006)(66946007)(66556008)(66476007)(41300700001)(2906002)(316002)(7416002)(5660300002)(8676002)(8936002)(110136005)(54906003)(478600001)(66899021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJ4ajcrR0tVb0dzR2dsRXZZSkVtWEQ1MUJGaDJWQVdObDRGNVUzVGM5NnlY?=
 =?utf-8?B?RE5XbmpMMjdMYXdHUkZjbWhJZmZUenlnYmVHcFNUcThlMFNuczl1cXh0Rnpi?=
 =?utf-8?B?ZlFCY050dEkxM1pHUzV2WWRrWDZVYXlWOUowVkZpRjVNRVV4WVpIeXllUkhF?=
 =?utf-8?B?STV4Q3Q2clpDVmFzVkhaYU8xOTJFenNOa0VkdCt1Y1JTMlBvOEpYM1NmTnc0?=
 =?utf-8?B?aWlXeFBrdTZOSFJYa2Fvay90YXdIU0lEem44SVlRdzZtQmlQaDE0Q2NPc1h0?=
 =?utf-8?B?M3lWZW9CZmRvNmptZmRBMm9RUVBXaVBpelgwcGRYL0wwWUJsRFZjMDl2dEx5?=
 =?utf-8?B?a1V0eHZiOVZ3OEd2QU9SUllHY2pMM283UHlCMXZRZmN2UnNRYjhzamNqZTZM?=
 =?utf-8?B?VUt0YVJ5NTllM3dEcXJqaFN6R0xzTThWVXlqZk8vWDFpUWhSaUdHZjl3V244?=
 =?utf-8?B?RWtVRW5tM2thM1pKSkVVRjBCV2dtNEgzUWVQdSs5Z3BLcnd4VG5KMkxzME1X?=
 =?utf-8?B?WThvMTZ2aUZDU1RBT3ZKakdYWVFLMmdMM3FIMzQ5RHhtNU9JeXVjZkRObXFj?=
 =?utf-8?B?bExaTWRDV3AycDl6cDJqWTZodllRNCtQcWVmdUhWbHdYTGtVdE8za2cvTHVC?=
 =?utf-8?B?Q2IxUG9ScFg5KzRZUnFEUmFtRzRsNGRxQmNxT0lkMjRuL1FRUkZVWlBzWmE4?=
 =?utf-8?B?UFZjaHpzSjhWL2dEZUFOV00wZlJITVFvUlBWeUpNMnJYSHBodDF1SWk1eHZ3?=
 =?utf-8?B?RUI5ZE1HUVo5S3NuOStlOHhYVWkrdDhuREppcVAxcm5wZU9WdmFEVC9RRWV5?=
 =?utf-8?B?R3F6NW1WNnlrWFd1bnVhT2lmK05nTnE1ZTBOdWNGQXg0eTNpbUVsVHA0cEZ3?=
 =?utf-8?B?M2lTNE9ucW1ndkZPK2QxUHQxVmFCL2dCTjVZOEZXQzdENTZDWGRCZlNRNUhT?=
 =?utf-8?B?aWM3am5CdmJOdlF2UFVJWlRYMjIwVHFzeUdxMGd3RmxoOXpTQWxObEpid0lz?=
 =?utf-8?B?WmZyMWVwK1ZRcllQZkVmZWJZSVg2YXhvL3JheGs2emp0ZTFhWmY5RXZjb3Ax?=
 =?utf-8?B?TVMrTTZBYUhuVUhCeGNnSXpPdzd3RnAzeFRacENGek4zcVpBNEEzemc5aTFU?=
 =?utf-8?B?dTI1U3FaRkFHRUxCczMxd3M2Vk16aXN4cUJwYVZDbEs3RmFiajRFaVdwcmdm?=
 =?utf-8?B?L2hsQUZqVGYzSTg1QjE5bkRwREc3dlZId081MXlJd3dQa3dGUDhESC9uWUtr?=
 =?utf-8?B?MHdCM3dXbGZkaE11SUZtbnZjcGtTT0lLY0FPclpVL3JTV1pFbHJ5NXBEeTk4?=
 =?utf-8?B?WEdPU0NuSDFoMUl3VmRJdVA0VExwV1hEak9YWUMvQnMxdXM0c2pibnpwbVFh?=
 =?utf-8?B?V0V5T1hBekwyS29yeVUxdC9YMjdyem0rbFhKeElnMml1cW5NK0Vnd3NGc0J6?=
 =?utf-8?B?TVFTRERCYWdsaVcvdm5YMG5mSk5lVTl2cXBxWk1JVEJBdVJuZ1Fja2VBWDRm?=
 =?utf-8?B?SC83aW9YRm41MlZWYUJNN2tweHA2emd6OWtpNkl1UTJNQWhYM0ZsLzR2Vlpv?=
 =?utf-8?B?ZytmbVljdFVOUkVVN0I3dE5sY2V0Q1VEbDh5TDhxaWRtaTA3UHRVVDQ1UEZw?=
 =?utf-8?B?eUVHRDJCYXloRGdDUUtNUm1sLzFqWnQxWUwwcUh3dENvM0tCY1Q5MjdNeiti?=
 =?utf-8?B?QVFNbVhqZUVZNEZSVjZETHZsUC9vbUpKeWNSUEtaVUhXNUJRSlhTVHBhTU9x?=
 =?utf-8?B?d3VFVFZoMm14eEd3Mm5XeW1jNFR4TzlBQWtuMU00OThyV0IrZDY3MHBldHRz?=
 =?utf-8?B?Sld4SkoyTGFtVHRiOE1ZWlQvWENqVzlCd1M3RjlsRDNjeG9NcG9xQWtVSGdz?=
 =?utf-8?B?Q2pGTnhhSmJ3SGFYRHhJNU5ab3hrVGs3K0dwejlmeFJiNTZKZXgrelgvRUZk?=
 =?utf-8?B?MVVZVHA4Nm53RlZ1NjcxVmh4b0NmTlJZeTJYTDBSZHNWMDRRYVVxUlozc2Jt?=
 =?utf-8?B?cjlqdlBtUk1WOCtoZ2Y1c1pra0ViRnlwTUtCT1JzR0g0WGt5aG03RHdidTUx?=
 =?utf-8?B?VS91Q3pHeWFUV3I4eHF0ekpEdVJvSlJ1NStoYkJOY0Z1aUxRNkZpOEFuS0Qr?=
 =?utf-8?B?dzZ2MkthZVl5RURhcFdXT2FSSDVnQ0dSWE9tK21zdStJSm9hSEtySTNnWFVo?=
 =?utf-8?B?M0E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <74FAC08483954144A59A0E41DAAE2FA8@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7b1734-8276-46c8-059d-08db83b40002
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:15:32.0298
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6PH0K3GbttYRfXGJCrayN2ypum8hoks+05CaKhVzDUxxDWUCP1e631lOaiyJsXjjfGGVxvevSKe9PY80xbjWCJ9YUCSUGOjQdMWjiBC4ih8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6132
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDA5OjIzICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAxMy4wNy4yMyAwODo0NSwgVmVybWEsIFZpc2hhbCBMIHdyb3RlOgo+ID4gCj4gPiBJ
J20gdGFraW5nIGEgc2hvdCBhdCBpbXBsZW1lbnRpbmcgdGhlIHNwbGl0dGluZyBpbnRlcm5hbGx5
IGluCj4gPiBtZW1vcnlfaG90cGx1Zy5jLiBUaGUgY2FsbGVyIChrbWVtKSBzaWRlIGRvZXMgYmVj
b21lIHRyaXZpYWwgd2l0aCB0aGlzCj4gPiBhcHByb2FjaCwgYnV0IHRoZXJlJ3MgYSBzbGlnaHQg
Y29tcGxpY2F0aW9uIGlmIEkgZG9uJ3QgaGF2ZSB0aGUgbW9kdWxlCj4gPiBwYXJhbSBvdmVycmlk
ZSAocGF0Y2ggMSBvZiB0aGlzIHNlcmllcykuCj4gPiAKPiA+IFRoZSBrbWVtIGRpZmYgbm93IGxv
b2tzIGxpa2U6Cj4gPiAKPiA+IMKgwqDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgva21lbS5j
IGIvZHJpdmVycy9kYXgva21lbS5jCj4gPiDCoMKgwqAgaW5kZXggODk4Y2E5NTA1NzU0Li44YmU5
MzJmNjNmOTAgMTAwNjQ0Cj4gPiDCoMKgwqAgLS0tIGEvZHJpdmVycy9kYXgva21lbS5jCj4gPiDC
oMKgwqAgKysrIGIvZHJpdmVycy9kYXgva21lbS5jCj4gPiDCoMKgwqAgQEAgLTEwNSw2ICsxMDUs
OCBAQCBzdGF0aWMgaW50IGRldl9kYXhfa21lbV9wcm9iZShzdHJ1Y3QgZGV2X2RheCAqZGV2X2Rh
eCkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+bWdpZCA9IHJjOwo+ID4gwqDCoMKg
wqAgCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAoaSA9IDA7IGkgPCBkZXZfZGF4LT5u
cl9yYW5nZTsgaSsrKSB7Cj4gPiDCoMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
bWhwX3QgbWhwX2ZsYWdzID0gTUhQX05JRF9JU19NR0lEIHwgTUhQX01FTU1BUF9PTl9NRU1PUlkg
fAo+ID4gwqDCoMKgICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1IUF9TUExJVF9NRU1CTE9DS1M7Cj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByYW5nZSByYW5nZTsK
PiA+IMKgwqDCoMKgIAo+ID4gwqDCoMKgIEBAIC0xNDEsNyArMTQzLDcgQEAgc3RhdGljIGludCBk
ZXZfZGF4X2ttZW1fcHJvYmUoc3RydWN0IGRldl9kYXggKmRldl9kYXgpCj4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhpcyBhcyBSQU0gYXV0b21hdGljYWxs
eS4KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiA+IMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJjID0gYWRkX21lbW9yeV9kcml2
ZXJfbWFuYWdlZChkYXRhLT5tZ2lkLCByYW5nZS5zdGFydCwKPiA+IMKgwqDCoCAtwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdl
X2xlbigmcmFuZ2UpLCBrbWVtX25hbWUsIE1IUF9OSURfSVNfTUdJRCk7Cj4gPiDCoMKgwqAgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oCByYW5nZV9sZW4oJnJhbmdlKSwga21lbV9uYW1lLCBtaHBfZmxhZ3MpOwo+ID4gwqDCoMKgwqAg
Cj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmMpIHsKPiA+
IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBk
ZXZfd2FybihkZXYsICJtYXBwaW5nJWQ6ICUjbGx4LSUjbGx4IG1lbW9yeSBhZGQgZmFpbGVkXG4i
LAo+ID4gwqDCoMKgIAo+ID4gCj4gCj4gV2h5IGRvIHdlIG5lZWQgdGhlIE1IUF9TUExJVF9NRU1C
TE9DS1M/CgpJIHRob3VnaHQgd2Ugc3RpbGwgd2FudGVkIGVpdGhlciBhbiBvcHQtaW4gb3Igb3B0
LW91dCBmb3IgdGhlIGttZW0KZHJpdmVyIHRvIGJlIGFibGUgdG8gZG8gbWVtbWFwX29uX21lbW9y
eSwgaW4gY2FzZSB0aGVyZSB3ZXJlCnBlcmZvcm1hbmNlIGltcGxpY2F0aW9ucyBvciB0aGUgbGFj
ayBvZiAxR2lCIFBVRHMuIEkgaGF2ZW4ndAppbXBsZW1lbnRlZCB0aGF0IHlldCwgYnV0IEkgd2Fz
IHRoaW5raW5nIGFsb25nIHRoZSBsaW5lcyBvZiBhIHN5c2ZzCmtub2IgZXhwb3NlZCBieSBrbWVt
LCB0aGF0IGNvbnRyb2xzIHNldHRpbmcgb2YgdGhpcyBuZXcKTUhQX1NQTElUX01FTUJMT0NLUyBm
bGFnLgoKPiAKPiBJbiBhZGRfbWVtb3J5X2RyaXZlcl9tYW5hZ2VkKCksIGlmIG1lbW1hcF9vbl9t
ZW1vcnkgPSAxIEFORCBpcyBlZmZlY3RpdmUgZm9yIGEKPiBzaW5nbGUgbWVtb3J5IGJsb2NrLCB5
b3UgY2FuIHNpbXBseSBzcGxpdCB1cCBpbnRlcm5hbGx5LCBubz8KPiAKPiBFc3NlbnRpYWxseSBp
biBhZGRfbWVtb3J5X3Jlc291cmNlKCkgc29tZXRoaW5nIGxpa2UKPiAKPiBpZiAobWhwX2ZsYWdz
ICYgTUhQX01FTU1BUF9PTl9NRU1PUlkgJiYKPiDCoMKgwqDCoCBtaHBfc3VwcG9ydHNfbWVtbWFw
X29uX21lbW9yeShtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygpKSkgewo+IMKgwqDCoMKgwqDCoMKg
wqBmb3IgKGN1cl9zdGFydCA9IHN0YXJ0LCBjdXJfc3RhcnQgPCBzdGFydCArIHNpemU7Cj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGN1cl9zdGFydCArPSBtZW1vcnlfYmxvY2tfc2l6ZV9ieXRl
cygpKSB7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBtaHBfYWx0bWFwLmZyZWUg
PSBQSFlTX1BGTihtZW1vcnlfYmxvY2tfc2l6ZV9ieXRlcygpKTsKPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoG1ocF9hbHRtYXAuYmFzZV9wZm4gPSBQSFlTX1BGTihzdGFydCk7Cj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwYXJhbXMuYWx0bWFwID0gJm1ocF9hbHRt
YXA7Cj4gCj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXQgPSBhcmNoX2FkZF9t
ZW1vcnkobmlkLCBzdGFydCwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtZW1vcnlfYmxvY2tfc2l6ZV9i
eXRlcygpLCAmcGFyYW1zKTsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoGlmIChy
ZXQgPCAwKSAuLi4KPiAKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHJldCA9IGNy
ZWF0ZV9tZW1vcnlfYmxvY2tfZGV2aWNlcyhzdGFydCwgbWVtb3J5X2Jsb2NrX3NpemVfYnl0ZXMo
KSwKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBtaHBfYWx0bWFw
LmFsbG9jLCBncm91cCk7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBpZiAocmV0
KSAuLi4KPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoAo+IMKgwqDCoMKgwqDCoMKg
wqB9Cj4gfSBlbHNlIHsKPiDCoMKgwqDCoMKgwqDCoMKgLyogb2xkIGJvcmluZyBzdHVmZiAqLwo+
IH0KPiAKPiBPZiBjb3Vyc2UsIGRvaW5nIGl0IGEgYml0IGNsZWFuZXIsIGZhY3RvcmluZyBvdXQg
YWRkaW5nIG9mIG1lbStjcmVhdGluZyBkZXZpY2VzIGludG8KPiBhIGhlbHBlciBzbyB3ZSBjYW4g
dXNlIGl0IG9uIHRoZSBvdGhlciBwYXRoLCBhdm9pZGluZyByZXBlYXRpbmcgbWVtb3J5X2Jsb2Nr
X3NpemVfYnl0ZXMoKQo+IC4uLgoKTXkgY3VycmVudCBhcHByb2FjaCB3YXMgbG9vcGluZyBhIGxl
dmVsIGhpZ2hlciwgb24gdGhlIGNhbGwgdG8KYWRkX21lbW9yeV9yZXNvdXJjZSwgYnV0IHRoaXMg
bG9va3MgcmVhc29uYWJsZSB0b28sIGFuZCBJIGNhbiBzd2l0Y2ggdG8KdGhpcy4gSW4gZmFjdCBp
dCBpcyBiZXR0ZXIgYXMgaW4gbXkgY2FzZSBJIGhhZCB0byBsb29wIHR3aWNlLCBvbmNlIGZvcgp0
aGUgcmVndWxhciBhZGRfbWVtb3J5KCkgcGF0aCBhbmQgb25jZSBmb3IgdGhlIF9kcml2ZXJfbWFu
YWdlZCgpIHBhdGguCllvdXJzIHNob3VsZCBhdm9pZCB0aGF0LgoKPiAKPiBJZiBhbnkgYWRkaW5n
IG9mIG1lbW9yeSBmYWlsZWQsIHdlIHJlbW92ZSB3aGF0IHdlIGFscmVhZHkgYWRkZWQuIFRoYXQg
d29ya3MsIGJlY2F1c2UgYXMKPiBsb25nIGFzIHdlJ3JlIGhvbGRpbmcgdGhlIHJlbGV2YW50IGxv
Y2tzLCBtZW1vcnkgY2Fubm90IGdldCBvbmxpbmVkIGluIHRoZSBtZWFudGltZS4KPiAKPiBUaGVu
IHdlIG9ubHkgaGF2ZSB0byB0ZWFjaCByZW1vdmVfbWVtb3J5KCkgdG8gZGVhbCB3aXRoIGluZGl2
aWR1YWwgYmxvY2tzIHdoZW4gZmluZGluZwo+IGJsb2NrcyB0aGF0IGhhdmUgYW4gYWx0bWFwLgo+
IAoK
