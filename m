Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECEB7671EA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 18:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjG1Qgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 12:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232690AbjG1Qgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 12:36:41 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D3F449F
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:36:40 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-78363cc070aso98603439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 09:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690562199; x=1691166999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pwuk8n2meTmgvaIWDWJy7EuvwYQ64eRgecrm4y1w17k=;
        b=SWPY2tUUJSQCZkOIDu9QqwbUhSi3TbL98uTaogGk+nOz8f8Po9HLZ8NRM0LaZtwU6J
         EVUt49ElZceER3ZEy8HzJSdGOS6ChufL8Zv6CoakN1k1buZeWHX6Pgv8n37d2LlChDc3
         7+bklvKaPGvdM0conpLDEavYCshJezTz/lWX2T0gVrpxrnUL00NdMSPhevX4yeegCW6Y
         tLaF4jWwFhZ10dA2ORGcbJ/Xg6G6ExcwmRgStwi12KylBDaSmQGSr9V4mtIGCFX4FFAs
         5qomrN9siD+SqIjpUYBRGqI+rnIG/tBGBVEd3v0Y952k9UuxN2mEUPchre7vOn7IxeAt
         eCyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690562199; x=1691166999;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwuk8n2meTmgvaIWDWJy7EuvwYQ64eRgecrm4y1w17k=;
        b=BqL/SPyCnDTQdLiKQttZmP6Xe1fd7U94hcN/atuVRDV00dmRHsy9z7Oqhfnzte232I
         VPPEIXvqgx2IRP74qK3WcaqFmlZX29vnr+8ly24FLJpPJbZRc4KawAxlah6LaRSllOne
         26zSDPaxyY6ergHZjsSaCoVRorapB9cU/cIlAZg8gK4XABUmloTgCKe4kDqMKpEhuzLa
         fM78v4YJm9oUQjXiaRLKOUThqYiPA6yX9WVQdCQnWJSc7ApQ6aTkGYJN0yk++TwsYOiV
         LJKm09FWFH1MXyM0kCJ/cnU5IGFIMJUg5+4Mw21j05gaddulkz0LdP9jU7oo3weibVkY
         E9sg==
X-Gm-Message-State: ABy/qLb8XpHET0D24XTsHCS/gXLDRdEiL4mvaOXIMLF8O0UlIg/FcCgA
        HFPDY4LNlvEMiymH7u56zuU=
X-Google-Smtp-Source: APBJJlFvd4z/Ast/aDVCxLeomNbM7cTmlFllJyS7UQgiejuKqm5RL1gN767xhggYfVHfqoo6IvWAjQ==
X-Received: by 2002:a92:cd8e:0:b0:348:8b32:976e with SMTP id r14-20020a92cd8e000000b003488b32976emr100916ilb.2.1690562198968;
        Fri, 28 Jul 2023 09:36:38 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a14-20020a02ac0e000000b0042b67b12363sm1166913jao.37.2023.07.28.09.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 09:36:38 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Fri, 28 Jul 2023 09:36:37 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Rik van Riel <riel@surriel.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@meta.com
Subject: Re: [PATCH] mm,memblock: reset memblock.reserved to system init
 state to  prevent UAF
Message-ID: <fcb2fbc2-a26e-486f-b6e4-4574774f476f@roeck-us.net>
References: <20230719154137.732d8525@imladris.surriel.com>
 <8a48adce-3ad5-4793-8ca6-0b9f59e14665@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a48adce-3ad5-4793-8ca6-0b9f59e14665@roeck-us.net>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:09:09AM -0700, Guenter Roeck wrote:
> Hi,
> 
> On Wed, Jul 19, 2023 at 03:41:37PM -0400, Rik van Riel wrote:
> > The memblock_discard function frees the memblock.reserved.regions
> > array, which is good.
> > 
> > However, if a subsequent memblock_free (or memblock_phys_free) comes
> > in later, from for example ima_free_kexec_buffer, that will result in
> > a use after free bug in memblock_isolate_range.
> > 
> > When running a kernel with CONFIG_KASAN enabled, this will cause a
> > kernel panic very early in boot. Without CONFIG_KASAN, there is
> > a chance that memblock_isolate_range might scribble on memory
> > that is now in use by somebody else.
> > 
> > Avoid those issues by making sure that memblock_discard points
> > memblock.reserved.regions back at the static buffer.
> > 
> > If memblock_discard is called while there is still memory
> > in the memblock.reserved type, that will print a warning
> > in memblock_remove_region.
> > 
> > Signed-off-by: Rik van Riel <riel@surriel.com>
> 
> This patch results in the following WARNING backtrace when booting sparc
> or sparc64 images in qemu. Bisect log is attached.
> 

Follow-up: On sparc64, this patch also results in the following backtrace.

[    2.931808] BUG: scheduling while atomic: swapper/0/1/0x00000002
[    2.932865] no locks held by swapper/0/1.
[    2.933722] Modules linked in:
[    2.934627] CPU: 0 PID: 1 Comm: swapper/0 Tainted: G        W          6.5.0-rc3+ #1
[    2.935604] Call Trace:
[    2.936315] [<00000000004a0610>] __schedule_bug+0x70/0x80
[    2.937174] [<0000000000f68f50>] switch_to_pc+0x598/0x8e8
[    2.937999] [<0000000000f69300>] schedule+0x60/0xe0
[    2.938811] [<0000000000f72d2c>] schedule_timeout+0x10c/0x1c0
[    2.939668] [<0000000000f69be0>] __wait_for_common+0xa0/0x1a0
[    2.940510] [<0000000000f69d98>] wait_for_completion_killable+0x18/0x40
[    2.941402] [<0000000000494dec>] __kthread_create_on_node+0xac/0x120
[    2.942259] [<0000000000494e80>] kthread_create_on_node+0x20/0x40
[    2.943023] [<0000000001b81348>] devtmpfs_init+0xb4/0x140
[    2.943777] [<0000000001b81068>] driver_init+0x10/0x60
[    2.944528] [<0000000001b56e4c>] kernel_init_freeable+0xd4/0x228
[    2.945300] [<0000000000f67404>] kernel_init+0x18/0x134
[    2.946026] [<00000000004060e8>] ret_from_fork+0x1c/0x2c
[    2.946757] [<0000000000000000>] 0x0
[    2.959537] devtmpfs: initialized

While that seemed unlikely (and I don't claim to understand it), I ran
bisect separately and confirmed that both tracebacks are gone after
reverting this patch.

Guenter
