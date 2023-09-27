Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A45E7AFE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 10:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbjI0Idz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 04:33:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230468AbjI0IdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 04:33:20 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DF61D10D9;
        Wed, 27 Sep 2023 01:32:58 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 16:31:34
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 16:31:34 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     lduncan@suse.com, cleech@redhat.com, michael.christie@oracle.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: iscsi: Clean up errors in libiscsi_tcp.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <7db9a4b1.889.18ad5c3d0ef.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD5m6BNlifm9AA--.577W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAisx
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
Iihmb28qKSIgc2hvdWxkIGJlICIoZm9vICopIgpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3Jl
IHRoZSBvcGVuIHBhcmVudGhlc2lzICcoJwpFUlJPUjogc3BhY2UgcmVxdWlyZWQgYmVmb3JlIHRo
ZSBvcGVuIGJyYWNlICd7JwoKU2lnbmVkLW9mZi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVh
QGphcmkuY24+Ci0tLQogZHJpdmVycy9zY3NpL2xpYmlzY3NpX3RjcC5jIHwgMjAgKysrKysrKysr
Ky0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3Njc2kvbGliaXNjc2lfdGNwLmMgYi9kcml2ZXJz
L3Njc2kvbGliaXNjc2lfdGNwLmMKaW5kZXggYzE4MmFhODNmMmM5Li4xMWI5Y2Q0MWZjMWYgMTAw
NjQ0Ci0tLSBhL2RyaXZlcnMvc2NzaS9saWJpc2NzaV90Y3AuYworKysgYi9kcml2ZXJzL3Njc2kv
bGliaXNjc2lfdGNwLmMKQEAgLTQ2MiwxNiArNDYyLDE2IEBAIHZvaWQgaXNjc2lfdGNwX2NsZWFu
dXBfdGFzayhzdHJ1Y3QgaXNjc2lfdGFzayAqdGFzaykKIAogCXNwaW5fbG9ja19iaCgmdGNwX3Rh
c2stPnF1ZXVlMnBvb2wpOwogCS8qIGZsdXNoIHRhc2sncyByMnQgcXVldWVzICovCi0Jd2hpbGUg
KGtmaWZvX291dCgmdGNwX3Rhc2stPnIydHF1ZXVlLCAodm9pZCopJnIydCwgc2l6ZW9mKHZvaWQq
KSkpIHsKLQkJa2ZpZm9faW4oJnRjcF90YXNrLT5yMnRwb29sLnF1ZXVlLCAodm9pZCopJnIydCwK
LQkJCSAgICBzaXplb2Yodm9pZCopKTsKKwl3aGlsZSAoa2ZpZm9fb3V0KCZ0Y3BfdGFzay0+cjJ0
cXVldWUsICh2b2lkICopJnIydCwgc2l6ZW9mKHZvaWQgKikpKSB7CisJCWtmaWZvX2luKCZ0Y3Bf
dGFzay0+cjJ0cG9vbC5xdWV1ZSwgKHZvaWQgKikmcjJ0LAorCQkJICAgIHNpemVvZih2b2lkICop
KTsKIAkJSVNDU0lfREJHX1RDUCh0YXNrLT5jb25uLCAicGVuZGluZyByMnQgZHJvcHBlZFxuIik7
CiAJfQogCiAJcjJ0ID0gdGNwX3Rhc2stPnIydDsKIAlpZiAocjJ0ICE9IE5VTEwpIHsKLQkJa2Zp
Zm9faW4oJnRjcF90YXNrLT5yMnRwb29sLnF1ZXVlLCAodm9pZCopJnIydCwKLQkJCSAgICBzaXpl
b2Yodm9pZCopKTsKKwkJa2ZpZm9faW4oJnRjcF90YXNrLT5yMnRwb29sLnF1ZXVlLCAodm9pZCAq
KSZyMnQsCisJCQkgICAgc2l6ZW9mKHZvaWQgKikpOwogCQl0Y3BfdGFzay0+cjJ0ID0gTlVMTDsK
IAl9CiAJc3Bpbl91bmxvY2tfYmgoJnRjcF90YXNrLT5xdWV1ZTJwb29sKTsKQEAgLTQ5Niw3ICs0
OTYsNyBAQCBzdGF0aWMgaW50IGlzY3NpX3RjcF9kYXRhX2luKHN0cnVjdCBpc2NzaV9jb25uICpj
b25uLCBzdHJ1Y3QgaXNjc2lfdGFzayAqdGFzaykKIAkgKiBpcyBzdGF0dXMuCiAJICovCiAJaWYg
KCEocmhkci0+ZmxhZ3MgJiBJU0NTSV9GTEFHX0RBVEFfU1RBVFVTKSkKLQkJaXNjc2lfdXBkYXRl
X2NtZHNuKGNvbm4tPnNlc3Npb24sIChzdHJ1Y3QgaXNjc2lfbm9waW4qKXJoZHIpOworCQlpc2Nz
aV91cGRhdGVfY21kc24oY29ubi0+c2Vzc2lvbiwgKHN0cnVjdCBpc2NzaV9ub3BpbiAqKXJoZHIp
OwogCiAJaWYgKHRjcF9jb25uLT5pbi5kYXRhbGVuID09IDApCiAJCXJldHVybiAwOwpAQCAtNTgw
LDcgKzU4MCw3IEBAIHN0YXRpYyBpbnQgaXNjc2lfdGNwX3IydF9yc3Aoc3RydWN0IGlzY3NpX2Nv
bm4gKmNvbm4sIHN0cnVjdCBpc2NzaV9oZHIgKmhkcikKIAogCXRjcF90YXNrID0gdGFzay0+ZGRf
ZGF0YTsKIAlyMnRzbiA9IGJlMzJfdG9fY3B1KHJoZHItPnIydHNuKTsKLQlpZiAodGNwX3Rhc2st
PmV4cF9kYXRhc24gIT0gcjJ0c24peworCWlmICh0Y3BfdGFzay0+ZXhwX2RhdGFzbiAhPSByMnRz
bikgewogCQlJU0NTSV9EQkdfVENQKGNvbm4sICJ0YXNrLT5leHBfZGF0YXNuKCVkKSAhPSByaGRy
LT5yMnRzbiglZClcbiIsCiAJCQkgICAgICB0Y3BfdGFzay0+ZXhwX2RhdGFzbiwgcjJ0c24pOwog
CQlyYyA9IElTQ1NJX0VSUl9SMlRTTjsKQEAgLTYzOCw3ICs2MzgsNyBAQCBzdGF0aWMgaW50IGlz
Y3NpX3RjcF9yMnRfcnNwKHN0cnVjdCBpc2NzaV9jb25uICpjb25uLCBzdHJ1Y3QgaXNjc2lfaGRy
ICpoZHIpCiAJcjJ0LT5zZW50ID0gMDsKIAogCXRjcF90YXNrLT5leHBfZGF0YXNuID0gcjJ0c24g
KyAxOwotCWtmaWZvX2luKCZ0Y3BfdGFzay0+cjJ0cXVldWUsICh2b2lkKikmcjJ0LCBzaXplb2Yo
dm9pZCopKTsKKwlrZmlmb19pbigmdGNwX3Rhc2stPnIydHF1ZXVlLCAodm9pZCAqKSZyMnQsIHNp
emVvZih2b2lkICopKTsKIAljb25uLT5yMnRfcGR1c19jbnQrKzsKIAlzcGluX3VubG9jaygmdGNw
X3Rhc2stPnBvb2wycXVldWUpOwogCkBAIC03MTUsNyArNzE1LDcgQEAgaXNjc2lfdGNwX2hkcl9k
aXNzZWN0KHN0cnVjdCBpc2NzaV9jb25uICpjb25uLCBzdHJ1Y3QgaXNjc2lfaGRyICpoZHIpCiAJ
SVNDU0lfREJHX1RDUChjb25uLCAib3Bjb2RlIDB4JXggYWhzbGVuICVkIGRhdGFsZW4gJWRcbiIs
CiAJCSAgICAgIG9wY29kZSwgYWhzbGVuLCB0Y3BfY29ubi0+aW4uZGF0YWxlbik7CiAKLQlzd2l0
Y2gob3Bjb2RlKSB7CisJc3dpdGNoIChvcGNvZGUpIHsKIAljYXNlIElTQ1NJX09QX1NDU0lfREFU
QV9JTjoKIAkJc3Bpbl9sb2NrKCZjb25uLT5zZXNzaW9uLT5iYWNrX2xvY2spOwogCQl0YXNrID0g
aXNjc2lfaXR0X3RvX2N0YXNrKGNvbm4sIGhkci0+aXR0KTsKQEAgLTExNzgsNyArMTE3OCw3IEBA
IGludCBpc2NzaV90Y3BfcjJ0cG9vbF9hbGxvYyhzdHJ1Y3QgaXNjc2lfc2Vzc2lvbiAqc2Vzc2lv
bikKIAogCQkvKiBSMlQgeG1pdCBxdWV1ZSAqLwogCQlpZiAoa2ZpZm9fYWxsb2MoJnRjcF90YXNr
LT5yMnRxdWV1ZSwKLQkJICAgICAgc2Vzc2lvbi0+bWF4X3IydCAqIDQgKiBzaXplb2Yodm9pZCop
LCBHRlBfS0VSTkVMKSkgeworCQkgICAgICBzZXNzaW9uLT5tYXhfcjJ0ICogNCAqIHNpemVvZih2
b2lkICopLCBHRlBfS0VSTkVMKSkgewogCQkJaXNjc2lfcG9vbF9mcmVlKCZ0Y3BfdGFzay0+cjJ0
cG9vbCk7CiAJCQlnb3RvIHIydF9hbGxvY19mYWlsOwogCQl9Ci0tIAoyLjE3LjEK
