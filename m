Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 705A67B05B2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 15:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231961AbjI0NqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 09:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjI0NqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 09:46:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7006511D
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 06:45:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695822333;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QFbm4vEtEQ22He33Pyk3ovolVD+5Yr+BAJRVhAsXwOs=;
        b=XuWYDYvnsgt1wUgcpLERqZVMkltxvBhKD9Zt99Rkt5FCltKmWixdLpyD/41bc+hcco/SC6
        KwAW+cM/mq8OkfEfF0yXA7UVXGKEaIWg1zboFfsDQgHynY5ONXHPF/FLyBU3BgergRJgEJ
        kZy/NwlTfpKn962d5cxor8p9tA6s9ME=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-ODs_yfuOM3CMXltAHZm8oA-1; Wed, 27 Sep 2023 09:45:28 -0400
X-MC-Unique: ODs_yfuOM3CMXltAHZm8oA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A85223800A13;
        Wed, 27 Sep 2023 13:45:27 +0000 (UTC)
Received: from [100.85.132.103] (unknown [10.22.50.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id ACB4BC15BB8;
        Wed, 27 Sep 2023 13:45:26 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Nicholas Piggin <npiggin@gmail.com>
Cc:     linux-nfs@vger.kernel.org,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] nfs: reduce stack usage of nfs_get_root
Date:   Wed, 27 Sep 2023 09:45:25 -0400
Message-ID: <BAF96CD3-98A1-4D61-B188-BBCFBE81EA22@redhat.com>
In-Reply-To: <20230927001624.750031-1-npiggin@gmail.com>
References: <20230927001624.750031-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26 Sep 2023, at 20:16, Nicholas Piggin wrote:

> Move fsinfo allocation off stack, reducing stack overhead of
> nfs_get_root from 304 to 192 bytes.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Hi,
>
> This is motivated by a stack overflow described here:
> https://lore.kernel.org/netdev/20230927001308.749910-1-npiggin@gmail.com/
>
> NFS is not really a major culprit but it seems not too hard to
> shrink the stack a little.
>
> Thanks,
> Nick

Looks good, might be able to get rid of the local "root" var too if the
compiler doesn't optimize it away.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

