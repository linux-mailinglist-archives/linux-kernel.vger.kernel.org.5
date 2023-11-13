Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A0D27EA586
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 22:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231804AbjKMVhl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 16:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMVhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 16:37:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281A0D68;
        Mon, 13 Nov 2023 13:37:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B3C9C433C8;
        Mon, 13 Nov 2023 21:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699911456;
        bh=xQc5JLHDvxSflGI+W8bGTg4cLOgkDFItdB/5D5OsLX0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kZkMXIZ2NrBr3aq9q4+sjYbpUUB6ZpoKXpTlbLgWblC3mLGyQdsFlCxitfh4JoliK
         I3qLle93j0VcFR+vdIHegyW7L/I2QAV3HZZQ+5bN+8gHJdTEJMYPM6RLxvTV/pzrjK
         /mSZsog3D1IEd/459lwnsvxfIjLqRuURCt2gqyGM=
Date:   Mon, 13 Nov 2023 16:37:34 -0500
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     =?utf-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Cc:     Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH] /proc/sysrq-trigger: accept multiple keys at once
Message-ID: <2023111330-headstone-pyromania-c57e@gregkh>
References: <20231113182227.698989-1-tomas.mudrunka@gmail.com>
 <2023111333-duly-mobility-edc7@gregkh>
 <CAH2-hcLoz591mduTVPtFd0ZOEzMNSzhU108qqvv-ZWre7+jm9Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2-hcLoz591mduTVPtFd0ZOEzMNSzhU108qqvv-ZWre7+jm9Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 10:09:50PM +0100, Tomáš Mudruňka wrote:
> po 13. 11. 2023 v 19:33 Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > What did you just break where people would send a string and only relied
> > on the first character being checked?  This might not be ok to do.
> 
> It truly might not be ok. But i hope you will not consider me impolite
> if i open further discussion. Is this actual use case for some people?

It might be, we can't start doing different functionality just because
we were previously ignoring all the other characters.  Especially for a
user/kernel api that is allowed to reboot the machine :)

> I understand that it might be, but currently i can only think about
> this being done by mistake, rather than on purpose... are you aware of
> any software actually leveraging this feature?

I'm not, but there is a lot of userspace software out there...

> Please also note that there is really good use case for this. if i do
> the REISUB bash loop as suggested, the bash will be killed during E or
> I and the rest of emergency procedure will not finish. Therefore i
> really think it makes sense to be able to pass whole sysrq batch to
> the kernel at once.
> 
> In case you are sure that this is a bad idea, i can suggest
> alternative approach. only activate the "bulk mode" when first
> character is '_' (underscore).
> User would then be able to do
> echo _reisub > /proc/sysrq-trigger
> 
> Would you prefer if i do it this way? In my opinion it does introduce
> little unnecessary complexity, to fix something that might arguably
> not be actual issue. I mean... we still have /dev/null in case people
> need to discard some extra characters. :-)
> But if you think it's better to stay on safe side, i think it's viable
> option as well...

I think you are only going to be able to do this "mode switch" method as
we can't potentially break existing systems.  Your change should prevent
that from happening, so at a quick glance, yes, this seems like the only
way forward if this is needed at all (an independent question...)

thanks,

greg k-h
