Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C07937769B4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjHIUSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbjHIUSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:18:00 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060c.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe59::60c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643DD10D8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 13:18:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiQmaBfZIkAsbapbMFCEtxirG6bkMdnooDjdZzPaN6WWkc/WwB8HaYM9qnyaRWeqCsX5Mv35JhwuqHuPzZY5Rf0x4kzs84PB+chy5siltl+lVtMpPY3bf8ar/gzTvKzUuy2dHMdal2x0YCP/vNJSVKSdqmoeORO8kkDv4lxWSKaMC+xf2G7KQpMRdBqdK2ccoc/cHTatahrVht85dggm9ltaM2iBj8fRr5nKwYru+qCR1XUt3mUNDqaciCu5HuwhjAKlPTkASY3X5iBRmAVksoZxFk4Jp/y8wT9R9UHuRZVNqkHfUA+VassI6PsJDU48Y09LqLPE9revUsQykWw+/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LYsX+3/AH4b2fwJZ3KFsjX6hl0vgHGMYV0dq8xixnXM=;
 b=DsHx7mXc1AdtTAMmYdVuEB0QlR9rK53SjILrpQU6I+7vqpXnhkz4Uv5OShmqiQyFJDN3qSSjXyuAXCJJDS5xVPvQIXAK776FS2hUOP9feS7jWyLh66gqZjY64G6EXHdJMEzKUzP2t4cYkOobFK0jVriN4y+9BpthqVwfCMw+ODjQ+6a4al3VA2rLM3TnLMQVyeXQpDkyGF3VQLGaDdJ+chi5o/VZQOKgFV9Uf1pPQY6CXm/5HaCc4pWEHXojCPWr3uAtSDkiyofxiEGgb6+3f3FB2zBGpEW9yrPEqHUd3dZyY7yHI5H4mKZa/I6MfQH5qEIi88/RqtYiTem6iZwbIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LYsX+3/AH4b2fwJZ3KFsjX6hl0vgHGMYV0dq8xixnXM=;
 b=olFgey8pqKyM2XEU1VTegwh6mAH0bNzANMywqYpKFxqm6eJhiKU/tb9wrBGSfE1Fj3hy1ow3ujpr1oFfyEL57+pwS50j6YZx/5UYhNDL2pDzAuIZx4RLVbmj5S5UEKmVVosHMiBpAvYyr6zlnk9x0Yxso6FBbF/iKlSFyG1vxqGQWoj5EM8XKV1EG4H/wW7nyM1MafAaL3q5hfyGSHI5pBMENpGAqvBrwCJmpt5JmuXHTVFkOYyqLB3faxCMMMxi4ATe2ZvOODlu5MzKLssm6PDbQ+HYIjHdrudiBVo8fXGfAli7w0J4iewCSNEIOciVbO4pF5J8FeWfsOkSItu/iQ==
Received: from MN2PR12MB3902.namprd12.prod.outlook.com (2603:10b6:208:169::23)
 by DM4PR12MB5937.namprd12.prod.outlook.com (2603:10b6:8:68::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.28; Wed, 9 Aug
 2023 20:17:57 +0000
Received: from MN2PR12MB3902.namprd12.prod.outlook.com
 ([fe80::149d:ff18:9f37:af72]) by MN2PR12MB3902.namprd12.prod.outlook.com
 ([fe80::149d:ff18:9f37:af72%7]) with mapi id 15.20.6652.028; Wed, 9 Aug 2023
 20:17:57 +0000
From:   Asmaa Mnebhi <asmaa@nvidia.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        "markgross@kernel.org" <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 0/2] mlxbf-bootctl: Support access to the large icm
 size and setting the BlueField boot state.
Thread-Topic: [PATCH v2 0/2] mlxbf-bootctl: Support access to the large icm
 size and setting the BlueField boot state.
Thread-Index: AQHZyt6j/vodt9ALAUWzX7KlErsUQ6/iZw+AgAAAR5A=
Date:   Wed, 9 Aug 2023 20:17:57 +0000
Message-ID: <MN2PR12MB3902DBB1C064D4D7E91A534FD712A@MN2PR12MB3902.namprd12.prod.outlook.com>
References: <20230809162857.21243-1-asmaa@nvidia.com>
 <5f9b3dcf-4551-c959-4cd2-990923c76bcc@redhat.com>
In-Reply-To: <5f9b3dcf-4551-c959-4cd2-990923c76bcc@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR12MB3902:EE_|DM4PR12MB5937:EE_
x-ms-office365-filtering-correlation-id: 7b83f231-9f37-4bc5-fe76-08db9915b8b2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g0wKzIUhvbdciFysGqjSxMJ4iBxf8wNmnfZXzCGcLPH8AbKsJ5zKabc6EQWVq/Dk/Or/eHXkQs/BWieJtIf9BjZzgnqq0VXiIm9KOn5e6sI7FVBae+Gm6PlFEQ/8ah9lRxMSQCyKpZiOLWClPfCnDLktZu9Rp95wAu7laCQr+Wg6bpc2Lv5bhiWaNpqn6IPKhaiJmJsPN7W/cja7o1V4hgmpopEH5eFM+ffxQEzGLlzwa3Mp1d+MXbAXOV4Lo8RnzwanJOoLx/z3gnZ6JHV2PUDqo2nxkr+KKY602K6yRV4XNHt5zePVizr+/QRZzsL9If304wvpuYb34RUHBVzQBK+x+1LX3SRDfJoxsQnt9rWbgmaP9C6JiY/A/O/2iegTCiwpQ9KevjdjODTsd5UFqxr+z5LLNXAnOIZ9OV+kKd+TTXrNGth98oqxrci0RKR6HB1TXfl1Xv657bFSiLq98TvkegRPcMfZhO/02dgK4D1ZUbvcsnLEV2Nrhpf7ZH401kXQgLRz+AD+PekngWk8MdwyJs1q7mVTKVgZE+fY4+sGSiRJpxiWh71X4mNAr+x5KBpfr5mk797CJK9oOoXANKFH0Me9NXup+CgTICx8qb7XIZ+SNrHvFS0nDgq2ULLppDeMyXUWpaPII/QTXJZiozRVSTBqAEWkmPPJjEspjm4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3902.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(39860400002)(366004)(136003)(396003)(186006)(1800799006)(451199021)(84970400001)(83380400001)(478600001)(122000001)(9686003)(966005)(6506007)(26005)(55016003)(8936002)(41300700001)(66476007)(76116006)(66446008)(66556008)(66946007)(64756008)(8676002)(4744005)(2906002)(316002)(7696005)(71200400001)(110136005)(38100700002)(33656002)(52536014)(38070700005)(86362001)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cEFkdklLRmpEVFZpN2ZhbUREK25lOEZPTzBsd01kTVR6WkJJWEpPMzlwY3Yy?=
 =?utf-8?B?cjE2VitjTXEwT1RubDFlTjgxZ2FrbU80SlNvWnhEb2JtaVRIWU53SU1yOEk4?=
 =?utf-8?B?N3pmVkpUQThmSjVWUVg2WDliSC9tSGxmWlhla2tRNVlKbXFvZTRDUzRWWWtH?=
 =?utf-8?B?SmVELzkrS044R2VlNDhsWGxwaENJT3FjaStBakpYRHlFOERwWFk5MHdDbGRW?=
 =?utf-8?B?WDZVT1Q0QXk5M2NQQm0zTmZSbEJ2Q0l0alVjM3llVldvdUUxZnJ4VmZwYXc2?=
 =?utf-8?B?dXZHWnV2ZTV3ckdwS200LytrN24zcXBpWGZXS0gvcnp3N1BTY3RlSEErZ3o1?=
 =?utf-8?B?U3hueWw2N3c5MTVvaFRrUTJSakVjL3g2YkhRZ2RkbkVvdm10THUyQ0FQNlQv?=
 =?utf-8?B?TmVWMGVJcW5XKzVIMHRWSlA4NmIxakFpTldaS2g0by9SQk1YNUhzV3ZlU2JG?=
 =?utf-8?B?d0ZOWlJ2M09GSzJvRnNmVnFnVExiSWh1d054RThOUS9LRFdqYjVMckk4aGli?=
 =?utf-8?B?bDROTEpwTkxFandEaWpXOUYzS2dsdi9OREo5eDBoTVVPVnlBTy9pQWlhQW1G?=
 =?utf-8?B?YVhsaS9LcWtHNXlNeG1BZm9PYW93RHFuYzRJOWUySTRpa3pCYVpuTUs3ZS9X?=
 =?utf-8?B?RnV5NHZCOTlZOWMwMitBOXd4QlpTajRwNUZOeDJKQ1I0VkpnUXpTenBjclEx?=
 =?utf-8?B?V1hwV2xZR2FEdGYzMzNhZy9YdnFwUm1tK3VRc3ZRR1NUcFdDbkJrNDZwei9Z?=
 =?utf-8?B?b3IzTHVPMVErSElVc0xNWlFsREM2eWNETXlxSXFuN2EzdlN1T2tycm84N0Ri?=
 =?utf-8?B?VGNzekxncGtLdm5GUG45dy96cDY3RGhEQVprdUpTMFVKeW56YkFEck40SlYv?=
 =?utf-8?B?cE5NcGk1VWQyRFFwSXY4MitWanlVdmRnZlFsdWFhM3VTbFplc2dBZVlXelFy?=
 =?utf-8?B?ZnU0T2FWTlVqMWpaaHF4MXFrVnZ5RkJzU3A1N2c1QXp6R0o3Z0VMS0dwZFlu?=
 =?utf-8?B?anFIS2V1VXcrejMzN0Q1a0JCYjhPNnJIRndKcnRia3ZsZ3hmalcyM3lIakJM?=
 =?utf-8?B?NW4wRHZ6eE1hTVBxTStuUmhCei8zZjkycHo4ZUdpZC9nU0N2UGgwM3B4a0R0?=
 =?utf-8?B?Vm9sZVZGMnJFSXR4UVJDclMyck1UTjdFVmZvVnpCU25RYjBWcVFrbVB4STJF?=
 =?utf-8?B?VkdvOThGWmV3RGRpZTBxcHY2YXhmaU16NW1LVys5QTF3MEl4bERhWk5EcDg4?=
 =?utf-8?B?K2FmRHlJMmZpcDNUVW55MmJtaXFGOWpqYzF4dzRtc2FIcWo3eGd3cjhPQWJt?=
 =?utf-8?B?VFl1NXh2OW5ackVmdlpzdEdUbmZ2ZUpCMlNDKzVzSkFXZm9PWEI0Nks3Znhv?=
 =?utf-8?B?NTNLcjJzT2FYRWNJT3RnU0dMR2VwYi94MXpXbzd1eThhVTZNamJHZElTTEJ0?=
 =?utf-8?B?N0tpdmpkNUk5ODh1c05HUW1CYndPdmpUcjVWWHN5V0hOUXJ4RDZNWDViOXRi?=
 =?utf-8?B?ME5SWSsvbU1abDA1L3lYVXlGcHhjZlp6RVoyQlZQcjdHN3Y2OU9FSnZBcU5i?=
 =?utf-8?B?bjRQbVhQWFJtcnN3cURRb2UraXJvRHM3U1hLUzFKT0pZUzF1RTgxNDVYRVJr?=
 =?utf-8?B?am9VREsvM04wMXBmdTROc0ZpbHFmbTBzUk4xZUFKZ2xmTEVqTms4aTN6MkdM?=
 =?utf-8?B?SHpuYWFUMUUrVDNOdnZXamFlYmRQTXpjSXJkK0FCT3d4KzJvMDRGL09yRG53?=
 =?utf-8?B?ZVUweWpub1JGZ1hkMkpxeFBNMzRZNkFIcG9Dd2xBcXNMVDRHbjl0eWlKSmxw?=
 =?utf-8?B?UE1IWnZHWkswWS9KcnVoME5vSzZrenhnQWR1UTlQS1c3NDVJdWxLT295cHo4?=
 =?utf-8?B?ZFNwS2xiRGNWbVY1cEtqWE9ZOTUzbkpxQXZCb2RPcWg4OTNCSlp2MlpUeUpD?=
 =?utf-8?B?M3VUZi9hMDcxaWFkWTNBU0R3b2JLY09IUk8zZW13bE1HYkZ1QzB5N3JtS1g5?=
 =?utf-8?B?WVN4c2d2Sy9MNDdTU1E1WjhsOGl1Qlo2Y1RhNmFFWEtmYkFEek1DWExhcGJ2?=
 =?utf-8?B?cFpQRkFaaEZWRU9TSXAvWDB4UExMT252eFpJclZOdlVnZTlOblI3WmFSRFJr?=
 =?utf-8?Q?SD08=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3902.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b83f231-9f37-4bc5-fe76-08db9915b8b2
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Aug 2023 20:17:57.4794
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5buqItJyTzDEaMIlGx7fCtMRKFb1lydf73dEBw/eFakbkE4+XiL/lFbxvvbV1iBZtMQu9fMWpjrCSo1yOx5nqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5937
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+ICBkcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLWJvb3RjdGwuYyB8IDY3DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysgIGRyaXZlcnMvcGxhdGZvcm0vbWVsbGFub3gvbWx4YmYt
Ym9vdGN0bC5oIHwNCj4gPiAxOSArKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgODYgaW5z
ZXJ0aW9ucygrKQ0KPiANCj4gVGhhbmsgeW91IGZvciB5b3VyIHBhdGNoLXNlcmllcywgSSd2ZSBh
cHBsaWVkIHRoZSBzZXJpZXMgdG8gbXkgcmV2aWV3LWhhbnMNCj4gYnJhbmNoOg0KPiBodHRwczov
L2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9wZHg4Ni9wbGF0Zm9ybS1k
cml2ZXJzLQ0KPiB4ODYuZ2l0L2xvZy8/aD1yZXZpZXctaGFucw0KPiANCj4gT25jZSBJJ3ZlIHJ1
biBzb21lIHRlc3RzIG9uIHRoaXMgYnJhbmNoIHRoZSBwYXRjaGVzIHRoZXJlIHdpbGwgYmUgYWRk
ZWQgdG8gdGhlDQo+IHBsYXRmb3JtLWRyaXZlcnMteDg2L2Zvci1uZXh0IGJyYW5jaCBhbmQgZXZl
bnR1YWxseSB3aWxsIGJlIGluY2x1ZGVkIGluIHRoZQ0KPiBwZHg4NiBwdWxsLXJlcXVlc3QgdG8g
TGludXMgZm9yIHRoZSBuZXh0IG1lcmdlLXdpbmRvdy4NCj4gDQpUaGFuayB5b3UgdmVyeSBtdWNo
IEhhbnMhDQo=
