Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C01F7B283E
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:14:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbjI1WOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232552AbjI1WNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:52 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0CA1A2;
        Thu, 28 Sep 2023 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939214; x=1696544014; i=linosanfilippo@gmx.de;
 bh=mLPlHXBVRwexjH0Cj387VLbBgxjGGRTQWXTD7dFXyMo=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=KQLdbtXKMqmvGK1Ic+BlRFgjsdhtMa+SeK206YXzV9aLWtvVG3MwcYgjKoUQbdH/5H+HEPQ/98h
 1f1UIEEaRq5EDiw6QmnAWVRBvcQx68gSlSmUTr/UkFn0TcTKQULUDGuMPzXKglAf0dLIKKvUdQHDF
 lXFnkYn/j4gO3Fitg9FsTeqgd9n41FEoFphuA1tv9qHepmeadFE/N6F1Fe0Z3j2cnRwIEKtQprXWs
 6ZG9jcFkQoEylmIWrz5ceHC8/f0HNyM96VfoJZ0Hu9h2jSCpuXAKuJ6O0qPjNZn34ICO116qDw5xu
 p7of6bPxWU+UB7SWibAFzsQrMnbBFOCVIIvg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Fs-1rOqb53LEM-00oBVU; Fri, 29
 Sep 2023 00:13:33 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Subject: [PATCH 4/6] serial: core: fix sanitizing check for RTS settings
Date:   Fri, 29 Sep 2023 00:12:44 +0200
Message-Id: <20230928221246.13689-5-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:q5g0/t22Us9cn/lBgY6QmJyAiEQaNgtDtxjK+YvBOStqaS2nDfQ
 zMcTJuIMThPdRFuVaW1gtGcUHYDcWQvKrpC6sbHrpdTc/V83oLE6S/gf+SZ0WT8FwTubJLA
 AK73xikeMQpfk/RPyTmOERBOOoOQ2mVVMRJMrA3y9kR1A2XLWdNRW+68nf0BpeantrkOKqd
 HzcieTLxxlfeczVfyRNjQ==
UI-OutboundReport: notjunk:1;M01:P0:bWWTFd2uhgo=;AAkMwugWAP0QngTop9gN+mtLifq
 oyiuk799766XqgO1K4PbKk23jcF3B5UPyv7QojPxbW84dCERYBzE82tpJ2XRNJOQTiq33W6uP
 Kx4lAHLq9tSkIDhtZI1xZINRU/aUpmv3x0kv8cp+zWk1BZeAQqfb58pFZm/h2h4SDCVObX/xO
 NCEw/yQjvvsLFuGV4ggzxESWWrLboDBgfdRmzeu1iMSzZaXNJcWSFv+3o7VldANvdjCkCBPq/
 IWdbDI/zo8tQHvUaSkeARUL69JhN5kD7+ePl7gf8lullnbfeFZtwai07MJv5sKWqH780ZnXSj
 v0bQ3TUEKZVU7EH4g3Z19bMO49QcV+hdKI934bbjfJbuhv/1lbUgVLD/uTSMLHkiv+U7kbq/E
 pBF56nWaK+So+UhfZnf8KsRCqFYHdKG7boemqTncZZaJ7v1cqC/fhmjb3xS1DB5/dEn4W6pwy
 icTY2jlHJokKpaw7JX222AdC5uvyf1dPGXrrrSep0JsmQGU1ltFfcmH10I1KsOT6/hrNZetpR
 IxGm/3w5odmbxEJw+SVJwFsFAaz/NRodQdT4aTtG+mK/+g+ydEdYu4ojdNw4kq++SBW9tl4Z8
 E2avaKu6wq1+mIrQjzjXTtsGodmjX2fOcEFOI5kbLMzD2mDLDAznVWq8YyfjK0LNGMD1wMlwe
 j5EJsUxowU9Q1r8UEtFKDIIgpUfnmtv8uSIVQUvHnTucjg/nfwF5WW2yEjLf5+TXbQ+XhIVK0
 waMoQgJUB4KhvgCfJfxxhpk+D8JfZer+Bff0qEatMvwwxqVggY+SsGwTjaYbi2msKxl/dxZeR
 QzrM55e/IgDbEDWL5hQysiHe5Aet7imB+qyAFBQvMDTN1VV0wXCaCC1i3U/syBRf7PQI846UW
 lPMzRTeKhKDg+mmdMrQQk+A0oKcKcBifty4FS3PtRc4Pg8Dv9oRWNBDLIj0KmW6CKcvuNDfwV
 irpBEA==
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkFtb25nIG90
aGVyIHRoaW5ncyB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NSgpIHRlc3RzIHRoZSBzYW5pdHkg
b2YgdGhlIFJUUwpzZXR0aW5ncyBpbiBhIFJTNDg1IGNvbmZpZ3VyYXRpb24gdGhhdCBoYXMgYmVl
biBwYXNzZWQgYnkgdXNlcnNwYWNlLgpJZiBSVFMtb24tc2VuZCBhbmQgUlRTLWFmdGVyLXNlbmQg
YXJlIGJvdGggc2V0IG9yIHVuc2V0IHRoZSBjb25maWd1cmF0aW9uCmlzIGFkanVzdGVkIGFuZCBS
VFMtYWZ0ZXItc2VuZCBpcyBkaXNhYmxlZCBhbmQgUlRTLW9uLXNlbmQgZW5hYmxlZC4KClRoaXMg
aG93ZXZlciBtYWtlcyBvbmx5IHNlbnNlIGlmIGJvdGggUlRTIG1vZGVzIGFyZSBhY3R1YWxseSBz
dXBwb3J0ZWQgYnkKdGhlIGRyaXZlci4KCldpdGggY29tbWl0IGJlMmUyY2IxZDI4MSAoInNlcmlh
bDogU2FuaXRpemUgcnM0ODVfc3RydWN0IikgdGhlIGNvZGUgZG9lcwp0YWtlIHRoZSBkcml2ZXIg
c3VwcG9ydCBpbnRvIGFjY291bnQgYnV0IG9ubHkgY2hlY2tzIGlmIG9uZSBvZiBib3RoIFJUUwpt
b2RlcyBhcmUgc3VwcG9ydGVkLiBUaGlzIG1heSBsZWFkIHRvIHRoZSBlcnJvcm5lb3VzIHJlc3Vs
dCBvZiBSVFMtb24tc2VuZApiZWluZyBzZXQgZXZlbiBpZiBvbmx5IFJUUy1hZnRlci1zZW5kIGlz
IHN1cHBvcnRlZC4KCkZpeCB0aGlzIGJ5IGNoYW5naW5nIHRoZSBpbXBsZW1lbnRlZCBsb2dpYzog
Rmlyc3QgY2xlYXIgYWxsIHVuc3VwcG9ydGVkCmZsYWdzIGluIHRoZSBSUzQ4NSBjb25maWd1cmF0
aW9uLCB0aGVuIGFkanVzdCBhbiBpbnZhbGlkIFJUUyBzZXR0aW5nIGJ5CnRha2luZyBpbnRvIGFj
Y291bnQgd2hpY2ggUlRTIG1vZGUgaXMgc3VwcG9ydGVkLgoKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5l
bC5vcmcKRml4ZXM6IGJlMmUyY2IxZDI4MSAoInNlcmlhbDogU2FuaXRpemUgcnM0ODVfc3RydWN0
IikKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNv
bT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDI4ICsrKysrKysrKysr
KysrKysrKy0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxOCBpbnNlcnRpb25zKCspLCAxMCBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IDY5N2MzNmRjN2VjOC4u
ZjRmZWViZjgyMDBmIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUu
YworKysgYi9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTM3MCwxOSArMTM3
MCwyNyBAQCBzdGF0aWMgdm9pZCB1YXJ0X3Nhbml0aXplX3NlcmlhbF9yczQ4NShzdHJ1Y3QgdWFy
dF9wb3J0ICpwb3J0LCBzdHJ1Y3Qgc2VyaWFsX3JzNAogCQlyZXR1cm47CiAJfQogCisJcnM0ODUt
PmZsYWdzICY9IHN1cHBvcnRlZF9mbGFnczsKKwogCS8qIFBpY2sgc2FuZSBzZXR0aW5ncyBpZiB0
aGUgdXNlciBoYXNuJ3QgKi8KLQlpZiAoKHN1cHBvcnRlZF9mbGFncyAmIChTRVJfUlM0ODVfUlRT
X09OX1NFTkR8U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EKSkgJiYKLQkgICAgIShyczQ4NS0+Zmxh
Z3MgJiBTRVJfUlM0ODVfUlRTX09OX1NFTkQpID09CisJaWYgKCEocnM0ODUtPmZsYWdzICYgU0VS
X1JTNDg1X1JUU19PTl9TRU5EKSA9PQogCSAgICAhKHJzNDg1LT5mbGFncyAmIFNFUl9SUzQ4NV9S
VFNfQUZURVJfU0VORCkpIHsKLQkJZGV2X3dhcm5fcmF0ZWxpbWl0ZWQocG9ydC0+ZGV2LAotCQkJ
IiVzICglZCk6IGludmFsaWQgUlRTIHNldHRpbmcsIHVzaW5nIFJUU19PTl9TRU5EIGluc3RlYWRc
biIsCi0JCQlwb3J0LT5uYW1lLCBwb3J0LT5saW5lKTsKLQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9S
UzQ4NV9SVFNfT05fU0VORDsKLQkJcnM0ODUtPmZsYWdzICY9IH5TRVJfUlM0ODVfUlRTX0FGVEVS
X1NFTkQ7Ci0JCXN1cHBvcnRlZF9mbGFncyB8PSBTRVJfUlM0ODVfUlRTX09OX1NFTkR8U0VSX1JT
NDg1X1JUU19BRlRFUl9TRU5EOwotCX0KKwkJaWYgKHN1cHBvcnRlZF9mbGFncyAmIFNFUl9SUzQ4
NV9SVFNfT05fU0VORCkgeworCQkJcnM0ODUtPmZsYWdzIHw9IFNFUl9SUzQ4NV9SVFNfT05fU0VO
RDsKKwkJCXJzNDg1LT5mbGFncyAmPSB+U0VSX1JTNDg1X1JUU19BRlRFUl9TRU5EOwogCi0JcnM0
ODUtPmZsYWdzICY9IHN1cHBvcnRlZF9mbGFnczsKKwkJCWRldl93YXJuX3JhdGVsaW1pdGVkKHBv
cnQtPmRldiwKKwkJCQkiJXMgKCVkKTogaW52YWxpZCBSVFMgc2V0dGluZywgdXNpbmcgUlRTX09O
X1NFTkQgaW5zdGVhZFxuIiwKKwkJCQlwb3J0LT5uYW1lLCBwb3J0LT5saW5lKTsKKwkJfSBlbHNl
IHsKKwkJCXJzNDg1LT5mbGFncyB8PSBTRVJfUlM0ODVfUlRTX0FGVEVSX1NFTkQ7CisJCQlyczQ4
NS0+ZmxhZ3MgJj0gflNFUl9SUzQ4NV9SVFNfT05fU0VORDsKKworCQkJZGV2X3dhcm5fcmF0ZWxp
bWl0ZWQocG9ydC0+ZGV2LAorCQkJCSIlcyAoJWQpOiBpbnZhbGlkIFJUUyBzZXR0aW5nLCB1c2lu
ZyBSVFNfQUZURVJfU0VORCBpbnN0ZWFkXG4iLAorCQkJCXBvcnQtPm5hbWUsIHBvcnQtPmxpbmUp
OworCQl9CisJfQogCiAJdWFydF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODVfZGVsYXlzKHBvcnQsIHJz
NDg1KTsKIAotLSAKMi40MC4xCgo=
