Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC4B87CFFDA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 18:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345100AbjJSQno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 12:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232326AbjJSQnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 12:43:43 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A13A11B
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:43:41 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a82f176860so79046627b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 09:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1697733820; x=1698338620; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=v/PWIrwK7yjVyTLCrAnW4DXLe2PtvDZ2eghjerodrKw=;
        b=Ac/em7+OEM6sju6lbQRfRMeQVVyk2AwDXXeZz4LwYp8iWrOzHSMWkzk6afpfJQofyZ
         PYFTlIjJ4S59e9RC/qJXQBuxFDhpO0InVlMlUteY1hjSwIxhhX1JtGQ7p3Rs7ER6v7DA
         xiv7GY16XY58CCpZS7VR3gZxTCxVWznXzy6Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697733820; x=1698338620;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=v/PWIrwK7yjVyTLCrAnW4DXLe2PtvDZ2eghjerodrKw=;
        b=rfVCp9d6kTiERbYQuJbF3gme9kaXp5GkdH19Vns6gj/oCNvceWycLvMPbqUIJe9j/n
         BjSU5cfCsAwH+tvMUtULC0h5osgivqnUkyyHEHOOG6CCkPU+jAmITapvX65mbIHZpMfs
         bMcxXU7611T3bKdxzHbK7V6QN0w3Kjg3/MpyGFQCz4mi35d+29Z+Us6CIqRg/s+2yZcx
         lazHSXALPBlztXRnaPXokke/HIwyIuwERe2jy9qm32kXmb7lD4iKvnd++ey/WLkORDt7
         D2Wo8/IxDsEjsUD1Dehfr7W84t4PhvTpGYsT4zWNtEsjzlh5II6H1uyL1sBNyN9YEhJb
         5yfQ==
X-Gm-Message-State: AOJu0Yxh8qnpz2rWiOev37leZp2A0kPNXhRJRQ38AOh4OjQgo6wq83vI
        SJhf1cVVOtDupJ3G/nUVA78HUcUeLNVcqcEkgXjLYA==
X-Google-Smtp-Source: AGHT+IFd62ic0pQJCqoncPJxXabGcZf4KKud86nThgMjLPEjjH97+UYqiqAisRJM3jhW+CQVFLq1IPqoZ7FHOmR54B0=
X-Received: by 2002:a0d:d789:0:b0:595:8e80:30ef with SMTP id
 z131-20020a0dd789000000b005958e8030efmr2679766ywd.51.1697733820608; Thu, 19
 Oct 2023 09:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20231018235944.1860717-1-markhas@chromium.org> <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com>
In-Reply-To: <7b08520e-8f36-45a1-9b7a-316a33c8e8c4@linux.intel.com>
From:   Mark Hasemeyer <markhas@chromium.org>
Date:   Thu, 19 Oct 2023 10:43:29 -0600
Message-ID: <CANg-bXDvZ00ZHEgbUf1NwDrOKfDF4vpBOxZ4hGEp-ohs6-pZpw@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
To:     =?UTF-8?B?QW1hZGV1c3ogU8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>, stable@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Brady Norander <bradynorander@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Mark Brown <broonie@kernel.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I would assume that platform that has DMI_SYS_VENDOR set to "Google",
> also has DMI_BIOS_VERSION set to "Google", so perhaps just replace
> DMI_SYS_VENDOR match with DMI_BIOS_VERSION, to keep table small? Or is
> that not a case?

That is the case. But I'm inclined to keep it for two reasons:
1. There is precedent in the kernel to use DMI_SYS_VENDOR=="Google"
for Chromebook detection.
2. If the coreboot version schema for Chromebooks were to change, this
check would fail for all JSL Chromebooks instead of just a few models.
