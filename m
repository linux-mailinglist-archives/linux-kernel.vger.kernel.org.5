Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07D897676A0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjG1Tvl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 15:51:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234961AbjG1Tvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 15:51:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D0F44A5
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690573833;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JL0vjTaxYUqkmZNYFhgTom6BuK4FVEs8BSvx2Ibs/QU=;
        b=JvVMvfW3G7Mx/na4JkYK+NdMPgHIhpwoE3sn/O/ggDlXt7EwizO4V/uYaqaYtRycNJV1Sm
        jSlcbdSz8gHQAm13xu50pu+flXSediyhYNItk74BzlpLtKV5HpBgHYv57DO/D4aYfcyqRz
        HjUcXBmF/6E05LaypT6wm8hY47J/Vcs=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-zdgwpW3SPTiwpOIzv4lZgw-1; Fri, 28 Jul 2023 15:50:32 -0400
X-MC-Unique: zdgwpW3SPTiwpOIzv4lZgw-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-76c8e07cbe9so13211385a.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 12:50:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690573831; x=1691178631;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JL0vjTaxYUqkmZNYFhgTom6BuK4FVEs8BSvx2Ibs/QU=;
        b=g3C5rkymhKGPLIMJkFQTrqKScNpOkn2uUWieShsvRo5VUUsp/Vz/HXZ/gMTkGRn16/
         9TdnDd0eAhoVRhc/zpCj0QIzu8zyfUuvtw9/TLmmLh2jzmeSDlRYGXEknk4F04MTsjF1
         TTHeiIilABYfOfmCbYuuYe2Rf4iVETgWpLjFKcSvnXEUMIiRquJMPzU5V6oIjOfAnu7W
         1yI57fw1e3oTtXhuiSuwMhgrSg1sqd8YZX8qmD+PQ3s1eoznfHuUS5P4stmpVUTz0nCv
         NFi5HuGFqsCsB4eTEwBC+vihOqJH1VKtjtJOpuvT6TuEC1nskXbO8jdI3p3o5c1j3fm8
         1ENg==
X-Gm-Message-State: ABy/qLb4uSRXpnMWK+zxQtRAdpUgmKoBXWtTcMonUiKQJacuN3eaLlwV
        YCO4opE69aX7IReGscetdZQj+S+tVhWszuxnv6Uv69WWRmozSbh/pVKLy/LF5wqGdWtGOq9k260
        u9zGenecnsrkVYIHOguqlW7zt
X-Received: by 2002:ac8:5ad5:0:b0:400:990c:8f7c with SMTP id d21-20020ac85ad5000000b00400990c8f7cmr825188qtd.0.1690573831584;
        Fri, 28 Jul 2023 12:50:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEvAskwCoVMGlYLkEaAmUF4jcMWrt6qNlGnn1uYl/VfOdOQ0yaJwY1yqIo6W+eUFAntaOCUjQ==
X-Received: by 2002:ac8:5ad5:0:b0:400:990c:8f7c with SMTP id d21-20020ac85ad5000000b00400990c8f7cmr825160qtd.0.1690573831320;
        Fri, 28 Jul 2023 12:50:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id o11-20020ac872cb000000b004055106ee80sm195044qtp.44.2023.07.28.12.50.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 12:50:30 -0700 (PDT)
Date:   Fri, 28 Jul 2023 15:50:29 -0400
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        liubo <liubo254@huawei.com>,
        Matthew Wilcox <willy@infradead.org>,
        Hugh Dickins <hughd@google.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>,
        Mel Gorman <mgorman@techsingularity.net>
Subject: Re: [PATCH v1 0/4] smaps / mm/gup: fix gup_can_follow_protnone
 fallout
Message-ID: <ZMQcBWvjVUEBU6mF@x1n>
References: <20230727212845.135673-1-david@redhat.com>
 <CAHk-=wiig=N75AGP7UAG9scmghWAqsTB5NRO6RiWLOB5YWfcTQ@mail.gmail.com>
 <eaa67cf6-4896-bb62-0899-ebdae8744c7a@redhat.com>
 <b647fd9a-3d75-625c-9f2c-dd3c251528c4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b647fd9a-3d75-625c-9f2c-dd3c251528c4@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 28, 2023 at 09:40:54PM +0200, David Hildenbrand wrote:
> Hmm. So three alternatives I see:
> 
> 1) Use FOLL_FORCE in follow_page() to unconditionally disable protnone
>    checks. Alternatively, have an internal FOLL_NO_PROTNONE flag if we
>    don't like that.
> 
> 2) Revert the commit and reintroduce unconditional FOLL_NUMA without
>    FOLL_FORCE.
> 
> 3) Have a FOLL_NUMA that callers like KVM can pass.

I'm afraid 3) means changing numa balancing to opt-in, probably no-go for
any non-kvm gup users as that could start to break there, even if making
smaps/follow_page happy again.

I keep worrying 1) on FOLL_FORCE abuse.

So I keep my vote on 2).

Thanks,

-- 
Peter Xu

