Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B921679769C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 18:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238453AbjIGQNl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 12:13:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241162AbjIGQNH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 12:13:07 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60204BE6C
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 08:48:48 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B26EFC433C9;
        Thu,  7 Sep 2023 15:32:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694100728;
        bh=4/JKnKNExLGNGv2sCb9eyK1f+7iv+45LcWMfCPifJOo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FzYu7q8H4km5gUF2N5v5Qpvt7O6xn42LrO9Ej8XfTRaq8JkQJKQ75LZkXZVh58LG7
         RzIz3zz3ZbNBhqr9HTBXuW9FbN5XmRSl8hVVbNuCf+f8mJQEXPU0eFp4iMl4ew3uhU
         9yeUW3oXtWsHEbt296hRUkZz6LRPPqfKoH0qzUXuq9eLbWsgFop44ZtBtTRNaCfKdy
         eQbqd3AOP+9s4tvT/w9Thd1wg8lg6mieUoeBh837n2k8GPM3efEr4tcHd90JL6nD5a
         M1HmY+xEUMOPRBVkJ9dG5/DbzQugBVdocLuA58kTpUOab7JR7G2NclEhm0hB+xbEXG
         rOR99XJ7ZB1vg==
Date:   Thu, 7 Sep 2023 17:31:56 +0200
From:   Simon Horman <horms@kernel.org>
To:     Petr Oros <poros@redhat.com>
Cc:     netdev@vger.kernel.org, jesse.brandeburg@intel.com,
        anthony.l.nguyen@intel.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, linux-kernel@vger.kernel.org,
        mschmidt@redhat.com, ivecera@redhat.com, ahmed.zaki@intel.com
Subject: Re: [PATCH net v2 2/2] iavf: schedule a request immediately after
 add/delete vlan
Message-ID: <20230907153156.GJ434333@kernel.org>
References: <20230907150251.224931-1-poros@redhat.com>
 <20230907150251.224931-2-poros@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230907150251.224931-2-poros@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 07, 2023 at 05:02:51PM +0200, Petr Oros wrote:
> When the iavf driver wants to reconfigure the VLAN filters
> (iavf_add_vlan, iavf_del_vlan), it sets a flag in
> aq_required:
>   adapter->aq_required |= IAVF_FLAG_AQ_ADD_VLAN_FILTER;
> or:
>   adapter->aq_required |= IAVF_FLAG_AQ_DEL_VLAN_FILTER;
> 
> This is later processed by the watchdog_task, but it runs periodically
> every 2 seconds, so it can be a long time before it processes the request.
> 
> In the worst case, the interface is unable to receive traffic for more
> than 2 seconds for no objective reason.
> 
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

