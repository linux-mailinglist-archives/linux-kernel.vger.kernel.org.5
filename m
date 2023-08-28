Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7C678A88E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 11:11:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229999AbjH1JL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 05:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjH1JLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 05:11:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FAA319F
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693213832; x=1724749832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=J2OSijYIYTjzn3/E0G3yM7TJmxmcqbi+I3CDn+VuPXE=;
  b=CzFRpR6tIFMMDb74YVyWwhg3KeulX+wF9fNorTiKyuvQDszg0biLTfZ2
   gDuquhqYk4n/kTa+Cf33rZo9fk/76B18AzoRaRsnlc1+ymVG23JJ2ia1v
   JljIaLB7jiFzUKkG+Ay4k6ved6AeSshTIyEXYtzuPvJV3+a40pR9WrjD3
   D09mfvVQr10lsnAPHaQuGWFjlAitf5pbf316x/JUH/r/nOxzhsIot/2sS
   SKaPvhDMZ72WF5LNsnmJFF20cnd81HEIGTGsdgSTvxc+384EalttH+5ga
   TgS+EIHfsvFlpcW9lImhZ4Nplyx6KlPWgMrLQJ3APHoW50VGu9TnlIyVl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="360051762"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="360051762"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 02:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="803634778"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="803634778"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 28 Aug 2023 02:10:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 02:10:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 28 Aug 2023 02:10:29 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 28 Aug 2023 02:10:29 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.46) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 28 Aug 2023 02:10:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F8r3JpiUPw+99lpAXSxy0W04HQ91T9+c4nx1Q8sh/MpcpraSvwa2zvfxPWHAtkWgXDFfIgIgXoXZBGlje4/8t2Eihuo3VnFZcJRJt6R0ZdtnDuw/EVc++TZO/D/Acnjsc0oieLdNirormOVziDTjkcnHoqWZQ41yo+FbKV0Kpz7H40U+w9Jzo44DiRoAVuvyM0ziBFRK5Yf35Q+GtIiBtiblp/VnVVPHbA+6w5zrVcbk9AUbT3nNHEZ7dLcwMTrywTbVzEHYKpb1FBOzL3MCtzGZXoMPtxf2+8SVVLlVfDOVrMIz6GLOq/okLRLNhXctCHAnWLkVDWb9n8CeIW1y+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J2OSijYIYTjzn3/E0G3yM7TJmxmcqbi+I3CDn+VuPXE=;
 b=OChsWKd0B68yAHydBW0hYfoJAExGTNNIOBpID6iIibZyk1veSezcnySa/7ic3xcjyump6+dby1sN2R7A2qcInC7HAeMDNKczMeNO/ri65y5RbZ7XCjEvWE2ldvfwl9HEcka9wyMkqh4v5Qnoz99QQLULjUcPnanzI0VbcWSK6HAz7aRdXDiPZzaYk81hRmk2XOOvoI0edB/ptnO3BZN0ndfWIpknV8kyvJkiGWrOBsDOnrAm0lteNS3WSmERaui2Nd9WWg45UObjw/KRoHct0qHhPF4IzGuahfza2zcSfdrfMPigMiK+f/JYcIvcpH+Jq03EPrUuuvrpntHJexSA8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by PH0PR11MB5580.namprd11.prod.outlook.com (2603:10b6:510:e5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Mon, 28 Aug
 2023 09:10:25 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6699.034; Mon, 28 Aug 2023
 09:10:25 +0000
From:   "Zhang, Tina" <tina.zhang@intel.com>
To:     Vasant Hegde <vasant.hegde@amd.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>
CC:     "iommu@lists.linux.dev" <iommu@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Thread-Topic: [PATCH v2 4/5] iommu: Support mm PASID 1:n with sva domains
Thread-Index: AQHZ2MK1gTpf1q6C50W/7sJTiiM5MK//YvIAgAAHa4A=
Date:   Mon, 28 Aug 2023 09:10:24 +0000
Message-ID: <MW5PR11MB58811372039BED21EF588C1B89E0A@MW5PR11MB5881.namprd11.prod.outlook.com>
References: <20230827084401.819852-1-tina.zhang@intel.com>
 <20230827084401.819852-5-tina.zhang@intel.com>
 <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
In-Reply-To: <aa834f12-ce45-fe15-430b-2a9c3446a5ba@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW5PR11MB5881:EE_|PH0PR11MB5580:EE_
x-ms-office365-filtering-correlation-id: aef93010-f55c-4a30-499d-08dba7a69d6b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TwhOQ2mp9JVmDMiwA81roQKHldpcZGfnMMnmz3ebz2SJssYhlDvHdC6qu9MqSdiir87VCN2X63eghXBQ/gk5tCMfvff7Qp5Z/O6Z/ePLDy9zu2vPVwif6IpY7/3D16JWcO1BnZzVAmUSGriOFP+tpSHzMj9Ts5/sAQ5wSNnWP3+XPhpn2IevPaSlPMb3NL4wNGpyBR2sYHQ2J6yLJicc7bva7huIe3OKo17VosIELv2w9p/j0M3f7bpfhWJdICFWWitYdXagZIsb7LhDlg3qs6Olthyzf+l7bLEy/9/d1F7MaAVcg9uUCs+tn357dPapdGw7oy3uvIq5DLzqhreTEDnPVrLkk75UtkV1XMo02jpuE127rGC97XrdwETjcVludJO3pOeDBXfe8UlwvCYufKwf2kN/ahr56iqbbeEk/Y6TZVMwsdUYyCnGhgglgIfdZvlVU9TdYWrCQfpTCPphknclQhawx3poMuNbcGJPDGOZE4WLFaS4ke7zoGQW5m2DWcg6i8PJMwBrLHjjsBw+iRgiCEeMwob7tXk6bbUpCSVZ9A5dkLYPBPsD0eCrv352boca5smrDgyAcE71+C2mOM2N+ghmVK9nF8JQJHS0R6ihoAskkR2Plr0LfgHnD69G
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(396003)(136003)(346002)(1800799009)(451199024)(186009)(26005)(82960400001)(86362001)(55016003)(71200400001)(478600001)(33656002)(83380400001)(8936002)(8676002)(110136005)(53546011)(7696005)(6506007)(66476007)(66556008)(76116006)(66446008)(64756008)(66946007)(316002)(9686003)(41300700001)(54906003)(52536014)(4326008)(5660300002)(2906002)(38070700005)(122000001)(38100700002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eFVoSTBrVFBVQUFzWU9SSkZXVzJ5UnFRd0VKbDc5di9BV1k0bktzNThwRmRK?=
 =?utf-8?B?bGNEM0NSOFRuMG9wYVVvK2tSTWFoaG5iMThvSXJkNzZnZDFZclZKWFVydERL?=
 =?utf-8?B?eURra1ltY3FqOXNzRS8wOTN2Zkl5K0VjL2oxcE1yRElWQ01reWV0Yys0ZmRM?=
 =?utf-8?B?K2hpYlVNR2FQT2J0S0VoaDlrYlErVUY0aDBhdVFjSU5YbEtRUVphKzNZNnNj?=
 =?utf-8?B?UW1HWVl3ZG14NFdFbXgyQ25GZEZYcnlBQlRaN0xTbzVEeDcyU0NVdThhUUgz?=
 =?utf-8?B?UWt3RlNqK2d5T3JEWGdJQ0JvVENxU1NnN3RHYzFxRFFmV29hV3UvNGpnWEUy?=
 =?utf-8?B?WlJyOHZzUEU2dnpsTjVhUnFPNzdoVmhXR2R0VmVFRUlBM1ZGUHlLcUtRYUFs?=
 =?utf-8?B?bWhxdFBqWGw3TVBud1BBRGczbU04WFgydSt6SERpVWEzQXJ1Q1BEbUt6cG9k?=
 =?utf-8?B?NkRQMkNmSmVMcHdJZVVIbE1YaHd4U0FVaFU1bnFXZm16dnVkbUpSVXhvOUxC?=
 =?utf-8?B?SHBrT3d4NG1mam1EVnkydkhZQUFVejlvbGN1YXZlcWJLdEJHbXNQRVI1U0dD?=
 =?utf-8?B?YU0xeWI4TzNBZVZJbU9HR2RUaUhnL0R4Si9VY0V6eEYxYWVQVzZiVmJiVmtG?=
 =?utf-8?B?MUUzYTQwUHJGSEN5QlBGRm5UUlB0cXoxMEdmalBlZkU2cmhIYUVMTWg0TXpU?=
 =?utf-8?B?dHlSVklZRlp6NlNwa3J0YXJ5MHV4WnRqcXZVWVU5M3V6T0hUSDdzWDVWVjVG?=
 =?utf-8?B?WDJWUXNMWUhtYzhIOTBlODlGYXVxcVhqSzI2ZEVJbGtjK2NpMEtDV2VRRXFB?=
 =?utf-8?B?YUVqYTRhTjlHZUd4bUlsY3ZwY2RvVE1YZFdGMXd4bGtQeWRmYlJlNGUyTVNt?=
 =?utf-8?B?Q0I2cnRTTUxaaVRFOWVSUXpaVmU1aHRUK3VrcmxGVHBxc29scERoTmZqSFNo?=
 =?utf-8?B?UzZtelF6NDVXRlJ0c1NBTmxUWnZjWTI1SDFZZUFuSXo2Vms3Qmk5akNmWnda?=
 =?utf-8?B?Y2FCZWh1ZHlydHA2TTJDak9WanNSY1BPZEpDT29PVTl1ZFRzdmlwT2s5MlBx?=
 =?utf-8?B?aWswOTRXNUhUcDBoM3ppTWM4RnVTb29BUHRscnJ6ck9YUmRYR2pUN3NLNE9V?=
 =?utf-8?B?UlFkQVYyT0RlQWlFM1VDbmFuUkR0dE05UC9yOVdackRjallvODVvemtibVVo?=
 =?utf-8?B?MzBWb0hNUUVGcDB2bU1kbVcrUTFHS0RKZkk1azZWc3BKcGVjOFpKcCt2ZG9x?=
 =?utf-8?B?Z0lLL2czTEZpYm5iWkRMZ0tkaHg3WFZXSnoyMG02RGE3Z3JJUjVsZ3U5bjkx?=
 =?utf-8?B?a080a0Fialg1dTFFSmx4aFdHZ2RRVi9jdFhSbXpqM0VLRG1Dd0NjOUxJNExz?=
 =?utf-8?B?L05SUFBPcVF0WWNEcUhBS2hza2MvZXdXSU1DZEhaQTEwRU16enBuWjErdGJs?=
 =?utf-8?B?MmU1aElLeWdRRnVNQ0ZhZVFYMTlibzR3RTc5V2E4citqUjU3UEU5NDhuMm1U?=
 =?utf-8?B?eVBCeDRSMncyMmZSaXA5NDhhWk5Qd2lsM2RwNmVTeXhTRnJzQnNxZWdkSURy?=
 =?utf-8?B?a2ZIek5kNWdNMW5NdmRTNDNBeTRDQWM2T3N2TmRXdzFWakU5eGhVZmppYXdy?=
 =?utf-8?B?MjFTcTRGUUdxNlBmWnBMeVJWanNiU1lnUDUrWFFUaFk5OWc2TGdtcmtqMVdX?=
 =?utf-8?B?a3NOVTJCOVo4VW5FU0s1Y3ZDdHdOZmNPSjFSWmlUWmJNcVAxWktMMnN2SlUx?=
 =?utf-8?B?aWp1UUF1REwvNHkxZ1o1VTlzbS9Kend3ZzRhTFBPZjZHa2J6azNkdndOdVpt?=
 =?utf-8?B?M2t1ZU9mZ1AvWnJJYXI5RmVWKy9SYk9odFlYZkd6YWRKdmNlSjIyNUM5ME1U?=
 =?utf-8?B?OVBwV0M5enFUVktRZmp1QzM4UEswRDdjbnVEUE5IWnQ4cDJ4TWR4c3FzdVU2?=
 =?utf-8?B?UzBwUmNxZkN0WDhqcy8rSzgrb211dlQ4TU8xOXQ1bDFlY1dUcWpoc2N2RUNs?=
 =?utf-8?B?LzlQWk11UVVLSUd2TnllNURVYnJZS1ZDTW5IRW43N0J3Rzlia0JvY2hsT3NQ?=
 =?utf-8?B?Qml5WE95VDY1b2NuaXVXd2FIQTlQUjMwYi8rd1lRc0IvalppQkVCbDJmNFJX?=
 =?utf-8?Q?wLxzW++MuuitlX8CIeh5GD2ZX?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aef93010-f55c-4a30-499d-08dba7a69d6b
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2023 09:10:25.0167
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: thvUmZWpXwsfn/XhKW/cN+9fuzGOFtgSQPYJyxJuWO+bZb+CubAmeVB/h9JEcP4DKFHyxcNHhHiHt0qXC+xcZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5580
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVmFzYW50LA0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFZhc2Fu
dCBIZWdkZSA8dmFzYW50LmhlZ2RlQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwgQXVndXN0IDI4
LCAyMDIzIDQ6MzMgUE0NCj4gVG86IFpoYW5nLCBUaW5hIDx0aW5hLnpoYW5nQGludGVsLmNvbT47
IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsNCj4gVGlhbiwgS2V2aW4gPGtldmluLnRp
YW5AaW50ZWwuY29tPjsgTHUgQmFvbHUgPGJhb2x1Lmx1QGxpbnV4LmludGVsLmNvbT47DQo+IE1p
Y2hhZWwgU2hhdml0IDxtc2hhdml0QGdvb2dsZS5jb20+DQo+IENjOiBpb21tdUBsaXN0cy5saW51
eC5kZXY7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRD
SCB2MiA0LzVdIGlvbW11OiBTdXBwb3J0IG1tIFBBU0lEIDE6biB3aXRoIHN2YSBkb21haW5zDQo+
IA0KPiBIaSBUaW5hLA0KPiANCj4gT24gOC8yNy8yMDIzIDI6MTQgUE0sIFRpbmEgWmhhbmcgd3Jv
dGU6DQo+ID4gRWFjaCBtbSBib3VuZCB0byBkZXZpY2VzIGdldHMgYSBQQVNJRCBhbmQgY29ycmVz
cG9uZGluZyBzdmEgZG9tYWlucw0KPiA+IGFsbG9jYXRlZCBpbiBpb21tdV9zdmFfYmluZF9kZXZp
Y2UoKSwgd2hpY2ggYXJlIHJlZmVyZW5jZWQgYnkNCj4gaW9tbXVfbW0NCj4gPiBmaWVsZCBvZiB0
aGUgbW0uIFRoZSBQQVNJRCBpcyByZWxlYXNlZCBpbiBfX21tZHJvcCgpLCB3aGlsZSBhIHN2YQ0K
PiA+IGRvbWFpbiBpcyByZWxlYXNlZCB3aGVuIG5vIG9uZSBpcyB1c2luZyBpdCAodGhlIHJlZmVy
ZW5jZSBjb3VudCBpcw0KPiA+IGRlY3JlbWVudGVkIGluIGlvbW11X3N2YV91bmJpbmRfZGV2aWNl
KCkpLg0KPiA+DQo+ID4gU2luY2UgdGhlIHJlcXVpcmVkIGluZm8gb2YgUEFTSUQgYW5kIHN2YSBk
b21haW5zIGlzIGtlcHQgaW4gc3RydWN0DQo+ID4gaW9tbXVfbW1fZGF0YSBvZiBhIG1tLCB1c2Ug
bW0tPmlvbW11X21tIGZpZWxkIGluc3RlYWQgb2YgdGhlIG9sZA0KPiBwYXNpZA0KPiA+IGZpZWxk
IGluIG1tIHN0cnVjdC4gVGhlIHN2YSBkb21haW4gbGlzdCBpcyBwcm90ZWN0ZWQgYnkgaW9tbXVf
c3ZhX2xvY2suDQo+ID4NCj4gPiBCZXNpZGVzLCB0aGlzIHBhdGNoIHJlbW92ZXMgbW1fcGFzaWRf
aW5pdCgpLCBhcyB3aXRoIHRoZSBpbnRyb2R1Y2VkDQo+ID4gaW9tbXVfbW0gc3RydWN0dXJlLCBp
bml0aWFsaXppbmcgbW0gcGFzaWQgaW4gbW1faW5pdCgpIGlzIHVubmVjZXNzYXJ5Lg0KPiA+DQo+
ID4gU2lnbmVkLW9mZi1ieTogVGluYSBaaGFuZyA8dGluYS56aGFuZ0BpbnRlbC5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvaW9tbXUvaW9tbXUtc3ZhLmMgfCAzOCArKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tLQ0KPiA+ICBpbmNsdWRlL2xpbnV4L2lvbW11LmggICAgIHwg
MTAgKysrLS0tLS0tLQ0KPiA+ICBrZXJuZWwvZm9yay5jICAgICAgICAgICAgIHwgIDEgLQ0KPiA+
ICAzIGZpbGVzIGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKyksIDIxIGRlbGV0aW9ucygtKQ0KPiA+
DQo+IA0KPiANCj4gLi4uLy4uLg0KPiANCj4gPg0KPiA+ICAJLyogQWxsb2NhdGUgYSBuZXcgZG9t
YWluIGFuZCBzZXQgaXQgb24gZGV2aWNlIHBhc2lkLiAqLyBAQCAtMTA1LDYNCj4gPiArMTEzLDgg
QEAgc3RydWN0IGlvbW11X3N2YSAqaW9tbXVfc3ZhX2JpbmRfZGV2aWNlKHN0cnVjdCBkZXZpY2Ug
KmRldiwNCj4gc3RydWN0IG1tX3N0cnVjdCAqbW0NCj4gPiAgCWlmIChyZXQpDQo+ID4gIAkJZ290
byBvdXRfZnJlZV9kb21haW47DQo+ID4gIAlkb21haW4tPnVzZXJzID0gMTsNCj4gPiArCWxpc3Rf
YWRkKCZkb21haW4tPm5leHQsICZtbS0+aW9tbXVfbW0tPnN2YV9kb21haW5zKTsNCj4gPiArDQo+
ID4gIG91dDoNCj4gPiAgCW11dGV4X3VubG9jaygmaW9tbXVfc3ZhX2xvY2spOw0KPiA+ICAJaGFu
ZGxlLT5kZXYgPSBkZXY7DQo+ID4gQEAgLTEzNyw4ICsxNDcsOSBAQCB2b2lkIGlvbW11X3N2YV91
bmJpbmRfZGV2aWNlKHN0cnVjdCBpb21tdV9zdmENCj4gKmhhbmRsZSkNCj4gPiAgCXN0cnVjdCBk
ZXZpY2UgKmRldiA9IGhhbmRsZS0+ZGV2Ow0KPiA+DQo+ID4gIAltdXRleF9sb2NrKCZpb21tdV9z
dmFfbG9jayk7DQo+ID4gKwlpb21tdV9kZXRhY2hfZGV2aWNlX3Bhc2lkKGRvbWFpbiwgZGV2LCBw
YXNpZCk7DQo+ID4gIAlpZiAoLS1kb21haW4tPnVzZXJzID09IDApIHsNCj4gPiAtCQlpb21tdV9k
ZXRhY2hfZGV2aWNlX3Bhc2lkKGRvbWFpbiwgZGV2LCBwYXNpZCk7DQo+ID4gKwkJbGlzdF9kZWwo
JmRvbWFpbi0+bmV4dCk7DQo+ID4gIAkJaW9tbXVfZG9tYWluX2ZyZWUoZG9tYWluKTsNCj4gPiAg
CX0NCj4gPiAgCW11dGV4X3VubG9jaygmaW9tbXVfc3ZhX2xvY2spOw0KPiA+IEBAIC0yMTgsNCAr
MjI5LDUgQEAgdm9pZCBtbV9wYXNpZF9kcm9wKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tKQ0KPiA+ICAJ
CXJldHVybjsNCj4gPg0KPiA+ICAJaWRhX2ZyZWUoJmlvbW11X2dsb2JhbF9wYXNpZF9pZGEsIG1t
X2dldF9wYXNpZChtbSkpOw0KPiA+ICsJa2ZyZWUobW0tPmlvbW11X21tKTsNCj4gDQo+IA0KPiBJ
IGFtIG5vdCBzdXJlIHdoZXRoZXIgSSB1bmRlcnN0b29kIHRoZSBmbG93IGNvbXBsZXRlbHkuIEp1
c3Qgd29uZGVyaW5nIHdoeQ0KPiB5b3UgYXJlIG5vdCBmcmVlaW5nIHBhc2lkIGluIGlvbW11X3N2
YV91bmJpbmRfZGV2aWNlKCkuDQo+IEkgbWVhbiBvbmNlIGlvbW11X21tLT5zdmFfZG9tYWlucyBi
ZWNvbWVzIGZyZWUgc2hvdWxkbid0IHdlIGZyZWUgdGhlDQo+IGlvbW11X21tLT5wYXNpZD8NCk5v
LCB0aGUgc3ZhIGRvbWFpbiBhbmQgdGhlIFBBU0lEIGFyZSBzZXBhcmF0ZSBvYmplY3RzIHdpdGgg
dGhlaXIgb3duIGxpZmVjeWNsZXMuDQpUaGUgaW9tbXVfbW0tPnBhc2lkIGlzIHJlbGVhc2VkIHdo
ZW4gdGhlIG1tIGlzIGJlaW5nIHJlbGVhc2VkLCBtZWFud2hpbGUgdGhlIHN2YV9kb21haW4gaXMg
cmVsZWFzZWQgd2hlbiBubyBvbmUgaXMgdXNpbmcgaXQuDQoNClJlZ2FyZHMsDQotVGluYQ0KPiAN
Cj4gQWxzbyBpbiB0aGlzIGZ1bmN0aW9uIChtbV9wYXNpZF9kcm9wKCkpLCBzaG91bGQgd2UgY2hl
Y2svZnJlZSBzdmEgZG9tYWlucz8NCj4gDQo+IC1WYXNhbnQNCg0K
