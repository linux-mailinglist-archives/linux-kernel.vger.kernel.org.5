Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80627EFD09
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 02:55:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232709AbjKRBsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 20:48:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjKRBse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 20:48:34 -0500
Received: from m1316.mail.163.com (m1316.mail.163.com [220.181.13.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0683BD79;
        Fri, 17 Nov 2023 17:48:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=kQWPGBGA003W+v9st+8v1Kv9E76Ff1X5kUDffYhbGBI=; b=T
        O+JTLpUzLYRo1dBC0/wba80D8xtLS7ZpUELIy4iQA604J9sGsXmONX+c7j/DtqRo
        xuBvElWpUVqYfplpfmtNzj3zoLOIGgsx6Z9/ojhNgfo3GWWL8dissbtR3ykq1PCK
        79z5ZmUtwbuWya3WYXEgUgk+EHqFzQA8CyAEZDoAMA=
Received: from 00107082$163.com ( [111.35.185.43] ) by ajax-webmail-wmsvr16
 (Coremail) ; Sat, 18 Nov 2023 09:46:42 +0800 (CST)
X-Originating-IP: [111.35.185.43]
Date:   Sat, 18 Nov 2023 09:46:42 +0800 (CST)
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
In-Reply-To: <CAM9d7cg-tudzG4iPMHs5L-zYMe-WhyzZXN9eOtkoapS1n7t8AA@mail.gmail.com>
References: <449fb8d2.27fb.18bcc190021.Coremail.00107082@163.com>
 <76d75357.6ab6.18bce6b7d5b.Coremail.00107082@163.com>
 <20231115103241.GD3818@noisy.programming.kicks-ass.net>
 <407a06f8.632a.18bd2a2ece1.Coremail.00107082@163.com>
 <CAM9d7cgdUJytP31y90c5AuQAmR6FgkBWjj4brVjH8Pg+d00O+Q@mail.gmail.com>
 <1a1338d0.6b3a.18bd3c09056.Coremail.00107082@163.com>
 <CAM9d7cgjCKynoTC0L53pEXnCWHF7AZ8Gr2a0xQnes7L24KVNsA@mail.gmail.com>
 <489ecb9e.28cc.18bd650affa.Coremail.00107082@163.com>
 <CAM9d7cg-tudzG4iPMHs5L-zYMe-WhyzZXN9eOtkoapS1n7t8AA@mail.gmail.com>
X-NTES-SC: AL_Qu2bAv6cvUgr5CeeYekZnEYQheY4XMKyuPkg1YJXOp80oync1S84Y3JdOXXx0/2PKjCsvRWLYQpXyuhjfrl9UJyuyfAn6WnRQ3hZgeYIctXO
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <1da1b7f.564.18be01bd6ce.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: EMGowAD3nwaDF1hlGDUgAA--.24165W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEBIrql8YMjKeegAGsm
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

CkF0IDIwMjMtMTEtMTggMDU6MTE6MDIsICJOYW1oeXVuZyBLaW0iIDxuYW1oeXVuZ0BrZXJuZWwu
b3JnPiB3cm90ZToKPk9uIFdlZCwgTm92IDE1LCAyMDIzIGF0IDg6MDnigK9QTSBEYXZpZCBXYW5n
IDwwMDEwNzA4MkAxNjMuY29tPiB3cm90ZToKPj4KCj4+Cj4+Cj4+IEZyb20gdGhlIGRhdGEgSSBj
b2xsZWN0ZWQsIEkgdGhpbmsgdHdvIHByb2JsZW0gY291bGQgYmUgb2JzZXJ2ZWQgZm9yIGYwNmNj
NjY3Zjc5OTA5ZTkxNzU0NjBiMTY3YzI3N2I3YzY0ZDNkZjAKPj4gMS4gc2FtcGxlIG1pc3Npbmcu
Cj4+IDIuIHNhbXBsZSB1bnN0YWJsZSwgdG90YWwgc2FtcGxlIGNvdW50IGRyaWZ0IGEgbG90IGJl
dHdlZW4gdGVzdHMuCj4KPkhtbS4uIHNvIHRoZSBmaW8gcHJvY2VzcyB3YXMgcnVubmluZyBpbiB0
aGUgYmFja2dyb3VuZCBkdXJpbmcKPnRoZSBwcm9maWxpbmcsIHJpZ2h0PyAgQnV0IEknbSBub3Qg
c3VyZSBob3cgeW91IG1lYXN1cmVkIHRoZSBzYW1lCj5hbW91bnQgb2YgdGltZS4gIFByb2JhYmx5
IHlvdSBuZWVkIHRvIHJ1biB0aGlzIChmb3IgMTAgc2Vjb25kcyk6Cj4KPiAgc3VkbyBwZXJmIHJl
Y29yZCAtYSAtRyBteXRlc3QgLS0gc2xlZXAgMTAKPgo+QW5kIEkgZ3Vlc3MgeW91IGRvbid0IHJ1
biB0aGUgcGVyZiBjb21tYW5kIGluIHRoZSB0YXJnZXQgY2dyb3VwCj53aGljaCBpcyBnb29kLgo+
CgpZZXMgIHByb2ZpbGluZyBwcm9jZXNzIHdhcyBub3QgaW4gdGhlIHRhcmdldCBjZ3JvdXAuCkkg
dXNlICBmaW8gd2l0aCBgZmlvIC0tcmFuZHJlcGVhdD0xIC0taW9lbmdpbmU9bGliYWlvIC0tZGly
ZWN0PTEgLS1uYW1lPXRlc3QgIC0tYnM9NGsgLS1pb2RlcHRoPTY0IC0tc2l6ZT0xRyAtLXJlYWR3
cml0ZT1yYW5kcncgIC0tcnVudGltZT02MDAgLS1udW1qb2JzPTQgLS10aW1lX2Jhc2VkPTFgIHdo
aWNoIHdvdWxkIHJ1biA2MDAgc2Vjb25kcy4KVGhlcmUgd291bGQgYmUgZHJpZnRzIGluIHRoZSBw
cm9maWxpbmcgcmVwb3J0IGJldHdlZW4gcnVucywgIGZyb20gdGhvc2Ugc21hbGwgIHNhbXBsZXMg
b2YgdGVzdCBkYXRhIEkgY29sbGVjdGVkLCBtYXliZSBub3QgZW5vdWdoIHRvIG1ha2UgYSBmaXJt
IGNvbmNsdXNpb24sICBJIGZlZWwgd2hlbiB0aGUgY29tbWl0IGlzIHJldmVydGVkLCB0aGUgZXhw
ZWN0YXRpb24gZm9yIHRvdGFsIHNhbXBsZSBjb3VudCBpcyBoaWdoZXIgYW5kIHRoZSBzdGFuZGFy
ZCBkZXZpYXRpb24gaXMgc21hbGxlci4KCj5BbmQgaXMgdGhlcmUgYW55IGNoYW5jZSBpZiBpdCdz
IGltcHJvdmVkIGJlY2F1c2Ugb2YgdGhlIGNoYW5nZT8KPkFyZSB0aGUgbnVtYmVycyBpbiA2Ljcg
YmV0dGVyIG9yIHdvcnNlPwo+CkkgaGF2ZSBubyBpZGVhIHdoZXRoZXIgdGhlIGNoYW5nZSBvZiBl
eHBlY3RlZCB0b3RhbCBzYW1wbGUgY291bnQgYSBidWcgb3IgYSBmaXgsICBidXQsICB0aGUgb2Jz
ZXJ2ZWQgcmVzdWx0IHRoYXQgdG90YWwgc2FtcGxlIGNvdW50IGRyaWZ0IGEgbG90IChiaWdnZXIg
c3RhbmRhcmQgZGV2aWF0aW9uKSwgSSB0aGluayAsICBpcyBhIGJhZCB0aGluZy4gCiAKClRoYW5r
cwpEYXZpZCBXYW5nCg==
