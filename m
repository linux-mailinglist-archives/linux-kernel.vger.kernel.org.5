Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9FDE786861
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 09:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240340AbjHXHdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 03:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234781AbjHXHct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 03:32:49 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E92A010F3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 00:32:47 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 24 Aug 2023 15:32:20
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Thu, 24 Aug 2023 15:32:20 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com, airlied@gmail.com, daniel@ffwll.ch
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amd: Clean up errors in atom.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7789e44b.63f.18a26755f72.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwBn+D2FB+dkbTiSAA--.462W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQANCmTl1A4AOgAQs3
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQt
b2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jIHwgNiArKystLS0KIDEgZmlsZSBjaGFuZ2VkLCAzIGlu
c2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2FtZC9hbWRncHUvYXRvbS5jIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRvbS5jCmlu
ZGV4IDlmNjNkZGI4OWI3NS4uOTViMTk0YWJiOWU0IDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9hdG9tLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL2FtZC9hbWRncHUvYXRv
bS5jCkBAIC03Myw5ICs3Myw5IEBAIGludCBhbWRncHVfYXRvbV9kZWJ1ZzsKIHN0YXRpYyBpbnQg
YW1kZ3B1X2F0b21fZXhlY3V0ZV90YWJsZV9sb2NrZWQoc3RydWN0IGF0b21fY29udGV4dCAqY3R4
LCBpbnQgaW5kZXgsIHVpbnQzMl90ICpwYXJhbXMpOwogaW50IGFtZGdwdV9hdG9tX2V4ZWN1dGVf
dGFibGUoc3RydWN0IGF0b21fY29udGV4dCAqY3R4LCBpbnQgaW5kZXgsIHVpbnQzMl90ICpwYXJh
bXMpOwogCi1zdGF0aWMgdWludDMyX3QgYXRvbV9hcmdfbWFza1s4XSA9Ci0JeyAweEZGRkZGRkZG
LCAweEZGRkYsIDB4RkZGRjAwLCAweEZGRkYwMDAwLCAweEZGLCAweEZGMDAsIDB4RkYwMDAwLAot
CSAgMHhGRjAwMDAwMCB9Oworc3RhdGljIHVpbnQzMl90IGF0b21fYXJnX21hc2tbOF0gPSB7CisJ
MHhGRkZGRkZGRiwgMHhGRkZGLCAweEZGRkYwMCwgMHhGRkZGMDAwMCwgMHhGRiwgMHhGRjAwLCAw
eEZGMDAwMCwKKwkweEZGMDAwMDAwIH07CiBzdGF0aWMgaW50IGF0b21fYXJnX3NoaWZ0WzhdID0g
eyAwLCAwLCA4LCAxNiwgMCwgOCwgMTYsIDI0IH07CiAKIHN0YXRpYyBpbnQgYXRvbV9kc3RfdG9f
c3JjWzhdWzRdID0gewotLSAKMi4xNy4xCg==
