Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDA777A4975
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 14:21:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241853AbjIRMUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 08:20:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242005AbjIRMU1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:20:27 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9F97FF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:20:08 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3a9ee3c7dbbso2923897b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1695039608; x=1695644408; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wJ/RnGWVlYXjsYT2wHH8A/bPUFSgIF9iFkS7fZpZUgg=;
        b=YYqUufJuc0c2gUq3T4K/nNaVOlESAu+hSXbRk1FKOvjnEqS6+J1RcTPzhk9A0CsLEJ
         XjgM+Yx9yWe4c7w+dHUwa0hVcK5J+xTtfDqJArIYmIorjZU3YaXEg68IA6JWauofuApR
         Kb9Sl/nxMGDhzcKxMYF0n2KHvPuWcYOMmFIABPKpSmbJpFtUTPQT07dXIGvR2YT+6kZO
         4ezB9/kxW/qQc84ANG+kQuTR+v3UbY82jLHJ5PYpw/+0wj9xmoLTF9Tb6jH8sZR8rV3E
         OsE08NXE1ZdkmV+YdzRJ1wq5tvlcVoRYfoTsZycwpStjT0QQ81cGuUmHEsGg+yzrAgw9
         mLyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695039608; x=1695644408;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wJ/RnGWVlYXjsYT2wHH8A/bPUFSgIF9iFkS7fZpZUgg=;
        b=WKjzn5C2G7PArYEkQo6vIfAkKytT3twprCSr8rF3JESt5fcmO5w9kAzIa3jUng3HOO
         xMTSSWWc6jCaWmkpCYndIbzVN9oGy+LN4GKeGQtH4Ok9vI4ReX5LVTwLg8Oy0SYkMxDS
         IieE0S8PCzezMTsPP2EM9AjCLFU+Nnc8Oho7nPngjCDlomEoqAnd19mvyUAsDq+f9j7O
         wXHcUbqE7G3W91wV0s9DXjPtySNLDiOjgAiBaH6MYJ4qO6jE/FcUQm7zr7m3vh1ORZgz
         WyjiuFz/kHz+lZA0mbeN6mLBisANVZH7ms3KSzDCIfWZmf4q20IVpgjevRUJkdcYaXKX
         yi0A==
X-Gm-Message-State: AOJu0YyeqYwEH8c4qYGc97MgcpIRWkMN8Kr/IbyIw5sQgIjyvYLZi0rc
        oS0KWRSPwHj6VDDBUwaZW/86gTuZUBV44+p8Ngl7Zw==
X-Google-Smtp-Source: AGHT+IH4QInl/j5+gGf/Cu4Jd0o/JiZS8iO20fPzFtf4EWnwwCOCLo+sv7ujZymbloG1cGj+fly8h6Plt0tgKbwj9Mg=
X-Received: by 2002:a05:6870:d784:b0:1d6:5e41:a8a1 with SMTP id
 bd4-20020a056870d78400b001d65e41a8a1mr10689149oab.27.1695039607944; Mon, 18
 Sep 2023 05:20:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230916021835.never.147-kees@kernel.org>
In-Reply-To: <20230916021835.never.147-kees@kernel.org>
From:   Matteo Rizzo <matteorizzo@google.com>
Date:   Mon, 18 Sep 2023 14:19:57 +0200
Message-ID: <CAHKB1wK5MPG8k2ij-bQLwES7Ytp0h2wE2jp5Cs6CJ3o_sOKDTg@mail.gmail.com>
Subject: Re: [PATCH] x86/mm/dump_pagetables: Add SLAB_VIRTUAL knowledge
To:     Kees Cook <keescook@chromium.org>
Cc:     Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Sept 2023 at 04:18, Kees Cook <keescook@chromium.org> wrote:
>
> Add the markings for the SLAB_VIRTUAL area.
>
> Feel free to collapse this into the x86 patch from the above series.

Thanks! I will add it to the next revision of the series.

--
Matteo
