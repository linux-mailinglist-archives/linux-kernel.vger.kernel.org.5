Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A687FBAD9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 14:05:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344853AbjK1NFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 08:05:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344694AbjK1NFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 08:05:06 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DCB18E
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 05:05:13 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id C62A9227A87; Tue, 28 Nov 2023 14:05:08 +0100 (CET)
Date:   Tue, 28 Nov 2023 14:05:08 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Christoph Hellwig <hch@lst.de>, Daniel Wagner <dwagner@suse.de>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231128130508.GA8221@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <20231127141857.GA25833@lst.de> <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com> <20231127155649.GA1403@lst.de> <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com> <20231127163333.GA2273@lst.de> <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWTH85bmw0cdePXf@kbusch-mbp.dhcp.thefacebook.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:46:43AM -0700, Keith Busch wrote:
> > 
> > Yes.  But does it care about the tuple size, or the actual size of the
> > metadata field even if is bigger than the PI tuple?
> 
> tuple_size is the same value as metadata size regardless of PI usage.
> See nvme_init_integrity() for how this driver sets it:
> 
> 	integrity.tuple_size = ns->ms;

Yes, for the case where we actually support integrity in the kernel
for a given device.  But if the device has a metadata size larger than
the PI size we still support it, and just let the device strip/insert
the PI.  And if nvme-cli wants to report detailed information about
the namespace it probably needs to report the actual metadata size
as the tuple size won't be reported given that we're never initializing
the kernel PI support.
