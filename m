Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D79067F0733
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjKSPbs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:31:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjKSPbq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:31:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3980C2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 07:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700407902;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VJDSDW6Pnxgedb2WwvdXdi3IPWir2LFj6HcK4uMq+TE=;
        b=HJ2UPx9ik7g/XWy5UxZrE1EwMopu0Wg48qHjJ+vPp2Z4k5lMYX+YAx0ZWcaY4EcPU7L1ea
        2rIjfiPxhEPrqrX4CygnqgJZwzdFDtFLL4NhDChAQIpoyydMsVqblmyc0fIud//MLjouXd
        qPAFt66vzh8rubWoxf6r+ftD+xS5FF8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-aaxRoKxrNoKaooQ-KTCq4A-1; Sun, 19 Nov 2023 10:31:39 -0500
X-MC-Unique: aaxRoKxrNoKaooQ-KTCq4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 910D7185A782;
        Sun, 19 Nov 2023 15:31:38 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.31])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5F08D2026D4C;
        Sun, 19 Nov 2023 15:31:34 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 19 Nov 2023 16:30:33 +0100 (CET)
Date:   Sun, 19 Nov 2023 16:30:28 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     syzbot <syzbot+cef555184e66963dabc2@syzkaller.appspotmail.com>,
        boqun.feng@gmail.com, brauner@kernel.org, cgroups@vger.kernel.org,
        hannes@cmpxchg.org, linux-kernel@vger.kernel.org,
        lizefan.x@bytedance.com, longman@redhat.com,
        michael.christie@oracle.com, mingo@redhat.com, mst@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        wander@redhat.com, will@kernel.org
Subject: Re: [syzbot] [cgroups?] possible deadlock in cgroup_free
Message-ID: <20231119153028.GB29401@redhat.com>
References: <000000000000f5b0d0060a430995@google.com>
 <0000000000009642b4060a4f017f@google.com>
 <ZVolxA8RHsY11CnE@slm.duckdns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZVolxA8RHsY11CnE@slm.duckdns.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/19, Tejun Heo wrote:
>
> On Thu, Nov 16, 2023 at 05:25:05PM -0800, syzbot wrote:
> > syzbot has bisected this issue to:
> >
> > commit 2d25a889601d2fbc87ec79b30ea315820f874b78
> > Author: Peter Zijlstra <peterz@infradead.org>
> > Date:   Sun Sep 17 11:24:21 2023 +0000
> >
> >     ptrace: Convert ptrace_attach() to use lock guards
>
> Looks like the tasklist_lock conversion in ptrace_attach() forgot _irq.
> Peter, Oleg?

Yes, please see

	Re: [syzbot] [kernel?] inconsistent lock state in ptrace_attach
	https://lore.kernel.org/all/20231117094531.GN8262@noisy.programming.kicks-ass.net/

Oleg.

