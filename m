Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6AA804D11
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 10:02:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344873AbjLEJCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 04:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229980AbjLEJCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 04:02:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3231FA;
        Tue,  5 Dec 2023 01:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701766945; x=1733302945;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=8KlNvqw21EtjClhM/olh8KAS5lUXDjPHvrauWC6tQ5s=;
  b=K8H4RREYyMMYkXJsTyUnaVUiFJ34tXUpjIQvhyf+NBN5EvOWryjn3c8z
   HILV8IppTDA5cihIzmHzptwiBy/1pPGd6sbbRAe0drKZ4FyNiql1Nln9l
   E5m6ncQYB7u+wwrFAD4BpbJR5oYrpmvMLwmH9+or+BZ7GEq3ThvWVewif
   lGSwFQglHbXjmWPIESHw6JHt+C61JPjzGoO4i2pve2HtcXNSxJxiPurGX
   7XwZ8+t+d0V4FwqhjrMFc7nfs2IR/zEZQrHGI8ZLSF67dY9PxSuvHHiBu
   3LiggYoLkDIDueb47OI9TmdfBmuJFZZWZzzvN82iNuKabpVcGF2DXF3Vq
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="15413847"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="15413847"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:02:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="1018158098"
X-IronPort-AV: E=Sophos;i="6.04,251,1695711600"; 
   d="scan'208";a="1018158098"
Received: from aslawinx-mobl.ger.corp.intel.com (HELO [10.94.0.53]) ([10.94.0.53])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Dec 2023 01:02:19 -0800
Message-ID: <d4cacfdc-873a-46ae-86d6-8838e867bbe4@linux.intel.com>
Date:   Tue, 5 Dec 2023 10:02:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ASoC: topology: Replace fake root_device with
 kunit_device in tests
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
 <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
From:   =?UTF-8?Q?Amadeusz_S=C5=82awi=C5=84ski?= 
        <amadeuszx.slawinski@linux.intel.com>
In-Reply-To: <20231205-kunit_bus-v1-4-635036d3bc13@google.com>
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
> Using struct root_device to create fake devices for tests is something
> of a hack. The new struct kunit_device is meant for this purpose, so use
> it instead.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   sound/soc/soc-topology-test.c | 11 +++--------
>   1 file changed, 3 insertions(+), 8 deletions(-)
> 
> diff --git a/sound/soc/soc-topology-test.c b/sound/soc/soc-topology-test.c
> index 2cd3540cec04..1d7696e5bffc 100644
> --- a/sound/soc/soc-topology-test.c
> +++ b/sound/soc/soc-topology-test.c
> @@ -10,6 +10,7 @@
>   #include <sound/soc.h>
>   #include <sound/soc-topology.h>
>   #include <kunit/test.h>
> +#include <kunit/device.h>

Nitpick:
Can we add device.h before test.h, to keep it in alphabetical order?

>   
>   /* ===== HELPER FUNCTIONS =================================================== */
>   
> @@ -21,26 +22,20 @@
>    */
>   static struct device *test_dev;
>   
> -static struct device_driver test_drv = {
> -	.name = "sound-soc-topology-test-driver",
> -};
> -
>   static int snd_soc_tplg_test_init(struct kunit *test)
>   {
> -	test_dev = root_device_register("sound-soc-topology-test");
> +	test_dev = kunit_device_register(test, "sound-soc-topology-test");
>   	test_dev = get_device(test_dev);
>   	if (!test_dev)
>   		return -ENODEV;
>   
> -	test_dev->driver = &test_drv;
> -
>   	return 0;
>   }
>   
>   static void snd_soc_tplg_test_exit(struct kunit *test)
>   {
>   	put_device(test_dev);
> -	root_device_unregister(test_dev);
> +	kunit_device_unregister(test, test_dev);
>   }
>   
>   /*
> 

