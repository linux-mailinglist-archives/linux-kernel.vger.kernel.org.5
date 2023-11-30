Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBC07FFBAE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 20:43:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376499AbjK3TnT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 14:43:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbjK3TnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 14:43:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3DD7F
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 11:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701373404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=1LzR82TZZoRBH/QGAZ8DY5Aa+itdrUDM4gzCDXUwKhE=;
        b=LxVJiDGbAnDe/LOuqwr3l/qTI2kCRrYewu0z2DZ7vLMy9CNyoaWkTHHOcvMeRKlmhCvoYX
        Tt6MzUGGLXRnTsr75uoV2ir3ZjeibQDrUxLcDdD3A6/QT1kJvVCd38avupTz15p3sZxRfo
        DC9wIYeGWrUHiBVU7gJD4EIn+bhGQf4=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-HioBAyClOBG-ZY4j2hqARw-1; Thu,
 30 Nov 2023 14:43:22 -0500
X-MC-Unique: HioBAyClOBG-ZY4j2hqARw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AB73B381CBA1;
        Thu, 30 Nov 2023 19:43:21 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.45])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 046491121307;
        Thu, 30 Nov 2023 19:43:19 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Tycho Andersen <tycho@tycho.pizza>,
        Christian Brauner <brauner@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        Tycho Andersen <tandersen@netflix.com>
Subject: Re: [RFC 1/3] pidfd: allow pidfd_open() on non-thread-group leaders
References: <20231130163946.277502-1-tycho@tycho.pizza>
        <874jh3t7e9.fsf@oldenburg.str.redhat.com>
        <ZWjaSAhG9KI2i9NK@tycho.pizza>
        <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com>
Date:   Thu, 30 Nov 2023 20:43:18 +0100
In-Reply-To: <a07b7ae6-8e86-4a87-9347-e6e1a0f2ee65@efficios.com> (Mathieu
        Desnoyers's message of "Thu, 30 Nov 2023 14:00:01 -0500")
Message-ID: <87ttp3rprd.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Mathieu Desnoyers:

>>> I'd like to offer a userspace API which allows safe stashing of
>>> unreachable file descriptors on a service thread.

>> By "safe" here do you mean not accessible via pidfd_getfd()?

No, unreachable by close/close_range/dup2/dup3.  I expect we can do an
intra-process transfer using /proc, but I'm hoping for something nicer.

Thanks,
Florian

