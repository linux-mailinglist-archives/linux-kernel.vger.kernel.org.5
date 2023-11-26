Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA3E47F92E8
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 14:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229843AbjKZN6B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 08:58:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKZN56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 08:57:58 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86CE4
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 05:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701007083;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KKGtbNLv4dX1YXjgRfFngETML/jtPXXGi079i/UOOu8=;
        b=UL3h8JCXNX9IRnt/FU9RiGB1Kaep7DzD/v9r6ujDJqmioh0uJ1rXLGTh2bVFqXiVSLFzkk
        hyCc9w4B06K8VmHACquJ/DAIFwmKs/JmGMo18qZ1DvFdw6trHJq7YE9T4/rFjLoWi3Jlry
        g92HT7IwGlTIRI6HDV+9m588thAiTKQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-570-yGDnhNAgP1qPMJmNqQ6ZsQ-1; Sun, 26 Nov 2023 08:57:57 -0500
X-MC-Unique: yGDnhNAgP1qPMJmNqQ6ZsQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 08CF1101A52D;
        Sun, 26 Nov 2023 13:57:56 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.14])
        by smtp.corp.redhat.com (Postfix) with SMTP id E4741492BFA;
        Sun, 26 Nov 2023 13:57:50 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Sun, 26 Nov 2023 14:56:50 +0100 (CET)
Date:   Sun, 26 Nov 2023 14:56:44 +0100
From:   Oleg Nesterov <oleg@redhat.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Kees Cook <keescook@chromium.org>,
        Florent Revest <revest@chromium.org>,
        David Hildenbrand <david@redhat.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Andy Chiu <andy.chiu@sifive.com>,
        Joey Gouly <joey.gouly@arm.com>,
        Stefan Roesch <shr@devkernel.io>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ondrej Mosnacek <omosnace@redhat.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>, rongtao@cestc.cn
Subject: Re: [PATCH v2] prctl: Get private anonymous memory region name
Message-ID: <20231126135644.GA7199@redhat.com>
References: <tencent_77E0BC1E8E9A21CA1B9009DD66555C72A90A@qq.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_77E0BC1E8E9A21CA1B9009DD66555C72A90A@qq.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26, Rong Tao wrote:
>
> then the PR_GET_VMA interface should be provided accordingly,
> which is necessary, as the userspace program usually wants to know what
> VMA name it has configured for the anonymous page.

I don't really understand the use-case for PR_GET_VMA ...

But the patch looks reasonable and correct to me.

Reviewed-by: Oleg Nesterov <oleg@redhat.com>

