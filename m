Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5F77AF68E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 01:08:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjIZXI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 19:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbjIZXGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 19:06:55 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 905FE19A2
        for <linux-kernel@vger.kernel.org>; Tue, 26 Sep 2023 15:09:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695766146;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rVPe3+KdW1jPsi0jBlXBNKMV25TaYQzseuW/GsNuJu0=;
        b=DgEn0WGdy08M58LjfNcfTjmtV88esitK1DX6QNcTwt224TiGaGQon3pHRlz2hGvPNz+Fet
        qaeoZpWOPPkwC1A8yC1VTRube5RJNJMRMHkxmu1coxcSImBg/rlN0RRexZW/XJs0cv0Sok
        /tZPHMvVfxtDu9yIqOr2U+iNRiJK/MA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-482-WZ032l7-OM-44FQa4KHWDA-1; Tue, 26 Sep 2023 17:53:37 -0400
X-MC-Unique: WZ032l7-OM-44FQa4KHWDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96EC53C11A10;
        Tue, 26 Sep 2023 21:53:36 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.16])
        by smtp.corp.redhat.com (Postfix) with SMTP id 4D3C82156A27;
        Tue, 26 Sep 2023 21:53:31 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Tue, 26 Sep 2023 23:52:40 +0200 (CEST)
Date:   Tue, 26 Sep 2023 23:52:34 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Li kunyu <kunyu@nfschina.com>
Cc:     peterz@infradead.org, mcgrof@kernel.org,
        mathieu.desnoyers@efficios.com, elver@google.com,
        viro@zeniv.linux.org.uk, dvyukov@google.com,
        vincent.whitchurch@axis.com, michael.christie@oracle.com,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] kernel/signal: =?utf-8?Q?Remov?=
 =?utf-8?B?ZSB1bm5lY2Vzc2FyeSDigJhOVUxM4oCZ?= values from ucounts
Message-ID: <20230926215233.GA26968@redhat.com>
References: <20230926022410.4280-1-kunyu@nfschina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230926022410.4280-1-kunyu@nfschina.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
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

On 09/26, Li kunyu wrote:
>
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -415,7 +415,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
>  		 int override_rlimit, const unsigned int sigqueue_flags)
>  {
>  	struct sigqueue *q = NULL;
> -	struct ucounts *ucounts = NULL;
> +	struct ucounts *ucounts;
>  	long sigpending;

this looks obviously correct, so

Acked-by: Oleg Nesterov <oleg@redhat.com>


but you know, this change is so trivial, perhaps you should
resend this minor cleanup to kernel-janitors@vger.kernel.org

but let me add Andrew, perhaps he will take this patch...

Oleg.

