Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC7B75114E
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 21:36:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbjGLTgT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231499AbjGLTgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 15:36:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FED1BDC
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 12:36:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64FB461719
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 19:36:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E222C433C8;
        Wed, 12 Jul 2023 19:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689190574;
        bh=EogeTGIiuUFqzne3v5vm4Ifad7BZZ2pCtarM917N8FI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LpE3SJuNK4U7nmwc8P4oTt0ZKY7/t2LKkaEq8vEXLKYM8LnUOaJU0H7H0C+RhZ4mv
         ttm0IOyk6cIjvzPIMUxFThldGR4abW/8Aknzi53P2wErDaQpIoPiU5gAaWKIhHWY/2
         EtMI8/8C3jH0byvt5apBXNgnl9RERwkcMMqffHgnOpZH3eskXZXWBPo66ohtW4v88M
         2PwmkAW2cUDbgkk5A8EJt8OgxuC1PcQY7W8Lqio7OUlzAwtDlHIBOOTXOOCOrGO+8I
         2XW6vyo6jBcouoJXLjKa44KCxp5fRJDiXH8JHDYDCjwziNuOxnJLrYvZCrRG3IscTu
         DEhB8WwhRBQiA==
Date:   Wed, 12 Jul 2023 12:36:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ivan Vecera <ivecera@redhat.com>
Cc:     netdev@vger.kernel.org, Simon Horman <simon.horman@corigine.com>,
        Rafal Romanowski <rafal.romanowski@intel.com>,
        Leon Romanovsky <leon@kernel.org>, Ma Yuying <yuma@redhat.com>,
        Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        intel-wired-lan@lists.osuosl.org (moderated list:INTEL ETHERNET DRIVERS),
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH v2 1/2] i40e: Add helper for VF inited state check with
 timeout
Message-ID: <20230712123613.20a98732@kernel.org>
In-Reply-To: <20230712133247.588636-1-ivecera@redhat.com>
References: <20230712133247.588636-1-ivecera@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 12 Jul 2023 15:32:46 +0200 Ivan Vecera wrote:
> +	for (i = 0; i < 15; i++)
> +		if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states))
> +			msleep(20);
> +
> +	if (!test_bit(I40E_VF_STATE_INIT, &vf->vf_states)) {
> +		dev_err(&vf->pf->pdev->dev,
> +			"VF %d still in reset. Try again.\n", vf->vf_id);
> +		return false;

I like my loop more but if you want to have the msleep() indented just
add an else { return true; } branch. Take advantage of the fact this is
a function, now, and you can just return.
