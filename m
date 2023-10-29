Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43F817DAD70
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Oct 2023 18:09:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230219AbjJ2RJj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Oct 2023 13:09:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230229AbjJ2RJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Oct 2023 13:09:37 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D3C1C1;
        Sun, 29 Oct 2023 10:09:32 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6be0277c05bso3183695b3a.0;
        Sun, 29 Oct 2023 10:09:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698599371; x=1699204171; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=guERSytxagybtbBbeomtKql3F3b0h01rxt6mXX5cAlI=;
        b=W387qXk2Nluaym0irzA/VSUrRwXuf8Fpcm+psiGOfBlP0JnRxvSRoJa5AK1fIvfopb
         +Xa5dfJX0ZQ5LTneXp5vsocseFKiLz8I7V/iWyYkgbxXIGuoUpyASLZRNaC/F/WnSjct
         dWh/fsG9O31fr0cZTS44Czu41jI+eZOBPCFfvLQVJ0iTb/tZ/NaX66FgDRRmEVfCLGO5
         XBSS39+FeDzl7pS/yTK0ry8/EgIek/MmJ1pRftqkwKSVQk12R40X4i7FdXOR1yALbe2C
         MnQ7RlhB9K6hkN7/f7SD81295kosO9mAqo6i2nXohNnTOTb5yjF2yv+jWKpcI73RUwcf
         5bmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698599371; x=1699204171;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=guERSytxagybtbBbeomtKql3F3b0h01rxt6mXX5cAlI=;
        b=T3HfvrVmBOuy8UTwdaILjLwjQBWBUf1TW5luq5CQDcF0lqqfJkmr/KOSJvBaSMGxmX
         9pIqM9y7WgZF8Zjruvj0+vIFYOlvXZ0vRv/cNCPxuzC3kAdGZmP2NZQMeggm4T6Um3PQ
         cqWXGqDtBgm5CknDCNKieD22UuknBNdRgSv1x1BAIAGyLQlDtcWi7yQBP4UaGB5oIYP4
         i6szh2yOWpQ0gPwq2/ivJ8Jt7wIt8t3wrDfRx8BegkzJcBEyfzTKyqgUwWp9qBWYev60
         o8ILjStJ9MY/EF3uKzmCFRf5+TojH3jgVx0APfCjLKBN8H6KqwdCaF+FL+1mUkd5CXjq
         I7rg==
X-Gm-Message-State: AOJu0YyTcFnVOFzp2FVLFwjyS9YqQiNVyf/Aoy8R0/xvrl1egeqGOZ4w
        uEHFeCJuC+77YtdVIpHREbU=
X-Google-Smtp-Source: AGHT+IH88+Mk59vQGJ5nKQIqEa3n4i8/9BovsucMsW204LbWrviTtnK4UGzgWAjOG+hgHa0DmvOvRQ==
X-Received: by 2002:a05:6a21:a105:b0:14c:a53c:498e with SMTP id aq5-20020a056a21a10500b0014ca53c498emr6437194pzc.42.1698599371502;
        Sun, 29 Oct 2023 10:09:31 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c11-20020a170902d48b00b001c613b4aa33sm4714035plg.287.2023.10.29.10.09.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Oct 2023 10:09:31 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 29 Oct 2023 10:09:30 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Chuyi Zhou <zhouchuyi@bytedance.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@kernel.org, tj@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH bpf-next v6 2/8] bpf: Introduce css_task
 open-coded iterator kfuncs
Message-ID: <bf2add1f-a9e4-46ac-b1ac-5b6ad9f0ed86@roeck-us.net>
References: <20231018061746.111364-1-zhouchuyi@bytedance.com>
 <20231018061746.111364-3-zhouchuyi@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231018061746.111364-3-zhouchuyi@bytedance.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 02:17:40PM +0800, Chuyi Zhou wrote:
> This patch adds kfuncs bpf_iter_css_task_{new,next,destroy} which allow
> creation and manipulation of struct bpf_iter_css_task in open-coded
> iterator style. These kfuncs actually wrapps css_task_iter_{start,next,
> end}. BPF programs can use these kfuncs through bpf_for_each macro for
> iteration of all tasks under a css.
> 
> css_task_iter_*() would try to get the global spin-lock *css_set_lock*, so
> the bpf side has to be careful in where it allows to use this iter.
> Currently we only allow it in bpf_lsm and bpf iter-s.
> 
> Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
> Acked-by: Tejun Heo <tj@kernel.org>

With this patch in linux-next:

Building m68k:defconfig ... failed
--------------
Error log:
kernel/bpf/task_iter.c: In function 'bpf_iter_css_task_new':
kernel/bpf/task_iter.c:917:14: error: 'CSS_TASK_ITER_PROCS' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:
      |              ^~~~~~~~~~~~~~~~~~~
kernel/bpf/task_iter.c:917:14: note: each undeclared identifier is reported only once for each function it appears in
kernel/bpf/task_iter.c:917:36: error: 'CSS_TASK_ITER_THREADED' undeclared (first use in this function)
  917 |         case CSS_TASK_ITER_PROCS | CSS_TASK_ITER_THREADED:

My apologies for the noise if this has already been reported and/or fixed.

Guenter
