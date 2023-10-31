Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C962A7DC652
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 07:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235879AbjJaGNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 02:13:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235555AbjJaGNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 02:13:13 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2B8128
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:13:11 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53d8320f0easo8558823a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:13:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1698732789; x=1699337589; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GgoxWh+3mFmu9qGS5n4klAc9TWzAx3QMY9929RDoymk=;
        b=fxMnBbrnp1Sbak7YSMus263BayDnXXpjuTt19N/2e/PKT1YmRI3z33TlW/U1gV4eMd
         PQgTsQhNgM8TYnKAV/W/oCtG2Ow05+NtPGX4wZ+LU/FT9y5Xv54dkoX0GQCL8HIAbMXb
         uudS7+yBAi2vGGagroc0T7CmNVRC8hph2jMOs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732789; x=1699337589;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GgoxWh+3mFmu9qGS5n4klAc9TWzAx3QMY9929RDoymk=;
        b=Y5sxJ8Afzv+ENHK7IHjXkWM38AHTN3mnaaIesywx7xPcsQ+cskRMoz03hQuqKiJZMJ
         4/6/3SQCLKWjt0dlFEB0vl+e9KcDtVxe4BnvLW4u/tI/CELVMQMo3NXeAHG3AWISy47s
         eHnvIiEdyITgRDISknsCfzK6MDQ8sEvtuww48FAbuC5+FzIb2yJJThKIeWRQas9uQTUD
         uiin3DTVdOP8bI6rugN4N9KaCdKwvHm7JQIiRJI9aOSAcWg7kV3PEkQE7u+Fr+xdqqLo
         7wCCOQ8/ArfWPtf4pSBTT49uWp5tCS5tOitpLDI7WE2QDqhOwZ2MXvZ28S1LzeuMW6Ro
         VwHw==
X-Gm-Message-State: AOJu0Yw9uy/0lQf/BEj/b3GOIFaCUC8tIuxTScisgH98nJC02EyjXlfK
        E0cB/WusNqDBXVSz8Fd6LWtaYyGAPhQCnvJ9ECaFJA2G
X-Google-Smtp-Source: AGHT+IHeSa0ZE0xjLmIswOBz1btgGnZ21bmkLXDWsGqzKXb7zEh1iv5N2neLaXy/qJ5zx3OZrHJLQQ==
X-Received: by 2002:a50:d7c2:0:b0:543:5c2f:e0e6 with SMTP id m2-20020a50d7c2000000b005435c2fe0e6mr1375639edj.17.1698732789489;
        Mon, 30 Oct 2023 23:13:09 -0700 (PDT)
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com. [209.85.208.47])
        by smtp.gmail.com with ESMTPSA id v4-20020a50a444000000b00533dd4d2947sm546184edb.74.2023.10.30.23.13.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 23:13:09 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-53e04b17132so8606579a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 23:13:08 -0700 (PDT)
X-Received: by 2002:a17:906:99c1:b0:9c7:4d98:9847 with SMTP id
 s1-20020a17090699c100b009c74d989847mr10898273ejn.53.1698732788596; Mon, 30
 Oct 2023 23:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
In-Reply-To: <78932582fa556fd5fd6e8886e80e993f.paul@paul-moore.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 30 Oct 2023 20:12:51 -1000
X-Gmail-Original-Message-ID: <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
Message-ID: <CAHk-=whOtZK1g_dzEnb5NEB8ssNqotmHy3CkUwbnab_4phFRdw@mail.gmail.com>
Subject: Re: [GIT PULL] selinux/selinux-pr-20231030
To:     Paul Moore <paul@paul-moore.com>,
        =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     selinux@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Oct 2023 at 16:16, Paul Moore <paul@paul-moore.com> wrote:
>
> * Use a better hashing function for the SELinux role tansition hash
>   table.

Bah.

While the old hash function was garbage, the new one is quite expensive.

Maybe it's worth it.

But generally, if you find that "oh, just doing a modulus with a power
of two drops all high bits", the first thing to try is probably to
just do "hash_long(x, N)" to get N bits instead.

Assuming the input is somewhat ok in one word, it does a fairly good
job of mixing the bits with a simple multiply-and-shift.

Yes, yes, jhash is a fine hash, but it does a quite *lot* of (simple)
ALU ops. While "hash_long()" is often small enough to be inlined.

I also note that filenametr_hash() does the old "one byte at a time"
hash and partial_name_hash(). Is there any reason that code doesn't
use the "full_name_hash()" which does things a word at a time?

Probably doesn't matter, but since I looked at this to see what the
new hashing was, I noticed...

            Linus
