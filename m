Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 793A77E5067
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 07:40:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbjKHGkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 01:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbjKHGkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 01:40:43 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2061.outbound.protection.outlook.com [40.107.93.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6A185;
        Tue,  7 Nov 2023 22:40:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cfCC2Ai5JOpv9V6ACYLmnbjXztjxn0VMKR8tlhulxVWt1x7G7E21TiMSdHAJfW/rLjHH8u7kThwe2omTMavir2fuZ+Vf3fKfQudkjirDVoXp/UBfId9+W/oeJU49jfmBKkRU4HG7C7SyggEZi7zIof+lSKjzJZwffoZ/ixse74lxtXxMtMNrZABPRtj0wKn6j0lWgggRMmKejj4PuSj5hj6sZ2guokebMXEbBXuXY9jvCII+3f42f5V/L+LoC8FjL+gaRBV3yOwMfQANiexGgi3+q/hnr1JhBgx5k9CUzf1mSbw21zF9CkVO9jHIIlAJzAHzDB1ilus+NzRijXQ+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vw5X6Zj6LXOVgS6TrDRtGJePdq6Kt700Hd24ubzIb3I=;
 b=jUnjdmSa9/T3Y+wG29nmT9B4kZ/cLosUZmMUuYvHgQHLa+gv8dZ+Uw5RsY+SHZJD61XugttLCxhoUpi3cezCO8dM2PHyLX76dT2rdXTTSB3YWqtyab8mV4Ml6/5e6NWHywuNAfC88b2pzeFkX40BSvPwgNsoZxso/VL3EKzBFTSZ/5pEH5Y00+Lw85cm7jSl/ijjUzzcovnQFmiCO+pXW+ObmeA3FlYr4c5YoaECN8ffD1Q38WFfeWGQLfclmfPOF+y75mtaSWECert+r8l9hHn8zukHBlaNXvOHqfuuZg8Tr3nKLrVIynqllBlzFhr5vSBAxTsgWBwuHHt0Pg2CeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vw5X6Zj6LXOVgS6TrDRtGJePdq6Kt700Hd24ubzIb3I=;
 b=Zt02oOUMTFb7TD8UbkPevAt2/fcTdszu+PENA/+Si6cEC95buYhkYKqLQBNfE3vgp/eltCzPrUPTHNquCrR01zkkvumatwpXAXiMLeARE8tDlcOPHquircnipEaDyptbzAq7i9KsMxtrrJ91ae8GQsXCqcgvUW+jkxLxVq64mCFTO73AvW8qRVDFCYZGCPtCsrz5nmWrJt0oDx5lQPMwOAyTSV7v5dkCFwTm1ytNjL8FPoyX/R2Y0b8m1Zb/VLUYCl62AVl9s/kfPJgxqJVnv/Z7tOHpUsxujKRnTbS2lSD6tOpmf+BNI47sGMEh7LtFg4qI5sHmu5dBwpZE+E7eNA==
Received: from CYXPR12MB9386.namprd12.prod.outlook.com (2603:10b6:930:de::20)
 by DM6PR12MB4385.namprd12.prod.outlook.com (2603:10b6:5:2a6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Wed, 8 Nov
 2023 06:40:38 +0000
Received: from CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64]) by CYXPR12MB9386.namprd12.prod.outlook.com
 ([fe80::78d0:a51c:4795:9f64%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 06:40:38 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Edward Adam Davis <eadavis@qq.com>,
        "syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com" 
        <syzbot+fcc47ba2476570cbbeb0@syzkaller.appspotmail.com>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH] null_blk: fix warning in blk_mq_start_request
Thread-Topic: [PATCH] null_blk: fix warning in blk_mq_start_request
Thread-Index: AQHaEe758r95S8dmJEebn2yZ4dl9U7Bv+RuA
Date:   Wed, 8 Nov 2023 06:40:38 +0000
Message-ID: <c2eee1f6-c060-4fd3-b161-2ce98a778b89@nvidia.com>
References: <0000000000000e6aac06098aee0c@google.com>
 <tencent_03A5938DE6921DDDE9DD921956CFAD0DE007@qq.com>
In-Reply-To: <tencent_03A5938DE6921DDDE9DD921956CFAD0DE007@qq.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYXPR12MB9386:EE_|DM6PR12MB4385:EE_
x-ms-office365-filtering-correlation-id: 488f1681-6b8a-4acf-8d33-08dbe0259e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8hGZZpVUj2gBot0sCyAeymHIHudb7hs3lZ6Y/2wAF46pKN97x12ecJL8M/9cu9etFYJiMr5aN4JQK6L4xtZ7d2fmXD9BI7RGZPl404AkhMEl+oTxIQNK9g2Z1KTOf8kbbvgWBdg99qNYXJwtMiemZcocas7i78iz/oow7nFpKGr2mrhLBOLDFXd6Aumin2g7nbjL0T3d0Vg0teNri/OjI9G9vZJH9PJtR69QU2ddkWoncyLciScfzD5Hir/NptunaFwSd6uFj7yULJrGnydzFAg6ot/LKlaeIFonNa0APYzxKLKIgFJ61wiTUKE2zt18+r5QDSBcUTrX5m91x7mDCNCXpjEdCYi26hFjOa9Th8NXjdi8Qc3whICgBbrdn3EEF/ssrp/1/0kBg41Kb80BY4EynTP/7xwXkYiAZAbo+pcq1fpbOPUW0ai3iLhQqyrZ5rpA/fyccHnmAvMjvqC9n0Bpyv62JBW7zuPYK23+hkvJlz2ATGHLOrLgk2R5AT0FdDQfqUaOM4udtTG2l731obHv+jyA59IPkgRwdLgGt9k7fgc5Ltf9BdknIKnCmqj0umPLlCwrx4bHmobz4E6+rS1n5nWHL/ZdsW1+89oVsgnYm7/wuofwdh4ru2MQWpM6oPATWYtdTJ90e2uhkBjbN0LPJcBAjg+ZRC3xv1WSpnrrvdxCY9sQt8JeIy5X8Otr
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CYXPR12MB9386.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(186009)(451199024)(64100799003)(1800799009)(122000001)(2616005)(6512007)(31696002)(6486002)(478600001)(36756003)(110136005)(66446008)(64756008)(66476007)(54906003)(66946007)(66556008)(76116006)(316002)(91956017)(38070700009)(53546011)(6506007)(71200400001)(8676002)(4326008)(8936002)(2906002)(38100700002)(4744005)(41300700001)(5660300002)(86362001)(83380400001)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cHplUTBMZlhXUWc0dTN2YmtrN2pSWHZvTUQrWlVKUy9EMmdUaE1KTCt4RVIx?=
 =?utf-8?B?Y1lnZmlvTExlRXJqT3hWclRmM09zMjBmcThoSk11bnlKejNIeitjTVd5MHR0?=
 =?utf-8?B?bWp3K2RlVGloZFVkN2x6VTR4QmN2bkZkSndqMmJnUHVvQjg5OUQ3eGVmRzdk?=
 =?utf-8?B?QUlQVXU2VVRkeVZ3N3IzUGE5dTkzb3M3K1ZYZ3BOQUNNbEhGcXdoTUx4K01k?=
 =?utf-8?B?aEFJNTkzNU8vditnZDhmY214aXVvdldNQXFhSEQ5UGpQU083Qk9teGhIUjN1?=
 =?utf-8?B?UW1pTnRPQnZTRHZFcndyeEtrTzlnY1BCR0xMYjZvQ3duZS9Fc3B0KzU5cXJ5?=
 =?utf-8?B?UmdmbHc2R1JCR0IxdTVuK21KaGZmSzZ3RXZQS2lBeDV0aElMenZ5Q2RvNmp2?=
 =?utf-8?B?OVhmSVB0cENBTStzZEZ3QnZkYmdTUkpQMEU5UksxdFJHZ0hYTnRGUTdTcjBx?=
 =?utf-8?B?ZzhCRXFza2pDTHJVZ2VCSEFRTEwwU2RISG1BTGk1QXFYbS9tWmJqYjFFNThR?=
 =?utf-8?B?czIvUm5Qc1FWdDVLd3J3d25rOVRYQWgzaFlxbitGckVHVS84UFZGOS9USTg0?=
 =?utf-8?B?V0pNWUJGaUplRWpLM0N0WUh2b1BYekw1bk1WV1ArdnhJVTZ6aWNXVGgxQ1p6?=
 =?utf-8?B?cWZSYUQwZ0M4RWZRa1V6U0srQU5NYWQzOStSWXBtVithd2dKcHYvdHMybmQ3?=
 =?utf-8?B?YlhyS2l3TWFjeGtFZTZaanZnbmxxd29YemYraFZqejYyWWJDQTZiUHI0THRw?=
 =?utf-8?B?aXBEenUrbmt2SHhZaWx1OFgxR3B4S1pRb05MdGxneUFiWjkrUTArVS9XR0w1?=
 =?utf-8?B?UGthM1N2ajVSNldtM2xFQjFLTStsZUt1bWU3NE04OUdrQUI0MzN4bW05UGFy?=
 =?utf-8?B?TEtPSVh0RHA0ZnVKU1cxR1c5c2l1R1dhTUJWSFBFR1U0cUdIWHh0SnNLVVhZ?=
 =?utf-8?B?NERGQVQ5RkhNcU5YaGUwamRucUNBOXl0dWVHVnVKY3lkck5SanJsVld2R05F?=
 =?utf-8?B?dFlHdGRXUjJjUXlILzM2T0NrcWwvTGZxR0d3cUo2OXFxdEVmMFVTdUgyd2JY?=
 =?utf-8?B?NDM0ZHJISGVmY0Z2Zk5UN0pHcGlwWDVIMnIrdi9hbzlhMUNrMnkyR2ZPaHFn?=
 =?utf-8?B?dXBiUnJ6c3pGZE9ob0xrd1NxRUVEL2tCZ1NvUVNtdnhWUUlGQnNxbTE3eThr?=
 =?utf-8?B?dlgyWklZbHJHWG5pZ1hZOHpiZ3Q0R1FleG94cmJNdVF2UC80dExEbHZwbktD?=
 =?utf-8?B?MHFtaThUeEd4QitrNlJmaWNZMUxaRk9mN2hEbjBEVWNlbUk0OHowKzE2Z3JW?=
 =?utf-8?B?UmJ3dmdwK25nazk0MisxdFFJZjc0ZVhFd1lNMzVjUG9udm9SQkh1SThRTFBD?=
 =?utf-8?B?MDRQaHRoeW95d2VuNHBSSGZsUGRPZlRCYVJDbEZtRTV1ZnhEUGhCRklsTlBN?=
 =?utf-8?B?ekN4NG1zU0hmbjNzc1lzNGd1UjF2RDNZbUpyL3dqT0JRdjc5cndQcytEdE5N?=
 =?utf-8?B?WXpYQno1OFZRNWlMUzYzeDZ1cE4xN1lGY2VTRngwZkVqVjhSZHloUVBUTm5z?=
 =?utf-8?B?RVB5VTNHMGtDYy9ZTVpDYkZVeXFocTBJMzNyTTFCcVZ2MmwvcXZBTFVGcnhH?=
 =?utf-8?B?SG1HYjBTQlBTaWgyclJqa01oR2M3aisxSG95RG1TdWJPMEwyNDFyY0JhZ2xT?=
 =?utf-8?B?emFsVkN2c0dxdCs0MlhOMWVwR2NXY1h5cW8rYXdidUNZa2FjcUdCd1FoaFBF?=
 =?utf-8?B?WENxOUc1QmMwa3IzUzZoc1lNT3FicGdHWlBVbStua0pEd2RidlpZSDhtNzNM?=
 =?utf-8?B?N1ZBbW02RVNjK2R0bGpVU2RKRDlQNEFvY2Rhb3pUeEFMS3NMR3YxUVNweTlS?=
 =?utf-8?B?OFhOZ1NGUDhDRlFpcFFqT1JieU9wbkdJS2NjNkdvUUFneGU3MDdHc21vU0hs?=
 =?utf-8?B?M2tYeCs3NGthWFJuSFh6U0dDbnZrWDJOeUNUdmFQZEtQcVFMd0tJbUQxclZJ?=
 =?utf-8?B?T3dEL3RSNmtyaWJmZ1NRNWZiUFhsdEJTSHhIK29obVJlNjVVOSszOVUyRm1l?=
 =?utf-8?B?YW82N1JHcVBxUVlpa3F4ZEFOVU5PWnloRDg0Ti9Gb0tWSERaRnBWUWNVQkJQ?=
 =?utf-8?B?d01MK0gybitDM1pmc0tZbDd3YVpxaWVVOU1RS3VXRDRYWjhtYmx6bzhleTR0?=
 =?utf-8?Q?i01DZX3x7E4ineGbNUkiVp3Rw0qx16I7YyFbQ2mWr88c?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BB948CD40829B4E9BDEACE4C3792B03@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYXPR12MB9386.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 488f1681-6b8a-4acf-8d33-08dbe0259e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 06:40:38.0137
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LEN+oBtLSe5iXZEB51dER6SftfMlTlVhQKOgn8NZ166IfhceEON2llb5dQLn+Lhe2uL8jgr/NcEAoyZSHp78ZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4385
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTEvNy8yMDIzIDY6NDYgUE0sIEVkd2FyZCBBZGFtIERhdmlzIHdyb3RlOg0KPiBCZWZvcmUg
Y2FsbCBibGtfbXFfc3RhcnRfcmVxdWVzdCgpIGluIG51bGxfcXVldWVfcnEoKSwgaW5pdGlhbGl6
ZSBycS0+c3RhdGUgdG8NCj4gTVFfUlFfSURMRS4NCj4gDQo+IFJlcG9ydGVkLWFuZC10ZXN0ZWQt
Ynk6IHN5emJvdCtmY2M0N2JhMjQ3NjU3MGNiYmViMEBzeXprYWxsZXIuYXBwc3BvdG1haWwuY29t
DQo+IFNpZ25lZC1vZmYtYnk6IEVkd2FyZCBBZGFtIERhdmlzIDxlYWRhdmlzQHFxLmNvbT4NCj4g
LS0tDQoNCmRvIHlvdSBoYXZlIHRoZSBhY3R1YWwgcmVwb3J0IGZyb20gc3l6a2FsbGVyID8NCg0K
LWNrDQoNCg0K
