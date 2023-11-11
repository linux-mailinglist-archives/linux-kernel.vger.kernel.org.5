Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572707E8923
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Nov 2023 05:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345748AbjKKEaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 23:30:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjKKEaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 23:30:08 -0500
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11CE63C30
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:30:05 -0800 (PST)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6d33298f8fdso1461684a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 20:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699677004; x=1700281804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=qbEMuqKiRO1Bmqqs4mp6AF0/3oi8wc7b0yDR5qPsAek=;
        b=A/5eaJzCFchnJt2hoFn/OBxwJj35awiYkZGprGxnTWOTxMx6dPE/xOFlZyREmdyPrd
         Ri2bZwJw7wSw99s44DMhMtzafSHn+17Kjmp4GNIlUDQ6XWQhQa7fLQsYY88FIeevk/YL
         /spMLMkouEQ4feWjnlOm1Cx2LkFae7cA4Scd//wKDm9eogYrZMPgbNJornESrO8dbkS5
         jLjioMLWe481NNylyrJXd4Yv07ggwuNtaXXBA5MwCT53YQ9jTOrGiYoBjo6SxJTsmMEx
         VxECc+nC+HdZbIvKRhOGykdKf7x5n+4a6+sOoVuwbKP9IExd8EgkeDiHEfbo+USsR2Ny
         F5SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699677004; x=1700281804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbEMuqKiRO1Bmqqs4mp6AF0/3oi8wc7b0yDR5qPsAek=;
        b=CRwiznBSWytUiW8+GXOi3TIuAi2USxaQDG7UXeQLMmUcQw06uo+393krfCWSDi5yBY
         x98XVbEY7IMBjM6k5NbLCNHHIS6hs7lcMbNJbxk41uDoxIxGXiZRbfvZjQs7ZQobN+HC
         ojW/Bt7v3xD/PsW+sjEhs7dhC2YbUHP6gfNFi/uKO5pvN4vWMPSlsPO2zBZu3//3o4m9
         8Y+pgmelNrvIeHg5glIjKvAJLAn8IaDztQAu1RWECYebT8BImcWMmtMoCf5Siu72s5MF
         zdrfeUWPl2+O5/2CzU052pd66EgisOj5QmbjZGRPt4d32N9/OsPrNnmQ1lgnKi+ZJM0F
         7jRg==
X-Gm-Message-State: AOJu0Yw+/wp2YnR8ZNYNN12V0ZYvcMRMYcyXcyFqkdRdTZoe/gV1A1Hh
        FTVVEChfgZrDh+7LuyqEJO8=
X-Google-Smtp-Source: AGHT+IHOe1HBDh7zJVpvbDhWnWNvgk48cuwtImFRumXvct8eYDMrWuFc6b5vdq+M/ULV1w2+F2dMzA==
X-Received: by 2002:a9d:6847:0:b0:6cd:a989:c7ea with SMTP id c7-20020a9d6847000000b006cda989c7eamr392942oto.16.1699677004262;
        Fri, 10 Nov 2023 20:30:04 -0800 (PST)
Received: from macbook.lan (119-18-27-45.77121b.mel.nbn.aussiebb.net. [119.18.27.45])
        by smtp.gmail.com with ESMTPSA id a8-20020a1709027d8800b001c74df14e6esm469672plm.51.2023.11.10.20.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Nov 2023 20:30:03 -0800 (PST)
From:   Andrew Worsley <amworsley@gmail.com>
To:     Thomas Zimmermann <tzimmermann@suse.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org (open list:DRM DRIVER FOR FIRMWARE
        FRAMEBUFFERS), linux-kernel@vger.kernel.org (open list)
Subject: 
Date:   Sat, 11 Nov 2023 15:21:21 +1100
Message-ID: <20231111042926.52990-1-amworsley@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
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

   This patch fix's the failure of the frame buffer driver on my Asahi kernel
which prevented X11 from starting on my Apple M1 laptop. It seems like a straight
forward failure to follow the procedure described in drivers/video/aperture.c
to remove the ealier driver. This patch is very simple and minimal. Very likely
there may be better ways to fix this and very like there may be other drivers
which have the same problem but I submit this so at least there is
an interim fix for my problem.

    Thanks

    Andrew Worsley

