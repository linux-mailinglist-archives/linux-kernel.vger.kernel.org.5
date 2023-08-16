Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E54B77E49F
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:05:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343979AbjHPPFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344018AbjHPPEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:04:47 -0400
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E8526AA;
        Wed, 16 Aug 2023 08:04:43 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:73::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 0D5F5385;
        Wed, 16 Aug 2023 15:04:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 0D5F5385
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1692198283; bh=+fSYm9CJrIkdJWuqjppkPHT3qTZb8tVB+rfzJ4jWDbM=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=MQxvCRCWTp2JuX/XeRVbJzO9sEFw8FZhbIUIyf6lERRhWEL2M6HicHDPsbjezb+U+
         nyXTl0vFhbN74vmVInt5sHMYDbLjkw2bgdzdkbfXJ0y9Xm310Hm5Ckjw5VLUonKyvy
         WsCYvoSKHxcx27m6/xyFWUsE991qsRoFEdQcEJ//uWTSG2vsBBORiOr1kDP8ZnePKd
         uq5GCQkn6P35+pB0rv/z11XS93HU56aXQ1PTeDRO78nQ7MloeIGUsip+9PwbiuE78f
         EmWcmdekT2BI3KwTVHcG7cdNNWw9IB9gpkLIOdXu4288ZglanYQK1vj3nvCgkoNy6V
         Q6g6JGJ2JD+wQ==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Carlos Bilbao <carlos.bilbao@amd.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc:     Avadhut Naik <Avadhut.Naik@amd.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Akira Yokosawa <akiyks@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [RFC] Proposal to relax warnings of htmldocs
In-Reply-To: <24698029-4c45-2292-ded5-13a6c12e93dc@amd.com>
References: <85964510-4f88-58d2-2687-f7fa76013cf9@amd.com>
 <87v8dgtb9o.fsf@meer.lwn.net>
 <24698029-4c45-2292-ded5-13a6c12e93dc@amd.com>
Date:   Wed, 16 Aug 2023 09:04:42 -0600
Message-ID: <87fs4jrpth.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Carlos Bilbao <carlos.bilbao@amd.com> writes:

>> ...other than fixing the actual problems? :)
>
> I'm happy to fix as many as I can, but there are obstacles e.g. some things
> lack documentation, such as undocumented fields in structures with names
> that nobody but their creator could decipher. Also, that won't solve the
> underlying warning display problem (which maybe it's W!=1, as noted by
> Matthew.

I *did* put a smiley on that...

>>> I suggest for the command `make htmldocs` to
>>> only display, by default, warnings directly related to the changes being
>>> made, unless explicitly requested otherwisee.
>>>
>>> I'm thinking we could do this, for example, by making hmtldocs a two-step
>>> process: First running htmldocs as usual but with warnings disabled, and
>>> then generating docs again but only for the new files (see $git diff
>>> --name-only HEAD), with warnings active but limited to the scope of the
>>> changes made.
>> 
>> A normal build should just generate warnings for files that have
>> changed (since the last build).  Does that not do what you want?
>
> That's not the behavior I see on my system, when I run `make htmldocs` I
> see many warnings from other places.It floods my screen. The default
> behavior appears to change between configurations and compilers.

Warnings that are generated at output time, such as broken references,
will come out every time.  Those generated during the read phase are
generally limited to what has been changed.  I rely on that pretty
heavily to do incremental builds when applying patches.  If you're doing
a full rebuild after changing one file, something strange is happening.

Thanks,

jon
