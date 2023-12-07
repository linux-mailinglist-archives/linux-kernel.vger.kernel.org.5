Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1000E808643
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:02:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378575AbjLGJsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 04:48:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLGJsG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 04:48:06 -0500
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2071.outbound.protection.outlook.com [40.107.243.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BB6AC;
        Thu,  7 Dec 2023 01:48:12 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P8aWNyPkBTJlsIRMCw2o76WVg/iAiBYvjGGFtIJypv8NPUrLbRTbu2ExOKby01lyi+h7xQJOR3E53wn7OcJkELjpx5DYoiDpPL20XpBdXl5hr00VBIykka7Q4cf/AM7Z2+MvTXUqQUIEStZSye54UNv90aw/73yCDDw7Jip89gCugzbOwIW5X2OWVscaV8uJ3nw3XHi3TlgJDB29ruRH/OsL007mKoFPVgFS2o1b5RZyyXPVeAIjUNOrBt4boDTqiF9AgGz2RsbYSlfv+OhsJKIiD8UeqSPjPLteMht2NatchamPqkLLYqFewdfhGQeH4MMi8kXGVL/fWE61Zlr/Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Z6T/8svJ5oBXGPaCjzQ5fR48bbUWnWzPrE25qfV45I=;
 b=RaIs7S33uXQB8ziVp+jOhMkxyVOnZw1EpYcQUE5jc7dt2eHz3yw6feQLeuwMJx1BKoMUs9ui9kJb0recDZpjyKrUhl4NtlksMZTJjcrqChxmv9zN4fvv3T36mpMaqy+bSmzhPu9DggRDQakVpNp9vvke36Ss5NK/6t0yLe0/ITMMuFP3f4ZaxMh3RWUuteLLTRb/qysWXNFzOCD2Hj48sbelj7JhI0P22oZqDSA6Hhjnplz3xGmSgTYLb2CNg/V/sZeZuZW8f7mSHZqQv9JONx4ppN0uiCu4AhH7+CYB/w3jL2vqF5ODHGkCCjrWfqtNoMXX+R/hT+zviUYfRegb3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Z6T/8svJ5oBXGPaCjzQ5fR48bbUWnWzPrE25qfV45I=;
 b=pWpz4vNfJyocpg+Eov4TH7mUPFU8EidTSfTh3tbFKsihcImnF1Kr5DhgDxefaU8JKfaBnexDtCilLX+KIJJtILjP1qzH9mpxXmWruAR1AGZzLfZLNJ7kx30V2YT/2S2jXArw29ReldVSmPtuABkmbWCJAKjTEZ8n9LWdRS5yc5ZmPsXv1pmFNa/0nTYTdUxFhDWAXn5+SJFZTIK6IREWFPg3rWmdtHvcYsnbSiIxq9CMekwlWfeVEENASj0nA5CVBRlxLTAIciCvQBVSjJu6dS0hwLoyVxocfjHLxkzYW4gFkBGAX3nKZVnxJY189xwLIjg6dnTRH7Ca4p2lA1Cc/A==
Received: from LV3PR12MB9404.namprd12.prod.outlook.com (2603:10b6:408:219::9)
 by LV3PR12MB9403.namprd12.prod.outlook.com (2603:10b6:408:217::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.27; Thu, 7 Dec
 2023 09:48:09 +0000
Received: from LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762]) by LV3PR12MB9404.namprd12.prod.outlook.com
 ([fe80::efb1:c686:d73d:2762%7]) with mapi id 15.20.7068.027; Thu, 7 Dec 2023
 09:48:09 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Li Feng <fengli@smartx.com>
CC:     Jens Axboe <axboe@kernel.dk>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Stefan Hajnoczi <stefanha@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:VIRTIO BLOCK AND SCSI DRIVERS" 
        <virtualization@lists.linux.dev>
Subject: Re: [PATCH] virtio_blk: set the default scheduler to none
Thread-Topic: [PATCH] virtio_blk: set the default scheduler to none
Thread-Index: AQHaKMZ7r4KRZS/zvEOlcT827vufd7CdYsAAgAAHwgCAACjpgA==
Date:   Thu, 7 Dec 2023 09:48:09 +0000
Message-ID: <b9c8309a-6263-4eca-b2f0-2262bb43e81c@nvidia.com>
References: <20231207043118.118158-1-fengli@smartx.com>
 <9b963af6-0a3f-4957-9227-43673e70b720@nvidia.com>
 <ADCE81A1-D65A-41C4-A485-66E1B056B1CC@smartx.com>
In-Reply-To: <ADCE81A1-D65A-41C4-A485-66E1B056B1CC@smartx.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV3PR12MB9404:EE_|LV3PR12MB9403:EE_
x-ms-office365-filtering-correlation-id: 698df1ed-9e59-4842-5db0-08dbf7099f07
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aE2f0yx0cmAMukIQPvRoRjGHq0Py9n+OWJFwqH29kjUVMD7cWuWgAtf2U2SgNC2DHNp5MKcmGkbUjzWYDP+BO7Fc5c+LNH1MLJ2qkloFvhV/mZNnrkwr+Qtv/bICdGUKLHJag1QvFpTiAxnONtyTGQb58vRU8gCdwK323RyrV6LFIIjswNN0dAnAJDObFVfQ1oTnyMqskZTwYEvxZZsn/6RZ8dgtYvBVo0fBO0/iQWlN+17iWNebk5NH2PdkLGM93faHPjbD42UdG/3wHhMQ4b8vLxCklHhJn5ji/y6ygHZHIWZAjqa+RFNUz1CMi426E02E/CjaWPmxg5ci1QwiPsDlb13g31yEZNsEQrWjxw/CjWFKgFBBZ7OSI1XehS1yKPeSSEI7G2FlXk+H1PrZyOgy2eVnQxY6zA4UYwxd/f8z7RO2GtMKVxTIjkugwYbwYZzm0a6F20+TcSz++tL9JW82ptWkwB84XI+C+l2iB0CsjujHHeChi/kdRH30caj9AvQbToNy8utTPfYQ/NmfxgSFMiIB3TADRf3nFX5YXy8jxGXxZMX8B2dwcT80zlcCwwkmEcWBHourbRdD0rYNEbDGS+cdj/j0CXeCw5m63iTecfi/UNIRZqDzxrJB7np1s4wzKR+meSeNKoeoLmUOUf/XiXZhMjzvDOXtqV2KC/jf4fOtfpwjY7tuaSDjmkYJ
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR12MB9404.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(376002)(396003)(366004)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(2906002)(7416002)(4326008)(8936002)(8676002)(5660300002)(31686004)(316002)(31696002)(66556008)(66446008)(76116006)(66476007)(6916009)(91956017)(38100700002)(66946007)(54906003)(64756008)(86362001)(122000001)(6486002)(478600001)(36756003)(41300700001)(71200400001)(6506007)(6512007)(53546011)(2616005)(83380400001)(38070700009)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TWNVWVhDdytJWjJHdEFMT2xmM2xsMlN3VFhtZWRCeWJIWFJ1aWlCNklIazc4?=
 =?utf-8?B?QkVKQ3ZlRG1rbUlLR0hjY1Y5VHpnYkVyeHZoYnFobElTcjcvSVMxUmE2aS85?=
 =?utf-8?B?TzRQY2ZqN1laVjRzcU5Oay9TMEVWcDhMQkU3TlNtN1hrcStMWC8wSzNwOU1U?=
 =?utf-8?B?U0tGUmQwTGRNWVRDaTB6QzdKNHFNQnZ2SDY3dSs1NDJOdnpsS3p6aksxeXlE?=
 =?utf-8?B?Q0hudDdmRGVROEpxV3NhdzZDTXNoNVh4VXFuUkR4ZXRTRFZUMDNFY1Rhcmt5?=
 =?utf-8?B?VTU5MGxkVkhyanM4L1ZvMlU5cFhBOVpSSXVwbDMwdk1HVHBKLzlPYXo5SGV3?=
 =?utf-8?B?WVdyV1RBSUpjYmdyRStUTm81M2pIdEo2ZHl1SzR2c0tSMldaM01SWjlkRU1n?=
 =?utf-8?B?TkZFTmRZNnFNYWVITFV4TG12L1NvcWRzTzJaSkRoT1dxNHFOZ2NoYTFBK1pS?=
 =?utf-8?B?WndxOXlhVlFBQ3hjdUtqTGJkcy9BNzNVbzBFdmZrSkg1SmNCay9NdkxoaVh6?=
 =?utf-8?B?Ly9OWms4YVkwN2tYcWZ5QTJDeWY3eW5Gcll3UDQwMm85WVBxMEZEb3ZqNVFy?=
 =?utf-8?B?czVxUEJPaDIwK09iay9RNi82dkU5Wkx5dWtBWWtweFUvV2kzZ01wT2ozVWxX?=
 =?utf-8?B?WDdQWlZmOFc4MHE0Wk8rWm9ESjFaeXRIMGlMVGkzcHIyRGlYTmpMMzhUSlJD?=
 =?utf-8?B?bms2QTVaRnYzMmkzMVJXNmxVSzlEMWQ3R1N4NlZ2UnBqbVduc2RMTkIyV2dj?=
 =?utf-8?B?YlRvblZOd0p2RFUwbVB1Z0lVNCtnZ09oNjEwQlhBMEZxZ2ZlUGFSNjNoNGk4?=
 =?utf-8?B?cVB0V1FSR2xZcS8zZTNEZ3MzdXBXSHJjTlEwcnNWaTlRYzVXVnlMVG9uanh5?=
 =?utf-8?B?eHJMNFh1emM2bkd5ZWFqdXpMWlIvd1lUNG1hc042ZS9DeFFacXQzYS84ZGlw?=
 =?utf-8?B?VUVxVHNUbjNNVkNWdGU5VDZPdDM0ZncyOENXb0o4dnc3d2R1TkY0YzVxUVJE?=
 =?utf-8?B?SGZyQjlKMnZPRnY0ZEhzNkpacTVLQi9VNjRGYmxRTy9xdU9kbVFWYTBsclla?=
 =?utf-8?B?Sk9oVEJhT2pLbktEeExNWDUwUTFIZ1h1WUY5TXFyZFdVT2p2bjZXRTlUWHhj?=
 =?utf-8?B?RmVoeVZhL1dHcXJNOXA5aHA1STBXZTUrUUpIWk5xZ2FKa2svUHJjSmVUMk94?=
 =?utf-8?B?VEpadjYzUGxEbndkT3c0dDdyMTVmck1QTENycXBjNWZYeExkd1ZMa0pYRnRO?=
 =?utf-8?B?RjQ3MFdwMzgyNzVyYVFSOUN4Y0Vabk9KeUFDRjZHNmJTMkZocU9PQ2IxTmpq?=
 =?utf-8?B?VkdWbk04L3plRHJ6dnRxdGNBS25QVlJpZExkTXFwNmdyN0hzdU0rQ1BmQVh0?=
 =?utf-8?B?YUlaV1BseFRvd1pyWmFBMXNQMFV5WFppbnAvUDQ2OFBBWkRjMlMrdmI3RFZ5?=
 =?utf-8?B?ZEx6cGo4Rml1cXM5QW9Gam8vbitaSTI2VXd1MkVxcmxud1dTd212V3ViK2ZS?=
 =?utf-8?B?eVhJSGF3L0dTcU5uMkZRdUgyYnZvdW0xYXEvNHUySkRGaXRvTUErK3hnQVRT?=
 =?utf-8?B?aStZdjZ4bUZwQXp5MXJpNkRzY2ZMNDkxVFBpakRYWk9kNS9iaXVicVQzSVBP?=
 =?utf-8?B?VVdZdmd6ZnNKeFJFeTNpRXozK0Q3S2RZZ05mdkQ1TU5mMGp2V2d2eHRpYXBE?=
 =?utf-8?B?SkRzUjNBSllYUGU5bWNXbmZmTkMxanFSNC8xTS9KU1MxSmRTR0FiZnNSZTMv?=
 =?utf-8?B?SDdOcS93cGlUVWdvVWQ2SzRQekRjQ284T2k2d0NQODA4MDM2eUtMTEhvM0xU?=
 =?utf-8?B?WTBuV25BeHhrVmR1ZzVpMHgzNk81VDFtVFFLRXJZVW9VdDdsOWkyS0JRaU91?=
 =?utf-8?B?QnA2a0wyY3VhSmIwZnZaUHR0cGlpRUJLaTlYdjFnNjUxc0J0dS9PNS9UTWpM?=
 =?utf-8?B?OFAwSVdkbTlDdE9yeERjamRQR3pqMTlyMDB2Tm9Scjh4cjdHL3R1NGNRMkNW?=
 =?utf-8?B?OW1MaVlkdmtRTm0zUU1aRm12aUxrMy9lNjYwbCtZdFpxMm56VWxhdkVIbHVl?=
 =?utf-8?B?OFljMmFDcGMvQ3hFMWliZFJrTlRhZjZKOTZMVXR4ZHkzOEQwT3VwcExIQ1Bp?=
 =?utf-8?B?V0lWa1FhU0x0WFBzekJiTjBxUjVtZEtoaG54aEdXMmVWSzB2aHhTMURoUG9k?=
 =?utf-8?Q?vCQ4+E5OlGtclVvWXQayj4X3PNNjlpGhzXJueuLmwpzW?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A92F69F09AA2841BDD8FCC341F1941C@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV3PR12MB9404.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 698df1ed-9e59-4842-5db0-08dbf7099f07
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Dec 2023 09:48:09.7624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OdlKs8xpW2WmXf9fTbzRSN+I9TIFyQVRp+T0YHZSc+uckdLoA4xeLrSmNr6r3uGp6x7BQfVxmKi4VyMBs9M0Lg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9403
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMTIvNi8yMDIzIDExOjIxIFBNLCBMaSBGZW5nIHdyb3RlOg0KPiANCj4gDQo+PiBPbiBEZWMg
NywgMjAyMywgYXQgMTQ6NTMsIENoYWl0YW55YSBLdWxrYXJuaSA8Y2hhaXRhbnlha0BudmlkaWEu
Y29tPiB3cm90ZToNCj4+DQo+PiBPbiAxMi82LzIzIDIwOjMxLCBMaSBGZW5nIHdyb3RlOg0KPj4+
IHZpcnRpby1ibGsgaXMgZ2VuZXJhbGx5IHVzZWQgaW4gY2xvdWQgY29tcHV0aW5nIHNjZW5hcmlv
cywgd2hlcmUgdGhlDQo+Pj4gcGVyZm9ybWFuY2Ugb2YgdmlydHVhbCBkaXNrcyBpcyB2ZXJ5IGlt
cG9ydGFudC4gVGhlIG1xLWRlYWRsaW5lIHNjaGVkdWxlcg0KPj4+IGhhcyBhIGJpZyBwZXJmb3Jt
YW5jZSBkcm9wIGNvbXBhcmVkIHRvIG5vbmUgd2l0aCBzaW5nbGUgcXVldWUuIEluIG15IHRlc3Rz
LA0KPj4+IG1xLWRlYWRsaW5lIDRrIHJlYWRyZWFkIGlvcHMgd2VyZSAyNzBrIGNvbXBhcmVkIHRv
IDQ1MGsgZm9yIG5vbmUuIFNvIGhlcmUNCj4+PiB0aGUgZGVmYXVsdCBzY2hlZHVsZXIgb2Ygdmly
dGlvLWJsayBpcyBzZXQgdG8gIm5vbmUiLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogTGkgRmVu
ZyA8ZmVuZ2xpQHNtYXJ0eC5jb20+DQo+Pj4gLS0tDQo+Pj4NCj4+DQo+PiBUaGlzIHBhdGNoIGxv
b2tzIGdvb2QgdG8gbWUsIGhvd2V2ZXIgSSdkIHVwZGF0ZSB0aGUgY29tbWl0IGxvZyBhbmQgYWRk
DQo+PiBwZXJmb3JtYW5jZSBudW1iZXJzIGZvciB0aGUgbm9uLW1xIGNhc2UgYWxzbywganVzdCBp
bi1jYXNlIHRvIHNob3cgdGhhdCB3ZQ0KPj4gYXJlIG5vdCBicmVha2luZyBub24tbXEgc2V0dXAu
DQo+Pg0KPj4gQmVpbmcgc2FpZCB0aGF0LCBpbiBjYXNlIHdlIHdhbnQgdG8gYmUgZnV0dXJlIHBy
b29mLCB3ZSBjYW4gYWxzbyB0aGluayBvZg0KPj4gYWRkaW5nIGEgbW9kdWxlIHBhcmFtIHNvIGlm
IHNvbWVvbmUgY29tZXMgd2l0aCBhIHNjZW5hcmlvIHdoZXJlIE5PX1NDSEVEIGlzDQo+PiBub3Qg
cHJvdmlkaW5nIHRoZSBwZXJmb3JtYW5jZSB0aGVuIHRoZXkgY2FuIGp1c3QgdXNlIHRoZSBtb2R1
bGUgcGFyYW1ldGVyDQo+PiBpbnN0ZWFkIG9mIGFnYWluIGVkaXRpbmcgdGhlIGNvZGUsIGlycmVz
cGVjdGl2ZSBvZiB0aGF0IDotDQo+Pg0KPj4gUmV2aWV3ZWQtYnk6IENoYWl0YW55YSBLdWxrYXJu
aSA8a2NoQG52aWRpYS5jb20+DQo+Pg0KPj4gLWNrDQo+IA0KPiBIaSBjaywNCj4gDQo+IFdoYXQg
SSBwdXQgYWJvdmUoNDUwayB2cyAyNzBrKSBpcyB0aGUgZGF0YSBvZiBzaW5nbGUgcXVldWUobm9u
LW1xKS4gSSB0aGluaw0KPiB3ZSBkb27igJl0IG5lZWQgdG8gYWRkIG1vZHVsZSBwYXJhbWV0ZXJz
IGJlY2F1c2UgdGhlIHNjaGVkdWxlciBjYW4gYmUgbW9kaWZpZWQNCj4gdGhyb3VnaCBzeXNmcy4N
Cj4gDQo+IFRoYW5rcy4NCg0Kb2theS4NCg0KLWNrDQoNCg0KDQo=
