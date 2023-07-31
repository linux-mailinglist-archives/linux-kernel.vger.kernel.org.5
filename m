Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC94F76A16B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjGaTlm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229673AbjGaTlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:41:39 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 993F9199F
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:41:11 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9F64968AA6; Mon, 31 Jul 2023 21:41:07 +0200 (CEST)
Date:   Mon, 31 Jul 2023 21:41:07 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Keith Busch <kbusch@kernel.org>
Cc:     Mario Limonciello <mario.limonciello@amd.com>, axboe@fb.com,
        hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        git@augustwikerfors.se, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230731194107.GA13620@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:10:11PM -0600, Keith Busch wrote:
> > As the check has been relaxed at startup for multiple disks with
> > duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> > probe due to duplicate IDs for single-ported PCIe devices") also
> > relax the check that runs on resume for NSIDs and mark them bogus
> > if this occurs on resume.
> 
> How could the driver tell the difference between the device needing a
> quirk compared to a rapid delete-create-attach namespace sequence?
> Proceeding with the namespace now may get dirty writes intended for the
> previous namespace, corrupting the new one.
> 
> The commit you mentioned tries to constrain allowing duplication where
> we can reasonably assume the quirk is needed. If we need to do similiar
> for this condition, one possible constraint might be that the device
> doesn't report OACS bit 3 (Namespace Management).

Yes, this patch as-is looks really dangerous.  I don't think we should
just ignore the fact that IDs change when queried again.
