Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D587FA1E2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 15:03:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbjK0ODZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 09:03:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233564AbjK0OBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 09:01:21 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE5F92D4E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:57:58 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 647A567373; Mon, 27 Nov 2023 14:57:55 +0100 (CET)
Date:   Mon, 27 Nov 2023 14:57:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <20231127135755.GB23928@lst.de>
References: <20231127103208.25748-1-dwagner@suse.de> <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com> <mwen6fl5yszmk5nh2hbsqtu5pu76ir6rh6jpdfppbczsov7qfz@vivqeew6y7wk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <mwen6fl5yszmk5nh2hbsqtu5pu76ir6rh6jpdfppbczsov7qfz@vivqeew6y7wk>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:07:32PM +0100, Daniel Wagner wrote:
> libnvme itself is also cashing this value and exposes it via the
> nvme_ns_get_lba_util() getter. I'd say libnvme shouldn't cache it
> either. Instead the function should just issue the ns command to report
> the current nuse value.
> 
> I'll drop the nuse sysfs entry.
> 
> Unfortunately, 'nvme list' is using the 'nuse' field for showing the
> currently used space. I was hoping to get 'nvme list' working without
> issuing any commands.

I'd be ok with implementing nuse in a way where we issue an identify
command to read it, but rate limit the calls to something reasonable.
I think the kernel can do that much better than userspace because it
can keep that state a lot better.
