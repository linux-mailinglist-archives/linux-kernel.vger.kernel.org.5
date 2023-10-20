Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 908287D09C2
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 09:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376457AbjJTHxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 03:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376406AbjJTHxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 03:53:12 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6FA3;
        Fri, 20 Oct 2023 00:53:09 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7120B1F45B;
        Fri, 20 Oct 2023 07:53:08 +0000 (UTC)
Received: from suse.cz (pmladek.tcp.ovpn2.prg.suse.de [10.100.208.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id EDB7A2C7B4;
        Fri, 20 Oct 2023 07:53:07 +0000 (UTC)
Date:   Fri, 20 Oct 2023 09:53:07 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        linux-alpha@vger.kernel.org, mattst88@gmail.com,
        linux-kernel@vger.kernel.org, kernel-dev@igalia.com,
        kernel@gpiccoli.net, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v5] alpha: Clean-up the panic notifier code
Message-ID: <ZTIx4-Sn3mzYFzke@alley>
References: <20230902165725.3504046-1-gpiccoli@igalia.com>
 <alpine.DEB.2.21.2310100109100.48714@angie.orcam.me.uk>
 <f5837e2d-2fbd-34f2-37eb-11701db4464e@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f5837e2d-2fbd-34f2-37eb-11701db4464e@igalia.com>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of pmladek@suse.com does not designate 149.44.160.134 as permitted sender) smtp.mailfrom=pmladek@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         ARC_NA(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RWL_MAILSPIKE_GOOD(0.00)[149.44.160.134:from];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         VIOLATED_DIRECT_SPF(3.50)[];
         MX_GOOD(-0.01)[];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[9];
         RCVD_NO_TLS_LAST(0.10)[];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(0.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_COUNT_TWO(0.00)[2];
         MID_RHS_NOT_FQDN(0.50)[];
         BAYES_HAM(-3.00)[100.00%];
         FREEMAIL_CC(0.00)[orcam.me.uk,vger.kernel.org,gmail.com,igalia.com,gpiccoli.net,jurassic.park.msu.ru,linaro.org]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: 7120B1F45B
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun 2023-10-15 15:54:49, Guilherme G. Piccoli wrote:
> On 10/10/2023 02:16, Maciej W. Rozycki wrote:
> > On Sat, 2 Sep 2023, Guilherme G. Piccoli wrote:
> > 
> >> So, let's clean the code and set the notifier to run as the
> >> latest, following the same approach other architectures are
> >> doing - also, remove the unnecessary include of a header already
> >> included indirectly.
> > 
> >  FWIW my understanding is our current policy is not to rely on indirect 
> > inclusions and if a given source relies on declarations or definitions 
> > provided by a header, then it is supposed to pull it explicitly.
> > 
> >  And in any case such an unrelated self-contained change is expected to be 
> > sent as a separate patch, in a series if there's a mechanical dependency.
> > 
> >   Maciej
> > 
> 
> Hi Maciej, thanks for your review!
> 
> I'm not sure how the indirect inclusion is happening here. The only
> notifier present in this file is a panic notifier, and for this one, we
> have the "panic_notifier.h" header. It's like this for many others (if
> not all) panic notifiers in the kernel.

IMHO, including linux/panic_notifier.h should be enough. It is includes
linux/notifier.h by definition.

Well, it is not a big deal to keep the include. Let's not block the
change because of this.

> Regarding split in another patch, it can easily be done, but I think
> it's quite self-contained now, a simple patch that cleans-up the alpha
> notifier. I've done that for other notifiers so far, but I'm OK either
> way, as long maintainers are happy and community agrees =)

If I was the maintainer, I would prefer the split as well ;-)
I mean to move the code in one patch and do the changes in
a followup patch.

It is much easier for review. It is more clear what are the real
changes and that there are only wanted changes.

Even removal of the include might be in a separate patch. It helps
to find regressions by bisecting. The eventual revert is easier.
Also it does not block the other changes ;-)

Best Regards,
Petr
