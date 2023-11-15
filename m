Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C67D7EC833
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 17:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232378AbjKOQM0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 11:12:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232227AbjKOQMY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 11:12:24 -0500
Received: from m13115.mail.163.com (m13115.mail.163.com [220.181.13.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 229E683;
        Wed, 15 Nov 2023 08:12:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=GXGVKdwy5DsAX8pLOcKCWbltln5EH7eBs7UasJPfv18=; b=m
        S1G6Fs9C7e8Ly++5BikQ+zBNBR86m6MI/S/kymnkBpVL5BTS7lWpJCFy5VPS5UHv
        Nt3JmGR30OIbQFOdXFEdnIYnLL4P4UefpYGGVljjRroFITbt8tXTxQp7nL185jyd
        ydV3VsNEDnsvCP0uUW846+a6Nb79VwENATdHU5ii6k=
Received: from 00107082$163.com ( [111.35.186.243] ) by
 ajax-webmail-wmsvr115 (Coremail) ; Thu, 16 Nov 2023 00:11:34 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Thu, 16 Nov 2023 00:11:34 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Namhyung Kim" <namhyung@kernel.org>
Cc:     "Peter Zijlstra" <peterz@infradead.org>, mingo@redhat.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Regression or Fix]perf: profiling stats sigificantly changed
 for aio_write/read(ext4) between 6.7.0-rc1 and 6.6.0
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
 <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
X-NTES-SC: AL_Qu2bAvydu04i4iOdYOkZnEYQheY4XMKyuPkg1YJXOp80qSvR3Ac+Qm1GJF3b/P+fAQWUogqGWwBf7vl6YbVUVpzNPh8ERBbpPFgUzWYcPEHd
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: c8GowADnD4m37VRlRMQHAA--.64135W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/xtbBnAEpqlghlW-3-AAFsT
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CuWcqCAyMDIzLTExLTE1IDIzOjQ4OjMz77yMIk5hbWh5dW5nIEtpbSIgPG5hbWh5dW5nQGtlcm5l
bC5vcmc+IOWGmemBk++8mgo+T24gV2VkLCBOb3YgMTUsIDIwMjMgYXQgMzowMOKAr0FNIERhdmlk
IFdhbmcgPDAwMTA3MDgyQDE2My5jb20+IHdyb3RlOgo+Pgo+Pgo+Pgo+PiBBdCAyMDIzLTExLTE1
IDE4OjMyOjQxLCAiUGV0ZXIgWmlqbHN0cmEiIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4gd3JvdGU6
Cj4+ID4KPj4gPk5hbWh5dW5nLCBjb3VsZCB5b3UgcGxlYXNlIHRha2UgYSBsb29rLCB5b3Uga25v
dyBob3cgdG8gb3BlcmF0ZSB0aGlzCj4+ID5jZ3JvdXAgc3R1ZmYuCj4+ID4KPj4KPj4gTW9yZSBp
bmZvcm1hdGlvbiwgIEkgcnVuIHRoZSBwcm9maWxpbmcgd2l0aCA4Y3B1IG1hY2hpbmUgb24gYSBT
U0Qgd2l0aCBleHQ0IGZpbGVzeXN0ZW0gOgo+Pgo+PiAjIG1rZGlyIC9zeXMvZnMvY2dyb3VwL215
dGVzdAo+PiAjIGVjaG8gJCQgPiAvc3lzL2ZzL2Nncm91cC9teXRlc3QvY2dyb3VwLnByb2NzCj4+
ICMjIFN0YXJ0IHByb2ZpbGluZyB0YXJnZXRpbmcgY2dyb3VwIC9zeXMvZnMvY2dyb3VwL215dGVz
dCAgIG9uIGFub3RoZXIgdGVybWluYWwKPj4gIyBmaW8gLS1yYW5kcmVwZWF0PTEgLS1pb2VuZ2lu
ZT1saWJhaW8gLS1kaXJlY3Q9MSAtLW5hbWU9dGVzdCAgLS1icz00ayAtLWlvZGVwdGg9NjQgLS1z
aXplPTFHIC0tcmVhZHdyaXRlPXJhbmRydyAgLS1ydW50aW1lPTYwMCAtLW51bWpvYnM9NCAtLXRp
bWVfYmFzZWQ9MQo+Pgo+PiBJIGdvdCBhIGZlZWxpbmcgdGhhdCBmMDZjYzY2N2Y3OTkwIHdvdWxk
IGRlY3JlYXNlIHRvdGFsIHNhbXBsZXMgYnkgMTAlfjIwJSB3aGVuIHByb2ZpbGluZyBJTyBiZW5j
aG1hcmsgd2l0aGluIGNncm91cC4KPgo+T2ggc29ycnksIEkgbWlzc2VkIHRoaXMgbWVzc2FnZS4g
IENhbiB5b3UgcGxlYXNlIHNoYXJlIHRoZQo+Y29tbWFuZCBsaW5lIGFuZCB0aGUgb3V0cHV0Pwo+
CkkgZGlkIG5vdCB1c2UgcGVyZi4uLi4uIFRoaXMgaXMgdGhlIHBhcnQgd2hlcmUgIGl0IGlzIG5v
dCBxdWl0ZSBjb252aW5jaW5nIHRvIHJlcG9ydCB0aGUgY2hhbmdlLCBJIGFtIHVzaW5nIGEgcHJv
ZmlsaW5nIHRvb2wgb2YgbXkgb3duIGFzIEkgbWVudGlvbmVkIGluIHRoZSBmaXJzdCBtYWlsLi4u
Li4KQnV0IEkgYmVsaWV2ZSBteSBwcm9maWxpbmcgdG9vbHMgZGlkIGRldGVjdCBzb21lIGNoYW5n
ZXMuCgpJIGFtIG5vdCBleHBlcmllbmNlZCB3aXRoIHRoZSBwZXJmLXRvb2wgYXQgYWxsLCAgIHRv
byBjb21wbGljYXRlZCBhIHRvb2wgZm9yIG1lLi4uLiBCdXQgSSB0aGluayBJIGNhbiB0cnkgaXQu
CgpEYXZpZCBXYW5nLgo=
