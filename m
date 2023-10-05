Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3C47BA046
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234143AbjJEOey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 10:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235115AbjJEOdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 10:33:11 -0400
Received: from angie.orcam.me.uk (angie.orcam.me.uk [IPv6:2001:4190:8020::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C342261B4;
        Thu,  5 Oct 2023 05:24:16 -0700 (PDT)
Received: by angie.orcam.me.uk (Postfix, from userid 500)
        id 6F01992009C; Thu,  5 Oct 2023 14:24:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by angie.orcam.me.uk (Postfix) with ESMTP id 6B00692009B;
        Thu,  5 Oct 2023 13:24:12 +0100 (BST)
Date:   Thu, 5 Oct 2023 13:24:12 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@orcam.me.uk>
To:     Dan Carpenter <dan.carpenter@linaro.org>
cc:     Su Hui <suhui@nfschina.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rafael@kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] driver base: slience unused warning
In-Reply-To: <d98f7107-56d7-44a3-8b77-b8766cdc02d9@kadam.mountain>
Message-ID: <alpine.DEB.2.21.2310051305530.20354@angie.orcam.me.uk>
References: <45027fa0-cda5-2a80-f1cd-ed805d2717ee@nfschina.com> <alpine.DEB.2.21.2310041557310.61599@angie.orcam.me.uk> <d98f7107-56d7-44a3-8b77-b8766cdc02d9@kadam.mountain>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Oct 2023, Dan Carpenter wrote:

> > > This variable is been used but never be read, so gcc and W=1 give such
> > > warning.
> > > 
> > > drivers/base/module.c:36:6: error:
> > > variable ‘no_warn’ set but not used [-Werror=unused-but-set-variable]
> > > 
> > > I wanted to use "__maybe_unused" to avoid  this warning.
> > > 
> > > However it seems like a wrong using of "__maybe_unused" as Greg KH said:
> > > 
> > > "But no_warn is being used in this file, it's being set but not read
> > > which is ok.  That's a real use, so this change really isn't correct,
> > > sorry."
> > 
> >  The warning itself is a real issue to be sorted though.  Is this a use 
> > case for `#pragma GCC diagnostic'?
> 
> I thought Greg liked using __maybe_unused in this case?  This is
> drivers/base.  Do the rest of us even get a vote?  ;)
> 
> If I do have a vote then #pragma is always the worst option.  Linus has
> taught me to dislike pragmas a lot.

 I'm not a great supporter of this solution, but at least it's guaranteed 
to work by definition.  Otherwise we could try to outsmart the compiler; 
perhaps:

	(no_warn = sysfs_create_link(&drv->p->kobj, &mk->kobj,
				     "module")), no_warn;

would work.  At the end of the day it's us who told the compiler to warn 
if the result of `sysfs_create_link' is unused with all the consequences.  
And while assigning to `no_warn' technically fulfils the requirement, the 
variable itself isn't used beyond being assigned to, which the compiler 
rightfully complains about because we asked for it.  It's up to us really 
to tell the compiler what we want it to complain about and what we do not.

  Maciej
