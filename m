Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A3D809536
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 23:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444109AbjLGWTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 17:19:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444099AbjLGWTk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 17:19:40 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A817E1713
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 14:19:46 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5d3758fdd2eso13671317b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 14:19:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701987586; x=1702592386; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n29wcNbg5W2ULSKtYxVWR9CYTbMdnhOAqjz6tEmiHCQ=;
        b=k+xxLbslQTaDIzoJg++ZLHevAw53dtwUOkntQWtvUWrXoN1IxzgsTCRzBn7Jtw9gZH
         F5x6tsc7kA30e7CdOE9LYdAvgJuWSMStNO5LT9L8cTmjY+fHdiJFICcBYgin5+Yl8L+n
         LMgGonyveA66woAy/GQ/a/isPT9AlQZ8vgyPyQNT/EDwY+ru2tJn4IlgrhLxFXiY97oa
         PSSZ4v2qLljknsGTicOS6OR+IPzhD7TMQXXvN5rAQFsGt73GHsWm2pk6Tv1UmNx3QTTo
         O969n7Zd0qbCldAlciGgeSx0Sctof3uYKuX+WpQk9ra365cfePEs8vmQibHnUODoCny6
         4Jvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701987586; x=1702592386;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n29wcNbg5W2ULSKtYxVWR9CYTbMdnhOAqjz6tEmiHCQ=;
        b=bF1B5uawkpOBvdy5YOy5DHLFawVhnuyWvufdTM+iEyYAfiKGcQluLw6sysriAJGmjR
         qxiFVmDWenoCSJWVV9hAxs2YiMWl8lFi7YejJ1jPJY9ig1n8xXH8Sa0R5OT23tNQ41NM
         +KUuv31RhNP5q6AR6AVzNuOnRnW2yyfxOlujHWHkXjYNdWbG/XFjERQ3fDaXOs2zCR+/
         DN7FQ7SObQ4Lv3Y9s3WJvWcySslsdJumhi1iUHVIzCX/IQP3AsJh8oGs6CJ5Nc/gYMU7
         3mw0zJBGPfIKiPAFSBeSnUnZF0W2fRmTA593Ls01wIeN92+Z5ZUznMGCDF5ed/59ulyi
         mckA==
X-Gm-Message-State: AOJu0YxLBYQDm+USscQ6asTeiKo1VMJkNMaOLIAXZHcPcwNZmEITAXxp
        aEoSblVfHOcAp3r6aABqs18=
X-Google-Smtp-Source: AGHT+IEJI2uaHbLPVto4X7Pn3vIIv+Dsggz0zzq2TR3bsm0atrnNIUgxUDV9+Ju4lCditYeHVxBylg==
X-Received: by 2002:a0d:ea88:0:b0:5d7:1941:356f with SMTP id t130-20020a0dea88000000b005d71941356fmr3180366ywe.86.1701987585799;
        Thu, 07 Dec 2023 14:19:45 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:8f7f:efcd:5388:af4f])
        by smtp.gmail.com with ESMTPSA id u134-20020a0deb8c000000b005d3f531a37asm204223ywe.85.2023.12.07.14.19.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Dec 2023 14:19:44 -0800 (PST)
Date:   Thu, 7 Dec 2023 14:19:43 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH v2 0/6] lib/group_cpus: rework grp_spread_init_one() and
 make it O(1)
Message-ID: <ZXJE/1z5DR8lIBOK@yury-ThinkPad>
References: <20231207203900.859776-1-yury.norov@gmail.com>
 <20231207134619.52545aaf4e5f393618a92c41@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207134619.52545aaf4e5f393618a92c41@linux-foundation.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 07, 2023 at 01:46:19PM -0800, Andrew Morton wrote:
> On Thu,  7 Dec 2023 12:38:54 -0800 Yury Norov <yury.norov@gmail.com> wrote:
> 
> > grp_spread_init_one() implementation is sub-optimal because it
> > traverses bitmaps from the beginning, instead of picking from the
> > previous iteration.
> > 
> > Fix it and use find_bit API where appropriate. While here, optimize
> > cpumasks allocation and drop unneeded cpumask_empty() call.
> 
> Thanks.  This isn't my playground, but I'll grab the patches to at
> least get them some testing.  Review from those who have worked
> on this code would be appreciated.

Thanks you!
