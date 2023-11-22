Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC53F7F51C8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 21:36:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344021AbjKVUgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 15:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjKVUgV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 15:36:21 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28396112
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:36:16 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a640c23a62f3a-a02cc476581so17880466b.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:36:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700685374; x=1701290174; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MTFW+4h4lZJz6rbXAaizRdJw1t8O20ELX/WfD27HXjM=;
        b=iL7k/MxKz93XWTxiuAXIXhZe6aGQGrmJ1K9ihaq2M2Jwsj85MoNk1Ctw6X7/Lcd4eg
         9WSw61PsrjB33WlFl6eOEP2jf3NfkLcO3Hdq6LjrLV68cAdjThJpxlcIV7iHaaqE8nXI
         SCXKXqxjF+Isd0/ypOeHHZI+sq6IZe9yF9oPc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700685374; x=1701290174;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MTFW+4h4lZJz6rbXAaizRdJw1t8O20ELX/WfD27HXjM=;
        b=K+I4PnmPFkZzsrSJRFa3hgbPhdTQv7tK++8O8+MEJC7ugUkv3qW5dn+M0tztdsOuPO
         lc78smP3TASNCd5lAsKDHnLXunOHRpvlbLJvwZgxPum+VQUYcOJ4OTx+pN0PCpJabYIo
         aJ1TQ2A+h5SpG0LHvcbe6P5r7p/cIh6vM2y3jMktZDqYuiqqBRluLZnlrxwkA5myO/bB
         AAmHMfGbU6Xg/GgtLU0UVlbDsD68pLBxrlMjeqHnEVk5pAG6S8ZmgEZUWoK3BQ6YKyUF
         f9NytY5zzweU7YclQdCMEKXhT1iBvThDzMnmnW6VyGf6KR/n75HE6BswGUMcNe2y3dqP
         ymwg==
X-Gm-Message-State: AOJu0Yx3opxyj+Al/lDrTii5mtRLEak9CplG6EY6STZn+o4k5jNM8avk
        1NhGANqtesEZ6+jMuscEutR4sffHv+sf8+CqGjM0vHSJ
X-Google-Smtp-Source: AGHT+IFl986I2y9LwjiOnpeE1oOtrACTnv167fXyNA5xGMXk+PbLI7Gqm3LspDNRuykGyZkQKpoyGg==
X-Received: by 2002:a17:906:292:b0:9e6:bcd2:14b5 with SMTP id 18-20020a170906029200b009e6bcd214b5mr959842ejf.46.1700685374308;
        Wed, 22 Nov 2023 12:36:14 -0800 (PST)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id v3-20020a1709067d8300b00977cad140a8sm180580ejo.218.2023.11.22.12.36.12
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 12:36:13 -0800 (PST)
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-548f0b7ab11so290669a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 12:36:12 -0800 (PST)
X-Received: by 2002:a05:6402:34c5:b0:548:615c:33aa with SMTP id
 w5-20020a05640234c500b00548615c33aamr2977402edc.20.1700685372660; Wed, 22 Nov
 2023 12:36:12 -0800 (PST)
MIME-Version: 1.0
References: <20230825141226.13566-1-lukas.bulwahn@gmail.com>
 <c67bd324-cec0-4fe4-b3b1-fc1d1e4f2967@leemhuis.info> <20231112181036.GBZVEVHIIj/Oos1cx4@fat_crate.local>
 <0e9cbe6f-ac6c-47f2-b663-a22568799eca@leemhuis.info> <20231122115826.GAZV3s4krKXI002KQ0@fat_crate.local>
 <e1ca042c-de1d-4fe3-ad69-51d147b1fe0b@leemhuis.info> <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
In-Reply-To: <20231122155758.GEZV4lBgtZyzsP5Z4V@fat_crate.local>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 22 Nov 2023 12:35:54 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
Message-ID: <CAHk-=wiV+NM+jLKbSj_Ej9RaXpu4akWV03G_wXyTSHZhArq1tg@mail.gmail.com>
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

On Wed, 22 Nov 2023 at 07:58, Borislav Petkov <bp@alien8.de> wrote:
>
> IMO, yes, we should not break userspace but dracut is special. And it
> parses willy nilly kernel internals which are not ABI to begin with.

I don't think the "dracut is special" is the thing that matters.

The real issue is that hey, if dracut in its incompetence doesn't
include the microcode on the initrd, that doesn't really matter much.
It's fairly easily fixable, and at worst it will mean that we end up
having CPU mitigations that aren't optimal. Since most of those are BS
anyway, it really doesn't seem critical.

Sure, it's a "regression" in that you don't get the microcode update
included, but from a user perspective things should still continue to
work.

End result: this seems to be pretty solidly a distro issue.

IOW, the whole "users are the only thing that matters" pretty much
means that it's a non-issue. Things continued to work, to the point
that I'm actually surprised anybody even noticed.

That said, I don't think some ELF note is the fix either. I think we
might as well leave it at CONFIG_MICROCODE. Maybe add a note in the
kernel Kconfig that this thing matters for dracut.

Dracut also checks for CONFIG_ACPI_INITRD_TABLE_OVERRIDE. It's a
similar "normal users don't care".

              Linus
