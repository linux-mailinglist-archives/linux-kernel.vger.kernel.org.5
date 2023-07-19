Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2B4C75A1DA
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 00:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjGSW0t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 18:26:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229790AbjGSW0q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 18:26:46 -0400
Received: from mail-io1-xd2e.google.com (mail-io1-xd2e.google.com [IPv6:2607:f8b0:4864:20::d2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99D0D2699
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:13 -0700 (PDT)
Received: by mail-io1-xd2e.google.com with SMTP id ca18e2360f4ac-77a62a84855so5936939f.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 15:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689805568; x=1692397568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O4hpguHBmYCOtbZuyxhfD1fybnhRTWM1zbbotIr9V0c=;
        b=FGuL0MhwW3FW9w8TXZe1NWokgm/kG6SL6+cVH9CSqvwCHmB+Y5SKafqFEtU64h1Fgc
         Buja7fyVt7jfCOlsvhpn7wopN4nHLjoWzeVThYryFNfhHotsyYQRL4pU6TIVF40x4phL
         an5crvu+U9s+Rdvx18gjA22hNxmZLVm9S6Aakcz0xGm8P4SDaNt8vAkH5twEEUI7yo/1
         FvrY0xxJgDr8fIFcdD+fdMR9cYxfhtsrVco24A+i0xANll4OF6j/PscLsu8llIE/7ELM
         04P68F6LfeQWuzkqlMqfeZX3j2rxlW5HxRiN1DatIf4yBVMDjMf843hsIAT2pVFDjupC
         wiew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689805568; x=1692397568;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O4hpguHBmYCOtbZuyxhfD1fybnhRTWM1zbbotIr9V0c=;
        b=YwxquJbY8eirQuW7ZAaio9Eoc9yFWNF9iEmtMwUgce7eQXb5pzakhZIyjWxbg8dU81
         8eyuHwiAczpga/6hLJRPxAPCHCz2nG9VqWyPevCt3XgLC/O7ZsuC3EneAC9GouhauA33
         MnYVVYrb3B++iheTPovCfV+9uITa8kfedmfjUXFwwgAQ8Tt+ZXhxGd80TKGbRSQvOhI+
         lX6qrGVHPgNAOrXqDCPUoDS2DRrNHel6k4O9J6FCEX1t49dIl+V5zYMjXl85pT2FeC1f
         YZiH9eegeVoKuCiQk6CoiOlFA1XHWmeHxe5E4FAOdROc+naVcwtGRAdghYUIz7nk9aCj
         7QPA==
X-Gm-Message-State: ABy/qLYgSsyAvyOor9+LxpFPY2HBUSpa1RXWfIYVAABUAO5aR+j/eZ8p
        3GWqxet60p+Trelb8hAoL4fU9Q==
X-Google-Smtp-Source: APBJJlGTJf0O7Fk+xJWT9qywyV2N/3H7tz3wnHQaXe+ZSu1xhUb9OmMf8YuPpu/xy5b34gul655A3g==
X-Received: by 2002:a6b:dc05:0:b0:786:e612:72f8 with SMTP id s5-20020a6bdc05000000b00786e61272f8mr3450210ioc.21.1689805568494;
        Wed, 19 Jul 2023 15:26:08 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:84dc:2218:a741:ad50])
        by smtp.gmail.com with ESMTPSA id w26-20020a5d961a000000b007864c26fd35sm1592012iol.13.2023.07.19.15.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jul 2023 15:26:07 -0700 (PDT)
Date:   Wed, 19 Jul 2023 16:26:04 -0600
From:   Ross Zwisler <zwisler@google.com>
To:     Mike Rapoport <rppt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>, Michal Hocko <mhocko@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>
Subject: Re: collision between ZONE_MOVABLE and memblock allocations
Message-ID: <20230719222604.GB3528218@google.com>
References: <20230718220106.GA3117638@google.com>
 <20230719054434.GG1901145@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230719054434.GG1901145@kernel.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 19, 2023 at 08:44:34AM +0300, Mike Rapoport wrote:
> 3. Switch memblock to use bottom up allocations. Historically memblock
> allocated memory from the top to avoid corrupting the kernel image and to
> avoid exhausting precious ZONE_DMA. I believe we can use bottom-up
> allocations with lower limit of memblock allocations set to 16M.
> 
> With the hack below no memblock allocations will end up in ZONE_MOVABLE:

Yep, I've confirmed that for my use cases at least this does the trick, thank
you!  I had thought about moving the memblock allocations, but had no idea it
was (basically) already supported and thought it'd be much riskier than just
adjusting where ZONE_MOVABLE lived.

Is there a reason for this to not be a real option for users, maybe per a
kernel config knob or something?  I'm happy to explore other options in this
thread, but this is doing the trick so far.
