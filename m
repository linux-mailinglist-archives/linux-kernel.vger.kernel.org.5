Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A2B75B9BF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 23:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230253AbjGTVsC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 17:48:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjGTVsB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 17:48:01 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 860B71719
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:48:00 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-52cb8e5e9f5so926948a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 14:48:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689889680; x=1690494480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=twEvmkPU0mxcvyzF5PqdNe8AyZ4NwFNYaQ1CTqmcu+E=;
        b=No5VDdWPDUvfW7+NJOwgoJQDfOD+IhbiqUf5oJwIfT5+B0/WTewqNZPzRdC+JgE/lP
         kjJjektXdbhx3MC2con9lxGY6jtKJu4fUqeSH3TvDBcAMLaRTxOfTxMfNZ8F4mxf+mDR
         KAea+ZtWfUbezLnbGHamUG+Wo9A/RULPP2LYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689889680; x=1690494480;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twEvmkPU0mxcvyzF5PqdNe8AyZ4NwFNYaQ1CTqmcu+E=;
        b=C1xhJcBk7xVcSqm6YwPoZKKBDnXgaXgX8zB/W0d7Ljk1kUtO5lf8AGkcKCgXe0v5vZ
         n8/x040p0gAd5lcDlqLM4/hDxOwoIV8aBiqKfn1yE+sexwVm9i01hEr/7E15uc3l96JC
         g7Gknnmy0TNBtRG6QJSRj3FV2Qexn/rRCxj2ZNwj4scfx7d2YMrtZIjnS1vmViK1ZLiZ
         tC3jNe5bj4UAj0bXhO/4DOq6uLrWei5I0vQ6mqIdR6SLy8c0NhaczuVTqZt5XkzlJkHM
         7631o5jKZUdPacioT4AbcXzJA7w0/KbFE4YZ4W+Ogbo8IegCXjyZrrziKoMcAbINUKuR
         XjZw==
X-Gm-Message-State: ABy/qLYNsUO2upicgQkdRSQ0trD3LVgdu8wG2L1KAmk5pIf+1aWzRCKC
        WkS6joGdHFy0mu1D10vLDOcw3g==
X-Google-Smtp-Source: APBJJlGgt8Uu256GC15jac2zmoopBLCBf3En87S/BmxQdJUTUmMg3SvdGETr/NVT/gJlxKlMTrezCw==
X-Received: by 2002:a17:90b:118e:b0:262:fe4b:b45 with SMTP id gk14-20020a17090b118e00b00262fe4b0b45mr171679pjb.19.1689889680021;
        Thu, 20 Jul 2023 14:48:00 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id lc14-20020a17090b158e00b002612150d958sm3082786pjb.16.2023.07.20.14.47.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 14:47:59 -0700 (PDT)
Date:   Fri, 21 Jul 2023 06:47:55 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Ricardo Ribalda <ribalda@chromium.org>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        stable@kernel.org, Zubin Mithra <zsm@chromium.org>
Subject: Re: [PATCH v2] media: uvcvideo: Fix OOB read
Message-ID: <20230720214755.GE57770@google.com>
References: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717-uvc-oob-v2-1-c7745a8d5847@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/20 17:46), Ricardo Ribalda wrote:
> 
> If the index provided by the user is bigger than the mask size, we might do an
> out of bound read.
> 
> CC: stable@kernel.org
> Fixes: 40140eda661e ("media: uvcvideo: Implement mask for V4L2_CTRL_TYPE_MENU")
> Reported-by: Zubin Mithra <zsm@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
