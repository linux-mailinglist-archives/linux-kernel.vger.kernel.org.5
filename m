Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863287FA7FA
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjK0RcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:32:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjK0RcX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:32:23 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9BCEBF
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701106349; x=1732642349;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=OegQjZTvBuMbPLfZdWHLrWZDSz2ATO7Q/UOLpiLT/YY=;
  b=mwe1630smro4pqxEafAIdzNbLTo89E/nxVyt82akgI75qazqM+Gr7lUn
   xq+ymbjQQvgZQyI5/4ARCr3+kpFlEEs4jRG6dNugAG8ttLTyUBr03A3Cl
   d0pkWkyEP25BK27nplcUd7UBHswDS1sJ182uYbpt1BUV8yRYpfUgkPkwk
   vbu1gG0Xx0BrAg5e1QXoOv/l+H9Vf4ReG1YeDUYSkMhc9lReVDpnj/35J
   rFuKiHFKAB78iq2i56eWLOlPDmQXjV1sja1WHauxgbFawBy6mHs4CDE5i
   y2nX5xO4hYxTjfZneC7zxJF8nfwxOd2jbcUskyEjPmfy/BQmICMFazEMZ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="372127990"
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="372127990"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 09:32:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,231,1695711600"; 
   d="scan'208";a="9678533"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 09:32:29 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:32:28 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 09:32:28 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 09:32:28 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 09:32:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncbr7/E5yMXIpAazlONk55PyIdMldlX8aHmC7QMiWUwMwborO5bxRRVNJodYUVR4tFVKY6xzmKJw9M2TNx9S6Bcd/unYYcCv3BlYvWcsOTKEXx1iL4eqBB5P4eowgXbcojRNv1dOgiOrM4VBAqLuZv4ON8CZ0oU38DU48Pusb7BQqfIqbCFswZR0iqy9OxVsXslGgZyKrX5WyN/N58LEpyaOPzjabYgEwZUwJEeaAJy4RLMixRn+CA5LbHwvPz/KHT3kj8y4qKoF6FuYc1/EWJXJBb+zWSUu4O40ypnV9OwkqgwPfxMYV6N+ySsqSpUyIaOHenZ16e5fUxV4PykLIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OegQjZTvBuMbPLfZdWHLrWZDSz2ATO7Q/UOLpiLT/YY=;
 b=Yb1OYh1zl1/ZGeBJD3KCR0P+PB9og+YwQMDV3zyp8QtP/DiMeYBohEMr5oMM0qtuobz00lb+1uA8iL2zPJz6XJbB/MHWkCJ33U+67ilUlGTtAsQO54egXYoVzzP4Tr8MulQ/kCPD05a7di7RGI6Dov7v2cN38v4ttC2VN5MHECH8Tg0hnc8FApTORfTZNrUpJsXxf6gmTMn7OPkQhvtR6SXPuApRTOoL9hsXYLHw+ElunEexqAODoPGohExmUEynRxSET2CcaWOFqkTKXWYuhX52T3dIl8SXdc1Vsw3IOoGYZe0VpTq/a/x87D4cSwkzcb9yM+xunXmdTAhj2eR09A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MN0PR11MB5963.namprd11.prod.outlook.com (2603:10b6:208:372::10)
 by SA1PR11MB6894.namprd11.prod.outlook.com (2603:10b6:806:2b1::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.26; Mon, 27 Nov
 2023 17:32:25 +0000
Received: from MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9]) by MN0PR11MB5963.namprd11.prod.outlook.com
 ([fe80::5260:13db:a6e:35e9%6]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 17:32:24 +0000
From:   "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>
To:     "broonie@kernel.org" <broonie@kernel.org>,
        "debug@rivosinc.com" <debug@rivosinc.com>
CC:     "keescook@chromium.org" <keescook@chromium.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "Pandey, Sunil K" <sunil.k.pandey@intel.com>,
        "szabolcs.nagy@arm.com" <szabolcs.nagy@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hjl.tools@gmail.com" <hjl.tools@gmail.com>,
        "kito.cheng@sifive.com" <kito.cheng@sifive.com>
Subject: Re: Shadow stack enabling from dynamic loader v/s kernel on exec
Thread-Topic: Shadow stack enabling from dynamic loader v/s kernel on exec
Thread-Index: AQHaHaLVAy4ouJt4Q0WQalPzbfPTrrCK67sAgAOIXQA=
Date:   Mon, 27 Nov 2023 17:32:24 +0000
Message-ID: <b2498b8097da6223f54aebd80f2e3f0b06fe47e2.camel@intel.com>
References: <CAKC1njRkpaqbAFWrZpz75u4M-T8mniY2QHVZEENameqnHOOGPg@mail.gmail.com>
         <ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk>
In-Reply-To: <ZWHcBq0bJ+15eeKs@finisterre.sirena.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4-0ubuntu2 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR11MB5963:EE_|SA1PR11MB6894:EE_
x-ms-office365-filtering-correlation-id: e59fe459-7b94-48a0-3824-08dbef6ed1d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Q+iyVySDYJ/3klIWijmphHF7JFsHMlEvv38klmkTItbxDMK9RUT3UQ8vTme1uKCahsM4xmFRYLV48PLufIvx19/iYiztjYJilROFiK0vlqauRLYXDbYJiQX7IIX4mb4CnGrBM4FUHBsmLZyzwchmuOCJVx0MPWgXibMTGFdiw6NbOlREixmmlgG3mrwczRdkhp5EHNfRsOsQqxDSkQEWyhJED4jcOsL7sh8kbx1fafz1xMBOnAWJ3pHAtzZITZsPeVmfswifo0ewDx2If39VVBqEMd+x19Z7IdVDCePHiwSxjeL7DX5/HEqz9RBfENU71tNddJyxCsffYj03ZsQSEyobtLWaG0uE0yPwB1zomMtu97ieNCqGqOYQNlZu2HX72mTg7B9XnfmFl4ckXQBZ1M9R5OWGMa1EJavfpEnrqhI76AVgquUEhTKokcImHnBRJWXuHl+CV8+hUsYbHo6tkcGX/x/H3UYpMFmQmn/gEehrkievDD/EgUz0nT5CRYtqDp+LpozPIpRc0dKnHnYq4GqpY224jp036U2nj92HL8byQmfAMxs2UiqROGmPD8a1l9uAolyWhKki5n/K82bNm+/BSEREr+9D+vhK2bOTwPP7hBSR76siTJfngaCZoVbuFRyuKKrBeYFeKDiPnHm0eLbgg8QMJdIr/l6l62fCslk=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB5963.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(366004)(396003)(136003)(230173577357003)(230922051799003)(230273577357003)(451199024)(64100799003)(1800799012)(186009)(38100700002)(54906003)(66556008)(66476007)(64756008)(66446008)(316002)(4001150100001)(2906002)(41300700001)(5660300002)(8676002)(76116006)(91956017)(71200400001)(8936002)(66946007)(110136005)(478600001)(4326008)(36756003)(26005)(38070700009)(122000001)(82960400001)(6512007)(2616005)(6506007)(6486002)(83380400001)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eUJqL1p2aGY1bTdQUW81dFVWODZKQzdOTlI2S3VLZHpWbHEvN05zcXFjYy91?=
 =?utf-8?B?R3BTaXByNFhhZzFQZlNMcEZJb0ZYMlBVbXozVnNqK2ZHUkNkanZTTW9aYnlR?=
 =?utf-8?B?ayt3S0VYR3BGeEd3NVVVWHp1aXNtQUNnSmo0by9CRGpXMjg5Tjh0QUpldm1j?=
 =?utf-8?B?S0xRQmV3WnI1U2VIamJRM3VkMnd5TkV3Z3Y4cFBVR29EY3d5OVZjaWpjQlhV?=
 =?utf-8?B?YU1LL1VBYW8xelZ2aTIrclFoU3EycXhDRUR5QlNmR2tJOWh5UXYzQTdCcEZW?=
 =?utf-8?B?aDhRRHVZSnBMdm1rU3pVNkd6VlVoZmdOUVhTUHlEYUNIRXBncldPU3pCYUwy?=
 =?utf-8?B?SGRjUytwTGNnb3pBK0tVZ1BJemRpTVQ4MzgrMWpobmZrY21rQXowTnpYeUxD?=
 =?utf-8?B?OGxJWTNUYXltUHNjbW52VGV2aG80R1pCaGRZbUJvdEpSdFN0RnNXRkg5dGZn?=
 =?utf-8?B?cmxTMUdZU1BYc09wN1RiRlZHdzZHVlF3dHpqVU8rd2huQkpYUXJkRndWQTlC?=
 =?utf-8?B?NllhS3VpQmlFeUZzaFRUdFBlUHdxWGt4RmJSZGt4Tm9nQlFnb05rZXlkbWFy?=
 =?utf-8?B?RjlYdFNxOGZRdUx2ZDBjbkJOL0tIK25hTFFrR2tscTYza1BzVlBZODV0WGdm?=
 =?utf-8?B?ZDFNMVZ0MW5pb0lrYklkaXpCWktXY3ROQzQvVW9rSnprdFlqaXd3VHQ4eVJt?=
 =?utf-8?B?eGtGdVpWdnd5dmVNOGlsWmNPbU1LT3NmdDFPaHBuNktnU2J2WDQ2OU1RQ2tM?=
 =?utf-8?B?SWMvVmU0OHlCNWJicTkwZldIK2FuVDZyczZMMEVyWDJvSVk2d09QQWFxelhT?=
 =?utf-8?B?cVhqR2dIYXdEb3R0WEVkbFIvdHdPUzhLRC9KZ1pFWVBpbW1VcVJNUHYxL2Q3?=
 =?utf-8?B?OEJ4Qk9kSjhxNW00ZTBRVUlybUJ5aDRta21RQkZhQ3kxS01mbmFmUDZTMVMz?=
 =?utf-8?B?SGx4Rmk2OGo5VjhHMkM5c0t1TE83ZmJOMDducC9WeldrN21hOFBXQmtGTWZR?=
 =?utf-8?B?ZDFmRHN6V1cva0NKRkc4MDMyUEtBMkNUVGFaNFdSRDdGa0I5dVpBM2VXN0FH?=
 =?utf-8?B?ZUloVERuSHFWa003SXFwTEFuSVBwWmxQNzBUbktxd2kvQUdlMWRaY0JQb1VB?=
 =?utf-8?B?L2Z1RWRxZWFLajVEMTVweCtnSStrNEdZSldIeXdqbmJHdkExWHE4VDhZcjQ2?=
 =?utf-8?B?bzQ1bHBHVkNib2pIMWZGbEN2bURkQU1zdEJVQ2pnUkMxVHhvZ2lRWmk1VXRY?=
 =?utf-8?B?SjdKZytTeTI0WEp3Tk1oYWVCUGk5TmdOVkY1K0xtdDgrNDRwUkpobmdzbUtC?=
 =?utf-8?B?S3Q1eXBLaXFKeFNXd0RCRExCZ0g5M2FwRHRGZFRMM2xRWVVPRTJxQndlcEpB?=
 =?utf-8?B?Y3pjZjF1MERaYWpPei95WldwdUt1N1Vpc1dRMnlGSGNOK1B5QUN4bTlCbE5F?=
 =?utf-8?B?YU5VTFdla25ERmtKMXQ0WjJXWmViTjUyTDZFUit1TkViRzlWdi9QbWZYNkVj?=
 =?utf-8?B?QUpXUzFVZGZiSXhUMGdkZXNvTWZoU3JPYjUrZFdNaC9KVWVESmNnd2xjeVFQ?=
 =?utf-8?B?dUt0aUJLbUhpQVA0NjdnZkt6VytpcGl1MHYrbStrbHgrM2hNUFhDWnFiV0g2?=
 =?utf-8?B?bTJtZWpIbmlzYlgzK0tVR2w0Zmo2Nmd5d2hmOXRXN291REhsdFYvOGtPMHF3?=
 =?utf-8?B?SDNXUlpaRWZMUTBEM2F2RDF1R3c3bGU4ajl3dkVqWHJBbDhSbWhHVnpwOWdD?=
 =?utf-8?B?YUZ2cUY1bENKUzhXUkdiQlhNczZObWFCNFBKOFlNMk8yVHZtU3NBUGJPTEJs?=
 =?utf-8?B?R1d3YTZHejdGZnVYNXRZaEM1Q0ZYU0MrUzZmRUR1OGZrNW04QnU5S2VGT0hj?=
 =?utf-8?B?bW9XaWlhdFh3eWxEdkRvMUtiQkw5UEhpMnFxYTlKd002VHZJNDF5Wno3RFZK?=
 =?utf-8?B?Mi9QQjIyU2svR0FTVXkrcHoyOC96QW95MWZ6d0pMY2hHMmZDTVRIL0VSd1gy?=
 =?utf-8?B?SmVBTXVFazRMQ2FGMXJVNURabE4yQ1lTRHFpZkdlRVl2a09lSjBqdHFPb0Mr?=
 =?utf-8?B?Y2dld3FHRVlxTXE0QVVteWVxdDBURHdJeGxOZ1BZZkdjRVh6d0RzSXE2R2xj?=
 =?utf-8?B?MUVUd05ObzgrYWMrWmhMUGJyUVpLbVc0T1hnMTNabXNxRGdkbTBEMFFXMGpG?=
 =?utf-8?B?VXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <364F1A34218417438DAB3FACF4BF7503@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB5963.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e59fe459-7b94-48a0-3824-08dbef6ed1d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2023 17:32:24.8539
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 47vxTVoxUSt6wKycL6fqiUdJcMXrjdN+Qku3MAAeSZgWIcXlMlnsgqpFG3VreuxL/7MF2anMOMtxbDuQZqtdlcWgwN9hDzAlJJFT4yR8l54=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6894
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

T24gU2F0LCAyMDIzLTExLTI1IGF0IDExOjM1ICswMDAwLCBNYXJrIEJyb3duIHdyb3RlOg0KPiBP
biBXZWQsIE5vdiAyMiwgMjAyMyBhdCAwNDoxOTo1MVBNIC0wODAwLCBEZWVwYWsgR3VwdGEgd3Jv
dGU6DQo+IA0KPiA+ICJXYXMgdGhlcmUgYW55IG90aGVyIHJlYXNvbiBvdGhlciB0aGFuIHN1cHBv
cnRpbmcgRUxGIGJpbmFyaWVzIHRoYXQNCj4gPiB3ZW50IGFoZWFkIG9mIGtlcm5lbCBjaGFuZ2Vz
IHRoYXQNCj4gPiBsZWQgdG8gZGVjaXNpb24gb2YgZGVsZWdhdGluZyBvZiBzaGFkb3cgc3RhY2sg
ZW5hYmxpbmcgaW4gZHluYW1pYw0KPiA+IGxvYWRlciINCj4gDQo+ID4gSWYgdGhlcmUgYXJlIG90
aGVyIGNvbXBsaWNhdGlvbnMgdGhhdCBjYW4gaGFwcGVuIGR1ZSB0byBrZXJuZWwNCj4gPiBlbmFi
bGluZyBvZiBzaGFkb3cgc3RhY2sgYmFzZWQgb24gRUxGIGJpdHMsDQo+ID4gSSB3b3VsZCBsaWtl
IHRvIGtub3cgYWJvdXQgdGhlbS4NCj4gDQo+IFRoaXMgd291bGRuJ3QgcGxheSBuaWNlbHkgd2l0
aCBzZWN1cml0eSBwb2xpY2llcyB0aGF0IHByZXZlbnQNCj4gZGlzYWJsaW5nDQo+IHRoZSBzaGFk
b3cgc3RhY2tzIC0gaXQgd291bGQgYmUgZmluZSB3aXRoIHRoZSBwcmN0bCgpIGJhc2VkIGxvY2tp
bmcNCj4gYnV0DQo+IHNvbWV0aGluZyBpbXBvc2VkIGV4dGVybmFsbHkgd2l0aCBzZWNjb21wIG9y
IHNpbWlsYXIgd291bGQgYmUgdGhlcmUNCj4gZnJvbQ0KPiBwcm9jZXNzIHN0YXJ0Lg0KDQpJSVJD
IHdlIGRpc2N1c3NlZCB0aGlzIGF0IHNvbWUgcG9pbnQuIFllYSwgdGhlIGRvd25zaWRlIGlzIHRo
YXQgZXhlYw0KZG9lc24ndCBrbm93IGlmIGFsbCB0aGUgbGlua2VkIGxpYnJhcmllcyB3aWxsIGhh
dmUgc2hhZG93IHN0YWNrLiBTbyBmb3INCmNvbXBhdGliaWxpdHksIGl0IHdvdWxkIG5lZWQgdG8g
bGVhdmUgdGhlICJkaXNhYmxlIiBwcmN0bCgpIGF2YWlsYWJsZQ0KZm9yIHRoZSBsb2FkZXIgdG8g
dXNlLg0KDQpPbiB4ODYgdGhlcmUgd2FzIGRpc2N1c3Npb24gb2YgaGF2aW5nIGEgV1JTUyBlbGYg
Yml0LiAoSSBtZW50aW9uIGl0DQp0b3dhcmRzIHRoZSBzaW1pbGFyIGZlYXR1cmVzIG9uIHRoZSBv
dGhlciBhcmNocykgQnV0IHRoaXMgYml0IHdvdWxkDQp3b3JrIGRpZmZlcmVudGx5LiBJbnN0ZWFk
IG9mIGVuYWJsaW5nIGl0IGlmIEFMTCBvZiB0aGUgRFNPcyBzdXBwb3J0ZWQNCnNoYWRvdyBzdGFj
aywgV1JTUyB3b3VsZCBiZSBlbmFibGVkIGlmIEFOWSBvZiB0aGUgRFNPcyBuZWVkZWQgV1JTUy4N
CkV4ZWMtdGltZSBlbmFibGluZyB3b3VsZCBoYXZlIHRyb3VibGUga25vd2luZyB3aGF0IHRvIGRv
IGFib3V0IHRoaXMuIEl0DQpjb3VsZCBsZWF2ZSBpdCB1bmxvY2tlZCB0byBwaWNrIGxhdGVyLCBi
dXQgdGhpcyBkb2Vzbid0IHNlZW0gZ3JlYXQgaW4gYQ0Kc2VjdXJpdHkgZm9jdXNlZCBydW50aW1l
IGVudmlyb25tZW50LiBTbyBhIHNlY2NvbXAgbW9kZSBzdGFydHMgdG8gc2VlbQ0KbGlrZSBhIHNl
cGFyYXRlIGVuYWJsaW5nIG1vZGUgd2l0aCBpdCdzIG93biBydWxlcywgaW4gd2hpY2ggY2FzZSBp
dA0KY291bGQgYmUgbGVmdCBmb3IgdGhlIGZ1dHVyZS4NCg0KSSBkb24ndCB0aGluayBkb2luZyBl
eGVjIGJhc2VkIGVuYWJsaW5nIHdpbGwgaW1wYWN0IHRoZSBhcHAgZGV2ZWxvcGVycw0KZXhwZWN0
YXRpb25zLCBiZWNhdXNlIGl0IHNob3VsZCBiZSBjb25maW5lZCB0byB0aGUgbG9hZGVyLiBTbyBp
dCdzIGZpbmUNCmVpdGhlciB3YXkgZnJvbSBteSBwZXJzcGVjdGl2ZS4NCg0KPiANCj4gSSdsbCBh
bHNvIG5vdGUgdGhhdCBmb3IgYXJtNjQgQlRJIHdoZXJlIHdlJ3JlIGxlc3MgY29uY2VybmVkIHdp
dGgNCj4gY29tcGF0aWJpbGl0eSAoc2luY2UgdGhlIHByb3RlY3Rpb24gaXMgcGVyIHBhZ2Ugd2Ug
b25seSBuZWVkIHRvIG1ha2UNCj4gc3VyZSB0aGF0IGVhY2ggRUxGIGltYWdlIGlzIEJUSSBlbmFi
bGVkIHdoZW4gd2UgbWFwIGl0LCB3ZSBkb24ndCBuZWVkDQo+IHRvDQo+IHdvcnJ5IGFib3V0IGFu
eSBmdXJ0aGVyIGNvZGUgdGhhdCBtaWdodCBiZSBtYXBwZWQvbG9hZGVkKSB3ZSBvbmx5DQo+IGVu
Zm9yY2UgQlRJIGZvciB0aGUgZHluYW1pYyBsb2FkZXIsIHdlIHN0aWxsIGxlYXZlIGl0IHRvIHRo
ZSBkeW5hbWljDQo+IGxvYWRlciB0byByZW1hcCB0aGUgbWFpbiBleGVjdXRhYmxlIGFzIEJUSS7C
oCBUaGUgYXJjaGl0ZWN0dXJlDQo+IG1haW50YWluZXJzIGhhdmUgYSBzdHJvbmcgcHJlZmVyZW5j
ZSBmb3IgZGVsZWdhdGluZyBhcyBtdWNoIGFzDQo+IHBvc3NpYmxlDQo+IHRvIHVzZXJzcGFjZSBp
biBvcmRlciB0byByZWR1Y2UgdGhlIHBvdGVudGlhbCBmb3IgYmVpbmcgbG9ja2VkIGludG8NCj4g
YW4NCj4gdW53YW50ZWQgcG9saWN5IG9yIGhhdmluZyBkaWZmaWN1bHR5IGluIHdvcmtpbmcgYXJv
dW5kIGJyZWFrYWdlLsKgIFRoZQ0KPiBpc3N1ZXMgb24geDg2IGFyZSBhbiBleGFtcGxlIG9mIHRo
ZSBzb3J0IG9mIHNpdHVhdGlvbiBwZW9wbGUgYXJlDQo+IHdvcnJpZWQNCj4gYWJvdXQgc2VlaW5n
IGluIGZ1dHVyZS7CoCBJIHBlcnNvbmFsbHkgd291bGQgYmUgT0sgd2l0aCBkaXJlY3RseQ0KPiBp
bnRlcnByZXRpbmcgdGhlIEVMRiBtYXJraW5ncyB0aGVyZSBidXQgaXQgd2Fzbid0IHRoZSBjb25z
ZW5zdXMuDQo+IA0KPiBPbiBhcm02NCB0aGVyZSB3b3VsZCBiZSB0aGUgcG90ZW50aWFsIGZvciBk
aXNydXB0aW5nIHNvbWUgbGltaXRlZCBhbmQNCj4gdGhlb3JldGljYWwgdXNlIGNhc2VzIHdoZXJl
IEdDUyBpcyBlbmFibGVkIGV2ZW4gdGhvdWdoIHNvbWUgbGlicmFyaWVzDQo+IGRvDQo+IG5vdCBz
dXBwb3J0IGl0DQoNCk9uIHg4NiB3ZSBzZWUgdGhpcyBjYXNlIGFscmVhZHkgaW4gdGVzdGluZy4g
V2h5IGRvIHlvdSB0aGluayBpdCBpcw0KdGhlb3JldGljYWw/DQoNCg==
