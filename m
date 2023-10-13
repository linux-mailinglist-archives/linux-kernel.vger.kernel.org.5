Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 783D47C8B37
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 18:35:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjJMQ0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 12:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMQ0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 12:26:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DB64EEB
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 09:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697213520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5ixLD8OkftC+bT/37jK03Qzb/pMnfq0yPTWJiAzf+0U=;
        b=IxoGQo3YMOYniRw/QgZTAanWhnqV58jCp5Wig/x37eTyJBGOgAW5MAjohl8heFqp/qC7Ct
        vLvByM/GgB3j9rlIqKvD+/5Q08XrwbQHTP7qLlU0Df/yQrB/fkg9akosrLy65W6pZPnTb2
        6S5iKzfQisDic4sS3l+5i2v8dHCrzVw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-241-FH94Om5-NF-ue7L8KVY4pg-1; Fri, 13 Oct 2023 12:11:57 -0400
X-MC-Unique: FH94Om5-NF-ue7L8KVY4pg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EAB301029F44;
        Fri, 13 Oct 2023 16:11:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.59])
        by smtp.corp.redhat.com (Postfix) with SMTP id 793612157F5A;
        Fri, 13 Oct 2023 16:11:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 13 Oct 2023 18:10:57 +0200 (CEST)
Date:   Fri, 13 Oct 2023 18:10:54 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexey Gladkov <legion@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] locking/seqlock: Propagate 'const' pointers within
 read-only methods, remove forced type casts
Message-ID: <20231013161054.GA18531@redhat.com>
References: <20231012143158.GA16133@redhat.com>
 <20231012143227.GA16143@redhat.com>
 <ZSg5KAFxVzKoFlhZ@gmail.com>
 <CAHk-=wgsybshMs3KLsyheP8hHhndrRhjo70L1qi+GdBZND8M+A@mail.gmail.com>
 <ZSkD4RLAhJaW3VyB@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSkD4RLAhJaW3VyB@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/13, Ingo Molnar wrote:
>
> So create two wrapper variants instead: 'ptr' and 'const_ptr', and pick the
> right one for the codepaths that are const: read_seqcount_begin() and
> read_seqcount_retry().
>
> This cleans up type handling and allows the removal of all type forcing.

Too late, but nevertheless

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

