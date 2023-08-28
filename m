Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721C578BB7B
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 01:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233320AbjH1X0L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 19:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233779AbjH1XZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 19:25:43 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67629114
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:25:37 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c93638322so781620466b.1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693265135; x=1693869935; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7vLv0ifrZ8NV3Dgr8q5p5pf4PMwIpobYCAqOSMCUur4=;
        b=Nsncds028UAi0inO0xgTWhmYZocMlI5GQHAEnFox7lN1opey96LY4GUeVyQCCoQJua
         5VijFikKN5O4QVqdxeLB55ZGFI/yLYV8woOVGti0ZAiZAfLBr3WTJaljCzI53QfKbPCB
         NEgJiXhPWNsPdEBm1yscucLkxF7O5u+2K5xW8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693265135; x=1693869935;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7vLv0ifrZ8NV3Dgr8q5p5pf4PMwIpobYCAqOSMCUur4=;
        b=HZN2/DB98JvdpypkIgWNcBIY/WYq0EWbcmWg0sZvS2qiRC9Y9iDALYtNVm/50olT33
         NlEQmU653Pt5b/c5cLXOuZYyon78TH5MplTChAtHHMZySA0K7ZNbmIS31A71HavvV+0K
         LKQY/ujiSPASeiuZXWrqWIpgZeFKvebLaJ+L5MInRUNkeoVfO6hWQTlBtfPdInqGr22R
         SIJfuR78wnUXiFtr3wpxd6imzYotekRBJGj6Y9//lAGkAcBi4+RYCRxM3QOfj7b5VIlB
         2eyJddt7deQyk3mLJduQjjbQ5prx70SSl7OTuGQ/xo8t6ZS8RBblHoVyqyp43TbeJEWL
         nEQg==
X-Gm-Message-State: AOJu0YyngVsYXj/9XabFStfFBa/WnGPQipX2pDuTNthVQYHOfujzD1jF
        DB0AMhOsj27udrjpznqaQe7EW3SDhpJMI8EpICtMWg==
X-Google-Smtp-Source: AGHT+IEqTjf+WIsx555hJpnsXILoEFh6NytkudCJsjl1NgbUo1Cv+HYqPlZZYuaARlcy369SPI9lXg==
X-Received: by 2002:a17:907:7295:b0:9a1:aaae:8207 with SMTP id dt21-20020a170907729500b009a1aaae8207mr1049227ejc.20.1693265135677;
        Mon, 28 Aug 2023 16:25:35 -0700 (PDT)
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com. [209.85.218.45])
        by smtp.gmail.com with ESMTPSA id g24-20020a170906395800b0099cd1c0cb21sm5238195eje.129.2023.08.28.16.25.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 16:25:35 -0700 (PDT)
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-9a1de3417acso994713866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 16:25:35 -0700 (PDT)
X-Received: by 2002:a17:907:6e90:b0:9a1:c35b:9e09 with SMTP id
 sh16-20020a1709076e9000b009a1c35b9e09mr1304406ejc.8.1693265134778; Mon, 28
 Aug 2023 16:25:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230828122533.GBZOySPQIjw25NiUqI@fat_crate.local> <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com>
In-Reply-To: <CAHk-=wjPNoHZm4ukpSXRCpxoCSb59GLgiDZBTgs-yn0=082TFw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Aug 2023 16:25:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgYsC7XcPRwekr5RcqAn4EkjyhpjzB34i-GfyVe-unTbA@mail.gmail.com>
Message-ID: <CAHk-=wgYsC7XcPRwekr5RcqAn4EkjyhpjzB34i-GfyVe-unTbA@mail.gmail.com>
Subject: Re: [GIT PULL] x86/microcode for v6.6-rc1
To:     Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
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

On Mon, 28 Aug 2023 at 16:09, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Please just let me know how much I messed up.
>
> I apologize in advance.

Ahh, I see that Ingo put it in <asm/processor.h> in the linux-next
tree. I'm not convinced it's any better than my <asm/microcode.h>
choice, but it does result in not needing another

  #ifdef CONFIG_CPU_SUP_AMD
 ..

thing, so...

Feel free to send me a follow-up patch to move that
amd_check_microcode() declaration to whatever the appropriate place
is.

           Linus
