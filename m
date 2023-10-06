Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260607BBD5A
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 18:57:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjJFQ5F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 12:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbjJFQ5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 12:57:03 -0400
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65C0DBF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 09:57:01 -0700 (PDT)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-65d0da28fa8so12304046d6.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 09:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1696611420; x=1697216220; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=C+I8CK19UqtAB8f1CJ6Vj7LXdS2XW4DpDpklb8lSJ0g=;
        b=QPHXylJmv6P4KZveITH8glK15f1BzpdFL0Ne4ZxRsdarKF9cPHd/hTiYFDAyEy94LE
         LTtHtxMmQZOK+vPnXx4LDPfKCtFA+pa86jHeMkrXHA+3L4yokzdrxjkiS79GcD9hxojT
         /O8uLWcqv1h52zK1rskgX7EVGThni2W0N7cD83G134+XMsZOh2XKx+p+PqxutyVRwVzY
         Dvpo3r4Tle3kqomv9GtvjJ45COHvaQUMyw+oVDXF/OML8Un/eNKBaLrpXoF4NjCPJf1l
         SvWkK7nD8MT3AFnsoIAG0UL7rJSg4ZRtEZZkmKvWIHczj5vbmEjT7B1QIYx+5ms0/HZN
         VXXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696611420; x=1697216220;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C+I8CK19UqtAB8f1CJ6Vj7LXdS2XW4DpDpklb8lSJ0g=;
        b=wZ4vbjueAUumSQirbjYrDTtMap3e40yhAEallNZscotQ/ogtMgXoSkPXpiGmZpJXrk
         Q6YzzjmuZmJHlG3lk/dT81qq4TEQglgFLjNR+Mq0WE+twonY07zseB8nubGV+H+dPWEC
         +qSkpV6a4UOyRA9IFb8ZFvwFgjCwZQrxsV7zuKK7X1zh+8V4BmD4VG7GPxqmZnmaaRw8
         2jQSCZ8OK/H+d03Rf5nuzs33RKu2hYRIfDm81bobP+scoDZPvntaVT0CQ79rf8fy4pTE
         IDTrZLgLJ3IJ0m8W9tQCRFTmzyMCT3veMiBMi6K4Jl/zu+VPEpzPqCcXD1U8i6Ot/yQQ
         CpUg==
X-Gm-Message-State: AOJu0YwMNh2ZJoq871mzH8Lwagzl0VD0mMRagaFY9qhCI0xuXl0nxzeo
        tLJZUWm4uWEHnLlhJJXb3hMQTQ==
X-Google-Smtp-Source: AGHT+IFAJFIYutUtEyBGOiyj900g37e5yxSx57t11D+gbzbImeOTFgc0eSwBTce10eDMifD8UfXBbA==
X-Received: by 2002:a0c:bf09:0:b0:656:3fa4:6016 with SMTP id m9-20020a0cbf09000000b006563fa46016mr8288298qvi.62.1696611420496;
        Fri, 06 Oct 2023 09:57:00 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-26-201.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.26.201])
        by smtp.gmail.com with ESMTPSA id n4-20020a0c9d44000000b0065af4977ea3sm1532904qvf.24.2023.10.06.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Oct 2023 09:57:00 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1qoo8J-004lqe-Ax;
        Fri, 06 Oct 2023 13:56:59 -0300
Date:   Fri, 6 Oct 2023 13:56:59 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Alex Williamson <alex.williamson@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        liucong2@kylinos.cn, yishaih@nvidia.com, brett.creeley@amd.com
Subject: Re: [PATCH] vfio: Fix smatch errors in vfio_combine_iova_ranges()
Message-ID: <20231006165659.GX13795@ziepe.ca>
References: <20230920095532.88135-1-liucong2@kylinos.cn>
 <20231002224325.3150842-1-alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231002224325.3150842-1-alex.williamson@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 02, 2023 at 04:43:25PM -0600, Alex Williamson wrote:
> smatch reports:
> 
> vfio_combine_iova_ranges() error: uninitialized symbol 'last'.
> vfio_combine_iova_ranges() error: potentially dereferencing uninitialized 'comb_end'.
> vfio_combine_iova_ranges() error: potentially dereferencing uninitialized 'comb_start'.
> 
> These errors are only reachable via invalid input, in the case of
> @last when we receive an empty rb-tree or for @comb_{start,end} if the
> rb-tree is empty or otherwise fails to produce a second node that
> reduces the gap.  Add tests with warnings for these cases.
> 
> Reported-by: Cong Liu <liucong2@kylinos.cn>
> Link: https://lore.kernel.org/all/20230920095532.88135-1-liucong2@kylinos.cn
> Cc: Yishai Hadas <yishaih@nvidia.com>
> Cc: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
> ---
>  drivers/vfio/vfio_main.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)

Yeah, this is much clearer

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Thanks,
Jason
