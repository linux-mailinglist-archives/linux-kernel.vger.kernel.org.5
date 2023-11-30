Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 051007FF06F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:43:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345633AbjK3NnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345622AbjK3NnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:43:05 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2a07:de40:b251:101:10:150:64:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37A84194
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 05:43:11 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id CF6D021A3C;
        Thu, 30 Nov 2023 13:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701351789; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=E0xXRK+aUL8cLCXEAdHHc8BYb0q+10UFV8/xhlNkfxo=;
        b=UqaGXeICW1+gaCJDa6EZhJWtlB4LY7R/CiHmE7gP5NDtbyhtrd5Q+id0DpmQy3PSdQXx3F
        YmKFs6lmIf1ejZKglsIKpWaF9FPWZ+VoI60WHgMFsIUDiTkTgPCdVjHECXhi50gel2Va4A
        8dRFvP2nKJJRJQPukyjxCPgNnS7KyJY=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AB59113AB1;
        Thu, 30 Nov 2023 13:43:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id q5nTJm2RaGUKRAAAD6G6ig
        (envelope-from <mhocko@suse.com>); Thu, 30 Nov 2023 13:43:09 +0000
Date:   Thu, 30 Nov 2023 14:43:08 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Pingfan Liu <piliu@redhat.com>
Cc:     Baoquan He <bhe@redhat.com>, Donald Dutile <ddutile@redhat.com>,
        Jiri Bohac <jbohac@suse.cz>, Tao Liu <ltao@redhat.com>,
        Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWiRbLGdBMO2jFGs@tiehlicka>
References: <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
 <ZWWuBSiZZdF2W12j@tiehlicka>
 <ZWbyDx3TJ7zo3jCw@MiWiFi-R3L-srv>
 <91a31ce5-63d1-7470-18f7-92b039fda8e6@redhat.com>
 <ZWf64BowWrYqA2Rf@MiWiFi-R3L-srv>
 <ZWhg_b3O6piZtkQ-@tiehlicka>
 <ZWh6ax8YmkhxAzIf@MiWiFi-R3L-srv>
 <ZWiOO-KNJ82f6Gxu@tiehlicka>
 <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAF+s44QSJL5e6BVTAyyHR9Kzx7RJqZSkR=uXEypaouK_XuBbEw@mail.gmail.com>
Authentication-Results: smtp-out1.suse.de;
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
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 30-11-23 21:33:04, Pingfan Liu wrote:
> On Thu, Nov 30, 2023 at 9:29 PM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Thu 30-11-23 20:04:59, Baoquan He wrote:
> > > On 11/30/23 at 11:16am, Michal Hocko wrote:
> > > > On Thu 30-11-23 11:00:48, Baoquan He wrote:
> > > > [...]
> > > > > Now, we are worried if there's risk if the CMA area is retaken into kdump
> > > > > kernel as system RAM. E.g is it possible that 1st kernel's ongoing RDMA
> > > > > or DMA will interfere with kdump kernel's normal memory accessing?
> > > > > Because kdump kernel usually only reset and initialize the needed
> > > > > device, e.g dump target. Those unneeded devices will be unshutdown and
> > > > > let go.
> > > >
> > > > I do not really want to discount your concerns but I am bit confused why
> > > > this matters so much. First of all, if there is a buggy RDMA driver
> > > > which doesn't use the proper pinning API (which would migrate away from
> > > > the CMA) then what is the worst case? We will get crash kernel corrupted
> > > > potentially and fail to take a proper kernel crash, right? Is this
> > > > worrisome? Yes. Is it a real roadblock? I do not think so. The problem
> > > > seems theoretical to me and it is not CMA usage at fault here IMHO. It
> > > > is the said theoretical driver that needs fixing anyway.
> > > >
> > > > Now, it is really fair to mention that CMA backed crash kernel memory
> > > > has some limitations
> > > >     - CMA reservation can only be used by the userspace in the
> > > >       primary kernel. If the size is overshot this might have
> > > >       negative impact on kernel allocations
> > > >     - userspace memory dumping in the crash kernel is fundamentally
> > > >       incomplete.
> > >
> > > I am not sure if we are talking about the same thing. My concern is:
> > > ====================================================================
> > > 1) system corrutption happened, crash dumping is prepared, cpu and
> > > interrupt controllers are shutdown;
> > > 2) all pci devices are kept alive;
> > > 3) kdump kernel boot up, initialization is only done on those devices
> > > which drivers are added into kdump kernel's initrd;
> > > 4) those on-flight DMA engine could be still working if their kernel
> > > module is not loaded;
> > >
> > > In this case, if the DMA's destination is located in crashkernel=,cma
> > > region, the DMA writting could continue even when kdump kernel has put
> > > important kernel data into the area. Is this possible or absolutely not
> > > possible with DMA, RDMA, or any other stuff which could keep accessing
> > > that area?
> >
> > I do nuderstand your concern. But as already stated if anybody uses
> > movable memory (CMA including) as a target of {R}DMA then that memory
> > should be properly pinned. That would mean that the memory will be
> > migrated to somewhere outside of movable (CMA) memory before the
> > transfer is configured. So modulo bugs this shouldn't really happen.
> > Are there {R}DMA drivers that do not pin memory correctly? Possibly. Is
> > that a road bloack to not using CMA to back crash kernel memory, I do
> > not think so. Those drivers should be fixed instead.
> >
> I think that is our concern. Is there any method to guarantee that
> will not happen instead of 'should be' ?
> Any static analysis during compiling time or dynamic checking method?

I am not aware of any method to detect a driver is going to configure a
RDMA.
 
> If this can be resolved, I think this method is promising.

Are you indicating this is a mandatory prerequisite?
-- 
Michal Hocko
SUSE Labs
