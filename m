Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22374777BEA
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235714AbjHJPOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236065AbjHJPN7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:13:59 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE126BC
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:13:57 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1bc83a96067so7725475ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 08:13:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1691680437; x=1692285237;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yH1lR7Tmb/121ugTuhyYiipeLnL26qyWyxJS1YHu6k=;
        b=fisx6tDiRoHdpjchdDQDaYu+AxzZRxKXddUGJDrRYeC+Qbbhlm1ZHdlft0uLxKS6NM
         TtJsKXfhhl/oXRrShuS7fHFpMD5RixmhG+UmSvvcdp17DkCUYlmMJ7LLldWBJvQ0xHH3
         uuhveIWbFeP/MWkSzta8InmHES6xMe+s/o0dPooFzmVvgkpk39QTAgL1LdkNN47GuBtl
         MLs80BAdpDr7OJLH1FUWbQv0qXDenZ8RfFUIM6ngKjdnRaUdKAxTFWquTFLwBp6Vcaxd
         5+YEAhzCze10+IlMABH0AR0ovBYrMzI3k81gv2oj8FAUsPa8LnbtzyoI2K2vZvGXFVT2
         tXTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691680437; x=1692285237;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0yH1lR7Tmb/121ugTuhyYiipeLnL26qyWyxJS1YHu6k=;
        b=XS4hDDXgldN53i11LuSeDmJpQT1WX9BbcpEZlPO4e93TZuoWUX4aDohf2hnjgI9aAn
         W+DkFsVf8UPOFF3sANFw2t0fKZaOUSmnKZlEnsvflujxEhsJ+NsPEgpx+sAWcINW1FBV
         iFViSnyGewxihmyPoGGo5vhRRvovfq5DvDqJf5FkzFrj+XPP+S6PvZ7aOA/nwi5wWJGU
         1Fn2d6volLsvwerjv8c4z9I4ikRdM+CXQF20Bl23URdy0A1MryuekL/grVw5kzip0mnJ
         tL8PwFMkImJ5GevD73ZBdT77MZKpQAntI3cxPksXGO5DeBVKJjO+Uy3aKpaojuy++QBq
         qBuQ==
X-Gm-Message-State: AOJu0YyJYF35UT50he/aBg5jsN5d5m5ZlW908hDhS5+PeNSJZNYagSjj
        nvvQYs/D3ZKCnYQpHdlXdHBXUQ==
X-Google-Smtp-Source: AGHT+IEseVfgJhHs0X3dkW4aAOaplIv6mghWHgV2rrKNruGAQY1FWypVPlIP6PMZUgCShLumnOvQvQ==
X-Received: by 2002:a17:902:9681:b0:1b8:5b13:5958 with SMTP id n1-20020a170902968100b001b85b135958mr2145864plp.31.1691680436948;
        Thu, 10 Aug 2023 08:13:56 -0700 (PDT)
Received: from localhost ([135.180.227.0])
        by smtp.gmail.com with ESMTPSA id ji1-20020a170903324100b001b9cea4e8a2sm1871565plb.293.2023.08.10.08.13.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 08:13:56 -0700 (PDT)
Date:   Thu, 10 Aug 2023 08:13:56 -0700 (PDT)
X-Google-Original-Date: Thu, 10 Aug 2023 08:13:53 PDT (-0700)
Subject:     Re: [PATCH -fixes] mm: Add a call to flush_cache_vmap() in vmap_pfn()
In-Reply-To: <ZNQSTw4uoksSMYB5@infradead.org>
CC:     alexghiti@rivosinc.com, akpm@linux-foundation.org,
        urezki@gmail.com, Christoph Hellwig <hch@infradead.org>,
        lstoakes@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Christoph Hellwig <hch@infradead.org>, dylan@andestech.com
Message-ID: <mhng-3d3afb21-bd40-4095-ba62-41cf40b782ca@palmer-ri-x1c9>
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

On Wed, 09 Aug 2023 15:25:19 PDT (-0700), Christoph Hellwig wrote:
> On Wed, Aug 09, 2023 at 06:46:33PM +0200, Alexandre Ghiti wrote:
>> flush_cache_vmap() must be called after new vmalloc mappings are
>> installed in the page table in order to allow architectures to make sure
>> the new mapping is visible.
>
> Looks good.  I somehow vaguely remember seing a patch like this floating
> around before as part of a series, but if that didn't make it it
> certainly should now.
>
> Reviewed-by: Christoph Hellwig <hch@lst.de>

I think we're likely to end up with performance problems around here, 
but at least it's correct.  If someone has performance

Dylan: this fixes your breakage as well, right?

I've queued it up for testing, but I doubt QEMU would find any issues 
here.  My build box has been slow lately, but it should end up in fixes 
later today.
