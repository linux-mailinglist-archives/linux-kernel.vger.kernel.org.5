Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A037A716E
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 06:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjITELA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 00:11:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjITEK4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 00:10:56 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2077.outbound.protection.outlook.com [40.107.92.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AAFAC
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 21:10:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Db1VamFSQCH63e6yh7h7/dv19+W7AZavm6xYxqaCY35CRVfsqKVb2xVcJYhTP7YEuoiXz5MSV9tR4a8tRegyIPa9znw1daY9VhxUBx22FQLGZTycHcj8WRJr/RkUcORhYgrGY1Tp11Cd9LymrxcwAL6gWKj8cJCQ2Zq7c+Qu2TbWHn0Tw0P5hryokuE4fo+TtaJKF8Se0/NDYqq8lpWTTwZu1qk5fDt2UlKF5cQcqXUXcfnJ6jmxaNw8UcTGdPoBj5g48Z6J2ISpfxM+Lu8xXDG/PpZiNifqtm8UW5SoaUnxy4sJByHgdqfDjKV8f8Hp4eVpU/BWa+JXhHUQ5rxT4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZI+4/Yf/Tn45CquTikMx+l6NDgwRVprfFz2uam7yCk=;
 b=NqQTGPzGS9YgMf7AP7LX5U3v2bn99TioLqQL69vPi9G/UJn1QHCLzQmXs1IBSyEprhUfeLttpM+KkdkPdASYI+5CSV9S0A13tZ/wUwz8fDHwyU4KaeH0HWbzmwu6WGBx5CFC4Ico+auEpdkINYUcOINm7KKr1uV+gO3frrz2eh+rWxC2mDrukAgw0bSnCocApJQuWmQBdu+OrjCnyZhznpmByMrYvSYYdjZ9Sm4KG6yGgwW7rEoB0VDZwt+HlXDRvTbSu7N6sI2F3abYX6+ftvUiqJ8sKgks1iLdt3mWFeCFxUdDBdkVMrgoCPp1TDBS0a6LYQQTZ4Kwq+oHQqxnJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZI+4/Yf/Tn45CquTikMx+l6NDgwRVprfFz2uam7yCk=;
 b=CC3bjVpRcxIJv1EwWS/dbVAVlZ6tCIGe5NCb7MJMIbNM62iMkuctJoO1YAOX68HQu/vTKg8wMXi1v7+enI86oy/kh52hrnabmYLFWdxa9GTjNoyra2ielmO7K0jGMGypsyv9bh/Jf2/A3T5qN5x0WIsy437XFCqssVzAqP13rhsTpnQy1fhxB4v3jykldT29kNEgyNy5pFX+EuA0Wa39hWFjd4wcsBBh2L+5GVc9jv6dC0/ZFuGKCkC9XGotd5Vrk2VAYEc9hcHcayXDm8PFErdObKUEJ/vmcy/wyKHH4JgsyE81cB5dE6NMRdZIe5ZB0OwI6eczVvWEiBhRDNgEow==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by DS7PR12MB6214.namprd12.prod.outlook.com (2603:10b6:8:96::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 04:10:44 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 04:10:44 +0000
From:   Parav Pandit <parav@nvidia.com>
To:     "Chen, Jiqian" <Jiqian.Chen@amd.com>
CC:     "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "virtio-comment@lists.oasis-open.org" 
        <virtio-comment@lists.oasis-open.org>,
        Mikhail Golubev-Ciuchea <Mikhail.Golubev-Ciuchea@opensynergy.com>,
        Robert Beckett <bob.beckett@collabora.com>,
        =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        Chia-I Wu <olvaffe@gmail.com>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Gerd Hoffmann <kraxel@redhat.com>,
        "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Stefano Stabellini <sstabellini@kernel.org>,
        =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?= <roger.pau@citrix.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>,
        "Koenig, Christian" <Christian.Koenig@amd.com>,
        "Hildebrand, Stewart" <Stewart.Hildebrand@amd.com>,
        Xenia Ragiadakou <burzalodowa@gmail.com>,
        "Huang, Honglei1" <Honglei1.Huang@amd.com>,
        "Zhang, Julia" <Julia.Zhang@amd.com>,
        "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [virtio-dev] RE: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] RE: [VIRTIO PCI PATCH v5 1/1] transport-pci: Add
 freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiChaQgAENTYCAAABEYA==
Date:   Wed, 20 Sep 2023 04:10:44 +0000
Message-ID: <PH0PR12MB5481DE5DBFFF3F5B91E53FCFDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <PH0PR12MB5481C0BE6E076F4EC077C4DDDCFAA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <BL1PR12MB5849B6C811E3BA8A8977FE18E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
In-Reply-To: <BL1PR12MB5849B6C811E3BA8A8977FE18E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|DS7PR12MB6214:EE_
x-ms-office365-filtering-correlation-id: 0eb5e024-8fee-4cff-3ea2-08dbb98f8fcd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2HW2u7we2vJZGTDjvKoTvSAJFt1tf2cAviBl8y3Hbep5eagZ0D/LrgecFewKXQTYIO1PZq5PxoIOveTG2AmLlnpre0S+P7tL7Q6Bwj4k8DMqYgu6qFelrCY2JgI1X6K4v1AD6Qt5TfZiKjVZcLqKDFApZj/jE1WyPGNrXyUWadJBcXaKZ514/HLAUkXxZD9VnKYfZtJTVaE4eK+ZFkD2B/+hq7LWwppQ7Q0IhsPrOo0kOcrEkIh0B90wB++5+ZiUC9/9zy7mDHJTBwGUdkCKRM8heW7rKAaglIzApUH/Rwbbe/87mUUw0FWBtiPHOwkR66FY4PeFlZ/tmpHpE7Nwevhpyzzqu1ml1scL1hj1jCCRdazBfRL4KeNYuS8CsJbJjnMn4A2u+DKcMq69X+N5w1ptkyu0GMPMlMGoHbbMrazw7uPLAVrzaX76267gef3xSG69TcXjPjPXrcfthrEFjyvOXxVSO9iC3y0a6E5AHZs335TejVR831cx+wTPbNoYw42XZax9iR4AaukXJvo6Mckjcg3GEJkMmt6vfnY8e07Rm8v5E2snhU+alOYWaCvzvi7DleAP9F1s+eEhtuoTzcichPkHfQEJfVIny920dtpAOyICGeYeBH7qhFWF4yk+j1gOiT9nGVQNcJx8qolrkIyhH/sjga7kQwQ0wyJ/3RHhoSscbdvlR3YtD8st9ahPVOy5IRejSPswfFWJkN9DZw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR12MB5481.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(186009)(1800799009)(451199024)(7696005)(6506007)(9686003)(71200400001)(966005)(478600001)(83380400001)(4326008)(26005)(2906002)(7416002)(76116006)(64756008)(66476007)(6916009)(66446008)(66556008)(54906003)(316002)(66946007)(5660300002)(8676002)(52536014)(8936002)(41300700001)(38100700002)(33656002)(55016003)(86362001)(38070700005)(122000001)(84970400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VE9uREV0RHVSZ2lzeE9oZUJFZHhTT2kzc25zclowZUxROUpxNkNSd2RpY0Y0?=
 =?utf-8?B?bFJ1RUl0UUJ3YkdqREppK2ZhczBsa1dNTHBpbTd4RGcycHM2OXZ4eWpGaXA2?=
 =?utf-8?B?MVdlV050ZHhkdWZyTStzK1loclY4b2FWVk55QlVUZUJoVWJlanU1bWI3QnNL?=
 =?utf-8?B?YUw5SC9sK2FtNHlHdEZJdC9FTi9uSk1QQ1Brd3ZrUGZEemdGYjkwaWNHMk4r?=
 =?utf-8?B?STlZOUVpdC95SjNUWHc4N3QxY0VoR1hoTzhZbVIvNkIwUWlWVXZTRUNLSXN5?=
 =?utf-8?B?cC81TnFqY3Fpb3YwVFV2cWdVdjhiTCt6dnhKMVZZMDRPT3BpTC94YVZXT1lp?=
 =?utf-8?B?bldhQmVZbkVycWJQZ2VFU3JZbllWOG55eHVaKzkzcktGRGZPRnRQYXQvRDYw?=
 =?utf-8?B?V3YrVXp6RmVETVY5TnBwbEpJVzZiQVE5NDdER2kxazEzWGVYam5qNWQxTFNl?=
 =?utf-8?B?WFJPSlprZXVpd2FzZjZjTWtkVjFxemo2Qk4vRE1mOU9SZEUvWVIxbHpvYlpl?=
 =?utf-8?B?RmFWS1IxQ3lJS1hhdHNBWXFhTWtub2ZKcTNLVXM2MjRJakMwam5haDVTVlhM?=
 =?utf-8?B?a1lSbjgwdU1WM3ZwTlgzUk9WQ3ZWWFhXR09vSUVxYXV6S3VxMlJtMVpIUXE2?=
 =?utf-8?B?UnVOczYrd0hOck5pdDFaUTlpcUY5U0ZEaGdjb3lMd2xkR256UE8xV21vK1ZP?=
 =?utf-8?B?RUVMWmVmUUFyUHBGdmQwTTMwUllsRDVORXp0L1VLVThVYTlQTnpqQXIyOUpG?=
 =?utf-8?B?RG9VbU1vUk5kZzFDZFdGTHpUQVpPblZKUlJUV3ZPL1hkYUNaTjJrdDBPaStt?=
 =?utf-8?B?NlE1blFQaE9OZzNkcTR0ZXBDLzdrb3hIUU1ZTC8yb01FRFBuajhQd20xeW93?=
 =?utf-8?B?U1Z6bWgyZ0JUNTN1cncyRmFMNnphd1NnS2JlbWRIMjNyRzFYSldWd3FFZlMv?=
 =?utf-8?B?aTJ2T3pPbkZ5bmVxdmpFRktNa2dNOGpIV01qSEsxS2hOSkd2MVZyS0o3MHNW?=
 =?utf-8?B?RUZWcWswWTFYN0tQTGcrNTdTZnhEcEhaV3E0YXJKdjZ2RFZPVUs2MHRuQWtp?=
 =?utf-8?B?K0IwNS9xdFltT1dyeUdKbE1iMmtwV0lia1M5UUJFME1LMSs3UG1tMXVZMmhw?=
 =?utf-8?B?OUZXOW5jcG5iejJZYkcyeCtKSm1BWkJOczVOQjNzMXFKVGJ0a21MSzlnY2ZI?=
 =?utf-8?B?cjVQMVZIRzNSbUU3dkFZVGFxNTBBNFgwRm4wVm5sQWhiQmpTcy9KV3JBZ1Mr?=
 =?utf-8?B?NkNxV3FFVDMwQTlqWlMzY09BM09MSy94ekhyaTFUWjJrV2x3ZkpnOThFempE?=
 =?utf-8?B?QWlLTjRPMWJtR3NCT0t3Y21SZ3FoYzVFa1B6dUp4YW53cHJlNmFoWWlQVXJN?=
 =?utf-8?B?QXdEdXlITzh6bHpjVjZ2dzBSOTFxaGIwNjBkcC80bklvQ3lveVNGNzYyeC9W?=
 =?utf-8?B?bDhnTk53Uk5oQWlxOFRoTVJYUDdhTy9pL0t0YXdJdWJ4QnBnbVpkamxiZU9F?=
 =?utf-8?B?Ty9BZmRlQytlU3N5TEVQTkJiQjN0YW1SVWxQOHQ4YXdOVnBsVGlSMEptZmU3?=
 =?utf-8?B?MTh5UmNCZTRkeXdnOG1WenFHa1loSG42Y3p1Yy81cWcvaFFKa0lMcHVKbG5u?=
 =?utf-8?B?dDhMelJUMTczWWprU0ZOM3pqeVJ2a3RVbktmOEkvZVVGRjNic1ZvUWVVNCtp?=
 =?utf-8?B?VUNBVnFJTWVQbEtqRFdpcVJGbnltbzdXd0YyckRreFdNUzZNcUFSNzJlaC8x?=
 =?utf-8?B?aGhSRnRtLytRK0RRNDR3V2xQc2I3QVo0Z08zb2RteXZFWHlHZ0JrL3J0MXNE?=
 =?utf-8?B?emVSZ3VFdjlneFVkT3RRUmpTSmp0UEJjdmpyRWRzSDVqVjZjT3M4alFYN0ZY?=
 =?utf-8?B?SmxBS1RzOUxiMDZxeWdmcFFjaEpTOXd4Qjl4TWRmbXdkYllIK3FiNmY0b3l2?=
 =?utf-8?B?QzNMcCtkYm5jSVgyRXZXWVgyK3Q4K2U4QkN3Z1JkVElLTXpDVU5mSUJRRFVp?=
 =?utf-8?B?elZqS1YvcXVoby9QRDZIUHJITFoyL0dEdE5mcEU2bzZ0dy9ucmxBU25ZNmdC?=
 =?utf-8?B?WFFYanNSejVHNzFoZXJJZ0V2L1FpS0Q1a0FlN3dqc2o0QXFXdEY5ZTd1T1Nr?=
 =?utf-8?Q?nkKQ=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0eb5e024-8fee-4cff-3ea2-08dbb98f8fcd
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 04:10:44.6601
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9AVsCeZJSivWstnfaDBR74xLrH9aWfLPsg2Rcu4cS/I32rzVcVTDEJxM9wrDkp4WLyMNj1/OArLgB9+MuAxSTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6214
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gRnJvbTogQ2hlbiwgSmlxaWFuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiBTZW50OiBX
ZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA5OjI4IEFNDQoNCj4gPj4gRm9yIGFib3ZlIHB1
cnBvc2UsIHdlIG5lZWQgYSBtZWNoYW5pc20gdGhhdCBhbGxvd3MgZ3Vlc3RzIGFuZCBRRU1VIHRv
DQo+ID4+IG5lZ290aWF0ZSB0aGVpciByZXNldCBiZWhhdmlvci4gU28gdGhpcyBwYXRjaCBhZGQg
YSBuZXcgcGFyYW1ldGVyDQo+ID4+IG5hbWVkDQo+ID4gRnJlZXplICE9IHJlc2V0LiA6KQ0KPiA+
IFBsZWFzZSBmaXggaXQgdG8gc2F5IGZyZWV6ZSBvciBzdXNwZW5kLg0KPiBCdXQgaW4gbXkgdmly
dGlvLWdwdSBzY2VuZSwgSSB3YW50IHRvIHByZXZlbnQgUWVtdSBkZXN0cm95aW5nIHJlc291cmNl
cyB3aGVuDQo+IEd1ZXN0IGRvIHJlc3VtaW5nKHBjaV9wbV9yZXN1bWUtPiB2aXJ0aW9fcGNpX3Jl
c3RvcmUtPg0KPiB2aXJ0aW9fZGV2aWNlX3Jlc3RvcmUtPiB2aXJ0aW9fcmVzZXRfZGV2aWNlLT4g
dnBfbW9kZXJuX3NldF9zdGF0dXMtPlFlbXUNCj4gdmlydGlvX3BjaV9yZXNldC0+dmlydGlvX2dw
dV9nbF9yZXNldC0+IHZpcnRpb19ncHVfcmVzZXQpLiBBbmQgSSBhZGQgY2hlY2sgaW4NCj4gdmly
dGlvX2dwdV9nbF9yZXNldCBhbmQgdmlydGlvX2dwdV9yZXNldCwgaWYgZnJlZXplX21vZGUgd2Fz
IHNldCB0byBGUkVFWkVfUzMNCj4gZHVyaW5nIEd1ZXN0IHN1c3BlbmRpbmcsIFFlbXUgd2lsbCBu
b3QgZGVzdHJveSByZXNvdXJjZXMuIFNvIHRoZSByZWFzb24gd2h5IEkNCj4gYWRkIHRoaXMgbWVj
aGFuaXNtIGlzIHRvIGFmZmVjdCB0aGUgcmVzZXQgYmVoYXZpb3IuIEFuZCBJIHRoaW5rIHRoaXMg
YWxzbyBjYW4gaGVscA0KPiBvdGhlciB2aXJ0aW8gZGV2aWNlcyB0byBhZmZlY3QgdGhlaXIgYmVo
YXZpb3IsIGxpa2UgdGhlIGlzc3VlIG9mIHZpcnRpby12aWRlbyB3aGljaA0KPiBNaWtoYWlsIEdv
bHViZXYtQ2l1Y2hlYSBlbmNvdW50ZXJlZC4NCj4NClRoZSBwb2ludCBpcyB3aGVuIGRyaXZlciB0
ZWxscyB0byBmcmVlemUsIGl0IGlzIGZyZWV6ZSBjb21tYW5kIGFuZCBub3QgcmVzZXQuDQpTbyBy
ZXN1bWUoKSBzaG91bGQgbm90IGludm9rZSBkZXZpY2VfcmVzZXQoKSB3aGVuIEZSRUVaRStSRVNV
TUUgc3VwcG9ydGVkLg0KIA0KPiA+DQo+ID4+IGZyZWV6ZV9tb2RlIHRvIHN0cnVjdCB2aXJ0aW9f
cGNpX2NvbW1vbl9jZmcuIEFuZCB3aGVuIGd1ZXN0IHN1c3BlbmRzLA0KPiA+PiBpdCBjYW4gd3Jp
dGUgZnJlZXplX21vZGUgdG8gYmUgRlJFRVpFX1MzLCBhbmQgdGhlbiB2aXJ0aW8gZGV2aWNlcyBj
YW4NCj4gPj4gY2hhbmdlIHRoZWlyIHJlc2V0IGJlaGF2aW9yIG9uIFFlbXUgc2lkZSBhY2NvcmRp
bmcgdG8gZnJlZXplX21vZGUuDQo+ID4+IFdoYXQncyBtb3JlLA0KPiA+IE5vdCByZXNldCwgYnV0
IHN1c3BlbmQgYmVoYXZpb3IuDQo+IFRoZSBzYW1lIHJlYXNvbiBhcyBhYm92ZS4NCj4NClJlc2V0
IHNob3VsZCBub3QgYmUgZG9uZSBieSB0aGUgZ3Vlc3QgZHJpdmVyIHdoZW4gdGhlIGRldmljZSBz
dXBwb3J0cyB1bmZyZWV6ZS4NCiANCj4gPg0KPiA+PiBmcmVlemVfbW9kZSBjYW4gYmUgdXNlZCBm
b3IgYWxsIHZpcnRpbyBkZXZpY2VzIHRvIGFmZmVjdCB0aGUgYmVoYXZpb3INCj4gPj4gb2YgUWVt
dSwgbm90IGp1c3QgdmlydGlvIGdwdSBkZXZpY2UuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6
IEppcWlhbiBDaGVuIDxKaXFpYW4uQ2hlbkBhbWQuY29tPg0KPiA+PiAtLS0NCj4gPj4gIHRyYW5z
cG9ydC1wY2kudGV4IHwgNyArKysrKysrDQo+ID4+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRp
b25zKCspDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS90cmFuc3BvcnQtcGNpLnRleCBiL3RyYW5z
cG9ydC1wY2kudGV4IGluZGV4DQo+ID4+IGE1YzY3MTkuLjI1NDM1MzYgMTAwNjQ0DQo+ID4+IC0t
LSBhL3RyYW5zcG9ydC1wY2kudGV4DQo+ID4+ICsrKyBiL3RyYW5zcG9ydC1wY2kudGV4DQo+ID4+
IEBAIC0zMTksNiArMzE5LDcgQEAgXHN1YnN1YnNlY3Rpb257Q29tbW9uIGNvbmZpZ3VyYXRpb24g
c3RydWN0dXJlDQo+ID4+IGxheW91dH1cbGFiZWx7c2VjOlZpcnRpbyBUcmFuc3BvcnQNCj4gPj4g
ICAgICAgICAgbGU2NCBxdWV1ZV9kZXNjOyAgICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICov
DQo+ID4+ICAgICAgICAgIGxlNjQgcXVldWVfZHJpdmVyOyAgICAgICAgICAgICAgLyogcmVhZC13
cml0ZSAqLw0KPiA+PiAgICAgICAgICBsZTY0IHF1ZXVlX2RldmljZTsgICAgICAgICAgICAgIC8q
IHJlYWQtd3JpdGUgKi8NCj4gPj4gKyAgICAgICAgbGUxNiBmcmVlemVfbW9kZTsgICAgICAgICAg
ICAgICAvKiByZWFkLXdyaXRlICovDQo+ID4+ICAgICAgICAgIGxlMTYgcXVldWVfbm90aWZfY29u
ZmlnX2RhdGE7ICAgLyogcmVhZC1vbmx5IGZvciBkcml2ZXIgKi8NCj4gPj4gICAgICAgICAgbGUx
NiBxdWV1ZV9yZXNldDsgICAgICAgICAgICAgICAvKiByZWFkLXdyaXRlICovDQo+ID4+DQo+ID4g
VGhlIG5ldyBmaWVsZCBjYW5ub3QgYmUgaW4gdGhlIG1pZGRsZSBvZiB0aGUgc3RydWN0dXJlLg0K
PiA+IE90aGVyd2lzZSwgdGhlIGxvY2F0aW9uIG9mIHRoZSBxdWV1ZV9ub3RpZl9jb25maWdfZGF0
YSBkZXBlbmRzIG9uDQo+IGNvbXBsZXRlbHkgdW5yZWxhdGVkIGZlYXR1cmUgYml0LCBicmVha2lu
ZyB0aGUgYmFja3dhcmQgY29tcGF0aWJpbGl0eS4NCj4gPiBTbyBwbGVhc2UgbW92ZSBpdCBhdCB0
aGUgZW5kLg0KPiBJIGhhdmUgY29uZnVzZWQgYWJvdXQgdGhpcy4gSSBmb3VuZCBpbiBsYXRlc3Qg
a2VybmVsIGNvZGUobWFzdGVyIGJyYW5jaCk6DQo+IHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9j
Zmcgew0KPiAJLyogQWJvdXQgdGhlIHdob2xlIGRldmljZS4gKi8NCj4gCV9fbGUzMiBkZXZpY2Vf
ZmVhdHVyZV9zZWxlY3Q7CS8qIHJlYWQtd3JpdGUgKi8NCj4gCV9fbGUzMiBkZXZpY2VfZmVhdHVy
ZTsJCS8qIHJlYWQtb25seSAqLw0KPiAJX19sZTMyIGd1ZXN0X2ZlYXR1cmVfc2VsZWN0OwkvKiBy
ZWFkLXdyaXRlICovDQo+IAlfX2xlMzIgZ3Vlc3RfZmVhdHVyZTsJCS8qIHJlYWQtd3JpdGUgKi8N
Cj4gCV9fbGUxNiBtc2l4X2NvbmZpZzsJCS8qIHJlYWQtd3JpdGUgKi8NCj4gCV9fbGUxNiBudW1f
cXVldWVzOwkJLyogcmVhZC1vbmx5ICovDQo+IAlfX3U4IGRldmljZV9zdGF0dXM7CQkvKiByZWFk
LXdyaXRlICovDQo+IAlfX3U4IGNvbmZpZ19nZW5lcmF0aW9uOwkJLyogcmVhZC1vbmx5ICovDQo+
IA0KPiAJLyogQWJvdXQgYSBzcGVjaWZpYyB2aXJ0cXVldWUuICovDQo+IAlfX2xlMTYgcXVldWVf
c2VsZWN0OwkJLyogcmVhZC13cml0ZSAqLw0KPiAJX19sZTE2IHF1ZXVlX3NpemU7CQkvKiByZWFk
LXdyaXRlLCBwb3dlciBvZiAyLiAqLw0KPiAJX19sZTE2IHF1ZXVlX21zaXhfdmVjdG9yOwkvKiBy
ZWFkLXdyaXRlICovDQo+IAlfX2xlMTYgcXVldWVfZW5hYmxlOwkJLyogcmVhZC13cml0ZSAqLw0K
PiAJX19sZTE2IHF1ZXVlX25vdGlmeV9vZmY7CS8qIHJlYWQtb25seSAqLw0KPiAJX19sZTMyIHF1
ZXVlX2Rlc2NfbG87CQkvKiByZWFkLXdyaXRlICovDQo+IAlfX2xlMzIgcXVldWVfZGVzY19oaTsJ
CS8qIHJlYWQtd3JpdGUgKi8NCj4gCV9fbGUzMiBxdWV1ZV9hdmFpbF9sbzsJCS8qIHJlYWQtd3Jp
dGUgKi8NCj4gCV9fbGUzMiBxdWV1ZV9hdmFpbF9oaTsJCS8qIHJlYWQtd3JpdGUgKi8NCj4gCV9f
bGUzMiBxdWV1ZV91c2VkX2xvOwkJLyogcmVhZC13cml0ZSAqLw0KPiAJX19sZTMyIHF1ZXVlX3Vz
ZWRfaGk7CQkvKiByZWFkLXdyaXRlICovDQo+IA0KPiAJX19sZTE2IGZyZWV6ZV9tb2RlOwkJLyog
cmVhZC13cml0ZSAqLw0KPiB9Ow0KPiBUaGVyZSBpcyBubyBxdWV1ZV9ub3RpZl9jb25maWdfZGF0
YSBvciBxdWV1ZV9yZXNldCwgYW5kIGZyZWV6ZV9tb2RlIEkgYWRkZWQNCj4gaXMgYXQgdGhlIGVu
ZC4gV2h5IGlzIGl0IGRpZmZlcmVudCBmcm9tIHZpcnRpby1zcGVjPw0KPg0KQmVjYXVzZSBub3Rp
ZnkgZGF0YSBtYXkgbm90IGJlIHVzZWQgYnkgTGludXggZHJpdmVyIHNvIGl0IG1heSBiZSBzaG9y
dGVyLg0KSSBkaWRu4oCZdCBkaWcgY29kZSB5ZXQuDQogDQo+ID4NCj4gPj4gQEAgLTM5Myw2ICsz
OTQsMTIgQEAgXHN1YnN1YnNlY3Rpb257Q29tbW9uIGNvbmZpZ3VyYXRpb24gc3RydWN0dXJlDQo+
ID4+IGxheW91dH1cbGFiZWx7c2VjOlZpcnRpbyBUcmFuc3BvcnQgIFxpdGVtW1xmaWVsZHtxdWV1
ZV9kZXZpY2V9XQ0KPiA+PiAgICAgICAgICBUaGUgZHJpdmVyIHdyaXRlcyB0aGUgcGh5c2ljYWwg
YWRkcmVzcyBvZiBEZXZpY2UgQXJlYSBoZXJlLg0KPiA+PiBTZWUgc2VjdGlvbiBccmVme3NlYzpC
YXNpYyBGYWNpbGl0aWVzIG9mIGEgVmlydGlvIERldmljZSAvIFZpcnRxdWV1ZXN9Lg0KPiA+Pg0K
PiA+PiArXGl0ZW1bXGZpZWxke2ZyZWV6ZV9tb2RlfV0NCj4gPj4gKyAgICAgICAgVGhlIGRyaXZl
ciB3cml0ZXMgdGhpcyB0byBzZXQgdGhlIGZyZWV6ZSBtb2RlIG9mIHZpcnRpbyBwY2kuDQo+ID4+
ICsgICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfVU5GUkVFWkUgLSB2aXJ0aW8tcGNpIGlz
IHJ1bm5pbmc7DQo+ID4+ICsgICAgICAgIFZJUlRJT19QQ0lfRlJFRVpFX01PREVfRlJFRVpFX1Mz
IC0gZ3Vlc3Qgdm0gaXMgZG9pbmcgUzMsIGFuZA0KPiA+PiArdmlydGlvLQ0KPiA+IEZvciBhYm92
ZSBuYW1lcywgcGxlYXNlIGRlZmluZSB0aGUgYWN0dWFsIHZhbHVlcyBpbiB0aGUgc3BlYy4NCj4g
T2ssIEkgd2lsbCBhZGQgdGhlbS4NCj4gDQo+ID4NCj4gPj4gcGNpIGVudGVycyBTMyBzdXNwZW5z
aW9uOw0KPiA+PiArICAgICAgICBPdGhlciB2YWx1ZXMgYXJlIHJlc2VydmVkIGZvciBmdXR1cmUg
dXNlLCBsaWtlIFM0LCBldGMuDQo+ID4+ICsNCj4gPiBJdCBjYW5ub3QgYmUganVzdCBvbmUgd2F5
IGNvbW11bmljYXRpb24gZnJvbSBkcml2ZXIgdG8gZGV2aWNlIGFzIGZyZWV6aW5nIHRoZQ0KPiBk
ZXZpY2Ugb2YgZmV3IGh1bmRyZWQgTUIgdG8gR0Igb2YgZ3B1IG1lbW9yeSBvciBvdGhlciBkZXZp
Y2UgbWVtb3J5IGNhbg0KPiB0YWtlIHNldmVyYWwgbXNlYy4NCj4gPiBIZW5jZSBkcml2ZXIgbXVz
dCBwb2xsIHRvIGdldCB0aGUgYWNrbm93bGVkZ2VtZW50IGZyb20gdGhlIGRldmljZSB0aGF0DQo+
IGZyZWV6ZSBmdW5jdGlvbmFsaXR5IGlzIGNvbXBsZXRlZC4NCj4gSSB0aGluayB0aGUgZnJlZXpl
IGZ1bmN0aW9uYWxpdHkgaXRzZWxmIGhhcyBub3QgbWFueSBwcm9ibGVtcy4gTXkgcGF0Y2hlcyBq
dXN0DQo+IHdhbnQgdG8gdGVsbCBRZW11IHRoYXQgdGhlIHJlc2V0IHJlcXVlc3QgaXMgZnJvbSB0
aGUgcHJvY2VzcyBvZiBndWVzdCByZXN1bWluZw0KPiBub3Qgb3RoZXIgc2NlbmUsIGFuZCB3cml0
ZSBhIHN0YXR1cyBpbnRvIGZyZWV6ZV9tb2RlLCB0aGVuIHdlIGNhbiBjaGFuZ2UgdGhlDQo+IHJl
c2V0IGJlaGF2aW9yIGR1cmluZyBndWVzdCByZXN1bWluZy4NCj4gDQpFaXRoZXIgZ3Vlc3Qgc2hv
dWxkIGRvIGZyZWV6ZSBvciByZXNldCwgbm90IGJvdGguDQpXaXRoIHRoYXQgZWFjaCBmdW5jdGlv
bmFsaXR5IGhhcyBjbGVhciBzZW1hbnRpY3Mgb2Ygd2hhdCBpdCBleGFjdGx5IGRvZXMuDQpGcmVl
emUgdG8gbm90IGNoYW5nZSByZXNldCBiZWhhdmlvci4NCg0KSSBhbSBub3Qgc2F5aW5nIGZyZWV6
ZSBmdW5jdGlvbmFsaXR5IGhhcyBwcm9ibGVtLiBGcmVlemUgZnVuY3Rpb25hbGl0eSBpcyByZXF1
ZXN0LCByZXNwb25zZSBtZWNoYW5pc20uDQpEcml2ZXIgcmVxdWVzdHMgaXRzLCBkZXZpY2UgdGFr
ZXMgaXQgc3dlZXQgdGltZSBtb3JlIHRoYW4gNTBuc2VjLCB0byBmcmVlemUgbGFyZ2UgZGV2aWNl
LiBSZXNwb25kcyBiYWNrIGluIGEgMW1zZWMgb3Igc29tZSBmaW5pdGUgdGltZSB0aGF0IGZyZWV6
ZSBkb25lLg0KQW5kIGRyaXZlciBjYW4gcHJvZ3Jlc3MgdG8gZnJlZXplIHRoZSBWTS4NCg0KU2Ft
ZSBvbiB1bmZyZWV6ZSwgaXQgY2FuIGJyaW5nIGJhY2sgbGFyZ2UgYW1vdW50IG9mIG1lbW9yeSBm
cm9tIHNvbWUgc2xvdyBtZWRpYS4NClNvIHVuZnJlZXplIHRvIGJlIHJlcXVlc3QtPnJlc3BvbnNl
IGFzIHdlbGwuDQoNCj4gPg0KPiA+DQo+ID4gWW91IG5lZWQgdG8gZGVzY3JpYmUgd2hhdCBleGFj
dGx5IHNob3VsZCBoYXBwZW4gaW4gdGhlIGRldmljZSB3aGVuIGl0cw0KPiBmcmVlemUuDQo+ID4g
UGxlYXNlIHJlZmVyIHRvIG15IHNlcmllcyB3aGVyZSBpbmZyYXN0cnVjdHVyZSBpcyBhZGRlZCBm
b3IgZGV2aWNlIG1pZ3JhdGlvbg0KPiB3aGVyZSB0aGUgRlJFRVpFIG1vZGUgYmVoYXZpb3IgaXMg
ZGVmaW5lZC4NCj4gPiBJdCBpcyBzaW1pbGFyIHRvIHdoYXQgeW91IGRlZmluZSwgYnV0IGl0cyBt
YW5hZ2VtZW50IHBsYW5lIG9wZXJhdGlvbiBjb250cm9sbGVkDQo+IG91dHNpZGUgb2YgdGhlIGd1
ZXN0IFZNLg0KPiA+IEJ1dCBpdCBpcyBnb29kIGRpcmVjdGlvbiBpbiB0ZXJtcyBvZiB3aGF0IHRv
IGRlZmluZSBpbiBzcGVjIGxhbmd1YWdlLg0KPiA+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3Zp
cnRpby1jb21tZW50LzIwMjMwOTA5MTQyOTExLjUyNDQwNy03LXBhcmF2QG4NCj4gPiB2aWRpYS5j
b20vVC8jdQ0KPiBUaGFuayB5b3UgdmVyeSBtdWNoIGZvciB5b3VyIHN1Z2dlc3Rpb24uIEkgd2ls
bCByZWZlciB0byB5b3VyIGxpbmsgYW5kIHRoZW4NCj4gbW9kaWZ5IG15IGRlc2NyaXB0aW9uLg0K
PiANCj4gPg0KPiA+IHlvdSBhcmUgbWlzc2luZyB0aGUgZmVhdHVyZSBiaXQgdG8gaW5kaWNhdGUg
dG8gdGhlIGRyaXZlciB0aGF0IGRldmljZSBzdXBwb3J0cw0KPiB0aGlzIGZ1bmN0aW9uYWxpdHku
DQo+ID4gUGxlYXNlIGFkZCBvbmUuDQo+IERvIEkgbmVlZCB0byBhZGQgZmVhdHVyZSBiaXQgdG8g
REVGSU5FX1ZJUlRJT19DT01NT05fRkVBVFVSRVM/IA0KRXhwbG9yZSBWSVJUSU9fRl9SSU5HX1JF
U0VUIHRvdWNoIHBvaW50cy4NCllvdSBjYW4gYWxzbyBleHBsb3JlIG5ldyBwYXRjaCBbMV0gd2hp
Y2ggYWRkcyBnZW5lcmljIGZlYXR1cmUgYml0IHRvIHVuZGVyc3RhbmQgdGhlIHNwZWMgdG91Y2gg
cG9pbnRzIHdoZXJlIHRvIGFkZCBldGMuDQoNClsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy92
aXJ0aW8tY29tbWVudC8yMDIzMDkxODE3MzUxOC4xNTkwMC0xLXBhcmF2QG52aWRpYS5jb20vVC8j
bTlkZDE4ZDM1MmUzYWMzOGUwZTdjODJhZDlhNjM0ZGI0M2RmYzhiM2INCg0KPiBBbmQNCj4gZWFj
aCB0aW1lIHdoZW4gSSB3cml0ZSBmcmVlemVfbW9kZSBmaWxlZCBvbiBrZXJuZWwgZHJpdmVyIHNp
ZGUsIEkgbmVlZCB0byBjaGVjaw0KPiB0aGlzIGJpdD8NCj4gDQpZZXMuIA0K
