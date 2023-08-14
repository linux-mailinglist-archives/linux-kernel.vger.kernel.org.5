Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124E077C135
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 22:02:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232355AbjHNUBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 16:01:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjHNUBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 16:01:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7CC410F0
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 13:01:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BCBE637E4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 20:01:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D273C433C7;
        Mon, 14 Aug 2023 20:01:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692043290;
        bh=0Dopu3Kr2QfFROt/Fub5T1L31qUpIl/MqUeM9m/mw6k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gjlvrGkAmq08fLoMQW3+seEBRrwbC1oUNnbb4Sfr5On5w7i9mKc7jnCN5+IeMdKCK
         awmk8fNryGoirR1GXJYvB4rJZExPxljLRyxGfZIjRzIysuIucF2pI0eeYt2vMvzxxU
         wJtJGLBLhko//QZBkzOKCUj5TYW9Iw1zW/lpd1LzKNBtQMQ/GaEZXWGPtJL6ZYAXkQ
         P5YSh3QcG2njGoSpHPANJSFJYXVBIK257zefhVfXqEufK6wBvfd1Or+eeu8iasPu+C
         GlUzRXRN5xKxZNSRNit5TeWtGhZsLegcudKiHXlZrcXxyFSILZ4FweNvOcVf4ffd7c
         lZVO49Zeq5vnQ==
Date:   Mon, 14 Aug 2023 13:01:28 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, David.Kaplan@amd.com,
        Andrew.Cooper3@citrix.com, gregkh@linuxfoundation.org,
        nik.borisov@suse.com
Subject: Re: [PATCH v2 00/11] Fix up SRSO stuff
Message-ID: <20230814200128.ioas5lk2r3yzfkkv@treble>
References: <20230814114426.057251214@infradead.org>
 <20230814164447.GFZNpZ/64H4lENIe94@fat_crate.local>
 <20230814195153.2zxtp6zx552trgh6@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230814195153.2zxtp6zx552trgh6@treble>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:51:55PM -0700, Josh Poimboeuf wrote:
> On Mon, Aug 14, 2023 at 06:44:47PM +0200, Borislav Petkov wrote:
> > On Mon, Aug 14, 2023 at 01:44:26PM +0200, Peter Zijlstra wrote:
> > > The one open techinical issue I have with the mitigation is the alignment of
> > > the RET inside srso_safe_ret(). The details given for retbleed stated that RET
> > > should be on a 64byte boundary, which is not the case here.
> > 
> > I have written this in the hope to make this more clear:
> > 
> > /*
> >  * Some generic notes on the untraining sequences:
> >  *
> >  * They are interchangeable when it comes to flushing potentially wrong
> >  * RET predictions from the BTB.
> >  *
> >  * The SRSO Zen1/2 (MOVABS) untraining sequence is longer than the
> >  * Retbleed sequence because the return sequence done there
> >  * (srso_safe_ret()) is longer and the return sequence must fully nest
> >  * (end before) the untraining sequence. Therefore, the untraining
> >  * sequence must overlap the return sequence.
> >  *
> >  * Regarding alignment - the instructions which need to be untrained,
> >  * must all start at a cacheline boundary for Zen1/2 generations. That
> >  * is, both the ret in zen_untrain_ret() and srso_safe_ret() in the
> >  * srso_untrain_ret() must both be placed at the beginning of
> >  * a cacheline.
> >  */
> 
> It's a good comment, but RET in srso_safe_ret() is still misaligned.
> Don't we need something like so?

Scratch that, I guess I misread the confusingly worded comment:

  "both the ret in zen_untrain_ret() and srso_safe_ret()..."

to mean the RET in each function.

How about:

  "both the RET in zen_untrain_ret() and the LEA in srso_untrain_ret()"

?

-- 
Josh
