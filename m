Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8202A8064A6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 03:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376399AbjLFB2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 20:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjLFB2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 20:28:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7AEA109
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 17:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701826125; x=1733362125;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=LqHlrkgHCsUm0yax9UXwZWXhFyjuHqrqEi3c7mIzGOg=;
  b=kJwGI5aYMYFj9ispe6knSh3FTtR7rAaZH04FLOmbOReOkc++eC/tmCM/
   f6uG1YxzVvM0Dqz8DK6t0CNScyq0swAsVoZ1gcrxZ+lIgGbmtgATguIBe
   lF8mkty+pKE/4ANWMvJLD6qRXRdIpcNGY+2Yvan/opdzduW9K/VikCImo
   IKyGlUcKwAZ8TKWwZJ6eJWhIvHsTYy9qaqeCIf7QFLWk97TrNKVlZsQni
   cwTT3hEXYDFq/fNMs+Stw/FI7FvVAS4bELGAeMQMEdXdLMHbdwBObKZxs
   f5JIImhWXdNBlUZdXMVSmNYtdG8DJIschpcJstDri+Mf0SyYWLGl3MlCb
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="1076859"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="1076859"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 17:28:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10915"; a="774820648"
X-IronPort-AV: E=Sophos;i="6.04,254,1695711600"; 
   d="scan'208";a="774820648"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Dec 2023 17:28:21 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:28:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Dec 2023 17:28:20 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Dec 2023 17:28:20 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Dec 2023 17:28:15 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k29S89qyPSte0cRB2bmiGNPmPTTCJmIidjLytKtPdAB8Xyku20f2YyBrb1o/scgKMk/agaTtjKRuFuNYVwEmt6NCMRyEzho+GlVGlFCiZH46rXQeegEZVCBSG5wPtAnqJpxpFWvt372FJrKkK/A0+LsMwr68linsfC3COdILXLQUdFdTt48pG0mmELJ6kZ7pSm+YwYaBckYPWVhL5kOhfwqrRs4aoRX032DdWblz8w+XiPCEddy02MzOkEALA50RF9ouJoBFWOCsQdgEoZOBoNSgYgJLafWsSnlYLYOvdv8iRCYLWUovi+uDjIUknPkLVLm0W4V73vL0utLC/O65Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LqHlrkgHCsUm0yax9UXwZWXhFyjuHqrqEi3c7mIzGOg=;
 b=DqMcpsPunq8Qu8OH0PRYfdopWmGfZJ52Jedr4ZUshtcU3KYJ5ryGw3ii0dHX3ZqiRKHmu0Md1tkQB6nV/GqSfT++xDJtMO4t2yC/fXlFCRA/f/DMAy/EWaIhL+M7wF1S98dBc5Vgkybb6AsD9o0qBrhJiUnap28iscR2GO07/UuwnYTj5ARQfOQNjAIggClpaWX4d4eaNI/GrY7GPKc7Q7Hgyia7DDJnTqlnm5NP9KmS7tukydRStd+BsONCngHDWwArHq+MRcg/H7DSAiKUzocFc+bex7Yq3knptvLvqAS/q+IDrV/+Gy2QgS2GP/l8m5N9xSn8lhuavTRdhGxL2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by DS0PR11MB7444.namprd11.prod.outlook.com (2603:10b6:8:146::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 01:28:08 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::6dc:cee5:b26b:7d93%4]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 01:28:08 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "x86@kernel.org" <x86@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>
CC:     "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "Nakajima, Jun" <jun.nakajima@intel.com>,
        "rafael@kernel.org" <rafael@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "Huang, Kai" <kai.huang@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Hunter, Adrian" <adrian.hunter@intel.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "ashish.kalra@amd.com" <ashish.kalra@amd.com>,
        "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "seanjc@google.com" <seanjc@google.com>,
        "bhe@redhat.com" <bhe@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCHv4 10/14] x86/tdx: Convert shared memory back to private on
 kexec
Thread-Topic: [PATCHv4 10/14] x86/tdx: Convert shared memory back to private
 on kexec
Thread-Index: AQHaJxRg6aYbhJu/jEihwtrgSIlA/bCbeMWA
Date:   Wed, 6 Dec 2023 01:28:08 +0000
Message-ID: <3cf8b953c449320cc4c085924ef0e2eed5eadcf7.camel@intel.com>
References: <20231205004510.27164-1-kirill.shutemov@linux.intel.com>
         <20231205004510.27164-11-kirill.shutemov@linux.intel.com>
In-Reply-To: <20231205004510.27164-11-kirill.shutemov@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|DS0PR11MB7444:EE_
x-ms-office365-filtering-correlation-id: 0d81f220-79f0-4bd3-2bfa-08dbf5fa9a82
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gm9DlSlYY7lMZ1d3cdiSAFGFwJzILuyxSgO0htMEAINA30LpgBeI0fwRCraRQLlABofrzG737yBOGuyxUL7anPQlQe00hk/Z9T11Bzp6+DLm+jFW10/DNG4B5U2g6jUeQUcDJLjjIWk8Tg7BG0lhFlpy09ygnRHPobHTVTpdFyjpwMUx4yCIFSP4vac/gAn5QtUt6Ith6hBA44I6xzAUGpR+ocQygv1A1c/7uKXXMA+WO94ThEPNlFHPdbAmHDGo4lqcD07A8EcJCo47Zeq/1TEFoCTrigCxsMfdeNPQxEtPgaK2K85GDBh6rm6wO6ZLcfUY59ZhYd/3DGcU+ExV0mjjWEiQK3nquK0aXR0nx078At5LRTW6QvC53SQ6XSofqeHI+CkNGLatmF947ZGJuey5LTfhWEmS3XedFdlAES8oQP7d3uDO/fH2TlXkJIf4l4rm89TTk+eNWZj2sRdK6XLvP9cg7h0sTr8z68i0gCorjnvjO1uY6Qj3O62QCqIdhl8ECdGCA6aa6SulSvsM6C5x5SW+u7SV6DMqtx4bWKSfuLrvEg0FNjQWjevvbbZqBsm6OUgmPEX03Nh8w/KnI+JwncLudZj4aSNL8KrxC4/2qFbJ7ywrKFWXZJFaYdCVb+WXInM7lzjyGv93RK3F6mAVi6eiMW9QdA3bRGC4lGo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(39860400002)(366004)(376002)(230922051799003)(230273577357003)(230173577357003)(186009)(1800799012)(451199024)(64100799003)(38100700002)(38070700009)(122000001)(5660300002)(7416002)(83380400001)(82960400001)(6512007)(71200400001)(2906002)(6506007)(26005)(2616005)(36756003)(76116006)(110136005)(6486002)(478600001)(91956017)(41300700001)(66946007)(86362001)(64756008)(54906003)(66476007)(66556008)(316002)(66446008)(4326008)(8676002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dGcrTEZZWmxMbDZ0TEVGcXBSS2VaQll4alAxU3k1TFVJT1ZuNE5PNHIvSTgz?=
 =?utf-8?B?TTBYbGEvbEtVNHFpYkpmbUdENHBXbXNEL1FORkgvYWNqTEZFN0F4WG43R0ls?=
 =?utf-8?B?VjE3SzFneWVncUgvSFdDb0JpVFJIQlMzTFE3ZW1CTWRFb0VqcldFUzkzMTM5?=
 =?utf-8?B?S2xCLzJyeVp2eHJDa0g2WWpGdzVUNGxSNUF2U2toUkhKQUZZb0dlUFpIZS9I?=
 =?utf-8?B?NXhHclVuQzN0OHN2WmJUb1p4YmxSOUF1eTl0bHZRUXlCVm5sK1J5T1BHWFZZ?=
 =?utf-8?B?ejFoYTlRM3BmaitjZU1mNUxEV3E5L0NubE9XT2hBTVZxYk5PUDhWazU5ZnY5?=
 =?utf-8?B?cWlEc0FRK1J4aTMrYVh4djNKRlhsVWlPWk0xY3oranhHa3ZrVnlGZkNNT1FR?=
 =?utf-8?B?OHljUENMd1hmSEovcHBxRkRGcWttb0orV2poRmdsZC93UW9wY0plUmJXVTBh?=
 =?utf-8?B?MC9qYVZNbkxhUmdHMENHRnRteDEyODlleHhYV1RaZVZZOENPOXhNTUJndG9k?=
 =?utf-8?B?dzQ0UFQ1bkZoWlhJTTNPNUdxazFjTlRQbmdsZzRRaDBBb2VhSHZ4TzVRRWZU?=
 =?utf-8?B?UlFQdzhZbi9uT00zWTdaVlVNcEJLV3RaOWcyd2hYVUFlbTA2L1ZSd3F0NW9q?=
 =?utf-8?B?bnlrY1FLWUg2WGNUSWwycjJVTGRHTldLRlZ3Yi9lT0lLWE5VNUFJZ2ppNVpq?=
 =?utf-8?B?QTgvd0plZ1ZGalRuSjg5R3d2TnlJLzVUR1ZXM2Z0QkUrQWpZNTZhNjFCcnlT?=
 =?utf-8?B?N3RVY0JRbDNTenUycGFCSStsTlhqdUI5cFBWck4zYXd4YnFxOWJ4MGxVNkZP?=
 =?utf-8?B?ZW1SUmRQMGpkeW5INlFJQnZEUHNnamQvS3NXckJtZnFOY2xWQlh2bFh6ZzhS?=
 =?utf-8?B?eWhjNEtEdHBMRXJZVnpIbDVRNm1NZG0zdFBxQk1EM005MUFNSVN3dFNhVHdm?=
 =?utf-8?B?ZkRtTGV6SUhwdU1RTlcxb1pEYTUvOHV3SjYrMGhDUEZ4dHQvdmZpenZLZFl6?=
 =?utf-8?B?T2lLTjNhVTJNcUJoYk9qM0kvTDNtOHJRTUNtaU5scWFWTmFIVGE2MU4vRUx0?=
 =?utf-8?B?dXNpMDdadkRodVJINDJEaFgyUTA0M0JtWEowV0ZrUjNBaVBzemgxQnIwd2lH?=
 =?utf-8?B?U3pjTW1PcUdVVDJGNkI1YmxrLzZ1ZDRVK1pRZUNKZVFqTjBuWEhlVkZZYUxy?=
 =?utf-8?B?c0tUeFM1aGM5TkR1MlEyaEVFa2p6R0dLNjZsUnFCQUFJalEzMXZZeUNvMms1?=
 =?utf-8?B?TFQycW4wUVZsT0Ntd1NSY1pPQ1lySUcyaGF0V2VFZkFQRVozZW9QVmllSG5G?=
 =?utf-8?B?NkIvaWtQZ1YyLzluMGhXQ3dNTUNWUXBxa015WDhxaVk1YUZlR0NUdUMwdU4x?=
 =?utf-8?B?eHBrcVlPcDRGd1k2RGE4QjJTTVNNdk9lTUxhWDI1dzNCbGJUcExZNEFQNDFn?=
 =?utf-8?B?STFVYXVzbkJITDNkMGNWT2V1RnB6YnNCZWZmbURUVzBxZGpoTnV0VEV3Lytt?=
 =?utf-8?B?cS9sZHlLV2IvclFsVXI1Zy9vMDVpZEdoQnZ6QUgwbkxXOFlUTFdBODVuaGs5?=
 =?utf-8?B?MElpdHhpZmhZTnNlZVJ4dk9NOCtGWi9mMFJieDJMOGFtK0JMcHRDckk3MFJX?=
 =?utf-8?B?cE8wMi9lcVpGN2pmV1ZxMHhSRnB4RkgxOHgrZXpUUTNHVm1Za2lCeGVrcDdE?=
 =?utf-8?B?VytiaXJFcEduaEsvdkxseDRpT2VGUi9kUENqQ3NHbVVkNG8zOTFhbGk5bXNC?=
 =?utf-8?B?eVZJOUpwWG9ZRmN4V2RhNDdjOC9qTlVpZkk1b2Jhb2Q5RmZhTkFLMURsYjVt?=
 =?utf-8?B?cnJZMnN6U1dqTXAwTGMvZjVnc3MrSXZlWkxiMzZDV0pLMTZXeUY0VDRHZEZt?=
 =?utf-8?B?YklaekIyUmR5c0EvUS8wWkRUWlhuaHFieTlxZlBVR21aOWg2WkRqcU5JWWov?=
 =?utf-8?B?Y1RsNnplUVNUeFJ4TFIrblI3RmU1a20xRlZoTUJjQ25NalErQlUzNmZrbVph?=
 =?utf-8?B?ckVxdlB4MXp6d2FjMktMQkp2YmQvb1BzclhyU1hwamVYQ3AxR1ZyTVhodHQ0?=
 =?utf-8?B?cmdPMENFK0MzME5scFdFNDR6NnhxT25xQVg1UjlSQ1NSNEhERWJxeVdSaDl0?=
 =?utf-8?B?M0pUN2IwS3VKSURYTXhBWklpOXVTeSs3bUE1eTRoRm9kd3Q1NVhzOHhrYTNO?=
 =?utf-8?B?Vnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <9170D72FCC2A544E9A38DB3640616E81@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d81f220-79f0-4bd3-2bfa-08dbf5fa9a82
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 01:28:08.5342
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NIqruUNyoBkHsjwfFcJ19AGYL3edBCfIBh1aph/z4lwKKcSBpF1OXS2NtWOj3S4VP6dqNsqeLmwq5PP7ZaoCnN4wJL3uddS80IDD1ZlNVTQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7444
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTEyLTA1IGF0IDAzOjQ1ICswMzAwLCBLaXJpbGwgQS4gU2h1dGVtb3Ygd3Jv
dGU6wqAKPiArc3RhdGljIHZvaWQgdGR4X2tleGVjX3Vuc2hhcmVfbWVtKGJvb2wgY3Jhc2gpCj4g
K3sKPiArwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIGFkZHIsIGVuZDsKPiArwqDCoMKgwqDC
oMKgwqBsb25nIGZvdW5kID0gMCwgc2hhcmVkOwo+ICsKPiArwqDCoMKgwqDCoMKgwqAvKiBTdG9w
IG5ldyBwcml2YXRlPC0+c2hhcmVkIGNvbnZlcnNpb25zICovCj4gK8KgwqDCoMKgwqDCoMKgY29u
dmVyc2lvbl9hbGxvd2VkID0gZmFsc2U7CgpJIHdvbmRlciBpZiB0aGlzIG1pZ2h0IG5lZWQgYSBj
b21waWxlciBiYXJyaWVyIGhlcmUgdG8gYmUgdG90YWxseSBzYWZlLgpJJ20gbm90IHN1cmUuCgo+
ICsKPiArwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKgwqDCoCAqIENyYXNoIGtlcm5lbCBy
ZWFjaGVzIGhlcmUgd2l0aCBpbnRlcnJ1cHRzIGRpc2FibGVkOiBjYW4ndAo+IHdhaXQgZm9yCj4g
K8KgwqDCoMKgwqDCoMKgICogY29udmVyc2lvbnMgdG8gZmluaXNoLgo+ICvCoMKgwqDCoMKgwqDC
oCAqCj4gK8KgwqDCoMKgwqDCoMKgICogSWYgcmFjZSBoYXBwZW5lZCwganVzdCByZXBvcnQgYW5k
IHByb2NlZWQuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKCFjcmFz
aCkgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBsb25nIHRpbWVv
dXQ7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAvKgo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBXYWl0IGZvciBpbi1mbGlnaHQgY29udmVyc2lvbnMgdG8g
Y29tcGxldGUuCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqCj4gK8KgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqIERvIG5vdCB3YWl0IG1vcmUgdGhhbiAzMCBzZWNvbmRz
Lgo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8KPiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgdGltZW91dCA9IDMwICogVVNFQ19QRVJfU0VDOwo+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB3aGlsZSAoYXRvbWljX3JlYWQoJmNvbnZlcnNpb25zX2luX3By
b2dyZXNzKSAmJgo+IHRpbWVvdXQtLSkKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoHVkZWxheSgxKTsKPiArwqDCoMKgwqDCoMKgwqB9Cj4gKwo+ICvCoMKg
wqDCoMKgwqDCoGlmIChhdG9taWNfcmVhZCgmY29udmVyc2lvbnNfaW5fcHJvZ3Jlc3MpKQo+ICvC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqBwcl93YXJuKCJGYWlsZWQgdG8gZmluaXNoIHNo
YXJlZDwtPnByaXZhdGUKPiBjb252ZXJzaW9uc1xuIik7CgpJIGNhbid0IHRoaW5rIG9mIGFueSBu
b24tcmlkaWN1bG91cyB3YXkgdG8gaGFuZGxlIHRoaXMgY2FzZS4gTWF5YmUgd2UKbmVlZCBWTU0g
aGVscC4KCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYyBiL2FyY2gv
eDg2L2tlcm5lbC9yZWJvb3QuYwo+IGluZGV4IDgzMDQyNWU2ZDM4ZS4uYzgxYWZmZmFhOTU0IDEw
MDY0NAo+IC0tLSBhL2FyY2gveDg2L2tlcm5lbC9yZWJvb3QuYwo+ICsrKyBiL2FyY2gveDg2L2tl
cm5lbC9yZWJvb3QuYwo+IEBAIC0xMiw2ICsxMiw3IEBACj4gwqAjaW5jbHVkZSA8bGludXgvZGVs
YXkuaD4KPiDCoCNpbmNsdWRlIDxsaW51eC9vYmp0b29sLmg+Cj4gwqAjaW5jbHVkZSA8bGludXgv
cGd0YWJsZS5oPgo+ICsjaW5jbHVkZSA8bGludXgva2V4ZWMuaD4KPiDCoCNpbmNsdWRlIDxhY3Bp
L3JlYm9vdC5oPgo+IMKgI2luY2x1ZGUgPGFzbS9pby5oPgo+IMKgI2luY2x1ZGUgPGFzbS9hcGlj
Lmg+Cj4gQEAgLTMxLDYgKzMyLDcgQEAKPiDCoCNpbmNsdWRlIDxhc20vcmVhbG1vZGUuaD4KPiDC
oCNpbmNsdWRlIDxhc20veDg2X2luaXQuaD4KPiDCoCNpbmNsdWRlIDxhc20vZWZpLmg+Cj4gKyNp
bmNsdWRlIDxhc20vdGR4Lmg+Cj4gwqAKPiDCoC8qCj4gwqAgKiBQb3dlciBvZmYgZnVuY3Rpb24s
IGlmIGFueQo+IEBAIC03MTYsNiArNzE4LDE0IEBAIHN0YXRpYyB2b2lkCj4gbmF0aXZlX21hY2hp
bmVfZW1lcmdlbmN5X3Jlc3RhcnQodm9pZCkKPiDCoAo+IMKgdm9pZCBuYXRpdmVfbWFjaGluZV9z
aHV0ZG93bih2b2lkKQo+IMKgewo+ICvCoMKgwqDCoMKgwqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKg
ICogQ2FsbCBlbmNfa2V4ZWNfdW5zaGFyZV9tZW0oKSB3aGlsZSBhbGwgQ1BVcyBhcmUgc3RpbGwK
PiBhY3RpdmUgYW5kCj4gK8KgwqDCoMKgwqDCoMKgICogaW50ZXJydXB0cyBhcmUgZW5hYmxlZC4g
VGhpcyB3aWxsIGFsbG93IGFsbCBpbi1mbGlnaHQKPiBtZW1vcnkKPiArwqDCoMKgwqDCoMKgwqAg
KiBjb252ZXJzaW9ucyB0byBmaW5pc2ggY2xlYW5seSBiZWZvcmUgdW5zaGFyaW5nIGFsbCBtZW1v
cnkuCj4gK8KgwqDCoMKgwqDCoMKgICovCj4gK8KgwqDCoMKgwqDCoMKgaWYgKGNjX3BsYXRmb3Jt
X2hhcyhDQ19BVFRSX0dVRVNUX01FTV9FTkNSWVBUKSAmJgo+IGtleGVjX2luX3Byb2dyZXNzKQo+
ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB4ODZfcGxhdGZvcm0uZ3Vlc3QuZW5jX2tl
eGVjX3Vuc2hhcmVfbWVtKGZhbHNlKTsKClRoZXNlIHF1ZXN0aW9ucyBhcmUgY29taW5nIGZyb20g
YW4gaW5jb21wbGV0ZSB1bmRlcnN0YW5kaW5nIG9mIHRoZQprZXhlYy9yZWJvb3Qgb3BlcmF0aW9u
LiBQbGVhc2UgZGlzcmVnYXJkIGlmIGl0IGlzIG5vdCBoZWxwZnVsLgoKQnkgZG9pbmcgdGhpcyB3
aGlsZSBvdGhlciB0YXNrcyBjYW4gc3RpbGwgcnVuLCBpdCBoYW5kbGVzIHRoZQpjb252ZXJzaW9u
IHJhY2VzIGluIHRoZSAhY3Jhc2ggY2FzZS4gQnV0IHRoZW4gaXQgc2V0cyBzaGFyZWQgcGFnZXMg
dG8KTlAuIFdoYXQgaGFwcGVucyBpZiBhbm90aGVyIGFjdGl2ZSB0YXNrIHRyaWVzIHRvIHdyaXRl
IHRvIG9uZT8KCkkgZ3Vlc3Mgd2UgcmVseSBvbiB0aGUga2VybmVsX3Jlc3RhcnRfcHJlcGFyZSgp
LT5kZXZpY2Vfc2h1dGRvd24oKSB0bwpjbGVhbiB1cCwgd2hpY2ggcnVucyBiZWZvcmUgbmF0aXZl
X21hY2hpbmVfc2h1dGRvd24oKS4gU28gdGhlcmUgbWlnaHQKYmUgY29udmVyc2lvbnMgaW4gcHJv
Z3Jlc3Mgd2hlbiB0ZHhfa2V4ZWNfdW5zaGFyZV9tZW0oKSBpcyBjYWxsZWQsIGZyb20KdGhlIGFs
bG9jYXRvciB3b3JrIHF1ZXVlcy4gQnV0IHRoZSBhY3R1YWwgbWVtb3J5IHdvbid0IGJlIGFjY2Vz
c2VkCmR1cmluZyB0aGF0IG9wZXJhdGlvbi4KCkJ1dCB0aGUgY29uc29sZSBtdXN0IGJlIGFjdGl2
ZT8gT3Igb3RoZXJ3aXNlIHdobyBjYW4gc2VlIHRoZXNlCndhcm5pbmdzLiBJdCBkb2Vzbid0IHVz
ZSBhIHNoYXJlZCBwYWdlPyBPciB0aGUgS1ZNIGNsb2NrLCB3aGljaCBsb29rcwp0byBjbGVhbiB1
cCBhdCBjcHUgdGVhciBkb3duLCB3aGljaCBub3cgaGFwcGVucyBhZnRlcgp0ZHhfa2V4ZWNfdW5z
aGFyZV9tZW0oKT8gU28gSSB3b25kZXIgaWYgdGhlcmUgbWlnaHQgYmUgY2FzZXMuCgpJZiBzbywg
bWF5YmUgeW91IGNvdWxkIGhhbHQgdGhlIGNvbnZlcnNpb25zIGluCm5hdGl2ZV9tYWNoaW5lX3No
dXRkb3duKCksIHRoZW4gZG8gdGhlIGFjdHVhbCByZXNldCB0byBwcml2YXRlIGFmdGVyCnRhc2tz
IGNhbid0IHNjaGVkdWxlLiBJJ2Qgc3RpbGwgd29uZGVyIGFib3V0IGlmIGFueXRoaW5nIG1pZ2h0
IHRyeSB0bwphY2Nlc3MgYSBzaGFyZWQgcGFnZSB0cmlnZ2VyZWQgYnkgdGhlIGNvbnNvbGUgb3V0
cHV0LgoKCj4gKwo+IMKgwqDCoMKgwqDCoMKgwqAvKiBTdG9wIHRoZSBjcHVzIGFuZCBhcGljcyAq
Lwo+IMKgI2lmZGVmIENPTkZJR19YODZfSU9fQVBJQwo+IMKgwqDCoMKgwqDCoMKgwqAvKgoK
