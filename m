Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C420D7DDA96
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 02:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377001AbjKAB0T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 21:26:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345060AbjKAB0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 21:26:18 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218E7F1
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:26:16 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-6ba54c3ed97so6396872b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 18:26:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698801975; x=1699406775; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRhIv33/xNOydaS40tvWBRwkpIiHBlMX74EhxM1mr3A=;
        b=KwTdA0Xwf6bc1od7lc1d/Pzr2/R9NJf4MGG9BWGb3i3rhrxZZC3vaNEPSqEf2QBTWl
         82ZBsq/mU/M1ZAfkzWCQLRIDMkZmiOy5UcpBVsd6F0AnrqwG8QmCpjp+mpe2Y+gksJUm
         4draaup1CYDKZlRpem9OuB6Smrx233x/JaNjzkVwIf8KjCMIvMEBhp28LCDSwXNJruK/
         L1STFuAfwVYMofPr12SgX+g92YDt1d+c42hb3ATapOkKCFEzMNeRtr+XXJHF3/jiEie3
         ctXd5TLDX8xhj4KBSHQVkrLopA1JpP9aidIDsoCIKNfgsGeNm8vYypiIFoanxe/iy0k1
         Ua/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698801975; x=1699406775;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KRhIv33/xNOydaS40tvWBRwkpIiHBlMX74EhxM1mr3A=;
        b=hLIZaoiXQfdqaDGKoOAoFJa8P7Ykb7+ZB58BfCbWbrQOXtHNbCBr2hYZD4ZIcEEYOJ
         NIyduuFurCXNnR3VguRjO8m9tWaWUVQf1NBgnBaDsh1q9iVeToxGJII1mLLLQfrtfkUU
         eXUko8uEANViMX0+JZmtOvAcLdJ0Zhe3Nl28kfkjc/kV9d1uNLBFIOC+17gU4N0UTmle
         INVBNzggdrETEcyoYcUjLolAz5KkUQaU1967XdTc9FZwTcefufoGPulElfVc5XnaIICf
         AfENwNzqxukGiY/DmVzMTw/XZ5aCZ2/JqCwOCD8p9ZAJ1AkIMsrLU72x6uDfkO7lFSjk
         8P3A==
X-Gm-Message-State: AOJu0YzdPZGXrWMsCao3MwwPjSwTSeF9z7NhUJcdHurbjWQ3BAkuwZPz
        waPGVwCz2yvS0c/y8l69B5k=
X-Google-Smtp-Source: AGHT+IFuXaY7xLDUkog6Pu239mbMB7I91mFSjlX5YJafSat477CpurLSjC/HbHRm+Nt6OqnF4H4uew==
X-Received: by 2002:a05:6a20:a122:b0:148:f952:552b with SMTP id q34-20020a056a20a12200b00148f952552bmr19654936pzk.51.1698801975542;
        Tue, 31 Oct 2023 18:26:15 -0700 (PDT)
Received: from localhost (fwdproxy-prn-003.fbsv.net. [2a03:2880:ff:3::face:b00c])
        by smtp.gmail.com with ESMTPSA id jk6-20020a170903330600b001c61901ed2esm176358plb.219.2023.10.31.18.26.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 18:26:15 -0700 (PDT)
From:   Nhat Pham <nphamcs@gmail.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, mhocko@kernel.org,
        roman.gushchin@linux.dev, shakeelb@google.com,
        muchun.song@linux.dev, chrisl@kernel.org, linux-mm@kvack.org,
        kernel-team@meta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
Date:   Tue, 31 Oct 2023 18:26:14 -0700
Message-Id: <20231101012614.186996-1-nphamcs@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024203302.1920362-3-nphamcs@gmail.com>
References: <20231024203302.1920362-3-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
about memory controller + list_lru reparenting logic than me.

There seems to be a race between memcg offlining and zswap’s
cgroup-aware LRU implementation:

CPU0                            CPU1
zswap_lru_add()                 mem_cgroup_css_offline()
    get_mem_cgroup_from_objcg()
                                    memcg_offline_kmem()
                                        memcg_reparent_objcgs()
                                        memcg_reparent_list_lrus()
                                            memcg_reparent_list_lru()
                                                memcg_reparent_list_lru_node()
    list_lru_add()
                                                memcg_list_lru_free()


Essentially: on CPU0, zswap gets the memcg from the entry's objcg
(before the objcgs are reparented). Then it performs list_lru_add()
after the list_lru entries reparenting (memcg_reparent_list_lru_node())
step. If the list_lru of the memcg being offlined has not been freed
(i.e before the memcg_list_lru_free() call), then the list_lru_add()
call would succeed - but the list will be freed soon after. The new
zswap entry as a result will not be subjected to future reclaim
attempt. IOW, this list_lru_add() call is effectively swallowed. And
worse, there might be a crash when we invalidate the zswap_entry in the
future (which will perform a list_lru removal).

Within get_mem_cgroup_from_objcg(), none of the following seem
sufficient to prevent this race:

    1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
    section.
    2. Checking if the memcg is freed yet (with css_tryget()) (what
    we're currently doing in this patch series).
    3. Checking if the memcg is still online (with css_tryget_online())
    The memcg can still be offlined down the line.


I've discussed this privately with Johannes, and it seems like the
cleanest solution here is to move the reparenting logic down to release
stage. That way, when get_mem_cgroup_from_objcg() returns,
zswap_lru_add() is given an memcg that is reparenting-safe (until we
drop the obtained reference).
