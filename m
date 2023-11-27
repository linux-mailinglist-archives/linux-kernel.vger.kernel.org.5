Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E438A7F9762
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 03:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231387AbjK0CHY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 21:07:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbjK0CHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 21:07:22 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C687211B
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 18:07:27 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 56D6C2C063F;
        Mon, 27 Nov 2023 15:07:25 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1701050845;
        bh=LhxxACd8dghdQZn1oHq+gSzpl7xTf6ckLAsgiTT5KiQ=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=mAXP8eL7PWUMnlM0iqCVAkApCs2yjRfISchkleGv2DCsrs1jPXXoXGNM0hdl5Z5f7
         FFqxX5SX4VYpfn+K8A4kGBp2zp0DT4ZOuc9/O9qfSAYeQ3mAUBikZy2xHOiKkuKh2W
         nVu4UvqLGVQrCrLvDBgHcJsjMO/EqFZH3rOT5I71UCzaq4mV5LosyvfqxevLjImA2y
         tXlHjrsmyBMDxkBSs9USzQe+J0t7JBuitN0Mnyz+Y45jrjUiyo8N46utEhqpu67U1i
         AJJXmYdQcw/RAO6CsRtSWDRTyQjziQvMfWA1WQKUr0wnIFSwNG6RCRRTHTglbrWlzd
         TxLz7WRfJ1k+g==
Received: from svr-chch-ex2.atlnz.lc (Not Verified[2001:df5:b000:bc8::76]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B6563f9dd0001>; Mon, 27 Nov 2023 15:07:25 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.1118.40; Mon, 27 Nov 2023 15:07:25 +1300
Received: from svr-chch-ex2.atlnz.lc (2001:df5:b000:bc8::76) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with Microsoft
 SMTP Server (TLS) id 15.0.1497.48; Mon, 27 Nov 2023 15:07:24 +1300
Received: from svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567]) by
 svr-chch-ex2.atlnz.lc ([fe80::a9eb:c9b7:8b52:9567%15]) with mapi id
 15.02.1118.040; Mon, 27 Nov 2023 15:07:24 +1300
From:   Angga <Hermin.Anggawijaya@alliedtelesis.co.nz>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        "peterhuewe@gmx.de" <peterhuewe@gmx.de>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>
CC:     "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Topic: [PATCH] tpm: Start the tpm2 before running a self test.
Thread-Index: AQHaHREnjIixcvoKIE+Z7DUtybpc5rCH2ueAgAS99oA=
Date:   Mon, 27 Nov 2023 02:07:24 +0000
Message-ID: <22f6605c-7e24-423b-b4f3-df096b340674@alliedtelesis.co.nz>
References: <20231122065528.1049819-1-hermin.anggawijaya@alliedtelesis.co.nz>
 <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>
In-Reply-To: <CX6NSGFJVYKC.3KFEPA92N0V53@kernel.org>
Accept-Language: en-NZ, en-US
Content-Language: en-NZ
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0BB615F929DAE4439BDCCA891933D9B8@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=AZXP4EfG c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=BNY50KLci1gA:10 a=e6lE4nR9YQSnTHqkly4A:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=zZCYzV9kfG8A:10
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjQvMTEvMjAyMyAyOjQyIHBtLCBKYXJra28gU2Fra2luZW4gd3JvdGU6DQo+IE9uIFdlZCBO
b3YgMjIsIDIwMjMgYXQgODo1NSBBTSBFRVQsIEhlcm1pbiBBbmdnYXdpamF5YSB3cm90ZToNCj4+
IEJlZm9yZSBzZW5kaW5nIGEgY29tbWFuZCB0byBhdHRlbXB0IHRoZSBzZWxmIHRlc3QsIHRoZSBU
UE0NCj4+IG1heSBuZWVkIHRvIGJlIHN0YXJ0ZWQsIG90aGVyd2lzZSB0aGUgc2VsZiB0ZXN0IHJl
dHVybnMNCj4+IFRQTTJfUkNfSU5JVElBTElaRSB2YWx1ZSBjYXVzaW5nIGEgbG9nIGFzIGZvbGxv
d3M6DQo+PiAidHBtIHRwbTA6IEEgVFBNIGVycm9yICgyNTYpIG9jY3VycmVkIGF0dGVtcHRpbmcg
dGhlIHNlbGYgdGVzdCIuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSGVybWluIEFuZ2dhd2lqYXlh
IDxoZXJtaW4uYW5nZ2F3aWpheWFAYWxsaWVkdGVsZXNpcy5jby5uej4NCj4gRmlybXdhcmUgZG9l
cyBUUE0gcG93ZXIgb24uDQo+DQo+IEJSLCBKYXJra28NCg0KSGVsbG8gSmFya2tvDQoNClRoYW5r
IHlvdSBmb3IgeW91ciBjb21tZW50IG9uIHRoZSBwYXRjaC4gQXMgaW5kaWNhdGVkIGluIG15IHBy
ZXZpb3VzIA0KcmVwbHkgdG8gU3RlZmFuJ3MgY29tbWVudCwNCkkgaGF2ZSB2MiB2ZXJzaW9uIG9m
IHRoZSBwYXRjaCB3aGljaCBhbHNvIGRlYWxzIHdpdGggbXVsdGlwbGUgYXR0ZW1wdHMgDQp0byBz
dGFydCB1cCB0aGUgVFBNIGdyYWNlZnVsbHksDQpmb3IgZXhhbXBsZSwgb25jZSBieSB0aGUgZmly
bXdhcmUgYW5kIGFub3RoZXIgYnkgdGhlIGtlcm5lbCBkdXJpbmcgdHBtMiANCmF1dG8tc3RhcnR1
cC4NCg0KSWYgeW91IHRoaW5rIHRoZSBpZGVhIGlzIE9LLCBJIGNhbiBzZW5kIHRoZSB2MiBvZiB0
aGUgcGF0Y2guDQoNCg0KS2luZCByZWdhcmRzDQoNCkhlcm1pbg0KDQoNCg==
