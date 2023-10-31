Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5B97DD952
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 00:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346942AbjJaXlA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 19:41:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230375AbjJaXk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 19:40:58 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AD45C9
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:40:56 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5a7b9e83b70so3164027b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 16:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698795655; x=1699400455; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=pAuUiRH/6IYineqwKVLSSqFiEk7BGaE+7e5FuTbpUqg=;
        b=Adja7pE2JWKvu5DGEoLgfRycuEAvfRAjg3W6cstyCXZzdV95NwXzsftW3wzxXdiSAO
         JN2Hvf125VWbKzbgzMGqbvz8rqjJ6ghZQa3PbdylZ7bGQ/nbRElkApvn/up07zvmf10K
         p/7dWIyGnappHvwCNkLa170F2wjNWlVNQQoWIiZrePOhNygndqsTvGW3LYcvNfrNEQRS
         T/72ICvl8Q9m28SVF+srWSLheJ0UbOTkDRwgdRYLEvG+wMYcY8LfKoRONvbhA1Xtx+U3
         W7T4xIqmd+xaZBuUT/yzxNTUO6J9Piq6BnVnO5dVt1fLUhl8YHWimZreBSkMb9W+WuBT
         7d4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698795655; x=1699400455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAuUiRH/6IYineqwKVLSSqFiEk7BGaE+7e5FuTbpUqg=;
        b=Pglss9NSHH5EJBdWglnCMeF/xfGZgys9v2wy884pjSUipGhiwU38uvBkIX4sHR5EQq
         /jttngep+m+RP0HvpWplYIJzH+/We/FV2eokUZya+cdeVjPM+QA32WHRNJ14eVOpnRHa
         6rcqHG05OxpObZ6iQ5n8Qs9jyjltkcj8nHXsEabBIcrPG+7npufQQkvkc7s9gj1Fki/y
         FA9TtoIu0ERj2+f0sPRGbYEYeiuouNeAd6FHFUXluYuGRrBwDb5vPJP6cziC1cwEB+7T
         qnTKWlhsdCJJzygrppHKQHh+NCyox9olk7rRpG4VO3OGOgHCmRvsluu93Jd+DqvQTi0e
         cYqg==
X-Gm-Message-State: AOJu0Yw7hZe5wK6Sg2wblRWOxOw5s5dAV4QQApaHmnuXWvPMLkOEt0Bb
        kOHubx4rrZ7R7OA6zn/SdADImARxkU4=
X-Google-Smtp-Source: AGHT+IGLbwlANyjrrJ36/sGvijbFIoZawEfNxiVzXOWt+q7P+31wikkSTQv3XGE6y3vIzBujHun7BLsPkvI=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:690c:ecb:b0:5a7:b95c:a58f with SMTP id
 cs11-20020a05690c0ecb00b005a7b95ca58fmr34239ywb.1.1698795655480; Tue, 31 Oct
 2023 16:40:55 -0700 (PDT)
Date:   Tue, 31 Oct 2023 16:40:53 -0700
In-Reply-To: <20231002095740.1472907-5-paul@xen.org>
Mime-Version: 1.0
References: <20231002095740.1472907-1-paul@xen.org> <20231002095740.1472907-5-paul@xen.org>
Message-ID: <ZUGQhfH3HE-y6_5C@google.com>
Subject: Re: [PATCH v7 04/11] KVM: pfncache: base offset check on khva rather
 than gpa
From:   Sean Christopherson <seanjc@google.com>
To:     Paul Durrant <paul@xen.org>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Durrant <pdurrant@amazon.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        David Woodhouse <dwmw2@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023, Paul Durrant wrote:
> From: Paul Durrant <pdurrant@amazon.com>
> 
> After a subsequent patch, the gpa may not always be set whereas khva will
> (as long as the cache valid flag is also set).

This holds true only because there are no users of KVM_GUEST_USES_PFN, and
because hva_to_pfn_retry() rather oddly adds the offset to a NULL khva.

I think it's time to admit using this to map PFNs into the guest is a bad idea
and rip out KVM_GUEST_USES_PFN before fully relying on khva.

https://lore.kernel.org/all/ZQiR8IpqOZrOpzHC@google.com
