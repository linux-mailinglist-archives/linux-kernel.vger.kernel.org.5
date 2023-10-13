Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2197C7ED7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjJMHrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229863AbjJMHrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:47:33 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 17E89B8
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:47:30 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 15:45:46
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 15:45:46 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     mark@fasheh.com, jlbec@evilplan.org
Cc:     ocfs2-devel@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] ocfs2: Clean up errors in dlmunlock.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f2d4ee9.96a.18b27ffa1db.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD6q9Shld9_BAA--.636W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQADB2UnvzMAKwAFsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=3.4 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2VzIHJlcXVpcmVkIGFyb3VuZCB0aGF0ICc8JyAoY3R4OlZ4VikKRVJST1I6IHNwYWNlcyBy
ZXF1aXJlZCBhcm91bmQgdGhhdCAnPScgKGN0eDpWeFYpCkVSUk9SOiBzcGFjZSByZXF1aXJlZCBi
ZWZvcmUgdGhhdCAnJicgKGN0eDpPeFYpCkVSUk9SOiBzcGFjZXMgcmVxdWlyZWQgYXJvdW5kIHRo
YXQgJz09JyAoY3R4OlZ4VikKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnOicg
KGN0eDpWeEUpCgpTaWduZWQtb2ZmLWJ5OiBLYWlMb25nIFdhbmcgPHdhbmdrYWlsb25nQGphcmku
Y24+Ci0tLQogZnMvb2NmczIvZGxtL2RsbXVubG9jay5jIHwgOCArKysrLS0tLQogMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9v
Y2ZzMi9kbG0vZGxtdW5sb2NrLmMgYi9mcy9vY2ZzMi9kbG0vZGxtdW5sb2NrLmMKaW5kZXggNzMx
OGU0Nzk0ZWY5Li5hYzliMjliMmExMWYgMTAwNjQ0Ci0tLSBhL2ZzL29jZnMyL2RsbS9kbG11bmxv
Y2suYworKysgYi9mcy9vY2ZzMi9kbG0vZGxtdW5sb2NrLmMKQEAgLTE4NCw4ICsxODQsOCBAQCBz
dGF0aWMgZW51bSBkbG1fc3RhdHVzIGRsbXVubG9ja19jb21tb24oc3RydWN0IGRsbV9jdHh0ICpk
bG0sCiAJCQltbG9nKDAsICIlczolLipzOiBjbGVhcmluZyBhY3Rpb25zLCAlc1xuIiwKIAkJCSAg
ICAgZGxtLT5uYW1lLCByZXMtPmxvY2tuYW1lLmxlbiwKIAkJCSAgICAgcmVzLT5sb2NrbmFtZS5u
YW1lLAotCQkJICAgICBzdGF0dXM9PURMTV9SRUNPVkVSSU5HPyJyZWNvdmVyaW5nIjoKLQkJCSAg
ICAgKHN0YXR1cz09RExNX01JR1JBVElORz8ibWlncmF0aW5nIjoKKwkJCSAgICAgc3RhdHVzID09
IERMTV9SRUNPVkVSSU5HID8gInJlY292ZXJpbmciIDoKKwkJCSAgICAgKHN0YXR1cyA9PSBETE1f
TUlHUkFUSU5HID8gIm1pZ3JhdGluZyIgOgogCQkJCShzdGF0dXMgPT0gRExNX0ZPUldBUkQgPyAi
Zm9yd2FyZCIgOgogCQkJCQkJIm5vbG9ja21hbmFnZXIiKSkpOwogCQkJYWN0aW9ucyA9IDA7CkBA
IC00MzYsNyArNDM2LDcgQEAgaW50IGRsbV91bmxvY2tfbG9ja19oYW5kbGVyKHN0cnVjdCBvMm5l
dF9tc2cgKm1zZywgdTMyIGxlbiwgdm9pZCAqZGF0YSwKIAkJZ290byBub3RfZm91bmQ7CiAJfQog
Ci0JcXVldWU9JnJlcy0+Z3JhbnRlZDsKKwlxdWV1ZSA9ICZyZXMtPmdyYW50ZWQ7CiAJc3Bpbl9s
b2NrKCZyZXMtPnNwaW5sb2NrKTsKIAlpZiAocmVzLT5zdGF0ZSAmIERMTV9MT0NLX1JFU19SRUNP
VkVSSU5HKSB7CiAJCXNwaW5fdW5sb2NrKCZyZXMtPnNwaW5sb2NrKTsKQEAgLTQ1OSw3ICs0NTks
NyBAQCBpbnQgZGxtX3VubG9ja19sb2NrX2hhbmRsZXIoc3RydWN0IG8ybmV0X21zZyAqbXNnLCB1
MzIgbGVuLCB2b2lkICpkYXRhLAogCQlnb3RvIGxlYXZlOwogCX0KIAotCWZvciAoaT0wOyBpPDM7
IGkrKykgeworCWZvciAoaSA9IDA7IGkgPCAzOyBpKyspIHsKIAkJbGlzdF9mb3JfZWFjaF9lbnRy
eShpdGVyLCBxdWV1ZSwgbGlzdCkgewogCQkJaWYgKGl0ZXItPm1sLmNvb2tpZSA9PSB1bmxvY2st
PmNvb2tpZSAmJgogCQkJICAgIGl0ZXItPm1sLm5vZGUgPT0gdW5sb2NrLT5ub2RlX2lkeCkgewot
LSAKMi4xNy4xCg==
