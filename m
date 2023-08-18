Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13AEF7806FE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 10:18:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358523AbjHRIS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 04:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358560AbjHRISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 04:18:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716282D79
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 01:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692346642;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQKXLKH2L3l0y0ESLluKceN5qNLk28AqzUrRAq+W0Fg=;
        b=gVA2Qkn4ruK1ef9fUY3H5h81GyIRgZGRHB0bidGWoSr0P48hqgLPJ/7bRbKjGoY8I7ewiu
        7/VbKsE1Mtp+ve6334oMp9idRS5t3lTmQ+5n/HYozJ4zO8xpP9kdushFgOkE9EHoGed0NG
        QpcnqsCzrXI9H/DvuyfOS4xWsFdZKTs=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-62-YPI4836hMFCBhJroaZwHJA-1; Fri, 18 Aug 2023 04:17:10 -0400
X-MC-Unique: YPI4836hMFCBhJroaZwHJA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AE6C93C1014E;
        Fri, 18 Aug 2023 08:17:09 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id E9C6440C207B;
        Fri, 18 Aug 2023 08:17:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 18 Aug 2023 10:16:25 +0200 (CEST)
Date:   Fri, 18 Aug 2023 10:16:17 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Jiri Slaby <jirislaby@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kill do_each_thread()
Message-ID: <20230818081617.GA5339@redhat.com>
References: <20230817163708.GA8248@redhat.com>
 <d92e7938-49e0-3b4c-89ab-77dcd15b8676@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d92e7938-49e0-3b4c-89ab-77dcd15b8676@kernel.org>
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

On 08/18, Jiri Slaby wrote:
>
> On 17. 08. 23, 18:37, Oleg Nesterov wrote:
> >Eric has pointed out that we still have 3 users of do_each_thread().
> >Change them to use for_each_process_thread() and kill this helper.
>
> Is there any change in behavior?

No.

Well, there is a subtle change, after do_each_thread/while_each_thread
g == t == &init_task, while after for_each_process_thread() they both
point to nowhere, but this doesn't matter.

> Why is for_each_process_thread() better than do_each_thread()?

Say, for_each_process_thread() is rcu safe, do_each_thread() is not.

And certainly

	for_each_process_thread(p, t) {
		do_something(p, t);
	}

looks better than

	do_each_thread(p, t) {
		do_something(p, t);
	} while_each_thread(p, t);

And again, there are only 3 users of this awkward helper left.
It should have been killed years ago and in fact I thought it
had already been killed. It uses while_each_thread() which needs
some changes.

Oleg.

