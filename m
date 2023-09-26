Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6E27AF6A0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:14:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjIZXOL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:14:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjIZXMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:12:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3B8D93CF;
        Tue, 26 Sep 2023 15:14:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695766481; x=1727302481;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=+9U14g7W5ACSieqONK6vtQcajHT5U7ijo5PDRipWN3k=;
  b=JDGsY9qVC+mbDANYOC5wAHKXCh/PxidGk9QRl0hGbD5bA/bf3I3OnFY3
   QDQ6kHQom863N08sLQUGdm84aJoPj618Q+UzAc/cYt+CEVYLeEr2MOhaI
   fJVc2C26KZwjpU3Yvg2DbaBYso9JXgizk9d0QZNZOQlIrfEzbB2pcP2ow
   gmthjZIK8hObpxyZHEGt009JkLZe1b3yt5IHM3E8QOQAMCVjgKy9ip/px
   /HnJmkWPiJEG9Pup6//ercusxvtbaFS0hKs6bClK7WeoGoxyOnrHeKnlC
   VLbX0N7jGnbzx/6h01arHKIPweWl+FY72I0Sqa9jtCttFlWSZV/RPS1h/
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="361930200"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="361930200"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 15:14:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; 
   d="scan'208";a="315777"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Sep 2023 15:14:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 15:14:40 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 26 Sep 2023 15:14:40 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 26 Sep 2023 15:14:40 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 26 Sep 2023 15:14:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V5icp5box7nUfbchKqqbn2WcgCJIzT0kzZ8uQrPnXjF4fEOIZpxTgp8wOYuJi/DmdCk9Ow2yfy8/dyAtmADeuQWyz4xzC+FwNTl8a5cZDscAWPFTW9bHpbt7QJnYGpAjbfgCwIgoPZkrzSPcbfbe27A8jH8kBUO/Cg5bvScuOju/+QSgTta91/dpwY4TtmlYLxCln2l+BWLDWJdHZWufMMFLziVkbRUGAx+mrePJZ7DbKrQNR8O5b8IsgeNcMJFQVKCner54f6G88BfZWfAeM6FZh9Y3tQT2yLCIqjTOdAMrDZKylLq01hbIPDjhYayA+VsmswkA5er5SXnx+z3a2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9U14g7W5ACSieqONK6vtQcajHT5U7ijo5PDRipWN3k=;
 b=FpQhQLT+m1YKJBdFlWUnWUmSgqNH3RT2HNv6CY+I860VD8BqPeeg1DknK3RkRhHMEJW0/tcH/gDXZnvEpnVwmZPKa2Pa3vjWGpQjx6p/TZ3l5cbKQ6VgzRyU59qDzAY74x1YqW/sgq20p0Gg+1e25xjDDjIYHbqEXRZkNMb6A8kpZFSygPoYnPOrTilqrMoS+AawyBNJ2cASVaoFzMAHwNCyU/qf4QIgk5BQvpo2ae/QQE4AYkMkqalrBl0JLsUrfWS9xmBkNT1s8ET5Y9ExDhlhSERwzin0fjj9YR6cqTIqpbwkJC3UCrzv1S/pQITcntjKh9TqRBHxMkl7yF5yjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by DM4PR11MB6334.namprd11.prod.outlook.com (2603:10b6:8:b5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Tue, 26 Sep
 2023 22:14:38 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%7]) with mapi id 15.20.6792.026; Tue, 26 Sep 2023
 22:14:38 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Chatre, Reinette" <reinette.chatre@intel.com>
CC:     "Yu, Fenghua" <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>
Subject: RE: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Thread-Topic: [PATCH v5 3/8] x86/resctrl: Split the rdt_domain structure
Thread-Index: AQHZ2tLNO4lA/XIHxUC5FtYBBgm4WrAsWW2AgAF60aCAAAHJAA==
Date:   Tue, 26 Sep 2023 22:14:38 +0000
Message-ID: <SJ1PR11MB6083D9AA22033235210BD847FCC3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-4-tony.luck@intel.com>
 <5f1256d3-737e-a447-abbe-f541767b2c8f@intel.com>
 <ZRMnCFWzcxa6Qa4E@agluck-desk3>
 <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
In-Reply-To: <5b2fd31e-3cef-3c35-7d17-411cea27502a@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|DM4PR11MB6334:EE_
x-ms-office365-filtering-correlation-id: ef554c10-4e1a-4ac9-58ea-08dbbeddf944
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cmUhOx/KXFMB1vGMqOooFXg55Algmu3Ez+QlevP0fxGlWD9aKsX36DTqnqRqetmrTBIUww81SuX4Fx2lMFZP+7hE5SSLaOBJruXwspGa3kIw6KKHT7ROUBcsicVvCrN49tMGChTcFdNa3RJ6ekGwfnQ/Ii22mzZKbHIB9YZ0j81FNol2gI6Pv02/yxIroV61W2D33YL+3rw32a7m075or512Cm6uvPVyV+xpd3IvJ+47aGvIJhZUxCOuV7qCx7nsyUJglL5327CB8X/p135e4tooyjq0oNxXw0gNIfxAx0txKpgAzY7xAjJpm8N1PIAVjBzqwjH6YguzwHHdEXM/1mlzY+Timv2VC1xskoGe6czhqBAXdb5mhsHrfvYJAorRQBrUwV17DIkKzrxl1qrAzM3hLGMF+du1IayMUVlDjHvrMnQrYnT+rDcnIkXba8SbyoxCCNEm+ZewJgI4q03le9wEO1cbJWS6am6coLiZdkcgFsUivK6kaqURYUN6QZ1taPT0+KYMG1pUtL7ukNRFlnrUdFl+RHKLquYyGppcff4IkstuRELfqbqUnuprcLW5UQ39n6gfQJdeeLBNOcCfSRu5iq6GpmC6Aq85lBHw+WfniVDYzcufF3TUP7CvECcI
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(39860400002)(346002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(55016003)(7696005)(6506007)(478600001)(71200400001)(38100700002)(82960400001)(122000001)(38070700005)(4744005)(7416002)(41300700001)(26005)(9686003)(2906002)(86362001)(33656002)(6636002)(66476007)(66446008)(5660300002)(8676002)(76116006)(66556008)(66946007)(54906003)(316002)(6862004)(52536014)(8936002)(4326008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UHd4SzdQRTltSGFDaVZmaGJvTmY5bGUyS3VSeFhIWVlJTmZwNmpjMFhwcmV2?=
 =?utf-8?B?dzRkUHdFQVFWOUF1am5aZHQ4Z3JsWVV5cWIzSThob1lsTmpwai9sR3loOStC?=
 =?utf-8?B?c0ZSc1daVGFRa1VqRTB6TkFQcnQxU0ZFS0hlSSs3M0x4R1FXcVBrLytBRFdU?=
 =?utf-8?B?S3hUL0JBRDlsd0d0aFhDNzRsMUZRQVZyVHlCdCtrWTZjc25DcU9zVDU5Vjlt?=
 =?utf-8?B?RVRvMFNPTW4wTjV5a1JrTHdBS2tQUm92Tmp1czNrbXI1aEp6SVY2R1dlZXJR?=
 =?utf-8?B?Z1Z4RFNXam12WkdqM0g5YkZraGZEbmlEMGxtSHZNVWdnVVo2bU1ickt1RzZ3?=
 =?utf-8?B?S3pqeFRnOEJsRURPOFNNYzV6VFFqYThjRGRGbG5tb0ZlcE5JY2FJTzc3QmdO?=
 =?utf-8?B?Ymw1QUNzeE1NVG5OM2x3d25PcVk2dyt4bUY1b2QwWlZrYXZaZ0R2OXV0S3Ra?=
 =?utf-8?B?WVR2YWY4OVVtR1RXdlZtSVkrTEVEZmU0Wk9WakVvbW96WE9SZkhzOURwcGc4?=
 =?utf-8?B?MkxtMG5UT2d6eGJKaGlENnRyYkpPaEdpU1UxMW9wcDZYSUs0Y2ZvSXU5SXlz?=
 =?utf-8?B?NHcxUWtmRDh0NmUzTFUrUEl6enZYTDFmejMvTkRRNHFTcEVBNExuUnlMRmwr?=
 =?utf-8?B?RE8zRm9ZdVdRQjk5TzF3V3Y4dWdsMCtVQmtBcUNQQjNuVVVOMDlpcHB0RUJ5?=
 =?utf-8?B?Nnpwd01XTDJHSTdPN1R2ajl6emhKNW5xdnZPRmV1a3RQbWNRajlqQTdYY0E1?=
 =?utf-8?B?U01waEh5SzgrcG1GNUhQWXo0Q3BGYlFIVTR1VmdBWFkyTHBSZ2xRUUhMRitQ?=
 =?utf-8?B?M0tnalJjekorc1IzTHZvWExzUWFDWTRaeDBkSjdMQmtneTVKQTVqK2tGZXYy?=
 =?utf-8?B?MUVNRkZFVVFmU3FlYklQYzNKdnUrc1QxRFpiZy81TjBneGpRT2VzS3dVcjd0?=
 =?utf-8?B?c0s3SzAydThwNjVjWU9wbk0yRU9PZGxQWWRFRUtYYitPbWdTUzJpdTZCMWRu?=
 =?utf-8?B?eUZsVlJ0YzlzRklvN2hua2ROMTlwSU5iSzNkdUtLcHFMSUFOMHRzNmduM1RI?=
 =?utf-8?B?UDRnRUFHejUyYVVEK0hwU3EyVE1SZjUxc3Q5ZmdqRHcyZmd3TlN0NFloTXdC?=
 =?utf-8?B?L29TWTlGZTBzM3N5Q2ZJakZGYlpJWlVYdHU3YXEwQ2ovREhOUlFUbVFLZHA2?=
 =?utf-8?B?SndMUWdJRWZhWWJqUm5IWVdNcGZOV1RGNzJuSTliUUlFWDRYTmRaRFVqY3Bj?=
 =?utf-8?B?V3hEc3l5ZVo0bE1zM3N3YVgvZHowbUxGcmttTTkwRldSNmpZUy9NUEJoVkJ2?=
 =?utf-8?B?czlzaGxLL2xlaWlXdm5CWmR5VmRHOTZHVlFEV2ZuVGVPbTJqbUlSbmhyT2V4?=
 =?utf-8?B?UVJQY0ZMZXhFZ0xtMUFKK0tTcHpCblcvRHNsK1ZneWlKZGVFV1ZwNnpZZ1NL?=
 =?utf-8?B?TGE1eXRmRkZzMzk3a0RjSkVocGZ0c29lSEpHR0d6Y2dmb3RWTSs4ODNHRS9H?=
 =?utf-8?B?K0ZualRJZ2w5Z0dRZFVscEJiRlB3eUVnWFNlK0xmNmRvblVISVVCcncrcC9t?=
 =?utf-8?B?UEs4SGdtR0paNDBDZTFmSzFKVkwyQWF1NGhubEhxZEk2V2JsY2Z6SmE5eFNP?=
 =?utf-8?B?VnhxbmdXV2JWUjBoa0ZrcytMemRKK0dXdGMwWEZKcGFnNnE3a1ZkaTZsUExE?=
 =?utf-8?B?YnFBV0J1YWgwNTNiQm4rSmIzdVRiejZlblJSNmU4QXFqbjE3WjBhS3VmeUJB?=
 =?utf-8?B?dUpDWnR5b0tWTlVENUg1WGRsbTgrUlR5WXJOL1UwUFFPbGJ1N1JHRmxXTTAw?=
 =?utf-8?B?eVBBd3E5OXJkUDl5NzVKWEg0c1FYb09FeWhFNGpGR0EzeEJVdnBrVjA4ZDRo?=
 =?utf-8?B?dnZQTk91d1RQdExZY2NOeHlDcVU4RG8rOFhEeDl3R3R0eTNNNDRGVTMrYmxq?=
 =?utf-8?B?aGZaeVVKcGJqKzdGQWQ0MzR1TFVPeUdobkcydXVoNTdPaVFnUkNjekZRK2Nz?=
 =?utf-8?B?VXlmRE0xNGxsZ0FYWDlQZHJrMC81Sll1dkpuem5vd3ZCcGtUUW1VeHNIUGFn?=
 =?utf-8?B?YkZnU25FU3hiNngycEdXaXJsTVdPWGxIU3BrMStISnFmQURyUTlxb0VMOGJs?=
 =?utf-8?Q?U+uuPBnTMTA91fYbSVeWxPnMk?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef554c10-4e1a-4ac9-58ea-08dbbeddf944
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Sep 2023 22:14:38.1949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wWIpLgi+83kzYQALr7JRC/VGa0mTFDZFqmx0zGSvJ4i85Hfi43q7DDRayoGdx66WBsGpY+Qj2XMC6UKbAmTj2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6334
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

PiA+IEJ1dCB0aGlzIHNlZW1zIGxpa2UgaXQgaXMgYSBsb3Qgb2YgY2h1cm4gdG8gYXZvaWQgaGF2
aW5nIHNlcGFyYXRlDQo+ID4gZnVuY3Rpb25zIHRvIHNlYXJjaCBjb250cm9sIGFuZCBtb25pdG9y
IGxpc3RzLiBFYWNoIGEgY2xvbmUgb2YNCj4gPiB0aGUgZXhpc3RpbmcgfjI0IGxpbmUgcmR0X2Zp
bmRfZG9tYWluKCkgd2l0aCBqdXN0IHRoZSB0eXBlIGNoYW5nZWQNCj4gPiBmb3IgdGhlIHJldHVy
biB2YWx1ZSBhbmQgdGhlIGxpc3QgdHJhdnNlcnNhbC4NCj4NCj4gWWVzLiBTb3JyeSwgSSBkaWQg
bm90IHJlYWxpemUgdGhpcyBpbXBsaWNhdGlvbiBkdXJpbmcgdGhlIGVhcmxpZXINCj4gZGlzY3Vz
c2lvbnMuDQo+DQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0aGluaz8NCj4gPg0KPg0KPiBJdCBzb3Vu
ZHMgdG8gbWUgYXMgdGhvdWdoIHlvdSBhcmUgYWR2b2NhdGluZyBmb3Igb3BlbiBjb2RpbmcNCj4g
cmR0X2ZpbmRfY3RybF9kb21haW4oKSBhbmQgcmR0X2ZpbmRfbW9uX2RvbWFpbigpPyBUaGF0IHNv
dW5kcyBnb29kDQo+IHRvIG1lLg0KDQpSZWluZXR0ZSwNCg0KV2hpbGUgdGhlcmUgaXMgc29tZSBj
aHVybiwgaXQgbWF5YmUgaXNuJ3QgYWxsIHRoYXQgYmFkLiAgSSBhbHNvIHJhbiB0aGUgb3Blbg0K
Y29kaW5nIGNhc2UgYW5kIGhhdmluZyBhIHBhaXIgb2YgMjQtbGluZSBmdW5jdGlvbnMgb25lIGFm
dGVyIHRoZSBvdGhlciB3aXRoDQpqdXN0IHR3byB0cml2aWFsIGxpbmVzIGNoYW5nZWQgYmV0d2Vl
biB0aGVtIGlzIHVubGlrZWx5IHRvIGdldCBwYXN0IHRoZSB4ODYNCm1haW50YWluZXJzIHdpdGhv
dXQgcnVubmluZyB0aGlzIHNhbWUgY29udmVyc2F0aW9uIGFnYWluLg0KDQotVG9ueQ0K
