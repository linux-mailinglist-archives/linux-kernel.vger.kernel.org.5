Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E3176A9CE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 09:16:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230357AbjHAHQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 03:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjHAHQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 03:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBFF91BC6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 00:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690874115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2xykq6MCLxVS9fhmaOvf4Q67Lhej7GxRvBqCzZn6c5I=;
        b=It6KQ5JyHE/mqYsIlirgzABAZ1W9N216EC48P94nZ7xRwtNs/i2b0OD2zz+XIBZzYrSzqP
        9Dw8mUrW2qCqhshKh6hQm/PUYCX3T9zrUpuxQWftZkQ1MRY9DC47ev+2hlyrI+SYyGWbc+
        adoxrOMM2KqzWDyR8mxNZAEOFX9Cuzw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-570-Pi5QiCozPYCQOfbdsl5b1g-1; Tue, 01 Aug 2023 03:15:10 -0400
X-MC-Unique: Pi5QiCozPYCQOfbdsl5b1g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 22A341C0E0D4;
        Tue,  1 Aug 2023 07:15:10 +0000 (UTC)
Received: from oldenburg.str.redhat.com (unknown [10.2.16.12])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3A5CD40C2063;
        Tue,  1 Aug 2023 07:15:08 +0000 (UTC)
From:   Florian Weimer <fweimer@redhat.com>
To:     Harald van Dijk <harald@gigawatt.nl>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Rich Felker <dalias@libc.org>, linux-x86_64@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] x86: Fix x32 System V message queue syscalls
References: <1156938F-A9A3-4EE9-B059-2294A0B9FBFE@jrtc27.com>
        <20201012134444.1905-1-jrtc27@jrtc27.com>
        <CALCETrWKwFD7QhFQu9X_yQeVW1_yy-gEMNEtsWmQK=fNg9y68A@mail.gmail.com>
        <20201101012202.GM534@brightrain.aerifal.cx>
        <7842A462-0ADB-4EE3-B4CB-AE6DCD70CE1C@jrtc27.com>
        <20201101015013.GN534@brightrain.aerifal.cx>
        <CALCETrUuBR3Pt_9NhRZTLzjZzwdsS2OPW4U2r31_1Uq-=poRDw@mail.gmail.com>
        <04832096-ED7F-4754-993D-F578D4A90843@jrtc27.com>
        <EEC90B2F-E972-475F-B058-918CDE401618@jrtc27.com>
        <20201101210102.GO534@brightrain.aerifal.cx>
        <29423184-A433-42D4-B635-CDEFE7271B40@jrtc27.com>
        <2AC632C0-EC00-4C4E-92DC-B7F238897C4C@jrtc27.com>
        <CALCETrWWcVhYoVuvovo558sXpA7X75jNpf8LA+w+k-dzyRiUcg@mail.gmail.com>
        <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl>
Date:   Tue, 01 Aug 2023 09:15:06 +0200
In-Reply-To: <347eab9f-b64a-b124-ba7a-ee458e6407f3@gigawatt.nl> (Harald van
        Dijk's message of "Tue, 1 Aug 2023 01:43:40 +0100")
Message-ID: <87zg3b5j45.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Harald van Dijk:

> There is one complication that I think has not been mentioned yet:
> when _GNU_SOURCE is defined, glibc does provide a definition of struct
> msghdr in <sys/msg.h> with a field "__syscall_slong_t mtype;". This
> makes it slightly more likely that there is code out there in the wild
> that works fine with current kernels and would be broken by the
> fix. Given how rare x32 is, and how rare message queues are, this may
> still be acceptable, but I am mentioning it just in case this would
> cause a different approach to be preferred. And whatever is done, a
> fix should also be submitted to glibc.

What should glibc do here?  Just change the definition in the header to
long and ignore the breakage?

Thanks,
Florian

