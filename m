Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D89FA7D7A35
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 03:35:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjJZBfQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 21:35:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJZBfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 21:35:15 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B910CCC
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 18:35:13 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96.2)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qvpGJ-00067y-2B;
        Wed, 25 Oct 2023 21:34:15 -0400
Message-ID: <3ac68b3be0f62cfcd930ee84b87fbdc8244fe45e.camel@surriel.com>
Subject: Re: [PATCH] kpageflags: respect folio head-page flag placement
From:   Rik van Riel <riel@surriel.com>
To:     Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, willy@infradead.org, david@redhat.com,
        vbabka@suse.cz, naoya.horiguchi@linux.dev,
        linux-kernel@vger.kernel.org,
        Gregory Price <gregory.price@memverge.com>
Date:   Wed, 25 Oct 2023 21:34:15 -0400
In-Reply-To: <20231025201237.948993-1-gregory.price@memverge.com>
References: <20231025201237.948993-1-gregory.price@memverge.com>
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

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDE2OjEyIC0wNDAwLCBHcmVnb3J5IFByaWNlIHdyb3RlOgo+
IAo+ICsrKyBiL2ZzL3Byb2MvcGFnZS5jCj4gQEAgLTE4OCwyMCArMTg4LDMxIEBAIHU2NCBzdGFi
bGVfcGFnZV9mbGFncyhzdHJ1Y3QgcGFnZSAqcGFnZSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHUgfD0gMSA8PCBLUEZfU0xBQjsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqB1IHw9
IGtwZl9jb3B5X2JpdChrLCBLUEZfRVJST1IswqDCoMKgwqDCoMKgwqDCoMKgUEdfZXJyb3IpOwo+
IC3CoMKgwqDCoMKgwqDCoHUgfD0ga3BmX2NvcHlfYml0KGssIEtQRl9ESVJUWSzCoMKgwqDCoMKg
wqDCoMKgwqBQR19kaXJ0eSk7Cj4gKwo+ICvCoMKgwqDCoMKgwqDCoGlmIChQYWdlRGlydHkocGFn
ZSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUgfD0gMSA8PCBLUEZfRElSVFk7
Cj4gKwo+IMKgwqDCoMKgwqDCoMKgwqB1IHw9IGtwZl9jb3B5X2JpdChrLCBLUEZfVVBUT0RBVEUs
wqDCoMKgwqDCoMKgUEdfdXB0b2RhdGUpOwo+IMKgwqDCoMKgwqDCoMKgwqB1IHw9IGtwZl9jb3B5
X2JpdChrLCBLUEZfV1JJVEVCQUNLLMKgwqDCoMKgwqBQR193cml0ZWJhY2spOwo+IMKgCj4gLcKg
wqDCoMKgwqDCoMKgdSB8PSBrcGZfY29weV9iaXQoaywgS1BGX0xSVSzCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgUEdfbHJ1KTsKPiAtwqDCoMKgwqDCoMKgwqB1IHw9IGtwZl9jb3B5X2JpdChrLCBLUEZf
UkVGRVJFTkNFRCzCoMKgwqDCoFBHX3JlZmVyZW5jZWQpOwo+IC3CoMKgwqDCoMKgwqDCoHUgfD0g
a3BmX2NvcHlfYml0KGssIEtQRl9BQ1RJVkUswqDCoMKgwqDCoMKgwqDCoFBHX2FjdGl2ZSk7Cj4g
K8KgwqDCoMKgwqDCoMKgaWYgKFBhZ2VMUlUocGFnZSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoHUgfD0gMSA8PCBLUEZfTFJVOwo+ICsKPiArwqDCoMKgwqDCoMKgwqBpZiAoUGFn
ZVJlZmVyZW5jZWQocGFnZSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUgfD0g
MSA8PCBLUEZfUkVGRVJFTkNFRDsKPiArCj4gK8KgwqDCoMKgwqDCoMKgaWYgKFBhZ2VBY3RpdmUo
cGFnZSkpCj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUgfD0gMSA8PCBLUEZfQUNU
SVZFOwo+ICsKPiDCoMKgwqDCoMKgwqDCoMKgdSB8PSBrcGZfY29weV9iaXQoaywgS1BGX1JFQ0xB
SU0swqDCoMKgwqDCoMKgwqBQR19yZWNsYWltKTsKPiDCoAo+IMKgwqDCoMKgwqDCoMKgwqBpZiAo
UGFnZVN3YXBDYWNoZShwYWdlKSkKPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHUg
fD0gMSA8PCBLUEZfU1dBUENBQ0hFOwo+IMKgwqDCoMKgwqDCoMKgwqB1IHw9IGtwZl9jb3B5X2Jp
dChrLCBLUEZfU1dBUEJBQ0tFRCzCoMKgwqDCoFBHX3N3YXBiYWNrZWQpOwo+IAoKQXJlbid0IFBH
X2xvY2tlZCwgUEdfcmVjbGFpbSwgYW5kIFBHX3N3YXBiYWNrZWQgYWxzbyBtYWludGFpbmVkIG9u
bHkgb24KdGhlIGZvbGlvL2hlYWQ/CgpXb3VsZCBpdCBtYWtlIHNlbnNlIHRvIGNvbnZlcnQgdGhv
c2Ugb3ZlciBhcyB3ZWxsPwoKLS0gCkFsbCBSaWdodHMgUmV2ZXJzZWQuCg==

