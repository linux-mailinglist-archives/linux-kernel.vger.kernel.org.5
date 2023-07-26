Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7866276406C
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbjGZUWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 16:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjGZUWr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 16:22:47 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079619B5;
        Wed, 26 Jul 2023 13:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690402965; x=1721938965;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HwpqoLJjDFbhyy1ApJY3cDqfxSdjUw7B0Rvo0MpADq8=;
  b=dfQJhKwf7pzlnGm6k/2z2cLR6ZNCo5ENXIGDiiycxsMxrnQxt2MCRsZR
   CVv/kIN+e7iLTjzxEJ9hymSni6R2YD9409i1wpwrkPdUJfeyk/R04MCaQ
   eUhj13EvIeXwb+qW+FpVZIY0PA3c0nfVR96dZaMGjOcU09sGuBCVsebWE
   jsIE9IFogMEufH5LusYV8Oj+d5E3lDgNa4VCz6ewNLksC0UfpdsTU0bu5
   q1zi9ZhG0R6F+fQTTaSMyx9N0g/NxAiJq45kkGxOzAIwbEtqTJ3pMzs+j
   jri0mVjxoLFfrL3CQOMn2zXyby8UtUEI9hBljXjvi6NYvNi3hsVAQPleJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434390495"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="434390495"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 13:22:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="973257465"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="973257465"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 26 Jul 2023 13:22:33 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 13:22:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 13:22:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 13:22:32 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.109)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 13:22:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hTq8CykQ2JHSNApzHVvyXbKyDGEQ/MJezHwxEWNK4fBblTPoAx4LE4YTY/N8Q8eZ0HeLKEtOeHhQoPhZpKrG/BuX/5HvKP+ZnoUXhaqAcqjSz435+ANAKvUUNKKjfcIOPkpyGd0V7wG2wy9S3j/XC/Qn+eMytsz630wj+N01iZrW5fz3B+BAG+pg9VxedHFFYuxg9fJznn4dUhUYrN1qC7k0GSbAAbiZfY/7KZaf5OhdlKoW3HN9tCMGubV+qo/sUnhrdu87usGorl8lcz4zEmqXnn20gctjAL8JX0QQ+B/MijzLvqJgBPzQumQzTeVCYis13BPkkqPcBr/gKWXmMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HwpqoLJjDFbhyy1ApJY3cDqfxSdjUw7B0Rvo0MpADq8=;
 b=HbXyAAEWhMkYoFli0E6r6puiwmzJj+znzu848LXTLagP7dx7k7DjI79gj6r68/DfTfEIoXI1omU3qMmUKetRo55Tx0/1tPY4k++3HAC/cOc3aGwSr+SvEoWIGCeohRwicmT02ISL6VywxRI7O1daE/3G6UhB5teO2W5xkpK0l3weW0d/PZQiyEi3h5y4jS2ZtX2DXEeEd8gf2M5kAHSHbtHOmWd5TBWNd6lBEVIs1aJVITMSrZECA97lBRtMdfv03Opzv8fgFOghxpzRZ+3Hhk5ErGc9b+pixI2hJEDDdHgLR1uCYfxKYRwaA7Q4hLl628P/eJ6X+kah0tDA4WNSnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB5823.namprd11.prod.outlook.com (2603:10b6:303:186::12)
 by PH0PR11MB4856.namprd11.prod.outlook.com (2603:10b6:510:32::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 20:22:30 +0000
Received: from MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::95fe:e2ee:d733:6399]) by MW4PR11MB5823.namprd11.prod.outlook.com
 ([fe80::95fe:e2ee:d733:6399%5]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 20:22:30 +0000
From:   "Winiarska, Iwona" <iwona.winiarska@intel.com>
To:     "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Solanki, Naresh" <naresh.solanki@9elements.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>
CC:     "Rudolph, Patrick" <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v4 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids support
Thread-Topic: [PATCH v4 3/3] hwmon: (peci/dimmtemp) Add Sapphire Rapids
 support
Thread-Index: AQHZvuT26e3IclUZcEC53H7vEgQrAq/MgACA
Date:   Wed, 26 Jul 2023 20:22:29 +0000
Message-ID: <b7e7b713045117db782341d74f69094e167b95c1.camel@intel.com>
References: <20230725104354.33920-1-Naresh.Solanki@9elements.com>
         <20230725104354.33920-3-Naresh.Solanki@9elements.com>
In-Reply-To: <20230725104354.33920-3-Naresh.Solanki@9elements.com>
Accept-Language: en-US, pl-PL
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.46.4 (3.46.4-1.fc37) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB5823:EE_|PH0PR11MB4856:EE_
x-ms-office365-filtering-correlation-id: 161bf031-d084-4986-ea76-08db8e16095c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZZNYpWcbtlFNAfgDSl7Bcaznywe7Vmy5pi8W6gy0LSCgNZnuRPaEjqcRbdJ59PlsysHyWK7Z2hjfjAcNQm0wjr3sR639gA9t8fidFH3ToZIRciW5+UKbci8SaD/9yS8YW8FxMzfpWjo9tero5hBJmGMLAp339IKodVBXhufZguCAFoQxrtK7rYRp2hi+dSUcNJVmGRdZ5B41fV2mFZqTKjMqnPBCjOC5fCI9wueu7mAPuVAiqkpkXga9iEoZtdQeKJfVJT3H7Z8V3OH4Fsv9VPkNL+GBLt+OYzf5wFJ3afh0MP1DoDGl6gsoqbVm+o9iYgjd6vcqIld6C73lUk/nX+rHLZUsxZIYgwZ5UzPeNHQS2W9ADjKaRaIGuDbAUdVPFRVTFiksgVRPXYVZYbVyKrxn/b9V5tzGw/0zxBG12lWSiW39P4QC/s49C2b2cQFUsYCm46mR3LCZtAAE/Z3pKQ63figXJkmNPNZUSth1Qh68c8Ju0PfmvwWS2RaFtsMR0IRnadrwap3aP8uxMvUho8JLHvIHG7n19OTKgvtTZfELCTQ7BSQg9YLBkDB0wjdxY7vMfUcP8NfC7WNyrOT3hUaaTv/TrmpGBdMSaDN3UOun8cgP4x4q2onykpR6oLYa
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR11MB5823.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(39860400002)(346002)(376002)(366004)(396003)(136003)(451199021)(478600001)(6486002)(6512007)(110136005)(66476007)(2616005)(71200400001)(26005)(186003)(6506007)(2906002)(66446008)(66556008)(4326008)(66946007)(91956017)(316002)(76116006)(5660300002)(8936002)(8676002)(41300700001)(82960400001)(64756008)(122000001)(38100700002)(36756003)(38070700005)(86362001)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDJZcU9KVFlvU3dYajhPVHNneGFKdFJVNTJZa1U2azgwVmRaRzJEdmllVE5M?=
 =?utf-8?B?U29nb2t2NmJ0eEJZK21rbTBDSUtPcWkrc0VvVndlSmRjb1lFN0hQYWxSTWV1?=
 =?utf-8?B?S3lGRE1qWHRpaDIzR1VhYm5pUitpbnN4SmNraXVpWkEwRUplREsxVEZub3N6?=
 =?utf-8?B?eW15SEZrTDNzZWJVa01Xdm5yZGg5bDhmZk9uR0FRUTMwSzVXQ1JybXQ5dHll?=
 =?utf-8?B?bHU4Mk1yc2xKd3lqSW5ZMG1qNXZtYUtFZjRlMlJldHVxOHROK25DcDRkTmRN?=
 =?utf-8?B?RXMxK0JFMHN5VzFZOERCSFBkNjRQNjFHb1A3amRYZ3dhQktCbUlHQlF6NFZK?=
 =?utf-8?B?SFZNbm1hWjJWVUszTExFUzJxaTJSMFcwRG1UYW42dmUxL1JuTTlHZnlEVnE5?=
 =?utf-8?B?YUVuZjJYSktDdTlZT2VGUmFmLytoRXRHTmVld0hkQ3VMOGtmM2VXOWJWVHpX?=
 =?utf-8?B?OFYxVlRQcThjZTZTTmM2R1ZIQUJvdU13NGludzVURk42UXMvNjZHTGtocGF0?=
 =?utf-8?B?azFNUjhXckdnNFBCWHpxT3c1bGJ2NmQyelJBdTZpVjJJWHZnMTdaRHVnTTdi?=
 =?utf-8?B?bk9jaFFZcGV5WjljOENNQ3VwSlpZamlCS3kzTzUrRnNYaGtEU0d3YXJPK2x6?=
 =?utf-8?B?cDhWN2M3dEw3amIxeVpoM2lkVlpMSnZqSkhvVDk5dmNGMlFzTG5HM2wrSE52?=
 =?utf-8?B?WXBmQlFKQWRkZ0lHVkg0VGd2eWdHd29zc2VlUmZ6OWZZeDhBN2FDTkp6OUti?=
 =?utf-8?B?NUYwdkp2S3JCM04wR2dha0haL1RqR1hYVFZwSW9Ub1VEMWR3N244ZUU2WGlV?=
 =?utf-8?B?Qkp5QTQ0SElBQXQ1L2NsM0swTGtBZXh5Zm1VWG90MWE1b0NOTXV4SFZrcHpn?=
 =?utf-8?B?c2hyME1Oc0psYjQveDYyVk1lZEw5alQ2cnJuQzhYUFkrblp1dzNHN1VPelpo?=
 =?utf-8?B?QTYyeDJjczd4QlNwZ1h1R3BSeEZEektYQ3dtdlJ2SG40NWplUWVQTXVpR09h?=
 =?utf-8?B?Vk1sWXgwOVhZbThzT1hpWENvSjZWcmtjZXhFcFkvNkZEZ3E0S09OQ2RSNEhG?=
 =?utf-8?B?ak1nVVJWOVR6bE4wMHVieUNWbmkwaTBQcVA5STVkK014WHQ4WXhLQkpGZlJx?=
 =?utf-8?B?THBxME9MaDdpeDhLVGh2cElweUZiKys0T3hNQ1NTbDd6RmdsbnhxeUpOaFEr?=
 =?utf-8?B?UFluZGlmWENEcFNuQmlHMWd5dWZrWmo2WU9zbStKR2F4c1B5akFWckxQQ1VE?=
 =?utf-8?B?UnVlZS9mZHFPM0w4VnVuNHNoWW8rUGdVNFpIVmMySk1aOEt4bzhUK2w5d3BT?=
 =?utf-8?B?ZjBXbW9hd2pCODFZSUlKQ3FYbE9kQ0NlVU9nS3ZMQlJQdXFqdm9jNUhjZkdS?=
 =?utf-8?B?V0dnMnl0bHhFRXFGMFI3V3gyZUVaU1M4RytFWDVXWTVpcDVYaDVBN3M3d3l6?=
 =?utf-8?B?bUtQSzlYMWVsSXdnbTlPVEdlc1FNeTFYRHZDWjdyZHNPSHZDR1VjcytETExV?=
 =?utf-8?B?aGU1OUFTZHROYjdYTWQ0OEdvKzVHN3Q4dDFuVDdlUW1ETWJIZnhxODRKamFx?=
 =?utf-8?B?RHNjYk1OWmhNUUE2L0tqOFV5d0ZDV0dFaVRjNE5yYlBxdDlQc3RBd29QVE1B?=
 =?utf-8?B?KzJzQnJ1NWF0VVVUcUlLQ0d3SWxLRlJYcUlVeUduV3ZteENrTkFNNUJDVjk4?=
 =?utf-8?B?Y3VGckFUK0p1Yi9XaENjV3g2YTYwUkJMS2kzd1FpV0E3aVp3RTI2NTBlcWh4?=
 =?utf-8?B?QUdiejdiNVloY2F2UFJqc2dXUGRRbjVPQ1VFU0FBSTBmR1FTS05DQ05ZdjVz?=
 =?utf-8?B?S28xYXJZNVdDMGJqNkR6c3dFUGZneGNTYVpnNEtOd3doRjFBUEV2ak4zbkNB?=
 =?utf-8?B?elR5dzlETlNxbFovaE1SeDl3ZXhoMUdVdi9oTVFYckZHQ0tTb0JEcG1SRENX?=
 =?utf-8?B?Y2V5TS93Z1haQkl1YzR4UHVCbXNPaW9zRWhoR0RvVHJ5N01NdWRwMjFWN2tW?=
 =?utf-8?B?dFNVRDdQV0NIVEo1L0pNTndSK3NrL0NpQ0xhMThJdmZVUXNnUVJoVnoyZ0k4?=
 =?utf-8?B?NHhaQXZ0RmdmUDdlYVBBdklPT0dBdW5Jc3NDc0hqWkRxUFV4V3A5S21KWVVT?=
 =?utf-8?B?bWV0Tk9nd1dyb1ZNYmdUUHA1ZEFFZzladHpNQllvREdWU0paU1JJdGl4K29p?=
 =?utf-8?B?dWc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A75A00E4E5C0564EAC1932638CCCEF41@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB5823.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 161bf031-d084-4986-ea76-08db8e16095c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2023 20:22:29.9998
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: owKopO2rMsT5ILqgm0ojPN4xlOh4yDcM4xAPMb8sktEK02EMlQ+Jc08L0/cqLMvL14UvukzcYrJ6nF03PrGsC+blUiFCVnPp/hvr8RK0jIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4856
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA3LTI1IGF0IDEyOjQzICswMjAwLCBOYXJlc2ggU29sYW5raSB3cm90ZToK
PiBGcm9tOiBQYXRyaWNrIFJ1ZG9scGggPHBhdHJpY2sucnVkb2xwaEA5ZWxlbWVudHMuY29tPgo+
IAo+IEV4dGVuZCB0aGUgZnVuY3Rpb25hbGl0eSBvZiBod21vbiAocGVjaS9kaW1tdGVtcCkgZm9y
IFNhcHBoaXJlIFJhcGlkcwo+IHBsYXRmb3JtLgo+IAo+IEFkZCB0aGUgY29ycmVzcG9uZGluZyBT
YXBwaGlyZSBSYXBpZHMgSUQgYW5kIHRocmVzaG9sZCBjb2RlLgo+IAo+IFRoZSBwYXRjaCBoYXMg
YmVlbiB0ZXN0ZWQgb24gYSA0UyBzeXN0ZW0gd2l0aCA2NCBESU1NcyBpbnN0YWxsZWQuCj4gVmVy
aWZpZWQgcmVhZCBvZiBESU1NIHRlbXBlcmF0dXJlIHRocmVzaG9sZHMgJiB0ZW1wZXJhdHVyZS4K
PiAKPiBTaWduZWQtb2ZmLWJ5OiBQYXRyaWNrIFJ1ZG9scGggPHBhdHJpY2sucnVkb2xwaEA5ZWxl
bWVudHMuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE5hcmVzaCBTb2xhbmtpIDxOYXJlc2guU29sYW5r
aUA5ZWxlbWVudHMuY29tPgo+IEFja2VkLWJ5OiBHdWVudGVyIFJvZWNrIDxsaW51eEByb2Vjay11
cy5uZXQ+CgpSZXZpZXdlZC1ieTogSXdvbmEgV2luaWFyc2thIDxpd29uYS53aW5pYXJza2FAaW50
ZWwuY29tPgoKSSdsbCBhcHBseSBpdCB0byBwZWNpLW5leHQuCgpUaGFua3MKLUl3b25hCgo+IC0t
LQo+IENoYW5nZXMgaW4gVjQ6Cj4gLSBJbnN0ZWFkIG9mIHVzaW5nIGhhcmQgY29kZWQgZGltbSB0
ZW1wZXJhdHVyZSB0aHJlc2hvbGQsIHJlYWQgZnJvbSBtbWlvCj4gwqAgb2Zmc2V0Lgo+IC0gQ2hh
bmdlIENIQU5fUkFOS19NQVhfT05fU1BSIHRvIDgKPiAtIFJlc3RvcmUgI2RlZmluZSBDSEFOX1JB
TktfTUFYIHRvIHByZXZpb3VzIGFzc2lnbm1lbnQuCj4gLSBVcGRhdGUgY29tbWl0IG1lc3NhZ2Uu
Cj4gQ2hhbmdlcyBpbiBWMzoKPiAtIFVwZGF0ZSBBY2tlZC1ieSBpbiBjb21taXQgbWVzc2FnZS4K
PiBDaGFuZ2VzIGluIFYyOgo+IC0gVXBkYXRlIHN1YmplY3QuCj4gLS0tCj4gwqBkcml2ZXJzL2h3
bW9uL3BlY2kvZGltbXRlbXAuYyB8IDUwICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrCj4gwqAxIGZpbGUgY2hhbmdlZCwgNTAgaW5zZXJ0aW9ucygrKQo+IAo+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL2h3bW9uL3BlY2kvZGltbXRlbXAuYyBiL2RyaXZlcnMvaHdtb24vcGVjaS9kaW1t
dGVtcC5jCj4gaW5kZXggY2U4OWRhMzkzN2EwLi41Y2E0ZDA0ZTRiMTQgMTAwNjQ0Cj4gLS0tIGEv
ZHJpdmVycy9od21vbi9wZWNpL2RpbW10ZW1wLmMKPiArKysgYi9kcml2ZXJzL2h3bW9uL3BlY2kv
ZGltbXRlbXAuYwo+IEBAIC0zMCw2ICszMCw4IEBACj4gwqAjZGVmaW5lIERJTU1fSURYX01BWF9P
Tl9JQ1jCoMKgwqDCoDIKPiDCoCNkZWZpbmUgQ0hBTl9SQU5LX01BWF9PTl9JQ1hEwqDCoDQKPiDC
oCNkZWZpbmUgRElNTV9JRFhfTUFYX09OX0lDWETCoMKgwqAyCj4gKyNkZWZpbmUgQ0hBTl9SQU5L
X01BWF9PTl9TUFLCoMKgwqA4Cj4gKyNkZWZpbmUgRElNTV9JRFhfTUFYX09OX1NQUsKgwqDCoMKg
Mgo+IMKgCj4gwqAjZGVmaW5lIENIQU5fUkFOS19NQVjCoMKgwqDCoMKgwqDCoMKgwqDCoENIQU5f
UkFOS19NQVhfT05fSFNYCj4gwqAjZGVmaW5lIERJTU1fSURYX01BWMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqBESU1NX0lEWF9NQVhfT05fSFNYCj4gQEAgLTUzNCw2ICs1MzYsNDMgQEAgcmVhZF90aHJl
c2hvbGRzX2ljeChzdHJ1Y3QgcGVjaV9kaW1tdGVtcCAqcHJpdiwgaW50Cj4gZGltbV9vcmRlciwg
aW50IGNoYW5fcmFuaywgdQo+IMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiDCoH0KPiDCoAo+
ICtzdGF0aWMgaW50Cj4gK3JlYWRfdGhyZXNob2xkc19zcHIoc3RydWN0IHBlY2lfZGltbXRlbXAg
KnByaXYsIGludCBkaW1tX29yZGVyLCBpbnQKPiBjaGFuX3JhbmssIHUzMiAqZGF0YSkKPiArewo+
ICvCoMKgwqDCoMKgwqDCoHUzMiByZWdfdmFsOwo+ICvCoMKgwqDCoMKgwqDCoHU2NCBvZmZzZXQ7
Cj4gK8KgwqDCoMKgwqDCoMKgaW50IHJldDsKPiArwqDCoMKgwqDCoMKgwqB1OCBkZXY7Cj4gKwo+
ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBlY2lfZXBfcGNpX2xvY2FsX3JlYWQocHJpdi0+cGVjaV9k
ZXYsIDAsIDMwLCAwLCAyLCAweGQ0LAo+ICZyZWdfdmFsKTsKPiArwqDCoMKgwqDCoMKgwqBpZiAo
cmV0IHx8ICEocmVnX3ZhbCAmIEJJVCgzMSkpKQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqByZXR1cm4gLUVOT0RBVEE7IC8qIFVzZSBkZWZhdWx0IG9yIHByZXZpb3VzIHZhbHVlICov
Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJldCA9IHBlY2lfZXBfcGNpX2xvY2FsX3JlYWQocHJpdi0+
cGVjaV9kZXYsIDAsIDMwLCAwLCAyLCAweGQwLAo+ICZyZWdfdmFsKTsKPiArwqDCoMKgwqDCoMKg
wqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1cm4gLUVOT0RB
VEE7IC8qIFVzZSBkZWZhdWx0IG9yIHByZXZpb3VzIHZhbHVlICovCj4gKwo+ICvCoMKgwqDCoMKg
wqDCoC8qCj4gK8KgwqDCoMKgwqDCoMKgICogRGV2aWNlIDI2LCBPZmZzZXQgMjE5YTg6IElNQyAw
IGNoYW5uZWwgMCAtPiByYW5rIDAKPiArwqDCoMKgwqDCoMKgwqAgKiBEZXZpY2UgMjYsIE9mZnNl
dCAyOTlhODogSU1DIDAgY2hhbm5lbCAxIC0+IHJhbmsgMQo+ICvCoMKgwqDCoMKgwqDCoCAqIERl
dmljZSAyNywgT2Zmc2V0IDIxOWE4OiBJTUMgMSBjaGFubmVsIDAgLT4gcmFuayAyCj4gK8KgwqDC
oMKgwqDCoMKgICogRGV2aWNlIDI3LCBPZmZzZXQgMjk5YTg6IElNQyAxIGNoYW5uZWwgMSAtPiBy
YW5rIDMKPiArwqDCoMKgwqDCoMKgwqAgKiBEZXZpY2UgMjgsIE9mZnNldCAyMTlhODogSU1DIDIg
Y2hhbm5lbCAwIC0+IHJhbmsgNAo+ICvCoMKgwqDCoMKgwqDCoCAqIERldmljZSAyOCwgT2Zmc2V0
IDI5OWE4OiBJTUMgMiBjaGFubmVsIDEgLT4gcmFuayA1Cj4gK8KgwqDCoMKgwqDCoMKgICogRGV2
aWNlIDI5LCBPZmZzZXQgMjE5YTg6IElNQyAzIGNoYW5uZWwgMCAtPiByYW5rIDYKPiArwqDCoMKg
wqDCoMKgwqAgKiBEZXZpY2UgMjksIE9mZnNldCAyOTlhODogSU1DIDMgY2hhbm5lbCAxIC0+IHJh
bmsgNwo+ICvCoMKgwqDCoMKgwqDCoCAqLwo+ICvCoMKgwqDCoMKgwqDCoGRldiA9IDI2ICsgY2hh
bl9yYW5rIC8gMjsKPiArwqDCoMKgwqDCoMKgwqBvZmZzZXQgPSAweDIxOWE4ICsgZGltbV9vcmRl
ciAqIDQgKyAoY2hhbl9yYW5rICUgMikgKiAweDgwMDA7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoHJl
dCA9IHBlY2lfbW1pb19yZWFkKHByaXYtPnBlY2lfZGV2LCAwLCBHRVRfQ1BVX1NFRyhyZWdfdmFs
KSwKPiBHRVRfQ1BVX0JVUyhyZWdfdmFsKSwKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGRldiwgMCwgb2Zmc2V0LCBkYXRhKTsKPiArwqDC
oMKgwqDCoMKgwqBpZiAocmV0KQo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqByZXR1
cm4gcmV0Owo+ICsKPiArwqDCoMKgwqDCoMKgwqByZXR1cm4gMDsKPiArfQo+ICsKPiDCoHN0YXRp
YyBjb25zdCBzdHJ1Y3QgZGltbV9pbmZvIGRpbW1faHN4ID0gewo+IMKgwqDCoMKgwqDCoMKgwqAu
Y2hhbl9yYW5rX21heMKgwqA9IENIQU5fUkFOS19NQVhfT05fSFNYLAo+IMKgwqDCoMKgwqDCoMKg
wqAuZGltbV9pZHhfbWF4wqDCoMKgPSBESU1NX0lEWF9NQVhfT05fSFNYLAo+IEBAIC01NzYsNiAr
NjE1LDEzIEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGltbV9pbmZvIGRpbW1faWN4ZCA9IHsKPiDC
oMKgwqDCoMKgwqDCoMKgLnJlYWRfdGhyZXNob2xkcyA9ICZyZWFkX3RocmVzaG9sZHNfaWN4LAo+
IMKgfTsKPiDCoAo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGRpbW1faW5mbyBkaW1tX3NwciA9IHsK
PiArwqDCoMKgwqDCoMKgwqAuY2hhbl9yYW5rX21heMKgwqA9IENIQU5fUkFOS19NQVhfT05fU1BS
LAo+ICvCoMKgwqDCoMKgwqDCoC5kaW1tX2lkeF9tYXjCoMKgwqA9IERJTU1fSURYX01BWF9PTl9T
UFIsCj4gK8KgwqDCoMKgwqDCoMKgLm1pbl9wZWNpX3JldmlzaW9uID0gMHg0MCwKPiArwqDCoMKg
wqDCoMKgwqAucmVhZF90aHJlc2hvbGRzID0gJnJlYWRfdGhyZXNob2xkc19zcHIsCj4gK307Cj4g
Kwo+IMKgc3RhdGljIGNvbnN0IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkIHBlY2lfZGltbXRl
bXBfaWRzW10gPSB7Cj4gwqDCoMKgwqDCoMKgwqDCoHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoC5uYW1lID0gInBlY2lfY3B1LmRpbW10ZW1wLmhzeCIsCj4gQEAgLTYwMSw2ICs2
NDcsMTAgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBhdXhpbGlhcnlfZGV2aWNlX2lkCj4gcGVjaV9k
aW1tdGVtcF9pZHNbXSA9IHsKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoC5uYW1l
ID0gInBlY2lfY3B1LmRpbW10ZW1wLmljeGQiLAo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgLmRyaXZlcl9kYXRhID0gKGtlcm5lbF91bG9uZ190KSZkaW1tX2ljeGQsCj4gwqDCoMKg
wqDCoMKgwqDCoH0sCj4gK8KgwqDCoMKgwqDCoMKgewo+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAubmFtZSA9ICJwZWNpX2NwdS5kaW1tdGVtcC5zcHIiLAo+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vsb25nX3QpJmRpbW1fc3By
LAo+ICvCoMKgwqDCoMKgwqDCoH0sCj4gwqDCoMKgwqDCoMKgwqDCoHsgfQo+IMKgfTsKPiDCoE1P
RFVMRV9ERVZJQ0VfVEFCTEUoYXV4aWxpYXJ5LCBwZWNpX2RpbW10ZW1wX2lkcyk7Cgo=
