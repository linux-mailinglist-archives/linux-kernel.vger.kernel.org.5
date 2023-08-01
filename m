Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1E2E76B32A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:25:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234299AbjHALZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231862AbjHALY5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:24:57 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D91F53AA6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:24:12 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B64B76732D; Tue,  1 Aug 2023 13:24:03 +0200 (CEST)
Date:   Tue, 1 Aug 2023 13:24:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        August Wikerfors <git@augustwikerfors.se>,
        Keith Busch <kbusch@kernel.org>, axboe@fb.com,
        sagi@grimberg.me, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, nilskruse97@gmail.com,
        David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <20230801112403.GA3972@lst.de>
References: <20230731185103.18436-1-mario.limonciello@amd.com> <ZMgHE2wu4T4OfrTR@kbusch-mbp> <040c5788-1a7b-26ea-23cc-ba239c76efa9@augustwikerfors.se> <39697f68-9dc8-7692-7210-b75cce32c6ce@amd.com> <20230731201047.GA14034@lst.de> <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <36319a0f-34a6-9353-bc52-4d4d0fac27a5@amd.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 03:14:54PM -0500, Limonciello, Mario wrote:
>> No.  There are tons of NVMe devices that only support creating and
>> deleting namespace out of band, especially in virtualized and cloud
>> setups.
>
> Even if it's only the error handling path only that it's checked?

Do you mean nvme_validate_ns with the error code?  I wouldn't really call
that an error case, that's the function called to check namespaces are
still the same after we did a rescan (either manually or triggered by the
AEN).

> If you don't want more changes or heuristics on the error handling path for 
> this case, I think the best solution is probably to pick up
>
> https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
>
> instead then and hopefully we don't end up with more disks like this.

That's probably the better idea.  I know at least one of the early
quirked devices also IDs that changed for subsequent identify calls.
