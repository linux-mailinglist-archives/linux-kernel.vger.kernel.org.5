Return-Path: <linux-kernel+bounces-45851-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 910DB84370D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:00:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47047282E55
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 07:00:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029234174A;
	Wed, 31 Jan 2024 07:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Akf2M78w"
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2085.outbound.protection.outlook.com [40.107.220.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C537712;
	Wed, 31 Jan 2024 07:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706684446; cv=fail; b=sO/iYI4zuz3eL72vB8JrhK3InEssadzX3/cuJkmPc3jC53xxgQ6m+oWfeF+/wumy6e0Xz55bqeIOS+Dee4c4GCffo8sWmWutnXWykoGLWikRYFRzAw17mhHMsRTBUhYus3XTCC9UyK1kZQQvz1LlbFGmzb6/OLYT6HlpAOt3s2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706684446; c=relaxed/simple;
	bh=2EkSga+57dihpqSGwcBv3Ve/01RnV65Y7FEboIuatRc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=CKhLGtX18pKGzI2Hxh+01uu5RJNjwgK4hVRRftrDmOXRCY8THIy4DXqZ31UwEYRhQFncX35wdShRD+K7rk7Za3BdbdcALIIkHE4kc2QdyXbE1lIZ4A26BoO3bRO3R+Jl2OsekLNy8Jrkr1xwlhpZJt8sZZdKm4TRisEtSn9i7tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Akf2M78w; arc=fail smtp.client-ip=40.107.220.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BVcRJRlLARnRmTPHRia2Cbwm0UbmrDyGctvrSdrBg96NR5EMYnWz/9JBNqDsc10vQGPDNzhNyRQnO6K6FcP27algZwT963gRk2iivBL+86T5j/3Zg9Z8nvYA1znWUmlgcBncwZ3QNxlr+pcUp95HNo+HHot6v1m80/AhUulBsqzfyw9O9VOTYR81LvdNl8FqBA5wv7nFnRdT7JkRjlINsRAl5bUPfqLIB+2cv/Z4HIb8oTPRdh2hgm35bRU1yohr7Gj+Yk1sO5n9KfBnx5nYUTY0Zmy1K++aMYav8X+tZxiZw/DGkhSoXSYintI/grIGyOC3OHHT5kkQXTs3SpSJ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2EkSga+57dihpqSGwcBv3Ve/01RnV65Y7FEboIuatRc=;
 b=hLhk92dcOnsVS470rrZhC33Bjt5smo4VxQVfox4H8fN+MpPSyb1Bu9Xth1HXWJOGReW7jEzkuHORqXrYFTmT54qBi9qg8pLcajFcrVejoo9/gnbZi/Xj18yHvBcF+e4VYS2KjclX+upcMR+03WJzec4Rdg6aIcH7keQ/RaARBXbLQEkR0y/ll8dZFmR0GLWxFaLGx/cNg3c0HlTa4coiI/fb0FQORMSudr34U+VY3DZbqXbJHWKzO2LMGEPh5qH+guvkLtobZ0gjxkt2sgThblM1agkiXC9VbULVrTvfwaKBqmDalEnIryFFF2cFFObc/hvVFpGC4U6eD7rQm2AfFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2EkSga+57dihpqSGwcBv3Ve/01RnV65Y7FEboIuatRc=;
 b=Akf2M78wAEYbOhYWcrXgr+43ophsBhXBs5iL4vg4Z+zu50vTQW0fINa42S6pczlmGV45I09s7R5Io2edY4h7ogFn7HL3ixXOKrUsnvVnLniwFRDuDfGOmznkYHKmKLd0VHCoH0J16ekhvuNdUNg+7jbw6xJlRrmOmxXNo7gysFSXu1OVbEzsssqEFYA1y/xYBBpr/uemNvvh4Cn84XTrRpH4s2ddXnQpHBsJqTjmK32CejZrHSxwg6b0Nh/JEKQk425BgU9XzRMCy5bABzERyhjnRs/zipi0RKpkUt+cQUXlq1uOx6uXkFnIX09meku+BIM8GWuTB043CpXYpOzvug==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by BY5PR12MB4966.namprd12.prod.outlook.com (2603:10b6:a03:1da::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.22; Wed, 31 Jan
 2024 07:00:42 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::ffce:bbde:c1ca:39ed%4]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 07:00:42 +0000
From: Chaitanya Kulkarni <chaitanyak@nvidia.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
CC: Stefan Hajnoczi <stefanha@redhat.com>, "virtualization@lists.linux.dev"
	<virtualization@lists.linux.dev>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "mst@redhat.com" <mst@redhat.com>,
	"hch@lst.de" <hch@lst.de>, "jasowang@redhat.com" <jasowang@redhat.com>,
	"pbonzini@redhat.com" <pbonzini@redhat.com>, "xuanzhuo@linux.alibaba.com"
	<xuanzhuo@linux.alibaba.com>, "axboe@kernel.dk" <axboe@kernel.dk>, Ming Lei
	<ming.lei@redhat.com>
Subject: Re: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
Thread-Topic: [RFC PATCH 1/1] virtio-blk: process block layer timedout request
Thread-Index: AQHaI1shzp//y36X6UaYv9pqCqj82LCTo7mAgD1uyACAFVzmgIANcEsA
Date: Wed, 31 Jan 2024 07:00:42 +0000
Message-ID: <13d6be3f-d6a8-4ccf-8e14-15647b2eae5b@nvidia.com>
References: <20231130070133.8059-1-kch@nvidia.com>
 <20231130070133.8059-2-kch@nvidia.com> <20231201012507.GA1209828@fedora>
 <f4c17344-33be-4832-9045-fb6b40a478b6@nvidia.com>
 <CAJSP0QX7H5F=rzz=STeWWYZbTxog0S-MARXgoHkR=u04qTD+_w@mail.gmail.com>
In-Reply-To:
 <CAJSP0QX7H5F=rzz=STeWWYZbTxog0S-MARXgoHkR=u04qTD+_w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|BY5PR12MB4966:EE_
x-ms-office365-filtering-correlation-id: 41e4ca96-0bdc-443e-a84e-08dc222a573c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 jNJHWsSWzPsHSlIERZwPuXeuzxKBqqRvvOT0m9+we4wBAP05wnMW515xv4Vpe5x+Ixjo4MbHSNMkV0lhxij2Dx9+73k7c/Sw2lr03Po6pS0ej2iZwtCFM8eNp3XP4hUzcLf9mqgMEw6IUOiJo+J/BAIw+HJJKwB6SlFg2GotSTtydX5QFKCW2PeXbqriWfUi91bXK4+xN30FB/6vD4cq+sOCMInX9JNcx8zNsxWG6kPUB+P60qqAOLpGO4+ZNlJa81JQZcw7efUyC++UUbaceozSxSP0+PhtILuKBCvlNdftjexz+caCE/niKs3SKO/G6j2Hn+t54U6ZoZpqPDKqPLoqATcGnx0WnIFMZ6fW0vktgojXKY7mB8iSlV6m3uticDW4suTOZw1FhSpPTn0Xg/+hkhQTOElVwRKFpF4G95qns4XSOCYa3C0mI7nDFNkFaMWkyCtAzCvPNwERiha+EsQrN5N1zlT55gEZu/GnA7xPszRWBdct/D09YDzB/ljWJUQI4Gp79ag9/Uzr9a/NWBFAijQ35CJamnA+nAEgJO+A+Bxn5fTuXPi5SdGgQ31zDCa848cCRT1ybx5iPci4Psa58wip6rws4wzxlU/LnlESLNjJw/Kfd6mjiFGRUIeQfdhF54VNfuCzFZEGLUYjY5sQ/c9hz7ZUbGXlD+fH0W2qzoRTtcBI5o150/R1dXAF
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(366004)(39860400002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(41300700001)(83380400001)(6512007)(2616005)(38100700002)(122000001)(5660300002)(4326008)(8676002)(8936002)(7416002)(478600001)(2906002)(53546011)(6486002)(6506007)(54906003)(64756008)(66446008)(66476007)(66556008)(71200400001)(6916009)(76116006)(91956017)(316002)(66946007)(38070700009)(31696002)(86362001)(36756003)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ZWJ4eE8zWFc4ZG4zL3BNOG9VREhJckxFY2V4VGJXNmhNUW1XMkM1UE5IWmVH?=
 =?utf-8?B?c2tSQWFrUDdUbHVDMUVtdzJ3enBZMGlEMVRqbmZ3b2pmcThMQTNRd21DbHRB?=
 =?utf-8?B?RTRnVXFVdlRRekN6Q2pOK3ROVFFuSjhKV1ZIM1BuZ2xBUzlMSFlGaXVFc2pY?=
 =?utf-8?B?cTFReC9PeGp4RnFYUXQwZm5UNkxBQ0x5KytPMnlFdkNQVy8wK2FXcmdTNkVn?=
 =?utf-8?B?NWNlR3FRR1ZqWWdBc3N3NXFkbUw1ZnEvS2FzTEZJeE5zMjA2a1hTUVZUOXJN?=
 =?utf-8?B?Yld0Vi9qbWZreVJLM3BsZ3c5a3BiVlJUcE1IRkIyYmczVS9oeU90RDlBZGJW?=
 =?utf-8?B?aDZOcE44WXJrcHRQY2sxcU5Ubk1pbFRNbU1aSUh6cGU2cHNrQjlzUElsOFZQ?=
 =?utf-8?B?eHc0ZE0yU0xCQ2YvMVhIMzkxQVQ3elpha2Fld1BycWhQUDZiZWxMLzJYYTNQ?=
 =?utf-8?B?QjNzWWVoWVgwSjdjaUxRTGVWUEZxZEFZWW9CRW9BaUlYQ2lIMnV0QVZscW9E?=
 =?utf-8?B?R09yRWM5NFpveG1jUDlIN0lvZGphVzh5dGp3REhNT0NCZjQzVWxqQ3FmWmVi?=
 =?utf-8?B?M3NtUXB4V2ZXekZMLzNud2w1NHZhVFdoQkxrWk9KY0Jibk9sUC9tZFhzZlRu?=
 =?utf-8?B?bEJnd2Y1Wnhuc1NHU0hEWTdCSXlibWVBZTF1bXpxWHAxNUJnOVBGazRaVTVO?=
 =?utf-8?B?YmxwdFNMRTVWek5SQkh6a2ZxdHdReEVOakJKS2dSeVZNc29IYnJMaGh1VjBB?=
 =?utf-8?B?dk1wU0FFR00vSG8zZ2hoMU9EUTI1VlVNeDkrQXlLcjFFZXV0dEtjMzExdGFy?=
 =?utf-8?B?UzdFa0ZTWlZxc1JVVENxeXV1SXp6TS9BZGpldktWdWo1NU1PUHlTcDlkSGdH?=
 =?utf-8?B?QjQwS0FRZ0dXZWRnc1NEVjFoQmxUV3BWU0dIQVZEZmpxSnFtQkNnRytIakhx?=
 =?utf-8?B?NUtiMWhUaTJ5MTRGbnhVdC9YMWdoTlRqQ0p0bVl6VFdWeU5jRHRENDRSVFNL?=
 =?utf-8?B?Vzh2dDBNZ0dNWXI4d2JQVGhoQ0w0Q1JpMHdkUjBIeVpLck0walhMMkNyTkY1?=
 =?utf-8?B?dmdlQ3BhdExRcEs1TmVjQzZpanQyeXlNK0NvWVNqT2hFUVdrTlFYY0toV3lo?=
 =?utf-8?B?NTNiSkF3OTNlNTIvZk8rV2VFbTdRbWdwWjRwUTZ3dktucml1NjFSZEZlcXhh?=
 =?utf-8?B?MWpYNHQ3eVRKR0R5UnR6TEV2dFpmWndpOXVXWEN6STEvT1ZHMnd0TDVsVG5p?=
 =?utf-8?B?bnQyRmdmWEsxUWVML3FKSHIxS0xiUndVZ2dlVER0aSs0TlNlUllMdUtNbW5h?=
 =?utf-8?B?UlF4R3pJQnlpQzM1NmxWS1p4YlFZTGpua1pvamJlTzhSaVl5MEN0NWhBUkJY?=
 =?utf-8?B?WmZTQ0FIUUVBY21VRjBoWllBK2szQnFid2dDRWVEWndLRVFVVGpOQ0VOdzd0?=
 =?utf-8?B?eUczOHhnN1RwaXRPZnBTc0IrMkc1QU5hbXBKMU54RXdZZFdzSmhSMzJTdEpD?=
 =?utf-8?B?dU1mREQzKzAxQ2xWT1BTVXNCV00zVTd1aThwWTFBQkYwbkJUZ29aK01TNzNo?=
 =?utf-8?B?TVNVL01aQmdwTElFeXFucEJzM1AraVZoZ2c3VndNcVREVFJXMlIrajdFSVd3?=
 =?utf-8?B?c0I2UkJoTW92TXpEZm94VDVCZTgwbklQZmRrd0h0NkltaC9Tb0lweXhmZXRr?=
 =?utf-8?B?MEtuNFZEUWZWTWZHOGtGa1l0Mkt0UndBeTBvc1hha0VKSXcweE9BeFN6c1J1?=
 =?utf-8?B?blFFNXREQ09NT2p0VGtnMlpvN3ZiMjZrSUttaVAvYlBudmJjTHdpVDJMbHpi?=
 =?utf-8?B?emhoT2lTN09Ga3B0TWxvYis2ZmNPc0tocjdiNzRFemgzZXc4cUVpVmx0a3Y2?=
 =?utf-8?B?SjMyTDZJUWpEQVlPUmM0ZlprYmdETUdTbk4rcjE3TWh0Yk5jNWJ2d3hQWCtr?=
 =?utf-8?B?czUrMG5XWWpxdUNuVHdtbmdLWkZkem1WUm1GRHpwNzdBVDVUN2tFUk5aTFlq?=
 =?utf-8?B?TzZldVZpKzl0WDdtU3hkVzNGdFQ1RFdMMFBoM09hUU1Zc3JDZU9TdW1Ra3pG?=
 =?utf-8?B?Yk5sQ3BnOTdwRXNTMjFRWk5TRWVvZ3hHajMrK0ZPWmxuM0liQ2ZScGM0b2Rn?=
 =?utf-8?B?TW1tc0x5NmNrUEFGUEhjWHNiNDhucUtpV05uckxHT2s2RlFRc0tXN1IzdmVN?=
 =?utf-8?Q?mqK8gUWDgYXAqRNX82QWR2yO09XLaY4izFOV2aFdTKuL?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <783C81A9A17BC54090C629337411B21E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e4ca96-0bdc-443e-a84e-08dc222a573c
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2024 07:00:42.7009
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 71JqpTPpuw4vf+OYe2U9SFugPqux4bPQ1J4mtXlyWpQIi6qlAwoLLQ0HUgs5pEyOWjmFYM/m+xAfxJwH5FyogA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4966

T24gMS8yMi8yNCAwOTo0NywgU3RlZmFuIEhham5vY3ppIHdyb3RlOg0KPiBPbiBNb24sIDggSmFu
IDIwMjQgYXQgMjI6MzMsIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEuY29t
PiB3cm90ZToNCj4+IE9uIDExLzMwLzIzIDE3OjI1LCBTdGVmYW4gSGFqbm9jemkgd3JvdGU6DQo+
Pj4gT24gV2VkLCBOb3YgMjksIDIwMjMgYXQgMTE6MDE6MzNQTSAtMDgwMCwgQ2hhaXRhbnlhIEt1
bGthcm5pIHdyb3RlOg0KPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRp
b19ibGsuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fYmxrLmgNCj4+Pj4gaW5kZXggMzc0
NGU0ZGExYjJhLi5lZDg2NDE5NWFiMjYgMTAwNjQ0DQo+Pj4+IC0tLSBhL2luY2x1ZGUvdWFwaS9s
aW51eC92aXJ0aW9fYmxrLmgNCj4+Pj4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19i
bGsuaA0KPj4+PiBAQCAtMzE3LDYgKzMxNyw3IEBAIHN0cnVjdCB2aXJ0aW9fc2NzaV9pbmhkciB7
DQo+Pj4+ICAgICNkZWZpbmUgVklSVElPX0JMS19TX09LICAgICAgICAgICAgMA0KPj4+PiAgICAj
ZGVmaW5lIFZJUlRJT19CTEtfU19JT0VSUiAxDQo+Pj4+ICAgICNkZWZpbmUgVklSVElPX0JMS19T
X1VOU1VQUCAgICAgICAgMg0KPj4+PiArI2RlZmluZSBWSVJUSU9fQkxLX1NfVElNRU9VVCAgICAg
ICAgMw0KPj4+IFRoZSBzdHJ1Y3RzIGFuZCBjb25zdGFudHMgaW4gdGhpcyBoZWFkZXIgZmlsZSBj
b21lIGZyb20gdGhlIFZJUlRJTw0KPj4+IHNwZWNpZmljYXRpb24uIEFueXRoaW5nIGNoYW5nZWQg
aW4gdGhpcyBmaWxlIG11c3QgZmlyc3QgYmUgYWNjZXB0ZWQgaW50bw0KPj4+IHRoZSBWSVJUSU8g
c3BlYyBiZWNhdXNlIHRoaXMgaXMgdGhlIGhhcmR3YXJlIGludGVyZmFjZSBkZWZpbml0aW9uLg0K
Pj4+DQo+Pj4gVklSVElPX0JMS19TX1RJTUVPVVQgc2VlbXMgdG8gYmUgc3ludGhldGljIHZhbHVl
IHRoYXQgaXMgcHVyZWx5IHVzZWQgYnkNCj4+PiBzb2Z0d2FyZSwgbm90IHRoZSBkZXZpY2UuIE1h
eWJlIHRoZXJlIGlzIG5vIG5lZWQgdG8gdXBkYXRlIHRoZSBzcGVjLg0KPj4+IEp1c3QgYXZvaWQg
dXNpbmcgaW5faGRyLnN0YXR1cyB0byBzaWduYWwgdGltZW91dHMgYW5kIHVzZSBhIHNlcGFyYXRl
DQo+Pj4gZmxhZy9maWVsZCBpbnN0ZWFkIGluIGEgYmxvY2sgbGF5ZXIgb3IgdmlydGlvX2JsayBk
cml2ZXIgcmVxdWVzdCBzdHJ1Y3QuDQo+PiBJdCBpcyBhIHNwZWNpZmljIGVycm9yIGhlbmNlIEkn
dmUgYWRkZWQgdGhhdCBvbiB0aGUgc2ltaWxhciBsaW5lcywNCj4+IGRvIHlvdSBoYXZlIGEgc3Bl
Y2lmaWMgZmllbGQgaW4gbWluZCB0aGF0IHlvdSB3b3VsZCBwcmVmZXIgPw0KPiBJIGRpZG4ndCBo
YXZlIGEgc3BlY2lmaWMgZmxhZyBvciBmaWVsZCBpbiBtaW5kLCBidXQgaXQncyBwcm9iYWJseSBu
bw0KPiBsb25nZXIgbmVjZXNzYXJ5IGluIHYyIGJlY2F1c2UgdGhlIGNvZGUgbmVlZHMgdG8gd2Fp
dCBmb3IgdGhlIGRldmljZQ0KPiB0byBjb21wbGV0ZSB0aGUgcmVxdWVzdCBhbnl3YXkuDQo+DQo+
IFN0ZWZhbg0KDQp3aWxsIHNlbmQgdGhlIFYyIHNvb24sIHRoYW5rcyAuLi4NCg0KLWNrDQoNCg0K

