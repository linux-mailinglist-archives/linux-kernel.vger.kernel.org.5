Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A05C37E35D1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 08:23:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233708AbjKGHXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 02:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbjKGHXp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 02:23:45 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E7910DA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 23:23:41 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-d9c66e70ebdso5447406276.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 23:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699341820; x=1699946620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OWNGndg7wx7UsmLs5D+Rq7iYTC+ge2DYU9RXrsS94No=;
        b=aER4jRTvNq1DiEPODWXkjaHRDaYlsm/IbQsKYfxeD8SQJ/74Lyd8VvZkSRx3BN4VX1
         ME/yDikGKqE7Co5rMVu+6krJNdqAuXm9CBZssKsWnnIRsPs+ieranJZee5cuuiWpu9B+
         VRKR3bIdF4sXYRgjhnyUFKFEhtZHZdidJtXtI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699341820; x=1699946620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWNGndg7wx7UsmLs5D+Rq7iYTC+ge2DYU9RXrsS94No=;
        b=cM9qaTdmTYsSn8NcWjGRQWB3/WEwYDtOzNw1ZTbyYwILB3jnJdB2XCo7q/tHRqI0GC
         LbHsVnZ4vjxifq82aBOFpYM4RmlEB0HJUxBsgKZx057PZNO6sNvKHxmyYdjjtl9G5SuV
         s3hYNkjXq+bZvEcXAzVDGvVWH3RuZzCmTdUJucbneUslntZuUM3DpjnB4x3BK3OlnRqg
         03KYiC5Kt1t9gHe+NZn05/5/KwP5dO3kwRZMIX5JQKmpjtUXQEWbTwPtfi5WWhft1/ME
         aMPjH8nnrVW/ufzdMuqgviPwOxWNlC2joE3Z4w7AXS44oN8U8usSpLrEwmMS0h3DsyEl
         Xamw==
X-Gm-Message-State: AOJu0YwzRGg5mQlhngXkeTz0u2CbUnk96ZEjCfTF0TxDyVA0JKQCpybv
        KKgyCEYNjugkXSVtMkmRpjouyg==
X-Google-Smtp-Source: AGHT+IEF1P8WPg9mrCIYC35ojAXg98l7Ku77fGg3/ZA9CByuTMWybwPkdQXraU0BM0N0EwyTIrFmpQ==
X-Received: by 2002:a25:f828:0:b0:d9a:3d72:bfab with SMTP id u40-20020a25f828000000b00d9a3d72bfabmr27321209ybd.40.1699341820257;
        Mon, 06 Nov 2023 23:23:40 -0800 (PST)
Received: from google.com ([2401:fa00:8f:203:7d66:31e7:94a6:e6a9])
        by smtp.gmail.com with ESMTPSA id k125-20020a632483000000b005bd3f34b10dsm825837pgk.24.2023.11.06.23.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Nov 2023 23:23:39 -0800 (PST)
Date:   Tue, 7 Nov 2023 16:23:35 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Vasily Averin <vasily.averin@linux.dev>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org
Subject: Re: zram: zram_free_page calls in zram_meta_free
Message-ID: <20231107072335.GA11577@google.com>
References: <ebd87e1e-f941-498a-870e-15743ca3fb1f@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebd87e1e-f941-498a-870e-15743ca3fb1f@linux.dev>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/11/06 23:42), Vasily Averin wrote:
> The only place where content of zram entry is accessed and even changed without taken zran lock is
> zram_free_page() calls from zram_meta_free().
> 
> It does not look like problem because zram should not have any users at this point,
> however I still do not understand why this is required?

It's simply pointless. Reset is performed under write init_lock,
which is an upper level per-device lock.
