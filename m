Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F2B7B1070
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjI1Bjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjI1Bjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:39:31 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D33E8B3;
        Wed, 27 Sep 2023 18:39:29 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 09:38:09
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 09:38:09 +0800 (GMT+08:00)
X-CM-HeaderCharset: UTF-8
From:   "KaiLong Wang" <wangkailong@jari.cn>
To:     linux@highpoint-tech.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: hptiop: Clean up errors in hptiop.c
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.1-cmXT6 build
 20230419(ff23bf83) Copyright (c) 2002-2023 www.mailtech.cn
 mispb-4e503810-ca60-4ec8-a188-7102c18937cf-zhkzyfz.cn
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Message-ID: <79a31286.896.18ad96fae37.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4B2RRlinW+AA--.579W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQALsz
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
ImZvbyAqIGJhciIgc2hvdWxkIGJlICJmb28gKmJhciIKRVJST1I6IGVsc2Ugc2hvdWxkIGZvbGxv
dyBjbG9zZSBicmFjZSAnfScKRVJST1I6IHNwYWNlcyByZXF1aXJlZCBhcm91bmQgdGhhdCAnPycg
KGN0eDpWeFcpCkVSUk9SOiBuZWVkIGNvbnNpc3RlbnQgc3BhY2luZyBhcm91bmQgJyYnIChjdHg6
VnhXKQoKU2lnbmVkLW9mZi1ieTogR3VvSHVhIENoZW5nIDxjaGVuZ3VvaHVhQGphcmkuY24+Ci0t
LQogZHJpdmVycy9zY3NpL2hwdGlvcC5jIHwgMTkgKysrKysrKystLS0tLS0tLS0tLQogMSBmaWxl
IGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKSwgMTEgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9zY3NpL2hwdGlvcC5jIGIvZHJpdmVycy9zY3NpL2hwdGlvcC5jCmluZGV4IGY1MzM0
Y2NiZjJjYS4uNTdmMjhmNWI1ZGExIDEwMDY0NAotLS0gYS9kcml2ZXJzL3Njc2kvaHB0aW9wLmMK
KysrIGIvZHJpdmVycy9zY3NpL2hwdGlvcC5jCkBAIC05Myw3ICs5Myw3IEBAIHN0YXRpYyB2b2lk
IGhwdGlvcF9kcmFpbl9vdXRib3VuZF9xdWV1ZV9pdGwoc3RydWN0IGhwdGlvcF9oYmEgKmhiYSkK
IAkJaWYgKHJlcSAmIElPUE1VX1FVRVVFX01BU0tfSE9TVF9CSVRTKQogCQkJaHB0aW9wX3JlcXVl
c3RfY2FsbGJhY2tfaXRsKGhiYSwgcmVxKTsKIAkJZWxzZSB7Ci0JCQlzdHJ1Y3QgaHB0X2lvcF9y
ZXF1ZXN0X2hlYWRlciBfX2lvbWVtICogcDsKKwkJCXN0cnVjdCBocHRfaW9wX3JlcXVlc3RfaGVh
ZGVyIF9faW9tZW0gKnA7CiAKIAkJCXAgPSAoc3RydWN0IGhwdF9pb3BfcmVxdWVzdF9oZWFkZXIg
X19pb21lbSAqKQogCQkJCSgoY2hhciBfX2lvbWVtICopaGJhLT51Lml0bC5pb3AgKyByZXEpOwpA
QCAtMTAzLDggKzEwMyw3IEBAIHN0YXRpYyB2b2lkIGhwdGlvcF9kcmFpbl9vdXRib3VuZF9xdWV1
ZV9pdGwoc3RydWN0IGhwdGlvcF9oYmEgKmhiYSkKIAkJCQkJaHB0aW9wX3JlcXVlc3RfY2FsbGJh
Y2tfaXRsKGhiYSwgcmVxKTsKIAkJCQllbHNlCiAJCQkJCXdyaXRlbCgxLCAmcC0+Y29udGV4dCk7
Ci0JCQl9Ci0JCQllbHNlCisJCQl9IGVsc2UKIAkJCQlocHRpb3BfcmVxdWVzdF9jYWxsYmFja19p
dGwoaGJhLCByZXEpOwogCQl9CiAJfQpAQCAtMzk0LDcgKzM5Myw3IEBAIHN0YXRpYyBpbnQgaW9w
X3NlbmRfc3luY19tc2coc3RydWN0IGhwdGlvcF9oYmEgKmhiYSwgdTMyIG1zZywgdTMyIG1pbGxp
c2VjKQogCX0KIAogCWhiYS0+b3BzLT5lbmFibGVfaW50cihoYmEpOwotCXJldHVybiBoYmEtPm1z
Z19kb25lPyAwIDogLTE7CisJcmV0dXJuIGhiYS0+bXNnX2RvbmUgPyAwIDogLTE7CiB9CiAKIHN0
YXRpYyBpbnQgaW9wX2dldF9jb25maWdfaXRsKHN0cnVjdCBocHRpb3BfaGJhICpoYmEsCkBAIC02
ODgsOCArNjg3LDcgQEAgc3RhdGljIHZvaWQgaHB0aW9wX21lc3NhZ2VfY2FsbGJhY2soc3RydWN0
IGhwdGlvcF9oYmEgKmhiYSwgdTMyIG1zZykKIAlpZiAobXNnID09IElPUE1VX0lOQk9VTkRfTVNH
MF9SRVNFVCkgewogCQlhdG9taWNfc2V0KCZoYmEtPnJlc2V0dGluZywgMCk7CiAJCXdha2VfdXAo
JmhiYS0+cmVzZXRfd3EpOwotCX0KLQllbHNlIGlmIChtc2cgPD0gSU9QTVVfSU5CT1VORF9NU0cw
X01BWCkKKwl9IGVsc2UgaWYgKG1zZyA8PSBJT1BNVV9JTkJPVU5EX01TRzBfTUFYKQogCQloYmEt
Pm1zZ19kb25lID0gMTsKIH0KIApAQCAtODE3LDEzICs4MTUsMTIgQEAgc3RhdGljIHZvaWQgaHB0
aW9wX2lvcF9yZXF1ZXN0X2NhbGxiYWNrX2l0bChzdHJ1Y3QgaHB0aW9wX2hiYSAqaGJhLCB1MzIg
dGFnKQogCiAJCWlmIChhcmctPm91dGJ1Zl9zaXplKQogCQkJbWVtY3B5X2Zyb21pbyhhcmctPm91
dGJ1ZiwKLQkJCQkmcC0+YnVmWyhyZWFkbCgmcC0+aW5idWZfc2l6ZSkgKyAzKSYgfjNdLAorCQkJ
CSZwLT5idWZbKHJlYWRsKCZwLT5pbmJ1Zl9zaXplKSArIDMpICYgfjNdLAogCQkJCWFyZy0+b3V0
YnVmX3NpemUpOwogCiAJCWlmIChhcmctPmJ5dGVzX3JldHVybmVkKQogCQkJKmFyZy0+Ynl0ZXNf
cmV0dXJuZWQgPSBhcmctPm91dGJ1Zl9zaXplOwotCX0KLQllbHNlCisJfSBlbHNlCiAJCWFyZy0+
cmVzdWx0ID0gSFBUX0lPQ1RMX1JFU1VMVF9GQUlMRUQ7CiAKIAlhcmctPmRvbmUoYXJnKTsKQEAg
LTEwOTAsMTIgKzEwODcsMTIgQEAgc3RhdGljIGludCBocHRpb3BfcmVzZXRfaGJhKHN0cnVjdCBo
cHRpb3BfaGJhICpoYmEpCiAKIHN0YXRpYyBpbnQgaHB0aW9wX3Jlc2V0KHN0cnVjdCBzY3NpX2Nt
bmQgKnNjcCkKIHsKLQlzdHJ1Y3QgaHB0aW9wX2hiYSAqIGhiYSA9IChzdHJ1Y3QgaHB0aW9wX2hi
YSAqKXNjcC0+ZGV2aWNlLT5ob3N0LT5ob3N0ZGF0YTsKKwlzdHJ1Y3QgaHB0aW9wX2hiYSAqaGJh
ID0gKHN0cnVjdCBocHRpb3BfaGJhICopc2NwLT5kZXZpY2UtPmhvc3QtPmhvc3RkYXRhOwogCiAJ
cHJpbnRrKEtFUk5fV0FSTklORyAiaHB0aW9wX3Jlc2V0KCVkLyVkLyVkKVxuIiwKIAkgICAgICAg
c2NwLT5kZXZpY2UtPmhvc3QtPmhvc3Rfbm8sIC0xLCAtMSk7CiAKLQlyZXR1cm4gaHB0aW9wX3Jl
c2V0X2hiYShoYmEpPyBGQUlMRUQgOiBTVUNDRVNTOworCXJldHVybiBocHRpb3BfcmVzZXRfaGJh
KGhiYSkgPyBGQUlMRUQgOiBTVUNDRVNTOwogfQogCiBzdGF0aWMgaW50IGhwdGlvcF9hZGp1c3Rf
ZGlza19xdWV1ZV9kZXB0aChzdHJ1Y3Qgc2NzaV9kZXZpY2UgKnNkZXYsCi0tIAoyLjE3LjEK
