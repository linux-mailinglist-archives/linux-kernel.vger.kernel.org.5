Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868CA777CFE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:58:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232201AbjHJP6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234880AbjHJP6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:58:15 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F1FE53
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:58:14 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id 98e67ed59e1d1-26837895fbbso727631a91.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691683094; x=1692287894;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VDBBjEUhdOwGqmMS5EZuk5kV7DmaXVSYKyA1KEjjfTQ=;
        b=Loux/lcbFGKt/PwP6moOiY2xjkOS3vWT1JKnclVLiLOabD41avWWLUPZx/1Iramwr2
         tnlCkFCqmZGZMpOCoY4PAIQCMqOKs7nw7JTxkNJFhoeq8Rfc7NVdanAbYNJ2XI0/WnI9
         Qh5+I2kq9wQGqQx6LyV9eiwakiwABwd66AAx1JOQfRn/UwawKiYrfedIC5JbdnhPLROJ
         TsHOnT2zUPQ0AYCoBnjfJkUv9WH9MhSqjCwUeauUagThIRi3w47QqkfUseiR5dOTCKmp
         0yBzs2uX24fBdU4gzdyFBKYAJDNqxkbUmwxbHlFA4U6lOLAoMV0Kbvss1TVvBXeXXKbj
         LWAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691683094; x=1692287894;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VDBBjEUhdOwGqmMS5EZuk5kV7DmaXVSYKyA1KEjjfTQ=;
        b=WHeCo91fHI0znACE7qfTV5pOXcJx1nEj/lkWz1dmLqTcjjpljibkhOhgPGaMy9JkZV
         jTssZucdmP1TTPr3mPE8Cs51/OwpA2zGXeio/dsUy6Js5OCZ4abKCZtPeSxeCkisb5ND
         DuPNKakhUetG8BInC8aX5IpGNAWYLyMYeaYgIUCIXZY1sMPc96ILFOLCt9qdzOZKnqAW
         qmt1czYy5wONCjOVF0Pe3AzW1hqtrWA1gNAMW8G3qFXo0UTXX8Pj37T66AwXxbpAiafV
         wCKNkwBBTWqF5ImpLWMWAgDgxdK5LmbLvn7cWUwTGUPvKJjZS6nJTnLEnvof2MDkzHkm
         Hs6Q==
X-Gm-Message-State: AOJu0YxveVjvxwEq5DPheugKn74DHlR+hEwdcE+gokVevzapGMK/K9jP
        +cT446snWiD0plPNacg7HSb2Kw==
X-Google-Smtp-Source: AGHT+IGQgJUoPsyLlnUjbWwQ15bA7rnW1cqZKBxqQSQLdnCfIunbQ7ghC9b7SWjg3YpGttzhK2pkdg==
X-Received: by 2002:a17:90b:3e8d:b0:262:ee7d:2d20 with SMTP id rj13-20020a17090b3e8d00b00262ee7d2d20mr2620120pjb.12.1691683093833;
        Thu, 10 Aug 2023 08:58:13 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id 30-20020a17090a001e00b002630bfd35b0sm3827053pja.7.2023.08.10.08.58.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:58:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:58:13 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 08:58:09 PDT (-0700)
Subject:     Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
In-Reply-To: <mhng-3d3afb21-bd40-4095-ba62-41cf40b782ca@palmer-ri-x1c9>
CC:     dylan@andestech.com, alexghiti@rivosinc.com, urezki@gmail.com,
        Christoph Hellwig <hch@infradead.org>, lstoakes@gmail.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>, akpm@linux-foundation.org
Message-ID: <mhng-057e1f9e-8320-43b9-a0fe-282b4beffd13@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Aug 2023 08:13:56 PDT (-0700), Palmer Dabbelt wrote:
> On Wed, 09 Aug 2023 15:25:19 PDT (-0700), Christoph Hellwig wrote:
>> On Wed, Aug 09, 2023 at 06:46:33PM +0200, Alexandre Ghiti wrote:
>>> flush_cache_vmap() must be called after new vmalloc mappings are
>>> installed in the page table in order to allow architectures to make sure
>>> the new mapping is visible.
>>
>> Looks good.  I somehow vaguely remember seing a patch like this floating
>> around before as part of a series, but if that didn't make it it
>> certainly should now.
>>
>> Reviewed-by: Christoph Hellwig <hch@lst.de>
>
> I think we're likely to end up with performance problems around here,
> but at least it's correct.  If someone has performance
>
> Dylan: this fixes your breakage as well, right?
>
> I've queued it up for testing, but I doubt QEMU would find any issues
> here.  My build box has been slow lately, but it should end up in fixes
> later today.

Sorry about that, I'm in the wrong thread -- I meant to be over here 
<https://lore.kernel.org/all/20230725132246.817726-1-alexghiti@rivosinc.com/>.

Reviewed-by: Palmer Dabbelt <palmer@rivosinc.com>
Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

but I'm not taking this via the RISC-V tree unless someone asks.
