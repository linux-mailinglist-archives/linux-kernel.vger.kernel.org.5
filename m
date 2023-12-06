Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96156806793
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 07:38:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376984AbjLFGiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 01:38:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376811AbjLFGhy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 01:37:54 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2051.outbound.protection.outlook.com [40.107.102.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B976510C7;
        Tue,  5 Dec 2023 22:37:29 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFlM1Cil31c3xzIeC/a3JkCTGNsCTkZ0lyxZIdKHsyaesI8oxoNskUTSo4CL+iqBkniyK+Urn2uMzKAKujKPrUuoh+ODbmABMta47SK/lXE2RU/jcxOOGvB2jSKCHgQunHqusnlytd1TUZ2X39yHn8IVsLwzXjdyJdIKPTQ5zd0dgabHoFwxBIJ/drQ0w+dBp9LuEOtEO+JTIxV6YpCQKUrLdqV/XMZtVg8Vm5clNXbR501rSdwQuXFkUhR/hPLK/jbXQBm3VzS6/QQ3jDJ5aBYcTsZFxhOIkuG9JZMuKP6KYJFPpaLf5VyYLqhAatLcuRdN/zbdsZEJED/VVNMOLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k+7ROP0NuvX80up+nKqC5tUaPngGETCucybdsSYiwgk=;
 b=A1axZGpLrLawJYqf3p1m/4kVGeAVb6kWJw7NPRJ4lR3KRGBlS/GKZVJhPGj8lQXIcDp3xtE3y6pWruJixIUtjunRXnHvtlitvbQrcyLJ0ykpPDDfE6WG+pKdf0zKuUJiVbp4KkeInKka0IWlIRBAVknURifNmVCaiivHkmryyVlkoYD2ReNfx+/xpMLNZcnuKn3QvHliitvOrGlK6euE7m3VnvnQHdb1V4fp/DzvIRZaSk65WNEtvpyQKHfpnzJ9u9kQJZxoSMjDaZh7pjQoTd1x/FyHEktTkz8cL/j60LFST3Fixh40i7yFg53D/O5G7i9gzH0XRnBEynRwcUhxRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k+7ROP0NuvX80up+nKqC5tUaPngGETCucybdsSYiwgk=;
 b=mW3FZiMkGg1znq9USfCvN2pyHZxxQ+7lCGxhySUofPlK78MZzzN1JkmxqvbcpMXk4NlI/smCof8SW45g+Xq8cpGkup0O8v972N4WTj5VvpHboYsvwU0CyzZkn16RAbciIBqCLDD3NIZxHA762nyRUKuDMcGYMSqB58i9givyc4o=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS7PR12MB6007.namprd12.prod.outlook.com (2603:10b6:8:7e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Wed, 6 Dec
 2023 06:37:26 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.034; Wed, 6 Dec 2023
 06:37:26 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Topic: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Index: AQHaHsGaWb8EJvAynUiF4JhdQXSstLCY0coAgACRkoCAAFGagIABR00AgAFl/QA=
Date:   Wed, 6 Dec 2023 06:37:25 +0000
Message-ID: <BL1PR12MB58495E0ED6706CAF0873608AE784A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx>
 <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
 <87fs0gwpj5.ffs@tglx>
In-Reply-To: <87fs0gwpj5.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA0PR12MB8351.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS7PR12MB6007:EE_
x-ms-office365-filtering-correlation-id: 2c3ce1cb-69b0-42df-be43-08dbf625cf73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: dTt3AI2Q85npelKW1e6sNPSn/oU1rhCB+GwTz5Yi0NQ/aFDrM4alCVchfHQUzUx2P2zSMFQ2AALk/TGc9ZdzzawzXfc+2j0ONbxFtg/5pHbkiXrv2wNVa0VImO/wEm/mbQGEOiOcLb8oF/QuASsEROk9cqJ4KpXZ39ASNzY6eJO7puBgfCs/lV4e9Dy7JkkGuGy8csOhB++VfX78ceuYi/UmfbVwn3QNgBrlH8QAbv8BQbTv4O6lZa18YAt8QG1pskHbw9dPyKaDqtK3/AlWhS7+0W0AkaG4gNKEDOVIA6kN/hqPEYG9oog9RYEtTRgR6FwAu6Vx2v5jqZbRAkb4N4+GGLMf20+KUlpRvcAegf2TbaUuLL4rbPvgIPWqeBdPu2Z2DoMq4DUw6EoYKC5jPN+V4Zui3n6Ev1qGpZ6fn1lCbpXAXnnoVY8W66YIbmOPxIQz2Q+WDENxlgizflDVeWIHNxMu+KCfn1p8HaD3KOQ3nGQ+wXSeXc8qrERmryzlV3kFQke/3tB03sn7G9ehz0PuaZ5C05nt5nHEPGW3cO69ynCitmbAR6zwqAnv/TUx/ZXx1VrHAZIqLfcM+A1BEUTmoVXAyxic9UZp3r7+GZJU+3xewCKORZYDatyph1PD
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(55016003)(26005)(122000001)(33656002)(38100700002)(7696005)(38070700009)(83380400001)(6506007)(7416002)(52536014)(5660300002)(53546011)(298455003)(9686003)(66946007)(66556008)(4326008)(8936002)(71200400001)(316002)(66446008)(54906003)(110136005)(64756008)(76116006)(2906002)(8676002)(41300700001)(478600001)(66476007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a3ozRFY1N1FTUkU1SzQxbXBFaVo4R1VlV3REdTJHbWF4MUV1UHRoSjZsb3VN?=
 =?utf-8?B?d0xDTG5sYU5vVE1BOWFRekdZNUR0bFpXQnBnMithdklHOFJXQmE5djZ2M1p1?=
 =?utf-8?B?SjYza0dHbXI3U1dLdFJIdDJjazBmUXNkekoyS1NDQS9hcVZ6RjUwemQxTUlR?=
 =?utf-8?B?U2JmamttYkhpOGdyM09xbWlpclQ3c3NHSjJrWW9HRDQ1L0JJWFZaN2ZUZUli?=
 =?utf-8?B?NkdkWER2ZkZRM0s4ajZQb0hvMXdSSzE0RGE2bmVNNDBVTk5yeC9HZWo1Vklu?=
 =?utf-8?B?NGxZYVZLRzZORTdkbVl5WlIxa3JNNEJiU0RsWXRkZmlGSWFiV2pDa3hYVkI3?=
 =?utf-8?B?VmpaMi9ITHVOV1g3SXlYUGhRQ0loalBleEx5dmh4bDIyczVtSTY2akpMamdq?=
 =?utf-8?B?dWd1WWdvRTUzQmlqdEhpU3llY2I4NVRMZnVGTXJjRjMxbzdnSTNBQitKaE1q?=
 =?utf-8?B?amRpdkt1ZHJ4S2Q2QUNCRVRvOWhjWHM0cnpLMjhsUVRuNVd6dGJQazZmNWlG?=
 =?utf-8?B?T3ZtQnYvcVl3UU9YdDlORTcrZDNlV0hYWmhFNnJZU3lRSXdXdGsxY24yTmhQ?=
 =?utf-8?B?K0Fsem90T0lYSVhodldVd2lzcFJMWm8rbndzZE1ENVF4RVdYbStxakhVK0Z3?=
 =?utf-8?B?ek5nL2QxOTFncXBjYklmcHhnR0ZPcHR4ZnZQYlZyVlpaTHI0TFNQKzFqYW5E?=
 =?utf-8?B?SllCbm5xbjI5RjVEbFpmc29vZzlmT0pHT1puTnI2aFArMlVYMUNpbkg4bnFD?=
 =?utf-8?B?d21EdXRuRkFONVIrQWtleXFQeVNYUmpVQWlpMG9WaFVla0owL0xBbFRRRUFz?=
 =?utf-8?B?R2UxbExpSUpjMTBiOElDcVlzMjNDZGlVM3krRWJmcWwybUR4K251d3ovUjY4?=
 =?utf-8?B?bGtpRjRoQ0hscmhKUTNYKzVtNzJzdE1LczVsVkJZYi91UGhMWXJCdHl6Mnpv?=
 =?utf-8?B?R1NLVjZvMks0c3JNZlFmQWFUU0tkRDRKbnNzU3BrdlVWdWY1bmRSNk1IT3lG?=
 =?utf-8?B?YmVXOG11K05BdnI4TTRQRU5qQURabUVXODdwb3pDVjc2QnJNcjQwZUNYby9s?=
 =?utf-8?B?aUllczhiVmZkajZYZFYrSzcxSnFrbmZEakJCVW9tTDlwYXpFT1JGNFpEQnJv?=
 =?utf-8?B?VVdZNVhySGdhN3JHYmgxTFdZdEFWbGxXZElmYXBRcG1sNVZ6cVI4MnB3dWtv?=
 =?utf-8?B?eFluMWJpRy8zNWZ5TWtGSDA4aG5FVmZKTlRKMnlrbFo3M20yT2lyajRZYkVD?=
 =?utf-8?B?YlVEaVhSaFRyeTAwemJja25MamhZejJQT3c3bSt3cnpFeVo1K3liK0dWUXl6?=
 =?utf-8?B?Y2dGR0QwVmNXV3Fmc3daSks5SFB2ZWZYc2VwZDVNUUVYQXdsZ3YrK1QzTEZm?=
 =?utf-8?B?cFdzandydUFVR0RFYk00ZThKR1NVOStrd1d3U2RXVGUyb2RZbDJ2eS8yT0Qr?=
 =?utf-8?B?RERPWGUwWTAyTXRJOGZIRFVFcWZyY0ZUcTAyd1VsSU4zY1lhZm01NkpCbFNH?=
 =?utf-8?B?b1lCbTIxVGZrTy9nUlRpUFVJQ2FjN1lRbkxGYmt5OHpKblNzR3FzbGIvb0Mw?=
 =?utf-8?B?R1VYWGxmZFpORE5GT21OaGFTRk5uaGF3MGRIanZmNjFKb3lMYmZGTmIwRTVI?=
 =?utf-8?B?bUVLTGhDQVFnemVpdWgyZUI4UHZHaTBac1ViT2ZBV3I1MGN3eFNXMnlSc3F4?=
 =?utf-8?B?T1lFL1gxQTc5UVpTU3Rqb3F3dXc1ME1jQlBGdm9PVkVzU2RvaTJrcWNXRURQ?=
 =?utf-8?B?UnlxaXdSV1BGWWtYNU01SWxodW1XSkRDRTRwWG5TL2tEZnFSNnlCUTl1Ujcx?=
 =?utf-8?B?K3lrZFc0Wnp3czdVQUs2Q09jYVQ0Wkdad205V1hpMXFNckI5WkNPVSttRlo4?=
 =?utf-8?B?M2lOQ2pxS3ZxMllQRGFuVmJ6QWcvSkRwM0tOdkxaRVdrc3hUZi9pSDlsVXZV?=
 =?utf-8?B?VFFmbGhUb0orL1Zjem1qQVZpUmtYZkhrK0lrNzQ3aExibmZvN2s2cFRmWDF4?=
 =?utf-8?B?Ymx2d0R0Mm96OU1DT1hsUDRlQVA1aDgzdkUxRXFFUWNhUFFEK1FRd2ZjSHhn?=
 =?utf-8?B?bFppWE5XUjAyeGRWSm5IM0JSNUQ2eG5salBZc1BlajRwemltSmRibFN3Qy9h?=
 =?utf-8?Q?wsx8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD974A48D3EF2F4CB8C6F6BA100AA22D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c3ce1cb-69b0-42df-be43-08dbf625cf73
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Dec 2023 06:37:25.7281
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85HtkrIJF7QijUMlZQYneKZ2OSTxVt82vOgJAmceUSAGDAQpwjwoiwBaDC79k4yj4Ukym2efNpCvRbcqcC54Gw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6007
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzIEdsZWl4bmVyLA0KDQpPbiAyMDIzLzEyLzYgMDE6MDIsIFRob21hcyBHbGVpeG5l
ciB3cm90ZToNCj4gT24gTW9uLCBEZWMgMDQgMjAyMyBhdCAxMzozMSwgU3RlZmFubyBTdGFiZWxs
aW5pIHdyb3RlOg0KPj4gT24gTW9uLCAzIERlYyAyMDIzLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+
Pj4+PiB2cGNpIGRldmljZSBzdGF0ZSB3aGVuIGRldmljZSBpcyByZXNldCBvbiBkb20wIHNpZGUu
DQo+Pj4+Pg0KPj4+Pj4gQW5kIGNhbGwgdGhhdCBmdW5jdGlvbiBpbiBwY2lzdHViX2luaXRfZGV2
aWNlLiBCZWNhdXNlIHdoZW4NCj4+Pj4+IHdlIHVzZSAicGNpLWFzc2lnbmFibGUtYWRkIiB0byBh
c3NpZ24gYSBwYXNzdGhyb3VnaCBkZXZpY2UgaW4NCj4+Pj4+IFhlbiwgaXQgd2lsbCByZXNldCBw
YXNzdGhyb3VnaCBkZXZpY2UgYW5kIHRoZSB2cGNpIHN0YXRlIHdpbGwNCj4+Pj4+IG91dCBvZiBk
YXRlLCBhbmQgdGhlbiBkZXZpY2Ugd2lsbCBmYWlsIHRvIHJlc3RvcmUgYmFyIHN0YXRlLg0KPj4+
Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29t
Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NCj4+
Pj4NCj4+Pj4gVGhpcyBTaWduZWQtb2ZmLWJ5IGNoYWluIGlzIGluY29ycmVjdC4NCj4+Pj4NCj4+
Pj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmctcGF0Y2hlcy5yc3QgaGFzIGEgZnVs
bCBjaGFwdGVyIGFib3V0DQo+Pj4+IFMtTy1CIGFuZCB0aGUgY29ycmVjdCB1c2FnZS4NCj4+PiBJ
IGFtIHRoZSBhdXRob3Igb2YgdGhpcyBzZXJpZXMgb2YgcGF0Y2hlcywgYW5kIEh1YW5nIFJ1aSB0
cmFuc3BvcnRlZCB0aGUgdjEgdG8gdXBzdHJlYW0uIEFuZCBub3cgSSB0cmFuc3BvcnQgdjIuIEkg
YW0gbm90IGF3YXJlIHRoYXQgdGhlIFNPQiBjaGFpbiBpcyBpbmNvcnJlY3QuDQo+Pj4gRG8geW91
IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KPj4NCj4+IEkgdGhpbmsgaGUgbWVhbnMgdGhhdCB5b3Vy
IFNpZ25lZC1vZmYtYnkgc2hvdWxkIGJlIHRoZSBzZWNvbmQgb25lIG9mIHRoZQ0KPj4gdHdvIGFz
IHlvdSBhcmUgdGhlIG9uZSBzdWJtaXR0aW5nIHRoZSBwYXRjaCB0byB0aGUgTEtNTA0KPiANCj4g
Tm8uDQo+IA0KPiAgICBNYWlsZnJvbTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+
DQo+ICAgIDxib2R5Pg0KPiANCj4gICAgQ2hhbmdlbG9nLXRleHQNCj4gDQo+ICAgIFNpZ25lZC1v
ZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+ICAgIFNpZ25lZC1vZmYtYnk6
IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiANCj4gaXMgZXF1YWxseSB3cm9u
ZyBiZWNhdXNlIHRoYXQgd291bGQgZW5kIHVwIHdpdGggQ2hlbiBhcyBhdXRob3IgYW5kIEh1YW5n
DQo+IGFzIGZpcnN0IFMtTy1CIHdoaWNoIGlzIHJlcXVpcmVkIHRvIGJlIHRoZSBhdXRob3IncyBT
LU8tQg0KPiANCj4gVG8gbWFrZSB0aGUgYWJvdmUgY29ycmVjdCB0aGlzIHdvdWxkIHJlcXVpcmU6
DQo+IA0KPiAgICBNYWlsZnJvbTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+
ICAgIDxib2R5Pg0KPiANCj4gICAgRnJvbTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4N
Cj4gDQo+ICAgIENoYW5nZWxvZy10ZXh0DQo+IA0KPiAgICBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBS
dWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPiAgICBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8
SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gDQo+ICAgIHdoaWNoIHRlbGxzIHRoYXQgSHVhbmcgaXMg
dGhlIGF1dGhvciBhbmQgQ2hlbiBpcyB0aGUgJ3RyYW5zcG9ydGVyJywNCj4gICAgd2hpY2ggdW5m
b3J0dW5hdGVseSBkb2VzIG5vdCByZWZsZWN0IHJlYWxpdHkuDQo+IA0KPiBPcjoNCj4gDQo+ICAg
IE1haWxmcm9tOiBKaXFpYW4gQ2hlbiA8SmlxaWFuLkNoZW5AYW1kLmNvbT4NCj4gICAgPGJvZHk+
DQo+IA0KPiAgICBDaGFuZ2Vsb2ctdGV4dA0KPiANCj4gICAgQ28tZGV2ZWxvcGVkLWJ5OiBIdWFu
ZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPiAgICBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkg
PHJheS5odWFuZ0BhbWQuY29tPg0KPiAgICBTaWduZWQtb2ZmLWJ5OiBKaXFpYW4gQ2hlbiA8Smlx
aWFuLkNoZW5AYW1kLmNvbT4NCj4gDQo+ICAgIHdoaWNoIHRlbGxzIHRoYXQgQ2hlY24gaXMgdGhl
IGF1dGhvciBhbmQgSHVhbmcgY28tZGV2ZWxvcGVkIHRoZQ0KPiAgICBwYXRjaCwgd2hpY2ggbWln
aHQgYmUgdHJ1ZSBvciBub3QuDQo+IA0KPiANCj4gVjEgd2hpY2ggd2FzIHNlbnQgYnkgSHVhbmcg
aGFzIHRoZSBvcmRlcmluZyBpcyBjb3JyZWN0Og0KPiANCj4gICAgTWFpbGZyb206IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+ICAgIDxib2R5Pg0KPiANCj4gICAgRnJvbTogSmlxaWFu
IENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IA0KPiAgICBDaGFuZ2Vsb2ctdGV4dA0KPiAN
Cj4gICAgU2lnbmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+
ICAgIFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+IA0KPiAg
ICBpLmUuIENoZW4gYXV0aG9yZWQgYW5kIEh1YW5nIHRyYW5zcG9ydGVkDQo+IA0KPiBOb3cgdGhp
cyBWMiBoYXMgbm90IHJlYWxseSBtdWNoIHRvIGRvIHdpdGggVjEgYW5kIGlzIGEgbmV3DQo+IGlt
cGxlbWVudGF0aW9uIHRvIHNvbHZlIHRoZSBwcm9ibGVtLCB3aGljaCB3YXMgYXV0aG9yZWQgYnkg
Q2hlbiwgc28NCj4gSHVhbmcgaXMgbm90IGludm9sdmVkIGF0IGFsbCBpZiBJIHVuZGVyc3RhbmQg
Y29ycmVjdGx5Lg0KTm90IGV4YWN0bHksIFYyIGlzIG1vZGlmaWVkIGJhc2VkIG9uIHRoZSBWMS4g
SSBhbSB0aGUgYXV0aG9yIG9mIHRoaXMgc2VyaWVzLiBIdWFuZyBSdWkgdXBzdHJlYW0gdGhlIFYx
LCBhbmQgaGUgYWxzbyBoZWxwZWQgbWUgdG8gaW1wcm92ZSB0aGUgZmlyc3QgcGF0Y2ggb2YgdGhp
cyBWMiBzZXJpZXMuDQpNYXliZSBpbiBuZXh0IHZlcnNpb24sIGJlbG93IGlzIG1vcmUgc3VpdGFi
bGU6DQoNCkNvLWRldmVsb3BlZC1ieTogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNvbT4NClNp
Z25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KDQpXaGljaCBj
YW4gcmVmbGVjdCB0aGF0IEh1YW5nIFJ1aSBpcyBjby1kZXZlbG9wZXIsIGFuZCBJIGFtIHRoZSBh
dXRob3IgYW5kIHRoZSBsYXN0IHBlb3BsZSB0byBzZW5kIHBhdGNoZXMuDQoNCj4gDQo+IFNvIHdo
YXQgZG9lcyBoaXMgUy1PLUIgbWVhbiBoZXJlPyBOb3RoaW5nLi4uDQo+IA0KPiBJdCdzIHZlcnkg
d2VsbCBkb2N1bWVudGVkIGhvdyB0aGUgd2hvbGUgUy1PLUIgYnVzaW5lc3Mgd29ya3MgYW5kIGl0
J3MNCj4gbm90IHJlYWxseSByb2NrZXQgc2NpZW5jZSB0byBnZXQgaXQgc3RyYWlnaHQuDQo+IA0K
PiBJdCBoYXMgYSBtZWFuaW5nIGFuZCBpcyBub3QganVzdCBmb3IgZGVjb3JhdGlvbiBwdXJwb3Nl
cy4NCj4gDQo+IFRoYW5rcywNCj4gDQo+ICAgICAgICAgdGdseA0KDQotLSANCkJlc3QgcmVnYXJk
cywNCkppcWlhbiBDaGVuLg0K
