Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFC6A79F9B8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 07:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234632AbjINFDo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 01:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233781AbjINFDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 01:03:42 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63DE51BCA;
        Wed, 13 Sep 2023 22:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=weissschuh.net;
        s=mail; t=1694667816;
        bh=zaJQ9ZymV5taIz5m4T4i5glZ2wKz2JIJ1ijQFw1ecAY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oS+i8l1oRw5IVtAyeOFJ5jLSSqQfMyauPSiPgXdtawKBKwoqBP+7e/yAxd3fuIKgK
         YUJ0Vtqrac0UIDasp63PQVwWnGVFrIcu26Jlp4kXXQal8Bm+K1B/0qLHgmERfQKf0n
         iBf6LR0fMI233OYe2bCrnXXiAlA1sdlZ9275YVZs=
Date:   Thu, 14 Sep 2023 07:03:35 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>
To:     Dennis Bonke <admin@dennisbonke.com>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/x86: thinkpad_acpi: Take mutex in hotkey_resume
Message-ID: <2ef51572-3a41-4088-8630-b474f5b8feae@t-8ch.de>
References: <20230913231829.192842-1-admin@dennisbonke.com>
 <900bedba-378e-4215-8b88-27dcc6353164@t-8ch.de>
 <b5246c7e2b81afe99bd146dd1209b1971b196a0b.camel@dennisbonke.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b5246c7e2b81afe99bd146dd1209b1971b196a0b.camel@dennisbonke.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dennis,

On 2023-09-14 02:36:44+0200, Dennis Bonke (admin) wrote:
> On Thu, 2023-09-14 at 01:33 +0200, Thomas Weißschuh wrote:
> > thanks for the fix!
> Hello Thomas,
> 
> Thank you for the quick review!

The least I can do if somebody else has to clean up my mess :-)

> I apologize for the messy V2 that I seem to have posted.
> It's my first time working with a mailing list and it seems that something went wrong.

No need to apologize.


Some more notes:

You should also CC LKML (linux-kernel@vger.kernel.org) and the
subsystems maintainers as per MAINTAINERS / get_maintainers.pl on all
your patches.

And now that I have worked with you on a patch also CC me on new
revisions.

I can also recommend the usage of the "b4"[0] tool to prepare your
patches. It takes care of some of the chores.

[0] https://b4.docs.kernel.org/en/latest/

Some more comments below.

> > 
> > On 2023-09-14 01:18:29+0200, admin@dennisbonke.com wrote:
> > > From: Dennis Bonke <admin@dennisbonke.com>
> > > 
> > > hotkey_status_{set,get} expect the hotkey_mutex to be held.
> > > It seems like it was missed here and that gives warnings while resuming.
> > 
> > Which kind of warnings?
> > 
> > If it's from lockdep then it's triggered by hotkey_mask_set() and the
> > commit message is a bit off.
> It is indeed from lockdep. I've changed the commit message to reflect your comment.

Thanks!

> > 
> > Also then the patch needs:
> > 
> > Fixes: 38831eaf7d4c ("platform/x86: thinkpad_acpi: use lockdep annotations")
> > Cc: stable@vger.kernel.org
> > 
> > With those:
> > 
> > Reviewed-by: Thomas Weißschuh <linux@weissschuh.net>

> About those tags, do I add them to the patch? Just double checking
> before I accidentally CC the stable list with an incorrect patch.

Yes, please add them to the patch.
The CC stable will only have any effect after your patch is in Linus'
tree at which point multiple people will have looked at it.
If an incorrect patch makes it that far it's not your fault.

> > > 
> > > Signed-off-by: Dennis Bonke <admin@dennisbonke.com>
> > > ---
> > >  drivers/platform/x86/thinkpad_acpi.c | 2 ++
> > >  1 file changed, 2 insertions(+)
> > > 
> > > diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
> > > index d70c89d32534..de5859a5eb0d 100644
> > > --- a/drivers/platform/x86/thinkpad_acpi.c
> > > +++ b/drivers/platform/x86/thinkpad_acpi.c
> > > @@ -4116,9 +4116,11 @@ static void hotkey_resume(void)
> > >  {
> > >         tpacpi_disable_brightness_delay();
> > >  
> > > +       mutex_lock(&hotkey_mutex)
> > >         if (hotkey_status_set(true) < 0 ||
> > >             hotkey_mask_set(hotkey_acpi_mask) < 0)
> > >                 pr_err("error while attempting to reset the event firmware interface\n");
> > > +       mutex_unlock(&hotkey_mutex);
> > >  
> > >         tpacpi_send_radiosw_update();
> > >         tpacpi_input_send_tabletsw();
> > > -- 
> > > 2.40.1
> > > 
> 

Thomas
