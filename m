Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19AE1802A91
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 04:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjLDDZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 22:25:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDDZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 22:25:03 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2040.outbound.protection.outlook.com [40.107.236.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EC72B6;
        Sun,  3 Dec 2023 19:25:08 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YIzmWchLz/hOUWTF1+HvHFHBu1HUEEJl487nvSzWz0fAgJzUV9W6d1WITHzO173O5vATBOq190ia2PH1/lO0w+qkX9OT7biCX2Py3+sEz1vmpeU6wstvj0KYu8w1K5iXLVghDn8N1Hzz6v9PVVkpPWXtjgw1bqjmAnrglyLV638K7cKJ7VIozSnCvlWMJCVmJzdJ3dcVO+NZWo8AJ6eMA/VIkefHer9ziNqWH7Xjenyj2CGSwkqTaY6kWGg536FSuPZXzIEVPJUnBHXVNDrq42Vp5LN5NC9LJxo7/9nQTT1ibV8J7Cfrw8jAO7yGIELYObzGNo2s3pIPTKeFokk/Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4aU/uTLo3RlHfm5FCZIVyq31sQ8yHkfG0fGyTUua+0=;
 b=Hkjfo05P406LpvEbA3WKDMOqyosJlnMW3eSitb5b0ICLLpIH2B7dyEgeIf1t2y1pCZxn80s9Apuh8mqLqay6TgQboF9Fe2Fg7/4RKgDggPovS89nyUS8doSfzzRoLOdqerXcbvH+MgKbppFh6UjURyxtCiiIlj644rO1sNGTDk6jRYBrlUnobw2+H86pgH8AubfUt+OFyKEXkB51PPXGlCs455dbnGcTQQOjFO6x2p8PVi7EXyc8rr0LYJ4iPqozP4NdrlctCZmSfMy0qskLzMsAPQGsZpw0JChBuTlGuHUDxYatFInqSSI1AWDi4S/4g2gsVGsLA5Ocdp2RBCPM5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H4aU/uTLo3RlHfm5FCZIVyq31sQ8yHkfG0fGyTUua+0=;
 b=K/y5unvmaMdkssfCvdtGsb7otWL7v/3thq3UBHM2yvJpzg0mWM87ekEBy090S3EPMZRUGZIUHdmYohYptDMTUpqViGLbK1x7s391FOtiSWG3Cxm6vX4ezCliM+TWGAhelxb2R73NGFFulZmD7Q6seW/vadK2lIwG/8pvnXOBKsA=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH2PR12MB4133.namprd12.prod.outlook.com (2603:10b6:610:7a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 03:25:03 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 03:25:02 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>,
        "Stabellini, Stefano" <stefano.stabellini@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Ragiadakou, Xenia" <Xenia.Ragiadakou@amd.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: Re: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Topic: [RFC KERNEL PATCH v2 1/3] xen/pci: Add xen_reset_device_state
 function
Thread-Index: AQHaHsGaWb8EJvAynUiF4JhdQXSstLCSQgGAgAC8QwCAAADZAIAGC94A
Date:   Mon, 4 Dec 2023 03:25:02 +0000
Message-ID: <BL1PR12MB5849C9BFEBECAF3C5BCBB09DE786A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291943260.3533093@ubuntu-linux-20-04-desktop>
 <BL1PR12MB58490EB260D226500141557EE782A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <f78395f3-6588-4bc9-8612-3450a8f44be7@amd.com>
In-Reply-To: <f78395f3-6588-4bc9-8612-3450a8f44be7@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5364.namprd12.prod.outlook.com
 (15.20.7068.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH2PR12MB4133:EE_
x-ms-office365-filtering-correlation-id: 52ff7014-cad1-41a2-7f73-08dbf4789a87
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lH/UZnpFRrBUFNgqQU1uY84IUlGtcZCnNU5kmmTaVMTdlhsKYt5po5Fjpk2JtWcuy6CTM7EmQnGYMwg3S/xDUGBFG83ezlrYUQVy9P4PgzBCl7MesGaxYZQulZEUsv/P+iKsFIw/My71AFxLiw75oR3ri0ialeWhlho2T5FdMOiZc4K88lMjb8VXV/BP7W472wU0jVLNhLHvIXDI0zBuQr0+RXQLyVCwehQ95Hr4CtYwsPX2jSXIRzGOl7WqkAwim7ulk6WLTr7R8tgU4MW6tsdxQ+M+bCB6d/nqky6kYG35f1oiGUoSqfZoJEzV/m894qK9M33KJmhuqB+VsUxq+LONpKFmMe0jXJ9lieaDAsKf+JpSYG4aUJiqoJeInC0Sv7m4gVygSMbuf4KJVOkHaVdXy7clipUW87ZJZQ0OgFwJAWAFuQ2YS0P0021i9GKx9UZzoxQIBfSqgBw9EURAu/OWMv+eZvQTBZAaV8j0SlwIdtMg+ar531ioHtPt+9nS7YVnLnbbcuQBmbfDpOE8m8MuFqi0T6vukT3QAEcx98CIdvGsmPyY175VUF6PUvwviv/+aeCiNlpZ/6iapPnGULINyQCvzoZ76fR/564i1H9PXhqCVpt+jqSlaA8+XsN2
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(376002)(366004)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66556008)(110136005)(76116006)(66476007)(66446008)(66946007)(54906003)(64756008)(316002)(478600001)(71200400001)(7416002)(5660300002)(38070700009)(41300700001)(38100700002)(33656002)(2906002)(52536014)(4326008)(8676002)(8936002)(122000001)(83380400001)(55016003)(26005)(9686003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?a1ViekozSEQrQ0o5Q1lERTQvcFV5VmRPZXlnRGp2aEFNdjlrcDFBdGJSSjh1?=
 =?utf-8?B?cEVoa1U3Nzd4OGl6OUdjUTJjbGFuU2NYRmd3YWVSSzVRaWt4cHNQWnpGbXNF?=
 =?utf-8?B?cExXeTN0MDJVaEo3Y0Y1ZU5rWHc2dEJxK3ZiS1JVajlNck1SVzliaFhBNDk0?=
 =?utf-8?B?NG9nMU9GVVExSkRDUy9VdVFNeG9DV2d3T3ZoOSs4L2tpUCtKVDVSQ3ZOa20v?=
 =?utf-8?B?TWt6NTNGN0VrbUdlZEVoazZBcTVieTdQcm5WWWU1dXpTNkV3ZmdBSVl1M2NE?=
 =?utf-8?B?TUo4MkhXT1gwZjFFbEV1OTEyeXFpbHpUMGJIL3V1clk0K0tWSHZSRXcwZ3FN?=
 =?utf-8?B?VHpUckdGOFV2OG05Y0hvTmZObGt6Vi8vSG14YjZyY3FJOGFXZmJITWpETTBV?=
 =?utf-8?B?bHZ4MDdCemR0dTJoUjRYWnE2eEJyVjhaNXhtVmlEMzJpYkNibU04L3pPWnFa?=
 =?utf-8?B?Znh1TzNQMUF1OVdlUjRhaXNwaVhQQ3g4ZzVkOEkveXU3cFBpUjlBeGd5WFpH?=
 =?utf-8?B?eWJBVmRPRkF5N0dkQytreXd2NjRCekF2SE9NYStkNUpzaGFKS2c1bDNTcVFQ?=
 =?utf-8?B?ZjBtekhwblBQL3c0Vlowa0p0VytqWG50NHpORGJGUlpBdVhTM2hMaXY3Vm0w?=
 =?utf-8?B?aFBxV090TkpadS9rZTQ5bU9PNUw5TzFnejNtMEg1VjlaQjI5TzA5bnduUkRv?=
 =?utf-8?B?R3JsemdHRW1KcG5LU0xDdUg4QTAvdWIvWDFXQTFQM25GTXkwc1E4R0hpZXpD?=
 =?utf-8?B?UGJPUWV3YW9WdDZOWVo0TkJmSmlld2lFMjZaVnI4b3JMTWpEcFBzQ2hTMlJ0?=
 =?utf-8?B?ZTkyNnRDaE9kRUNpTmZubFFCTmV2cGVqNVNyN0czcWs1VkpmK3N2S05sTGN3?=
 =?utf-8?B?UzVhY2sxN1NGbDVMSkhKMjlKMGdZOWRkOFUwd1hPL3Vkamk1QVhQTjhDSEsv?=
 =?utf-8?B?ZXlNem42WS9wTVFUbmF5QzhTd1VYY1c3RUFDMkprdWlBVEdDK00rZ3RqOEdi?=
 =?utf-8?B?Sll2dUNnaWxIR2dOOXViL2tFNDJYK0ZCWllRbDQ0aXQrN2tscjJSYWpxQ0Ju?=
 =?utf-8?B?dGpCbEZHaGxrWm8zL1ozRDBGeTkvSCswck1JWWdBdXp3Uzl4T3NaZys0ZWxp?=
 =?utf-8?B?c1gwRUxBNjJ1QXJSNm83QmRQRFY3bVlhY2NKTWVyOGQySmF4UThnS0dEV3V4?=
 =?utf-8?B?cFpPWGp2a3BZOVRBdXpUYW5UNm43Mm4wV3dOSkhUYklOYm04WUIwby91blJW?=
 =?utf-8?B?N28zbGNPbW9ZWmVLOWYzMkd5WnE0SnJQVENoV0NoNDNlcmZrNStYZ2J2UVRP?=
 =?utf-8?B?OUNmOHRBWUwrSW1qMk5VaFNITGprK0xhM3pGM2YxM1F6bGtYWlI2SG9CNTRr?=
 =?utf-8?B?SitNQ2hXMmNEL1V1MnJBZ1hvU2w2RnZSN3QwNFh6UzdvdFhoZFVCTkdZbmQ0?=
 =?utf-8?B?bG1YaVoyYUxXc1Z1YlVTK0EzazF6STFRU1RKZ1d6cTN0Smt2WkFQNERoOHBy?=
 =?utf-8?B?UkptcFJnNU9wTXA2WHgyZmlPd3NUS1FSSUpvL0pFdmw3enRNbzE2R1lzVysx?=
 =?utf-8?B?cnNWODFRNElmM3Y3K1RRaWlsTER0MWhoZDVUSUgyTGowaERiWEdVNVZ3aW0y?=
 =?utf-8?B?bVJCclF3bTNtQkpVUWhaRXNrUWhocHk0eVhxeXU4U0gwSkgvdC9HY1JNSjUx?=
 =?utf-8?B?NHFyd2tYNmxUOWpIWHRvZVpEK0hIWkVkVW93TXU1TTNXN1pLb0hiU0gxL2pE?=
 =?utf-8?B?UlhYWURkQTNKZTZjbDJ2ZHFtcGkzaEkrd0Y1d3lzZjEzUUtSM1NjQ2R4eGF6?=
 =?utf-8?B?dTBzUW9wKzhKOC9KQXhQY0NHVkJ2MVhKeVR3U2ZZZEp6RXhqOTJlL28vNlBB?=
 =?utf-8?B?NkNXYmJsQ1NHSWlqN2J1ZnBGM3I3MXVPQ0YzK3MzWGNFY25hdmlPcEN1SnBD?=
 =?utf-8?B?ZWhNTFpzNmdobGIwOEJZVExmUXExQkhmVzlvN3d0dGhIN3l3eU9TVXc4RDMw?=
 =?utf-8?B?Vzk4bTBhU1hGSGpUdFZIaC81T05XWTZkTG0xc2FjSGZ6cStxTHJPeGg1bndH?=
 =?utf-8?B?ZkVsSytqZFpRZU12UmJSY2VLNVdycjB3RGxqRU1xSkVzUmRrVjJyUGtJNUoy?=
 =?utf-8?Q?TBbY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A98AAE1BD69EB54792977A6FC58254E6@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52ff7014-cad1-41a2-7f73-08dbf4789a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 03:25:02.8479
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bz3REsea0n6E//nrX4UyZEW+N7J/QklP2xRJ/ks/jnpgCjUyHi1NphEeXQKF/VkswrQEbWS+9aYk8aZcPlrWlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4133
X-Spam-Status: No, score=0.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgU3Rld2FydCwNCg0KT24gMjAyMy8xMS8zMCAyMzowMywgU3Rld2FydCBIaWxkZWJyYW5kIHdy
b3RlOg0KPiBPbiAxMS8zMC8yMyAwMjowMywgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4NCj4+IE9u
IDIwMjMvMTEvMzAgMTE6NDYsIFN0ZWZhbm8gU3RhYmVsbGluaSB3cm90ZToNCj4+PiBPbiBGcmks
IDI0IE5vdiAyMDIzLCBKaXFpYW4gQ2hlbiB3cm90ZToNCj4+Pj4gV2hlbiBkZXZpY2Ugb24gZG9t
MCBzaWRlIGhhcyBiZWVuIHJlc2V0LCB0aGUgdnBjaSBvbiBYZW4gc2lkZQ0KPj4+PiB3b24ndCBn
ZXQgbm90aWZpY2F0aW9uLCBzbyB0aGF0IHRoZSBjYWNoZWQgc3RhdGUgaW4gdnBjaSBpcw0KPj4+
PiBhbGwgb3V0IG9mIGRhdGUgd2l0aCB0aGUgcmVhbCBkZXZpY2Ugc3RhdGUuDQo+Pj4+IFRvIHNv
bHZlIHRoYXQgcHJvYmxlbSwgdGhpcyBwYXRjaCBhZGQgYSBmdW5jdGlvbiB0byBjbGVhciBhbGwN
Cj4+Pj4gdnBjaSBkZXZpY2Ugc3RhdGUgd2hlbiBkZXZpY2UgaXMgcmVzZXQgb24gZG9tMCBzaWRl
Lg0KPj4+Pg0KPj4+PiBBbmQgY2FsbCB0aGF0IGZ1bmN0aW9uIGluIHBjaXN0dWJfaW5pdF9kZXZp
Y2UuIEJlY2F1c2Ugd2hlbg0KPj4+PiB3ZSB1c2UgInBjaS1hc3NpZ25hYmxlLWFkZCIgdG8gYXNz
aWduIGEgcGFzc3Rocm91Z2ggZGV2aWNlIGluDQo+Pj4+IFhlbiwgaXQgd2lsbCByZXNldCBwYXNz
dGhyb3VnaCBkZXZpY2UgYW5kIHRoZSB2cGNpIHN0YXRlIHdpbGwNCj4+Pj4gb3V0IG9mIGRhdGUs
IGFuZCB0aGVuIGRldmljZSB3aWxsIGZhaWwgdG8gcmVzdG9yZSBiYXIgc3RhdGUuDQo+Pj4+DQo+
Pj4+IFNpZ25lZC1vZmYtYnk6IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPj4+
PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4+PiAtLS0N
Cj4+Pj4gIGRyaXZlcnMveGVuL3BjaS5jICAgICAgICAgICAgICAgICAgfCAxMiArKysrKysrKysr
KysNCj4+Pj4gIGRyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMgfCAgMyArKysNCj4+
Pj4gIGluY2x1ZGUveGVuL2ludGVyZmFjZS9waHlzZGV2LmggICAgfCAgMiArKw0KPj4+PiAgaW5j
bHVkZS94ZW4vcGNpLmggICAgICAgICAgICAgICAgICB8ICA2ICsrKysrKw0KPj4+PiAgNCBmaWxl
cyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3hlbi9wY2kuYyBiL2RyaXZlcnMveGVuL3BjaS5jDQo+Pj4+IGluZGV4IDcyZDRlM2YxOTNh
Zi4uZTliMzBiYzA5MTM5IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJzL3hlbi9wY2kuYw0KPj4+
PiArKysgYi9kcml2ZXJzL3hlbi9wY2kuYw0KPj4+PiBAQCAtMTc3LDYgKzE3NywxOCBAQCBzdGF0
aWMgaW50IHhlbl9yZW1vdmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+Pj4gIAlyZXR1
cm4gcjsNCj4+Pj4gIH0NCj4+Pj4gIA0KPj4+PiAraW50IHhlbl9yZXNldF9kZXZpY2Vfc3RhdGUo
Y29uc3Qgc3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4gK3sNCj4+Pj4gKwlzdHJ1Y3QgcGh5c2Rl
dl9wY2lfZGV2aWNlIGRldmljZSA9IHsNCj4+Pj4gKwkJLnNlZyA9IHBjaV9kb21haW5fbnIoZGV2
LT5idXMpLA0KPj4+PiArCQkuYnVzID0gZGV2LT5idXMtPm51bWJlciwNCj4+Pj4gKwkJLmRldmZu
ID0gZGV2LT5kZXZmbg0KPj4+PiArCX07DQo+Pj4+ICsNCj4+Pj4gKwlyZXR1cm4gSFlQRVJWSVNP
Ul9waHlzZGV2X29wKFBIWVNERVZPUF9wY2lfZGV2aWNlX3N0YXRlX3Jlc2V0LCAmZGV2aWNlKTsN
Cj4+Pj4gK30NCj4+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKHhlbl9yZXNldF9kZXZpY2Vfc3RhdGUp
Ow0KPj4+PiArDQo+Pj4+ICBzdGF0aWMgaW50IHhlbl9wY2lfbm90aWZpZXIoc3RydWN0IG5vdGlm
aWVyX2Jsb2NrICpuYiwNCj4+Pj4gIAkJCSAgICB1bnNpZ25lZCBsb25nIGFjdGlvbiwgdm9pZCAq
ZGF0YSkNCj4+Pj4gIHsNCj4+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNr
L3BjaV9zdHViLmMgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+Pj4+IGlu
ZGV4IGUzNGI2MjNlNGI0MS4uNWE5NmI2YzY2YzA3IDEwMDY0NA0KPj4+PiAtLS0gYS9kcml2ZXJz
L3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+Pj4+ICsrKyBiL2RyaXZlcnMveGVuL3hlbi1w
Y2liYWNrL3BjaV9zdHViLmMNCj4+Pj4gQEAgLTQyMSw2ICs0MjEsOSBAQCBzdGF0aWMgaW50IHBj
aXN0dWJfaW5pdF9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4gIAllbHNlIHsNCj4+
Pj4gIAkJZGV2X2RiZygmZGV2LT5kZXYsICJyZXNldHRpbmcgKEZMUiwgRDMsIGV0YykgdGhlIGRl
dmljZVxuIik7DQo+Pj4+ICAJCV9fcGNpX3Jlc2V0X2Z1bmN0aW9uX2xvY2tlZChkZXYpOw0KPj4+
PiArCQllcnIgPSB4ZW5fcmVzZXRfZGV2aWNlX3N0YXRlKGRldik7DQo+Pj4+ICsJCWlmIChlcnIp
DQo+Pj4+ICsJCQlnb3RvIGNvbmZpZ19yZWxlYXNlOw0KPj4+DQo+Pj4gT2xkZXIgdmVyc2lvbnMg
b2YgWGVuIHdvbid0IGhhdmUgdGhlIGh5cGVyY2FsbA0KPj4+IFBIWVNERVZPUF9wY2lfZGV2aWNl
X3N0YXRlX3Jlc2V0IGltcGxlbWVudGVkLiBJIHRoaW5rIHdlIHNob3VsZCBkbw0KPj4+IHNvbWV0
aGluZyBsaWtlOg0KPj4+DQo+Pj4gaWYgKGVyciAmJiB4ZW5fcHZoX2RvbWFpbigpKQ0KPj4+ICAg
ICBnb3RvIGNvbmZpZ19yZWxlYXNlOw0KPj4+DQo+Pj4NCj4+PiBPciBldmVuOg0KPj4+DQo+Pj4g
aWYgKHhlbl9wdmhfZG9tYWluKCkpIHsNCj4+PiAgICAgZXJyID0geGVuX3Jlc2V0X2RldmljZV9z
dGF0ZShkZXYpOw0KPj4+ICAgICBpZiAoZXJyKQ0KPj4+ICAgICAgICAgZ290byBjb25maWdfcmVs
ZWFzZTsNCj4+PiB9DQo+Pj4NCj4+PiBkZXBlbmRpbmcgb24gd2hldGhlciB3ZSB3YW50IHRvIGNh
bGwgeGVuX3Jlc2V0X2RldmljZV9zdGF0ZSBhbHNvIGZvciBQVg0KPj4+IGd1ZXN0cyBvciBub3Qu
IEkgYW0gYXNzdW1pbmcgd2UgZG9uJ3Qgd2FudCB0byBlcnJvciBvdXQgb24gZmFpbHVyZSBzdWNo
DQo+Pj4gYXMgLUVOT0VOVCBmb3IgUFYgZ3Vlc3RzLg0KPj4gWWVzLCBvbmx5IGZvciBQVkggZG9t
MCwgSSB3aWxsIGFkZCB0aGUgY29uZGl0aW9uIGluIG5leHQgdmVyc2lvbi4gVGhhbmsgeW91IQ0K
PiANCj4gV2Ugd2lsbCB3YW50IHRvIGNhbGwgeGVuX3Jlc2V0X2RldmljZV9zdGF0ZSgpIGZvciBB
cm0gZG9tMCwgdG9vLCBzbyBjaGVja2luZyB4ZW5fcHZoX2RvbWFpbigpIGFsb25lIGlzIG5vdCBz
dWZmaWNpZW50LiBJIHN1Z2dlc3QgaW5zdGVhZCB0byBjaGVjayAheGVuX3B2X2RvbWFpbigpLg0K
SSBhbSBub3QgdXNpbmcgQXJtLiBCdXQgaXMgQXJtIGRvbTAgbm90IGEgUFZIIHR5cGUgZG9tMD8N
Cg0KPiANCj4+DQo+Pj4NCj4+Pg0KPj4+PiAgCQlwY2lfcmVzdG9yZV9zdGF0ZShkZXYpOw0KPj4+
PiAgCX0NCj4+Pj4gIAkvKiBOb3cgZGlzYWJsZSB0aGUgZGV2aWNlICh0aGlzIGFsc28gZW5zdXJl
cyBzb21lIHByaXZhdGUgZGV2aWNlDQo+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi9pbnRl
cmZhY2UvcGh5c2Rldi5oIGIvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3BoeXNkZXYuaA0KPj4+PiBp
bmRleCBhMjM3YWY4Njc4NzMuLjIzMTUyNmY4MGY2YyAxMDA2NDQNCj4+Pj4gLS0tIGEvaW5jbHVk
ZS94ZW4vaW50ZXJmYWNlL3BoeXNkZXYuaA0KPj4+PiArKysgYi9pbmNsdWRlL3hlbi9pbnRlcmZh
Y2UvcGh5c2Rldi5oDQo+Pj4+IEBAIC0yNjMsNiArMjYzLDggQEAgc3RydWN0IHBoeXNkZXZfcGNp
X2RldmljZSB7DQo+Pj4+ICAgICAgdWludDhfdCBkZXZmbjsNCj4+Pj4gIH07DQo+Pj4+ICANCj4+
Pj4gKyNkZWZpbmUgUEhZU0RFVk9QX3BjaV9kZXZpY2Vfc3RhdGVfcmVzZXQgICAgIDMyDQo+Pj4+
ICsNCj4+Pj4gICNkZWZpbmUgUEhZU0RFVk9QX0RCR1BfUkVTRVRfUFJFUEFSRSAgICAxDQo+Pj4+
ICAjZGVmaW5lIFBIWVNERVZPUF9EQkdQX1JFU0VUX0RPTkUgICAgICAgMg0KPj4+PiAgDQo+Pj4+
IGRpZmYgLS1naXQgYS9pbmNsdWRlL3hlbi9wY2kuaCBiL2luY2x1ZGUveGVuL3BjaS5oDQo+Pj4+
IGluZGV4IGI4MzM3Y2Y4NWZkMS4uYjJlMmU4NTZlZmQ2IDEwMDY0NA0KPj4+PiAtLS0gYS9pbmNs
dWRlL3hlbi9wY2kuaA0KPj4+PiArKysgYi9pbmNsdWRlL3hlbi9wY2kuaA0KPj4+PiBAQCAtNCwx
MCArNCwxNiBAQA0KPj4+PiAgI2RlZmluZSBfX1hFTl9QQ0lfSF9fDQo+Pj4+ICANCj4+Pj4gICNp
ZiBkZWZpbmVkKENPTkZJR19YRU5fRE9NMCkNCj4+Pj4gK2ludCB4ZW5fcmVzZXRfZGV2aWNlX3N0
YXRlKGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0KPj4+PiAgaW50IHhlbl9maW5kX2Rldmlj
ZV9kb21haW5fb3duZXIoc3RydWN0IHBjaV9kZXYgKmRldik7DQo+Pj4+ICBpbnQgeGVuX3JlZ2lz
dGVyX2RldmljZV9kb21haW5fb3duZXIoc3RydWN0IHBjaV9kZXYgKmRldiwgdWludDE2X3QgZG9t
YWluKTsNCj4+Pj4gIGludCB4ZW5fdW5yZWdpc3Rlcl9kZXZpY2VfZG9tYWluX293bmVyKHN0cnVj
dCBwY2lfZGV2ICpkZXYpOw0KPj4+PiAgI2Vsc2UNCj4+Pj4gK3N0YXRpYyBpbmxpbmUgaW50IHhl
bl9yZXNldF9kZXZpY2Vfc3RhdGUoY29uc3Qgc3RydWN0IHBjaV9kZXYgKmRldikNCj4+Pj4gK3sN
Cj4+Pj4gKwlyZXR1cm4gLTE7DQo+Pj4+ICt9DQo+Pj4+ICsNCj4+Pj4gIHN0YXRpYyBpbmxpbmUg
aW50IHhlbl9maW5kX2RldmljZV9kb21haW5fb3duZXIoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+
Pj4gIHsNCj4+Pj4gIAlyZXR1cm4gLTE7DQo+Pj4+IC0tIA0KPj4+PiAyLjM0LjENCj4+Pj4NCj4+
DQoNCi0tIA0KQmVzdCByZWdhcmRzLA0KSmlxaWFuIENoZW4uDQo=
