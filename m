Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A27D7BA497
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237549AbjJEQHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237979AbjJEQFg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:05:36 -0400
X-Greylist: delayed 4165 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 05 Oct 2023 08:54:29 PDT
Received: from a1712.mx.srv.dfn.de (a1712.mx.srv.dfn.de [194.95.232.209])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BECC194;
        Thu,  5 Oct 2023 08:54:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=
        uniklinik-freiburg.de; h=mime-version:content-transfer-encoding
        :content-id:content-type:content-type:content-language
        :accept-language:in-reply-to:references:message-id:date:date
        :subject:subject:from:from:received:received:received; s=s1; t=
        1696499748; x=1698314149; bh=lKcngNkNaJ2ZDxjfFkR58Vb8y7czhkiNh4X
        i9DQEKJ8=; b=RNwuOCJBvaCCe6DAQSnKXYMYYGYTK3A/UCkvo4ZdmXogen8DtQf
        9/V57bB9rE/uT8kb+OloNheioZUQRTPUTlPM/ju/e9zFevYHfyscYNDBJuAjFYnr
        O4lLh59Hfk330BG7hXKIUQK2/fl7eKuG2iQXHtczRqOZRoTetikbVOUk=
Received: from ukl-fm1.ukl.uni-freiburg.de (ukl-fm-ha.ukl.uni-freiburg.de [193.196.199.18])
        by a1712.mx.srv.dfn.de (Postfix) with ESMTPS id D112538010B;
        Thu,  5 Oct 2023 11:55:48 +0200 (CEST)
Received: from UKL-EX3.ad.uniklinik-freiburg.de (xxx53.ukl.uni-freiburg.de [193.196.253.53])
        by ukl-fm1.ukl.uni-freiburg.de  with ESMTPS id 3959tfPs008803-3959tfPu008803
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=OK);
        Thu, 5 Oct 2023 11:55:41 +0200
Received: from UKL-EX4.ad.uniklinik-freiburg.de (193.196.253.54) by
 UKL-EX3.ad.uniklinik-freiburg.de (193.196.253.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:55:41 +0200
Received: from UKL-EX4.ad.uniklinik-freiburg.de ([fe80::6c6e:c675:beef:7071])
 by UKL-EX4.ad.uniklinik-freiburg.de ([fe80::6c6e:c675:beef:7071%5]) with mapi
 id 15.01.2507.032; Thu, 5 Oct 2023 11:55:41 +0200
From:   "Dr. Bernd Feige" <bernd.feige@uniklinik-freiburg.de>
To:     "tom@talpey.com" <tom@talpey.com>,
        "smfrench@gmail.com" <smfrench@gmail.com>,
        "paul@darkrain42.org" <paul@darkrain42.org>
CC:     "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "bagasdotme@gmail.com" <bagasdotme@gmail.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "pc@manguebit.com" <pc@manguebit.com>,
        "ronniesahlberg@gmail.com" <ronniesahlberg@gmail.com>,
        "nspmangalore@gmail.com" <nspmangalore@gmail.com>,
        "brian.pardy@gmail.com" <brian.pardy@gmail.com>,
        "bharathsm@microsoft.com" <bharathsm@microsoft.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS share
 is mounted (cifsd-cfid-laundromat in"D" state)
Thread-Topic: Possible bug report: kernel 6.5.0/6.5.1 high load when CIFS
 share is mounted (cifsd-cfid-laundromat in"D" state)
Thread-Index: AQHZ92+sm0zmujZcU0uXcBrFhineoLA608yA
Date:   Thu, 5 Oct 2023 09:55:41 +0000
Message-ID: <85d538fec5a086acf62d5a803056586a6c00e4bd.camel@uniklinik-freiburg.de>
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
In-Reply-To: <ZRN9MtBqYnT6oX60@vaarsuvius>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [193.196.253.71]
Content-Type: text/plain; charset="utf-8"
Content-ID: <68FBD33032B9744A8A19C5C1FDCA7193@ad.uniklinik-freiburg.de>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-FEAS-Client-IP: 193.196.253.53
X-FE-Last-Public-Client-IP: 193.196.253.53
X-FE-Policy-ID: 1:4:1:SYSTEM
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QW0gRGllbnN0YWcsIGRlbSAyNi4wOS4yMDIzIHVtIDE3OjU0IC0wNzAwIHNjaHJpZWIgUGF1bCBB
dXJpY2g6DQo+IFBlcmhhcHMgdGhlIGxhdW5kcm9tYXQgdGhyZWFkIHNob3VsZCBiZSB1c2luZyBt
c2xlZXBfaW50ZXJydXB0aWJsZSgpPw0KPiANCj4gVXNpbmcgYW4gaW50ZXJydXB0aWJsZSBzbGVl
cCBhcHBlYXJzIHRvIHByZXZlbnQgdGhlIHRocmVhZCBmcm9tDQo+IGNvbnRyaWJ1dGluZyANCj4g
dG8gdGhlIGxvYWQgYXZlcmFnZSwgYW5kIGhhcyB0aGUgaGFwcHkgc2lkZS1lZmZlY3Qgb2YgcmVt
b3ZpbmcgdGhlDQo+IHVwLXRvLTFzIGRlbGF5IA0KPiB3aGVuIHRlYXJpbmcgZG93biB0aGUgdGNv
biAoc2luY2UgYTdjMDFmYTkzYWUsIGt0aHJlYWRfc3RvcCgpIHdpbGwNCj4gcmV0dXJuIA0KPiBl
YXJseSB0cmlnZ2VyZWQgYnkga3RocmVhZF9zdG9wKS4NCg0KU29ycnkgZm9yIGNoaW1pbmcgaW4g
c28gbGF0ZSAtIEknbSBhbHNvIG9uIGdlbnRvbyAoa2VybmVsIDYuNS41LQ0KZ2VudG9vKSwgYnV0
IGFzIGEgY2xpZW50IG9mIFdpbmRvd3MgQUQuDQoNCkp1c3Qgd2FudCB0byBlbXBoYXNpemUgdGhh
dCB1c2luZyB1bmludGVycnVwdGlibGUgc2xlZXAgaGFzIG5vdCBqdXN0DQp1bmhhcHB5IGJ1dCBk
ZXZhc3RhdGluZyBzaWRlLWVmZmVjdHMuDQoNCkkgaGF2ZSA4IHByb2Nlc3NvcnMgYW5kIDE2IGNp
ZnNkLWNmaWQtbGF1bmRyb21hdCBwcm9jZXNzZXMsIHNvDQovcHJvYy9sb2FkYXZnIHJlcG9ydHMg
YSBsb2FkIGF2ZXJhZ2Ugb2YgMTYgb24gYSB0b3RhbGx5IGlkbGUgc3lzdGVtLg0KDQpUaGlzIG1l
YW5zIHRoYXQgbG9hZC1iYWxhbmNpbmcgc29mdHdhcmUgd2lsbCBuZXZlciBzdGFydCBhZGRpdGlv
bmFsDQp0YXNrcyBvbiB0aGlzIHN5c3RlbSAtICJtYWtlIC1sIiBidXQgYWxzbyBhbnkgb3RoZXIg
bG9hZC1kZXBlbmRlbnQNCnN5c3RlbS4gSnVzdCByZWR1Y2luZyB0aGUgbnVtYmVyIG9mIGNpZnNk
LWNmaWQtbGF1bmRyb21hdCBwcm9jZXNzZXMNCmRvZXMgbm90IGZpeCB0aGlzIC0gZXZlbiBhIHNp
bmdsZSBvbmUgbWFrZXMgbG9hZGF2ZyByZXBvcnQgYSB3cm9uZw0KcmVzdWx0IGZvciBsb2FkIGJh
bGFuY2luZy4NCg0KU28sIGlmIGNpZnNkLWNmaWQtbGF1bmRyb21hdCBtdXN0IHJlYWxseSBiZSB1
bmludGVycnVwdGlibGUsIHRoZSBvbmx5DQpzb2x1dGlvbiB3b3VsZCBiZSB0byBjaGFuZ2UgdGhl
IHdheSBsb2FkYXZnIGlzIGNvbXB1dGVkIGJ5IHRoZSBrZXJuZWwNCnRvIGV4Y2x1ZGUgdW5pbnRl
cnJ1cHRpYmxlIGJ1dCBzbGVlcGluZyBwcm9jZXNzZXMuIEJ1dCBtdXN0IGl0IGJlDQp1bmludGVy
cnVwdGlibGU/DQoNClRoYW5rcyBhbmQgYmVzdCByZWdhcmRzLA0KQmVybmQNCg==
