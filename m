Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B3657E8C2B
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 19:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjKKSlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Nov 2023 13:41:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjKKSlF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Nov 2023 13:41:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26223C7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 10:41:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3757C433C7;
        Sat, 11 Nov 2023 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699728062;
        bh=RX3cBdIDKqcF57RnJqTIKKb8tzO0jX/53K43wpZkfaM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JX9ST7pmqRLghGLS7zyNC/HocKeBpovpuRqw2Jz/p4XuyrOJsalbi4mZAUH6uMJIb
         PnOlPrZFvJjmwcOB/NioYCw3uHkliZo6fxI07BuFd1hGgL36EsGTrnd0tEzjcU4s/V
         rqRPeAXjS5dz6OASQzkqo6NeXtvogL7YYeL3TzuR9/UMJx898K+9nKemVYLo2piWAA
         1pp7Mt46U53NRvaIf9Ixp26m58ew93Tw00a6QorCxFgI+XsAG/W+Yq0l5qVbxzTsAW
         WRda9xI6nX3+Yk3tzHYCDYeFAfWHPEDa4Qs+qP/njhdzwNIrMqJBCJ0+Y8GNuwi1bC
         OxqSHSguRaqxQ==
Date:   Sat, 11 Nov 2023 18:40:52 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     intel-wired-lan@lists.osuosl.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Todd Fujinaka <todd.fujinaka@intel.com>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix unexpected MFS warning message
Message-ID: <20231111184052.GA705326@kernel.org>
References: <20231110081209.189481-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231110081209.189481-1-ivecera@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 10, 2023 at 09:12:09AM +0100, Ivan Vecera wrote:
> Commit 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set") added
> a warning message that reports unexpected size of port's MFS (max
> frame size) value. This message use for the port number local
> variable 'i' that is wrong.
> In i40e_probe() this 'i' variable is used only to iterate VSIs
> to find FDIR VSI:
> 
> <code>
> ...
> /* if FDIR VSI was set up, start it now */
>         for (i = 0; i < pf->num_alloc_vsi; i++) {
>                 if (pf->vsi[i] && pf->vsi[i]->type == I40E_VSI_FDIR) {
>                         i40e_vsi_open(pf->vsi[i]);
>                         break;
>                 }
>         }
> ...
> </code>
> 
> So the warning message use for the port number indext of FDIR VSI
> if this exists or pf->num_alloc_vsi if not.
> 
> Fix the message by using 'pf->hw.port' for the port number.
> 
> Fixes: 3a2c6ced90e1 ("i40e: Add a check to see if MFS is set")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks Ivan,

I agree with your analysis that this change corrects the port number
printed. And that the problem is introduced in the cited commit.

Reviewed-by: Simon Horman <horms@kernel.org>
