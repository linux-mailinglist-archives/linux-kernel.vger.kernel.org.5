Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76C39758ACC
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 03:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229945AbjGSBVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 21:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjGSBVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 21:21:34 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2054.outbound.protection.outlook.com [40.107.96.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE77D1BDB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 18:21:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oFk5fRjKkWDuLZ3npLB0SpCTKsRezApdKKvCnj/o4fEGdkY/1VXD+/rQuT45f/6i3rUeXhwZtDRMJcEECZf+KnSKt6MTkBZTzq+jbZD7aiNCs6iZjTa3WT3lgpDZd+GQWLZ7sbuZjaP0ogyFfCgsVcnFYxMOn25NuAX5L3jZqH2XLJXDHdzr09zrLdg8I7nNFfsxZaFXVQqmdcqAWFRwOAvhSyPdp5jXBp2FO8wI7lIANVNtrZ/tGM3tIyaPCl+nmu+iPvEpozUA5diDPP51ZiBMZyI1gEm/XnuaizuLBek0om8TVTPanb+E1B0PoNu5Tas2RQXgYDTiYQSMcjuUOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k8XF3XAfnvGpOWzzt1+bqMrpWFHaPZQPnwS9mSz+zyw=;
 b=WEo14qxSMX6Acr7wTLWupNwZkmTpnUmw3CiJsA6VxIYUZt+T9CSB5w4I23JMAYLgcCTo5McaHMLxs8fmAHxniEJz1iT6KwD/EZnWpvu2vENGOFY1xZwwPmoqb/00nkH2+lZWgGk9VMZ0MzRLjBppJdMwFwRo4TRvP4WTbvneU8KqhNKTMIpUT1wDOzHkdcwp8lzpaj++vOi2a8m7J1Whylfnita5o5o5Dcya03QYuD9beakeyCC7CwHi/UBSUs+ydQLkwF7DQj2k18Y7ez3zdCASRfnccBGJzYrfztubdx/U5DSI/tUvBQsDB8XypzPaKrSbFUzAZwCC9D7vK8Uygw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=k8XF3XAfnvGpOWzzt1+bqMrpWFHaPZQPnwS9mSz+zyw=;
 b=HPI4YBCs7qwLmWiXJzS53/ot537oD/FX/P0cE1cf3KJ1N+RQXg8+3p6V+Cgrbbn9l721PPu2Xc18A67RdKG1yLRc63+kCtqUdatSWTFXOvU5UOVF2h5BsN1OYZ6AT7lBWDEspT8Ps98doUHWZUQ0WIR7V+0mRUnGG324hi30a8I=
Received: from DM5PR12MB2469.namprd12.prod.outlook.com (2603:10b6:4:af::38) by
 SJ2PR12MB7893.namprd12.prod.outlook.com (2603:10b6:a03:4cc::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6588.32; Wed, 19 Jul 2023 01:21:27 +0000
Received: from DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225]) by DM5PR12MB2469.namprd12.prod.outlook.com
 ([fe80::72dd:353e:4775:1225%3]) with mapi id 15.20.6588.031; Wed, 19 Jul 2023
 01:21:26 +0000
From:   "Chen, Guchun" <Guchun.Chen@amd.com>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
CC:     "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Pelloux-Prayer, Pierre-Eric" <Pierre-eric.Pelloux-prayer@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Subject: RE: [bug/bisected] commit a2848d08742c8e8494675892c02c0d22acbe3cf8
 cause general protection fault, probably for non-canonical address
 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
Thread-Topic: [bug/bisected] commit a2848d08742c8e8494675892c02c0d22acbe3cf8
 cause general protection fault, probably for non-canonical address
 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN NOPTI
Thread-Index: AQHZuOcHK2HEfZ3U10uRZ9q0gZtajK++yLpwgAB2rACAAQyCwA==
Date:   Wed, 19 Jul 2023 01:21:26 +0000
Message-ID: <DM5PR12MB2469B5E374A545AB2205DF10F139A@DM5PR12MB2469.namprd12.prod.outlook.com>
References: <CABXGCsNc6mSOLHv1W5qPuvn56Yy0Bsjgg8X13qzg8uUwCaYkjw@mail.gmail.com>
 <DM5PR12MB24697E6B83397ADD6F8F6556F138A@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CABXGCsNXfk32HmEc+45qM7850N1PQhZS=2ypTkZhp9SpBJfxRA@mail.gmail.com>
In-Reply-To: <CABXGCsNXfk32HmEc+45qM7850N1PQhZS=2ypTkZhp9SpBJfxRA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ActionId=a415c433-2331-46bc-80a5-69bb0cecb2cd;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_ContentBits=0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Enabled=true;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Method=Privileged;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_Name=Public-AIP
 2.0;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SetDate=2023-07-19T01:18:03Z;MSIP_Label_d4243a53-6221-4f75-8154-e4b33a5707a1_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM5PR12MB2469:EE_|SJ2PR12MB7893:EE_
x-ms-office365-filtering-correlation-id: e8a84880-fd24-42a9-985b-08db87f67908
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IsPVLEAtOAEAT11eJRRa9eh+5bi5PGBU01kVDCqKtxcbCPDFwPd/j+9tS/xRGGGyIKhpSh+GA7bQuNLFPnhaThLTDQvIt9cJbM9NmgH8XkLeYRyEtL9m8v9v34WAojjvKuRZLEPdoOD8pePE3YBIz7XFuwgX52h75DMqhnYit5NoRxeKX5yHhOhIJzqOXcrWZJ6H8jwSjBSM84GzmECENEvxRcmSePshbmK+IpZ/Jk0W01dyQTp46Qt89yhYuVVFG7BO3GNYWsSgP3IvSlVVChXX0GbqRZerxe0qgpYCPUEY/1xqwtsCr/VPzGCpYDPOZ5/6OIiHd6ouessFV/RMRhdAAGS4GqxF2fLCOSjnStTq5pEtRjIQ4fO3k27zfR1aKODl1QXzK/l7GxLTfEpxG7HgPSTgU6ML9rQ7LD4nIIttPtCN6SZnoTpIDhawMlv96xnh+bOjINMugKDpLcHNtlrxJnDFhcECtVCaXL3wkLajVjrgm7cW2NDXDUAlP6ncWj6OK51+2W/U+g8bMFdYDKA7wsvQNm9uFY0rMDIbHiORfd+4m5rC/h/kaXGyVKv+ohluD7eKJUVhqivJ1NCLvZ1cFVKszkLenXZ3ykQYHUv2Q52oE0B5jAP+DuBolVFl
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB2469.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(376002)(346002)(136003)(366004)(451199021)(33656002)(6506007)(71200400001)(83380400001)(38100700002)(186003)(26005)(55016003)(478600001)(38070700005)(53546011)(54906003)(66476007)(41300700001)(7696005)(8676002)(66446008)(2906002)(8936002)(66556008)(6916009)(66946007)(966005)(52536014)(316002)(4326008)(5660300002)(9686003)(64756008)(86362001)(122000001)(76116006)(17413003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFyaUxkWDB1dlpZMFIrdnI1MkhWZThPSnA4Qm9nbWd3RU03aHhKc05Ceitj?=
 =?utf-8?B?b1NSS0QvYjZnSjBjY2xRUjBxNk1KN1hjQjNWbGdRT1llVVI5ZnNsRVZSWGV4?=
 =?utf-8?B?eFNzRE9FRWJ0VDRKUk84UE40QjJUMkxCMzBDcFd5YjVyQnZ5TFMreGRSZm9D?=
 =?utf-8?B?MjdLVStvOFEyVVZsaFVkZnRkMzRyT1NYNmM4VmJyNGpZRGNEVmlHR0RXMFlE?=
 =?utf-8?B?bGpEVGM0ZTBpdGdXNk14a0JVNEEydTlRUW1XTVJ0R080WUlkNU9ZK2dGZk5H?=
 =?utf-8?B?eGJrZFc2a2tKR2tCTVlkWHJWVGhWVjlqbU1KOWZqSnYxZEpITDhNbElTbXBF?=
 =?utf-8?B?WWNMUEIzYm9QNVZzTXBuL2RlYzlGdWlPWHlhMno0M2lSNFFES2ljamF2TERs?=
 =?utf-8?B?Ym1UV1E5dU5QSEt2RUIwcUFxN3JBUjNGeHNMMzEvRU10ajRNSVNoREM2UmEz?=
 =?utf-8?B?d1VSNk9zZWp0Vkg4aUlrVGw4NmtielRBNWpvaDRNd25aUGN6OXpZZ0FXTTlT?=
 =?utf-8?B?TEMvYkdtbncyVnMvVHVpbncrMmVEWHhxOTQzM2FIYk53Zy91WWJ5ak9SR3dq?=
 =?utf-8?B?T2pUeEJ4dzVjbFI3K295eWlkK1J2eWlscVBxbXhUK2RHTlFrTHNtVkIyVnox?=
 =?utf-8?B?KytuZHFTRWVJN2Fzd0pyd05oY1MvdmszaWJUVmlQRnoxdG9ZNFMwMms2SjNG?=
 =?utf-8?B?cUNrbWNBWFJoMWN0MzVVWkNqMldUbWh0SytjeEJ2REFSY2RXSGNRbFFrN2xC?=
 =?utf-8?B?MFZNc3pEcnRWQWZHUHFya1UrQkhoT1lBemFLU1UzdVlFL1kwdmpwR1VCKzR0?=
 =?utf-8?B?U1c4OHdjTjZLeEY5Y2MvdE5qNVRCbWVtaG5WcVA2NjlzSUxtU0hBR24wUVdL?=
 =?utf-8?B?dkFVUi8rc3hTNkhUUU5GQzh1VklLM21RTkxPY0tYcmpVclY0RjJ2WElVcFFy?=
 =?utf-8?B?ZTZucHNoRFRGNmFMNkMxMFM2TFU0aC9Hdm94QjlPaE1IOENXRzZoV3ZBM0pT?=
 =?utf-8?B?Q3NhZlJpcUIzMG5HRGVLVkpxdy85QkdPVitFb0lyNzA5T3V0QXBwcmRSNE5Y?=
 =?utf-8?B?MkVjSm5UVUo5VmMxK0YrUkJhSmE0ZXlDVW5kY2l6czVtM2F6VExVem5peCtB?=
 =?utf-8?B?VlRqU090a2RDZWVNOER4aWdQSTZkR2c0MkFmQlNrbENDNGI1b0F6UDArNWl2?=
 =?utf-8?B?RFRSY3k2eE9MY3l6VWdibVZzL0RLZjNCNDhxcm1UdDUxTHVVVDFWenBFdC9j?=
 =?utf-8?B?bE96dXIxcHdiUGkxbGZTcHFEekZoUGZZRDNnVHdlYzAzYno0blRaU2lEL2xJ?=
 =?utf-8?B?Z0NiR2llRWZ1V0IvUnlieWhoQnFtS0xnZ2NHMjh4SDNFSEZUWnFJWXBrVm1o?=
 =?utf-8?B?bFhSVENtVmhZcmY5bGRWMnZBVElYNUtRRldMaWR2M2VNZFZUNUQvTVBVdHQv?=
 =?utf-8?B?NkpEZk1GZEo3VklVeGJpNnRhUlE5OVd1MzJvMWdmUWdmcEJHTmJPZTdrTEJ4?=
 =?utf-8?B?Z3F2ZlVFWGZNRmNhamZkK1laQjdkUyt6SlZzaW5UMmZienE4eFoyR1B4QWc1?=
 =?utf-8?B?d1Vrdi82cCtZVVlmc090a3BTVlQrNm0rWVBPanY5bmE5cXJTY2F1dTJ5ODdl?=
 =?utf-8?B?RjdkdFVKOWZJLy9VN1NQZEU3SHNyMno4c01CSk5rbGxidEZUYzZlaXorWkt3?=
 =?utf-8?B?RGFHMTBRbjJxeTR2MTVHeWtqT3BKMVB0R1ppVGFvQno1NlFhZEJhV3R1NTBk?=
 =?utf-8?B?OW1XOFZaNWFrOFdOVlhMbmRzRHZ2MDZiZGR1TmxjSXBMSTFBYlpVV3BLVWRn?=
 =?utf-8?B?WmN3YUEyOGZKN2RaZGxTTFVmTFpzb2kya08yZWdhM1kxbmdwYS9LVFBxQnVF?=
 =?utf-8?B?aGRENFhndXBoTHVYZmlkVG9EYUFnbnJIOWp6Y2pHYUwyRWxGQThNOWpDZW81?=
 =?utf-8?B?R2lvT1daeU5pTnZISFVTNmR3djJGeVBoelUzWkhydWdBNmJvazJZdEpqQU11?=
 =?utf-8?B?eUlTMzBSa3c4N21zbVJGMTIvRVBpOElMcVNrVy95N2JVMENRVUVVR1M3MFoy?=
 =?utf-8?B?UFVuQWNOdnZVOWl1eFJMYmlIMU9iRnZkUXZZNytuS0E3VXdGMlVVWEJiMFhy?=
 =?utf-8?Q?gvlQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB2469.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8a84880-fd24-42a9-985b-08db87f67908
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jul 2023 01:21:26.4949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hJqCe3aQPG8gMH/8fFrieF5ypCEMFBX3f5bZRxJUXSy7zOFDGc3hcFkcP8dlnTz/hQ+M1Tm2X6aPBC+CGa5bXQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7893
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W1B1YmxpY10NCg0KVGhhbmsgZm9yIHlvdXIgdGVzdCwgTWlrZS4gQWZ0ZXIgZ2V0dGluZyBSQiBm
b3IgdGhpcyBwYXRjaCwgSSB3aWxsIGFzayBDaHJpc3RpYW4gdG8gYXBwbHkgaXQgdG8gY29ycmVz
cG9uZGluZyBicmFuY2hlcyBsaWtlIGRybS1taXNjLW5leHQuDQoNClJlZ2FyZHMsDQpHdWNodW4N
Cg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBNaWtoYWlsIEdhdnJpbG92
IDxtaWtoYWlsLnYuZ2F2cmlsb3ZAZ21haWwuY29tPg0KPiBTZW50OiBUdWVzZGF5LCBKdWx5IDE4
LCAyMDIzIDU6MTcgUE0NCj4gVG86IENoZW4sIEd1Y2h1biA8R3VjaHVuLkNoZW5AYW1kLmNvbT4N
Cj4gQ2M6IEtvZW5pZywgQ2hyaXN0aWFuIDxDaHJpc3RpYW4uS29lbmlnQGFtZC5jb20+OyBQZWxs
b3V4LVByYXllciwgUGllcnJlLQ0KPiBFcmljIDxQaWVycmUtZXJpYy5QZWxsb3V4LXByYXllckBh
bWQuY29tPjsgRGV1Y2hlciwgQWxleGFuZGVyDQo+IDxBbGV4YW5kZXIuRGV1Y2hlckBhbWQuY29t
PjsgYW1kLWdmeCBsaXN0IDxhbWQtDQo+IGdmeEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+OyBMaW51
eCBMaXN0IEtlcm5lbCBNYWlsaW5nIDxsaW51eC0NCj4ga2VybmVsQHZnZXIua2VybmVsLm9yZz4N
Cj4gU3ViamVjdDogUmU6IFtidWcvYmlzZWN0ZWRdIGNvbW1pdA0KPiBhMjg0OGQwODc0MmM4ZTg0
OTQ2NzU4OTJjMDJjMGQyMmFjYmUzY2Y4IGNhdXNlIGdlbmVyYWwgcHJvdGVjdGlvbg0KPiBmYXVs
dCwgcHJvYmFibHkgZm9yIG5vbi1jYW5vbmljYWwgYWRkcmVzcyAweGRmZmZmYzAwMDAwMDAwMDA6
IDAwMDAgWyMxXQ0KPiBQUkVFTVBUIFNNUCBLQVNBTiBOT1BUSQ0KPg0KPiBPbiBUdWUsIEp1bCAx
OCwgMjAyMyBhdCA3OjEz4oCvQU0gQ2hlbiwgR3VjaHVuIDxHdWNodW4uQ2hlbkBhbWQuY29tPg0K
PiB3cm90ZToNCj4gPg0KPiA+IFtQdWJsaWNdDQo+ID4NCj4gPiBIZWxsbyBNaWtlLA0KPiA+DQo+
ID4gSSBndWVzcyB0aGlzIHBhdGNoIGNhbiByZXNvbHZlIHlvdXIgcHJvYmxlbS4NCj4gPiBodHRw
czovL3BhdGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvNTQ3ODk3Lw0KPiA+DQo+ID4gUmVn
YXJkcywNCj4gPiBHdWNodW4NCj4gPg0KPg0KPiBUZXN0ZWQtYnk6IE1pa2hhaWwgR2F2cmlsb3Yg
PG1pa2hhaWwudi5nYXZyaWxvdkBnbWFpbC5jb20+IFRoYW5rcywgdGhlDQo+IGlzc3VlIHdhcyBn
b25lIHdpdGggdGhpcyBwYXRjaC4NCj4NCj4gSSBkaWRuJ3Qgc2F5IGFueXRoaW5nIGFib3ZlIGFi
b3V0IGhvdyB0byByZXByb2R1Y2UgdGhpcyBwcm9ibGVtLg0KPiBDYXNlIHdhcyBsaWtlIHRoaXM6
DQo+IE9uIGEgZHVhbCBHUFUgbGFwdG9wLCBJIHJhbiBHb29nbGUgQ2hyb21lIG9uIGEgZGlzY3Jl
dGUgZ3JhcGhpY3MgY2FyZC4NCj4gSSB1c2VkIGZvciBpdCB0aGlzIGNvbW1hbmQ6DQo+ICQgRFJJ
X1BSSU1FPTEgZ29vZ2xlLWNocm9tZS11bnN0YWJsZSAtLWRpc2FibGUtZmVhdHVyZXM9VnVsa2Fu
DQo+DQo+IC0tDQo+IEJlc3QgUmVnYXJkcywNCj4gTWlrZSBHYXZyaWxvdi4NCg==
