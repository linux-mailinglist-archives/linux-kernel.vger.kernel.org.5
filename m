Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9045C782D0D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 17:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236236AbjHUPQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 11:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjHUPQl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 11:16:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF4DBC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 08:16:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 52559618BF
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 15:16:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569DCC433C7;
        Mon, 21 Aug 2023 15:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692630998;
        bh=nUnU/eJw/z9XobglMFHWX2PLQc8tDxd8PnG9xVDrNMM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xvm+zFeGlkMPyi44ipywMGXKv+td3w/wTME4lXKMwwET/vFj7uvXdU7lShLp608fC
         r5TubIkOyUzZdt2wJCQuZGpNH3sVnnTd/2SQU76EvhQ53kiG7hGlR6i7XVj/FQuAXe
         e5afWao1gRyk2sunG8nFTg8/morcutQRJ2dW93g9YT2CHncDK9+isCRniu0lsTv/tx
         8l9prKjL2/1Xx/gvQ7sCYBXNXO+xaBLoHlMzQSzJCIek15Lgo5wsdkB8PghGbHHhY7
         8v/ZdKXPpvdW9rgzNaBQ3mdsax6ljtlaAGwOJ7GBhq3PYkOjtRVeU825va6ntB9dkI
         dASGOJEvZ9Ecw==
Date:   Mon, 21 Aug 2023 08:16:36 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Andrew Cooper <andrew.cooper3@citrix.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Babu Moger <babu.moger@amd.com>, David.Kaplan@amd.com,
        Nikolay Borisov <nik.borisov@suse.com>,
        gregkh@linuxfoundation.org, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH RFC 4/4] x86/srso: Use CALL-based return thunks to reduce
 overhead
Message-ID: <20230821151636.onk2e6tlhmjg5yz5@treble>
References: <20230821112723.3995187-1-andrew.cooper3@citrix.com>
 <20230821112723.3995187-5-andrew.cooper3@citrix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230821112723.3995187-5-andrew.cooper3@citrix.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 21, 2023 at 12:27:23PM +0100, Andrew Cooper wrote:
> The SRSO safety depends on having a CALL to an {ADD,LEA}/RET sequence which
> has been made safe in the BTB.  Specifically, there needs to be no pertubance
> to the RAS between a correctly predicted CALL and the subsequent RET.
> 
> Use the new infrastructure to CALL to a return thunk.  Remove
> srso_fam1?_safe_ret() symbols and point srso_fam1?_return_thunk().
> 
> This removes one taken branch from every function return, which will reduce
> the overhead of the mitigation.  It also removes one of three moving pieces
> from the SRSO mess.

So, the address of whatever instruction comes after the 'CALL
srso_*_return_thunk' is added to the RSB/RAS, and that might be
speculated to when the thunk returns.  Is that a concern?

> Signed-off-by: Andrew Cooper <andrew.cooper3@citrix.com>
> ---
> CC: x86@kernel.org
> CC: linux-kernel@vger.kernel.org
> CC: Borislav Petkov <bp@alien8.de>
> CC: Peter Zijlstra <peterz@infradead.org>
> CC: Josh Poimboeuf <jpoimboe@kernel.org>
> CC: Babu Moger <babu.moger@amd.com>
> CC: David.Kaplan@amd.com
> CC: Nikolay Borisov <nik.borisov@suse.com>
> CC: gregkh@linuxfoundation.org
> CC: Thomas Gleixner <tglx@linutronix.de>
> 
> RFC:
> 
>   vmlinux.o: warning: objtool: srso_fam17_return_thunk(): can't find starting instruction
> 
> Any objtool whisperers know what's going on, and particularly why
> srso_fam19_return_thunk() appears to be happy?
> 
> Also, depends on the resolution of the RFC in the previous patch.

I can take a look.

-- 
Josh
