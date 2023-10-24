Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF76E7D5D3E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 23:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344361AbjJXVeI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 17:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344360AbjJXVeD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 17:34:03 -0400
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C84D9D
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:33:15 -0700 (PDT)
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5822a990ea6so1986986eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 14:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698183194; x=1698787994;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ydoeA8bMPTFfL7KIyd2iImmXpydvV8NCmR/UYsYbpxw=;
        b=j/vQ1TRlyyAN3ie6yDV2ON86JkY3J4V/omrKYHJDvlMSmkkQYxK/dOcztYBugGEQbI
         jg0B21YFSFjJKJ1dW7g16CzC6LtTETAiKkcmQwwUvLnlVqdpgOx7PjFrh7mqWUmCBWse
         qi7poXyzmRgu1/+OqYuMuEkolNzljg3ttsjEa6qpCLrFUZqrHNs+g+bz83vfFTGgd6xs
         tcJPl1DmKDahVFD212Y6XGLeg39W7cy0QGUz2D16YzOICkY6ON+O9OscsztUWOpg9N+O
         dpH47GEnCbhhgwX4+vx0m+54+cFmNspI0jo8FMpWcwnwX6zU+95hZ8G7CFdHdRIV3Tb/
         QQZw==
X-Gm-Message-State: AOJu0YwRrnMVW6ZgQvPewqBSF24gpRwacfsc/MaGnpVxeLt+iAf6Cpol
        f0eV/guyI2uh+/tgbxsyG3PB
X-Google-Smtp-Source: AGHT+IFqScwwPuBCfU8gLwXESZj/TMXWuFnwg6pun1lrsaq6xPSm0Hu7AUgBAWsoFigBdJfZnWdsrw==
X-Received: by 2002:a05:6358:72a3:b0:168:e707:2e56 with SMTP id w35-20020a05635872a300b00168e7072e56mr4769109rwf.16.1698183194698;
        Tue, 24 Oct 2023 14:33:14 -0700 (PDT)
Received: from localhost (pool-68-160-141-91.bstnma.fios.verizon.net. [68.160.141.91])
        by smtp.gmail.com with ESMTPSA id e20-20020ad442b4000000b0065d1380dd17sm3840065qvr.61.2023.10.24.14.33.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Oct 2023 14:33:14 -0700 (PDT)
Date:   Tue, 24 Oct 2023 17:33:12 -0400
From:   Mike Snitzer <snitzer@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Alasdair Kergon <agk@redhat.com>, dm-devel@lists.linux.dev,
        Justin Stitt <justinstitt@google.com>,
        linux-hardening@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: dm crypt: replace open-coded kmemdup_nul
Message-ID: <ZTg4GA005km7mmgC@redhat.com>
References: <20230925-strncpy-drivers-md-dm-crypt-c-v1-1-eef875e4f9b2@google.com>
 <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169818232968.2100071.5806064081646325604.b4-ty@chromium.org>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24 2023 at  5:18P -0400,
Kees Cook <keescook@chromium.org> wrote:

> On Mon, 25 Sep 2023 06:35:54 +0000, Justin Stitt wrote:
> > kzalloc() followed by strncpy() on an expected NUL-terminated string is
> > just kmemdup_nul(). Let's simplify this code (while also dropping a
> > deprecated strncpy() call [1]).
> > 
> > 
> 
> Applied to for-next/hardening, thanks!
> 
> [1/1] dm crypt: replace open-coded kmemdup_nul
>       https://git.kernel.org/kees/c/17348b0a6a6d
> 
> Take care,
> 
> -- 
> Kees Cook
> 

Hey,

I had picked up this patch and the 3 others in my local tree
yesterday, was going to push shortly... do you still want them to go
through your hardening tree?

Mike


