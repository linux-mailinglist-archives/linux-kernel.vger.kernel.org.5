Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38181782F52
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 19:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235034AbjHURX0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 13:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjHURXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 13:23:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD974EE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692638562;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ivazL8JAv7ckKoyhSXqt/af/Hi5kAJceHFL5yG3w5+0=;
        b=VVd50zXtaqgVKDQ4h06fykkYvawLZWkJRKRCS+N+hOa0BrlFBKtj3Udh3T1EmfW4kepy7V
        c8AFrsUdoh+QpQAEXIZak0ohbdVO4C+zTCQt7HDwDqVla0avHCjzeQv3Xl+/HW530JCMzj
        2B8f99iQnVREgUVpyssnP6yKQNgAYik=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-oNqfGmp_MjS-WInkJM2taw-1; Mon, 21 Aug 2023 13:22:41 -0400
X-MC-Unique: oNqfGmp_MjS-WInkJM2taw-1
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-34bad467102so37963885ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 10:22:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692638560; x=1693243360;
        h=content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ivazL8JAv7ckKoyhSXqt/af/Hi5kAJceHFL5yG3w5+0=;
        b=jVSPrwx6bj3InxaRAv13u4Rpj9x844mSCshHxeWC2+BuUD3GQHuHYp9sok8MzV6zcO
         efOvQq3eoEEWrLneHU0TThBqpIKtjbBrTP5Pj0Z+ypEVw5aoNo7W7O6UpAsutVhLySgc
         Ojy/gpAOHgwHNp/SUoodbH/jgl0ZzanZ9UPLm9wdtUJPEkhaMdDN5Jdz9gtBzEWsa1g1
         Kiye9DjBAalHCek6Vt46ZYUoISjXvbn4C2LqcRtm0dlw+MWaNa6JpCrn+j193loTC4Ly
         yLzVagt+JYro77UZ+y0CjL/yQfXXWmatPjLhxajFiUK77aQptkVrK+q95gO4gbwzGCJ7
         M00w==
X-Gm-Message-State: AOJu0YyqqlhlUrYU1AGNCB0Y2zHinmvMdYK70KZYeqcZ1ZzM0XHuulD9
        WGfWvF4gEYrwunMO4sdj1IqvIMzAxESpMRWv9uUPoF8uXM89AYW/pP+tWZl6XVl2yrMIkBs1Ccv
        K26t1MNY77/blDne9RqKX9zqt
X-Received: by 2002:a6b:6d01:0:b0:786:2125:a034 with SMTP id a1-20020a6b6d01000000b007862125a034mr9049996iod.18.1692638560257;
        Mon, 21 Aug 2023 10:22:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+lop5wsmnU+SlGPBBWWtiFkHhFzhxLlxUJv2EeKUr0epxXAEysTNC2s8HvQtn+j8YxpixZQ==
X-Received: by 2002:a6b:6d01:0:b0:786:2125:a034 with SMTP id a1-20020a6b6d01000000b007862125a034mr9049979iod.18.1692638559974;
        Mon, 21 Aug 2023 10:22:39 -0700 (PDT)
Received: from redhat.com ([38.15.60.12])
        by smtp.gmail.com with ESMTPSA id l21-20020a02ccf5000000b004317dfe68e7sm2498718jaq.153.2023.08.21.10.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 10:22:39 -0700 (PDT)
Date:   Mon, 21 Aug 2023 11:22:37 -0600
From:   Alex Williamson <alex.williamson@redhat.com>
To:     Brett Creeley <bcreeley@amd.com>
Cc:     patchwork-bot+netdevbpf@kernel.org,
        Yang Li <yang.lee@linux.alibaba.com>, edumazet@google.com,
        davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        shannon.nelson@amd.com, brett.creeley@amd.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] pds_core: Fix some kernel-doc comments
Message-ID: <20230821112237.105872b5.alex.williamson@redhat.com>
In-Reply-To: <ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
References: <20230821015537.116268-1-yang.lee@linux.alibaba.com>
        <169260062287.23906.5426313863970879559.git-patchwork-notify@kernel.org>
        <ed1bd63a-a992-5aef-f4da-eb7d2bc64652@amd.com>
Organization: Red Hat
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 10:05:21 -0700
Brett Creeley <bcreeley@amd.com> wrote:

> On 8/20/2023 11:50 PM, patchwork-bot+netdevbpf@kernel.org wrote:
> > Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> > 
> > 
> > Hello:
> > 
> > This patch was applied to netdev/net-next.git (main)
> > by David S. Miller <davem@davemloft.net>:
> > 
> > On Mon, 21 Aug 2023 09:55:37 +0800 you wrote:  
> >> Fix some kernel-doc comments to silence the warnings:
> >>
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Function parameter or member 'pf' not described in 'pds_client_register'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:18: warning: Excess function parameter 'pf_pdev' description in 'pds_client_register'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Function parameter or member 'pf' not described in 'pds_client_unregister'
> >> drivers/net/ethernet/amd/pds_core/auxbus.c:58: warning: Excess function parameter 'pf_pdev' description in 'pds_client_unregister'
> >>
> >> [...]  
> > 
> > Here is the summary with links:
> >    - [net-next] pds_core: Fix some kernel-doc comments
> >      https://git.kernel.org/netdev/net-next/c/cb39c35783f2
> > 
> > You are awesome, thank you!
> > --
> > Deet-doot-dot, I am a bot.
> > https://korg.docs.kernel.org/patchwork/pwbot.html
> > 
> >   
> 
> FYI - there might be some conflicts here as this was already fixed on 
> Alex Williamson's vfio next branch. I don't fully understand how all 
> things get merged into v6.6, so I just wanted to update here.
> 
> On vfio's next branch this was fixed by: 06d220f13b1f ("pds_core: Fix 
> function header descriptions"). It also has a pre-requisite patch that 
> actually introduced the warning: b021d05e106e ("pds_core: Require 
> callers of register/unregister to pass PF drvdata").

Right, the issue was introduced by:

https://lore.kernel.org/all/20230807205755.29579-4-brett.creeley@amd.com/

which exists in the vfio next branch as:

b021d05e106e ("pds_core: Require callers of register/unregister to pass PF drvdata")

The problem doesn't actually exist in the stand alone net-next branch,
so I felt confident in taking Brett's fix from here:

https://lore.kernel.org/all/20230817224212.14266-1-brett.creeley@amd.com/

which is currently in the vfio next branch:

06d220f13b1f ("pds_core: Fix function header descriptions")

Additionally this includes proper attributes and fixes tags.

I'm sure Linus can fixup the conflict, but a preferable solution might
be to drop the patch from Yang Li from net-next.  Thanks,

Alex

