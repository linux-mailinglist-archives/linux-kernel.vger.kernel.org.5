Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24C075A7A0
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 09:18:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbjGTHSq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 03:18:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjGTHSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 03:18:34 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65D41998
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:18:31 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1b9c5e07c1bso3292565ad.2
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 00:18:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689837511; x=1690442311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9GN3HyftBoKSOmVAm+Fkdt+TXRyhURYP74WueJdYkM=;
        b=EKtxTElXQnD+NjS1xmtvsURoPkam7yZWt0UiQSlGyx6eFpFjZTHxNDUHMKWNGRPvkD
         yfdfHIy9HvWS4HQZlH5yjir1JAr2tXphEeGfelSVPKeQSpOZuwlg+ubowqZhljoKyPF/
         wct7IeputY2hV0GT9i83fiMcnNoyUWXmZZIlo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689837511; x=1690442311;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9GN3HyftBoKSOmVAm+Fkdt+TXRyhURYP74WueJdYkM=;
        b=Fp5HWjkzxRKSTjec7C17RdmZtloavQUWdl8fhOsN0f5SWrBu7HRysFm7dHxiAL9TCK
         wH/U2ygmtLpSCa0RAksfbJ6rs1vBIBP0/3M+yTRPfBkV7aHVogTJT79oNi0/8GkD1QTU
         ppP6jEOf+CwzuuPL5nC8jMc5Jg1PMDyGKWyOHZPIN6xIK/myMXpM4jc7L1DoqNOppG+N
         0NOB5QypWSXqH7td2ZCs9BGwz+25joAzz6OLipaOdomezvCUkXWT7eetiOxMjRAa3ttO
         UtUcPkBYGQa9goFGOPp3OfqEsKRZ+Uet0ChfGFKB84qm3j+lQZNh4hVEsy8JGavM44AS
         w9iQ==
X-Gm-Message-State: ABy/qLZka14ZU461QeKK0lNb2GnqWu2CtIc0xVqlc/C16jBrK9bkmeFE
        F2i1lacEGAmtNkTfS2c8BnnhVQ==
X-Google-Smtp-Source: APBJJlHyFmZzX8iCbjVkSdMc+qY+0UhLZLbLGj1qifn2QYea//eu23FJGgw1q4e6QSAfQPTOW1B2ew==
X-Received: by 2002:a17:902:ea94:b0:1b8:903d:8dd0 with SMTP id x20-20020a170902ea9400b001b8903d8dd0mr1472952plb.32.1689837511198;
        Thu, 20 Jul 2023 00:18:31 -0700 (PDT)
Received: from google.com ([2401:fa00:8f:203:648f:4ec7:23d9:d855])
        by smtp.gmail.com with ESMTPSA id ba9-20020a170902720900b001b890009634sm509533plb.139.2023.07.20.00.18.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 00:18:30 -0700 (PDT)
Date:   Thu, 20 Jul 2023 16:18:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Matthew Wilcox <willy@infradead.org>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [RFC PATCH v2 00/21] mm/zsmalloc: Split zsdesc from struct page
Message-ID: <20230720071826.GE955071@google.com>
References: <20230713042037.980211-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713042037.980211-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/13 13:20), Hyeonggon Yoo wrote:
> The purpose of this series is to define own memory descriptor for zsmalloc,
> instead of re-using various fields of struct page. This is a part of the
> effort to reduce the size of struct page to unsigned long and enable
> dynamic allocation of memory descriptors.
> 
> While [1] outlines this ultimate objective, the current use of struct page
> is highly dependent on its definition, making it challenging to separately
> allocate memory descriptors.

I glanced through the series and it all looks pretty straight forward to
me. I'll have a closer look. And we definitely need Minchan to ACK it.

> Therefore, this series introduces new descriptor for zsmalloc, called
> zsdesc. It overlays struct page for now, but will eventually be allocated
> independently in the future.

So I don't expect zsmalloc memory usage increase. On one hand for each
physical page that zspage consists of we will allocate zsdesc (extra bytes),
but at the same time struct page gets slimmer. So we should be even, or
am I wrong?
