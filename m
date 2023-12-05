Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1218805FB5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 21:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346293AbjLEUs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 15:48:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbjLEUs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 15:48:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44E9E181
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 12:49:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83137C433C7;
        Tue,  5 Dec 2023 20:49:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701809342;
        bh=fed1Khe3LcDNw8l1xszLr/0ELbkoHU+0quBAU6lvWFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4wAHStvUOAeCeta1YoWNlWxK5F+9eKD9UjWj2vao2iGNiI2rq+ii1dbijNu8FVXD
         /ElX0695XmWiW2gKNDytWMDyF1gcWq1MnwuIiZallMJAbMhAZdcV8BywQshbFveNgg
         OjMWttWxesqigO7tQqKMKI+83MxJKY/VQrROV42lhW0vQ9lkCZVKDyA9Zl5yCibn54
         OGK7qPLs/CSP08WwFLJb2X3QEESeNNoXe8RywB6U3kqjAUhbC3tiWk3syeUlK7lxc0
         HfSRl6YNyBlCRMqgkg383gGVjT/vMpZqNmvS6TUk6oCRBxSSyYRv/EvjheM/HW+Cio
         Wry5devnCRNDw==
Date:   Tue, 5 Dec 2023 20:48:58 +0000
From:   Simon Horman <horms@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        "moderated list:INTEL ETHERNET DRIVERS" 
        <intel-wired-lan@lists.osuosl.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH iwl-net] i40e: Fix wrong mask used during DCB config
Message-ID: <20231205204858.GY50400@kernel.org>
References: <20231130193135.1580284-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130193135.1580284-1-ivecera@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 08:31:34PM +0100, Ivan Vecera wrote:
> Mask used for clearing PRTDCB_RETSTCC register in function
> i40e_dcb_hw_rx_ets_bw_config() is incorrect as there is used
> define I40E_PRTDCB_RETSTCC_ETSTC_SHIFT instead of define
> I40E_PRTDCB_RETSTCC_ETSTC_MASK.
> 
> The PRTDCB_RETSTCC register is used to configure whether ETS
> or strict priority is used as TSA in Rx for particular TC.
> 
> In practice it means that once the register is set to use ETS
> as TSA then it is not possible to switch back to strict priority
> without CoreR reset.
> 
> Fix the value in the clearing mask.
> 
> Fixes: 90bc8e003be2 ("i40e: Add hardware configuration for software based DCB")
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
