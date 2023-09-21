Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A57487AA525
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231641AbjIUWfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:35:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231927AbjIUWfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:35:21 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1212290F17
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:57:51 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id ffacd0b85a97d-31fe2c8db0dso1202470f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695322670; x=1695927470; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=j1uUms1xcVmsgxP8Cxil7xsyErVNC6Ys2DDi9t4fnCZzIBljh8q4+Svp/SHVEmW+ea
         l593smLsZnxzoB2dZJAkiTk3TUxtaPsegRv5lqVSHb1TFrQfwf+2Q1sKPxsvDmxuvPUs
         P17MWCIgsqP7bAlhBlYuUKt06FLNuH16e0L+XMhy6ZpBCa4BoAWkjEGzzBMVz0tm7iqr
         tOTl9bub3qo/CCAVg2Ud03mC6oQ9Y1KBiCukNtRiWErwnxikHs0um8RSMYfVs3EgbNCo
         +6yMuBvZB0o9YHFb1eQdRFzf4auKh6S1r/JbKFOXG9fbl58xOMPr0NULUWObSFjfC7wc
         VfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322670; x=1695927470;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=b/lesyyYEsnt9FdfxR9CoxFmQAH4gicQBv/bIfqhS7o=;
        b=pl4OANtWrKZLuYYlOetXnSzTbua1anEGVZMSXeoz+8oQe5/RsrFL3VjMLBKiKfiZR2
         4TEQ3mCPp59j6rw+X47LW8xJX/teNDy2w3Va10f/1fioe1LGQ1v4kJl3xNyx0sOAYop1
         GalTprTXPl7uL6eN1GPsE+dqmhbWc7vSt4dEfY92aa3UGLjpURcpKzUNjkdfD/qUexYi
         1fBNJUwFPfemfUlyZNB21ADDoLFe7aA3BHbnSgZxsNxPnm8d97JksV9UKxm0Uq0OStp/
         ZpeD9w03ZiUHeMPrstGjCQLh4YteVuQ45+Q4u2yUQSXv504+s2E/x/8ltn5v5ZSdCx3A
         97GA==
X-Gm-Message-State: AOJu0Yyht0DqsjEjoJpsZH0hOB+e2qZOAopdTxCEPfmcv+KRs/erKe90
        MAgdsVKp+kFVoqwUenARtG16dnS4SE73hzh4h67gPA==
X-Google-Smtp-Source: AGHT+IGJfbg273QOiGyWJV30e+vCp/gVKXDpLIBgIJKJV1ZLq7zoYeLh1EwUM6sczbGm0RhUCMN7/g==
X-Received: by 2002:a05:6402:64c:b0:523:100b:462b with SMTP id u12-20020a056402064c00b00523100b462bmr4294427edx.5.1695281801541;
        Thu, 21 Sep 2023 00:36:41 -0700 (PDT)
Received: from linaro.org (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id x13-20020aa7d38d000000b0052fe12a864esm440591edq.57.2023.09.21.00.36.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 00:36:40 -0700 (PDT)
Date:   Thu, 21 Sep 2023 09:36:37 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc:     Linux ACPI <linux-acpi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH v1 9/9] ACPI: thermal: Drop valid flag from struct
 acpi_thermal_trip
Message-ID: <20230921073637.GA3346@linaro.org>
References: <5708760.DvuYhMxLoT@kreacher>
 <9162925.CDJkKcVGEf@kreacher>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9162925.CDJkKcVGEf@kreacher>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 08:47:23PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Notice that the valid flag in struct acpi_thermal_trip is in fact
> redundant, because the temperature field of invalid trips is always
> equal to THERMAL_TEMP_INVALID, so drop it from there and adjust the
> code accordingly.
> 
> No intentional functional impact.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 

 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
