Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 331C9789FD2
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Aug 2023 16:56:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbjH0OvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbjH0Oum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 10:50:42 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13CA136
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 07:50:39 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-52a069edca6so3464991a12.3
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 07:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693147838; x=1693752638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Aur7k0McRiFXCUTD2gEOTvsFVl8EBmZX7s+nttC/DQI=;
        b=a6ELKFswxwSyE+EgI3MO3wA1KtAnk3QemRUwTI4gwwiVb2U3zO+TaDHl2ZDmvyC6rz
         24EwpRQv53W37rjYVuQGEMZBG5W06hIg4+ZtjlG2T5kSBHMopuISPklRrm8yTVugda/J
         bC7tXucAGHlA5goiZQTewNRpPsZF24u+8jMbQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693147838; x=1693752638;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Aur7k0McRiFXCUTD2gEOTvsFVl8EBmZX7s+nttC/DQI=;
        b=foBNoAyvSbHZ62/oJhFMNRqU5Eie7ZRrcro5MWBs6dSRl9bk4qe5uDOj2iSquAQlHE
         FK6RsW9zT9t3GdL1TVn1f67JPqQo80bv7AX7EY1BKANzOZ5OsXUkjqQLMdFXUZLcbDpS
         i+G8kwHgnekWUZod8DmPSsdSztWfEaPbFmLXfpj+tKcRSwHNtIkV/y+jNkMouZWQKkJn
         +KG3wdsdcqwi6kKD5+2tm1wZofUWve4TnfslOW9tRIwhlyTLrEuGZm/UzwCDcFRqFvTz
         l7ESmGBOOIGAMf5rKSRpFW8snDxsQn9cglfUiqMmCmBCvPIGnlfw6OpGNje2UGpFYR14
         oNVw==
X-Gm-Message-State: AOJu0YwJ+F/Bw9XCZvbDhWGdE1B+I2kAem5Rx4jogWpfqDH01JlqZQaW
        0N4WQU4/h+USQ1WesOmfRTSPIFgIokuP4sEZ5U0XEg==
X-Google-Smtp-Source: AGHT+IE8r/HjajlnltHZCLInA390zktAVwfcQYLjid33BxZU2CGAdIgnJ/1pk4OqYygL9fBw4DMecw==
X-Received: by 2002:aa7:c741:0:b0:525:73dd:4f71 with SMTP id c1-20020aa7c741000000b0052573dd4f71mr17653096eds.14.1693147837757;
        Sun, 27 Aug 2023 07:50:37 -0700 (PDT)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com. [209.85.218.47])
        by smtp.gmail.com with ESMTPSA id y9-20020aa7d509000000b0052239012c65sm3391805edq.82.2023.08.27.07.50.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 27 Aug 2023 07:50:37 -0700 (PDT)
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-99c3c8adb27so290807366b.1
        for <linux-kernel@vger.kernel.org>; Sun, 27 Aug 2023 07:50:37 -0700 (PDT)
X-Received: by 2002:a17:906:10dc:b0:9a1:bf00:ae4e with SMTP id
 v28-20020a17090610dc00b009a1bf00ae4emr13151173ejv.54.1693147836857; Sun, 27
 Aug 2023 07:50:36 -0700 (PDT)
MIME-Version: 1.0
References: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
In-Reply-To: <4fa74fe53f7a1302b1c4c7c4e17590aa97f9ecc5.camel@HansenPartnership.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 27 Aug 2023 07:50:20 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi=D=y2z9YQkbMMQpHsCqZaM0x54E78UAbiNBf8FGVRig@mail.gmail.com>
Message-ID: <CAHk-=wi=D=y2z9YQkbMMQpHsCqZaM0x54E78UAbiNBf8FGVRig@mail.gmail.com>
Subject: Re: [GIT PULL] SCSI fixes for 6.5-rc7
To:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Sun, 27 Aug 2023 at 00:01, James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Hmm. For some reason the pr-tracker-bot is not tracking.

So here's a manual, non-robot, "has been merged" message.

Konstantin, is everything ok in robot-land?

                Linus
