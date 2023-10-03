Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402827B627A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 09:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230395AbjJCH2q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 03:28:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjJCH2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 03:28:45 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B59A83
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 00:28:38 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9ae75ece209so91748366b.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 00:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696318117; x=1696922917; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ucqw6X61coCqcSfzC4WcVSLrJYNxmNxx1TxpbToBncM=;
        b=Af1hw3Y0BcyVrxtwPR4gaeDoYQ9M84CIGN1thsP1b3RsKzvrp+HA/mESxxOkvV7WEs
         +njMV5c5FlImgCYgEPEYQpbmv1rFD13hgMQq6WxebScZVkrO/q6E3tOHsom1IzxvBkiD
         9j7h1hHvt0mxJZWfbptxyLji9N9Jq+FBWAvEHICrmXgox92odLvgxM8YZ4qtla833Cta
         AFk1CKtP4a5jhPV/V/FL3gCMtvpGrRCHKhi1dU7O9o+aDUY9RghOJvkXXE3BG4dsfifu
         vZl9hqwrZFTey7A1viJm75WvfWal035wCz2WgqkLUq9GzjT+Db//2NUld2XtrudsQw3k
         hU4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696318117; x=1696922917;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ucqw6X61coCqcSfzC4WcVSLrJYNxmNxx1TxpbToBncM=;
        b=QT958qRfBtr0ZC7TMDp4+8Deu4wTN0WrxRmBfDEbzqXEsjhqwWx3O33ko6OXxQPR6/
         gy1HOCPczIcNG4nlnac1rKwTFxE/8lUbSHAttrtlgqhUz3twK0A7gWSqEWgkpo/9D/vS
         +Ib4Nd5CPOdn5onG43yXc8bCX7qc2BeQjL6CID1ZfRSMwKPTQGjuUjPIHGCb5phYrqlw
         9cfC7v+CfojeiJTQCkwEu9E1lZnA6jaIMiBeL/mcPrs2qwAnPGr8/lJcEgOFKpFhzE8T
         2WPIJi/Ficjg/Kq3K0zW62Uk7JLe3atyAjGDn9KZjOdJmHmM++AWOa08qE6kDX725z/H
         gVyA==
X-Gm-Message-State: AOJu0YyKxbaP8IRTX94OEiEdZxfxAmkUpQyrfyJHX4+qCforI7iG+iUs
        mvC8vxejpiWsfB66iK8bKmE=
X-Google-Smtp-Source: AGHT+IHZ1kAC1A1CZY/3XYlSuV9n6RlS+Vy/Q121wiJg0bkW6CqSl5x3L0h4EbFAyb+Kk5WhUPf4vg==
X-Received: by 2002:a17:906:20ce:b0:9a1:e233:e627 with SMTP id c14-20020a17090620ce00b009a1e233e627mr13839558ejc.42.1696318116414;
        Tue, 03 Oct 2023 00:28:36 -0700 (PDT)
Received: from gmail.com (1F2EF530.nat.pool.telekom.hu. [31.46.245.48])
        by smtp.gmail.com with ESMTPSA id r27-20020a17090638db00b0099cf9bf4c98sm567225ejd.8.2023.10.03.00.28.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 00:28:35 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Tue, 3 Oct 2023 09:28:33 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, acdunlap@google.com,
        ashok.raj@intel.com, bp@alien8.de, david@redhat.com,
        dionnaglaze@google.com, hpa@zytor.com, jacobhxu@google.com,
        jgross@suse.com, jroedel@suse.de, khalid.elmously@canonical.com,
        kim.phillips@amd.com, kirill.shutemov@linux.intel.com,
        llvm@lists.linux.dev, luto@kernel.org, mingo@redhat.com,
        nikunj@amd.com, peterz@infradead.org, pgonda@google.com,
        rientjes@google.com, rppt@kernel.org, seanjc@google.com,
        tglx@linutronix.de, thomas.lendacky@amd.com
Subject: Re: [PATCH] x86/boot: Move x86_cache_alignment initialization to
 correct spot
Message-ID: <ZRvCoc8miXAjSenM@gmail.com>
References: <20231002200426.GA4127272@dev-arch.thelio-3990X>
 <20231002220045.1014760-1-dave.hansen@linux.intel.com>
 <20231002222402.GA486933@dev-arch.thelio-3990X>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002222402.GA486933@dev-arch.thelio-3990X>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Nathan Chancellor <nathan@kernel.org> wrote:

> On Mon, Oct 02, 2023 at 03:00:45PM -0700, Dave Hansen wrote:
> > c->x86_cache_alignment is initialized from c->x86_clflush_size.
> > However, commit fbf6449f84bf moved c->x86_clflush_size initialization
> > to later in boot without moving the c->x86_cache_alignment assignment.
> > 
> > This presumably left c->x86_cache_alignment set to zero for longer
> > than it should be.
> > 
> > The result was an oops on 32-bit kernels while accessing a pointer
> > at 0x20.  The 0x20 came from accessing a structure member at offset
> > 0x10 (buffer->cpumask) from a ZERO_SIZE_PTR=0x10.  kmalloc() can
> > evidently return ZERO_SIZE_PTR when it's given 0 as its alignment
> > requirement.
> > 
> > Move the c->x86_cache_alignment initialization to be after
> > c->x86_clflush_size has an actual value.
> > 
> > Fixes: fbf6449f84bf ("x86/sev-es: Set x86_virt_bits to the correct value straight away, instead of a two-phase approach")
> > Cc: Adam Dunlap <acdunlap@google.com>
> > Cc: Ingo Molnar <mingo@kernel.org>
> > Cc: Jacob Xu <jacobhxu@google.com>
> > Link: https://lore.kernel.org/all/20231002200426.GA4127272@dev-arch.thelio-3990X/
> 
> Tested-by: Nathan Chancellor <nathan@kernel.org>
> 
> Thanks for the quick fix!

Thanks for the quick testing - I've applied this fix on top
of fbf6449f84bf in tip:x86/mm.

Dave, I've added your SOB - let me know if that's not OK:

  Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>

Thanks,

	Ingo
