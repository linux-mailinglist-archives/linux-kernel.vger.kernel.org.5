Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8611F77E5BF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 17:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344441AbjHPP53 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 11:57:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344417AbjHPP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 11:57:20 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F41DF;
        Wed, 16 Aug 2023 08:57:19 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-403e7472b28so40632191cf.2;
        Wed, 16 Aug 2023 08:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692201438; x=1692806238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YshRgUB42I9mCVAZnPFCJJH7vWJCFrGt7B+0D9K2FHc=;
        b=LP9nnBbHakxS09pZVZ2gBHC+peyKU0gOYuqjFn7SksQZZpRWPG5saCa+UXohTYmLEy
         n1hlLMckND9GkOtQ7icnxOIiGD+mVZaD/r+oVanRamsuzYM2HSVrk4Wwc2znav/mscXl
         dFaVVyt2owMVBXxfoyGPTrwBS9q9t6XkbfKxZDmrG+rmJ1UXEHb3sdffiP43Kqf/UzSL
         DubrvbeKyIi9fWdWmTf8CUANPGIUXBVJ2nX3AzJqGIXFtW5tNGC4F5e18V8cNRxSSX/C
         +FcbwdxhOkpwm3Be2JJuLgSp6Q/qbkLa/PzrliweDAQ6W9qf+ZcQicOJXEq+mLycsLR3
         hvLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692201438; x=1692806238;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YshRgUB42I9mCVAZnPFCJJH7vWJCFrGt7B+0D9K2FHc=;
        b=QUCkjLaDdIOQPMPvzTsuNQfW/A3Z0kEEfftDCewTiWFE5F6U4axif4/L5ihbybToq/
         p8RtfhHwMUtRZIx4wynNcV/r9HNxjBvhEu8O/n/vQ7PijqnA7Xc61xxgABAcfyTyUvlT
         G2oz4Ab9jOTmxQ1pdJovklRZiYBznjvJCcouirJWDnvgywJ1zx/0y1RTqC04zy0mC/wT
         EuHq+PJdvL3FMJfaD1kzNhFuLnsOU1OVYeqlru7lfKMRSAnlDiPW5QlA6cGy1CCY3pO8
         5i+2+3Ui1NHAPqxK36UkQYyQu9m/akic1kEWr67HrxwpL2qIPtxAS9Cnybqd1WoZnpPi
         kKgg==
X-Gm-Message-State: AOJu0Yy96pc2oCS0XnXN2YdeR8tOFY74Y5MlNJuyaWys08Vk+YwhfW4X
        7xRo5dcduUfRIB0gD3DqDMa14TwkwMV3Mlnr0h8=
X-Google-Smtp-Source: AGHT+IGG/ZbzEPA/0Evt2EsGJCpD8qQA4p4zKe5YtgjUXsEWDhJQehuEDFRcejwW8BaQQFy7+/1EJt6ZDJEHMqJHuiM=
X-Received: by 2002:a05:622a:11c1:b0:40f:d4b8:113e with SMTP id
 n1-20020a05622a11c100b0040fd4b8113emr3172815qtk.31.1692201438714; Wed, 16 Aug
 2023 08:57:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230816155524.5913-1-dg573847474@gmail.com>
In-Reply-To: <20230816155524.5913-1-dg573847474@gmail.com>
From:   Chengfeng Ye <dg573847474@gmail.com>
Date:   Wed, 16 Aug 2023 23:57:06 +0800
Message-ID: <CAAo+4rWfz+NvRDkGeS6Qjm_qqaoL3hhH2Knzgcru+FWgpqzGpQ@mail.gmail.com>
Subject: Re: [PATCH RESEND] scsi: fcoe: Fix potential deadlock on &fip->ctlr_lock
To:     hare@suse.de, jejb@linux.ibm.com, martin.petersen@oracle.com,
        bigeasy@linutronix.de, dave@stgolabs.net, satishkh@cisco.com,
        sebaddel@cisco.com, kartilak@cisco.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
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

Dear maintainers,

May I ask if anyone could help review the patch?

Thanks,
Chengfeng
