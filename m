Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD71A802DFD
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 10:12:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343617AbjLDIt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 03:49:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234870AbjLDIt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 03:49:57 -0500
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB88CA4;
        Mon,  4 Dec 2023 00:50:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDP22pmEpabUF8CYEnobLuE0MYpSO5ah4nUTUh2asQCdE8+xZYzsMAehDYnKqEMzmH+Q/FFoudbDmZXZz9chyqyAMdsZOXGcmtpxquA1xoxTYFGAvIBHxv8/+lWsUuls7gqYVy4in4DzZDaM3pTy9ePOWDQZ4TOG0tawzsWgnnCXcXEEUgnkE91KKgW7Nd//PSEssUuVUc9BelChjqxW7IKxbAjhoeFOf+/nWeGq6l0hSb/kP9wHXInFyKMz0QTBLP+Kus3V0d386cd73Du4inv3RLBfi0WxsMLshYUrKZ+x7QPufYHfsPCYptT6xk1nht+tCL5YE3W9Dp5KoID+Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lSYNP17FW+d29WFtlOlSR8mnGPm95Lfk7PNHYinfE+U=;
 b=bYf5rMJBYGX57+w1W0KAApgKUz7grYtxoThRtPVLwX1MJvX9stN72RVrf8EQ0atGwuNtwkQoCJt0Iipv6Wi+nUQMQW1Y9GJwfZplpVGmn1INQ6wWrzxicOKgY7KAFkBa81gp16Z8LVmCiGUyr2Jp+tFQJOQm8GqTb3Z+prkE4PO2ZMze32UCWfJcxrDppsZzpT6+pbnvVNOJ9o7SnLvCnHSMaEKgNf8ispYCovPF54niTk0XYBxcEG3/t0rga96aRpCzcPsKrtWOlaWKfdHMXFU2WJmsIQ+WnsZPHfNqcfukRC1uUAPf+fbUZizbZM54tmG9kgPe9lTk1vKzNEed/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lSYNP17FW+d29WFtlOlSR8mnGPm95Lfk7PNHYinfE+U=;
 b=wTaXaZ1oPbgVGX018M/iQR6rHIg5UoRlJ7pV1+2K2tKRJbNkifwk4OtKmqTZPtQees20mISpLM9BNR6Qfr8wwscRFbP2wi30WT+JM5g5fConuKHozRM9Qa+JU/bLcu7a2Z3nGAhVaryE1UieuHtcg+8ib3FzS8YTtXJu7qp6jFw=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by CH3PR12MB9429.namprd12.prod.outlook.com (2603:10b6:610:1c9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 08:49:57 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 08:49:57 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
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
Thread-Index: AQHaHsGaWb8EJvAynUiF4JhdQXSstLCY0coAgACRkoA=
Date:   Mon, 4 Dec 2023 08:49:56 +0000
Message-ID: <BL1PR12MB5849F2E24E00BF7B20A0B4A6E786A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com> <87edg2xuu9.ffs@tglx>
In-Reply-To: <87edg2xuu9.ffs@tglx>
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
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|CH3PR12MB9429:EE_
x-ms-office365-filtering-correlation-id: 9755d61f-0040-489a-fe82-08dbf4a5fd95
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UL0U0Hvlt9S9cEWSX3CCh0/9AoeNieO33fWr4UKd1P7+0/8ooWplW5ywV/A5iwzde9Z3pT2kwkoIZspKIdxLLwXW00qcdFv3us+ReF/Dgssc+h7H8UMIXmdU/ph+sEU/Yvi5emYfJ2Gc3dF83e135NEsqQ3h+31vj9MRSbT/ZfvUoiGvKeeErAld1yiSweIYdUhkQkUEjL+ArXVq2c1ywoWAHSyFnMyg7i/GODxhv8HsDdY/Mdu/BV/wF2h9/YdFJ9FOnxQgeBuvGQRl66HPUTd32g4T69n9hfLczvOwrxlUm2zX52vp3u/BXPbN3ywRLWjZQSX2ZvWAopjCpqLSsJ/JHzWY4JPbcXXPZ6z7Ltq/1jQhOnIGdO78w1tWP8hH7okD/zmT9HHSxvIj4/G5GZtmF+yjven9U7UGMsgftfevuDZh4q6YTai/jAzxLn58qaEeZA/7GnZ/9W5B1RgS+ndOIGC0gi93XUi39hwK8ZO5jYiTrlzmQ8HvxQ6VFMB3ncdz6nCR+A9RXVlKVb7bK1M4VuwtoBV4ZJCvOguKKOk3JKlc09d+GbHydEVe6ljBmIv4aVvip7B0h6SEdDtiUJ24ge4lYH48HCziZqunnvdM4IGvltb97uL+K9w0Pz9e
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(478600001)(26005)(83380400001)(7696005)(71200400001)(6506007)(9686003)(53546011)(316002)(6916009)(66476007)(66446008)(64756008)(54906003)(76116006)(66946007)(66556008)(122000001)(38100700002)(55016003)(5660300002)(52536014)(4326008)(2906002)(8936002)(8676002)(7416002)(41300700001)(33656002)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djNmMmFMWGlReEh4d2hneDhsRWlWNytxNHR4VCsyR3MvdGEycWhaVy93QnZu?=
 =?utf-8?B?NTNrMHJzSFNXa0oxUy9xZGtMYzdZQ2ZIcGdRZFloTUcxYi9mbHE2dkNnWEN3?=
 =?utf-8?B?alEraExhMFBJVXZiYzNmNi9yUlNrVktlNVVtQWZhb0w4WHRPQ09DNzcxM1RD?=
 =?utf-8?B?ZWpkdnZ0RUZCbHpqOW9DMlVCSGFGZ20rVlg1dk82STlZY3hCU1l5RjRNY1hu?=
 =?utf-8?B?TzFnWlJoeURwc3lDekVvTk1XVk5mbHNwZTdoSzVTNUJTaUM2RlpxY0psa1Nz?=
 =?utf-8?B?dXRUZ2pWcm40dW05MUU2NXQ2cllQWDdBNHdoT1dYWnBDaXR2WWZPUHI5blRD?=
 =?utf-8?B?c2l4NW1zbGE4a1d6Ry9idW5MWE1NYTI1bWRsU0l6aTdLT0NjQzF4dllwU2to?=
 =?utf-8?B?VXpLSnpKVHY1Tk1BTTFHbGF6eW1IOVVsRkY3eUQvVEVkRTduQ1BFL01rNWp4?=
 =?utf-8?B?aDFvaXpsaXNlNWRNcERuS2NUZ2RLVnNpQnBTc0JueVJmMEJad09OTSs3dk5H?=
 =?utf-8?B?d2pPTE5kRUl0ZWt6WUZVV3BpRWF4aTFKRmhqTkdDUXFnZUNvKzExU09wdVVJ?=
 =?utf-8?B?ZXMzVi9hVjQwWGMzRDFYa0ZGTjhSdHRiMDRHZUdBWXBJUEpFTGg3UThoOURV?=
 =?utf-8?B?YTB5SEtoL0RIVmk5Z1FyYlFrUmVsWkFPV2Mxd0s3am5XMDE3SldzNDhTdjF2?=
 =?utf-8?B?UGlGUWdyZGphZ3M2K3MrVFpnNDlLTnFVQ2VKRzZJajdJQXB0UUFuMTJRK1Fv?=
 =?utf-8?B?di8rWTB3cStrdVZQT2R1eElCR2Y3RHZJb1IvVlRqWHIvQ25vOUI3SmxPWHFJ?=
 =?utf-8?B?TTFhMTZaMzA2MGhvWUlWaHhsOHNCby9ZMk5pb1hyQVI3T1YyT2Q0Y21PNURY?=
 =?utf-8?B?R3NhRXZUMnRubjJSN2tqSnU3MUo3YlhNRU51ek9pc0UrZERIaEdKSjVXUzRk?=
 =?utf-8?B?MDhLQ1NxM2ZDZzEvN0NhSXVybFBpYVkwTXl6R1JjZUtWOXdOZmFoTXNkMDFP?=
 =?utf-8?B?azQ3TnRyRGYxS216VWdZbS9jZkhpb0gzMnFBK0poWVVWRnVtVllIR3NHZUh4?=
 =?utf-8?B?dXIwUVpJdEVSRnV2UzZqVG5Mc21BQzNpNUVCaVFlQVF0bjBnaEFZMm4zZXM1?=
 =?utf-8?B?REZYMDJwRDdoYXpCL1I0aGpCQVFjY1UrNElUWmVxYlZzVHJ6ZE1ObXd0S0dw?=
 =?utf-8?B?UVliTzlOUXlXS2k5QWxZZjdNRnZuL3FaekdndG91MkpnVEZ5cHVVaDlSVndU?=
 =?utf-8?B?eUlsTVNJQkFZV25XWU1UWmxnUlQvSmkyK0lKcWFsVXQ3d1dQcWVHODRhM1B6?=
 =?utf-8?B?K1loZ0Y1VEFKWVBrVGtTQkx2dkpERmVSREpCbHpoTUM4QnhBNEhidi9OaW5U?=
 =?utf-8?B?NmdCc001dHFEdElkb3k0WmpyTnI2NTl0cXhVMENUNnRCKzVmVnJNbm5IY3lH?=
 =?utf-8?B?WDZGMTl4S3FMZW1OQ3ErbWtOZDllNmFXTi9iMS8yWGYwaU1BdzY2cit6bVhp?=
 =?utf-8?B?SW9kL2hud1V1eXlhcHNYSFp5c1p4WERvZ3IzRXNBbzNXZUtYRUVscnlObDVX?=
 =?utf-8?B?RnpCWXZCZHRrcFZZeCtkMGRsK1lWNFozeGs2QllxQ0VzZFRteVV4OU04Qnh2?=
 =?utf-8?B?RnZ3NkJ0NW9HbVh6MjJJY3ovYkdKd1RrM1ZKQmhlRWphQTk1bFpMaEdweFNH?=
 =?utf-8?B?dzhNUWM1aElVcmo0QXU4OFRUN0s1YzBBR3JwYnNWY0ZjeUZNVU1YY3M4cDh5?=
 =?utf-8?B?VlZlcHhJQlV5ekNVdTBpdysvL3pIZlp1UzBKUGhucHNSV3V2Z1ZJZ1VmT2Ft?=
 =?utf-8?B?d0xLc2RteXZKSWNnVmRpT1lhMXR5U1JSRUl5cVZDV1hwZXZvd25lNFkzOWVU?=
 =?utf-8?B?YjZNanpzQjdNWVo1SW5QU2ZnYk9QUU5qL1pDeEdJZjhrdGtWR1lQMDd3YkF2?=
 =?utf-8?B?Y1d0TUVldmRhM1hITEdpWGRiRjZQVVU0Ry9XRWJhTHhDUDBESTJWYVc4eWZs?=
 =?utf-8?B?WllQUVl1NHVqMTRRYmZZdFF1WUt4QWNDdWJUV24wMjAvcFRYUUw2T1FnZDJV?=
 =?utf-8?B?aWo1T2d0VFdkRkw0YkVDcjYyODRFUmJ2YkRiRnpMc1JoeU1jUzZGOStGeVFL?=
 =?utf-8?Q?Awrw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C984281BFD69B42B458B06706B2D46A@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9755d61f-0040-489a-fe82-08dbf4a5fd95
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2023 08:49:56.4083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NPw7JkePKsKGEMyHNv98rBmutYbSmuT4k6b4A3mxVYKuzdXGwLGKFKsiVFux/tGP1ghlqA58Vyp4eHF74m2S7A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9429
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIzLzEyLzQgMTU6NTgsIFRob21hcyBHbGVpeG5lciB3cm90ZToNCj4gT24gRnJpLCBO
b3YgMjQgMjAyMyBhdCAxODozMSwgSmlxaWFuIENoZW4gd3JvdGU6DQo+PiBXaGVuIGRldmljZSBv
biBkb20wIHNpZGUgaGFzIGJlZW4gcmVzZXQsIHRoZSB2cGNpIG9uIFhlbiBzaWRlDQo+PiB3b24n
dCBnZXQgbm90aWZpY2F0aW9uLCBzbyB0aGF0IHRoZSBjYWNoZWQgc3RhdGUgaW4gdnBjaSBpcw0K
Pj4gYWxsIG91dCBvZiBkYXRlIHdpdGggdGhlIHJlYWwgZGV2aWNlIHN0YXRlLg0KPj4gVG8gc29s
dmUgdGhhdCBwcm9ibGVtLCB0aGlzIHBhdGNoIGFkZCBhIGZ1bmN0aW9uIHRvIGNsZWFyIGFsbA0K
PiANCj4gUGxlYXNlIGdldCByaWQgb2YgJ3RoaXMgcGF0Y2gnIGFsbCBvdmVyIHRoZSBzZXJpZXMu
DQo+IA0KPiAjIGdyZXAgLXIgJ1RoaXMgcGF0Y2gnIERvY3VtZW50YXRpb24vcHJvY2Vzcy8NClRo
YW5rcy4gSSB3aWxsIHJlbW92ZSAidGhpcyBwYXRjaCIgb3IgIkkvd2UiIGluIG5leHQgdmVyc2lv
bi4NCg0KPiANCj4+IHZwY2kgZGV2aWNlIHN0YXRlIHdoZW4gZGV2aWNlIGlzIHJlc2V0IG9uIGRv
bTAgc2lkZS4NCj4+DQo+PiBBbmQgY2FsbCB0aGF0IGZ1bmN0aW9uIGluIHBjaXN0dWJfaW5pdF9k
ZXZpY2UuIEJlY2F1c2Ugd2hlbg0KPj4gd2UgdXNlICJwY2ktYXNzaWduYWJsZS1hZGQiIHRvIGFz
c2lnbiBhIHBhc3N0aHJvdWdoIGRldmljZSBpbg0KPj4gWGVuLCBpdCB3aWxsIHJlc2V0IHBhc3N0
aHJvdWdoIGRldmljZSBhbmQgdGhlIHZwY2kgc3RhdGUgd2lsbA0KPj4gb3V0IG9mIGRhdGUsIGFu
ZCB0aGVuIGRldmljZSB3aWxsIGZhaWwgdG8gcmVzdG9yZSBiYXIgc3RhdGUuDQo+Pg0KPj4gU2ln
bmVkLW9mZi1ieTogSmlxaWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiBTaWduZWQt
b2ZmLWJ5OiBIdWFuZyBSdWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPiANCj4gVGhpcyBTaWduZWQt
b2ZmLWJ5IGNoYWluIGlzIGluY29ycmVjdC4NCj4gDQo+IERvY3VtZW50YXRpb24vcHJvY2Vzcy9z
dWJtaXR0aW5nLXBhdGNoZXMucnN0IGhhcyBhIGZ1bGwgY2hhcHRlciBhYm91dA0KPiBTLU8tQiBh
bmQgdGhlIGNvcnJlY3QgdXNhZ2UuDQpJIGFtIHRoZSBhdXRob3Igb2YgdGhpcyBzZXJpZXMgb2Yg
cGF0Y2hlcywgYW5kIEh1YW5nIFJ1aSB0cmFuc3BvcnRlZCB0aGUgdjEgdG8gdXBzdHJlYW0uIEFu
ZCBub3cgSSB0cmFuc3BvcnQgdjIuIEkgYW0gbm90IGF3YXJlIHRoYXQgdGhlIFNPQiBjaGFpbiBp
cyBpbmNvcnJlY3QuDQpEbyB5b3UgaGF2ZSBhbnkgc3VnZ2VzdGlvbnM/DQoNCj4gDQo+IFRoYW5r
cywNCj4gDQo+ICAgICAgICAgdGdseA0KDQotLSANCkJlc3QgcmVnYXJkcywNCkppcWlhbiBDaGVu
Lg0K
