Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4CC80A06A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 11:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233338AbjLHKE3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 05:04:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjLHKE1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 05:04:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E38171E
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 02:04:33 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 511202212B;
        Fri,  8 Dec 2023 10:04:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 11D8012FF7;
        Fri,  8 Dec 2023 10:04:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id +t5LATDqcmVNHgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Fri, 08 Dec 2023 10:04:32 +0000
Date:   Fri, 8 Dec 2023 11:04:27 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Philipp Rudo <prudo@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        David Hildenbrand <dhildenb@redhat.com>
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZXLqK_Shia2CFqnH@tiehlicka>
References: <20231201165113.43211a48@rotkaeppchen>
 <ZWoQ1k2AikSiMjys@tiehlicka>
 <20231206120805.4fdcb8ab@rotkaeppchen>
 <ZXB7_rbC0GAkIp7p@tiehlicka>
 <ZXCRF-bvm8ijXxr4@tiehlicka>
 <ZXFIsZ+0GmUZMFk3@MiWiFi-R3L-srv>
 <ZXGIeAgCcatUDa2h@tiehlicka>
 <20231207121314.50b8e4c4@rotkaeppchen>
 <ZXGyANwELvFKpysH@tiehlicka>
 <ZXJ3m4fPZXJnj29z@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZXJ3m4fPZXJnj29z@MiWiFi-R3L-srv>
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[11];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out1.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out1.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd1
X-Rspamd-Queue-Id: 511202212B
X-Spam-Score: 15.00
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 08-12-23 09:55:39, Baoquan He wrote:
> On 12/07/23 at 12:52pm, Michal Hocko wrote:
> > On Thu 07-12-23 12:13:14, Philipp Rudo wrote:
[...]
> > > Thing is that users don't only want to reduce the memory usage but also
> > > the downtime of kdump. In the end I'm afraid that "simply waiting" will
> > > make things unnecessarily more complex without really solving any issue.
> > 
> > I am not sure I see the added complexity. Something as simple as
> > __crash_kexec:
> > 	if (crashk_cma_cnt) 
> > 		mdelay(TIMEOUT)
> > 
> > should do the trick.
> 
> I would say please don't do this. kdump jumping is a very quick
> behavirou after corruption, usually in several seconds. I can't see any
> meaningful stuff with the delay of one minute or several minutes.

Well, I've been told that DMA should complete within seconds after
controller is programmed (if that was much more then short term pinning
is not really appropriate because that would block memory movability for
way too long and therefore result in failures). This is something we can
tune for.

But if that sounds like a completely wrong approach then I think an
alternative would be to live with potential inflight DMAs just avoid
using that memory by the kdump kernel before the DMA controllers (PCI
bus) is reinitialized by the kdump kernel. That should happen early in
the boot process IIRC and the CMA backed memory could be added after
that moment. We already do have means so defer memory initialization
so an extension shouldn't be hard to do. It will be a slightly more involved
patch touching core MM which we have tried to avoid so far. Does that
sound like something acceptable?

[...]

> > The thing we should keep in mind is that the memory sitting aside is not
> > used in majority of time. Crashes (luckily/hopefully) do not happen very
> > often. And I can really see why people are reluctant to waste it. Every
> > MB of memory has an operational price tag on it. And let's just be
> > really honest, a simple reboot without a crash dump is very likely
> > a cheaper option than wasting a productive memory as long as the issue
> > happens very seldom.
> 
> All the time, I have never heard people don't want to "waste" the
> memory. E.g, for more than 90% of system on x86, 256M is enough. The
> rare exceptions will be noted once recognized and documented in product
> release.
> 
> And ,cma is not silver bullet, see this oom issue caused by i40e and its
> fix , your crashkernel=1G,cma won't help either.
> 
> [v1,0/3] Reducing memory usage of i40e for kdump
> https://patchwork.ozlabs.org/project/intel-wired-lan/cover/20210304025543.334912-1-coxu@redhat.com/
> 
> ======Abstrcted from above cover letter==========================
> After reducing the allocation of tx/rx/arg/asq ring buffers to the
> minimum, the memory consumption is significantly reduced,
>     - x86_64: 85.1MB to 1.2MB 
>     - POWER9: 15368.5MB to 20.8MB
> ==================================================================

Nice to see memory consumption reduction fixes. But, honestly this
should happen regardless of kdump. CMA backed kdump is not to
workaround excessive kernel memory consumers. It seems I am failing to
get the message through :( but I do not know how else to express that the
pressure on reducing the wasted memory is real. It is not important
whether 256MB is enough for everybody. Even that would grow to non
trivial cost in data centers with many machines.

> And say more about it. This is not the first time of attempt to make use
> of ,cma area for crashkernel=. In redhat, at least 5 people have tried
> to add this, finally we gave up after long discussion and investigation.
> This year, one kernel developer in our team raised this again with a
> very long mail after his own analysis, we told him the discussion and
> trying we have done in the past.

This is really hard to comment on without any references to those
discussions. From this particular email thread I have a perception that
you guys focus much more on correctness provability than feasibility. If
we applied the same approach universally then many other features
couldn't have been merged. E.g. kexec for reasons you have mentioned in
the email thread.

Anyway, thanks for pointing to regular DMA via gup case which we were
obviously not aware of. I personally have considered this to be a
marginal problem comparing to RDMA which is unpredictable wrt timing.
But we believe that this could be worked around. Now it would be really
valuable if we knew somebody has _tried_ that and it turned out not
working because of XYZ reasons.  That would be a solid base to
re-evaluate and think of different approaches.

Look, this will be your call as maintainers in the end. If you are
decided then fair enough. We might end up trying this feature downstream
and maybe come back in the future with an experience which we currently
do not have. But it seems we are not alone seeing the existing state is
insufficient (http://lkml.kernel.org/r/20230719224821.GC3528218@google.com).

Thanks!
-- 
Michal Hocko
SUSE Labs
