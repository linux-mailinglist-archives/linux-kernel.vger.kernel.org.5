Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85DD7A8B03
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 20:01:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjITSBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 14:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjITSBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 14:01:04 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A26194
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:58 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-991c786369cso3160666b.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695232856; x=1695837656; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=x11cnA5i6BYv1UJiZcsle56884GMaZKBKvxZRyq2WDI=;
        b=VKR465u9CXmsEXo4ZRqDBUaU2yBeod36deI03WvyzkYMm6flakkoBOWFSc2pHMc/4n
         tLs/7s6MITBuDEdA28jHSkQIrdC0FdDnrlAihMb5FAVGMAJCyzQ6MnEC2LdRin0SAh/j
         xEG+rAghFqYUQpdX5RrcXsE8k/O8918GIO5sI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695232856; x=1695837656;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=x11cnA5i6BYv1UJiZcsle56884GMaZKBKvxZRyq2WDI=;
        b=GZ5K2FIkMTKDViuKT+CvXtcSOj3GIpVXAS7vKa0/CYXJy78zlwLEl4QQQPN4jmuL4w
         aVsZZ6h3Do85dSA0xt9RMd8hnp4XrlvwdgnN632ie5BLm4Oq0DNV9pK8LlmCz9JMnYZb
         jyqq62QpcvHGbDu6gAMV+TDxYX+b46fV1JwVxR7wc7zxXZywZLtX0wjP/ykIQeLYtpX3
         lhGuEmknAYvnDiUmcH3NqOhbV6GxLaEl2tgEzGBQSC1wIB2EsuBXojy9TFpOypQGhqkw
         HVFrgGvp26ml5PxuHFABGmhRpVrZNGKZMU7QbJYar1oudlKM1W6C1xyOWjXLITNpy7hQ
         1k7Q==
X-Gm-Message-State: AOJu0YxcKOHxdm20pP/RDLA1DYBkSzKbi2RJGDLRLB7RIGvoJQF8nJcR
        DA3ZgA5mcQ+8byTk2hPjpmbon0jW3DfOcXP38Wxt3w==
X-Google-Smtp-Source: AGHT+IEXNeZUAX4OAU22aEyqbbSLMKzIXjcBce5ACYaTC0w2AJjtB5KKkQa8AMMcYHFe6Uu3NkqCGQ==
X-Received: by 2002:a17:906:cc1:b0:9a1:b967:aca9 with SMTP id l1-20020a1709060cc100b009a1b967aca9mr2854429ejh.63.1695232856536;
        Wed, 20 Sep 2023 11:00:56 -0700 (PDT)
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com. [209.85.208.48])
        by smtp.gmail.com with ESMTPSA id vl3-20020a170907b60300b009adc77fe164sm8625161ejc.66.2023.09.20.11.00.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 11:00:55 -0700 (PDT)
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so18351a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 11:00:55 -0700 (PDT)
X-Received: by 2002:a05:6402:719:b0:532:ac24:5c00 with SMTP id
 w25-20020a056402071900b00532ac245c00mr2453767edx.40.1695232855125; Wed, 20
 Sep 2023 11:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230918-hirte-neuzugang-4c2324e7bae3@brauner>
 <CAHk-=wiTNktN1k+D-3uJ-jGOMw8nxf45xSHHf8TzpjKj6HaYqQ@mail.gmail.com>
 <e321d3cfaa5facdc8f167d42d9f3cec9246f40e4.camel@kernel.org>
 <CAHk-=wgxpneOTcf_05rXMMc-djV44HD-Sx6RdM9dnfvL3m10EA@mail.gmail.com>
 <2020b8dfd062afb41cd8b74f1a41e61de0684d3f.camel@kernel.org>
 <CAHk-=whACfXMFPP+dPdsJmuF0F6g+YHfUtOxiESM+wxvZ22-GA@mail.gmail.com>
 <20230919-kranz-entsagen-064754671396@brauner> <20230920-fixpunkt-besingen-128f43c16416@brauner>
In-Reply-To: <20230920-fixpunkt-besingen-128f43c16416@brauner>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 20 Sep 2023 11:00:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5gYo-rYLUxyR_oBGgZ4hMy1EaOk5c2NE9C4RJ6WB_NQ@mail.gmail.com>
Message-ID: <CAHk-=wi5gYo-rYLUxyR_oBGgZ4hMy1EaOk5c2NE9C4RJ6WB_NQ@mail.gmail.com>
Subject: Re: [GIT PULL] timestamp fixes
To:     Christian Brauner <brauner@kernel.org>
Cc:     Jeff Layton <jlayton@kernel.org>, Jan Kara <jack@suse.cz>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Sept 2023 at 09:22, Christian Brauner <brauner@kernel.org> wrote:
>
> In the meantime we had a report that unconditionally enabling
> multi-grain timestamps causes a regression for some users workloads.

Ok.

> I'll be putting the reverts into -next now and I'll get you a pull
> request by the end of the week. In case you'd rather do it right now
> it's already here:

By the end of the week is fine, I'll wait for the proper pull request.

Thanks,

             Linus
