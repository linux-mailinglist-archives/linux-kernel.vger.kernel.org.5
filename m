Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEA679BBBD
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378637AbjIKWgM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:36:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242673AbjIKQFP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 12:05:15 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6AF31AE
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:05:09 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6c0b727c1caso2932811a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 09:05:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20230601.gappssmtp.com; s=20230601; t=1694448309; x=1695053109; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3NcImq2ANXyTU9IjWwqj61QAzOMpFgaQdLTxRaWVzyQ=;
        b=gBIhswhdzeipcWeE3vvBPz7G00K8wQS7eXPqDNoe9Q/PmE4vY2ZxzkD2vBQXnJqLcf
         PnMmy/RmFKiGFECVCYRIoD50VYZdrrfrUsi4uxJfJmvZCA/vVYf0BW0sArnAO4DEyba4
         5eG0qn+pgf5iX2Rt1OPZtfMHKVvCcRhNmLjyBuN55oDUTYsFEm2TDeh5JsvRJ1KjGeVl
         0XWHFrziXItfgxrZ9a6JTtE6WozqB9REx4v6tmTU9XxKMT3hlU33XXegYFo095TXmTIY
         BK/0HI5NXXDwc4KEtkbGhwtsc34l14TO4Is4qJs5w57P26IQR/zskGDi9kGNJdPvNsO9
         JCYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694448309; x=1695053109;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3NcImq2ANXyTU9IjWwqj61QAzOMpFgaQdLTxRaWVzyQ=;
        b=nvTzwBCb19OrHkfgmcaD5plNt2iV4F66ihg1VWSiFffmaaVtMICLXZdaHdZrjHv4gu
         weZRgfZLb3g/96OdHY9vaBsKDk6lpAIkWBzEx/Ecdo5ht+fRyhnRd0AWzplawQ82ybXz
         Rddz2FaL33ud394fs3VT/94iRmVDTyaJVqZEwJ/zHsIRHJpPoaibKJCjEN2gPs2PAQV9
         QJG54mIrnwvnoZY5Fz/7cqP4/yEC0+zk6VQH0rJgOApqow2e3gvkDdwvJrlRD1NkU1U1
         WpKQZ2KdX0bknEQCDhuyBl3kQViEiVedJP22GErmF4efL01V7HV6eKhyMQYDMAnZTlfk
         3JRQ==
X-Gm-Message-State: AOJu0Yy90Fy6rfxMux5kxnwtVYTC5IihMBRYV1aaWkkVMAlY6TIV/ySM
        WXtJgctLiyft/I3Vdz3s8myaHg==
X-Google-Smtp-Source: AGHT+IFgu4s3lCy20ZYftOE3FaCBjP14GK9MBKMm8PyBTvWDIGobThLDoRnBJtB+3pRvIgkjSWIaJA==
X-Received: by 2002:a05:6358:9491:b0:134:d559:2590 with SMTP id i17-20020a056358949100b00134d5592590mr10251018rwb.14.1694448309102;
        Mon, 11 Sep 2023 09:05:09 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-3012-16a2-6bc2-2937.res6.spectrum.com. [2603:7000:c01:2716:3012:16a2:6bc2:2937])
        by smtp.gmail.com with ESMTPSA id k5-20020ac81405000000b0040fdcd391d8sm2688274qtj.72.2023.09.11.09.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 09:05:08 -0700 (PDT)
Date:   Mon, 11 Sep 2023 12:05:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Nhat Pham <nphamcs@gmail.com>
Cc:     akpm@linux-foundation.org, cerasuolodomenico@gmail.com,
        yosryahmed@google.com, sjenning@redhat.com, ddstreet@ieee.org,
        vitaly.wool@konsulko.com, linux-mm@kvack.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] zswap: change zswap's default allocator to zsmalloc
Message-ID: <20230911160508.GA103342@cmpxchg.org>
References: <20230908235115.2943486-1-nphamcs@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908235115.2943486-1-nphamcs@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 04:51:15PM -0700, Nhat Pham wrote:
> Out of zswap's 3 allocators, zsmalloc is the clear superior in terms of
> memory utilization, both in theory and as observed in practice, with its
> high storage density and low internal fragmentation. zsmalloc is also
> more actively developed and maintained, since it is the allocator of
> choice for zswap for many users, as well as the only allocator for zram.
> 
> A historical objection to the selection of zsmalloc as the default
> allocator for zswap is its lack of writeback capability. However, this
> has changed, with the zsmalloc writeback patchset, and the subsequent
> zswap LRU refactor. With this, there is not a lot of good reasons to
> keep zbud, an otherwise inferior allocator, as the default instead of
> zswap.
> 
> This patch changes the default allocator to zsmalloc. The only exception
> is on settings without MMU, in which case zbud will remain as the
> default.
> 
> Signed-off-by: Nhat Pham <nphamcs@gmail.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
