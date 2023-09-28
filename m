Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530457B2833
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232564AbjI1WNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjI1WNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A46BA199;
        Thu, 28 Sep 2023 15:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939213; x=1696544013; i=linosanfilippo@gmx.de;
 bh=D/HyYToAkt8HPU01PSU5AsEnPHKGV/ERmzj/d7KZ9N8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=ocXHYEMymDm8AwrYH/9hMJ23Uqf+T7qGBDjofO6MnC6jsyI9U5leiSguquC9l1kvTHib+tl0cdQ
 fQrXMxJHX760iyvo/3dTfAyHkL/As0TTLkct/wT0qB/IX0qVitgP/WPI0aoZEGFb5J2NundoDdnE3
 7n3pLfPgXCmeAzMqSO/7XykHQjHNVnZqbUu8Ec2r1cCZRMZXEIUtNAmD8Ag23loUyZBm8JhSPNKAA
 SMx3a7Co1HAwznwkRZaCAkJE2xvZEJJ57LySHnQLfV5G9eHFqmlr88Deh02T2mOmNVOt4hU+JhxSn
 qzf1GSMsoslAlTqyiK9+kLolOKsvjs+xcxAg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MnakR-1rSRUe28N3-00jWnv; Fri, 29
 Sep 2023 00:13:33 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
Subject: [PATCH 3/6] serial: core: set missing supported flag for RX during TX GPIO
Date:   Fri, 29 Sep 2023 00:12:43 +0200
Message-Id: <20230928221246.13689-4-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:QcDgxfI6XE1Vgtej5E7fXsbYloK1SIkv9Fyxhooz1MfNM3zpbJY
 dmIGkalvdLuwTRffnp5MXVpTGMjkrwAjqGhNtMIPWW3jfOVMgkUh53zJo5NqE3I7gBTMFU6
 0TEz6YrcUIRHEgU33k8I2vopmmvpX0nKH48r8xBZfn61yJmlOMnIe368suvkB7wImPQ6fkH
 rS5RpDyGpJ0JI7dmXuOcg==
UI-OutboundReport: notjunk:1;M01:P0:Hrdkk3es4BE=;05suxLYMnno4mb/EG0e3AmVxk8n
 XvAqZj/RZb+iEJQs80GZbmaXK/a/NPFV/3wWWSVFKqwC5TJwqb7a+jwXCAn4ncxlyUVmfjaNZ
 gXToS8rzVUatV48BOYEpPJF9vRz+1PCU8ytIwX3QA0JO+zyMwzRj9PR9Y5szHfsJsjQcI+uEh
 68FU12dVwiOdOfnSk2bKiXGLGxjFiO2IxJEbSK2AsRIWvBthT7xFXkET/86zF/nmOfaYbCGo/
 7asFxs+d64DBL6wYzKPxY629gQCeQgRx+07xrc5osq/WSWxRCUVX9S3DcgJZXVbjiJpDwXrgW
 r+ZbaORrrcuOog02YNd3XJa13GwMfiXesHh7qQngFkdtW9EAj2Pxc2C+yue8a1B3sJSHxfNmv
 rHqnpJpVdJcAir+dPGd0cPDeT6wpnnvrL9IK1/gbGvgqP/yb1aSYUbKM3FyeREsaZYIqTlR4m
 C2mLAkDlgzog1SeQIi5VKbJqpIBU+54wNB5Ab63pFGiRS8dGzdOxSXu6V4vt8+WRr0jYUrIOT
 mpw2DiKx+S0kxkVkfyjGoEQHRab8iBTZ7kCShrpGh0XR6EzAq7ptBjGJ9xD32DgxlhokdBUlp
 0TbTRZi+E2dXvyCTyPCt1ls0Jzi6F4ihS+QmdB4PSQUXYLb/7unndXGwgEvD+lkp/zDmlHzCC
 l9lNaGukPE5Zg129OqVyFXzJSgKcdPcpM9MvdoSJYxtg5K5ZzPVYqn0eQ1RepFxuJZfbwDwLr
 lyY8IZ6JMcQHzZ/IOjEZoeA/T1sAP8U0fbjLM9ynI6hDwUUKuGfkgQmKVm12qO9yBpiBUpCAO
 q7hleiy/OIokeQv2IQv1IpGw/BrJVDWl632tT4mkLIG6AY/ClJVyeqYjmgM/OdPCls2vYuUac
 KHV8bHclUpLGY1pcFKv6ZfDBA4ye5ylua1zVz12HpCoMs3ZuVqkKa6r4bv/4x+2MzT2hjEj+k
 lt0q/Q==
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCklmIHRoZSBS
UzQ4NSBmZWF0dXJlIFJYLWR1cmluZy1UWCBpcyBzdXBwb3J0ZWQgYnkgbWVhbnMgb2YgYSBHUElP
IHNldCB0aGUKYWNjb3JkaW5nIHN1cHBvcnRlZCBmbGFnLiBPdGhlcndpc2Ugc2V0dGluZyB0aGlz
IGZlYXR1cmUgZnJvbSB1c2Vyc3BhY2UgbWF5Cm5vdCBiZSBwb3NzaWJsZSwgc2luY2UgaW4gdWFy
dF9zYW5pdGl6ZV9zZXJpYWxfcnM0ODUoKSB0aGUgcGFzc2VkIFJTNDg1CmNvbmZpZ3VyYXRpb24g
aXMgbWF0Y2hlZCBhZ2FpbnN0IHRoZSBzdXBwb3J0ZWQgZmVhdHVyZXMgYW5kIHVuc3VwcG9ydGVk
CnNldHRpbmdzIGFyZSB0aGVyZWJ5IHJlbW92ZWQgYW5kIHRodXMgdGFrZSBubyBlZmZlY3QuCgpD
Yzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwpGaXhlczogMTYzZjA4MGViNzE3ICgic2VyaWFsOiBj
b3JlOiBBZGQgb3B0aW9uIHRvIG91dHB1dCBSUzQ4NSBSWF9EVVJJTkdfVFggc3RhdGUgdmlhIEdQ
SU8iKQpTaWduZWQtb2ZmLWJ5OiBMaW5vIFNhbmZpbGlwcG8gPGwuc2FuZmlsaXBwb0BrdW5idXMu
Y29tPgotLS0KIGRyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jIHwgMiArKwogMSBmaWxl
IGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jIGIvZHJpdmVycy90dHkvc2VyaWFsL3NlcmlhbF9jb3JlLmMKaW5kZXgg
ZWYwNTAwYmUzNTUzLi42OTdjMzZkYzdlYzggMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvdHR5L3Nlcmlh
bC9zZXJpYWxfY29yZS5jCisrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9zZXJpYWxfY29yZS5jCkBA
IC0zNjIyLDYgKzM2MjIsOCBAQCBpbnQgdWFydF9nZXRfcnM0ODVfbW9kZShzdHJ1Y3QgdWFydF9w
b3J0ICpwb3J0KQogCQlwb3J0LT5yczQ4NV9yeF9kdXJpbmdfdHhfZ3BpbyA9IE5VTEw7CiAJCXJl
dHVybiBkZXZfZXJyX3Byb2JlKGRldiwgcmV0LCAiQ2Fubm90IGdldCByczQ4NS1yeC1kdXJpbmct
dHgtZ3Bpb3NcbiIpOwogCX0KKwlpZiAocG9ydC0+cnM0ODVfcnhfZHVyaW5nX3R4X2dwaW8pCisJ
CXBvcnQtPnJzNDg1X3N1cHBvcnRlZC5mbGFncyB8PSBTRVJfUlM0ODVfUlhfRFVSSU5HX1RYOwog
CiAJcmV0dXJuIDA7CiB9Ci0tIAoyLjQwLjEKCg==
