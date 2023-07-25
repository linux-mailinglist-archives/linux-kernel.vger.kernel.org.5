Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AACB760CF1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:26:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjGYI0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231254AbjGYI0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:26:35 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52C6910C9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 01:26:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=na84XpHqoYnfxaJvn7DURHRc6jXZSWVemJTu6LJiaeVQflBfFnlvZZlf3jHK3TkcPY1/5nOBDX6qAVuwLM9t2+8FNXHuIGkZeYfwHOxO/uBSMBcwgms4LrDFQEIJ0NP0vRimvZEoYrWhINU+b1j7bkDSnn5tsZan4brwJj0RgKD/3k1RxkRDGhLz3psVG6CP4CELo35HYUWJmvmPelm54qDa4O2rIoIZrD0Nbiqa8ZodeE419uiSvnYik6LUPcCHhycuMVZ2Ve3fJkcIXGITcjuB99tiGgu79kaLDArqQ4Y2p33RM5VuLchyh9ehs1L80bXOsgF9VOtG+4gUt0UPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MK//GcmPjNdqWUe14U6kNBCGefqfUnHxiIdhV+l7OLE=;
 b=Th0BtVOj5taDg86S+FRLQH9Xj58+KJF30B11Os+A7vBjogrZ1Wx1yg5UnzkOGzHc5qTMeTDU1pxDXltC3MWr4Dj3PFhpE4EQ/SSRBl4n8amjMckVPPr21WA7r2c/UjC86lZfBv8chgga7KsR2s8ExgRUdC+IShGQ3mqWbX7H3btXJULCkGpdWgbGjeEAnRsflylm1+P8JK8WCePbWMOrU3s+o+3wbfwJIvCQWHBw7QZ9eVkKcsud4FaUXmev7iuunBR147oRC/ypsU7mEPAxq5AEo7nvxIkgleOjjMfowesnQSt/p8zr+6/hyWEvNPGy625VxyXPny25E1+qMZa2mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MK//GcmPjNdqWUe14U6kNBCGefqfUnHxiIdhV+l7OLE=;
 b=RChPvEB/R+TyjG9kB8UbhG21mAJQXbxTbKekOd+1lTWT/AJ4vupOntGgAjTfm0qgnrAGtFtkpxIt8P9z/KbKvKk4R/8eMLClyjQXR4YRcpCVMvenMtEjaOrlG5f2mCif0qBLqwyIZw0aViNoRitjUSLcM0tYXBirIC1vZUrID43DI/RfYW9fAN3plt6zphkMs4PGyATBYenJFj+rY0bmQ1s0ZeDd0TxH84aYo7MH8Y0DsOxHFP+aRRTEesvBtI94RP0o7HwAtLbXoFNtK0BZLp41FbpKtO5MvNQo59WeWKpbxPzVNAN9m1iKIQfpw7omFIj7IVRn5D5LKk0kTXvWKw==
Received: from DM6PR12MB5565.namprd12.prod.outlook.com (2603:10b6:5:1b6::13)
 by CH3PR12MB9252.namprd12.prod.outlook.com (2603:10b6:610:1ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.32; Tue, 25 Jul
 2023 08:26:32 +0000
Received: from DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667]) by DM6PR12MB5565.namprd12.prod.outlook.com
 ([fe80::40dc:9f89:895c:8667%4]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 08:26:32 +0000
From:   Dragos Tatulea <dtatulea@nvidia.com>
To:     "mst@redhat.com" <mst@redhat.com>
CC:     "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "linma@zju.edu.cn" <linma@zju.edu.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Eli Cohen <elic@nvidia.com>,
        "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
        Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Thread-Topic: [PATCH v1] vdpa: Complement vdpa_nl_policy for nlattr length
 check
Thread-Index: AQHZvUcvqaqP85S+UEe1bNGo0diH2q/HHwrXgAFiqICAABgRgIAACriAgAAo3oCAAI1ugIAAzhcA
Date:   Tue, 25 Jul 2023 08:26:32 +0000
Message-ID: <00e14bc9e9a1f3749be62cbefc7adfaa1ba2d81c.camel@nvidia.com>
References: <20230723080507.3716924-1-linma@zju.edu.cn>
         <20230723050656-mutt-send-email-mst@kernel.org>
         <729f5c17.e4079.18982192866.Coremail.linma@zju.edu.cn>
         <8ecec51.e40ad.1898226c545.Coremail.linma@zju.edu.cn>
         <20230723055820-mutt-send-email-mst@kernel.org>
         <CACGkMEuGHMu6te3jRfEhhwTrWR1mpqp3hbVhDKQiXK9tgwz3qw@mail.gmail.com>
         <56aa7d5c6d5840aedef83d3dc39f0bb3162bbb58.camel@nvidia.com>
         <20230724050005-mutt-send-email-mst@kernel.org>
         <280068e9c684f0ae644d195d3a4d3f5a1351c366.camel@nvidia.com>
         <20230724160836-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230724160836-mutt-send-email-mst@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.48.4 (3.48.4-1.fc38) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR12MB5565:EE_|CH3PR12MB9252:EE_
x-ms-office365-filtering-correlation-id: 09cd150d-c244-4cea-4707-08db8ce8d9ff
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /504ukPAh6HzBi5MVQyB+UyDIcirRZhdW97tD63nWiwXRtxKS51oPpLZpRBmu0KH80x0kMDnTtXVliuIOZDfhSiGm3n5vGScwOS4HdtAJr8z05UjMDe5jqDw03FgP5bnqNDxwQcgrRRHt+F5sheFp7r6ugi2GhVocwGi9Pi2IllC+2fAXrjzsC7XBVDkR+JjfpOhmyCGwDjyzFKqI76/CjtLm6SDjAoUtO/V2mMoP5Orjli5T8EgkIYzNy14jzCs20V2LelRMGK1snvmDXnf421DeQm+NB9MJQpD8KUIGdwak6Al1W30T5fGZtRHOzTTSqoakaiThM3Xd+R9YfhslGPQH5ntsVslEi38MvArloNhSDXST0Md+KP6LasGu1tWk6aShbQ7fCNf1cuCj/BnZFJHChtfj912VamwNoOMol2yiFeuxdRr+dYEUTweyXkzQgfp6jdNsVVVwiI+LFpU3fk9CdJ2lcnKMhYmSxT8D5zOwsfyPquV6nzyeBtvEr/puPoE05JM3og3Zd+2sAmPIM6HjcDGMRlQTKrccr4VIa7jJZXul9PUnsqR1pMb/aC5eu3uovI8MNARtBsBv4BNIITbtIftUpI5vbhBpGHyUp09x7p70gFe2rEQMxOLV/KT
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB5565.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(346002)(39860400002)(396003)(376002)(136003)(451199021)(86362001)(38100700002)(122000001)(6486002)(71200400001)(2906002)(6512007)(2616005)(64756008)(107886003)(53546011)(38070700005)(66946007)(186003)(6506007)(36756003)(5660300002)(66446008)(41300700001)(76116006)(66556008)(66476007)(91956017)(316002)(6916009)(4326008)(8936002)(478600001)(8676002)(54906003)(83380400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N0VNV1VSbUNuTWhGMWdhanlOemhMWnplRGdHejNKNVdaaUlNTTl5R1Y5WHJk?=
 =?utf-8?B?RWtIZmo2b1gwUUpETjNRR2pqUWRUSWRVazB5L1BMREdMb1I5NzBBR3RLSVhE?=
 =?utf-8?B?VE9wYUVvZy83a2tjOUxxVDJEL1F6UUFkZG5iam92WFNNai9kZnl6OElqbUYx?=
 =?utf-8?B?U0l0WlRKeGFnd2Y0NHE3Wk5yTTNlakdSdkRsZHQvc0V1ZjJtZnZoSjhML3g1?=
 =?utf-8?B?QkFXcE84WXEwT0VVTmZjdHo4bTNpOGFFY2Viaiswc3krdnRqcGZKV3NHL1kw?=
 =?utf-8?B?VkdhNGlSREpQdHZHTGVDZ01MU3VkVmVUdDV6Vk84bjBBV2NzK2lXMlpuNnhp?=
 =?utf-8?B?cHY0YzBoS296cHo5bGlXN3VsWm5xSG1YN2cyTWt3WEFVNyt4LzFOZ0xFWnJW?=
 =?utf-8?B?VUhHVzNBMVpRNUJza1VqZEJuSVZuLzROMFFwN2g0VWlUdjYvVzVDSUlvbHg1?=
 =?utf-8?B?K3NkV0hXQXprRGU3MkpRMXRZNGRLS01mTWdIWU5rbEN1eEU2cWFQUHB2Y3Zk?=
 =?utf-8?B?MDhtbnQyZlcweFZ6YkpTYjU2bSttaUs0Um54RDhsZGloUnNVeUV4bzBQbXA5?=
 =?utf-8?B?NERtdDByTHJQUmovR0lGaGUvZkFoaUF2RTJxb0hCTnhYcDNCcWcvT2FDS0RW?=
 =?utf-8?B?UTlNR3hGRkdKMlh0WGlqZTIySjFHZ25xaW9CbEgySEJSUzF6M01iUVNsNG95?=
 =?utf-8?B?VDNaMTFBWE9GbVo4bUdNY2xzUkhkR3RZT2Zoay9MVGJJNis0YTlxTk51bHdY?=
 =?utf-8?B?Z0VNOFl6TklJZzQzTGE0R0lLclJOd3diTjV5Mk9vYVJZZzRDVzlKbWF2YUdw?=
 =?utf-8?B?VFh5MGQ2NjNKTldaVTJnRVF5L0tMVE9EVXVYRE5Hbk8zVGFPSjh0RTdmWXYy?=
 =?utf-8?B?Y1pnaHNHUTNwdjFNTEIvRk15blhtTDZHSzc5YXRIS2VpTmRiYVIvU3o1c0RZ?=
 =?utf-8?B?REVGRlV4bjdaTzFRL1kvOHZSRnRWUm93K3RDbzJ5TDBQOHhyNkxVaU8vWkZq?=
 =?utf-8?B?SU10SDVHdUUyZUdzamFtaFczZmFmZHZ2RTZTdDRmaWk2dUFxV0hVSCt1c0Nm?=
 =?utf-8?B?S3QwZkZxQjhkTGIxZkpiMUp3bFpIQ3JxRjhDcEgvZWgrU3lVNy9hbnc0cCtD?=
 =?utf-8?B?Q1JyWGpnWUpDM0Y3OXlWdWZYSFlHOE03UCs1Q2JmUTVBVmkvdDZ2UC9jdFdT?=
 =?utf-8?B?T29hazZ1M285NlMvZzhmMG5mTjVEaCtPMko3Q255djlpSnZPbGlCRmg5ZWJn?=
 =?utf-8?B?cTUzcklDT3Q0aUV4dHlNMVBDSzdRcjFPMS80V09TcU5JQUh2Uyt4VnRpQThN?=
 =?utf-8?B?WWdLMThNTHNEZkdLUi9CYWFMZkkzSjJzNlBmUFZkZFhsS01aYU5NK1VyMk00?=
 =?utf-8?B?WHNjUkYxQlRQMC9MeXplVEJ2NGpLUlhLOGdXWjFTTWpLeEt1QkhXYnhvV3ky?=
 =?utf-8?B?OUpGOCtSUkR2V2U3SmdVbWpCSzhTd0lUSnRlUTdvZlVoWXJ6Kyt4T3lNT29M?=
 =?utf-8?B?MWVlSUVhVUd2YmRrTi9LQ0N2Sm9uSmtONEwreElzZGVJenVGYzhpSlJqbU9v?=
 =?utf-8?B?TGp4OWJROUNjQzhHMVl0WjhqYkkyOFNZK3E0T3BhcVZia3NWSVJTZ05raHI0?=
 =?utf-8?B?cEFUcW5hOFhLSERhVm51WlhXNlI1bWhnMERUSldnT2FuV1R0OFQ5UFhPTXEx?=
 =?utf-8?B?Tk5BTzYwRmxCRC83bGo2Vlc3ZWovRGg0QndvUzVwWDc1T1pMT2xzWHNiQmtX?=
 =?utf-8?B?QUNUQjN5bXVjSU9KT2JLYmlJdFVla1RGSDBCSEU1NllXU3pCbWJRRlVrSkpZ?=
 =?utf-8?B?eGthUUkrOWgwc0JhM2NaaUJDWXE3bkw5RUNycDJHK0RaQUpjT0t2ZzFaaHZT?=
 =?utf-8?B?QnhGazJrYndXOXNTZGtiOVpKTUdlSTB3NlUvaTYwa3lmcmg1cWN2TGNUV1Vq?=
 =?utf-8?B?U0g0STJjUkpkM0x0eVZvSmh3RUFJdFQ0WUM2QjgvOGp5K2ExbmZpZG5YTlpi?=
 =?utf-8?B?bkFZOWpvUnpjY2E2TjdycWhmZGRWOEpWMDhqZ2FZY05uais0QktDdUpHSnV4?=
 =?utf-8?B?dytFazE5UDNqaHY3aEs4SW5sZHg0akduSCtMSllJdGVKNVVCWmdEVWpCd3lS?=
 =?utf-8?B?aEhCN2VtaTJSbkFsSjlzWXlXdVRJWkwvVHp6MU42ZTJmK1Jjc0tTbEpJNlU0?=
 =?utf-8?Q?CKEg7DMaJN0BajoeboEbNOE/Bfkpj0Cao1ajUFa8Pgfx?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C98744B9FC6C54791FC5F61FCD27FE4@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB5565.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09cd150d-c244-4cea-4707-08db8ce8d9ff
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jul 2023 08:26:32.0471
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +Y6BS+xhsPoa7wJpM8Uhoj1RmQECqDYtbljyYLxuCSUmEZ8FIsw1lJGqfVY64aGbIDykZ5oEwVN/zRw5lIKvdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9252
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gTW9uLCAyMDIzLTA3LTI0IGF0IDE2OjA4IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6DQo+IE9uIE1vbiwgSnVsIDI0LCAyMDIzIGF0IDExOjQyOjQyQU0gKzAwMDAsIERyYWdvcyBU
YXR1bGVhIHdyb3RlOg0KPiA+IE9uIE1vbiwgMjAyMy0wNy0yNCBhdCAwNToxNiAtMDQwMCwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBKdWwgMjQsIDIwMjMgYXQgMDg6
Mzg6MDRBTSArMDAwMCwgRHJhZ29zIFRhdHVsZWEgd3JvdGU6DQo+ID4gPiA+IA0KPiA+ID4gPiBP
biBNb24sIDIwMjMtMDctMjQgYXQgMTU6MTEgKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6DQo+ID4g
PiA+ID4gT24gU3VuLCBKdWwgMjMsIDIwMjMgYXQgNjowMuKAr1BNIE1pY2hhZWwgUy4gVHNpcmtp
biA8bXN0QHJlZGhhdC5jb20+DQo+ID4gPiA+ID4gd3JvdGU6DQo+ID4gPiA+ID4gPiANCj4gPiA+
ID4gPiA+IE9uIFN1biwgSnVsIDIzLCAyMDIzIGF0IDA1OjQ4OjQ2UE0gKzA4MDAsIExpbiBNYSB3
cm90ZToNCj4gPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiA+ID4gU3VyZSwgdGhhdCBpcyBhbm90
aGVyIHVuZGVyZ29pbmcgdGFzayBJJ20gd29ya2luZyBvbi4gSWYgdGhlDQo+ID4gPiA+ID4gPiA+
ID4gbmxhdHRyDQo+ID4gPiA+ID4gPiA+ID4gaXMNCj4gPiA+ID4gPiA+ID4gPiBwYXJzZWQgd2l0
aA0KPiA+ID4gPiA+ID4gPiA+IE5MX1ZBTElEQVRFX1VOU1BFQywgYW55IGZvcmdvdHRlbiBubGF0
dHIgd2lsbCBiZSByZWplY3RlZCwNCj4gPiA+ID4gPiA+ID4gPiB0aGVyZWZvcmUNCj4gPiA+ID4g
PiA+ID4gPiAod2hpY2ggaXMgdGhlIGRlZmF1bHQNCj4gPiA+ID4gPiA+ID4gPiBmb3IgbW9kZXJu
IG5sYV9wYXJzZSkuDQo+ID4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gPiBGb3IgdGhlIGdlbmVy
YWwgbmV0bGluayBpbnRlcmZhY2UsIHRoZSBkZWNpZGluZyBmbGFnIHNob3VsZCBiZQ0KPiA+ID4g
PiA+ID4gPiBnZW5sX29wcy52YWxpZGF0ZSBkZWZpbmVkIGluDQo+ID4gPiA+ID4gPiA+IGVhY2gg
b3BzLiBUaGUgZGVmYXVsdCB2YWxpZGF0ZSBmbGFnIGlzIHN0cmljdCwgd2hpbGUgdGhlIGRldmVs
b3Blcg0KPiA+ID4gPiA+ID4gPiBjYW4NCj4gPiA+ID4gPiA+ID4gb3ZlcndyaXRlIHRoZSBmbGFn
DQo+ID4gPiA+ID4gPiA+IHdpdGggR0VOTF9ET05UX1ZBTElEQVRFX1NUUklDVCB0byBlYXNlIHRo
ZSB2YWxpZGF0aW9uLiBUaGF0IGlzIHRvDQo+ID4gPiA+ID4gPiA+IHNheSwNCj4gPiA+ID4gPiA+
ID4gc2FmZXIgY29kZSBzaG91bGQNCj4gPiA+ID4gPiA+ID4gZW5mb3JjZSBOTF9WQUxJREFURV9T
VFJJQ1QgYnkgbm90IG92ZXJ3cml0aW5nIHRoZSB2YWxpZGF0ZSBmbGFnLg0KPiA+ID4gPiA+ID4g
PiANCj4gPiA+ID4gPiA+ID4gUmVncmFkcw0KPiA+ID4gPiA+ID4gPiBMaW4NCj4gPiA+ID4gPiA+
IA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBPaCBJIHNlZS4NCj4gPiA+ID4gPiA+IA0KPiA+
ID4gPiA+ID4gSXQgc3RhcnRlZCBoZXJlOg0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiBjb21t
aXQgMzNiMzQ3NTAzZjAxNGViZjc2MjU3MzI3Y2JjNzAwMWM2YjcyMTk1Ng0KPiA+ID4gPiA+ID4g
QXV0aG9yOiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52aWRpYS5jb20+DQo+ID4gPiA+ID4gPiBEYXRl
OsKgwqAgVHVlIEphbiA1IDEyOjMyOjAwIDIwMjEgKzAyMDANCj4gPiA+ID4gPiA+IA0KPiA+ID4g
PiA+ID4gwqDCoMKgIHZkcGE6IERlZmluZSB2ZHBhIG1nbXQgZGV2aWNlLCBvcHMgYW5kIGEgbmV0
bGluayBpbnRlcmZhY2UNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gd2hpY2ggZGlkOg0KPiA+
ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAudmFs
aWRhdGUgPSBHRU5MX0RPTlRfVkFMSURBVEVfU1RSSUNUIHwNCj4gPiA+ID4gPiA+IEdFTkxfRE9O
VF9WQUxJREFURV9EVU1QLA0KPiA+ID4gPiA+ID4gDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+
IHdoaWNoIHdhcyBtb3N0IGxpa2VseSBqdXN0IGEgY29weSBwYXN0ZSBmcm9tIHNvbWV3aGVyZSwg
cmlnaHQgUGFyYXY/DQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IGFuZCB0aGVuIGV2ZXJ5b25l
IGtlcHQgY29weWluZyB0aGlzIGFyb3VuZC4NCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+ID4gUGFy
YXYsIEVsaSBjYW4gd2UgZHJvcCB0aGVzZT8gVGhlcmUncyBhIHRpbnkgY2hhbmNlIG9mIGJyZWFr
aW5nDQo+ID4gPiA+ID4gPiBzb21ldGhpbmcNCj4gPiA+ID4gPiA+IGJ1dCBJIGZlZWwgdGhlcmUg
YXJlbid0IHRoYXQgbWFueSB1c2VycyBvdXRzaWRlIG1seDUgeWV0LCBzbyBpZiB5b3UNCj4gPiA+
ID4gPiA+IGd1eXMgY2FuIHRlc3Qgb24gbWx4NSBhbmQgY29uZmlybSBubyBicmVha2FnZSwgSSB0
aGluayB3ZSBhcmUgZ29vZC4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBBZGRpbmcgRHJhZ29zLg0K
PiA+ID4gPiA+IA0KPiA+ID4gPiBJIHdpbGwgY2hlY2suIEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5k
ZXJzdGFuZCBjb3JyZWN0bHk6IHlvdSB3YW50IG1lIHRvDQo+ID4gPiA+IGRyb3ANCj4gPiA+ID4g
dGhlDQo+ID4gPiA+IC52YWxpZGF0ZSBmbGFncyBhbGwgdG9nZXRoZXIgaW4gYWxsIHZkcGEgb3Bz
IGFuZCBjaGVjaywgcmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IERy
YWdvcw0KPiA+ID4gDQo+ID4gPiB5ZXMgLSBJIHN1c3BlY3QgeW91IHdpbGwgdGhlbiBuZWVkIHRo
aXMgcGF0Y2ggdG8gbWFrZSB0aGluZ3Mgd29yay4NCj4gPiA+IA0KPiA+IFllcC4gQWRkaW5nIHRo
ZSBwYXRjaCBhbmQgcmVtb3ZpbmcgdGhlIC52YWxpZGF0ZSBjb25maWcgb24gdGhlIHZkcGFfbmxf
b3BzDQo+ID4gc2VlbXMgdG8gd29yayBqdXN0IGZpbmUuDQo+ID4gDQo+ID4gVGhhbmtzLA0KPiA+
IERyYWdvcw0KPiANCj4gT0ssIHBvc3QgYSBwYXRjaD8NCj4gDQpTdXJlLCBidXQgaG93IGRvIEkg
bWFrZSBpdCBkZXBlbmQgb24gdGhpcyBwYXRjaD8gT3RoZXJ3aXNlIGl0IHdpbGwgYnJlYWsgdGhp
bmdzLg0KDQpUaGFua3MsDQpEcmFnb3MNCg0K
