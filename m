Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A42F7D38CF
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 16:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjJWODx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 10:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjJWODv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 10:03:51 -0400
Received: from us-smtp-delivery-44.mimecast.com (unknown [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6030ECC
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 07:03:49 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-447-orEJjE89OeeGCSgho3wybg-1; Mon,
 23 Oct 2023 10:03:28 -0400
X-MC-Unique: orEJjE89OeeGCSgho3wybg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 59E171C11703;
        Mon, 23 Oct 2023 14:03:14 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01E23111D784;
        Mon, 23 Oct 2023 14:03:12 +0000 (UTC)
Date:   Mon, 23 Oct 2023 16:03:11 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Hangyu Hua <hbh25y@gmail.com>
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <ZTZ9H4aDB45RzrFD@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231023080611.19244-1-hbh25y@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_VALIDITY_RPBL,RDNS_NONE,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-23, 16:06:11 +0800, Hangyu Hua wrote:
> tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
> with msg being NULL. This may lead to null pointer dereferences in
> tls_decrypt_device and tls_decrypt_sw.
> 
> Fix this by adding a check.

Have you actually hit this NULL dereference? I don't see how it can
happen.

darg->zc is 0 in both cases, so tls_decrypt_device doesn't call
skb_copy_datagram_msg.

tls_decrypt_sw will call tls_decrypt_sg with out_iov = &msg->msg_iter
(a bogus pointer but no NULL deref yet), and darg->zc is still
0. tls_decrypt_sg skips the use of out_iov/out_sg and allocates
clear_skb, and the next place where it would use out_iov is skipped
because we have clear_skb.

Relevant parts of tls_decrypt_sg:

static int tls_decrypt_sg(struct sock *sk, struct iov_iter *out_iov,
			  struct scatterlist *out_sg,
			  struct tls_decrypt_arg *darg)
{
[...]
	if (darg->zc && (out_iov || out_sg)) {
		clear_skb = NULL;
[...]
	} else {
		darg->zc = false;

		clear_skb = tls_alloc_clrtxt_skb(sk, skb, rxm->full_len);
[...]
	}

[...]
	if (err < 0)
		goto exit_free;

	if (clear_skb) {
		sg_init_table(sgout, n_sgout);
		sg_set_buf(&sgout[0], dctx->aad, prot->aad_size);

		err = skb_to_sgvec(clear_skb, &sgout[1], prot->prepend_size,
				   data_len + prot->tail_size);
		if (err < 0)
			goto exit_free;
	} else if (out_iov) {
[...]
	} else if (out_sg) {
		memcpy(sgout, out_sg, n_sgout * sizeof(*sgout));
	}
[...]
}

-- 
Sabrina

