Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E7B17FE97B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 08:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344678AbjK3HDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 02:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344673AbjK3HD3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 02:03:29 -0500
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2071.outbound.protection.outlook.com [40.107.244.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C2FA10D1;
        Wed, 29 Nov 2023 23:03:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JdMu/QxQ+wtXpmOPYrgCL9Gad2GXtVoUiQh7xfm8yViqn6g4woFlh4TWSqCII/1P1SqGmUlyVeEsmFN7Itlu1GP4kAeuUk3TR0PIonDfQKFJOwiUtVb8ACH4GPPpTwfr0KuLcFSLA0jhdl6BYoQew+Jw5/Ggx9fFLisB90jMWTYCZ4RIxNdNEnqN7lKqiSg+SUcZlDe5Jnnvfv3UoYu4VKPY0qvEF6lYzccZfJxykAzIGxlMH5H0cebcePPSHUDH88N5yRYKkw/71ge+7WYshzCIrfcBuJDoaEnOXN92PlfG+8mD9sZko+LyKBQOfHP4Rv06rzZDq1Z7HTVQ0xPOAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=btFGlaLFcCSHxu/Vewv7AMybhRwhB7CQTim3lzsxeG0=;
 b=G5MWRBQFWpEMcDhHoS0NdEWux7aARkQHOc1kUYPbZjUGLRscmo0Tk9vlPaAphZzcVoWS6D3WD8LIDAwNKYwRURdYT81c1y4FBi4VQg8va3Vf7F5v0+ynphb1kaKWaw0qvcDv7wcGFV5BoxrC3iMxpuHRhYNjtOEghQPrkqMgfHulgYTO9RlTfE/eYO28ljaW6zO4Drgm/lO2LccZGpz2Xw6c/Zew/qW3oro7f/PxfLg3hX+EIgflpyrg1OkCmxuhtpIUXJZeUBMdoXqAaQkCLp7sv0rjK/Es7iL7UAyYFabUQJtHcue4tZlkp0EOut6RQvzwT4ulOToNFYDJaJ+abA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=btFGlaLFcCSHxu/Vewv7AMybhRwhB7CQTim3lzsxeG0=;
 b=SykLGCHX+93xzaVT/J+ahq76isg+KoHs9JfUhHLrj0dOpoDZu+tXTq8QjTwTa1v59dTk8b9CLXjIB8yaGzkocdMM4W6RX/N6F3L7ItD9YuAtY+FiVgVt+FL+x4wjb4BJKrkslaKejvcqOU05PNr5Qqw0ze6HmRg53wfC2JIsn4I=
Received: from BL1PR12MB5849.namprd12.prod.outlook.com (2603:10b6:208:384::18)
 by PH7PR12MB8056.namprd12.prod.outlook.com (2603:10b6:510:269::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.24; Thu, 30 Nov
 2023 07:03:30 +0000
Received: from BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1]) by BL1PR12MB5849.namprd12.prod.outlook.com
 ([fe80::969f:11b3:5ec2:3aa1%3]) with mapi id 15.20.7046.024; Thu, 30 Nov 2023
 07:03:29 +0000
From:   "Chen, Jiqian" <Jiqian.Chen@amd.com>
To:     Stefano Stabellini <sstabellini@kernel.org>
CC:     Juergen Gross <jgross@suse.com>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Thomas Gleixner <tglx@linutronix.de>,
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
Thread-Index: AQHaHsGaWb8EJvAynUiF4JhdQXSstLCSQgGAgAC8QwA=
Date:   Thu, 30 Nov 2023 07:03:29 +0000
Message-ID: <BL1PR12MB58490EB260D226500141557EE782A@BL1PR12MB5849.namprd12.prod.outlook.com>
References: <20231124103123.3263471-1-Jiqian.Chen@amd.com>
 <20231124103123.3263471-2-Jiqian.Chen@amd.com>
 <alpine.DEB.2.22.394.2311291943260.3533093@ubuntu-linux-20-04-desktop>
In-Reply-To: <alpine.DEB.2.22.394.2311291943260.3533093@ubuntu-linux-20-04-desktop>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-imapappendstamp: MN0PR12MB6054.namprd12.prod.outlook.com
 (15.20.7068.000)
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL1PR12MB5849:EE_|PH7PR12MB8056:EE_
x-ms-office365-filtering-correlation-id: 6c273887-ff37-45aa-65c7-08dbf17274fc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rg9k9wM3t/20mmvXlBg4b5Qb/9EnHX/s8RHb/FEULme/FFmcC+sLuq7nLaxoOJ97Rp8DqkJNUKxe6jP3onRPEDqQYrublnAzsUzd9+kFErxJsGsKXI/7FsD5pD7dfGvdVt7T7A4n518M7BQ0FlXBrmTdrQB+oyvalOEymggfd7wtfi9dvNPuDe5+vZa6mvFHUK4G/XRvEY4+G4WqDzeHF3emVpjZhQj9H+liw+MnKtbh1XLsaNQO0FTYIY45U2Ln538Df4BNu/lVXXWYRfpKJ3FTZatOlnpZr4VMw5GwGySsZyADdJtvVlTTnR+Q5hSKu+BKvtZgrMUF3J2+1CDT0NyCFTfHuoUMPeGF1WBda/eCdWkEDOEmlyI3qK5+QxfjwB5qyK78ajq8mYld4A3KmqprZ+KU/DFNTZZg2gu6aBPaXCZinXng0TaamXSi68QezrsOKnNOoec+d5y9IBXkkVcx2w6qFbIPh6Wu+PfGmL28E+M0SlM5El0ZZha1kE8EH5QcethSIINM6GPxar1CjaQaMWYdgiN9k+wpshq51mMBwkoBggR1N5vGBzXABWYWS8sopg9jD6iV84tJV2VWZAlPb/zMNXmhpOIbXhsAdiyCTufmEKDXCHRXRnFUTaF7h6ym3F+b0mqrw7tNaTi8/Wk2DUik9QGHFNFtqjuyjrM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(39860400002)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(202311291699003)(55016003)(26005)(122000001)(33656002)(38070700009)(38100700002)(83380400001)(52536014)(7416002)(5660300002)(9686003)(6506007)(53546011)(7696005)(71200400001)(8936002)(4326008)(76116006)(66946007)(66556008)(66476007)(8676002)(66446008)(316002)(54906003)(64756008)(6916009)(41300700001)(2906002)(478600001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WXp6QzBHRTZKN1VwQlNudWd6Y1d5NE5EaFZ2MC9lMlBuTFBLdzRTRy96azBH?=
 =?utf-8?B?RVlxUUY5SFkzYU5aOFR3dDk2UUNNNWpETEdmWGZJdjBtc0paaGpIbHJ2VEFo?=
 =?utf-8?B?SHhjRlFkdnBydnIxeGZKUWNlVFNDK29VUXYzNlh5ZnZ3eFpKVWZsZ0V2cU1k?=
 =?utf-8?B?Q29mWUlXeFA3SWtld0pMbWJGMnhCT3Ewc2RycHNrM3R5SXZLeFoyWmFYbS9a?=
 =?utf-8?B?dGw4Qlc2bW5EVDJuWGlhbk50TFFybW9XSEs5VWY1Z2o2TmlZRHNEdy9SbG1k?=
 =?utf-8?B?STViNUNWTlJXZm9wcmxaYjVDUmNPc1hVZTRaa3NiUzJnelJYMnl0NXhEeWFH?=
 =?utf-8?B?V3FJaHpsMFNkQ01QUVNGRm5FcjdvYTJLTEI0ZVNuRFQ2Vmx3T1dsbDN3NWZS?=
 =?utf-8?B?bHVxTmVFZnQ2VmRLNCthOXNiZXB3UTFUa09MdjI5NEs1RnBUWi9Cb2JXWGp4?=
 =?utf-8?B?NVAwYVZWZXRUK3pHK1Z2M29nU3pIOVF3cGVrN1QzQ3orNVJzdEMzd1dTQVJI?=
 =?utf-8?B?VE5Lc3lzOVlLWGVxcEpxUDhEVi9uZHRxWlIwWnlyMEtiS2YrWGw2RzdNRkQ0?=
 =?utf-8?B?amxzSmFSSlkxdnZtRXgyV3Z0WFZETWNNVEpHd1BQWVRTa0ZtZWFLQ3d3YXlS?=
 =?utf-8?B?NDZ1bXdOeUpmU1FaUG9HZVpxRmp4M0Q1Ris0blVuNlBtaVMwSXhsclNSdnhH?=
 =?utf-8?B?UkYrdCt3elQ2Wm95Wmp1OHpCbVpMYitkUUhrNEI0Zno4WkFkNHBqMlVSSkto?=
 =?utf-8?B?OW9GZlNoOUdYNlFGREFpQktPVk1rMERHVFFQN1RVekhPZXRvb1d2MmZmalE5?=
 =?utf-8?B?VjNPNVJHSjM4OWhUdlVGT3MvVkVTNXJpL1pEUkJoVlVwMXZRelZiaEhGemcr?=
 =?utf-8?B?c25JcFg3ODBhMUhXUzN1NWpwcEROYkhkd1QyZDFYY3RHUDRoaFRFdkZXRlcx?=
 =?utf-8?B?bFZrNFV2RlZCMUFGa2x2Uk9HUFFwVDJJMVc3bnZFUFk4MmtxY3dmMnM5YTZs?=
 =?utf-8?B?UjBsMVhMQU5BbXBaK3dtc2lmZFFPVW9pVVZ4dUtxNkNTS2RVbFVmM3ZPMmpo?=
 =?utf-8?B?cGFhYVNpZG85MTJJNTE2QlF5em5EZ3B1ZW9CdXRXZ1U4UXc3RnJnMGlRMlZQ?=
 =?utf-8?B?RUtYSEZTUmd6aEs4ZGhhVld0bVRUdnR3N2d6LzNkbWpFOUdQZS9iOGlOMTh0?=
 =?utf-8?B?cUJlY0l2cVNLdlo2MEcrSGxOeHdMVHExUDB1VlNxUGJCUEQvRjk5alJjUzh2?=
 =?utf-8?B?bGRsNFBPUXZMTVFNS1RVWHF1Zk0yd0FMUk5NZ3RhS2xDTnRGSlE4bHVzdVlt?=
 =?utf-8?B?ZU40MGpZMEhRaENlbEF6WGpCdzcyLzkxVG1NeHJZSW5nczZvcnlYSW5xQUlx?=
 =?utf-8?B?UmcvL0E4OGdtcDlmZHhsTSsxQ0JGaGdjV1EzeEJxYkJIQkxUV3hlTVllak91?=
 =?utf-8?B?Q1dBWTQ4UjBrbXZzNWRIUzJQeVhRUDQ2ZTJJU2pWYWZPcC9Sb05DY1FUU0cr?=
 =?utf-8?B?aU1mRzFJZDAxTStLRzRWMmFxT1VFNmx0aVhxNU4wMjRuS0NtY3FkdFdLUHpr?=
 =?utf-8?B?Q0lXWHFOSkE1RWY3UTJPMjRvbFpKZmlPT3lTUlJsSzVpZzBGMytFbnpkaGVr?=
 =?utf-8?B?b2J1Q3JjeHlEZ3k4ZldFY21IT1hlZEF5czduZWVUVHNEL05MVW1qSHRNQTVL?=
 =?utf-8?B?dWRlNDE3SmNwVnhEZ3JoY3pUQTQ2SVhJWktsVjN5cFp0TUxOY2NWQ0t4VDBD?=
 =?utf-8?B?MXlZZlNFUzRTK0d0UitrUFAzZEtvOHNjU3ZCamVRRkJHUHl5UU5sSmQ5Sm5m?=
 =?utf-8?B?bnZoR1RrNC8zdDE0Rk1nelhmdGV1bjhKWGhaSzY4TTB1RUE4SWJrc0FxRkFN?=
 =?utf-8?B?N0tQQWM4Sm55Y1RCNmxMcUJHVWcyVzRmWklhczlFVVBsTlhDVm1XSzVmYTVB?=
 =?utf-8?B?US9uc255Mm5iL1R5Ky9LamVXNks2UTNBU1JSUS9laDJzcHB5U2diTCtaQ1FG?=
 =?utf-8?B?L1o0TnFmNXVxU3lwK2lzS3lCVkRFeDRURGFBY0V4Vk5UdWxjeXJjTGpVWUg0?=
 =?utf-8?B?OEZtSkl5Ly9XZHhVTEhmWmlZYXRwcWZ4d1FGbHZnY0RKaGRCME9VTC8weVI0?=
 =?utf-8?Q?P7Wo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F144D27B800B574295802F12BD199560@amdcloud.onmicrosoft.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c273887-ff37-45aa-65c7-08dbf17274fc
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Nov 2023 07:03:29.4135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PW+5Wsp/0WSInSV589OiCcT41gOT/zsYa3RjH/WecdZ/sXpSjqvBsEyZ7rGq8lKnRHJ8QTRI/Wz+SIE6lqtg9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8056
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiAyMDIzLzExLzMwIDExOjQ2LCBTdGVmYW5vIFN0YWJlbGxpbmkgd3JvdGU6DQo+IE9uIEZy
aSwgMjQgTm92IDIwMjMsIEppcWlhbiBDaGVuIHdyb3RlOg0KPj4gV2hlbiBkZXZpY2Ugb24gZG9t
MCBzaWRlIGhhcyBiZWVuIHJlc2V0LCB0aGUgdnBjaSBvbiBYZW4gc2lkZQ0KPj4gd29uJ3QgZ2V0
IG5vdGlmaWNhdGlvbiwgc28gdGhhdCB0aGUgY2FjaGVkIHN0YXRlIGluIHZwY2kgaXMNCj4+IGFs
bCBvdXQgb2YgZGF0ZSB3aXRoIHRoZSByZWFsIGRldmljZSBzdGF0ZS4NCj4+IFRvIHNvbHZlIHRo
YXQgcHJvYmxlbSwgdGhpcyBwYXRjaCBhZGQgYSBmdW5jdGlvbiB0byBjbGVhciBhbGwNCj4+IHZw
Y2kgZGV2aWNlIHN0YXRlIHdoZW4gZGV2aWNlIGlzIHJlc2V0IG9uIGRvbTAgc2lkZS4NCj4+DQo+
PiBBbmQgY2FsbCB0aGF0IGZ1bmN0aW9uIGluIHBjaXN0dWJfaW5pdF9kZXZpY2UuIEJlY2F1c2Ug
d2hlbg0KPj4gd2UgdXNlICJwY2ktYXNzaWduYWJsZS1hZGQiIHRvIGFzc2lnbiBhIHBhc3N0aHJv
dWdoIGRldmljZSBpbg0KPj4gWGVuLCBpdCB3aWxsIHJlc2V0IHBhc3N0aHJvdWdoIGRldmljZSBh
bmQgdGhlIHZwY2kgc3RhdGUgd2lsbA0KPj4gb3V0IG9mIGRhdGUsIGFuZCB0aGVuIGRldmljZSB3
aWxsIGZhaWwgdG8gcmVzdG9yZSBiYXIgc3RhdGUuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmlx
aWFuIENoZW4gPEppcWlhbi5DaGVuQGFtZC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBIdWFuZyBS
dWkgPHJheS5odWFuZ0BhbWQuY29tPg0KPj4gLS0tDQo+PiAgZHJpdmVycy94ZW4vcGNpLmMgICAg
ICAgICAgICAgICAgICB8IDEyICsrKysrKysrKysrKw0KPj4gIGRyaXZlcnMveGVuL3hlbi1wY2li
YWNrL3BjaV9zdHViLmMgfCAgMyArKysNCj4+ICBpbmNsdWRlL3hlbi9pbnRlcmZhY2UvcGh5c2Rl
di5oICAgIHwgIDIgKysNCj4+ICBpbmNsdWRlL3hlbi9wY2kuaCAgICAgICAgICAgICAgICAgIHwg
IDYgKysrKysrDQo+PiAgNCBmaWxlcyBjaGFuZ2VkLCAyMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMveGVuL3BjaS5jIGIvZHJpdmVycy94ZW4vcGNpLmMNCj4+IGlu
ZGV4IDcyZDRlM2YxOTNhZi4uZTliMzBiYzA5MTM5IDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVycy94
ZW4vcGNpLmMNCj4+ICsrKyBiL2RyaXZlcnMveGVuL3BjaS5jDQo+PiBAQCAtMTc3LDYgKzE3Nywx
OCBAQCBzdGF0aWMgaW50IHhlbl9yZW1vdmVfZGV2aWNlKHN0cnVjdCBkZXZpY2UgKmRldikNCj4+
ICAJcmV0dXJuIHI7DQo+PiAgfQ0KPj4gIA0KPj4gK2ludCB4ZW5fcmVzZXRfZGV2aWNlX3N0YXRl
KGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+PiArew0KPj4gKwlzdHJ1Y3QgcGh5c2Rldl9w
Y2lfZGV2aWNlIGRldmljZSA9IHsNCj4+ICsJCS5zZWcgPSBwY2lfZG9tYWluX25yKGRldi0+YnVz
KSwNCj4+ICsJCS5idXMgPSBkZXYtPmJ1cy0+bnVtYmVyLA0KPj4gKwkJLmRldmZuID0gZGV2LT5k
ZXZmbg0KPj4gKwl9Ow0KPj4gKw0KPj4gKwlyZXR1cm4gSFlQRVJWSVNPUl9waHlzZGV2X29wKFBI
WVNERVZPUF9wY2lfZGV2aWNlX3N0YXRlX3Jlc2V0LCAmZGV2aWNlKTsNCj4+ICt9DQo+PiArRVhQ
T1JUX1NZTUJPTF9HUEwoeGVuX3Jlc2V0X2RldmljZV9zdGF0ZSk7DQo+PiArDQo+PiAgc3RhdGlj
IGludCB4ZW5fcGNpX25vdGlmaWVyKHN0cnVjdCBub3RpZmllcl9ibG9jayAqbmIsDQo+PiAgCQkJ
ICAgIHVuc2lnbmVkIGxvbmcgYWN0aW9uLCB2b2lkICpkYXRhKQ0KPj4gIHsNCj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jIGIvZHJpdmVycy94ZW4veGVu
LXBjaWJhY2svcGNpX3N0dWIuYw0KPj4gaW5kZXggZTM0YjYyM2U0YjQxLi41YTk2YjZjNjZjMDcg
MTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+PiAr
KysgYi9kcml2ZXJzL3hlbi94ZW4tcGNpYmFjay9wY2lfc3R1Yi5jDQo+PiBAQCAtNDIxLDYgKzQy
MSw5IEBAIHN0YXRpYyBpbnQgcGNpc3R1Yl9pbml0X2RldmljZShzdHJ1Y3QgcGNpX2RldiAqZGV2
KQ0KPj4gIAllbHNlIHsNCj4+ICAJCWRldl9kYmcoJmRldi0+ZGV2LCAicmVzZXR0aW5nIChGTFIs
IEQzLCBldGMpIHRoZSBkZXZpY2VcbiIpOw0KPj4gIAkJX19wY2lfcmVzZXRfZnVuY3Rpb25fbG9j
a2VkKGRldik7DQo+PiArCQllcnIgPSB4ZW5fcmVzZXRfZGV2aWNlX3N0YXRlKGRldik7DQo+PiAr
CQlpZiAoZXJyKQ0KPj4gKwkJCWdvdG8gY29uZmlnX3JlbGVhc2U7DQo+IA0KPiBPbGRlciB2ZXJz
aW9ucyBvZiBYZW4gd29uJ3QgaGF2ZSB0aGUgaHlwZXJjYWxsDQo+IFBIWVNERVZPUF9wY2lfZGV2
aWNlX3N0YXRlX3Jlc2V0IGltcGxlbWVudGVkLiBJIHRoaW5rIHdlIHNob3VsZCBkbw0KPiBzb21l
dGhpbmcgbGlrZToNCj4gDQo+IGlmIChlcnIgJiYgeGVuX3B2aF9kb21haW4oKSkNCj4gICAgIGdv
dG8gY29uZmlnX3JlbGVhc2U7DQo+IA0KPiANCj4gT3IgZXZlbjoNCj4gDQo+IGlmICh4ZW5fcHZo
X2RvbWFpbigpKSB7DQo+ICAgICBlcnIgPSB4ZW5fcmVzZXRfZGV2aWNlX3N0YXRlKGRldik7DQo+
ICAgICBpZiAoZXJyKQ0KPiAgICAgICAgIGdvdG8gY29uZmlnX3JlbGVhc2U7DQo+IH0NCj4gDQo+
IGRlcGVuZGluZyBvbiB3aGV0aGVyIHdlIHdhbnQgdG8gY2FsbCB4ZW5fcmVzZXRfZGV2aWNlX3N0
YXRlIGFsc28gZm9yIFBWDQo+IGd1ZXN0cyBvciBub3QuIEkgYW0gYXNzdW1pbmcgd2UgZG9uJ3Qg
d2FudCB0byBlcnJvciBvdXQgb24gZmFpbHVyZSBzdWNoDQo+IGFzIC1FTk9FTlQgZm9yIFBWIGd1
ZXN0cy4NClllcywgb25seSBmb3IgUFZIIGRvbTAsIEkgd2lsbCBhZGQgdGhlIGNvbmRpdGlvbiBp
biBuZXh0IHZlcnNpb24uIFRoYW5rIHlvdSENCg0KPiANCj4gDQo+PiAgCQlwY2lfcmVzdG9yZV9z
dGF0ZShkZXYpOw0KPj4gIAl9DQo+PiAgCS8qIE5vdyBkaXNhYmxlIHRoZSBkZXZpY2UgKHRoaXMg
YWxzbyBlbnN1cmVzIHNvbWUgcHJpdmF0ZSBkZXZpY2UNCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRl
L3hlbi9pbnRlcmZhY2UvcGh5c2Rldi5oIGIvaW5jbHVkZS94ZW4vaW50ZXJmYWNlL3BoeXNkZXYu
aA0KPj4gaW5kZXggYTIzN2FmODY3ODczLi4yMzE1MjZmODBmNmMgMTAwNjQ0DQo+PiAtLS0gYS9p
bmNsdWRlL3hlbi9pbnRlcmZhY2UvcGh5c2Rldi5oDQo+PiArKysgYi9pbmNsdWRlL3hlbi9pbnRl
cmZhY2UvcGh5c2Rldi5oDQo+PiBAQCAtMjYzLDYgKzI2Myw4IEBAIHN0cnVjdCBwaHlzZGV2X3Bj
aV9kZXZpY2Ugew0KPj4gICAgICB1aW50OF90IGRldmZuOw0KPj4gIH07DQo+PiAgDQo+PiArI2Rl
ZmluZSBQSFlTREVWT1BfcGNpX2RldmljZV9zdGF0ZV9yZXNldCAgICAgMzINCj4+ICsNCj4+ICAj
ZGVmaW5lIFBIWVNERVZPUF9EQkdQX1JFU0VUX1BSRVBBUkUgICAgMQ0KPj4gICNkZWZpbmUgUEhZ
U0RFVk9QX0RCR1BfUkVTRVRfRE9ORSAgICAgICAyDQo+PiAgDQo+PiBkaWZmIC0tZ2l0IGEvaW5j
bHVkZS94ZW4vcGNpLmggYi9pbmNsdWRlL3hlbi9wY2kuaA0KPj4gaW5kZXggYjgzMzdjZjg1ZmQx
Li5iMmUyZTg1NmVmZDYgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL3hlbi9wY2kuaA0KPj4gKysr
IGIvaW5jbHVkZS94ZW4vcGNpLmgNCj4+IEBAIC00LDEwICs0LDE2IEBADQo+PiAgI2RlZmluZSBf
X1hFTl9QQ0lfSF9fDQo+PiAgDQo+PiAgI2lmIGRlZmluZWQoQ09ORklHX1hFTl9ET00wKQ0KPj4g
K2ludCB4ZW5fcmVzZXRfZGV2aWNlX3N0YXRlKGNvbnN0IHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0K
Pj4gIGludCB4ZW5fZmluZF9kZXZpY2VfZG9tYWluX293bmVyKHN0cnVjdCBwY2lfZGV2ICpkZXYp
Ow0KPj4gIGludCB4ZW5fcmVnaXN0ZXJfZGV2aWNlX2RvbWFpbl9vd25lcihzdHJ1Y3QgcGNpX2Rl
diAqZGV2LCB1aW50MTZfdCBkb21haW4pOw0KPj4gIGludCB4ZW5fdW5yZWdpc3Rlcl9kZXZpY2Vf
ZG9tYWluX293bmVyKHN0cnVjdCBwY2lfZGV2ICpkZXYpOw0KPj4gICNlbHNlDQo+PiArc3RhdGlj
IGlubGluZSBpbnQgeGVuX3Jlc2V0X2RldmljZV9zdGF0ZShjb25zdCBzdHJ1Y3QgcGNpX2RldiAq
ZGV2KQ0KPj4gK3sNCj4+ICsJcmV0dXJuIC0xOw0KPj4gK30NCj4+ICsNCj4+ICBzdGF0aWMgaW5s
aW5lIGludCB4ZW5fZmluZF9kZXZpY2VfZG9tYWluX293bmVyKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+PiAgew0KPj4gIAlyZXR1cm4gLTE7DQo+PiAtLSANCj4+IDIuMzQuMQ0KPj4NCg0KLS0gDQpC
ZXN0IHJlZ2FyZHMsDQpKaXFpYW4gQ2hlbi4NCg==
