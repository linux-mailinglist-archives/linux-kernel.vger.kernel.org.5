Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012B07FB53C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 10:08:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjK1JIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 04:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjK1JIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 04:08:21 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4554BAB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 01:08:27 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id E86591F6E6;
        Tue, 28 Nov 2023 09:08:25 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D011B13763;
        Tue, 28 Nov 2023 09:08:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id /Uq5MAmuZWXmVgAAD6G6ig
        (envelope-from <mhocko@suse.com>); Tue, 28 Nov 2023 09:08:25 +0000
Date:   Tue, 28 Nov 2023 10:08:21 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     Jiri Bohac <jbohac@suse.cz>, Pingfan Liu <piliu@redhat.com>,
        Tao Liu <ltao@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] kdump: crashkernel reservation from CMA
Message-ID: <ZWWuBSiZZdF2W12j@tiehlicka>
References: <ZWD_fAPqEWkFlEkM@dwarf.suse.cz>
 <CAO7dBbUVQn8xzPZQhhw1XqF+sQT0c6phk4sda+X=MrR6RmPE0A@mail.gmail.com>
 <ZWJllXCN0SDIELrX@dwarf.suse.cz>
 <CAO7dBbVJ=ytRra_77VRZ8ud1wVkP9fub=Vj6cfTkx=CnYg5J2A@mail.gmail.com>
 <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWVMUxmi66xLZPsr@MiWiFi-R3L-srv>
X-Spam-Level: 
X-Rspamd-Server: rspamd1
Authentication-Results: smtp-out2.suse.de;
        none
X-Rspamd-Queue-Id: E86591F6E6
X-Spam-Score: -4.00
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 28-11-23 10:11:31, Baoquan He wrote:
> On 11/28/23 at 09:12am, Tao Liu wrote:
[...]
> Thanks for the effort to bring this up, Jiri.
> 
> I am wondering how you will use this crashkernel=,cma parameter. I mean
> the scenario of crashkernel=,cma. Asking this because I don't know how
> SUSE deploy kdump in SUSE distros. In SUSE distros, kdump kernel's
> driver will be filter out? If latter case, It's possibly having the
> on-flight DMA issue, e.g NIC has DMA buffer in the CMA area, but not
> reset during kdump bootup because the NIC driver is not loaded in to
> initialize. Not sure if this is 100%, possible in theory?

NIC drivers do not allocation from movable zones (that includes CMA
zone). In fact kernel doesn't use GFP_MOVABLE for non-user requests.
RDMA drivers might and do transfer from user backed memory but for that
purpose they should be pinning memory (have a look at
__gup_longterm_locked and its callers) and that will migrate away from
the any zone.
 
[...]
> The crashkernel=,cma requires no userspace data dumping, from our
> support engineers' feedback, customer never express they don't need to
> dump user space data. Assume a server with huge databse deployed, and
> the database often collapsed recently and database provider claimed that
> it's not database's fault, OS need prove their innocence. What will you
> do?

Don't use CMA backed crash memory then? This is an optional feature.
 
> So this looks like a nice to have to me. At least in fedora/rhel's
> usage, we may only back port this patch, and add one sentence in our
> user guide saying "there's a crashkernel=,cma added, can be used with
> crashkernel= to save memory. Please feel free to try if you like".
> Unless SUSE or other distros decides to use it as default config or
> something like that. Please correct me if I missed anything or took
> anything wrong.

Jiri will know better than me but for us a proper crash memory
configuration has become a real nut. You do not want to reserve too much
because it is effectively cutting of the usable memory and we regularly
hit into "not enough memory" if we tried to be savvy. The more tight you
try to configure the easier to fail that is. Even worse any in kernel
memory consumer can increase its memory demand and get the overall
consumption off the cliff. So this is not an easy to maintain solution.
CMA backed crash memory can be much more generous while still usable.
-- 
Michal Hocko
SUSE Labs
