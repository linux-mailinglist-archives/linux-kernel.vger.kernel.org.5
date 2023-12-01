Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39D801121
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:21:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378605AbjLAQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 11:59:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjLAQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 11:59:26 -0500
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA09A2;
        Fri,  1 Dec 2023 08:59:33 -0800 (PST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-6cddc59e731so2153369b3a.1;
        Fri, 01 Dec 2023 08:59:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701449973; x=1702054773; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3dRbGatx1opBY03QMl1LAqDJ92qlmNckr8hscmiczpg=;
        b=DtQiTnMgqNMo0z3q2fRLNtShFxO0EEeHcKWuyKGSBUCuzlI+W3XIJqwNqzOkGkRMsP
         ixgbsV3z2QxkiUlzIFVnhVhY3s5FX7ZpuP79v7ys4j6iwhumc0C7Nkbbk5yn1vbd0ocp
         TcJS6U9nJSrfhuDOkqDaqBqHwYzlyH4jn9+rzBeWFnC5oJnZSYKLX9AUDbqSmw6HsGpP
         9YENVHpmFFR8Ot+A9yI/CRLa3yCqxrEgBRddnK5ScI2ndq/953fL5NJCsyJkE8Yxiys3
         9G4ca6z3vEjtn4w+OrScdUB/kkKMNGTHGyT1hx89MGwsmvfDJFgA6oPGDyipuf5Z8bxe
         fV/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701449973; x=1702054773;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3dRbGatx1opBY03QMl1LAqDJ92qlmNckr8hscmiczpg=;
        b=KwM6NhS2VYDhfr9Aq74HjTnCq95e2nTQWoJCZ+tvlO9VKKVwMS+mleaK/zSxqRuIMu
         Tac9cesDbfxwB8Fo3lh6C30UX3ObG1BDlspe1BQznlHdpvRpGe8y32opAK/Z112dTFH4
         XuJKNeoo5si/cdXU5DktKiRaUMLs+p6LWCCPVT/Eri0Xjwiv/Fy8s4sA7YD/P9RgTqY3
         83qXKHDQojnhnWARrrhoMRc7R0vAWyRqU3uz+SEdLVHuBie0McxTrX/qDTjcU0C+1z/X
         93tfj52fQIBD+v++gLAW5CTxDBL0pM1KIFwzNN5VhRtzMWHq4Db9wFdIybiwzFjmFvuz
         7L+g==
X-Gm-Message-State: AOJu0YxvY/H1SM6wJdReeRW19WamGEnlwydpiWePZ2Z8+5YvWLP96xts
        1i0TtkDYxlGK83pRDfeA5H4=
X-Google-Smtp-Source: AGHT+IHaQXt2nCWUoqLr98KVdxbGpPD4vg9+YHblnrEG2m0hzeYNXnZMAn3OXjQfLt95pfx/lMACwg==
X-Received: by 2002:a05:6a20:918e:b0:185:a90d:363d with SMTP id v14-20020a056a20918e00b00185a90d363dmr29094374pzd.2.1701449972533;
        Fri, 01 Dec 2023 08:59:32 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id g1-20020a62e301000000b006c4d86a259csm3222850pfh.28.2023.12.01.08.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 08:59:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Dec 2023 06:59:30 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Max Kellermann <max.kellermann@ionos.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] kernel/cgroup: use kernfs_create_dir_ns()
Message-ID: <ZWoQ8uroTtMDsBF8@slm.duckdns.org>
References: <20231201125638.1699026-1-max.kellermann@ionos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231201125638.1699026-1-max.kellermann@ionos.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, Dec 01, 2023 at 01:56:37PM +0100, Max Kellermann wrote:
> By passing the fsugid to kernfs_create_dir_ns(), we don't need
> cgroup_kn_set_ugid() any longer.  That function was added for exactly
> this purpose by commit 49957f8e2a ("cgroup: newly created dirs and
> files should be owned by the creator").
> 
> Eliminating this piece of duplicate code means we benefit from future
> improvements to kernfs_create_dir_ns(); for example, both are lacking
> S_ISGID support currently, which my next patch will add to
> kernfs_create_dir_ns().  It cannot (easily) be added to
> cgroup_kn_set_ugid() because we can't dereference struct kernfs_iattrs
> from there.
> 
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>

 Acked-by: Tejun Heo <tj@kernel.org>

Greg, given that the two patches are related, it'd probably be less
confusing to route them together through your tree. If you want to route
them differently, please let me know.

Thanks.

-- 
tejun
