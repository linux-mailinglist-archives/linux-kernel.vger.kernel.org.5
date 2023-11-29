Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8357FCDD0
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 05:19:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376893AbjK2ETa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 23:19:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231288AbjK2ET1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 23:19:27 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B856E1AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:19:31 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5c19a328797so4512275a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 20:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701231571; x=1701836371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8sF8sEE2ZTc9ObiMO1OzkZ6Z6YbCekFkAXIm79+6W8w=;
        b=B9HAq6lN0gqBdKxxHzl+TumZYBizeRB4Y+R95Z4D9KVI0E93DusuRsTkn6MqqXJtMS
         vQHlMKtoJ6vMvgoAvxPlrJOwDbETcHzxkqmLpPLG7YMc4JUBjxylAjr4/440smXLwcK1
         90fdEhqowCCAqWxaikGJMxYrhyxEOk9gF6tL4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701231571; x=1701836371;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8sF8sEE2ZTc9ObiMO1OzkZ6Z6YbCekFkAXIm79+6W8w=;
        b=NCC93SZUiFdeZEY6B+cXd14vQJ+VjHrA98E+lXUOB1JKPXf66DonUDg0/Q7p9NUM6m
         IyHpom4PxGkRZn4WzLzbPE5dk2T3gNItNKIptnzseHW3fIchaqvUEjMyM2OC0NJf7wlN
         eszdvhYRIPyJr1x2mqWzg76lYaZ6puZUtoPBE3c5h9wTzt8+EWtQ8ePcoe2fxbEC6OG1
         VKJby9Qn8GyMER40+BTSLYzDn0F1Wd3YPG9LnneH94YV0ngkapN8YAbpM09ax9744rAa
         k2N66eAgh5eO3/CCA0zSckxYvICsg9JV21pyS4nkH7nP2zsTEhcy4HywKDlZ3l+vtZEe
         BGtQ==
X-Gm-Message-State: AOJu0YyaUsqZOOonaykgVOkXYKhMcQE6jGzLOWXYrrtzcWeVwrdazqP6
        BitUnaWw1xhlmZL/ZW4SvjkMLw==
X-Google-Smtp-Source: AGHT+IGVsQS2WwOQK7A6U+gxRY2q9is6X8IKCeex3/lpav2fyxkdHoMlkRmgWIkOH2QxX/hvMIDhKA==
X-Received: by 2002:a05:6a21:7886:b0:17f:d42e:202c with SMTP id bf6-20020a056a21788600b0017fd42e202cmr19782814pzc.49.1701231571187;
        Tue, 28 Nov 2023 20:19:31 -0800 (PST)
Received: from google.com (KD124209171220.ppp-bb.dion.ne.jp. [124.209.171.220])
        by smtp.gmail.com with ESMTPSA id q2-20020a170902edc200b001cfb573674fsm7337050plk.30.2023.11.28.20.19.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 20:19:30 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:19:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: Use kmap_local_page()
Message-ID: <20231129041926.GC6525@google.com>
References: <20231128083845.848008-1-senozhatsky@chromium.org>
 <ZWZ_W3tkw9tBqdvE@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWZ_W3tkw9tBqdvE@google.com>
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/28 16:01), Minchan Kim wrote:
> On Tue, Nov 28, 2023 at 05:22:07PM +0900, Sergey Senozhatsky wrote:
> > Use kmap_local_page() instead of kmap_atomic() which has been
> > deprecated.
> > 
> > Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Acked-by: Minchan Kim <minchan@kernel.org>

Thanks.

> I didn't know that the kmap_atomic was deprecated.

Me neither, figured it out recently (via checkpatch warning).
https://lore.kernel.org/all/20220813220034.806698-1-ira.weiny@intel.com/

We need to take a look at zsmalloc, the conversion can be a little more
difficult than zram's.
