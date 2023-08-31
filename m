Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6E3278EEBF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 15:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344930AbjHaNiU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 09:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344899AbjHaNiT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 09:38:19 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C6BCE4A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:38:16 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3a81154c5f5so430021b6e.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 06:38:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693489095; x=1694093895; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WnfBvAXT1xVE37ZcKh2hKMLAng14FgF20JU9vZkoeeg=;
        b=Y4PUw8aTqFgplFKaVDCn7nNK7UTFSUXtRhH3jPtWkd1iQmLh9vH5XX9+mqQRfvcoka
         NlAiLKFPH12nOnVHzbaRPmAWklKvJQkyQKSdLuwMFITwegNwGScWvarYAyj1hZ+ORWw6
         Uk0eehnWh73fkDdZ4DzOwwbTFS/oxqxd4Zsxk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693489095; x=1694093895;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnfBvAXT1xVE37ZcKh2hKMLAng14FgF20JU9vZkoeeg=;
        b=aYGu5dyMZ/slfNDYwMoy9xu8jLE41uXwZwULjx8uE1P67fLdAlcobMN8v257IDPevb
         1+jI+femiBQV8hl9tKOB8UnmKQ7VA+1AYiozy9l/iPBir36lDmIR0u8xnFxeAFRARUZh
         2eLR0BOhjZQYanITOFxamINuG7b2LbGfmP/+nTJRl1QgY9EEn9wQRy+lnWnlRmuwWL7U
         JlAB/jtgs3+EorGstWvaV16Mb23rrc4XyExgmHZkAGR233YBU8OuTIxj5ahxpYWDnMbX
         4kMpguH39KNgMIz1h/ScJJQ1GozmV705yWWL6Gl9XAktu85evtskAIZkh4EeWP8Acfk0
         OnqQ==
X-Gm-Message-State: AOJu0YypKDdqD6SeW/Onj1Sn6RtDgUfB+wMrJB8CNAxs2mNFh8FEclQe
        HCU5ANXY408nVWrwRVYBT0gggvVtP+kOcER/20om0w==
X-Google-Smtp-Source: AGHT+IFRwYUBge4ieB/At4zcOGYmWN/rQxRgzqgNJfiPCPV89l6sTDHL6sduj2YM3P1+3vEtXtqYKMGsjveoBo/C85s=
X-Received: by 2002:a05:6808:1406:b0:3a4:57a7:b30e with SMTP id
 w6-20020a056808140600b003a457a7b30emr6975375oiv.26.1693489095366; Thu, 31 Aug
 2023 06:38:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230823174134.v2.1.I7ed1ca09797be2dd76ca914c57d88b32d24dac88@changeid>
 <e22c4a5f-c592-7121-7173-eef669ebdf89@intel.com> <f8a6bdee-4abb-b69d-874e-c0a13e2ac4a9@intel.com>
In-Reply-To: <f8a6bdee-4abb-b69d-874e-c0a13e2ac4a9@intel.com>
From:   Sven van Ashbrook <svenva@chromium.org>
Date:   Thu, 31 Aug 2023 09:38:04 -0400
Message-ID: <CAG-rBigAJbZ34bf7ZEuEM+OyEQ0i2yj=sQ+10KXAquQ7HHcwBw@mail.gmail.com>
Subject: Re: [PATCH v2] mmc: sdhci-pci-gli: fix LPM negotiation so x86/S0ix
 SoCs can suspend
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, ulf.hansson@linaro.org,
        jason.lai@genesyslogic.com.tw, skardach@google.com,
        Renius Chen <reniuschengl@gmail.com>,
        linux-mmc@vger.kernel.org, greg.tu@genesyslogic.com.tw,
        jasonlai.genesyslogic@gmail.com, SeanHY.chen@genesyslogic.com.tw,
        ben.chuang@genesyslogic.com.tw, victor.shih@genesyslogic.com.tw,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Thu, Aug 31, 2023 at 9:02=E2=80=AFAM Adrian Hunter <adrian.hunter@intel.=
com> wrote:
>
> I think the discussion was a little uncertain over
> moving this, so maybe leave it alone.

Agree, will do.

>
> However please consider my other comments.

Of course !
