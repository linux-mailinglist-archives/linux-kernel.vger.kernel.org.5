Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F69777F177
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 09:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346365AbjHQHtA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 03:49:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348624AbjHQHsf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 03:48:35 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D606F2D70;
        Thu, 17 Aug 2023 00:48:32 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3178dd771ceso6523702f8f.2;
        Thu, 17 Aug 2023 00:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692258511; x=1692863311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wKt5VMyKNFNEE81rex7AGLsz6J3VT0uYRT93t4kZwFQ=;
        b=X0y/helmEjXtNL6SazTR10yD5RobrYhztvIiEN/ojgR5vz50pS1ieUlTDMq1KyWjl2
         SjKEWIfIBKF6d22jIb529rTy7swfyPqt9W0IhqQURhOZmirFJFvdlO13YSQ3jzZ1Xcep
         l5f0rneJY/WpOsSGNDyS05pL3xk2YfLI1OGeIqs43h5wYvrO+J9o3+DSQAcUI4hl+V0e
         WvZm/JrKktY8RetiMhORdlMuIlUwQsTOvFVFzqu5z6HAhGiotGW3dntVi/j7cXV+eU7A
         5UR/0yyps2ior2CwpLhbtWLMrUHkiyqjUX4ZcCbb3Ma3fIxnjknEKzVETxKHhlK0tPd1
         X/Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692258511; x=1692863311;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wKt5VMyKNFNEE81rex7AGLsz6J3VT0uYRT93t4kZwFQ=;
        b=JwTktqC7LuE9bnz/f2byggvMVXkaXmAWlPFqsjdb8GVh4hi64T04mFOCLS2fSp3dRt
         KhImuPLQXQ1tkg9n7bP9hmxl5sfPJtzoIpk8El/nGJkpZa9iBouNtNWoZKxR1Av65mll
         nfzgjMIbGyY+nSTJUEYZ08RtFYIHNJBEO9foI78N701ySehD+TDdu8fYYQ0eCsAF9/RZ
         Rw2Zy9/TN/QWz0QB6TXD8pW4K1TCPaTtU+CQR1SEX0mrsiTJXjTdjuwj2K3Jl7S03Gh6
         7UPv00nU6g/Iq1rglsl1EfzVYwp03IJ24EOw60JuA1lVFuw6D3lftfoDVvETutnwEfYI
         sR+Q==
X-Gm-Message-State: AOJu0YzSprmq8DzzW+Ezi/5aldkhjou1EpvEcLCdiKFS25pJBFigmkIY
        S0FISmUEftp6GQZaiR/2R/iIYNBirNx4FM2NO7w=
X-Google-Smtp-Source: AGHT+IGyxOxr44x90Oh13zTJul7HsGYJ4D6EsqapQuOad2y7CbsdFvThk5ejL/vWF3IyT2SG+2Dbn2mdrffahyvqeBg=
X-Received: by 2002:a5d:42c2:0:b0:31a:d4d0:6e98 with SMTP id
 t2-20020a5d42c2000000b0031ad4d06e98mr1271936wrr.8.1692258511145; Thu, 17 Aug
 2023 00:48:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230816155524.5913-1-dg573847474@gmail.com> <20230817065211.ajz8zcev@linutronix.de>
In-Reply-To: <20230817065211.ajz8zcev@linutronix.de>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Thu, 17 Aug 2023 15:48:19 +0800
Message-ID: <CAAo+4rVzgdAsbj7Nrd32BFBsGY1YBBh18v9vF0xH2jcWoPgivA@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        dave@stgolabs.net, satishkh@cisco.com, sebaddel@cisco.com,
        kartilak@cisco.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So you did not use lockdep or is the code path so unlikely that nobody
> stumbled upon it before?

I think so, the lock acquisition inside the interrupt is guarded by an
"unlikely"
if-branch condition inside fnic_send_frame(), so it happens that no one has
encountered the problem so far by using lockdep.


> Fixes: 794d98e77f590 ("[SCSI] libfcoe: retry rejected FLOGI to another FCF if possible")

Just sent v2 patch to add the fixes tag


Thanks for the review,
Chengfeng
