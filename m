Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65395760330
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 01:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjGXXdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 19:33:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjGXXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 19:33:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D46E10F0;
        Mon, 24 Jul 2023 16:33:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF66661463;
        Mon, 24 Jul 2023 23:32:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385C8C433C8;
        Mon, 24 Jul 2023 23:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690241579;
        bh=e9QSEh6b4uhYqAZa6VEZ0jeCfnlnxgRWV+zrxCBm1/Q=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xs/NWONSkVisnkPTtB8iJ4sBB5kfU8K/L1iGGn2wWk90Jkn5R570A9L4HnOLqykz1
         2dYSD18rByxVe8fb/x8alwMMNP5h8YvxNE8e/BsdCmnal0+pDH3bELel2iNDPZaMI7
         QBNkMr3+4f3aYaN2FkM0coNcxbtp8DHmocyyyFm+UPPYTXwqi9BEbRw/Kz9462IdOU
         3cdqJmLj0WMO0mpAk1lTUuo8bOEgDjypl77Xy8PDCeICmJCRqhu1NZJFkV/HhtJvUa
         m9eF3ezAqh/T0/duXq4f4jU0KUR2wbvn8uWf0K49uu0nEeIzDFl0rP/jkuKLoTqLq5
         ZDoM1R6H1ha7Q==
Received: (nullmailer pid 1125486 invoked by uid 1000);
        Mon, 24 Jul 2023 23:32:56 -0000
Date:   Mon, 24 Jul 2023 17:32:56 -0600
From:   Rob Herring <robh@kernel.org>
To:     Rik van Riel <riel@surriel.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@meta.com,
        Mike Rapoport <rppt@kernel.org>, devicetree@vger.kernel.org,
        x86@kernel.org, Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>
Subject: Re: [PATCH] mm,ima,kexec: use memblock_free_late from
 ima_free_kexec_buffer
Message-ID: <20230724233256.GA1124187-robh@kernel.org>
References: <20230720101431.71640c8a@imladris.surriel.com>
 <20230721193815.GA1679711-robh@kernel.org>
 <74c0d1b900d8f518bc152478682a353c29e0faa3.camel@surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <74c0d1b900d8f518bc152478682a353c29e0faa3.camel@surriel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 08:40:41PM -0400, Rik van Riel wrote:
> On Fri, 2023-07-21 at 13:38 -0600, Rob Herring wrote:
> > On Thu, Jul 20, 2023 at 10:14:31AM -0400, Rik van Riel wrote:
> > > The code calling ima_free_kexec_buffer runs long after the memblock
> > > allocator has already been torn down, potentially resulting in a
> > > use
> > > after free in memblock_isolate_range.
> > > 
> > > With KASAN or KFENCE, this use after free will result in a BUG
> > > from the idle task, and a subsequent kernel panic.
> > > 
> > > Switch ima_free_kexec_buffer over to memblock_free_late to avoid
> > > that issue.
> > > 
> > > Fixes: fee3ff99bc67 ("powerpc: Move arch independent ima kexec
> > > functions to drivers/of/kexec.c")
> > 
> > Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on
> > kexec")
> > 
> Thank you for digging further back in the history of that code.
> 
> > Acked-by: Rob Herring <robh@kernel.org>
> > 
> > (I'm assuming someone else is taking this)
> 
> I hope so, but I don't know who...

You could split this into 2 patches, then there's no doubt. And each 
Fixes is clear.

Rob
