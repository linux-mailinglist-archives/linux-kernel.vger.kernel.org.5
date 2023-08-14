Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D4177B419
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 10:28:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233407AbjHNI1u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 04:27:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234858AbjHNI1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 04:27:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F023B10E5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 01:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692001616;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H33gECP+9hXyb+EizpAzFVTxGWbGL8MsN4gYGXEf7/Q=;
        b=e5Gr7WEqkkcrXmpJVIoBZSIQVlQxsu55442TUa0JG5sVp+9tlWkqxT25W+sOUy1T8A6fEX
        1DALNjAb8vmkcNMa/7DHX+3zWmJ943/h5EZoc3mGDmzDgpXF1W2gQ4Jqm2X23jEivFcbmt
        P+uU1m4472geyCYJbhOJPRoo+UNu5LA=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-478-UZ9e3W2COM-03RqOQaRmKA-1; Mon, 14 Aug 2023 04:26:52 -0400
X-MC-Unique: UZ9e3W2COM-03RqOQaRmKA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 174012A59575;
        Mon, 14 Aug 2023 08:26:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.13])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C4FB41121315;
        Mon, 14 Aug 2023 08:26:50 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230813122344.14142-1-paskripkin@gmail.com>
References: <20230813122344.14142-1-paskripkin@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     dhowells@redhat.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, pabeni@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzbot+cba21d50095623218389@syzkaller.appspotmail.com
Subject: Re: [PATCH] crypto: fix uninit-value in af_alg_free_resources
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3954479.1692001609.1@warthog.procyon.org.uk>
Date:   Mon, 14 Aug 2023 09:26:49 +0100
Message-ID: <3954480.1692001609@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Skripkin <paskripkin@gmail.com> wrote:

> Syzbot was able to trigger use of uninitialized memory in
> af_alg_free_resources.
> 
> Bug is caused by missing initialization of rsgl->sgl.need_unpin before
> adding to rsgl_list. Then in case of extract_iter_to_sg() failure, rsgl
> is left with uninitialized need_unpin which is read during clean up

Looks feasible :-).

> +		rsgl->sgl.need_unpin = 0;
> +

The blank line isn't really necessary and it's a bool, so can you use 'false'
rather than '0'?

Alternatively, it might be better to move:

		rsgl->sgl.need_unpin =
			iov_iter_extract_will_pin(&msg->msg_iter);

up instead.

David

