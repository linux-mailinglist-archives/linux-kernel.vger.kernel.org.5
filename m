Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D42E680AC23
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:35:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574566AbjLHSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233827AbjLHSf0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:35:26 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33387D6D
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 10:35:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1702060532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O4wJSXXt5neot2flp1x6zxgWM58LefvpkGHJupVSw+E=;
        b=YyQv3B3A05q6vCzrJ2952MwuECs2zWVVwt7hFW3GkeGZO5N5vVqtyN21glSSsfdqvxwS7G
        zYOVJ04cC4/Us55AksIWIPdYewthgXJvGhidovI2SaZX1Cuq7UvHBVgQ139OTRGiKVQicQ
        n1Z6hoyKtywuGXUYOhVlx4J2ancHHeg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-125-gmoEQhd6N3KHZ7niw_I7xw-1; Fri, 08 Dec 2023 13:35:29 -0500
X-MC-Unique: gmoEQhd6N3KHZ7niw_I7xw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B577A845DC1;
        Fri,  8 Dec 2023 18:35:28 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.39.192.131])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 38C3C3C2E;
        Fri,  8 Dec 2023 18:35:27 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-api@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH v2] ELF: supply userspace with available page shifts
 (AT_PAGE_SHIFT_MASK)
References: <6b399b86-a478-48b0-92a1-25240a8ede54@p183>
        <87v89dvuxg.fsf@oldenburg.str.redhat.com>
        <1d679805-8a82-44a4-ba14-49d4f28ff597@p183>
        <202312061236.DE847C52AA@keescook>
        <4f5f29d4-9c50-453c-8ad3-03a92fed192e@p183>
        <202312081027.BA44B7B3@keescook>
Date:   Fri, 08 Dec 2023 19:35:25 +0100
In-Reply-To: <202312081027.BA44B7B3@keescook> (Kees Cook's message of "Fri, 8
        Dec 2023 10:29:25 -0800")
Message-ID: <87lea4czki.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Kees Cook:

> I significantly prefer APIs not being arch-specific, so I'd prefer we
> always include AT_PAGE_SHIFT_MASK. For an architecture that doesn't
> define its own ARCH_AT_PAGE_SHIFT_MASK, it's not _inaccurate_ to report
> 1 << PAGE_SHIFT, but it might be incomplete.

The downside is that as an application programmer, I have to go and
chase for the information the legacy way if I encounter
getauxval(AT_PAGE_SHIFT_MASK) == getpagesize() for a longer time
because the interface does not signal the absence of any extended
page sizes.

Thanks,
Florian

