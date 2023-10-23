Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 057337D3810
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 15:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjJWN3a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 09:29:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230526AbjJWN3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 09:29:25 -0400
X-Greylist: delayed 1884 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 23 Oct 2023 06:29:21 PDT
Received: from mx0b-00549402.pphosted.com (mx0b-00549402.pphosted.com [205.220.178.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F114010C7;
        Mon, 23 Oct 2023 06:29:21 -0700 (PDT)
Received: from pps.filterd (m0233779.ppops.net [127.0.0.1])
        by mx0b-00549402.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39N9Ps1K001239;
        Mon, 23 Oct 2023 12:57:18 GMT
Received: from deu01-be0-obe.outbound.protection.outlook.com (mail-be0deu01lp2169.outbound.protection.outlook.com [104.47.7.169])
        by mx0b-00549402.pphosted.com (PPS) with ESMTPS id 3tv80hh5n8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 23 Oct 2023 12:57:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eiVaLxR//vesPJDcqMCnr6YEyjuhISAJnrWrJPXs2d25Uc1yU0AcXU2dbfxeHN7EVgOxboLI3SMz5FEasmekVqqrHW8ujYE3OrA499Y1Giul3mWBLx811avIEy0yWALn42pDAv6YR7KQt/c5/pfIK6wqaDmj70HfOvBQ5AuWoACyGFw04NAUTllnBnjDMt8Yw9+LvMN8U6eUwW0qlQoIURf7mbaJfeTmuk4oD+bUujIlKHUqbHO5M5IJrEqhmuy8TZ8ZU6dBLZDyNbKuwXaIwcdwRz89EiZHRPvWJxPXCc8IwI0XX2rid04iVPWJ/7yyYnAJjbWxHagLtPK/K6vMnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z5Ol9sblsFN39X90CkitYcOrKtNoVkm0pO8PlOqLtos=;
 b=CQu9jvbWeRUwes1mKslNU5PZ+VYCiDLLmT4txMeH7AE9RCm13B0E6/t9DOMgMWkf0a4BJgJNXJly9C8Nkmx3o7e6ffPzvdTd+ugowtHD6Scpi+oTm/8rEBSjv5rVkGf38AM/yhOx8k3MFtKeEFtRZcqUDCaZGR+wh+E1BxP/iqV8NA2lCmV8RnCW2gJKPUM8qzPoTue1DBfUkDNt3aF6fUE4P+GS0ODk9voK1d5GwTtY9bjHms0UIFZVPanDwyl5VdCZAcwO9eNHCMf3gELPNvZWWafihcjbWnsfV18h5DkTt11PbiFrxVxx9RPmK2sreSqAAswyF4TaaQbs2WzaLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=tdk.com; dmarc=pass action=none header.from=tdk.com; dkim=pass
 header.d=tdk.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tdk.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z5Ol9sblsFN39X90CkitYcOrKtNoVkm0pO8PlOqLtos=;
 b=Q5dOdOPgb+73YWnSFdTVAlrHwf2b0+lePTgPwOKkZslN4dSC8hBBEE6XpCGB7VzRZEVtcvWolAS7nzkhrAPle67qvO3Jmuds7G9r3tzwcqTF7T3El1W4AMxhRFDok3LYG36/HCgKY+x+HCARs5uVjxROZWgU+rdrno3Guv3IiiDecNY/7bzdYM04W5N4iJlRurwbIgscJptKXQ1P8MeTE5RQnq/eq2bYsZfaxp00tNETUVJtLshEva5PtBemey7UcDSGTrHj3NQK5LKYMKBWNyjAP4OAvdheyEFPAehAnQU0IFYHrg37dDWTorxd1XT6jq6g5czy4GufEe6LHJfnzw==
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10:7c::11)
 by BE1P281MB2337.DEUP281.PROD.OUTLOOK.COM (2603:10a6:b10:34::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Mon, 23 Oct
 2023 12:57:13 +0000
Received: from FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c]) by FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
 ([fe80::4342:ef1e:e80e:196c%3]) with mapi id 15.20.6907.032; Mon, 23 Oct 2023
 12:57:12 +0000
From:   Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
To:     Su Hui <suhui@nfschina.com>,
        "Jonathan.Cameron@Huawei.com" <Jonathan.Cameron@Huawei.com>,
        "jic23@kernel.org" <jic23@kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>
CC:     "andy.shevchenko@gmail.com" <andy.shevchenko@gmail.com>,
        "chenhuiz@axis.com" <chenhuiz@axis.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Thread-Topic: [PATCH v2] iio: imu: inv_mpu6050: fix an error code problem in
 inv_mpu6050_read_raw
Thread-Index: AQHaBWZO/yWrdW0G+EGbF+XAV4RwKrBXVDkf
Date:   Mon, 23 Oct 2023 12:57:11 +0000
Message-ID: <FR3P281MB17570A319238078822C9C77CCED8A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231023040551.68902-1-suhui@nfschina.com>
In-Reply-To: <20231023040551.68902-1-suhui@nfschina.com>
Accept-Language: en-US, fr-FR
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: FR3P281MB1757:EE_|BE1P281MB2337:EE_
x-ms-office365-filtering-correlation-id: 54476f56-0a25-4b5f-422a-08dbd3c79262
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DsAdjbXKsFApSvnwaxD9ZcLU0IFbUsFj+pyDleQBWeUxeU2vBWCAy3f9x0eyWTEhSEJsVJ/7XkAJ9OWNYkzk0ByiNZ/NL2ku+0bcS601EJILHoN3E72K4SbL7BHKJaMcL4i1eQOgoDdh3J5XwrzcsmDU16pXlV/biRjOgVsnx67fXBS9bv7YHg2MXaCCi0DAYHNbk8OzugrpaVXxtuEY+Jcu22udeK3p8mGhN3BZpdr/8tm9wPVN84z22RCpBaql5jhGJvsYyV0YIkaJN0CsSvh5V1c5c68FIa8h2nr6J4bcXrs8bL/JEu4TkYYMSzrNPDDPYUWmd7FpFOy98l3SGzVXFBNh/8yB4m1hopRWFZcdgw2S8miZjuoPt3ekj0PN059/tMtzF4Vw6oj0kZ7xEVxprM997LYfsmCEla2mYmg8iRmRFa3rJ5tCLEyPZKu4ODcUWEYe8Vs8OYpDCG+4uTGgcymDYbGTG911aVayoaEH/ZLe8XFcugDL6vzAlum80C6jLAAWO3RA6iH6O/9j1QyEiJ+JFxmM78UTI8JS9MSsG5sUJOEAadzu9ZEwNy/eEr75LpDtuWlZerWl/jrWe30GeTv50hrewWDLPkorSTB6SCZZu24OHsyFKJrpJTYQaKXUjvUhu4S7aNr8IXQOxBjVGzl2fgNJIhlEEDnAI436ka65WF+0/Paun4sgEqM0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(366004)(376002)(136003)(39860400002)(230922051799003)(1800799009)(186009)(451199024)(64100799003)(55016003)(2906002)(38100700002)(41300700001)(110136005)(76116006)(66446008)(316002)(64756008)(66556008)(54906003)(66476007)(122000001)(66946007)(7696005)(6506007)(91956017)(71200400001)(478600001)(966005)(53546011)(9686003)(83380400001)(3613699003)(86362001)(52536014)(5660300002)(33656002)(4326008)(8936002)(8676002)(38070700009)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZXhRZ3NqWTN6ajFKOEFhcDMwamZSU05jWllkd0xlUm9BK0FBeXg0anBPNjNa?=
 =?utf-8?B?K0hSTlJNTmNQczNMa2pncFR5emRqNjJQZDd0bDRsdHRxNVZBSWUzT3lZSHZF?=
 =?utf-8?B?c3M3RElSNzJ0Wjl1WlFKbHArK3pvdUc4VG43SXRyZnlScGJQVktQdi9pTjFj?=
 =?utf-8?B?aHlDVzJzQ0ZZM1Nuek1hQ0VkKzMrZ1hPREMyTGlrOVVCZDluaTR0THcwN1lS?=
 =?utf-8?B?bkpSVGczN3IyeHA4UzdWN2p5NzhwQkhxdGR5QkVsRGFIV1pwR1ROM29kQVIw?=
 =?utf-8?B?a0QvTXhGZnFSclFXbERObitLdFJvbWdyQTVkdVZ4cHMzTDVPbzE2bWlteWZp?=
 =?utf-8?B?QU9kckhtdFVicUllOFhwZENzUUNUSDgzZEZUVkd0eFV2cGlVSTY5VkViMGF4?=
 =?utf-8?B?OTBIeDNYQWwreEpaUWc5enlQNHV3ejJjVWJaWEJxUjJ2Qjc1d2xaMnJrQlNB?=
 =?utf-8?B?ZG1YQVlLSkdiVG1UVTdWNHpSSzQxVkoxT1lVNDcvSThXajdZeEExVmltckN1?=
 =?utf-8?B?RTdNMWMycysvT3d2N1BWYUR2WE8wOWpGUnpZNjhXM0phcCtBU3J6UlFRRXFI?=
 =?utf-8?B?eUZiRStHYzRBVkYyL3ZKZlRFc1JRY2UxM1ZKWDhmS1dPZTRnRnc4L0dXZThw?=
 =?utf-8?B?SEZGZmRveXBpTVRiOVhnTW1DM0hmSjduc1c3Ump2MnZCeS83OEh3NTQxOGFv?=
 =?utf-8?B?VjRlejBaSms2bUsyYWxFSGxDS3RYNU5Fd2w4aHJSQkJnSy8wU0IveXpBcy9R?=
 =?utf-8?B?anUxWkdKcXdRVUgvV1c2VG1RNmRCVlNaN1pqcUUxcFlOT1VxNXVCNFdhaXZs?=
 =?utf-8?B?UkpiWlNQVFdDM3BSSldlaU53cGJML3E3Nmx5QUVvRWoyaWtaYnRvTWxnVE9M?=
 =?utf-8?B?YmdCSmZSa2JPSFc3K3U2S09YTFhPZmp5OEMwM1NPQjNMTUk2V1NBMVozWUF5?=
 =?utf-8?B?dWNCOXBCNVMrT0p0emZTTVBkdlRaay9jUXI0TmRDbS8welN6OXhaeWZqRyt1?=
 =?utf-8?B?R1dLZmV0VUhsQ1EvNkl2WVp2SENMUVJPdlZOQmh2ME82R3cvazFHSDROQ3FS?=
 =?utf-8?B?YWJEbGVsaUlaVlJubTV1dldCY3pacWVCeDdFdjAxR0pFd2hkMkFMQm9jNVBK?=
 =?utf-8?B?WFNLc0dXTjk5R0Rib0FUbVZCcWFPV2FrTzEyS1cyUzRDcEowUmo5MEFvWS9u?=
 =?utf-8?B?Q0hLY3lWMGVDbitCTUVQZmhlOWhmY1F0TmdlSVVqRTkyN29tUHdkdXZRWDda?=
 =?utf-8?B?cmVrdUxML1hKSnBKZHF2anR5bGhNdE9nY0hNaEwyd28rQUh6WnZyV0hUYkVX?=
 =?utf-8?B?Vi83bDc0TndpenV0a0sxbXJvVkdJWXpvWFhDU25PTmNhbHE5T0VYdi9CV2F2?=
 =?utf-8?B?N0hMNE4vMDN0Q25mejg4VHRtclc5VlJOUnZsT0x5M2cvK24yayttVDVmY1Nt?=
 =?utf-8?B?OXVCeHdGWjVNdXVnWG0zMjVmTUVvd0Y1Z1RqdGNaR0hFb3Y0N0xzT0k1WVN4?=
 =?utf-8?B?Y1RpSXNwS2w3Y3lNem9kdkx6dXNLNmNhZFVQc3U1KytrSXY3UDVoVGM4MXZn?=
 =?utf-8?B?YmNHYXBnVmJPMXVKcW9idXZuN3JDMGNaN05pZVNuMkR0b1N0UnV1UGN1T3Rx?=
 =?utf-8?B?RTV0U1JnRFM2YVJuUTFUQVF4OEdwMytIUmo0R3owM2JhSDVJU2YxemZCY1pk?=
 =?utf-8?B?TlU0MEZzZUpzZUhSb0hEOC9OZSt6VHp5TTRSMjdPZTR1eExIZW5ZZThiNVlF?=
 =?utf-8?B?WC9NMlZxRHg1bXhBMUZWMWVaL2pqS1lINit1NVVlWnFYZkQ3UEk5bGJYNXd6?=
 =?utf-8?B?NDJSV0JCamtjRzh6UXBONnlaN1hFTW1xekRXRmpoWUFRNFJta21TY2FvTHVj?=
 =?utf-8?B?UGdrRFpnY3I3by9BRERPR2xTM1NLaTU1QmJVQ0NWbGxMUXlvYjNhM0UvY1cr?=
 =?utf-8?B?MzlrdkV1QU5LKzBwR0IxOTBzcnlmZnk2c1BGeCtITXB0ZEZMWnVCa0Z3OENV?=
 =?utf-8?B?cnBSWGxxS0Y3U2VicElOTDZIRzdrbmZjaklSdUtLR0g5NkdXbjlHTFJIQ0JE?=
 =?utf-8?B?Q1lVeGxoZHdzVVBoeUdkdVhyQW0rUnpPUXJPbW81bWIxanl4cER4RVhnc3hB?=
 =?utf-8?B?TGVxMmd1aUNsZ1NMZk1YazNJTC9UZFIvMjYrWTgxQm1Wd1RlY1QvNlFyMnZl?=
 =?utf-8?B?Rnc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: tdk.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 54476f56-0a25-4b5f-422a-08dbd3c79262
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Oct 2023 12:57:11.0549
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7e452255-946f-4f17-800a-a0fb6835dc6c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5IEAwmy6HbP5n/9bxXJIK4cvYNWPbQpMj0VuR3XEAN/ALB5Qrj2xZ66kiTYZwVE9P0gG4TzCBxWcHQNT/5WyKjjMuKTOMztTfGaSa+o1lZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BE1P281MB2337
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-23_11,2023-10-19_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGVsbG8sCgpsb29rcyBnb29kIGZvciBtZSwgdGhhbmtzIGZvciB0aGUgZml4LgoKQWNrZWQtYnk6
IEplYW4tQmFwdGlzdGUgTWFuZXlyb2wgPGplYW4tYmFwdGlzdGUubWFuZXlyb2xAdGRrLmNvbT4K
ClRoYW5rcywKSkIKCkZyb206IFN1IEh1aSA8c3VodWlAbmZzY2hpbmEuY29tPgpTZW50OiBNb25k
YXksIE9jdG9iZXIgMjMsIDIwMjMgMDY6MDUKVG86IEpvbmF0aGFuLkNhbWVyb25ASHVhd2VpLmNv
bSA8Sm9uYXRoYW4uQ2FtZXJvbkBIdWF3ZWkuY29tPjsgamljMjNAa2VybmVsLm9yZyA8amljMjNA
a2VybmVsLm9yZz47IGxhcnNAbWV0YWZvby5kZSA8bGFyc0BtZXRhZm9vLmRlPgpDYzogU3UgSHVp
IDxzdWh1aUBuZnNjaGluYS5jb20+OyBKZWFuLUJhcHRpc3RlIE1hbmV5cm9sIDxKZWFuLUJhcHRp
c3RlLk1hbmV5cm9sQHRkay5jb20+OyBhbmR5LnNoZXZjaGVua29AZ21haWwuY29tIDxhbmR5LnNo
ZXZjaGVua29AZ21haWwuY29tPjsgY2hlbmh1aXpAYXhpcy5jb20gPGNoZW5odWl6QGF4aXMuY29t
PjsgbGludXgtaWlvQHZnZXIua2VybmVsLm9yZyA8bGludXgtaWlvQHZnZXIua2VybmVsLm9yZz47
IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmcgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc+OyBrZXJuZWwtamFuaXRvcnNAdmdlci5rZXJuZWwub3JnIDxrZXJuZWwtamFuaXRvcnNAdmdl
ci5rZXJuZWwub3JnPgpTdWJqZWN0OiBbUEFUQ0ggdjJdIGlpbzogaW11OiBpbnZfbXB1NjA1MDog
Zml4IGFuIGVycm9yIGNvZGUgcHJvYmxlbSBpbiBpbnZfbXB1NjA1MF9yZWFkX3JhdyAKwqAKaW52
X21wdTYwNTBfc2Vuc29yX3Nob3coKSBjYW4gcmV0dXJuIC1FSU5WQUwgb3IgSUlPX1ZBTF9JTlQu
IFJldHVybiB0aGUgdHJ1ZSB2YWx1ZSByYXRoZXIgdGhhbiBvbmx5IHJldHVybiBJSU9fVkFMX0lO
VC4gU2lnbmVkLW9mZi1ieTogU3UgSHVpIDxzdWh1aUDigIpuZnNjaGluYS7igIpjb20+IC0tLSB2
MjogLSBmaXggdGhlIGVycm9yIG9mIGNvbW1pdCB0aXRsZS4gdjE6IC0gaHR0cHM64oCKLy91cmxk
ZWZlbnNlLuKAimNvbS92My9fX2h0dHBzOuKAii8vbG9yZS7igIprZXJuZWwu4oCKb3JnL2FsbC8y
MDIzMTAyMDA5MTQxMy7igIoyMDU3NDMtMi1zdWh1aUDigIpuZnNjaGluYS7igIpjb20vX187ISFG
dHJodFBzV0RoWjZ0dyFIa2hvWXlPYy1XaHhfUk9tc2w1bGFvY2RnUGZtQUNDNVBpZmY5NkZHX253
VHFaRkE0R2dYZU5ocDdxMXdWRWxVRmJmYWJBY0NtdDZEMXV1S0ExTE8xcTVFJFtsb3JlWy7igIpd
a2VybmVsWy7igIpdb3JnXSAKWmpRY21RUllGcGZwdEJhbm5lclN0YXJ0ClRoaXMgTWVzc2FnZSBJ
cyBGcm9tIGFuIFVudHJ1c3RlZCBTZW5kZXIgCllvdSBoYXZlIG5vdCBwcmV2aW91c2x5IGNvcnJl
c3BvbmRlZCB3aXRoIHRoaXMgc2VuZGVyLiAKwqAKWmpRY21RUllGcGZwdEJhbm5lckVuZAppbnZf
bXB1NjA1MF9zZW5zb3Jfc2hvdygpIGNhbiByZXR1cm4gLUVJTlZBTCBvciBJSU9fVkFMX0lOVC4g
UmV0dXJuIHRoZQp0cnVlIHZhbHVlIHJhdGhlciB0aGFuIG9ubHkgcmV0dXJuIElJT19WQUxfSU5U
LgoKU2lnbmVkLW9mZi1ieTogU3UgSHVpIDxzdWh1aUBuZnNjaGluYS5jb20+Ci0tLQp2MjoKIC0g
Zml4IHRoZSBlcnJvciBvZiBjb21taXQgdGl0bGUuCnYxOiAKIC0gaHR0cHM6Ly91cmxkZWZlbnNl
LmNvbS92My9fX2h0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAyMDA5MTQxMy4yMDU3
NDMtMi1zdWh1aUBuZnNjaGluYS5jb20vX187ISFGdHJodFBzV0RoWjZ0dyFIa2hvWXlPYy1XaHhf
Uk9tc2w1bGFvY2RnUGZtQUNDNVBpZmY5NkZHX253VHFaRkE0R2dYZU5ocDdxMXdWRWxVRmJmYWJB
Y0NtdDZEMXV1S0ExTE8xcTVFJFtsb3JlWy5da2VybmVsWy5db3JnXQogZHJpdmVycy9paW8vaW11
L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jIHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBp
bnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaWlvL2lt
dS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYyBiL2RyaXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1
MC9pbnZfbXB1X2NvcmUuYwppbmRleCAyOWY5MDZjODg0YmQuLmE5YTVmYjI2NmVmMSAxMDA2NDQK
LS0tIGEvZHJpdmVycy9paW8vaW11L2ludl9tcHU2MDUwL2ludl9tcHVfY29yZS5jCisrKyBiL2Ry
aXZlcnMvaWlvL2ltdS9pbnZfbXB1NjA1MC9pbnZfbXB1X2NvcmUuYwpAQCAtNzQ5LDEzICs3NDks
MTMgQEAgaW52X21wdTYwNTBfcmVhZF9yYXcoc3RydWN0IGlpb19kZXYgKmluZGlvX2RldiwKIAkJ
CXJldCA9IGludl9tcHU2MDUwX3NlbnNvcl9zaG93KHN0LCBzdC0+cmVnLT5neXJvX29mZnNldCwK
IAkJCQkJCWNoYW4tPmNoYW5uZWwyLCB2YWwpOwogCQkJbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7
Ci0JCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7CisJCQlyZXR1cm4gcmV0OwogCQljYXNlIElJT19BQ0NF
TDoKIAkJCW11dGV4X2xvY2soJnN0LT5sb2NrKTsKIAkJCXJldCA9IGludl9tcHU2MDUwX3NlbnNv
cl9zaG93KHN0LCBzdC0+cmVnLT5hY2NsX29mZnNldCwKIAkJCQkJCWNoYW4tPmNoYW5uZWwyLCB2
YWwpOwogCQkJbXV0ZXhfdW5sb2NrKCZzdC0+bG9jayk7Ci0JCQlyZXR1cm4gSUlPX1ZBTF9JTlQ7
CisJCQlyZXR1cm4gcmV0OwogCiAJCWRlZmF1bHQ6CiAJCQlyZXR1cm4gLUVJTlZBTDsKLS0gCjIu
MzAuMgoK
