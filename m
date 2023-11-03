Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104947E0733
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:09:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376321AbjKCRJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:09:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345483AbjKCRJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:09:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB85A8E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:09:33 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4560C433C8;
        Fri,  3 Nov 2023 17:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699031373;
        bh=sq3L5gUrO9wxalfWm5HOiwIfw0lC8DkpESy25Odx+hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tkhmF8t+hdszhtvZFdcxIUCkZguAyqoHMDR2jOPEL+5Ked3zu9OKkuNyiwqVLy/zr
         fdB95qyMygnaWOzw5t9vbfRhjzYrKSYi0JNsxd4zmLq+FPUmFeRWegt7XPiFDEx7GV
         nPHRTjDtBEdyok9/nLUpZjzEpOVgRY7Tw1o/izNpDfFzPrsq23Y+FKgxPNH/UktSUJ
         /CtAipVpNhDWss8cxTM8wD9nSarGpkH8RRjHX+MX5ID9pKEz0AtOrbGxFD5OcFW72x
         QoCRp1XTBISxXF0s+oDYMZF6LmxK1aygn1ecLzoFztXYt4+2ERqi6gg3p4tv4H1DhN
         ZWAFlbJpccrZw==
Date:   Fri, 3 Nov 2023 17:09:28 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
Subject: Re: [PATCH iwl-next] iavf: Remove queue tracking fields from
 iavf_adminq_ring
Message-ID: <20231103170928.GD714036@kernel.org>
References: <20231026083932.2623631-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026083932.2623631-1-ivecera@redhat.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:39:32AM +0200, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in iavf_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> iavf_adminq_ring structure.
> 
> Remove these fields from iavf_adminq_ring and use register offset
> constants instead. Remove iavf_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve iavf_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.
> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Thanks, this is a nice cleanup.

Reviewed-by: Simon Horman <horms@kernel.org>

...
