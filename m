Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FD1B7C7AAF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 01:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjJLX7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 19:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJLX7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 19:59:50 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0905A9D
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:59:49 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-53df747cfe5so2850805a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 Oct 2023 16:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1697155187; x=1697759987; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e9GaXfWsi/7WQYTgQPNsZbyXpgIytjUO3rUQd1WDOEU=;
        b=RimZll2QMAF4B2/1JWRGopbD1e+BffaJj9U+k4HrKl/HTyCGsN5S1jsSvBFOK5WRn9
         PEeWSlrbaGdcQZh3T934VO8+ig9jd/bHzEfR8nccTjlkiFfnV7qqZGy4EYOwvFv18inB
         9hiyyDxKHEUGKtPWg9TNBqlFZGL67jTj11lLhw9cNeKwATgI1e8NYHvaWfKrC0/E1lqW
         3C4nQMcbfq1zpIH0NtZBNzJGlyYTAIv/jWmNxFxitVodjOiH8QvMi5pQvvLUOesb4Knf
         jwlOwRAPBLSznIiigG57y9IPTor90Tu+FXP8Cwiny1KnBdmcsyIs9WhQg4Eyc15zOwjO
         YG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697155187; x=1697759987;
        h=to:subject:message-id:date:from:in-reply-to:references:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e9GaXfWsi/7WQYTgQPNsZbyXpgIytjUO3rUQd1WDOEU=;
        b=kYtke2hwlEu2VuQmAO9QGOzL6FCiqlniSb+zQJYNTbJa0gi3bkBHktwyRWb4mcEFQw
         dIo2tufJAOmwBTkUY7AFfuM75gcMT5Yh7+sEu6YKAAkn1R1Oa/rtQYsYNmXXfan+1bAN
         vQVBw3z0MA87tt0VO4z7/FRX2cuY6rRPGbMME5VUwtRTDdCL1LtpYsY77KiXUvF1Q4gT
         JEcNtqL1/tJVOFLtz1P8QNMMdaxtKWexU43urZyN7zbApIkrer5EAHtqt9Vdig41ZdHW
         Co2bfnUfn9RLIjcB8aUR/FytH6BqZ9ilCddvbv4KAFtLiVAI79JwmQ8P0P57LvkJcFJ9
         QF5g==
X-Gm-Message-State: AOJu0Yz/BFG24705wCy8DN6tZPkq0Tng+WUeyHczErJDMYqR9BkCMtg1
        mGO6eLwgBLwzs5rm1xeMag8Siwvws0ihqNXXijVw+oldw69p2d06
X-Google-Smtp-Source: AGHT+IFgaW9usWLmJAqjC3CusVl+MVQdOQ9L4tW2bP8OQuWigR67vaEsFkIwz3DlWZIGr7FjZXm8/Uob6GsDgZ0gq1k=
X-Received: by 2002:a05:6402:27c9:b0:53d:993b:6b68 with SMTP id
 c9-20020a05640227c900b0053d993b6b68mr9297967ede.36.1697155187466; Thu, 12 Oct
 2023 16:59:47 -0700 (PDT)
MIME-Version: 1.0
References: <20231011213919.52267-1-sconnor@purestorage.com> <ZShUmLU3X5QMiWQH@google.com>
In-Reply-To: <ZShUmLU3X5QMiWQH@google.com>
From:   Seamus Connor <sconnor@purestorage.com>
Date:   Thu, 12 Oct 2023 16:59:34 -0700
Message-ID: <CAB5MrP5VqmWpnS9O6vQpFWp254rpu6rx9Ki85fKZDUBb586WOQ@mail.gmail.com>
Subject: Re: [PATCH] [WIP] configfs: improve item creation performance
To:     Seamus Connor <sconnor@purestorage.com>,
        Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> This is subtle.  Your patch description of course describes why we are
> partitioning the items and attributes, but that will get lost into the
> memory hole very quickly.  Please add a comment.
>

Will do. And thanks for taking a look at the patch.

> Plus, aren't the pinned/not-pinned checks redundant?  Can't we avoid the
> extra conditional?
>
>
> ```
>         spin_lock(&configfs_dirent_lock);
>         list_for_each_entry(sd, &parent_sd->s_children, s_sibling) {
> -               if ((sd->s_type & CONFIGFS_NOT_PINNED) &&
> -                   !strcmp(configfs_get_name(sd), dentry->d_name.name)) {

Unfortunately they are not. CONFIGFS_IS_PINNED and CONFIGFS_NOT_PINNED
are asymmetrical. There is the readdir cursor (s_type == 0) that might
be anywhere in the list and should not be treated as a pinned item,
but should also not be treated as an unpinned attribute.

Is there any testing that you could recommend for this change? So far
I've gone through testing of our internal components that depend on
configfs, but I haven't done anything targeted.

Thanks,
Seamus
