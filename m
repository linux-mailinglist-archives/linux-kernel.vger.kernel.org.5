Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A154769D07
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbjGaQnl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:43:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjGaQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 204781729
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690821769;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3MJb09xP7TBuBVjm7iqv4BZk2hin/3r222HONq3g2yE=;
        b=c6kUf0jFoXz2ODAdmcCBxj1q8pLKk9FtuzaP9Ph48g0o8qf0jgjYjJ7UxgeVvzTFoW2e8k
        9bMoltgASE1b0dTkOepIQMtWo5R0hQmPiz/vtKBJ1Ml0x9637uMu8OZbdszW1yxSwgTNfr
        gRZ16oElXMw2mvt4o/5pneLcyn8eUyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-Z29rPmlVM0CuL2evo7T0mg-1; Mon, 31 Jul 2023 12:42:46 -0400
X-MC-Unique: Z29rPmlVM0CuL2evo7T0mg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6BD9F858EED;
        Mon, 31 Jul 2023 16:42:45 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0F555401061;
        Mon, 31 Jul 2023 16:42:43 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     linux-kernel@vger.kernel.org, lersek@redhat.com
Cc:     Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 1/2] net: tun_chr_open(): set sk_uid from current_fsuid()
Date:   Mon, 31 Jul 2023 18:42:36 +0200
Message-Id: <20230731164237.48365-2-lersek@redhat.com>
In-Reply-To: <20230731164237.48365-1-lersek@redhat.com>
References: <20230731164237.48365-1-lersek@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MIME_BASE64_TEXT,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Q29tbWl0IGEwOTZjY2NhNmU1MCBpbml0aWFsaXplcyB0aGUgInNrX3VpZCIgZmllbGQgaW4gdGhl
IHByb3RvY29sIHNvY2tldAooc3RydWN0IHNvY2spIGZyb20gdGhlICIvZGV2L25ldC90dW4iIGRl
dmljZSBub2RlJ3Mgb3duZXIgVUlELiBQZXIKb3JpZ2luYWwgY29tbWl0IDg2NzQxZWMyNTQ2MiAo
Im5ldDogY29yZTogQWRkIGEgVUlEIGZpZWxkIHRvIHN0cnVjdApzb2NrLiIsIDIwMTYtMTEtMDQp
LCB0aGF0J3Mgd3Jvbmc6IHRoZSBpZGVhIGlzIHRvIGNhY2hlIHRoZSBVSUQgb2YgdGhlCnVzZXJz
cGFjZSBwcm9jZXNzIHRoYXQgY3JlYXRlcyB0aGUgc29ja2V0LiBDb21taXQgODY3NDFlYzI1NDYy
IG1lbnRpb25zCnNvY2tldCgpIGFuZCBhY2NlcHQoKTsgd2l0aCAidHVuIiwgdGhlIGFjdGlvbiB0
aGF0IGNyZWF0ZXMgdGhlIHNvY2tldCBpcwpvcGVuKCIvZGV2L25ldC90dW4iKS4KClRoZXJlZm9y
ZSB0aGUgZGV2aWNlIG5vZGUncyBvd25lciBVSUQgaXMgaXJyZWxldmFudC4gSW4gbW9zdCBjYXNl
cywKIi9kZXYvbmV0L3R1biIgd2lsbCBiZSBvd25lZCBieSByb290LCBzbyBpbiBwcmFjdGljZSwg
Y29tbWl0IGEwOTZjY2NhNmU1MApoYXMgbm8gb2JzZXJ2YWJsZSBlZmZlY3Q6CgotIGJlZm9yZSwg
InNrX3VpZCIgd291bGQgYmUgemVybywgZHVlIHRvIHVuZGVmaW5lZCBiZWhhdmlvcgogIChDVkUt
MjAyMy0xMDc2KSwKCi0gYWZ0ZXIsICJza191aWQiIHdvdWxkIGJlIHplcm8sIGR1ZSB0byAiL2Rl
di9uZXQvdHVuIiBiZWluZyBvd25lZCBieSByb290LgoKV2hhdCBtYXR0ZXJzIGlzIHRoZSAoZnMp
VUlEIG9mIHRoZSBwcm9jZXNzIHBlcmZvcm1pbmcgdGhlIG9wZW4oKSwgc28gY2FjaGUKdGhhdCBp
biAic2tfdWlkIi4KCkNjOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+CkNjOiBM
b3JlbnpvIENvbGl0dGkgPGxvcmVuem9AZ29vZ2xlLmNvbT4KQ2M6IFBhb2xvIEFiZW5pIDxwYWJl
bmlAcmVkaGF0LmNvbT4KQ2M6IFBpZXRybyBCb3JyZWxsbyA8Ym9ycmVsbG9AZGlhZy51bmlyb21h
MS5pdD4KQ2M6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKRml4ZXM6IGEwOTZjY2NhNmU1MCAoInR1bjogdHVuX2Nocl9vcGVuKCk6IGNvcnJlY3RseSBp
bml0aWFsaXplIHNvY2tldCB1aWQiKQpCdWd6aWxsYTogaHR0cHM6Ly9idWd6aWxsYS5yZWRoYXQu
Y29tL3Nob3dfYnVnLmNnaT9pZD0yMTczNDM1ClNpZ25lZC1vZmYtYnk6IExhc3psbyBFcnNlayA8
bGVyc2VrQHJlZGhhdC5jb20+Ci0tLQogZHJpdmVycy9uZXQvdHVuLmMgfCAyICstCiAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC90dW4uYyBiL2RyaXZlcnMvbmV0L3R1bi5jCmluZGV4IGQ3NTQ1NmFkYzYyYS4uMjVm
MDE5MWRmMDBiIDEwMDY0NAotLS0gYS9kcml2ZXJzL25ldC90dW4uYworKysgYi9kcml2ZXJzL25l
dC90dW4uYwpAQCAtMzQ2OSw3ICszNDY5LDcgQEAgc3RhdGljIGludCB0dW5fY2hyX29wZW4oc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGZpbGUgKiBmaWxlKQogCXRmaWxlLT5zb2NrZXQuZmls
ZSA9IGZpbGU7CiAJdGZpbGUtPnNvY2tldC5vcHMgPSAmdHVuX3NvY2tldF9vcHM7CiAKLQlzb2Nr
X2luaXRfZGF0YV91aWQoJnRmaWxlLT5zb2NrZXQsICZ0ZmlsZS0+c2ssIGlub2RlLT5pX3VpZCk7
CisJc29ja19pbml0X2RhdGFfdWlkKCZ0ZmlsZS0+c29ja2V0LCAmdGZpbGUtPnNrLCBjdXJyZW50
X2ZzdWlkKCkpOwogCiAJdGZpbGUtPnNrLnNrX3dyaXRlX3NwYWNlID0gdHVuX3NvY2tfd3JpdGVf
c3BhY2U7CiAJdGZpbGUtPnNrLnNrX3NuZGJ1ZiA9IElOVF9NQVg7Cgo=

