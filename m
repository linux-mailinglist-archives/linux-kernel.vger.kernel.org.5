Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B402C7D6871
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 12:28:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234359AbjJYK2O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 06:28:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234404AbjJYK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 06:27:17 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EEE2BB
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 03:27:15 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-B-UoJyzDOqqdZRdFYbzjxw-1; Wed, 25 Oct 2023 06:27:09 -0400
X-MC-Unique: B-UoJyzDOqqdZRdFYbzjxw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5D925891F2F;
        Wed, 25 Oct 2023 10:27:08 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1780A25C0;
        Wed, 25 Oct 2023 10:27:06 +0000 (UTC)
Date:   Wed, 25 Oct 2023 12:27:05 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Hangyu Hua <hbh25y@gmail.com>, kuba@kernel.org
Cc:     borisp@nvidia.com, john.fastabend@gmail.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <ZTjteQgXWKXDqnos@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
 <ZTZ9H4aDB45RzrFD@hog>
 <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-24, 10:17:08 +0800, Hangyu Hua wrote:
> On 23/10/2023 22:03, Sabrina Dubroca wrote:
> > 2023-10-23, 16:06:11 +0800, Hangyu Hua wrote:
> > > tls_rx_one_record can be called in tls_sw_splice_read and tls_sw_read_sock
> > > with msg being NULL. This may lead to null pointer dereferences in
> > > tls_decrypt_device and tls_decrypt_sw.
> > > 
> > > Fix this by adding a check.
> > 
> > Have you actually hit this NULL dereference? I don't see how it can
> > happen.
> > 
> > darg->zc is 0 in both cases, so tls_decrypt_device doesn't call
> > skb_copy_datagram_msg.
> > 
> > tls_decrypt_sw will call tls_decrypt_sg with out_iov = &msg->msg_iter
> > (a bogus pointer but no NULL deref yet), and darg->zc is still
> > 0. tls_decrypt_sg skips the use of out_iov/out_sg and allocates
> > clear_skb, and the next place where it would use out_iov is skipped
> > because we have clear_skb.
> 
> My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and found
> it was wrong. Do I need to make a new patch to fix the harmless bogus
> pointer?

I don't think that's necessary, but maybe it would avoid people trying
to "fix" this code in the future. Jakub, WDYT?

-- 
Sabrina

