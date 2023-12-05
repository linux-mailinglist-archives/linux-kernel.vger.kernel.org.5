Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D160D804A95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 07:50:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjLEGup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 01:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344505AbjLEGuk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 01:50:40 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED36188;
        Mon,  4 Dec 2023 22:50:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UXZyjhPZBsrP9/NCInsoEaxUySuWaJw8KkDbsD7a3oVqiws4W/495qKi566K2VV5cucRD0kVaZz1Ksyqm9GrFykApP4UwYQWnIGBFGLKxSteJWk0pKkoSbLlsYwTnrzF8mNAc0yA7WUbS1z47b54KhJ+WYsCxXPLa8hjlHW4PT5lJUFZhJN9mkpNwQTmWoBVzYHd6dxPqIffYBhdBdhzE3pwdymmvdfCGr9q08xK4OSuERMzmZ1Rxux7lBit5drsYpSl60uObb/LlxVkjaQck5zIrAC4nV9mLzxQz9lv/i24xom/sOk5FC9nD3bGF/TRXtdzdF0OJ37jNEdj7C5eZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f6RNUL+Ut+CYXBUDWZ4JCiI5JMo8p99RsiMYMVlPc0=;
 b=PeV0iWLujT6KTKGYw5Q/mZCpUvb75Vtq585IkZCs1Kc8ZVXREizce3cGP7PVuloog57/yyerc6vwhTFFJYR3/CeI0zptgsqQACZKr0vEv5qtxwKALN4qLCAMqadc8gBrduSqAMjT+Iwv5IeI8EyrjaraH/czki8RX42mtp6hZwfcluuTfPb4qJI19KKFKiDZoCqXl8/dAAAKUnGlldwKBCR8hs/nQ6x9ofj1m8rN2OdZUnIJodTasfDqy1RQrdndGctSk4WHrbWVz/iZ/NlET/Rxb8DFL1TXxA2hv6NgVi95z90idlFdC740WEcds5aeCXO0j3N9cvhHql84ft0tDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f6RNUL+Ut+CYXBUDWZ4JCiI5JMo8p99RsiMYMVlPc0=;
 b=LggkYs6WOWCMgSzvYhl/CIslfdJhh7AlPBpI2afHatU39X/knZ57tIVpZDnNrMSLDY1DHyxMWx/Cm58gnTSZJ/CzpueyOJEDWK0yhuYY5+iS8e7nOQbOfeCzFsYbouXLOypM5P7zUMC0IdCRmiTiWRA8fzpcbZjatNJBwCu2jzg=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by DS0PR12MB7745.namprd12.prod.outlook.com (2603:10b6:8:13c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 06:50:40 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 06:50:40 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
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
Thread-Index: AQHaHsGaWb8EJvAynUiF4JhdQXSstLCY0coAgACRkoCAAFGagIABIYqA
Date:   Tue, 5 Dec 2023 06:50:40 +0000
Message-ID: <BL1PR12MB5849F70BA37B8612ACAE0127E785A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx>
 <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2312041331210.110490@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB7661.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|DS0PR12MB7745:EE_
x-ms-office365-filtering-correlation-id: 5471572c-7c44-4f17-8220-08dbf55e7ec3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eGvCrMJllxXyNcP2469yhaBtiHjVtbkNtQav/qdsT3yRvCY55qWFSFZsSDIYmGp5/Lj4/QmxsMB+rrl6kdRBmpnVWUtfT77dRdesPojPnOTnVT13eQPzD8CMfSMRgkOkOkhtyWEtszbPTA6rfh0J3v1EJ02rk1PmXzLjA4d6+jWFnD2dt6IIa6tNP6jx6ylsSEyg1zfXg5krZpWm5nVJFfbAgu/C89Su1B67ODby4JZjyEjZPPBR/UPRFfS4rwygzhOAc5ccsVHHKPx6mGelQ2ozcP9b6CAQuA9wrhJdhAUwW3kLLR5mE/bo2MetwP8yVPfCkuJQ3AzDIayfajORki7lOZxe2hbakkpa9g4QtH9n+zbhLqAkco6UwwOM1ZYthWyE0QLrFhsHjBuSuLNypbh7Omv1iKsHiVqOCPfxJGBhuX9Lxg/u5L4o21jLr1FxLkcKw3rxv9/Dhuu+H5mHVYznOTB6dyX68gtu2pDeQxnvvm1+jlo8DmKE+7oIAShofZxOfHSxWjiabZMj45joZBw9LawpkFdddr9LJPfH921nHrhmoqouMDNtYu2WISod5mdRbXNSGw6dQvebbtGmHIyh+0qEvp4aszMRuLMp2MERmqB/0poiOXUECfwrLnCb
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(136003)(366004)(39860400002)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(38100700002)(122000001)(55016003)(53546011)(9686003)(6506007)(7696005)(478600001)(71200400001)(110136005)(54906003)(64756008)(66946007)(66446008)(66556008)(66476007)(76116006)(316002)(26005)(83380400001)(4326008)(8676002)(8936002)(52536014)(5660300002)(7416002)(2906002)(33656002)(38070700009)(41300700001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MldvWUgzNnhZN2VBeEk1STZCOXNvZDZQUGNtNndiS2dBcXVKazFMcFlDWXBj?=
 =?utf-8?B?MG1rUnowVHJTNkdQMFB6RmFDdE1NdC9LeWRPc2duL0UzVXVPODE3NUFuVVNZ?=
 =?utf-8?B?V0Q1SlkwOTN5aEpScXdOckgxSENZZDNrcWdXTUFKQ2RDWU9SQnl0NDNLcmdX?=
 =?utf-8?B?SzRYZE1BWmNIbTc4WXh0TWNLQzZVbUd2SW1JTW0rVzIvYWVoRVl4YXo1RFY3?=
 =?utf-8?B?eWFUUlRUWUYrekxVRWFDSXQzZXNMTmkzdkNEdjhDN2p3akhrTkUyNzNPZHJu?=
 =?utf-8?B?c2dOL2N0bnI3bTBRQUxPWE1SYUMyWVQrRDl2b3hCQnpJaGFEZTh2QmxBS29Q?=
 =?utf-8?B?cml3ZmZyN3dIQnNPR2hvMlZrQTR3L1IxQTNHQ1dXQTNMeE1aZEVyaDA3UG14?=
 =?utf-8?B?dHVZb3FxWWIwUHM2M0huSmlUU0Q3c1VDcTZPQkVqRWMyTmhxL1pVVjlhM1pr?=
 =?utf-8?B?bUdPUExZV0lSOEdiOVdyV2FxV2JHYXZwdFhIdzgxaTRRNjgyeW5OS2xTNVBj?=
 =?utf-8?B?TlBNQ2ZzV21XQkRoYXJPSUUyWnpGK045YkZjYWk0cUhUcjNNZkJoV3A2aWRB?=
 =?utf-8?B?L1VQL1U5bzB6WWptQTVlVW9CQVYzbk5EMndFTm5XTjZmOFhvVzBHUGMrcElk?=
 =?utf-8?B?S0l4dnZ3aWpQTlo2WFAveHJHMHFQelhHeVptMzRTbjhPbG90NVhJRGFjRmZv?=
 =?utf-8?B?WkFDSXRpd2kwcU1IUldURTV2WWxEOHV4TlpmU0tmckJjbnk5a1Jra2F0Tk95?=
 =?utf-8?B?Yk1mTCs4ellPNWljbDI0YjVqSjR5akZKVmwzR21KaExzbzd2MEM1SjRlY1lH?=
 =?utf-8?B?WjBaT0UrQk9Rb3N4YjFIcFd1cHNybnVLcTBqMXpKUVd2NEtKcEVxODRUR1VR?=
 =?utf-8?B?M3hJdmJPTThTOHdzOUp2Ui95ZzRvZno3NEtzbDM3NFBvc3YzdStacnk1bkxK?=
 =?utf-8?B?Nnl1WjdWOW9LU1BQRU1Nd2lFaTdVckFBKzh0NDJCcFE1Wk1IMmx0bC9UTGlx?=
 =?utf-8?B?enYycEladlJHYUdhYVhHQ3FTZWlmUTA0T3JhMEpoOUdXQjYzalhla2hCSE9M?=
 =?utf-8?B?dHpnK08vcHZ1Z2l1QzF1bk9wSUdhcXNQNHB1TWhzZFhFczV3SVNoL1c5b1lx?=
 =?utf-8?B?WGRFZGF5MlNoYVlKb1FER0hCVWVnV0VQdXN4L3kwQ1FURk1YWFh2NEZmRTdq?=
 =?utf-8?B?SlQ5d2hkMlBLaURPZFBhYThEa0w4c0NTOEZEaExlRXR4cWkwQUs2aFV3L29t?=
 =?utf-8?B?WDlnZml2WmZiSDE1YXpkM2xZc0FtbmhISGM2Y1Vka0dQSGRwN1psUXNlMGxq?=
 =?utf-8?B?WmsyZSsrQnN6bWVtakh6dDVTNHoySHhMQ3ExNTlGNWk1dnhPRkFJSnB2UEFZ?=
 =?utf-8?B?OGxwRkZ3M01oeEd3VXBGZUZpYjhJaHJVeFBOanQyZEMrSnZSY0Z2dDBCNkto?=
 =?utf-8?B?UldxdFNLRkFDWHZPTHpDdlRyV0F6UnR1K2RFUkpTL0pJMVVzQ1JSZEora3VB?=
 =?utf-8?B?ZzYrb0wzTVo2cHRUcDI1SlpnaFNqQWhuQXhXeGJkNHZTZFpSRHlqRENFTksx?=
 =?utf-8?B?ZGpQM2t0UVNsMDVQTVNoZDdQVjdkSm9ZWldoa0RPN29wUFVtY2JDZ3NseURz?=
 =?utf-8?B?SDVsY3pDVzhtcXhsVUt0eGMyMXBjK3JBdVJsdUs1VTBTeVA2M2ZnTUFuUlA3?=
 =?utf-8?B?Q0RnNldHR3lBTmFMRm5iekxaZjhRdlRlVUpvNVZWazVZak82TUZCdHNscnNj?=
 =?utf-8?B?OEFQTWwrR0h6ZzZqVjgzZXFkNWFjNC96RFFLVmdoeCt4UVQwRVA4c005dU0w?=
 =?utf-8?B?RERKMzR0bnJEa3RlVDBmeEhpQnExS25qVEhFaU5aRGZ6VWxKWjBFNnd4Q3VE?=
 =?utf-8?B?OHBBR3M3VHNTZzVtM2tKaVo1K091eWRCMHBxdnU5cWFWQkR6U2RHdXg2STUw?=
 =?utf-8?B?Yi80UjIyYUszTVVIeWNwM3pxaXg3UFcvTm1lTmtZak1jTnM0RjJYcHNmT1k5?=
 =?utf-8?B?QTFSc0NvVDNMUmVjVG8wZ0phcEpXQUVTeWV1VmlrRWg0aGpJZjNlTzlkNkUw?=
 =?utf-8?B?Znl5QVIxbC9kL0h6cHpNZXE3YWFCdzU3d3RJMGVFRUhyL25sSWJueXFvUVNt?=
 =?utf-8?Q?6HgA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <33FB979D19384B4D901DE537355E7F4D@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5471572c-7c44-4f17-8220-08dbf55e7ec3
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2023 06:50:40.5049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esRnGxmSEtFxfB6302diDexVOR4eFOP8HhCtGumMr89ZhTAZJ4iNAP7iaFa18kv5ixaWVY+lzoZKTc8d5NSLhw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7745
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjAyMy8xMi81IDA1OjMxLCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IE9uIE1vbiwg
MyBEZWMgMjAyMywgQ2hlbiwgSmlxaWFuIHdyb3RlOg0KPj4+PiB2cGNpIGRldmljZSBzdGF0ZSB3
aGVuIGRldmljZSBpcyByZXNldCBvbiBkb20wIHNpZGUuDQo+Pj4+DQo+Pj4+IEFuZCBjYWxsIHRo
YXQgZnVuY3Rpb24gaW4gcGNpc3R1Yl9pbml0X2RldmljZS4gQmVjYXVzZSB3aGVuDQo+Pj4+IHdl
IHVzZSAicGNpLWFzc2lnbmFibGUtYWRkIiB0byBhc3NpZ24gYSBwYXNzdGhyb3VnaCBkZXZpY2Ug
aW4NCj4+Pj4gWGVuLCBpdCB3aWxsIHJlc2V0IHBhc3N0aHJvdWdoIGRldmljZSBhbmQgdGhlIHZw
Y2kgc3RhdGUgd2lsbA0KPj4+PiBvdXQgb2YgZGF0ZSwgYW5kIHRoZW4gZGV2aWNlIHdpbGwgZmFp
bCB0byByZXN0b3JlIGJhciBzdGF0ZS4NCj4+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogSmlxaWFu
IENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+Pj4+IFNpZ25lZC1vZmYtYnk6IEh1YW5nIFJ1
aSA8cmF5Lmh1YW5nQGFtZC5jb20+DQo+Pj4NCj4+PiBUaGlzIFNpZ25lZC1vZmYtYnkgY2hhaW4g
aXMgaW5jb3JyZWN0Lg0KPj4+DQo+Pj4gRG9jdW1lbnRhdGlvbi9wcm9jZXNzL3N1Ym1pdHRpbmct
cGF0Y2hlcy5yc3QgaGFzIGEgZnVsbCBjaGFwdGVyIGFib3V0DQo+Pj4gUy1PLUIgYW5kIHRoZSBj
b3JyZWN0IHVzYWdlLg0KPj4gSSBhbSB0aGUgYXV0aG9yIG9mIHRoaXMgc2VyaWVzIG9mIHBhdGNo
ZXMsIGFuZCBIdWFuZyBSdWkgdHJhbnNwb3J0ZWQgdGhlIHYxIHRvIHVwc3RyZWFtLiBBbmQgbm93
IEkgdHJhbnNwb3J0IHYyLiBJIGFtIG5vdCBhd2FyZSB0aGF0IHRoZSBTT0IgY2hhaW4gaXMgaW5j
b3JyZWN0Lg0KPj4gRG8geW91IGhhdmUgYW55IHN1Z2dlc3Rpb25zPw0KPiANCj4gSSB0aGluayBo
ZSBtZWFucyB0aGF0IHlvdXIgU2lnbmVkLW9mZi1ieSBzaG91bGQgYmUgdGhlIHNlY29uZCBvbmUg
b2YgdGhlDQo+IHR3byBhcyB5b3UgYXJlIHRoZSBvbmUgc3VibWl0dGluZyB0aGUgcGF0Y2ggdG8g
dGhlIExLTUwNCkdvdCBpdC4gVGhhbmtzIFN0ZWZhbm8hIEkgd2lsbCBhZGp1c3QgdGhlIHNlcXVl
bmNlIGluIG5leHQgdmVyc2lvbi4NCg0KLS0gDQpCZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4N
Cg==
