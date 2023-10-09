Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA7E7BD1BB
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 03:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344939AbjJIBO6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 21:14:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232267AbjJIBO4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 21:14:56 -0400
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1CEFAB;
        Sun,  8 Oct 2023 18:14:54 -0700 (PDT)
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
        by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3991BwBe027666;
        Mon, 9 Oct 2023 01:14:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=bqKwEEDSZeu3XWsBzxAeh+cU4hhpiMZzmCfjh4Tm36c=;
 b=Zi1FKHcay3lumEj/HBQFHoXymqxPq4MK6j61RigHcQD0RE+6pWOx2MBmw7XgnEiUkrs6
 h51dWY5/bOYguNfieT1rKFHruLKiBWgAUsSAhPMN/vgCCHrEEsGuipfEgyuR3J33Jlbn
 qZFfNIAhKAuUDsRsGJuQhZXsvbjwSeO0FUd/1AwBqb2GY4X1/rXTFX7PNLwH1BJ2XE3n
 1alQZTCuEZPOioKxXrTcFYmYSAWqBj6HdMDA9QEodSljPLJdaSZNWQxZ0zD1BCiSeP9Q
 xRXJB+A3Ci3ERo/P0MoGplYUo2bCrJV6ARzCwG2vEYnJ3klx84WKNO+RpP9th9rzzSDk 4Q== 
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
        by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3tkh6g19m9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Oct 2023 01:14:32 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
        by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3991EVDw002833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 9 Oct 2023 01:14:31 GMT
Received: from nalasex01c.na.qualcomm.com (10.47.97.35) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.36; Sun, 8 Oct 2023 18:14:31 -0700
Received: from nalasex01c.na.qualcomm.com ([fe80::6c73:4982:d918:fc9e]) by
 nalasex01c.na.qualcomm.com ([fe80::6c73:4982:d918:fc9e%11]) with mapi id
 15.02.1118.030; Sun, 8 Oct 2023 18:14:31 -0700
From:   "Joey Jiao (QUIC)" <quic_jiangenj@quicinc.com>
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Alexander Potapenko <glider@google.com>
CC:     "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "Kevin Ding (QUIC)" <quic_likaid@quicinc.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Nicolas Schier" <nicolas@fjasle.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kbuild@vger.kernel.org" <linux-kbuild@vger.kernel.org>,
        "Changmin Liu (QUIC)" <quic_changmil@quicinc.com>
Subject: RE: [PATCH] kasan: Add CONFIG_KASAN_WHITELIST_ONLY mode
Thread-Topic: [PATCH] kasan: Add CONFIG_KASAN_WHITELIST_ONLY mode
Thread-Index: AQHZ8cKGhLNei3YqKk6uH8pD4/r18bAyTeQAgAFRKACADRj7EA==
Date:   Mon, 9 Oct 2023 01:14:31 +0000
Message-ID: <11e5eafbf8ac42fd90491e09e96d8eea@quicinc.com>
References: <20230928041600.15982-1-quic_jiangenj@quicinc.com>
 <CAG_fn=V9FXGpqceojn0UGiPi7gFbDbRnObc-N5a55Qk=XQy=kg@mail.gmail.com>
 <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
In-Reply-To: <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.132.37]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: rrhB8qCbGW6xgOd3duwbO0qi0XsUyDXW
X-Proofpoint-ORIG-GUID: rrhB8qCbGW6xgOd3duwbO0qi0XsUyDXW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-09_01,2023-10-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 clxscore=1015 mlxlogscore=883 bulkscore=0 lowpriorityscore=0 phishscore=0
 mlxscore=0 adultscore=0 priorityscore=1501 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2309180000
 definitions=main-2310090009
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UmlnaHQsIGl0IHdpbGwgYmUgb25seSB1c2VmdWwgZm9yIGxvdyBtZW1vcnkga2VybmVsIHdoZXJl
ICdLQVNBTl9TQU5JVElaRSA6PXknIGhhcyB0byBiZSBhZGRlZCBleHBsaWNpdGx5IGluIGxvY2Fs
IGFzIGhvdGZpeC4NCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IE1hc2FoaXJv
IFlhbWFkYSA8bWFzYWhpcm95QGtlcm5lbC5vcmc+IA0KU2VudDogU2F0dXJkYXksIFNlcHRlbWJl
ciAzMCwgMjAyMyA2OjEyIFBNDQpUbzogQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2ds
ZS5jb20+DQpDYzogSm9leSBKaWFvIChRVUlDKSA8cXVpY19qaWFuZ2VuakBxdWljaW5jLmNvbT47
IGthc2FuLWRldkBnb29nbGVncm91cHMuY29tOyBLZXZpbiBEaW5nIChRVUlDKSA8cXVpY19saWth
aWRAcXVpY2luYy5jb20+OyBBbmRyZXkgUnlhYmluaW4gPHJ5YWJpbmluLmEuYUBnbWFpbC5jb20+
OyBBbmRyZXkgS29ub3ZhbG92IDxhbmRyZXlrbnZsQGdtYWlsLmNvbT47IERtaXRyeSBWeXVrb3Yg
PGR2eXVrb3ZAZ29vZ2xlLmNvbT47IFZpbmNlbnpvIEZyYXNjaW5vIDx2aW5jZW56by5mcmFzY2lu
b0Bhcm0uY29tPjsgTmF0aGFuIENoYW5jZWxsb3IgPG5hdGhhbkBrZXJuZWwub3JnPjsgTmljayBE
ZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2dsZS5jb20+OyBOaWNvbGFzIFNjaGllciA8bmlj
b2xhc0BmamFzbGUuZXU+OyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rYnVp
bGRAdmdlci5rZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIXSBrYXNhbjogQWRkIENPTkZJ
R19LQVNBTl9XSElURUxJU1RfT05MWSBtb2RlDQoNCk9uIEZyaSwgU2VwIDI5LCAyMDIzIGF0IDEx
OjA24oCvUE0gQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xpZGVyQGdvb2dsZS5jb20+IHdyb3RlOg0K
Pg0KPiAoQ0MgTWFzYWhpcm8gWWFtYWRhKQ0KPg0KPiBPbiBUaHUsIFNlcCAyOCwgMjAyMyBhdCA2
OjE24oCvQU0gSm9leSBKaWFvIDxxdWljX2ppYW5nZW5qQHF1aWNpbmMuY29tPiB3cm90ZToNCj4g
Pg0KPiA+IEZvdyBsb3cgbWVtb3J5IGRldmljZSwgZnVsbCBlbmFibGVkIGthc2FuIGp1c3Qgbm90
IHdvcmsuDQo+ID4gU2V0IEtBU0FOX1NBTklUSVpFIHRvIG4gd2hlbiBDT05GSUdfS0FTQU5fV0hJ
VEVMSVNUX09OTFk9eS4NCj4gPiBTbyB3ZSBjYW4gZW5hYmxlIGthc2FuIGZvciBzaW5nbGUgZmls
ZSBvciBtb2R1bGUuDQo+DQo+IEkgZG9uJ3QgaGF2ZSB0ZWNobmljYWwgb2JqZWN0aW9ucyBoZXJl
LCBidXQgaXQgYm90aGVycyBtZSBhIGJpdCB0aGF0IA0KPiB3ZSBhcmUgYWRkaW5nIHN1cHBvcnQg
Zm9yIEtBU0FOX1NBTklUSVpFOj15LCBhbHRob3VnaCBub2JvZHkgd2lsbCBiZSANCj4gYWRkaW5n
IEtBU0FOX1NBTklUSVpFOj15IHRvIHVwc3RyZWFtIE1ha2VmaWxlcyAtIG9ubHkgZGV2ZWxvcG1l
bnQgDQo+IGtlcm5lbHMgd2hlbiBkZWJ1Z2dpbmcgb24gbG93LWVuZCBkZXZpY2VzLg0KPg0KPiBN
YXNhaGlybywgaXMgdGhpcyBzb21ldGhpbmcgd29ydGggaGF2aW5nIGluIHVwc3RyZWFtIEtjb25m
aWcgY29kZT8NCg0KDQpFdmVuIGlmIHdlIGFwcGx5IHRoaXMgcGF0Y2ggdG8gdGhlIHVwc3RyZWFt
LCB5b3Ugd2lsbCBlbmQgdXAgd2l0aCBhZGRpbmcgJ0tBU0FOX1NBTklUSVpFIDo9eScNCnRvIHRo
ZSBzaW5nbGUgZmlsZS9NYWtlZmlsZS4NCg0KSSBhbSBub3QgY29udmluY2VkIHdpdGggdGhpcyBw
YXRjaA0Kc2luY2UgdGhpcyBub2QgaXMgbm90IHNvIHVzZWZ1bCBzdGFuZGFsb25lLg0KDQoNCg0K
PiA+IFNpZ25lZC1vZmYtYnk6IEpvZXkgSmlhbyA8cXVpY19qaWFuZ2VuakBxdWljaW5jLmNvbT4N
Cj4gUmV2aWV3ZWQtYnk6IEFsZXhhbmRlciBQb3RhcGVua28gPGdsaWRlckBnb29nbGUuY29tPg0K
DQoNCg0KLS0NCkJlc3QgUmVnYXJkcw0KTWFzYWhpcm8gWWFtYWRhDQo=
