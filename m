Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1CB7F9DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 11:44:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233072AbjK0KoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 05:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233018AbjK0KoI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 05:44:08 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CD2135
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 02:44:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47DACC433C9;
        Mon, 27 Nov 2023 10:44:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701081853;
        bh=BM0cucoJgxfeP1gzwakogjRSOFzNW7OJuGhJzO+AwkU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NI16mUAXXRUJtUvwYyXOroh0N2ft1jiQaRcczcB6RhO4ZvmnLcGGw5xn9e9s8qZ/E
         4UtGTLQbcZU6MQEelp/SzIZQbKaZN81mvujDqRsT8+/E/mb8xqHfdLorKxLnPpY/83
         QJnjhmu4Ctj50+2mguMeihYYlaoqSTccpPZwk56KRIZqq0iThWX/jAte8nS3z68HHn
         W0piVO6Df6MYWYq8GeYO5moxBV2ritL3K3AcXx0mpYlL8/jDGShBmq7Srz+NU7vaJJ
         6Vkhd2HT2KsUzaJrrhdfvoHlMgwVHVUH/c3aSxXyu5I6FVoOkZ4I62SQap+sVsUz4I
         nAdevmLpocSCA==
Date:   Mon, 27 Nov 2023 03:44:11 -0700
From:   Keith Busch <kbusch@kernel.org>
To:     Daniel Wagner <dwagner@suse.de>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [RFC v1] nvme: add cse, ds, ms, nsze and nuse to sysfs
Message-ID: <ZWRy-4Bhqw0Gxo4c@kbusch-mbp.dhcp.thefacebook.com>
References: <20231127103208.25748-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127103208.25748-1-dwagner@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 11:32:08AM +0100, Daniel Wagner wrote:
> libnvme is using the sysfs for enumarating the nvme resources. Though
> there are few missing attritbutes in the sysfs. For these libnvme issues
> commands during discovering.
> 
> As the kernel already knows all these attributes and we would like to
> avoid libnvme to issue commands all the time, expose these missing
> attributes.

The id namespace 'nuse' field can be quite volatile: it can change on
any write or discard command, so caching it may quickly get out of sync
with the actual value.
