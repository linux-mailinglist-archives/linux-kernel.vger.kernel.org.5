Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64A9804A8F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjLEGqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:46:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344312AbjLEGqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:46:53 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2043.outbound.protection.outlook.com [40.107.243.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B123411F;
        Mon,  4 Dec 2023 22:46:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B7xmP18Ey6DfoIA6OfAXvMW1XpXHs67T1yajMz89LOC70jlGwPKIsql5w4akn5dOqMPWtMWRq73BtRHqoE27qnxmqiKeLp97Gm+EdwAj60HfAd+cCCKpgARoWGCeSXEA2z9ruJzz6ocU6FBQuA4KuU4Saly4tn4qgjOQI1T6AUZeV8W/yRmim4H+ZPp5vip0gfNFT+nsLOK4t8tfQKm0X/oVywCdSGpCXb3se6K4J+pFo6NpnL337m2jOyRn6+kIBRedW6BGWZMrRXJB6J0c616Kk7NaGWPd0HgPIUdt24j/Tlq+lOhKd1ok3M/Qd2pSSz1Hn3K1yqQ3Ep6zGG1mLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqx+cxsH1B7Jfs5EkBX9S2OoALgUZEXE8Euzheto1uA=;
 b=kXmfLl2pA0nDLhoTv4nd/QmOR4xSCHeMRcNSHI389XqUnNrkx2xznEJO3yiwAe9D/1hU/FQyUKIBXwwcpln7JQfSYDmoBBAaMIyT/O98NtLn+LfBeFD7m8Z2rQOiCs1a6pjwmBvO6l+nGq+w94kh4XIYqH1C5OKzZYPj6vVhpbv0/7SnoVgxixnblMJv2ZfYOU4yqgsvGre2lb+Bb8qrzp4BBfhNm54Ka46MCZRR4VOm4Ge7LsjLunSk/+DFLiceP/ee+XGDtDePB64dRBGm8U0CWEb01hyuN9I61uAwHWeXDqu9wozDGRYvwsy9vMrubiw69Zxq/uaTydH5wqZCuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqx+cxsH1B7Jfs5EkBX9S2OoALgUZEXE8Euzheto1uA=;
 b=RtjhcwZG8wR6knyyNC2bolj60geb+433wU35ohE//LX+IRlKp0+msPW8cCWDCSYmy4qC09l3pHQbxo+QZSwz7VsIMpFXMpVsBKDLIznDiVoMKlfwtWO8IxE+2Q9XfZ4b5MjXQMmqjhSu2NaN4KGFgaxpouWM4Yx1E3e5AuH1abY=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS7PR12MB6239.namprd12.prod.outlook.com (2603:10b6:8:95::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:46:56 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:46:56 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
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
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CSRC+AgADLdgCAALwOgIAAX9AAgAE42ICAA5dDgIAB2GiA
Date:   Tue, 5 Dec 2023 06:46:56 +0000
Message-ID: <BL1PR12MB584944749CEE372A1F475C62E785A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
In-Reply-To: <ZW2ptexPQXrWBiOS@macbook>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN0PR12MB6151.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS7PR12MB6239:EE_
x-ms-office365-filtering-correlation-id: 3449475d-4b3f-42d5-cdee-08dbf55df903
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ahry19Wj5T1NZ6e2CzVIR0tS+UNI9UdTPJ/rAb1q7wr/k3shsF4kEO8VPA0BPYzLlTrqd85pW68hWxd09wMhPJ3TbbXK7r0fuO3CJfTXh0wn1YdtPOqk4HMc+6MbU/c4AdC9Bp+SG8joq6tY2SQzx2kLDJOiasz521DqMWtqsKn1nlM8yc3Km5MhuWwFMg7M3px0hSm29CsKjlDe9qrMR7TepCSRYkrQDkLpqzJmqfkYjy5ayW8niMmjtX4kMb1OXO+ojZdedzbP4b8Gc0QMTiWzvYm7xlkAcadqd6efP8triG8OCJsrDmnwTUy/XerOHXvaQUPusuc6fVACyrFxuq+MqfVQZgBmbTkAkqT6NE3A3U855vFRgtb+NnyqfEbLvnwMSmSHa65cKf2KjBfCquuPAAUYCf2XSa3GogmzVXWiHF1rvM5tDmykEOnzI2K5OdR8vUhvFU5TKk/7zb3fF+SH/DjlJ2Qs4V5N2HFY/0CfvSPOhjK4flI9gBSxmvhKiZalRNOrv9YO7Kcn7KkBN4XGbsYkzpWpwPu6OsfwspC6rjySs+NMTqQDMSGTDPlA87NCGRf2A1cYGqaNUdawsCyl7FqWWfbbE5+W75G+50xZjaRky3gAWuxNTeO2C0HhnOCPAnaj/v399FQ+lxxdBURhnoKRxVd/2jwV/YTPZlw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(136003)(39860400002)(396003)(230922051799003)(230273577357003)(230173577357003)(64100799003)(1800799012)(451199024)(186009)(55016003)(122000001)(8676002)(8936002)(83380400001)(38100700002)(53546011)(7696005)(6506007)(9686003)(26005)(71200400001)(478600001)(316002)(64756008)(66556008)(54906003)(66476007)(76116006)(66446008)(110136005)(66946007)(33656002)(2906002)(38070700009)(41300700001)(52536014)(4326008)(5660300002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk9NNEY2NVhqa2kyWVVtWG9YRlpoSW1qbWw1OExnaFpaZzdDVzZPY3dUdkFh?=
 =?utf-8?B?YnBOd0doUHVOeU1PZUFSOWwyYzdpSzNvSmRWRHFFa0N6UEUwNzl2Zk9WY1lo?=
 =?utf-8?B?VEhOSit6V3k1YTNsMHZRNG1vdjJhSys3YS9kTHhmVFlrYkN4V2lKVXNHNnVZ?=
 =?utf-8?B?aWw3YXRFaDVVanFOWVlLUlBUSVBnV1ZkUjlVaUVvbDcybVpiM1p1T2Rsd3J4?=
 =?utf-8?B?MDJFYVVqOTExV3NHWFVUQUJ3b2h0cFdDaFBOQ0M4enArOEhCNzFWL0taRDlD?=
 =?utf-8?B?Q3dBRnBBSHFJdVVjbjBoK1M4RUF0dEtURFdtbmRoNkFCdCs5c0xXUmMxelEv?=
 =?utf-8?B?QklJZVc1SDhDbXVsZ2Q3M1l3cWQ0SWd0dDcyN1dtNUJiOWV5YVJnT05mUG1z?=
 =?utf-8?B?TGJxRFR4VXIyRDFOS1JPdVR6WGdkd1F1K3R3dXZNYXdJY0ljWkNpWkszYmlq?=
 =?utf-8?B?RzVGYUt3Mm1LZlNvVnBiYi9vU2lvM21yMEcycURvL3lzbWJFRjRQcEhaNVBG?=
 =?utf-8?B?cXZiUUl3MWF2dnFnRDNEZ1JYbEhCbnR1TG03TjhJNzZyYXFBRTRoMzl0SjZq?=
 =?utf-8?B?SEl1TWNvVDBzeTNDYXJHSi9kd1pjTDlrcHprN3B2SFVHRTE0UzQzSlBXcHk1?=
 =?utf-8?B?eDNrcDFJTWxCczhlZ0haeTRPYXVSNzhwV25EaGUzaTNBb2FrcXUyR0FUTExI?=
 =?utf-8?B?NnBJSjQzQ0JnVUlTUjR4b0tScW5rNGtMSDNsQ2J4MVVNQm9NMGlZYnpiakN6?=
 =?utf-8?B?UzVlaklYZjBlMTQ3RkNEd3UxNTBIb2lHbS83a3JTSk9xRjdzbW84ZEVSMis1?=
 =?utf-8?B?RU9nWXRlSmk2Q0lQOUxpbTJhak9yRzE1UFBPaC9yTXJFVEM2UmhJVzFtdk82?=
 =?utf-8?B?WnZLVlFWbHVEcDlzYTZhaHo3N1VSYnRHdG9PNlR0M05FdldIYXAwcTRaQXhD?=
 =?utf-8?B?c2p1dEdONVhGakZkVUhzUU5oSjY3cVhPeDJmeE81dFlraTF0NDZLdmFzT1VH?=
 =?utf-8?B?MDhIY1ZiYVM5Y2g1NnRXTGVqQVA1K09sL0IwNE1LcTJmYmtVNGxSK2RTRlJx?=
 =?utf-8?B?TmcwbVVCZmVocysyRk5xYmkvcVJrOWpDR25PSjl3aDZhNUNGeHFudTNVcnFk?=
 =?utf-8?B?RmNrdllsYVM0TUxDeWtKaEpxTkFLVEJVRTVKclNTam5hVzg1RTJFc2YzWSsr?=
 =?utf-8?B?SWNRcUN0S04zTWxZODM2RXl1Yk84ZVlFY01XRUpPVUMxNHk3TVd0YjBMN1dm?=
 =?utf-8?B?TFd4NzJmQnA0UjB0L05iaTNvVERaOGxxVU8xRlI5cWJEeTYvd25aUWRVa1R1?=
 =?utf-8?B?RkVIVDFpRnFCcDVNV0p3dnd6TnhFTUhMTnRMc2lvZEFkTXA4M0pEMExNZml3?=
 =?utf-8?B?VjJlcm9wNlJqakxNVlF1bXo0ZW1xSmR0azlBejBKMDhrWHFrVEFuTUYreVB5?=
 =?utf-8?B?QnFKMVNCSWhrZGM0bE1adEUvbVJEaCtsVE5LTXFXdFdqZkg2M09rcTNic05a?=
 =?utf-8?B?Y0VNdXhULzBDSGN6SW1OTDRDTUFTZnNnSC9UeUxLQXJvWGNZTG4wY2xjTHNi?=
 =?utf-8?B?Q1FxY2k1VjdkUzJ5alN2S0dkN25rTjFFZFZVdS84OGVuMzFWS0JjM2I4UWxH?=
 =?utf-8?B?K1dlT2UxcHBuN2s3dGVrRUl6ZERXSUYwOEJScDdnSHdEWjJBcE94YXhmNHZ3?=
 =?utf-8?B?VWlaQ2tMZjZKelhTNmhKRXJaK1ZFODErT2dWTlE0M012VlNpOWVyT1dVTk9G?=
 =?utf-8?B?bjljb3FZaHh2c3huMVJpbTRmd1ZKdmQ2TVRaaWZuWWdSaXRrM0M3UkVjTklR?=
 =?utf-8?B?ZzBrc1FmbGJzQWRBa0x6VEp4cXA5WlJJU1I1dTdzeldtaVBrRnd5bXRNSDFz?=
 =?utf-8?B?eEkzb0huc0d2SGRqWWV6YXAzZDFVWXRVcmhmZXBUVFdPK044NGFTKzVOQjJx?=
 =?utf-8?B?dVJxa3Z1U0kxeTEvVlVHNmlVV2tFd05HVU9DY3ZZMWZyUThPTzFnOU5xTzVw?=
 =?utf-8?B?Nmp5SExwMGJhNTdwZWdxMWpsVjZ6RkxYQjZBVkcraHlwRlJDLzdRTFE5VDc1?=
 =?utf-8?B?N2lzc1FrRGVseldFQnd3VWo0UUd0R1Yvdk9XU01aUjlWOFRLRW5tS2JuNkp0?=
 =?utf-8?Q?TG4U=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3A4E4569F409F84B9B4778209EADF3BB@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3449475d-4b3f-42d5-cdee-08dbf55df903
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:46:56.1161
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CucxFi4cN53Wsm7Yz37yBY8bNeWEnxhWEkpmx31AabUPdKzzOnjRTYw/T/J6M5zkia2NpHc71TeSq8LcQQxYnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6239
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy8xMi80IDE4OjI4LCBSb2dlciBQYXUgTW9ubsOpIHdyb3RlOg0KPiBPbiBGcmksIERl
YyAwMSwgMjAyMyBhdCAwNzozNzo1NVBNIC0wODAwLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6
DQo+PiBPbiBGcmksIDEgRGVjIDIwMjMsIFJvZ2VyIFBhdSBNb25uw6kgd3JvdGU6DQo+Pj4gT24g
VGh1LCBOb3YgMzAsIDIwMjMgYXQgMDc6MTU6MTdQTSAtMDgwMCwgU3RlZmFubyBTdGFiZWxsaW5p
IHdyb3RlOg0KPj4+PiBPbiBUaHUsIDMwIE5vdiAyMDIzLCBSb2dlciBQYXUgTW9ubsOpIHdyb3Rl
Og0KPj4+Pj4gT24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMDc6NTM6NTlQTSAtMDgwMCwgU3RlZmFu
byBTdGFiZWxsaW5pIHdyb3RlOg0KPj4+Pj4+IE9uIEZyaSwgMjQgTm92IDIwMjMsIEppcWlhbiBD
aGVuIHdyb3RlOg0KPj4+Pj4+PiBUaGlzIHBhdGNoIGlzIHRvIHNvbHZlIHR3byBwcm9ibGVtcyB3
ZSBlbmNvdW50ZXJlZCB3aGVuIHdlIHRyeSB0bw0KPj4+Pj4+PiBwYXNzdGhyb3VnaCBhIGRldmlj
ZSB0byBodm0gZG9tVSBiYXNlIG9uIFhlbiBQVkggZG9tMC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gRmly
c3QsIGh2bSBndWVzdCB3aWxsIGFsbG9jIGEgcGlycSBhbmQgaXJxIGZvciBhIHBhc3N0aHJvdWdo
IGRldmljZQ0KPj4+Pj4+PiBieSB1c2luZyBnc2ksIGJlZm9yZSB0aGF0LCB0aGUgZ3NpIG11c3Qg
Zmlyc3QgaGFzIGEgbWFwcGluZyBpbiBkb20wLA0KPj4+Pj4+PiBzZWUgWGVuIGNvZGUgcGNpX2Fk
ZF9kbV9kb25lLT54Y19kb21haW5faXJxX3Blcm1pc3Npb24sIGl0IHdpbGwgY2FsbA0KPj4+Pj4+
PiBpbnRvIFhlbiBhbmQgY2hlY2sgd2hldGhlciBkb20wIGhhcyB0aGUgbWFwcGluZy4gU2VlDQo+
Pj4+Pj4+IFhFTl9ET01DVExfaXJxX3Blcm1pc3Npb24tPnBpcnFfYWNjZXNzX3Blcm1pdHRlZCwg
ImN1cnJlbnQiIGlzIFBWSA0KPj4+Pj4+PiBkb20wIGFuZCBpdCByZXR1cm4gaXJxIGlzIDAsIGFu
ZCB0aGVuIHJldHVybiAtRVBFUk0uDQo+Pj4+Pj4+IFRoaXMgaXMgYmVjYXVzZSB0aGUgcGFzc3Ro
cm91Z2ggZGV2aWNlIGRvZXNuJ3QgZG8gUEhZU0RFVk9QX21hcF9waXJxDQo+Pj4+Pj4+IHdoZW4g
dGhheSBhcmUgZW5hYmxlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gU2Vjb25kLCBpbiBQVkggZG9tMCwg
dGhlIGdzaSBvZiBhIHBhc3N0aHJvdWdoIGRldmljZSBkb2Vzbid0IGdldA0KPj4+Pj4+PiByZWdp
c3RlcmVkLCBidXQgZ3NpIG11c3QgYmUgY29uZmlndXJlZCBmb3IgaXQgdG8gYmUgYWJsZSB0byBi
ZQ0KPj4+Pj4+PiBtYXBwZWQgaW50byBhIGRvbVUuDQo+Pj4+Pj4+DQo+Pj4+Pj4+IEFmdGVyIHNl
YXJjaGluZyBjb2Rlcywgd2UgY2FuIGZpbmQgbWFwX3BpcnEgYW5kIHJlZ2lzdGVyX2dzaSB3aWxs
IGJlDQo+Pj4+Pj4+IGRvbmUgaW4gZnVuY3Rpb24gdmlvYXBpY193cml0ZV9yZWRpcmVudC0+dmlv
YXBpY19od2RvbV9tYXBfZ3NpIHdoZW4NCj4+Pj4+Pj4gdGhlIGdzaShha2EgaW9hcGljJ3MgcGlu
KSBpcyB1bm1hc2tlZCBpbiBQVkggZG9tMC4gU28gdGhlIHByb2JsZW1zDQo+Pj4+Pj4+IGNhbiBi
ZSBjb25jbHVkZSB0byB0aGF0IHRoZSBnc2kgb2YgYSBwYXNzdGhyb3VnaCBkZXZpY2UgZG9lc24n
dCBiZQ0KPj4+Pj4+PiB1bm1hc2tlZC4NCj4+Pj4+Pj4NCj4+Pj4+Pj4gVG8gc29sdmUgdGhlIHVu
bWFza2UgcHJvYmxlbSwgdGhpcyBwYXRjaCBjYWxsIHRoZSB1bm1hc2tfaXJxIHdoZW4gd2UNCj4+
Pj4+Pj4gYXNzaWduIGEgZGV2aWNlIHRvIGJlIHBhc3N0aHJvdWdoLiBTbyB0aGF0IHRoZSBnc2kg
Y2FuIGdldCByZWdpc3RlcmVkDQo+Pj4+Pj4+IGFuZCBtYXBwZWQgaW4gUFZIIGRvbTAuDQo+Pj4+
Pj4NCj4+Pj4+Pg0KPj4+Pj4+IFJvZ2VyLCB0aGlzIHNlZW1zIHRvIGJlIG1vcmUgb2YgYSBYZW4g
aXNzdWUgdGhhbiBhIExpbnV4IGlzc3VlLiBXaHkgZG8NCj4+Pj4+PiB3ZSBuZWVkIHRoZSB1bm1h
c2sgY2hlY2sgaW4gWGVuPyBDb3VsZG4ndCB3ZSBqdXN0IGRvOg0KPj4+Pj4+DQo+Pj4+Pj4NCj4+
Pj4+PiBkaWZmIC0tZ2l0IGEveGVuL2FyY2gveDg2L2h2bS92aW9hcGljLmMgYi94ZW4vYXJjaC94
ODYvaHZtL3Zpb2FwaWMuYw0KPj4+Pj4+IGluZGV4IDRlNDBkMzYwOWEuLmRmMjYyYTRhMTggMTAw
NjQ0DQo+Pj4+Pj4gLS0tIGEveGVuL2FyY2gveDg2L2h2bS92aW9hcGljLmMNCj4+Pj4+PiArKysg
Yi94ZW4vYXJjaC94ODYvaHZtL3Zpb2FwaWMuYw0KPj4+Pj4+IEBAIC0yODcsNyArMjg3LDcgQEAg
c3RhdGljIHZvaWQgdmlvYXBpY193cml0ZV9yZWRpcmVudCgNCj4+Pj4+PiAgICAgICAgICAgICAg
aHZtX2RwY2lfZW9pKGQsIGdzaSk7DQo+Pj4+Pj4gICAgICB9DQo+Pj4+Pj4gIA0KPj4+Pj4+IC0g
ICAgaWYgKCBpc19oYXJkd2FyZV9kb21haW4oZCkgJiYgdW5tYXNrZWQgKQ0KPj4+Pj4+ICsgICAg
aWYgKCBpc19oYXJkd2FyZV9kb21haW4oZCkgKQ0KPj4+Pj4+ICAgICAgew0KPj4+Pj4+ICAgICAg
ICAgIC8qDQo+Pj4+Pj4gICAgICAgICAgICogTkI6IGRvbid0IGNhbGwgdmlvYXBpY19od2RvbV9t
YXBfZ3NpIHdoaWxlIGhvbGRpbmcgaHZtLmlycV9sb2NrDQo+Pj4+Pg0KPj4+Pj4gVGhlcmUgYXJl
IHNvbWUgaXNzdWVzIHdpdGggdGhpcyBhcHByb2FjaC4NCj4+Pj4+DQo+Pj4+PiBtcF9yZWdpc3Rl
cl9nc2koKSB3aWxsIG9ubHkgc2V0dXAgdGhlIHRyaWdnZXIgYW5kIHBvbGFyaXR5IG9mIHRoZQ0K
Pj4+Pj4gSU8tQVBJQyBwaW4gb25jZSwgc28gd2UgZG8gc28gb25jZSB0aGUgZ3Vlc3QgdW5tYXNr
IHRoZSBwaW4gaW4gb3JkZXINCj4+Pj4+IHRvIGFzc2VydCB0aGF0IHRoZSBjb25maWd1cmF0aW9u
IGlzIHRoZSBpbnRlbmRlZCBvbmUuICBBIGd1ZXN0IGlzDQo+Pj4+PiBhbGxvd2VkIHRvIHdyaXRl
IGFsbCBraW5kIG9mIG5vbnNlbnNlIHN0dWZmIHRvIHRoZSBJTy1BUElDIFJURSwgYnV0DQo+Pj4+
PiB0aGF0IGRvZXNuJ3QgdGFrZSBlZmZlY3QgdW5sZXNzIHRoZSBwaW4gaXMgdW5tYXNrZWQuDQo+
Pj4+Pg0KPj4+Pj4gT3ZlcmFsbCB0aGUgcXVlc3Rpb24gd291bGQgYmUgd2hldGhlciB3ZSBoYXZl
IGFueSBndWFyYW50ZWVzIHRoYXQNCj4+Pj4+IHRoZSBoYXJkd2FyZSBkb21haW4gaGFzIHByb3Bl
cmx5IGNvbmZpZ3VyZWQgdGhlIHBpbiwgZXZlbiBpZiBpdCdzIG5vdA0KPj4+Pj4gdXNpbmcgaXQg
aXRzZWxmIChhcyBpdCBoYXNuJ3QgYmVlbiB1bm1hc2tlZCkuDQo+Pj4+Pg0KPj4+Pj4gSUlSQyBQ
Q0kgbGVnYWN5IGludGVycnVwdHMgYXJlIGxldmVsIHRyaWdnZXJlZCBhbmQgbG93IHBvbGFyaXR5
LCBzbyB3ZQ0KPj4+Pj4gY291bGQgY29uZmlndXJlIGFueSBwaW5zIHRoYXQgYXJlIG5vdCBzZXR1
cCBhdCBiaW5kIHRpbWU/DQo+Pj4+DQo+Pj4+IFRoYXQgY291bGQgd29yay4NCj4+Pj4NCj4+Pj4g
QW5vdGhlciBpZGVhIGlzIHRvIG1vdmUgb25seSB0aGUgY2FsbCB0byBhbGxvY2F0ZV9hbmRfbWFw
X2dzaV9waXJxIGF0DQo+Pj4+IGJpbmQgdGltZT8gVGhhdCBtaWdodCBiZSBlbm91Z2ggdG8gcGFz
cyBhIHBpcnFfYWNjZXNzX3Blcm1pdHRlZCBjaGVjay4NCj4+Pg0KPj4+IE1heWJlLCBhbGJlaXQg
dGhhdCB3b3VsZCBjaGFuZ2UgdGhlIGJlaGF2aW9yIG9mIFhFTl9ET01DVExfYmluZF9wdF9pcnEN
Cj4+PiBqdXN0IGZvciBQVF9JUlFfVFlQRV9QQ0kgYW5kIG9ubHkgd2hlbiBjYWxsZWQgZnJvbSBh
IFBWSCBkb20wIChhcyB0aGUNCj4+PiBwYXJhbWV0ZXIgd291bGQgYmUgYSBHU0kgaW5zdGVhZCBv
ZiBhIHByZXZpb3VzbHkgbWFwcGVkIElSUSkuICBTdWNoDQo+Pj4gZGlmZmVyZW5jZSBqdXN0IGZv
ciBQVF9JUlFfVFlQRV9QQ0kgaXMgc2xpZ2h0bHkgd2VpcmQgLSBpZiB3ZSBnbyB0aGF0DQo+Pj4g
cm91dGUgSSB3b3VsZCByZWNvbW1lbmQgdGhhdCB3ZSBpbnN0ZWFkIGludHJvZHVjZSBhIG5ldyBk
bW9wIHRoYXQgaGFzDQo+Pj4gdGhpcyBzeW50YXggcmVnYXJkbGVzcyBvZiB0aGUgZG9tYWluIHR5
cGUgaXQncyBjYWxsZWQgZnJvbS4NCj4+DQo+PiBMb29raW5nIGF0IHRoZSBjb2RlIGl0IGlzIGNl
cnRhaW5seSBhIGJpdCBjb25mdXNpbmcuIE15IHBvaW50IHdhcyB0aGF0DQo+PiB3ZSBkb24ndCBu
ZWVkIHRvIHdhaXQgdW50aWwgcG9sYXJpdHkgYW5kIHRyaWdnZXIgYXJlIHNldCBhcHByb3ByaWF0
ZWx5DQo+PiB0byBhbGxvdyBEb20wIHRvIHBhc3Mgc3VjY2Vzc2Z1bGx5IGEgcGlycV9hY2Nlc3Nf
cGVybWl0dGVkKCkgY2hlY2suIFhlbg0KPj4gc2hvdWxkIGJlIGFibGUgdG8gZmlndXJlIG91dCB0
aGF0IERvbTAgaXMgcGVybWl0dGVkIHBpcnEgYWNjZXNzLg0KPiANCj4gVGhlIGxvZ2ljIGlzIGNl
cnRhaW5seSBub3Qgc3RyYWlnaHRmb3J3YXJkLCBhbmQgaXQgY291bGQgYmVuZWZpdCBmcm9tDQo+
IHNvbWUgY29tbWVudHMuDQo+IA0KPiBUaGUgaXJxIHBlcm1pc3Npb25zIGFyZSBhIGJpdCBzcGVj
aWFsLCBpbiB0aGF0IHRoZXkgZ2V0IHNldHVwIHdoZW4gdGhlDQo+IElSUSBpcyBtYXBwZWQuDQo+
IA0KPiBUaGUgcHJvYmxlbSBob3dldmVyIGlzIG5vdCBzbyBtdWNoIHdpdGggSVJRIHBlcm1pc3Np
b25zLCB0aGF0IHdlIGNhbg0KPiBpbmRlZWQgc29ydCBvdXQgaW50ZXJuYWxseSBpbiBYZW4uICBT
dWNoIGNoZWNrIGluIGRvbTAgaGFzIHRoZSBzaWRlDQo+IGVmZmVjdCBvZiBwcmV2ZW50aW5nIHRo
ZSBJUlEgZnJvbSBiZWluZyBhc3NpZ25lZCB0byBhIGRvbVUgd2l0aG91dCB0aGUNCj4gaGFyZHdh
cmUgc291cmNlIGJlaW5nIHByb3Blcmx5IGNvbmZpZ3VyZWQgQUZBSUNULg0KPiANCj4+DQo+PiBT
byB0aGUgaWRlYSB3YXMgdG8gbW92ZSB0aGUgY2FsbCB0byBhbGxvY2F0ZV9hbmRfbWFwX2dzaV9w
aXJxKCkgZWFybGllcg0KPj4gc29tZXdoZXJlIGJlY2F1c2UgYWxsb2NhdGVfYW5kX21hcF9nc2lf
cGlycSBkb2Vzbid0IHJlcXVpcmUgdHJpZ2dlciBvcg0KPj4gcG9sYXJpdHkgdG8gYmUgY29uZmln
dXJlZCB0byB3b3JrLiBCdXQgdGhlIHN1Z2dlc3Rpb24gb2YgZG9pbmcgaXQgYQ0KPj4gImJpbmQg
dGltZSIgKG1lYW5pbmc6IFhFTl9ET01DVExfYmluZF9wdF9pcnEpIHdhcyBhIGJhZCBpZGVhLg0K
Pj4NCj4+IEJ1dCBtYXliZSB3ZSBjYW4gZmluZCBhbm90aGVyIGxvY2F0aW9uLCBtYXliZSB3aXRo
aW4NCj4+IHhlbi9hcmNoL3g4Ni9odm0vdmlvYXBpYy5jLCB0byBjYWxsIGFsbG9jYXRlX2FuZF9t
YXBfZ3NpX3BpcnEoKSBiZWZvcmUNCj4+IHRyaWdnZXIgYW5kIHBvbGFyaXR5IGFyZSBzZXQgYW5k
IGJlZm9yZSB0aGUgaW50ZXJydXB0IGlzIHVubWFza2VkLg0KPj4NCj4+IFRoZW4gd2UgY2hhbmdl
IHRoZSBpbXBsZW1lbnRhdGlvbiBvZiB2aW9hcGljX2h3ZG9tX21hcF9nc2kgdG8gc2tpcCB0aGUN
Cj4+IGNhbGwgdG8gYWxsb2NhdGVfYW5kX21hcF9nc2lfcGlycSwgYmVjYXVzZSBieSB0aGUgdGlt
ZQ0KPj4gdmlvYXBpY19od2RvbV9tYXBfZ3NpIHdlIGFzc3VtZSB0aGF0IGFsbG9jYXRlX2FuZF9t
YXBfZ3NpX3BpcnEgaGFkDQo+PiBhbHJlYWR5IGJlZW4gZG9uZS4NCj4gDQo+IEJ1dCB0aGVuIHdl
IHdvdWxkIGVuZCB1cCBpbiBhIHNpdHVhdGlvbiB3aGVyZSB0aGUNCj4gcGlycV9hY2Nlc3NfcGVy
bWl0dGVkKCkgY2hlY2sgd2lsbCBwYXNzLCBidXQgdGhlIElPLUFQSUMgcGluIHdvbid0IGJlDQo+
IGNvbmZpZ3VyZWQsIHdoaWNoIEkgdGhpbmsgaXQncyBub3Qgd2hhdCB3ZSB3YW50Lg0KPiANCj4g
T25lIG9wdGlvbiB3b3VsZCBiZSB0byBhbGxvdyBtcF9yZWdpc3Rlcl9nc2koKSB0byBiZSBjYWxs
ZWQgbXVsdGlwbGUNCj4gdGltZXMsIGFuZCB1cGRhdGUgdGhlIElPLUFQSUMgcGluIGNvbmZpZ3Vy
YXRpb24gYXMgbG9uZyBhcyB0aGUgcGluIGlzDQo+IG5vdCB1bm1hc2tlZC4gIFRoYXQgd291bGQg
cHJvcGFnYXRlIGVhY2ggZG9tMCBSVEUgdXBkYXRlIHRvIHRoZQ0KPiB1bmRlcmx5aW5nIElPLUFQ
SUMuICBIb3dldmVyIHN1Y2ggYXBwcm9hY2ggcmVsaWVzIG9uIGRvbTAgY29uZmlndXJpbmcNCj4g
YWxsIHBvc3NpYmxlIElPLUFQSUMgcGlucywgZXZlbiBpZiBubyBkZXZpY2Ugb24gZG9tMCBpcyB1
c2luZyB0aGVtLCBJDQo+IHRoaW5rIGl0J3Mgbm90IGEgdmVyeSByZWxpYWJsZSBvcHRpb24uDQo+
IA0KPiBBbm90aGVyIG9wdGlvbiB3b3VsZCBiZSB0byBtb2RpZnkgdGhlIHRvb2xzdGFjayB0byBz
ZXR1cCB0aGUgR1NJDQo+IGl0c2VsZiB1c2luZyB0aGUgUEhZU0RFVk9QX3NldHVwX2dzaSBoeXBl
cmNhbGwuICBBcyBzYWlkIGluIGEgcHJldmlvdXMNCj4gZW1haWwsIHNpbmNlIHdlIG9ubHkgY2Fy
ZSBhYm91dCBQQ0kgZGV2aWNlIHBhc3N0aHJvdWdoIHRoZSBsZWdhY3kgSU5UeA0KPiBzaG91bGQg
YWx3YXlzIGJlIGxldmVsIHRyaWdnZXJlZCBhbmQgbG93IHBvbGFyaXR5Lg0KDQpJIGFtIHRoaW5r
aW5nIGlmIHdlIGNhbiBkbyBQSFlTREVWT1BfbWFwX3BpcnEgYW5kIFBIWVNERVZPUF9zZXR1cF9n
c2kgb25seSBmb3IgcGFzc3Rocm91Z2ggZGV2aWNlcyhpbiBmdW5jdGlvbiBwY2lzdHViX2luaXRf
ZGV2aWNlKS4NClRoZW4gaXQgY2FuIHBhc3MgcGVybWlzc2lvbiBjaGVjayBhbmQgc2V0dXAgZ3Np
IHdpdGhvdXQgYWZmZWN0aW5nIG90aGVyIGRldmljZXMgdGhhdCBkbyBub3QgdXNlIElPLUFQSUMg
cGlucy4NCldoYXQgZG8geW91IHRoaW5rPw0KDQo+IA0KPj4gSSBhbSBub3QgZmFtaWxpYXIgd2l0
aCB2aW9hcGljLmMgYnV0IHRvIGdpdmUgeW91IGFuIGlkZWEgb2Ygd2hhdCBJIHdhcw0KPj4gdGhp
bmtpbmc6DQo+Pg0KPj4NCj4+IGRpZmYgLS1naXQgYS94ZW4vYXJjaC94ODYvaHZtL3Zpb2FwaWMu
YyBiL3hlbi9hcmNoL3g4Ni9odm0vdmlvYXBpYy5jDQo+PiBpbmRleCA0ZTQwZDM2MDlhLi4xNmQ1
NmZlODUxIDEwMDY0NA0KPj4gLS0tIGEveGVuL2FyY2gveDg2L2h2bS92aW9hcGljLmMNCj4+ICsr
KyBiL3hlbi9hcmNoL3g4Ni9odm0vdmlvYXBpYy5jDQo+PiBAQCAtMTg5LDE0ICsxODksNiBAQCBz
dGF0aWMgaW50IHZpb2FwaWNfaHdkb21fbWFwX2dzaSh1bnNpZ25lZCBpbnQgZ3NpLCB1bnNpZ25l
ZCBpbnQgdHJpZywNCj4+ICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAgICAgIH0NCj4+ICANCj4+
IC0gICAgcmV0ID0gYWxsb2NhdGVfYW5kX21hcF9nc2lfcGlycShjdXJyZCwgcGlycSwgJnBpcnEp
Ow0KPj4gLSAgICBpZiAoIHJldCApDQo+PiAtICAgIHsNCj4+IC0gICAgICAgIGdwcmludGsoWEVO
TE9HX1dBUk5JTkcsICJ2aW9hcGljOiBlcnJvciBtYXBwaW5nIEdTSSAldTogJWRcbiIsDQo+PiAt
ICAgICAgICAgICAgICAgICBnc2ksIHJldCk7DQo+PiAtICAgICAgICByZXR1cm4gcmV0Ow0KPj4g
LSAgICB9DQo+PiAtDQo+PiAgICAgIHBjaWRldnNfbG9jaygpOw0KPj4gICAgICByZXQgPSBwdF9p
cnFfY3JlYXRlX2JpbmQoY3VycmQsICZwdF9pcnFfYmluZCk7DQo+PiAgICAgIGlmICggcmV0ICkN
Cj4+IEBAIC0yODcsNiArMjc5LDE3IEBAIHN0YXRpYyB2b2lkIHZpb2FwaWNfd3JpdGVfcmVkaXJl
bnQoDQo+PiAgICAgICAgICAgICAgaHZtX2RwY2lfZW9pKGQsIGdzaSk7DQo+PiAgICAgIH0NCj4+
ICANCj4+ICsgICAgaWYgKCBpc19oYXJkd2FyZV9kb21haW4oZCkgKSANCj4+ICsgICAgew0KPj4g
KyAgICAgICAgaW50IHBpcnEgPSBnc2ksIHJldDsNCj4+ICsgICAgICAgIHJldCA9IGFsbG9jYXRl
X2FuZF9tYXBfZ3NpX3BpcnEoY3VycmQsIHBpcnEsICZwaXJxKTsNCj4+ICsgICAgICAgIGlmICgg
cmV0ICkNCj4+ICsgICAgICAgIHsNCj4+ICsgICAgICAgICAgICBncHJpbnRrKFhFTkxPR19XQVJO
SU5HLCAidmlvYXBpYzogZXJyb3IgbWFwcGluZyBHU0kgJXU6ICVkXG4iLA0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgZ3NpLCByZXQpOw0KPj4gKyAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiAr
ICAgICAgICB9DQo+PiArICAgIH0NCj4+ICAgICAgaWYgKCBpc19oYXJkd2FyZV9kb21haW4oZCkg
JiYgdW5tYXNrZWQgKQ0KPj4gICAgICB7DQo+PiAgICAgICAgICAvKg0KPiANCj4gQXMgc2FpZCBh
Ym92ZSwgc3VjaCBhcHByb2FjaCByZWxpZXMgb24gZG9tMCB3cml0aW5nIHRvIHRoZSBJTy1BUElD
IFJURQ0KPiBvZiBsaWtlbHkgZWFjaCBJTy1BUElDIHBpbiwgd2hpY2ggaXMgSU1PIG5vdCBxdWl0
ZSByZWxpYWJsZS4gIEluIHRoZXJlDQo+IGFyZSB0d28gZGlmZmVyZW50IGlzc3VlcyBoZXJlIHRo
YXQgbmVlZCB0byBiZSBmaXhlZCBmb3IgUFZIIGRvbTA6DQo+IA0KPiAgLSBGaXggdGhlIFhFTl9E
T01DVExfaXJxX3Blcm1pc3Npb24gcGlycV9hY2Nlc3NfcGVybWl0dGVkKCkgY2FsbCB0bw0KPiAg
ICBzdWNjZWVkIGZvciBhIFBWSCBkb20wLCBldmVuIGlmIGRvbTAgaXMgbm90IHVzaW5nIHRoZSBH
U0kgaXRzZWxmLg0KPiANCj4gIC0gQ29uZmlndXJlIElPLUFQSUMgcGlucyBmb3IgUENJIGludGVy
cnVwdHMgZXZlbiBpZiBkb20wIGlzIG5vdCB1c2luZw0KPiAgICB0aGUgSU8tQVBJQyBwaW4gaXRz
ZWxmLg0KPiANCj4gRmlyc3Qgb25lIG5lZWRzIHRvIGJlIGZpeGVkIGludGVybmFsbHkgaW4gWGVu
LCBzZWNvbmQgb25lIHdpbGwgcmVxdWlyZQ0KPiB0aGUgdG9vbHN0YWNrIHRvIGlzc3VlIGFuIGV4
dHJhIGh5cGVyY2FsbCBpbiBvcmRlciB0byBlbnN1cmUgdGhlDQo+IElPLUFQSUMgcGluIGlzIHBy
b3Blcmx5IGNvbmZpZ3VyZWQuDQo+IA0KPiBUaGFua3MsIFJvZ2VyLg0KDQotLSANCkJlc3QgcmVn
YXJkcywNCkppcWlhbiBDaGVuLg0K
