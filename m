Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C89C8088ED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 14:12:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379433AbjLGNKD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 08:10:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232642AbjLGNKA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 08:10:00 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D075410CF
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 05:10:05 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id E3831480A23;
        Thu,  7 Dec 2023 08:10:04 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701954604;
 h=content-type : message-id : date : mime-version : to : from :
 subject : from; bh=YFT+XgcjZvZD8ZIeR8zZ5vBfavVKpWeN2+mPu/24h/E=;
 b=UO8xJfgj+tHXK+x+BhYsSqy5ZQAJG8hyeCesGdSaFQrTouVtkhQJaKb2L3rBnQSac0fqa
 X6x7p5NwOuHyM0IDg==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701954604;
        cv=none; b=nEd6Mn/XCRJ2ELiQhh96sTzOjSULX/VGWUk4lCNnlMZN/Ynh6B7FEK0qYTOOW8kwslNZdtxoaohzJYu5jGYdoN0hQBtuyGFMcU19Nvc0MrP/PtjIV7D4S/+gdx7kWQB9tKVnLS2x8wsV8BlOOzKeMsQ21KXuGQ0n0qDNPE+APsp11NH6pkrHCabAMc4DpG4FaTa/Fjx71klfrf4GoumEW7QbBwKTsuVUWsFQ20RqVU9Xncz91byturyaCs2oNAHvFHOAilEty3DT5H5YJUiz6ORYxSzAAtttiKf8Gf/VBysLMinsh0hXFSnQ9UTJ3W2LcY++fhaplvLZEs1pIgDm8A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1701954604; c=relaxed/simple;
        bh=+LZI/wgiz0o6nnIwfk/pQlkxu3sLHNBRYJuCTZBVXsQ=;
        h=DKIM-Signature:DKIM-Signature:Content-Type:Message-ID:Date:
         MIME-Version:User-Agent:Content-Language:To:From:Subject; b=iA3KPVD0QY8RvDzikzMJY0x1amdxHaDBD3iAdKJBpfnixpUncgySNfhi028O5D86jLy+EZpTcmQHxjZrzT6mpVsEh6g2VTwjUeWXFeppVCQlhNpNkFAh4KkFCxYn98bP3tN4X3DsGiD0em+epZod8x6Lxb11YUbgsAsBSKEq9UGEDHigBbf/2DempjP2fJBKczeE+V2R5LWO5XLzNviMObOwxHZBuSMI60wZZyFhOFXfwnHkuBkbjYfNGRbl8B4t+CDF88BUopz3oT358Dt6N5PL9WG6wHBOAlJ6HiD/4myTOCVs9Ac4iiJgWO078X4wOVhctGgrxmseKVZOwAdEVQ==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701954604;
 h=content-type : message-id : date : mime-version : to : from :
 subject : from; bh=YFT+XgcjZvZD8ZIeR8zZ5vBfavVKpWeN2+mPu/24h/E=;
 b=R1Ilqtmk5BYwTA0gr2VXcuNvLUx7qaWa0BItXdBtd7XMhEqBz4j0KKuu+xWMgb0Rd+Ogf
 h6CA8WL+T48/C1BrZs2ci4KQj6RZLn2QN33q6Ez/fgmYK4N3Ax6PV817mXIWiGTM67PzzYm
 HAVa8ThE9lLHTpkqdwFtOj/Xd9pCDFIhQHtVK/IryHpu0FvvQO2YdHuo4gSyFk0k0EsrrXU
 ndSz7iI3ru/P3hRHhS1ScVi5WDbtxMGsZyQ5PL8WHyTtKZYaf6DxK21AHucfskXXep/+ntf
 M1d0CkXz7WOmJtsjfRkkOpHoreTZ+kOdO4kGsFh6ur2RAggx47e/HgO4O1LQ==
Content-Type: multipart/mixed; boundary="------------6081krpCvr0LUwH3LLwoIfP5"
Message-ID: <6e6816dd-2ec5-4bca-9558-60cfde46ef8c@sapience.com>
Date:   Thu, 7 Dec 2023 08:10:04 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     snitzer@kernel.org, song@kernel.org, yukuai3@huawei.com,
        axboe@kernel.dk, mpatocka@redhat.com, heinzm@redhat.com,
        linux-kernel@vger.kernel.org
From:   Genes Lists <lists@sapience.com>
Subject: md raid6 oops in 6.6.4 stable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------6081krpCvr0LUwH3LLwoIfP5
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

I have not had chance to git bisect this but since it happened in stable 
I thought it was important to share sooner than later.

One possibly relevant commit between 6.6.3 and 6.6.4 could be:

   commit 2c975b0b8b11f1ffb1ed538609e2c89d8abf800e
   Author: Song Liu <song@kernel.org>
   Date:   Fri Nov 17 15:56:30 2023 -0800

     md: fix bi_status reporting in md_end_clone_io

log attached shows page_fault_oops.
Machine was up for 3 days before crash happened.

gene
--------------6081krpCvr0LUwH3LLwoIfP5
Content-Type: text/plain; charset=UTF-8; name="raid6-crash"
Content-Disposition: attachment; filename="raid6-crash"
Content-Transfer-Encoding: base64

RGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQlVHOiB1bmFibGUgdG8gaGFuZGxlIHBhZ2Ug
ZmF1bHQgZm9yIGFkZHJlc3M6IGZmZmY4ODgxMDE5MzEyZTgKRGVjIDA2IDE5OjIwOjU0IHM2
IGtlcm5lbDogI1BGOiBzdXBlcnZpc29yIHdyaXRlIGFjY2VzcyBpbiBrZXJuZWwgbW9kZQpE
ZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAjUEY6IGVycm9yX2NvZGUoMHgwMDAzKSAtIHBl
cm1pc3Npb25zIHZpb2xhdGlvbgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBQR0QgMzM2
ZTAxMDY3IFA0RCAzMzZlMDEwNjcgUFVEIDEwMTllZTA2MyBQTUQgMTAxOWYwMDYzIFBURSA4
MDAwMDAwMTAxOTMxMDIxCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IE9vcHM6IDAwMDMg
WyMxXSBQUkVFTVBUIFNNUCBQVEkKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQ1BVOiAz
IFBJRDogNzczIENvbW06IG1kMTI3X3JhaWQ2IE5vdCB0YWludGVkIDYuNi40LXN0YWJsZS0x
ICM0IDc4NGMxYzcxMDY0NmNmZmMxZThjYzU5NzhmOGY2Y2VjOTc0YWExNzkKRGVjIDA2IDE5
OjIwOjU0IHM2IGtlcm5lbDogSGFyZHdhcmUgbmFtZTogVG8gQmUgRmlsbGVkIEJ5IE8uRS5N
LiBUbyBCZSBGaWxsZWQgQnkgTy5FLk0uL1ozNzAgRXh0cmVtZTQsIEJJT1MgUDQuMjAgMTAv
MzEvMjAxOQpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBSSVA6IDAwMTA6dXBkYXRlX2lv
X3RpY2tzKzB4MmMvMHg2MApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBDb2RlOiAxZiAw
MCAwZiAxZiA0NCAwMCAwMCA0OCA4YiA0ZiAyOCA0OCAzOSBmMSA3OCAxNyA4MCA3ZiAzMSAw
MCA3NCAzYiA0OCA4YiA0NyAxMCA0OCA4YiA3OCA0MCA0OCA4YiA0ZiAyOCA0OCAzOSBmMSA3
OSBlOSA0OCA4OSBjOCA8ZjA+IDQ4IDBmIGIxIDc3IDI4IDc1IGRlIDQ4IDg5IGYwIDQ4IDI5
IGM4IDg0IGQyIGI5IDAxIDAwID4KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogUlNQOiAw
MDE4OmZmZmZjOTAwMDBjMGJiNzggRUZMQUdTOiAwMDAxMDI5NgpEZWMgMDYgMTk6MjA6NTQg
czYga2VybmVsOiBSQVg6IGNjY2NjY2NjY2NjY2NjY2MgUkJYOiBmZmZmODg4MTAxOTMxMmMw
IFJDWDogY2NjY2NjY2NjY2NjY2NjYwpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBSRFg6
IDAwMDAwMDAwMDAwMDAwMDEgUlNJOiAwMDAwMDAwMTEwZjI4ZjRlIFJESTogZmZmZjg4ODEw
MTkzMTJjMApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBSQlA6IDAwMDAwMDAwMDAwMDAw
MDEgUjA4OiBmZmZmODg4MTA0Y2MxNzYwIFIwOTogMDAwMDAwMDA4MDIwMDAxNgpEZWMgMDYg
MTk6MjA6NTQgczYga2VybmVsOiBSMTA6IGZmZmY4ODg1MWYwY2VkMDAgUjExOiBmZmZmODg4
OGJlZmZiMDAwIFIxMjogMDAwMDAwMDAwMDAwMDAwOApEZWMgMDYgMTk6MjA6NTQgczYga2Vy
bmVsOiBSMTM6IDAwMDAwMDAwMDAwMDAwMjggUjE0OiAwMDAwMDAwMDAwMDAwMDA4IFIxNTog
MDAwMDAwMDAwMDAwMDA0OApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiBGUzogIDAwMDAw
MDAwMDAwMDAwMDAoMDAwMCkgR1M6ZmZmZjg4ODg5ZWVjMDAwMCgwMDAwKSBrbmxHUzowMDAw
MDAwMDAwMDAwMDAwCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IENTOiAgMDAxMCBEUzog
MDAwMCBFUzogMDAwMCBDUjA6IDAwMDAwMDAwODAwNTAwMzMKRGVjIDA2IDE5OjIwOjU0IHM2
IGtlcm5lbDogQ1IyOiBmZmZmODg4MTAxOTMxMmU4IENSMzogMDAwMDAwMDMzNjAyMDAwMiBD
UjQ6IDAwMDAwMDAwMDAzNzA2ZTAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogRFIwOiAw
MDAwMDAwMDAwMDAwMDAwIERSMTogMDAwMDAwMDAwMDAwMDAwMCBEUjI6IDAwMDAwMDAwMDAw
MDAwMDAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogRFIzOiAwMDAwMDAwMDAwMDAwMDAw
IERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAKRGVjIDA2IDE5
OjIwOjU0IHM2IGtlcm5lbDogQ2FsbCBUcmFjZToKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5l
bDogIDxUQVNLPgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAgPyBfX2RpZSsweDIzLzB4
NzAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogID8gcGFnZV9mYXVsdF9vb3BzKzB4MTcx
LzB4NGUwCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ICA/IGV4Y19wYWdlX2ZhdWx0KzB4
MTc1LzB4MTgwCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ICA/IGFzbV9leGNfcGFnZV9m
YXVsdCsweDI2LzB4MzAKRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogID8gdXBkYXRlX2lv
X3RpY2tzKzB4MmMvMHg2MApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAgYmRldl9lbmRf
aW9fYWNjdCsweDYzLzB4MTYwCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ICBtZF9lbmRf
Y2xvbmVfaW8rMHg3NS8weGEwIFttZF9tb2QgYjZjYTE3ZWU0YWU2YzAzZTUxOGFkMzNiNzBk
ZGQ2NThiZGIwYzAzYV0KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogIGhhbmRsZV9zdHJp
cGVfY2xlYW5fZXZlbnQrMHgxZWUvMHg0MzAgW3JhaWQ0NTYgY2E5YTQ5NjYyYmY1NGE5ZWJl
ZjY1YTgwMTZiMDVlNmMzMDI0OGQ3N10KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogIGhh
bmRsZV9zdHJpcGUrMHg3YjYvMHgxYWMwIFtyYWlkNDU2IGNhOWE0OTY2MmJmNTRhOWViZWY2
NWE4MDE2YjA1ZTZjMzAyNDhkNzddCkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6ICBoYW5k
bGVfYWN0aXZlX3N0cmlwZXMuaXNyYS4wKzB4MzhkLzB4NTUwIFtyYWlkNDU2IGNhOWE0OTY2
MmJmNTRhOWViZWY2NWE4MDE2YjA1ZTZjMzAyNDhkNzddCkRlYyAwNiAxOToyMDo1NCBzNiBr
ZXJuZWw6ICByYWlkNWQrMHg0ODgvMHg3NTAgW3JhaWQ0NTYgY2E5YTQ5NjYyYmY1NGE5ZWJl
ZjY1YTgwMTZiMDVlNmMzMDI0OGQ3N10KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogID8g
bG9ja190aW1lcl9iYXNlKzB4NjEvMHg4MApEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAg
PyBwcmVwYXJlX3RvX3dhaXRfZXZlbnQrMHg2MC8weDE4MApEZWMgMDYgMTk6MjA6NTQgczYg
a2VybmVsOiAgPyBfX3BmeF9tZF90aHJlYWQrMHgxMC8weDEwIFttZF9tb2QgYjZjYTE3ZWU0
YWU2YzAzZTUxOGFkMzNiNzBkZGQ2NThiZGIwYzAzYV0KRGVjIDA2IDE5OjIwOjU0IHM2IGtl
cm5lbDogIG1kX3RocmVhZCsweGFiLzB4MTkwIFttZF9tb2QgYjZjYTE3ZWU0YWU2YzAzZTUx
OGFkMzNiNzBkZGQ2NThiZGIwYzAzYV0KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogID8g
X19wZnhfYXV0b3JlbW92ZV93YWtlX2Z1bmN0aW9uKzB4MTAvMHgxMApEZWMgMDYgMTk6MjA6
NTQgczYga2VybmVsOiAga3RocmVhZCsweGU1LzB4MTIwCkRlYyAwNiAxOToyMDo1NCBzNiBr
ZXJuZWw6ICA/IF9fcGZ4X2t0aHJlYWQrMHgxMC8weDEwCkRlYyAwNiAxOToyMDo1NCBzNiBr
ZXJuZWw6ICByZXRfZnJvbV9mb3JrKzB4MzEvMHg1MApEZWMgMDYgMTk6MjA6NTQgczYga2Vy
bmVsOiAgPyBfX3BmeF9rdGhyZWFkKzB4MTAvMHgxMApEZWMgMDYgMTk6MjA6NTQgczYga2Vy
bmVsOiAgcmV0X2Zyb21fZm9ya19hc20rMHgxYi8weDMwCkRlYyAwNiAxOToyMDo1NCBzNiBr
ZXJuZWw6ICA8L1RBU0s+CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IE1vZHVsZXMgbGlu
a2VkIGluOiBhbGdpZl9oYXNoIGFmX2FsZyBtcHRjcF9kaWFnIHhza19kaWFnIHRjcF9kaWFn
IHVkcF9kaWFnIHJhd19kaWFnIGluZXRfZGlhZyB1bml4X2RpYWcgYWZfcGFja2V0X2RpYWcg
bmV0bGlua19kaWFnIHJwY3NlY19nc3Nfa3JiNSBuZnN2NCBkbnNfcmVzb2x2ZXIgbmZzIGZz
Y2FjaGUgbmV0ZnMgbmZ0X2N0PgpEZWMgMDYgMTk6MjA6NTQgczYga2VybmVsOiAgc25kX2hk
YV9jb2RlYyBrdm0gc25kX2hkYV9jb3JlIGRybV9idWRkeSBzbmRfaHdkZXAgaVRDT193ZHQg
aTJjX2FsZ29fYml0IG1laV9weHAgaW50ZWxfcG1jX2J4dCBzbmRfcGNtIG1laV9oZGNwIGVl
MTAwNCBpcnFieXBhc3MgdHRtIGlUQ09fdmVuZG9yX3N1cHBvcnQgcmFwbCBkcm1fZGlzcGxh
eV9oZWxwZXIgbmxzX2lzbzg4NTlfMT4KRGVjIDA2IDE5OjIwOjU0IHM2IGtlcm5lbDogQ1Iy
OiBmZmZmODg4MTAxOTMxMmU4CkRlYyAwNiAxOToyMDo1NCBzNiBrZXJuZWw6IC0tLVsgZW5k
IHRyYWNlIDAwMDAwMDAwMDAwMDAwMDAgXS0tLQoK

--------------6081krpCvr0LUwH3LLwoIfP5--
