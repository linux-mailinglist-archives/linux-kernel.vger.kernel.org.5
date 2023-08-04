Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A82770B3C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 23:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjHDVtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 17:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjHDVtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 17:49:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F03E5F0;
        Fri,  4 Aug 2023 14:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691185755; x=1722721755;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=HnuF27DjDnzoU6/RiGgfF+6GFFOrahmJ0gNbrQESsrs=;
  b=Eu47RPRokPk+EhgPOZgRqnwpSTXowAfrfBCw7+hvNPsDseczUT4sn5JP
   3ED0WtGGNNGhrOPDJtm9qy6BZzB064fhOnWGw0mBd0JkuyxNJwKmx/PKX
   ZwxHBgghpW3G8kWQehn9iEywI6PR53rKlXlyp29wSyNBdLE42ERVOvbah
   U/EF3FIwlpJrRDO5K2HMDcpKT7LlBwnPFl9fh8NM++LDF06nrztAAphIp
   VFh65ZluHoreLR9Gq3mKlCqvIBUNjx1Uz+xciUK2vu4rHYA3q3geI8tm8
   0zVOf2CKTtNoFJR5tVrDbQUYkhRo/tAuBrJ8WYpUjeoKUrWIyKua+bl1z
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="456633118"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="456633118"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2023 14:49:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10792"; a="904037567"
X-IronPort-AV: E=Sophos;i="6.01,256,1684825200"; 
   d="scan'208";a="904037567"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga005.jf.intel.com with ESMTP; 04 Aug 2023 14:49:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 14:49:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 14:49:14 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 4 Aug 2023 14:49:14 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 4 Aug 2023 14:49:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WIWWd8G7mp5Ejd+AD7RuqjWAaothxaGc3CCuM6dbmuryYMZHYmuiW/yYM03NmB2k4jJxkB46WFX6IJjcnaNX4+v7tqDmSilat871a9hVwUFEDYHpiiaPLAHlgoBLf+oC+kW2UKe3vi2vkwK7lgUZ6or5tmEHFhMc43RJJgObVhhJyvGxoaS5yXhxLuGTQ+8RADMMJrooo4lNYTHs6x79nhVQMLfRa4Nzahisjs9AHcYC6ElH53eHrf/7fUfCj5yDNtaB1u4iAFYlU0KHxOEqCvqYr9K/tZxT0HMdQMDNxRXoFS5CCX/B/1ETbmcuQ7S1krPmfb9q2K0rltH2Ur3W5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HnuF27DjDnzoU6/RiGgfF+6GFFOrahmJ0gNbrQESsrs=;
 b=Bk1tM1Ybg3n6bcRXPxUzUuj0oZvA+vxNnAObJCxNn64PkBViKw1JgzrlA2fBC00Q9JWw3WBhU1MbyKXaI493kAL+MtTD6tis7tDXEZXNxLctnh+Zk7mp4xOptM5PsGzMTapRjhCfBqsSu3+/Cg6tgnhAgRS3Tpg0zUp4KwfqHgUuX5h3PrzOuOwkYQEjJ5Yuf8San4ZoxMUBJgIQJu5HOzk7eMWynznnf5CQjLw2UantuReGGzr/Tkb+tLHjU7ZWgchfkyMxSVdPutbAkVevF+ZRAWiQf8DzLWBXycioi6LEXhVVTX5e7HtGFx4dCDg2NfOWJSrMVpF82XX6pu2Crg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL1PR11MB5978.namprd11.prod.outlook.com (2603:10b6:208:385::18)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Fri, 4 Aug
 2023 21:49:12 +0000
Received: from BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739]) by BL1PR11MB5978.namprd11.prod.outlook.com
 ([fe80::980d:80cc:c006:e739%4]) with mapi id 15.20.6652.020; Fri, 4 Aug 2023
 21:49:12 +0000
From:   "Huang, Kai" <kai.huang@intel.com>
To:     "berrange@redhat.com" <berrange@redhat.com>
CC:     "linux-coco@lists.linux.dev" <linux-coco@lists.linux.dev>,
        "sameo@rivosinc.com" <sameo@rivosinc.com>,
        "James.Bottomley@hansenpartnership.com" 
        <James.Bottomley@hansenpartnership.com>,
        "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>,
        "dionnaglaze@google.com" <dionnaglaze@google.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "jarkko@kernel.org" <jarkko@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "brijesh.singh@amd.com" <brijesh.singh@amd.com>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: Re: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Topic: [PATCH 0/4] keys: Introduce a keys frontend for attestation
 reports
Thread-Index: AQHZwYoTw9Njl1TosE69WJRoUv/G3a/RDr0AgACyhACAAIcTgIADD9cAgAUDpQCAAFwXAA==
Date:   Fri, 4 Aug 2023 21:49:11 +0000
Message-ID: <f62594e1e3c16144de00b1132b019e4101209853.camel@intel.com>
References: <169057265210.180586.7950140104251236598.stgit@dwillia2-xfh.jf.intel.com>
         <a507ef3302d3afff58d82528ee17e82df1f21de0.camel@HansenPartnership.com>
         <64c5ed6eb4ca1_a88b2942a@dwillia2-xfh.jf.intel.com.notmuch>
         <c6576d1682b576ba47556478a98f397ed518a177.camel@HansenPartnership.com>
         <6dec442c64faf2fecd21bcc77e4a6350e88948b9.camel@intel.com>
         <ZM0lEvYJ+5IgybLT@redhat.com>
In-Reply-To: <ZM0lEvYJ+5IgybLT@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR11MB5978:EE_|IA0PR11MB8398:EE_
x-ms-office365-filtering-correlation-id: 7e43590d-2bbc-4a89-b132-08db9534a342
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: G3nx37fRkhBTz5yyl2At6vbMeXuAR2lOBtnYsVKRR6H90ozshJeq91zZapxRxsVIntHp1FtyebjDsQ8TklQrKmmYQNymb2hd41UNJQ4b/UGPnMG7jpK7BELglzfah+siJyorieI00/GgKqnC95EIzjwfaRBbGS03ZqLZb9okRB4J8Eatu5yW70i29DIXA+jZe9ZCAG3+HbjD5G7sWZZ1lI0Y+NbSb7X0zLEEloz5+fk3FC2o9wpLvok57FQIHv3digzGoKIRhWLr3cM+WLB2rS3wZhgy2TGA2oA2yiFpfRR9BPmTvfNpIlW3Sj5ApA3HjvGAnjuFic8Q8R3QL2q+cEqTp7d5GuyqVXVUqXh385SKsWhir8MBp7wNYr9NtzOTHGy1L3N2JusWCQdRLniODbXHn2kRWR67Z6S/vYpNt8ut/AqPcwvQ84kqYKIVff6EzwfTvaWULiQabbKY+gZW2Mc+Bla/pQ16oIPsEIEvC8+Tb/WAVTjgc+H/nL9YXZ/KnP70DuvdqtzTx36B70Tf2Gu3g9rnJQ6LOz91OTDGx2UWTPXV45Yw82u2KWNNk61Gf9j+YuJNh4FvuNFpFIvVHJeSn9U1W1mKPdbWwe3ycycrcFJt4aUte8qXczSovIpw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR11MB5978.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(136003)(346002)(396003)(366004)(186006)(1800799003)(451199021)(71200400001)(54906003)(6486002)(41300700001)(478600001)(7416002)(5660300002)(8936002)(8676002)(66446008)(4326008)(91956017)(316002)(6916009)(66476007)(6512007)(64756008)(6506007)(66556008)(76116006)(66946007)(26005)(2616005)(2906002)(83380400001)(38100700002)(36756003)(82960400001)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UENVNmY4cExmT0x4WlJqNm9qTHFsU0VNSUJ0bUxCVHlWcEZoRWJnU01LRlhM?=
 =?utf-8?B?blFWSktUMUh3d0VsRUlWUk1odDl3aEpOR1U3SFhRVUdyM21sYTZzZHlvUGQr?=
 =?utf-8?B?TjcyaXNLbXF4bmtrTXJIcHF6T2VZZGxPT29zMGFYdWl5bmoxR3dyQXBycm5k?=
 =?utf-8?B?SlJ5N2pZUzNzcVdOU3VYRzYvcEtJWHpvb0tqSjB6ZmZONDBJR0E5RkNzR1Uy?=
 =?utf-8?B?VzVDWTQ1Q2xRVXdwd051d1FIeVpYK0tzVXNtR3RiUVJXZmk2bXFacDY3cGoy?=
 =?utf-8?B?cTNCVTNaaTd0TEhKNHRDSXRza2pPaDRQcno5S3lPUld5ZUR5SXlUNFYzZHJI?=
 =?utf-8?B?eHIrTytIajZBUXZwT1IzTGMrODJ0ZTYvUThFNzVuWVI3RElqd2JVVDZGbGtk?=
 =?utf-8?B?dG5oNlllYWMwQTVHU2wzazhmeTBCR29qUm9ZdmlETHBOajFXTEU0QTF1d2lM?=
 =?utf-8?B?eDNJMjhKdjdrMGkzc1phVnlwRjRPL3JwUmlackdycjJ2MGZpUktYNW5aM2V3?=
 =?utf-8?B?ZndiRi8xVnNhZ2lka3I5S1NhcmhLdENzNWhpVEtjeFNrc0sxTTlyVzRBOTQw?=
 =?utf-8?B?Z2tkZ2tBeTVLNUk0MVFoN2o1UlROSkYrdlFJQlIzQm1pNHQ3NFhNakE5d2d3?=
 =?utf-8?B?RGVxMDkwbDJObVdHTkxZK0swNjd0NkZ6dHFVdXZOM25HZzB0ZDhsOG84aUsr?=
 =?utf-8?B?WmN2T3h3VXUzTktJNUpjWnZDbzM0a0RqYzVkTDYzUUpiSUdjSXFkLzhwUHdU?=
 =?utf-8?B?RFdDYlhCWWdGVEEzaEpNaCtnU3M1bHdjb2J5MFg2aEUwcUZNVzhlMWFYRW54?=
 =?utf-8?B?V1R4TExwVzRBT1hoaG5RdUpEdUtQSnlnNzhrMWVYWER5Q0x4MFNHTWFpQzlS?=
 =?utf-8?B?V0dUT2JNdWNPdlBzMEh2cXRWb1lEUkI4ZzNLMy9hSFlIRFFWRjZXNkczajNV?=
 =?utf-8?B?ZlM2cklxcTkxTjdIN0VZdncwOUlxdDdVdGNGcWRoeFZjVVRPUDZ6NkJnbEdK?=
 =?utf-8?B?MEFmSmo5UTlnRit1ZUkxOHNaU2ZCQ1dZS2YrclR0SDByWDBuSkNwcUh1a1Bj?=
 =?utf-8?B?d3lSTnl5aWN2dTFVYW1oQlFUa1daTnV1MnB1c0p0M3Axa1Zjem4zZDNuUGdV?=
 =?utf-8?B?eHRQK3lRR01oOVBkM3lySk5tZEhOaWlJbjVWZklsYzVJVlczTWhVSnVEYXFx?=
 =?utf-8?B?QkdCV09KL2hMelhsc3Z4dlZuNWF2ZFNocGRpczB2NXRGRnFWSFVlYTduM1ht?=
 =?utf-8?B?WjY3eXBRTnBlM3FSeXNMRHZNUEpQaVJoQWJ4ZjhrcENWV2tzbkJqMU9SWmpX?=
 =?utf-8?B?VmZJakZJVVhIelVnOWFCUitwQmRETDIxVnlpZDkxdTNkQ1hIWHRSY2w0allr?=
 =?utf-8?B?R2M0NmhsTEltNVp0REV0ZEM2QUFEcXJYSW0yNkF2ZkVvQ2NaV21UVlUxTGEx?=
 =?utf-8?B?RHJuZXNYSVhqaHYvWUFsbU9ZeTVlVUg5V2NGKzA3TlQzclROWm1TdzBFRzl3?=
 =?utf-8?B?WnpJSmF4SURNNWRTQUpOWWZHeW16UkpjNmZINVhQb24zdjNUUGd4WVM3NDQ2?=
 =?utf-8?B?QzRqMzk3ZFZpL1pTUm1iTUNSU3pCM2pINVZiWjhSWXRZbzdSRGROQ2kvTXAy?=
 =?utf-8?B?SjNrVk9YQWxKVFlKb0xFUzBsamE0NEZJT3BjQnp5S0pSMmk3R0huc1FST3Jw?=
 =?utf-8?B?bUtlVUE1d2M0UnZTbmFRUWpYNFJXK29FcWFXem0vdmNUbEZIdC9vbTkxWUU3?=
 =?utf-8?B?OTJ4blMwSXIyRlRpQkpMZUJiblBFanNGYTVWZkVhNndzOGxZZnQyMkJxbjNS?=
 =?utf-8?B?eC9FbHVZSmlRSzVOYzZtWksvWTViZmRFM29UbzEwVm42aVIxNmRPY1grZjVr?=
 =?utf-8?B?VHF6Sk1wSTZDdi9zdlQ2VHVSVi83SHY4TUpmQStjU0Q5RWRDZlBGUkd2ZVBt?=
 =?utf-8?B?UGcvbVZ3L3EwM0JROG1SS0FiLy85NlcxNkl2RTJUZnk3MzczNGFya09LbExp?=
 =?utf-8?B?UXB5UWJieDFPSm1VSllBZTNQalJWcHBDdmdkVFQrRVorbWVXaGxLQ3RQVVNt?=
 =?utf-8?B?aFIyVUg5RndNUDAyVmlCandIc2QrQW5UcCtPRXpEdklUUmtRM3BUV0dESHZG?=
 =?utf-8?Q?GxIV5XANUc0mKETTTryjJE4qW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD83E43E07DDA34A868A81CE7B9DCFB7@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR11MB5978.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e43590d-2bbc-4a89-b132-08db9534a342
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Aug 2023 21:49:11.2788
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bmx27cWG3pzTHhAg6K18WTKFZCC85wQe/+XI8ICZnlBWuBmnp595e1A06Fe5b2ZmBsETLroyYCSk4SV218VSiw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gRnJpLCAyMDIzLTA4LTA0IGF0IDE3OjE5ICswMTAwLCBEYW5pZWwgUC4gQmVycmFuZ8OpIHdy
b3RlOg0KPiBPbiBUdWUsIEF1ZyAwMSwgMjAyMyBhdCAxMTo0NToxMkFNICswMDAwLCBIdWFuZywg
S2FpIHdyb3RlOg0KPiA+IFRoZSBJT0NUTCB2cyAvc3lzZnMgaXNuJ3QgZGlzY3Vzc2VkLg0KPiA+
IA0KPiA+IEZvciBpbnN0YW5jZSwgYWZ0ZXIgcm91Z2ggdGhpbmtpbmcsIHdoeSBpcyB0aGUgSU9D
VEwgYmV0dGVyIHRoYW4gYmVsb3cgYXBwcm9hY2gNCj4gPiB1c2luZyAvc3lzZnM/DQo+ID4gDQo+
ID4gZWNobyA8UkVQT1JUREFUQT4gPiAvc3lzL2tlcm5lbC9jb2NvL3RkeC9hdHRlc3QvcmVwb3J0
ZGF0YQ0KPiA+IGNhdCAvc3lzL2tlcm5lbC9jb2NvL3RkeC9hdHRlc3QvdGRyZXBvcnQNCj4gPiAN
Cj4gPiBFYWNoICJlY2hvIDxSRVBPUlREQVRBPiIgdG8gJy9zeXMvLi4uL3JlcG9ydGRhdGEnIHRy
aWdnZXJzIHRoZSBkcml2ZXIgdG8gY2FsbA0KPiA+IFREQ0FMTCB0byBnZXQgdGhlIFREUkVQT1JU
LCB3aGljaCBpcyBhdmFpbGFibGUgYXQgJy9zeXMvLi4uL3RkcmVwb3J0Jy4NCj4gDQo+IFdoYXQg
d291bGQgeW91IHN1Z2dlc3QgYXMgYmVoYXZpb3VyIHdpdGggbXVsdGlwbGUgcHJvY2Vzc2VzIHdy
aXRpbmcNCj4gaW50byAncmVwb3J0ZGF0YScgYW5kIHRyeWluZyB0byByZWFkIGZyb20gJ3RkcmVw
b3J0JyBpbiBwYXJhbGxlbCA/DQo+IFNwbGl0dGluZyBpbnB1dCBhbmQgb3V0cHV0IGFjcm9zcyBz
ZXBhcmF0ZSBmaWxlcyByZW1vdmVzIGFueQ0KPiB0cmFuc2FjdGlvbmFsIHJlbGF0aW9uc2hpcCBi
ZXR3ZWVuIGlucHV0IGFuZCBvdXRwdXQuIFRoaXMgYXBwcm9hY2gNCj4gZmVlbHMgbGlrZSBpdCBj
b3VsZCBlYXNpbHkgcmVzdWx0IGluIGJ1Z2d5IGJlaGF2aW91ciBmcm9tIGNvbmN1cnJlbnQNCj4g
YXBwbGljYXRpb24gdXNhZ2UsIHdoaWNoIHdvdWxkIG5vdCBiZSBhbiBpc3N1ZSB3aXRoIGlvY3Rs
KCkNCg0KQXQgdGhhdCB0aW1lIHdlIGJlbGlldmVkIGF0dGVzdGF0aW9uIGlzIGEgcmVsYXRpdmVs
eSBsb3cgZnJlcXVlbnQgb3BlcmF0aW9uIHRodXMNCml0J3MgYWNjZXB0YWJsZSB0byBub3Qgc3Vw
cG9ydCBjb25jdXJyZW50IHJlcG9ydCBnZW5lcmF0aW9uLiAgV2hpbGUga2VybmVsIGlzDQpwcm9j
ZXNzaW5nIG9uZSByZXBvcnQgdGhlIG90aGVyIHJlcXVlc3RzIG5lZWQgdG8gd2FpdC4gIFRoaXMg
c2hvdWxkbid0IGJlIGENCnByb2JsZW0gYmVjYXVzZSB0aGUgVERSRVBPUlQgbWVudGlvbmVkIGFi
b3ZlIGlzIGRpcmVjdGx5IGZyb20gVERYIGZpcm13YXJlIGFuZA0Kd29uJ3QgYmxvY2sgZm9yIGxv
bmcgdGltZS4NCg0KQW5kIGluIHRoYXQgY29udGV4dCB3ZSB3ZXJlIHNwbGl0dGluZyBnZXR0aW5n
IFREUkVQT1JUIGFuZCBRdW90ZSwgbWVhbmluZyBhZnRlcg0KZ2V0dGluZyBURFJFUE9SVCB3ZSBj
b3VsZCBoYXZlIGFub3RoZXIgbWVjaGFuaXNtIChlLmcuLCB1c2luZyBJT0NUTCgpKSB0byBnZXQN
ClF1b3RlLCB3aGljaCBjb3VsZCBiZSBtYWRlIHRvIHN1cHBvcnQgY29uY3VycmVudCByZXF1ZXN0
cy4gDQoNCk5vdyBpZiB3ZSB3YW50IHRvIHVzZSAvc3lzZnMgdG8gZ2V0IHRoZSBRdW90ZSwgSSBh
bSBzdGlsbCBleHBlY3RpbmcgYXR0ZXN0YXRpb24NCnNob3VsZCBiZSBhIGxvdyBmcmVxdWVudCBv
cGVyYXRpb24sIHRodXMgdG8gbWUgbm90IHN1cHBvcnRpbmcgY29uY3VycmVudA0KcmVxdWVzdHMg
aXMgc3RpbGwgYWNjZXB0YWJsZS4gIEJ1dCBzaW5jZSBnZXR0aW5nIFF1b3RlIGludm9sdmVzIGFz
a2luZyBWTU0gdG8NCmdldCBhIHNpZ25lZCBRdW90ZSBmcm9tIGFub3RoZXIgdXNlcnNwYWNlIHBy
b2Nlc3MgKFNHWCBRRSkgb3IgZXZlbiBmcm9tIGFub3RoZXINClZNICh3aGVyZSBRRSBydW5zKSBk
ZXBlbmRpbmcgb24gdGhlIGRlcGxveW1lbnQsIHRoZSBsYXRlbmN5IG9mIGJlaW5nIGJsb2NrZWQN
CmZyb20gcmVhZGluZyAvc3lzZnMgbWF5IGJlIGEgY29uY2Vybi4gIEJ1dCB3ZSBjYW4gc3VwcG9y
dCByZXR1cm4gLUVJTlRSIGlmDQpuZWVkZWQgc28gbm90IGEgYmxvY2tpbmcgaXNzdWUgSSBzdXBw
b3NlLg0KDQpEbyB5b3UgaGF2ZSBhbnkgdXNlIGNhc2UgdGhhdCBzdXBwb3J0aW5nIGNvbmN1cnJl
bnQgYXR0ZXN0YXRpb24gcmVxdWVzdHMgaXMNCmltcG9ydGFudD8NCg0KQnR3IEkgYW0gbm90IGFn
YWluc3QgdXNpbmcgSU9DVEwoKSA6LSkNCg0KPiANCj4gQWxzbyBub3RlLCB0aGVyZSBuZWVkcyB0
byBiZSBzY29wZSBmb3IgbW9yZSB0aGFuIDEgaW5wdXQgYW5kIDEgb3V0cHV0DQo+IGRhdGEgaXRl
bXMuIEZvciBTTlAgZ3Vlc3RzLCB0aGUgVk1QTCBpcyBhIGlucHV0LCBhbmQgaWYgZmV0Y2hpbmcg
YQ0KPiBWTVBMIDAgcmVwb3J0IGZyb20gdW5kZXIgU1ZTTSBbMV0sIGFuIG9wdGlvbmFsIHNlcnZp
Y2UgR1VJRCBpcyBuZWVkZWQuDQo+IFdpdGggU1ZTTSwgdGhlcmUgYXJlIHRocmVlIGRpc3RpbmN0
IG91dHB1dCBkYXRhIGJsb2JzIC0gYXR0ZXN0YXRpb24NCj4gcmVwb3J0LCBzZXJ2aWNlcyBtYW5p
ZmVzdCBhbmQgY2VydGlmaWNhdGUgZGF0YS4NCg0KWWVhaCB3ZSBuZWVkIHRvIGZpbmQgc29tZXdh
eSB0byB1bmlmeS4NCg==
