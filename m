Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A36367FB3EA
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 09:19:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344088AbjK1ITa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 03:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344049AbjK1IT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 03:19:27 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6DB5DB
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 00:19:33 -0800 (PST)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52CEC2195A;
        Tue, 28 Nov 2023 08:19:32 +0000 (UTC)
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F0DE133B5;
        Tue, 28 Nov 2023 08:19:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap2.dmz-prg2.suse.org with ESMTPSA
        id hMfuDZSiZWWbPQAAn2gu4w
        (envelope-from <dwagner@suse.de>); Tue, 28 Nov 2023 08:19:32 +0000
Date:   Tue, 28 Nov 2023 09:21:45 +0100
From:   Daniel Wagner <dwagner@suse.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <n57gxockmm4iqt53olerr52rgxg3mvgdp4wfshyci2r7dohxfg@22mqtj3ya3g3>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
 <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
 <20231127163333.GA2273@lst.de>
 <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
        none
X-Rspamd-Server: rspamd2
X-Spamd-Result: default: False [-4.00 / 50.00];
         REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Queue-Id: 52CEC2195A
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> On Mon, Nov 27, 2023 at 05:33:33PM +0100, Christoph Hellwig wrote:
> > On Mon, Nov 27, 2023 at 09:30:14AM -0700, Keith Busch wrote:
> > > > > Should this even be an nvme specific attribute? I thought we should have
> > > > > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > > > > work as long as we're not dealing with extended metadata at least, but
> > > > > that's kind of a special format that doesn't have block layer support.
> > > > 
> > > > Reporting the tuple size is a good idea.  But is that enough for
> > > > the existing nvme-cli use case?

'nvme list' is just listening the block size and the meta size in the
'Format' field. So nothing really crazy going on:

  Usage                      Format
  -------------------------- ----------------
  343.33  GB / 512.11  GB    512   B +  0 B

nvme-cli commands like 'nmve ns-id' etc will always issue a command so
that is not a concern. It's just the libnvme nvme_scan_topology() call
which should stop issuing any commands.

I'll add the missing tuple_size to the integrity sysfs dir in this case.

> > > nvme-cli currently queries with admin passthrough identify command, so
> > > adding a new attribute won't break that. I assume Daniel would have it
> > > fallback to that same command for backward compatibilty if a desired
> > > sysfs attribute doesn't exist.

Yes, a fallback will exist. There is no need to break existing users.

In summary, the only missing entries are

 - csi
 - tuple_size
 - nuse
