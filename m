Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C1847EA61C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 23:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjKMWih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 17:38:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMWig (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 17:38:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B371738
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 14:38:33 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9939C433C7;
        Mon, 13 Nov 2023 22:38:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699915112;
        bh=OP3I7fpOVYpk/z9dNWNGPuMZiLtZS4ZdqSK6+IzmD2U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SVm0VlNumMuPkfY6BPByX96F51MOtPGk1twkJwdP1Ns2MVOGSc0AINj7/5JlJNvij
         ZYzLEyCOLONmbcd+eOm1+NRR5C6tRNoXKPsMvtxc7D4tsbx7WrdcVQM1x/AzjUIXxg
         P3wThId7CL2F4JfFiGcKJe/+mVgXTP29Fk8qFfy8wLtbcGrfEJ6SWLT6uF9iETJp0x
         qo/zXXGBFia5UQGx/W9xw+yB+elvOMSHFJHUiAf+OnU7B86v6QUWHHcYICccoSRgpQ
         d8u/48dHQTqbllD0ElOzkBHuqnaUHUPX0yHCqRAyttan0AOqdN2fD6an699vW6AY1Y
         ADO3uaIcNAL+w==
Date:   Mon, 13 Nov 2023 17:38:30 -0500
From:   Jakub Kicinski <kuba@kernel.org>
To:     <mchan@broadcom.com>
Cc:     <alexey.pakhunov@spacex.com>, <vincent.wong2@spacex.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <siva.kallam@broadcom.com>, <prashant@broadcom.com>
Subject: Re: [PATCH v4 1/2] tg3: Move the [rt]x_dropped counters to tg3_napi
Message-ID: <20231113173830.4c01d551@kernel.org>
In-Reply-To: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
References: <20231113182350.37472-1-alexey.pakhunov@spacex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Nov 2023 10:23:49 -0800 alexey.pakhunov@spacex.com wrote:
> This change moves [rt]x_dropped counters to tg3_napi so that they can be
> updated by a single writer, race-free.

Michael, do you have a preference on the using u64_stats_inc() ?
Since we're only doing inc here the conversion should be pretty
trivial. The semantics of local64 are a bit murky but looks like
other drivers think that it's okay to use inc without
u64_stats_update_begin() / end().
