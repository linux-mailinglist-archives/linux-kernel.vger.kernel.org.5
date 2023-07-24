Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3026375EDCB
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 10:38:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjGXIiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 04:38:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbjGXIiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 04:38:09 -0400
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2057.outbound.protection.outlook.com [40.107.212.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6590B94
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 01:38:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qr3z0s6WNA+RHGbRmGa7H7JSrD4hxIu0pMIDYXkuPUH7Py3HhG5NdYNCpWzKDAtkPAhdoPN3UQKhyJZhQNTrkhauQg4rWCgM6DAcmMZoNYx9TAtZVH5uH9xQ3nQOjIr7OZO/2iAEoSJ46Qq1yoVqeCRibmmNC24v89DGZYTN/i0SWlx2Ee6zDBGsh/PiPq9hjsbhf87+ZYrTm8RmR/wmHnOGOCPzjLsVZR6EPwRiIomq+J4J9cYPNWIu0fO1ywZ1gnk+MR7wqiMRifLesDs8aHpP2HEl1qlEvjDjP7zlk+2KHdRPm70MUoaan9R/LE6So4FQEwpgpuU6//dLXjnrFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uW3DeeokXysdeZXY2bxgdt1DSOd4Sko2/5Q09vZ1WSA=;
 b=V0JT6Pa2u1OpwSyovbmozgIMYoAo044oSij2HJkIczy9ALrNYQy3dwc6Xy0fB/KEeD9IMiX5iyHZQoSO8/AOKDsrneFvVgoQAZMvKQR2PjiHjJwma6rJlxVuKhLQWaqUmiwI7uKnpZS82l5X0ohESUaaudfNhSBCzd2J39LtBLRsmGFGkAZLHruWhn30YaOBVJC08mlG2SDu7qIQGd3/jHJw8tTAwjVc6BkwK19CfYQw5cq+NSn15AqtoiDh4bwJiIxqJdnetJhiko09Z+T3slBQHt0UNE+wYU51Eg3hiLXqwmQRiEVjjEggNR5O6RQC225FGOTkqBPihLIk45HPDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uW3DeeokXysdeZXY2bxgdt1DSOd4Sko2/5Q09vZ1WSA=;
 b=qGbXF+1n2g4OTIlVN7KTDIZg3hKsym+ZsOQPTUghu1t5BcXGOBpiAceqEgrC349mykaXBtFDaxvz8WpqgFl53yHGObg7CDGUXwo1asl3VR4yVN0CXFvIDa7UAfLr72WXU7NagCng1jirW9w35I5FKInsA317KZHSMpx1GIUOdJJJaO8TqzP+xPlIGw958ZRS/2vrIEnMrBL8qaKX8KU45aKYgmXvFQZ6h+oKn1i6nFkab1PWdl+AaHicoRlFFnyGWmTn1GyShjSNYjbb2kzyF4EauNg9Ac4xppngwCw0GSXKm5Bs+oPfuD3oopl0iZ9nxkRpLFctW4o4T5e0Fo++yw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by MW4PR12MB6753.namprd12.prod.outlook.com (2603:10b6:303:1ec::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Mon, 24 Jul
 2023 08:38:05 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 08:38:04 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "jasowang@redhat.com" <jasowang@redhat.com>,
        "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>, Eli Cohen <elic@nvidia.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Thread-Topic: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Thread-Index: AQHZvUcvqaqP85S+UEe1bNGo0diH2q/HHwrXgAFiqICAABgRgA==
Date:   Mon, 24 Jul 2023 08:38:04 +0000
Message-ID: <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
         <20230723050656-mutt-send-email-mst@kernel.org>
         <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
         <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
         <20230723055820-mutt-send-email-mst@kernel.org>
         <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
In-Reply-To: <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|MW4PR12MB6753:EE_
x-ms-office365-filtering-correlation-id: 45fb04a0-18d4-43ca-22b3-08db8c214c75
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: u1sIbB8q4/qipHYB82qpRBv3fCDnrFyhWtRU+Ui6432e8Qwsv2TDXzFyhlJS1aqmDNWGdlETmcz76NnnJ7/J5hVDhS8SRtc1dC5Dv/AEK1ae8/96Na1KPhA/xP6JIrdvNlyo+8qImCq81010CPhx1Gf/jbKmXdvWC2xYs5Z873O0K6G3RDgAjUfORvvWZHUwyBdzqvzkdGxL5h/TV51JNKs9D5eCZ75Dtdc7yiOm8ESUfWrovG+Eetzvtp/sDaI+14LEIOzkRxbvj4UYmILWXzhUTJkyAlsk/7NB6MHg8xxVxpyKYMgCik77hVtKrUCOunHuZJFw2A+5wEogb2zaewpEClBQssOOmdQVoV9w7ULpkQzgQW6k6+AbAnRn7ijMSjO5U6ZA9kX0NqOZpG1Qkka4ocSDdHYpkLS7eoA5zkm6tFgrFwkWtRmaDxUw106Klb6Lj3K0GuhlDtBUyEZwHFnTMcRSbPl8VlZl10cZAtpXwqFRawpb75kXIcT8OJAhR41bHUqf8eOvVpBkyh1oPFhK7jR0O+/9YPfc1OhTPHINa9YDw0DP5ITIGB2cN0zJ1AaABkqqsZksodA2Sbf9ABLeTCV3MQ8cChEU3fpdo74DV6hSIex3d6iqT3crMA8O
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(396003)(376002)(39860400002)(136003)(366004)(451199021)(5660300002)(8676002)(8936002)(76116006)(41300700001)(316002)(91956017)(2906002)(54906003)(110136005)(478600001)(6486002)(71200400001)(6512007)(186003)(6506007)(64756008)(53546011)(2616005)(107886003)(66556008)(4326008)(66946007)(66446008)(66476007)(38100700002)(83380400001)(36756003)(122000001)(86362001)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TmxZSEtBRFZjRXFhNHR5cUJBenY1V2RBMGsySEpMbGhhdzY0bk10dThXSEdB?=
 =?utf-8?B?eTQ5bkl2R3dpZnRhMG16ZDFtL1NFS0ZERE5VM3MzbjFQSlZ1QjdkUy9XUnlj?=
 =?utf-8?B?QjJUYU9XbzZvaWthMkxpR2x0ekRqVnY0YzV2R3hxQmMzRHFJWFBUdHNyeTVX?=
 =?utf-8?B?OHdCSzdYdWFhanNpeS9MeDducWNNbHRDN290VXk3ZVg4dlRRdnc1cHB3OEYr?=
 =?utf-8?B?NWNjeGJESGNMSlVJaU55M0orTjdnZm15TEJRcTRtclZNL2pCaEMvSEIyODdu?=
 =?utf-8?B?aXhPWklzMnpQWFdJOHNaZUZUT3VybFROd20xUUIrOG9tZkhCRTZSVDdJb0FZ?=
 =?utf-8?B?VGRQSk1wSmRINGlnYUIvV3prSDdUZzRrOUsvbXp2Y1NEL3ZaQVprM1BuQ0d4?=
 =?utf-8?B?bWhzSnN6dGxvVW1pcGN5bHRCOXJZWW1EcWlNV3VmcURFdmFzUUFCQmdpUUpH?=
 =?utf-8?B?NTY4KzFwZ0JFUHhVcGxpSHpUcFNKek1WdDZGQ05iZnpPM01SSC9HTDJoYWNv?=
 =?utf-8?B?dE1Db3hWcklXbG9kdjNWK1dmTG5lN1dRVHA5Z09QVWR1Mmc4aGRmU1ZZNlZw?=
 =?utf-8?B?ZUx6SktIanYvWi9ZalFHTDRiYkRkdnpkaDRWNDltL3hPL0E3cUFGODNIRFdr?=
 =?utf-8?B?dGZkY25QcTVKT0s2QndKZWdiV1FBbGJpWlBmVnR4TTNybitIcnFjekxMeUxL?=
 =?utf-8?B?RW8wSnRwejQrTW43b256ZXRmN0xDeXFuWWhieWF1aGQzcGR4MHlWb000bWlW?=
 =?utf-8?B?SVBEc3lDVEtDamEwNjJQT1VqeEY2M2JjZzFXNTJQQk9lNE16cEtiNXI5czZj?=
 =?utf-8?B?SkZaRUhnRkw5N0ZiT2JUOEptTkdtbTFldGNBTU1IUC9BY1FPdWl6R0JOWEJ5?=
 =?utf-8?B?WFR1YXErYXo4SlJ2V0FEamJKZ1Qwb0lNYmhZSFNKZjZiTmVRL1hHV1VKelI4?=
 =?utf-8?B?ZG1RWXdEK2VtTE1lKzdmdUt1SUhObkxMSDNJbUV1Y3NVL2dCZC9DZFpRTkhu?=
 =?utf-8?B?R2VFWWdyUEJTbm5ZZERFdzE5UkhWV2xuQ1FBTS80YWVaeW9jS0dTN0REak9q?=
 =?utf-8?B?SlV4aGxpRWhnc2VSa1dtdGxFRHJERGFYVFZXQThQNm1xV3VrclNnQVFiTThn?=
 =?utf-8?B?V2J5SjVONEwvb0N5NnpvY1VleXgzOHZkTjdHd2ovMUxpNTMyRFZETG41UlNa?=
 =?utf-8?B?MUYrQkFkeUROeW42YlF5VnBhYnZNS3lQMStLYWhaKy9NUHJKVVRaS3AzZDhH?=
 =?utf-8?B?YXBXaUhFUXlwUWlVWWNOdDJ5eCsvOFpHZU56L1QrTU4ydUd3MkNwNXlaMUxt?=
 =?utf-8?B?VWJkU2dYb1lEaHAzZTVtTCt4UzlQaTBScW9DUUFpVVlJa2paV2pRWTd1c2lv?=
 =?utf-8?B?OUEvY2NtazcwaEtmMXN0eVRxUnE0ZHJrR2NqVy8zejZFbkFmVTFGdi9zOWNu?=
 =?utf-8?B?bWFEL2VqVG5wNlZUNGNUaU8wWmEyL0M0NWZGMVpCODk5YUc1c3pIdzVMeTBN?=
 =?utf-8?B?eVRBT1hVcUdyUDkzS3hIR1dnVDBOaENRVVNIUTVVU1JMRExSeXB6UGxKcWRC?=
 =?utf-8?B?TGgzb09IaElFS2VCSWl3ZEVvTXBCRnFML2JkblRsQUFCTWxNdlV1clNnUlJv?=
 =?utf-8?B?Y0l1d2Y0VUpiZVpoakpvcVJUbWlCaGNlYzJsMFFKdzJiZU9POXM2RWxFVmto?=
 =?utf-8?B?TUJnQnF3UC9PZXdiQkRrbWJKTExXM2g0ZS9keUlReTloL2I3YkViRjRoeC92?=
 =?utf-8?B?RmZBQ0RBdWFkaUkvbVhUL2QrdXRWSGJacHhITFZ4QkJrQktMZTNVS2xROE5X?=
 =?utf-8?B?bXlrSndkNmV5NDByOUc1c0VJZVJEbDZoSWZFS1gyMWRaRU04U0pwTnRUMW1I?=
 =?utf-8?B?RmNKaHJaS1RLQnpkSU8yUWtQdkVaQ0wzeWNyZU1OaXBqbzZRVlBXRnBkN2dv?=
 =?utf-8?B?SVUvMStvQ1dXanhSNFBwUVN5cENqeHBTc0Q0ZmNNZm1LZXQ3T2h6cnNwYk92?=
 =?utf-8?B?NkVPTGNvT3VEZVB0MjBucW9RTk9NVjl1VUNrLzJleGRnRTRqU3dqVDNmcHMr?=
 =?utf-8?B?V1ZQa3h3UFZ1VDc3S01Vb3lLcnM1RTZMWGVSamdIdThSeTJIWThmYmIrSEdS?=
 =?utf-8?B?VWVrQlAwdGRybVhBZjV3T1RVUEZxcmNlR0cvUExxZTRkVkJySkZxU3paTEl3?=
 =?utf-8?Q?nab4BT6dRdLtmnblyn7zAalz/dpzfTBGQOFrAUwPtcH7?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <071EFE62F09A104293A0D05BE27D7119@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fb04a0-18d4-43ca-22b3-08db8c214c75
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 08:38:04.7270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AjGhdZXBox8gByR4UhaFcGwNxVm3vyqdOsEWM2ZJl25TFqWCylobWet6ua0vkTX+lBqKe2ZBptYpkP71i7rJmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6753
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQpPbiBNb24sIDIwMjMtMDctMjQgYXQgMTU6MTEgKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+
IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDY6MDLigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToNCj4gPiANCj4gPiBPbiBTdW4sIEp1bCAyMywgMjAyMyBhdCAw
NTo0ODo0NlBNICswODAwLCBMaW4gTWEgd3JvdGU6DQo+ID4gPiANCj4gPiA+ID4gU3VyZSwgdGhh
dCBpcyBhbm90aGVyIHVuZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBvbi4gSWYgdGhlIG5sYXR0
ciBpcw0KPiA+ID4gPiBwYXJzZWQgd2l0aA0KPiA+ID4gPiBOTF9WQUxJREFURV9VTlNQRUMsIGFu
eSBmb3Jnb3R0ZW4gbmxhdHRyIHdpbGwgYmUgcmVqZWN0ZWQsIHRoZXJlZm9yZQ0KPiA+ID4gPiAo
d2hpY2ggaXMgdGhlIGRlZmF1bHQNCj4gPiA+ID4gZm9yIG1vZGVybiBubGFfcGFyc2UpLg0KPiA+
ID4gDQo+ID4gPiBGb3IgdGhlIGdlbmVyYWwgbmV0bGluayBpbnRlcmZhY2UsIHRoZSBkZWNpZGlu
ZyBmbGFnIHNob3VsZCBiZQ0KPiA+ID4gZ2VubF9vcHMudmFsaWRhdGUgZGVmaW5lZCBpbg0KPiA+
ID4gZWFjaCBvcHMuIFRoZSBkZWZhdWx0IHZhbGlkYXRlIGZsYWcgaXMgc3RyaWN0LCB3aGlsZSB0
aGUgZGV2ZWxvcGVyIGNhbg0KPiA+ID4gb3ZlcndyaXRlIHRoZSBmbGFnDQo+ID4gPiB3aXRoIEdF
TkxfRE9OVF9WQUxJREFURV9TVFJJQ1QgdG8gZWFzZSB0aGUgdmFsaWRhdGlvbi4gVGhhdCBpcyB0
byBzYXksDQo+ID4gPiBzYWZlciBjb2RlIHNob3VsZA0KPiA+ID4gZW5mb3JjZSBOTF9WQUxJREFU
RV9TVFJJQ1QgYnkgbm90IG92ZXJ3cml0aW5nIHRoZSB2YWxpZGF0ZSBmbGFnLg0KPiA+ID4gDQo+
ID4gPiBSZWdyYWRzDQo+ID4gPiBMaW4NCj4gPiANCj4gPiANCj4gPiBPaCBJIHNlZS4NCj4gPiAN
Cj4gPiBJdCBzdGFydGVkIGhlcmU6DQo+ID4gDQo+ID4gY29tbWl0IDMzYjM0NzUwM2YwMTRlYmY3
NjI1NzMyN2NiYzcwMDFjNmI3MjE5NTYNCj4gPiBBdXRob3I6IFBhcmF2IFBhbmRpdCA8cGFyYXZA
bnZpZGlhLmNvbT4NCj4gPiBEYXRlOsKgwqAgVHVlIEphbiA1IDEyOjMyOjAwIDIwMjEgKzAyMDAN
Cj4gPiANCj4gPiDCoMKgwqAgdmRwYTogRGVmaW5lIHZkcGEgbWdtdCBkZXZpY2UsIG9wcyBhbmQg
YSBuZXRsaW5rIGludGVyZmFjZQ0KPiA+IA0KPiA+IHdoaWNoIGRpZDoNCj4gPiANCj4gPiArwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmFsaWRhdGUgPSBHRU5MX0RPTlRfVkFMSURBVEVf
U1RSSUNUIHwNCj4gPiBHRU5MX0RPTlRfVkFMSURBVEVfRFVNUCwNCj4gPiANCj4gPiANCj4gPiB3
aGljaCB3YXMgbW9zdCBsaWtlbHkganVzdCBhIGNvcHkgcGFzdGUgZnJvbSBzb21ld2hlcmUsIHJp
Z2h0IFBhcmF2Pw0KPiA+IA0KPiA+IGFuZCB0aGVuIGV2ZXJ5b25lIGtlcHQgY29weWluZyB0aGlz
IGFyb3VuZC4NCj4gPiANCj4gPiBQYXJhdiwgRWxpIGNhbiB3ZSBkcm9wIHRoZXNlPyBUaGVyZSdz
IGEgdGlueSBjaGFuY2Ugb2YgYnJlYWtpbmcgc29tZXRoaW5nDQo+ID4gYnV0IEkgZmVlbCB0aGVy
ZSBhcmVuJ3QgdGhhdCBtYW55IHVzZXJzIG91dHNpZGUgbWx4NSB5ZXQsIHNvIGlmIHlvdQ0KPiA+
IGd1eXMgY2FuIHRlc3Qgb24gbWx4NSBhbmQgY29uZmlybSBubyBicmVha2FnZSwgSSB0aGluayB3
ZSBhcmUgZ29vZC4NCj4gDQo+IEFkZGluZyBEcmFnb3MuDQo+IA0KSSB3aWxsIGNoZWNrLiBKdXN0
IHRvIG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgY29ycmVjdGx5OiB5b3Ugd2FudCBtZSB0byBkcm9w
IHRoZQ0KLnZhbGlkYXRlIGZsYWdzIGFsbCB0b2dldGhlciBpbiBhbGwgdmRwYSBvcHMgYW5kIGNo
ZWNrLCByaWdodD8NCg0KVGhhbmtzLA0KRHJhZ29zDQo=
