Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B952F7B105F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:30:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjI1Baq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1Bap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:30:45 -0400
X-Greylist: delayed 187 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 27 Sep 2023 18:30:37 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72478AC;
        Wed, 27 Sep 2023 18:30:37 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 09:25:57
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 09:25:57 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     satishkh@cisco.com, sebaddel@cisco.com, kartilak@cisco.com,
        jejb@linux.ibm.com, martin.petersen@oracle.co
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: fnic: Clean up errors in fnic_scsi.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7b9428c6.895.18ad9648170.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD8l1hRlCnS+AA--.588W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAEs8
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_PBL,RDNS_NONE,T_SPF_HELO_PERMERROR,T_SPF_PERMERROR,XPRIO
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvc2Nz
aS9mbmljL2ZuaWNfc2NzaS5jIHwgMTQgKysrKysrKy0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA3
IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9zY3Np
L2ZuaWMvZm5pY19zY3NpLmMgYi9kcml2ZXJzL3Njc2kvZm5pYy9mbmljX3Njc2kuYwppbmRleCA5
NzYxYjJjOWRiNDguLmZiNDE4NGY3OTRkYiAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL2ZuaWMv
Zm5pY19zY3NpLmMKKysrIGIvZHJpdmVycy9zY3NpL2ZuaWMvZm5pY19zY3NpLmMKQEAgLTEwMTks
MjIgKzEwMTksMjIgQEAgc3RhdGljIHZvaWQgZm5pY19mY3Bpb19pY21uZF9jbXBsX2hhbmRsZXIo
c3RydWN0IGZuaWMgKmZuaWMsCiAJaW9fZHVyYXRpb25fdGltZSA9IGppZmZpZXNfdG9fbXNlY3Mo
amlmZmllcykgLQogCQkJCQkJamlmZmllc190b19tc2VjcyhzdGFydF90aW1lKTsKIAotCWlmKGlv
X2R1cmF0aW9uX3RpbWUgPD0gMTApCisJaWYgKGlvX2R1cmF0aW9uX3RpbWUgPD0gMTApCiAJCWF0
b21pYzY0X2luYygmZm5pY19zdGF0cy0+aW9fc3RhdHMuaW9fYnR3XzBfdG9fMTBfbXNlYyk7Ci0J
ZWxzZSBpZihpb19kdXJhdGlvbl90aW1lIDw9IDEwMCkKKwllbHNlIGlmIChpb19kdXJhdGlvbl90
aW1lIDw9IDEwMCkKIAkJYXRvbWljNjRfaW5jKCZmbmljX3N0YXRzLT5pb19zdGF0cy5pb19idHdf
MTBfdG9fMTAwX21zZWMpOwotCWVsc2UgaWYoaW9fZHVyYXRpb25fdGltZSA8PSA1MDApCisJZWxz
ZSBpZiAoaW9fZHVyYXRpb25fdGltZSA8PSA1MDApCiAJCWF0b21pYzY0X2luYygmZm5pY19zdGF0
cy0+aW9fc3RhdHMuaW9fYnR3XzEwMF90b181MDBfbXNlYyk7Ci0JZWxzZSBpZihpb19kdXJhdGlv
bl90aW1lIDw9IDUwMDApCisJZWxzZSBpZiAoaW9fZHVyYXRpb25fdGltZSA8PSA1MDAwKQogCQlh
dG9taWM2NF9pbmMoJmZuaWNfc3RhdHMtPmlvX3N0YXRzLmlvX2J0d181MDBfdG9fNTAwMF9tc2Vj
KTsKLQllbHNlIGlmKGlvX2R1cmF0aW9uX3RpbWUgPD0gMTAwMDApCisJZWxzZSBpZiAoaW9fZHVy
YXRpb25fdGltZSA8PSAxMDAwMCkKIAkJYXRvbWljNjRfaW5jKCZmbmljX3N0YXRzLT5pb19zdGF0
cy5pb19idHdfNTAwMF90b18xMDAwMF9tc2VjKTsKLQllbHNlIGlmKGlvX2R1cmF0aW9uX3RpbWUg
PD0gMzAwMDApCisJZWxzZSBpZiAoaW9fZHVyYXRpb25fdGltZSA8PSAzMDAwMCkKIAkJYXRvbWlj
NjRfaW5jKCZmbmljX3N0YXRzLT5pb19zdGF0cy5pb19idHdfMTAwMDBfdG9fMzAwMDBfbXNlYyk7
CiAJZWxzZSB7CiAJCWF0b21pYzY0X2luYygmZm5pY19zdGF0cy0+aW9fc3RhdHMuaW9fZ3JlYXRl
cl90aGFuXzMwMDAwX21zZWMpOwogCi0JCWlmKGlvX2R1cmF0aW9uX3RpbWUgPiBhdG9taWM2NF9y
ZWFkKCZmbmljX3N0YXRzLT5pb19zdGF0cy5jdXJyZW50X21heF9pb190aW1lKSkKKwkJaWYgKGlv
X2R1cmF0aW9uX3RpbWUgPiBhdG9taWM2NF9yZWFkKCZmbmljX3N0YXRzLT5pb19zdGF0cy5jdXJy
ZW50X21heF9pb190aW1lKSkKIAkJCWF0b21pYzY0X3NldCgmZm5pY19zdGF0cy0+aW9fc3RhdHMu
Y3VycmVudF9tYXhfaW9fdGltZSwgaW9fZHVyYXRpb25fdGltZSk7CiAJfQogfQotLSAKMi4xNy4x
Cgo=
