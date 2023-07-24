Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F98175F7F4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 15:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbjGXNNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 09:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbjGXNN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 09:13:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C562F5;
        Mon, 24 Jul 2023 06:13:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C56A061173;
        Mon, 24 Jul 2023 13:13:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9CD1C433CD;
        Mon, 24 Jul 2023 13:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690204404;
        bh=gWOH0uyBxFAQFsitrV8ckB3ZDQP6ZEQxzPayDsxkpxM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ftbVneXBxS4CtSEIVk1WWYxMQF2HFE3xjsQRI7eZwg+2ZPkR2+KsEmD90myobeadG
         HIBjRpJH+hH1C3FJXvHeZ42iaF+Wh7xYtMywPIm8/fJNXROZCAKR1P2jOV2XQKjL0O
         PC1h4BXIHJlcYA9Z9ze943nPSxvwZWyuTlVzPD1zLwa+P17k+TEzxSeyYI0d8+D85l
         VXQUV/M2PO+LWAwPTM2zBHZ2NbRyRozpSp6KSKGyU9BBF6mvJjxQtbichqHwU5yz8f
         o0r/4tc12rwM9jesSRJHS85BiKKWlJR9x0gEG7mf0l9sYkObIrttW/pJF+fzPY1vzn
         FYz2Hl/5BcGVw==
Received: (nullmailer pid 3313599 invoked by uid 1000);
        Mon, 24 Jul 2023 13:13:16 -0000
Date:   Mon, 24 Jul 2023 07:13:16 -0600
From:   Rob Herring <robh@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Rob Herring <robherring2@gmail.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH] of: fix htmldocs build warnings
Message-ID: <20230724131316.GA3307169-robh@kernel.org>
References: <20230220163638.04e9d0c4@canb.auug.org.au>
 <20230310113258.463f836c@canb.auug.org.au>
 <20230322180032.1badd132@canb.auug.org.au>
 <20230713161038.382b5e14@canb.auug.org.au>
 <20230724135513.3773f184@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230724135513.3773f184@canb.auug.org.au>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 01:55:13PM +1000, Stephen Rothwell wrote:
> Hi all,
> 
> On Thu, 13 Jul 2023 16:10:38 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Wed, 22 Mar 2023 18:00:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > Fix these htmldoc build warnings:
> > > 
> > > include/linux/of.h:115: warning: cannot understand function prototype: 'const struct kobj_type of_node_ktype; '
> > > include/linux/of.h:118: warning: Excess function parameter 'phandle_name' description in 'of_node_init'
> > > 
> > > Reported by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > Reported by: Randy Dunlap <rdunlap@infradead.org>
> > > Fixes: 39459ce717b8 ("of: dynamic: add lifecycle docbook info to node creation functions")
> > > Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > > ---
> > >  include/linux/of.h | 7 +++----
> > >  1 file changed, 3 insertions(+), 4 deletions(-)
> > > 
> > > Replaces "[PATCH] of: fix htmldocs build warning" and additionally
> > > fixes the new warning about phandle that Randy reported.
> > > 
> > > diff --git a/include/linux/of.h b/include/linux/of.h
> > > index 9b7a99499ef3..d55dab9ad728 100644
> > > --- a/include/linux/of.h
> > > +++ b/include/linux/of.h
> > > @@ -100,10 +100,12 @@ struct of_reconfig_data {
> > >  	struct property		*old_prop;
> > >  };
> > >  
> > > +extern const struct kobj_type of_node_ktype;
> > > +extern const struct fwnode_operations of_fwnode_ops;
> > > +
> > >  /**
> > >   * of_node_init - initialize a devicetree node
> > >   * @node: Pointer to device node that has been created by kzalloc()
> > > - * @phandle_name: Name of property holding a phandle value
> > >   *
> > >   * On return the device_node refcount is set to one.  Use of_node_put()
> > >   * on @node when done to free the memory allocated for it.  If the node
> > > @@ -111,9 +113,6 @@ struct of_reconfig_data {
> > >   * whether to free the memory will be done by node->release(), which is
> > >   * of_node_release().
> > >   */
> > > -/* initialize a node */
> > > -extern const struct kobj_type of_node_ktype;
> > > -extern const struct fwnode_operations of_fwnode_ops;
> > >  static inline void of_node_init(struct device_node *node)
> > >  {
> > >  #if defined(CONFIG_OF_KOBJ)
> > > -- 
> > > 2.39.2  
> > 
> > Any chance if this patch being applied?
> 
> Is there something wrong with the patch?

Sorry, missed this one. Now applied. If it's not sent to DT list and 
into PW, then it's a gamble when/if I see it.

> P.S. Rob, should I use your kernel.org address as your linux-next
> contact?

Yes.

Rob
