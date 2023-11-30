Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 384BE7FF11B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbjK3ODf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:03:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232108AbjK3ODd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:03:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E43D9D
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:03:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701353019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gmdPA6Q0p/W1i/RS4gTbBPaBlWq/FezNYBpeVlP4grs=;
        b=N8xcDpw2///jfjNKoZnElslDFdSb1Qt4gVElagYoZjKwiHtT76t0lZYLrNAPRe7l7j4UU8
        KzLVaHGM4mE/6I8NOp+DZeqIKWF0dqMbGhkdYNAgPLrtVKK1x77sjowTdQ+P3ti/HQXOHL
        YNau5B4eVgWP4oGNc3PHPENRrJXsmcQ=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-8E4ocuv_P8CAQHWuppM7sQ-1; Thu, 30 Nov 2023 09:03:36 -0500
X-MC-Unique: 8E4ocuv_P8CAQHWuppM7sQ-1
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6cde4342fe9so1000446b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:03:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701353015; x=1701957815;
        h=content-transfer-encoding:mime-version:references:in-reply-to:from
         :subject:cc:to:message-id:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gmdPA6Q0p/W1i/RS4gTbBPaBlWq/FezNYBpeVlP4grs=;
        b=j30eMch8rkfLY53BHdU18EiDNTbS+/KvH1RkcSYtqixT7u/yWQGkEwJfVra0ij286r
         3GWB8VCU+Kk8jjchWCA7YUvnTDbWXlIKzqp6wludveRU7BP42RORZ27ZsbdDcO7o5fRu
         FeUy+dJE/2tt2881v4n0++WUFA/aAocp8YHS8Z3F0AoiDj3S6TvJFEvDl0rjaEnMuTrp
         m2mSBS2nADmjHVrnebhEyvAAEd+meI7MiXybpfOT4yiHKEn+lHhRLjngccRIwDAcW4BJ
         sjHzTJdbHirIaVryn29Fa4I6fHa2jzPERVk5DaE3xTWAqGI3mBSjelpHLbPQQROoX/Rn
         TlQw==
X-Gm-Message-State: AOJu0YwjOh0O25syo7+UKWbSFGnkPCeDz048k99hBlivL4vPSc+ukG4h
        BQ8R+hU+dqWCk+WRO4A25RJRI23SyAaCk8KCAAGnasxt9QEA0DKaw3NsyWNjTiRwXN0Au5S0VqQ
        cHDlRcWm8pY2n7izsIEiy/GCWUtfiFMy6
X-Received: by 2002:a05:6a20:7d90:b0:18c:159b:7f9 with SMTP id v16-20020a056a207d9000b0018c159b07f9mr21669081pzj.9.1701353015305;
        Thu, 30 Nov 2023 06:03:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEdSW+2umD53SCs6TiYdklpG0q3siARTKLwhi4Q9J/3czjPhDQqPtFb2ESipFTTfZjLCSxxKg==
X-Received: by 2002:a05:6a20:7d90:b0:18c:159b:7f9 with SMTP id v16-20020a056a207d9000b0018c159b07f9mr21669055pzj.9.1701353014964;
        Thu, 30 Nov 2023 06:03:34 -0800 (PST)
Received: from localhost ([240d:1a:c0d:9f00:3342:3fe3:7275:954])
        by smtp.gmail.com with ESMTPSA id y62-20020a62ce41000000b006be0fb89ac3sm1269885pfg.30.2023.11.30.06.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:03:34 -0800 (PST)
Date:   Thu, 30 Nov 2023 23:03:29 +0900 (JST)
Message-Id: <20231130.230329.2023533070545022513.syoshida@redhat.com>
To:     edumazet@google.com
Cc:     willemdebruijn.kernel@gmail.com, pabeni@redhat.com,
        davem@davemloft.net, dsahern@kernel.org, kuba@kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] ipv4: ip_gre: Handle skb_pull() failure in
 ipgre_xmit()
From:   Shigeru Yoshida <syoshida@redhat.com>
In-Reply-To: <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
References: <6564bbd5580de_8a1ac29481@willemb.c.googlers.com.notmuch>
        <20231129.105046.2126277148145584341.syoshida@redhat.com>
        <CANn89iLxEZAjomWEW4GFJds6kyd6Zf+ed9kx6eVsaQ57De6gMw@mail.gmail.com>
X-Mailer: Mew version 6.9 on Emacs 29.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2VkLCAyOSBOb3YgMjAyMyAxMDo1Njo0NyArMDEwMCwgRXJpYyBEdW1hemV0IHdyb3RlOg0K
PiBPbiBXZWQsIE5vdiAyOSwgMjAyMyBhdCAyOjUx4oCvQU0gU2hpZ2VydSBZb3NoaWRhIDxzeW9z
aGlkYUByZWRoYXQuY29tPiB3cm90ZToNCj4+DQo+PiBPbiBNb24sIDI3IE5vdiAyMDIzIDEwOjU1
OjAxIC0wNTAwLCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOg0KPj4gPiBTaGlnZXJ1IFlvc2hpZGEg
d3JvdGU6DQo+PiA+PiBJbiBpcGdyZV94bWl0KCksIHNrYl9wdWxsKCkgbWF5IGZhaWwgZXZlbiBp
ZiBwc2tiX2luZXRfbWF5X3B1bGwoKSByZXR1cm5zDQo+PiA+PiB0cnVlLiBGb3IgZXhhbXBsZSwg
YXBwbGljYXRpb25zIGNhbiBjcmVhdGUgYSBtYWxmb3JtZWQgcGFja2V0IHRoYXQgY2F1c2VzDQo+
PiA+PiB0aGlzIHByb2JsZW0gd2l0aCBQRl9QQUNLRVQuDQo+PiA+DQo+PiA+IEl0IG1heSBmYWls
IGJlY2F1c2UgYmVjYXVzZSBwc2tiX2luZXRfbWF5X3B1bGwgZG9lcyBub3QgYWNjb3VudCBmb3IN
Cj4+ID4gdHVubmVsLT5obGVuLg0KPj4gPg0KPj4gPiBJcyB0aGF0IHdoYXQgeW91IGFyZSByZWZl
cnJpbmcgdG8gd2l0aCBtYWxmb3JtZWQgcGFja2V0PyBDYW4geW91DQo+PiA+IGVsb2JvcmF0ZSBh
IGJpdCBvbiBpbiB3aGljaCB3YXkgdGhlIHBhY2tldCBoYXMgdG8gYmUgbWFsZm9ybWVkIHRvDQo+
PiA+IHJlYWNoIHRoaXM/DQo+Pg0KPj4gVGhhbmsgeW91IHZlcnkgbXVjaCBmb3IgeW91ciBwcm9t
cHQgZmVlZGJhY2suDQo+Pg0KPj4gQWN0dWFsbHksIEkgZm91bmQgdGhpcyBwcm9ibGVtIGJ5IHJ1
bm5pbmcgc3l6a2FsbGVyLiBTeXprYWxsZXINCj4+IHJlcG9ydGVkIHRoZSBmb2xsb3dpbmcgdW5p
bml0LXZhbHVlIGlzc3VlIChJIHRoaW5rIHRoZSByb290IGNhdXNlIG9mDQo+PiB0aGlzIGlzc3Vl
IGlzIHRoZSBzYW1lIGFzIHRoZSBvbmUgRXJpYyBtZW50aW9uZWQpOg0KPiANCj4gWWVzLCBJIGFs
c28gaGF2ZSBhIHNpbWlsYXIgc3l6Ym90IHJlcG9ydCAoYnV0IG5vIHJlcHJvIHlldCkgSSBhbQ0K
PiByZWxlYXNpbmcgaXQgcmlnaHQgbm93Lg0KPiANCj4+DQo+PiA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPj4gQlVHOiBLTVNBTjogdW5pbml0
LXZhbHVlIGluIF9fZ3JlX3htaXQgbmV0L2lwdjQvaXBfZ3JlLmM6NDY5IFtpbmxpbmVdDQo+PiBC
VUc6IEtNU0FOOiB1bmluaXQtdmFsdWUgaW4gaXBncmVfeG1pdCsweGRmNC8weGU3MCBuZXQvaXB2
NC9pcF9ncmUuYzo2NjINCj4+ICBfX2dyZV94bWl0IG5ldC9pcHY0L2lwX2dyZS5jOjQ2OSBbaW5s
aW5lXQ0KPj4NCj4gDQo+IA0KPiANCj4+IFRoZSBzaW1wbGlmaWVkIHZlcnNpb24gb2YgdGhlIHJl
cHJvIGlzIHNob3duIGJlbG93Og0KPj4NCj4+ICNpbmNsdWRlIDxsaW51eC9pZl9ldGhlci5oPg0K
Pj4gI2luY2x1ZGUgPHN5cy9pb2N0bC5oPg0KPj4gI2luY2x1ZGUgPG5ldGluZXQvZXRoZXIuaD4N
Cj4+ICNpbmNsdWRlIDxuZXQvaWYuaD4NCj4+ICNpbmNsdWRlIDxzeXMvc29ja2V0Lmg+DQo+PiAj
aW5jbHVkZSA8bmV0aW5ldC9pbi5oPg0KPj4gI2luY2x1ZGUgPHN0cmluZy5oPg0KPj4gI2luY2x1
ZGUgPHVuaXN0ZC5oPg0KPj4gI2luY2x1ZGUgPHN0ZGlvLmg+DQo+PiAjaW5jbHVkZSA8c3RkbGli
Lmg+DQo+PiAjaW5jbHVkZSA8bGludXgvaWZfcGFja2V0Lmg+DQo+Pg0KPj4gaW50IG1haW4odm9p
ZCkNCj4+IHsNCj4+ICAgICAgICAgaW50IHMsIHMxLCBzMiwgZGF0YSA9IDA7DQo+PiAgICAgICAg
IHN0cnVjdCBpZnJlcSBpZnI7DQo+PiAgICAgICAgIHN0cnVjdCBzb2NrYWRkcl9sbCBhZGRyID0g
eyAwIH07DQo+PiAgICAgICAgIHVuc2lnbmVkIGNoYXIgbWFjX2FkZHJbXSA9IHsweDEsIDB4Miwg
MHgzLCAweDQsIDB4NSwgMHg2fTsNCj4+DQo+PiAgICAgICAgIHMgPSBzb2NrZXQoQUZfUEFDS0VU
LCBTT0NLX0RHUkFNLCAweDMwMCk7DQo+PiAgICAgICAgIHMxID0gc29ja2V0KEFGX1BBQ0tFVCwg
U09DS19SQVcsIDB4MzAwKTsNCj4+ICAgICAgICAgczIgPSBzb2NrZXQoQUZfTkVUTElOSywgU09D
S19SQVcsIDApOw0KPj4NCj4+ICAgICAgICAgc3RyY3B5KGlmci5pZnJfbmFtZSwgImdyZTAiKTsN
Cj4+ICAgICAgICAgaW9jdGwoczIsIFNJT0NHSUZJTkRFWCwgJmlmcik7DQo+Pg0KPj4gICAgICAg
ICBhZGRyLnNsbF9mYW1pbHkgPSBBRl9QQUNLRVQ7DQo+PiAgICAgICAgIGFkZHIuc2xsX2lmaW5k
ZXggPSBpZnIuaWZyX2lmaW5kZXg7DQo+PiAgICAgICAgIGFkZHIuc2xsX3Byb3RvY29sID0gaHRv
bnMoMCk7DQo+PiAgICAgICAgIGFkZHIuc2xsX2hhdHlwZSA9IEFSUEhSRF9FVEhFUjsNCj4+ICAg
ICAgICAgYWRkci5zbGxfcGt0dHlwZSA9IFBBQ0tFVF9IT1NUOw0KPj4gICAgICAgICBhZGRyLnNs
bF9oYWxlbiA9IEVUSF9BTEVOOw0KPj4gICAgICAgICBtZW1jcHkoYWRkci5zbGxfYWRkciwgbWFj
X2FkZHIsIEVUSF9BTEVOKTsNCj4+DQo+PiAgICAgICAgIHNlbmR0byhzMSwgJmRhdGEsIDEsIDAs
IChzdHJ1Y3Qgc29ja2FkZHIgKikmYWRkciwgc2l6ZW9mKGFkZHIpKTsNCj4+DQo+PiAgICAgICAg
IHJldHVybiAwOw0KPj4gfQ0KPj4NCj4+IFRoZSByZXBybyBzZW5kcyBhIDEtYnl0ZSBwYWNrZXQg
dGhhdCBkb2Vzbid0IGhhdmUgdGhlIGNvcnJlY3QgSVANCj4+IGhlYWRlci4gSSBtZWFudCB0aGlz
IGFzICJtYWxmb3JtZWQgcGFjaGV0IiwgYnV0IHRoYXQgbWlnaHQgYmUgYSBiaXQNCj4+IGNvbmZ1
c2luZywgc29ycnkuDQo+Pg0KPj4gSSB0aGluayB0aGUgY2F1c2Ugb2YgdGhlIHVuaW5pdC12YWx1
ZSBhY2Nlc3MgaXMgdGhhdCBpcGdyZV94bWl0KCkNCj4+IHJlYWxsb2NhdGVzIHRoZSBza2Igd2l0
aCBza2JfY293X2hlYWQoKSBhbmQgY29waWVzIG9ubHkgdGhlIDEtYnl0ZQ0KPj4gZGF0YSwgc28g
YW55IElQIGhlYWRlciBhY2Nlc3MgdGhyb3VnaCBgdG5sX3BhcmFtc2AgY2FuIGNhdXNlIHRoZQ0K
Pj4gcHJvYmxlbS4NCj4+DQo+PiBBdCBmaXJzdCBJIHRyaWVkIHRvIG1vZGlmeSBwc2tiX2luZXRf
bWF5X3B1bGwoKSB0byBkZXRlY3QgdGhpcyB0eXBlIG9mDQo+PiBwYWNrZXQsIGJ1dCBJIGVuZGVk
IHVwIGRvaW5nIHRoaXMgcGF0Y2guDQo+IA0KPiBFdmVuIGFmdGVyIHlvdXIgcGF0Y2gsIF9fc2ti
X3B1bGwoKSBjb3VsZCBjYWxsIEJVRygpIGFuZCBjcmFzaC4NCj4gDQo+IEkgd291bGQgc3VnZ2Vz
dCB1c2luZyB0aGlzIGZpeCBpbnN0ZWFkLg0KDQpUaGFuayB5b3UgZm9yIHlvdXIgY29tbWVudC4N
Cg0KWW91ciBwYXRjaCBlbnN1cmVzIHRoYXQgc2tiX3B1bGwoKSBjYW4gcHVsbCB0aGUgcmVxdWly
ZWQgc2l6ZSwgc28gaXQNCmxvb2tzIGdvb2QgdG8gbWUuIEFsc28sIEkgaGF2ZSB0ZXN0ZWQgeW91
ciBzdWdnZXN0ZWQgcGF0Y2ggd2l0aCB0aGUNCnJlcHJvIGFuZCBjb25maXJtZWQgdGhhdCBpdCBm
aXhlcyB0aGUgaXNzdWUuDQoNClRoYW5rcywNClNoaWdlcnUNCg0KPiANCj4gZGlmZiAtLWdpdCBh
L25ldC9pcHY0L2lwX2dyZS5jIGIvbmV0L2lwdjQvaXBfZ3JlLmMNCj4gaW5kZXggMjJhMjZkMWQy
OWEwOWQyMzRmMThjZTNiMGYzMjllNTA0N2MwYzA0Ni4uNTE2OWMzYzcyY2ZmZTQ5Y2VmNjEzZTY5
ODg5ZDEzOWRiODY3ZmY3NA0KPiAxMDA2NDQNCj4gLS0tIGEvbmV0L2lwdjQvaXBfZ3JlLmMNCj4g
KysrIGIvbmV0L2lwdjQvaXBfZ3JlLmMNCj4gQEAgLTYzNSwxNSArNjM1LDE4IEBAIHN0YXRpYyBu
ZXRkZXZfdHhfdCBpcGdyZV94bWl0KHN0cnVjdCBza19idWZmICpza2IsDQo+ICAgICAgICAgfQ0K
PiANCj4gICAgICAgICBpZiAoZGV2LT5oZWFkZXJfb3BzKSB7DQo+ICsgICAgICAgICAgICAgICBp
bnQgcHVsbF9sZW4gPSB0dW5uZWwtPmhsZW4gKyBzaXplb2Yoc3RydWN0IGlwaGRyKTsNCj4gKw0K
PiAgICAgICAgICAgICAgICAgaWYgKHNrYl9jb3dfaGVhZChza2IsIDApKQ0KPiAgICAgICAgICAg
ICAgICAgICAgICAgICBnb3RvIGZyZWVfc2tiOw0KPiANCj4gICAgICAgICAgICAgICAgIHRubF9w
YXJhbXMgPSAoY29uc3Qgc3RydWN0IGlwaGRyICopc2tiLT5kYXRhOw0KPiANCj4gLSAgICAgICAg
ICAgICAgIC8qIFB1bGwgc2tiIHNpbmNlIGlwX3R1bm5lbF94bWl0KCkgbmVlZHMgc2tiLT5kYXRh
IHBvaW50aW5nDQo+IC0gICAgICAgICAgICAgICAgKiB0byBncmUgaGVhZGVyLg0KPiAtICAgICAg
ICAgICAgICAgICovDQo+IC0gICAgICAgICAgICAgICBza2JfcHVsbChza2IsIHR1bm5lbC0+aGxl
biArIHNpemVvZihzdHJ1Y3QgaXBoZHIpKTsNCj4gKyAgICAgICAgICAgICAgIGlmICghcHNrYl9u
ZXR3b3JrX21heV9wdWxsKHNrYiwgcHVsbF9sZW4pKQ0KPiArICAgICAgICAgICAgICAgICAgICAg
ICBnb3RvIGZyZWVfc2tiOw0KPiArDQo+ICsgICAgICAgICAgICAgICAvKiBpcF90dW5uZWxfeG1p
dCgpIG5lZWRzIHNrYi0+ZGF0YSBwb2ludGluZyB0byBncmUgaGVhZGVyLiAqLw0KPiArICAgICAg
ICAgICAgICAgc2tiX3B1bGwoc2tiLCBwdWxsX2xlbik7DQo+ICAgICAgICAgICAgICAgICBza2Jf
cmVzZXRfbWFjX2hlYWRlcihza2IpOw0KPiANCj4gICAgICAgICAgICAgICAgIGlmIChza2ItPmlw
X3N1bW1lZCA9PSBDSEVDS1NVTV9QQVJUSUFMICYmDQo+IA0K

