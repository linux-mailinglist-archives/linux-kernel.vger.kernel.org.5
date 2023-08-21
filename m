Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D927834DD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 23:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHUVYY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 17:24:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbjHUVYX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 17:24:23 -0400
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCEB13D
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:23:59 -0700 (PDT)
Received: by mail-qk1-x72e.google.com with SMTP id af79cd13be357-76d7b5e374fso246519785a.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 14:23:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692653038; x=1693257838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=DP6IDsgCHUZqVeY6SUa+gx+l+qskomA4jh82+amtcws=;
        b=j8Zr+W7YMa40iJK+BLVYWT/YVZ3X1KKH0Hn4zfaXo2+6BHsjjVlIkDnVzDSvGQ+50m
         CgAlRlWvuZQIZcibXUYK/g1bHIvw5QiDW4meQvTHXWiGMvqiTG/YAu/iC0Ms+eyL/lWn
         s+Af7PHZQhuQE7RCT2aMCue8WuQSjPuLEZdz+6l8LajIpRI82ovsbwVl86h2Qth8/oMF
         uyOGz4IlHCw74e13AEutfbBNbL3l3lhV8e9QB+H5udwmCoZt35dWash+89oqxn389jYE
         ICp0amFGh06HhgeKEzHOHx6UqxH9ZoNxiGSNAS6lQBwfkVrgB+rMTobRZrHZW+2VbLie
         Nj/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692653038; x=1693257838;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DP6IDsgCHUZqVeY6SUa+gx+l+qskomA4jh82+amtcws=;
        b=lw+CcybA44lVjPTRYlTfxwgJ4Vd+6X3AN7j1euI1wHEyLdGB59iPBhi39RZGhZ46Bs
         rVQRATaongqZOVqT7Nks8fWnZ/YRvVrDtIY6x90hgu2sdFNwaZp73HAmy8IZ9zdLLG4I
         1O+hvVAeIsdjPaL02cPm+KR6ytrSU6PIqIZej+TFDT49CzVIXDrUygOHHgEV/jI6WHrB
         14ZszXjV/roOVfXrbny632dtcNHcvpR0YR8pc8KA1E9NVqL6RqzfQnru1Hhc2MrhTpkT
         PK4vCc26Oweu0ZXA7G9NeqqpyeaMGMTgiF6sDxUo4bNacmTpicvw0f2zZYqq+pcXIb1k
         q2VA==
X-Gm-Message-State: AOJu0YyZc86v2Fck7RLEAXCioIJhE9w/NbKq7yTGA/CiNSdxV9IPw1YE
        aoOQybNu0B7smUW8wettKGaq8g==
X-Google-Smtp-Source: AGHT+IHDpY9KDQrcZKpW6g0neLmQwOGB/c0MbsD5Cg/XSeQ9GXuPzIdBXl4oXKhBDR0jHEtnfIM1kQ==
X-Received: by 2002:a0c:b452:0:b0:639:91ad:64d6 with SMTP id e18-20020a0cb452000000b0063991ad64d6mr7151887qvf.61.1692653038141;
        Mon, 21 Aug 2023 14:23:58 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-699c-6fe1-d2a8-6a30.res6.spectrum.com. [2603:7000:c01:2716:699c:6fe1:d2a8:6a30])
        by smtp.gmail.com with ESMTPSA id x4-20020a0cb204000000b0063642bcc5e4sm3238893qvd.9.2023.08.21.14.23.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 14:23:57 -0700 (PDT)
Date:   Mon, 21 Aug 2023 17:23:57 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org, baolin.wang@linux.alibaba.com,
        mgorman@techsingularity.net, david@redhat.com, willy@infradead.org
Subject: Re: [PATCH 1/2] mm/page_alloc: remove unnecessary inner
 __get_pfnblock_flags_mask
Message-ID: <20230821212357.GD106501@cmpxchg.org>
References: <20230811115945.3423894-1-shikemeng@huaweicloud.com>
 <20230811115945.3423894-2-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230811115945.3423894-2-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 11, 2023 at 07:59:44PM +0800, Kemeng Shi wrote:
> Function get_pfnblock_flags_mask just calls inline inner
> __get_pfnblock_flags_mask without any extra work. Just opencode
> __get_pfnblock_flags_mask in get_pfnblock_flags_mask and replace call
> to __get_pfnblock_flags_mask with call to get_pfnblock_flags_mask to
> remove unnecessary __get_pfnblock_flags_mask.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
