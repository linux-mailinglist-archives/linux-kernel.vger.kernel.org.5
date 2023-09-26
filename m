Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 253B07AF860
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 05:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235719AbjI0DAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 23:00:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjI0C6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 22:58:32 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D8210E9
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 16:58:10 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qlHvq-0007JE-0r;
        Tue, 26 Sep 2023 19:57:34 -0400
Message-ID: <a3ed000de83d9958b6bd921cbc22f9c6363efa0b.camel@surriel.com>
Subject: Re: [PATCH 2/3] hugetlbfs: close race between MADV_DONTNEED and
 page fault
From:   Rik van Riel <riel@surriel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, muchun.song@linux.dev, mike.kravetz@oracle.com,
        leit@meta.com, willy@infradead.org
Date:   Tue, 26 Sep 2023 19:57:34 -0400
In-Reply-To: <20230926141530.26bc8550f2f2411945b566f1@linux-foundation.org>
References: <20230926031245.795759-1-riel@surriel.com>
         <20230926031245.795759-3-riel@surriel.com>
         <20230926141530.26bc8550f2f2411945b566f1@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
Sender: riel@surriel.com
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gVHVlLCAyMDIzLTA5LTI2IGF0IDE0OjE1IC0wNzAwLCBBbmRyZXcgTW9ydG9uIHdyb3RlOgo+
IE9uIE1vbiwgMjUgU2VwIDIwMjMgMjM6MTA6NTEgLTA0MDAgcmllbEBzdXJyaWVsLmNvbcKgd3Jv
dGU6Cj4gCj4gPiBGcm9tOiBSaWsgdmFuIFJpZWwgPHJpZWxAc3VycmllbC5jb20+Cj4gPiAKPiA+
IE1hbGxvYyBsaWJyYXJpZXMsIGxpa2UgamVtYWxsb2MgYW5kIHRjYWxsb2MsIHRha2UgZGVjaXNp
b25zIG9uIHdoZW4KPiA+IHRvIGNhbGwgbWFkdmlzZSBpbmRlcGVuZGVudGx5IGZyb20gdGhlIGNv
ZGUgaW4gdGhlIG1haW4KPiA+IGFwcGxpY2F0aW9uLgo+ID4gCj4gPiBUaGlzIHNvbWV0aW1lcyBy
ZXN1bHRzIGluIHRoZSBhcHBsaWNhdGlvbiBwYWdlIGZhdWx0aW5nIG9uIGFuCj4gPiBhZGRyZXNz
LAo+ID4gcmlnaHQgYWZ0ZXIgdGhlIG1hbGxvYyBsaWJyYXJ5IGhhcyBzaG90IGRvd24gdGhlIGJh
Y2tpbmcgbWVtb3J5Cj4gPiB3aXRoCj4gPiBNQURWX0RPTlRORUVELgo+ID4gCj4gPiBVc3VhbGx5
IHRoaXMgaXMgaGFybWxlc3MsIGJlY2F1c2Ugd2UgYWx3YXlzIGhhdmUgc29tZSA0a0IgcGFnZXMK
PiA+IHNpdHRpbmcgYXJvdW5kIHRvIHNhdGlzZnkgYSBwYWdlIGZhdWx0LiBIb3dldmVyLCB3aXRo
IGh1Z2V0bGJmcwo+ID4gc3lzdGVtcyBvZnRlbiBhbGxvY2F0ZSBvbmx5IHRoZSBleGFjdCBudW1i
ZXIgb2YgaHVnZSBwYWdlcyB0aGF0Cj4gPiB0aGUgYXBwbGljYXRpb24gd2FudHMuCj4gPiAKPiA+
IER1ZSB0byBUTEIgYmF0Y2hpbmcsIGh1Z2V0bGJmcyBNQURWX0RPTlRORUVEIHdpbGwgZnJlZSBw
YWdlcwo+ID4gb3V0c2lkZSBvZgo+ID4gYW55IGxvY2sgdGFrZW4gb24gdGhlIHBhZ2UgZmF1bHQg
cGF0aCwgd2hpY2ggY2FuIG9wZW4gdXAgdGhlCj4gPiBmb2xsb3dpbmcKPiA+IHJhY2UgY29uZGl0
aW9uOgo+ID4gCj4gPiDCoMKgwqDCoMKgwqAgQ1BVIDHCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgQ1BVIDIKPiA+IAo+ID4gwqDCoMKgwqDCoMKg
IE1BRFZfRE9OVE5FRUQKPiA+IMKgwqDCoMKgwqDCoCB1bm1hcCBwYWdlCj4gPiDCoMKgwqDCoMKg
wqAgc2hvb3QgZG93biBUTEIgZW50cnkKPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcGFnZSBmYXVs
dAo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBmYWlsIHRvIGFsbG9jYXRlIGEgaHVnZSBwYWdlCj4g
PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIGtpbGxlZCB3aXRoIFNJR0JVUwo+ID4gwqDCoMKgwqDCoMKg
IGZyZWUgcGFnZQo+ID4gCj4gPiBGaXggdGhhdCByYWNlIGJ5IHB1bGxpbmcgdGhlIGxvY2tpbmcg
ZnJvbQo+ID4gX191bm1hcF9odWdlcGFnZV9maW5hbF9yYW5nZQo+ID4gaW50byBoZWxwZXIgZnVu
Y3Rpb25zIGNhbGxlZCBmcm9tIHphcF9wYWdlX3JhbmdlX3NpbmdsZS4gVGhpcwo+ID4gZW5zdXJl
cwo+ID4gcGFnZSBmYXVsdHMgc3RheSBsb2NrZWQgb3V0IG9mIHRoZSBNQURWX0RPTlRORUVEIFZN
QSB1bnRpbCB0aGUKPiA+IGh1Z2UgcGFnZXMgaGF2ZSBhY3R1YWxseSBiZWVuIGZyZWVkLgo+ID4g
Cj4gCj4gV2FzIGEgLXN0YWJsZSBiYWNrcG9ydCBjb25zaWRlcmVkPwo+IApUaGF0J3MgYSBnb29k
IGlkZWEuIEknbGwgaGF2ZSB0byBzZWUgaG93IGZhciBiYWNrIAp0aGUgaHVnZXRsYl92bWFfKl9s
b2NrIHN0dWZmIGV4aXN0cy4KCldlIHByb2JhYmx5IGRvbid0IHdhbnQgdG8gYmFja3BvcnQgYWxs
IHRoZSByZXF1aXJlZAppbmZyYXN0cnVjdHVyZSBldmVyeXdoZXJlLgoKLS0gCkFsbCBSaWdodHMg
UmV2ZXJzZWQuCg==

