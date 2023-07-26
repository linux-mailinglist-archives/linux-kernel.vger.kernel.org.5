Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86552763422
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 12:45:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233610AbjGZKpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 06:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232739AbjGZKpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 06:45:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE5A4212D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690368262;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YfPtcfCQozYTXWKac7jHLSgcmv2DVRuwJJ0/d8VMgrg=;
        b=VLkc4sRMRtaJEFZG6GIFW85CfswSxwTUKF5u87N3sSD85bS3bLCcjAmg6jPUhz310q/In2
        anZrka2Tkbaae4sYCdUiGIEQwLhpa5bqgrW0fZQ+EGd/GvL/L1HsJuWOcKZiwnE2UjaUTy
        7HMM/PUbHsJoVgr5kb2CIKtSncdQjd0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-7-gxptkbULPOqGmtzoenmH5w-1; Wed, 26 Jul 2023 06:44:20 -0400
X-MC-Unique: gxptkbULPOqGmtzoenmH5w-1
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-3fbb0c01e71so33412525e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 03:44:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690368259; x=1690973059;
        h=in-reply-to:references:cc:subject:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YfPtcfCQozYTXWKac7jHLSgcmv2DVRuwJJ0/d8VMgrg=;
        b=LwVDu799Nuv2r+/Hre48sUZxayEEu4yMfNhw7u6WFjJoCedQdBdNcU4T2IczoYOz5M
         OWZpoJ0Gqv8IVx/3ARrqmkc7VPHHy+qQxSMnawVklfvHmYu3288z2YBrBF3fWgScCvKS
         ERs5u4A2mTQ2BbRi3w0SxGMfywQ/zn6vR8SMYDXBYZ9tuZ0BhA2cEdIzFlhQ66BPIqUk
         ymIAj1q82qoG5ca5XAiVptML/XRME4lyhE+NbYg15fBYtNITqXbpaoiq3XvzRQewn3ST
         s7P7UW7KJebcw9B112jwGaTIPmxXBbe1/kNKqomkHjCfTo8TwfRpz7AkrJSqN3yt4XMA
         Yh3A==
X-Gm-Message-State: ABy/qLbmBsMFZwukG+Gx0gFdl7sIcQqJTj+ikvRIANAMhoJaD943mWDX
        c3EIFHcgsGNVWntGhsnuWZ8juESk7UNxVaqWGqJyfITYqtuYHggVnQhEnXYwoJnr7qLYb8BtC5M
        YJtJjVg3BreDy57l2hyL7d7m0
X-Received: by 2002:a05:6000:10c5:b0:311:142d:5d97 with SMTP id b5-20020a05600010c500b00311142d5d97mr1052820wrx.31.1690368259640;
        Wed, 26 Jul 2023 03:44:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPE19oxP27KE+bldxvZsZEsBDu6isImTZngYehdy08igFHWbefk4Hcu0B763Q3Vg22jtIh8Q==
X-Received: by 2002:a05:6000:10c5:b0:311:142d:5d97 with SMTP id b5-20020a05600010c500b00311142d5d97mr1052796wrx.31.1690368259327;
        Wed, 26 Jul 2023 03:44:19 -0700 (PDT)
Received: from localhost (2a01cb000f8b9700598da2e1679e8383.ipv6.abo.wanadoo.fr. [2a01:cb00:f8b:9700:598d:a2e1:679e:8383])
        by smtp.gmail.com with ESMTPSA id l13-20020a5d410d000000b0031766e99429sm6702219wrp.115.2023.07.26.03.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jul 2023 03:44:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 26 Jul 2023 12:44:18 +0200
Message-Id: <CUC1JDJIR32Y.10JMBOYZA2ZLQ@ringo>
From:   "Robin Jarry" <rjarry@redhat.com>
To:     "Waiman Long" <longman@redhat.com>,
        "Peter Zijlstra" <peterz@infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Pawan Gupta" <pawan.kumar.gupta@linux.intel.com>,
        "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
        "Len Brown" <lenb@kernel.org>, "Jonathan Corbet" <corbet@lwn.net>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v5 4/4] intel_idle: Add ibrs_off module parameter to
 force disable IBRS
Cc:     <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <x86@kernel.org>, <linux-pm@vger.kernel.org>,
        "Joe Mario" <jmario@redhat.com>,
        "Randy Dunlap" <rdunlap@infradead.org>
X-Mailer: aerc/0.15.2-111-gf7a4c37c303c-dirty
References: <20230710194857.2898284-1-longman@redhat.com>
 <20230710194857.2898284-5-longman@redhat.com>
In-Reply-To: <20230710194857.2898284-5-longman@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Waiman Long, Jul 10, 2023 at 21:48:
> Commit bf5835bcdb96 ("intel_idle: Disable IBRS during long idle")
> disables IBRS when the cstate is 6 or lower. However, there are
> some use cases where a customer may want to use max_cstate=3D1 to
> lower latency. Such use cases will suffer from the performance
> degradation caused by the enabling of IBRS in the sibling idle thread.
> Add a "ibrs_off" module parameter to force disable IBRS and the
> CPUIDLE_FLAG_IRQ_ENABLE flag if set.
>
> In the case of a Skylake server with max_cstate=3D1, this new ibrs_off
> option will likely increase the IRQ response latency as IRQ will now
> be disabled.
>
> When running SPECjbb2015 with cstates set to C1 on a Skylake system.
>
> First test when the kernel is booted with: "intel_idle.ibrs_off"
>   max-jOPS =3D 117828, critical-jOPS =3D 66047
>
> Then retest when the kernel is booted without the "intel_idle.ibrs_off"
> added.
>   max-jOPS =3D 116408, critical-jOPS =3D 58958
>
> That means booting with "intel_idle.ibrs_off" improves performance by:
>   max-jOPS:   1.2%, which could be considered noise range.
>   critical-jOPS: 12%, which is definitely a solid improvement.
>
> The admin-guide/pm/intel_idle.rst file is updated to add a description
> about the new "ibrs_off" module parameter.
>
> Signed-off-by: Waiman Long <longman@redhat.com>
> Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Hi Longman,

Adding back my tag that I had set in v1. Thanks!

Tested-by: Robin Jarry <rjarry@redhat.com>

