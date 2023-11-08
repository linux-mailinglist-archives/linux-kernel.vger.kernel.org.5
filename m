Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECBF7E4F16
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 03:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343681AbjKHCst (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 21:48:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjKHCsr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 21:48:47 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BAF710EC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 18:48:45 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6b44befac59so256606b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 18:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699411725; x=1700016525; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kaj+RCWZQIA5NHy/kpFVQnZTMJJvFNtoHfEeUobZeJg=;
        b=bFAee/QewJokti4wPCJZKiXDtL//EOQGEc79cfOwnUA3+F/l6z6rl3tASfBSGG8pki
         LikX+TBuKa1yk0q3uCEnI2zoiXo3JkvYaLvzpZLoHWvlu1jjg6noQgAzYEIhjyIXW7BW
         r7ku+B/bk6aJfzUoTTCdL9V8tSJY1hRlfieFg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699411725; x=1700016525;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kaj+RCWZQIA5NHy/kpFVQnZTMJJvFNtoHfEeUobZeJg=;
        b=c/x5iT/fvYR6CvbkWiiQw+x3VI7oYdjKiwPkCG1SjKkKrLqItGMsTimW9+sGwuOTa8
         RxXfXUXGHh5bETLlySqir5fJV9ktPblzCyZOJzn0kVODxNJGi7gz8NEGMc3nBsBlWLcx
         /eYKqlAe/W/b5lPHMO7N8cirSf7wlqtT1znjsNNvNEKzKeXp3M6gyFMo9sea42BmEo1p
         DvyxKxNOt6CKS0aF2GG+YGnI5j/pIFnX6ZQVOR0yXiDGisKuDMwCp9/lSzdi5J54sV5f
         zkcyjzeDBKgvZXpemP7TyaUWfXdvCmb25d+z6ifEzxMezAn3V1andJfs0Ybay3JRfi2q
         WtZQ==
X-Gm-Message-State: AOJu0YxzL1eRckqesZ1BxPrU9LrBxiGR/MNV6sE5j0ZvL5QYxfZgS7sk
        sYI3Wtm+wZV1RF6yJ3RQcJR5Sg==
X-Google-Smtp-Source: AGHT+IGsEjAXCRkP53e88ZDou4Yty+jmDxQfN8ot4iSASxlV9onWjmcrR7CMITv7Yplj3OO+ofqprg==
X-Received: by 2002:a05:6a21:7882:b0:155:1710:664a with SMTP id bf2-20020a056a21788200b001551710664amr963743pzc.18.1699411724883;
        Tue, 07 Nov 2023 18:48:44 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:2fe:d436:c346:6fcf])
        by smtp.gmail.com with ESMTPSA id du4-20020a056a002b4400b00694ebe2b0d4sm7857734pfb.191.2023.11.07.18.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 18:48:43 -0800 (PST)
Date:   Wed, 8 Nov 2023 11:48:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: [PATCH] zram: extra zram_get_element call in
 zram_read_from_zspool()
Message-ID: <20231108024839.GF11577@google.com>
References: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
 <f30438ab-01e4-4847-a72d-5a4107d7ba46@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f30438ab-01e4-4847-a72d-5a4107d7ba46@linux.dev>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/06 23:03), Vasily Averin wrote:
> On 11/6/23 22:55, Vasily Averin wrote:
> > 'element' and 'handle' are union in struct zram_table_entry.
> 
> struct zram_table_entry {
>         union {
>                 unsigned long handle;
>                 unsigned long element;
>         };
> 
> I do not understand the sense of this union.
> From my POV it just makes it harder to check the code because an reviewer doesn't
> expect that the zram element can't be used together.
> Can I remove this union at all and replace zram_get/set_element calls by zram_get/set_handle instead?

I guess it sort of helps API-wise to distinguish zram_handle (allocated
zsmalloc object handle) and zram_element (same-filled entry).

I'll leave it to Minchan to decide.
