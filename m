Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E532C7F78DE
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231156AbjKXQZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:25:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjKXQZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:25:03 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDA34BB
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:25:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28C7AC433C7;
        Fri, 24 Nov 2023 16:25:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700843109;
        bh=vz2zgekRERvzIcolWYRkH/DuOG/ehsYPRdrpMBVZqGU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L60ux02MLoOnGxe6YwcEu4PG8a0uszd+POyFNJ/n+jWatpAWs+qeF/KMAs8G/03qV
         Ui5AX4KzUYubOs5C/3t3158rF6o54rTUjiAZ3f8zIPZWcL8Za90PW4tfRFKwIuABSj
         xX4S1O7J3lulZQo/lstDnD5IfJ0gdzrs6E7J7vak=
Date:   Fri, 24 Nov 2023 16:25:07 +0000
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Sagar Biradar <sagar.biradar@microchip.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        John Garry <john.g.garry@oracle.com>
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Message-ID: <2023112456-disinfect-undoing-b5ef@gregkh>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 21, 2023 at 10:50:57AM +0100, Thorsten Leemhuis wrote:
> * @SCSI maintainers: could you please look into below please?
> 
> * @Stable team: you might want to take a look as well and consider a
> revert in 6.1.y (yes, I know, those are normally avoided, but here it
> might make sense).
> 
> Hi everyone!
> 
> TLDR: I noticed a regression (Adaptec 71605z with aacraid sometimes
> hangs for a while) that was reported months ago already but is still not
> fixed. Not only that, it apparently more and more users run into this
> recently, as the culprit was recently integrated into 6.1.y; I wonder if
> it would be best to revert it there, unless a fix for mainline comes
> into reach soon.
> 
> Details:
> 
> Quite a few machines with Adaptec controllers seems to hang for a few
> tens of seconds to a few minutes before things start to work normally
> again for a while:
> https://bugzilla.kernel.org/show_bug.cgi?id=217599
> 
> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
> commit despite a warning of mine to Sasha recently made it into 6.1.53
> -- and that way apparently recently reached more users recently, as
> quite a few joined that ticket.
> 
> The culprit is authored by Sagar Biradar who unless I missed something
> never replied even once to the ticket or earlier mails about it. Lore
> has no messages from him since early June.
> 
> Hannes Reinecke at least tried to fix it a few weeks ago (many thx), but
> that didn't work out (see the ticket for details). Since then things
> look stalled again, which is, ehh, unfortunate when it comes to
> regressions.

I am loath to revert a stable patch that has been there for so long as
any upgrade will just cause the same bug to show back up.  Why can't we
just revert it in Linus's tree now and I'll take that revert in the
stable trees as well?

thanks,

greg k-h
