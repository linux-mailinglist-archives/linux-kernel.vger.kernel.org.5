Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76C678517A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 09:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjHWH2U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 03:28:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233267AbjHWH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 03:28:18 -0400
X-Greylist: delayed 125 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 23 Aug 2023 00:28:03 PDT
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8CCEDE70
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 00:28:03 -0700 (PDT)
Received: from chenxuebing$jari.cn ( [125.70.163.142] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 23 Aug 2023 15:25:34
 +0800 (GMT+08:00)
X-Originating-IP: [125.70.163.142]
Date:   Wed, 23 Aug 2023 15:25:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "XueBing Chen" <chenxuebing@jari.cn>
To:     alexander.deucher@amd.com
Cc:     amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/amdgpu: Clean up errors in iceland_ih.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <41b4538c.618.18a2148cf83.Coremail.chenxuebing@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD9utOVk3ECQAA--.447W
X-CM-SenderInfo: hfkh05pxhex0nj6mt2flof0/1tbiAQAMCmTkgo0ARAACsO
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
dGhhdCBvcGVuIGJyYWNlIHsgc2hvdWxkIGJlIG9uIHRoZSBwcmV2aW91cyBsaW5lCgpTaWduZWQt
b2ZmLWJ5OiBYdWVCaW5nIENoZW4gPGNoZW54dWViaW5nQGphcmkuY24+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2FtZC9hbWRncHUvaWNlbGFuZF9paC5jIHwgMyArLS0KIDEgZmlsZSBjaGFuZ2VkLCAx
IGluc2VydGlvbigrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9k
cm0vYW1kL2FtZGdwdS9pY2VsYW5kX2loLmMgYi9kcml2ZXJzL2dwdS9kcm0vYW1kL2FtZGdwdS9p
Y2VsYW5kX2loLmMKaW5kZXggYWVjYWQ1MzBiMTBhLi40YzgyOTY3MGQyZmEgMTAwNjQ0Ci0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9hbWQvYW1kZ3B1L2ljZWxhbmRfaWguYworKysgYi9kcml2ZXJzL2dw
dS9kcm0vYW1kL2FtZGdwdS9pY2VsYW5kX2loLmMKQEAgLTQzMyw4ICs0MzMsNyBAQCBzdGF0aWMg
dm9pZCBpY2VsYW5kX2loX3NldF9pbnRlcnJ1cHRfZnVuY3Moc3RydWN0IGFtZGdwdV9kZXZpY2Ug
KmFkZXYpCiAJYWRldi0+aXJxLmloX2Z1bmNzID0gJmljZWxhbmRfaWhfZnVuY3M7CiB9CiAKLWNv
bnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBpY2VsYW5kX2loX2lwX2Jsb2NrID0K
LXsKK2NvbnN0IHN0cnVjdCBhbWRncHVfaXBfYmxvY2tfdmVyc2lvbiBpY2VsYW5kX2loX2lwX2Js
b2NrID0gewogCS50eXBlID0gQU1EX0lQX0JMT0NLX1RZUEVfSUgsCiAJLm1ham9yID0gMiwKIAku
bWlub3IgPSA0LAotLSAKMi4xNy4xCg==
