Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B76D7EA1F3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 18:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjKMRfe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 12:35:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229769AbjKMRfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 12:35:32 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94B61706;
        Mon, 13 Nov 2023 09:35:25 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A59A960007;
        Mon, 13 Nov 2023 17:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699896924;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VyXwIvD+vJrAcsZapUkBDZTlpjO79yirXHEOhMGcuI8=;
        b=j9/XseXB3aedkdzdO36LIYXbmv55tE3mvEolbijrfu3DUSL6d+rlANgmANcYQoYn8pEpRL
        28ivAVg2ZJ5zvgGbEaDl93WFsu+yB5Dtnq/3Nfnlk7ecfOcuk+QTBjKTtPSZhg/KXgFuke
        C57JeW0WhuX3bg9U/hAMG3fjOS16sw9BXYH+C5JePN19Xi5/Q3cL616aqEIbh59nJr+ELH
        NrZgQFh8nof7uWV5IFifg1gHzCbaK5I7345qhaV90RLDhEVYVdrIlz9oatxAZ/keChNvkt
        TefTtUsHFIgPxL93AWWOc7cGnwOWif1cr+lVowLRQFZhGuvp1mNeQtz4pxWOvw==
Date:   Mon, 13 Nov 2023 18:35:22 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org,
        Allan Nielsen <allan.nielsen@microchip.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        Steen Hegelund <steen.hegelund@microchip.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        stable@vger.kernel.org
Subject: Re: [PATCH 1/1] driver core: Avoid using fwnode in
 __fwnode_link_del()
Message-ID: <20231113183522.376970ab@bootlin.com>
In-Reply-To: <CAGETcx9gib6HC9TZNoJpS3RmnRt6_5UixRyvP6Mu_TbuxLO3fg@mail.gmail.com>
References: <20231110170121.769221-1-herve.codina@bootlin.com>
        <CAGETcx9gib6HC9TZNoJpS3RmnRt6_5UixRyvP6Mu_TbuxLO3fg@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Saravan,

On Fri, 10 Nov 2023 12:09:02 -0800
Saravana Kannan <saravanak@google.com> wrote:

> On Fri, Nov 10, 2023 at 9:01 AM Herve Codina <herve.codina@bootlin.com> wrote:
> >
> > A refcount issue can appeared in __fwnode_link_del() due to the
> > pr_debug() call:
> >   WARNING: CPU: 0 PID: 901 at lib/refcount.c:25 refcount_warn_saturate+0xe5/0x110
> >   Call Trace:
> >   <TASK>
> >   ? refcount_warn_saturate+0xe5/0x110
> >   ? __warn+0x81/0x130
> >   ? refcount_warn_saturate+0xe5/0x110
> >   ? report_bug+0x191/0x1c0
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? prb_read_valid+0x1b/0x30
> >   ? handle_bug+0x3c/0x80
> >   ? exc_invalid_op+0x17/0x70
> >   ? asm_exc_invalid_op+0x1a/0x20
> >   ? refcount_warn_saturate+0xe5/0x110
> >   kobject_get+0x68/0x70
> >   of_node_get+0x1e/0x30
> >   of_fwnode_get+0x28/0x40
> >   fwnode_full_name_string+0x34/0x90
> >   fwnode_string+0xdb/0x140
> >   vsnprintf+0x17b/0x630
> >   va_format.isra.0+0x71/0x130
> >   vsnprintf+0x17b/0x630
> >   vprintk_store+0x162/0x4d0
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   ? try_to_wake_up+0x9c/0x620
> >   ? rwsem_mark_wake+0x1b2/0x310
> >   vprintk_emit+0xe4/0x2b0
> >   _printk+0x5c/0x80
> >   __dynamic_pr_debug+0x131/0x160
> >   ? srso_alias_return_thunk+0x5/0x7f
> >   __fwnode_link_del+0x25/0xa0
> >   fwnode_links_purge+0x39/0xb0
> >   of_node_release+0xd9/0x180
> >   kobject_put+0x7b/0x190
> >   ...
> >
> > Indeed, an of_node is destroyed and so, of_node_release() is called
> > because the of_node refcount reached 0.
> > of_node_release() calls fwnode_links_purge() to purge the links and
> > ended with __fwnode_link_del() calls.
> > __fwnode_link_del calls pr_debug() to print the fwnodes (of_nodes)
> > involved in the link and so this call is done while one of them is no
> > more available (ie the one related to the of_node_release() call)
> >
> > Remove the pr_debug() call to avoid the use of the links fwnode while
> > destroying the fwnode itself.
> >
> > Fixes: ebd6823af378 ("driver core: Add debug logs when fwnode links are added/deleted")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  drivers/base/core.c | 2 --
> >  1 file changed, 2 deletions(-)
> >
> > diff --git a/drivers/base/core.c b/drivers/base/core.c
> > index f4b09691998e..62088c663014 100644
> > --- a/drivers/base/core.c
> > +++ b/drivers/base/core.c
> > @@ -109,8 +109,6 @@ int fwnode_link_add(struct fwnode_handle *con, struct fwnode_handle *sup)
> >   */
> >  static void __fwnode_link_del(struct fwnode_link *link)
> >  {
> > -       pr_debug("%pfwf Dropping the fwnode link to %pfwf\n",
> > -                link->consumer, link->supplier);  
> 
> Valid issue, but a NACK for the patch.
> 
> The pr_debug has been very handy, so I don't want to delete it. Also,
> the fwnode link can't get deleted before the supplier/consumer. If it
> is, I need to take a closer look as I'd expect the list_del() to cause
> corruption. My guess is that the %pfwf is traversing stuff that's
> causing an issue. But let me take a closer look next week when I'll be
> at LPC.
> 

The issue is really related to print the full name (%pfwf) of the node
been destroyed by of_node_release() due to refcount == 0.
The issue does not appear with %pfwP.

Looked at printk(). On %pfwf fwnode_handle_{get,put}() is called for
current node and its parents whereas %pfwP does not call
fwnode_handle_{get,put}() on the current node.

A fix can probably be done at printk() level to avoid the
fwnode_handle_{get,put}() calls for the current node in case of %pfwf.

I will do a patch in this way instead of removing the pr_debug() call
in __fwnode_link_del().

Best regards,
Hervé
