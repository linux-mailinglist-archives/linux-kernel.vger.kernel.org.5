Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A7978530D
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 10:50:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234924AbjHWIua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 04:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235224AbjHWIs3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 04:48:29 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A3069CD2
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 01:48:18 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 16:47:52
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 16:47:52 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu/sdma: Clean up errors in cik_sdma.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <537f6117.61f.18a21942a78.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwD3lD+4x+VkIVqQAA--.476W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0ASwABsC
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCkVSUk9SOiB0
cmFpbGluZyBzdGF0ZW1lbnRzIHNob3VsZCBiZSBvbiBuZXh0IGxpbmUKClNpZ25lZC1vZmYtYnk6
IFh1ZUJpbmcgQ2hlbiA8Y2hlbnh1ZWJpbmdAamFyaS5jbj4KLS0tCiBkcml2ZXJzL2dwdS9kcm0v
YW1kL2FtZGdwdS9jaWtfc2RtYS5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2Ft
ZC9hbWRncHUvY2lrX3NkbWEuYyBiL2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1h
LmMKaW5kZXggNTI1OThmYmM5YjM5Li4xYzcxY2RhODNiYTUgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMv
Z3B1L2RybS9hbWQvYW1kZ3B1L2Npa19zZG1hLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9h
bWRncHUvY2lrX3NkbWEuYwpAQCAtMTI4LDcgKzEyOCw4IEBAIHN0YXRpYyBpbnQgY2lrX3NkbWFf
aW5pdF9taWNyb2NvZGUoc3RydWN0IGFtZGdwdV9kZXZpY2UgKmFkZXYpCiAJY2FzZSBDSElQX01V
TExJTlM6CiAJCWNoaXBfbmFtZSA9ICJtdWxsaW5zIjsKIAkJYnJlYWs7Ci0JZGVmYXVsdDogQlVH
KCk7CisJZGVmYXVsdDoKKwkJQlVHKCk7CiAJfQogCiAJZm9yIChpID0gMDsgaSA8IGFkZXYtPnNk
bWEubnVtX2luc3RhbmNlczsgaSsrKSB7CkBAIC0xMzc1LDggKzEzNzYsNyBAQCBzdGF0aWMgdm9p
ZCBjaWtfc2RtYV9zZXRfdm1fcHRlX2Z1bmNzKHN0cnVjdCBhbWRncHVfZGV2aWNlICphZGV2KQog
CWFkZXYtPnZtX21hbmFnZXIudm1fcHRlX251bV9zY2hlZHMgPSBhZGV2LT5zZG1hLm51bV9pbnN0
YW5jZXM7CiB9CiAKLWNvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBjaWtfc2Rt
YV9pcF9ibG9jayA9Ci17Citjb25zdCBzdHJ1Y3QgYW1kZ3B1X2lwX2Jsb2NrX3ZlcnNpb24gY2lr
X3NkbWFfaXBfYmxvY2sgPSB7CiAJLnR5cGUgPSBBTURfSVBfQkxPQ0tfVFlQRV9TRE1BLAogCS5t
YWpvciA9IDIsCiAJLm1pbm9yID0gMCwKLS0gCjIuMTcuMQo=
