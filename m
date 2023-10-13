Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9D57C7E54
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:05:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjJMHFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbjJMHFB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:05:01 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DDDD91;
        Fri, 13 Oct 2023 00:05:00 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 15:03:18
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 15:03:18 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ceph: Clean up errors in locks.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5bea2493.963.18b27d8bfb6.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwC3VUC26yhlit7BAA--.671W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQABB2UlHDMAlgAXsp
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
bmVlZCBjb25zaXN0ZW50IHNwYWNpbmcgYXJvdW5kICctJyAoY3R4Old4VikKClNpZ25lZC1vZmYt
Ynk6IEthaUxvbmcgV2FuZyA8d2FuZ2thaWxvbmdAamFyaS5jbj4KLS0tCiBmcy9jZXBoL2xvY2tz
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9mcy9jZXBoL2xvY2tzLmMgYi9mcy9jZXBoL2xvY2tzLmMKaW5kZXggY2I1
MWM3ZTljOGUyLi5mOTU2ZjYxM2RkOTMgMTAwNjQ0Ci0tLSBhL2ZzL2NlcGgvbG9ja3MuYworKysg
Yi9mcy9jZXBoL2xvY2tzLmMKQEAgLTE0MSw3ICsxNDEsNyBAQCBzdGF0aWMgaW50IGNlcGhfbG9j
a19tZXNzYWdlKHU4IGxvY2tfdHlwZSwgdTE2IG9wZXJhdGlvbiwgc3RydWN0IGlub2RlICppbm9k
ZSwKIAkJbGVuZ3RoID0gbGU2NF90b19jcHUocmVxLT5yX3JlcGx5X2luZm8uZmlsZWxvY2tfcmVw
bHktPnN0YXJ0KSArCiAJCQkJCQkgbGU2NF90b19jcHUocmVxLT5yX3JlcGx5X2luZm8uZmlsZWxv
Y2tfcmVwbHktPmxlbmd0aCk7CiAJCWlmIChsZW5ndGggPj0gMSkKLQkJCWZsLT5mbF9lbmQgPSBs
ZW5ndGggLTE7CisJCQlmbC0+ZmxfZW5kID0gbGVuZ3RoIC0gMTsKIAkJZWxzZQogCQkJZmwtPmZs
X2VuZCA9IDA7CiAKLS0gCjIuMTcuMQo=
