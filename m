Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D577A0AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 18:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbjINQW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 12:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjINQWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 12:22:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E7B711AE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694708493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Apv7kZBdrsJj6vSoPspXlJgOULxG2yaZ21oYqATlQW4=;
        b=VzCM/Z7tDMDUYcDew6ZswKZR5j8ohmSpZ7PnsP7oIJqz8npBCOfj2SoF2N0LCaRllKnRfg
        95CJI0vWWAu+T2P972/N9vm7YnWh+Z8ZlXfwK+e1yDMXp4Rj1Q0RYNlYIgkqIRb87Tws6t
        lsbVYS0FiGlBbQjw/1lJSGFGYlMT438=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-649-jLr1BkTANmqTvIjcneMJXQ-1; Thu, 14 Sep 2023 12:21:31 -0400
X-MC-Unique: jLr1BkTANmqTvIjcneMJXQ-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-401d8873904so9198455e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 09:21:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694708490; x=1695313290;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Apv7kZBdrsJj6vSoPspXlJgOULxG2yaZ21oYqATlQW4=;
        b=Y1w7ZgAJlINRld349JZ7w4zR7Ji5zU2QbM+K3yZQXSph1Xq+IqoC44jfFsZ7FNpG++
         IYaA2bYyEtxM5yXW1qso6tbD7c1fAtn03XYo4OaUPi04bGpO2JH2L5KfhdDH2D47MH73
         4L4tFtudvZk5xC5/9jiRvfMrUEFsIiBfcpUoLFMXeILMzDHoph3oJvPfugL/F2FZOsmO
         uWvkjwIo3UkKgE7thplc7Qmb4wj/SBjfSBLxKIFgx6pBBNbK1sWPUFr7B11VA4eIHNwg
         axbSz6WJp8V5bhVZm+JI/+h/eFw5ff8NdXjDKVhufG6vIs2cQBsVzLnB2oQs8CCjFpKI
         9tXA==
X-Gm-Message-State: AOJu0YzFF5QudM7BiNIR3FAbQV4QjL8c2ADPuYwFXWDsEbcHXNEAzh6y
        ekQ8Cx4ZqAg2oJJtW1QlAxxexE2CvB4sjapK++GIjm+YGzu4csNYHFxMsM3mRTjUGgEC8Bq7u97
        h8Vt0ola+XRcb5e8GSeltSCdz
X-Received: by 2002:a05:600c:3644:b0:402:f517:9c07 with SMTP id y4-20020a05600c364400b00402f5179c07mr5155354wmq.0.1694708490085;
        Thu, 14 Sep 2023 09:21:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF0l2mOR4Ouykav2ZeMBHYkvKadQHUF2Zaeoc7F2CrsRfvG9bQL7gl1wAZjb2NlX+3HLLvS0Q==
X-Received: by 2002:a05:600c:3644:b0:402:f517:9c07 with SMTP id y4-20020a05600c364400b00402f5179c07mr5155334wmq.0.1694708489718;
        Thu, 14 Sep 2023 09:21:29 -0700 (PDT)
Received: from vschneid.remote.csb (anice-256-1-26-111.w86-203.abo.wanadoo.fr. [86.203.135.111])
        by smtp.gmail.com with ESMTPSA id z6-20020a05600c220600b00402dbe0bbdcsm5199538wml.28.2023.09.14.09.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 09:21:29 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Shrikanth Hegde <sshegde@linux.vnet.ibm.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org
Cc:     sshegde@linux.vnet.ibm.com, dietmar.eggemann@arm.com,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com,
        quentin.perret@arm.com, srikar@linux.vnet.ibm.com,
        mgorman@techsingularity.net, mingo@kernel.org,
        pierre.gondois@arm.com, yu.c.chen@intel.com,
        tim.c.chen@linux.intel.com
Subject: Re: [PATCH v3] sched/topology: remove sysctl_sched_energy_aware
 depending on the architecture
In-Reply-To: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
References: <20230913114807.665094-1-sshegde@linux.vnet.ibm.com>
Date:   Thu, 14 Sep 2023 18:21:27 +0200
Message-ID: <xhsmhil8cvi7s.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/23 17:18, Shrikanth Hegde wrote:
> sysctl_sched_energy_aware is available for the admin to disable/enable
> energy aware scheduling(EAS). EAS is enabled only if few conditions are
> met by the platform. They are, asymmetric CPU capacity, no SMT,
> valid cpufreq policy, frequency invariant load tracking. It is possible
> platform when booting may not have EAS capability, but can do that after.
> For example, changing/registering the cpufreq policy.
>
> At present, though platform doesn't support EAS, this sysctl is still
> present and it ends up calling rebuild of sched domain on write to 1 and
> NOP when writing to 0. That is confusing and un-necessary.
>

But why would you write to it in the first place? Or do you mean to use
this as an indicator for userspace that EAS is supported?

