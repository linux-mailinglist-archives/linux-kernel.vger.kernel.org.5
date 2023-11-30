Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27C8F7FF982
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 19:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346555AbjK3ShI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 13:37:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230045AbjK3ShH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 13:37:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8B29C4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 10:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701369432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kPXCfmMAxbqQxyMucaabmjeI2zK+WyVJ0GgG5IsxqJU=;
        b=DycJh0SI/0R6D76PrsGvJLM/fUcUoq7HVmpYnKPjS0n3a8EHEo2AcXKRrYGoppnq471nch
        +aDhzJOnVdetdnpXbAloXyWwzukpn9dZmWzW+9biSxvA/N4a0PK/QKgZjFA7ymOb1lIgHY
        fpHsP76APCOOsL/PK6gi3xWXSI16djo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-8Q7ESA0UNTaYG9qmgH8r8Q-1; Thu, 30 Nov 2023 13:37:07 -0500
X-MC-Unique: 8Q7ESA0UNTaYG9qmgH8r8Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 33AD7101A52D;
        Thu, 30 Nov 2023 18:37:06 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 769A11C060B1;
        Thu, 30 Nov 2023 18:37:04 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Tycho Andersen <tycho@tycho.pizza>
Cc:     Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>,
        mathieu.desnoyers@efficios.com
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
Date:   Thu, 30 Nov 2023 19:37:02 +0100
In-Reply-To: <20231130163946.277502-1-tycho@tycho.pizza> (Tycho Andersen's
        message of "Thu, 30 Nov 2023 09:39:44 -0700")
Message-ID: <874jh3t7e9.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tycho Andersen:

> From: Tycho Andersen <tandersen@netflix.com>
>
> We are using the pidfd family of syscalls with the seccomp userspace
> notifier. When some thread triggers a seccomp notification, we want to do
> some things to its context (munge fd tables via pidfd_getfd(), maybe write
> to its memory, etc.). However, threads created with ~CLONE_FILES or
> ~CLONE_VM mean that we can't use the pidfd family of syscalls for this
> purpose, since their fd table or mm are distinct from the thread group
> leader's. In this patch, we relax this restriction for pidfd_open().

Does this mean that pidfd_getfd cannot currently be used to get
descriptors for a TID if that TID doesn't happen to share its descriptor
set with the thread group leader?

I'd like to offer a userspace API which allows safe stashing of
unreachable file descriptors on a service thread.

Cc:ing Mathieu because of our previous discussions?

Thanks,
Florian

