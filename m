Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 595B87A00D3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 11:50:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbjINJur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 05:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237788AbjINJul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 05:50:41 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BE5210D
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:44:03 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9936b3d0286so108721566b.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 02:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google; t=1694684642; x=1695289442; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fpyUSA4zqMpJvFIRfLkgjwyN5TLcHnhqRritAX1SXxg=;
        b=Y94vGfTPOkhD5b7nXKflpOfEAbD00UKQYbeBzkQMrM69c6ARXeuJXId8LjBubaOUYe
         5Yex09MY80gCm0lnPqfVYdEmPtcBJ8i8PUclyrmS/ASRRmUISLS9uroYY65kBseOtVzQ
         n/BAFc+Ss0SrJBDRw8PO/RWPyDKVaY5ms/oOc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694684642; x=1695289442;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fpyUSA4zqMpJvFIRfLkgjwyN5TLcHnhqRritAX1SXxg=;
        b=jaGasoKth5758oYvJBum21ngOPvZqrQpB/cNqvYmKuLJIlCaJOVGxpYHYNgA796PgA
         1ElE/cDHPEVbKnf24Nr66MmWHgv6iqHAy4hC0BJtyrjiZAwobJ+5YVKKF/Yyu0SCJ2WU
         da+baU13PnNpi8przZ1WgC1rFO2tmfsJy3wdAMECWJvhk66urR8prOyAt0yiTp/M313K
         uVQCp790LPVnWl3FGoM07CFtArammidTSHxvrUn6Yq7o9hkySjRjE1S1fVnENBpPLfmG
         I0ZW1f8H7CnR5zSHLuqb++0kaX/lbWMQMdZb9WpxEJE/q14UEJfRCagwgCpDCZwknieX
         4R6g==
X-Gm-Message-State: AOJu0Yx4hDp1R4FM+X5INJlUcwHXqGj7LvA4g3zQl6sYfMhc9LtWLQjF
        CNtD0aHgr2cn2erwM6v1T99RDEji8L0OgDJ3RzQgLQ==
X-Google-Smtp-Source: AGHT+IEyolZjfGkJMmzniA571qSWAQ1BD87u/IWRMEO++M7nad1th1Wn2dPp8AwzT6FUIh4dPaRcViOPJcnRyrmQYX0=
X-Received: by 2002:a17:907:77c2:b0:99b:f58d:1c49 with SMTP id
 kz2-20020a17090777c200b0099bf58d1c49mr3978899ejc.53.1694684642180; Thu, 14
 Sep 2023 02:44:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230913152238.905247-1-mszeredi@redhat.com> <20230913152238.905247-2-mszeredi@redhat.com>
 <20230914-himmel-imposant-546bd73250a8@brauner> <CAJfpegv8ZVyyZN7ppSYMD4g8i7rAP1_5UBxzSo869_SKmFhgvw@mail.gmail.com>
 <20230914-jeweiligen-normung-47816c153531@brauner>
In-Reply-To: <20230914-jeweiligen-normung-47816c153531@brauner>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Thu, 14 Sep 2023 11:43:50 +0200
Message-ID: <CAJfpeguJ+H7HkZOgZrJ7VmTY_GhQ5uqueZH+DL9EuEeX5kgXQw@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] add unique mount ID
To:     Christian Brauner <brauner@kernel.org>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-man@vger.kernel.org,
        linux-security-module@vger.kernel.org, Karel Zak <kzak@redhat.com>,
        Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Sept 2023 at 11:36, Christian Brauner <brauner@kernel.org> wrote:
>
> > Yes, one concern is that humans confuse the old and the new ID.
> >
> > I also think it makes sense to allow the new interfaces to look up the
> > mount based on either the old or the new ID.   But I could be wrong
>
> Hm, mount id recycling may happen so quickly that for service restarts
> with a lot of mounts this becomes mostly useless...

Agreed.  The old ID is mostly useful for human interaction.

>
> > there, since that might encourage bad code.  Maybe the new interface
> > should only use take the new ID, which means no mixed use of
> > /proc/$$/mountinfo and statmnt/listmnt.
>
> ... so I think that is indeed the better way of doing things. There's no
> need to encourage userspace to mix both identifiers.

Okay.

But I'd still leave the 2^32 offset for human confusion avoidance.

Thanks,
Miklos
