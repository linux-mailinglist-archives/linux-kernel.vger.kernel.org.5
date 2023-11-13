Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B86ED7EA05D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 16:43:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231295AbjKMPnv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 10:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjKMPnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 10:43:50 -0500
Received: from m13128.mail.163.com (m13128.mail.163.com [220.181.13.128])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B5146C2
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 07:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Content-Type:MIME-Version:
        Message-ID; bh=Fuv98azFKRVeZ0C2oKaVVTfLjXZDC4AIwopP0MRSCgs=; b=P
        ctq+axoTKKWAvKlrLr4wOaGTVWHDj2AWOWDKPsgLQBNnyokh1gEGg8ycTBlmvL/A
        9/V+SB2mPu6Pt8uOrkR0gBAqXo8rmoWVZ61vdYVSLc5ODNeCTYuDQ/txc56Vhp7t
        cZ2uiQqd/ADLDwQLdsbyrPUxZUR4nRjqCx6eq4KvVs=
Received: from 00107082$163.com ( [111.35.186.243] ) by
 ajax-webmail-wmsvr128 (Coremail) ; Mon, 13 Nov 2023 23:42:53 +0800 (CST)
X-Originating-IP: [111.35.186.243]
Date:   Mon, 13 Nov 2023 23:42:53 +0800 (CST)
From:   "David Wang" <00107082@163.com>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     "David Hildenbrand" <david@redhat.com>, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        "Mike Rapoport" <rppt@linux.ibm.com>
Subject: Re: [BUG?] mm/secretmem: memory address mapped to memfd_secret can
 be used in write syscall.
X-Priority: 3
X-Mailer: Coremail Webmail Server Version XT5.0.14 build 20230109(dcb5de15)
 Copyright (c) 2002-2023 www.mailtech.cn 163com
In-Reply-To: <ZVIj_cDIzat39lQ6@mit.edu>
References: <61159548.60cf.18baec1fd65.Coremail.00107082@163.com>
 <60081af2-d580-4f82-9233-3d3d7dd883bc@redhat.com>
 <ZVIj_cDIzat39lQ6@mit.edu>
X-NTES-SC: AL_QuySC/SSv0ks5SaZZ+kZnEYQheY4XMKyuPkg1YJXOp80gyvT3hsKQUNaAUD7z/iOJxGOjCSVSzl05dZDZIVbYL55ROyXHEtKpHgQvSCWpQwC
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=GBK
MIME-Version: 1.0
Message-ID: <cf33b9b.709e.18bc95996af.Coremail.00107082@163.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: gMGowADnT3v+Q1JlB48GAA--.35339W
X-CM-SenderInfo: qqqrilqqysqiywtou0bp/1tbiEBInql8YMcOO0gAFsj
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CgpBdCAyMDIzLTExLTEzIDIxOjI2OjIxLCAiVGhlb2RvcmUgVHMnbyIgPHR5dHNvQG1pdC5lZHU+
IHdyb3RlOgo+T24gTW9uLCBOb3YgMTMsIDIwMjMgYXQgMTA6MTU6MDVBTSArMDEwMCwgRGF2aWQg
SGlsZGVuYnJhbmQgd3JvdGU6Cj4+IAo+PiBBY2NvcmRpbmcgdG8gdGhlIG1hbiBwYWdlOgo+PiAK
Pj4gIlRoZSAgbWVtb3J5IGFyZWFzIGJhY2tpbmcgdGhlIGZpbGUgY3JlYXRlZCB3aXRoIG1lbWZk
X3NlY3JldCgyKSBhcmUgdmlzaWJsZQo+PiBvbmx5IHRvIHRoZSBwcm9jZXNzZXMgdGhhdCBoYXZl
IGFjY2VzcyB0byB0aGUgZmlsZSBkZXNjcmlwdG9yLiBUaGUgbWVtb3J5Cj4+IHJlZ2lvbiBpcyBy
ZW1vdmVkIGZyb20gdGhlIGtlcm5lbCBwYWdlIHRhYmxlcyBhbmQgb25seSB0aGUgcGFnZSB0YWJs
ZXMgIG9mCj4+IHRoZSAgcHJvY2Vzc2VzICBob2xkaW5nICB0aGUgZmlsZSBkZXNjcmlwdG9yIG1h
cCB0aGUgY29ycmVzcG9uZGluZyBwaHlzaWNhbAo+PiBtZW1vcnkuICAoVGh1cywgdGhlIHBhZ2Vz
IGluIHRoZSByZWdpb24gY2FuJ3QgYmUgYWNjZXNzZWQgYnkgdGhlIGtlcm5lbAo+PiBpdHNlbGYs
IHNvIHRoYXQsIGZvciBleGFtcGxlLCBwb2ludGVycyAgdG8gIHRoZSByZWdpb24gY2FuJ3QgYmUg
cGFzc2VkIHRvCj4+IHN5c3RlbSBjYWxscy4pCj4+IAo+PiBJJ20gbm90IHN1cmUgaWYgdGhlIGxh
c3QgcGFydCBpcyBhY3R1YWxseSB0cnVlLCBpZiB0aGUgc3lzY2FsbHMgZW5kIHVwCj4+IHdhbGtp
bmcgdXNlciBwYWdlIHRhYmxlcyB0byBjb3B5IGRhdGEgaW4vb3V0Lgo+Cj5UaGUgaWRlYSBiZWhp
bmQgcmVtb3ZpbmcgaXQgZnJvbSB0aGUga2VybmVsIHBhZ2UgdGFibGVzIGlzIHNvIHRoYXQKPmtl
cm5lbCBjb2RlIHJ1bm5pbmcgaW4gc29tZSBvdGhlciBwcm9jZXNzIGNvbnRleHQgd29uJ3QgYmUg
YWJsZSB0bwo+cmVmZXJlbmNlIHRoZSBtZW1vcnkgdmlhIHRoZSBrZXJuZWwgYWRkcmVzcyBzcGFj
ZS4gIChTbyBpZiB0aGVyZSBpcwo+c29tZSBraW5kIG9mIGtlcm5lbCB6ZXJvLWRheSB3aGljaCBh
bGxvd3MgYXJiaXRyYXJ5IGNvZGUgZXhlY3V0aW9uLAo+dGhlIGluamVjdGVkIGF0dGFjayBjb2Rl
IHdvdWxkIGhhdmUgdG8gcGxheSBnYW1lcyB3aXRoIHBhZ2UgdGFibGVzCj5iZWZvcmUgYmVpbmcg
YWJsZSB0byByZWZlcmVuY2UgdGhlIG1lbW9yeSAtLS0gdGhpcyBpcyBub3QKPippbXBvc3NpYmxl
KiwganVzdCBtb3JlIGFubm95aW5nLikKPgo+QnV0IGlmIHlvdSBhcmUgZG9pbmcgYSBidWZmZXJl
ZCB3cml0ZSwgdGhlIGNvcHkgZnJvbSB0aGUgdXNlci1zdXBwbGllZAo+YnVmZmVyIHRvIHRoZSBw
YWdlIGNhY2hlIGlzIGhhcHBlbmluZyBpbiB0aGUgcHJvY2VzcydzIGNvbnRleHQuICBTbwo+ImZv
cmVncm91bmQga2VybmVsIGNvZGUiIGNhbiBkZXJlZmVyZW5jZSB0aGUgdXNlci1zdXBwbGllZCBw
b2ludGVyCj5qdXN0IGZpbmUuCj4KCkJ1dCB0aGUgIGluY29uc2lzdGVudCB0cmVhdG1lbnQgaW4g
a2VybmVsLCAgIG1lbWZkIGRlbmllZCB3aGlsZSAgbW1hcGVkLWFkZHJlc3MgYWxsb3dlZCwgICBp
cyBraW5kIG9mIGNvbmZ1c2luZy4uLgpJIHRob3VnaHQgdGhvc2UgdHdvIHNob3VsZCBiZSB0cmVh
dGVkIHRoZSBzYW1lIHdheS4uLi4KClRoYW5rcwpEYXZpZCBXYW5n
