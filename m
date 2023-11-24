Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A6D27F6AC3
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 03:52:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjKXCwf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 21:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXCwd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 21:52:33 -0500
Received: from mta20.hihonor.com (mta20.hihonor.com [81.70.206.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB045D44
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 18:52:38 -0800 (PST)
Received: from w011.hihonor.com (unknown [10.68.20.122])
        by mta20.hihonor.com (SkyGuard) with ESMTPS id 4Sbzz25hhSzYpNfn;
        Fri, 24 Nov 2023 10:51:58 +0800 (CST)
Received: from a002.hihonor.com (10.68.31.193) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 24 Nov
 2023 10:52:34 +0800
Received: from a007.hihonor.com (10.68.22.31) by a002.hihonor.com
 (10.68.31.193) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Fri, 24 Nov
 2023 10:52:34 +0800
Received: from a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4]) by
 a007.hihonor.com ([fe80::ccdd:b4b:ae86:edd4%10]) with mapi id 15.02.1258.025;
 Fri, 24 Nov 2023 10:52:34 +0800
From:   gaoxu <gaoxu2@hihonor.com>
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        yipengxiang <yipengxiang@hihonor.com>,
        Michal Hocko <mhocko@suse.com>
Subject: =?gb2312?B?u9i4tDogW1BBVENIXSBtbSxvb21fcmVhcGVyOiBhdm9pZCBydW4gcXVldWVf?=
 =?gb2312?Q?oom=5Freaper_if_task_is_not_oom?=
Thread-Topic: [PATCH] mm,oom_reaper: avoid run queue_oom_reaper if task is not
 oom
Thread-Index: AdodQUgb0N3ZJU2TSUK/4IicgpocdQACR6uAAE2HqPA=
Date:   Fri, 24 Nov 2023 02:52:34 +0000
Message-ID: <cba9d589a666493b9f034c0a8e48f26c@hihonor.com>
References: <400d13bddb524ef6af37cb2220808c75@hihonor.com>
 <20231122134715.487677f38de74a6f8e0111cd@linux-foundation.org>
In-Reply-To: <20231122134715.487677f38de74a6f8e0111cd@linux-foundation.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.164.11.140]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gV2ViLCAyMiBOb3YgMjAyMyAyMTo0Nzo0NCArMDAwMCBBbmRyZXcgTW9ydG9uIHdyb3RlOg0K
PiBPbiBXZWQsIDIyIE5vdiAyMDIzIDEyOjQ2OjQ0ICswMDAwIGdhb3h1IDxnYW94dTJAaGlob25v
ci5jb20+IHdyb3RlOg0KDQo+PiBUaGUgZnVuY3Rpb24gcXVldWVfb29tX3JlYXBlciB0ZXN0cyBh
bmQgc2V0cyB0c2stPnNpZ25hbC0+b29tX21tLT5mbGFncy4NCj4+IEhvd2V2ZXIsIGl0IGlzIG5l
Y2Vzc2FyeSB0byBjaGVjayBpZiAndHNrJyBpcyBhbiBPT00gdmljdGltIGJlZm9yZSANCj4+IGV4
ZWN1dGluZyAncXVldWVfb29tX3JlYXBlcicgYmVjYXVzZSB0aGUgdmFyaWFibGUgbWF5IGJlIE5V
TEwuDQo+PiANCj4+IFdlIGVuY291bnRlcmVkIHN1Y2ggYW4gaXNzdWUsIGFuZCB0aGUgbG9nIGlz
IGFzIGZvbGxvd3M6DQo+PiBbMzcwMToxMV9zZWVdT3V0IG9mIG1lbW9yeTogS2lsbGVkIHByb2Nl
c3MgMzE1NCAoc3lzdGVtX3NlcnZlcikgDQo+PiB0b3RhbC12bToyMzY2MjA0NGtCLCBhbm9uLXJz
czowa0IsIGZpbGUtcnNzOjBrQiwgc2htZW0tcnNzOjBrQiwNCj4+IFVJRDoxMDAwIHBndGFibGVz
OjQwNTZrQiBvb21fc2NvcmVfYWRqOi05MDANCj4+IFszNzAxOjExX3NlZV1bUkIvRV1yYl9zcmVh
c29uX3N0cl9zZXQ6IHNyZWFzb25fc3RyIHNldCBudWxsX3BvaW50ZXINCj4+IFszNzAxOjExX3Nl
ZV1bUkIvRV1yYl9zcmVhc29uX3N0cl9zZXQ6IHNyZWFzb25fc3RyIHNldCB1bmtub3duX2FkZHIg
DQo+PiBbMzcwMToxMV9zZWVdVW5hYmxlIHRvIGhhbmRsZSBrZXJuZWwgTlVMTCBwb2ludGVyIGRl
cmVmZXJlbmNlIGF0IA0KPj4gdmlydHVhbCBhZGRyZXNzIDAwMDAwMDAwMDAwMDAzMjgNCg0KPiBX
ZWxsIHRoYXQgaXNuJ3QgZ29vZC4gIEhvdyBmcmVxdWVudGx5IGRvZXMgdGhpcyBoYXBwZW4gYW5k
IGNhbiB5b3Ugc3VnZ2VzdCB3aHkgc29tZSBxdWl0ZSBvbGQgY29kZSBpcyBzdWRkZW5seSBjYXVz
aW5nIHByb2JsZW1zPyANCj4gV2hhdCBpcyB5b3VyIHdvcmtsb2FkIGRvaW5nIHRoYXQgb3RoZXJz
JyBkbyBub3QgZG8/DQpUaGlzIGlzIGEgbG93IHByb2JhYmlsaXR5IGlzc3VlLiBXZSBjb25kdWN0
ZWQgbW9ua2V5IHRlc3RpbmcgZm9yIGEgbW9udGgsDQphbmQgdGhpcyBwcm9ibGVtIG9jY3VycmVk
IG9ubHkgb25jZS4NClRoZSBjYXVzZSBvZiB0aGUgT09NIGVycm9yIGlzIHRoZSBwcm9jZXNzIHN1
cmZhY2VmbGluZ2VyIGhhcyBlbmNvdW50ZXJlZCBkbWEtYnVmIG1lbW9yeSBsZWFrLg0KDQpJIGhh
dmUgbm90IGZvdW5kIHRoZSByb290IGNhdXNlIG9mIHRoaXMgcHJvYmxlbS4NClRoZSBwaHlzaWNh
bCBtZW1vcnkgb2YgdGhlIHByb2Nlc3Mga2lsbGVkIGJ5IE9PTSBoYXMgYmVlbiByZWxlYXNlZCwg
aW5kaWNhdGluZyB0aGF0IHRoZSBpc3N1ZSBtYXkgaGF2ZSBvY2N1cnJlZCBkdWUgdG8gYSBjb25j
dXJyZW5jeSBwcm9ibGVtDQpiZXR3ZWVuIHByb2Nlc3MgdGVybWluYXRpb24gYW5kIE9PTSBraWxs
Lg0Kb29tIGtpbGwgbG9no7oNCk91dCBvZiBtZW1vcnk6IEtpbGxlZCBwcm9jZXNzIDMxNTQgKHN5
c3RlbV9zZXJ2ZXIpIHRvdGFsLXZtOjIzNjYyMDQ0a0IsIGFub24tcnNzOjBrQiwgZmlsZS1yc3M6
MGtCLCBzaG1lbS1yc3M6MGtCLA0KVUlEOjEwMDAgcGd0YWJsZXM6NDA1NmtCIG9vbV9zY29yZV9h
ZGo6LTkwMA0KDQo+PiBbMzcwMToxMV9zZWVddXNlciBwZ3RhYmxlOiA0ayBwYWdlcywgMzktYml0
IFZBcywgcGdkcD0wMDAwMDAwMDgyMWRlMDAwIA0KPj4gWzM3MDE6MTFfc2VlXVswMDAwMDAwMDAw
MDAwMzI4XSBwZ2Q9MDAwMDAwMDAwMDAwMDAwMCwNCj4+IHA0ZD0wMDAwMDAwMDAwMDAwMDAwLHB1
ZD0wMDAwMDAwMDAwMDAwMDAwDQo+PiBbMzcwMToxMV9zZWVddHJhY2luZyBvZmYNCj4+IFszNzAx
OjExX3NlZV1JbnRlcm5hbCBlcnJvcjogT29wczogOTYwMDAwMDUgWyMxXSBQUkVFTVBUIFNNUCAN
Cj4+IFszNzAxOjExX3NlZV1DYWxsIHRyYWNlOg0KPj4gWzM3MDE6MTFfc2VlXSBxdWV1ZV9vb21f
cmVhcGVyKzB4MzAvMHgxNzAgWzM3MDE6MTFfc2VlXSANCj4+IF9fb29tX2tpbGxfcHJvY2Vzcysw
eDU5MC8weDg2MCBbMzcwMToxMV9zZWVdIA0KPj4gb29tX2tpbGxfcHJvY2VzcysweDE0MC8weDI3
NCBbMzcwMToxMV9zZWVdIG91dF9vZl9tZW1vcnkrMHgyZjQvMHg1NGMgDQo+PiBbMzcwMToxMV9z
ZWVdIF9fYWxsb2NfcGFnZXNfc2xvd3BhdGgrMHg1ZDgvMHhhYWMNCj4+IFszNzAxOjExX3NlZV0g
X19hbGxvY19wYWdlcysweDc3NC8weDgwMCBbMzcwMToxMV9zZWVdIA0KPj4gd3BfcGFnZV9jb3B5
KzB4YzQvMHgxMTZjIFszNzAxOjExX3NlZV0gZG9fd3BfcGFnZSsweDRiYy8weDZmYyANCj4+IFsz
NzAxOjExX3NlZV0gaGFuZGxlX3B0ZV9mYXVsdCsweDk4LzB4MmE4IFszNzAxOjExX3NlZV0gDQo+
PiBfX2hhbmRsZV9tbV9mYXVsdCsweDM2OC8weDcwMCBbMzcwMToxMV9zZWVdIA0KPj4gZG9faGFu
ZGxlX21tX2ZhdWx0KzB4MTYwLzB4MmNjIFszNzAxOjExX3NlZV0gZG9fcGFnZV9mYXVsdCsweDNl
MC8weDgxOCANCj4+IFszNzAxOjExX3NlZV0gZG9fbWVtX2Fib3J0KzB4NjgvMHgxN2MgWzM3MDE6
MTFfc2VlXSBlbDBfZGErMHgzYy8weGEwIA0KPj4gWzM3MDE6MTFfc2VlXSBlbDB0XzY0X3N5bmNf
aGFuZGxlcisweGM0LzB4ZWMgWzM3MDE6MTFfc2VlXSANCj4+IGVsMHRfNjRfc3luYysweDFiNC8w
eDFiOCBbMzcwMToxMV9zZWVddHJhY2luZyBvZmYNCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogR2Fv
IFh1IDxnYW94dTJAaGlob25vci5jb20+DQoNCj4gSSdsbCBxdWV1ZSB0aGlzIGZvciAtc3RhYmxl
IGJhY2twb3J0aW5nLCBhc3N1bWluZyByZXZpZXcgaXMgYWdyZWVhYmxlLiANCj4gQ2FuIHdlIHBs
ZWFzZSBpZGVudGlmeSBhIHN1aXRhYmxlIEZpeGVzOiB0YXJnZXQgdG8gdGVsbCAtc3RhYmxlIG1h
aW50YWluZXJzIHdoaWNoIGtlcm5lbHMgbmVlZCB0aGUgZml4PyAgSXQgbG9va3MgbGlrZSB0aGlz
IGdvZXMgYmFjayBhIGxvbmcgd2F5Lg0KVGhlIHByb2JsZW0gb2NjdXJyZWQgb24gTGludXggdmVy
c2lvbiA1LjE1Ljc4LCBUaGVyZSBpcyBubyBkaWZmZXJlbmNlIGJldHdlZW4gdGhlIGxhdGVzdCBr
ZXJuZWwgdmVyc2lvbiBjb2RlIGFuZCBMaW51eCB2ZXJzaW9uIDUuMTUuNzggaW4gdGhlDQpGdW5j
dGlvbiBfX29vbV9raWxsX3Byb2Nlc3MsIHNvIHRoaXMgcHJvYmxlbSBpcyBsaWtlbHkgY29tbW9u
IHRvIGJvdGggdmVyc2lvbnMuDQo=
