Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B293790285
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350676AbjIATiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 15:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350659AbjIATh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 15:37:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2E510E0
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 12:37:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-9a21b6d105cso293496166b.3
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 12:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693597075; x=1694201875; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=trT8rJs4itRMrUUN+r3Bs9PYSmOYVL0fzoG+3eNw/pM=;
        b=V0vEQnsgM9WQjhD24ZSG0BqpV/I19eVgKhlvu0ocEAQR3LwUCNWaHk5N/rqN5ziDMI
         P/z2KO+w53uioSze/wJvbf8KGlx03UWYJV4P6s9kyXLBQgryMdFD3tOHsNUtf1GPDvhu
         AsDjkM/BqP+KXzWMrAFMcWjLBGICEBBZLqm10=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693597075; x=1694201875;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=trT8rJs4itRMrUUN+r3Bs9PYSmOYVL0fzoG+3eNw/pM=;
        b=GE/pM0tg/gvQZwlaqBwNgfncD5EkpMGvmqIE5zGV5MEk4YAS/qlbRq3tYm+slqCKxO
         AvCiqw2tl2F4cijRIb0HbinydB1Emc+Lvw9ryTrXJ3qR6zeMQuR9pAdo/jSi7jynRfdn
         nGNGNrso9I8iPeJ6gWoGd8/6VTZX6fcAhNBhQe3CHJqjAsLcoWG3OPNF06PyyvmZwh/I
         Yq9Quh9K1iG5LejvLINvQk2GOv5O+rCmRJ3IIcyHzWjE1F/9hsxDIbLBpmxhfTaX9WBg
         ikH4Q8fNUl60uBRi2HUcBTHA8QqDs333kdDRybMsl42pCk3HdqlS3xp81itPbHtU8ZRq
         f++Q==
X-Gm-Message-State: AOJu0YzDjhDwnoxYayNXRv1uX6C6hYtQDUSMNQCUAh4+oXwLkPNsJfdL
        8boc5UwfLxqSNcXQROSEt/p7bJcQe+LEc1+E7+51w9N+
X-Google-Smtp-Source: AGHT+IF9Di4bCkSoKKvDzIDSYYB1wTIt0MFIOP1PsC1OcgI7q+m7JovWVbWvs/EitxwrawThZhfmUA==
X-Received: by 2002:a17:906:73d2:b0:9a5:c9a4:ba19 with SMTP id n18-20020a17090673d200b009a5c9a4ba19mr2658791ejl.47.1693597075381;
        Fri, 01 Sep 2023 12:37:55 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id a3-20020a17090680c300b009a19fa8d2e9sm2323243ejx.206.2023.09.01.12.37.54
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 Sep 2023 12:37:54 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-99c1c66876aso294355166b.2
        for <linux-kernel@vger.kernel.org>; Fri, 01 Sep 2023 12:37:54 -0700 (PDT)
X-Received: by 2002:a17:906:53cf:b0:9a2:ecd:d95d with SMTP id
 p15-20020a17090653cf00b009a20ecdd95dmr2244197ejo.68.1693597074340; Fri, 01
 Sep 2023 12:37:54 -0700 (PDT)
MIME-Version: 1.0
References: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
In-Reply-To: <rbbohtzjjqpbh7w6nmkqqoi2ca5jfl62sxtjyv5go5dock32yr@vslcd4yadpdg>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 1 Sep 2023 12:37:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=whQveTsVOJX9TVTBCtKLMun6spgC-MrSjKeowufariHKw@mail.gmail.com>
Message-ID: <CAHk-=whQveTsVOJX9TVTBCtKLMun6spgC-MrSjKeowufariHKw@mail.gmail.com>
Subject: Re: [GIT PULL] HID for 6.6
To:     Benjamin Tissoires <bentiss@kernel.org>
Cc:     Jiri Kosina <jikos@kernel.org>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 31 Aug 2023 at 07:37, Benjamin Tissoires <bentiss@kernel.org> wrote:
>
> - devm fixes that were now sending use after free in linux-next

Please double-check your pull requests.

I have no idea what that random set of words in a random order means.
It's not a sentence, and none of it makes sense.

I tried to make it a sentence based on the actual git commits I see,
but please try to make your pull requests more sensible.

            Linus
