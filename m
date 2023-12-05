Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95347804ADF
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 08:03:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376343AbjLEHD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 02:03:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344554AbjLEHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 02:03:27 -0500
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30F6EA0;
        Mon,  4 Dec 2023 23:03:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sk7564trNkkxXgp1Rpma1ils7H+xmV06spXmId6QBKAGlxsIyOptPtAr2dSXf/33UI0saPuCgo2naBdsIqGY1X1s4Xg6sfKauqxQ0ChndAwwcx0JpX2ixcGjCNeEc3fukRzBJWPF/OQxXEUtkP4Q/k4OC8lLDLdFpz/g1tboJHJUbdwZbE0jAx+K4U9e7q+h2hEtHlwIovgT3/mbXPtm+wWYhjopkfiP4jpHW7YKkXsThg3WdLqXBe1pKNU53syLbAITWa0Jlw2zytT6yPhL1ApWjthghh1UUGef0C8BVJ6IulMc7YhKdxOOgazm3OVb4St8ar7cjlzOMGk8QYZ1Ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QFwEYzQ4/8GxG6jK1OV9K+yVFMjmfST+HoKxmzIAGeo=;
 b=lNltlMSRlsDTexciwoxLM6OMGim/x29rDjMCcXoqGi5gY2lygZp6FQlSC++h6EaWlteTLOCt1jEMUaoZlT9qS3rAVwk2g5Ze8mY9WAi4qRCeO69EU2U8mK9NLX8K626mlwJcXZK219Pfwh6yqIgOfZjBhJvRDfRzJwQ/Z+UvMSFy5Uj5aZCZSUpT9gTK/ufUsDgTu/ZqEENhdHIme7q3VG1sP8Sh07100S67NSZCYABV7R1E4HtUGdFQq21xEmYzsjJXjAYEAr35bvGL0zbtOJgqn0ZGAxVKoldn0AoHwcKixOmlerLbNGr6p1XI9gMxXiEqNJ2nuvSYPG/aMV9mWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QFwEYzQ4/8GxG6jK1OV9K+yVFMjmfST+HoKxmzIAGeo=;
 b=ms1WPW0ci0uwhjOSaIJCB056E+WGIAYISmxEpgN49uLoxTEnf7iz0BIvg51QJ0x1hxUCfJjG7UmbnHeYX7xGqZsBpvnF1cJfEp5vtQURSnBO1sOsvvKLOp1AfhrIWgsxwOGBl8M2x1EFmaWbZL71LosdI5QkMEa3ct+72xWEQkI=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by BL1PR12MB5208.namprd12.prod.outlook.com (2603:10b6:208:311::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 07:03:31 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 07:03:30 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Stefano Stabellini <sstabellini@kernel.org>,
        Juergen Gross <jgross@suse.com>,
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
Subject: Re: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Topic: [RFC KERNEL PATCH v2 2/3] xen/pvh: Unmask irq for passthrough
 device in PVH dom0
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CY1iEAgAICoQA=
Date:   Tue, 5 Dec 2023 07:03:30 +0000
Message-ID: <BL1PR12MB5849CB9EE88BF3E5269438DFE785A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com> <87bkb6xu4d.ffs@tglx>
In-Reply-To: <87bkb6xu4d.ffs@tglx>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN0PR12MB5762.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|BL1PR12MB5208:EE_
x-ms-office365-filtering-correlation-id: 496a8e72-56dc-4c32-3de7-08dbf560498c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h4lbqILofD1J3lujlAGnQHq0NYcpphk1eejA+OOJD3NLukLtW+cQkplS0nIrx73lFNwm+a8oiTk0LqSanGG0ff6TCXOI4mEnGnEChG0K+eyy83DKMAhWeyItF17/V5phNz+A1Teg58fJdOBlU0cWfbmGRBxBatWXNNN1tYg9GZq4lsXrXmjK8cJ/asAfym2aMXOL9tKGE0oX9jUvt0GxTr4LNZykhY1aMLrl3AO2+9SjFwzBXzerpdBCJZmowj4bmhptsJ3sXXIMre75El/Zyo8+Vy73CztbqX6cjDKE/m0AtLzK0bleo2NgfR7A94GQl81peXykb3ugXbGyi+z1iuB1F1yiU1Jctc8VPg35ZmBNayEh1kNVyXGLYW8yr97EB5yle6eZdWVVy7JpI4WoL2tv/uXZCL1zmpOxCvZXuOnwu/BBJqJ3r6fJEONfuNoPMAh3UiLu6swVIf4v1u2LbPg9XrrmqeMaRekEXTxEu7dpz5mfG+mjrL2FE7CAgWZ5/5PCYMviS0hRX1FfBNweWfaIJCpJ601c5HS/CCZHIhKu6rcArb/unhTNv39yqAGBbA78UiLFcepE1NW5QX770W/a4Hz3cMLV3568x3WoucpILEiajYnjgKe/8bMGXWNs
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(1800799012)(451199024)(64100799003)(66946007)(54906003)(66476007)(66556008)(76116006)(66446008)(64756008)(38100700002)(316002)(6916009)(478600001)(71200400001)(7416002)(5660300002)(38070700009)(41300700001)(33656002)(2906002)(52536014)(8676002)(4326008)(8936002)(122000001)(83380400001)(55016003)(26005)(9686003)(53546011)(7696005)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RXBnSXp0eFBMODA4SG14S1ZSNGJBTWtvTG5zNVJabTRuMTZlc1dXNE1aV0ov?=
 =?utf-8?B?MURkUnFWdi91dmpIMHc0ZStCMVQ3aWdsSWI3YlZtVnVXTGVrWDRGWU9UNThi?=
 =?utf-8?B?azFEVUN5RmJwaEJ6bDJqUjBlemJDYmtudDlOaHlPWEFSUUpJbXVnWW1Ua3hB?=
 =?utf-8?B?UGw0S0x6QzB5cGdsWnQ1c284TUZrT0JpV2pvbHd3c1Y2RzgxMWtkMlRvK0Iv?=
 =?utf-8?B?UUZaUVFPQ2t3U3pMSWNVYW1pb01rN09yRkwzcml0NnFzRk1qNXg3QlZPSEUw?=
 =?utf-8?B?TmpaTmwzM2RpbTlzV0F4V2dzVmVxTFJNbDFCa2FrQURGSDhpUUF2MEVzdDFY?=
 =?utf-8?B?Z1FGUXcvSHlCQ2taaFNPallrbUpOTWU1WndCdGVnb2pBTjQvZHZlQWY4R21N?=
 =?utf-8?B?TWdBQ2tlREFHSk9XNWgvWnV5cUpuMmZYc0RDeWgzSUdObUFHQjdHY0ZxdXVz?=
 =?utf-8?B?Q0x6d0UwUWxYUHJ4N3A3Y3F0Y3F1V0RpTjlsY1VxckF3Z3N0M204SE4rRnVh?=
 =?utf-8?B?WDFDU3cyT2k3bmVrZnJzMnVJZEh4cjZWSjBnMGJJU0s4aDJvVXdpRyt4am1G?=
 =?utf-8?B?YVNraEZoSnljNmd6WCs0eXRDYXI1aVFkeit2WkZwY2RMa1hOclVHdEhXNkVt?=
 =?utf-8?B?eWZlbm81elZOSDJaUUc1bXd1RHV6RG8yVXgvQWJXZnh5cGFWcW51dzcwVWJz?=
 =?utf-8?B?RGp1RTdIbnlhdmRkRyt3NFk4MEpMaUsrZ2ZBQ2tLS1pPeENCSUFvT3FrYlI1?=
 =?utf-8?B?czZTdmhXdDU1cXNEU0Y3L2NzaGEzYUZmQUhsSDBoVlIxb0gyelVYVFVJL3FT?=
 =?utf-8?B?djdsQnVHNU9hMFArRG9hdTlncTkzR1Q3bmRBTXlXMFI5YUdjdlVpdEYyWW41?=
 =?utf-8?B?blhzSE5aVUVBc1VRdW1kTTFyRndWQU1uWldCTUFoT0pOK2VFYVVtT0w0b2xt?=
 =?utf-8?B?eWswT2NTSzRUV2lLZ0dQajhubTFrcis5cmNNOEgzUm0xLzlYN0dDRlhJcjVh?=
 =?utf-8?B?OG8xNnJYT0pKaWJjRzVIZGlJZVArckZZOFpuYW02djNaOXlBTFRqZzRicXNm?=
 =?utf-8?B?M09sTlgxdHVwU0JaTnZNNFV3QVMwMnBvU25ESVNtc0hBdVMxdmEwbnBRMnY5?=
 =?utf-8?B?ZUhrNDdNTGt1TEhkSWRvUnJaU0xhTUlxbm55VmprTnpjQTRvSnFmRm85QlNY?=
 =?utf-8?B?Tkp2R2ROY2Q4aUF4QmxTTjVJTlN6SmVRQTBVaHFBSm9rZnFNNTZ3V2o0bCtJ?=
 =?utf-8?B?VHpUQUZJc1BJTUVkc3pXUzNMaFVyendCaG8yUFo1S2N3eGdsRG1JWDk2RE9W?=
 =?utf-8?B?SmY3WWlUWGxpalV1akE0OXExQlpHQ2NveXppcUQxS2hpK3hvTTZORmhJMnNq?=
 =?utf-8?B?OFc3TlN2YVhoN2p5ZWdzbmp4cUp2V2I1NHQ1cDVKL3ZoQ3ZHYUVMNkcrdGxa?=
 =?utf-8?B?K056cFAwNFdiT2V4Ny9jdnU2ck43Mloxd2c2bGZPSjZ3bStoUEZiYjBvZGQ0?=
 =?utf-8?B?SnJ3Mk5UVXdldFJORmJIQXRFMUp1U2Yxa0YrWkJBdTJiK0d5TGUwdjNYVjFa?=
 =?utf-8?B?Y1piRE5ZclBSZTdFaVBCb1A5Z2lSaWpKZXVKM2VLTGNGTDhSbUl0UGlGN240?=
 =?utf-8?B?dnZ0RTE3WVRIRVd1TVJYdlNMelJaQWZiOC9kbW5sVUZTSnpoM0VidHdIMVNZ?=
 =?utf-8?B?THhZQmVtUmJibkEzbC9GcnpobzFzOTJmaTJwRkNHWkE5SlBOVkFrMGZ0Nms3?=
 =?utf-8?B?OXBYMDJnalhNM09xeWlvejY3bGxodW9yZ2lvV3F2dnREaTNEcFJrTE5uZFF2?=
 =?utf-8?B?YVEyT1ZNLytHZGtyNnRQUlE4NGdqdWxhWUwySEtIUnF3bGhienhhRXJMY1NL?=
 =?utf-8?B?ci93Tlh2MmRFWVQ3OUtIZ3pDSzBsWTNhMkt1eHZrekdieTVkQ0NJZTdDNjNZ?=
 =?utf-8?B?ekJIVjAvNitHUWJ4YTJjamRyYjg2NEEvTHlhRUg4dWx4b2VFc2QzazFSRnFx?=
 =?utf-8?B?dWxGM0ZOQXQ4WHlwRm1hTUs0N1duNUthWmovckU1RWRkMGg5YWFJa2RBK3Vj?=
 =?utf-8?B?aGlqU056RlNYRkR0Zkd0OXhUZ1lkcERYT2NrUitMNUI0eHk0eGZtaGV4RHhw?=
 =?utf-8?Q?Rvjc=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5646BC56D81469478E4713A31429530A@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 496a8e72-56dc-4c32-3de7-08dbf560498c
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 07:03:30.2348
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fyvfvqH9IJl9JEevQjn/X2pLnl/Mij5Wk7rb7blQlhgxcwEudbA0kzNf/Ly8Ut5iEWIG2uPEjQuM4Ofpp6hUsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5208
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgVGhvbWFzIEdsZWl4bmVyLA0KDQpUaGFuayB5b3UgZm9yIHJldmlldywgYW5kIHlvdSBhcmUg
cmlnaHQsIGl0IHNlZW1zIG1vcmUgbGlrZSBhIFhFTiBpbnRlcm5hbCBpc3N1ZS4gV2UgYXJlIGRp
c2N1c3NpbmcgaXQgYW5kIG1heWJlIHdpbGwgZml4IGl0IGluIFhlbiBjb2RlIG5leHQgdmVyc2lv
bi4NCg0KT24gMjAyMy8xMi80IDE2OjEzLCBUaG9tYXMgR2xlaXhuZXIgd3JvdGU6DQo+IE9uIEZy
aSwgTm92IDI0IDIwMjMgYXQgMTg6MzEsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMgYi9kcml2ZXJzL3hlbi94ZW4t
cGNpYmFjay9wY2lfc3R1Yi5jDQo+PiBpbmRleCA1YTk2YjZjNjZjMDcuLmI4M2QwMmJjYzc2YyAx
MDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMNCj4+ICsr
KyBiL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHViLmMNCj4+IEBAIC0zNTcsNiArMzU3
LDcgQEAgc3RhdGljIGludCBwY2lzdHViX21hdGNoKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAg
c3RhdGljIGludCBwY2lzdHViX2luaXRfZGV2aWNlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiAg
ew0KPj4gIAlzdHJ1Y3QgeGVuX3BjaWJrX2Rldl9kYXRhICpkZXZfZGF0YTsNCj4+ICsJc3RydWN0
IGlycV9kZXNjICpkZXNjID0gTlVMTDsNCj4+ICAJaW50IGVyciA9IDA7DQo+PiAgDQo+PiAgCWRl
dl9kYmcoJmRldi0+ZGV2LCAiaW5pdGlhbGl6aW5nLi4uXG4iKTsNCj4+IEBAIC0zOTksNiArNDAw
LDEyIEBAIHN0YXRpYyBpbnQgcGNpc3R1Yl9pbml0X2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2
KQ0KPj4gIAlpZiAoZXJyKQ0KPj4gIAkJZ290byBjb25maWdfcmVsZWFzZTsNCj4+ICANCj4+ICsJ
aWYgKHhlbl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdmhfZG9tYWluKCkpIHsNCj4+ICsJCWlm
IChkZXYtPmlycSA8PSAwIHx8ICEoZGVzYyA9IGlycV90b19kZXNjKGRldi0+aXJxKSkpDQo+IA0K
PiBEcml2ZXIgY29kZSBoYXMgYWJzb2x1dGVseSBubyBidXNpbmVzcyB0byBhY2Nlc3MgaXJxX2Rl
c2MuDQo+IA0KPj4gKwkJCWdvdG8gY29uZmlnX3JlbGVhc2U7DQo+PiArCQl1bm1hc2tfaXJxKGRl
c2MpOw0KPiANCj4gT3IgdG8gaW52b2tlIGFueSBpbnRlcm5hbCBmdW5jdGlvbi4NCj4gDQo+PiAt
LS0gYS9rZXJuZWwvaXJxL2NoaXAuYw0KPj4gKysrIGIva2VybmVsL2lycS9jaGlwLmMNCj4+IEBA
IC00MzksNiArNDM5LDcgQEAgdm9pZCB1bm1hc2tfaXJxKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykN
Cj4+ICAJCWlycV9zdGF0ZV9jbHJfbWFza2VkKGRlc2MpOw0KPj4gIAl9DQo+PiAgfQ0KPj4gK0VY
UE9SVF9TWU1CT0xfR1BMKHVubWFza19pcnEpOw0KPiANCj4gTm90IGdvaW5nIHRvIGhhcHBlbi4N
Cj4gDQo+PiAtLS0gYS9rZXJuZWwvaXJxL2lycWRlc2MuYw0KPj4gKysrIGIva2VybmVsL2lycS9p
cnFkZXNjLmMNCj4+IEBAIC0zODAsNyArMzgwLDcgQEAgc3RydWN0IGlycV9kZXNjICppcnFfdG9f
ZGVzYyh1bnNpZ25lZCBpbnQgaXJxKQ0KPj4gIHsNCj4+ICAJcmV0dXJuIG10cmVlX2xvYWQoJnNw
YXJzZV9pcnFzLCBpcnEpOw0KPj4gIH0NCj4+IC0jaWZkZWYgQ09ORklHX0tWTV9CT09LM1NfNjRf
SFZfTU9EVUxFDQo+PiArI2lmIGRlZmluZWQgQ09ORklHX0tWTV9CT09LM1NfNjRfSFZfTU9EVUxF
IHx8IGRlZmluZWQgQ09ORklHX1hFTl9QVkgNCj4gDQo+IE5laXRoZXIgdGhhdC4NCj4gDQo+IFRo
aXMgYWxsIHNtZWxscyBiYWRseSBsaWtlIGEgWEVOIGludGVybmFsIGlzc3VlIGFuZCB3ZSBhcmUg
bm90IGdvaW5nIHRvDQo+IGhhY2sgYXJvdW5kIGl0IGJ5IGV4cG9zaW5nIGludGVycnVwdCBpbnRl
cm5hbHMuDQo+IA0KPiBUaGFua3MsDQo+IA0KPiAgICAgICAgIHRnbHgNCg0KLS0gDQpCZXN0IHJl
Z2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==
