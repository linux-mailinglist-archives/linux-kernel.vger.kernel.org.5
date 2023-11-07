Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6A87E4A88
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 22:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbjKGVX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 16:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234888AbjKGVXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 16:23:25 -0500
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6EDD7A;
        Tue,  7 Nov 2023 13:23:22 -0800 (PST)
Received: from localhost (unknown [IPv6:2601:281:8300:73::646])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id F31F12E6;
        Tue,  7 Nov 2023 21:23:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net F31F12E6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1699392202; bh=2bPfjR7kBNZGvheEbYB67hyrLGZvMBmZpVWx1tFetOc=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=rK+OnYx1kL0a3bjZDfsENQn/36liPQbikm+cF0IIL7uoRqvigxogbLjdpPCqpOUL4
         20vKdaAIOJQTqgbNBat7EE54SVjzJ1cB0r+6Hj6klHk0UaQtTvHi0zzjA7q+UtIOBg
         eLOp8qgztGXW1kIIl+AOBvajTaaMWbbj3biCrXYq4GjtY/78SLhH2r2hHMkfr8Qz1N
         IuCUc1qUEkHhZdyLr3nsjFMAHG6n+Ha22XOXRgKRcG+R0zXHSP/SXwwziD9EBQ+TvJ
         0a0H3NY+qRfmDvAUoyLtplpp3HfufK2AolwLLciPpzLM1PTay0YOi1/RLDhckMUJMD
         yFMw/uISJbmyg==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Miklos Szeredi <mszeredi@redhat.com>, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-man@vger.kernel.org, linux-security-module@vger.kernel.org,
        Karel Zak <kzak@redhat.com>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v4 5/6] add listmount(2) syscall
In-Reply-To: <20231025140205.3586473-6-mszeredi@redhat.com>
References: <20231025140205.3586473-1-mszeredi@redhat.com>
 <20231025140205.3586473-6-mszeredi@redhat.com>
Date:   Tue, 07 Nov 2023 14:23:21 -0700
Message-ID: <87il6d1cmu.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Miklos Szeredi <mszeredi@redhat.com> writes:

> Add way to query the children of a particular mount.  This is a more
> flexible way to iterate the mount tree than having to parse the complete
> /proc/self/mountinfo.
>
> Allow listing either
>
>  - immediate child mounts only, or
>
>  - recursively all descendant mounts (depth first).

So I have one probably silly question:

> +SYSCALL_DEFINE4(listmount, const struct __mount_arg __user *, req,
> +		u64 __user *, buf, size_t, bufsize, unsigned int, flags)
> +{

Why use struct __mount_arg (or struct mnt_id_req :) here rather than
just passing in the mount ID directly?  You don't use the request_mask
field anywhere.

Thanks,

jon
