Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2050F7BEB43
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 22:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378536AbjJIUIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 16:08:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378518AbjJIUIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 16:08:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3032694
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 13:08:09 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-693375d2028so4392925b3a.2
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 13:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696882088; x=1697486888; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=onOvRhiLbUo8zF+oHZNS91V/ID2PM4jpOE8wTF3XaLE=;
        b=P7s7KwRpWeRe56FOMFsQ3e2o4VTEMprHtKMlc84nuLrO3klY84UR6lLNcZr3CQtZs1
         pH7GtpUzpHU8qzsFFoacmdInj5K9ao6HiUXbV1lrHyYFcN0GtnQPYNcqF7hVzEJRxNZK
         9spgy1zxHhWLWe/G0SMtfYpQWXC2Bkgfevluk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696882088; x=1697486888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=onOvRhiLbUo8zF+oHZNS91V/ID2PM4jpOE8wTF3XaLE=;
        b=bcNkzUo+msg6z3OOCPP07/GhH46huTRUUrkORMVlWB9JxOL+jqoTlnlNMWs5n0P7gm
         ozGCD3sxVPinqu4/e5L7T4v174LYApxlMxalfEJyGcOyaWicIgtiT1+EXTWnu3zJIzIs
         BlSUiLqnFps618MEohriD8AdF7GTxGA/DY+5Hmq9XQIHVerR1r4gLsVBom0quuB0CwCR
         DBrkGoX213Qv3JjXx59YoHLhRiwbKUQQuJKnWaYDfL4hLWJJZxWcAKCYqx1vJThRvCH8
         nKyZjnstgUeIsnuV69k2I3Wgsduv7w2RSY8mUVVRz4jVxow/DM+n3RBHPCkCcP5byM5b
         idSQ==
X-Gm-Message-State: AOJu0YwVdvXKC5LpgcW4U2od/ZFucjpEHQ/nCEMJf6tNLtWBAGf7Lz9X
        pV/9Y4pwuatheji54RG18BZ88w==
X-Google-Smtp-Source: AGHT+IGr+BIYQMlA/kld0EK0UgQk/dbg8RRmpElpgIxCFYdre5mwVfD1dvtbeynxVg4bJgAtGyzdyQ==
X-Received: by 2002:a17:902:8343:b0:1bb:c06e:647a with SMTP id z3-20020a170902834300b001bbc06e647amr14356668pln.53.1696882088674;
        Mon, 09 Oct 2023 13:08:08 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id h10-20020a170902f7ca00b001bc445e249asm9974341plw.124.2023.10.09.13.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 13:08:08 -0700 (PDT)
Date:   Mon, 9 Oct 2023 13:08:05 -0700
From:   Kees Cook <keescook@chromium.org>
To:     yunhui cui <cuiyunhui@bytedance.com>, brauner@kernel.org
Cc:     jeffxu@google.com, akpm@linux-foundation.org, cyphar@cyphar.come,
        mcgrof@kernel.org, frederic@kernel.org,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Discuss the implementation of pidns_install()
Message-ID: <202310091307.CB416B950@keescook>
References: <CAEEQ3wnfOOpKAKGt07cFv1Du-NaFOzX_=yeQZfD6VNojpPFTqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEEQ3wnfOOpKAKGt07cFv1Du-NaFOzX_=yeQZfD6VNojpPFTqA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 20, 2023 at 05:37:20PM +0800, yunhui cui wrote:
> Hi Kees, jeff, Andrew, Christian,
> 
> We hope that containers at the same level can also switch pid namespace.
> To fork() the entire pstree of a container, we need to switch from the pid
> namespace of the template container to the  target container's pid
> namespace. But it is blocked by the following code:
> 
> ...
>         while (ancestor->level > active->level)
>                 ancestor = ancestor->parent;
>         if (ancestor != active)
>                 return -EINVAL;
> ...
> 
> Can we give this code permission, such as CAP_SYS_ADMIN ..., so that those
> with this permission can switch to sibling pid namespace. Rather than just
> parent, parent ...
> 
> Do you think this plan is okay?  Or can you give me some suggestions?

I'll defer to Christian on this, but it seems like moving processes
sideways is kind of unexpected. I agree it'd need privilege if we did
it, though.

-- 
Kees Cook
