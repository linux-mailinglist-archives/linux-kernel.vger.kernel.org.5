Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D509579CE94
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:41:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234231AbjILKlw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:41:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230223AbjILKlu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:41:50 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8EFC9F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 03:41:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gg87UJVq1VpvWo+1Gtc/21fWAxCKfNFymofIg9lnTpRlM8t0o2h79txLVFZ1zoIkhycWZ53ibd+h+0WmKvzxpjH32mjrIzgTtRs6SKgTWK4iCO/fMp6thkojjiZLT7EutOtDrsz27RsLm7MsbHIZ94Q9R90wMYXQU9L0BXPcJHEOM8c09F4UE0TFXlfy/5nz+N7eksJgMIPxLQYrlM58pYIOqETguUbe0sJJJ1sUWATnbsfG3CMpsOlujtgrEm6dRLGC2D78/bmoeXq2gOhE3lG+uQXShZAKrxUGcPLoo0OhNlYM++0ar4favnBfM8cdHyvRUI4VFXx674PeAeNENQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8WCfv6PYVrzH7sFdct+PEjVQq8bt//ab8e7npl9ye5M=;
 b=Mbm3YxGkWcNHGlqAY/2q1LoRdjvv4A/46yAtaxFduATKflLhrrJkKIYnzZ3iTw8Za5TxTwrk5S93Y+TOQ1nTJ43Op2WbeSUXvNOMDQwrCrHRBCkluA+n/XPKMtWQlfOkuvDmBsDThjDD/CdHY8NaP2ni/W77Nok5u8g0LJOPR+OOYRbLbAV7pR/Va1E6qCSy94uEIJlPuS/7vCSDOb5rY+Fd5r1SUNaktvO6ERaV5dJcQYKBJcEoiUxeoR/ujK1+ft8z0zuqFXTjsazqSsbWoHv3GuUZ6BCNeKN2vBv1brAw8KD/+uiGvy9phJqaMa1NPvQOqLp5UfQrerMLgZGOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8WCfv6PYVrzH7sFdct+PEjVQq8bt//ab8e7npl9ye5M=;
 b=CP3EEXkp7H8FLsxR0BX7UcabiOoIQpNG/3mH0wvdytiCJLnNG6idjIv9exU6ZgceWINuhLlsbDjJtvDFoH+4Fvyvs7qRyqp+ecrpu3at8axThebhrSQAwEM9T2dDijLFEKiJuwC7fyGX8wLh5mDQZ8W0wyGHSzE8sPVYhXc5aiE=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DM4PR12MB8523.namprd12.prod.outlook.com (2603:10b6:8:18e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6768.37; Tue, 12 Sep
 2023 10:41:43 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::c838:299:8697:dd70]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::c838:299:8697:dd70%5]) with mapi id 15.20.6768.029; Tue, 12 Sep 2023
 10:41:43 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Parav Pandit <parav@nvidia.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>
CC:     "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>,
        "Chen, Jiqian" <Jiqian.Chen@amd.com>
Subject: Re: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add new
 feature flag VIRTIO_GPU_F_FREEZE_S3
Thread-Topic: [virtio-dev] [RESEND VIRTIO GPU PATCH v3 1/1] virtio-gpu: Add
 new feature flag VIRTIO_GPU_F_FREEZE_S3
Thread-Index: AQHZ5Jd4vAiT0dEvAkWqbdFs9IHp77AV0i8AgAGupwA=
Date:   Tue, 12 Sep 2023 10:41:42 +0000
Message-ID: <BL1PR12MB584954DC1D5864E853150BCEE7F1A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20230911100430.1408168-1-Jiqian.Chen@amd.com>
 <20230911100430.1408168-2-Jiqian.Chen@amd.com>
 <FR0P281MB286152665C939C9CE291CE63BCF2A@FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM>
In-Reply-To: <FR0P281MB286152665C939C9CE291CE63BCF2A@FR0P281MB2861.DEUP281.PROD.OUTLOOK.COM>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: BL1PR12MB5849.namprd12.prod.outlook.com
 (15.20.6768.024)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DM4PR12MB8523:EE_
x-ms-office365-filtering-correlation-id: 3ea494d3-087d-4624-b828-08dbb37cdaac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3ReZFb1ZiV+z6W7Ny+xz/cziNQGsJWgGvjRd4ebIiARKtf73UJm3R4tfsmgGa/IzoWjbpkChAA64nj9IGBwDM8kxqCx2J9HwnRYIogerSZP5bhiV7vPus738KptNx24QhwRO6eEyQOCa++DOGRSteQc1CmQ3XM0HQLT97DHIcO7Fvd+Gi7M++DHeZFIdNDjZqCX4suopbL60SX73ubdYUvOJLdyCdASyzmtda9LzlAVt8+LQvOk1ZR2ItCDw6i2csua3RU3W8nKbCx0AbjjAiUSBwG6cD0etSmYCRTQGJXaZsbFEapWtRzbZ/mUMkWpq7CbL4HZWRtfBZiMsnxOqWh9/4rXH+x3IRk9EyKgNSSi5LpAUuXpywPeeMOOfVlPEmZyUQnlrHoPBxiAN/e5St5vAfpBqhGYAmPGdz9Wd1lU/0Ezj/Llk8RZZDU6hqInnj2isx49FIkemPY+1uGrkdgDAverHW7TuMW1716YYEtAxvE1U1UfRsBhsQMZHeFSXOySMkkIA7eRSHwpOo0Mg20lOYgrHDN30KGpnWrMGGaVc+kyN+OFiQ6z+7lIESU0BONZ3lqw7RlA52kh+w7Tuwz30i2VISKi6elCNvt9HijY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(136003)(39860400002)(396003)(186009)(1800799009)(451199024)(83380400001)(26005)(5660300002)(52536014)(41300700001)(8676002)(8936002)(4326008)(53546011)(7696005)(6506007)(9686003)(33656002)(66574015)(478600001)(122000001)(55016003)(110136005)(38070700005)(38100700002)(966005)(71200400001)(66899024)(76116006)(316002)(66446008)(54906003)(64756008)(66946007)(66476007)(66556008)(2906002)(15974865002)(7416002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OHRONUU1SnhwYkxFbjdoUnNNMVdDbFVWTC9xcU0yNUpteTVHVDRRNXRwVFZm?=
 =?utf-8?B?Qkk3Vm1CNTc2OEtQbkNvRXBaL1drTjJYeGVrdlVpZW9iWlA4WkZmSEwxQlZw?=
 =?utf-8?B?MENYUFBENHVLcmRyNm9mTXVEaUJMdTd6U3RUS1hGU0pkOHQ3SlZKWkt0TmxS?=
 =?utf-8?B?c0dZdktuUEtDcFJBaWZQa3M5eFdNY0tXUzhoeUpOUDhRRzlYZk1oM2Erditk?=
 =?utf-8?B?Z2ZMQmoyMkdENEk0Nkw2Mzh0R3JPSjNFb3hOWHc3SVlxVUUyMWw1UGpZMDNn?=
 =?utf-8?B?ZnlPdnZRY2tDTEt5M2NLUHNiYWp2THJVUm5YcEpNMWZLZmttcmV3alIxcnY2?=
 =?utf-8?B?K1F4cW9NcVl1SXNFcDB2TUlXdjQ5djJXMkNBV3VFd3EyeGZNY3N5RDVJZGN0?=
 =?utf-8?B?MGNhWmhteGZ3UzREVi9KNFZ4aU1Zek9NcmFEQTVyalBreVRoc3hBOTlKeVNt?=
 =?utf-8?B?SWZmN2pnMUZlY0p0cWRnNkMwYkFnSi9UVitJRjZiblNyNE1tZEZSMnQ3aVpU?=
 =?utf-8?B?MllUM3J0SWdqUDZ2VmU2YUdwYWpmL2FIazVkNGR4a3ZFaGltYUdCSEFnOXln?=
 =?utf-8?B?Vi9mWGFyUk5RWmJyT3NlS3orb1dabHNWOGtnWXBqaFB2ck9kUUtVRUJYdHli?=
 =?utf-8?B?T29GZ0t3bHBnbVNsRnZaSFo0aFBWZmFFbUxueUd3ZFNHWFpJc0c0NXVOTVk5?=
 =?utf-8?B?R3dQOXh6THZWdEVlM1M3U2lCVmxubWNnRWpRdFBxZjcrY2lSWGhkeis4Z24z?=
 =?utf-8?B?eU5iOHE3b01oS09JUCsvVEE4UUYzY2o2NFkrZFNBMytrRTkzTXBsOEt1VGN4?=
 =?utf-8?B?dWp3SWJzVGJRVENwWXhYQkkwUDlSYmZGcVI0cnJiTzhVZkY1ZmN6MVlvMzln?=
 =?utf-8?B?NVMrc1p5aXhJY2JqTnFiaDI2UWpsMit3K3JFTFpMTDN1ZFlTTTBmU1dIZndT?=
 =?utf-8?B?N1lNTzBvekRIc1BMYmdlQkp2K2k5N1BiMmVHYm5ld0RHRTBvdWpXODM4bTJy?=
 =?utf-8?B?UzMvd0s0V0VkR25FQUVUSmdtZ292QW5kc3ExdDM3OW1QWFVPZXlpMkcrWE1y?=
 =?utf-8?B?Q3JtU3RYakVQeVZ5QllsNDl4cGhrdU1KeTRkdTNnU3ZDZGpzM0JUcGJiSUYr?=
 =?utf-8?B?OVE4Qks5SFJTRDNOTDdKRkdGTG1NYVM3b0FrMEI2WUEzT090YXMrSXlVVnN3?=
 =?utf-8?B?WUdUOEZmMHpheGVWNlpvUkcrbi9JRWtKeVBKVEEzem9mSEplRkRYaE5vWm5P?=
 =?utf-8?B?cWZQTHVGdjlWbTFUbUpiSlA2SFBRUW9ZUGtQdlVIZ3RRcFZnUGhYTk1yVlhr?=
 =?utf-8?B?VTJwOFF3eU9lbnU1bTNmSldMK0d6aWJtZ3FLK3FaL3VxR3dnaVlubFVkemdP?=
 =?utf-8?B?c0pkSk5ONW9sa0tPb3dKTkhOWWxRWkdOanNJMkNmZ3VxQVplS2IxcWhTYjVj?=
 =?utf-8?B?ZER3TkF4UytNamZ3OWVHYW9WUHcrZjhlMEUwdzZGQ0JpNkVDUUZZUHRaajFI?=
 =?utf-8?B?M0luc3h0dUpjL1Q3NXpPemg2R3gvUHBMM3AvK3A1ZFdXRGFaaVN1RlBuYzZw?=
 =?utf-8?B?VW5ZWjNhbitZUVRDLzVDUXRXclRUUGxpYXdlaUVleGE5WGJ0Y1pEQkFFaXJ0?=
 =?utf-8?B?MjBhOHc4RldiVXgzekt0cEllZXZ6SHgrME5zMWJPMlI0YlJKamg3cHRzSHEx?=
 =?utf-8?B?UGRyUDFmTVBZd3FvRDNQTkFBT1NrSHlSMGVmVWlyM25NNHlscm95dGcxTEJI?=
 =?utf-8?B?VWQxMFlXRExVUllkSWZ4VzNEY2VOejdZVndCTjNueGJNSU10TlZScDFwcjJZ?=
 =?utf-8?B?RDBMSzRlVlBPZHoxRHdpbzV6NVFaNWZaQUt1RXN0TXMzVUV1OWRpbWZEOTkz?=
 =?utf-8?B?ajFnTXh3YjJlWUVlcFkxSHZHSFk2cTdRYTlicDl4WWFSTTlMSGVzemFXZlVI?=
 =?utf-8?B?UEJmcDBmV2FtbjVuZDlnUVpWSndWSnovT21oUDBFMmM4aWZSazk3ekhEbzVq?=
 =?utf-8?B?OE1RbCtrRXFyRm5iNTdvM3dUelg4RmUwQU4yR2RPdkpEQWdXSnR5cmZ4aXFW?=
 =?utf-8?B?OW9Wd1hidzVEYmVvTUcwV2xHeDVHa3AvK2dJY2hxeEp0cmhwcGNqQ3BJbFcv?=
 =?utf-8?Q?9Xo0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7EF4590E2568FF488E2D2367AA6D70BF@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ea494d3-087d-4624-b828-08dbb37cdaac
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Sep 2023 10:41:42.8690
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I3r7mj2T3xaYfaDmEkvEytVTDErx4Xxd9oXdWeNEFEtpKzghYtMkOe5sspyUGga2c6JaJk2lLVR0FAyspCOiGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8523
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgTWlraGFpbCBHb2x1YmV2LUNpdWNoZWEsDQoNCk9uIDIwMjMvOS8xMiAwMDozMywgTWlraGFp
bCBHb2x1YmV2LUNpdWNoZWEgd3JvdGU6DQo+IEhpIEppcWlhbiwNCj4gDQo+IFRoYW5rcyBmb3Ig
dGhlIHByb3Bvc2FsLg0KPiANCj4gU29tZSB0aW1lIGFnbyBJIHdhcyB3b3JraW5nIG9uIHRoZSBz
YW1lIGlzc3VlIHdpdGggc3VzcGVuZGluZyB0aGUgZ3B1IGRldmljZQ0KPiAob24gYXJtKS4gIEFk
ZGl0aW9uYWxseSwgSSBoYWQgdHJvdWJsZXMgd2l0aCB2aXJ0aW8tdmlkZW8gZGV2aWNlIGFzIHdl
bGwsIHNlZQ0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjExMjE1MTcyNzM5LkdB
NzcyMjVAb3BlbnN5bmVyZ3kuY29tL1QvIGZvcg0KPiBkZXRhaWxzLg0KPiANCj4gSW4geW91ciBj
YXNlLCB0aGUNCj4gVklSVElPX0dQVV9GUkVFWkVfTU9ERV9GUkVFWkVfUzMvVklSVElPX0dQVV9G
UkVFWkVfTU9ERV9VTkZSRUVaRSBkbyBpbmZsdWVuY2UNCj4gaG93IHJlc2V0IGlzIGJlaW5nIGhh
bmRsZWQgYnkgUWVtdSwgaXMgdGhpcyBjb3JyZWN0PyAgU2luY2UgbXVsdGlwbGUgZGV2aWNlcw0K
WWVzLCBpdCBjYW4gYWZmZWN0IHRoZSByZXNldCBiZWhhdmlvciBvZiBRZW11Lg0KDQo+IGNhbiBi
ZW5lZml0IGZyb20gdGhlIHNhbWUgbWVjaGFuaXNtLCB3b3VsZCBpdCBiZSBwb3NzaWJsZSB0bzog
YSkgaGF2ZSBhIG1vcmUNCj4gZ2VuZXJpYywgbm9uIEFDUEktYmFzZWQgbmFtZSwgYikgbWFrZSB0
aGUgZmVhdHVyZSBnZW5lcmljLCBhcHBsaWNhYmxlIHRvIG90aGVyDQo+IGRldmljZXMgYXMgd2Vs
bD8NCkl0IHNlZW1zIHlvdXIgb3BpbmlvbiBpcyB0aGUgc2FtZSBhcyBQYXJhdiBQYW5kaXQncywg
Ym90aCBob3BlIHRoaXMgZmVhdHVyZSBjYW4gYmUgbW9yZSBnZW5lcmljLiANCklmIHRoYXQncyB0
aGUgY2FzZSwgaXRzIHJvbGUgYW5kIHNjb3BlIG9mIGluZmx1ZW5jZSB3aWxsIGJlY29tZSBxdWl0
ZSBsYXJnZSwgYW5kIEknbSBub3Qgc3VyZSBpZiB0aGF0J3MgYXBwcm9wcmlhdGUuDQpJIHdpbGwg
dHJ5IHRvIG1vZGlmeSB0aGUgY29kZSB0byBpbXByb3ZlIHRoZSBsZXZlbCBvZiB0aGlzIGZlYXR1
cmUsIGlmIEkgY2FuIG1ha2UgaXQgd29yaywgSSB3aWxsIHNlbmQgYSBuZXcgc2VyaWVzIG9mIHBh
dGNoLg0KQW5kIGR1cmluZyB0aGlzIHBlcmlvZCwgSSBhbSBzdGlsbCBsb29raW5nIGZvcndhcmQg
dG8gcmVjZWl2aW5nIG1vcmUgc3VnZ2VzdGlvbnMgYW5kIGd1aWRhbmNlIGZyb20gZXZlcnlvbmUu
IFRoYW5rIHlvdSENCg0KPiANCj4gDQo+IEJlc3Qgd2lzaGVzLA0KPiBNaWtoYWlsIEdvbHViZXYt
Q2l1Y2hlYQ0KPiANCj4gDQo+IA0KPiAtLQ0KPiANCj4gTWlraGFpbCBHb2x1YmV2LUNpdWNoZWEN
Cj4gDQo+IA0KPiBPcGVuU3luZXJneSBHbWJIDQo+IA0KPiBSb3RoZXJzdHIuIDIwLCAxMDI0NSBC
ZXJsaW4NCj4gDQo+IFRlbGVmb246ICs0OSAoMzApIDYwIDk4IDU0IDAgLSA5MDMNCj4gDQo+IEVN
YWlsOiAgIG1pa2hhaWwuZ29sdWJldkBvcGVuc3luZXJneS5jb20NCj4gDQo+IHd3dy5vcGVuc3lu
ZXJneS5jb20NCj4gDQo+IEhhbmRlbHNyZWdpc3Rlci9Db21tZXJjaWFsIFJlZ2lzdHJ5OiBBbXRz
Z2VyaWNodCBDaGFybG90dGVuYnVyZywgSFJCIDEwODYxNkINCj4gDQo+IEdlc2Now6RmdHNmw7xo
cmVyL01hbmFnaW5nIERpcmVjdG9yOiBSZWdpcyBBZGphbWFoDQo+IA0KPiANCj4gX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXw0KPiBGcm9tOiB2aXJ0aW8tZGV2QGxpc3Rz
Lm9hc2lzLW9wZW4ub3JnIDx2aXJ0aW8tZGV2QGxpc3RzLm9hc2lzLW9wZW4ub3JnPiBvbiBiZWhh
bGYgb2YgSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IFNlbnQ6IE1vbmRheSwg
U2VwdGVtYmVyIDExLCAyMDIzIDEyOjA0IFBNDQo+IFRvOiBHZXJkIEhvZmZtYW5uOyBNYXJjLUFu
ZHLDqSBMdXJlYXU7IFJvYmVydCBCZWNrZXR0OyB2aXJ0aW8tY29tbWVudEBsaXN0cy5vYXNpcy1v
cGVuLm9yZzsgdmlydGlvLWRldkBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiBDYzogcWVtdS1kZXZl
bEBub25nbnUub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBTdGVmYW5vIFN0YWJl
bGxpbmk7IFJvZ2VyIFBhdSBNb25uw6k7IEFsZXggRGV1Y2hlcjsgQ2hyaXN0aWFuIEtvZW5pZzsg
U3Rld2FydCBIaWxkZWJyYW5kOyBYZW5pYSBSYWdpYWRha291OyBIb25nbGVpIEh1YW5nOyBKdWxp
YSBaaGFuZzsgSHVhbmcgUnVpOyBKaXFpYW4gQ2hlbg0KPiBTdWJqZWN0OiBbdmlydGlvLWRldl0g
W1JFU0VORCBWSVJUSU8gR1BVIFBBVENIIHYzIDEvMV0gdmlydGlvLWdwdTogQWRkIG5ldyBmZWF0
dXJlIGZsYWcgVklSVElPX0dQVV9GX0ZSRUVaRV9TMw0KPiANCj4gV2hlbiB3ZSBzdXNwZW5kL3Jl
c3VtZSBndWVzdCBvbiBYZW4sIHRoZSBkaXNwbGF5IGNhbid0IGNvbWUgYmFjay4NCj4gVGhpcyBp
cyBiZWNhdXNlIHdoZW4gZ3Vlc3Qgc3VzcGVuZGVkLCBpdCBjYWxsZWQgaW50byBRZW11LiBUaGVu
DQo+IFFlbXUgZGVzdHJveWVkIGFsbCByZXNvdXJjZXMgd2hpY2ggaXMgdXNlZCBmb3IgZGlzcGxh
eS4gU28gdGhhdA0KPiBndWVzdCdzIGRpc3BsYXkgY2FuJ3QgY29tZSBiYWNrIHRvIHRoZSB0aW1l
IHdoZW4gaXQgd2FzIHN1c3BlbmRlZC4NCj4gDQo+IFRvIHNvbHZlIGFib3ZlIHByb2JsZW0sIEkg
YWRkZWQgYSBuZXcgbWVjaGFuaXNtIHRoYXQgd2hlbiBndWVzdCBpcw0KPiBzdXNwZW5kaW5nLCBp
dCB3aWxsIG5vdGlmeSBRZW11LCBhbmQgdGhlbiBRZW11IHdpbGwgbm90IGRlc3Ryb3kNCj4gcmVz
b3VyY2VzaSB3aGljaCBhcmUgY3JlYXRlZCBieSB1c2luZyBjb21tYW5kcw0KPiBWSVJUSU9fR1BV
X0NNRF9SRVNPVVJDRV9DUkVBVEVfKi4NCj4gDQo+IER1ZSB0byB0aGF0IG1lY2hhbmlzbSBuZWVk
cyBjb29wZXJhdGlvbiBiZXR3ZWVuIGd1ZXN0IGFuZCBob3N0LA0KPiBJIG5lZWQgdG8gYWRkIGEg
bmV3IGZlYXR1cmUgZmxhZywgc28gdGhhdCBndWVzdCBhbmQgaG9zdCBjYW4NCj4gbmVnb3RpYXRl
IHdoZW5ldmVyIGZyZWV6ZV9TMyBpcyBzdXBwb3J0ZWQgb3Igbm90Lg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+IC0tLQ0KPiAgZGV2aWNl
LXR5cGVzL2dwdS9kZXNjcmlwdGlvbi50ZXggfCA0MiArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYg
LS1naXQgYS9kZXZpY2UtdHlwZXMvZ3B1L2Rlc2NyaXB0aW9uLnRleCBiL2RldmljZS10eXBlcy9n
cHUvZGVzY3JpcHRpb24udGV4DQo+IGluZGV4IDQ0MzUyNDguLjFhMTM3ZTcgMTAwNjQ0DQo+IC0t
LSBhL2RldmljZS10eXBlcy9ncHUvZGVzY3JpcHRpb24udGV4DQo+ICsrKyBiL2RldmljZS10eXBl
cy9ncHUvZGVzY3JpcHRpb24udGV4DQo+IEBAIC0zNyw2ICszNyw4IEBAIFxzdWJzZWN0aW9ue0Zl
YXR1cmUgYml0c31cbGFiZWx7c2VjOkRldmljZSBUeXBlcyAvIEdQVSBEZXZpY2UgLyBGZWF0dXJl
IGJpdHN9DQo+ICAgIHJlc291cmNlcyBpcyBzdXBwb3J0ZWQuDQo+ICBcaXRlbVtWSVJUSU9fR1BV
X0ZfQ09OVEVYVF9JTklUICg0KV0gbXVsdGlwbGUgY29udGV4dCB0eXBlcyBhbmQNCj4gICAgc3lu
Y2hyb25pemF0aW9uIHRpbWVsaW5lcyBzdXBwb3J0ZWQuICBSZXF1aXJlcyBWSVJUSU9fR1BVX0Zf
VklSR0wuDQo+ICtcaXRlbVtWSVJUSU9fR1BVX0ZfRlJFRVpFX1MzICg1KV0gZnJlZXppbmcgdmly
dGlvLWdwdSBhbmQga2VlcGluZyByZXNvdXJjZXMNCj4gKyAgYWxpdmUgaXMgc3VwcG9ydGVkLg0K
PiAgXGVuZHtkZXNjcmlwdGlvbn0NCj4gDQo+ICBcc3Vic2VjdGlvbntEZXZpY2UgY29uZmlndXJh
dGlvbiBsYXlvdXR9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8gRGV2aWNl
IGNvbmZpZ3VyYXRpb24gbGF5b3V0fQ0KPiBAQCAtMjI4LDYgKzIzMCw5IEBAIFxzdWJzdWJzZWN0
aW9ue0RldmljZSBPcGVyYXRpb246IFJlcXVlc3QgaGVhZGVyfVxsYWJlbHtzZWM6RGV2aWNlIFR5
cGVzIC8gR1BVIERlDQo+ICAgICAgICAgIFZJUlRJT19HUFVfQ01EX1VQREFURV9DVVJTT1IgPSAw
eDAzMDAsDQo+ICAgICAgICAgIFZJUlRJT19HUFVfQ01EX01PVkVfQ1VSU09SLA0KPiANCj4gKyAg
ICAgICAgLyogZnJlZXplIG1vZGUgKi8NCj4gKyAgICAgICAgVklSVElPX0dQVV9DTURfU0VUX0ZS
RUVaRV9NT0RFID0gMHgwNDAwLA0KPiArDQo+ICAgICAgICAgIC8qIHN1Y2Nlc3MgcmVzcG9uc2Vz
ICovDQo+ICAgICAgICAgIFZJUlRJT19HUFVfUkVTUF9PS19OT0RBVEEgPSAweDExMDAsDQo+ICAg
ICAgICAgIFZJUlRJT19HUFVfUkVTUF9PS19ESVNQTEFZX0lORk8sDQo+IEBAIC04MzgsNiArODQz
LDQzIEBAIFxzdWJzdWJzZWN0aW9ue0RldmljZSBPcGVyYXRpb246IGN1cnNvcnF9XGxhYmVse3Nl
YzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8NCj4gDQo+ICBcZW5ke2Rlc2NyaXB0aW9ufQ0K
PiANCj4gK1xzdWJzdWJzZWN0aW9ue0RldmljZSBPcGVyYXRpb246IGZyZWV6ZV9tb2RlfVxsYWJl
bHtzZWM6RGV2aWNlIFR5cGVzIC8gR1BVIERldmljZSAvIERldmljZSBPcGVyYXRpb24gLyBEZXZp
Y2UgT3BlcmF0aW9uOiBmcmVlemVfbW9kZX0NCj4gKw0KPiArXGJlZ2lue2xzdGxpc3Rpbmd9DQo+
ICt0eXBlZGVmIGVudW0gew0KPiArICBWSVJUSU9fR1BVX0ZSRUVaRV9NT0RFX1VORlJFRVpFID0g
MCwNCj4gKyAgVklSVElPX0dQVV9GUkVFWkVfTU9ERV9GUkVFWkVfUzMgPSAzLA0KPiArfSB2aXJ0
aW9fZ3B1X2ZyZWV6ZV9tb2RlX3Q7DQo+ICsNCj4gK3N0cnVjdCB2aXJ0aW9fZ3B1X3NldF9mcmVl
emVfbW9kZSB7DQo+ICsgIHN0cnVjdCB2aXJ0aW9fZ3B1X2N0cmxfaGRyIGhkcjsNCj4gKyAgdmly
dGlvX2dwdV9mcmVlemVfbW9kZV90IGZyZWV6ZV9tb2RlOw0KPiArfTsNCj4gK1xlbmR7bHN0bGlz
dGluZ30NCj4gKw0KPiArXGJlZ2lue2Rlc2NyaXB0aW9ufQ0KPiArDQo+ICtcaXRlbVtWSVJUSU9f
R1BVX0NNRF9TRVRfRlJFRVpFX01PREVdDQo+ICtOb3RpZnkgZnJlZXplIG1vZGUgdGhyb3VnaCBj
b250cm9scS4NCj4gK1JlcXVlc3QgZGF0YSBpcyBcZmllbGR7c3RydWN0IHZpcnRpb19ncHVfc2V0
X2ZyZWV6ZV9tb2RlfS4NCj4gK1Jlc3BvbnNlIHR5cGUgaXMgVklSVElPX0dQVV9SRVNQX09LX05P
REFUQS4NCj4gKw0KPiArVGhpcyBpcyBhZGRlZCBmb3IgUzMgZnVuY3Rpb24gaW4gZ3Vlc3Qgd2l0
aCB2aXJ0aW8tZ3B1LiBXaGVuIGd1ZXN0IGRvZXMNCj4gK1MzLCBsZXQgaXQgbm90aWZ5IFFFTVUg
dGhhdCB2aXJ0aW8tZ3B1IGlzIGluIHdoYXQgZnJlZXplIG1vZGUgaW4NCj4gK1xmaWVsZHtmcmVl
emVfbW9kZX0uIFZJUlRJT19HUFVfRlJFRVpFX01PREVfRlJFRVpFX1MzIG1lYW5zIGd1ZXN0IGlz
DQo+ICtkb2luZyBTMyBhbmQgdmlydGlvLWdwdSB3aWxsIGJlIGZyZWV6ZWQsIFZJUlRJT19HUFVf
RlJFRVpFX01PREVfVU5GUkVFWkUNCj4gK21lYW5zIHZpcnRpby1ncHUgY2FuIGJlIHVzZWQgYXMg
dXN1YWwuIFdoZW4gdmlydGlvLWdwdSBpcyBmcmVlemVkLCBRRU1VDQo+ICt3aWxsIG5vdCBkZXN0
cm95IHJlc291cmNlcyB3aGljaCBhcmUgY3JlYXRlZCBieSB1c2luZyBjb21tYW5kcw0KPiArVklS
VElPX0dQVV9DTURfUkVTT1VSQ0VfQ1JFQVRFXyosIHNvIHRoYXQgZ3Vlc3QgY2FuIHVzZSB0aG9z
ZSByZXNvdXJjZXMNCj4gK3RvIHJlc3VtZSBkaXNwbGF5Lg0KPiArDQo+ICtOb3RlOiB0aGlzIGNo
YW5nZSBpcyBub3QgZW5vdWdoIHRvIHNvbHZlIHRoZSBwcm9ibGVtcyBvZiBTNCBmdW5jdGlvbi4N
Cj4gK1FFTVUgbWF5IGxvc2UgcmVzb3VyY2VzIGFmdGVyIGhpYmVybmF0aW9uLiBJdCBuZWVkcyBt
b3JlIHJlc2VhcmNoIGFuZA0KPiArZGV2ZWxvcG1lbnQuIElmIFM0IGlzIHN1cHBvcnRlZCBpbiB0
aGUgZnV0dXJlLCBpdCBtYXkgbmVlZCBhbm90aGVyDQo+ICtmZWF0dXJlIGZsYWcgaGVyZS4NCj4g
Kw0KPiArXGVuZHtkZXNjcmlwdGlvbn0NCj4gKw0KPiAgXHN1YnNlY3Rpb257VkdBIENvbXBhdGli
aWxpdHl9XGxhYmVse3NlYzpEZXZpY2UgVHlwZXMgLyBHUFUgRGV2aWNlIC8gVkdBIENvbXBhdGli
aWxpdHl9DQo+IA0KPiAgQXBwbGllcyB0byBWaXJ0aW8gT3ZlciBQQ0kgb25seS4gIFRoZSBHUFUg
ZGV2aWNlIGNhbiBjb21lIHdpdGggYW5kDQo+IC0tDQo+IDIuMzQuMQ0KPiANCj4gDQo+IC0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQ0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJl
QGxpc3RzLm9hc2lzLW9wZW4ub3JnDQo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6
IHZpcnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiANCj4gDQo+IC0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQ0KPiBUbyB1bnN1YnNjcmliZSwgZS1tYWlsOiB2aXJ0aW8tZGV2LXVuc3Vic2NyaWJlQGxp
c3RzLm9hc2lzLW9wZW4ub3JnDQo+IEZvciBhZGRpdGlvbmFsIGNvbW1hbmRzLCBlLW1haWw6IHZp
cnRpby1kZXYtaGVscEBsaXN0cy5vYXNpcy1vcGVuLm9yZw0KPiANCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpKaXFpYW4gQ2hlbi4NCg==
