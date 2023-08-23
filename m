Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1C5785D67
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 18:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237321AbjHWQmA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 12:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231450AbjHWQl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 12:41:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B15CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692808868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YW0EDZCY0m8+/dZecu2djclRs+GAoB7p8AH+s2fFlNo=;
        b=CZDKvRWzrcWocFds9vYM9TNtm3r/Is5wMXYrcd7V6MgBpP5rj+rkzrJJWKuluK3sJ+f9IV
        o7FW6YevIrEHFIVhGx9Vyzv2sM8vUSUg/10J0fL4+jxEo8FVA9b7Ndb0Z+nqZkGGy5p+10
        QJSSUiRlVhvEbIZ7IsIGIgGx+G8qZGg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-AFwa0AN6PKepvU3wlzhGlQ-1; Wed, 23 Aug 2023 12:41:04 -0400
X-MC-Unique: AFwa0AN6PKepvU3wlzhGlQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-63d2b88325bso13913856d6.1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Aug 2023 09:41:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692808864; x=1693413664;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YW0EDZCY0m8+/dZecu2djclRs+GAoB7p8AH+s2fFlNo=;
        b=k92jVmlZX1TYPIeA89CpuqiwTqs4ElKaPrIn22tGjhtziFIvgCXLu5CFAO4jOOQBOh
         lQW/79TXVmMysfwsJvY2wnJ1ZdIthyl1vTs1UlQq34yXQIltB+61JWprIJPo1GYQWCMA
         s7DJ0YNmCx6IQdTAEINqFsO94lCQ4giLwvcdV3ynq6O0GwUad0lm1U/+oHu/SrUdjdak
         obw9jQsj/m0k2EhtMTSun3qMvwwa0l90J4mx4exwzsGPZ3E2lJfKKnnjZ92E20Ey3oAl
         HaosNYRcOFHlXzea5+RCLF7aw8JDNTkIBoIBR9rEcYLvfxj7Wp74/eM7/f5COtAoS39V
         ZUzQ==
X-Gm-Message-State: AOJu0Yx3NClMqyjyaAS3g+JKnI0rGpIkpK/uKq8DTZU9v0/zZ6ZWPNCP
        dCjMJ9c/4YHvxsYOGq0/UK2iJf94+eOOOSei1cp9/1H7KWkANjjMlZg1mtHoikcy4y+cLp4OmS4
        bbJApNIBJ1NRvhp5Admto5TSv
X-Received: by 2002:ad4:5c63:0:b0:645:3c6:56ab with SMTP id i3-20020ad45c63000000b0064503c656abmr15349101qvh.1.1692808864537;
        Wed, 23 Aug 2023 09:41:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY59trkyfeqoHva+BRsUTu+ef1zBDxPgp/+hPFtlZY7Syl2yVvoX/z+RQuT4WgRq8pYA809Q==
X-Received: by 2002:ad4:5c63:0:b0:645:3c6:56ab with SMTP id i3-20020ad45c63000000b0064503c656abmr15349095qvh.1.1692808864306;
        Wed, 23 Aug 2023 09:41:04 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
        by smtp.gmail.com with ESMTPSA id j26-20020a0cae9a000000b0064f3d5cbbb6sm2926202qvd.114.2023.08.23.09.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 09:41:03 -0700 (PDT)
Date:   Wed, 23 Aug 2023 12:41:00 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Edward Liaw <edliaw@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH mm-hotfixes-unstable] shmem: fix smaps BUG sleeping while
 atomic
Message-ID: <ZOY2nMjTOVe2ozIS@x1n>
References: <6fe3b3ec-abdf-332f-5c23-6a3b3a3b11a9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fe3b3ec-abdf-332f-5c23-6a3b3a3b11a9@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 10:14:47PM -0700, Hugh Dickins wrote:
> smaps_pte_hole_lookup() is calling shmem_partial_swap_usage() with page
> table lock held: but shmem_partial_swap_usage() does cond_resched_rcu()
> if need_resched(): "BUG: sleeping function called from invalid context".
> 
> Since shmem_partial_swap_usage() is designed to count across a range, but
> smaps_pte_hole_lookup() only calls it for a single page slot, just break
> out of the loop on the last or only page, before checking need_resched().
> 
> Fixes: 230100321518 ("mm/smaps: simplify shmem handling of pte holes")
> Signed-off-by: Hugh Dickins <hughd@google.com>
> Cc: stable@vger.kernel.org # 5.16+

Oops.. thanks Hugh.

Acked-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu

