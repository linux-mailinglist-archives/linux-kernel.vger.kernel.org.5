Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47AA2785302
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234855AbjHWIrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjHWIp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:45:56 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AE2B9E6C
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:42:50 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 16:42:19
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 16:42:19 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in amdgpu_umc.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <f810a4e.61c.18a218f145e.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D1rxuVksViQAA--.444W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0ARQAIsF
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
Zi1ieTogWHVlQmluZyBDaGVuIDxjaGVueHVlYmluZ0BqYXJpLmNuPgotLS0KIGRyaXZlcnMvZ3B1
L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuYyB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9h
bWRncHVfdW1jLmMKaW5kZXggZGIwZDk0Y2E0ZmZjLi5lNjJhOTg2YjA4NzUgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2FtZGdwdV91bWMuYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9hbWRncHVfdW1jLmMKQEAgLTEwMiw3ICsxMDIsNyBAQCBzdGF0aWMg
aW50IGFtZGdwdV91bWNfZG9fcGFnZV9yZXRpcmVtZW50KHN0cnVjdCBhbWRncHVfZGV2aWNlICph
ZGV2LAogCQkJLyogc3RpbGwgY2FsbCBxdWVyeV9yYXNfZXJyb3JfYWRkcmVzcyB0byBjbGVhciBl
cnJvciBzdGF0dXMKIAkJCSAqIGV2ZW4gTk9NRU0gZXJyb3IgaXMgZW5jb3VudGVyZWQKIAkJCSAq
LwotCQkJaWYoIWVycl9kYXRhLT5lcnJfYWRkcikKKwkJCWlmICghZXJyX2RhdGEtPmVycl9hZGRy
KQogCQkJCWRldl93YXJuKGFkZXYtPmRldiwgIkZhaWxlZCB0byBhbGxvYyBtZW1vcnkgZm9yICIK
IAkJCQkJCSJ1bWMgZXJyb3IgYWRkcmVzcyByZWNvcmQhXG4iKTsKIApAQCAtMTI2LDcgKzEyNiw3
IEBAIHN0YXRpYyBpbnQgYW1kZ3B1X3VtY19kb19wYWdlX3JldGlyZW1lbnQoc3RydWN0IGFtZGdw
dV9kZXZpY2UgKmFkZXYsCiAJCQkvKiBzdGlsbCBjYWxsIHF1ZXJ5X3Jhc19lcnJvcl9hZGRyZXNz
IHRvIGNsZWFyIGVycm9yIHN0YXR1cwogCQkJICogZXZlbiBOT01FTSBlcnJvciBpcyBlbmNvdW50
ZXJlZAogCQkJICovCi0JCQlpZighZXJyX2RhdGEtPmVycl9hZGRyKQorCQkJaWYgKCFlcnJfZGF0
YS0+ZXJyX2FkZHIpCiAJCQkJZGV2X3dhcm4oYWRldi0+ZGV2LCAiRmFpbGVkIHRvIGFsbG9jIG1l
bW9yeSBmb3IgIgogCQkJCQkJInVtYyBlcnJvciBhZGRyZXNzIHJlY29yZCFcbiIpOwogCi0tIAoy
LjE3LjEK
