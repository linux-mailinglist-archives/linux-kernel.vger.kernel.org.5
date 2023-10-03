Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48A177B6EF1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 18:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbjJCQsq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 12:48:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240491AbjJCQso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 12:48:44 -0400
Received: from mail-vk1-xa2f.google.com (mail-vk1-xa2f.google.com [IPv6:2607:f8b0:4864:20::a2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0457BB4
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 09:48:37 -0700 (PDT)
Received: by mail-vk1-xa2f.google.com with SMTP id 71dfb90a1353d-495eb6e2b80so511946e0c.1
        for <linux-kernel@vger.kernel.org>; Tue, 03 Oct 2023 09:48:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1696351716; x=1696956516; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7fQqegtPGr2l/qfGLLeKHAsEgJgKMskDcYWjAE5QgNs=;
        b=gVKov6mPeAcopJtqLwZsXvaTj9WR0vDK2+KkquuE/SjYdRn1jSZzwvo3S2upYQ3YXP
         fF7RnI3OWo63osg1t7KQ2L2EibfLTAQEs+NgBCiIM/MAk4FYyjsxGxSmo0aAkOBxf/3K
         NrGgY0UunZZNfEyVcE0wFUZTMjs/ldNGMRf2EZGgJVr9FvMrhEl+ceE1eNyCQYRUVG/v
         tnSqY6ElKdByFadA9Y2iHAr3p2Hgl2ZwzjzlvaA3LIURF7mKZgTN5O+iTNFtW/EmWbla
         dixOHshXditOZwGRzylht4pMObof4vwtsyaIHqYh1TDurtciDJak9FG+l+WisyxvPbXZ
         D8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696351716; x=1696956516;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7fQqegtPGr2l/qfGLLeKHAsEgJgKMskDcYWjAE5QgNs=;
        b=gVe8XX6398m+pZZEv3ZXP5NGH0twaxj3wzcGSJnvKPqJMBep9W3b2WJxykrqGWHCld
         MfVRjjB8FyD+OvYa4aVi2Y0QClL0eNfAQRAzU5cvrTRx/YJgajVZH2p4ZYRV04wqkcNZ
         iSn3iBlX0AkwgTjY2hpC5iKmfnKs/vM77abg6dkZpCFCBGouZp+MmcEtI8eEyTGV7Us1
         3oKSibgWS+lY5fO07KVQ8r4hvXsuqLKMi+H38tWKGYQtg4LIOGJqEbFh5vs4alvXzsyQ
         jFJqbLU2ShthXovKL37Bxg6kX3PwBlQ8n/f8EGSH2a6khqS1G9YD0ejJlkoIaSMEA/Kw
         6JAg==
X-Gm-Message-State: AOJu0YzMCBG7PDkaAoDfWSkPa01/OQmP1zuF6uT3RnZpQHp9e9RfCBtz
        R+7HkU2LUhJBAN+zQQhmhQOs0EuXxJ9XRmpawGs=
X-Google-Smtp-Source: AGHT+IEzXIwhhXIHlbSduWagnxX4PLiRp03xXdD5h2lcmYMEvKP7eJDYYCtQTx7mB+AMKvyGeBlo6Q==
X-Received: by 2002:a1f:e043:0:b0:490:b58e:75a9 with SMTP id x64-20020a1fe043000000b00490b58e75a9mr10316947vkg.4.1696351716094;
        Tue, 03 Oct 2023 09:48:36 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:753d])
        by smtp.gmail.com with ESMTPSA id g12-20020ac8480c000000b00415268abe26sm570941qtq.8.2023.10.03.09.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Oct 2023 09:48:35 -0700 (PDT)
Date:   Tue, 3 Oct 2023 12:48:35 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v1 1/5] mm: kmem: optimize get_obj_cgroup_from_current()
Message-ID: <20231003164835.GA20979@cmpxchg.org>
References: <20230929180056.1122002-1-roman.gushchin@linux.dev>
 <20230929180056.1122002-2-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929180056.1122002-2-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:00:51AM -0700, Roman Gushchin wrote:
> Manually inline memcg_kmem_bypass() and active_memcg() to speed up
> get_obj_cgroup_from_current() by avoiding duplicate in_task() checks
> and active_memcg() readings.
> 
> Also add a likely() macro to __get_obj_cgroup_from_memcg():
> obj_cgroup_tryget() should succeed at almost all times except a very
> unlikely race with the memcg deletion path.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>
> Acked-by: Shakeel Butt <shakeelb@google.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
