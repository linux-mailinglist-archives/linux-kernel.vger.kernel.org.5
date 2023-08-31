Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318B678F309
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 21:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345236AbjHaTEF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237445AbjHaTEF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 15:04:05 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E88EE6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:04:01 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5280ef23593so1499608a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1693508640; x=1694113440; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MxGEoM6NvMI83xhY8G/ImCWZyFVY8xF2ffN+doaTRi0=;
        b=KhgLzpCYjpxbyaSXMPtJJDXy56CWpI0HSMYo01C/wsL2jw4Avp+/shatNnyP4VpgZv
         +ksX9D3wMbi8/zubUzc4GgSdgOD5o5CZoWYcaMiyYd4aaz9INhizWFrRzdE8XzMPxJTV
         Ki9RrwQWkG9xC6r7DAXHb3uvljeflKXT1kUY8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693508640; x=1694113440;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MxGEoM6NvMI83xhY8G/ImCWZyFVY8xF2ffN+doaTRi0=;
        b=hhAHkd3P2jLO5QIsAsq7mKLE+6cEoRFuEjxHbTcGHZyPq28NBTde/zvLVv8izZYhZl
         L23k4t+Cgapby/6IiNNuY/ZocjfC45/i78pxR3/KuGdXFE42GmmDkBq4BCpHM4zaQKis
         96ogbShbC7CR4xwB6qSBpQMVHHeeo+K3pNw3foxa1NDhdUR/UwoJPP1TKJk47mNgx0qc
         Wj3S2SwNBc239N2Od7OWdhMalZXF2WJ+9JUNBfZGJKzHRJhr3WlTiBeCH2TrnVxh05bI
         xZbHjlMze/1/irn/suQybGMuvfg3eY7hW6Pm9uurNHzNcQgFCSgFlg//VmD/g5lPOsp2
         UZ9g==
X-Gm-Message-State: AOJu0YxfB4nfh7/ptc6W3cNsTAsdrKn92OzZta/gIm9K219DBuatat2n
        gZqkODQfh1m71KIFfbv1cZrw7NZZnR+Tyzicx1S0I6K1
X-Google-Smtp-Source: AGHT+IFM3iTYhcbhZolSgfZFzBRag5kNzPBWTqsb/PxwRI+d6ai/1HnhwJFG+awqAw7csNDw7g4tEA==
X-Received: by 2002:aa7:d911:0:b0:522:4cd7:efb0 with SMTP id a17-20020aa7d911000000b005224cd7efb0mr352454edr.17.1693508639938;
        Thu, 31 Aug 2023 12:03:59 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id z14-20020aa7c64e000000b00528922bb53bsm1115795edr.76.2023.08.31.12.03.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Aug 2023 12:03:58 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-31977ace1c8so1009788f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 12:03:58 -0700 (PDT)
X-Received: by 2002:a5d:5242:0:b0:315:8a13:ef17 with SMTP id
 k2-20020a5d5242000000b003158a13ef17mr269497wrc.65.1693508638437; Thu, 31 Aug
 2023 12:03:58 -0700 (PDT)
MIME-Version: 1.0
References: <ZPDgdGBbxrTl+m2s@debian>
In-Reply-To: <ZPDgdGBbxrTl+m2s@debian>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 31 Aug 2023 12:03:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
Message-ID: <CAHk-=wg4vpuourbbUPn19yFx2cNj93O6t0PhiARLLL6z22yV4Q@mail.gmail.com>
Subject: Re: mainline build failure due to 501126083855 ("fbdev/g364fb: Use
 fbdev I/O helpers")
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev
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

On Thu, 31 Aug 2023 at 11:48, Sudip Mukherjee (Codethink)
<sudipm.mukherjee@gmail.com> wrote:
> The latest mainline kernel branch fails to build mips jazz_defconfig with
> the error:
>
> drivers/video/fbdev/g364fb.c:115:9: error: 'FB_DEFAULT_IOMEM_HELPERS' undeclared here (not in a function); did you mean 'FB_DEFAULT_IOMEM_OPS'?
>   115 |         FB_DEFAULT_IOMEM_HELPERS,
>       |         ^~~~~~~~~~~~~~~~~~~~~~~~
>       |         FB_DEFAULT_IOMEM_OPS
>
>
> git bisect pointed to 501126083855 ("fbdev/g364fb: Use fbdev I/O helpers").
>
> Reverting the commit has fixed the build failure.
>
> I will be happy to test any patch or provide any extra log if needed.

Would you mind testing the exact thing that the compiler suggested?

So instead of the revert, just replace FB_DEFAULT_IOMEM_HELPERS with
FB_DEFAULT_IOMEM_OPS.

I think it's just a typo / confusion with the config variable (which
is called FB_IOMEM_HELPERS).

               Linus
