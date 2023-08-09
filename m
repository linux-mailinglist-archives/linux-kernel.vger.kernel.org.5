Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0CE776C92
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 01:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjHIXF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 19:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjHIXFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 19:05:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 337A5D1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 16:05:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C78EB643E8
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 23:05:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99407C433C7;
        Wed,  9 Aug 2023 23:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691622319;
        bh=XFaiJ6avOsTBWBsdzJRuTwDyB4qodJIkgKELloezsqQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O7JVYN4pARn+CN2OFra3AoP3IPt0GV3V2QhCHq2wT07/MP4izAJcB4Zn/JqXq1C/N
         0d9ZmI3hXKl6Z3Bw8/1mdC2l9PWUQD1R4EmzmINjnsprtjNissqnscb+TFn4fXzRyf
         XPsXWfGqK9ZH5ko1DCASVOGpoYXU6j8p2rqkMjx+YxvcGO4pMTSSAtqguLUe7YBJYg
         vcHrCbPtfBfFMzOYqMa/ISXCH2pebWKCC+NltgTbPznHVl+TScVV9yjsXYwFxk5HdU
         sru3NUNFMIa8ZvJ5qLbDDApF12tJsQb+oaVexJJjBfzY45bI47dowoG0+SLMenGXCY
         uPuqax3Z3evqg==
Date:   Wed, 9 Aug 2023 16:05:17 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Suman Ghosh <sumang@marvell.com>
Cc:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
Subject: Re: [net PATCH V2 1/4] octeontx2-pf: Update PFC configuration
Message-ID: <20230809160517.7ff84c3b@kernel.org>
In-Reply-To: <20230809070532.3252464-2-sumang@marvell.com>
References: <20230809070532.3252464-1-sumang@marvell.com>
        <20230809070532.3252464-2-sumang@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 12:35:29 +0530 Suman Ghosh wrote:
> +		otx2_stop(dev);
> +		otx2_open(dev);

If there is any error in open() this will silently take the interface
down. Can't you force a NAPI poll or some such, if the concern is a
missed IRQ?
-- 
pw-bot: cr
