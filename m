Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5610D7D83BA
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:40:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345029AbjJZNkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:40:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbjJZNj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:39:59 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03424BD
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:39:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32633C433C8;
        Thu, 26 Oct 2023 13:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698327597;
        bh=Yo1Jp9MQveisgDNa7SmJESLL8DTmwQjMaMUWrbBXxQ4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=IdX7isk4NJaVOXcPxsCULZn8rikRNx7vqIfiZeABmRI621N7Cvlsn56W7+1HNsMrh
         G/tm35NXAg7C4dXWXtbxzcgABqW4TqOyGhMWrR6fpjxS/Ngs9+O8ynCykZFW1FtrR+
         R/ycI79jMq++DsW5LLDfVgarZpTC/6qsPRVR4T1/uRerxpXbOwOckF8KDct9ws50ac
         mwZm1HUF6z4nCDJqJyusf6pwv5W5dX3I/4IjRPYJT5BWDlln55oLU1GhLFn2MdjehF
         3JgrmVxs+r/cuINidO7zi5VxB7ix19gdcKzUtcltqPqcIjo5adLPEB8R1LqEIOXMUE
         dd45wcEkfGtXg==
From:   Pratyush Yadav <pratyush@kernel.org>
To:     AceLan Kao <acelan.kao@canonical.com>
Cc:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] mtd: spi-nor: Improve reporting for software reset
 failures
In-Reply-To: <20231026012017.518610-1-acelan.kao@canonical.com> (AceLan Kao's
        message of "Thu, 26 Oct 2023 09:20:17 +0800")
References: <20231026012017.518610-1-acelan.kao@canonical.com>
Date:   Thu, 26 Oct 2023 15:39:54 +0200
Message-ID: <mafs0fs1xmrit.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26 2023, AceLan Kao wrote:

> From: "Chia-Lin Kao (AceLan)" <acelan.kao@canonical.com>
>
> When the software reset command isn't supported, we now report it
> as an informational message(dev_info) instead of a warning(dev_warn).
> This adjustment helps avoid unnecessary alarm and confusion regarding
> software reset capabilities.

I still think the soft reset command deserves a warn, and not an info.
Because it _is_ a bad thing if you need to soft reset and are unable to
do so. Your bootloader (or linux if you rmmod and modprobe again) might
not be able to detect the flash mode and operate it properly.

I think we should just not unconditionally run this and instead only
call it when the flash reset is not connected -- that is only call this
under a check for SNOR_F_BROKEN_RESET, like we do for 4-byte addressing
mode.

I don't have a strong opposition to this patch but I do think it is
fixing the problem in the wrong place.

[...]

-- 
Regards,
Pratyush Yadav
