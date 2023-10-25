Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95CEA7D7686
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 23:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbjJYVUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 17:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230306AbjJYVUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 17:20:50 -0400
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C737C133
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 14:20:46 -0700 (PDT)
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-w4m3W4JtM1qeNA1RPUeHUg-1; Wed, 25 Oct 2023 17:20:26 -0400
X-MC-Unique: w4m3W4JtM1qeNA1RPUeHUg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 277A7857CF6;
        Wed, 25 Oct 2023 21:20:26 +0000 (UTC)
Received: from hog (unknown [10.39.192.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D12321121314;
        Wed, 25 Oct 2023 21:20:24 +0000 (UTC)
Date:   Wed, 25 Oct 2023 23:20:23 +0200
From:   Sabrina Dubroca <sd@queasysnail.net>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Hangyu Hua <hbh25y@gmail.com>, borisp@nvidia.com,
        john.fastabend@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: tls: Fix possible NULL-pointer dereference in
 tls_decrypt_device() and tls_decrypt_sw()
Message-ID: <ZTmGl1BFr0NQtJRn@hog>
References: <20231023080611.19244-1-hbh25y@gmail.com>
 <ZTZ9H4aDB45RzrFD@hog>
 <120e6c2c-6122-41db-8c46-7753e9659c70@gmail.com>
 <ZTjteQgXWKXDqnos@hog>
 <20231025071408.3b33f733@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231025071408.3b33f733@kernel.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2023-10-25, 07:14:08 -0700, Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 12:27:05 +0200 Sabrina Dubroca wrote:
> > > My bad. I only checked &msg->msg_iter's address in tls_decrypt_sw and found
> > > it was wrong. Do I need to make a new patch to fix the harmless bogus
> > > pointer?  
> > 
> > I don't think that's necessary, but maybe it would avoid people trying
> > to "fix" this code in the future. Jakub, WDYT?
> 
> No strong feelings, but personally I find checks for conditions which
> cannot happen decrease the readability. Maybe a comment is better?

There's already a comment above tls_decrypt_sg that (pretty much) says
out_iov is only used in zero-copy mode.

 *          [...]            The input parameter 'darg->zc' indicates if
 * zero-copy mode needs to be tried or not. With zero-copy mode, either
 * out_iov or out_sg must be non-NULL.

Do we need another just above the call to tls_decrypt_sg?

-- 
Sabrina

