Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 987237FA8B4
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 19:16:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbjK0SQB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 13:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbjK0SP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 13:15:58 -0500
Received: from mail-oo1-xc29.google.com (mail-oo1-xc29.google.com [IPv6:2607:f8b0:4864:20::c29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F182198
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:16:03 -0800 (PST)
Received: by mail-oo1-xc29.google.com with SMTP id 006d021491bc7-58cdc801f69so2748912eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 10:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1701108962; x=1701713762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=FxoxtfZyYEABjHZ6RtVtSj3aKhK7A/US0jtAU3g5OGk=;
        b=BA//TnZGQIcE9zbe35i7lFPkNDKCQV27j+1h/F8ePFjQyxsl4hGSl9jaymPMCYIMej
         8JzcJQsXp3XPHdb3Bgi9ZZG/RPuTr2aJ6jCvNdK/B19YU4qLeY5IhW4wSnoMt49qW9bI
         Pfl+nWyqFPQi4b8sT0rJGHoez0l4jLvX2SMunRI6AmuIRQKrexBBRkAF2cYqrtdsjoJL
         yR97/L5hr6aH7fB+NC1e2JHWyQZGU+tZ/TkbAzitdfSISHOpAqf77RQVyIYzoDisIfEb
         ST1bjWnjRbkZJrKDm/O8ccQRRu0A+bMoBtIQXmgTJVVfweRTkCUfUPOFMvB+AVyAcV1t
         JsYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701108962; x=1701713762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxoxtfZyYEABjHZ6RtVtSj3aKhK7A/US0jtAU3g5OGk=;
        b=MYAeC9F63hd99IRbE7NprTTmsRe7CGBR/u0ucloLgMWTXAprWgIrR7+8yBj2CihuTh
         jgB+SKM/O/dpYyzlJd9yV/TRYWEagecI9Y1ksjcPZvyI+7ELa8ZiC7M/yf/YF5KsfaNQ
         vi9PFnOMlBikcyIGA0OThPlD9I9VPRVs9C6pB+Efax0Ka+zFZCH52Ymf9z+528gOPywu
         jeNCBWhHPrU6pAIS0ohua6GyChYJy9lk3x2jvvlGLlipj96ORUuxtyltJ7fJrZUQUPiJ
         vUSDgtwlM5lXUq6A1zN7ZixLzS5pIegBxu+6D9q2m1/SPfZ0i0Fy+q6Jaxx0/qNZ2Psr
         AJ/A==
X-Gm-Message-State: AOJu0Yw0gqo5iYmQn0OsXwck4RMNGzr0+G7GFgE/XtT/CRgAnG87weCi
        mawWG5Cg4tNPDbijrtE6zXh1zw==
X-Google-Smtp-Source: AGHT+IE+v6fFB7xdHxMtYP8G0Nfw9Tf/7BYotEm3H1gVkhmuH+mh9vYsMGoDKYeeMoWzyCVVgNRotw==
X-Received: by 2002:a05:6820:809:b0:58d:a6ed:5601 with SMTP id bg9-20020a056820080900b0058da6ed5601mr1113420oob.1.1701108962609;
        Mon, 27 Nov 2023 10:16:02 -0800 (PST)
Received: from ghost ([2601:647:5700:6860:a896:28e0:13ca:92d8])
        by smtp.gmail.com with ESMTPSA id b18-20020a4ac292000000b00581daa5c5fdsm1572457ooq.29.2023.11.27.10.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 10:16:01 -0800 (PST)
Date:   Mon, 27 Nov 2023 10:15:59 -0800
From:   Charlie Jenkins <charlie@rivosinc.com>
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH 1/2] riscv: Include riscv_set_icache_flush_ctx prctl
Message-ID: <ZWTc3/FeBbXHs7aM@ghost>
References: <20231122-fencei-v1-0-bec0811cb212@rivosinc.com>
 <20231122-fencei-v1-1-bec0811cb212@rivosinc.com>
 <20231127-epilogue-frying-4d5ba926617c@wendy>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127-epilogue-frying-4d5ba926617c@wendy>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 10:44:54AM +0000, Conor Dooley wrote:
> On Wed, Nov 22, 2023 at 05:03:20PM -0800, Charlie Jenkins wrote:
> > +
> > +/**
> > + * Enable userspace to emit icache flushing instructions.
> > + *
> > + * When in per-process context, there may be multiple threads using the same mm.
> > + * Therefore, the icache can never be assumed clean when. Multiple threads in
> > + * the process may modify instructions in the mm concurrently.
> > + *
> > + * In per-thread context, it can be assumed that all modifications to
> > + * instructions in memory will be performed by this thread. When the thread is
> > + * migrated the icache will be flushed.
> > + *
> > + * @arg arg: Sets the type of context
> > + *  - PR_RISCV_CTX_SW_FENCEI: Allow fence.i in userspace. Another fence.i will
> > + *			      emitted on thread/process migration.
> > + * @arg per_thread: When set to 0, will use the default behavior of setting the
> > + *  icache flush context per process. When set to 1, will use a per thread
> > + *  context.
> > + */
> 
> FYI, this is not valid kerneldoc and breaks allmodconfig builds:
>  arch/riscv/mm/cacheflush.c:159: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
> 
> > +int riscv_set_icache_flush_ctx(unsigned long ctx, unsigned long per_thread)
> 
> 
> Cheers,
> Conor.

Thank you, I will fix that in the next version.

- Charlie

