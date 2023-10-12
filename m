Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93A607C6FA1
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 15:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347295AbjJLNsY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 09:48:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347291AbjJLNsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 09:48:22 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E02C9
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:48:21 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5a08e5c7debso621781a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 06:48:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697118501; x=1697723301; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=T6LAtbmR8nPZulMVNVlGlT005qfp9ySsIt46rwUK2ts=;
        b=M8KcUlSD8MN0e/KgBYqpMJoyzPIn9dI5h46PIQm7Wg6NEWvujgC5pCdjiSTNE2epfD
         6aJzCthGwuMmScJCYNGhXeqhuD2o6WIw+DUyjwj4QpRQE3BRC1/ZHgXBmlyix3NEnQEF
         /9V1bjbu0Q7VWzEeDz0SdWl+wI4l5LeuhmXk1Dv/qZFxo44p05Q2Cnag3nfhN4g45Hkg
         WV/CM5Pb/GKvpk9JMLZaTv5mzv+Ri0Oxg/wLroRnj65b5Ajb85Owhjwzs89DjbMGGLT5
         KnXRpZtmq1Ed7Rl/W0DSXNXmlg3lRH2hLbbB1ciG3ZMvm/TRk1F00m0lUnQpdJ2WJvcY
         XbUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697118501; x=1697723301;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T6LAtbmR8nPZulMVNVlGlT005qfp9ySsIt46rwUK2ts=;
        b=YJ9z4LFACffdPNrMj05oWnPgUaju5O1EaOMA6AgD+7ia8mP6abnxfODP/yauVTFv2k
         en9Ceq3hgv+oOUgjQUmzoyjCEAmTVX+EyfOa+1taVQZbdSn2JCZJzJoYhj/v1xqvwH40
         m8uWB87ByPdYBeqYdZv0JMTjFjubZNh9X3t8pBuvV6pke6d0lYIZAf7m2COeZ8jgu+Lh
         0P/EPqjiRB69WnL0LSOKup7ZeFnf8N9JaCp5pUA6QN8IvCxsvZspDohh9zD1lEi9cX8X
         9KftTJDyw2fNebAMQuzwm3meSY7ybf1zGt9mrHyRTnLuA7OwwbaaLn94YqkNYkoeVQWN
         koUQ==
X-Gm-Message-State: AOJu0YwR9c04uugb6qyBXYGXxjrOr5dRcEU3dQpfAghXpmVZUJ1RFbTS
        6OyWvCtTgkEVJsH9hufJBB5VEwE5aEF5Bg==
X-Google-Smtp-Source: AGHT+IHI5jgd1c2oDlUjLraZPlJSkGAGErF45DQIm+sYXrCHbIRffp3LKnyIcwJ3misuhjuTpeOcKMFuqk/FfA==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a63:4e4d:0:b0:589:86ae:2107 with SMTP id
 o13-20020a634e4d000000b0058986ae2107mr330554pgl.9.1697118500654; Thu, 12 Oct
 2023 06:48:20 -0700 (PDT)
Date:   Thu, 12 Oct 2023 13:48:18 +0000
In-Reply-To: <20231010000929.450702-6-roman.gushchin@linux.dev>
Mime-Version: 1.0
References: <20231010000929.450702-1-roman.gushchin@linux.dev> <20231010000929.450702-6-roman.gushchin@linux.dev>
Message-ID: <20231012134818.737ack5hz76okmcy@google.com>
Subject: Re: [PATCH v2 5/5] percpu: scoped objcg protection
From:   Shakeel Butt <shakeelb@google.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Muchun Song <muchun.song@linux.dev>,
        Dennis Zhou <dennis@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 09, 2023 at 05:09:29PM -0700, Roman Gushchin wrote:
> Similar to slab and kmem, switch to a scope-based protection of the
> objcg pointer to avoid.
> 
> Signed-off-by: Roman Gushchin (Cruise) <roman.gushchin@linux.dev>

Acked-by: Shakeel Butt <shakeelb@google.com>
