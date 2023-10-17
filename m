Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CD7C7CC957
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 19:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbjJQRAs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 13:00:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbjJQRAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 13:00:44 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BCBD102;
        Tue, 17 Oct 2023 10:00:43 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id 3f1490d57ef6-d77ad095f13so5985771276.2;
        Tue, 17 Oct 2023 10:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697562042; x=1698166842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sfOHkZ34E86vmJaFpGPJUCgLZ0S7VG6ME9bd2Mw/kBU=;
        b=dHzR62meExQmSexGEdtAS8R3DFPMCro//1GopyDoaGP076HgtUou01EjjsjlOy5sL2
         H0m4vfA0/LYI3YqdDOFngX1lAfCkx6MV3Jyom1sBZSN51eV10XoaD8ts6er/zpOSLb+e
         LcMgCv7GCbX8l7+JKFw+3oYtnooPZnKg5H9e7d7vQ6eyOG+uLsn9Cnaf4u6GSy1wvm9F
         SyrtHjWneNIHbJb81GPM1kV0M6U2yn6Zchv8PuKnpIWSnJHTXE+veaLkLNJq0t26x4L5
         y5Fqc8vfTH73aa5IvAYzOTb+hSqWub/ga1hTAhV0gKezPXoIBgf1qdwOINm+TGn3VFvs
         TV6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697562042; x=1698166842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sfOHkZ34E86vmJaFpGPJUCgLZ0S7VG6ME9bd2Mw/kBU=;
        b=VpFqMOldIvmCWZS9va2wPmklk/QcnRLnfkvVz51n1NA/pifHUjqyvfBmzWlqBLg5tp
         K3hN84Y5y8ga6CjRZdXiAEDgFkYzEIyjE3FB52QDt2OQKzFTNSwai3IAp8j6SiPth1lC
         dym0/FXZNDwTOwIc/GIxzI8MFcalt7OaVpYJVjxdcd8Wvr0P52mM7d3EBu4kkqSLR0Rb
         W5XSksKltsBb/rVZ07KNoAj+F5nGjR3c+R275i9WeGP+8n2wCjeEDw54IAEVXeQS/yEA
         T8sP7NUbC3AjqKkofGTscpJXHvTUnT1lrMamPiiSBysBSDVCO4RDzQjdXiTz/XgORcwA
         O57A==
X-Gm-Message-State: AOJu0YyU2fec32XRacmvWj20dRzOyHqy51jrdGpaqmBLGGSkLVsIpObg
        qbfC7Umb40gBRH+RY2qKHSwxG+3SqsbQBiCLZoQ=
X-Google-Smtp-Source: AGHT+IFu2o/JDsRiYMJX7BrU6Y4pBF3px6Ls42uwN+rqDNcb+R2p4+elMC6mZFUDVZQ8v2UNMZMLljpk0IREjA0SPh4=
X-Received: by 2002:a25:e057:0:b0:d0a:fa7f:2fbf with SMTP id
 x84-20020a25e057000000b00d0afa7f2fbfmr2677012ybg.48.1697562042319; Tue, 17
 Oct 2023 10:00:42 -0700 (PDT)
MIME-Version: 1.0
References: <20231016020314.1269636-1-haowenchao2@huawei.com>
In-Reply-To: <20231016020314.1269636-1-haowenchao2@huawei.com>
From:   Wenchao Hao <haowenchao22@gmail.com>
Date:   Wed, 18 Oct 2023 01:00:31 +0800
Message-ID: <CAOptpSMSpuU_NDKNPKRk1ZS76KhOfCmSeB7YxbD6jvNpvNGZPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] SCSI: Fix issues between removing device and error handle
To:     Wenchao Hao <haowenchao2@huawei.com>
Cc:     "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        louhongxiang@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 10:04=E2=80=AFAM Wenchao Hao <haowenchao2@huawei.co=
m> wrote:
>
> I am testing SCSI error handle with my previous scsi_debug error
> injection patches, and found some issues when removing device and
> error handler happened together.
>
> These issues are triggered because devices in removing would be skipped
> when calling shost_for_each_device().

Friendly ping...

>
> Three issues are found:
> 1. statistic info printed at beginning of scsi_error_handler is wrong
> 2. device reset is not triggered
> 3. IO requeued to request_queue would be hang after error handle
>
> V3:
>   - Update patch description
>   - Update comments of functions added
>
> V2:
>   - Fix IO hang by run all devices' queue after error handler
>   - Do not modify shost_for_each_device() directly but add a new
>     helper to iterate devices but do not skip devices in removing
>
> Wenchao Hao (4):
>   scsi: core: Add new helper to iterate all devices of host
>   scsi: scsi_error: Fix wrong statistic when print error info
>   scsi: scsi_error: Fix device reset is not triggered
>   scsi: scsi_core: Fix IO hang when device removing
>
>  drivers/scsi/scsi.c        | 46 ++++++++++++++++++++++++++------------
>  drivers/scsi/scsi_error.c  |  4 ++--
>  drivers/scsi/scsi_lib.c    |  2 +-
>  include/scsi/scsi_device.h | 25 ++++++++++++++++++---
>  4 files changed, 57 insertions(+), 20 deletions(-)
>
> --
> 2.32.0
>
