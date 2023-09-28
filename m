Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00F57B2840
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbjI1WOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232570AbjI1WNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DA91A3;
        Thu, 28 Sep 2023 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939214; x=1696544014; i=linosanfilippo@gmx.de;
 bh=hg8w75pV0e3pjbzQLJFWM+TM+iujlrT3Ta4nBCXoDzs=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=im686yKF1Pr+8T9GT14YLKy2cCDauXeY+iT4ymje2THJJk7u9j7Uge8hyl3oEPMXJcAauQXmX91
 AFDdVBb+GoRvcxTu/8Z+/sZWdYpJAuDUDLs8l3ZvEraTB25HeE+c2zKZpF16a+M8o002ZDwgXpKF7
 nD3wPOHaLK+Y77jsEUGDMtf1hyrplNC9fCPi5ZmogKhgyzM+OG8C+CvHJjqWRd4EwiPuFDsmYp5Pv
 an0H6Og+HttTsjmC2b5ZvdzO5ffeXi3N5gRW7bTNwoo307Yvze2UNCOeFZDOPialnUFOSH0v8ZtV4
 dgX33wM8Hq/ad5/AQUZ3Th2972O37BdVsZqA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1rGM8d0T8j-00e39X; Fri, 29
 Sep 2023 00:13:34 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Subject: [PATCH 5/6] serial: core: make sure RS485 is cannot be enabled when it is not supported
Date:   Fri, 29 Sep 2023 00:12:45 +0200
Message-Id: <20230928221246.13689-6-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:Od3l4xl/uII61q4WCOzbzrdpV4WzfRrpfpwW+63udSex6TYzbGi
 Yxm3kzO8B0/p69CY6IbF6VIwdpcOC33Yh2uLfiUs2hUzzB+NvbzOW9K2YruY4zacovT56Qp
 wL/RFiJJTxVqsTJyhS/Yoo3m+FZdjOkPZDyRzr8yEqSw7cWa5e5YcWFsyzcAe3qXgQ3pum4
 pHQH9QaYtUL+pSUgFKF2Q==
UI-OutboundReport: notjunk:1;M01:P0:RERU25vI7eg=;t4JI+TeEd/T7kk73bmESiZA6A3d
 e+nOfxVI8YqeYeQsHbIdBiVKShltFe6hCz0O3OHfJUgXga3s/L/1+YxP2bLkHWLgUmG/OT1mS
 85HokF0MpWKcS1GPpiR5M9N/RwrKRtcWomL73hBQrIldlsLPCqH1hVpi7EI4Ty2kvzszI4frv
 RMic0di7sMBEKE/eZCC253W2uYY2438RJUUt5LOC13TqXEWWiuJdNEIvfC/HklzfBnQjuBokM
 a2nhL8W1DWZWAy/dPzKx7gHIP1XoT5ErCk6Ko+MgNRPiOqHHVrlKAapbTM2iAMO5HmeBHnEQx
 /jVqJfUan0e9tCw6ZYyfU67qrJu02q8E8x7D2JlwT7IB9h8dN6F7aRamWD8VWgD/0zjTa0LUG
 Bjs3XcSdH8btnkAkkrzZuVW7vGQH0AiN/QPkATOhmC8jNwX0NDxqgME0wN4v+NX38w4nrTg87
 oyuwiZxDz1Cm0OlTRN1yfChU2qhpZ1H3BPtbQa4N64U/VXO6KHuDqExNpc+3Yig2pW9VZVN6c
 7YCHKmPLq1Ptitz8p4S+4S2zY8IR0MAGcwB4uXG6PqIP9i3fFaxF7PqRdGSQuZrV/WRH/wNeZ
 zkhChi6kImrBx1ca/O1Sr4k2dUQpS0cLinZELGozGoG84xw+RpGncvtNhA5nqlIAl6YFu6kdY
 FUhi4JyEUY8GP79ZBl5xoD32lMEu8xrxvYfAHPgZ37dR06CT5nDCiciui79BEatfS4dL2gmdS
 m5X/UEkJzAbJiqumPWeHL4IHArpH6xpU3PsFUAyWo+LvmfLGU5WYj6MH0PNEGTI75OR01Gmel
 ncbbCyKwiEUjJsXhjAmpX/H589Sh6U3p8ucbCmxNT3yvVKmPH5jTCbVZ2kPmQP9Q0Gd6aKlV+
 cC7Og39gUqsA3fr810DFj5a0P/vahgn67Q1dsAS3amoamgoi+/mQI3V66s+Qk0IC6m2Y6hUTg
 oxM+XA==
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KClNvbWUgdWFy
dCBkcml2ZXJzIHNwZWNpZnkgYSByczQ4NV9jb25maWcoKSBmdW5jdGlvbiBhbmQgdGhlbiBkZWNp
ZGUgbGF0ZXIKdG8gZGlzYWJsZSBSUzQ4NSBzdXBwb3J0IGZvciBzb21lIHJlYXNvbiAoZS5nLiBp
bXggYW5kIGFyOTMzKS4KCkluIHRoZXNlIGNhc2VzIHVzZXJzcGFjZSBtYXkgYmUgYWJsZSB0byBh
Y3RpdmF0ZSBSUzQ4NSB2aWEgVElPQ1NSUzQ4NQpuZXZlcnRoZWxlc3MsIHNpbmNlIGluIHVhcnRf
c2V0X3JzNDg1X2NvbmZpZygpIGFuIGV4aXN0aW5nIHJzNDg1X2NvbmZpZygpCmZ1bmN0aW9uIGlu
ZGljYXRlcyB0aGF0IFJTNDg1IGlzIHN1cHBvcnRlZC4KCk1ha2Ugc3VyZSB0aGF0IHRoaXMgaXMg
bm90IGxvbmdlciBwb3NzaWJsZSBieSBjaGVja2luZyB0aGUgdWFydHMKcnM0ODVfc3VwcG9ydGVk
LmZsYWdzIGluc3RlYWQgYW5kIGJhaWxpbmcgb3V0IGlmIFNFUl9SUzQ4NV9FTkFCTEVEIGlzIG5v
dApzZXQuCgpGdXJ0aGVybW9yZSBpbnN0ZWFkIG9mIHJldHVybmluZyBhbiBlbXB0eSBzdHJ1Y3R1
cmUgcmV0dXJuIC1FTk9UVFkgaWYgdGhlClJTNDg1IGNvbmZpZ3VyYXRpb24gaXMgcmVxdWVzdGVk
IHZpYSBUSU9DR1JTNDg1IGJ1dCBSUzQ4NSBpcyBub3Qgc3VwcG9ydGVkLgoKQ2M6IHN0YWJsZUB2
Z2VyLmtlcm5lbC5vcmcKU2lnbmVkLW9mZi1ieTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlw
cG9Aa3VuYnVzLmNvbT4KLS0tCiBkcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyB8IDUg
KysrKy0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYyBiL2RyaXZlcnMvdHR5
L3NlcmlhbC9zZXJpYWxfY29yZS5jCmluZGV4IGY0ZmVlYmY4MjAwZi4uZGNhMDk4NzdmYWJjIDEw
MDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYworKysgYi9kcml2ZXJz
L3R0eS9zZXJpYWwvc2VyaWFsX2NvcmUuYwpAQCAtMTQzMiw2ICsxNDMyLDkgQEAgc3RhdGljIGlu
dCB1YXJ0X2dldF9yczQ4NV9jb25maWcoc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAl1bnNpZ25l
ZCBsb25nIGZsYWdzOwogCXN0cnVjdCBzZXJpYWxfcnM0ODUgYXV4OwogCisJaWYgKCEocG9ydC0+
cnM0ODVfc3VwcG9ydGVkLmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQpKQorCQlyZXR1cm4gLUVO
T1RUWTsKKwogCXNwaW5fbG9ja19pcnFzYXZlKCZwb3J0LT5sb2NrLCBmbGFncyk7CiAJYXV4ID0g
cG9ydC0+cnM0ODU7CiAJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcG9ydC0+bG9jaywgZmxhZ3Mp
OwpAQCAtMTQ0OSw3ICsxNDUyLDcgQEAgc3RhdGljIGludCB1YXJ0X3NldF9yczQ4NV9jb25maWco
c3RydWN0IHR0eV9zdHJ1Y3QgKnR0eSwgc3RydWN0IHVhcnRfcG9ydCAqcG9ydCwKIAlpbnQgcmV0
OwogCXVuc2lnbmVkIGxvbmcgZmxhZ3M7CiAKLQlpZiAoIXBvcnQtPnJzNDg1X2NvbmZpZykKKwlp
ZiAoIShwb3J0LT5yczQ4NV9zdXBwb3J0ZWQuZmxhZ3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkpCiAJ
CXJldHVybiAtRU5PVFRZOwogCiAJaWYgKGNvcHlfZnJvbV91c2VyKCZyczQ4NSwgcnM0ODVfdXNl
ciwgc2l6ZW9mKCpyczQ4NV91c2VyKSkpCi0tIAoyLjQwLjEKCg==
