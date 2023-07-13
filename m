Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C73BA752773
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 17:40:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232469AbjGMPkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 11:40:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231597AbjGMPkT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 11:40:19 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09FE2701;
        Thu, 13 Jul 2023 08:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689262816; x=1720798816;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uXlVPcqWoqlmHireKc9blS0vD8zdDTK31Gf4r8KDe/g=;
  b=FjuqaJd6izbpAPEIqXpVom36PMZZGgl8ysYQYcHnkenNaQ4yqcmn/tui
   gcV9vSpAr7ApInVI9r23ULbQ/hF6iZj3qHudaOEdl78/GY4HNSGouoR7r
   48hV1Mt/chVgJtSECC9j6NYHGKJ13PX6mlALKp7yUWJ0jNivbS6LW6K5e
   3i4y/hSCwYtakKqSmuaJT6Yn5X2nkM0ezmzEdUFIN5xdXXvKcBgouAFMk
   0bQAz7pjMQ9QPbmSaEajGp7Adn7gZgDXdAMkqwmw21hnzUhvpi4W4EmxK
   Ub7rPZnjkkj0Wxx98EKtgEah30QYpVCegqfBd2oZuQkiRTaBrIMkhbzyC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="364094230"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="364094230"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 08:40:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="725340817"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="725340817"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jul 2023 08:40:15 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 08:40:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 13 Jul 2023 08:40:14 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 13 Jul 2023 08:40:14 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 13 Jul 2023 08:40:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kl+u2lbxxDVcILTgkVB0FvgxfMMcuoff4dtQ9IGF+AMY10WtZvoM0FUNfSW7gIkwVHvTzZ+GG0bQvM85OsBrMN2wqcPz0IcuPGAWLKwq96qS2dJQxGY70/zlo3HbnbtqgbEnctzP7d6EC2Jjh9GHypxY7a2iTDmPsZRu0AFFY+Ro7hupNfwGo+8h2Xk4ZJravVL/DGPgdKExmGwU7+VTt6a/B4I7dxl1HN5z6zSY8/vQqg0zzcv5Pox5015VTKTjM1Z2wJw1KgD2yzhRI0JfAdUY06UvnlQ7afGwONosveHWlqHQidgAtzcUu5kf0BHkHaqjsRBwUeXznRIaO+1g7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uXlVPcqWoqlmHireKc9blS0vD8zdDTK31Gf4r8KDe/g=;
 b=nux27uHGmUcb0HZ3EQ+2wUfw1Ak59ImY9uSXyApt/VnPqXjmG11z7DnTZi2ykmqt9mC3/mK4kCbCkwLb+nkZFT56JYJJtvXa8m/Sbl6U0VWNoJsFNCgctPXAebSDA75MIMzkkzsT/RnCwM7jKR3XmIga01+sUTObl/iJ5oqN1/SzbPl11rsyVP8Q/DWCCdvMFc5+dPBfp/uP+l7kzWVN2xvYFivbFZ6tCsxAF8/aj3McVA/yxoH2DZP7Vc8kHReyFXLGbFIRqJ5ilmlxSVTeiypnsjSX8nvDSFDO0EJ94nHySIcpU20eEcSrgnKHwmzrQW1uL1uJSOhlZA6YegOq9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB7125.namprd11.prod.outlook.com (2603:10b6:303:219::12)
 by PH7PR11MB7595.namprd11.prod.outlook.com (2603:10b6:510:27a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.24; Thu, 13 Jul
 2023 15:40:12 +0000
Received: from MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7]) by MW4PR11MB7125.namprd11.prod.outlook.com
 ([fe80::c482:66a7:a0b3:7b7%4]) with mapi id 15.20.6588.024; Thu, 13 Jul 2023
 15:40:11 +0000
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
Thread-Index: AQHZn9Tstvh84woP/kqwvI9d+8RyUq+ND9wAgCe4+ACAAA4cAIAClJOAgAAKogCAAIPpAIAAAk0AgAAEmAA=
Date:   Thu, 13 Jul 2023 15:40:11 +0000
Message-ID: <b62572356db07ae0c3305ed03916b0ff40b14426.camel@intel.com>
References: <20230613-vv-kmem_memmap-v1-0-f6de9c6af2c6@intel.com>
         <20230613-vv-kmem_memmap-v1-3-f6de9c6af2c6@intel.com>
         <aadbedeb-424d-a146-392d-d56680263691@redhat.com>
         <87edleplkn.fsf@linux.ibm.com>
         <1df12885-9ae4-6aef-1a31-91ecd5a18d24@redhat.com>
         <5a8e9b1b6c8d6d9e5405ca35abb9be3ed09761c3.camel@intel.com>
         <ee0c84ff-6d97-3b7c-88a8-dd00797c2999@redhat.com>
         <6cb5624ebf3039b18f5180262fc6383b402d26ea.camel@intel.com>
         <80c8654e-21fb-b187-3475-9a1410a53a4e@redhat.com>
In-Reply-To: <80c8654e-21fb-b187-3475-9a1410a53a4e@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB7125:EE_|PH7PR11MB7595:EE_
x-ms-office365-filtering-correlation-id: d6851077-e58c-4a46-c387-08db83b771f8
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Mb12CUI3h101c3/Ag8B4e2rgy3CbhoLG2ixnaiJASCfeoXmTlG6X+dS2EARAhPTSynBpF2++MqTU61ZVnlnhmPqt3wFIz2Dp4o4zmPxj8SBMFYqS92EdNecOqPuftIv27w9VpBLhS6a4v68/XhNKjb1ubcHVz3ECVxM0gefFgXoQO/OpOAbLpsfvVkRGf9RM4mAtV/mm2ILN923GZLPQ0z8diN8phy85pclhF5WESPTU4XEsNDr343kvjulVkXVe7Yu/oE18G2wkTutIULgY7IU7ccPFbUYy81udJUvpmr4I4xevGtpcnXpaHXnIZglvPo8mzczAmXldveksa9vMlJwuQPVBHckxaLR5ky4twMkhtzoz0CnM090I/+Of3iLR/4PivkOFGvimHP2gxKcsWJ4lkRp3qSx5W9PL1dzioO0KbCLbv78osp7k1s1LZNqwVfQbwGprksJmQlfND9PdbQS0AIHPGW2eafXOoO8u8fELori+/KjNDGy61P499QLmRJ1Skre3bUj6n9jZ0+0Vn4yGaeCVjvYakn8wWZv8fwjPAH6kan+iDxDR6ba5DoNQ2/yVAib7Bg98dAgJd8uSwxiFw9BHnSx/TFeW7V9Cewr/A7VeFwpS+yo/lgJLO2cywmDb7+9D8GD+yRL44CF8TQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB7125.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(136003)(366004)(396003)(451199021)(38070700005)(38100700002)(82960400001)(122000001)(921005)(86362001)(36756003)(8936002)(26005)(5660300002)(6506007)(110136005)(54906003)(7416002)(8676002)(41300700001)(53546011)(186003)(2906002)(2616005)(83380400001)(316002)(6512007)(66946007)(76116006)(71200400001)(4326008)(66556008)(478600001)(66476007)(66446008)(64756008)(6486002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?M3hrUW9lM3NSOU43c042a09iYmxpaitLVGpadUZPcVNGaytKb2hWRzlSNnky?=
 =?utf-8?B?WmZiVmRuWk5pS0JPME5CRXdxejdzSjdoYkNmcERrQzhGV2V3bkVyNEdCWXZk?=
 =?utf-8?B?WmxOQVU2TzZ5bW1zTVlpZmhCbFpqVEZGYlJKcW0vSTFqZFNGVllOc09PdGwx?=
 =?utf-8?B?QXN6czhDSURiM2dwQ2plWGNPSEcxNmY1YzNJR0VLRmtaM01iZ2F2amwrd0FM?=
 =?utf-8?B?a1pTVG5Yb3ZEd2pHdEo1THBxNjYzWUZhNktGblV0aTJRd08welltRE1Ia3ZC?=
 =?utf-8?B?eFQzd1crUHIyeDY4WC9DRmRqS1MxbENDZFlTY1ZGRXZiVTB2anNkV29zUFhV?=
 =?utf-8?B?V2JHN2JGUjlMMTh3YjhMQ01LNXJ0VmpGNnBraERYNEdINkJDRzhGYjk0UUlG?=
 =?utf-8?B?Q20zeHRRM0JWaUcwOVE5bjJmWFpMTDZpd0hoTXpCUUt5VmpsQUU0bGxKR1hU?=
 =?utf-8?B?Y3lHTHJCcThEbUJPSDVKMTVDSHR2VExMcTMycmVONnZLVll5KzZsU1dmbjZm?=
 =?utf-8?B?T2FGcmdaWXZJV3BIM0htejZYL0hPbUZHTGhvWlJYcEhOWmQzNXcxNExDT28r?=
 =?utf-8?B?RnQ0R0Ywa2FXaTkyd2UvRm5EejJYUElVcENvV3RwQjNjRWhKT3lnK2Q1dzND?=
 =?utf-8?B?MWZ0N3FyOVlyMXRUUjBEZlcrUlBkaU1yazhJZ0Nlb09LM3UreDlkWk9HU05K?=
 =?utf-8?B?a1l6d2JPVW1DVHk3dTJwR0tndzRpek91ZnpsUkdZOFA4bHBYc2ltMlBLM1py?=
 =?utf-8?B?YXd3WTcyNEtsTDAyQ2NkWElQU0c2RGpFUFM2NWFUbFhlak50VVRHS0xmVkp4?=
 =?utf-8?B?Q295UjZxMDBsV0JNeVBuaWNzM1FhWWdGdVMxL0tjOWJzTzFHbFloNHV1R01F?=
 =?utf-8?B?VnM5bCtjNXRGM1pmS3NzWWlaVWs5WnBHN1lORDF1djBPSHJPWWJmTXlYbm1t?=
 =?utf-8?B?QzlaY0ZjT0hSUUFPbDJVNHhuUVYwYk5lT0tES0FRbEMrbHp3WVdvRWNhckkr?=
 =?utf-8?B?Z3JqOWNTZVI2aWU1cjAybVcyL2tTaUVGakh6ZUNwVXM1bXNxVzhRdU9LMDV5?=
 =?utf-8?B?YlJxSzgvMC84NVpnQ05ud3V4NnRJZ3FlRE5SaVdpMTRONlRuY3pCL1lJbUR0?=
 =?utf-8?B?MSs4dmtvcHpjY0RvdVZvVWxsUHFNQ3JTdTUxN1JjamtodjlTTXFWSERSbVVJ?=
 =?utf-8?B?ZGtBSDUvckFVclNUQXRUdmVBL3U4eXF0anJtRzBVdjlKQjBNM1cvQStHY0pO?=
 =?utf-8?B?YldHZ0gweWJRcWdZeUIvRDFkS3dWNUNMT2IzWWNjbnpiamlXc0tmN0ZLRmRZ?=
 =?utf-8?B?QmNkY0VNRTlNa1hHRlFHMHhPZU04MGhRaFc3YlU2UHhkU2pScGxDcGZtZXox?=
 =?utf-8?B?bHdDWVZLMW92UXMzNVhveDkvQkJzK1hleEx1d1pRb09DdjJmZzFSUXVuK3hU?=
 =?utf-8?B?SjBGWGxlK0U5VzJjMnZkcXBWcG5hUGFqdEk0b3hpc0NyVEJrMzVvOFN5aTBY?=
 =?utf-8?B?d01ZeWdxV1hKanBHL3BaazdFUCt5VktxRk1GZnFMa2NjU0FRZ09lbVNibnJn?=
 =?utf-8?B?WmJDam5zYWpVK0lVcU5Ed2tMSnVjRW5EZkxRTVJnNmpJZ2s0M2xUY2I4NHJa?=
 =?utf-8?B?S3dSRVlaTisrV21kK3lETGl5bFAyTW8yandIRGZ2UTYzOEgvempwR2NCcmM0?=
 =?utf-8?B?OWs0UE9pQ1ZDRTFrdE1zNkYxYVlWcEZ3T0NvTUV0Q3ptai9GU0hRSkxyVzlT?=
 =?utf-8?B?VmwxdFJtWUgxRjlwaUNDd3I5U2Zib0FUU2VzM0ZCcmoyajQzbGdNek0wRGdK?=
 =?utf-8?B?dEZRcUtyY1hINE8ra2FiMlhSRDN1bTJ5Ni9wYlhodDd5M0VFbFVobVVqZ0s3?=
 =?utf-8?B?UkpSQy9XdW1Jd3plbG83TzY2U2JTUDBCUlVTbDR4amFVbktMZmY4Unlyempz?=
 =?utf-8?B?TmFXRTdLREdPbjN3aC9ucUsvSnorRGVrUng5YnRiaUhJN3dreU4rWXpzdktU?=
 =?utf-8?B?ZGhzeE1icnBYdld5bitmYTR5UGZ2V08wczNMUEZuQmQ1cUJpaFB4KzZabXE0?=
 =?utf-8?B?ZXhKUFQyKzUzYnB5cWUxUVFDQno3N2IrV1pRcXhra2lJQ1pVc2VNZEttUWFs?=
 =?utf-8?B?bTlYV05kU3hJanZpZEc3enh2K3plK2FBU2NWeEJMVWs4WFdDOUdwdTIzbFNy?=
 =?utf-8?B?a1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC5351599C5A074F888CA6D876BEC1E2@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB7125.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6851077-e58c-4a46-c387-08db83b771f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2023 15:40:11.7333
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9nGaAfW3ii5u+g53jF7U2Tnhxn6upyZeLGo6AWyIxGjfM2YRMGeARYY/SXGOwXxKDBSxR2E66gWFwWnN0u0vcB48g76EWCkaD6DfS2pQnRA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7595
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

T24gVGh1LCAyMDIzLTA3LTEzIGF0IDE3OjIzICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90
ZToKPiBPbiAxMy4wNy4yMyAxNzoxNSwgVmVybWEsIFZpc2hhbCBMIHdyb3RlOgo+ID4gT24gVGh1
LCAyMDIzLTA3LTEzIGF0IDA5OjIzICswMjAwLCBEYXZpZCBIaWxkZW5icmFuZCB3cm90ZToKPiA+
ID4gT24gMTMuMDcuMjMgMDg6NDUsIFZlcm1hLCBWaXNoYWwgTCB3cm90ZToKPiA+ID4gPiAKPiA+
ID4gPiBJJ20gdGFraW5nIGEgc2hvdCBhdCBpbXBsZW1lbnRpbmcgdGhlIHNwbGl0dGluZyBpbnRl
cm5hbGx5IGluCj4gPiA+ID4gbWVtb3J5X2hvdHBsdWcuYy4gVGhlIGNhbGxlciAoa21lbSkgc2lk
ZSBkb2VzIGJlY29tZSB0cml2aWFsIHdpdGggdGhpcwo+ID4gPiA+IGFwcHJvYWNoLCBidXQgdGhl
cmUncyBhIHNsaWdodCBjb21wbGljYXRpb24gaWYgSSBkb24ndCBoYXZlIHRoZSBtb2R1bGUKPiA+
ID4gPiBwYXJhbSBvdmVycmlkZSAocGF0Y2ggMSBvZiB0aGlzIHNlcmllcykuCj4gPiA+ID4gCj4g
PiA+ID4gVGhlIGttZW0gZGlmZiBub3cgbG9va3MgbGlrZToKPiA+ID4gPiAKPiA+ID4gPiDCoMKg
wqDCoCBkaWZmIC0tZ2l0IGEvZHJpdmVycy9kYXgva21lbS5jIGIvZHJpdmVycy9kYXgva21lbS5j
Cj4gPiA+ID4gwqDCoMKgwqAgaW5kZXggODk4Y2E5NTA1NzU0Li44YmU5MzJmNjNmOTAgMTAwNjQ0
Cj4gPiA+ID4gwqDCoMKgwqAgLS0tIGEvZHJpdmVycy9kYXgva21lbS5jCj4gPiA+ID4gwqDCoMKg
wqAgKysrIGIvZHJpdmVycy9kYXgva21lbS5jCj4gPiA+ID4gwqDCoMKgwqAgQEAgLTEwNSw2ICsx
MDUsOCBAQCBzdGF0aWMgaW50IGRldl9kYXhfa21lbV9wcm9iZShzdHJ1Y3QgZGV2X2RheCAqZGV2
X2RheCkKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZGF0YS0+bWdpZCA9IHJjOwo+
ID4gPiA+IMKgwqDCoMKgwqAgCj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGZvciAo
aSA9IDA7IGkgPCBkZXZfZGF4LT5ucl9yYW5nZTsgaSsrKSB7Cj4gPiA+ID4gwqDCoMKgwqAgK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgbWhwX3QgbWhwX2ZsYWdzID0gTUhQX05JRF9JU19N
R0lEIHwgTUhQX01FTU1BUF9PTl9NRU1PUlkgfAo+ID4gPiA+IMKgwqDCoMKgICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIE1I
UF9TUExJVF9NRU1CTE9DS1M7Cj4gPiA+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoCBzdHJ1Y3QgcmVzb3VyY2UgKnJlczsKPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCByYW5nZSByYW5nZTsKPiA+ID4gPiDCoMKg
wqDCoMKgIAo+ID4gPiA+IMKgwqDCoMKgIEBAIC0xNDEsNyArMTQzLDcgQEAgc3RhdGljIGludCBk
ZXZfZGF4X2ttZW1fcHJvYmUoc3RydWN0IGRldl9kYXggKmRldl9kYXgpCj4gPiA+ID4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICogdGhpcyBhcyBSQU0gYXV0b21h
dGljYWxseS4KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqAgKi8KPiA+ID4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJj
ID0gYWRkX21lbW9yeV9kcml2ZXJfbWFuYWdlZChkYXRhLT5tZ2lkLCByYW5nZS5zdGFydCwKPiA+
ID4gPiDCoMKgwqDCoCAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHJhbmdlX2xlbigmcmFuZ2UpLCBrbWVtX25hbWUsIE1IUF9OSURf
SVNfTUdJRCk7Cj4gPiA+ID4gwqDCoMKgwqAgK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYW5nZV9sZW4oJnJhbmdlKSwga21lbV9u
YW1lLCBtaHBfZmxhZ3MpOwo+ID4gPiA+IMKgwqDCoMKgwqAgCj4gPiA+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpZiAocmMpIHsKPiA+ID4gPiDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBkZXZfd2Fybihk
ZXYsICJtYXBwaW5nJWQ6ICUjbGx4LSUjbGx4IG1lbW9yeSBhZGQgZmFpbGVkXG4iLAo+ID4gPiA+
IMKgwqDCoMKgIAo+ID4gPiA+IAo+ID4gPiAKPiA+ID4gV2h5IGRvIHdlIG5lZWQgdGhlIE1IUF9T
UExJVF9NRU1CTE9DS1M/Cj4gPiAKPiA+IEkgdGhvdWdodCB3ZSBzdGlsbCB3YW50ZWQgZWl0aGVy
IGFuIG9wdC1pbiBvciBvcHQtb3V0IGZvciB0aGUga21lbQo+ID4gZHJpdmVyIHRvIGJlIGFibGUg
dG8gZG8gbWVtbWFwX29uX21lbW9yeSwgaW4gY2FzZSB0aGVyZSB3ZXJlCj4gPiBwZXJmb3JtYW5j
ZSBpbXBsaWNhdGlvbnMgb3IgdGhlIGxhY2sgb2YgMUdpQiBQVURzLiBJIGhhdmVuJ3QKPiA+IGlt
cGxlbWVudGVkIHRoYXQgeWV0LCBidXQgSSB3YXMgdGhpbmtpbmcgYWxvbmcgdGhlIGxpbmVzIG9m
IGEgc3lzZnMKPiA+IGtub2IgZXhwb3NlZCBieSBrbWVtLCB0aGF0IGNvbnRyb2xzIHNldHRpbmcg
b2YgdGhpcyBuZXcKPiA+IE1IUF9TUExJVF9NRU1CTE9DS1MgZmxhZy4KPiAKPiBXaHkgaXMgTUhQ
X01FTU1BUF9PTl9NRU1PUlkgbm90IHN1ZmZpY2llbnQgZm9yIHRoYXQ/Cj4gCj4gCkFoIEkgc2Vl
IHdoYXQgeW91IG1lYW4gbm93IC0ga25vYiBqdXN0IGNvbnRyb2xzIE1IUF9NRU1NQVBfT05fTUVN
T1JZLAphbmQgbWVtb3J5X2hvdHBsdWcgaXMgZnJlZSB0byBzcGxpdCB0byBtZW1ibG9ja3MgaWYg
aXQgbmVlZHMgdG8gdG8Kc2F0aXNmeSB0aGF0LgoKVGhhdCBzb3VuZHMgcmVhc29uYWJsZS4gTGV0
IG1lIGdpdmUgdGhpcyBhIHRyeSBhbmQgc2VlIGlmIEkgcnVuIGludG8KYW55dGhpbmcgZWxzZS4g
VGhhbmtzIERhdmlkIQo=
