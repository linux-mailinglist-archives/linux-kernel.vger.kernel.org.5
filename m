Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E097B283C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 00:14:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232626AbjI1WOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 18:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232527AbjI1WNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 18:13:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FE3D1A1;
        Thu, 28 Sep 2023 15:13:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695939214; x=1696544014; i=linosanfilippo@gmx.de;
 bh=m4weqzXnsQgnMts6TFaFYqbOaRUWzpTcPEjf6E+HoPM=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=O2K6GDBcsvy/X7k3qNvCuY6yHPhAHspkfoSpIamF6aP3/YSxuXb6rvD/AAePbgSvoGI5tOJSqXY
 IpHIdujPHZdGZ5S5pF4pG6zBlOf+rZcpMrzyGugN+b1QSHSIsMRbPKamFt2Xzjk5LWXaeYeFXO7Vl
 TL8QL04aV3NiQtKqIacdorilnWlCXDTz5jPNtPz2+VXufzhDl2EWzKklwyzwTlHqmVmT1QzyW8jlK
 YpkjfOGXvpJhBoB+S5D23WTqbEyf6dIIUxcdIxooHPZwVn3owJFsz+hYsXPyRg/DjTrwV2wcWz6FV
 R9ezsBBaQGlvjvnDiV6I4DqAat2TB7PrarDg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from Venus.speedport.ip ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MVvL5-1rAufz2U8D-00RrSh; Fri, 29
 Sep 2023 00:13:34 +0200
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        LinoSanfilippo@gmx.de, lukas@wunner.de, p.rosenberger@kunbus.com
Subject: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not supported
Date:   Fri, 29 Sep 2023 00:12:46 +0200
Message-Id: <20230928221246.13689-7-LinoSanfilippo@gmx.de>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Provags-ID: V03:K1:+P81Kmr4hyoqergClf8xEE8mnhWpYVoCtypzwglXZWjyGqQWYLH
 RQKuksnXluP2TFFn63tcKtyOy8tLk5h25mkqMuMACecbLZ/rnIOLR3pyzsfY+N/+ye2fuUr
 /umOamJl3sJpsfNyWime4++fMNirZ3gwGxenxVq1c4BpOUi40fBiAHlhMpZioQZGNpt15bB
 r/qBmq/LmoQCrbla6OjHw==
UI-OutboundReport: notjunk:1;M01:P0:SaxcjmS9I4U=;tOhBjxhnZQ7yIMQ44q84IDoko7I
 +6nOqPJefUEWR6mxq0+Ty2mlVmTeSscj5yL8lvJitdT+bw23I5tjS8Ff066yzD5TqNCH5MfxA
 MCLe/k2zmw9QLMRM49RZEYLutlLz1Hio6BPmmb79N/ToG7DjC6nq5w42twqAwpr1KSTmF83Rv
 AgW7W0m60pAKjDY4URiPB5FVuTEpNT5o59ej5f7+divlzQq8NPDR083xAvqdxBGpxpLByGlPq
 eEnLAP6c9RVP/xkKImXpfTr2un23yJoXskFBsv2sBCwgrkdD3x20ChAvmRE9IRVI4CDSB+IRq
 vVTpd9NcB0rbIbq/+Ezbca2DMrNfoHh1tkXUKYFoPKT9PLIeY1cYVWx7/yt46ETTlF9qYSq34
 4XQPdjqcsqNRGkC0Jva2murcKazTu9W92UGWpc6YutjcZ3DgSihzQ1UYqdnT4e2jnbdc7GQLq
 p36J3m8PcqpTHa26HmqjjD3c3PFfoIh8rhmDh/JiuJNEZOYXzhoX2gbELHwn6KuDB8jCvy/aV
 n7oPv4sMZYqoYcZ+keA3VCC7khwrmuja7voUpF5eo0ocA9rP4FLwEtwxGcotStxD/wyKTgeRA
 qbSMAp3xh3z+5DzO3VZT5ghVQOWRsfJ4uSMetn76wXkK1ZOChx2O41Iyt/Am751pFl1YkK85m
 XVlqaYthFaPe9xIeQfctlBY+AzbiXAmb/Fe2KIMmxYUIXxEiFNu5klZJZMV6xzLO6Ddh/noL7
 X1F/MzRQKcVec6S1tFrX2RNP+uYD8ypt6qGJdnAtipfu8ppGrxUK4WQKgIq4ZymroQzzI1Rwn
 OGFQfDavflKn2vd12dd1uD/ThLPTNLFtZ+ekkzID9rCik9laKWfUPvXtz1xUYvqBGlfAgdatj
 uTnJV20CDfx5MOugZYxknlDxSH3qNoKjypubfh7PaE4qVCSmuJDU9CeWdV17VAEDllccuYpno
 UYS4LPQtjjsvM72QBWS0jL/8+7k=
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RnJvbTogTGlubyBTYW5maWxpcHBvIDxsLnNhbmZpbGlwcG9Aa3VuYnVzLmNvbT4KCklmIHRoZSBp
bXggZHJpdmVyIGNhbm5vdCBzdXBwb3J0IFJTNDg1IGl0IHNldHMgdGhlIFVBUlRTIHJzNDg1X3N1
cHBvcnRlZApzdHJ1Y3R1cmUgdG8gTlVMTC4gQnV0IGl0IHN0aWxsIGNhbGxzIHVhcnRfZ2V0X3Jz
NDg1X21vZGUoKSB3aGljaCBtYXkgc2V0CnRoZSBSUzQ4NV9FTkFCTEVEIGZsYWcuClRoZSBmbGFn
IGhvd2V2ZXIgaXMgZXZhbHVhdGVkIGJ5IHRoZSBzZXJpYWwgY29yZSBpbiB1YXJ0X2NvbmZpZ3Vy
ZV9wb3J0KCkKYXQgcG9ydCBzdGFydHVwIGFuZCB0aHVzIG1heSBsZWFkIHRvIGFuIGF0dGVtcHQg
dG8gY29uZmlndXJlIFJTNDg1IGV2ZW4gaWYKaXQgaXMgbm90IHN1cHBvcnRlZC4KCkF2b2lkIHRo
aXMgYnkgY2FsbGluZyB1YXJ0X2dldF9yczQ4NV9tb2RlKCkgb25seSBpZiBSUzQ4NSBpcyBhY3R1
YWxseQpzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4gUmVtb3ZlIGFsc28gYSBjaGVjayBmb3IgYW4g
ZXJyb3IgY29uZGl0aW9uCnRoYXQgaXMgbm90IHBvc3NpYmxlIGFueSBtb3JlIG5vdy4KClNpZ25l
ZC1vZmYtYnk6IExpbm8gU2FuZmlsaXBwbyA8bC5zYW5maWxpcHBvQGt1bmJ1cy5jb20+Ci0tLQog
ZHJpdmVycy90dHkvc2VyaWFsL2lteC5jIHwgMTQgKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFu
Z2VkLCA2IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVy
cy90dHkvc2VyaWFsL2lteC5jIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCmluZGV4IGVkYjJl
YzZhNTU2Ny4uODc2ODlhYmMyMWJkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3R0eS9zZXJpYWwvaW14
LmMKKysrIGIvZHJpdmVycy90dHkvc2VyaWFsL2lteC5jCkBAIC0yMzI2LDE2ICsyMzI2LDE0IEBA
IHN0YXRpYyBpbnQgaW14X3VhcnRfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikK
IAkJcmV0dXJuIHJldDsKIAl9CiAKLQlyZXQgPSB1YXJ0X2dldF9yczQ4NV9tb2RlKCZzcG9ydC0+
cG9ydCk7Ci0JaWYgKHJldCkgewotCQljbGtfZGlzYWJsZV91bnByZXBhcmUoc3BvcnQtPmNsa19p
cGcpOwotCQlyZXR1cm4gcmV0OworCWlmIChzcG9ydC0+cG9ydC5yczQ4NV9zdXBwb3J0ZWQuZmxh
Z3MgJiBTRVJfUlM0ODVfRU5BQkxFRCkgeworCQlyZXQgPSB1YXJ0X2dldF9yczQ4NV9tb2RlKCZz
cG9ydC0+cG9ydCk7CisJCWlmIChyZXQpIHsKKwkJCWNsa19kaXNhYmxlX3VucHJlcGFyZShzcG9y
dC0+Y2xrX2lwZyk7CisJCQlyZXR1cm4gcmV0OworCQl9CiAJfQogCi0JaWYgKHNwb3J0LT5wb3J0
LnJzNDg1LmZsYWdzICYgU0VSX1JTNDg1X0VOQUJMRUQgJiYKLQkgICAgKCFzcG9ydC0+aGF2ZV9y
dHNjdHMgJiYgIXNwb3J0LT5oYXZlX3J0c2dwaW8pKQotCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJu
byBSVFMgY29udHJvbCwgZGlzYWJsaW5nIHJzNDg1XG4iKTsKLQogCS8qCiAJICogSWYgdXNpbmcg
dGhlIGkuTVggVUFSVCBSVFMvQ1RTIGNvbnRyb2wgdGhlbiB0aGUgUlRTIChDVFNfQikKIAkgKiBz
aWduYWwgY2Fubm90IGJlIHNldCBsb3cgZHVyaW5nIHRyYW5zbWlzc2lvbiBpbiBjYXNlIHRoZQot
LSAKMi40MC4xCgo=
