Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7410580749A
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbjLFQNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:13:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjLFQNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:13:11 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A332E122
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701879196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=b00doOcUAWq1RTxBpUUl3AhHUCRtaaT2eXgI04xU0rI=;
        b=MuUazF834pLLeZBTRSB7JzZhqFvmt1A49hU/8g8OCt2qAQd0HQp5lZRGcNW2+mdM32s8zT
        RzHXEqw7V1BnR3sywhACyETlpDUrTGEbgvZPZRImBO/fImA7MD3i+zrjeW3jvU7rLvR4Wn
        hkVSoHmt5QxEs+WsUm7VOpsww8ApapA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-517-yIe0WVutN_udtif27DAn6w-1; Wed,
 06 Dec 2023 11:13:07 -0500
X-MC-Unique: yIe0WVutN_udtif27DAn6w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 142363806105;
        Wed,  6 Dec 2023 16:04:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4435340C6EB9;
        Wed,  6 Dec 2023 16:04:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20231206145744.17277-1-lhenriques@suse.de>
References: <20231206145744.17277-1-lhenriques@suse.de>
To:     Luis Henriques <lhenriques@suse.de>
Cc:     dhowells@redhat.com, Jarkko Sakkinen <jarkko@kernel.org>,
        Eric Biggers <ebiggers@kernel.org>, keyrings@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] keys: flush work when accessing /proc/key-users
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <498293.1701878642.1@warthog.procyon.org.uk>
Date:   Wed, 06 Dec 2023 16:04:02 +0000
Message-ID: <498294.1701878642@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
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

Luis Henriques <lhenriques@suse.de> wrote:

> This patch is mostly for getting some feedback on how to fix an fstest
> failing for ext4/fscrypt (generic/581).  Basically, the test relies on the
> data read from /proc/key-users to be up-to-date regarding the number of
> keys a given user currently has.  However, this file can't be trusted
> because it races against the keys GC.

Unfortunately, I don't think your patch helps.  If the GC hasn't started yet,
it won't achieve anything and the GC can still be triggered at any time after
the flush and thus race.

What is it you're actually trying to determine?

And is it only for doing the test?

David

