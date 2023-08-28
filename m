Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24FDC78BB29
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 00:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234251AbjH1WrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 18:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjH1WrB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 18:47:01 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E463813E
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:46:58 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1bf7a6509deso18193485ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 15:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693262818; x=1693867618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jfbVDtnUzC7S/98XQMX9mkLUChZIIcF3EqTa705rK40=;
        b=DpUgaRdGmyys0YbzcJ+/+C/4TT7jf1NRTxh6quRzHmf0W7ShC/TICRXTpcZ+bfooDZ
         MGEwb57HzW4HbsZv5qXAym6Vuj27xlfQRiC7IqWvDgw6tbgIsCaLtpawdHEDSOzx6h/C
         KdyPPAxwPmi/1KKanDD8q1ldw/5UXMQMWlcwjeePUW9NFPerJvASgEvRs1+i1viJg2sW
         4M54QrmCfMkGjh1r23unlGBCYVLiyLoj+GtplXm8aPBKD0pPKmqMO1jqR/CZrZyGuecf
         NHMVctNEvEYrD6lKE8Ul/08Ky52jOkCUMqMH62NW8vYpwWQcamzhUW4QOVJJStjHcvjI
         BlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693262818; x=1693867618;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jfbVDtnUzC7S/98XQMX9mkLUChZIIcF3EqTa705rK40=;
        b=HemYgKL2oyp3wc8NLWfeRA3qVezctz8KvhteTJ6mknzq8P4lhv2vfoUCp2kmNyOb72
         m7JOs+z4wRDB7sNlLMA4ylMlk/SQQ8bwlKxyRRFu/N9pytHa0zxolCcd/v2jFcalgeCt
         flB211JjzQSQT0e9vqCHVeQ8hQv8Xse7RI/NlQvh3cqJmvPjl2fsLoKouSkNKy5qs7C8
         cuf6oAXqkxo907qytbElbXu1X0LMzlbf6R0wmpScZCIS4avaJdhCX7eTmvohyRtSQISO
         ZMTEZ/qVs/N4EyUn8QLGxdviZVcV9TSrcGiIoMXAqQDTuix8I3AeC/VdNQykZnm02m7d
         K9RQ==
X-Gm-Message-State: AOJu0Yxwlg1/hcez71cpdU9vwvYUw3gkZrVCsy5dxVEee4Jzoiy5l7ya
        /Vp9zEPmz7x6p1nyli7mgeSQBg==
X-Google-Smtp-Source: AGHT+IFspYfjLzYgSOwGtPHy8bxl+y+5JkPrvkKdfXKLBR1uq/L9AkoAEuEDtgywPH8Tn+brWT5PnQ==
X-Received: by 2002:a17:902:dacd:b0:1c0:c86a:5425 with SMTP id q13-20020a170902dacd00b001c0c86a5425mr11041619plx.19.1693262818063;
        Mon, 28 Aug 2023 15:46:58 -0700 (PDT)
Received: from google.com ([2620:15c:2d1:203:b64:7817:9989:9eba])
        by smtp.gmail.com with ESMTPSA id jg12-20020a17090326cc00b001b8b07bc600sm7904627plb.186.2023.08.28.15.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 15:46:57 -0700 (PDT)
Date:   Mon, 28 Aug 2023 15:46:52 -0700
From:   Nick Desaulniers <ndesaulniers@google.com>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Stefan Haberland <sth@linux.ibm.com>,
        Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, nathan@kernel.org,
        llvm@lists.linux.dev, David Laight <David.Laight@aculab.com>
Subject: Re: [PATCH 1/1] s390/dasd: fix string length handling
Message-ID: <ZO0j3M8KFWeEznXy@google.com>
References: <20230828153142.2843753-1-hca@linux.ibm.com>
 <20230828153142.2843753-2-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828153142.2843753-2-hca@linux.ibm.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 05:31:42PM +0200, Heiko Carstens wrote:
> Building dasd_eckd.o with latest clang reveals this bug:
> 
>     CC      drivers/s390/block/dasd_eckd.o
>       drivers/s390/block/dasd_eckd.c:1082:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 11 [-Wfortify-source]
>        1082 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
>       drivers/s390/block/dasd_eckd.c:1087:3: warning: 'snprintf' will always be truncated;
>       specified size is 1, but format string expands to at least 10 [-Wfortify-source]
>        1087 |                 snprintf(print_uid, sizeof(*print_uid),
>             |                 ^
> 
> Fix this by moving and using the existing UID_STRLEN for the arrays
> that are being written to. Also rename UID_STRLEN to DASD_UID_STRLEN
> to clarify its scope.
> 
> Fixes: 23596961b437 ("s390/dasd: split up dasd_eckd_read_conf")
> Reviewed-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Thanks for the patch! Nathan just reported a bunch of these. I took a
look at these two and thought "yeah that's clearly a bug in the kernel
sources." Fix LGTM.

Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://github.com/ClangBuiltLinux/linux/issues/1923
Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

I also like David's idea of passing `char ident [DASD_UID_STRLEN]`, too,
but I don't feel strongly either way.
