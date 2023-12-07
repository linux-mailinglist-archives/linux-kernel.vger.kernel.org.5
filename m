Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4DDD8095FD
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjLGW4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:56:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjLGW4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:56:35 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D471ED5B;
        Thu,  7 Dec 2023 14:56:41 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1d06819a9cbso11664505ad.1;
        Thu, 07 Dec 2023 14:56:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701989801; x=1702594601; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=En3Kfr6yFcketU+H68sFxgGmFIYcncOOAldDpFCnChY=;
        b=QMeMDDbAP88WWhVuuN5aeic6WA1UpuRXPiaU8foCuGOyzC4iupY6l/MEGyRmiQaWU3
         TaSbuaWvuaAV1HwMrUXcc4aljpw9C5zcX4UnyF/Yic/GWAWsY62bIe/WllYBfFORn7jq
         Fj1VzcNojyOGBWMWaxAjTFEKrLcFV+BUrApCjrBPXnwAZaIqnZ8sG67Facwty4kMj/7R
         E3AAu26wxaVnRhP8lYEe/aC23l1X1B4T+anE8KeDcAbSbWw2FAl4VtNUig+55y8wcHnP
         MGFkZUycq4/QePBkUQ+KtQ344RWipaxY+ysU9U5lQgzfKAzqsrRL2Zvlbw6QGnU35nBF
         KDKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701989801; x=1702594601;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En3Kfr6yFcketU+H68sFxgGmFIYcncOOAldDpFCnChY=;
        b=mcOAoWXC/pONZC96KfXkmJylfGBxZMTMbthMbZ/epp9jpdxrcrbSyI6rTQZaqMS5Te
         EN2P3RRlhFRncqow1ryFVEyVc7lmQklaphorsrBNuzZ4x/xpKArKSMBkWP6oh4Ceu2kG
         tD963lUQlU1D1TBYRJKKWw8Bnw6YjCRmXfT2Mf4eOyrdJr1lRqC/4X66bRhQ4ZX7CyMg
         zgT90iE4ICGypHHnGWFZacZGHi7LtAbLZ0pNHn0em+dyD8+MxCiRZqzSP2R07iC1v7Gy
         jRM0sJpcMw48ezXT5jUYuXWtxcUYrMHXVrKlzD8G4VZCFp8dOlZaHw/7+oVndOI2Iboo
         pgmA==
X-Gm-Message-State: AOJu0YxDmw2KKUI8G0XkyHrL7b2oxIryYas12pob7X+Y0i1anUJUtVkS
        Zds1Juc9hTLLcs4+qrmMf1eTLA4LcGg=
X-Google-Smtp-Source: AGHT+IFGA30PwUqkquKHLYpKyg/lGbgTctk149l/c1J4fi6WKId3oOAEZApvA7unUMZX6zJGcM2Glw==
X-Received: by 2002:a17:902:be14:b0:1d0:6ffd:adf1 with SMTP id r20-20020a170902be1400b001d06ffdadf1mr2650460pls.88.1701989800194;
        Thu, 07 Dec 2023 14:56:40 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id t1-20020a170902b20100b001bb9d6b1baasm330392plr.198.2023.12.07.14.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:56:39 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 7 Dec 2023 12:56:38 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yafang Shao <laoar.shao@gmail.com>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v2] cgroup: Move rcu_head up near the top of
 cgroup_root
Message-ID: <ZXJNpr2uGEcxpoQt@slm.duckdns.org>
References: <20231207134614.882991-1-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134614.882991-1-longman@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 08:46:14AM -0500, Waiman Long wrote:
> Commit d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU
> safe") adds a new rcu_head to the cgroup_root structure and kvfree_rcu()
> for freeing the cgroup_root.
> 
> The current implementation of kvfree_rcu(), however, has the limitation
> that the offset of the rcu_head structure within the larger data
> structure must be less than 4096 or the compilation will fail. See the
> macro definition of __is_kvfree_rcu_offset() in include/linux/rcupdate.h
> for more information.
> 
> By putting rcu_head below the large cgroup structure, any change to the
> cgroup structure that makes it larger run the risk of causing build
> failure under certain configurations. Commit 77070eeb8821 ("cgroup:
> Avoid false cacheline sharing of read mostly rstat_cpu") happens to be
> the last straw that breaks it. Fix this problem by moving the rcu_head
> structure up before the cgroup structure.
> 
> Fixes: d23b5c577715 ("cgroup: Make operations on the cgroup root_list RCU safe")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Closes: https://lore.kernel.org/lkml/20231207143806.114e0a74@canb.auug.org.au/
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Yafang Shao <laoar.shao@gmail.com>

Applied to cgroup/for-6.8.

Thanks.

-- 
tejun
