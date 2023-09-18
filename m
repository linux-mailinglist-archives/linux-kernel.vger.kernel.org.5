Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98F7A4D47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 17:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjIRPr6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 11:47:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjIRPr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 11:47:56 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5559C1FD4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:47:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ad8bf9bfabso612112966b.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 08:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1695051845; x=1695656645; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=ovYugzXqR24d+lTEOmoVDv06w5IN9NQnd8fXHzcD0FbdnlQtbzSwlWy8QU+QVzqdQZ
         VIi8fBlqse5eWJMmukN1knIC2V7qR/y7bKEHW3nf+m8BZixoyYJ8YVrQ6ODeZsoSw1aR
         4/+7XX8wAZaCSzDt2NHY39j3u3PY+VGtxBK/4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695051845; x=1695656645;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RKiCOByDL96hotvveoALRujHhJ+JRMIfwmxKHnT1o6A=;
        b=CZiAQ2wfTrJdSaJydhtgSHgIhqMJzfj3wD4g0iVEgg3dusl1rYjb451xwBBmYYzPcW
         t9xgaL2HOmQmKWoaTVMG17QJGVnwYbhly14ABc7gW1jZUVK20lNKMQsXj45IFbJeB6XC
         325h0FOfiOr9MfypTRZ7IlOfEnIJupgL9IujCYLFYlmKki3qQPj3LS3qrIsNOQSxmLVX
         lwK3kaVL9Q/5J45tnaD5R3kdGyLxub8mJ7Jxpwo+1x1U+5rleW3R7jjhdrDhGsChne+g
         8QPMGkoxF8VzywETigZe6BknlB8/fZG68MddEudGkikXCgQY8zdpKQ3tnRVnkYreMY4K
         4PYA==
X-Gm-Message-State: AOJu0Yy4SsCyc0hOWT9m0pUv6YuaYXJUlCL3LeBD/2NwQfZVxmy7wMwA
        cVL2XmkjkXGbAbHkrBAhWNrlZAggDj0+1c4G/vIVdW09rgpHy4s+
X-Google-Smtp-Source: AGHT+IFIEvXbEUkU+mxN2F/R/tIeFBRSysj5+zBZP+k60Jl/lHiG5m9DX+A4lurODy2hOWFB3ngj7hncFNBhvH4RRiY=
X-Received: by 2002:a17:906:3102:b0:99c:e38d:e484 with SMTP id
 2-20020a170906310200b0099ce38de484mr8115574ejx.6.1695047562459; Mon, 18 Sep
 2023 07:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-3-mszeredi@redhat.com>
 <20230914-salzig-manifest-f6c3adb1b7b4@brauner> <CAJfpegs-sDk0++FjSZ_RuW5m-z3BTBQdu4T9QPtWwmSZ1_4Yvw@mail.gmail.com>
 <20230914-lockmittel-verknallen-d1a18d76ba44@brauner> <CAJfpegt-VPZP3ou-TMQFs1Xupj_iWA5ttC2UUFKh3E43EyCOQQ@mail.gmail.com>
 <20230918-grafik-zutreffen-995b321017ae@brauner> <CAOssrKfS79=+F0h=XPzJX2E6taxAPmEJEYPi4VBNQjgRR5ujqw@mail.gmail.com>
 <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
In-Reply-To: <20230918-hierbei-erhielten-ba5ef74a5b52@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 18 Sep 2023 16:32:30 +0200
Message-ID: <CAJfpegtaGXoZkMWLnk3PcibAvp7kv-4Yobo=UJj943L6v3ctJQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] add statmnt(2) syscall
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,HTML_IMAGE_ONLY_20,HTML_MESSAGE,
        MIME_HEADER_CTYPE_ONLY,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Sept 2023 at 16:25, Christian Brauner <brauner@kernel.org> wrote:

> The system call should please have a proper struct like you had in your
> first proposal. This is what I'm concerned about:
>
> int statmount(u64 mnt_id,
>               struct statmnt __user *st,
>               size_t size,
>               unsigned int flags)
>
> instead of taking an void pointer.

So you are not concerned about having ascii strings returned by the
syscall?   I thought that was the main complaint.

Thanks,
Miklos
