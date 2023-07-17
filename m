Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B86E756DB4
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbjGQTyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230165AbjGQTya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:54:30 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC33A126
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:54:29 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3a44fae863fso1673523b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1689623669; x=1692215669;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3WmX16EgwC3CJ6ucAB2UNDwt1Vs/Nx7jqfueCWED5rM=;
        b=TMWJXkLFioZxFC9wUdESsT5EKMp3HBNkhGPizVwHcnJMNlYPxyWJDhNxGC4YmPgmF1
         MH7k17+11lJF3QterPfivRiB9Yfv83Zlpcpi41xsxM5Ff8ao6gjVBFxKDu0w9yoN+Cjx
         1WQq4SXlv8FyuR6Mz3Tkfibb03hQnwwL2k8kjH+4VLSGuWmYe0arjEM9SuXgebmoy5HV
         7bgA7/zFT/MTgjbxVXmgQTwFEmN7LtFMFJ61wIsAwxttIORQfCJfGuRjvf8cAFuiCW53
         hAm57UBAJQ9MISpgay73YyJfKLCsYkyZDPWMmYd/kEGpc4PnfrtYrpDpiCDl9lkpGsr4
         7tDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623669; x=1692215669;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3WmX16EgwC3CJ6ucAB2UNDwt1Vs/Nx7jqfueCWED5rM=;
        b=iO0UsKuaIxFeyYaLwMwJcBvknNiUZd7to+OrQk+DQrjRll2xAEdNI/nyGRUmuOJepI
         ywiSkcjTnqs3HM38KItb5xfTnHqQ3Kb95orSY6t99g4hDFsuQQRSfCQOTqLr3bKdmN5K
         9IBEUMGpEBZi13sF/m2WLt/ns1oVok7ssrV4Erv4BSH21GkZcOJGPfcof4HBKuL4Gq1W
         5k7LzxpDXi2ci9eQtE4ZkulcILs7zyKq+xzdoER7Y7PQGFm1pimm2p/1FTj6JvWx5snE
         9wHNRfeKS+5Fjdp9Hy8QGqKNiZ+A2K3PaeKn75fG+EDACx4cxWF8AlzUta2lt4LVocHX
         hQZw==
X-Gm-Message-State: ABy/qLa3U6okvt1dP49ouzgVPAMlm2LADKUiZ3dd5WN0+Xi1Ndk7mD76
        19QasWcpsbjSRDoFcyOl3j1k0w==
X-Google-Smtp-Source: APBJJlHotYEXsPRwxjI/Sz0zHykOCKbRzYNKbefehROGeemMuYWDOq0ri61xXYx2DJ7K91VhaXWYAw==
X-Received: by 2002:a05:6808:1385:b0:3a4:9f:933e with SMTP id c5-20020a056808138500b003a4009f933emr13147590oiw.58.1689623669251;
        Mon, 17 Jul 2023 12:54:29 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:2000:b002:7d68:ffe6:2179:d496])
        by smtp.gmail.com with ESMTPSA id f1-20020a0ccc81000000b0062df95d7ef6sm137064qvl.115.2023.07.17.12.54.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:54:28 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH] regmap-irq: Set IRQCHIP_MASK_ON_SUSPEND if no wake_base
From:   Samuel Holland <samuel.holland@sifive.com>
In-Reply-To: <56388e8a-dfc6-4fe7-8aa8-a4b69f201bd0@sirena.org.uk>
Date:   Mon, 17 Jul 2023 14:54:18 -0500
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Laxman Dewangan <ldewangan@nvidia.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1C2DB0DE-016C-4F19-9D6F-5C8A0C003273@sifive.com>
References: <20230717191654.1303285-1-samuel.holland@sifive.com>
 <56388e8a-dfc6-4fe7-8aa8-a4b69f201bd0@sirena.org.uk>
To:     Mark Brown <broonie@kernel.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jul 17, 2023, at 2:22 PM, Mark Brown <broonie@kernel.org> wrote:
> 
> On Mon, Jul 17, 2023 at 12:16:54PM -0700, Samuel Holland wrote:
> 
>> If hardware provides no way to control which IRQs are wakeup enabled,
>> then software needs to mask non-wakeup-enabled IRQs when going to sleep.
> 
> This isn't an unambigiously clear statement, especially for MFDs where
> there might be a desire to have some function on the device be able to
> wake the system (eg, headset button press on an audio CODEC or a RTC on
> a PMIC) even if there's no control within the device...
> 
>> Fixes: 55ac85e942c6 ("regmap: irq: enable wake support by default")
> 
> ...as the commit log does hint at.  If there's a problem I think we need
> some finer grained control here.

The current problem is that if wakeup is enabled for any IRQ in the chip
(say, the PMIC's power button), then we enable wakeup for the parent IRQ,
and now suddenly all (enabled) IRQs on the PMIC are also inadvertently
wakeup-enabled.

But I realize this patch does not actually solve the issue, for a couple
of reasons:
1) regmap-irq does not implement .irq_mask, just .irq_disable.
2) The __disable_irq() call in suspend_device_irq() should be sufficient,
   except that we fail the irq_settings_is_nested_thread() check in
   suspend_device_irqs().

So maybe the real issue is that commit 3c646f2c6aa9 ("genirq: Don't
suspend nested_thread irqs over system suspend") missed the case where
the child IRQ should be suspended, but the parent IRQ should not.

If that is fixed, then suspend_device_irq() should do the right thing
without any changes to the regmap-irq code.

Sorry for the noise.

