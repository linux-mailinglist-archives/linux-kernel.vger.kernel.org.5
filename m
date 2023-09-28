Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 330CB7B1088
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 04:01:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbjI1CB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 22:01:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1CBY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 22:01:24 -0400
Received: from jari.cn (unknown [218.92.28.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B3D4EB3;
        Wed, 27 Sep 2023 19:01:22 -0700 (PDT)
Received: from wangkailong$jari.cn ( [182.148.12.64] ) by
 ajax-webmail-localhost.localdomain (Coremail) ; Thu, 28 Sep 2023 10:00:02
 +0800 (GMT+08:00)
X-Originating-IP: [182.148.12.64]
Date:   Thu, 28 Sep 2023 10:00:02 +0800 (GMT+08:00)
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
Message-ID: <34fa1c8d.89c.18ad983b6a3.Coremail.wangkailong@jari.cn>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: AQAAfwDXaD4i3hRla3i+AA--.581W
X-CM-SenderInfo: 5zdqwypdlo00nj6mt2flof0/1tbiAQAJB2T8PZMAAQAWsu
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
VnhXKQoKU2lnbmVkLW9mZi1ieTogS2FpTG9uZyBXYW5nIDx3YW5na2FpbG9uZ0BqYXJpLmNuPgot
LS0KIGRyaXZlcnMvc2NzaS9ocHRpb3AuYyB8IDE5ICsrKysrKysrLS0tLS0tLS0tLS0KIDEgZmls
ZSBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBh
L2RyaXZlcnMvc2NzaS9ocHRpb3AuYyBiL2RyaXZlcnMvc2NzaS9ocHRpb3AuYwppbmRleCBmNTMz
NGNjYmYyY2EuLjU3ZjI4ZjViNWRhMSAxMDA2NDQKLS0tIGEvZHJpdmVycy9zY3NpL2hwdGlvcC5j
CisrKyBiL2RyaXZlcnMvc2NzaS9ocHRpb3AuYwpAQCAtOTMsNyArOTMsNyBAQCBzdGF0aWMgdm9p
ZCBocHRpb3BfZHJhaW5fb3V0Ym91bmRfcXVldWVfaXRsKHN0cnVjdCBocHRpb3BfaGJhICpoYmEp
CiAJCWlmIChyZXEgJiBJT1BNVV9RVUVVRV9NQVNLX0hPU1RfQklUUykKIAkJCWhwdGlvcF9yZXF1
ZXN0X2NhbGxiYWNrX2l0bChoYmEsIHJlcSk7CiAJCWVsc2UgewotCQkJc3RydWN0IGhwdF9pb3Bf
cmVxdWVzdF9oZWFkZXIgX19pb21lbSAqIHA7CisJCQlzdHJ1Y3QgaHB0X2lvcF9yZXF1ZXN0X2hl
YWRlciBfX2lvbWVtICpwOwogCiAJCQlwID0gKHN0cnVjdCBocHRfaW9wX3JlcXVlc3RfaGVhZGVy
IF9faW9tZW0gKikKIAkJCQkoKGNoYXIgX19pb21lbSAqKWhiYS0+dS5pdGwuaW9wICsgcmVxKTsK
QEAgLTEwMyw4ICsxMDMsNyBAQCBzdGF0aWMgdm9pZCBocHRpb3BfZHJhaW5fb3V0Ym91bmRfcXVl
dWVfaXRsKHN0cnVjdCBocHRpb3BfaGJhICpoYmEpCiAJCQkJCWhwdGlvcF9yZXF1ZXN0X2NhbGxi
YWNrX2l0bChoYmEsIHJlcSk7CiAJCQkJZWxzZQogCQkJCQl3cml0ZWwoMSwgJnAtPmNvbnRleHQp
OwotCQkJfQotCQkJZWxzZQorCQkJfSBlbHNlCiAJCQkJaHB0aW9wX3JlcXVlc3RfY2FsbGJhY2tf
aXRsKGhiYSwgcmVxKTsKIAkJfQogCX0KQEAgLTM5NCw3ICszOTMsNyBAQCBzdGF0aWMgaW50IGlv
cF9zZW5kX3N5bmNfbXNnKHN0cnVjdCBocHRpb3BfaGJhICpoYmEsIHUzMiBtc2csIHUzMiBtaWxs
aXNlYykKIAl9CiAKIAloYmEtPm9wcy0+ZW5hYmxlX2ludHIoaGJhKTsKLQlyZXR1cm4gaGJhLT5t
c2dfZG9uZT8gMCA6IC0xOworCXJldHVybiBoYmEtPm1zZ19kb25lID8gMCA6IC0xOwogfQogCiBz
dGF0aWMgaW50IGlvcF9nZXRfY29uZmlnX2l0bChzdHJ1Y3QgaHB0aW9wX2hiYSAqaGJhLApAQCAt
Njg4LDggKzY4Nyw3IEBAIHN0YXRpYyB2b2lkIGhwdGlvcF9tZXNzYWdlX2NhbGxiYWNrKHN0cnVj
dCBocHRpb3BfaGJhICpoYmEsIHUzMiBtc2cpCiAJaWYgKG1zZyA9PSBJT1BNVV9JTkJPVU5EX01T
RzBfUkVTRVQpIHsKIAkJYXRvbWljX3NldCgmaGJhLT5yZXNldHRpbmcsIDApOwogCQl3YWtlX3Vw
KCZoYmEtPnJlc2V0X3dxKTsKLQl9Ci0JZWxzZSBpZiAobXNnIDw9IElPUE1VX0lOQk9VTkRfTVNH
MF9NQVgpCisJfSBlbHNlIGlmIChtc2cgPD0gSU9QTVVfSU5CT1VORF9NU0cwX01BWCkKIAkJaGJh
LT5tc2dfZG9uZSA9IDE7CiB9CiAKQEAgLTgxNywxMyArODE1LDEyIEBAIHN0YXRpYyB2b2lkIGhw
dGlvcF9pb3BfcmVxdWVzdF9jYWxsYmFja19pdGwoc3RydWN0IGhwdGlvcF9oYmEgKmhiYSwgdTMy
IHRhZykKIAogCQlpZiAoYXJnLT5vdXRidWZfc2l6ZSkKIAkJCW1lbWNweV9mcm9taW8oYXJnLT5v
dXRidWYsCi0JCQkJJnAtPmJ1ZlsocmVhZGwoJnAtPmluYnVmX3NpemUpICsgMykmIH4zXSwKKwkJ
CQkmcC0+YnVmWyhyZWFkbCgmcC0+aW5idWZfc2l6ZSkgKyAzKSAmIH4zXSwKIAkJCQlhcmctPm91
dGJ1Zl9zaXplKTsKIAogCQlpZiAoYXJnLT5ieXRlc19yZXR1cm5lZCkKIAkJCSphcmctPmJ5dGVz
X3JldHVybmVkID0gYXJnLT5vdXRidWZfc2l6ZTsKLQl9Ci0JZWxzZQorCX0gZWxzZQogCQlhcmct
PnJlc3VsdCA9IEhQVF9JT0NUTF9SRVNVTFRfRkFJTEVEOwogCiAJYXJnLT5kb25lKGFyZyk7CkBA
IC0xMDkwLDEyICsxMDg3LDEyIEBAIHN0YXRpYyBpbnQgaHB0aW9wX3Jlc2V0X2hiYShzdHJ1Y3Qg
aHB0aW9wX2hiYSAqaGJhKQogCiBzdGF0aWMgaW50IGhwdGlvcF9yZXNldChzdHJ1Y3Qgc2NzaV9j
bW5kICpzY3ApCiB7Ci0Jc3RydWN0IGhwdGlvcF9oYmEgKiBoYmEgPSAoc3RydWN0IGhwdGlvcF9o
YmEgKilzY3AtPmRldmljZS0+aG9zdC0+aG9zdGRhdGE7CisJc3RydWN0IGhwdGlvcF9oYmEgKmhi
YSA9IChzdHJ1Y3QgaHB0aW9wX2hiYSAqKXNjcC0+ZGV2aWNlLT5ob3N0LT5ob3N0ZGF0YTsKIAog
CXByaW50ayhLRVJOX1dBUk5JTkcgImhwdGlvcF9yZXNldCglZC8lZC8lZClcbiIsCiAJICAgICAg
IHNjcC0+ZGV2aWNlLT5ob3N0LT5ob3N0X25vLCAtMSwgLTEpOwogCi0JcmV0dXJuIGhwdGlvcF9y
ZXNldF9oYmEoaGJhKT8gRkFJTEVEIDogU1VDQ0VTUzsKKwlyZXR1cm4gaHB0aW9wX3Jlc2V0X2hi
YShoYmEpID8gRkFJTEVEIDogU1VDQ0VTUzsKIH0KIAogc3RhdGljIGludCBocHRpb3BfYWRqdXN0
X2Rpc2tfcXVldWVfZGVwdGgoc3RydWN0IHNjc2lfZGV2aWNlICpzZGV2LAotLSAKMi4xNy4xCg==

