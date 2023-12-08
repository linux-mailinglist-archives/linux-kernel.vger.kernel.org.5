Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76880809E22
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233002AbjLHIbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:31:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHIbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:31:00 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D651724
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:31:04 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6cecb004339so609974b3a.3
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024264; x=1702629064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VourKPxg2Q+bxGJMsn8XyNDYrDZ0v8oel3XGmBL1f3s=;
        b=lLdhhauovCg9jvAbiAh5oXevhIXfuTFd5GNpvSvNQYjxSzy4zfniztPZ90/+ulnavl
         XhUIcXtaXK9EYObm6ovz/9DM++i4373bX3cIm9rjLrwP7HsNaE2QU1OEUTrDDh/665cC
         mY6d3Z/XJ1KmVXSO9Ub1YtCW6tSYpVW3pLWedw0Pjn6x30Fr6TVdAft5nRVnTHlafD2x
         J+zhT1VBqCe4S3mXELa6lxEByiOV5r+FSIrJUHSVxPkaY/jaHSvfdLbTnyPFdXR+n1u4
         KlDx154TyYdxlgGzUK4UeR8tgx1tZcJQIUcu4lpO+ifJFppJs82VwBcPt8KTSw0elYj7
         g/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024264; x=1702629064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VourKPxg2Q+bxGJMsn8XyNDYrDZ0v8oel3XGmBL1f3s=;
        b=eymoFc4l0CEt6zCPXOOvq4AcFa0Gbzx1jhAQ4s9T9zDhs/SlOvHjfKJkKOOCrbuQNu
         7DzOAHPD8Wwh1pqXrZFHM5hXE2kJBBw/jd/07rO+kI6Mn5we1V/6gWTWHrsqxLE360b6
         9BydbUGhoD6MCZrTOKQMCFXqPpVnPfcn3xS6bVS17q1QBOlaLgLEqpRK0fKsyNOcdmF5
         1slPTXW0wamGChSq2Uh2VfxI8kKmCZu/NNkf84F2gFpFTaQp8dWqR2XFwugmP5Jc5jSp
         tikHH8jlvLWjHs57ZbuZrzLATExbuUVVeVTSUi7jcaxVW2hLdP21UpmcZzOHtcXLFsj8
         +fMQ==
X-Gm-Message-State: AOJu0YwCc2SA/XwNA3PyhimVxCeuMkgCrfCtJuWgNNmhnJ8EGQYZFK9v
        j+72+HMHgPC359vUL4D9Y9o=
X-Google-Smtp-Source: AGHT+IF1n6V/nOTacXE6nw5HEocHvw9bqJ+ylQdJCMoz10wFi/Q80VgffnCw+4MDtYX4a/ZIb9d6XA==
X-Received: by 2002:a05:6a20:cea7:b0:18b:236d:3f0 with SMTP id if39-20020a056a20cea700b0018b236d03f0mr3085781pzb.43.1702024263874;
        Fri, 08 Dec 2023 00:31:03 -0800 (PST)
Received: from localhost ([156.236.96.164])
        by smtp.gmail.com with ESMTPSA id nk10-20020a17090b194a00b002865781c51dsm2778752pjb.18.2023.12.08.00.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:31:03 -0800 (PST)
Date:   Fri, 8 Dec 2023 16:30:59 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        huyue2@coolpad.com, zhangwen@coolpad.com
Subject: Re: [PATCH 4/5] erofs: refine z_erofs_transform_plain() for
 sub-page block support
Message-ID: <20231208163059.000053ee.zbestahu@gmail.com>
In-Reply-To: <8bdc5203-2356-4a7a-8f26-39fa4b2e2a46@linux.alibaba.com>
References: <20231206091057.87027-1-hsiangkao@linux.alibaba.com>
        <20231206091057.87027-5-hsiangkao@linux.alibaba.com>
        <20231208132031.00003b8d.zbestahu@gmail.com>
        <9ced71c9-4460-4907-abb9-21b517a883c7@linux.alibaba.com>
        <8bdc5203-2356-4a7a-8f26-39fa4b2e2a46@linux.alibaba.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=GB18030
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Dec 2023 15:44:33 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On 2023/12/8 15:34, Gao Xiang wrote:
> > 
> >   
> 
> ...
> 
> >> min_t(unsigned int, ,)?
> >>
> >> ../include/linux/minmax.h:21:28: error: comparison of distinct pointer types lacks a cast [-Werror]
> >>    (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))  
> > 
> > What compiler version are you using? I didn't find any error
> > and
> > https://lore.kernel.org/linux-erofs/202312080122.iCCXzSuE-lkp@intel.com
> > 
> > also didn't report this.  
> 
> Did you test against the latest kernel codebase?

Sorry, it's my testing environment issue, please ignore the noise.

Thanks.

> 
> > 
> > Thanks,
> > Gao Xiang  

