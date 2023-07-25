Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B66C762705
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 00:48:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232490AbjGYWs0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 18:48:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232079AbjGYWsH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 18:48:07 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F376959E0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:44:12 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso61457105e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1690324994; x=1690929794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UeN/BDzcT6fiIqPMLxrXSox3/PDpVZxEfiyL4rSFqMI=;
        b=FL8WmUqNhaZKbP12TYYkFJCjY6UeyaotamveIVjnM8lw3o9UNg/2xqcsjsi7FVgJm6
         3wZUUwVUeyBZO7Rg1EPn0vN3wjJgA3HcOuxhYcy0ny2QY35bgbE31z7tnMIjMbrLIJbd
         pMhTDfQUXaRnYrVzl+SvKv23ECDEjKNwO2zUc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690324994; x=1690929794;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UeN/BDzcT6fiIqPMLxrXSox3/PDpVZxEfiyL4rSFqMI=;
        b=QVNh1uZo+wRtdwTzGvu5kAujyjovn16e4uRzKSdHDGJmeNuDtURXvn2Z2qjGrAaU4/
         W428HCDqR92kgR8X/egSzuel8fpmBrJ4LA+jQ+eqIIu94Mw37MCAanzgYhdkdyuFQAgy
         WhPy5aWP4I2C+/vUevaeWyaEdULPVJTbx+paWqXFhE9Wuwn3JC1mAbXwpRXqDrFkrBZq
         adnn6ctZooKhWg6K/7NcnGVcCZON7SGHsuK1/uEh4opb0JHFChf0gg+HStHlay3M86cm
         xQXF0Jdpud4pAYvU7wtVwj78JX9FZawwTPgcLMEFVYa8J72U3pe9phO8astMUgriTGu8
         8RWg==
X-Gm-Message-State: ABy/qLYa84ezO/nc8/kKpTtQgD02D47/W9MCh8FMXpZns++2yYLG2I36
        4HsKDCl0WSZDCblRY6Tc1AtwaqZmRA56faD+s3SCc8cW
X-Google-Smtp-Source: APBJJlFj46I9jVsYAnhVeugdBcMatBZlnz3DqU/0Wcwv9EQNA/YF/0xDvYYzY3EAXZYjbCQbZTg+JA==
X-Received: by 2002:a05:6512:3452:b0:4fd:c844:6a43 with SMTP id j18-20020a056512345200b004fdc8446a43mr137028lfr.43.1690324314584;
        Tue, 25 Jul 2023 15:31:54 -0700 (PDT)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id q8-20020ac25288000000b004fcdf8b8ab4sm3034913lfm.23.2023.07.25.15.31.53
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 15:31:53 -0700 (PDT)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-4fdfefdf5abso2469326e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 15:31:53 -0700 (PDT)
X-Received: by 2002:a19:6903:0:b0:4f8:651f:9bbe with SMTP id
 e3-20020a196903000000b004f8651f9bbemr125999lfc.54.1690324313249; Tue, 25 Jul
 2023 15:31:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230724230329.3970-1-kirill.shutemov@linux.intel.com>
 <CAHk-=wipev18s9sErt+iNO_rzgyvGTce38fr1CYO0U_hGVGy2Q@mail.gmail.com> <6f56c604-7580-2d8b-cab0-ad656aa0728a@intel.com>
In-Reply-To: <6f56c604-7580-2d8b-cab0-ad656aa0728a@intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 25 Jul 2023 15:31:36 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgwLyksuRU0hjXKdas9-RHMmKQk5YB1xFn=64Ud_Tkb4A@mail.gmail.com>
Message-ID: <CAHk-=wgwLyksuRU0hjXKdas9-RHMmKQk5YB1xFn=64Ud_Tkb4A@mail.gmail.com>
Subject: Re: [PATCH] x86/traps: Fix load_unaligned_zeropad() handling for
 shared TDX memory
To:     Dave Hansen <dave.hansen@intel.com>
Cc:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 at 15:23, Dave Hansen <dave.hansen@intel.com> wrote:
>
> Feel free to pull it directly.

Ok, done. I edited the commit message a bit to clarify that we don't
actually _rely_ on that fault_address thing, but other than a slight
wording change it's all good.

And for some reason 'b4' didn't pick up your Acked-by: (maybe it
hadn't made it to the lore DB yet since I got the reply directly) so I
added that manually.

         Linus
