Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D02FF75B5D0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 19:42:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbjGTRmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 13:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjGTRmo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 13:42:44 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB1E10FC
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:42:42 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-5774335bb2aso12290637b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689874962; x=1690479762;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iw9BdfYVQgyQBoPjCHW6EH0Qre4wR7dPFluL4RxQ1xw=;
        b=2jVkEC5ZNZt3+ope3Zw+2+jPrU866WnQrAjV/TY8OZQje6pWl+saEYBKFNuccW8rnc
         r1/Yk6BLvlY9X38GX9Ui4/7Ip9tU7glLyYJNV//fOkmUQtXU/BfPzrDQSe1ygShGoKCT
         bj3KUBZq5I6PvIBd6Lbaq/dNEUq4uIFfAIKLUlb6GEijoqQWK+90wfDQ9D9bmgMa44bu
         qBXAg2LytvcKT75M6xVOcWs86NPY6FMtGs4KNnp9DZ0nmg2yfnrYE+0Jzi6Xm2Cuy1ra
         GrJXDTydOsaN0vK7UoAd/Ribhl+KIsW8U6dWgngiHtuPVlZdZOmPhEryVjywyuNYhO7j
         Q8Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689874962; x=1690479762;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iw9BdfYVQgyQBoPjCHW6EH0Qre4wR7dPFluL4RxQ1xw=;
        b=Ej2g1kyIQgOEywzTJL3VuKzgtvNDlXqsw5oQ2kYc9UElXtlP/iwDJjgTTo9oTYWrtW
         DWC57e1HbZfM4vuoBSPDoMZEsB+osxIRPCFrjOmzAQecypV2xhgDHTtge/PczDxlGyJ6
         f0W8MGK58LqLevAqPYrhfssQMGN5o/GSTQBmR6iH9ZZMBYXN/S2McHD3YXtuGwlV128o
         vjYEX09Ilaa1oXmm0z2Y1Wkib+GtwyZXVGFoLFf5WFK9BlkbDLDRmnhd3nCQsG+/Ko4p
         Qe3BGOA/8A7AdkHhmp8Nw0YVjnoFzvDfllBbtXLwUVMQcbEhvfwCslC14XlHrTaWGpuV
         S0fg==
X-Gm-Message-State: ABy/qLafs5LqU1wHpI2xgOpbtOFR3e0iZ+8+omlABZCT8DrAnDLS1cuw
        TGFHFeiDBelbJaouZvLI+XJhLQ==
X-Google-Smtp-Source: APBJJlHLnaAjmEmO9ugYaut2lIUnqUML2b054gjF+qFo1fkVwZDIE15Oa8XWzPDep8MQf4t2wvwsmg==
X-Received: by 2002:a0d:ef07:0:b0:56d:2c60:2f84 with SMTP id y7-20020a0def07000000b0056d2c602f84mr20144883ywe.46.1689874961710;
        Thu, 20 Jul 2023 10:42:41 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id b7-20020a816707000000b0057a54615bf4sm340500ywc.55.2023.07.20.10.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 10:42:41 -0700 (PDT)
Date:   Thu, 20 Jul 2023 10:42:32 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To:     Oleksandr Tymoshenko <ovt@google.com>
cc:     Hugh Dickins <hughd@google.com>, Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] shmem: add support for user extended attributes
In-Reply-To: <CACGj0CjD3NHumhRkDYiWh5YYbjcwh5sw_HqdoeafdsYxABUfZA@mail.gmail.com>
Message-ID: <cfb2c75c-fbf4-1eb6-bba9-c3c13735f60@google.com>
References: <20230720065430.2178136-1-ovt@google.com> <9b8d38f0-fd22-3f98-d070-16baf976ecb5@google.com> <CACGj0CjD3NHumhRkDYiWh5YYbjcwh5sw_HqdoeafdsYxABUfZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jul 2023, Oleksandr Tymoshenko wrote:

> Hi Hugh,
> 
> Could you share that patch?

When I'm ready to, of course.

Hugh
