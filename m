Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE6765807
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233635AbjG0PvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229965AbjG0PvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:51:01 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91ACB26BC;
        Thu, 27 Jul 2023 08:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=whKeVZWLhmUYByq+U/YnOMvphcGTOrmTTlmTUFROnf0=; b=boxukzui/wv967gWjsN1nu1vL8
        BbCpncLGebuycMF8caT1clC2fsrYVjiVM2mc73Opka5/x758sffC01xiM2lgIPMU7frfQ4an8355L
        6+cYY589IjVE6RaneL/6XS4S7mPu9V8ToD7AIcDHPMKgNE1TRdiz99eJrk6NwcR29dszNgH5KzV95
        Zng3e1ahmT86WH2d71zAVZAaZi6NxUvKJv9JemqyJAnAUuB+C4nVfSTBVhORdn9XVkr+ti2OUmFRK
        P+afcJV6rmETsrWIsClJ92ibmNFp+TtQ6wTN+o+L23yUuHRnpRejf2FVeu34FxgLQMai+yYiG4uJN
        FDfIH3ZQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qP3GL-00G8P5-09;
        Thu, 27 Jul 2023 15:50:49 +0000
Date:   Thu, 27 Jul 2023 08:50:49 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Joel Granados <j.granados@samsung.com>
Cc:     Joerg Reuter <jreuter@yaina.de>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, willy@infradead.org,
        keescook@chromium.org, josh@joshtriplett.org,
        linux-hams@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/14] ax.25: Update to register_net_sysctl_sz
Message-ID: <ZMKSWewULuEH6Naa@bombadil.infradead.org>
References: <20230726140635.2059334-1-j.granados@samsung.com>
 <CGME20230726140703eucas1p2786577bcc67d5ae434671dac11870c60@eucas1p2.samsung.com>
 <20230726140635.2059334-10-j.granados@samsung.com>
 <ZMFfRR3PftnLHPlT@bombadil.infradead.org>
 <20230727153804.vjsofabjbkkfat25@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727153804.vjsofabjbkkfat25@localhost>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 05:38:04PM +0200, Joel Granados wrote:
> On Wed, Jul 26, 2023 at 11:00:37AM -0700, Luis Chamberlain wrote:
> > On Wed, Jul 26, 2023 at 04:06:29PM +0200, Joel Granados wrote:
> > > This is part of the effort to remove the sentinel (last empty) element
> > > from the ctl_table arrays. We update to the new function and pass it the
> > > array size.
> > 
> > The commit log does not explain why. It also does not explain if there
> > is any delta on size at compile or runtime.
> Just to be on the same page:
> You mean the specific why for this commit. like for example:
> "
> We update  to register_net_sysctl_sz

I think it is clearer to just say:

Move from register_net_sysctl() to register_net_sysctl_sz()

> to prepare for when the ctl_table
> array sentinels are removed.

That is not as clear. I think you should just spell it out.

We want to use the syctl ARRAY_SIZE() when possible, and subsequent
patches ... now the register_net_sysctl() <does something> while
register_net_sysctl_sz() <does something else> and <in this case>
this user <does something> and so we must use register_net_sysctl_sz().

> "
> 
> right?

  Luis
