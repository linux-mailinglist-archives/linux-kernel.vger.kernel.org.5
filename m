Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 506FB769D08
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:43:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233204AbjGaQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjGaQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:43:39 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E7E41725
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690821768;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ixI4MQwQdtAD2JkXFfqXO58v2WbfQeqVX+hHpJApB/M=;
        b=R0IMkVUCNMwAXeoZMJdoREGUOYKpQJ00uRQ+X+KnQlB7RwHPZGZQUVu2QpQ4zhxBVO6lLq
        6CabBCmpAA+EVZcLzNDKp42WRONY3qe0LGWdtluXrhlD8Ushiq6OrWtSvwtp5EiP2u1Og4
        ht1FWzj2wRMWj3x0k8YChSWoOJ6oONg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-371-fMG9J2jaPsK_T0MQC5_nAw-1; Mon, 31 Jul 2023 12:42:44 -0400
X-MC-Unique: fMG9J2jaPsK_T0MQC5_nAw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C36B2856F67;
        Mon, 31 Jul 2023 16:42:43 +0000 (UTC)
Received: from lacos-laptop-9.usersys.redhat.com (unknown [10.39.192.146])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4147401DA9;
        Mon, 31 Jul 2023 16:42:39 +0000 (UTC)
From:   Laszlo Ersek <lersek@redhat.com>
To:     linux-kernel@vger.kernel.org, lersek@redhat.com
Cc:     Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH 0/2] tun/tap: set sk_uid from current_fsuid()
Date:   Mon, 31 Jul 2023 18:42:35 +0200
Message-Id: <20230731164237.48365-1-lersek@redhat.com>
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

VGhlIG9yaWdpbmFsIHBhdGNoZXMgZml4aW5nIENWRS0yMDIzLTEwNzYgYXJlIGluY29ycmVjdCBp
biBteSBvcGluaW9uLgpUaGlzIHNtYWxsIHNlcmllcyBmaXhlcyB0aGVtIHVwOyBzZWUgdGhlIGlu
ZGl2aWR1YWwgY29tbWl0IG1lc3NhZ2VzIGZvcgpleHBsYW5hdGlvbi4KCkkgaGF2ZSBhIHZlcnkg
ZWxhYm9yYXRlIHRlc3QgcHJvY2VkdXJlIGRlbW9uc3RyYXRpbmcgdGhlIHByb2JsZW0gZm9yCmJv
dGggdHVuIGFuZCB0YXA7IGl0IGludm9sdmVzIGxpYnZpcnQsIHFlbXUsIGFuZCAiY3Jhc2giLiBJ
IGNhbiBzaGFyZQp0aGF0IHByb2NlZHVyZSBpZiBuZWNlc3NhcnksIGJ1dCBpdCdzIGluZGVlZCBx
dWl0ZSBsb25nIChJIHdyb3RlIGl0Cm9yaWdpbmFsbHkgZm9yIG91ciBRRSB0ZWFtKS4KClRoZSBw
YXRjaGVzIGluIHRoaXMgc2VyaWVzIGFyZSBzdXBwb3NlZCB0byAicmUtZml4IiBDVkUtMjAyMy0x
MDc2OyBnaXZlbgp0aGF0IHNhaWQgQ1ZFIGlzIGNsYXNzaWZpZWQgYXMgTG93IEltcGFjdCAoQ1ZT
U3YzPTUuNSksIEknbSBwb3N0aW5nIHRoaXMKcHVibGljbHksIGFuZCBub3Qgc3VnZ2VzdGluZyBh
bnkgZW1iYXJnby4gUmVkIEhhdCBQcm9kdWN0IFNlY3VyaXR5IG1heQphc3NpZ24gYSBuZXcgQ1ZF
IG51bWJlciBsYXRlci4KCkkndmUgdGVzdGVkIHRoZSBwYXRjaGVzIG9uIHRvcCBvZiB2Ni41LXJj
NCwgd2l0aCAiY3Jhc2giIGJ1aWx0IGF0IGNvbW1pdApjNzRmMzc1ZTBlZjcuCgpDYzogRXJpYyBE
dW1hemV0IDxlZHVtYXpldEBnb29nbGUuY29tPgpDYzogTG9yZW56byBDb2xpdHRpIDxsb3Jlbnpv
QGdvb2dsZS5jb20+CkNjOiBQYW9sbyBBYmVuaSA8cGFiZW5pQHJlZGhhdC5jb20+CkNjOiBQaWV0
cm8gQm9ycmVsbG8gPGJvcnJlbGxvQGRpYWcudW5pcm9tYTEuaXQ+CkNjOiBuZXRkZXZAdmdlci5r
ZXJuZWwub3JnCkNjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCgpMYXN6bG8gRXJzZWsgKDIpOgog
IG5ldDogdHVuX2Nocl9vcGVuKCk6IHNldCBza191aWQgZnJvbSBjdXJyZW50X2ZzdWlkKCkKICBu
ZXQ6IHRhcF9vcGVuKCk6IHNldCBza191aWQgZnJvbSBjdXJyZW50X2ZzdWlkKCkKCiBkcml2ZXJz
L25ldC90YXAuYyB8IDIgKy0KIGRyaXZlcnMvbmV0L3R1bi5jIHwgMiArLQogMiBmaWxlcyBjaGFu
Z2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgoKYmFzZS1jb21taXQ6IDVkMGMy
MzBmMWRlOGM3NTE1YjY1NjdkOWFmYmExZjE5NmZiNGUyZjQK

