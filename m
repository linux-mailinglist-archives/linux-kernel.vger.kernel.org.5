Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F031C76442D
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 05:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230238AbjG0DMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 23:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjG0DMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 23:12:00 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6D2707;
        Wed, 26 Jul 2023 20:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690427516; x=1721963516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KL0eoLNTKLmXnJs/s1r/K6mwYJMx5AZHAVTARmvpYjs=;
  b=Ca9otM7HbTc7oWqcii8RDD0mzZ0romT08VKjWGGHiNnrxHt9P9CrGuF5
   n8RIqh6t79O38iAYn3XzGM9AszDXUrJ4OsBJQFYTXvu/FEeYSyYanCsqW
   kGUP9Porufskt/2Y2I+qozt49rEOBeuXNJ1+Sx7OrrVUg7DA7IAWxtchl
   cZLHcAgOFox6WHOYDjSYKZ3VrYmI8/e2Bpw+mNdAEubT2jYSf+u1PEDSn
   2Hn3Y3JZ1RPOO3d5X9PmMy4qcWWiBK9T8v4sUz5mdit2pT28Jhigxev+m
   9FyPmGutKjGMOP1lpkz7BifoUJu5wZcevpGSdAp5w7QAswZP8AKLoS58r
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="367064477"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="367064477"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 20:11:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="726770209"
X-IronPort-AV: E=Sophos;i="6.01,233,1684825200"; 
   d="scan'208";a="726770209"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP; 26 Jul 2023 20:11:54 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 20:11:54 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 20:11:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 20:11:53 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 20:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSXwJELKmUObKW9P4ATcYYtkUy95OQcQT8tQdj37kZYbafbl9pJUUBMn/Vu9OSkeiK0no9+qwF6RIaH+dM7a+dY9N7p528+gPAhscHoNAsjF6cU8MHKOLHV62Nmeqv93rO3z7hNJ4+xwbdGJXKYn1rK9F7ooG4W5zHMLsNEjK07bJPY3Cc8AXvjuDq1KjKvPO02dCDcT6w9ZdJJeUf5O/hV6YzXMJXa419ev8NyBz2hpQvVbUc+xI+Bi4RjbblyY7Joktbpx2Ar02PTx26ztvOkuVj2H/3S1g1qWd6LQEDTDvPATGuaWedbm9NBPvqgd6ewe6oa7ZBYY1iXYw1Mo3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KL0eoLNTKLmXnJs/s1r/K6mwYJMx5AZHAVTARmvpYjs=;
 b=TN1uYUzXmhk2AENPhgf+GZFu/So1IB56z+Ey2XNkQEA2xNtsivkmW/1X1dc5vlCX7ZBS6JSAvH4UJ1vgAk4cRyivjUvKK8l/MJVJm3I5iZcYkGwb3pV+yiFoIiSwqxCundLJdE1ADgN25WMi7WzlrLALdIcIaMXIrPjALW/dxFRvCPoBA3XicsVjc9atQTi/6c7KR+lwRGN3K0eajf+RDoTB5LcJE1KnDLmBaMZ7HGMTHdY7L5Ej61UtPs7ZKadpz98VrHhk4fw/pb6bXG/4Re4QVvSNsgbloIAlV7p45yIFWRqptu8kBrhEypccD0+R8Ycktdvs+sWrt9/jtxjO/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA1PR11MB6492.namprd11.prod.outlook.com (2603:10b6:208:3a4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 03:11:51 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::3729:308d:4f:81c8%3]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 03:11:50 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "linux-sgx@vger.kernel.org" <linux-sgx@vger.kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "Chatre, Reinette" <reinette.chatre@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "bp@alien8.de" <bp@alien8.de>,
        "haitao.huang@linux.intel.com" <haitao.huang@linux.intel.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>
CC:     "kristen@linux.intel.com" <kristen@linux.intel.com>,
        "Mehta, Sohil" <sohil.mehta@intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>
Subject: Re: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for EAUG
 race
Thread-Topic: [PATCH v5] x86/sgx: Resolves SECS reclaim vs. page fault for
 EAUG race
Thread-Index: AQHZwCYBmjwKzMBZUUGqRDKoJ6bjba/M6cUAgAAGFoA=
Date:   Thu, 27 Jul 2023 03:11:50 +0000
Message-ID: <1418814b95d486a68ebce81524d6261f3849a711.camel@intel.com>
References: <20230727010212.26406-1-haitao.huang@linux.intel.com>
         <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
In-Reply-To: <c57d8cc4e4bfbef028a1f226ec2c4691a7c100fe.camel@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA1PR11MB6492:EE_
x-ms-office365-filtering-correlation-id: 7a4038ea-11da-4947-29fd-08db8e4f389a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bzwC9VMcTgEaEwMTz2A0KJ8jcQqCBV8ytjVTu/PebH4zKu33Zrh6fkJ4kH24GlKoLcCKLlBxgX8Opm1vx74Cg4FCXdjO4Innpx2tF5WzNOJXYJrw5KFXnqGXf8gwvenWHENM/EqCilitrHvCFhv0GE7OmVztidYSMYjs4vcKogq9KSkUnSO6D9dWVJ9F55BqGykANADqD+qK5IZYBKlzXXl/vmcMG9Yh5+xj3cFUPGnxMPDvrc5FUEGScngxNFnFQFxHhhR9cLBpkwkIWV+U9kJV7T5gRlPd7IA92yWJ76Kb78DnTlL4m+JbR+0/eAZzkLk/Tyxm7WdVJyv6i7ufNDwZ8iFSLQMD1n9WAHX5dNm0fHChQbwMnNrz48tXtreCYMSNhLWMNOKIamHdgu0f47oMjVnHlrgBlFWGUrNOpLKylxTUE6Hvckz2xEibVhSJG6ynrHPSfyXX7qMX8OqomZzfPqK0xN0uW512qiGNjj5u+LzNmBrzesEYZ6nv+Yr85QMkzqjimsZBqXritrsOkOykqpvJd9etTDTHC7xExRfM/Vj3HvO5elhrHvlV1hiDBI3i4p3BHupfyDTRK3ccCDCjCXEwI5bH/+SdWdGRvf6thDXll+oAIhxVVvVNunXRoJthDo27pSyaf5ra7Pur5Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(396003)(366004)(376002)(136003)(451199021)(4744005)(316002)(41300700001)(2906002)(38070700005)(7416002)(8676002)(5660300002)(36756003)(86362001)(8936002)(6506007)(6512007)(26005)(478600001)(6486002)(82960400001)(71200400001)(921005)(186003)(2616005)(91956017)(76116006)(66946007)(38100700002)(66476007)(4326008)(64756008)(66556008)(54906003)(66446008)(122000001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eGZzMHNxUy9FY0ljUm1CSlBHNXlpUVRqREczU0I2blB2Z2h6aTBXUzZrd3Jm?=
 =?utf-8?B?S0dYOWVnckQraWNKZ2o0Z3Q0RkdsL3VrRkk4SXk3dXgrcDU5YjBlVXlHMmgz?=
 =?utf-8?B?eFZ4OUhzMzU0TlJoUkhWaWVIM1VRWWFsdDNYYTAwbFNXVUliZXphbVBnZVIy?=
 =?utf-8?B?bzZtdk1lNEhORkFib3VUWVczRnRiSTNJTmMwZFVpbmVvcXFKcEVBdHlra29i?=
 =?utf-8?B?STRidW9QYXNIaTJiUUp6NjVrVzZHazd6cjNlUzVWN0duRTRsQ2ZTWFByMUcy?=
 =?utf-8?B?OFJQZXdqT20ya2cvYzdCcDNIbE12QitENmh0NHk4aWtwcUNmb0k5dTBuVUsv?=
 =?utf-8?B?cGtFSjEwOHN6cnptNXNxSTlXaDJXazVqckV2MWlrWllZSVNSZGU3ZFI4bTlk?=
 =?utf-8?B?QWs5QjZvZHQwRFFHQ01hdjRWZThIVEpuSmRrODVoL1Y1L3FrNEdVU21xbGJx?=
 =?utf-8?B?TXdidmpLMWFSOHdPemJWOUxpSFlhTUk3Rm4rZmlla1pIUzhneVFQaTVJcVlE?=
 =?utf-8?B?VHdjKzdqREhPM0Y4NzRncUFTazA0ZnBwc0g0alhJLzJORVRNT2tzUEhka2FY?=
 =?utf-8?B?VGd1VDd4QXJNUy9icCtSQmorR2dqdmNBSjBTV2ZBb0FBQkRnNHcrdzgvZlRx?=
 =?utf-8?B?d1NIYkcwOUhCeFZ3WXR2Qm5mSXNnRnRHdFNQMEpTeG1vZTExQjNhOUMvNWNX?=
 =?utf-8?B?eG9hNzArZ0RzWlZiQ082djl4ZGZIdmREVm5ESDVkWkd4NlZQQzlTbFNicTgv?=
 =?utf-8?B?QXlwZzhqMjRSSWx2MmdDaURsMC8vU1BNT2MwcVczb0pBSnM5bElNNTkrRUVs?=
 =?utf-8?B?VHl2NDFjbjJENEthY2RIVlJORklhdkt0MlZkK256K3pscXBCaEtrVGVXeGlu?=
 =?utf-8?B?T3lLMnpUVVhBVmU5dFNPZXBldjBWdVlZY2VXV0JDdXprU1FoTFdMTVBNTkd4?=
 =?utf-8?B?Z0g5YS8yOHNFa3ByWjhWaThTcmtPc1hFalJERnFEaDFTT2t3QVB3SHo5Ni9V?=
 =?utf-8?B?QXhQOUdzRnF3aVQxcHlSd2xnT2JuUjVEOGlxdXZWQlBBUENFVkNhYlpLQlY3?=
 =?utf-8?B?SkI0aWNlUFRyZ3FnT0d3V3JnL0tWUHg2QUVCazBQdklEWEVOM2x6MTBnQy9j?=
 =?utf-8?B?a3llTUU4WE84OEFIUHhaMy9tbUNzdW12dzIrVjhsZ1J6Z2dKOWM2L1Jvd2pk?=
 =?utf-8?B?NFNBelk1WXdtRlpUOXI1end0ejZUV3pEOGNWWmhrbHNqWXh4UndoQVplR0RH?=
 =?utf-8?B?NlR4Zm9UdDNmTDNxWmdsYWZzRnBaTCtmWUZxdVBjWGtYdk9oVHJvV1h2Vjh3?=
 =?utf-8?B?Q09SblAxdzhocEtqWHo3U3RJOXJKVXNqWm8vc2FGL2pCWDFUSDVrM2cyVXJv?=
 =?utf-8?B?UjJZZEFQMG54eDM0bldyeVFZdnZIdGdFQW0vOHJRZWFGWnFWS1YvVFV2eHk5?=
 =?utf-8?B?dkp2SUhQanNOUjR4QUFqSGlxS1VDOGN4Mk9QejFxL09mUldCUjhBVzIzbGVU?=
 =?utf-8?B?UU4yRzJxb1VxZVpJS0FZb2t3S3V3U2ZXRExaWGZzZTJ6SUx5MVY4UmFBOTQy?=
 =?utf-8?B?S1BDZmFRVDF0dG55czdxZE9WclJRMVdUKzNKS2oxMUsvUEJnNThXMVdkNmZD?=
 =?utf-8?B?cDg5b2lSSCtpWGdEZlpmUE9pQlJQZTQrV1RHazVnUmxvQm9zb29EWEM4QVJo?=
 =?utf-8?B?RGtYMDlQM3g1dnA1eWhiemI5dWErMndTTkVGYmJFTDUvY3RSalkySTJDdmww?=
 =?utf-8?B?d1pxTmtTZGFkR09sSkZ3cXA4akFQZU81VTFDNUNCT2t0Z1d4OFhIZmlDU0t6?=
 =?utf-8?B?VWdWMUFOMS8xOElhYnUzVmZITlpIZDhvOXY0L0ZwdXdDci9pSUJuSy9vVW9B?=
 =?utf-8?B?ZEVuWW8yNHEvUFRaeHdFUEdLZXB1R3RXQjc0cTZNZGNiRUNHb2lYcEpnTXRq?=
 =?utf-8?B?Rk1rOE5WYUhsbzU5N1lvdElrRm5QdWVTVFFndms5UmFCL25xTzZ6S251RElj?=
 =?utf-8?B?SkdUMExLRW4wb3ZJUnllVW83cVBWbk5Gck92ak9SUmVGMFNqVi9XZXhYTEZY?=
 =?utf-8?B?bDFDUjRJMk5XYzhaWUU2TEFwTHZqTUFBYVlGTk1UaVRYdFdKazY4WlhnNEds?=
 =?utf-8?Q?SPFjybepBW0+2fl7dsGW9jFwF?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4ACD125CBC543F49A8DAA7C868E6E487@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4038ea-11da-4947-29fd-08db8e4f389a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 03:11:50.6203
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsGADv1fR97f1Cs5Bynm2ZtyvzL3pfdPG7xid4UGEjkwG5KCNY5fD+KdxSIzynM/iPVQuPv/NuN197VrnzmdoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6492
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVGh1LCAyMDIzLTA3LTI3IGF0IDAyOjUwICswMDAwLCBIdWFuZywgS2FpIHdyb3RlOg0KPiA+
IEFuIGVuY2xhdmUgY2FuIG5vdCBydW4gbm9yIGdlbmVyYXRlIHBhZ2UgZmF1bHRzIHdpdGhvdXQg
YSByZXNpZGVudCBTRUNTDQo+ID4gcGFnZS7CoA0KPiA+IA0KPiANCj4gSSBhbSBub3Qgc3VyZSB3
aGV0aGVyICJub3IgZ2VuZXJhdGUgcGFnZSBmYXVsdHMgd2l0aG91dCBhIHJlc2lkZW50IFNFQ1Mg
cGFnZSIgaXMNCj4gYWNjdXJhdGU/wqAgV2hlbiBTRUNTIGlzIHN3YXBwZWQgb3V0LCBJIHN1cHBv
c2UgdGhlIGZpcnN0IEVFTlRFUiBzaG91bGQgdHJpZ2dlciBhDQo+ICNQRiBvbiB0aGUgVFNDIHBh
Z2UgYW5kIGluIHRoZSAjUEYgaGFuZGxlciB0aGUgU0VDUyB3aWxsIGJlIHN3YXBwZWQgaW4gZmly
c3QuDQo+IA0KPiBJIGd1ZXNzIHlvdSBjYW4ganVzdCByZW1vdmUgdGhpcyBzZW50ZW5jZT8NCg0K
SG1tLi4gUHJvYmFibHkgSSBzaG91bGQgaW50ZXJwcmV0IHRoaXMgc2VudGVuY2UgYXMgdGhlIGVu
Y2xhdmUgImNvZGUiIGl0c2VsZg0KY2Fubm90IGdlbmVyYXRlIHBhZ2UgZmF1bHRzIHdpdGhvdXQg
YSByZXNpZGVudCBTRUNTLiAgVGhpcyBpcyB0cnVlLiAgU28gZmVlbA0KZnJlZSB0byBpZ25vcmUg
dGhpcyBjb21tZW50Lg0K
