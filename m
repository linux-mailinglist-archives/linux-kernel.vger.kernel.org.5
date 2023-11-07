Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC557E4A22
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234488AbjKGUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:52:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbjKGUwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:52:07 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A8A10CC;
        Tue,  7 Nov 2023 12:52:05 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-9dd6dc9c00cso670296666b.3;
        Tue, 07 Nov 2023 12:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699390324; x=1699995124; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=WHD9MrkpuzBL019+pu/tF6WpBjLY38oBJb9Q97KwJZg=;
        b=Ann4Lzmyb5bPhQd2W9rrCzth3Mfn1NCEohPC6HaqYDWmdetSwp/YppUD/jIezncHPH
         JUtGKgjxoPC5QPsA9HLo3iGAkLdJGwE8UJFjrp1P4Fw1lnLsAlk7FZmWomQTn1aWf2PS
         4PL+DLwXX+85g8jVzuLrh5bXCatTIZd4hY9lfrAnytYaw2WBhhlvNkq5r+Q8qk5+zjms
         07vWtdQ/lG81R6fZ57LRfhINQWhAAEwRaXDcx0rYnd6Qbc+Z41CKT/GmAed6r7eomh/k
         /GbTuaRv59HfiAwJgBVYJRPWzVkOVrBE76aeQZtzsExHvxmQXMUFBVezr69RDX1BFkfO
         l8FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699390324; x=1699995124;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WHD9MrkpuzBL019+pu/tF6WpBjLY38oBJb9Q97KwJZg=;
        b=X5dKrBfF13vk7B/pAoV+br7evpMu7FC0n4/tm14nyuU+FgFyqQDJSFCSljrlPq1uQ3
         6PAloMAVrKNEtWLZGZGedAxmPLzlxaupqKMPuXxc6EecERoqHTsAJf5YCjVSv5mUsqzd
         Or3qyNOwZFF/h6DEGQ50jsTIa9ZRGK4qI4ROMdAF5gcGUtofF4RHRAGPgiN7dvlsUzgk
         NZHQKFTBialgoFRFqnTLpm1UdNcOR5SvDGZCkUjcgZyUCW7zfHPiechUUaIISo9/Cb5W
         p6aksoRuMmsCj+O9E5PNDFyJXI+TkjRC46qSIuCjestwM582ganZv4O0f1+rikHHUdL/
         D9qA==
X-Gm-Message-State: AOJu0YyCGOH9su3zScKO79GAEP+MjtdDjLMemsWhVXELm27fVO/64Xue
        nzxWz2cLrvUUma6AoytRc8E=
X-Google-Smtp-Source: AGHT+IG35rCRFP1xAW5DdWqensQUZSKqgaN9Hs6rsm7Y6CDppdeyoIBUF1TV9TlFDZofLDwNdzIF+A==
X-Received: by 2002:a17:907:d502:b0:9db:e46c:569 with SMTP id wb2-20020a170907d50200b009dbe46c0569mr12135731ejc.45.1699390323535;
        Tue, 07 Nov 2023 12:52:03 -0800 (PST)
Received: from f (cst-prg-81-17.cust.vodafone.cz. [46.135.81.17])
        by smtp.gmail.com with ESMTPSA id t27-20020a170906179b00b009a1dbf55665sm1534eje.161.2023.11.07.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 12:52:03 -0800 (PST)
Date:   Tue, 7 Nov 2023 21:51:51 +0100
From:   Mateusz Guzik <mjguzik@gmail.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <20231107205151.qkwlw7aarjvkyrqs@f>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202311071228.27D22C00@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 12:30:37PM -0800, Kees Cook wrote:
> On Fri, Sep 16, 2022 at 02:41:30PM +0100, Josh Triplett wrote:
> > Currently, execve allocates an mm and parses argv and envp before
> > checking if the path exists. However, the common case of a $PATH search
> > may have several failed calls to exec before a single success. Do a
> > filename lookup for the purposes of returning ENOENT before doing more
> > expensive operations.
> > 
> > This does not create a TOCTTOU race, because this can only happen if the
> > file didn't exist at some point during the exec call, and that point is
> > permitted to be when we did our lookup.
> > 
> > To measure performance, I ran 2000 fork and execvpe calls with a
> > seven-element PATH in which the file was found in the seventh directory
> > (representative of the common case as /usr/bin is the seventh directory
> > on my $PATH), as well as 2000 fork and execve calls with an absolute
> > path to an existing binary. I recorded the minimum time for each, to
> > eliminate noise from context switches and similar.
> > 
> > Without fast-path:
> > fork/execvpe: 49876ns
> > fork/execve:  32773ns
> > 
> > With fast-path:
> > fork/execvpe: 36890ns
> > fork/execve:  32069ns
> > 
> > The cost of the additional lookup seems to be in the noise for a
> > successful exec, but it provides a 26% improvement for the path search
> > case by speeding up the six failed execs.
> > 
> > Signed-off-by: Josh Triplett <josh@joshtriplett.org>
> 
> *thread necromancy*
> 
> I'll snag this patch after -rc1 is out. Based on the research we both
> did in the rest of this thread, this original patch is a clear win.
> Let's get it into linux-next and see if anything else falls out of it.
> 

So the obvious question is why not store lookup result within bprm,
instead of doing the lookup again later.

Turns out you had very same question and even wrote a patch to sort it
out: https://lore.kernel.org/all/202209161637.9EDAF6B18@keescook/

Why do you intend to go with this patch instead?
