Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C507B84E6
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 18:22:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243309AbjJDQWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 12:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243267AbjJDQWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 12:22:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CDA4A7;
        Wed,  4 Oct 2023 09:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5FB5C433C7;
        Wed,  4 Oct 2023 16:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696436527;
        bh=pvpGmo1Yrt+7LMlccum7Usx/gcLqZWbEtiJQ4DejeFg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VxEPyFJ1+lzraM+2M57RSOdNws0syfKnTDqjRM04kXjmrrlVE8B/VdzofnQmIW3e3
         dZUu8GH9stBl1Tf/kSB3YrD+ci3AP6NWfLnImPAt7mTEZqGAyJUUyjCKLJCqkwLmw4
         tR/E0V48Gdn+lVVTadNmmvFyCr05bFrYpoFDEo4j6iplF5O+U6Rnkg5SjzKgSMivep
         WDMZxiVuIUCAzkkGnS+QZ3o4C9ez+qgKsqxFlHmPCg+QUUhmolRny9hu4DdWF86v7y
         jZZs1O1tDU99DveNkLdW/+4mdW0n17IMpNb5SsOVzms5ipZxA77rxjElhRn7Oh7eYf
         zIHIMI5gkfVow==
Date:   Wed, 4 Oct 2023 09:22:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH 0/4] tracing: improve symbolic printing
Message-ID: <20231004092205.02c8eb0b@kernel.org>
In-Reply-To: <20230921085129.261556-5-johannes@sipsolutions.net>
References: <20230921085129.261556-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 10:51:30 +0200 Johannes Berg wrote:
> So I was frustrated with not seeing the names of SKB dropreasons
> for all but the core reasons, and then while looking into this
> all, realized, that the current __print_symbolic() is pretty bad
> anyway.
> 
> So I came up with a new approach, using a separate declaration
> of the symbols, and __print_sym() in there, but to userspace it
> all doesn't matter, it shows it the same way, just dyamically
> instead of munging with the strings all the time.
> 
> This is a huge .data savings as far as I can tell, with a modest
> amount (~4k) of .text addition, while making it all dynamic and
> in the SKB dropreason case even reusing the existing list that
> dropmonitor uses today. Surely patch 3 isn't needed here, but it
> felt right.
> 
> Anyway, I think it's a pretty reasonable approach overall, and
> it does works.
> 
> I've listed a number of open questions in the first patch since
> that's where the real changes for this are.

Potentially naive question - the trace point holds enum skb_drop_reason.
The user space can get the names from BTF. Can we not teach user space
to generically look up names of enums in BTF?
