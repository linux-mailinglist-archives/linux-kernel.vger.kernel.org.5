Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DAED7AFB4A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 08:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229916AbjI0Gof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 02:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjI0GoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 02:44:09 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A34BD180
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 23:44:03 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 14:42:45
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 14:42:45 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm/vmstat: Clean up errors in vmstat.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <676ec6fe.873.18ad5603269.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUDmzhNlcum9AA--.616W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8ANwABse
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcHJvaGliaXRlZCBhZnRlciB0aGF0ICctJyAoY3R4Old4VykKClNpZ25lZC1vZmYtYnk6
IEd1b0h1YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIG1tL3Ztc3RhdC5jIHwgNCAr
Ky0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL21tL3Ztc3RhdC5jIGIvbW0vdm1zdGF0LmMKaW5kZXggODhlYTk1ZDQyMjFjLi4w
YjBkN2RjODAxMjUgMTAwNjQ0Ci0tLSBhL21tL3Ztc3RhdC5jCisrKyBiL21tL3Ztc3RhdC5jCkBA
IC00OTYsNyArNDk2LDcgQEAgdm9pZCBfX2RlY196b25lX3N0YXRlKHN0cnVjdCB6b25lICp6b25l
LCBlbnVtIHpvbmVfc3RhdF9pdGVtIGl0ZW0pCiAKIAl2ID0gX190aGlzX2NwdV9kZWNfcmV0dXJu
KCpwKTsKIAl0ID0gX190aGlzX2NwdV9yZWFkKHBjcC0+c3RhdF90aHJlc2hvbGQpOwotCWlmICh1
bmxpa2VseSh2IDwgLSB0KSkgeworCWlmICh1bmxpa2VseSh2IDwgLXQpKSB7CiAJCXM4IG92ZXJz
dGVwID0gdCA+PiAxOwogCiAJCXpvbmVfcGFnZV9zdGF0ZV9hZGQodiAtIG92ZXJzdGVwLCB6b25l
LCBpdGVtKTsKQEAgLTUxOSw3ICs1MTksNyBAQCB2b2lkIF9fZGVjX25vZGVfc3RhdGUoc3RydWN0
IHBnbGlzdF9kYXRhICpwZ2RhdCwgZW51bSBub2RlX3N0YXRfaXRlbSBpdGVtKQogCiAJdiA9IF9f
dGhpc19jcHVfZGVjX3JldHVybigqcCk7CiAJdCA9IF9fdGhpc19jcHVfcmVhZChwY3AtPnN0YXRf
dGhyZXNob2xkKTsKLQlpZiAodW5saWtlbHkodiA8IC0gdCkpIHsKKwlpZiAodW5saWtlbHkodiA8
IC10KSkgewogCQlzOCBvdmVyc3RlcCA9IHQgPj4gMTsKIAogCQlub2RlX3BhZ2Vfc3RhdGVfYWRk
KHYgLSBvdmVyc3RlcCwgcGdkYXQsIGl0ZW0pOwotLSAKMi4xNy4xCg==
