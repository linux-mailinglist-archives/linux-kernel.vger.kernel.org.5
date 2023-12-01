Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 101E4801484
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:35:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379524AbjLAUfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLAUe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:34:59 -0500
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2050.outbound.protection.outlook.com [40.107.102.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE15FF1;
        Fri,  1 Dec 2023 12:35:02 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iYAbepkwW+m7DxWU06grg+ykiqnQke4C80KVDILUaXK5rNmNRl1tMPJM1k/doz+7r6A5TT4OYFBLYaz6Nz0YvzPgNAB7oVp6Llp+e6LBi6gMnNloqRexNlAx9pB8hs4Z9GEEM9zUoOYeDT/FadJuQvv3A3eqDC93wxDsallL+D1vzgD6ByUBamykI5mXsxXjYELhTCbWa6U3qk0rvOk4/7XP0eXn95uWJ24MuhNZOSUA26qUuZZQMi5yQQSiY0Xnf50v7+3mdndsWsoFCnPPfS295Vt9w0bqPU1gTaCdPRFrVIgeD7mXZqiGKoyCYc7pX61Jo2ijVS6yYxnFeBK5vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+TWETa/xWs8hT4QKx8R6D9YOK//DGkoQ4jPw5YuOjts=;
 b=GQUELKvSMbmUYpaXBpt70B8N1OHYQMU9TAD6ZPY0kFmW2llpYubhf6SlMThbSgKK11VvJ3mAsaMCDuV9DcUZT3yqzjDQ4KXRe3aAMHL2gNUNZv4dnZvQIptjFvNin9nl0QHuZjmYd889hZW4eTc0K+LTgEPEscLFF1Roi7l6Hf4zvOVJDF8xRKx89kQy6HKiJcFbRh/iYH7b8NvkfZEHl+b01Pa9VqNmXyjc0Z9r0VC2rfip7kORxiBOaaFTEDLbc1EebiRvHo6Xxk9oV4bC5iVztX3mZS1t+cjOPOf/cbKbITEFYpo+6/qXZUpntmC/DlspJMoKqSXnWM2oJ2kydQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+TWETa/xWs8hT4QKx8R6D9YOK//DGkoQ4jPw5YuOjts=;
 b=DwshIScMiVN+SsNDIVNF0ISpkcSF/L28FTlDFJcDU/Wv4pda0C1VIZilS4VtUogCXZ3jIOkyWwJm9CIGg9wqdgWCDMV3/o13e901CuhRLgK8k9TgVxEnR9FTpinzLAxeE+0KYyI90FJ7CyZ56Z8Lp/Ve0c8COi5TfxC2YDsl02MEGF+dFwB70oVFdGS1WnOeNz3ue6n66OzDZyjdrl5T9l1LtBYZOknQNwSC5Javaz5xMbjpH0Sxz8JArIaAGRZ97jNqXzQEq2Oh6nQm/Yr656Jm8Utz41dP2g9gSxvCRkUe0fQ+cGAD+XB3gjll85ea4J0EFwEP16vLPzt3Y2luiA==
Received: from BN9PR12MB5381.namprd12.prod.outlook.com (2603:10b6:408:102::24)
 by DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7046.27; Fri, 1 Dec 2023 20:35:00 +0000
Received: from BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb]) by BN9PR12MB5381.namprd12.prod.outlook.com
 ([fe80::a02:fa08:8729:c1bb%4]) with mapi id 15.20.7046.027; Fri, 1 Dec 2023
 20:35:00 +0000
From:   Vadim Pasternak <vadimp@nvidia.com>
To:     Kunwu Chan <chentao@kylinos.cn>,
        "hdegoede@redhat.com" <hdegoede@redhat.com>,
        "ilpo.jarvinen@linux.intel.com" <ilpo.jarvinen@linux.intel.com>,
        "jdelvare@suse.com" <jdelvare@suse.com>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        Shravan Ramani <shravankr@nvidia.com>,
        "jiri@resnulli.us" <jiri@resnulli.us>
CC:     "kunwu.chan@hotmail.com" <kunwu.chan@hotmail.com>,
        "platform-driver-x86@vger.kernel.org" 
        <platform-driver-x86@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>
Subject: RE: [PATCH v2] platform/mellanox: Add some null/error pointer checks
 to mlxbf-pmc.c
Thread-Topic: [PATCH v2] platform/mellanox: Add some null/error pointer checks
 to mlxbf-pmc.c
Thread-Index: AQHaJBsBarANaY4i8kSOk7A1nYaPgbCU41nw
Date:   Fri, 1 Dec 2023 20:35:00 +0000
Message-ID: <BN9PR12MB5381B3408452445483B7281EAF81A@BN9PR12MB5381.namprd12.prod.outlook.com>
References: <20231201055447.2356001-1-chentao@kylinos.cn>
In-Reply-To: <20231201055447.2356001-1-chentao@kylinos.cn>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN9PR12MB5381:EE_|DM3PR12MB9416:EE_
x-ms-office365-filtering-correlation-id: c73b2754-de7b-48c1-2984-08dbf2acfd4b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y+znFwoDhGXpYoALFETi80ePvVRoqBJnM+1qjVe4bhlrIrCrAtXYsB3VOizmOJpejCOWfWMWVfN3dOJxbT4v4aATjOG8RYrG1oYcjBoy4CqUoZfuMBM7QDCaTi4b1+4xHVxwurgO+LUdDCZ32WzIQxvikV7mI+Ov62Lxc/wFgSwT/yoV1wKjxaUwhHObFOq+mpcDDXtRCevru9qGaHvWkB03N2vIojlHSxQcoa5XSS5XYPeYv8JwnBw5GrsS1fVv1WcsMFXaZF2ZpVluRoDMg1pXjiC2LvwZPGfPtkrVR7twfBnPVDN2nlV5VMNEe8/g/P/jy2R+ZemSX3dCWtrC5Kf4Rk0uNn6GCwd3ReftHGANY1ggdagpmq+jGFnSPBuxHaS7sTsHNwKr3U5AgKp+sFtqJWmKuEjcr7HR6+GC/V02HUIohKxoa2pD/JUI0SFRCpnRqapo2UKIRi9bkUoV2QVChusbkUZEckDUyX1deMRfLnpyZlIlWI3tu46zzyVaTqy2ZAZP+NGFEG3wWzVcmPe9jjVYz1DZKOjwhwe0ymWlPbu94Lbee/VillSN+9kr+EfbzqPX5Jg5+KofXNjQPU+aX0kom+uZfGIC94nPEFHQHQ2GAKWij5d91j9Jch55
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN9PR12MB5381.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(396003)(39860400002)(366004)(136003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(38070700009)(86362001)(33656002)(55016003)(122000001)(7696005)(66476007)(53546011)(9686003)(110136005)(66556008)(66446008)(76116006)(6506007)(66946007)(66574015)(38100700002)(26005)(83380400001)(71200400001)(8676002)(8936002)(2906002)(41300700001)(54906003)(478600001)(45080400002)(64756008)(4326008)(5660300002)(7416002)(316002)(52536014);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmRiZ1NJVkpxOFdzMFlwN2c0Z243bFl5UXRHd1pFckZMZVlRWHcrR1JFa1BK?=
 =?utf-8?B?K3lERGdtRlJDUTFvSW1IYmg0L0d1RzNITHBoWWpyS1RrNERMQWFiY1E5UGl4?=
 =?utf-8?B?cmlCdGEzRVQ0Q0I2L2tZRENJcC9GTUw5UXJ2NU1nbURVcllsZmEvMTBIcUlk?=
 =?utf-8?B?dkZIWWhPTmFqWjg5RVZNWEh1NWRFK3pMd3hjU29ObThhYzFqenpHcTdxRkFy?=
 =?utf-8?B?d3VQbkZNZGw0dmJlYnpmV21aNEVESEsybk1vWGQ4Tk02U2hVeHAxQ2hTQ2s2?=
 =?utf-8?B?dGRBK2FDVUIrTENMK2txNVNtdWRuL2JRZ3lOalV0WmMzSU9nSEJVclJyZW5w?=
 =?utf-8?B?SEx3RVVlaXNLdGU1RkVBMExWbHorNFBzN05SQndBdFFPWkZSSTNOMUJ3RVVT?=
 =?utf-8?B?eXF0aXYvaUFsT09SQUcrUDBYdWVmMkVnRFp0c0oxNVZwZXI5blhUQXNtWUVj?=
 =?utf-8?B?TVJoV3FuTFdkVlBZSHp4R1FOcXVMc0ZIaXZkVCtCS0RDazJpY2RwMkZrZFhk?=
 =?utf-8?B?bEQzYjY0RnZhZXJBR1FjSktZRWlXMGRzY2NaNm9UR3prUkpURUdPbkxBQi8y?=
 =?utf-8?B?THhJc3g1eWdwNUxBT3FmcGtBT3FiRmxYZlRJV1lydVg0bGVHZU5nMDNXRUF2?=
 =?utf-8?B?M0Zna1pWUXZ5ZjlxTEVoUzVvM3M4Q1ZvM0ErZEpDWDU4OGNzRnc3RVVMN1kz?=
 =?utf-8?B?TUtQMTJQQ3ZlcGJQRzl4a0hTMHB2cGx5K09OZ1VWODlTekNIbWZHR1RtNVRn?=
 =?utf-8?B?SHBRNE56bVM2TGhqYi95QkQ0WDBNb0JKVEJxdlZJRjBUZWk3U1NWQS9sS21C?=
 =?utf-8?B?aGFnaEZYUmxjQjFoTGNBZUJKRjZCNnVUWXpHVktGMTFNN2hzNGtDRmFLeW1W?=
 =?utf-8?B?UUJndDZyWG42RkxQNG53SnBQdmE2anpobTE1Zm1sVVRicEVEUlRCd2NlbU1E?=
 =?utf-8?B?dUIvQVo2dThyaFBHUEhkYjVmbU9yVTFVaUVkazZoQlFML3ZZRFpOK1pDcElY?=
 =?utf-8?B?Z1FNb1p6SHNzb1AyTVpST1VnU2MycDhzNTljQTdweHU4Y0QyblZDdVpWTUFR?=
 =?utf-8?B?ektoSmd0NEs2OEpvdWdvVDVKV3ZjRzdza2s5TXZFRXllbnpjS25kODdOSHZQ?=
 =?utf-8?B?T1QxbDBYMmU4am5saVZHYVJTQnZuTWZlcXY4WU1ZZ2RyVkQxVWdmU3MvMURQ?=
 =?utf-8?B?VldiUVNlZU9jVEVIYjI0b2RvTVI0UUJFYjloenRtVzJmM3hBeXRieXVsODFq?=
 =?utf-8?B?bjNjYnFIV3VUajBjYk9vOW1SQ2NmbE5ETnZPWUk4RExwOENTUXFkWkZjNkpZ?=
 =?utf-8?B?L1ZYNncycUxwWURIMFNEOHlxSkZJUEdkR0xGU1RlZzFZNk9VazNRTnlWUjBo?=
 =?utf-8?B?cmtHRmtHRlVjNDNwdnFCeERiVk1RUE0yVmlicGpHeUxTRWdmWE1DZXZSWWxr?=
 =?utf-8?B?U0FWN2EyY29ibFVCZGJEZjU5ellwQ3lyUmJiVTZZYUp2RlRYSUdBN2tFZkw2?=
 =?utf-8?B?K2hWbi91ZGt2cFFTc1VNRUcxSXJQTmNlTms4YVo5ZGxJcm5LaXJrdlFtVHhu?=
 =?utf-8?B?ZHlrWUN5K2FPVm1TRy80Skd3SC95MXlwSGJzSVJrV1RGa1QwOHlqQ3E1dkQz?=
 =?utf-8?B?a2ZiOVZYNmM2SjhEZEpVa3Y1VDRCcndvdHRNOEtvd25Cc3RaeEtlWE8yYm9i?=
 =?utf-8?B?L1BnTG5JNGJiQVBtdVQrKys1bGpIc3JxOU1Mc2dSeU9leWdCMDVON29BVnFh?=
 =?utf-8?B?Vmdnc0hkaUhJanY5ekUxOENCNUlSZW1MdW9kanNyUkpuclloRjRFTm1YMW1S?=
 =?utf-8?B?REhtNHRwbVNQWWFVK1JHcWZBWlgxaFY4bHlKOXdhanZCUklxYVMwWlpYZUgx?=
 =?utf-8?B?RCsyZU9iUFlqZml0aVJUZ1MzVTV5ZlhTSjdPU25wRFhxb0k5dWlqUGNLSmM2?=
 =?utf-8?B?N0tQaDFPQkZjZkROcGowSTIxYXRsSGt1UXp1VlpodjVXNWNMeXpCakxKL3hU?=
 =?utf-8?B?UUlHZUMwUGE5RC9WUzlLeURtN2s1Y0l2dFh4ZU1aNGpWQ3VuU1plT3pGUHY4?=
 =?utf-8?B?UWZKeUc1dlkzTndiZFpoQmJEcVJ2bkg3MVUrMzFkaXdGWms3TUx5SWpaS2k3?=
 =?utf-8?Q?nlIM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN9PR12MB5381.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c73b2754-de7b-48c1-2984-08dbf2acfd4b
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Dec 2023 20:35:00.0664
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mCHIjLJAfOjKB9eNHSbQ0HKx00aOA9PnHHSQaMCkKaS0tNDGNvu1qQPq/lLYkmqknagbQ6Kvg8Bnsp0sK6Vtwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR12MB9416
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogS3Vud3UgQ2hhbiA8Y2hl
bnRhb0BreWxpbm9zLmNuPg0KPiBTZW50OiBGcmlkYXksIDEgRGVjZW1iZXIgMjAyMyA3OjU1DQo+
IFRvOiBoZGVnb2VkZUByZWRoYXQuY29tOyBpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbTsg
VmFkaW0gUGFzdGVybmFrDQo+IDx2YWRpbXBAbnZpZGlhLmNvbT47IGpkZWx2YXJlQHN1c2UuY29t
OyBsaW51eEByb2Vjay11cy5uZXQ7IFNocmF2YW4NCj4gUmFtYW5pIDxzaHJhdmFua3JAbnZpZGlh
LmNvbT47IGppcmlAcmVzbnVsbGkudXMNCj4gQ2M6IGt1bnd1LmNoYW5AaG90bWFpbC5jb207IHBs
YXRmb3JtLWRyaXZlci14ODZAdmdlci5rZXJuZWwub3JnOyBsaW51eC0NCj4ga2VybmVsQHZnZXIu
a2VybmVsLm9yZzsgbGludXgtaHdtb25Admdlci5rZXJuZWwub3JnOyBLdW53dSBDaGFuDQo+IDxj
aGVudGFvQGt5bGlub3MuY24+DQo+IFN1YmplY3Q6IFtQQVRDSCB2Ml0gcGxhdGZvcm0vbWVsbGFu
b3g6IEFkZCBzb21lIG51bGwvZXJyb3IgcG9pbnRlciBjaGVja3MgdG8NCj4gbWx4YmYtcG1jLmMN
Cj4gDQo+IGRldm1fa2FzcHJpbnRmKCkgcmV0dXJucyBhIHBvaW50ZXIgdG8gZHluYW1pY2FsbHkg
YWxsb2NhdGVkIG1lbW9yeSB3aGljaA0KPiBjYW4gYmUgTlVMTCB1cG9uIGZhaWx1cmUuDQo+IGRl
dm1faHdtb25fZGV2aWNlX3JlZ2lzdGVyX3dpdGhfZ3JvdXBzIHJldHVybiBhIGVycm9yIHBvaW50
ZXIgdXBvbg0KPiBmYWlsdXJlLg0KPiANCj4gQ29tcGlsZS10ZXN0ZWQgb25seS4NCj4gDQo+IEZp
eGVzOiAxYTIxOGQzMTJlNjUgKCJwbGF0Zm9ybS9tZWxsYW5veDogbWx4YmYtcG1jOiBBZGQgTWVs
bGFub3gNCj4gQmx1ZUZpZWxkIFBNQyBkcml2ZXIiKQ0KPiBTdWdnZXN0ZWQtYnk6IElscG8gSsOk
cnZpbmVuIDxpbHBvLmphcnZpbmVuQGxpbnV4LmludGVsLmNvbT4NCj4gU3VnZ2VzdGVkLWJ5OiBW
YWRpbSBQYXN0ZXJuYWsgPHZhZGltcEBudmlkaWEuY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBLdW53
dSBDaGFuIDxjaGVudGFvQGt5bGlub3MuY24+DQoNClJldmlld2VkLWJ5OiBWYWRpbSBQYXN0ZXJu
YWsgPHZhZGltcEBudmlkaWEuY29tPg0KDQo+IC0tLQ0KPiAgZHJpdmVycy9wbGF0Zm9ybS9tZWxs
YW5veC9tbHhiZi1wbWMuYyB8IDE0ICsrKysrKysrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MTQgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGxhdGZvcm0vbWVs
bGFub3gvbWx4YmYtcG1jLmMNCj4gYi9kcml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXBt
Yy5jDQo+IGluZGV4IDBiNDI3ZmMyNGE5Ni4uMWRkODRjN2E3OWRlIDEwMDY0NA0KPiAtLS0gYS9k
cml2ZXJzL3BsYXRmb3JtL21lbGxhbm94L21seGJmLXBtYy5jDQo+ICsrKyBiL2RyaXZlcnMvcGxh
dGZvcm0vbWVsbGFub3gvbWx4YmYtcG1jLmMNCj4gQEAgLTE3NzEsNiArMTc3MSw4IEBAIHN0YXRp
YyBpbnQgbWx4YmZfcG1jX2luaXRfcGVyZnR5cGVfY291bnRlcihzdHJ1Y3QNCj4gZGV2aWNlICpk
ZXYsIGludCBibGtfbnVtKQ0KPiAgCWF0dHItPmRldl9hdHRyLnNob3cgPSBtbHhiZl9wbWNfZXZl
bnRfbGlzdF9zaG93Ow0KPiAgCWF0dHItPm5yID0gYmxrX251bTsNCj4gIAlhdHRyLT5kZXZfYXR0
ci5hdHRyLm5hbWUgPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9LRVJORUwsDQo+ICJldmVudF9s
aXN0Iik7DQo+ICsJaWYgKCFhdHRyLT5kZXZfYXR0ci5hdHRyLm5hbWUpDQo+ICsJCXJldHVybiAt
RU5PTUVNOw0KPiAgCXBtYy0+YmxvY2tbYmxrX251bV0uYmxvY2tfYXR0cltpXSA9ICZhdHRyLT5k
ZXZfYXR0ci5hdHRyOw0KPiAgCWF0dHIgPSBOVUxMOw0KPiANCj4gQEAgLTE3ODQsNiArMTc4Niw4
IEBAIHN0YXRpYyBpbnQgbWx4YmZfcG1jX2luaXRfcGVyZnR5cGVfY291bnRlcihzdHJ1Y3QNCj4g
ZGV2aWNlICpkZXYsIGludCBibGtfbnVtKQ0KPiAgCQlhdHRyLT5uciA9IGJsa19udW07DQo+ICAJ
CWF0dHItPmRldl9hdHRyLmF0dHIubmFtZSA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5F
TCwNCj4gIAkJCQkJCQkgICJlbmFibGUiKTsNCj4gKwkJaWYgKCFhdHRyLT5kZXZfYXR0ci5hdHRy
Lm5hbWUpDQo+ICsJCQlyZXR1cm4gLUVOT01FTTsNCj4gIAkJcG1jLT5ibG9ja1tibGtfbnVtXS5i
bG9ja19hdHRyWysraV0gPSAmYXR0ci0+ZGV2X2F0dHIuYXR0cjsNCj4gIAkJYXR0ciA9IE5VTEw7
DQo+ICAJfQ0KPiBAQCAtMTgxMCw2ICsxODE0LDggQEAgc3RhdGljIGludCBtbHhiZl9wbWNfaW5p
dF9wZXJmdHlwZV9jb3VudGVyKHN0cnVjdA0KPiBkZXZpY2UgKmRldiwgaW50IGJsa19udW0pDQo+
ICAJCWF0dHItPm5yID0gYmxrX251bTsNCj4gIAkJYXR0ci0+ZGV2X2F0dHIuYXR0ci5uYW1lID0g
ZGV2bV9rYXNwcmludGYoZGV2LCBHRlBfS0VSTkVMLA0KPiAgCQkJCQkJCSAgImNvdW50ZXIlZCIs
IGopOw0KPiArCQlpZiAoIWF0dHItPmRldl9hdHRyLmF0dHIubmFtZSkNCj4gKwkJCXJldHVybiAt
RU5PTUVNOw0KPiAgCQlwbWMtPmJsb2NrW2Jsa19udW1dLmJsb2NrX2F0dHJbKytpXSA9ICZhdHRy
LT5kZXZfYXR0ci5hdHRyOw0KPiAgCQlhdHRyID0gTlVMTDsNCj4gDQo+IEBAIC0xODIxLDYgKzE4
MjcsOCBAQCBzdGF0aWMgaW50IG1seGJmX3BtY19pbml0X3BlcmZ0eXBlX2NvdW50ZXIoc3RydWN0
DQo+IGRldmljZSAqZGV2LCBpbnQgYmxrX251bSkNCj4gIAkJYXR0ci0+bnIgPSBibGtfbnVtOw0K
PiAgCQlhdHRyLT5kZXZfYXR0ci5hdHRyLm5hbWUgPSBkZXZtX2thc3ByaW50ZihkZXYsIEdGUF9L
RVJORUwsDQo+ICAJCQkJCQkJICAiZXZlbnQlZCIsIGopOw0KPiArCQlpZiAoIWF0dHItPmRldl9h
dHRyLmF0dHIubmFtZSkNCj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiAgCQlwbWMtPmJsb2NrW2Js
a19udW1dLmJsb2NrX2F0dHJbKytpXSA9ICZhdHRyLT5kZXZfYXR0ci5hdHRyOw0KPiAgCQlhdHRy
ID0gTlVMTDsNCj4gIAl9DQo+IEBAIC0xODUzLDYgKzE4NjEsOCBAQCBzdGF0aWMgaW50IG1seGJm
X3BtY19pbml0X3BlcmZ0eXBlX3JlZyhzdHJ1Y3QNCj4gZGV2aWNlICpkZXYsIGludCBibGtfbnVt
KQ0KPiAgCQlhdHRyLT5uciA9IGJsa19udW07DQo+ICAJCWF0dHItPmRldl9hdHRyLmF0dHIubmFt
ZSA9IGRldm1fa2FzcHJpbnRmKGRldiwgR0ZQX0tFUk5FTCwNCj4gIAkJCQkJCQkgIGV2ZW50c1tq
XS5ldnRfbmFtZSk7DQo+ICsJCWlmICghYXR0ci0+ZGV2X2F0dHIuYXR0ci5uYW1lKQ0KPiArCQkJ
cmV0dXJuIC1FTk9NRU07DQo+ICAJCXBtYy0+YmxvY2tbYmxrX251bV0uYmxvY2tfYXR0cltpXSA9
ICZhdHRyLT5kZXZfYXR0ci5hdHRyOw0KPiAgCQlhdHRyID0gTlVMTDsNCj4gIAkJaSsrOw0KPiBA
QCAtMTg4Miw2ICsxODkyLDggQEAgc3RhdGljIGludCBtbHhiZl9wbWNfY3JlYXRlX2dyb3Vwcyhz
dHJ1Y3QgZGV2aWNlDQo+ICpkZXYsIGludCBibGtfbnVtKQ0KPiAgCXBtYy0+YmxvY2tbYmxrX251
bV0uYmxvY2tfYXR0cl9ncnAuYXR0cnMgPSBwbWMtDQo+ID5ibG9ja1tibGtfbnVtXS5ibG9ja19h
dHRyOw0KPiAgCXBtYy0+YmxvY2tbYmxrX251bV0uYmxvY2tfYXR0cl9ncnAubmFtZSA9IGRldm1f
a2FzcHJpbnRmKA0KPiAgCQlkZXYsIEdGUF9LRVJORUwsIHBtYy0+YmxvY2tfbmFtZVtibGtfbnVt
XSk7DQo+ICsJaWYgKCFwbWMtPmJsb2NrW2Jsa19udW1dLmJsb2NrX2F0dHJfZ3JwLm5hbWUpDQo+
ICsJCXJldHVybiAtRU5PTUVNOw0KPiAgCXBtYy0+Z3JvdXBzW3BtYy0+Z3JvdXBfbnVtXSA9ICZw
bWMtDQo+ID5ibG9ja1tibGtfbnVtXS5ibG9ja19hdHRyX2dycDsNCj4gIAlwbWMtPmdyb3VwX251
bSsrOw0KPiANCj4gQEAgLTIwNjMsNiArMjA3NSw4IEBAIHN0YXRpYyBpbnQgbWx4YmZfcG1jX3By
b2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+IA0KPiAgCXBtYy0+aHdtb25f
ZGV2ID0gZGV2bV9od21vbl9kZXZpY2VfcmVnaXN0ZXJfd2l0aF9ncm91cHMoDQo+ICAJCWRldiwg
ImJmcGVyZiIsIHBtYywgcG1jLT5ncm91cHMpOw0KPiArCWlmIChJU19FUlIocG1jLT5od21vbl9k
ZXYpKQ0KPiArCQlyZXR1cm4gUFRSX0VSUihwbWMtPmh3bW9uX2Rldik7DQo+ICAJcGxhdGZvcm1f
c2V0X2RydmRhdGEocGRldiwgcG1jKTsNCj4gDQo+ICAJcmV0dXJuIDA7DQo+IC0tDQo+IDIuMzQu
MQ0KDQo=
