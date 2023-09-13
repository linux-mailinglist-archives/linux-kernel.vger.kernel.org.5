Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B1179DED7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236651AbjIMD70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:59:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjIMD7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:59:24 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F2E10F6;
        Tue, 12 Sep 2023 20:59:21 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1c39f2b4f5aso24305545ad.0;
        Tue, 12 Sep 2023 20:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694577560; x=1695182360; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dZNXL75OMjXwDkp2uS1JlOeEIcDnxrxKBZJz8t95Odg=;
        b=b8sIabIiko53O7k/6b+6axkWG5ZYZvdR96ft8jUYhRGGNYUKEZr8G0kkJWrSNE0ljh
         mCmVJ6cHnCH1r7fZEM/vMI8a7MME+H327kpsxJhozuH58oGpb+fWA9Opm/bYwlWUUaCa
         iK6jHkiVJ2bn0HZo+rwwYaI4QTbi1Ov82Eyw3CAUeHycg6qnkYswtQAVKcdHyU+wzker
         aDeBr2AvaMykfxfz2vVUlaLizJEZjU6dY+gbX+1tsUxNpDljeZ2g/aEgQxOFG7w7ogQp
         SK0zCWqs58jTNtjnj9SpEUyWkcZoUX59a/adHHDcXnmYag2n1nyRaCWRRQS3FYToNR7h
         FfOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694577560; x=1695182360;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dZNXL75OMjXwDkp2uS1JlOeEIcDnxrxKBZJz8t95Odg=;
        b=IksEJcwz9LcRlx/wjXcviShpclQ6RDAx52pKF078Su1QobyrtF0PfQZs1/cDjflXBz
         nj3xQpNURLJ87sLE3YgKAv6Bx/LPPqoxslTiMNYHxJl1wd1EYnhxg2u6n6O7nkCR7spR
         YzGNNYfkCRXe6XyVlmz7lKIoj3z1cXC5WRWr2Hyu6Xk8a7YMh3KFWbMUfvGX6IbWACvO
         IR7UVnShMPBkbAAqcoRVfjhHU1CaqDyNxKsFW1lQHxR0o0p8foU56R2CpPkW4u9P7m5C
         hM98ABfJqfri+SDHa3eGEmTRuwu0c50QAR6okWeaxcMsit9Fm+tk1ZtrZFGCXro/syf9
         X/PQ==
X-Gm-Message-State: AOJu0YwFKVroA2DCvuz4RsUfF4nLrB/rohIkYuDaB52LVO8IK/hNDxaI
        sD8N2+RwODky4O869HVt9yHmahnlbS6JqA==
X-Google-Smtp-Source: AGHT+IEWW4ZoNw3l5Sy3BpG++G8eCNehbWbCxvhWn8GlOBA+sQZab5nl+5uhxdHddqWX3zyzVv8oIA==
X-Received: by 2002:a17:903:230e:b0:1b7:f64b:378a with SMTP id d14-20020a170903230e00b001b7f64b378amr2111594plh.16.1694577560398;
        Tue, 12 Sep 2023 20:59:20 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id x18-20020a170902ec9200b001bbd1562e75sm9252308plg.55.2023.09.12.20.59.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 20:59:20 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     alexjlzheng@gmail.com
Cc:     alexjlzheng@tencent.com, chandan.babu@oracle.com,
        david@fromorbit.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: remove redundant batch variables for serialization
Date:   Wed, 13 Sep 2023 11:58:28 +0800
Message-Id: <20230913035828.1247566-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230913034115.1238353-1-alexjlzheng@tencent.com>
References: <20230913034115.1238353-1-alexjlzheng@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 11:41:15 +0800, Jinliang Zheng <alexjlzheng@gmail.com> wrote:
> On Mon, 11 Sep 2023 07:49:51 +1000, Dave Chinner <david@fromorbit.com> wrote:
> > On Sat, Sep 09, 2023 at 03:17:51PM +0800, alexjlzheng@gmail.com wrote:
> > > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > > 
> > > Historically, when generic percpu counters were introduced in xfs for
> > > free block counters by commit 0d485ada404b ("xfs: use generic percpu
> > > counters for free block counter"), the counters used a custom batch
> > > size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> > > this patch attempted to serialize the program using a smaller batch size
> > > as parameter to the addition function as the counter approaches 0.
> > > 
> > > Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> > > __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> > > ("xfs: use generic percpu counters for free block counter") mentioned
> > > above and said that "Because the counters use a custom batch size, the
> > > comparison functions need to be aware of that batch size otherwise the
> > > comparison does not work correctly". Then percpu_counter_compare() was
> > > replaced with __percpu_counter_compare() with parameter
> > > XFS_FDBLOCKS_BATCH.
> > > 
> > > After commit 8c1903d3081a ("xfs: inode and free block counters need to
> > > use __percpu_counter_compare"), the existence of the batch variable is
> > > no longer necessary, so this patch is proposed to simplify the code by
> > > removing it.
> > 
> > Hmmmm. Fiddling with percpu counter batch thresholds can expose
> > unexpected corner case behaviours.  What testing have you done on
> > this change?
> 
> Hi, Dave,
> 
> Thank you for your reply.
> 
> I have tested the patch using _filebench_ and _fio_.
> 
> In fact, corner cases often occur when the addition function and comparison
> function use different batch thresholds. This is why the batch parameter of
> the addition function must be chosen carefully when we use a additon function
> with a variable parameter *percpu_counter_batch*.

There is a typo here, it should be:

This is why the batch parameter of the addition function must be chosen
carefully when we use a compare function with a variable parameter
*percpu_counter_batch*.

Sorry, please forgive my carelessness.

> 
> The percpu_counter_compare() with variable parameter *percpu_counter_batch*
> was replaced with __percpu_counter_compare() with fixed parameter
> *XFS_FDBLOCKS_BATCH* by commit 8c1903d3081a ("xfs: inode and free block
> counters need to use __percpu_counter_compare").
> 
> Then there is no need to detect the batch threshold. Just use the fixed
> *XFS_FDBLOCKS_BATCH* to simplify the code.
> 
> > 
> > Cheers,
> > 
> > Dave.
> > -- 
> > Dave Chinner
> > david@fromorbit.com
> 
> Best regards，
> 
> Jinliang Zheng.

Best regards,

Jinliang Zheng.
