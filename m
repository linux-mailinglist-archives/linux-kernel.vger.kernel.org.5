Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 633B679EDA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjIMPuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:50:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjIMPup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:50:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1EC1;
        Wed, 13 Sep 2023 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694620241; x=1726156241;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=s/GThrrS38ODFaqgFkp5l+ooqfkqDQHpUWh5u/78uYs=;
  b=hBPGpwr3De36fZky3by5B0jn0wMQz6HRXawoVFXnPslFjBPjMvUDx102
   QAzhedNdoMhU3i2OS9htU526IVmmhgGILI5Y+OfwhgYE08szmc67wFy5s
   Efv/gi0CGLvmfGO4Ro/rBPazv8UBCD3JV73WsvJYFaP2qoC1g1lH3U3Sb
   uZwY7+FdFhz27GunVMU988i41ioNulVPm/7om1LLzJ1bPEyzIhyDP+GnN
   MbliFR73rfe4gCRaufrYz2LMwiwztoSJuz34ULeS1o2HRIMECrXI0zdv4
   oh3uY3sizC9SV8/Mt/CBLZQepdPahmR+e1gs3P/S+D3gDLxhxQ6G5H2qH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="358968106"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="358968106"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 08:50:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="744167790"
X-IronPort-AV: E=Sophos;i="6.02,143,1688454000"; 
   d="scan'208";a="744167790"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 13 Sep 2023 08:50:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:50:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 13 Sep 2023 08:50:13 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 13 Sep 2023 08:50:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 13 Sep 2023 08:50:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FErUEGCsMxgq6/pegpE4q6K76mN+tAer5cdKQhYEwdSEERa+K/E5wAABUna/x+Vr6ukzim2nJ/qQKlqkod/vdkJB8K42X4G1ZBU4jc/CRIJj2cBytp2y3MJmdRMvGe5vxcsJTMw/0PRUzMURBw/b4yqp401J1fY2qZ6MBgoCVOKj5NsUh/woAu4+fbvQUdOn+L+4S0zhtvL3ka8Lglwek527tMdj5yAKAkVgLOKUH06OCs4pWsZbRK4cMeg0sUnR16d0mPc9Q9TCLA9RKbL69GMExVBn6wjSRJQw8NTQX31ijNzRgRPQOcasFvuLSgDWPWKWAXLxucVGP7JQNCj/lQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s/GThrrS38ODFaqgFkp5l+ooqfkqDQHpUWh5u/78uYs=;
 b=BiDsZ9zGOrxvGnPBfTZPdZrsvNQMYASk95vL8o+ZY8M4Nj0P3uGl5qBy9a6tbF5GmGG62MmuQOohJH2Ye+R3PQtF54mnYy1AVEqUMhlQGbfmqnvM7JXu67qPjwOv15joeeoFfEJ/NUUuIKx4Y3AC4k70U2ma/REXzUM5t2HteHEvmz/9he1itvczceeYW9+DJDjoaO5K3VuBv4zMGwXsleX7kTIG1ilt3DCcjlc8YAjuLx0ocys14fICMQiAay4k+tV0fB6WUiCaVky+RmvZCXmPWaDqCMvcDuLA1PYTqbXG+QsXdYJVXptnjJBv7hy42ZYliBIdEwVDMNUgKefGaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com (2603:10b6:a03:48a::9)
 by CY8PR11MB7315.namprd11.prod.outlook.com (2603:10b6:930:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.30; Wed, 13 Sep
 2023 15:50:12 +0000
Received: from SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4]) by SJ1PR11MB6083.namprd11.prod.outlook.com
 ([fe80::bbd6:576b:132:74e4%6]) with mapi id 15.20.6768.029; Wed, 13 Sep 2023
 15:50:12 +0000
From:   "Luck, Tony" <tony.luck@intel.com>
To:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@alien8.de>,
        Elliott Mitchell <ehem+xen@m5p.com>
CC:     "smita.koralahallichannabasappa@amd.com" 
        <smita.koralahallichannabasappa@amd.com>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "rric@kernel.org" <rric@kernel.org>,
        "james.morse@arm.com" <james.morse@arm.com>
Subject: RE: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Thread-Topic: [PATCH] Revert "EDAC/mce_amd: Do not load edac_mce_amd module on
 guests"
Thread-Index: AQHZ4gHSSeZV30FbCEm60ywcBMZ8pbAQTaKAgAiN0ACAABNOsA==
Date:   Wed, 13 Sep 2023 15:50:12 +0000
Message-ID: <SJ1PR11MB6083BDC4D10D139EF28E0058FCF0A@SJ1PR11MB6083.namprd11.prod.outlook.com>
References: <20210628172740.245689-1-Smita.KoralahalliChannabasappa@amd.com>
 <ZPqQEHXgmak1LMNh@mattapan.m5p.com>
 <20230908035911.GAZPqcD/EjfKZ0ISrZ@fat_crate.local>
 <40d3399a-b260-4ffa-a503-40c61468a189@amd.com>
In-Reply-To: <40d3399a-b260-4ffa-a503-40c61468a189@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ1PR11MB6083:EE_|CY8PR11MB7315:EE_
x-ms-office365-filtering-correlation-id: 1cbf4288-e90e-4377-685b-08dbb4711d67
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kuVStuOANwofl7nuLr5THZ0qfolJ2OXfH+iYVdsvoaHGX3ClaO4Y5xalkbK1wv59HeicILcBF5iDe8XnodW4r7WGFoorhoch5AwvFuHZ2B0oAlO9+7zAK0dZxSLVxI24w61HlrCrgQ2hp9Pcn6PT15nPnXIbHnEX+DBxpAlVLus8JxeJq0wrmh5EIQqNyypdFKs7IiqdMVIe9z7dFtgdVoYkwtOFi1DBKJ8//5ZsO1+Zkgo/00M0r3WF7i79hmlKZvP5zR5L4auo97AT0dIprflWh8p/+w+9xtfxGUGdlLHeeuYBq0qA9tP2f0AgoIXNUqZpEmTK70ymlODWEqTlRSD/4h5q42dnGI0vdMCniYPkz2LjCBAcddPpnMerI+33XIqV7iceeWIijVCUqmWSSw+Utv46lr+GmWmD8RAjoBnQqA3aeuNbP/k305EdocoviKnR65gBB9QOsvWdzj23Dr3C9ghVlEUYavFHdZZec5mWav3HW/eJsKLAJcJHTJxwIUGhAPcgEjPoWvag99P88FOcb4nfp0+Ik3oLQGyYDkiXevwgV7dvdOoBJv9o4dTGyqgKS9hTENimHNKEW1IxMsmDe8NyAxhcmS+cS/Wo36k+neDjHWOoiRalQkjM0sXd
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR11MB6083.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(346002)(396003)(136003)(366004)(186009)(451199024)(1800799009)(5660300002)(26005)(52536014)(8676002)(8936002)(4326008)(2906002)(33656002)(7416002)(83380400001)(86362001)(38100700002)(4744005)(82960400001)(55016003)(122000001)(38070700005)(66946007)(66476007)(54906003)(66556008)(110136005)(66446008)(316002)(71200400001)(64756008)(76116006)(41300700001)(7696005)(478600001)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q2tuRFRKSHFML09lSmJyajZIRkUrVUNwSDkzV3FlRlFQUnkzZFZLcXBrdDk4?=
 =?utf-8?B?RStKWURGOHZrdDFmSFdkTDlLRU9Helk1OTBpR25sSXVDTzFIaVExNktuSjcy?=
 =?utf-8?B?bWdjQzhUa2RuTTkzTjIxZlUwL21oYW4vUjFmN1J4b05ERE9VWmxpVlZDL1pv?=
 =?utf-8?B?S2VJM1NsazlpSE5wSEVaMEhFTGJpRFUvVU9sMFFEZkg2WVlITUZYdG1nUWoy?=
 =?utf-8?B?bzNxOWR0R3IzdmNyandySmg1VzN6NVZRQVZnY1lRSW51UENyY1diU29CWlVm?=
 =?utf-8?B?UHI3Z29NTzVUVHlwekN2OUwrUllSQWp0QmpkcUMzUWJVNW5SMHZmN0J5TlA2?=
 =?utf-8?B?TnNXWXp2dUNhWWdtL2FURFdMeFBVRDhRWitOZzkvVEg4T1dCZnMrMmUxQU5E?=
 =?utf-8?B?VmZ2S2d5VTZ3YjVmRkFTOTdFRnppcTBqMEc4VmlHaXB3dzhZa0wxb1czQzJQ?=
 =?utf-8?B?ZlBhRzB3M2lMTTdFSlRmTFZxZ2JYZ05qbDJPVzA3Z1YxUmdZVjh4eUQ5U1RZ?=
 =?utf-8?B?UDk5MHcwMDZsamY3WCtETitrbEs3alJjaTlUaFpMWTJ2QVFsSURtVVNZa2pL?=
 =?utf-8?B?N2FwOVFDNGR3UkVSN0lNTGtQVDhvaHluZGFvL0hUQ0ovVk5qY3M1czduclNG?=
 =?utf-8?B?cm1UbFNOa3JIMno2TEFwYnZ2RUowQnNISVFWUkFMa0Y1TGJzNDZKcU9jMjMv?=
 =?utf-8?B?ZDF0VE1BNVFiWHliOHZKVEdWbnZrcThIWXM4WlpjWW9CU2NWL0RhUC9NYjkv?=
 =?utf-8?B?SDNEd1VWTnAzbjZvZzlEZ29BMGVkZmtFcDRwWkNEcVNHZHBlYjd5VWdmUk5o?=
 =?utf-8?B?ZUxQaXhpbVJncTk4QURpcE92YVdEcTNMdEpLNFJpVUsxTTl5bG9tS1Z6ZTJS?=
 =?utf-8?B?SmNXbUhPdGduSWtUOVRGeFU3YmlOamlHd2xrQkY4bTVTUk0zVzZNZ1V6U0di?=
 =?utf-8?B?aGlKZmhyVTd3bVZkS2hHeEs4UXZSTXZXeWxVRnFsVCtyMHFVVWd6aWU4Nlll?=
 =?utf-8?B?NytoRjZzNm5PQUJkT0VTWW9FZ3pQUTVSSTU1VDRCcEVYOU5lQ0p4V0JybXd5?=
 =?utf-8?B?YUZlbjh2WS81d1lXT3I2V2wzRFByRmlJb051NzlyVWNmL1ZnUUE0dkppbzBw?=
 =?utf-8?B?ZDgrcUw5REpVaWdDZmV4RGVna2pPZjFJRDlSV0FFWmdrV2xOYU9MdDV1TUVt?=
 =?utf-8?B?Q0VaKzdITjZWMGpoK0pUZWF2MXA4VGo4UmhXWmhIRVozS1l0bXVNejlqY0ow?=
 =?utf-8?B?U2lwdGdpYXdZNm5LTVNEd0k4akhHNVRpZzBDRURvdnk0ZVZ1NEcxSDQzSWRO?=
 =?utf-8?B?T3R6aEJDcE9vMFJRaDRFQXpiNS95ajYrQmpTb1dHUmRUR1dSUEpDdXNrZlBL?=
 =?utf-8?B?VWg1R2FKRWc0WnFYOVpwQzZCdzhWTEtJREtZRTVyV3M2dVNNa1hHcW15R2xh?=
 =?utf-8?B?bVB3TEFMQ0lHanNKVTV2VzV5YWxEUUt0SEVEZTQ5eVdHRXBUSDlHTCsrdVRr?=
 =?utf-8?B?R1hkQWUwWFFrU1ZCeWZyODNUTnRFam1JMlF1RkZZNFRjejZwdFdGUW9YdGwy?=
 =?utf-8?B?VS8vTm1LWnRCR2dWV2FxT0dEL041bDA3UWd5Uy8rZW1RK0NhcXBPQitreWx4?=
 =?utf-8?B?ZVlwTTFneW9vRjFKRHZUaGRBLyt2WnkwQ3ZZZEZ2YU4wNzVFeW1HbSttTHAz?=
 =?utf-8?B?SEVNN0NYQjRVRStJYi9RL0NuV3BpSUlWbU1sUVZxZ3ByczlzaEl1cjVqMm9k?=
 =?utf-8?B?NFBHTzh4djFHZDRucXZWbE1OR0pUNUFYV2tDRUltNXJkTlNkdEFYUFRDeHFC?=
 =?utf-8?B?Zi9BcGp2U0krbHcwNGtkOVI1KzhicnVTMXo0aDJKOVladlBKYjZCMFg5MFFP?=
 =?utf-8?B?Wi9uc1hEeTFvRU5JcFl5aVJHb05wUUxIZVllVUthaFNmbEQrV1U2elExMDR3?=
 =?utf-8?B?eEhMTklmbExobExTRHlvQ0JPT0pBN01hYXpOSnVHOWtpQUtpYnlqRjVtU0ln?=
 =?utf-8?B?WGRWK0g5ODZqVTlCMGpvQlQ5anowTEYyeU16L0tLZlI2TFNXRFNMcHgzSHUx?=
 =?utf-8?B?UTBlZEMvbFZyQzFwa3ZtZEhxZmtJTTNPejlVczRzazhrQVBNMmRsUWZLV2pp?=
 =?utf-8?Q?CUeZT02twdvJqfYb0+m3t1QyV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR11MB6083.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cbf4288-e90e-4377-685b-08dbb4711d67
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2023 15:50:12.0558
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L7p97N/Do5zP8eD9PWhVo8V0hKIaSwWrLvK/HNN5zwnTU0no4tUn6cJHiXSAtCHD7QAIPvC3omZgJGe/mZX0Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7315
X-OriginatorOrg: intel.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiBBbHNvLCBwbGVhc2Ugbm90ZSB0aGF0IHRoZSBFREFDIG1vZHVsZXMgZG9uJ3QgaGFuZGxlIE1D
RSBldmVudHMNCj4gZGlyZWN0bHkuIFRoZXkgYWN0IG9uIGluZm9ybWF0aW9uIHBhc3NlZCBmcm9t
IHRoZSBNQ0Ugc3Vic3lzdGVtLg0KPg0KPiBGdXJ0aGVybW9yZSwgdGhlcmUgYXJlIG90aGVyIEVE
QUMgbW9kdWxlcyB0aGF0IGhhdmUgdGhlIHNhbWUgIWh5cGVydmlzb3INCj4gY2hlY2ssIHNvIHdo
eSBjaGFuZ2Ugb25seSB0aGlzIG9uZT8NCg0KVGhlIG9sZGVyIEludGVsIEVEQUMgZHJpdmVycyB0
cmFuc2xhdGVkIHN5c3RlbSBwaHlzaWNhbCBhZGRyZXNzZXMgdG8gRElNTQ0KYWRkcmVzc2VzIGJ5
IGRpZ2dpbmcgYXJvdW5kIGluIHRoZSBDT05GSUcgYW5kIE1NSU8gc3BhY2Ugb2YgdGhlIG1lbW9y
eQ0KY29udHJvbGxlciBkZXZpY2VzLiBJdCB3b3VsZCBzZWVtIHVud2lzZSBmb3IgYSBWTU0gdG8g
Z2l2ZSBhY2Nlc3MgdG8gdGhvc2UNCmFkZHJlc3NlcyB0byBhIGd1ZXN0IChpbiBnZW5lcmFsIC4u
LiBwZXJoYXBzIE9LIGZvciBhIFhlbiBzdHlsZSAiRE9NMCIgZ3Vlc3QgdGhhdCBpcw0KaGFuZGxp
bmcgbWFueSB0YXNrcyBmb3IgdGhlIFZNTT8pLg0KDQpXaGF0IHN5c3RlbSByZXNvdXJjZXMgZG8g
QU1EIEVEQUMgZHJpdmVycyBuZWVkIGFjY2VzcyB0bz8gQ291bGQgdGhleQ0Kd29yayBpbnNpZGUg
YSBndWVzdD8NCg0KLVRvbnkNCg0KDQo=
