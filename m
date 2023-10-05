Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 202A57BA4BC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237841AbjJEQKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237790AbjJEQJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:09:48 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 751F47E213
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 08:52:28 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9ae75ece209so220845366b.3
        for <linux-kernel@vger.kernel.org>; Thu, 05 Oct 2023 08:52:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1696521147; x=1697125947; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=kaAKFbtGGjgq+daw7tAPVKBzxgbEZS9H7gZCMFN6Loa+RDfMDJJPx7OVmEaJtr5nO7
         whXAfc+4mSiqQGPVk8UZrzWIs7N9mg0yc5MiqbSkhy+B0awBpFHbdak6CYFQcvlZTqv6
         9DxxkWBBlTnGtHFJcuQ0qxZx2w3BZ416UgQm8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696521147; x=1697125947;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FQ7R/nvBhjGTebLIH07sXUQkeSq81lBJV2IFuqFT5ks=;
        b=P9PEfS/1AvDT6fmQeVV7TPovZigl895iiUynUwOtmbvp6Q4hm2PU6F8LgrwESPJlQg
         87T4BlwrQuut1JRJA2ApH28l8bNxGogscKxw5vU2x16zU8MpESCTbKR8p19qci09fXEF
         g8Br+KMgxBeO82oIRmyBXwlJDxPHYi7M89hrZrbw7ygT54bd0bCaYHPsN5nl7u5Ip5zL
         NObbJwyMJybJ0oo8XRlkwuJmcCUj7VHTdYY69K6cHz3UyhCrHnftaPCBbDkL9w0BVRkZ
         0Dzq7O9rs3aD55HIj8xSTzk1jfJXRGhMyjgSxqsg1LM6a9vix8RaZMNe+OYJSVonzRbf
         XGtw==
X-Gm-Message-State: AOJu0YwQWDcaAN7LS/qSvbqgbQcOek/rhfpOU/5frGGdgXVuMFUT0v3W
        jqz6iPUAy7ssFXwJBCJNM+b7B5IYF42a9B0rCslbGg==
X-Google-Smtp-Source: AGHT+IEjk91u8XSDRTtHtK1m9U1BbYI9ul1sY8PRZffqsVYEFnsO8jHMq77QF4AYuvBhByku9bOaBTvxJTmlGFVmmZk=
X-Received: by 2002:a17:907:724b:b0:9a1:fcd7:b825 with SMTP id
 ds11-20020a170907724b00b009a1fcd7b825mr5098742ejc.71.1696521146721; Thu, 05
 Oct 2023 08:52:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230928130147.564503-1-mszeredi@redhat.com> <20230928130147.564503-2-mszeredi@redhat.com>
In-Reply-To: <20230928130147.564503-2-mszeredi@redhat.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 5 Oct 2023 17:52:15 +0200
Message-ID: <CAJfpeguTQvA6cq-3JCEZx6wP+nvZX8E6_77pNRJUU2_S7cyAiA@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] add unique mount ID
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>,
        Matthew House <mattlloydhouse@gmail.com>,
        Florian Weimer <fweimer@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Sept 2023 at 15:03, Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> If a mount is released then its mnt_id can immediately be reused.  This is
> bad news for user interfaces that want to uniquely identify a mount.
>
> Implementing a unique mount ID is trivial (use a 64bit counter).
> Unfortunately userspace assumes 32bit size and would overflow after the
> counter reaches 2^32.
>
> Introduce a new 64bit ID alongside the old one.  Initialize the counter to
> 2^32, this guarantees that the old and new IDs are never mixed up.

It occurred to me that it might make sense to make this counter
per-namespace.  That would allow more separation between namespaces,
like preventing the observation of mount creations in other
namespaces.

Does a global number make any sense?

Thanks,
Miklos
