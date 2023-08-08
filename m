Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9B6773CC0
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231940AbjHHQJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjHHQHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:07:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 117F97687;
        Tue,  8 Aug 2023 08:46:04 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe2fb9b4d7so49553135e9.1;
        Tue, 08 Aug 2023 08:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691509562; x=1692114362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bzr4izHyCfSSAQ6X8x+9E1FZkkTrDyVAaEWH9zW6RUk=;
        b=TZrSQBibATn7GwTKQ0smWjnOrLnG6xeXxfiTR9NWC4aCbpvsWX4dDqdmAizcgH91QR
         yMvh8ufu2d900rW6i+WN4z3znZ13+saIWpzNZjWU7bPeesle+1UBKnHXOHwh/YUOIwdG
         MX8mHGCwVl6RaDN3OLKUx2Ttg0jbfP44nPqkaHu1O5o4j7XY8Zrj3c1k16AkmSo4Jn0s
         cv5GVxro0gpFGLGMZOh7fhpQ4sa7+//29aMrxSk1DJWDW6PeKOn41njQFYluo1ksSyBY
         vresofVgI/7/gn0KaqN+DK5B5P41tYF4kS5gtifNYslVxSTqj8CyZl/HDCTLNZ9k5VPb
         q4jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509562; x=1692114362;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bzr4izHyCfSSAQ6X8x+9E1FZkkTrDyVAaEWH9zW6RUk=;
        b=dnuFlN5aL0CqQsDBJt6B97oaMDPUAGWBuRsG5+wolKJU8hhh62Vo6YO50UkJTQU6im
         kv5sFO45bb9i6lNfxTSJ51G1pX8HU80mYj2/ZT00Kkfhbv58+9OGUh9/sDWzqRrGGAG4
         dq4+yssnkCaBjDtWryIwgWVxdlXXYdP5Hgl60sK6mZd2N+3qDJAMQfuLmNksN9uNedkt
         k3KX9j2AUVQRCZbmX39ie+zIKq1B2Jum28/kz560VobNya+lgS+M4MWCntbeTc60+MaV
         clZG+2I2/CaZ2RxWGYinRZYe/Vx1SFuyROhDZU31hLSntyqK35SsewwF8IB4Gz00XNvd
         Synw==
X-Gm-Message-State: AOJu0YyMB9B7EKcgABvUevC6hDUrC4K6rniz5P9ZvMdDb2frtovxpb6v
        yEUAeZojKiNZlgBqIXCGsK145T/RZ9It8HLJqIW1HRAgKiYnZA==
X-Google-Smtp-Source: AGHT+IGjktrjpcE+E06+IYNOGmUZiIovDW6ArkQ78VI6Jn9wdJ6xGENwhzCrq0lt2XTfFzOvbxO4F8pkM3h03Hq92Fs=
X-Received: by 2002:a5d:53c5:0:b0:317:5b1b:1a3c with SMTP id
 a5-20020a5d53c5000000b003175b1b1a3cmr7263549wrw.38.1691475806660; Mon, 07 Aug
 2023 23:23:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230726125655.4197-1-dg573847474@gmail.com> <169146257041.4040705.14041298485588180339.b4-ty@oracle.com>
In-Reply-To: <169146257041.4040705.14041298485588180339.b4-ty@oracle.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Tue, 8 Aug 2023 14:23:15 +0800
Message-ID: <CAAo+4rW25aSx_z4eDyHGF7g37d28OSU_wYzj5RV5ta9HkL8e+Q@mail.gmail.com>
Subject: Re: [PATCH] scsi: qedi: Fix potential deadlock on &qedi_percpu->p_work_lock
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     njavali@marvell.com, mrangankar@marvell.com,
        GR-QLogic-Storage-Upstream@marvell.com, jejb@linux.ibm.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the review.

Best,
Chengfeng
