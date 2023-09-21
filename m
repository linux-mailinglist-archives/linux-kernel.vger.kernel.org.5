Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE07A994B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 20:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229803AbjIUSMv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 14:12:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230366AbjIUSMI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 14:12:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23A3A7A95
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695318542;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=UDGdllQ1r/WmMGlK0hSZ+2wMvgx/CklizryCJJDN5lw=;
        b=PaleHHJQSoRGzFuhCG0Bia2L06peq2ESo5xCsCEvLrt5576CMQ5SAqfUOTV2JFbSCbwJu9
        jVBYGqYxJjqQ0JkWUOBTyOVtFf1gfO5y2Ev95XIR1koHyYJn4T4Mdg7DkCDrtsjFUryu2U
        gvU4heTtowpxJEhIKMmmjQBirfrvmC0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-36-T1GI33xdNTWqld3j0BdUWA-1; Thu, 21 Sep 2023 10:32:06 -0400
X-MC-Unique: T1GI33xdNTWqld3j0BdUWA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A0555858F1B;
        Thu, 21 Sep 2023 14:32:05 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.156])
        by smtp.corp.redhat.com (Postfix) with SMTP id 1D75C40C2064;
        Thu, 21 Sep 2023 14:32:02 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Thu, 21 Sep 2023 16:31:12 +0200 (CEST)
Date:   Thu, 21 Sep 2023 16:31:08 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Waiman Long <longman@redhat.com>,
        Will Deacon <will@kernel.org>,
        Alexey Gladkov <legion@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/5] seqlock: simplify SEQCOUNT_LOCKNAME()
Message-ID: <20230921143108.GB20728@redhat.com>
References: <20230913154907.GA26210@redhat.com>
 <20230913154953.GA26242@redhat.com>
 <20230916085117.GA35156@noisy.programming.kicks-ass.net>
 <20230921114826.GA20728@redhat.com>
 <20230921140406.GF14803@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230921140406.GF14803@noisy.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/21, Peter Zijlstra wrote:
>
> On Thu, Sep 21, 2023 at 01:48:26PM +0200, Oleg Nesterov wrote:
> >
> > Can you look at 2/5? To me it looks like a good cleanup too.
> > I am going to resend 1/5 and 2/5, as no one is interested in
> > stats_lock change.
>
> 2 seems okay. Will need a new changelog without the rest thouhg. Perhaps
> talk about how it perserves the constness instead?

OK, will do, thanks.

Oleg.

