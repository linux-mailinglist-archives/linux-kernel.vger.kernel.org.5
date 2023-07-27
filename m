Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA6807646EF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 08:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjG0GgS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 02:36:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbjG0GgD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 02:36:03 -0400
Received: from mgamail.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D2C1271E;
        Wed, 26 Jul 2023 23:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690439739; x=1721975739;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jgh0k+DTCfdSUB5gseDi4CihiguaODzesDOBZ39P/nI=;
  b=gy+uYXs9J8yGEf5MOcZ4mj4bOcL2anOWAnLwwfByuqiw/N+VhiHa/0+s
   59GFtE0JFj0IgJO75sPHkOnnKlwNcW1bYZYoT2Mo65Yaf7h3KDz891Cni
   FNfQexUrQddR178mUAeSyNIk30y74O7FmEKBP3+yDO5TIJgKZ0zZOcdw6
   tRpmSj/wnNfCDaPKvoqdR791x7VbQbuejgEQV/R2mRhkh2X+9tTame9UP
   e/aK+B3HUNBhIjJEdEIXQ5UBY8cpiyb+t1dbh3lyhmZelie0ZyJye3mmA
   wKow2TPxanJznFjmEr4qTGIByy/cdYvcXE9PePWXxdm+j36iSarQd55Nu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="347828842"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="347828842"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 23:35:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="704067439"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="704067439"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orsmga006.jf.intel.com with ESMTP; 26 Jul 2023 23:32:42 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 23:32:42 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 26 Jul 2023 23:32:42 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 26 Jul 2023 23:32:42 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 26 Jul 2023 23:32:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MhkeBZWbxUoxoNaIf33yvJyDJgIa+Tetzw8kaSUF8hUzonW6DYFETcXYRMgES8qwmDAfMQNk2pODLtqw7VjOp6sfCPOsXADG74QVOEwL/WfEitDrd+5OWaFJfS9S2t1OOoq+8mcgKLzT9hjAbD6eyI/9//x0AIf3K50jri/HpZJNmfRW8bKKwORoAuSnC8OwRAVXGdI+CzOnemODsc6XYpuKuaJh9xh4+nk6CLfvIsLGJwZ2OFTjG+MZcIm3oW7alEiG2PRKNY55LIn6S+RaaCx70Q3jA1gSzUM1gJrCGEKGLieZ8fPwPfEKzDXwg9cMlEKJy4NyN+w/R8drQR0WyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jgh0k+DTCfdSUB5gseDi4CihiguaODzesDOBZ39P/nI=;
 b=gEgZltcAKpzE0LNKwnF/WXdT+rCKi39V19mXjfqqMhGUV5FcaeMyhxGZaM1olxs/57NOiNCBew4oeesA7RUfH6FGQ+NHpZe6Fzy2/o0x/ndKXU7OcIh7kEUB2quWqArN4ITvn2INhR318uH6dstVTwpefMp9CJgCXcdY/WCKI734RHmfEssxrD/j7IkRgtyuciSJTaPHfgEQPLjl8PKKPxtLhdh26v/zY9AEMcPuIZ6LwxB9Ifg2ZDNw/+Wu+W2IJ+pTKaClRhuDy4DJmwsD53QfIIEJZ3/xFwjBd4CBhLgyQ9D/Crnkk5u9ntuAz6MuxIsUbAO0oSBLzOT0vSGqMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN2PR11MB4093.namprd11.prod.outlook.com (2603:10b6:208:13f::21)
 by SN7PR11MB6601.namprd11.prod.outlook.com (2603:10b6:806:273::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Thu, 27 Jul
 2023 06:32:40 +0000
Received: from MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::63d1:e2f7:dd1f:c047]) by MN2PR11MB4093.namprd11.prod.outlook.com
 ([fe80::63d1:e2f7:dd1f:c047%7]) with mapi id 15.20.6631.026; Thu, 27 Jul 2023
 06:32:40 +0000
From:   "Winkler, Tomas" <tomas.winkler@intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>
CC:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: RE: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Topic: [PATCH 1/2] mtd: use refcount to prevent corruption
Thread-Index: AQHZo3n2K/1+vgQRck+hqhi6hZ+dTK+5lImAgAGKEwCAAPgPAIAAeEAAgAxyZYCAAAIMAIAAA7kAgAGfBwCAArd3AIAAAwmg
Date:   Thu, 27 Jul 2023 06:32:39 +0000
Message-ID: <MN2PR11MB40937D15FE4076D5F73570B5E501A@MN2PR11MB4093.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230716153926.5e975231@xps-13>
        <CY5PR11MB6366C254F767B6C432C98A0CED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <20230724135118.54e39faf@xps-13>
        <CY5PR11MB6366FB890508D05E1D1C1375ED02A@CY5PR11MB6366.namprd11.prod.outlook.com>
        <CY5PR11MB636670FCA46F7F68F21AF44BED03A@CY5PR11MB6366.namprd11.prod.outlook.com>
 <20230727081914.03e44b96@xps-13>
In-Reply-To: <20230727081914.03e44b96@xps-13>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR11MB4093:EE_|SN7PR11MB6601:EE_
x-ms-office365-filtering-correlation-id: 5b1007fd-bad8-4b40-1689-08db8e6b4687
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xzb8F4UX0KIN6jVaosdUf+lAh4f/cmthixQqGy+PRsKRCHBddH4b8/0hhLtUmvP8rsws8pzM35Tkw31dusMzf4e7CifqYekHpzRzxIRcZuWC26i2N3B3DIw4c7dHwfUl16k8dalMx8CGE9UhN+eI6ndLxYDbiS5Bj4r/zhglyopag5DEG0K0SD8oHmpJm2klvSvkMglMFP6dYWoVtiwVAQP4pcpo4lwZeWVw2Id0LtB/GMCzvewdJdFKrlgVicF/YA6rFDcBuy7c+lIMkDeAPR47/ZgmClZ4SbwCLz/C6am32JAvDHSAnXRphL8ThmAXpGl5LgnR7HDgIIfOYRri25Y7waS1VAc7uzKhnK3YvJuIoB1tShrVxu1ZpFX7ODNVqnwk4SKMlTGQi/cwGEBW0hu1oI2og4RrheyxLa0Er1i5u1tJj3xzwF0mqTwOi6r5aYeSrxubMPf85dPL7FxRFhzUU+mAf/szfOY6GLTBK/Gm3JGVvO4R+YBM0ilzpIoQ5PEnIFSr+K3+Z9DN7mSzISVtbpmkZzqzajrloayf7UIxkaYNPt8NCwlREb/7GOeUEw6SerWLI/jTgOkiB6J+/4V7y3l/7yE10rcFLeLFAK4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4093.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(396003)(376002)(136003)(366004)(39860400002)(451199021)(26005)(6506007)(55016003)(186003)(66574015)(83380400001)(71200400001)(82960400001)(478600001)(122000001)(54906003)(110136005)(86362001)(33656002)(7696005)(4326008)(316002)(8676002)(66556008)(66446008)(64756008)(66946007)(2906002)(8936002)(6636002)(66476007)(7416002)(38100700002)(52536014)(41300700001)(5660300002)(76116006)(38070700005)(9686003)(966005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dC9HR1VieGNVcnhLbU1VS3IwVDI0bmluTm9ueW5MeEhCZnVROHB5UkhoQS85?=
 =?utf-8?B?RWhneEl4dUpBZERNaVp5UU9FL1pSS0NrRTdmVmpWQkgrWi9jSklzQm04NCs2?=
 =?utf-8?B?R09ic2R2WjVndERFTTA1Wm9BL0UwdUc2Q1BDV2o3MkpNSFJUeHI1eEZVbEJK?=
 =?utf-8?B?UmhvWUhFdldoWlFSVzdlYmdZbFkzaVFzVGtDVG5hc0Rtd3l5VkFPTC9DYk0v?=
 =?utf-8?B?bkdNajJta0dxZ1hPTFQxcXlvZzcxSmFqQUllUng5T09ibWpsM2NUVWRFMWtH?=
 =?utf-8?B?dVFDWkV5NzBXdnlqckc0NXhXRi84YjZDK01qTjFqRGIzcFJwd1Z1U245cU5q?=
 =?utf-8?B?emhPd0ZpQVlpVE81RVVUL2J4a1BLNW1Ec29EaXZ2VXhRT2ZZcUI1cEJEYlk2?=
 =?utf-8?B?djhaa2F5WGJTRVd5NWFEU0RYYVc0eVlxMEJ1NTM0VGJXQnhYVWxkMUxPVk5l?=
 =?utf-8?B?YzlNNHdkUEZyV3hvdDdydmdlYURadjZkTnlLb2FjTG85ZUpTdG1TUjNpTXlr?=
 =?utf-8?B?OGZWckpzMUxiTkNFd2JrR1pYT04zZUR1OWZ5Sm9zZ2g3ZjFOUCtjQmg0Wm9T?=
 =?utf-8?B?SXppL3VYM3ljbS8xazVsK1A4R09JWCtpMUVLUlZ1UHNNSlBzdkNtUDQvTEVD?=
 =?utf-8?B?UFlnZ3haNGtvaGVqVUFFOFhhRU9mZlRnMnpuQk1KTnl2N0JoTXh3amlsQW1G?=
 =?utf-8?B?V0dFT1pyUlNHNmcrWEV4QVkzNTk5YTRZMStrc1phOHdPeG1Ha0plQm5leWlJ?=
 =?utf-8?B?Z3AwZ3VaZ3hsZnEyaks2NVJQUmlwOGROQmovbTNzdkhkZktOOEFrV1JHVHFz?=
 =?utf-8?B?b01xU0Zhc3l4UHdjN0ZCK2NSbnJYdktMdWdqUC9MbDdyZm1UbVZXRXRiK09Y?=
 =?utf-8?B?Z3FUK1JzNlRuVGhGcTBlMy9jV1FaQTAyZk5LYVNlRmVoUytDVkhJb1ZITm5X?=
 =?utf-8?B?dXl6M3lHYklXUzJvNzIwWmp0Y3hwYk11TnVjNm9OT1FTbFM1QzJaMlZUa0l6?=
 =?utf-8?B?U3pnRGNPL2ZqYVgzZ1RkUkFDMzdGMVAxNEF2MzRxRVJiVGFXdlhrTzJnUWZ5?=
 =?utf-8?B?KytEWEVSTnFXZ1JsdlY1VG43dG9ZUmRRUk45dGJBNjdmNlBFWGc2YXlaSGZZ?=
 =?utf-8?B?anhOU3QzUDU4dzZLYnR5MU9VclU4ZUIrMUlEU2dhZ2F4SkhrMEVtVG9KMWIr?=
 =?utf-8?B?Slh5MjFkQlRGU3NlWUxMWlBmUmpIMHl6NTliRGNSaUpsWXk4c3BFc01HakJU?=
 =?utf-8?B?N3cxeGNiSWVTMU43a3JEcnFlZnVTcXVBSGhyckJKc0RjUCtScUV6RGc1UEgx?=
 =?utf-8?B?dGxob2VYRExQVU5FR096OE1TdzE2bWNQNDhnUWpEMXhEOGhpZmZZZGdqdjFC?=
 =?utf-8?B?dEVQdVNpTHZXa29DT0NKdVVzMjF3aXZwa2wxY0h3empjeU03aXJpcENCdmpD?=
 =?utf-8?B?OEZTN0xzZHJHamV2WjFkd1g3MnNGMUs1MGJURVkwcVVNbGFnakg2bmlncU5z?=
 =?utf-8?B?OW9JYkpNSCtXUkZWSC9SUjhxMG9CY0RLREVucDB6VUxqN1M3QW5HbWQ2SytR?=
 =?utf-8?B?MEJrL0Z6VXBnT2QzL3RqNUpxYU51V1VEbUZUZVdQUGdydG1CcW5jUWZ2NllG?=
 =?utf-8?B?S0RBc0xMczZBaml0dnJpWG5NNGt0SHhNS1NzK1FEVlRURndLWW9ieGFXRXB0?=
 =?utf-8?B?VmhNYXNKTnJRL0QzdGVIRTZ5bnBQdDJrNEVzTGtFNWE2cFNMQTk4bzhXclNW?=
 =?utf-8?B?U1NLcDRyc005LzFtRHlSczRMdlNGSDZSeHd2amhEb0c0R2tWZWFsRm5BZnVl?=
 =?utf-8?B?MWh2OTE0dFZKNFhRbWplbWhJU2svZFFaZWJMZXMzbVdrcHdTZ1VqY2p2MVph?=
 =?utf-8?B?R0VweUVlcXBjNnYxdzVxcUtOd2tpWGwyb3Z1THhqeWpyaFVWNFhMNTJ1Nzd3?=
 =?utf-8?B?cElwVjd1MVZvNlNQRVJxZ3ExSjV2dmJhbS91RW1jQ01yd3l5Y0JQdkg1ZEZn?=
 =?utf-8?B?akgrTTVBdEdyQWN5YXdHUGpveDhXOE5GNEszMWhTMVkyZCsxQVhsUjJ3VmRD?=
 =?utf-8?B?OEFnUWdKSHlwMUVHaTF6Y2NYU210UG5qY3VoV2lqcStnbkFDdzE4YmxaemZr?=
 =?utf-8?Q?loBHxKv67vBFRw/cjEU2E6Vus?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4093.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1007fd-bad8-4b40-1689-08db8e6b4687
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2023 06:32:39.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4uW1gDYckwPAv5mHpL/DDfr6SprUCdEj2p1p0WeJ7uGl+mOS+Pg5tiAhzebzd0pGrZ/S5hPNWsePA4onmjm27g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6601
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

PiANCj4gSGkgQWxleGFuZGVyLA0KPiANCj4gYWxleGFuZGVyLnVzeXNraW5AaW50ZWwuY29tIHdy
b3RlIG9uIFR1ZSwgMjUgSnVsIDIwMjMgMTI6NTA6MDQgKzAwMDA6DQo+IA0KPiA+IEhpDQo+ID4g
Pg0KPiA+ID4gSGkgTWlxdWVsLA0KPiA+ID4gPg0KPiA+ID4gPiBIaSBBbGV4YW5kZXIsDQo+ID4g
PiA+DQo+ID4gPiA+IGFsZXhhbmRlci51c3lza2luQGludGVsLmNvbSB3cm90ZSBvbiBNb24sIDI0
IEp1bCAyMDIzIDExOjQzOjU5DQo+ICswMDAwOg0KPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+ID4g
V2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIHdoZW4gSSBsb2FkIHVwIHRoZSBtb2R1bGUsIEkNCj4g
PiA+ID4gPiA+ID4gPiA+IGdldCB0aGUgc2FtZSAzDQo+ID4gPiA+ID4gPiA+ID4gPiBkZXZpY2Vz
Og0KPiA+ID4gPiA+ID4gPiA+ID4gL2Rldi9tdGQwDQo+ID4gPiA+ID4gPiA+ID4gPiAvZGV2L210
ZDBybw0KPiA+ID4gPiA+ID4gPiA+ID4gL2Rldi9tdGRibG9jazANCj4gPiA+ID4gPiA+ID4gPiA+
DQo+ID4gPiA+ID4gPiA+ID4gPiBVcG9uIHJlbW92YWwsIHRoZSBiZWxvdyAyIGRldmljZXMgc3Rp
bGwgaGFuZyBhcm91bmQ6DQo+ID4gPiA+ID4gPiA+ID4gPiAvZGV2L210ZDANCj4gPiA+ID4gPiA+
ID4gPiA+IC9kZXYvbXRkMHJvDQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gT3VyIHVz
ZS1jYXNlIGRvIG5vdCBwcm9kdWNlIG10ZGJsb2NrLCBtYXliZSB0aGVyZSBhcmUgc29tZQ0KPiA+
ID4gPiBpbWJhbGFuY2VzDQo+ID4gPiA+ID4gPiBvZiBnZXQvcHV0Pw0KPiA+ID4gPiA+ID4gPiBJ
IGhhdmUgc29tZXdoZXJlIHZlcnNpb24gd2l0aCBwcl9kZWJ1ZyBhZnRlciBldmVyeQ0KPiA+ID4g
PiA+ID4gPiBrcmVmX2dldC9wdXQuIFRoYXQNCj4gPiA+ID4gbWF5DQo+ID4gPiA+ID4gPiBoZWxw
IHRvIGNhdGNoIHdoZXJlDQo+ID4gPiA+ID4gPiA+IGl0IG1pc3NlZCwgSSBob3BlLg0KPiA+ID4g
PiA+ID4NCj4gPiA+ID4gPiA+IEkgYmVsaWV2ZSBtdGRibG9jayBpcyB0aGUgZ29vZCBjaXRpemVu
IGhlcmUuIEp1c3QgZGlzYWJsZQ0KPiA+ID4gPiA+ID4gQ09ORklHX01URF9CTE9DSyBmcm9tIHlv
dXIgY29uZmlndXJhdGlvbiBhbmQgeW91IHdpbGwgbGlrZWx5DQo+ID4gPiA+ID4gPiBvYnNlcnZl
IHRoZSBzYW1lIGlzc3VlLCBqdXN0IGEgYml0IG5hcnJvd2VkLCBwZXJoYXBzLiBJbmRlZWQsDQo+
ID4gPiA+ID4gPiBpZiB5b3UgbWFuYWdlIHRvIGZvbGxvdyBhbGwgdGhlIGdldC9wdXQgY2FsbHMg
aXQgY2FuIGhlbHAgdG8gZmluZCBhbg0KPiBpbWJhbGFuY2UuDQo+ID4gPiA+ID4gPg0KPiA+ID4g
PiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4gTWlxdcOobA0KPiA+ID4gPiA+DQo+ID4gPiA+ID4g
TWlxdWVsLCBkbyB5b3UgaGF2ZSBDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUiBzZXQgaW4g
eW91cg0KPiA+ID4gPiBjb25maWc/DQo+ID4gPiA+DQo+ID4gPiA+IE5vdCBzdXJlIEkgZ2V0IHlv
dXIgcXVlc3Rpb24uIFlvdSBjYW4gZW5hYmxlIG9yIGRpc2FibGUgaXQsIGl0DQo+ID4gPiA+IHNo
b3VsZCB3b3JrIGluIGJvdGggY2FzZXMgKHlldCwgdGhlIGhhbmRsaW5nIGlzIG9mIGNvdXJzZSBh
IGJpdA0KPiA+ID4gPiBkaWZmZXJlbnQgYXMgdGhlIHRvcCBsZXZlbCBkZXZpY2Ugd2lsbCBiZSBy
ZXRhaW5lZC9ub3QgcmV0YWluZWQpLg0KPiA+ID4gPg0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+
IE1pcXXDqGwNCj4gPiA+DQo+ID4gPiBJJ20gdHJ5aW5nIHRvIHVuZGVyc3RhbmQgd2h5IEkgY2Fu
J3QgcmVwcm9kdWNlIHRoZSBwcm9ibGVtIGluIG15DQo+IHNjZW5hcmlvLg0KPiA+ID4gSSBmb3Vu
ZCBhbiBpbXBvcnRhbnQgZGlmZmVyZW5jZSBpbiB1cHN0cmVhbWVkIHBhdGNoIGFuZCBpbnRlcm5h
bCB2ZXJzaW9uOg0KPiA+ID4gVGhlIElTX0VOQUJMRUQoQ09ORklHX01URF9QQVJUSVRJT05FRF9N
QVNURVIpIGNoZWNrIGFyb3VuZA0KPiA+ID4ga3JlZl9nZXQvcHV0IGRvZXMgbm90IGV4aXN0cyBp
biB0aGUgaW50ZXJuYWwgdHJlZS4NCj4gPiA+IFRoZSBjb2RlIGJlZm9yZSBteSBwYXRjaCBkbyBu
b3QgaGF2ZSBzdWNoIGNoZWNrLCBzbyBJIHRlbmQgdG8gYXNzdW1lDQo+ID4gPiB0aGF0IHRoaXMg
Y2hlY2sgc2hvdWxkIGJlIHJlbW92ZWQuDQo+ID4gPiBJZiB5b3UgcmVwcm9kdWNlIGhhcHBlbnMg
d2l0aCBDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUg0KPiBkaXNhYmxlZA0KPiA+ID4gdGhh
dCBtYXkgZXhwbGFpbiBwcm9ibGVtcyB0aGF0IHlvdSBzZWUuDQo+ID4gPg0KPiA+ID4gLS0NCj4g
PiA+IFRoYW5rcywNCj4gPiA+IFNhc2hhDQo+ID4gPg0KPiA+DQo+ID4gSSd2ZSB0cmllZCB0byBy
ZXByb2R1Y2UgdGhpcyB3aXRoIGxhdGVzdCBMaW51eCA2LjUtcmMxIGFuZCBteSB0d28gcGF0Y2hl
cy4NCj4gPiBUaGUgbWFudWFsIG1vZHByb2JlIG10ZGJsb2NrIGNyZWF0ZXMgbXRkYmxvY2swIG92
ZXIgbXkgcGFydGl0aW9ucyB0b28uDQo+ID4gSSBjYW4ndCByZXByb2R1Y2UgcHJvYmxlbSBuZWl0
aGVyIHdpdGggTVREX1BBUlRJVElPTkVEX01BU1RFUiBub3INCj4gd2l0aG91dC4NCj4gPg0KPiA+
IExldCdzIHRyeSB0byBkZWJ1ZyBvbiB5b3VyIHN5c3RlbSwgY2FuIHlvdSBlbmFibGUgZHluYW1p
YyBkZWJ1ZyBmb3INCj4gPiBtdGQgc3Vic3lzdGVtLCByZXByb2R1Y2UgYW5kIHB1Ymxpc2ggZG1l
c2c/DQo+ID4NCj4gPiBUaGUgcHJpbnRzIGZvciBrcmVmIGdldC9wdXQgY2FuIGJlIGFkZGVkIGFz
IGJlbG93Og0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL210ZGNvcmUuYyBiL2Ry
aXZlcnMvbXRkL210ZGNvcmUuYyBpbmRleA0KPiA+IDI0NjZlYTQ2NjQ2Ni4uMzc0ODM1ODMxNDI4
IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbXRkL210ZGNvcmUuYw0KPiA+ICsrKyBiL2RyaXZl
cnMvbXRkL210ZGNvcmUuYw0KPiA+IEBAIC0xMjQyLDEwICsxMjQyLDEzIEBAIGludCBfX2dldF9t
dGRfZGV2aWNlKHN0cnVjdCBtdGRfaW5mbyAqbXRkKQ0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4g
ICAgICAgICBrcmVmX2dldCgmbXRkLT5yZWZjbnQpOw0KPiA+ICsgICAgICAgcHJfZGVidWcoImdl
dCBtdGQgJXMgJWRcbiIsIG10ZC0+bmFtZSwNCj4gPiArIGtyZWZfcmVhZCgmbXRkLT5yZWZjbnQp
KTsNCj4gPg0KPiA+ICAgICAgICAgd2hpbGUgKG10ZC0+cGFyZW50KSB7DQo+ID4gLSAgICAgICAg
ICAgICAgIGlmIChJU19FTkFCTEVEKENPTkZJR19NVERfUEFSVElUSU9ORURfTUFTVEVSKSB8fCBt
dGQtDQo+ID5wYXJlbnQgIT0gbWFzdGVyKQ0KPiA+ICsgICAgICAgICAgICAgICBpZiAoSVNfRU5B
QkxFRChDT05GSUdfTVREX1BBUlRJVElPTkVEX01BU1RFUikgfHwNCj4gPiArIG10ZC0+cGFyZW50
ICE9IG1hc3Rlcikgew0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIGtyZWZfZ2V0KCZtdGQt
PnBhcmVudC0+cmVmY250KTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICBwcl9kZWJ1Zygi
Z2V0IG10ZCAlcyAlZFxuIiwgbXRkLT5wYXJlbnQtPm5hbWUsDQo+IGtyZWZfcmVhZCgmbXRkLT5w
YXJlbnQtPnJlZmNudCkpOw0KPiA+ICsgICAgICAgICAgICAgICB9DQo+ID4gICAgICAgICAgICAg
ICAgIG10ZCA9IG10ZC0+cGFyZW50Ow0KPiA+ICAgICAgICAgfQ0KPiA+DQo+ID4gQEAgLTEzMzUs
MTIgKzEzMzgsMTUgQEAgdm9pZCBfX3B1dF9tdGRfZGV2aWNlKHN0cnVjdCBtdGRfaW5mbw0KPiAq
bXRkKQ0KPiA+ICAgICAgICAgd2hpbGUgKG10ZCAhPSBtYXN0ZXIpIHsNCj4gPiAgICAgICAgICAg
ICAgICAgc3RydWN0IG10ZF9pbmZvICpwYXJlbnQgPSBtdGQtPnBhcmVudDsNCj4gPg0KPiA+ICsg
ICAgICAgICAgICAgICBwcl9kZWJ1ZygicHV0IG10ZCAlcyAlZFxuIiwgbXRkLT5uYW1lLA0KPiA+
ICsga3JlZl9yZWFkKCZtdGQtPnJlZmNudCkpOw0KPiA+ICAgICAgICAgICAgICAgICBrcmVmX3B1
dCgmbXRkLT5yZWZjbnQsIG10ZF9kZXZpY2VfcmVsZWFzZSk7DQo+ID4gICAgICAgICAgICAgICAg
IG10ZCA9IHBhcmVudDsNCj4gPiAgICAgICAgIH0NCj4gPg0KPiA+IC0gICAgICAgaWYgKElTX0VO
QUJMRUQoQ09ORklHX01URF9QQVJUSVRJT05FRF9NQVNURVIpKQ0KPiA+ICsgICAgICAgaWYgKElT
X0VOQUJMRUQoQ09ORklHX01URF9QQVJUSVRJT05FRF9NQVNURVIpKSB7DQo+ID4gKyAgICAgICAg
ICAgICAgIHByX2RlYnVnKCJwdXQgbXRkICVzICVkXG4iLCBtYXN0ZXItPm5hbWUsDQo+ID4gKyBr
cmVmX3JlYWQoJm1hc3Rlci0+cmVmY250KSk7DQo+ID4gICAgICAgICAgICAgICAgIGtyZWZfcHV0
KCZtYXN0ZXItPnJlZmNudCwgbXRkX2RldmljZV9yZWxlYXNlKTsNCj4gPiArICAgICAgIH0NCj4g
Pg0KPiA+ICAgICAgICAgbW9kdWxlX3B1dChtYXN0ZXItPm93bmVyKTsNCj4gPg0KPiA+DQo+IA0K
PiBDb3VsZCB0aGlzIGJlIGhlbHBmdWw/DQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzA3MjUyMTU1MzkuMzEzNTMwNC0xLQ0KPiB6aGFuZ3hpYW94dTVAaHVhd2VpLmNvbS8N
Cj4gDQo+IElmIHlvdSBzdWNjZXNzZnVsbHkgdGVzdCBpdCwgcGxlYXNlIHNlbmQgeW91ciBUZXN0
ZWQtYnkuDQpJbiB0aGUgZmlyc3QgZ2xhbmNlIGl0IGRvZXNuJ3QgbG9vayBjb3JyZWN0LCB3ZSBo
YXZlIHRoZSByZXByb2R1Y2VkIHVzaW5nIGthc2FuLCBzbyBob3BlZnVsbHkgdGhlIGZpeCB3aWxs
IGZvbGxvdywgc2hvcnRseS4gDQpUaGFua3MNClRvbWFzDQoNCg==
