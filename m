Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062B676A0E6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 21:10:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230140AbjGaTKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 15:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjGaTKP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 15:10:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CA2184
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 12:10:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC6C61277
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 19:10:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53347C433C8;
        Mon, 31 Jul 2023 19:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690830613;
        bh=7BUP17YZLUCEJIi4rAJBHLTCh+olUP+m+qo5gNNUQQ0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K3rVcA8G0AtmamNt3KZciRNmpZAw/gId0t1RzJbGLJkPD4PbMzKu7fAVivLCU6t8R
         zRm5RhEinrX2CWq1QAzTEqID4FOPvovwH7Ghb5VPjCAjRBqO81Hk2tzpyPsXxpmHvb
         Ndss40rzb6kGEP141ddFKfhhxe6l7uwCeA9upxQ7dYDckl4wQRjh5uf1xdv8uZMgHn
         +0kbgT8Nu6B/SiL1ZmKDOmteoJw4QxDaOSCWuZh1h2yDIwY5G1WgdNVaQ3EeUrtEHH
         7endB90IpUb3NyJ6jDaNVYzjhM7f/ZIWTaLQZS7OeVeGhz1M4Gd9SQUzwbUKtPMeqg
         adlYGJ0AG5fFw==
Date:   Mon, 31 Jul 2023 13:10:11 -0600
From:   Keith Busch <kbusch@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        nilskruse97@gmail.com, git@augustwikerfors.se, David.Chang@amd.com
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Message-ID: <ZMgHE2wu4T4OfrTR@kbusch-mbp>
References: <20230731185103.18436-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230731185103.18436-1-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2023 at 01:51:03PM -0500, Mario Limonciello wrote:
> Samsung PM9B1 has problems after resume because NSID has changed.
> This has been reported in the past on OEM varities of PM9B1 parts
> and fixed by firmware updates on 'some' of those parts.
> 
> However this same issue also happens on 'retail' PM9B1 parts which
> Samsung has not released firmware updates for.
> 
> As the check has been relaxed at startup for multiple disks with
> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> probe due to duplicate IDs for single-ported PCIe devices") also
> relax the check that runs on resume for NSIDs and mark them bogus
> if this occurs on resume.

How could the driver tell the difference between the device needing a
quirk compared to a rapid delete-create-attach namespace sequence?
Proceeding with the namespace now may get dirty writes intended for the
previous namespace, corrupting the new one.

The commit you mentioned tries to constrain allowing duplication where
we can reasonably assume the quirk is needed. If we need to do similiar
for this condition, one possible constraint might be that the device
doesn't report OACS bit 3 (Namespace Management).
