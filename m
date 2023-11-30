Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7849C7FF023
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:29:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345562AbjK3N33 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:29:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjK3N31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:29:27 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2a07:de40:b251:101:10:150:64:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC5B10DE
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:29:34 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id A09AD1FCE9;
        Thu, 30 Nov 2023 13:29:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7360F13AB1;
        Thu, 30 Nov 2023 13:29:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id Aq3+FzyOaGWUQAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:29:32 +0000
Date:   Thu, 30 Nov 2023 14:29:31 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Donald Dutile <ddutile@redhat.com>, Jiri Bohac <jbohac@suse.cz>,
        Pingfan Liu <piliu@redhat.com>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiOO-KNJ82f6Gxu@tiehlicka>
References: <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
X-Spamd-Bar: +++++++++++++++
Authentication-Results: smtp-out2.suse.de;
        dkim=none;
        dmarc=fail reason="No valid SPF, No valid DKIM" header.from=suse.com (policy=quarantine);
        spf=fail (smtp-out2.suse.de: domain of mhocko@suse.com does not designate 2a07:de40:b281:104:10:150:64:97 as permitted sender) smtp.mailfrom=mhocko@suse.com
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [15.00 / 50.00];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         R_SPF_FAIL(1.00)[-all];
         ARC_NA(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         NEURAL_HAM_LONG(-1.00)[-0.997];
         MIME_GOOD(-0.10)[text/plain];
         MID_RHS_NOT_FQDN(0.50)[];
         DMARC_POLICY_QUARANTINE(1.50)[suse.com : No valid SPF, No valid DKIM,quarantine];
         SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
         RCVD_COUNT_THREE(0.00)[3];
         MX_GOOD(-0.01)[];
         RCPT_COUNT_SEVEN(0.00)[9];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         R_DKIM_NA(2.20)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_IN_DNSWL_HI(-1.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Score: 15.00
X-Rspamd-Queue-Id: A09AD1FCE9
X-Spam: Yes
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-11-23 20:04:59, Baoquan He wrote:
> On 11/30/23 at 11:16am, Michal Hocko wrote:
> > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > [...]
> > > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > > or DMA will interfere with kdump kernel's normal memory accessing?
> > > Because kdump kernel usually only reset and initialize the needed
> > > device, e.g dump target. Those unneeded devices will be unshutdown and
> > > let go. 
> > 
> > I do not really want to discount your concerns but I am bit confused why
> > this matters so much. First of all, if there is a buggy RDMA driver
> > which doesn't use the proper pinning API (which would migrate away from
> > the CMA) then what is the worst case? We will get crash kernel corrupted
> > potentially and fail to take a proper kernel crash, right? Is this
> > worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > is the said theoretical driver that needs fixing anyway.
> > 
> > Now, it is really fair to mention that CMA backed crash kernel memory
> > has some limitations
> > 	- CMA reservation can only be used by the userspace in the
> > 	  primary kernel. If the size is overshot this might have
> > 	  negative impact on kernel allocations
> > 	- userspace memory dumping in the crash kernel is fundamentally
> > 	  incomplete.
> 
> I am not sure if we are talking about the same thing. My concern is:
> ====================================================================
> 1) system corrutption happened, crash dumping is prepared, cpu and
> interrupt controllers are shutdown;
> 2) all pci devices are kept alive;
> 3) kdump kernel boot up, initialization is only done on those devices
> which drivers are added into kdump kernel's initrd;
> 4) those on-flight DMA engine could be still working if their kernel
> module is not loaded;
> 
> In this case, if the DMA's destination is located in crashkernel=,cma
> region, the DMA writting could continue even when kdump kernel has put
> important kernel data into the area. Is this possible or absolutely not
> possible with DMA, RDMA, or any other stuff which could keep accessing
> that area?

I do nuderstand your concern. But as already stated if anybody uses
movable memory (CMA including) as a target of {R}DMA then that memory
should be properly pinned. That would mean that the memory will be
migrated to somewhere outside of movable (CMA) memory before the
transfer is configured. So modulo bugs this shouldn't really happen.
Are there {R}DMA drivers that do not pin memory correctly? Possibly. Is
that a road bloack to not using CMA to back crash kernel memory, I do
not think so. Those drivers should be fixed instead.

> The existing crashkernel= syntax can gurantee the reserved crashkernel
> area for kdump kernel is safe.

I do not think this is true. If a DMA is misconfigured it can still
target crash kernel memory even if it is not mapped AFAICS. But those
are theoreticals. Or am I missing something?
-- 
Michal Hocko
SUSE Labs
