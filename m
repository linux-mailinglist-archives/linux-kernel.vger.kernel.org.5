Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F577E0882
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 19:53:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345368AbjKCSxp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 14:53:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230246AbjKCSxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 14:53:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12FB3D45
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 11:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1699037574;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NCiQx7b6o0I8TtRZwuqX8qo/h0IQ9BycIscN4+R1OH0=;
        b=HIw19AjR3N6BFQ8N4pLGQACJf1UBdW+zYuZKkBbukMqfrOEJHeqNOR3THDRmdzIDR01xjH
        2QvzzuEeAv8KFISmNGSsZngJymya/sblDVLu+qugxVjj8vXw7CFn0MBV/9es+j+uepTsa4
        DThiYoJHv0WodnRF9CXYZe9gRr2W7Bw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-90-vJzT2UxzOjmmLss8mlavUw-1; Fri,
 03 Nov 2023 14:52:49 -0400
X-MC-Unique: vJzT2UxzOjmmLss8mlavUw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 725441E441D4;
        Fri,  3 Nov 2023 18:52:48 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.198])
        by smtp.corp.redhat.com (Postfix) with SMTP id B268F10102;
        Fri,  3 Nov 2023 18:52:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri,  3 Nov 2023 19:51:46 +0100 (CET)
Date:   Fri, 3 Nov 2023 19:51:43 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Linus Torvalds <torvalds@linuxfoundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Eric Biederman <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] cleanup: Add conditional guard support
Message-ID: <20231103185143.GB26864@redhat.com>
References: <20231102104429.025835330@infradead.org>
 <20231102110706.460851167@infradead.org>
 <20231102144009.GA9680@redhat.com>
 <20231103093023.GA8262@noisy.programming.kicks-ass.net>
 <CAHk-=wiGpX9+ajuRZeeX48C9ChwS0qNGj+Gkg_kDiuo6KJV00Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiGpX9+ajuRZeeX48C9ChwS0qNGj+Gkg_kDiuo6KJV00Q@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/03, Linus Torvalds wrote:
>
> On Thu, 2 Nov 2023 at 23:30, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > Linus, do you like that enough to suffer a flag day patch as proposed by
> > Oleg?
>
> I don't find myself caring too much whether we have that "double
> grouping" of the guard type-vs-arguments or the "(type, arg...)"
> syntax.

Neither me,

> I honestly think that "guard(spinlock)(&lock)" makes it more visually
> obvious that the first argument is the "type of guard", while
> "guard(spinlock, &lock)" makes it look like the two arguments are
> somehow at the same level, which they most definitely aren't.

My point was that

	guard(spinlock)(&lock);

doesn't match

	scoped_guard(spinlock, &lock);

but I agree this purely cosmetic, so lets forget it.

Oleg.

