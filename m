Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A9580A443
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 14:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1573792AbjLHNQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 08:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233499AbjLHNP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 08:15:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54377E9
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 05:16:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702041364;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Gb0GPMiMlGSDj0aJqLOnlqDRREqBTKMhjqExl2I2m1g=;
        b=MvjIoQVDOYkGoyHdDiHoy8xPt3PzalnCC/m895PCbapJbBIBmc3r67+TYTmrVFI8opSmm+
        9FA78fH5Kb1+MOmtTLHRFjJm6Qhisjue36D4ldaS37YUBuPoICuDrPuEVtHa8Ew79kKr/h
        AWXRQqYQTQH5GmDT3WHE4eNcvVoJqRM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-S3kEsJVQOfybehL8PHBI1g-1; Fri, 08 Dec 2023 08:16:02 -0500
X-MC-Unique: S3kEsJVQOfybehL8PHBI1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A7577830F20;
        Fri,  8 Dec 2023 13:16:01 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0D4953C2E;
        Fri,  8 Dec 2023 13:15:59 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Christian Brauner <brauner@kernel.org>
Cc:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Tycho Andersen <tycho@tycho.pizza>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Jan Kara <jack@suse.cz>, linux-fsdevel@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
        <874jh3t7e9.fsf@oldenburg.str.redhat.com>
        <ZWjaSAhG9KI2i9NK@tycho.pizza>
        <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
        <87ttp3rprd.fsf@oldenburg.str.redhat.com>
        <20231207-entdecken-selektiert-d5ce6dca6a80@brauner>
Date:   Fri, 08 Dec 2023 14:15:58 +0100
In-Reply-To: <20231207-entdecken-selektiert-d5ce6dca6a80@brauner> (Christian
        Brauner's message of "Thu, 7 Dec 2023 23:58:53 +0100")
Message-ID: <87wmtog7ht.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Christian Brauner:

> File descriptors are reachable for all processes/threads that share a
> file descriptor table. Changing that means breaking core userspace
> assumptions about how file descriptors work. That's not going to happen
> as far as I'm concerned.

It already has happened, though?  Threads are free to call
unshare(CLONE_FILES).  I'm sure that we have applications out there that
expect this to work.  At this point, the question is about whether we
want to acknowledge this possibility at the libc level or not.

Thanks,
Florian

