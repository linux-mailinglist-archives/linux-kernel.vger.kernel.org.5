Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DB187D55F7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:22:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbjJXPWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:22:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234864AbjJXPVR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:21:17 -0400
X-Greylist: delayed 767 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Oct 2023 08:18:34 PDT
Received: from m13130.mail.163.com (m13130.mail.163.com [220.181.13.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84AE526BD
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=DpGbO/eDlyACBhle1qGVmQ1cpPK3uAamURX5hja0ZnQ=; b=m
        6vAQgYRy5KPFfhQJISY0CrImn3rmujn+tttAgY9LcD6YVNNDk3WSM7YInyqd5cT1
        n4yWcdjNr5VmLeD+BCAaEdqNUarh9ujfNi3IrFCm7T7Fe6pSKYCZ5cJyrG1yQS2O
        Al2YhTqoUyZPBEj3/4B21z5R/NgrL8OXQlofhcThNM=
Received: from a929244872$163.com ( [124.90.109.239] ) by
 ajax-webmail-wmsvr130 (Coremail) ; Tue, 24 Oct 2023 23:18:13 +0800 (CST)
X-Originating-IP: [124.90.109.239]
Date:   Tue, 24 Oct 2023 23:18:13 +0800 (CST)
From:   =?GBK?B?zfXOsA==?= <a929244872@163.com>
To:     "Matthew Wilcox" <willy@infradead.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re:Re: [PATCH] mm/page_alloc: fix the potential memory waste in
 page_frag_alloc_align
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZTacpcP4zt9BS9xO@casper.infradead.org>
References: <20231023154216.376522-1-a929244872@163.com>
 <ZTacpcP4zt9BS9xO@casper.infradead.org>
X-NTES-SC: AL_QuySCv2dv04i5SmQYukfm0wShew2WMa4vfoj2YNXPJF8jCvk4C0ud0J+B3zJ78ioGgCJoCWqVRhe1eZQWrdyYaAodT+3fkLCoHnv98ELWUnodg==
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <440d5f35.70b0.18b6243d2e6.Coremail.a929244872@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gsGowACHOQo24DdlDe0VAA--.33318W
X-CM-SenderInfo: jdzsmjiuuylji6rwjhhfrp/xS2BKQYTplgi7t4oWgAEsm
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QXQgMjAyMy0xMC0yNCAwMDoxNzo0MSwgIk1hdHRoZXcgV2lsY294IiA8d2lsbHlAaW5mcmFkZWFk
Lm9yZz4gd3JvdGU6Cj5PbiBNb24sIE9jdCAyMywgMjAyMyBhdCAxMTo0MjoxNlBNICswODAwLCB3
YW5nIHdlaSB3cm90ZToKPj4gRmlyc3Qgc3RlcCwgYWxsb2NhdGluZyBhIG1lbW9yeSBmcmFnbWVu
dCB3aXRoIHNpemUgMUtCIGJ5dGVzIHVzZXMKPj4gcGFnZV9mcmFnX2FsbG9jX2FsaWduLiAgSXQg
d2lsbCBhbGxvY2F0ZSBQQUdFX0ZSQUdfQ0FDSEVfTUFYX1NJWkUKPj4gYnl0ZXMgYnkgX19wYWdl
X2ZyYWdfY2FjaGVfcmVmaWxsLCBzdG9yZSB0aGUgcG9pbnRlciBhdCBuYy0+dmEgYW5kCj4+IHRo
ZW4gcmV0dXJuIHRoZSBsYXN0IDFLQiBtZW1vcnkgZnJhZ21lbnQgd2hpY2ggYWRkcmVzcyBpcyBu
Yy0+dmEKPj4gKyBQQUdFX0ZSQUdfQ0FDSEVfTUFYX1NJWkUgLSAxS0IuIFRoZSByZW1haW5pbmcg
UEFHRV9GUkFHX0NBQ0hFX01BWF9TSVpFCj4+IC0gMUtCIGJ5dGVzIG9mIG1lbW9yeSBjYW4gTWVl
dCBmdXR1cmUgbWVtb3J5IHJlcXVlc3RzLgo+PiAKPj4gU2Vjb25kIHN0ZXAsIGlmIHRoZSBjYWxs
ZXIgcmVxdWVzdHMgYSBtZW1vcnkgZnJhZ21lbnQgd2l0aCBzaXplCj4+IG1vcmUgdGhlbiBQQUdF
X0ZSQUdfQ0FDSEVfTUFYX1NJWkUgYnl0ZXMsICBwYWdlX2ZyYWdfYWxsb2NfYWxpZ24sCj4+IGl0
IHdpbGwgYWxzbyBhbGxvY2F0ZSBQQUdFX0ZSQUdfQ0FDSEVfTUFYX1NJWkUgYnl0ZXMgYnkKPj4g
X19wYWdlX2ZyYWdfY2FjaGVfcmVmaWxsLCAgc3RvcmUgdGhlIHBvaW50ZXIgYXQgbmMtPnZhLCBh
bmQKPj4gcmV0dXJuIE5VTEwuICB0aGlzIGJlaGF2aW9yIG1ha2VzIHRoZSByZXN0IG9mCj4+IFBB
R0VfRlJBR19DQUNIRV9NQVhfU0laRSAtIDFLQiBieXRlcyBtZW1vcnkgYXQgRmlyc3Qgc3RlcCBh
cmUKPj4gd2FzdGVkKGFsbG9jYXRlIGZyb20gYnVkZHkgc3lzdGVtIGJ1dCBub3QgdXNlZCkuCj4K
PldlIGNvdWxkIGRvIHRoaXMsIGJ1dCBoYXZlIHlvdSBldmVyIHNlZW4gdGhpcyBoYXBwZW4sIG9y
IGFyZSB5b3UKPmp1c3QgcmVhZGluZyBjb2RlIGFuZCBsb29raW5nIGZvciBwcm9ibGVtcz8gIElm
IHRoZSBsYXR0ZXIsIEkgdGhpbmsKPnlvdSd2ZSBtaXN1bmRlcnN0b29kIGhvdyB0aGlzIGFsbG9j
YXRvciBpcyBub3JtYWxseSB1c2VkLgoKSSBhbSBpbmRlZWQgcmVhZGluZyB0aGUga2VybmVsIG1t
LXN1YnN5c3RlbSBjb2RlIHJlY2VudGx5LiBBbmQgSSBkaWQgCnR3byBleHBlcmltZW50cyBpbiBh
IEFSTTMyIHBsYXRmb3JtIHdoZW4gaSByZWFkIHBhZ2VfZnJhZ19hbGxvY19hbGlnbiBjb2RlLiAK
SW4gdGhpcyBwbGF0Zm9ybSwgUEFHRV9GUkFHX0NBQ0hFX01BWF9TSVpFID0gMzI3NjcoMzJLKS4K
CkZpcnN0IGV4cGVyaW1lbnQgY29kZToKCnN0YXRpYyBpbnQgX19pbml0IHRlc3Rfa29faW5pdCh2
b2lkKQp7CglzdHJ1Y3QgcGFnZV9mcmFnX2NhY2hlIG5jOwoJdm9pZCAqZGF0YTEsICpkYXRhMjsK
CglkYXRhMSA9IF9fYWxsb2NfcGFnZV9mcmFnKCZuYywgMzMgKiAxMDI0LCBOVUxMKTsKCXByaW50
aygiYWxsb2MgMzNLQiBkYXRhMSA9ICV4LCBuYy52YSA9ICV4IFxuIiwgZGF0YTEsIG5jLnZhKTsK
CWRhdGEyID0gX19hbGxvY19wYWdlX2ZyYWcoJm5jLCAzMyAqIDEwMjQsIE5VTEwpOwoJcHJpbnRr
KCJhbGxvYyAzM0tCIGRhdGEyID0gJXgsIG5jLnZhID0gJXggXG4iLCBkYXRhMiwgbmMudmEpOwoJ
cmV0dXJuIDA7Cn0KCm91dHB1dDoKClsgICAxOS45MzkyNjNdIGFsbG9jIDMzS0IgZGF0YTEgPSAw
LCBuYy52YSA9IGMzOTMwMDAwClsgICAxOS45NDM3OTBdIGFsbG9jIDMzS0IgZGF0YTIgPSAwLCBu
Yy52YSA9IGMzOTMwMDAwCgpJbiB0aGlzIGV4cGVyaW1lbnQsIGkgYWxsb2NhdGUgdHdvIDMzS0It
c2l6ZSBtZW1vcnkuICAKX19hbGxvY19wYWdlX2ZyYWcgcmV0dXJucyBOVUxMIGluZGljYXRlcyB0
aGUgbWVtb3J5IHJlcXVlc3QgY291bGQgbm90IGJlIG1lZXQuCgpTZWNvbmQgZXhwZXJpbWVudCBj
b2RlOgoKc3RhdGljIGludCBfX2luaXQgdGVzdF9rb19pbml0KHZvaWQpCnsKCXN0cnVjdCBwYWdl
X2ZyYWdfY2FjaGUgbmM7Cgl2b2lkICpkYXRhMSwgKmRhdGEyOwoKCWRhdGExID0gX19hbGxvY19w
YWdlX2ZyYWcoJm5jLCAxICogMTAyNCwgTlVMTCk7CglwcmludGsoImFsbG9jIDFLQiBkYXRhMSA9
ICV4LCBuYy52YSA9ICV4IFxuIiwgZGF0YTEsIG5jLnZhKTsKCWRhdGEyID0gX19hbGxvY19wYWdl
X2ZyYWcoJm5jLCAzMyAqIDEwMjQsIE5VTEwpOwoJcHJpbnRrKCJhbGxvYyAzM0tCIGRhdGEyID0g
JXgsIG5jLnZhID0gJXggXG4iLCBkYXRhMiwgbmMudmEpOwoJcmV0dXJuIDA7Cn0KCm91dHB1dDoK
ClsgICAxNS45MDY1NjZdIGFsbG9jIDFLQiBkYXRhMSA9IGMzOTM3YzAwLCBuYy52YSA9IGMzOTMw
MDAwClsgICAxNS45MTE2MzJdIGFsbG9jIDMzS0IgZGF0YTIgPSAwLCBuYy52YSA9IGMzOTM4MDAw
CgpJbiB0aGlzIGV4cGVyaW1lbnQsIGkgYWxsb2NhdGUgMUtCLXNpemUgYW5kIDMzS0Itc2l6ZSBt
ZW1vcnkuICAKX19hbGxvY19wYWdlX2ZyYWcgcmV0dXJucyBOVUxMIHdoZW4gaSBhbGxvY2F0ZSAz
M0tCLXNpemUgbWVtb3J5LgpCdXQsIG5jLnZhIGlzIG5ldyBwb2ludGVyIHRvIGEgMzJLQiBtZW1v
cnkgZnJhZ21lbnQuIFNvIHRoZSBtZW1vcnkgCmJldHdlZW4gYzM5MzAwMDAgYW5kIGMzOTM3YmZm
IGlzIHVudXNlZC4gdGhpcyB3aGF0IGkgc2FpZCBtZW1vcnkgd2FzdGUuCgpCYXNlZCBvbiB0aGUg
dHdvIGV4cGVyaW1lbnRzIGFib3ZlLCBJIHN1c3BlY3QgdGhpcyB3aWxsIGhhcHBlbiBvbiAKb3Ro
ZXIgcGxhdGZvcm1zIGFzIHdlbGwuIAoKSSBhbSBuZXcgY29tbWVyIGZvciBrZXJuZWwgY29kZSwg
YW5kIEkgYW0gbm90IHZlcnkgdW5kZXJzdGFuZCAKbG9zdCBvZiBrZXJuZWwgZnVuY3Rpb25zJyB1
c2UuIFRoYW5rcyBmb3IgeW91ciBhZHZpY2UuCgoKCgoK
