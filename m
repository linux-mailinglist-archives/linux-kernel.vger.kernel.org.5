Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA17C7C7E69
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 09:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjJMHMX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 03:12:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJMHMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 03:12:22 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79A7BA9
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 00:12:20 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.14.172] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Fri, 13 Oct 2023 15:10:38
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.14.172]
Date:   Fri, 13 Oct 2023 15:10:38 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     willy@infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] fs: Clean up errors in file.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <d79d057.965.18b27df7693.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDHZD9u7Shlqt7BAA--.689W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQADB2UnvzMAKgAEsl
X-Coremail-Antispam: 1Ur529EdanIXcx71UUUUU7IcSsGvfJ3iIAIbVAYjsxI4VWxJw
        CS07vEb4IE77IF4wCS07vE1I0E4x80FVAKz4kxMIAIbVAFxVCaYxvI4VCIwcAKzIAtYxBI
        daVFxhVjvjDU=
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_00,RCVD_IN_PBL,RDNS_NONE,
        T_SPF_HELO_PERMERROR,T_SPF_PERMERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rml4IHRoZSBmb2xsb3dpbmcgZXJyb3JzIHJlcG9ydGVkIGJ5IGNoZWNrcGF0Y2g6CgpFUlJPUjog
c3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwoKU2lnbmVkLW9m
Zi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgotLS0KIGZzL2Jmcy9maWxl
LmMgfCAyICstCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkK
CmRpZmYgLS1naXQgYS9mcy9iZnMvZmlsZS5jIGIvZnMvYmZzL2ZpbGUuYwppbmRleCBhZGMyMjMw
MDc5YzYuLmYyYjIxZDE3ZGE0OSAxMDA2NDQKLS0tIGEvZnMvYmZzL2ZpbGUuYworKysgYi9mcy9i
ZnMvZmlsZS5jCkBAIC01Myw3ICs1Myw3IEBAIHN0YXRpYyBpbnQgYmZzX21vdmVfYmxvY2tzKHN0
cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGxvbmcgc3RhcnQsCiAKIAlkcHJpbnRmKCIl
MDhseC0lMDhseC0+JTA4bHhcbiIsIHN0YXJ0LCBlbmQsIHdoZXJlKTsKIAlmb3IgKGkgPSBzdGFy
dDsgaSA8PSBlbmQ7IGkrKykKLQkJaWYoYmZzX21vdmVfYmxvY2soaSwgd2hlcmUgKyBpLCBzYikp
IHsKKwkJaWYgKGJmc19tb3ZlX2Jsb2NrKGksIHdoZXJlICsgaSwgc2IpKSB7CiAJCQlkcHJpbnRm
KCJmYWlsZWQgdG8gbW92ZSBibG9jayAlMDhseCAtPiAlMDhseFxuIiwgaSwKIAkJCQkJCQkJd2hl
cmUgKyBpKTsKIAkJCXJldHVybiAtRUlPOwotLSAKMi4xNy4xCg==
