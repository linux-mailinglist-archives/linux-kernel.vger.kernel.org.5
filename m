Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EC878032BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344076AbjLDMb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbjLDMbP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:31:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A6BB100
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 04:31:20 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40c0873cf84so15287895e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Dec 2023 04:31:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1701693078; x=1702297878; darn=vger.kernel.org;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W55/T9K6+K8UUWjjypa9TYy5bFm9BSQxOhQzpcpwFHU=;
        b=cx2cuEvwmmOfaQaFFuYLcGVg225tEU7qu5HUIvPrYhEtuq7byST0CVcWBWHHjeicAL
         P1eBeR891ioXEbfJvrypwAh6zkKP9YXoyPpLGZT8IaOl6IRRMppZcdpmrtijMzI9aMwd
         i9As71Ed0mDWWzJWCoZJsjD1CWHUJ3eQ3ovFXg1n1PXaR+zqHFk/PUWMirkafdyb5jgb
         d3kD+v91m5PM1D5puj01QuYHu4tomTiup+g/DIQkaVpo0b49E0viOMFkErcYR6X4nPxq
         mCCwfV/8v5qFLSVcJRsW1ZnDG4KBILJPR3yrjfa3GeQrf74b/1b3og1ts6mxCs7Tt9YL
         CZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701693078; x=1702297878;
        h=mime-version:user-agent:references:message-id:in-reply-to:subject
         :cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W55/T9K6+K8UUWjjypa9TYy5bFm9BSQxOhQzpcpwFHU=;
        b=SaHvVgkw2QhSDxPu9qfWri2G+NyPugNQT2qYibyjxPFp0IBjFFl8aoEo/aKjiQOf0J
         1I2vqwlX2aUmKQeaJAZg3c+bB/GLPu3wnH9iCBnlcuZXgnSsgyJZ5gQAxKIlV+FEV0W4
         bibKIysRuPQHDcRgXYD8HOriu62qHLN8vX4M0jPpwoojpc70rjNHpaRgH1C2H5XCscNp
         dREVxYOYbAVEc/+llUT8d+UQFGQM9hSpI5GljYsCS1ZN+0M944668M/BkMnKCGKOHykx
         e0MoLMu/DpoNp6B4qenjemR2pWA/4TOo1WD5HrZfSvg2uHjs2+ECofGN7ZPOQmVdssqD
         t3lg==
X-Gm-Message-State: AOJu0Yzu7u8jGe0q3TrlWZIB8cFeZrryH/Lmo333w3Q6JxyLy+bSun0f
        4/0frYCMjmdjXlx55b10wvgaGA==
X-Google-Smtp-Source: AGHT+IHB8BRFdhuNviEObNj50i/Qccig1rQTpxR703fqIvFCYt8GYXuVrTy0FmlwVcezeH1TnfE56A==
X-Received: by 2002:a05:600c:5128:b0:40b:5e21:d370 with SMTP id o40-20020a05600c512800b0040b5e21d370mr2452561wms.121.1701693078623;
        Mon, 04 Dec 2023 04:31:18 -0800 (PST)
Received: from localhost ([193.86.92.180])
        by smtp.gmail.com with ESMTPSA id bh12-20020a05600c3d0c00b0040b2976eb02sm14922744wmb.10.2023.12.04.04.31.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 Dec 2023 04:31:18 -0800 (PST)
From:   Jiri Kosina <jkosina@suse.com>
X-Google-Original-From: Jiri Kosina <jikos@kernel.org>
Date:   Mon, 4 Dec 2023 13:31:18 +0100 (CET)
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
cc:     srinivas.pandruvada@linux.intel.com, benjamin.tissoires@redhat.com,
        linux-pm@vger.kernel.org, linux-pci@vger.kernel.org,
        Jian Hui Lee <jianhui.lee@canonical.com>,
        Even Xu <even.xu@intel.com>, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] HID: intel-ish-hid: ipc: Rework EHL OOB wakeup
In-Reply-To: <20231108121940.288005-1-kai.heng.feng@canonical.com>
Message-ID: <nycvar.YFH.7.76.2312041331050.29220@cbobk.fhfr.pm>
References: <20231108121940.288005-1-kai.heng.feng@canonical.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023, Kai-Heng Feng wrote:

> Since PCI core and ACPI core already handles PCI PME wake and GPE wake
> when the device has wakeup capability, use device_init_wakeup() to let
> them do the wakeup setting work.
> 
> Also add a shutdown callback which uses pci_prepare_to_sleep() to let
> PCI and ACPI set OOB wakeup for S5.
> 
> Cc: Jian Hui Lee <jianhui.lee@canonical.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Srinivas, do you please have any feedback on this patch?

Thanks,

-- 
Jiri Kosina
SUSE Labs

