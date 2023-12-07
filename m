Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040608092F2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443928AbjLGVEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 16:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGVEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 16:04:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9AE01713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 13:04:27 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id ca18e2360f4ac-7b7085f4626so2244539f.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 13:04:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1701983067; x=1702587867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tXvEzGNamUbqRrEd+8gPXXWIOewwxYDCIMTlohmAGFI=;
        b=QoRiMK/Z9M/7bpN7wxJeH9Ytn/rFh9dfmJgdszH4KaB0TTvLJSTxXTkOisNZgsyGWG
         dkIadtkDAkS4b9TZfSm45P5Z7AMva6+YYUeqTeb1VvehYUkU6A4/zbB9bwQUqGUWOAVj
         o8o7THEjtHTFqUeWe29SdFzEvuoPrEGT3wVafZ08RT5KpFO79TSFLQgher4E8KlS40YZ
         MpqSEFg0qIW80NWGPHasXaJdP9/PNbLKyj2CgQFZGRKXV3bpbqZiOB/8YiamKAsQRXy9
         Bp/f6M8S6bFuXSz8FhApnN3yaPzIc1Ng6BrVPTJlsfk9/pdvU5Bg8R6aKzPaABakFv0A
         gmvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701983067; x=1702587867;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tXvEzGNamUbqRrEd+8gPXXWIOewwxYDCIMTlohmAGFI=;
        b=SDrgyeEHGCdghkLQ3R7wI8K7l/YkYTU0ZS0qjJFK85VZC0hTZR5lDDl3OSjZ//E/nC
         L97z5tCSBFvN6zSqfeq0A8KQ9geFxt5Hd23RoxyaQa1bcNMlGuXl44Mj8SSJpr78ZBpe
         8J1Nrn8fM8g/vd1xLRPSldNBmC7yT+jqciIUYoM0lVUIpzZKoJkMkCo5AjlHufvgWR7O
         /CzFFa1RTUOpBEctxVh+3Lc/Jjgxm1GWoyEOjJxzR6jWUSUl9gZiHOaAHgDqpQUBIQLr
         RQqCf9oQuIaKY4fY0+q7rQl4sp4lE0PBJjyZbjDrE3HrjHZBxGFmCAG6poa/oEcE375I
         B/0A==
X-Gm-Message-State: AOJu0Yw6m3pA2gBOAsgMes4O+TS88naQOqE5ofsuJgsUsVawKebrpoBM
        Gqm2weD3UknqQf/GFFvkSbUBUA==
X-Google-Smtp-Source: AGHT+IHD6Hl71ge/A3HXgZbYEah2+7DDoF0+51S3+Ha7PvHo1MdC6v1kljCPHJ00TvAeoRdBNPUd1g==
X-Received: by 2002:a6b:f105:0:b0:7b6:fb5d:fe4d with SMTP id e5-20020a6bf105000000b007b6fb5dfe4dmr2666390iog.2.1701983067233;
        Thu, 07 Dec 2023 13:04:27 -0800 (PST)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id f10-20020a056638118a00b0043a1b74a0e3sm115951jas.90.2023.12.07.13.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 13:04:26 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Hugh Dickins <hughd@google.com>, linux-mm@kvack.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <20230814144100.596749-1-willy@infradead.org>
References: <20230814144100.596749-1-willy@infradead.org>
Subject: Re: [PATCH] block: Remove special-casing of compound pages
Message-Id: <170198306635.1954272.10907610290128291539.b4-ty@kernel.dk>
Date:   Thu, 07 Dec 2023 14:04:26 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-7edf1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Aug 2023 15:41:00 +0100, Matthew Wilcox (Oracle) wrote:
> The special casing was originally added in pre-git history; reproducing
> the commit log here:
> 
> > commit a318a92567d77
> > Author: Andrew Morton <akpm@osdl.org>
> > Date:   Sun Sep 21 01:42:22 2003 -0700
> >
> >     [PATCH] Speed up direct-io hugetlbpage handling
> >
> >     This patch short-circuits all the direct-io page dirtying logic for
> >     higher-order pages.  Without this, we pointlessly bounce BIOs up to
> >     keventd all the time.
> 
> [...]

Applied, thanks!

[1/1] block: Remove special-casing of compound pages
      commit: 1b151e2435fc3a9b10c8946c6aebe9f3e1938c55

Best regards,
-- 
Jens Axboe



