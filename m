Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E647C7F5211
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:09:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbjKVVJH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:09:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbjKVVJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:09:05 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F10D1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:09:01 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-9fffa4c4f43so24387566b.3
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:09:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700687339; x=1701292139; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DjZ3A9RnpMc/0GPOf8DzrpfaMDka4vJ8RxujHh4ePRw=;
        b=TyL8aRoSG8W7XCbwEkgeGlsgn+vGank7QpQhJ5G48NdXyNih9MMcRA91/5NySZ3aCU
         ZEKXp/p+5UqVZCAS99U+93rWr2AUxe3FEu7R52AgXJ90GGAAQ8l7ZPTHDtS/u5eje6JD
         ZMjwHuwJI+xxgVUvknlTs+KDvQBcfAgXAIj40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700687339; x=1701292139;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DjZ3A9RnpMc/0GPOf8DzrpfaMDka4vJ8RxujHh4ePRw=;
        b=PdGuG1YCPUXkG88sco7zKvWoasIcSTyyaqgZlEvSDwkzBAlnwLvyfSLqdy+0TEXWmd
         g0I6HvLvOw+sAeREPcvQKYktqnkeEkclN4Be54YHGcim8oN65SNIchjNIgFLgOKAug7Y
         4JP/oLZpvG2QjZcV2FAHXj1vcRP+MIEmA7kn9BYWwHjyeB+UKaIKUau+VA009RjQzrM9
         WaHkVXmQzg+hPmPwD391o5b6jDE4mHde1MAlJqzwxC8NdWnNifqdv/Fu3KTIBcK59rOy
         +eeJJS985dM4BWcMHBx9luaN3ro6ji3ew7WweqUUQNtEt06B/GypZFXP9JdfxNPS7ovy
         w+ug==
X-Gm-Message-State: AOJu0YwvcFJrbIrnvm0ImMqxT+YARL7z+xg/zigfow5XDWcS335FZZOB
        wMlA6f3EbkIWTodei/mqT6MLIy5i+obc/wuL75iPRlHH
X-Google-Smtp-Source: AGHT+IHt8IuB/xYA6vUIxi17WgUp6M03hfI65AHIOjAsoD3V9UXubxe9DyD34IFRT+UNCq2m1hZp8A==
X-Received: by 2002:a17:907:371:b0:a02:9700:bf53 with SMTP id rs17-20020a170907037100b00a029700bf53mr2402562ejb.46.1700687339642;
        Wed, 22 Nov 2023 13:08:59 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906328d00b009a193a5acffsm211903ejw.121.2023.11.22.13.08.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 13:08:59 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5488bf9e193so279956a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:08:58 -0800 (PST)
X-Received: by 2002:aa7:d050:0:b0:53e:1825:be81 with SMTP id
 n16-20020aa7d050000000b0053e1825be81mr2626539edo.21.1700687338666; Wed, 22
 Nov 2023 13:08:58 -0800 (PST)
MIME-Version: 1.0
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info> <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info> <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info> <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
 <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com> <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
In-Reply-To: <20231122205135.GGZV5p157mBi6RYUNs@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Nov 2023 13:08:41 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
Message-ID: <CAHk-=wh03jMZRAxHFTkv0h9dZ6TmiqukzcHd4RTx7ijia_prsg@mail.gmail.com>
Subject: Re: [regression] microcode files missing in initramfs imgages from
 dracut (was Re: [PATCH] x86: Clean up remaining references to CONFIG_MICROCODE_AMD)
To:     Borislav Petkov <bp@alien8.de>
Cc:     Linux regressions mailing list <regressions@lists.linux.dev>,
        lukas.bulwahn@gmail.com, dave.hansen@linux.intel.com,
        hpa@zytor.com, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Nov 2023 at 12:51, Borislav Petkov <bp@alien8.de> wrote:
>
> My only worry here is that we're making a precedent and basically saying
> that it is ok for tools to grep .config to figure out what is supported
> by the kernel. And then other tools might follow.

Yes, I agree that it's not optimal, but I would hate to have some odd
"let's add another ELF note" churn too, for (presumably) increasingly
obscure reasons.

It looks like dracut has been doing this forever, and in fact back in
2015 apparently had the exact same issue (that never made it to kernel
developers, or at least not to me), when the kernel
CONFIG_MICROCODE_xyz_EARLY config went away, and became just
CONFIG_MICROCODE_xyz.

The whole "check kernel config" in dracut seems to go back to 2014, so
it's been that way for almost a decade by now.

Honestly, I think the right approach may be to just remove the check
again from dracut entirely - the intent seems to be to make the initrd
smaller when people don't support microcode updates, but does that
ever actually *happen*?

There are dracut command lines, like "--early-microcode" and
"--no-early-microcode", so people who really want to save space could
just force it that way. Doing the CONFIG_xyz check seems broken.

But that's for the dracut people to worry about.

I guess we on the kernel side could help with "make install" etc, but
we've (intentionally) tried to insulate us from distros having
distro-specific installkernel scripts, so we don't really haev a good
way to pass information down to the installkernel side.

It *would* make sense if we just had some actual arguments we might
pass down. Right now we just do

        exec "${file}" "${KERNELRELEASE}" "${KBUILD_IMAGE}" System.map
"${INSTALL_PATH}"

so basically the only argument we pass down is that INSTALL_PATH
(which is just "/boot" by default).

            Linus
