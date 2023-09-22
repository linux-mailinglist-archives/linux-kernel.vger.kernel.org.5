Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FC97AB92F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 20:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233029AbjIVSb4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 14:31:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjIVSbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 14:31:55 -0400
Received: from shelob.surriel.com (shelob.surriel.com [96.67.55.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD3D1AB
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 11:31:48 -0700 (PDT)
Received: from imladris.home.surriel.com ([10.0.13.28] helo=imladris.surriel.com)
        by shelob.surriel.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <riel@shelob.surriel.com>)
        id 1qjkvq-0002AW-34;
        Fri, 22 Sep 2023 14:31:14 -0400
Message-ID: <f79d6f2f4660c400ed309008033c773b2c542c9c.camel@surriel.com>
Subject: Re: [PATCH 1/2] hugetlbfs: extend hugetlb_vma_lock to private VMAs
From:   Rik van Riel <riel@surriel.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        linux-mm@kvack.org, akpm@linux-foundation.org,
        muchun.song@linux.dev, leit@meta.com
Date:   Fri, 22 Sep 2023 14:31:14 -0400
In-Reply-To: <20230922164408.GA224968@monkey>
References: <20230920021811.3095089-1-riel@surriel.com>
         <20230920021811.3095089-2-riel@surriel.com> <20230921224201.GB21193@monkey>
         <c3309a3486df6ad2901d4d5c23e7bc6f4b8a9a24.camel@surriel.com>
         <20230922164408.GA224968@monkey>
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

T24gRnJpLCAyMDIzLTA5LTIyIGF0IDA5OjQ0IC0wNzAwLCBNaWtlIEtyYXZldHogd3JvdGU6Cj4g
Cj4gZGlmZiAtLWdpdCBhL21tL2h1Z2V0bGIuYyBiL21tL2h1Z2V0bGIuYwo+IGluZGV4IGY5MDZj
NWZhNGQwOS4uOGYzZDU4OTVmZmZjIDEwMDY0NAo+IC0tLSBhL21tL2h1Z2V0bGIuYwo+ICsrKyBi
L21tL2h1Z2V0bGIuYwo+IEBAIC0zNzIsNiArMzcyLDExIEBAIHN0YXRpYyB2b2lkCj4gX19odWdl
dGxiX3ZtYV91bmxvY2tfd3JpdGVfZnJlZShzdHJ1Y3Qgdm1fYXJlYV9zdHJ1Y3QgKnZtYSkKPiDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBodWdldGxiX3ZtYV9sb2NrICp2
bWFfbG9jayA9IHZtYS0KPiA+dm1fcHJpdmF0ZV9kYXRhOwo+IMKgCj4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqBfX2h1Z2V0bGJfdm1hX3VubG9ja193cml0ZV9wdXQodm1hX2xvY2sp
Owo+ICvCoMKgwqDCoMKgwqDCoH0gZWxzZSBpZiAoX192bWFfcHJpdmF0ZV9sb2NrKHZtYSkpIHsK
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgc3RydWN0IHJlc3ZfbWFwICpyZXN2X21h
cCA9IHZtYV9yZXN2X21hcCh2bWEpOwo+ICsKPiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgLyogbm8gZnJlZSBmb3IgYW5vbiB2bWFzLCBidXQgc3RpbGwgbmVlZCB0byB1bmxvY2sgKi8K
PiArwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgdXBfd3JpdGUoJnJlc3ZfbWFwLT5yd19z
ZW1hKTsKPiDCoMKgwqDCoMKgwqDCoMKgfQo+IMKgfQo+IMKgCgpUaGF0IGRpZCB0aGUgdHJpY2su
IFRoZSBsaWJodWdldGxiZnMgdGVzdHMgcGFzcyBub3csIHdpdGgKbG9ja2RlcCBhbmQgS0FTQU4g
ZW5hYmxlZC4gQnJlbm8ncyBNQURWX0RPTlRORUVEIHRlc3QgY2FzZQpmb3IgaHVnZXRsYmZzIHN0
aWxsIHBhc3NlcywgdG9vLgoKCi0tIApBbGwgUmlnaHRzIFJldmVyc2VkLgo=

