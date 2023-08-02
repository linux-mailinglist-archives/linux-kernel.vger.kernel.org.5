Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E084E76C2B9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 04:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbjHBCLC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 22:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbjHBCLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 22:11:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C616D2139
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 19:11:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51EA161785
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 02:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66295C433C7;
        Wed,  2 Aug 2023 02:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690942259;
        bh=DQ/KDWOGALWyuzyoM61Yt4hVHiJAe+Q7zLw2E6AYw/0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AtFi2aAmfUP2CLhNRXwbB5I9Qb8M/I65QFuvTdf3u7baHoc2iosEdzPJsCu5hcVHK
         dIbywIe5FU1K92sa+RGcVvyd3iU/w+tWdf9MVlOkYz1G4xM7EFnU4LJXuqzZ8YLxsS
         G63LvBlyhyaMiiVT0QhTVg8PkofvhJRavhwO+wTPG6lmG7ahkAo65J7mZzYLH4+M0w
         zUlFeA03EGhLQq3kdw84PH24TEf4cqFwegyiQvCrfvt/YL5aCNMx4DSwsUDyIPTdCQ
         twifv+hM/acoRUo09ceq+MicOs65r0wxq80pWk3ImeP62cugb43AGFDNDlPUfy7TP1
         gKw0GPhhcP9rQ==
Date:   Tue, 1 Aug 2023 19:10:58 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, <davem@davemloft.net>,
        <pabeni@redhat.com>, <yoshfuji@linux-ipv6.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <simon.horman@corigine.com>
Subject: Re: [PATCH v3] ip6mr: Fix skb_under_panic in ip6mr_cache_report()
Message-ID: <20230801191058.0664b1b8@kernel.org>
In-Reply-To: <cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
References: <20230801064318.34408-1-yuehaibing@huawei.com>
        <CANn89iJO44CiUjftDZHEjOCy5Q3-PDB12uWTkrbA5JJNXMoeDA@mail.gmail.com>
        <20230801131146.51a9aaf3@kernel.org>
        <0e3e2d6f-0e8d-ccb4-0750-928a568ccaaf@kernel.org>
        <cad2b715-14fc-8424-f85d-b5391e0110dc@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Aug 2023 09:28:31 +0800 YueHaibing wrote:
> > that pattern shows up a few times:  
> 
> Ok, I will test and fix these if any.

Thanks, we may also want to add a 
  DEBUG_NET_WARN_ON_ONCE(len > INT_MAX)
in skb_push() but perhaps that's an overkill.
Most of those cases are probably legit (skb_.*_offset()
can well be negative if headers were already pulled).
