Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B059B7A4F7F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 18:44:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230490AbjIRQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbjIRQoU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 12:44:20 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40CCC5580
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:01 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-404724ec0dcso12306445e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 09:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695055379; x=1695660179; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EDTSwwfCQFc0vmO7Ha3nLis2+qn7gif0VNZaosxPawo=;
        b=JmreFbHKssr/wm1ISd1jHztuTHPKsmpebn+gLRSNXqoKP+qDCW5LCxDuEz171pLo5U
         ZJoahYEm1a2F1084e/DllgildXJRmvQSXsvvAQ66niLS4CNYd07eI5rdK5Kqvy/pqBro
         Q3t4tbLdz46EbGa/bEXGE7qEq2hP+8ldj3w5j6hcKKhLUn8b/9inoCb93sAhuFO68Qfh
         z4+1gusXbTR/F167IdtMbPjzuekTcrikPElCJagcNtZ8N04cDIlzmnhc8YNVe/qRecUV
         mef6nkou0+Pd9WY1fR6dD2N4DvvifBRgujs0laHABqSFFFxqau4ifplE8TNavZmo02gN
         ZCtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695055379; x=1695660179;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EDTSwwfCQFc0vmO7Ha3nLis2+qn7gif0VNZaosxPawo=;
        b=MEXeXRUch5G3gSyt0N10hTy+8j+ajbNAM0kutlxjA/8sV5cV6GerKRrvWAddJY7dDC
         COXTvSFG1DBrXph3oYPKHB8cqaaX3o7HyE1fZmOyk75yiPieVcAeiDq0hQWpwOhh5O9S
         mpFkNvjrVjt+tdpA+51jkP0UZRsrn7XXVkJ5QYL2bIFnXYI+5f4wqBDZATIh+1eqCSE6
         O2aHy1AMeLuCfKKd622Beg6+Re+fTKHGuqqD4w03c9gQUEPu/kBLgEzkGT0fcbgC5JHe
         4v+3hIbM7AI/CqIBEZBeGinbOyihByMr1/5bZ86jzB6xfik5W/zcQZwJtyJZ+qY88L3l
         mlxg==
X-Gm-Message-State: AOJu0Yzcf3SLP49+LMtUnvSTnTKVqn3H/j110yUv/HR7I06dJRmZTUD5
        F5VYrVb+B9rhhRJ7y0UG834=
X-Google-Smtp-Source: AGHT+IFXAoQ34PmkD7q0JyA0ClZNbVO4TwQAep6C/1S/IX2myp8KPe+TcLuHIiqkkJZMpOi9182u+A==
X-Received: by 2002:a05:600c:5006:b0:404:7606:a871 with SMTP id n6-20020a05600c500600b004047606a871mr8816012wmr.2.1695055379264;
        Mon, 18 Sep 2023 09:42:59 -0700 (PDT)
Received: from matrix-ESPRIMO-P710 (p579356c7.dip0.t-ipconnect.de. [87.147.86.199])
        by smtp.gmail.com with ESMTPSA id m7-20020a05600c280700b003fed630f560sm12829863wmb.36.2023.09.18.09.42.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Sep 2023 09:42:58 -0700 (PDT)
Date:   Mon, 18 Sep 2023 18:42:56 +0200
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] staging: rtl8192e: Fix alignment of structs and
 truncated writing
Message-ID: <cover.1695054044.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix alignment of structs and compiler warning truncated writing.

Tested with rtl8192e (WLL6130-D99) in Mode n (12.2 MB/s)
Transferred this patch over wlan connection of rtl8192e.

Philipp Hortmann (2):
  staging: rtl8192e: Fix alignment of structs in rtllib.h to two
  staging: rtl8192e: Fix compiler warning truncated writing of
    iwe.u.name

 drivers/staging/rtl8192e/rtllib.h    | 14 +++++++-------
 drivers/staging/rtl8192e/rtllib_wx.c |  2 +-
 2 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.42.0

