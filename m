Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F448804D0E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:02:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344788AbjLEJCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:02:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:02:08 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A4FC9;
        Tue,  5 Dec 2023 01:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701766935; x=1733302935;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=ZOeyE7NVJTkhBLEolveT7OB0fqrr4Rs84xpHFHSA1K4=;
  b=Zpc8OeN3i+J4ehszqWiHQ9zdYAtpeezT/BBvLgmbmKqr+oL1KUnfDnkh
   OJzGuci/8zZQhdozD/NDVYJgfY3VgWYJMttTeSyReSgNrpNTrSt11ftJI
   KvYDsmSlI51N3R0AVaMVxECONXumhYFOcmp/T4Fn+kn76+oWugZSb5eqH
   rZsy9T/Kt9Ukj0wbHdw4Aixg9YPq3Iwd733vdXgPfVQlYkfrB30/OG6BA
   4yuKr+4gjuXxdHWu16SgcbsLGZvRj4yq4N5WJ/DScwr/SgQk8OF9xa0UN
   uq6DrEcftpg+Xgs1mNRD1yo1SP8oM0kyBwNMpD7plbQnC4wpzty+Nt65C
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15413830"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15413830"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:02:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018158044"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1018158044"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:02:09 -0800
Message-ID: <f370cc19-719c-49dc-81a1-45a8ec4a6f3e@linux.intel.com>
Date:   Tue, 5 Dec 2023 10:02:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] kunit: Add APIs for managing devices
Content-Language: en-US
To:     davidgow@google.com, Rae Moar <rmoar@google.com>,
        Brendan Higgins <brendan.higgins@linux.dev>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Maxime Ripard <mripard@kernel.org>
Cc:     linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-sound@vger.kernel.org
References: <20231205-kunit_bus-v1-0-635036d3bc13@google.com>
 <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20231205-kunit_bus-v1-1-635036d3bc13@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/5/2023 8:31 AM, davidgow@google.com wrote:
> Tests for drivers often require a struct device to pass to other
> functions. While it's possible to create these with
> root_device_register(), or to use something like a platform device, this
> is both a misuse of those APIs, and can be difficult to clean up after,
> for example, a failed assertion.
> 
> Add some KUnit-specific functions for registering and unregistering a
> struct device:
> - kunit_device_register()
> - kunit_device_register_with_driver()
> - kunit_device_unregister()
> 
> These helpers allocate a on a 'kunit' bus which will either probe the
> driver passed in (kunit_device_register_with_driver), or will create a
> stub driver (kunit_device_register) which is cleaned up on test shutdown.
> 
> Devices are automatically unregistered on test shutdown, but can be
> manually unregistered earlier with kunit_device_unregister() in order
> to, for example, test device release code.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   Documentation/dev-tools/kunit/usage.rst |  49 +++++++++
>   include/kunit/device.h                  |  76 ++++++++++++++
>   lib/kunit/Makefile                      |   3 +-
>   lib/kunit/device.c                      | 176 ++++++++++++++++++++++++++++++++
>   lib/kunit/kunit-test.c                  |  68 +++++++++++-
>   lib/kunit/test.c                        |   3 +
>   6 files changed, 373 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/dev-tools/kunit/usage.rst b/Documentation/dev-tools/kunit/usage.rst
> index 9db12e91668e..a222a98edceb 100644
> --- a/Documentation/dev-tools/kunit/usage.rst
> +++ b/Documentation/dev-tools/kunit/usage.rst
> @@ -797,3 +797,52 @@ structures as shown below:
>   KUnit is not enabled, or if no test is running in the current task, it will do
>   nothing. This compiles down to either a no-op or a static key check, so will
>   have a negligible performance impact when no test is running.
> +
> +Managing Fake Devcices and Drivers
> +----------------------------------

Typo: Devices

