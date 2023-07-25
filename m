Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC165761D8D
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:42:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbjGYPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjGYPl6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:41:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 556C71FD2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690299673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ywc41/BPTk/JOAzpj2Ndsq/haHQiohuM6GBycryh5is=;
        b=emCsZIr6jKqZ7vlyZ45ONeGyycQJM+RgbU+DjUId2IW5s96A6Yxu3yxi8wJYk/0a8xuCso
        OiMtvCYPuRz5CVxqbVphHMnB+9/QrNPG5kusnNLuY5VbqqlV2yKNhiQfdW7tNbTFKmw3z3
        GUjQ9julY7wuWF4A3CleEWJy+Vb6qwQ=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-58NY2JxlP1-MVUVlCLPmgA-1; Tue, 25 Jul 2023 11:41:12 -0400
X-MC-Unique: 58NY2JxlP1-MVUVlCLPmgA-1
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-4053a03d5b2so73824461cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:41:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690299672; x=1690904472;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ywc41/BPTk/JOAzpj2Ndsq/haHQiohuM6GBycryh5is=;
        b=fpxTHYr2PpsnML/R/Y+jU+MV3iHAiJlUX5qUGZdCco8gDXHlB2VVfELGzFT0Rxmf3d
         7gdZCLEbyTLghYs7VnBWLtwUpINBa1W1fnUD0Hj6Uyh1nO6Mhy0cbGX2f0PxZqe6vtWb
         oG49IQyRTHeJL+gW+E7YRvDvK2FEBCBpKG9f9xhZv0FMtM9FsF8Q3e/uWh2SY0ImrqwW
         V0TbpevEvaoqXxYafkvPbgRJ2KKffzbMxP6fkS+VepYdpXh5/fXdzn0lvJ0hiMGahjLV
         SA2DffqeuVRXkzY0o0kE0U6lHAXlA41FqrQhhsxuG/PYgnGvpzaWpCiZuhWeLGQLqxO6
         KibA==
X-Gm-Message-State: ABy/qLYr1ik5ESd5EPjws3ozKLDv2PtDe1vT32rl1/tCj8agIOkK3O8f
        I4ZrmFuZaru/vG4ivpb/9Z82d12JdXMouT1qxaccyuXwK7pmjn276Go057KwHMi029G9rFoo1/G
        8DEnChNae+t6RJa2Y3YTwZlP2
X-Received: by 2002:ac8:5f0c:0:b0:405:47aa:742f with SMTP id x12-20020ac85f0c000000b0040547aa742fmr3527173qta.32.1690299671817;
        Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHA1b4My1rtvlYJYA1W4nzseTpuRek/vvdBo/xbpSdUcXuiki19nX3FPgKAFwQK2ije6YiWNA==
X-Received: by 2002:ac8:5f0c:0:b0:405:47aa:742f with SMTP id x12-20020ac85f0c000000b0040547aa742fmr3527157qta.32.1690299671554;
        Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.153.113])
        by smtp.gmail.com with ESMTPSA id g1-20020ac870c1000000b00404f8e9902dsm4132859qtp.2.2023.07.25.08.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jul 2023 08:41:11 -0700 (PDT)
Date:   Tue, 25 Jul 2023 17:41:05 +0200
From:   Stefano Garzarella <sgarzare@redhat.com>
To:     Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Cc:     Stefan Hajnoczi <stefanha@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>,
        kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@sberdevices.ru, oxffffaa@gmail.com
Subject: Re: [RFC PATCH v2 4/4] vsock/test: MSG_PEEK test for SOCK_SEQPACKET
Message-ID: <lkfzuvv53lyycpun27knppjhk46lyqrz4idvzj7fzer2566y5t@mtc7v33q3erg>
References: <20230719192708.1775162-1-AVKrasnov@sberdevices.ru>
 <20230719192708.1775162-5-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20230719192708.1775162-5-AVKrasnov@sberdevices.ru>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 10:27:08PM +0300, Arseniy Krasnov wrote:
>This adds MSG_PEEK test for SOCK_SEQPACKET. It works in the same way as
>SOCK_STREAM test, except it also tests MSG_TRUNC flag.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> tools/testing/vsock/vsock_test.c | 58 +++++++++++++++++++++++++++++---
> 1 file changed, 54 insertions(+), 4 deletions(-)
>
>diff --git a/tools/testing/vsock/vsock_test.c b/tools/testing/vsock/vsock_test.c
>index 444a3ff0681f..2ca2cbfa9808 100644
>--- a/tools/testing/vsock/vsock_test.c
>+++ b/tools/testing/vsock/vsock_test.c
>@@ -257,14 +257,19 @@ static void test_stream_multiconn_server(const struct test_opts *opts)
>
> #define MSG_PEEK_BUF_LEN 64
>
>-static void test_stream_msg_peek_client(const struct test_opts *opts)
>+static void __test_msg_peek_client(const struct test_opts *opts,

Let's stay with just test_msg_peek_client(), WDYT?

>+				   bool seqpacket)
> {
> 	unsigned char buf[MSG_PEEK_BUF_LEN];
> 	ssize_t send_size;
> 	int fd;
> 	int i;
>
>-	fd = vsock_stream_connect(opts->peer_cid, 1234);
>+	if (seqpacket)
>+		fd = vsock_seqpacket_connect(opts->peer_cid, 1234);
>+	else
>+		fd = vsock_stream_connect(opts->peer_cid, 1234);
>+
> 	if (fd < 0) {
> 		perror("connect");
> 		exit(EXIT_FAILURE);
>@@ -290,7 +295,8 @@ static void test_stream_msg_peek_client(const struct test_opts *opts)
> 	close(fd);
> }
>
>-static void test_stream_msg_peek_server(const struct test_opts *opts)
>+static void __test_msg_peek_server(const struct test_opts *opts,

Same here.

The rest LGTM!

Also the whole series should be ready for net-next, right?

Stefano

