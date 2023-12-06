Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15ECD80712D
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:50:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378617AbjLFNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:49:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D5EBD44
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:49:53 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B6BDB1F8D7;
        Wed,  6 Dec 2023 13:49:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701870591; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=64C5QQ6eD3zVjkzNd+FfGYCQlWWqe1ZkIuBmjwdiWno=;
        b=UWpI+xvhxHqJUS47LW1yHDaap4t8CnMIeLqxuDuX0b1xg2KWDlKejiMrUWasp8XyNKTcG2
        sZyyVhZutFRLcNkaZvQ+I2ms5gKv3z0iWRvTtjwdbSLgQoQ8ubH5h/5+mw9iDrPSUVnK+5
        G3NAma4WyzoLUTZhXOVu7rfnWmsOjrk=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91DA813408;
        Wed,  6 Dec 2023 13:49:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id mHSJIP97cGXjJwAAD6G6ig
        (envelope-from <mhocko@suse.com>); Wed, 06 Dec 2023 13:49:51 +0000
Date:   Wed, 6 Dec 2023 14:49:50 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Philipp Rudo <prudo@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXB7_rbC0GAkIp7p@tiehlicka>
References: <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiAsJlLookvCI+h@MiWiFi-R3L-srv>
 <ZWiQ-II9CvGv8EWK@tiehlicka>
 <20231201123353.2b3db7fa@rotkaeppchen>
 <ZWnJyArAmFo_uYPA@tiehlicka>
 <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206120805.4fdcb8ab@rotkaeppchen>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: -2.60
X-Spamd-Result: default: False [-2.60 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
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

On Wed 06-12-23 12:08:05, Philipp Rudo wrote:
> On Fri, 1 Dec 2023 17:59:02 +0100
> Michal Hocko <mhocko@suse.com> wrote:
> 
> > On Fri 01-12-23 16:51:13, Philipp Rudo wrote:
> > > On Fri, 1 Dec 2023 12:55:52 +0100
> > > Michal Hocko <mhocko@suse.com> wrote:
> > >   
> > > > On Fri 01-12-23 12:33:53, Philipp Rudo wrote:
> > > > [...]  
> > > > > And yes, those are all what-if concerns but unfortunately that is all
> > > > > we have right now.    
> > > > 
> > > > Should theoretical concerns without an actual evidence (e.g. multiple
> > > > drivers known to be broken) become a roadblock for this otherwise useful
> > > > feature?   
> > > 
> > > Those concerns aren't just theoretical. They are experiences we have
> > > from a related feature that suffers exactly the same problem regularly
> > > which wouldn't exist if everybody would simply work "properly".  
> > 
> > What is the related feature?
> 
> kexec

OK, but that is a completely different thing, no? crashkernel parameter
doesn't affect kexec. Or what is the actual relation?

> > > And yes, even purely theoretical concerns can become a roadblock for a
> > > feature when the cost of those theoretical concerns exceed the benefit
> > > of the feature. The thing is that bugs will be reported against kexec.
> > > So _we_ need to figure out which of the shitty drivers caused the
> > > problem. That puts additional burden on _us_. What we are trying to
> > > evaluate at the moment is if the benefit outweighs the extra burden
> > > with the information we have at the moment.  
> > 
> > I do understand your concerns! But I am pretty sure you do realize that
> > it is really hard to argue theoreticals.  Let me restate what I consider
> > facts. Hopefully we can agree on these points
> > 	- the CMA region can be used by user space memory which is a
> > 	  great advantage because the memory is not wasted and our
> > 	  experience has shown that users do care about this a lot. We
> > 	  _know_ that pressure on making those reservations smaller
> > 	  results in a less reliable crashdump and more resources spent
> > 	  on tuning and testing (especially after major upgrades).  A
> > 	  larger reservation which is not completely wasted for the
> > 	  normal runtime is addressing that concern.
> > 	- There is no other known mechanism to achieve the reusability
> > 	  of the crash kernel memory to stop the wastage without much
> > 	  more intrusive code/api impact (e.g. a separate zone or
> > 	  dedicated interface to prevent any hazardous usage like RDMA).
> > 	- implementation wise the patch has a very small footprint. It
> > 	  is using an existing infrastructure (CMA) and it adds a
> > 	  minimal hooking into crashkernel configuration.
> > 	- The only identified risk so far is RDMA acting on this memory
> > 	  without using proper pinning interface. If it helps to have a
> > 	  statement from RDMA maintainers/developers then we can pull
> > 	  them in for a further discussion of course.
> > 	- The feature requires an explicit opt-in so this doesn't bring
> > 	  any new risk to existing crash kernel users until they decide
> > 	  to use it. AFAIU there is no way to tell that the crash kernel
> > 	  memory used to be CMA based in the primary kernel. If you
> > 	  believe that having that information available for
> > 	  debugability would help then I believe this shouldn't be hard
> > 	  to add.  I think it would even make sense to mark this feature
> > 	  experimental to make it clear to users that this needs some
> > 	  time before it can be marked production ready.
> > 
> > I hope I haven't really missed anything important. The final
> 
> If I understand Documentation/core-api/pin_user_pages.rst correctly you
> missed case 1 Direct IO. In that case "short term" DMA is allowed for
> pages without FOLL_LONGTERM. Meaning that there is a way you can
> corrupt the CMA and with that the crash kernel after the production
> kernel has panicked.

Could you expand on this? How exactly direct IO request survives across
into the kdump kernel? I do understand the RMDA case because the IO is
async and out of control of the receiving end.

Also if direct IO is a problem how come this is not a problem for kexec
in general. The new kernel usually shares all the memory with the 1st
kernel.

/me confused.
-- 
Michal Hocko
SUSE Labs
