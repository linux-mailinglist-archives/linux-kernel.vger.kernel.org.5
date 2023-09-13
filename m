Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 873EF79DEB4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 05:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjIMDmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 23:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjIMDmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 23:42:00 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8AE1719;
        Tue, 12 Sep 2023 20:41:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1c39bc0439bso3957285ad.0;
        Tue, 12 Sep 2023 20:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694576516; x=1695181316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LqjFcx0difFSXNYkuxHkJeUyxeJr++2ATcFZSkOlwes=;
        b=TjWQI1WMDzwpC6MMgaEHIfnsRbnkG/G38vPDi91XqsLdVHhAZAF/UHdWbOS+Ztt9zc
         gz412PiQmaCwVzmT5XWjCdhOlsJBt04LInAQ8J6aPTgm52O7lLWsW0JxcGD52ZPhn3KU
         NB2OkMXboQDQe7Rak99VqHTraNWkE1Wgv+wOVR3m3XKC03K2qMfipmnIoedzziNxZ2Sh
         noSK9Back3Mt0fRX/z2ZMYZWbQe5r//3k9HJcPNhCkROf2DIJmAo7NNI9ARkHrZd9pSe
         sE2bCxbw3TYuW2/Elffnm2rca4NBQiLr8xK0XIHTFZq6SX9L3twTaj0Qyk6uVZd/nL73
         3nNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694576516; x=1695181316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LqjFcx0difFSXNYkuxHkJeUyxeJr++2ATcFZSkOlwes=;
        b=uryQZleJPu2M7E+wiJMei+S2T7fUHEwEHEpQn80N7GK/FF5kyvlTKmaJGr6DR1dDvQ
         ks1BD5Hch6soh04wUAqd80pGqz0KpCHNbfEeaJSUjHmOxzF1qnoNeUezGJQAx6bKTuyn
         WpOxHwnqqO/n7YJgf25SS22Nd+TsDWds07RP9aGbsYhOMPcB4Hwr0GN7XuvK+V6qruZQ
         SwUY8Kw9bHTpeQTbs0CtJ27tR+OP+3oelRDU7rliRFq60BiZfIehCRL5/8VU87EZvHnP
         ZNT3lSdaqOmFfMlCLWknjOdhAzR+xUq4bkbUPAKRJu4zGHAZCO8tkVRF929LgEKc9ur+
         zGwQ==
X-Gm-Message-State: AOJu0Yz5VBrDSErfvJ7IMRqL1XMkkH1saQBR+TgzhYcFlC3pbND57zVs
        o9OfLoM3gjwe16xzZBrDZOM=
X-Google-Smtp-Source: AGHT+IHBQMxHj4Mjd1Fiz//fG4R6JtgA79ayURCpPuJ6MYkmK8KT+m4GW6GEIVlCeufWjHDeUbZDcg==
X-Received: by 2002:a17:903:32c8:b0:1c3:9928:7b28 with SMTP id i8-20020a17090332c800b001c399287b28mr6337717plr.6.1694576515678;
        Tue, 12 Sep 2023 20:41:55 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.163])
        by smtp.gmail.com with ESMTPSA id p5-20020a170902eac500b001b567bbe82dsm9238915pld.150.2023.09.12.20.41.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 20:41:55 -0700 (PDT)
From:   alexjlzheng@gmail.com
X-Google-Original-From: alexjlzheng@tencent.com
To:     david@fromorbit.com
Cc:     alexjlzheng@gmail.com, alexjlzheng@tencent.com,
        chandan.babu@oracle.com, djwong@kernel.org,
        linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2] xfs: remove redundant batch variables for serialization
Date:   Wed, 13 Sep 2023 11:41:15 +0800
Message-Id: <20230913034115.1238353-1-alexjlzheng@tencent.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <ZP45/7KfB0sHuCIk@dread.disaster.area>
References: <ZP45/7KfB0sHuCIk@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Sep 2023 07:49:51 +1000, Dave Chinner <david@fromorbit.com> wrote:
> On Sat, Sep 09, 2023 at 03:17:51PM +0800, alexjlzheng@gmail.com wrote:
> > From: Jinliang Zheng <alexjlzheng@tencent.com>
> > 
> > Historically, when generic percpu counters were introduced in xfs for
> > free block counters by commit 0d485ada404b ("xfs: use generic percpu
> > counters for free block counter"), the counters used a custom batch
> > size. In xfs_mod_freecounter(), originally named xfs_mod_fdblocks(),
> > this patch attempted to serialize the program using a smaller batch size
> > as parameter to the addition function as the counter approaches 0.
> > 
> > Commit 8c1903d3081a ("xfs: inode and free block counters need to use
> > __percpu_counter_compare") pointed out the error in commit 0d485ada404b
> > ("xfs: use generic percpu counters for free block counter") mentioned
> > above and said that "Because the counters use a custom batch size, the
> > comparison functions need to be aware of that batch size otherwise the
> > comparison does not work correctly". Then percpu_counter_compare() was
> > replaced with __percpu_counter_compare() with parameter
> > XFS_FDBLOCKS_BATCH.
> > 
> > After commit 8c1903d3081a ("xfs: inode and free block counters need to
> > use __percpu_counter_compare"), the existence of the batch variable is
> > no longer necessary, so this patch is proposed to simplify the code by
> > removing it.
> 
> Hmmmm. Fiddling with percpu counter batch thresholds can expose
> unexpected corner case behaviours.  What testing have you done on
> this change?

Hi, Dave,

Thank you for your reply.

I have tested the patch using _filebench_ and _fio_.

In fact, corner cases often occur when the addition function and comparison
function use different batch thresholds. This is why the batch parameter of
the addition function must be chosen carefully when we use a additon function
with a variable parameter *percpu_counter_batch*.

The percpu_counter_compare() with variable parameter *percpu_counter_batch*
was replaced with __percpu_counter_compare() with fixed parameter
*XFS_FDBLOCKS_BATCH* by commit 8c1903d3081a ("xfs: inode and free block
counters need to use __percpu_counter_compare").

Then there is no need to detect the batch threshold. Just use the fixed
*XFS_FDBLOCKS_BATCH* to simplify the code.

> 
> Cheers,
> 
> Dave.
> -- 
> Dave Chinner
> david@fromorbit.com

Best regards，

Jinliang Zheng.
