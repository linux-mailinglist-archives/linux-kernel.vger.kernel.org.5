Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2362B807F3F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 04:48:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229496AbjLGDiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 22:38:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjLGDiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 22:38:10 -0500
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2065.outbound.protection.outlook.com [40.107.100.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBA7A4;
        Wed,  6 Dec 2023 19:38:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Az4uSC7R4ya3VVCfbTBS/iUMpwXOa4QzvXRUgH0AA1GkCgqEFkNksbaqVkZ1Svp2uGQEhir+i65T4pi8naQ/TJI5jR8gGmFy/ZFsuayhd7fMRO0T9HP2Ldij2piRtoovvofftgdEju3yWkiyolgzKnfe0014+WezTnOKc3ciwdyayPUZxb/TCsoi636AwP1N8WiLLF5gSNTW5UP7oZYzSG8aN32kSQfmL+T/sMN8aZy89xMpsSmkZOMM1/sQYCuk2+0jDjnq3miBjAEmWr5nJf7/FsYlkWuL3Wtxo4VXhhGmEUy7vZqQbM+f4CUSI/O1NM4C9gQvgwXZlfEsiZEMZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ol/wIxQCWBozCV33HEE499j8JVNtbjiWI3tgfIHz8k=;
 b=oR+MGhkSfO6EfZd01KhCxOmiPerWRhxbmnGUoD/IJps3oawJBnu58tdqnKFXD6kILUOCJxityB2dmht89ZrSm39OPujwswoDoohZH3Y22yOEuLZL3hhCE8kRdxqZzWr6PGdRuofvBl526W5wT1yg6tO1g+kcfZqQEr9qrkHPdURmsy0pd/xsKMmN1wjtzKdR1YB7Uz9Trwyu3+rAR5wXw65+uwM6rfPiZ1+uBaXzCP8HzJHr5t9OM3ZA2WE4VYLibXSp1MySLmmjRwmqAn/lH84CVNPJxDjYOgs8EwrB364x49+meiwm0jq7fnty81mp0K8QrEBTHcUuGRbdnIsOfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ol/wIxQCWBozCV33HEE499j8JVNtbjiWI3tgfIHz8k=;
 b=qfaWVjPepPBCsg2/x3XHPJ9cIGBTI4e4m14ySQ2KOFKjdzkApGreOmX4SRQbrWOLFVjbO4qLRR6rKGHGEsVBRkualr03FDF2VSjjS3MCh14avbe9ZNUKhLtH+HvE+YsFblQHUb3fepgAjunsnl0V2X5OPo9prHqniwSnvCwTD1w=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by SA3PR12MB7924.namprd12.prod.outlook.com (2603:10b6:806:313::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 03:38:12 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.034; Thu, 7 Dec 2023
 03:38:12 +0000
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
Thread-Index: AQHaHsGdlNZnjmvNCkucW725DqxYz7CSRC+AgADLdgCAALwOgIAAX9AAgAE42ICAA5dDgIAAxsiAgAC4TACAABRoAIABzBGAgADOj4CAAJuaAA==
Date:   Thu, 7 Dec 2023 03:38:12 +0000
Message-ID: <BL1PR12MB58494072635E3C6CEA628AD9E78BA@BL1PR12MB5849.namprd12.prod.outlook.com>
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
In-Reply-To: <alpine.DEB.2.22.394.2312061818030.1265976@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: IA1PR12MB7757.namprd12.prod.outlook.com
 (15.20.7091.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|SA3PR12MB7924:EE_
x-ms-office365-filtering-correlation-id: 6a31c946-133b-4401-a6b9-08dbf6d5f02c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VzLVeFmuXL5DTbMwALKP0p0vMUpra/xnkzdKXdI54pKU6K66e0pldt6DlXH7wEG1h/Cu8M28VvaZQi2SA4aFl0WNK9+Gt4P19N4ehxXpbNKbzA76HWueiAtev3AUPGshAYt/sHm+kAjqDE+cbQX8IK7Rx59IXJeqA3ZU/tORoCoMy17DJnfE4e5FIctFF0lT0sLx2obf9Wbi+9KljaRAE5/N2VIT90VvmiHbZhEYYhS2lDUlcOLWSrxib/3smaANLhNjfsoqKNM8MFLNUjXuADArITyrX887TJS4yily0FqB6OqHWGMaCFqAaWAjF3fJQ3hOIU+d+g8JkizTo8mmCoAeZJXC4dhR51eWKZuAGBRtICGOOJbuElcM3XJbdTDFjMCv5rQ/upHeq/megvD8arU0CxRPiPErELJpVNncFYmUhDm9Rre7uD09LKf0RBY2kcQ7IhJEmmZwF+qc7Pljg4tmwWv4QoNF9Sgvcgi3I241BL+Go1o835U6lu0mvK4I2c6CFTXmEGG99am6cJhQvw7coEoBWpOlO+Df5WzYdpKiDzZlykOvDY7XrrJ5fOWtHU9z3euXvYwRj2BS/D6IHqGa8CQqX4AnrGAwfnIF+VW2XqmlZcJOGeKKtj47cS9X
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(396003)(366004)(376002)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(5660300002)(2906002)(41300700001)(122000001)(38100700002)(76116006)(66476007)(66446008)(64756008)(54906003)(66556008)(66946007)(110136005)(71200400001)(478600001)(26005)(53546011)(6506007)(7696005)(9686003)(83380400001)(8936002)(52536014)(8676002)(4326008)(316002)(33656002)(38070700009)(55016003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RUFkd0NyMWhvVVRnckF6TWlFQ3YxcTdOTUdJNTEzOHNuSXpVeVV4WHl3NU9Z?=
 =?utf-8?B?bHBJMHRXV3RYbWRTZ0ZPQTVWbnFtb3Z1clVlLzhOUDJ6YUl5ZTJZMUZmUUVK?=
 =?utf-8?B?TUpoZS92a3hteitGK3R4c0FNaGgvNU85NXZmREsvaS9uZUhKSTFhL2lzTzdh?=
 =?utf-8?B?NkUxMlU4c1hjWHZyY3cyOU8xckUwRDZmUnl3cXpDWFN3WDBDQ1RpN0M5czNV?=
 =?utf-8?B?VnIwTTVpdGIxYWY1YUFNR2QvOUNUNWZZd3NVbDQ5citRVUNDZE0wczNsOUhv?=
 =?utf-8?B?Tm9YOWJqR1Z5SkFuZ1FmdG1yblRUODIrZ2xvMmE0Q3JrZmxFNitZL0lqcS9U?=
 =?utf-8?B?WkVsQzhSb2pXMk5jYlpvc1ZTYTcyZmlxUGZpKzg2ejBlbU5EU1NRTXRGZ0J0?=
 =?utf-8?B?N1hMTHl4Z29lMTRiL1QwN3pQT2N6b3p0UlEwVEUvZk9RMGpzRjh5SUNpVTJ2?=
 =?utf-8?B?SklQUDVoanZHdlh4MjZZL2p2NHRmVS9XczZ4VjUvQm1hRWFkeTMrK2FvUC9x?=
 =?utf-8?B?ZWthYkMvVW1adWFKM1llR01hdnhrbTQvNEFncVVOc2FSSU81QmNIS2QvcmVC?=
 =?utf-8?B?MUN1VzRHeFY0SzVteUdzSmxsYm1XTnJNUHJTOG9oMmlVZkpyMXRIV1JGT0VE?=
 =?utf-8?B?N0tGTUxlME80cjNWVzJKWlBsK05tWldTam5WK2RxWnJZWmFTTGlyS3huajg1?=
 =?utf-8?B?U2ZMMUIwMllNUEJwOVlxTFp1M2RRV1l6bGJwN2JjUkt3S3lRQmFyME1RQlgv?=
 =?utf-8?B?b1FOUnQwUnlhL2IxT25ST1dIUzZnRjVSUkVZY1BlVEVIaGk0bm0zcnRoVzBN?=
 =?utf-8?B?WDZ1NjY2RmlvZEhCUWVrOENURlJTRHFYYlhTaFZXdlREbHJIcFp0U1F2Qkgv?=
 =?utf-8?B?Mlc0clBLcFd2ZnZ6L1Fqek5tSXhzcXQ1d2VMQVpHcWtMTW9qOXJUdG1iRGZF?=
 =?utf-8?B?ZWh6M1RjTlFTTDE5Vm81K28rb2t0ZGJRczdnZ2tVd2NndGlDZEJ4QkZrY21U?=
 =?utf-8?B?dnZEZkp1WDVwc0h2ZnFSSm5vQ0Vxd0FkcVVIOVpsNk1KWDNGcVpKQ20rU1BX?=
 =?utf-8?B?RkExNjZlb0ttNTNiN2VrVUE1Z1FJQW5MNHJlMDdmOXBVVFB2S1J5MGxNYUNj?=
 =?utf-8?B?c25rR2xlQ2ZMMVdPL2pWdlVjWm5uVTQwZkZpZEpuR0ZWNjE3bnI4bWFRSlFS?=
 =?utf-8?B?czRXQUFQS2oyaUdrWU5QdTVxZjJvbG9xUkFuK1hxK0lSQzUrcjVvRjFlVTlp?=
 =?utf-8?B?dXBxZFJDaUxrR2hzM2QzUmdpcCtFbW1ieG4zUVJKSUVqcXkzMWdZR2E3MkFU?=
 =?utf-8?B?SGlmV3hPTFREdzU5VXlFY1pLVEtoczdrSDIwZ3FjUWxNTEU4VWxxY0xXRHpw?=
 =?utf-8?B?L21yMTFIK0NzN1ZxTW52azhqdWc3bW5QU1BSU1hCWnFCK1VTTDlFZ0ZPM3lu?=
 =?utf-8?B?Ui9sanZ3TWp0UVltalozcUN5YjRCZGZkM2RJcGs0emtaOXdHYVU2eC9GN0l0?=
 =?utf-8?B?N1BSaUNERG5qNXNBUDFuajF4UXUyOHBadlFzRURBRFBORUpVellKS1JVN0Zi?=
 =?utf-8?B?clh4enhzMjNJZnBMQS9nSHhZZXFtSkQ1amlCdnh1UDlGMVZrY21qd09LZlFh?=
 =?utf-8?B?VWRuTkVkNWZxeTk3cUxSaExHVzRPMjBaSjI4dlYyV2FnbXgvY29KNldXYlRX?=
 =?utf-8?B?UEd4SWQ1eDdyRC81S0ZtcmdpUzFjMmFLbW1aZVh1c1NBbTZpZGQzMHVKNkNW?=
 =?utf-8?B?NnY5eU1sYzZ6NkNCSTQ2RVZSdWZUNDg5ZEZqWlFUQ0lLemZZQjJYOHFHU05Q?=
 =?utf-8?B?M080ZVd3blRyZkhQbVpTZUlLTVQ1N05QRW1MSUZDcWdsdWJPSVMwTG0zZC9r?=
 =?utf-8?B?WnNqSnZDNGVWWnI5Q2pEVkdTUEU4ZUJvT1QwMnVwR3NDd21NVGJBcHQyRFRC?=
 =?utf-8?B?SnVJclNVNmdLTkdJQVhVMzk5NXpKQmJsaG9jaTR1ekd0N042aVdvaUdSM1ox?=
 =?utf-8?B?V25EVUROOUJBWHNzbi9acVYvNVY1MmM3OC92bnJzemUrT3RDYkVCY0xCMFNp?=
 =?utf-8?B?NktWcmZ0RVpqdE91dXVFRWZiOS8wSjFPTEhJMUF3Mm5ZYVVZaStnTC91RDVD?=
 =?utf-8?Q?CDEo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4A24FAC7503899409F781640B7FD708B@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a31c946-133b-4401-a6b9-08dbf6d5f02c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 03:38:12.0699
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1tdsFMDvmGibFYVuAEQs53V4zsb2J8oRZ9Rjwb776QcyxYXR5Rlke1CHILp1g5dTP19q+wTPDDr5bYXrIH8XHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7924
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KEFkZGluZyBKdWVyZ2VuIHRvIHRoZSAiVG8iIGxpc3QuKQ0KDQpIaSBKdWVyZ2VuLCANCkxvb2tp
bmcgZm9yd2FyZCB0byB5b3VyIG9waW5pb25zLg0KDQpPbiAyMDIzLzEyLzcgMTA6MTgsIFN0ZWZh
bm8gU3RhYmVsbGluaSB3cm90ZToNCj4gT24gVHVlLCA1IERlYyAyMDIzLCBDaGVuLCBKaXFpYW4g
d3JvdGU6DQo+PiBXaGVuIFBWSCBkb20wIGVuYWJsZSBhIGRldmljZSwgaXQgd2lsbCBnZXQgdHJp
Z2dlciBhbmQgcG9sYXJpdHkgZnJvbSBBQ1BJIChzZWUgYWNwaV9wY2lfaXJxX2VuYWJsZSkNCj4+
IEkgaGF2ZSBhIHZlcnNpb24gb2YgcGF0Y2ggd2hpY2ggdHJpZWQgdGhhdCB3YXksIHNlZSBiZWxv
dzoNCj4gDQo+IFRoaXMgYXBwcm9hY2ggbG9va3MgbXVjaCBiZXR0ZXIuIEkgdGhpbmsgdGhpcyBw
YXRjaCBpcyBPS2lzaC4gSnVlcmdlbiwNCj4gd2hhdCBkbyB5b3UgdGhpbms/DQo+IA0KPiANCj4+
IGRpZmYgLS1naXQgYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jIGIvYXJjaC94ODYveGVu
L2VubGlnaHRlbl9wdmguYw0KPj4gaW5kZXggYWRhMzg2OGMwMmMyLi40M2UxYmRhOWY5NDYgMTAw
NjQ0DQo+PiAtLS0gYS9hcmNoL3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jDQo+PiArKysgYi9hcmNo
L3g4Ni94ZW4vZW5saWdodGVuX3B2aC5jDQo+PiBAQCAtMSw2ICsxLDcgQEANCj4+ICAvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPj4gICNpbmNsdWRlIDxsaW51eC9hY3BpLmg+
DQo+PiAgI2luY2x1ZGUgPGxpbnV4L2V4cG9ydC5oPg0KPj4gKyNpbmNsdWRlIDxsaW51eC9wY2ku
aD4NCj4+DQo+PiAgI2luY2x1ZGUgPHhlbi9odmMtY29uc29sZS5oPg0KPj4NCj4+IEBAIC0yNSw2
ICsyNiwxMjcgQEANCj4+ICBib29sIF9fcm9fYWZ0ZXJfaW5pdCB4ZW5fcHZoOw0KPj4gIEVYUE9S
VF9TWU1CT0xfR1BMKHhlbl9wdmgpOw0KPj4NCj4+ICt0eXBlZGVmIHN0cnVjdCBnc2lfaW5mbyB7
DQo+PiArICAgICAgIGludCBnc2k7DQo+PiArICAgICAgIGludCB0cmlnZ2VyOw0KPj4gKyAgICAg
ICBpbnQgcG9sYXJpdHk7DQo+PiArICAgICAgIGludCBwaXJxOw0KPj4gK30gZ3NpX2luZm9fdDsN
Cj4+ICsNCj4+ICtzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgew0KPj4gKyAgICAgICBzdHJ1Y3QgYWNw
aV9wY2lfaWQgICAgICBpZDsNCj4+ICsgICAgICAgdTggICAgICAgICAgICAgICAgICAgICAgcGlu
Ow0KPj4gKyAgICAgICBhY3BpX2hhbmRsZSAgICAgICAgICAgICBsaW5rOw0KPj4gKyAgICAgICB1
MzIgICAgICAgICAgICAgICAgICAgICBpbmRleDsgICAgICAgICAgLyogR1NJLCBvciBsaW5rIF9D
UlMgaW5kZXggKi8NCj4+ICt9Ow0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF9nZXRfZ3Np
X2luZm8oc3RydWN0IHBjaV9kZXYgKmRldiwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBnc2lfaW5mb190ICpnc2lfaW5m
bykNCj4+ICt7DQo+PiArICAgICAgIGludCBnc2k7DQo+PiArICAgICAgIHU4IHBpbiA9IDA7DQo+
PiArICAgICAgIHN0cnVjdCBhY3BpX3BydF9lbnRyeSAqZW50cnk7DQo+PiArICAgICAgIGludCB0
cmlnZ2VyID0gQUNQSV9MRVZFTF9TRU5TSVRJVkU7DQo+PiArICAgICAgIGludCBwb2xhcml0eSA9
IGFjcGlfaXJxX21vZGVsID09IEFDUElfSVJRX01PREVMX0dJQyA/DQo+PiArICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEFDUElfQUNUSVZFX0hJR0ggOiBBQ1BJX0FDVElWRV9M
T1c7DQo+PiArDQo+PiArICAgICAgIGlmIChkZXYpDQo+PiArICAgICAgICAgICAgICAgcGluID0g
ZGV2LT5waW47DQo+PiArICAgICAgIGlmICghcGluKSB7DQo+PiArICAgICAgICAgICAgICAgeGVu
X3Jhd19wcmludGsoIk5vIGludGVycnVwdCBwaW4gY29uZmlndXJlZFxuIik7DQo+PiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+PiArICAgICAgIH0NCj4+ICsNCj4+ICsgICAgICAg
ZW50cnkgPSBhY3BpX3BjaV9pcnFfbG9va3VwKGRldiwgcGluKTsNCj4+ICsgICAgICAgaWYgKGVu
dHJ5KSB7DQo+PiArICAgICAgICAgICAgICAgaWYgKGVudHJ5LT5saW5rKQ0KPj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgZ3NpID0gYWNwaV9wY2lfbGlua19hbGxvY2F0ZV9pcnEoZW50cnktPmxp
bmssDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBlbnRyeS0+aW5kZXgsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAmdHJpZ2dlciwgJnBvbGFyaXR5LA0KPj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTlVMTCk7
DQo+PiArICAgICAgICAgICAgICAgZWxzZQ0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgZ3Np
ID0gZW50cnktPmluZGV4Ow0KPj4gKyAgICAgICB9IGVsc2UNCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gLUVJTlZBTDsNCj4+ICsNCj4+ICsgICAgICAgZ3NpX2luZm8tPmdzaSA9IGdzaTsNCj4+
ICsgICAgICAgZ3NpX2luZm8tPnRyaWdnZXIgPSB0cmlnZ2VyOw0KPj4gKyAgICAgICBnc2lfaW5m
by0+cG9sYXJpdHkgPSBwb2xhcml0eTsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIDA7DQo+PiAr
fQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF9tYXBfcGlycShnc2lfaW5mb190ICpnc2lf
aW5mbykNCj4+ICt7DQo+PiArICAgICAgIHN0cnVjdCBwaHlzZGV2X21hcF9waXJxIG1hcF9pcnE7
DQo+PiArICAgICAgIGludCByZXQ7DQo+PiArDQo+PiArICAgICAgIG1hcF9pcnEuZG9taWQgPSBE
T01JRF9TRUxGOw0KPj4gKyAgICAgICBtYXBfaXJxLnR5cGUgPSBNQVBfUElSUV9UWVBFX0dTSTsN
Cj4+ICsgICAgICAgbWFwX2lycS5pbmRleCA9IGdzaV9pbmZvLT5nc2k7DQo+PiArICAgICAgIG1h
cF9pcnEucGlycSA9IGdzaV9pbmZvLT5nc2k7DQo+PiArDQo+PiArICAgICAgIHJldCA9IEhZUEVS
VklTT1JfcGh5c2Rldl9vcChQSFlTREVWT1BfbWFwX3BpcnEsICZtYXBfaXJxKTsNCj4+ICsgICAg
ICAgZ3NpX2luZm8tPnBpcnEgPSBtYXBfaXJxLnBpcnE7DQo+PiArDQo+PiArICAgICAgIHJldHVy
biByZXQ7DQo+PiArfQ0KPj4gKw0KPj4gK3N0YXRpYyBpbnQgeGVuX3B2aF91bm1hcF9waXJxKGdz
aV9pbmZvX3QgKmdzaV9pbmZvKQ0KPj4gK3sNCj4+ICsgICAgICAgc3RydWN0IHBoeXNkZXZfdW5t
YXBfcGlycSB1bm1hcF9pcnE7DQo+PiArDQo+PiArICAgICAgIHVubWFwX2lycS5kb21pZCA9IERP
TUlEX1NFTEY7DQo+PiArICAgICAgIHVubWFwX2lycS5waXJxID0gZ3NpX2luZm8tPnBpcnE7DQo+
PiArDQo+PiArICAgICAgIHJldHVybiBIWVBFUlZJU09SX3BoeXNkZXZfb3AoUEhZU0RFVk9QX3Vu
bWFwX3BpcnEsICZ1bm1hcF9pcnEpOw0KPj4gK30NCj4+ICsNCj4+ICtzdGF0aWMgaW50IHhlbl9w
dmhfc2V0dXBfZ3NpKGdzaV9pbmZvX3QgKmdzaV9pbmZvKQ0KPj4gK3sNCj4+ICsgICAgICAgc3Ry
dWN0IHBoeXNkZXZfc2V0dXBfZ3NpIHNldHVwX2dzaTsNCj4+ICsNCj4+ICsgICAgICAgc2V0dXBf
Z3NpLmdzaSA9IGdzaV9pbmZvLT5nc2k7DQo+PiArICAgICAgIHNldHVwX2dzaS50cmlnZ2VyaW5n
ID0gKGdzaV9pbmZvLT50cmlnZ2VyID09IEFDUElfRURHRV9TRU5TSVRJVkUgPyAwIDogMSk7DQo+
PiArICAgICAgIHNldHVwX2dzaS5wb2xhcml0eSA9IChnc2lfaW5mby0+cG9sYXJpdHkgPT0gQUNQ
SV9BQ1RJVkVfSElHSCA/IDAgOiAxKTsNCj4+ICsNCj4+ICsgICAgICAgcmV0dXJuIEhZUEVSVklT
T1JfcGh5c2Rldl9vcChQSFlTREVWT1Bfc2V0dXBfZ3NpLCAmc2V0dXBfZ3NpKTsNCj4+ICt9DQo+
PiArDQo+PiAraW50IHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3NpKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+PiArew0KPj4gKyAgICAgICBpbnQgcmV0Ow0KPj4gKyAgICAgICBnc2lfaW5mb190IGdzaV9p
bmZvOw0KPj4gKw0KPj4gKyAgICAgICBpZiAoIWRldikgew0KPj4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRUlOVkFMOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHJldCA9IHhlbl9w
dmhfZ2V0X2dzaV9pbmZvKGRldiwgJmdzaV9pbmZvKTsNCj4+ICsgICAgICAgaWYgKHJldCkgew0K
Pj4gKyAgICAgICAgICAgICAgIHhlbl9yYXdfcHJpbnRrKCJGYWlsIHRvIGdldCBnc2kgaW5mbyFc
biIpOw0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiByZXQ7DQo+PiArICAgICAgIH0NCj4+ICsN
Cj4+ICsgICAgICAgcmV0ID0geGVuX3B2aF9tYXBfcGlycSgmZ3NpX2luZm8pOw0KPj4gKyAgICAg
ICBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgeGVuX3Jhd19wcmludGsoIkZhaWwgdG8g
bWFwIHBpcnEgZm9yIGdzaSAoJWQpIVxuIiwgZ3NpX2luZm8uZ3NpKTsNCj4+ICsgICAgICAgICAg
ICAgICByZXR1cm4gcmV0Ow0KPj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIHJldCA9IHhl
bl9wdmhfc2V0dXBfZ3NpKCZnc2lfaW5mbyk7DQo+PiArICAgICAgIGlmIChyZXQgPT0gLUVFWElT
VCkgew0KPj4gKyAgICAgICAgICAgICAgIHJldCA9IDA7DQo+PiArICAgICAgICAgICAgICAgeGVu
X3Jhd19wcmludGsoIkFscmVhZHkgc2V0dXAgdGhlIEdTSSA6JXVcbiIsIGdzaV9pbmZvLmdzaSk7
DQo+PiArICAgICAgIH0gZWxzZSBpZiAocmV0KSB7DQo+PiArICAgICAgICAgICAgICAgeGVuX3Jh
d19wcmludGsoIkZhaWwgdG8gc2V0dXAgZ3NpICglZCkhXG4iLCBnc2lfaW5mby5nc2kpOw0KPj4g
KyAgICAgICAgICAgICAgIHhlbl9wdmhfdW5tYXBfcGlycSgmZ3NpX2luZm8pOw0KPj4gKyAgICAg
ICB9DQo+PiArDQo+PiArICAgICAgIHJldHVybiByZXQ7DQo+PiArfQ0KPj4gK0VYUE9SVF9TWU1C
T0xfR1BMKHhlbl9wdmhfcGFzc3Rocm91Z2hfZ3NpKTsNCj4+ICsNCj4+ICB2b2lkIF9faW5pdCB4
ZW5fcHZoX2luaXQoc3RydWN0IGJvb3RfcGFyYW1zICpib290X3BhcmFtcykNCj4+ICB7DQo+PiAg
ICAgICAgIHUzMiBtc3I7DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hY3BpL3BjaV9pcnEuYyBi
L2RyaXZlcnMvYWNwaS9wY2lfaXJxLmMNCj4+IGluZGV4IGZmMzBjZWNhMjIwMy4uNjMwZmUwYTM0
YmM2IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy9hY3BpL3BjaV9pcnEuYw0KPj4gKysrIGIvZHJp
dmVycy9hY3BpL3BjaV9pcnEuYw0KPj4gQEAgLTI4OCw3ICsyODgsNyBAQCBzdGF0aWMgaW50IGFj
cGlfcmVyb3V0ZV9ib290X2ludGVycnVwdChzdHJ1Y3QgcGNpX2RldiAqZGV2LA0KPj4gIH0NCj4+
ICAjZW5kaWYgLyogQ09ORklHX1g4Nl9JT19BUElDICovDQo+Pg0KPj4gLXN0YXRpYyBzdHJ1Y3Qg
YWNwaV9wcnRfZW50cnkgKmFjcGlfcGNpX2lycV9sb29rdXAoc3RydWN0IHBjaV9kZXYgKmRldiwg
aW50IHBpbikNCj4+ICtzdHJ1Y3QgYWNwaV9wcnRfZW50cnkgKmFjcGlfcGNpX2lycV9sb29rdXAo
c3RydWN0IHBjaV9kZXYgKmRldiwgaW50IHBpbikNCj4+ICB7DQo+PiAgICAgICAgIHN0cnVjdCBh
Y3BpX3BydF9lbnRyeSAqZW50cnkgPSBOVUxMOw0KPj4gICAgICAgICBzdHJ1Y3QgcGNpX2RldiAq
YnJpZGdlOw0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHVi
LmMgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+PiBpbmRleCBlMzRiNjIz
ZTRiNDEuLjFhYmQ0ZGFkNmY0MCAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMveGVuL3hlbi1wY2li
YWNrL3BjaV9zdHViLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3hlbi1wY2liYWNrL3BjaV9zdHVi
LmMNCj4+IEBAIC0yMCw2ICsyMCw3IEBADQo+PiAgI2luY2x1ZGUgPGxpbnV4L2F0b21pYy5oPg0K
Pj4gICNpbmNsdWRlIDx4ZW4vZXZlbnRzLmg+DQo+PiAgI2luY2x1ZGUgPHhlbi9wY2kuaD4NCj4+
ICsjaW5jbHVkZSA8eGVuL2FjcGkuaD4NCj4+ICAjaW5jbHVkZSA8eGVuL3hlbi5oPg0KPj4gICNp
bmNsdWRlIDxhc20veGVuL2h5cGVydmlzb3IuaD4NCj4+ICAjaW5jbHVkZSA8eGVuL2ludGVyZmFj
ZS9waHlzZGV2Lmg+DQo+PiBAQCAtMzk5LDYgKzQwMCwxMiBAQCBzdGF0aWMgaW50IHBjaXN0dWJf
aW5pdF9kZXZpY2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4+ICAgICAgICAgaWYgKGVycikNCj4+
ICAgICAgICAgICAgICAgICBnb3RvIGNvbmZpZ19yZWxlYXNlOw0KPj4NCj4+ICsgICAgICAgaWYg
KHhlbl9pbml0aWFsX2RvbWFpbigpICYmIHhlbl9wdmhfZG9tYWluKCkpIHsNCj4+ICsgICAgICAg
ICAgICAgICBlcnIgPSB4ZW5fcHZoX3Bhc3N0aHJvdWdoX2dzaShkZXYpOw0KPj4gKyAgICAgICAg
ICAgICAgIGlmIChlcnIpDQo+PiArICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGNvbmZpZ19y
ZWxlYXNlOw0KPj4gKyAgICAgICB9DQo+PiArDQo+PiAgICAgICAgIGlmIChkZXYtPm1zaXhfY2Fw
KSB7DQo+PiAgICAgICAgICAgICAgICAgc3RydWN0IHBoeXNkZXZfcGNpX2RldmljZSBwcGRldiA9
IHsNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgIC5zZWcgPSBwY2lfZG9tYWluX25yKGRldi0+
YnVzKSwNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2FjcGkuaCBiL2luY2x1ZGUvbGlu
dXgvYWNwaS5oDQo+PiBpbmRleCA2NDFkYzQ4NDM5ODcuLjM2OGQ1NmJhMmM1ZSAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvbGludXgvYWNwaS5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2FjcGku
aA0KPj4gQEAgLTM3NSw2ICszNzUsNyBAQCB2b2lkIGFjcGlfdW5yZWdpc3Rlcl9nc2kgKHUzMiBn
c2kpOw0KPj4NCj4+ICBzdHJ1Y3QgcGNpX2RldjsNCj4+DQo+PiArc3RydWN0IGFjcGlfcHJ0X2Vu
dHJ5ICphY3BpX3BjaV9pcnFfbG9va3VwKHN0cnVjdCBwY2lfZGV2ICpkZXYsIGludCBwaW4pOw0K
Pj4gIGludCBhY3BpX3BjaV9pcnFfZW5hYmxlIChzdHJ1Y3QgcGNpX2RldiAqZGV2KTsNCj4+ICB2
b2lkIGFjcGlfcGVuYWxpemVfaXNhX2lycShpbnQgaXJxLCBpbnQgYWN0aXZlKTsNCj4+ICBib29s
IGFjcGlfaXNhX2lycV9hdmFpbGFibGUoaW50IGlycSk7DQo+PiBkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS94ZW4vYWNwaS5oIGIvaW5jbHVkZS94ZW4vYWNwaS5oDQo+PiBpbmRleCBiMWUxMTg2MzE0NGQu
LmNlN2Y1NTU0Zjg4ZSAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUveGVuL2FjcGkuaA0KPj4gKysr
IGIvaW5jbHVkZS94ZW4vYWNwaS5oDQo+PiBAQCAtNjcsNiArNjcsNyBAQCBzdGF0aWMgaW5saW5l
IHZvaWQgeGVuX2FjcGlfc2xlZXBfcmVnaXN0ZXIodm9pZCkNCj4+ICAgICAgICAgICAgICAgICBh
Y3BpX3N1c3BlbmRfbG93bGV2ZWwgPSB4ZW5fYWNwaV9zdXNwZW5kX2xvd2xldmVsOw0KPj4gICAg
ICAgICB9DQo+PiAgfQ0KPj4gK2ludCB4ZW5fcHZoX3Bhc3N0aHJvdWdoX2dzaShzdHJ1Y3QgcGNp
X2RldiAqZGV2KTsNCj4+ICAjZWxzZQ0KPj4gIHN0YXRpYyBpbmxpbmUgdm9pZCB4ZW5fYWNwaV9z
bGVlcF9yZWdpc3Rlcih2b2lkKQ0KPj4gIHsNCj4+DQo+Pj4NCj4+PiBKYW4NCj4+DQo+PiAtLSAN
Cj4+IEJlc3QgcmVnYXJkcywNCj4+IEppcWlhbiBDaGVuLg0KPj4NCg0KLS0gDQpCZXN0IHJlZ2Fy
ZHMsDQpKaXFpYW4gQ2hlbi4NCg==
