Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A418011D4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 18:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378848AbjLARhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 12:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLARhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 12:37:45 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF06EFE;
        Fri,  1 Dec 2023 09:37:51 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce015fd299so787611b3a.2;
        Fri, 01 Dec 2023 09:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701452271; x=1702057071; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=h1vqngejylljTl8aS0wEyCo9hvaRqIL121iZk7bSTek=;
        b=BWrsDN6bFv6dEdWNbX2GjqRojrgzaLAnTM84pTfad/jJBGwDaB9pMTdb6xm4iuynR6
         Ki3kPHZdHhgyk6dZWIuKBMOIUUMFKRNhlzFs+kHv8cgrMS6DM4vtCJOQyx7VGk4RDQai
         6zFy+hZV8kWc7frhzCGmAD/SaqLNh7dq4OilINsQaZsi1Ja8pVMYNGJIDqoBpQnRkBPh
         H7MKk+In6in1vDVrlPLH51M0ybdUInLiXMG8ls13eh83IIuMtA+UHq/e5Ql0NhSX8/jF
         dKCjmRldX5OuOqEJ0nB3peICZp/jPGbxAXXCz75SqUvgvk/HezYHccw1gh1KmziX/IuP
         lmsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701452271; x=1702057071;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1vqngejylljTl8aS0wEyCo9hvaRqIL121iZk7bSTek=;
        b=aPlJBh0ewahY/3M99Q5aG4KeDepU/FMh55jHEWWMYewXKRpPaWnaDEVW2fR4VJWeG0
         24QhFEoy/9q+//nQ67O0KmpsfXDP7bi4N1xP4O/pxpQOGCkVmGeFGKFRiw0rDTdaOD+e
         2QHFAlQT8Emc0zowvf9BccDlqPTB3tRfQPPy+rGyehHEmYJRsgO4zomoGw16jDne/yuR
         bx0+GWn7c2522+EWcPe6HlixsCSdBziwMg9yS9J2I4FXZAZbaa6TCj6jyDZrVu5jWy4O
         gZowecFZTWILkwx1eOPKZOlPA+kmX7QjclfA0efL1YLtmeK2GGfpx3kzyAyce1tMYC3/
         ElwA==
X-Gm-Message-State: AOJu0YxcHxQZ7q3TsE82JzL5Gd4HB4vh0FGIUcBCPSye8SKoSZU1rpOn
        X/0N3usnfRiVaBrjxNlKPLw=
X-Google-Smtp-Source: AGHT+IFAt0LiS7l0sn2Vw/b/IlTmAaaNeqgD2j10o5eTcjXrQnLBJ5810dswT4esP2xu+ZTLejLRGA==
X-Received: by 2002:a05:6a20:914a:b0:18c:651:c40e with SMTP id x10-20020a056a20914a00b0018c0651c40emr28205199pzc.50.1701452271350;
        Fri, 01 Dec 2023 09:37:51 -0800 (PST)
Received: from localhost ([2620:10d:c090:400::4:27ef])
        by smtp.gmail.com with ESMTPSA id gx21-20020a056a001e1500b006930db1e6cfsm3255376pfb.62.2023.12.01.09.37.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 09:37:50 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 1 Dec 2023 07:37:49 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, Joe Mario <jmario@redhat.com>,
        Sebastian Jug <sejug@redhat.com>,
        Yosry Ahmed <yosryahmed@google.com>
Subject: Re: [PATCH-cgroup v5 1/2] cgroup/rstat: Optimize
 cgroup_rstat_updated_list()
Message-ID: <ZWoZ7U8f5NNwimej@slm.duckdns.org>
References: <20231130204327.494249-1-longman@redhat.com>
 <20231130204327.494249-2-longman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231130204327.494249-2-longman@redhat.com>
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

On Thu, Nov 30, 2023 at 03:43:26PM -0500, Waiman Long wrote:
> The current design of cgroup_rstat_cpu_pop_updated() is to traverse
> the updated tree in a way to pop out the leaf nodes first before
> their parents. This can cause traversal of multiple nodes before a
> leaf node can be found and popped out. IOW, a given node in the tree
> can be visited multiple times before the whole operation is done. So
> it is not very efficient and the code can be hard to read.
> 
> With the introduction of cgroup_rstat_updated_list() to build a list
> of cgroups to be flushed first before any flushing operation is being
> done, we can optimize the way the updated tree nodes are being popped
> by pushing the parents first to the tail end of the list before their
> children. In this way, most updated tree nodes will be visited only
> once with the exception of the subtree root as we still need to go
> back to its parent and popped it out of its updated_children list.
> This also makes the code easier to read.
> 
> Signed-off-by: Waiman Long <longman@redhat.com>

Applied to cgroup/for-6.8 with a small comment edit.

...
> + * Iteratively traverse down the cgroup_rstat_cpu updated tree level by
> + * level and push all the parents first before their next level children
> + * into a singly linked list built from the tail backward like "pushing"
> + * cgroups into a stack. The parent is by the caller.

I found the last sentence a bit difficult to understand and changed it to
"The root is pushed by the caller." That's what you meant, right?

Thanks.

-- 
tejun
