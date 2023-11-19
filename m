Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E1E17F0707
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 16:05:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231292AbjKSPFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 10:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjKSPFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 10:05:37 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C421139;
        Sun, 19 Nov 2023 07:05:33 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1cc34c3420bso26576695ad.3;
        Sun, 19 Nov 2023 07:05:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700406333; x=1701011133; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZunorBu+pSlhXgVxLKtqIO/zrvDIVnpRCfzitU3U4Kw=;
        b=RE6e3UU9As7x4DWzgzlHI0dbeoeAUfZPOW5W8wGDkcfA8ColiCtGruOh732B1XNSLy
         B8GPmbUL5zenValbIWl6vpSgxNDOh2dex+yGfih+pO3D0M+sF+dQBaCFh+KDb/oKnSEa
         lD3vy2VgpI4Je4NHgO/pP5JV9gf0pJKfBB9QFxnMCjIo9+TDrdYdpP/Jt2eopYrktsvr
         9u+VG7cnJfM/LLiG/A9kIW7hAN3b1m0scsTU7HhwCYk/xydPXoy5Y303pHvdH47KNWiW
         /Zn+iammuv6SIhoLpjl3rjm0P8pJHgr2/6a6n6UKO/amdj4dwI6EgXMxdLVkomzN5SfI
         V71w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700406333; x=1701011133;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZunorBu+pSlhXgVxLKtqIO/zrvDIVnpRCfzitU3U4Kw=;
        b=efhM0pQ9thQmUBycdoT5PkVtJJNUUdMLLej1ezFos9U0S+BwevgRh+YYCJDX9OM1nG
         FLEbSgFWUD7nftgWpjbJgsq7yICmSsCPECWHSOsfLEqG5eA09Dm8Y57FvU/wa+bFstGY
         PMccIU2IkhRsz8l3H1Pyab3aNYH5CdyueR6RiGKMoDraa436JOtM6apih2brxlGVBO2U
         eG+J5ZAhDo5FKZPlAZuKPyKMs0VDD/GA1NA0XJ/w4ijdmNAEpteeLfLREYqRgi6f5VJW
         dF3iJIOgRb8qUhPAuSU/yKkNxNtZ2IyyWMn3EyJlxl+JwbsOLOk035LYVY3YPXFx6HDd
         I9jA==
X-Gm-Message-State: AOJu0YxnYD/LC+DSVOEEbyek172eUdS8YavjsErrflJleqPcj+Vd7P1j
        ULcK8qZVteTlnS+wxy+oAW0=
X-Google-Smtp-Source: AGHT+IGzH+/CjsKrHeKApvx47z5slzIAxpySHaRmP6Ect4tge+175o42wM4woX0wpMZ83M9ABOnGYA==
X-Received: by 2002:a17:902:e808:b0:1cf:5cb5:95c1 with SMTP id u8-20020a170902e80800b001cf5cb595c1mr476278plg.37.1700406332426;
        Sun, 19 Nov 2023 07:05:32 -0800 (PST)
Received: from localhost (dhcp-72-253-202-210.hawaiiantel.net. [72.253.202.210])
        by smtp.gmail.com with ESMTPSA id c8-20020a170902d48800b001ce5b6de75esm4417057plg.160.2023.11.19.07.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 07:05:32 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Sun, 19 Nov 2023 05:05:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Tim Van Patten <timvp@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, markhas@google.com,
        Tim Van Patten <timvp@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
Subject: Re: [PATCH] cgroup_freezer: cgroup_freezing: Check if not frozen
Message-ID: <ZVokO6_4o07FU0xP@slm.duckdns.org>
References: <20231115162054.2896748-1-timvp@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231115162054.2896748-1-timvp@chromium.org>
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

On Wed, Nov 15, 2023 at 09:20:43AM -0700, Tim Van Patten wrote:
> From: Tim Van Patten <timvp@google.com>
> 
> __thaw_task() was recently updated to warn if the task being thawed was
> part of a freezer cgroup that is still currently freezing:
> 
> 	void __thaw_task(struct task_struct *p)
> 	{
> 	...
> 		if (WARN_ON_ONCE(freezing(p)))
> 			goto unlock;
> 
> This has exposed a bug in cgroup1 freezing where when CGROUP_FROZEN is
> asserted, the CGROUP_FREEZING bits are not also cleared at the same
> time. Meaning, when a cgroup is marked FROZEN it continues to be marked
> FREEZING as well. This causes the WARNING to trigger, because
> cgroup_freezing() thinks the cgroup is still freezing.
> 
> There are two ways to fix this:
> 
> 1. Whenever FROZEN is set, clear FREEZING for the cgroup and all
> children cgroups.
> 2. Update cgroup_freezing() to also verify that FROZEN is not set.
> 
> This patch implements option (2), since it's smaller and more
> straightforward.
> 
> Signed-off-by: Tim Van Patten <timvp@google.com>

Applied to cgroup/for-6.7-fixes.

Thanks.

-- 
tejun
