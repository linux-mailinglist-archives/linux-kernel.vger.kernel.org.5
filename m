Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBCF57B9EB2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbjJEOJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbjJEOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:07:26 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on20611.outbound.protection.outlook.com [IPv6:2a01:111:f400:7eaa::611])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97AEC86A9;
        Thu,  5 Oct 2023 01:14:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mBDq/kwUneX/9U5nonvwtzs8QmtokdKP9YNwOqViUy/aKA5Ien6Swe1p2jmSBkP23/sEitWQPGSxfAos0GqQIBRIRLDUbmgTCQ6yG+vXO8M3ZdfMi7Zvmg+TnzRq8+l/OxAPaxcw5p3EOvP/GJ2EOYP4+iHOjA0XE8UD1uZHel6zLZFmDn3nMc5CRoss7bMf+1eAhgj37BVlzjTJfEjHf7kTdJLdNBuLZTt01+Mnt27dW/2Tpu2na+mz3f/0GDa+dxIRWQ0/qvLwJHWfD1go3+Yekyr5LlvC0ABVadkrOKEzSwJ5xU0ePhBP1drgx1/l3wAPZ7QmZbfOI1cAInM3vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HYZxgD9HS0x0iGFoMhRvc+6DH5ppYzD8aLen37lXJ68=;
 b=eJ7xut9U62UHEnEMXOomOkWfyoiFRJZfOB7agRqNUB7uz3eHxc/lR4RpEQctORhGQy53foSETAchIl4cz4KWIddCKoYnrIjCp+BTgYYqsSDhTMccWWll7B71J0jEtSUMvXmSr2vMVeurCYYJzGSpzhhHepJ/CLagl9LD2nkUdPFcOT/XVOpAMt0JTY5GNZjkkOePZe2g5H+aDf8dVrNCsN2HfSsUs6mrVcAOjUb4aQjl6mbYOF3ewQ07pBkCvxXUJcgZYkK71IDnWex9Yi6jUGfftAnzetP5Z8L8bR7gbiGui+gHwBAFqh0wlJY4vKMxlB5wvuT6XByJdh4k5fMibg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HYZxgD9HS0x0iGFoMhRvc+6DH5ppYzD8aLen37lXJ68=;
 b=ErXCrQwOHqlsDhPwLbxhcEJieR5igUObLNxTy6Pr7H0fLIBLHe7MeqOH4+Dn68mAh5K/MWr1sSW7RMzQy4PlAgAXQPKmucsNUJ4c3haZxi23R39PDNc+H7L4JRmV0ln/Ep7mbEr7/f+kYPcxbQVCKbh2R+VXfWeu0/BtW8I+cwC3fiHcALhBJOA3T7ogQwfADGgjokKOavxffBX3uRoQkSCc30NUjN/8g3NOp7thmbKPQKtcEWHsKy2Ni2ezGkTwLx6x04sRorvdUVHMskwrU36aHM2MDW3e4JAslDQGA08egG30S5t3iOHdluEKLoVAGYWcAiizx+5JupK+Fxzn9Q==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by MN6PR12MB8542.namprd12.prod.outlook.com (2603:10b6:208:477::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Thu, 5 Oct
 2023 08:13:58 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::7e45:fc48:aaba:6716]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::7e45:fc48:aaba:6716%7]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 08:13:58 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     =?utf-8?B?SWxwbyBKw6RydmluZW4=?= <ilpo.jarvinen@linux.intel.com>
CC:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Michael Shych <michaelsh@nvidia.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>
Subject: RE: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
Thread-Topic: [PATCH] platform: mellanox: Fix a resource leak in an error
 handling path in mlxplat_probe()
Thread-Index: AQHZ9C9x2SH6czTFHUq9nUWKO4bfRbA3+4GAgAAVesCAAUangIABhdqg
Date:   Thu, 5 Oct 2023 08:13:57 +0000
Message-ID: <BN9PR12MB53815CDEE5CECDAB98B9D28AAFCAA@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <8bd0a7944f0f4f1342333eaf8d92d8e9d5623110.1696141233.git.christophe.jaillet@wanadoo.fr>
 <7d966897-56b5-4a53-3b75-dd90072e17@linux.intel.com>
 <BN9PR12MB53810BC39ADE210092559CADAFC4A@BN9PR12MB5381.namprd12.prod.outlook.com>
 <70165032-796e-6f5c-6748-f514e3b9d08c@linux.intel.com>
In-Reply-To: <70165032-796e-6f5c-6748-f514e3b9d08c@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|MN6PR12MB8542:EE_
x-ms-office365-filtering-correlation-id: 2df17494-5ef9-4c88-3df1-08dbc57b0647
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ldt1gDcm85NpyU6p31cpeLHK8yRL3m+KpRY+lpw9Qqpo0vLAR6RFXmzw0dy0UQh/52NXVmLNghV9lXvdGw9rZxBdDmc+Vqfchh+2vYflvMbrNOPIQxa3tHx0R4N6OI+3Q4nq8lohNiOjfKISeCnplniEhyOlE0ENqcb6L0AXYi+FLviZExpQBDx9qNovJBoeReZ/zAcQSkX6CQ4fZPVHAx6QEdZKr1cf0keJPMYz/U8puHpjkHigyx/zX7Qbe9VUyUIXVYDs7Y4BlDhBviIrNEHqpwooyyXa0neptkb6fGycGR1Nz0BH+3w1k0714Hf9ngFAVpnqiIw/a1UOACEZHvcTgkFKtb6Y09FqTB4rIvLgXb/uQgVdn0eyUGvbUVfJ61YghqoOBAvcU2cKNKqaLnKbKmP5IzZS1UxNmfHQDi+mgm7U611E28IzI9FVIT3lHXE/nJPrb3/iP0Ea+FcjLyLIYqLlomP1wzx+DYglhKz3DDXckDnzgbxWo63zGMYo+5C1AjtWD/jFnmlKb3o/WKvnjr+6bL0kV56ScA6f48V9uqJ4xxDuKAKmU1p53Bqegsis0wOHWa6ywtHGT7+BNvR3B/2+jRHnfwiel4iwXeV9VNwq6ofJr6M6OWBMdNCw
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(346002)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(9686003)(316002)(66476007)(66446008)(76116006)(66556008)(66946007)(6916009)(64756008)(54906003)(8676002)(26005)(8936002)(41300700001)(478600001)(86362001)(83380400001)(66574015)(122000001)(38100700002)(53546011)(7696005)(33656002)(38070700005)(4326008)(71200400001)(6506007)(2906002)(55016003)(5660300002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?b2swM0l1S0lCc1ZVTlExb2hmSHlNeHR3dm5mWW9EQkJsRDhBVXRwOFJ1OTFp?=
 =?utf-8?B?ZSsxOUJrbndSYWRZa2NWaVdoUWVXZzdaUzhLck9SU2FLRlMzVmVKM1dRZVVu?=
 =?utf-8?B?YlE2TGJlZ0JRSDBNaVBiUVZaSDh3MmRibXFnbXlUN2tNbXEwZUJJUmNCRW1y?=
 =?utf-8?B?UVlncXhja0M1NHhTa0RvZHVlMXRSampUTnU3ekQ3YnhySE1uRVo2WVZJdGxV?=
 =?utf-8?B?ZndhdTV5R3duMDNaUzBOYk9NTWRDUExMbXZWOHFzUitNWHNwQUxHQjZBU3Qx?=
 =?utf-8?B?bHdsZ3laTStLeGNHUjZ1NEUwQVl3enNuMys1QmFsMnNudFUwdFRDbDJ1WkJa?=
 =?utf-8?B?MHEvbGhyNUlWSFdtbWxmZFhUOThKb1JLSXlXR0owTllnNWFKRG05UHY0VVJF?=
 =?utf-8?B?Q1pLeStrTTNQZjFwb1BhckNQb1EvVkI3T0RaVEtmZEhFUU9aWmswTEdMVmtO?=
 =?utf-8?B?YVc0S1U2L0JUcDBXQlFNbjQvOHpDN3Y5Q2JBeTU0emFOMHlpemQvdm5NaTMy?=
 =?utf-8?B?ZXh1U2RUVWxoL2VvUTBGTjZxRlJrK29ldHRpOWRhcFZaK1dvK0ZaNTNMUFFw?=
 =?utf-8?B?Um9nZmdYNFBNcmw2SkJ4K0RMUE5YWGJIdHdwMHkwVm9NVWxkWnJMc1ZoVm5G?=
 =?utf-8?B?ZC9LN2tZeE9kazZCWkRyOFFLSklDeXloSUJCcWlmeHQxNlFZOHM1VldybXJX?=
 =?utf-8?B?a2tPYWhaaU9nSWxrOTdiaTJ1NlBOTWZ3NVVtUWZ1NnBVWnFlZlF5VGxrNjVS?=
 =?utf-8?B?MXVmcDBqTzN2cjN5bXJCVVkwTWt0bko1cmk4S3BXZjVsckxPaldrUWNRNGVj?=
 =?utf-8?B?c0VLZUpUQWVWMVJ3WVN5MlFOV0FZd1lUM3YwL2tNaHpnajMydXkzWVZ2MmV6?=
 =?utf-8?B?TVN1NzNjNWlyVEFIdkRZT0RPRHRxbTh0ZWF0enI4NmJ4cGtJNnhhYXVETmw5?=
 =?utf-8?B?T2NONXJTd3dyamFLc1Q0Z2xZbUY0dUxPWEFrbzNCTjRTcEJhRVpVcUFDdmZP?=
 =?utf-8?B?bklPV2s1b2ZCY1c4a2VOaTNKdXRHS0dXMFZTVGpVMVVrcDNPN3MwS1VaRDFK?=
 =?utf-8?B?NXNpUmtJZlY5WS94Zmx0NkZFMi8rV2NRVktnMldQVG1ML3BlODNRcGlVZzJZ?=
 =?utf-8?B?UlA0Z21Ebmk5MFZUVzJrMnU3SUhOQy92cG0zeDhGQ1hlNGh5M3o5cXpseTd6?=
 =?utf-8?B?V2tvbUZnT1FJUkw5Y29weDgrNkI2cTlxb0ZOWHpLTG1lL0lMOERhL1VCSkN6?=
 =?utf-8?B?Yjd1b2xNc0xBWWhieHZMWnliTm5yalNEOUZZTnZlUy96dUdRZFBmLytSeWlu?=
 =?utf-8?B?TkU3T0J6K0pqUHVxTUpQeFkwNDZZS2ZjdHphUEJycm90ZHZqUHl4WGtXVGcx?=
 =?utf-8?B?MDlYSXVyZGg1SHR2V0pxZHY1ZnlXNVBrQW1QaTBjZzl5SzZUYzZCZG1uWUZk?=
 =?utf-8?B?TGxMRHZsMk5iczFVUUMvc0ZwdW8wS2pyUFVqT20vNXFqanZHbDgzYXg3cEhY?=
 =?utf-8?B?UmllVmNzSE9LOHRidW5jY3JHaGlYT2FFbmJMM1NmakYrYm5jNWdXdFh0SDBM?=
 =?utf-8?B?TVVhOU5wcUNzK1NyWFlDNFJwTGlXeWpobHh4MXRaeGdoUXNmblM1ekFBeTAz?=
 =?utf-8?B?bHNPSlR6UFlWOUtrMWZzemlkbFlsSzF5TXduMnlvbHhBbEZUcjRvMUlDWkZ3?=
 =?utf-8?B?VFRCSVo2aytNdXBnTEdSdkZXbG1ZZFdBczl5ZTRyRU9wdyttMTNmczRGYzNH?=
 =?utf-8?B?UzZsWmVrZ2xpTWl6RWI0OFIxYjBXTGJFMHM4Rk52WEpGMHpIdjBncVVodDYr?=
 =?utf-8?B?N3pjQmord3ZwOS8yUTNKNmJxbWtGWTlNbFQxQldlS2xNUU5GbVV3aGl4M08v?=
 =?utf-8?B?cEVyN0dMbUMzZFpvdkt4eVU3YTROY3BVLzMrL0tqeE9Kb2VoaGEzM2xtWGg2?=
 =?utf-8?B?SzdQK2VFYXRUS3FFMEM2OHFpcTRLN1JteStrSDUwem5pRlI1M3QzcWh3TGtr?=
 =?utf-8?B?eThTNjVsQ2k1cnJ2QmVCa1FtcGdtZUpacG5hT2xhOXF0QWI3WnJZWnJFRm5M?=
 =?utf-8?B?LzBYMVNVcHFINmt1M2dISVpGOXRzcEhKMGpnUUpyblZrWXhaUlBPZHhLYWMw?=
 =?utf-8?Q?KUTg=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2df17494-5ef9-4c88-3df1-08dbc57b0647
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Oct 2023 08:13:57.9809
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YfoRzliVEABom/2i9slgMxCVt7HSGAiM/6A5go4QopMYXnvaFxWgcphsqeIUYBu/lmyRf4yTcVDEDFp1I/Z3vA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8542
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSWxwbyBKw6RydmluZW4g
PGlscG8uamFydmluZW5AbGludXguaW50ZWwuY29tPg0KPiBTZW50OiBXZWRuZXNkYXksIDQgT2N0
b2JlciAyMDIzIDExOjUyDQo+IFRvOiBWYWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29t
Pg0KPiBDYzogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3RvcGhlLmphaWxsZXRAd2FuYWRvby5m
cj47IEhhbnMgZGUgR29lZGUNCj4gPGhkZWdvZWRlQHJlZGhhdC5jb20+OyBNYXJrIEdyb3NzIDxt
YXJrZ3Jvc3NAa2VybmVsLm9yZz47IE1pY2hhZWwNCj4gU2h5Y2ggPG1pY2hhZWxzaEBudmlkaWEu
Y29tPjsgTEtNTCA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz47IGtlcm5lbC0NCj4gamFu
aXRvcnNAdmdlci5rZXJuZWwub3JnOyBwbGF0Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSRTogW1BBVENIXSBwbGF0Zm9ybTogbWVsbGFub3g6IEZpeCBhIHJlc291
cmNlIGxlYWsgaW4gYW4gZXJyb3INCj4gaGFuZGxpbmcgcGF0aCBpbiBtbHhwbGF0X3Byb2JlKCkN
Cj4gDQo+IE9uIFR1ZSwgMyBPY3QgMjAyMywgVmFkaW0gUGFzdGVybmFrIHdyb3RlOg0KPiANCj4g
PiBIaSBJbHBvLA0KPiA+IFRoYW5rIHlvdSB2ZXJ5IG11Y2ggZm9yIHJldmlldy4NCj4gPg0KPiA+
ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IElscG8gSsOkcnZpbmVu
IDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gPiA+IFNlbnQ6IFR1ZXNkYXksIDMg
T2N0b2JlciAyMDIzIDE1OjA2DQo+ID4gPiBUbzogQ2hyaXN0b3BoZSBKQUlMTEVUIDxjaHJpc3Rv
cGhlLmphaWxsZXRAd2FuYWRvby5mcj4NCj4gPiA+IENjOiBWYWRpbSBQYXN0ZXJuYWsgPHZhZGlt
cEBudmlkaWEuY29tPjsgSGFucyBkZSBHb2VkZQ0KPiA+ID4gPGhkZWdvZWRlQHJlZGhhdC5jb20+
OyBNYXJrIEdyb3NzIDxtYXJrZ3Jvc3NAa2VybmVsLm9yZz47IE1pY2hhZWwNCj4gPiA+IFNoeWNo
IDxtaWNoYWVsc2hAbnZpZGlhLmNvbT47IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+Ow0KPiA+ID4ga2VybmVsLSBqYW5pdG9yc0B2Z2VyLmtlcm5lbC5vcmc7DQo+ID4gPiBwbGF0
Zm9ybS1kcml2ZXIteDg2QHZnZXIua2VybmVsLm9yZw0KPiA+ID4gU3ViamVjdDogUmU6IFtQQVRD
SF0gcGxhdGZvcm06IG1lbGxhbm94OiBGaXggYSByZXNvdXJjZSBsZWFrIGluIGFuDQo+ID4gPiBl
cnJvciBoYW5kbGluZyBwYXRoIGluIG1seHBsYXRfcHJvYmUoKQ0KPiA+ID4NCj4gPiA+IE9uIFN1
biwgMSBPY3QgMjAyMywgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiA+ID4NCj4gPiA+ID4g
SWYgYW4gZXJyb3Igb2NjdXJzIGFmdGVyIGEgc3VjY2Vzc2Z1bCBtbHhwbGF0X2kyY19tYWluX2lu
aXQoKSwNCj4gPiA+ID4gbWx4cGxhdF9pMmNfbWFpbl9leGl0KCkgc2hvdWxkIGJlIGNhbGxlZCB0
byBmcmVlIHNvbWUgcmVzb3VyY2VzLg0KPiA+ID4gPg0KPiA+ID4gPiBBZGQgdGhlIG1pc3Npbmcg
Y2FsbCwgYXMgYWxyZWFkeSBkb25lIGluIHRoZSByZW1vdmUgZnVuY3Rpb24uDQo+ID4gPiA+DQo+
ID4gPiA+IEZpeGVzOiAxNThjZDgzMjA3NzYgKCJwbGF0Zm9ybTogbWVsbGFub3g6IFNwbGl0IGxv
Z2ljIGluIGluaXQgYW5kDQo+ID4gPiA+IGV4aXQNCj4gPiA+ID4gZmxvdyIpDQo+ID4gPiA+IFNp
Z25lZC1vZmYtYnk6IENocmlzdG9waGUgSkFJTExFVCA8Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFk
b28uZnI+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiBUaGlzIHBhdGNoIGlzIGJhc2VkIG9uIGNvbXBh
cmlzb24gYmV0d2VlbiBmdW5jdGlvbnMgY2FsbGVkIGluIHRoZQ0KPiA+ID4gPiByZW1vdmUgZnVu
Y3Rpb24gYW5kIHRoZSBlcnJvciBoYW5kbGluZyBwYXRoIG9mIHRoZSBwcm9iZS4NCj4gPiA+ID4N
Cj4gPiA+ID4gRm9yIHNvbWUgcmVhc29uLCB0aGUgd2F5IHRoZSBjb2RlIGlzIHdyaXR0ZW4gYW5k
IGZ1bmN0aW9uIG5hbWVzDQo+ID4gPiA+IGFyZSBwdXp6bGluZyB0byBtZS4NCj4gPiA+DQo+ID4g
PiBJbmRlZWQsIHByZS9wb3N0IGFyZSBtaXhlZCB1cCBmb3IgaW5pdC9leGl0IHZhcmlhbnRzIHdo
aWNoIG1ha2VzDQo+ID4gPiBldmVyeXRoaW5nIHZlcnkgY29uZnVzaW5nIGFuZCB0aGUgY2FsbCB0
byBtbHhwbGF0X3Bvc3RfaW5pdCgpIGlzDQo+ID4gPiBidXJpZWQgZGVlcCBpbnRvIHRoZSBjYWxs
IGNoYWluLg0KPiA+ID4NCj4gPiA+IFRoZXNlIHdvdWxkIHNlZW0gYmV0dGVyIG5hbWVzIGZvciB0
aGUgaW5pdC9kZWluaXQgd2l0aCBwcm9wZXIgcGFpcmluZzoNCj4gPiA+DQo+ID4gPiAtIC4uLl9s
b2dpY2Rldl9pbml0L2RlaW5pdCBmb3IgRlBHQS9DUExEIGluaXQuDQo+ID4gPiAtIC4uLl9tYWlu
YnVzX2luaXQvZGVpbml0DQo+ID4gPiAtIHBlcmhhcHMgdGhlIHJlc3QgY291bGQgYmUganVzdCAu
Li5fcGxhdGRldnNfcmVnL3VucmVnDQo+ID4gPg0KPiA+ID4gVGhvc2UgYWxvbmUgd291bGQgbWFr
ZSBpdCBtdWNoIGVhc2llciB0byBmb2xsb3cuDQo+ID4gPg0KPiA+ID4gSW4gYWRkaXRpb24sDQo+
ID4gPiAtIG1seHBsYXRfaTJjX211eF9jb21wbGl0aW9uX25vdGlmeSgpIGxvb2tzIGp1c3QgdXNl
bGVzcyBjYWxsIGNoYWluIGxldmVsDQo+ID4gPiAgIGFuZCBzaG91bGQgYmUgcmVtb3ZlZCAoaXQg
YWxzbyBoYXMgYSB0eXBvIGluIGl0cyBuYW1lKS4NCj4gPiA+IC0gTWF5YmUgLi4uX3BsYXRkZXZf
cmVnKCkgKGN1cnJlbnRseSBtbHhwbGF0X3Bvc3RfaW5pdCgpKSBzaG91bGQgYmUgY2FsbGVkDQo+
ID4gPiAgIGRpcmVjdGx5IGZyb20gbWFpbmJ1c19pbml0KCkgb3IgZXZlbiBmcm9tIC5wcm9iZSgp
IGFuZCBub3QgZnJvbSB0aGUNCj4gPiA+ICAgbXV4IHRvcG8gaW5pdC4NCj4gPiA+DQo+ID4gPiA+
IFNvIFJldmlldyB3aXRoIGNhcmUhDQo+ID4gPg0KPiA+ID4gSXQgZG9lcyBub3QgbG9vayBjb21w
bGV0ZSBhcyBhbHNvIG1seHBsYXRfaTJjX21haW5faW5pdCgpIGxhY2tzDQo+ID4gPiByb2xsYmFj
ayBpdCBzaG91bGQgZG8gaXQgbWx4cGxhdF9pMmNfbXV4X3RvcG9sb2d5X2luaXQoKSBmYWlsZWQu
DQo+ID4gPg0KPiA+ID4gU2luY2UgY3VycmVudGx5IG1seHBsYXRfaTJjX21haW5faW5pdCgpIGlz
IHdoYXQgdWx0aW1hdGVseSBjYWxscw0KPiA+ID4gbWx4cGxhdF9wb3N0X2luaXQoKSBkZWVwIGRv
d24gaW4gdGhlIGNhbGwgY2hhaW4gKHVubGVzcyB0aGUgY2FsbCB0bw0KPiA+ID4gaXQgZ2V0cyBt
b3ZlZCBvdXQgZnJvbSB0aGVyZSksIGl0IHdvdWxkIGJlIGFwcHJvcHJpYXRlIGZvcg0KPiA+ID4g
bWx4cGxhdF9pMmNfbWFpbl9leGl0KCkgdG8gZG8vY2FsbCB0aGUgY2xlYW51cC4gIEFuZCBuZWl0
aGVyDQo+ID4gPiAucHJvYmUoKSBub3INCj4gPiA+IC5yZW1vdmUoKSBzaG91bGQgY2FsbCBtbHhw
bGF0X3ByZV9leGl0KCkgZGlyZWN0bHkgaW4gdGhhdCBjYXNlLg0KPiA+ID4NCj4gPiA+IFNvIHR3
byBhbHRlcm5hdGl2ZSB3YXlzIGZvcndhcmQgZm9yIHRoZSBmaXggYmVmb3JlIGFsbCB0aGUgcmVu
YW1pbmc6DQo+ID4gPg0KPiA+ID4gMSkgTW92ZSBtbHhwbGF0X3Bvc3RfaW5pdCgpIGNhbGwgb3V0
IG9mIGl0cyBjdXJyZW50IHBsYWNlIGludG8gLnByb2JlKCkNCj4gPiA+ICAgIGFuZCBtYWtlIHRo
ZSByb2xsYmFjayBwYXRoIHRoZXJlIHRvIG1hdGNoIHRoYXQuDQo+ID4gPiAyKSBEbyBjbGVhbnVw
IHByb3Blcmx5IGluIG1seHBsYXRfaTJjX21haW5faW5pdCgpIGFuZA0KPiA+ID4gICAgbWx4cGxh
dF9pMmNfbWFpbl9leGl0KCkuDQo+ID4gPg0KPiA+ID4gSSdkIHByZWZlciAxKSBiZWNhdXNlIGl0
J3MgbXVjaCBzaW1wbGVyIHRvIGZvbGxvdyB0aGUgaW5pdCBsb2dpYw0KPiA+ID4gd2hlbiB0aGUg
aW5pdCBjb21wb25lbnRzIGFyZSBub3QgaGlkZGVuIGRlZXAgaW50byB0aGUgY2FsbCBjaGFpbi4N
Cj4gPiA+DQo+ID4NCj4gPiBJIHdvdWxkIHByZWZlciB0byBrZWVwIG1seHBsYXRfaTJjX211eF9j
b21wbGl0aW9uX25vdGlmeSgpIGFzIHNlcGFyYXRlDQo+ID4gZnVuY3Rpb24uIEkgYW0gZ29pbmcg
dG8gdXNlIGl0IGFzIGEgY2FsbGJhY2suDQo+IA0KPiBJdCdzIG9rYXkgZm9yIGl0IHRvIHJlbWFp
biBhcyBsb25nIGFzIHRoZSBpbml0L2RlaW5pdCBwYWlycyBwcm9wZXJseSBpbiB0aGUgZW5kLg0K
PiANCj4gPiBJIHN1Z2dlc3QgSSdsbCBwcmVwYXJlIHRoZSBuZXh0IHBhdGNoZXM6DQo+ID4NCj4g
PiAxLg0KPiA+IEFzIGEgYnVnZml4LCBmaXggcHJvdmlkZWQgYnkgQ2hyaXN0b3BoZSBhbmQgYWRk
aXRpb25hbCBjbGVhbnVwIGluDQo+ID4gbWx4cGxhdF9pMmNfbWFpbl9pbml0KCk6DQo+ID4NCj4g
PiBAQCAtNjUxNCw2ICs2NTE0LDEwIEBAIHN0YXRpYyBpbnQgbWx4cGxhdF9pMmNfbWFpbl9pbml0
KHN0cnVjdA0KPiBtbHhwbGF0X3ByaXYgKnByaXYpDQo+ID4gICAgICAgICByZXR1cm4gMDsNCj4g
Pg0KPiA+ICBmYWlsX21seHBsYXRfaTJjX211eF90b3BvbG9neV9pbml0Og0KPiA+ICsgICAgICAg
aWYgKHByaXYtPnBkZXZfaTJjKSB7DQo+ID4gKyAgICAgICAgICAgICAgIHBsYXRmb3JtX2Rldmlj
ZV91bnJlZ2lzdGVyKHByaXYtPnBkZXZfaTJjKTsNCj4gPiArICAgICAgICAgICAgICAgcHJpdi0+
cGRldl9pMmMgPSBOVUxMOw0KPiA+ICsgICAgICAgfQ0KPiA+ICBmYWlsX3BsYXRmb3JtX2kyY19y
ZWdpc3RlcjoNCj4gPiAgZmFpbF9tbHhwbGF0X21seGNwbGRfdmVyaWZ5X2J1c190b3BvbG9neToN
Cj4gPiAgICAgICAgIHJldHVybiBlcnI7DQo+ID4gQEAgLTY1OTgsNiArNjYwMiw3IEBAIHN0YXRp
YyBpbnQgbWx4cGxhdF9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ID4gKnBkZXYpDQo+
ID4gIGZhaWxfcmVnaXN0ZXJfcmVib290X25vdGlmaWVyOg0KPiA+ICBmYWlsX3JlZ2NhY2hlX3N5
bmM6DQo+ID4gICAgICAgICBtbHhwbGF0X3ByZV9leGl0KHByaXYpOw0KPiA+ICsgICAgICAgbWx4
cGxhdF9pMmNfbWFpbl9leGl0KHByaXYpOw0KPiA+ICBmYWlsX21seHBsYXRfaTJjX21haW5faW5p
dDoNCj4gPiAgZmFpbF9yZWdtYXBfd3JpdGU6DQo+ID4NCj4gPiAyLg0KPiA+IE1vdmUgbWx4cGxh
dF9wcmVfZXhpdCgpIGluc2lkZSBtbHhwbGF0X2kyY19tYWluX2V4aXQoKQ0KPiANCj4gVGhpcyBj
YW4gYmUgYW5kIHNob3VsZCBiZSBjb21iaW5lZCB3aXRoIHN0ZXAgMSAod2hlcmUgLnByb2JlKCkn
cyByb2xsYmFjaw0KPiBhbmQgLnJlbW92ZSgpIHdvdWxkIGNhbGwgaXQgYW5kIG5vdCBtbHhwbGF0
X3ByZV9leGl0KCkgYXQgYWxsKS4gSXQgYWxyZWFkeSBtYWtlcw0KPiB0aGUgcGFpcmluZyBva2F5
IG9uIHRoZSBsb2dpYyBsZXZlbCBzbyBvbmx5IG5hbWUgcGFpcmluZyBuZWVkcyB0byBiZSBkb25l
IGFmdGVyDQo+IHRoYXQuDQo+IA0KPiBZb3UgY2FuIGRvIHNlcGFyYXRlIHBhdGNoIGJvdGggd2l0
aCBGaXhlcyB0YWdzIHNpbmNlIHRoZXNlIGFyZSBraW5kYQ0KPiBpbmRlcGVuZGVudCBpc3N1ZXMu
DQo+IA0KPiBUaGVzZSAxKzIgYXJlIHdoYXQgSSBzdWdnZXN0ZWQgaW4gMikuDQo+IA0KPiA+IDMu
DQo+ID4gRml4IG9mICcgY29tcGxpdGlvbicgbWlzc3BlbGxpbmc6DQo+ID4gcy9tbHhwbGF0X2ky
Y19tYWluX2NvbXBsaXRpb25fbm90aWZ5Lw0KPiA+IG1seHBsYXRfaTJjX21haW5fY29tcGxldGlv
bl9ub3RpZnkNCj4gPg0KPiA+IDQuDQo+ID4NCj4gPiBSZW5hbWluZzoNCj4gPiBtbHhwbGF0X3By
ZV9pbml0KCkvbWx4cGxhdF9wb3N0X2V4aXQoKSB0bw0KPiA+IAltbHhwbGF0X2xvZ2ljZGV2X2lu
aXQoKS9tbHhwbGF0X2xvZ2ljZGV2X2V4aXQoKQ0KPiA+DQo+ID4gbWx4cGxhdF9pMmNfbWFpbl9p
bml0KCkvbWx4cGxhdF9pMmNfbWFpbl9leGl0KCkga2VlcCBhcyBpcy4NCj4gPg0KPiA+IG1seHBs
YXRfcG9zdF9pbml0KCkvbWx4cGxhdF9wcmVfZXhpdCgpIHRvDQo+ID4gCW1seHBsYXRfcGxhdGRl
dnNfaW5pdCgpL21seHBsYXRfcGxhdGRldnNfZXhpdCgpDQo+ID4NCj4gPiBXaGF0IGRvIHlvdSB0
aGluaz8NCj4gDQo+IFllcyB0byAzICYgNC4NCg0KSGkgSWxwbywNCg0KVGhhbmsgeW91IHZlcnkg
bXVjaCBmb3IgeW91ciBpbnB1dHMuDQoNCkkgc2VudCBvbmUgYnVnZml4IGFuZCB0d28gYW1lbmRt
ZW50IHBhdGNoZXMuDQoNCkkganVzdCB3YW50ZWQgdG8gbm90ZSwgdGhhdCBpbiBjYXNlIG9mIHNv
bWUgY29tbWVudHMgZm9yIHRoZXNlDQpwYXRjaGVzLCBJJ2xsIGJlIGFibGUgdG8gbWFrZSBtb2Rp
ZmljYXRpb25zIG9ubHkgYWZ0ZXIgMTUgT2N0b2Jlci4NCg0KVGhhbmtzLA0KVmFkaW0uDQoNCj4g
DQo+IA0KPiAtLQ0KPiAgaS4NCg==
