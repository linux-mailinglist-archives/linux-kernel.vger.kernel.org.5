Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B16E7FA667
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 17:30:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjK0QaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 11:30:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjK0QaL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 11:30:11 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8F60DE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 08:30:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 119C3C433C7;
        Mon, 27 Nov 2023 16:30:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701102617;
        bh=VQ294nCR6/7aI+HtxIgb1t+5lA/sOhUAPy8Ess4W+k4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=imJ1oOKsMju4Hk+0o8KUdr6MiKFYjYQ4Mw76S/B9/pFFsd1OQmZeRWVSVBohJzYIg
         gll0ZzGFwcyMcl+p0we/8HJsswfUiFrPn4iOfbhaaejykFiHVm+Ps7FXzUCsVqRrSn
         FJqtRUMUI5zRAa2JZF3nIs8EsWUOaHX8jMYBPHed2Dxohigz8kxdszEgegi0cjpL32
         bNKiTLP4LoR/3zvX/o1JlWNGFoBfRoqMm/fMVm0B9R7k/TxZslYE/HgjGDJex1RwYo
         vpDPs9LAT//tOCM+822v9cAHs7G2PNnbYOjTnkXYpcIaLhpcU0TIqLptk7wNZjz6v3
         j6GJ8fzXmq8Lw==
Date:   Mon, 27 Nov 2023 09:30:14 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWTEFvYbI1bFTXyZ@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
 <20231127141857.GA25833@lst.de>
 <ZWS5dM5FzTMr5ftO@kbusch-mbp.dhcp.thefacebook.com>
 <20231127155649.GA1403@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127155649.GA1403@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 04:56:49PM +0100, Christoph Hellwig wrote:
> On Mon, Nov 27, 2023 at 08:44:52AM -0700, Keith Busch wrote:
> > > I'd probably spell out metadata_size, or probably even better
> > > metadata_bytes to match the unit postfixes elsewhere in the block code.
> > 
> > Should this even be an nvme specific attribute? I thought we should have
> > blk-integrity.c report its 'tuple_size' attribute instead. That should
> > work as long as we're not dealing with extended metadata at least, but
> > that's kind of a special format that doesn't have block layer support.
> 
> Reporting the tuple size is a good idea.  But is that enough for
> the existing nvme-cli use case?

nvme-cli currently queries with admin passthrough identify command, so
adding a new attribute won't break that. I assume Daniel would have it
fallback to that same command for backward compatibilty if a desired
sysfs attribute doesn't exist.
