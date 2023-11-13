Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F7E98FB
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 10:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbjKMJbV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 04:31:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233346AbjKMJbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 04:31:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F17E10D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 01:31:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53D23C433C8;
        Mon, 13 Nov 2023 09:31:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699867876;
        bh=6g9ZPv/bZJQ0HXiclJLh3+yq8Pv2lg/WXevTxvtUCrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=G914O3R/a97wzo6qnjURBitOPu69tSdJZ0rTya2wCnA1rJDY22wSJ50s0Q37Ri3xX
         Z4ypgsQWuB/eQmOQ6wR/rkkjMdzZ9KsmNXzE1Tyhgr5480pa7/ID6sfRwQe1Ks4fKS
         hsRQQsT+ynBXyUXNQzi4B8R8Nd4a4PKZ+/Yh/AG4XdbQPsDwQ7ZtSr9f6Rg0CUOd8C
         Dxp/kbDisHW74tJ2cZZEQnvIT4ZoQns1HQWRpGyVdHWt/SJFLUU7Kr9E2g2skoKOTd
         9/LQ2mUljgfvGusmauMFMAugjEDMUS2R7R2zogtUzWECqyzkWtEl08o7YymnbtioSA
         WEO2POoC0ZyYw==
Date:   Mon, 13 Nov 2023 09:31:12 +0000
From:   Simon Horman <horms@kernel.org>
To:     Kunwu Chan <chentao@kylinos.cn>
Cc:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, jeffrey.t.kirsher@intel.com,
        shannon.nelson@amd.com, kunwu.chan@hotmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        intel-wired-lan@lists.osuosl.org
Subject: Re: [PATCH] i40e: Use correct buffer size
Message-ID: <20231113093112.GL705326@kernel.org>
References: <20231112110146.3879030-1-chentao@kylinos.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231112110146.3879030-1-chentao@kylinos.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 12, 2023 at 07:01:46PM +0800, Kunwu Chan wrote:
> The size of "i40e_dbg_command_buf" is 256, the size of "name" is
> at most 256, plus a null character and the format size,
> the total size should be 516.

Hi Kunwu Chan,

Thanks for your patch.

I'm slightly confused as to why name is at most 256 bytes.
I see that name is IFNAMSIZ = 16 bytes.

In any case, perhaps we could make buf_size dependent on it's
constituent variables, to make things a bit clearer and
a bit more robust.

Something like this (completely untested!):

	int buf_size = IFNAMSIZ + sizeof(i40e_dbg_command_buf) + 4;

Also, I'm not clear if this addresses a problem that can manifest in
practice. Which affects if it it should be treated as a fix for iwl-net
with a fixes tag, or as a feature for iwl-next without a fixes tag.

In either case, if you repost, please designate the target tree in the
Subject line. Something like this:

	Subject: [PATCH iwl-next] ...

Lastly, when reposting patches, please allow 24h to elapse since
the previous posting.

Link: https://docs.kernel.org/process/maintainer-netdev.html

...
