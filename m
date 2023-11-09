Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 071667E7242
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:23:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344787AbjKITXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjKITXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:23:38 -0500
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F1F1FCB
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:23:36 -0800 (PST)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-586b512ba0aso623512eaf.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699557815; x=1700162615; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sRAqYuB0dg8aj3hzHIpJepiAoEm2PXVbN9qEZ/M71EI=;
        b=hbr5jFeZMz7F5npMFQXrn9L5wmB6WDnE9zp06lFKPQxgOWBNv2tBbgqcL1nbq+3SQH
         6cLEveWTTrVzaW+n1qPrk1A+Qi4I4KYXJzDVuTX7bLbvzRq2e6DHrZB7Do/VCT9Mo7mC
         A03oV82r769lxEyB2CpY1vzhfUr16D6Sma5Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699557815; x=1700162615;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sRAqYuB0dg8aj3hzHIpJepiAoEm2PXVbN9qEZ/M71EI=;
        b=Nd9VCyrZYZEl0aYJ9vKRtaVCQndz3CvxybOLzIWlwzORkH0NbGwgpcOqLjSqGIKgry
         vQMWlO87uz7yj1ySICeQCUkLnZZGRVqQztSovkmkvu34R6FQeOCMsmCQOXWnUEDN0q0L
         POFhtvv1Emams0L6nD9OaDkBJDinEpqyqit8jQaYKe80YPskKLtih1CgM+g0vKZnIHWL
         06DL4XheinDB1WfdJKFB9MPzW71liurvhDFJ2pxDtMoR6bl1ypGXl9ZiGqIZi9fty11a
         UcyD4CsE9Q4CJUkHaZ+ZqR33EIqBRS/etlpB9lycRjq+41HiGJ+926aJGfYRxrBw6NXR
         mRrw==
X-Gm-Message-State: AOJu0Yy0owsbQps+ITrYLx1+jqxLEdAmB9EfSlFbsxihUxHJbM3tsR9W
        8Mm9RcHk2xYENEHueN+txGnvaobZUAtcvM1QJnVWQw==
X-Google-Smtp-Source: AGHT+IElWKoMKHdAlMoMtEggmOnAEElUpDh1SA3LH7KO/ccsuakHXzsbTWI4PgviyHpL9Uc/hBfRqd53PH0BSNOKegU=
X-Received: by 2002:a4a:e1af:0:b0:581:f6b9:30d9 with SMTP id
 15-20020a4ae1af000000b00581f6b930d9mr5515579ooy.8.1699557815445; Thu, 09 Nov
 2023 11:23:35 -0800 (PST)
MIME-Version: 1.0
References: <20231109111934.4172565-1-korneld@chromium.org>
In-Reply-To: <20231109111934.4172565-1-korneld@chromium.org>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 9 Nov 2023 14:23:24 -0500
Message-ID: <CAG-rBijDzoCvNTVMTBP5hwSk6sZ4rZ0QKDzHL-jq-GtP1zr8Eg@mail.gmail.com>
Subject: Re: [PATCH] mmc: sdhci-pci-gli: Disable LPM during initialization
To:     =?UTF-8?Q?Kornel_Dul=C4=99ba?= <korneld@chromium.org>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Jason Lai <jasonlai.genesyslogic@gmail.com>,
        Victor Shih <victor.shih@genesyslogic.com.tw>,
        Ben Chuang <ben.chuang@genesyslogic.com.tw>,
        =?UTF-8?Q?Stanis=C5=82aw_Kardach?= <skardach@google.com>,
        linux-kernel@vger.kernel.org, linux-mmc@vger.kernel.org,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copypasta issue, I really meant to write:

+ /* Bring to consistent runtime suspended state with LPM negotiation enabled */
+ gl9763e_set_low_power_negotiation(slot, true);
+ pm_runtime_set_suspended(dev);
