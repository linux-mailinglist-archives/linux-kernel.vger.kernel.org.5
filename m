Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824B0769D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjGaQnw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:43:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233296AbjGaQno (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:43:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122C6A6
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690821771;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hIrzg23zm5bnaFzI5icqMbN8fi6qCvhn7sNqGYL6Vo0=;
        b=VCSaIEAu0vtP6AfgExRVWoD8NAAQqr2ZAnjkkFAEoq8jgtNmC0mykyw4VcHB4hlG2i1yBc
        WxxXAdbas7uWV6bNgyKAcWoFqAjyS8X7UVpHFUJUrZ2EfZ+uCXDlphNjMx6C394daUJKIu
        reX3FF8ZAvaXMuVkjgkLCx9KRXzMvGE=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-281-qnMNdh9GOoaMfomT5lE-dQ-1; Mon, 31 Jul 2023 12:42:48 -0400
X-MC-Unique: qnMNdh9GOoaMfomT5lE-dQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1450638210A0;
        Mon, 31 Jul 2023 16:42:47 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ABAD9401DA9;
        Mon, 31 Jul 2023 16:42:45 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     linux-kernel@vger.kernel.org, lersek@redhat.com
Cc:     Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 2/2] net: tap_open(): set sk_uid from current_fsuid()
Date:   Mon, 31 Jul 2023 18:42:37 +0200
Message-Id: <20230731164237.48365-3-lersek@redhat.com>
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

Q29tbWl0IDY2YjJjMzM4YWRjZSBpbml0aWFsaXplcyB0aGUgInNrX3VpZCIgZmllbGQgaW4gdGhl
IHByb3RvY29sIHNvY2tldAooc3RydWN0IHNvY2spIGZyb20gdGhlICIvZGV2L3RhcFgiIGRldmlj
ZSBub2RlJ3Mgb3duZXIgVUlELiBQZXIgb3JpZ2luYWwKY29tbWl0IDg2NzQxZWMyNTQ2MiAoIm5l
dDogY29yZTogQWRkIGEgVUlEIGZpZWxkIHRvIHN0cnVjdCBzb2NrLiIsCjIwMTYtMTEtMDQpLCB0
aGF0J3Mgd3Jvbmc6IHRoZSBpZGVhIGlzIHRvIGNhY2hlIHRoZSBVSUQgb2YgdGhlIHVzZXJzcGFj
ZQpwcm9jZXNzIHRoYXQgY3JlYXRlcyB0aGUgc29ja2V0LiBDb21taXQgODY3NDFlYzI1NDYyIG1l
bnRpb25zIHNvY2tldCgpIGFuZAphY2NlcHQoKTsgd2l0aCAidGFwIiwgdGhlIGFjdGlvbiB0aGF0
IGNyZWF0ZXMgdGhlIHNvY2tldCBpcwpvcGVuKCIvZGV2L3RhcFgiKS4KClRoZXJlZm9yZSB0aGUg
ZGV2aWNlIG5vZGUncyBvd25lciBVSUQgaXMgaXJyZWxldmFudC4gSW4gbW9zdCBjYXNlcywKIi9k
ZXYvdGFwWCIgd2lsbCBiZSBvd25lZCBieSByb290LCBzbyBpbiBwcmFjdGljZSwgY29tbWl0IDY2
YjJjMzM4YWRjZSBoYXMKbm8gb2JzZXJ2YWJsZSBlZmZlY3Q6CgotIGJlZm9yZSwgInNrX3VpZCIg
d291bGQgYmUgemVybywgZHVlIHRvIHVuZGVmaW5lZCBiZWhhdmlvcgogIChDVkUtMjAyMy0xMDc2
KSwKCi0gYWZ0ZXIsICJza191aWQiIHdvdWxkIGJlIHplcm8sIGR1ZSB0byAiL2Rldi90YXBYIiBi
ZWluZyBvd25lZCBieSByb290LgoKV2hhdCBtYXR0ZXJzIGlzIHRoZSAoZnMpVUlEIG9mIHRoZSBw
cm9jZXNzIHBlcmZvcm1pbmcgdGhlIG9wZW4oKSwgc28gY2FjaGUKdGhhdCBpbiAic2tfdWlkIi4K
CkNjOiBFcmljIER1bWF6ZXQgPGVkdW1hemV0QGdvb2dsZS5jb20+CkNjOiBMb3JlbnpvIENvbGl0
dGkgPGxvcmVuem9AZ29vZ2xlLmNvbT4KQ2M6IFBhb2xvIEFiZW5pIDxwYWJlbmlAcmVkaGF0LmNv
bT4KQ2M6IFBpZXRybyBCb3JyZWxsbyA8Ym9ycmVsbG9AZGlhZy51bmlyb21hMS5pdD4KQ2M6IG5l
dGRldkB2Z2VyLmtlcm5lbC5vcmcKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKRml4ZXM6IDY2
YjJjMzM4YWRjZSAoInRhcDogdGFwX29wZW4oKTogY29ycmVjdGx5IGluaXRpYWxpemUgc29ja2V0
IHVpZCIpCkJ1Z3ppbGxhOiBodHRwczovL2J1Z3ppbGxhLnJlZGhhdC5jb20vc2hvd19idWcuY2dp
P2lkPTIxNzM0MzUKU2lnbmVkLW9mZi1ieTogTGFzemxvIEVyc2VrIDxsZXJzZWtAcmVkaGF0LmNv
bT4KLS0tCiBkcml2ZXJzL25ldC90YXAuYyB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3RhcC5jIGIv
ZHJpdmVycy9uZXQvdGFwLmMKaW5kZXggOTEzN2ZiOGMxYzQyLi40OWQxZDZhY2Y5NWUgMTAwNjQ0
Ci0tLSBhL2RyaXZlcnMvbmV0L3RhcC5jCisrKyBiL2RyaXZlcnMvbmV0L3RhcC5jCkBAIC01MzQs
NyArNTM0LDcgQEAgc3RhdGljIGludCB0YXBfb3BlbihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1
Y3QgZmlsZSAqZmlsZSkKIAlxLT5zb2NrLnN0YXRlID0gU1NfQ09OTkVDVEVEOwogCXEtPnNvY2su
ZmlsZSA9IGZpbGU7CiAJcS0+c29jay5vcHMgPSAmdGFwX3NvY2tldF9vcHM7Ci0Jc29ja19pbml0
X2RhdGFfdWlkKCZxLT5zb2NrLCAmcS0+c2ssIGlub2RlLT5pX3VpZCk7CisJc29ja19pbml0X2Rh
dGFfdWlkKCZxLT5zb2NrLCAmcS0+c2ssIGN1cnJlbnRfZnN1aWQoKSk7CiAJcS0+c2suc2tfd3Jp
dGVfc3BhY2UgPSB0YXBfc29ja193cml0ZV9zcGFjZTsKIAlxLT5zay5za19kZXN0cnVjdCA9IHRh
cF9zb2NrX2Rlc3RydWN0OwogCXEtPmZsYWdzID0gSUZGX1ZORVRfSERSIHwgSUZGX05PX1BJIHwg
SUZGX1RBUDsK

