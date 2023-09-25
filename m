Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E01A97AD6E1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 13:21:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjIYLV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 07:21:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbjIYLV5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 07:21:57 -0400
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 25 Sep 2023 04:21:46 PDT
Received: from mx0a-00549402.pphosted.com (mx0a-00549402.pphosted.com [205.220.166.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885CDC6;
        Mon, 25 Sep 2023 04:21:46 -0700 (PDT)
Received: from pps.filterd (m0233778.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 38P8fdPa014490;
        Mon, 25 Sep 2023 11:14:22 GMT
Received: from deu01-fr2-obe.outbound.protection.outlook.com (mail-fr2deu01lp2172.outbound.protection.outlook.com [104.47.11.172])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3t9pcw199v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 25 Sep 2023 11:14:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPfv5V39WZfh1xvbi8VzAR3FhEe9pTKEUvNJjX/4YihZ69NGaZTYynwSgxtlN8QR0oFw9PVFkAwu5WGZ8ufsUzzp5F8H7OdzDYvJflha+pbGmOnhRc2MiN2C6sVlVFUsZlGIYQX5XVQU2oV7GqoWdV3z+VbQb07cHhwCSzlfbzm+zsKF1FK1jRWGl4SogY1tG2ROWBROzTkfB/KEGMhYhyPo3UadafO4hWKsO7v9DZlMaEXzuK5i86XEU4Gxzo7mmg+uoqqIp+dFh9AzqupMiqmPqnV+8YX2VNwlLZ2wle2VMRsY67WkTz+ljQmIqBThOTFTTo7uZG37lLUBCcshqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0T/YQejBieogykh9xV7xGT8ZnK6RuwRWz0uP48KadE=;
 b=W3M1bFi7pj8oEGlh6Vmt6JOwxo8h/pQE/FzkfNyl7x34nfDf6sHOUNFbEael/Ei1QowUxxdVBGqsBjnwReYq9lFyytwxsJuI0isr6yTxKTgFRdZWZ0gMQtaMwmIhT2fZy2c+VpgMD8WHeqZEvT93iTpWsfqSzCJHwzLL0LRCzQIdMRwS+CdrbNpI54bNrBnb2VbBhd9MCwx74V7ISMveJ60Lvza5bxlSE3fSDmRUBtnIyfvnxLJ65g20oqDYg4jaJlriAjpMizhRxldD1eg4bqHyHbLb7T7WfCeazx8ed6tuTHAGpGyFI0NwkcDZbKxJ96+gm1cTv4Axtu2LtDU9dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0T/YQejBieogykh9xV7xGT8ZnK6RuwRWz0uP48KadE=;
 b=Oxwxwr2HHcd9MDctAZ3LT8NAtgh3PWtVsky1PC9e9eMHeEWXACQ9TZ6+RUg2vVJkC9jxEfzgSlh6z3uS1blNMpmZ2uUK8uGufkDH69y/X91NxJS7O5KjjTD0PDQhyUAGGG8zI6ctEG+h25mR1GCBa7uckRdc4YsK/U095xnbbc0lRL/ewaaEAI/ES6Bs2+Trk2tGx30CM8ub6fMReXmyMbmTIwzKFAgRohU/NKnV4W/1JPcsj4MlhZxYFmpu1MYrYBIrsJAFRi8qDmqRuNhDddPxXIBhwdMaGWqw4g0gyOa1lqSvGem15imIbz/CI90CFThQzsubRJ0urZd/GMDoeA==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE0P281MB0290.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Mon, 25 Sep
 2023 11:14:16 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::ae2b:f2de:3e65:280f%3]) with mapi id 15.20.6813.027; Mon, 25 Sep 2023
 11:14:16 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Andreas Kemnade <andreas@kemnade.info>
CC:     "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "bcousson@baylibre.com" <bcousson@baylibre.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "chenhuiz@axis.com" <chenhuiz@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
Subject: Re: [PATCH 2/3] iio: imu: mpu6050: add level shifter flag
Thread-Topic: [PATCH 2/3] iio: imu: mpu6050: add level shifter flag
Thread-Index: AQHZ7zY3QuDazFezFUiNU8j0F2ljRbArYqgAgAAAaP8=
Date:   Mon, 25 Sep 2023 11:14:16 +0000
Message-ID: <FR3P281MB17575CB2EC8CFD3D5D74EC0CCEFCA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20230924222559.2038721-1-andreas@kemnade.info>
 <20230924222559.2038721-3-andreas@kemnade.info>
 <CAHp75VfvmED4ZsmrH4B6m9kGsH=68-zjQd5JMszb6UBTtbF0bw@mail.gmail.com>
In-Reply-To: <CAHp75VfvmED4ZsmrH4B6m9kGsH=68-zjQd5JMszb6UBTtbF0bw@mail.gmail.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE0P281MB0290:EE_
x-ms-office365-filtering-correlation-id: af02785f-78e1-416d-135d-08dbbdb88e34
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: exBhKxnfi5goNB2IV+d8jl14JYt8yjMo8gVGt86/K8dMPyx1APbc/o5iVPySidXfj85X1kGMCUdpFaZ6gp0UgJN+O8gfwV51bi4IcjPKqiFRGm/01b7MMcQZjS1bi7YmwnYJRNzh+9/BTWXsGXUR0QNWcbt42O0ICPNSPJX6kd7alYUVnCsCYycd1mYxbiJfu9kMGUjQDVQS76b+5RGNs+q2+rOcqttIDYRVfdi5LJYAlv0p4w7kSQeheO9JGwIGV+2F6plI21FONbutRkyHhBwqqOuBCPQPPWknk2a7vnmQhUcw6KPh2iVT1YdjRJWV1wjY7rbp5bVLPdbJr0tb3ypHvQvDHETIhiaq1NTAkAk0Ud9ImWUhEsUWpGL+nzE4BUKOX1PW4SqoEa7YU7MzUihw6rnb/11RgIDKpbOuvjE6m+JY9p80BQBOrGM+IUzjvmnpATek33080MHUMMSDt7CPAOASZVeiM2lfwzhd5YuU3t05pM1nJso2uLBiPBUS13AcAVIFl2zT7zy36zNCUgD3B0m9449M8ympz4hqGqz0UNMNXFslmS91xfbMKckgt28seNfqjpDSadyXmsQLUe7AZW8Py37Bii5EvVfk1u+PLz+hSr9Zx2e1F7KF4qJAu9VrjCM3PicOIr2IbcawyFaUYjCwQXMSud2WbD2U+dY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(346002)(376002)(396003)(230922051799003)(186009)(1800799009)(451199024)(38070700005)(33656002)(38100700002)(86362001)(55016003)(53546011)(9686003)(2906002)(5660300002)(66476007)(478600001)(41300700001)(52536014)(316002)(76116006)(66556008)(54906003)(64756008)(66446008)(91956017)(110136005)(66946007)(7416002)(122000001)(7696005)(6506007)(71200400001)(83380400001)(4326008)(8676002)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WmFHSlJHK05WSjNlVEkyemROUnFabGpmUGR1WHpBVHV2YlRCU3lCQlRNTE5M?=
 =?utf-8?B?KzBsaHVYcERlVTVBbUNqWWJsRFJOMkZWcVlueFZYdDRXUXdIMWhpT1Jvc01u?=
 =?utf-8?B?cWc2L0hYVGw2REZla0dWR2VtUitWVDcyeHIvRmZxM1NGTzJBZC9oTGFkTExI?=
 =?utf-8?B?T2xkaE4zbENRVXJYR3dadDhkT016dE4yZVUwZXRrN1A4amo5T2dLL3lvVHdy?=
 =?utf-8?B?dE9kUVVsOXhCUm9NK2lXT0d6amxscHFEK1l3eHg2Y1hiNGVsZjhmdVdVd1g5?=
 =?utf-8?B?MjFaZlIzaVNKRjJ0NWZTODU4V2pGVXIwaThzRHZHQlBjQXRtKzdxOHNodVlF?=
 =?utf-8?B?Y2lxdURaWjBUSWpvVlN2a2ZSSkV0a045clV3Y2RqY1IyZXl2SmNqZVFaYWdy?=
 =?utf-8?B?TG92eTExdUxUVERxdWUvU25PMzdLV0VmZ0F1WlFBaCszMnlLb2pJYU1sK09l?=
 =?utf-8?B?ZGJPWWxRamc3MXNJQndJYkRHUW4xY3dtc0lzNG1qUUtkcGNGWkV1K0xjNDV6?=
 =?utf-8?B?emNTaTlIKzQwSWxjeEphY29HUXB5ci90YkhmNTdTdGIrdkkyNFQ0YjRoeEcz?=
 =?utf-8?B?TkdVVCt1MDNwVnpONFlNQjI1N3dxVVphQmszUnRIU2tsQmZzaW1tditwODBC?=
 =?utf-8?B?eEFDMDJwQklOaWdwYXE1NUQ1UWYyWWpiZzRwR1ZCMzlYZTI0Q2x3c2lKSEdh?=
 =?utf-8?B?aGpCNFRuNHU2SW9vb1dsejV6c2dEZmtlV0RBVmROOXM1RWk5Z2dpd0paUUJR?=
 =?utf-8?B?ZzRhcVM4N2huOG9uTlczK2xnWm9KRWx2dW56TUp1VVBmNGpYUVZnWWxoRmRR?=
 =?utf-8?B?UkJhYUtRM25FaVUrYkxWZjRXbXlmZWlaTFphVlRzVmk1NUxOemEranlOcjJT?=
 =?utf-8?B?WXVLb0c4Tk9QMUs0SnYxTzZHV1JpOFhBcXFuMURsRk94L0p1Q3RRR0hGL3Ir?=
 =?utf-8?B?VVh5UDVDZmhWVko0NE9BTDhEeTRoOHZ4Nnh4Y0NXcm1UWFJkV3JQenk5MkFl?=
 =?utf-8?B?RW10TDR2YzJrTGV0UzlxTlhmK2pHNUprREV6RFNqcXFJUDh1N1JmVGpXVWYy?=
 =?utf-8?B?R292UVRDNTBHelF6bHlmWGhVRXpoRkdqL0huUUoxbmdaRzhnRXp1NUdnZldu?=
 =?utf-8?B?bnc3bVVaMUQwWVZ6REpVQ3A2VFBPd3hUeDBadUo1MWhLWWpZRHNEaHpTdWp5?=
 =?utf-8?B?Zm9pVjRtbENic1pTbnVscmptNlEyWVkxY1BCQUZocFAvSnEzWXMrUXpKaFMx?=
 =?utf-8?B?WkM5UjUwOEZuTkxzUUpudlEzL2h6aHlqNUh2dkZZdjNDMlpqL2lNQTVWa2Js?=
 =?utf-8?B?TnhlVmdnRktLaUNUY0JXYnZuSVpEOGRMUHNsck5JOW42MFdIUnRlanZlNjZ0?=
 =?utf-8?B?b3FaQXFoOWQybGh6KzNGRC9NdnBBYzFBOTl5UCtSR002YjN5d0VkMzA1U2lG?=
 =?utf-8?B?V3djZjRya2pvZi9vallqOHk3L2hRTFRHRHJDZUIxOTZqVnFGUXNTNmlnWnU3?=
 =?utf-8?B?QUlSc2J5OWMvQi81TG12L0lFSUJpYXplTVI5L3AybWtFWGg0NHlYTEd3ZG4x?=
 =?utf-8?B?UG5LN3g0dWJ6Y1ZLT0h0Y3JtMHV2R0ZkdnlxaE5LdDFmdlBWWXB0TzBvbUY0?=
 =?utf-8?B?bkhXZFpmM0tkV2RKcGJSQ1JMZnZOREtLd2hFdjlaR241SUVxa3MrL2hTV0Jn?=
 =?utf-8?B?MmRVa3dhU0RrejBhTUtqdWt6dlRiQjVHbDlJTnhPQUE4cWJyOWlVaGp3Znd1?=
 =?utf-8?B?MmJ4Z2tZTnA0anB6Q21KSUQ4VVFtUnlGVWxUclY2djg2V0lsSnNIRUd3Zmts?=
 =?utf-8?B?czR0YlZEV0JWT0xDaXdkRThtdnBhQndQdHk3dDVtVXQ3b2dnWE05MEpIQitu?=
 =?utf-8?B?ZVNuMmtwUUZJUHdxYUxpS1Z3Zm1RMlRsR3lpQmU3Vm9BdHE4Z2IzY0R6YWcv?=
 =?utf-8?B?VlBQRzVaQlFJdzlhaDNOOGE4Uloza1dwSElqTE9PYVp5bHJYWTJRNE9xa0pk?=
 =?utf-8?B?a0VtamtIemZwZTR2N3hUK21tYkk5dUh5YUV4R2puTjBIWFU0djVwNjBUalFD?=
 =?utf-8?B?L3V4cmRhMUoxZTBIdURoeWtCeFZxWnFMaW1zcGUxTm82UVlNNlhBLzNXaGF1?=
 =?utf-8?B?eW9Od29ZUGREMXRHa3htQU45bFJGVUhkc1g0WVJ1ZUF0V2Jzd1V1TjZVNkk2?=
 =?utf-8?B?RUpPKzJRazVIT0lsbVkyTTdhYnNBUW4ySGY1Y25kK3NZSURxTE91cnlLNll1?=
 =?utf-8?B?b1dRSUFWVk9BeTlzd3VhNzF5Ykl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: af02785f-78e1-416d-135d-08dbbdb88e34
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Sep 2023 11:14:16.0349
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fdUezWr3FhW/dHu0kTN1ggbKzY7V+I1qsTQf+JtfUBUtEBlvfl8NuiJVr1QyFbhu9uS0eoMSoQPgfD3BsLQjAOthomyaDpcjsEe6PZAqJBk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE0P281MB0290
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-09-25_07,2023-09-21_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgp0aGVzZSBhcmUgdmVyeSBvbGQgdW5zdXBwb3J0ZWQgY2hpcHMsIHRodXMgdGhpcyBp
cyBub3Qgc29tZXRoaW5nIEkgY2FuIGVhc2lseSBmaW5kLiBFdmVuIGFmdGVyIGRvaW5nIHNvbWUg
YXJjaGFlb2xvZ3kuCgpCdXQgd2hlbiBsb29raW5nIGF0IHJlZ2lzdGVyIG1hcHMsIGl0IHNob3Vs
ZCBvbmx5IGJlIHVzZWQgd2l0aCBNUFUtOTE1MCBhbmQgbm90IE1QVS05MjUwLiBJIHdvdWxkIGZl
ZWwgbXVjaCBtb3JlIGNvbWZvcnRhYmxlIHRvIHJlc3RyaWN0IHRoaXMgZml4IHRvIE1QVS05MTUw
IG9ubHkgKGJ5IHRlc3RpbmcgY2hpcF90eXBlIGFnYWluc3QgSU5WX01QVTkxNTApLgoKVGhhbmtz
LApKQgoKRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxhbmR5LnNoZXZjaGVua29AZ21haWwuY29tPgpT
ZW50OiBNb25kYXksIFNlcHRlbWJlciAyNSwgMjAyMyAxMzowNwpUbzogQW5kcmVhcyBLZW1uYWRl
IDxhbmRyZWFzQGtlbW5hZGUuaW5mbz4KQ2M6IGppYzIzQGtlcm5lbC5vcmcgPGppYzIzQGtlcm5l
bC5vcmc+OyBsYXJzQG1ldGFmb28uZGUgPGxhcnNAbWV0YWZvby5kZT47IHJvYmgrZHRAa2VybmVs
Lm9yZyA8cm9iaCtkdEBrZXJuZWwub3JnPjsga3J6eXN6dG9mLmtvemxvd3NraStkdEBsaW5hcm8u
b3JnIDxrcnp5c3p0b2Yua296bG93c2tpK2R0QGxpbmFyby5vcmc+OyBjb25vcitkdEBrZXJuZWwu
b3JnIDxjb25vcitkdEBrZXJuZWwub3JnPjsgYmNvdXNzb25AYmF5bGlicmUuY29tIDxiY291c3Nv
bkBiYXlsaWJyZS5jb20+OyB0b255QGF0b21pZGUuY29tIDx0b255QGF0b21pZGUuY29tPjsgSmVh
bi1CYXB0aXN0ZSBNYW5leXJvbCA8SmVhbi1CYXB0aXN0ZS5NYW5leXJvbEB0ZGsuY29tPjsgY2hl
bmh1aXpAYXhpcy5jb20gPGNoZW5odWl6QGF4aXMuY29tPjsgbGludXgtaWlvQHZnZXIua2VybmVs
Lm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47IGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnIDxkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBsaW51eC1vbWFwQHZnZXIua2Vy
bmVsLm9yZyA8bGludXgtb21hcEB2Z2VyLmtlcm5lbC5vcmc+ClN1YmplY3Q6IFJlOiBbUEFUQ0gg
Mi8zXSBpaW86IGltdTogbXB1NjA1MDogYWRkIGxldmVsIHNoaWZ0ZXIgZmxhZyAKwqAKT24gTW9u
LCBTZXAgMjUsIDIwMjMgYXQgMTrigIoyNiBBTSBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNA4oCK
a2VtbmFkZS7igIppbmZvPiB3cm90ZTogPiA+IFNvbWUgYm9hcmRzIGZhaWwgaW4gbWFnbmV0b21l
dGVyIHByb2JlIGlmIGZsYWcgaXMgbm90IHNldC4gV2hpY2ggZmxhZz8gQ2FuIHlvdSBlbGFib3Jh
dGUgYSBiaXQgbW9yZT8gRG9lcyBpdCBkZXNlcnZlIHRoZSBGaXhlcyB0YWc/IC4u4oCKLiA+IHVu
c2lnbmVkIApaalFjbVFSWUZwZnB0QmFubmVyU3RhcnQKVGhpcyBNZXNzYWdlIElzIEZyb20gYW4g
VW50cnVzdGVkIFNlbmRlciAKWW91IGhhdmUgbm90IHByZXZpb3VzbHkgY29ycmVzcG9uZGVkIHdp
dGggdGhpcyBzZW5kZXIuIArCoApaalFjbVFSWUZwZnB0QmFubmVyRW5kCk9uIE1vbiwgU2VwIDI1
LCAyMDIzIGF0IDE6MjbigK9BTSBBbmRyZWFzIEtlbW5hZGUgPGFuZHJlYXNAa2VtbmFkZS5pbmZv
PiB3cm90ZToKPgo+IFNvbWUgYm9hcmRzIGZhaWwgaW4gbWFnbmV0b21ldGVyIHByb2JlIGlmIGZs
YWcgaXMgbm90IHNldC4KCldoaWNoIGZsYWc/IENhbiB5b3UgZWxhYm9yYXRlIGEgYml0IG1vcmU/
CgpEb2VzIGl0IGRlc2VydmUgdGhlIEZpeGVzIHRhZz8KCi4uLgoKPiAgICAgICAgIHVuc2lnbmVk
IGludCB2YWw7Cj4gICAgICAgICBpbnQgcmV0OwoKPiArICAgICAgIHJldCA9IHJlZ21hcF91cGRh
dGVfYml0cyhzdC0+bWFwLCAweDEsIDB4ODAsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgc3QtPmxldmVsX3NoaWZ0ZXIgPyAweDgwIDogMCk7CgpUaGlzIGlzIGEgYml0IGNyeXB0
aWMsIHdoYXQgZG9lcyAxIHN0YW5kIGZvcj8KCkFsc28KCiAgdW5zaWduZWQgaW50IG1hc2sgPSBC
SVQoNyk7CiAgLi4uCiAgdmFsID0gc3QtPmxldmVsX3NoaWZ0ZXIgPyBtYXNrIDogMDsKCj4gKyAg
ICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICByZXR1cm4gcmV0OwoKLi4uCj4gKyAgICAg
ICBzdC0+bGV2ZWxfc2hpZnRlciA9IGRldmljZV9wcm9wZXJ0eV9wcmVzZW50KGRldiwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgImludmVuc2Vu
c2UsbGV2ZWwtc2hpZnRlciIpOwoKSXQgd2FzIGEgcmVjb21tZW5kYXRpb24gdG8gdXNlIF9yZWFk
X2Jvb2woKSB3aGVuIHJlYWRpbmcgdGhlIHZhbHVlLAp3aGlsZSB0aGUgcmVzdWx0IHdpbGwgYmUg
dGhlIHNhbWUuCgotLQpXaXRoIEJlc3QgUmVnYXJkcywKQW5keSBTaGV2Y2hlbmtvCg==
