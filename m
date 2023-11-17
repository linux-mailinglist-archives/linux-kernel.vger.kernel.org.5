Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DFF7EF2AA
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Nov 2023 13:34:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345794AbjKQMdk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Nov 2023 07:33:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbjKQMdi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Nov 2023 07:33:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BAA011D
        for <linux-kernel@vger.kernel.org>; Fri, 17 Nov 2023 04:33:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700224414;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4131Fo6b0Ii5kbX2pHaSr3NaSQ4oM7nlLK1KpOFMudg=;
        b=GcLLK3zdpgA6+gCB3POkUWkzBD573UoEhPRRFDeabgHmI9ntO9iJz67Cs9ysQEGHZioQnt
        N3strNmnPB/5/rma2mRthKDYyKRxf4+T1LGZIwM+029/eGz6wlfQ/zAADbkfqvb7TUqkad
        yIlCWsIeiCEMNSsM0hvqErjNo5lgJAw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-Q8ZIGh5iObmpAZFTEWfq4g-1; Fri, 17 Nov 2023 07:33:31 -0500
X-MC-Unique: Q8ZIGh5iObmpAZFTEWfq4g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BB069812C2F;
        Fri, 17 Nov 2023 12:33:30 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.123])
        by smtp.corp.redhat.com (Postfix) with SMTP id 8C25C2026D4C;
        Fri, 17 Nov 2023 12:33:27 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 17 Nov 2023 13:32:26 +0100 (CET)
Date:   Fri, 17 Nov 2023 13:32:22 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     syzbot <syzbot+cbb25bb9b4d29a773985@syzkaller.appspotmail.com>,
        boqun.feng@gmail.com, brauner@kernel.org,
        linux-kernel@vger.kernel.org, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        syzkaller-bugs@googlegroups.com, tglx@linutronix.de,
        wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
Message-ID: <20231117123148.GA6728@redhat.com>
References: <000000000000a25ea7060a430d3c@google.com>
 <00000000000064b787060a55354e@google.com>
 <20231117092730.GK8262@noisy.programming.kicks-ass.net>
 <20231117093829.GA32151@redhat.com>
 <20231117094531.GN8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117094531.GN8262@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/17, Peter Zijlstra wrote:
>
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -461,7 +461,7 @@ static int ptrace_attach(struct task_str
>  				return retval;
>  		}
>
> -		scoped_guard (write_lock, &tasklist_lock) {
> +		scoped_guard (write_lock_irq, &tasklist_lock) {

FWIW,

Acked-by: Oleg Nesterov <oleg@redhat.com>

