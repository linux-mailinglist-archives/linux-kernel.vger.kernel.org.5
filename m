Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30CFD78AFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 14:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjH1MTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 08:19:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232400AbjH1MSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 08:18:37 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 434AE123;
        Mon, 28 Aug 2023 05:18:33 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EF24521AD1;
        Mon, 28 Aug 2023 12:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1693225111; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhHiF9SmtTpwGjjJk9Jp9+qsr93zDTKtaY+5+helRDY=;
        b=1d0LSyK4vV3rKnQIJfH6T4/q5VTTTaNonU/GwrSKcEDI/1UMTGGi7SUn1kBNtzSVUf+I5i
        a1KyW9wcYlNCXs3SFqhoRuAgu8jelG++ppMn7CXb2m570T70Bfqb2fvUyzd+f5gevYI8o7
        vop/KCXCEdyVjkv+jKgbqUfM+dEbo9c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1693225111;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nhHiF9SmtTpwGjjJk9Jp9+qsr93zDTKtaY+5+helRDY=;
        b=RdnKubZ3yT4OIBS0EaaipJJc1F2ppGCA/edShrjFqRK3bSfvZ7dFN+mmyIzLTYZLSsE1q3
        ZBc4hdGh/DyCVmCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C711C139CC;
        Mon, 28 Aug 2023 12:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id A3gKL5eQ7GQfEwAAMHmgww
        (envelope-from <jdelvare@suse.de>); Mon, 28 Aug 2023 12:18:31 +0000
Date:   Mon, 28 Aug 2023 14:18:30 +0200
From:   Jean Delvare <jdelvare@suse.de>
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Michal Hocko <mhocko@suse.com>, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] module: print module name on refcount error
Message-ID: <20230828141830.02de4d90@endymion.delvare>
In-Reply-To: <ZMGJGlJ7XSG+2vjY@bombadil.infradead.org>
References: <20230626123252.73dbc139@endymion.delvare>
        <ZJ9fvQZ4k+zFfXbN@bombadil.infradead.org>
        <ZKLRaq3pzzE2gfws@dhcp22.suse.cz>
        <ZKhf8bi/eBDhaihD@bombadil.infradead.org>
        <ZKuaZepw51Nriqr8@dhcp22.suse.cz>
        <ZMGJGlJ7XSG+2vjY@bombadil.infradead.org>
Organization: SUSE Linux
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.34; x86_64-suse-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luis, Michal, 

On Wed, 26 Jul 2023 13:59:06 -0700, Luis Chamberlain wrote:
> On Mon, Jul 10, 2023 at 07:43:01AM +0200, Michal Hocko wrote:
> > On Fri 07-07-23 11:56:49, Luis Chamberlain wrote:  
> > > On Mon, Jul 03, 2023 at 03:47:22PM +0200, Michal Hocko wrote:  
> > > > On Fri 30-06-23 16:05:33, Luis Chamberlain wrote:
> > > > [...]  
> > > > > What prevents code from racing the free with a random module_put()
> > > > > called by some other piece of code?  
> > > > 
> > > > Wouldn't be ref count a garbage already? How can you race when freeing
> > > > if module_put fail?  
> > > 
> > > It could yes, ie, so this risks at all being junk.  
> > 
> > Could you be more specific please? I still do not see a scenario where
> > module string name would be junk while refcount itself would be a valid
> > memory.  
> 
> That is true, but if refcount is invalid so will the memory for the
> string.

This isn't how I read the code, and this is exactly the reason why I
submitted this patch in the first place.

As far as I can see, there are 3 possibilities:

1* The refcount is correct, everything is fine.
2* The refcount is wrong (we are trying to put a ref which was never
   taken), however the module wasn't unloaded yet, so the module name is
   still readable.
3* The refcount is wrong and the module has already been unloaded. The
   memory may have been reused already, so the module name can't be read.

My patch is only useful in case 2. Although it doesn't cover all cases,
I think it is relevant because unloading modules is something you
rarely do in production, so if the refcount goes wrong, we will almost
always be in case 2.

That being said, if you don't like my proposal for whatever reason, or
prefer addressing the issue in a different way, no problem at all.

> > It would likely be better to use refcount_t instead of atomic_t.  
> 
> Patches welcomed.

Michal, do I understand correctly that this would prevent the case our
customer had (too many gets), but won't make a difference for actual
too-many-puts situations?

-- 
Jean Delvare
SUSE L3 Support
