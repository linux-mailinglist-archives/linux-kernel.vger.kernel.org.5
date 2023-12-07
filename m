Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C023808710
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 12:52:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379076AbjLGLwa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 06:52:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjLGLw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 06:52:28 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95431D5C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 03:52:34 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 301D421DA2;
        Thu,  7 Dec 2023 11:52:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701949953; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zXp2pBxzzfhn7WW87mLOEoOlFwRFI4WpDCdw5P4sAjI=;
        b=rVi4JuRLwDorsYJ4fWcMcRnoxwCCfvUMzYiArSjZkSvy1UBYgbhYjGGms1QDCYBsGGBSIN
        UCYYFPUGuU9Mdv4kAWOt6n32Bah80ekgI7eNK7Rmp/1rV1XzUYDE7eP8COXMGUGb3a1QwB
        D1pdAspcrz26eF92s3f/Ni6cHbOYpcQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0A5FD13B6A;
        Thu,  7 Dec 2023 11:52:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 7MQrOwCycWUIfQAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 07 Dec 2023 11:52:32 +0000
Date:   Thu, 7 Dec 2023 12:52:32 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXGyANwELvFKpysH@tiehlicka>
References: <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
 <20231207121314.50b8e4c4@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207121314.50b8e4c4@rotkaeppchen>
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-1.000];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-1.000];
         RCPT_COUNT_SEVEN(0.00)[11];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
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

On Thu 07-12-23 12:13:14, Philipp Rudo wrote:
> On Thu, 7 Dec 2023 09:55:20 +0100
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Thu 07-12-23 12:23:13, Baoquan He wrote:
> > [...]
> > > We can't guarantee how swift the DMA transfer could be in the cma, case,
> > > it will be a venture.  
> > 
> > We can't guarantee this of course but AFAIK the DMA shouldn't take
> > minutes, right? While not perfect, waiting for some time before jumping
> > into the crash kernel should be acceptable from user POV and it should
> > work around most of those potential lingering programmed DMA transfers.
> 
> I don't think that simply waiting is acceptable. For one it doesn't
> guarantee that there is no corruption (please also see below) but only
> reduces its probability. Furthermore, how long would you wait?

I would like to talk to storage experts to have some ballpark idea about
worst case scenario but waiting for 1 minutes shouldn't terribly
influence downtime and remember this is an opt-in feature. If that
doesn't fit your use case, do not use it.

> Thing is that users don't only want to reduce the memory usage but also
> the downtime of kdump. In the end I'm afraid that "simply waiting" will
> make things unnecessarily more complex without really solving any issue.

I am not sure I see the added complexity. Something as simple as
__crash_kexec:
	if (crashk_cma_cnt) 
		mdelay(TIMEOUT)

should do the trick.

> > So I guess what we would like to hear from you as kdump maintainers is
> > this. Is it absolutely imperative that these issue must be proven
> > impossible or is a best effort approach something worth investing time
> > into? Because if the requirement is an absolute guarantee then I simply
> > do not see any feasible way to achieve the goal of reusable memory.
> > 
> > Let me reiterate that the existing reservation mechanism is showing its
> > limits for production systems and I strongly believe this is something
> > that needs addressing because crash dumps are very often the only tool
> > to investigate complex issues.
> 
> Because having a crash dump is so important I want a prove that no
> legal operation can corrupt the crashkernel memory. The easiest way to
> achieve this is by simply keeping the two memory regions fully
> separated like it is today. In theory it should also be possible to
> prevent any kind of page pinning in the shared crashkernel memory. But
> I don't know which side effect this has for mm. Such an idea needs to
> be discussed on the mm mailing list first.

I do not see that as a feasible option. That would require to migrate
memory on any gup user that might end up sending data over DMA.

> Finally, let me question whether the whole approach actually solves
> anything. For me the difficulty in determining the correct crashkernel
> memory is only a symptom. The real problem is that most developers
> don't expect their code to run outside their typical environment.
> Especially not in an memory constraint environment like kdump. But that
> problem won't be solved by throwing more memory at it as this
> additional memory will eventually run out as well. In the end we are
> back at the point where we are today but with more memory.

I disagree with you here. While the kernel is really willing to cache
objects into memory I do not think that any particular subsystem is
super eager to waste memory.

The thing we should keep in mind is that the memory sitting aside is not
used in majority of time. Crashes (luckily/hopefully) do not happen very
often. And I can really see why people are reluctant to waste it. Every
MB of memory has an operational price tag on it. And let's just be
really honest, a simple reboot without a crash dump is very likely
a cheaper option than wasting a productive memory as long as the issue
happens very seldom.
 
> Finally finally, one tip. Next time a customer complaints about how
> much memory the crashkernel "wastes" ask them how much one day of down
> time for one machine costs them and how much memory they could buy for
> that money. After that calculation I'm pretty sure that an additional
> 100M of crashkernel memory becomes much more tempting.

Exactly and that is why a simple reboot would be a preferred option than
configuring kdump and invest admin time to keep testing configuration
after every (major) upgrade to make sure the existing setup still works.
From my experience crashdump availability hugely improves chances to get
underlying crash diagnosed and bug solved so it is also in our interest
to encourage kdump deployments as much as possible.

Now I do get your concerns about potential issues and I fully recognize
the pain you have gone through when debugging these subtle issues in the
past but let's not forget that perfect is an enemy of good and that a
best effort solution might be better than crash dumps at all.

At the end, let me just ask a theoretical question. With the experience
you have gained would you nack the kexec support if it was proposed now
just because of all the potential problems it might have?
-- 
Michal Hocko
SUSE Labs
