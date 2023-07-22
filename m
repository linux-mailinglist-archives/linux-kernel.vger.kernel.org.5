Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE675D92A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 04:40:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjGVCkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 22:40:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGVCkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 22:40:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C478810F4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 19:40:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 61EC560E9D
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:40:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DB39C433C7;
        Sat, 22 Jul 2023 02:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689993637;
        bh=pi3k2BO7luhchIvvbbw+dGYcE2uioGjCAircbju4KXE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BKavWMXUUtaR66aE/rvOVnP0nmMnlRp/UYHfUJfQvCUbSScDKHlWk+Qx+L9gX13JC
         aHiKaKJYFq+/fWaf9GrRFxAP3PT19chb4vsv8tpVtidN284ZOPj1jOL5YIrGXZL0jd
         5wBcQqlG3g1LngnrscCfYV1DDgZEgkJvdBea4g/otG0rqQwPanyBVHh3RQJUHmem+4
         dwumA2EnqS4lzM/ik3M0soVVmoZexHJOIHBmAKOHBpKQabORc4lmj8m4rFWOk0QmVL
         bxftHVGb+6jHxFU1TlIwcwcl9lVJfqoJfvIyPJMGSrQ9ZhmD93V85p8N42p4HOpdLa
         JX6GFNZMxKDwg==
Date:   Fri, 21 Jul 2023 19:43:56 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org, peng.fan@nxp.com,
        quic_nkela@quicinc.com
Subject: Re: [PATCH] firmware: arm_scmi: Fix chan_free cleanup on SMC
Message-ID: <rr26mp6bx4lu667qufvxjewo3fxg5c6hvhmstngliwhzbkbes4@owpr7vauvzwg>
References: <20230719173533.2739319-1-cristian.marussi@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719173533.2739319-1-cristian.marussi@arm.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 06:35:33PM +0100, Cristian Marussi wrote:
> SCMI transport based on SMC can optionally use an additional IRQ to signal
> message completion; the associated ISR is currently allocated using devres
> but the core SCMI stack, on shutdown, will call .chan_free() well before
> any managed cleanup is invoked by devres and, as a consequence, the arrival
> of a late reply to an in-flight pending transaction could still trigger the
> ISR well after the SCMI core has cleaned up the channels, with unpleasant
> results.
> 
> Inhibit further message processing on the IRQ path by explicitly freeing
> the IRQ inside .chan_free() callback itself.
> 
> Fixes: dd820ee21d5e ("firmware: arm_scmi: Augment SMC/HVC to allow optional interrupt")
> Reported-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> ---

Reviewed-by: Bjorn Andersson <andersson@kernel.org>

Regards,
Bjorn
