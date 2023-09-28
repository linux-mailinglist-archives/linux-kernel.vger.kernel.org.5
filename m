Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE5197B283F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:14:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232538AbjI1WOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:14:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbjI1WNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C4F199;
        Thu, 28 Sep 2023 15:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939213; x=1696544013; i=linosanfilippo@gmx.de;
 bh=vJJdIPiNBx++tj9zJ3xfwS+JCLsCH3aBQui0XXS7z1o=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ucN9AKNMnNjgF0t/G/lNHGfY+LK1qfKnY83u1TXeWTRQwfnn2F7A+hSl8/Mtlv7qVAKjpkzbwnX
 J27DI96ZfVigm+YEK9umV1V/4ZYip72tywJU0QBNZB3ysZBhUyQqKZZoQqOcNDU3ErLrED+ggy8XC
 kw7aS0UVBNpi5M4jsv+wupz4yNDIMjwCAaskNeK6/el8GVnqiO4kNHPoOXhgiWdqzxdubiVgKI+xG
 Z6pKInF5CCOvaQ9BT4HDnVWuukIliUwFGFYzjpQrc3VWoNW1PR7EDFTIi0pKaan7MHqjmvaGrgFpm
 nyrdgiOvlOckpKYGXIsuF7qOmWDYiymASnTg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1McH9i-1rM8tF0x2a-00chIk; Fri, 29
 Sep 2023 00:13:33 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH 2/6] serial: amba-pl011: get rid of useless wrapper pl011_get_rs485_mode()
Date:   Fri, 29 Sep 2023 00:12:42 +0200
Message-Id: <20230928221246.13689-3-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:TpkKxtXsopZfiZUjpfsnzwKy/vXCM/Vs66OTnR8QnnHg11UC+ib
 /MXS/+n/r22VAEVPGicWkJpbejyF738VjNbNvsbUpmsGtcPE76CjoQcmIEbIr6shjNLK+ob
 4kGco/DFP1HQxSC+ufkSTUeJD03TateVj312C0d9kGDjZWe/dC1+DCAI8pTTCJ6l+y9Jxla
 ijflsV4IFSiaRI4Cpgc3w==
UI-OutboundReport: notjunk:1;M01:P0:g+IXyWx4S0s=;eXmYRB6me9QdFv/wdAED6xvpjP8
 dWkkwOhhDhLlJubZMPVAGOUCzcijhC/0YmCiJRFxrOtxuc8FFCqDppHfkEF3d8SDlPCrDp84b
 juLlg3lhaySRX6P1cVVkQcNrBZMjECQ/MHCHmdt4zjR6RHbTBp7NBYfxL2vMcDEUofFuv/pPX
 FKUiGj71j/V7/BScIi85DOe5uX/vHyGTwt0fthwyFmZhxQVOmOXxs8lLv0ly7IX/0I5mTd3Ha
 mfpS5048peoCglxkxbXhsg3slVPyy6XPuobJcrWXvfU3m8jxwK4FsMYckYfT1yl8FpUaPG87u
 IY9/870PJ44PvTvPpIHDx36swSJobLMWquZUUDYxscNRB/ODhKGafF3T3kBGTTn8o90COzK49
 D7zeMvjr4+paDpjbRaOMFhgVcGW6tqmcI4Cg+TUoqJKhhQxD25I12zzEwLSSDoXdiu5uLf0ML
 PPXrLq35UPKYHCccC7HHNi6mRF+rIqAuGJjaQHnUNYkYjrDv1Kn6EtMfE5qsCoYNZWVk3zEQN
 SRHH9282Wcv7WvFsYSsu7uaMW4d6MLJEEqcwd4KUktnGIvIN3OpRguLEduZESjCoFFwEmaj1M
 WvSfMkAcUjisKKr7zGNHsZK9WMW/wWkIvAmgiX888wYW/yjcKMWgZJRROewv1EcsxXrPAsHNo
 yEfk4XSuhztfBLPMzybfusEzXVR9hs3HQCjtrK3jAB2aXL0erwVZBWRtVu+008PrNQsXv3cx9
 CrzOMWWx8E1m5zWLbh+YU3QkF7uRc0ovihCJhcP0b3HJZy8uLymy4H+4xPFGtFZpAVv5yBLKi
 0Ac3RC9gV0TH+exyDVeuDyXVAxSf9NhToSJknwE3SdO4EgRmcFNiwHrRg0yj1VclK/PCOKkY2
 iMAxrcoK/Kc7+qUCG+TQ6JxNjIzjOye/t5IN+8lQmTvIX4dgiJjUXYE9QPGquWKMGFJmWxXHH
 ehMKJQ==
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCkR1ZSB0byBl
YXJsaWVyIGNvZGUgY2hhbmdlcyBmdW5jdGlvbiBwbDAxMV9nZXRfcnM0ODVfbW9kZSgpIGlzIG5v
dyBtZXJlbHkKYSB3cmFwcGVyIGZvciB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgd2hpY2ggZG9lcyBu
b3QgYWRkIGFueSBmdXJ0aGVyCmZ1bmN0aW9uYWxpdHkuIFNvIHJlbW92ZSBpdCBhbmQgaW5zdGVh
ZCBjYWxsIHVhcnRfZ2V0X3JzNDg1X21vZGUoKQpkaXJlY3RseS4KClNpZ25lZC1vZmYtYnk6IExp
bm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQogZHJpdmVycy90dHkv
c2VyaWFsL2FtYmEtcGwwMTEuYyB8IDE0ICstLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5
L3NlcmlhbC9hbWJhLXBsMDExLmMgYi9kcml2ZXJzL3R0eS9zZXJpYWwvYW1iYS1wbDAxMS5jCmlu
ZGV4IDNkYzliMGZjYWIxYy4uNzBiNDRmM2U5ZWI3IDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9z
ZXJpYWwvYW1iYS1wbDAxMS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9hbWJhLXBsMDExLmMK
QEAgLTI3MTYsMTggKzI3MTYsNiBAQCBzdGF0aWMgaW50IHBsMDExX2ZpbmRfZnJlZV9wb3J0KHZv
aWQpCiAJcmV0dXJuIC1FQlVTWTsKIH0KIAotc3RhdGljIGludCBwbDAxMV9nZXRfcnM0ODVfbW9k
ZShzdHJ1Y3QgdWFydF9hbWJhX3BvcnQgKnVhcCkKLXsKLQlzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0
ID0gJnVhcC0+cG9ydDsKLQlpbnQgcmV0OwotCi0JcmV0ID0gdWFydF9nZXRfcnM0ODVfbW9kZShw
b3J0KTsKLQlpZiAocmV0KQotCQlyZXR1cm4gcmV0OwotCi0JcmV0dXJuIDA7Ci19Ci0KIHN0YXRp
YyBpbnQgcGwwMTFfc2V0dXBfcG9ydChzdHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB1YXJ0X2Ft
YmFfcG9ydCAqdWFwLAogCQkJICAgIHN0cnVjdCByZXNvdXJjZSAqbW1pb2Jhc2UsIGludCBpbmRl
eCkKIHsKQEAgLTI3NDgsNyArMjczNiw3IEBAIHN0YXRpYyBpbnQgcGwwMTFfc2V0dXBfcG9ydChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHN0cnVjdCB1YXJ0X2FtYmFfcG9ydCAqdWFwLAogCXVhcC0+cG9y
dC5mbGFncyA9IFVQRl9CT09UX0FVVE9DT05GOwogCXVhcC0+cG9ydC5saW5lID0gaW5kZXg7CiAK
LQlyZXQgPSBwbDAxMV9nZXRfcnM0ODVfbW9kZSh1YXApOworCXJldCA9IHVhcnRfZ2V0X3JzNDg1
X21vZGUoJnVhcC0+cG9ydCk7CiAJaWYgKHJldCkKIAkJcmV0dXJuIHJldDsKIAotLSAKMi40MC4x
Cgo=
