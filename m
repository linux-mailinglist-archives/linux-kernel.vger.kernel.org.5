Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AD8E757AED
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 13:51:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbjGRLvt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 07:51:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjGRLvq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 07:51:46 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84002EC
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:51:45 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id 46e09a7af769-6b9c57c4d12so2342700a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 04:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1689681105; x=1692273105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bt8R0yrtkT9HdCJnGP8rK8VrJeyWRFxqKQi//6Da7GE=;
        b=YJJ7K/0vmJz/f04xwiyuKk8kOag7W4TZdVLfbvYI5skR6c9qDRXJf3IBzhvfNdTKpG
         QDOG9ERkhsPmY7HObV4nRjWRAs5JHSN0IH9jujsPACREffEOySDcNeJB9c6vgHKTNBNC
         pYlCYG6LLBBectUmpi+AiEP4U68mTQDH2bZkc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689681105; x=1692273105;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bt8R0yrtkT9HdCJnGP8rK8VrJeyWRFxqKQi//6Da7GE=;
        b=J+ATaxqb84ty/xmSbyxK7e6oS/67CVCkFGfr61skbx+BNl6LQMmLZ62f6XOyPHspNl
         xDXdEEFMeRVaq/+cTOfztDUyF7Ihx5yYF5fBkgjRp29ZylJGJTsjlXPJx7HUMJsIeE6B
         6jWW5vyJOrAk97AiA4Up7ykq6nTAo9kx7gTRRb7LpxhZ3/FwgVw38qrgrfTiLLNErshE
         qj3ZGQRx/0CjSul1qEn5bJrz55eDKxq6cvd2XTxVBxwf1r1O/MPSAvXZn9/BsGjHNvet
         ZY0DAkWYOEs5hR/1x9dhh61fKLJZloKv92EVvcPnDaevmhQNgF6QerDOLsBd8CVMqWu3
         VyCw==
X-Gm-Message-State: ABy/qLZ6wVD7cJvtcR1B9Q3zvEm29zOK0lLXvsN+YEdYoqCbWCT2EQrP
        DpESwct5miIpvC/yzG9sl6t98Q==
X-Google-Smtp-Source: APBJJlGSwNzDZ/D1eNN/xuYf2/U12n4u2seCb7p9PhhFw0d5UTDFarbRz1lof9iuLAPo5qBk1Cw1ig==
X-Received: by 2002:a05:6358:94a1:b0:131:46b:3953 with SMTP id i33-20020a05635894a100b00131046b3953mr12476851rwb.13.1689681104734;
        Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id ck23-20020a17090afe1700b00263fd82106asm1258194pjb.35.2023.07.18.04.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 04:51:44 -0700 (PDT)
Date:   Tue, 18 Jul 2023 20:51:39 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Huanpeng Xin <xinhuanpeng9@gmail.com>
Cc:     minchan@kernel.org, ngupta@vflare.org, axboe@kernel.dk,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        xinhuanpeng <xinhuanpeng@xiaomi.com>,
        Christoph Hellwig <hch@lst.de>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH] zram: set zram bio priority to REQ_PRIO.
Message-ID: <20230718115139.GC57770@google.com>
References: <20230718071154.21566-1-xinhuanpeng9@gmail.com>
 <20230718074929.GD955071@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230718074929.GD955071@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FSL_HELO_FAKE,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (23/07/18 16:49), Sergey Senozhatsky wrote:
> On (23/07/18 15:11), Huanpeng Xin wrote:
> > 
> > When the system memory pressure is high, set zram bio priority
> > to REQ_PRIO can quickly swap zarm's memory to backing device,
> > freeing up more space for zram.


This is not how zram writeback works. The only time you can be sure
that writeback frees memory is when you writeback ZRAM_HUGE objects,
because each such object uses a whole physical page on the zsmalloc
side. In any other case, compressed objects share physical pages that
zsmalloc pages consist of, so writeback simply punches wholes in zspages,
without actually freeing any memory immediately. You either need zspages
to becomes empty after writeback or pool compaction, otherwise writeback
does not save any memory, no matter how fast it works.
