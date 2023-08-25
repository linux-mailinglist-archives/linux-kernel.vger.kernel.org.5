Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9327881DF
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 10:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240516AbjHYIQS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 04:16:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243017AbjHYIPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 04:15:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F3F3211B
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 01:15:20 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1692951301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60tr9aFEHnjsY9mPcHCSATo81fQ6Yc8CRVNAxGD2+3k=;
        b=YnaVCUEgDycspjQv7rUeW7YDHio+7YJzQzDuZpXqlnbIF4cYwLoKMV5zHbYZmRshvhQvDS
        qKopvVKCqWmCE3BxpVTUqh91SYjk/3OL0CMRpGkVuXcCI1mGvGI0llynxDDu00LL2CTZop
        cylgXO5mCbf3YkCZyzvXbZPkgYZlShEJ2ha6qQuUCHiYFjJXWVt1jipesLmOUCPSDNk92u
        rO6uZgPq7TDTm8pv897aZVhVjDt+zA2sD/MjXlSQDeL9OeUYi0+v4z/a9KZ5+tXTluvx0b
        vWw3vaYBaGu1ykC0QpCw60MbAHBC+Ib5VRzd95tKmaApz7PQlajiSvkfwfbPpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1692951301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=60tr9aFEHnjsY9mPcHCSATo81fQ6Yc8CRVNAxGD2+3k=;
        b=X6xRv7vR6eT/uVXsSMwtU6aa6uPDDy6BM5+YIcmQnhQSZ6/Jl22kApnV1hn7KNppx9PVnU
        mncP4HVMIYZcN2CA==
To:     Juergen Gross <jgross@suse.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org
Cc:     Juergen Gross <jgross@suse.com>, Andy Lutomirski <luto@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Subject: Re: [PATCH] xen: simplify evtchn_do_upcall() call maze
In-Reply-To: <20230824154106.14799-1-jgross@suse.com>
References: <20230824154106.14799-1-jgross@suse.com>
Date:   Fri, 25 Aug 2023 10:15:01 +0200
Message-ID: <87zg2fbksa.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24 2023 at 17:41, Juergen Gross wrote:
> There are several functions involved for performing the functionality
> of evtchn_do_upcall():
>
> - __xen_evtchn_do_upcall() doing the real work
> - xen_hvm_evtchn_do_upcall() just being a wrapper for
>   __xen_evtchn_do_upcall(), exposed for external callers
> - xen_evtchn_do_upcall() calling __xen_evtchn_do_upcall(), too, but
>   without any user
>
> Simplify this maze by:
>
> - removing the unused xen_evtchn_do_upcall()
> - removing xen_hvm_evtchn_do_upcall() as the only left caller of
>   __xen_evtchn_do_upcall(), while renaming __xen_evtchn_do_upcall() to
>   xen_evtchn_do_upcall()
>
> Signed-off-by: Juergen Gross <jgross@suse.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
