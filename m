Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A4A6809BEF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 06:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573169AbjLHFx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 00:53:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjLHFx1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 00:53:27 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2079.outbound.protection.outlook.com [40.107.244.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EC6171D;
        Thu,  7 Dec 2023 21:53:33 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtWnvNisbUYv7QAlgvAqDoSmpgWi13vw96/ynshkdKYgW42XpvwO6MD78I/Xtx2qvBO84EHb8RSUZMoRgqpnU3wQ6Q4V7Qq47T5dHapn75jV0376acLLr5Yj4QYOq2I6iXMsXFJcpJE6wFTFq+IeK+Nbl7nicQXW6WYj/blznPUAHPa10B2TUAuBmjIv+9yy68WD4TTXmMedrSsAECwu2RdSZD4ztElGSP4yAchrPI0rjbwdTsFdn++Eb381lN6yMaG7XPBbX14Y41GdqK5ENdh7b+qAJaFwRJ2/t/7UldS0mf3xw9Phj+AiGbolimFLNQSk63waM3Iz0xHKimL47Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j83ED/3SCjJ/29w6Cns7QQ9f24CBQzAcSeEjmfIwCpU=;
 b=ZvD8gEp29IHJpF2CcUiTdinUQ9qyQNzFu5KkvKBXbGcHSfpA10VDiecKU32AKk7E/5Wr4Odnr+/flIEVHmNvpb45gByvtiK61t6h2ML8/hjTXUxvVBXFF91isBEZZQdZqpmq5NpUrltD+3p+UL81ncwqdZt3s7gfp+hAnqKQTJC0nPBozoaX83mdqX46OM9pBLXcLU9t/Of8YtUyC6dLeaM8kzbFYIl6s7ZozvuS8y5XOjJYZJ5KpoimrDaWe68T1mj/z5ICrZpUbr+8qXMp2vV9wHKUMoZeAodaHSYAJ1ZdXbjc1sQ9M1nQjJl6shN6NIFnTAHHwoKLoOy2CCkUyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j83ED/3SCjJ/29w6Cns7QQ9f24CBQzAcSeEjmfIwCpU=;
 b=reS/yhWBVeR2Vq/Iw8k5D+tlKLf4dXoGKjNAlGc6ccwQW4DuJ2IdB3bMr/EzBjB/mD/XcMDbNrhBSwFjm+ZcSzH/6cJFX2v0kLDUSaSAZndl4PHaR+eZHq/C4B+tCnjZO8Zg5FHPdJQYDmIYxkxSK9qmCACrewAol3E6aT5uT8Y=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CY8PR12MB7587.namprd12.prod.outlook.com (2603:10b6:930:9a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Fri, 8 Dec
 2023 05:53:30 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7068.027; Fri, 8 Dec 2023
 05:53:30 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>
CC:     Jan Beulich <jbeulich@suse.com>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
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
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CSRC+AgADLdgCAALwOgIAAX9AAgAE42ICAA5dDgIAAxsiAgAC4TACAABRoAIABzBGAgADOj4CAAEo5AIACCgeA
Date:   Fri, 8 Dec 2023 05:53:29 +0000
Message-ID: <BL1PR12MB584969E1A52C8C86EC7BA065E78AA@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-3-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291950350.3533093@ubuntu-linux-20-04-desktop>
 <ZWiyBP4Lzz5lXraP@macbook>
 <alpine.DEB.2.22.394.2311301912350.110490@ubuntu-linux-20-04-desktop>
 <ZWmgJNidFsfkDp7q@macbook>
 <alpine.DEB.2.22.394.2312011857260.110490@ubuntu-linux-20-04-desktop>
 <ZW2ptexPQXrWBiOS@macbook>
 <alpine.DEB.2.22.394.2312041413000.110490@ubuntu-linux-20-04-desktop>
 <ZW7rDjjC0gxEI1cq@macbook> <15275706-5c31-4e29-aa29-9f5e90526219@suse.com>
 <BL1PR12MB5849C871B0B9577D1E0BF576E784A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>
 <ed0729b6-8896-41cb-87fc-9111afc68151@suse.com>
In-Reply-To: <ed0729b6-8896-41cb-87fc-9111afc68151@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB8495.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CY8PR12MB7587:EE_
x-ms-office365-filtering-correlation-id: fe71ece7-b049-45f1-3082-08dbf7b20136
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lpoAiuu3fsBDJcycrw4w/o9fzvieLo2EloZmspZLUOtFUE1+tRTa7dMxmxKG5NxKeCLuNaKx0kil1fWf0yV906jexIWqIAEhjN1XHeR5tihPEQx/L/jNH5hPy8eYnPrifomjrE8dmoVfLphyqpgQgaajMrS6eEhlQg7s1q1UAYNINvnmYloU0y3hPQKM8ow/TVNIVOZhDKVxkfnDQpZP4Y43tkvnMsBQVabp3BdiY4CElpK//m9XFBVLYVeF22BAcbhQZ0QivH8RpYENC4jex8M8p669YA44WotCrvjw8yiDi5v9bEJW8a5qrFrpKq97YTBfkV2zS8KSLsXx8lB1hsOBnRbdyWZZjYqdWnkKLl1bFXz9zDE37P8JxzTxjKXcT1KKGljugJs7MAyEPTCSwqJ1mRulc3vhOOd+i7eTeS/FWCOVqsG6K6XlZIbzztUsLSHRLLIChBzSwkcEKuLuhX/DtUXH6EKkRUGzdovnSebBZ7+e0urLk1iiyfeSrhE9eZ3DmIdFWKzxNmgl16YrPK4KbD8NEIDK7tS5nge6oiztRvxyy873kkbakbjwLCzWVmNd+7CD2I4Oy7lL+P6p54ZNK9D9o+Wih47Aea1JF0CujGE4ujLB7qd3vLKoxwkX
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(136003)(366004)(396003)(346002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(2906002)(7416002)(52536014)(8936002)(4326008)(8676002)(55016003)(5660300002)(316002)(66556008)(76116006)(66476007)(54906003)(66946007)(66446008)(64756008)(110136005)(53546011)(9686003)(7696005)(6506007)(26005)(41300700001)(478600001)(38070700009)(71200400001)(83380400001)(33656002)(38100700002)(122000001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkRFNlJvbzRSRHhqdmdkSGgybkhlcU5mQ3l2Q3dlZVdlUW1HVWNseVlOaTFL?=
 =?utf-8?B?Z3FsMWRHdTBrUmN3ZzhXY0o2WHE1cmM5M0Q3T0kwNzVDZVU2K2NJcXBxOU0z?=
 =?utf-8?B?Sm9SeDI3OERxanErY2RzNkpyYlErMkpIT1FHQm5zK05oZ2xkaXp0c0JrUW5F?=
 =?utf-8?B?VkZ6b3VESk02TndRSFMwQkxhUmVkRTNka1lJWVVTSlFZMnBVTFhJU2dIOURE?=
 =?utf-8?B?SmxyN01aZlljZ2lSVUZBcm41TkF1UUhoZGZQU2FhU2J5L0xtZmhZbXd2bXow?=
 =?utf-8?B?cGZKOFlyYWJjTDZYMG9rTTA1YUJqaVdKL0psekx3ejh1NHBUenF0VlV1cWRx?=
 =?utf-8?B?YWM2L1BBaGY4ck81NE1MSU43dTNqYTRjOHRSYkVYSUhBSXg3WStiLzFieGtr?=
 =?utf-8?B?VnpvTFBLd0lIZjNDWFRFNExsdFBiVlk0bWRxenk3WDNoUWFxTmk4cnVJaVVV?=
 =?utf-8?B?dVMzb2xGSitqSkl0cG40K3p1S2dLamRHdG03aTFFdmVGaVdTbkp5aU9ncTlS?=
 =?utf-8?B?UUJMZTlMQnhqbjhIR1Uya2lYMjg5dlFRTXpFSldXSW9vd0FaMFExcVd1MFFp?=
 =?utf-8?B?bWVubGFBRy9lT3U5QkZ3eUx1NWhqclZ4MDJINkxqY2x6dkFPYURZeVZMalhi?=
 =?utf-8?B?bG02aVowNUpZbWt6UjZNTUIvdHhjNkdaRDFFQXZzTlcySFVIWUFGWFdKZXIz?=
 =?utf-8?B?dktQclQzZFRXdFJDT0ZEWXBBajRhU0d4eVZWSUY4RmFIK3A5eENyTHpBNFF3?=
 =?utf-8?B?dVVEVlE3MzMzMnRsZkRiTS85bnkrZVAwc2dBY0VQbWNST2o3bmVJNEEvQS9w?=
 =?utf-8?B?YVVqSGJjVGlnYVJ4cmh0ZTByNXBpWXI3aTJibGpKQ1pqNHBYNVJqYUUrb1NY?=
 =?utf-8?B?Vml1S05XUDMzdTRpVWdhZ3hRbXdOUFhJOXc2WlNQcGl1aXZMQnVBbWkyWlYw?=
 =?utf-8?B?TWowMG5tUFdrN0Jab0daZUVKUHI3a3VwdlFndXlNT2t0TDRSNGIzSy9uUm02?=
 =?utf-8?B?UFAxRnlnSDJ4N3E3RGJwaFVUMTBXQlV0c3A1RzQ1NG9sblZpbDR2TUpuaUN2?=
 =?utf-8?B?T1UwdG53WWZKa2hmNDNxVHRCNFN5SmZDU2FpRWNMcGY4YTRTd0Y0Y1ZadTJh?=
 =?utf-8?B?ZmxIc3ZMU1Z1ZXRIM1pMYkhILzBFRGtyQ3owZVVtdGxLcHNSZFlhQlNaSW1B?=
 =?utf-8?B?L2IydGM5WWJncjI4b3VBZ0FOcnE2aTdVdC9jNVRTTmx2a0NFellzZXBQTnZG?=
 =?utf-8?B?d1BqUjJpNnBYcG1ZRkUyL0pEZDk2SnZRcnhhcFgxZTYrWHdXNjUzblc5KzVU?=
 =?utf-8?B?cVFTOCtPKzllck5rZnZaOW8xbUx3M0cxS2lxQmhsRHQ2UEM4aUNZL28xS0FB?=
 =?utf-8?B?YlV0UDUxalZ2NkdMSTRBR0lEUDllSFkvSk9xUG40T3JQNVFuTHJ3Q2YvRnlO?=
 =?utf-8?B?ZFBoRUlvMWtvNVF0MU5lQkhPMmJoOE5CaUpXdUc1U29ZNnAzcW5hMms0WG9Q?=
 =?utf-8?B?bEwvT2N2YVc1WmJ6L0JlR2JoVHFyWFErSzFHdlliMVVPSmdlK3ZzaHFJd2lM?=
 =?utf-8?B?MUI0SE5qTTl5cTd4bGVSeUhOM2ZUQVZaK3UvZ3k5UExBR3ZxUTB5U0ZpSEhR?=
 =?utf-8?B?eHlycmNPRGROaytQUUdnc01SRXlQcFNTWGtYS0E3OXRjRUxKcTIyMnVDRldo?=
 =?utf-8?B?RWcrY3VFbDFzV0UyblpjckNwb3MzK0JJa05BTkdOeUh6aFlHZEYxMHpoVXIr?=
 =?utf-8?B?SWJqbERuRUtwM0J0RXVVbmJlQlg3d2VHUzRybEpFaFlqb09LRjRIQjBPbDMy?=
 =?utf-8?B?VWFYTVZYcks2NUFXOXpiUDViZm1DenRlVGRyd29HQW54eXA4YUl4Y21GZzEz?=
 =?utf-8?B?Vm1zVERaMk5UckR2NUVEWEd5anp1ZkhmajEyeFJrSi8rQjBRNjd4VitzN3lj?=
 =?utf-8?B?bE94K2N5a2NuMmxIMjk5eVhSNGhUL1AvdHNnKzU2eDJOaXgyNDN4dno4cTB5?=
 =?utf-8?B?QlBKemM5QlhHQ1lpQU9YS2ZIeUQ2NDFHbmxFWUs3TFFIdGdUdEVHR0d4cDRR?=
 =?utf-8?B?TEpueGVuM0lKM2IvL3NxemQvSUFBWU1CNjRmcW9SWW1uNjBuTFRySzFGK3JU?=
 =?utf-8?Q?0ttA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <892128889789D441A05768FC4A274245@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe71ece7-b049-45f1-3082-08dbf7b20136
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2023 05:53:29.9069
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r4mhDH/9gdbffV75n527KHI8yfc/keZeZ8o3imNlfKawfOtPeRLLqH0SZ6n4V1g2v/UOf4dEAD3Rz6UOtMUprg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7587
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhhbmsgU3RlZmFubyBhbmQgSnVlcmdlbiwgSSB3aWxsIHVzZSB0aGlzIGFwcHJvYWNoIGluIG5l
eHQgdmVyc2lvbi4NCg0KT24gMjAyMy8xMi83IDE0OjQzLCBKdWVyZ2VuIEdyb3NzIHdyb3RlOg0K
PiBPbiAwNy4xMi4yMyAwMzoxOCwgU3RlZmFubyBTdGFiZWxsaW5pIHdyb3RlOg0KPj4gT24gVHVl
LCA1IERlYyAyMDIzLCBDaGVuLCBKaXFpYW4gd3JvdGU6DQo+Pj4gV2hlbiBQVkggZG9tMCBlbmFi
bGUgYSBkZXZpY2UsIGl0IHdpbGwgZ2V0IHRyaWdnZXIgYW5kIHBvbGFyaXR5IGZyb20gQUNQSSAo
c2VlIGFjcGlfcGNpX2lycV9lbmFibGUpDQo+Pj4gSSBoYXZlIGEgdmVyc2lvbiBvZiBwYXRjaCB3
aGljaCB0cmllZCB0aGF0IHdheSwgc2VlIGJlbG93Og0KPj4NCj4+IFRoaXMgYXBwcm9hY2ggbG9v
a3MgbXVjaCBiZXR0ZXIuIEkgdGhpbmsgdGhpcyBwYXRjaCBpcyBPS2lzaC4gSnVlcmdlbiwNCj4+
IHdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gVGhlIGFwcHJvYWNoIHNlZW1zIHRvIGJlIGZpbmUu
DQo+IA0KPiANCj4gSnVlcmdlbg0KPiANCj4+DQo+Pg0KPj4+IGRpZmYgLS1naXQgYS9hcmNoL3g4
Ni94ZW4vZW5saWdodGVuX3B2aC5jIGIvYXJjaC94ODYveGVuL2VubGlnaHRlbl9wdmguYw0KPj4+
IGluZGV4IGFkYTM4NjhjMDJjMi4uNDNlMWJkYTlmOTQ2IDEwMDY0NA0KPj4+IC0tLSBhL2FyY2gv
eDg2L3hlbi9lbmxpZ2h0ZW5fcHZoLmMNCj4+PiArKysgYi9hcmNoL3g4Ni94ZW4vZW5saWdodGVu
X3B2aC5jDQo+Pj4gQEAgLTEsNiArMSw3IEBADQo+Pj4gwqAgLy8gU1BEWC1MaWNlbnNlLUlkZW50
aWZpZXI6IEdQTC0yLjANCj4+PiDCoCAjaW5jbHVkZSA8bGludXgvYWNwaS5oPg0KPj4+IMKgICNp
bmNsdWRlIDxsaW51eC9leHBvcnQuaD4NCj4+PiArI2luY2x1ZGUgPGxpbnV4L3BjaS5oPg0KPj4+
DQo+Pj4gwqAgI2luY2x1ZGUgPHhlbi9odmMtY29uc29sZS5oPg0KPj4+DQo+Pj4gQEAgLTI1LDYg
KzI2LDEyNyBAQA0KPj4+IMKgIGJvb2wgX19yb19hZnRlcl9pbml0IHhlbl9wdmg7DQo+Pj4gwqAg
RVhQT1JUX1NZTUJPTF9HUEwoeGVuX3B2aCk7DQo+Pj4NCj4+PiArdHlwZWRlZiBzdHJ1Y3QgZ3Np
X2luZm8gew0KPj4+ICvCoMKgwqDCoMKgwqAgaW50IGdzaTsNCj4+PiArwqDCoMKgwqDCoMKgIGlu
dCB0cmlnZ2VyOw0KPj4+ICvCoMKgwqDCoMKgwqAgaW50IHBvbGFyaXR5Ow0KPj4+ICvCoMKgwqDC
oMKgwqAgaW50IHBpcnE7DQo+Pj4gK30gZ3NpX2luZm9fdDsNCj4+PiArDQo+Pj4gK3N0cnVjdCBh
Y3BpX3BydF9lbnRyeSB7DQo+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgYWNwaV9wY2lfaWTCoMKg
wqDCoMKgIGlkOw0KPj4+ICvCoMKgwqDCoMKgwqAgdTjCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgcGluOw0KPj4+ICvCoMKgwqDCoMKgwqAgYWNwaV9oYW5kbGXCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgbGluazsNCj4+PiArwqDCoMKgwqDCoMKgIHUzMsKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaW5kZXg7wqDCoMKgwqDCoMKgwqDCoMKg
IC8qIEdTSSwgb3IgbGluayBfQ1JTIGluZGV4ICovDQo+Pj4gK307DQo+Pj4gKw0KPj4+ICtzdGF0
aWMgaW50IHhlbl9wdmhfZ2V0X2dzaV9pbmZvKHN0cnVjdCBwY2lfZGV2ICpkZXYsDQo+Pj4gK8Kg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqAgZ3NpX2luZm9fdCAqZ3NpX2luZm8pDQo+Pj4gK3sNCj4+PiArwqDCoMKgwqDCoMKg
IGludCBnc2k7DQo+Pj4gK8KgwqDCoMKgwqDCoCB1OCBwaW4gPSAwOw0KPj4+ICvCoMKgwqDCoMKg
wqAgc3RydWN0IGFjcGlfcHJ0X2VudHJ5ICplbnRyeTsNCj4+PiArwqDCoMKgwqDCoMKgIGludCB0
cmlnZ2VyID0gQUNQSV9MRVZFTF9TRU5TSVRJVkU7DQo+Pj4gK8KgwqDCoMKgwqDCoCBpbnQgcG9s
YXJpdHkgPSBhY3BpX2lycV9tb2RlbCA9PSBBQ1BJX0lSUV9NT0RFTF9HSUMgPw0KPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqAgQUNQSV9BQ1RJVkVfSElHSCA6IEFDUElfQUNUSVZFX0xPVzsNCj4+PiArDQo+
Pj4gK8KgwqDCoMKgwqDCoCBpZiAoZGV2KQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHBpbiA9IGRldi0+cGluOw0KPj4+ICvCoMKgwqDCoMKgwqAgaWYgKCFwaW4pIHsNCj4+PiAr
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fcmF3X3ByaW50aygiTm8gaW50ZXJydXB0
IHBpbiBjb25maWd1cmVkXG4iKTsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBy
ZXR1cm4gLUVJTlZBTDsNCj4+PiArwqDCoMKgwqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoMKg
wqDCoCBlbnRyeSA9IGFjcGlfcGNpX2lycV9sb29rdXAoZGV2LCBwaW4pOw0KPj4+ICvCoMKgwqDC
oMKgwqAgaWYgKGVudHJ5KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYg
KGVudHJ5LT5saW5rKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBnc2kgPSBhY3BpX3BjaV9saW5rX2FsbG9jYXRlX2lycShlbnRyeS0+bGluaywNCj4+
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAg
ZW50cnktPmluZGV4LA0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoCAmdHJpZ2dlciwgJnBvbGFyaXR5LA0KPj4+ICvCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBOVUxMKTsNCj4+PiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlbHNlDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdzaSA9IGVudHJ5LT5pbmRleDsNCj4+PiArwqDCoMKg
wqDCoMKgIH0gZWxzZQ0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiAt
RUlOVkFMOw0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgIGdzaV9pbmZvLT5nc2kgPSBnc2k7DQo+
Pj4gK8KgwqDCoMKgwqDCoCBnc2lfaW5mby0+dHJpZ2dlciA9IHRyaWdnZXI7DQo+Pj4gK8KgwqDC
oMKgwqDCoCBnc2lfaW5mby0+cG9sYXJpdHkgPSBwb2xhcml0eTsNCj4+PiArDQo+Pj4gK8KgwqDC
oMKgwqDCoCByZXR1cm4gMDsNCj4+PiArfQ0KPj4+ICsNCj4+PiArc3RhdGljIGludCB4ZW5fcHZo
X21hcF9waXJxKGdzaV9pbmZvX3QgKmdzaV9pbmZvKQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoMKgwqDC
oCBzdHJ1Y3QgcGh5c2Rldl9tYXBfcGlycSBtYXBfaXJxOw0KPj4+ICvCoMKgwqDCoMKgwqAgaW50
IHJldDsNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoCBtYXBfaXJxLmRvbWlkID0gRE9NSURfU0VM
RjsNCj4+PiArwqDCoMKgwqDCoMKgIG1hcF9pcnEudHlwZSA9IE1BUF9QSVJRX1RZUEVfR1NJOw0K
Pj4+ICvCoMKgwqDCoMKgwqAgbWFwX2lycS5pbmRleCA9IGdzaV9pbmZvLT5nc2k7DQo+Pj4gK8Kg
wqDCoMKgwqDCoCBtYXBfaXJxLnBpcnEgPSBnc2lfaW5mby0+Z3NpOw0KPj4+ICsNCj4+PiArwqDC
oMKgwqDCoMKgIHJldCA9IEhZUEVSVklTT1JfcGh5c2Rldl9vcChQSFlTREVWT1BfbWFwX3BpcnEs
ICZtYXBfaXJxKTsNCj4+PiArwqDCoMKgwqDCoMKgIGdzaV9pbmZvLT5waXJxID0gbWFwX2lycS5w
aXJxOw0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4gK30NCj4+PiAr
DQo+Pj4gK3N0YXRpYyBpbnQgeGVuX3B2aF91bm1hcF9waXJxKGdzaV9pbmZvX3QgKmdzaV9pbmZv
KQ0KPj4+ICt7DQo+Pj4gK8KgwqDCoMKgwqDCoCBzdHJ1Y3QgcGh5c2Rldl91bm1hcF9waXJxIHVu
bWFwX2lycTsNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoCB1bm1hcF9pcnEuZG9taWQgPSBET01J
RF9TRUxGOw0KPj4+ICvCoMKgwqDCoMKgwqAgdW5tYXBfaXJxLnBpcnEgPSBnc2lfaW5mby0+cGly
cTsNCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoCByZXR1cm4gSFlQRVJWSVNPUl9waHlzZGV2X29w
KFBIWVNERVZPUF91bm1hcF9waXJxLCAmdW5tYXBfaXJxKTsNCj4+PiArfQ0KPj4+ICsNCj4+PiAr
c3RhdGljIGludCB4ZW5fcHZoX3NldHVwX2dzaShnc2lfaW5mb190ICpnc2lfaW5mbykNCj4+PiAr
ew0KPj4+ICvCoMKgwqDCoMKgwqAgc3RydWN0IHBoeXNkZXZfc2V0dXBfZ3NpIHNldHVwX2dzaTsN
Cj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoCBzZXR1cF9nc2kuZ3NpID0gZ3NpX2luZm8tPmdzaTsN
Cj4+PiArwqDCoMKgwqDCoMKgIHNldHVwX2dzaS50cmlnZ2VyaW5nID0gKGdzaV9pbmZvLT50cmln
Z2VyID09IEFDUElfRURHRV9TRU5TSVRJVkUgPyAwIDogMSk7DQo+Pj4gK8KgwqDCoMKgwqDCoCBz
ZXR1cF9nc2kucG9sYXJpdHkgPSAoZ3NpX2luZm8tPnBvbGFyaXR5ID09IEFDUElfQUNUSVZFX0hJ
R0ggPyAwIDogMSk7DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqAgcmV0dXJuIEhZUEVSVklTT1Jf
cGh5c2Rldl9vcChQSFlTREVWT1Bfc2V0dXBfZ3NpLCAmc2V0dXBfZ3NpKTsNCj4+PiArfQ0KPj4+
ICsNCj4+PiAraW50IHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3NpKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+Pj4gK3sNCj4+PiArwqDCoMKgwqDCoMKgIGludCByZXQ7DQo+Pj4gK8KgwqDCoMKgwqDCoCBn
c2lfaW5mb190IGdzaV9pbmZvOw0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgIGlmICghZGV2KSB7
DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+Pj4g
K8KgwqDCoMKgwqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKgwqAgcmV0ID0geGVuX3B2aF9n
ZXRfZ3NpX2luZm8oZGV2LCAmZ3NpX2luZm8pOw0KPj4+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCkg
ew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9yYXdfcHJpbnRrKCJGYWls
IHRvIGdldCBnc2kgaW5mbyFcbiIpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybiByZXQ7DQo+Pj4gK8KgwqDCoMKgwqDCoCB9DQo+Pj4gKw0KPj4+ICvCoMKgwqDCoMKg
wqAgcmV0ID0geGVuX3B2aF9tYXBfcGlycSgmZ3NpX2luZm8pOw0KPj4+ICvCoMKgwqDCoMKgwqAg
aWYgKHJldCkgew0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9yYXdfcHJp
bnRrKCJGYWlsIHRvIG1hcCBwaXJxIGZvciBnc2kgKCVkKSFcbiIsIGdzaV9pbmZvLmdzaSk7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJldDsNCj4+PiArwqDCoMKg
wqDCoMKgIH0NCj4+PiArDQo+Pj4gK8KgwqDCoMKgwqDCoCByZXQgPSB4ZW5fcHZoX3NldHVwX2dz
aSgmZ3NpX2luZm8pOw0KPj4+ICvCoMKgwqDCoMKgwqAgaWYgKHJldCA9PSAtRUVYSVNUKSB7DQo+
Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0ID0gMDsNCj4+PiArwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCB4ZW5fcmF3X3ByaW50aygiQWxyZWFkeSBzZXR1cCB0aGUgR1NJ
IDoldVxuIiwgZ3NpX2luZm8uZ3NpKTsNCj4+PiArwqDCoMKgwqDCoMKgIH0gZWxzZSBpZiAocmV0
KSB7DQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgeGVuX3Jhd19wcmludGsoIkZh
aWwgdG8gc2V0dXAgZ3NpICglZCkhXG4iLCBnc2lfaW5mby5nc2kpOw0KPj4+ICvCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIHhlbl9wdmhfdW5tYXBfcGlycSgmZ3NpX2luZm8pOw0KPj4+ICvC
oMKgwqDCoMKgwqAgfQ0KPj4+ICsNCj4+PiArwqDCoMKgwqDCoMKgIHJldHVybiByZXQ7DQo+Pj4g
K30NCj4+PiArRVhQT1JUX1NZTUJPTF9HUEwoeGVuX3B2aF9wYXNzdGhyb3VnaF9nc2kpOw0KPj4+
ICsNCj4+PiDCoCB2b2lkIF9faW5pdCB4ZW5fcHZoX2luaXQoc3RydWN0IGJvb3RfcGFyYW1zICpi
b290X3BhcmFtcykNCj4+PiDCoCB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB1MzIgbXNyOw0KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL2FjcGkvcGNpX2lycS5jIGIvZHJpdmVycy9hY3BpL3BjaV9p
cnEuYw0KPj4+IGluZGV4IGZmMzBjZWNhMjIwMy4uNjMwZmUwYTM0YmM2IDEwMDY0NA0KPj4+IC0t
LSBhL2RyaXZlcnMvYWNwaS9wY2lfaXJxLmMNCj4+PiArKysgYi9kcml2ZXJzL2FjcGkvcGNpX2ly
cS5jDQo+Pj4gQEAgLTI4OCw3ICsyODgsNyBAQCBzdGF0aWMgaW50IGFjcGlfcmVyb3V0ZV9ib290
X2ludGVycnVwdChzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KPj4+IMKgIH0NCj4+PiDCoCAjZW5kaWYg
LyogQ09ORklHX1g4Nl9JT19BUElDICovDQo+Pj4NCj4+PiAtc3RhdGljIHN0cnVjdCBhY3BpX3By
dF9lbnRyeSAqYWNwaV9wY2lfaXJxX2xvb2t1cChzdHJ1Y3QgcGNpX2RldiAqZGV2LCBpbnQgcGlu
KQ0KPj4+ICtzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmFjcGlfcGNpX2lycV9sb29rdXAoc3RydWN0
IHBjaV9kZXYgKmRldiwgaW50IHBpbikNCj4+PiDCoCB7DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCBz
dHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmVudHJ5ID0gTlVMTDsNCj4+PiDCoMKgwqDCoMKgwqDCoMKg
IHN0cnVjdCBwY2lfZGV2ICpicmlkZ2U7DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hl
bi1wY2liYWNrL3BjaV9zdHViLmMgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5j
DQo+Pj4gaW5kZXggZTM0YjYyM2U0YjQxLi4xYWJkNGRhZDZmNDAgMTAwNjQ0DQo+Pj4gLS0tIGEv
ZHJpdmVycy94ZW4veGVuLXBjaWJhY2svcGNpX3N0dWIuYw0KPj4+ICsrKyBiL2RyaXZlcnMveGVu
L3hlbi1wY2liYWNrL3BjaV9zdHViLmMNCj4+PiBAQCAtMjAsNiArMjAsNyBAQA0KPj4+IMKgICNp
bmNsdWRlIDxsaW51eC9hdG9taWMuaD4NCj4+PiDCoCAjaW5jbHVkZSA8eGVuL2V2ZW50cy5oPg0K
Pj4+IMKgICNpbmNsdWRlIDx4ZW4vcGNpLmg+DQo+Pj4gKyNpbmNsdWRlIDx4ZW4vYWNwaS5oPg0K
Pj4+IMKgICNpbmNsdWRlIDx4ZW4veGVuLmg+DQo+Pj4gwqAgI2luY2x1ZGUgPGFzbS94ZW4vaHlw
ZXJ2aXNvci5oPg0KPj4+IMKgICNpbmNsdWRlIDx4ZW4vaW50ZXJmYWNlL3BoeXNkZXYuaD4NCj4+
PiBAQCAtMzk5LDYgKzQwMCwxMiBAQCBzdGF0aWMgaW50IHBjaXN0dWJfaW5pdF9kZXZpY2Uoc3Ry
dWN0IHBjaV9kZXYgKmRldikNCj4+PiDCoMKgwqDCoMKgwqDCoMKgIGlmIChlcnIpDQo+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBjb25maWdfcmVsZWFzZTsNCj4+Pg0K
Pj4+ICvCoMKgwqDCoMKgwqAgaWYgKHhlbl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdmhfZG9t
YWluKCkpIHsNCj4+PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBlcnIgPSB4ZW5fcHZo
X3Bhc3N0aHJvdWdoX2dzaShkZXYpOw0KPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
IGlmIChlcnIpDQo+Pj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIGdvdG8gY29uZmlnX3JlbGVhc2U7DQo+Pj4gK8KgwqDCoMKgwqDCoCB9DQo+Pj4gKw0KPj4+
IMKgwqDCoMKgwqDCoMKgwqAgaWYgKGRldi0+bXNpeF9jYXApIHsNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBzdHJ1Y3QgcGh5c2Rldl9wY2lfZGV2aWNlIHBwZGV2ID0gew0K
Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAuc2Vn
ID0gcGNpX2RvbWFpbl9ucihkZXYtPmJ1cyksDQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlu
dXgvYWNwaS5oIGIvaW5jbHVkZS9saW51eC9hY3BpLmgNCj4+PiBpbmRleCA2NDFkYzQ4NDM5ODcu
LjM2OGQ1NmJhMmM1ZSAxMDA2NDQNCj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2FjcGkuaA0KPj4+
ICsrKyBiL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+Pj4gQEAgLTM3NSw2ICszNzUsNyBAQCB2b2lk
IGFjcGlfdW5yZWdpc3Rlcl9nc2kgKHUzMiBnc2kpOw0KPj4+DQo+Pj4gwqAgc3RydWN0IHBjaV9k
ZXY7DQo+Pj4NCj4+PiArc3RydWN0IGFjcGlfcHJ0X2VudHJ5ICphY3BpX3BjaV9pcnFfbG9va3Vw
KHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwaW4pOw0KPj4+IMKgIGludCBhY3BpX3BjaV9pcnFf
ZW5hYmxlIChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4+PiDCoCB2b2lkIGFjcGlfcGVuYWxpemVf
aXNhX2lycShpbnQgaXJxLCBpbnQgYWN0aXZlKTsNCj4+PiDCoCBib29sIGFjcGlfaXNhX2lycV9h
dmFpbGFibGUoaW50IGlycSk7DQo+Pj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUveGVuL2FjcGkuaCBi
L2luY2x1ZGUveGVuL2FjcGkuaA0KPj4+IGluZGV4IGIxZTExODYzMTQ0ZC4uY2U3ZjU1NTRmODhl
IDEwMDY0NA0KPj4+IC0tLSBhL2luY2x1ZGUveGVuL2FjcGkuaA0KPj4+ICsrKyBiL2luY2x1ZGUv
eGVuL2FjcGkuaA0KPj4+IEBAIC02Nyw2ICs2Nyw3IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5f
YWNwaV9zbGVlcF9yZWdpc3Rlcih2b2lkKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGFjcGlfc3VzcGVuZF9sb3dsZXZlbCA9IHhlbl9hY3BpX3N1c3BlbmRfbG93bGV2ZWw7
DQo+Pj4gwqDCoMKgwqDCoMKgwqDCoCB9DQo+Pj4gwqAgfQ0KPj4+ICtpbnQgeGVuX3B2aF9wYXNz
dGhyb3VnaF9nc2koc3RydWN0IHBjaV9kZXYgKmRldik7DQo+Pj4gwqAgI2Vsc2UNCj4+PiDCoCBz
dGF0aWMgaW5saW5lIHZvaWQgeGVuX2FjcGlfc2xlZXBfcmVnaXN0ZXIodm9pZCkNCj4+PiDCoCB7
DQo+Pj4NCj4+Pj4NCj4+Pj4gSmFuDQo+Pj4NCj4+PiAtLcKgDQo+Pj4gQmVzdCByZWdhcmRzLA0K
Pj4+IEppcWlhbiBDaGVuLg0KPj4+DQo+IA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBD
aGVuLg0K
