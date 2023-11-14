Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3079F7EAB65
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbjKNIOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 03:14:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNIOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 03:14:24 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A029F181
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:14:21 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id 46e09a7af769-6d2de704f53so3295640a34.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699949661; x=1700554461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xq+h22Du6K4PHXdd1ehFCWVIecItR5XW1qYXi+x54PM=;
        b=RKZje8M4yGazht6XiWxWHYdD5zhrHiGHB8R5vGOoYOOLXmrYmnaBZVn6t16NP/Ybcw
         LzPcXNGdNQ/zeAsa8rIgXYnfU8unvng3vazeZvWdMBRdvned+om9dD9n7wYXuLMo0Pef
         n06WsrdY0AM6oXrhMFOBhOgC5Pjh5THBkhj668pagbilB0ZSJIo3nr/tWnR4xklcVVd6
         3yTaE+40ThDU0ANrLtWgSMhg/eIxX24f9Hcq8aAGRUqrtv5VVCApGfGFHFsJLXBw94rh
         8mqBai474cDllIIvnETqLDAxuPtwkYnrG5tRAmI0qv6ZJh1/D/5llsYxocVcuL3XG4cj
         9zOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699949661; x=1700554461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xq+h22Du6K4PHXdd1ehFCWVIecItR5XW1qYXi+x54PM=;
        b=opc9Kq4x9ZEoaxsMMU2uanrO4i4nj4j+LAa5hkV+Tseo+IPE9yzltxKbh9vQCL98Dr
         Hh+0fotou9HprRmFa5b3ZPa3E7PTUSZhw3WtbcAwUgeegROyIrbQ6MeQJ8pHQqizTV2T
         h0aImKhlVTGEBA7sq+vBc9Gd4y1lxutf7ioMjwJdk+EsNA/+IpOEUU/CD56Nz5QcDG7e
         xa3g3K69P/dyuHexcfYhLZ1xTOmVBoXPuVfsMhAMfDqp+Vf5oil3YuN8GCXR9Dtz33Wy
         06VOHaosYspeFhwZAZylBnTIWfiJlJpXATNA4UbJ1UfKdJdynA7ljRkvOBE8jemMxHQk
         o2BQ==
X-Gm-Message-State: AOJu0YwHfun7oSaZOzM4TA2mVO4x+cex0RErC9AqUE/gX6qhb2/ZawVq
        xJ6ddbALP0aGYYJlXvbBEWbhyRleiYQ=
X-Google-Smtp-Source: AGHT+IFuYjPTrbIlkYEyByLU3gz4oaeNkop4RzP+HqBwdaL6S14P6vWRpZNXzgY7TUAmzhBiqksJog==
X-Received: by 2002:a05:6870:3051:b0:1ea:69f6:fe09 with SMTP id u17-20020a056870305100b001ea69f6fe09mr12230979oau.10.1699949660885;
        Tue, 14 Nov 2023 00:14:20 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id y15-20020a056a00190f00b006c624e8e7e8sm705281pfi.83.2023.11.14.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 00:14:20 -0800 (PST)
Date:   Tue, 14 Nov 2023 16:14:15 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     xiang@kernel.org, chao@kernel.org, linux-erofs@lists.ozlabs.org,
        huyue2@coolpad.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] erofs: fix NULL dereference of dif->bdev_handle in
 fscache mode
Message-ID: <20231114161415.00003d8e.zbestahu@gmail.com>
In-Reply-To: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
References: <20231114070704.23398-1-jefflexu@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Nov 2023 15:07:04 +0800
Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Avoid NULL dereference of dif->bdev_handle, as dif->bdev_handle is NULL
> in fscache mode.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000000
>  RIP: 0010:erofs_map_dev+0xbd/0x1c0
>  Call Trace:
>   <TASK>
>   erofs_fscache_data_read_slice+0xa7/0x340
>   erofs_fscache_data_read+0x11/0x30
>   erofs_fscache_readahead+0xd9/0x100
>   read_pages+0x47/0x1f0
>   page_cache_ra_order+0x1e5/0x270
>   filemap_get_pages+0xf2/0x5f0
>   filemap_read+0xb8/0x2e0
>   vfs_read+0x18d/0x2b0
>   ksys_read+0x53/0xd0
>   do_syscall_64+0x42/0xf0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> Reported-by: Yiqun Leng <yqleng@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7245
> Fixes: 49845720080d ("erofs: Convert to use bdev_open_by_path()")
> Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
