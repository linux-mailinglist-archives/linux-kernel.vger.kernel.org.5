Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AE57AFBC3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 09:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjI0HPg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 03:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjI0HPd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 03:15:33 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72483136;
        Wed, 27 Sep 2023 00:15:32 -0700 (PDT)
Received: from chenguohua$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Wed, 27 Sep 2023 15:14:11
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Wed, 27 Sep 2023 15:14:11 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   chenguohua@jari.cn
To:     hare@suse.com, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: aic7xxx: Clean up errors in aicasm.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <5e399c83.87e.18ad57cf98b.Coremail.chenguohua@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDnhD9E1hNleu+9AA--.579W
X-CM-SenderInfo: xfkh0w5xrk3tw6md2xgofq/1tbiAQAHEWUSpy8AOwAEsX
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
cmV0dXJuIGlzIG5vdCBhIGZ1bmN0aW9uLCBwYXJlbnRoZXNlcyBhcmUgbm90IHJlcXVpcmVkCkVS
Uk9SOiBzcGFjZSByZXF1aXJlZCBiZWZvcmUgdGhlIG9wZW4gcGFyZW50aGVzaXMgJygnCgpTaWdu
ZWQtb2ZmLWJ5OiBHdW9IdWEgQ2hlbmcgPGNoZW5ndW9odWFAamFyaS5jbj4KLS0tCiBkcml2ZXJz
L3Njc2kvYWljN3h4eC9haWNhc20vYWljYXNtLmMgfCAxMCArKysrKy0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvc2NzaS9haWM3eHh4L2FpY2FzbS9haWNhc20uYyBiL2RyaXZlcnMvc2NzaS9haWM3eHh4L2Fp
Y2FzbS9haWNhc20uYwppbmRleCBhMjJmMGZmZmM5YjkuLjJmNzQ2MThkMDAzOCAxMDA2NDQKLS0t
IGEvZHJpdmVycy9zY3NpL2FpYzd4eHgvYWljYXNtL2FpY2FzbS5jCisrKyBiL2RyaXZlcnMvc2Nz
aS9haWM3eHh4L2FpY2FzbS9haWNhc20uYwpAQCAtOTcsNyArOTcsNyBAQCBGSUxFICpyZWdkaWFn
ZmlsZTsKIGludCAgIHNyY19tb2RlOwogaW50ICAgZHN0X21vZGU7CiAKLXN0YXRpYyBTVEFJTFFf
SEVBRCgsaW5zdHJ1Y3Rpb24pIHNlcV9wcm9ncmFtOworc3RhdGljIFNUQUlMUV9IRUFEKCwgaW5z
dHJ1Y3Rpb24pIHNlcV9wcm9ncmFtOwogc3RydWN0IGNzX3RhaWxxIGNzX3RhaWxxOwogc3RydWN0
IHNjb3BlX2xpc3Qgc2NvcGVfc3RhY2s7CiBzeW1saXN0X3QgcGF0Y2hfZnVuY3Rpb25zOwpAQCAt
MTQ0LDcgKzE0NCw3IEBAIG1haW4oaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIAltbWRlYnVnID0g
MDsKICNlbmRpZgogCXdoaWxlICgoY2ggPSBnZXRvcHQoYXJnYywgYXJndiwgImQ6aTpsOm46bzpw
OnI6SToiKSkgIT0gLTEpIHsKLQkJc3dpdGNoKGNoKSB7CisJCXN3aXRjaCAoY2gpIHsKIAkJY2Fz
ZSAnZCc6CiAjaWYgREVCVUcKIAkJCWlmIChzdHJjbXAob3B0YXJnLCAicyIpID09IDApIHsKQEAg
LTMwMSw3ICszMDEsNyBAQCBtYWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAKIAlzdG9wKE5V
TEwsIDApOwogCS8qIE5PVFJFQUNIRUQgKi8KLQlyZXR1cm4gKDApOworCXJldHVybiAwOwogfQog
CiBzdGF0aWMgdm9pZApAQCAtNjc0LDkgKzY3NCw5IEBAIGNoZWNrX3BhdGNoKHBhdGNoX3QgKipz
dGFydF9wYXRjaCwgaW50IHN0YXJ0X2luc3RyLAogCSpzdGFydF9wYXRjaCA9IGN1cl9wYXRjaDsK
IAlpZiAoc3RhcnRfaW5zdHIgPCAqc2tpcF9hZGRyKQogCQkvKiBTdGlsbCBza2lwcGluZyAqLwot
CQlyZXR1cm4gKDApOworCQlyZXR1cm4gMDsKIAotCXJldHVybiAoMSk7CisJcmV0dXJuIDE7CiB9
CiAKIC8qCi0tIAoyLjE3LjEK
