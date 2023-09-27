Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D41817AFD93
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjI0IFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:05:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjI0IFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:05:14 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CA78CDA;
        Wed, 27 Sep 2023 01:05:01 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:03:43
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:03:43 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: esp_scsi: Clean up errors in esp_scsi.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <234008e6.887.18ad5aa5094.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD_f4RNl7vW9AA--.582W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAesN
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
c3BhY2UgcmVxdWlyZWQgYWZ0ZXIgdGhhdCAnLCcgKGN0eDpWeFYpCkVSUk9SOiBuZWVkIGNvbnNp
c3RlbnQgc3BhY2luZyBhcm91bmQgJzw8JyAoY3R4Old4VikKClNpZ25lZC1vZmYtYnk6IEd1b0h1
YSBDaGVuZyA8Y2hlbmd1b2h1YUBqYXJpLmNuPgotLS0KIGRyaXZlcnMvc2NzaS9lc3Bfc2NzaS5j
IHwgNCArKy0tCiAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvc2NzaS9lc3Bfc2NzaS5jIGIvZHJpdmVycy9zY3NpL2Vz
cF9zY3NpLmMKaW5kZXggOTc4MTZhMGU2MjQwLi41NmNmYmQ5ZTBhODggMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvc2NzaS9lc3Bfc2NzaS5jCisrKyBiL2RyaXZlcnMvc2NzaS9lc3Bfc2NzaS5jCkBAIC0x
MTQsNyArMTE0LDcgQEAgZG8geyAgIGlmIChlc3BfZGVidWcgJiBFU1BfREVCVUdfQ09NTUFORCkJ
XAogfSB3aGlsZSAoMCkKIAogI2RlZmluZSBlc3BfcmVhZDgoUkVHKQkJZXNwLT5vcHMtPmVzcF9y
ZWFkOChlc3AsIFJFRykKLSNkZWZpbmUgZXNwX3dyaXRlOChWQUwsUkVHKQllc3AtPm9wcy0+ZXNw
X3dyaXRlOChlc3AsIFZBTCwgUkVHKQorI2RlZmluZSBlc3Bfd3JpdGU4KFZBTCwgUkVHKQllc3At
Pm9wcy0+ZXNwX3dyaXRlOChlc3AsIFZBTCwgUkVHKQogCiBzdGF0aWMgdm9pZCBlc3BfbG9nX2Zp
bGxfcmVncyhzdHJ1Y3QgZXNwICplc3AsCiAJCQkgICAgICBzdHJ1Y3QgZXNwX2V2ZW50X2VudCAq
cCkKQEAgLTU0Myw3ICs1NDMsNyBAQCBzdGF0aWMgdTMyIGVzcF9kbWFfbGVuZ3RoX2xpbWl0KHN0
cnVjdCBlc3AgKmVzcCwgdTMyIGRtYV9hZGRyLCB1MzIgZG1hX2xlbikKIAkJYmFzZSA9IGRtYV9h
ZGRyICYgKCgxVSA8PCAyNCkgLSAxVSk7CiAJCWVuZCA9IGJhc2UgKyBkbWFfbGVuOwogCQlpZiAo
ZW5kID4gKDFVIDw8IDI0KSkKLQkJCWVuZCA9ICgxVSA8PDI0KTsKKwkJCWVuZCA9ICgxVSA8PCAy
NCk7CiAJCWRtYV9sZW4gPSBlbmQgLSBiYXNlOwogCX0KIAlyZXR1cm4gZG1hX2xlbjsKLS0gCjIu
MTcuMQo=
