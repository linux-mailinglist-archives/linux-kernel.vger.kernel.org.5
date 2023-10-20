Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809EC7D11C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:45:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377562AbjJTOpK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:45:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377429AbjJTOpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:45:09 -0400
X-Greylist: delayed 434 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 07:45:04 PDT
Received: from b1712.mx.srv.dfn.de (b1712.mx.srv.dfn.de [194.95.234.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9234A19E;
        Fri, 20 Oct 2023 07:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        uniklinik-freiburg.de; h=mime-version:content-transfer-encoding
        :content-id:content-type:content-type:content-language
        :accept-language:in-reply-to:references:message-id:date:date
        :subject:subject:from:from:received:received:received; s=s1; t=
        1697812668; x=1699627069; bh=xaqiTiaHUMKPQPBP2nbNQFRpF0OrJpSUn2k
        mUFCgflc=; b=Y1bHc1dMz4BiOWNFa6Mt0GZU6QsZ4hmR75TWxkFPO/5fFvqr+Z4
        N9fS0LWMXJF+mZM+AXXld5k/YeBPDW9r1hpq9qodtYcHTqJ7G1A+Ztiqs0Jf+Cqi
        tZZDA/5mFsMjoLFsUfEN7vIQsHH2AJCTkvU88Wm3dXFDN44nMQ2DX/BI=
Received: from ukl-fm1.ukl.uni-freiburg.de (ukl-fm-ha.ukl.uni-freiburg.de [193.196.199.18])
        by b1712.mx.srv.dfn.de (Postfix) with ESMTPS id 039F74016E;
        Fri, 20 Oct 2023 16:37:47 +0200 (CEST)
Received: from ukl-ex2.ad.uniklinik-freiburg.de (xxx52.ukl.uni-freiburg.de [193.196.253.52])
        by ukl-fm1.ukl.uni-freiburg.de  with ESMTPS id 39KEbeb8015176-39KEbebA015176
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
        Fri, 20 Oct 2023 16:37:40 +0200
Received: from UKL-EX4.ad.uniklinik-freiburg.de (193.196.253.54) by
 ukl-ex2.ad.uniklinik-freiburg.de (193.196.253.52) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 16:37:40 +0200
Received: from UKL-EX4.ad.uniklinik-freiburg.de ([fe80::6c6e:c675:beef:7071])
 by UKL-EX4.ad.uniklinik-freiburg.de ([fe80::6c6e:c675:beef:7071%5]) with mapi
 id 15.01.2507.032; Fri, 20 Oct 2023 16:37:40 +0200
From:   "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>
To:     "smfrench@gmail.com" <smfrench@gmail.com>,
        "matoro_mailinglist_kernel@matoro.tk" 
        <matoro_mailinglist_kernel@matoro.tk>,
        "pc@manguebit.com" <pc@manguebit.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "paul@darkrain42.org" <paul@darkrain42.org>,
        "tom@talpey.com" <tom@talpey.com>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "brian.pardy@gmail.com" <brian.pardy@gmail.com>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
Thread-Topic: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
Thread-Index: AQHaA2L6GXEWZinVBEmsDkQRFDlV8A==
Date:   Fri, 20 Oct 2023 14:37:40 +0000
Message-ID: <779ef3ac542e7e39027dee19d669ad2f81b05bcc.camel@uniklinik-freiburg.de>
References: <CAO+kfxTwOvaxYV0ZRESxZB-4LHsF9b_VBjAKahhwUm5a1_c4ug@mail.gmail.com>
         <ZPfPfyIoVxw5L6El@debian.me>
         <CAO+kfxQgXOsx6u+xLKGJe0KDiFsRAGstSpnrwxjQF6udgz5HFQ@mail.gmail.com>
         <CAO+kfxTvA6N=i+jGf0XbSyqf85i=q+vR6R9d_42OWfM2sWWXaA@mail.gmail.com>
         <CAH2r5mtUedfLSv81Z-Yb3_=AbD_QpT3tVbU1PRzMTituaw7bgA@mail.gmail.com>
         <CAH2r5mt6YzapEKDo=hQ64yvBn7=jwMmY1c85NOABKcMPKPp3KA@mail.gmail.com>
         <CAO+kfxQtOKoKdb+LtMeFxgu8VXa73nbmTPSfscbdwjUXM7ME_A@mail.gmail.com>
         <CAH2r5msNf9WDHrBZSi5FhHDSewSNxMAuXTetMJDnoNh3CF_oMA@mail.gmail.com>
         <a895f860-11fa-e6d9-d042-a32bd08f9e9d@talpey.com>
         <CAH2r5mszCxPtdURenMVgeVDX5zc8knumH=ASXyUufPa7SxbJBw@mail.gmail.com>
         <ZRN9MtBqYnT6oX60@vaarsuvius>
         <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
         <83d00d50bc628a85db71adb440d8afb5@matoro.tk>
         <E1F307C7-9B1E-40F6-860B-6050856E8395@manguebit.com>
         <CA6E0F87-65FD-4672-AA0C-A761E5006B7D@manguebit.com>
         <CAH2r5mse_2sfXF+tdTmie5LLtBuc+6DOumDH3rn=5V24yhrYVQ@mail.gmail.com>
         <c88b2ecd27524153c2acd8aba6ae3c80@matoro.tk>
         <457a5483c3c4ca5bb6c7ec6f4231074c.pc@manguebit.com>
In-Reply-To: <457a5483c3c4ca5bb6c7ec6f4231074c.pc@manguebit.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.196.253.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EB79D542FA71234BB0135EE8EF78E273@ad.uniklinik-freiburg.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 193.196.253.52
X-FE-Last-Public-Client-IP: 193.196.253.52
X-FE-Policy-ID: 1:4:1:SYSTEM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gTW9udGFnLCBkZW0gMTYuMTAuMjAyMyB1bSAxNTo0MSAtMDMwMCBzY2hyaWViIFBhdWxvIEFs
Y2FudGFyYToNCj4gbWF0b3JvIDxtYXRvcm9fbWFpbGluZ2xpc3Rfa2VybmVsQG1hdG9yby50az4g
d3JpdGVzOg0KPiANCj4gPiBEbyB5b3UgaGF2ZSBiYWNrcG9ydHMgb2YgdGhlc2UgdG8gNi41P8Kg
IEkgdHJpZWQgdG8gZG8gaXQgbWFudWFsbHkNCj4gPiBidXQgDQo+ID4gdGhlcmUncyBhbHJlYWR5
IHNvIG1hbnkgY2hhbmdlcyBiZXR3ZWVuIDYuNSBhbmQgdGhlc2UgY29tbWl0cy4NCj4gDQo+IFBs
ZWFzZSBmaW5kIGF0dGFjaGVkIHR3byBwYXRjaGVzIHRoYXQgc2hvdWxkIGZpeCB5b3VyIFNNQjEg
Y2FzZS7CoA0KPiBUaGV5DQo+IGFwcGxpZWQgY2xlYW5seSBvbiB0b3Agb2YgdjYuNS55IGJyYW5j
aC4NCj4gDQo+IExldCBtZSBrbm93IGlmIGl0IHdvcmtzIGZvciB5b3UgYW5kIHRoZW4gSSdsbCBh
c2sgc3RhYmxlIHRlYW0gdG8gcGljaw0KPiB0aG9zZSB1cC4NCg0KVGhhbmtzIQ0KSSBjYW4gY29u
ZmlybSB0aGF0IHRoZSBwYXRjaGVzIGFwcGx5IGNsZWFubHkgb24gNi41LjggYW5kIGhlbHAgYSBs
b3QNCndpdGggdGhlIGlzc3VlIGhlcmUgKHZlcnM9My4xLjEsIGdlbnRvbyBjbGllbnQsIE1TIEFE
IHNlcnZlciB3aXRoIERGUykuDQoNCg==
