Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F30F07BD06D
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 23:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344710AbjJHVyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 17:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344437AbjJHVyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 17:54:35 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBBCAC
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 14:54:33 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-7741b18a06aso287768385a.1
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 14:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1696802073; x=1697406873; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2lF92kcVMrLRaxlLOpuuihR9KaLnr39sEQyi5og8S4Q=;
        b=oRt5lRhGA45NWLfsNWFveCjvPYIMf1OGRPgqL71zdRrmtlZVVh8UgD9kFurup6Ba32
         kVmzFQkQUe/B1kzt+HOR+/fQ/8iamOMvW1lj8MUNcLgfZLz+HK4Kwzq1lJpeHVKPS6Vh
         ynfOx/mmvv8Gkq14aSh9bwVMkOCx1WFNtkTtsrVolXVFToHSRNDRg6EuzvFKcO6VpuyN
         CL0H8NPh2NkDlHBcxjJ8NBh1GaKFxfjblpFDCEjM0gQDcqYOUhf1OXjua7cKFJPqDHnK
         cr3mD1RrZmZEIs1FcA/mcuQxbg7uuZxOTMtLNtzQSCGYflUT5mFMu49nXVaLUxRp5V4j
         NxAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696802073; x=1697406873;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2lF92kcVMrLRaxlLOpuuihR9KaLnr39sEQyi5og8S4Q=;
        b=aa8sPhd2cQ1X+ep1JxpI5pxOWqCxagaZtaMb2TzopvSSBzoX5PQ+cV0/2LAmDApz5q
         rZWC/70quo++7NbHVDYsfHGDy94P7e0Q2848ei6h2IdC5SSrxJctaFer3NPIjsrkqIyd
         tkvcC64ijIaLK3juQkJoLP24VqOxhVbiCXCr/8U2r4AwdUtOwUIsG04/z1TTLGl+c1V7
         iz+959i6rAbPL49G6+D8X3JkSNv8TDSuL7PzYG7ndmcfegNDXgAgOBsJCDVArPoRZIPC
         qqjb1dDcCbGdyqNxsP+H1iKMQDYsKyvwtEkLPlO9+QS8fvNcBXmNGU+Vhs/1n6PCIYhT
         Walg==
X-Gm-Message-State: AOJu0YzklTN1TCS0MogWTOo+pkY1mFIYw490HoALbbMc6sfYJStqeinI
        WzYBrzvEUu12FEIUuKntR68ToA+jNHY95DKG844=
X-Google-Smtp-Source: AGHT+IE9uk2jQHbCBVxRhP7NjawRCWYl0XIv9gecaHQ8PgPtfZNgekIL319uoZlVT8luWtvfdncaig==
X-Received: by 2002:a05:620a:410a:b0:76c:bdbd:c51d with SMTP id j10-20020a05620a410a00b0076cbdbdc51dmr18146770qko.66.1696802072815;
        Sun, 08 Oct 2023 14:54:32 -0700 (PDT)
Received: from dread.disaster.area (pa49-180-20-59.pa.nsw.optusnet.com.au. [49.180.20.59])
        by smtp.gmail.com with ESMTPSA id e18-20020aa78c52000000b00686b649cdd0sm4991103pfd.86.2023.10.08.14.54.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Oct 2023 14:54:31 -0700 (PDT)
Received: from dave by dread.disaster.area with local (Exim 4.96)
        (envelope-from <david@fromorbit.com>)
        id 1qpbjI-00BFzX-19;
        Mon, 09 Oct 2023 08:54:28 +1100
Date:   Mon, 9 Oct 2023 08:54:28 +1100
From:   Dave Chinner <david@fromorbit.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J . Wong" <djwong@kernel.org>, linux-xfs@vger.kernel.org,
        Mateusz Guzik <mjguzik@gmail.com>
Subject: Re: [PATCH v2 1/5] locking: Add rwsem_assert_held() and
 rwsem_assert_held_write()
Message-ID: <ZSMlFMTuD/5B1U/n@dread.disaster.area>
References: <20231007203543.1377452-1-willy@infradead.org>
 <20231007203543.1377452-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007203543.1377452-2-willy@infradead.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:35:39PM +0100, Matthew Wilcox (Oracle) wrote:
> Modelled after lockdep_assert_held() and lockdep_assert_held_write(),
> but are always active, even when lockdep is disabled.  Of course, they
> don't test that _this_ thread is the owner, but it's sufficient to catch
> many bugs and doesn't incur the same performance penalty as lockdep.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
.....
> @@ -169,6 +189,18 @@ static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
>   * the RT specific variant.
>   */
>  
> +static inline void rwsem_assert_held(const struct rw_semaphore *sem)
> +{
> +	lockdep_assert_held(sem);
> +	__rwsem_assert_held(sem);
> +}

	if (IS_ENABLED(CONFIG_LOCKDEP))
		lockdep_assert_held(sem);
	else
		__rwsem_assert_held(sem);

-Dave.
-- 
Dave Chinner
david@fromorbit.com
