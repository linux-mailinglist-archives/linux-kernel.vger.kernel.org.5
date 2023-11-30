Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC2F7FF05C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjK3NlL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:41:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232050AbjK3NlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:41:10 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE96C4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:41:15 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id CD3C71F8BF;
        Thu, 30 Nov 2023 13:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701351673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9F9Mgbd1Q4nxfYba9ZeBtXatG2N5U9vDkUkfp7pibMc=;
        b=NDNLxkDV7C7sVgY2ASW+FK9THKNYGKG9Uyf9jdGkIx/rUOWgxWzVeNVfAUva8bkjJR70UN
        Rr49wObYN5j8iyFNhRpZbHH1/MHx37i9VvjqmB1q988TQMS1rVQyC7+5abTjwVI3xBBBJo
        n0arfHpl0zPyW8Hi7NASLOoaXwuBTy4=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AAA8213AB1;
        Thu, 30 Nov 2023 13:41:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id V4niJvmQaGWRQwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:41:13 +0000
Date:   Thu, 30 Nov 2023 14:41:12 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
        Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiQ-II9CvGv8EWK@tiehlicka>
References: <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.60
X-Spamd-Result: default: False [-3.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-11-23 20:31:44, Baoquan He wrote:
[...]
> > > which doesn't use the proper pinning API (which would migrate away from
> > > the CMA) then what is the worst case? We will get crash kernel corrupted
> > > potentially and fail to take a proper kernel crash, right? Is this
> > > worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> 
> We may fail to take a proper kernel crash, why isn't it a roadblock?

It would be if the threat was practical. So far I only see very
theoretical what-if concerns. And I do not mean to downplay those at
all. As already explained proper CMA users shouldn't ever leak out any
writes across kernel reboot.

> We
> have stable way with a little more memory, why would we take risk to
> take another way, just for saving memory? Usually only high end server
> needs the big memory for crashkernel and the big end server usually have
> huge system ram. The big memory will be a very small percentage relative
> to huge system RAM.

Jiri will likely talk more specific about that but our experience tells
that proper crashkernel memory scaling has turned out a real
maintainability problem because existing setups tend to break with major
kernel version upgrades or non trivial changes.
 
> > > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > > is the said theoretical driver that needs fixing anyway.
> 
> Now, what we want to make clear is if it's a theoretical possibility, or
> very likely happen. We have met several on-flight DMA stomping into
> kexec kernel's initrd in the past two years because device driver didn't
> provide shutdown() methor properly. For kdump, once it happen, the pain
> is we don't know how to debug. For kexec reboot, customer allows to
> login their system to reproduce and figure out the stomping. For kdump,
> the system corruption rarely happend, and the stomping could rarely
> happen too.

yes, this is understood.
 
> The code change looks simple and the benefit is very attractive. I
> surely like it if finally people confirm there's no risk. As I said, we
> can't afford to take the risk if it possibly happen. But I don't object
> if other people would rather take risk, we can let it land in kernel.

I think it is fair to be cautious and I wouldn't impose the new method
as a default. Only time can tell how safe this really is. It is hard to
protect agains theoretical issues though. Bugs should be fixed.
I believe this option would allow to configure kdump much easier and
less fragile.
 
> My personal opinion, thanks for sharing your thought.

Thanks for sharing.

-- 
Michal Hocko
SUSE Labs
