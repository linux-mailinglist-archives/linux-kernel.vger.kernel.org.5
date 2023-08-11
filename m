Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7724778E2F
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 13:48:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234545AbjHKLsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 07:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235742AbjHKLsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 07:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BABEFC
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 04:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691754482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FMt5tOIVogT9iblSaxOIkwK9I4Msw741WoQTUm6Ym28=;
        b=ft+tiQd1IrhwKgoLtk3D7gd2AlCLQ+dWEa2rCTP2fWGZIfFA0zKmTLB+I+LpXHsoIwGrgo
        LOqeLYflEzA3VR/8k201rgnYfnF/mOzrQdKnbSEG6v8NERiRcxDzWSQeSIa+wsDSxVzLRv
        j6A2J2WEZRLGeRsnFyO/kIXybSzBVzw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-14-fJnnpD0OM0Osu8KtnM7Jlw-1; Fri, 11 Aug 2023 07:47:56 -0400
X-MC-Unique: fJnnpD0OM0Osu8KtnM7Jlw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C2C3C0F68F;
        Fri, 11 Aug 2023 11:47:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.66])
        by smtp.corp.redhat.com (Postfix) with SMTP id 6D86A2026D4B;
        Fri, 11 Aug 2023 11:47:54 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 11 Aug 2023 13:47:14 +0200 (CEST)
Date:   Fri, 11 Aug 2023 13:47:11 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     David Rheinsberg <david@readahead.eu>,
        linux-kernel@vger.kernel.org, Jan Kara <jack@suse.cz>,
        Kees Cook <keescook@chromium.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        Luca Boccassi <bluca@debian.org>
Subject: Re: [PATCH] pid: allow pidfds for reaped tasks
Message-ID: <20230811114711.GA24141@redhat.com>
References: <20230807085203.819772-1-david@readahead.eu>
 <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230807-porzellan-rehkitz-9fde1b94dd6b@brauner>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As I said, I am not sure I understand the problem. And I know nothing
about net/ but...

On 08/07, Christian Brauner wrote:
>
> > SO_PEERPIDFD returns `EINVAL` if the peer-task was already reaped,
> > but returns a stale pidfd if the task is reaped immediately after the
> > respective alive-check.

after the quick grep it seems that SO_PEERPIDFD can simply use
__pidfd_prepare() ? We know that sk->sk_peer_pid was initialized with
task_tgid(current) and thus we know it is (was) a valid TGID pid.

The same is probably true for scm->pid and scm_pidfd_recv()...

But again, I am not familiar with this code, I can be wrong.

Oleg.

