Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020E67FCE5A
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 06:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376941AbjK2FjZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 00:39:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjK2FjX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 00:39:23 -0500
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 912B51AE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:39:29 -0800 (PST)
Received: by mail-oi1-x22d.google.com with SMTP id 5614622812f47-3b843b61d8aso3686251b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 21:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701236369; x=1701841169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odzHaB82SZdpybaH4ujfpl6ch16xiqGdapqSSbgzBkI=;
        b=QretI651Qf08cNQqngzC7X6bUaikX+PMnjGxcqAXOxIA6dJLaB7OicrNcG8FpEd8n7
         Szrm2AUdOhifL7g6JsbiFH09B+BOG5WBAYo23Yw+pJdSRjI63iKG5FGiyvrZEIi2NYhY
         t1xwcLuLm+lRoYD1jvtJOSFiBXMOKh/Ui7P02A0P7yOb2WvXFY4WrlvOghWJDeajkhpa
         6ZuljVPzUY9jSD3xp1PlurNHCjxmwmi6Vnn9YclV3ignftEHjl/0pMFvmAC+F3SvFdz+
         6Oh/jmwd0A22SVo2bWBeHgoSX4EiWZprLW7DjSuy6SrcjO1dFAz3nidggV6fT2JqhVbJ
         5Lpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701236369; x=1701841169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odzHaB82SZdpybaH4ujfpl6ch16xiqGdapqSSbgzBkI=;
        b=CVn3HIcz7YDNoV92/YgjGa/mw/ojuoqLTyqPvDz/LugRX2YWE6tk7XLqS6sngM7faW
         W0LUGOlFVKZu5j1o4aypzrZJWkgqNmX4IezUiO+bc1Va9vDetTjjw7K72ZOdk3wWjFFT
         XX9wdG9+uYt/po6K2s4HfbdEWuNNUBzTIl5uwpXCXnvW+HQauGa8663aGA4VvbqmTC8I
         W3csgWD6aCr0Fvmj9aAeACFCjhYfFT9lpYKp+ypIT/GHjjbvejgA7bEWdmKVuf5tbZ/H
         5fshqge0TnFU3wJg4bRb6RuDmkH31aP5c/RLDg52VtaV+SPIZTTujwp4urw2RKqcYB8F
         wfKg==
X-Gm-Message-State: AOJu0YywkJXbLkTU6n3vGh6B+4LtiSEZ+qSgdBBnK0+8DNveF6v//qPZ
        QVS0XsydyWnvtgfUYKoQ+R0fhNhhQJM=
X-Google-Smtp-Source: AGHT+IGz8aGZVmu36Kmt61oqFIQCLjCV8dVstGF4hdOcUUg0GDOBZZrghen2rAaIuIBCohBpFEg9pg==
X-Received: by 2002:a05:6808:4342:b0:3b8:8db8:d8b5 with SMTP id dx2-20020a056808434200b003b88db8d8b5mr2218303oib.58.1701236368872;
        Tue, 28 Nov 2023 21:39:28 -0800 (PST)
Received: from localhost ([156.236.96.172])
        by smtp.gmail.com with ESMTPSA id e13-20020a631e0d000000b0057c44503835sm10337143pge.65.2023.11.28.21.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 21:39:28 -0800 (PST)
Date:   Wed, 29 Nov 2023 13:39:23 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com
Subject: Re: [PATCH v2] erofs: fix memory leak on short-lived bounced pages
Message-ID: <20231129133923.00005957.zbestahu@gmail.com>
In-Reply-To: <20231128180431.4116991-1-hsiangkao@linux.alibaba.com>
References: <20231128175810.4105671-1-hsiangkao@linux.alibaba.com>
        <20231128180431.4116991-1-hsiangkao@linux.alibaba.com>
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

On Wed, 29 Nov 2023 02:04:31 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Both MicroLZMA and DEFLATE algorithms can use short-lived pages on
> demand for overlap inplace I/O decompression.
> 
> However, those short-lived pages are actually added to
> `be->compressed_pages`.  Thus, it should be checked instead of
> `pcl->compressed_bvecs`.
> 
> The LZ4 algorithm doesn't work like this, so it won't be impacted.
> 
> Fixes: 67139e36d970 ("erofs: introduce `z_erofs_parse_in_bvecs'")
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
