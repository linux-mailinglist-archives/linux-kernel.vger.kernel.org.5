Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06437815A1
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 01:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241990AbjHRXFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 19:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242003AbjHRXEj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 19:04:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C40A421D;
        Fri, 18 Aug 2023 16:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=h1dj7muo6Cwmu5VpEvvhJpcCn482g7tBlmUX/NE7OgQ=; b=i+6f4EArC5B20yZ3hyYeuJNPq0
        8NYptfTpzFw5BxIg7NEqCL2NyD5cr14coxWBGifaReiUpU1kmdDdxJh9zrDy5KfksAQasbnfryhDF
        hFHeAfUnG+KzcIWz/pdYvyi1W4GfhyDXxocAkag2AcTlra+c/WO7m/myEJTUsv/ekRu3F6nDh+4Sj
        tb4NugbjVv0jWPE7Aq9q2c/JmIG+zNxn3dE12JOoEdP525l56EVsSoN5dg4r5WM79Ur+mLf0rzDvs
        F5VfG26hWeprJwdbrJcoeMxaj1Twwz9FWUVeTIsoEavnSvcoArRot0dEY7OIKSDOvSDH3RISscYkk
        xqPzxjfw==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qX8Vn-00A8bq-33;
        Fri, 18 Aug 2023 23:04:12 +0000
Message-ID: <0f16dd5a-bce7-0e36-3827-f713e90fb843@infradead.org>
Date:   Fri, 18 Aug 2023 16:04:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] tee: amdtee: add support for use of cma region
Content-Language: en-US
To:     Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H . Peter Anvin" <hpa@zytor.com>,
        Jens Wiklander <jens.wiklander@linaro.org>,
        Sumit Garg <sumit.garg@linaro.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Sneddon <daniel.sneddon@linux.intel.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        SivaSangeetha SK <SivaSangeetha.SK@amd.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Ross Lagerwall <ross.lagerwall@citrix.com>,
        Yuntao Wang <ytcoode@gmail.com>,
        Sean Christopherson <seanjc@google.com>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        op-tee@lists.trustedfirmware.org
Cc:     Mythri PK <Mythri.Pandeshwarakrishna@amd.com>,
        Nimesh Easow <Nimesh.Easow@amd.com>
References: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <7531423fcb3b18ff78737ae5eabc84b0e3cb2909.1692369704.git.Devaraj.Rangasamy@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi--

On 8/18/23 07:42, Devaraj Rangasamy wrote:
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 722b6eca2e93..5e38423f3d53 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -363,6 +363,13 @@
>  			  selects a performance level in this range and appropriate
>  			  to the current workload.
>  
> +	amdtee_cma=nn	[HW,TEE]
> +			Sets the memory size reserved for contiguous memory
> +			allocations, to be used by amdtee device driver.
> +			Value is in MB and can range from 4 to 128 (MBs)

			                                       128 (MBs).

> +			CMA will be active only when CMA is enabled, and amdtee is

	That could use some improvement. How about:

			AMD-TEE CMA will be active only when CONFIG_CMA is enabled,
			and amdtee is

> +			built as inbuilt driver, and not loaded as module.
> +
>  	amijoy.map=	[HW,JOY] Amiga joystick support
>  			Map of devices attached to JOY0DAT and JOY1DAT
>  			Format: <a>,<b>

> diff --git a/drivers/tee/amdtee/Kconfig b/drivers/tee/amdtee/Kconfig
> index 191f9715fa9a..5843c739a7b8 100644
> --- a/drivers/tee/amdtee/Kconfig
> +++ b/drivers/tee/amdtee/Kconfig
> @@ -6,3 +6,12 @@ config AMDTEE
>  	depends on CRYPTO_DEV_SP_PSP && CRYPTO_DEV_CCP_DD
>  	help
>  	  This implements AMD's Trusted Execution Environment (TEE) driver.
> +
> +config AMDTEE_CMA_SIZE
> +	int "Size of Memory in MiB reserved in CMA for AMD-TEE"
> +	default "0"

Why won't this default value cause an allocation error message?
Maybe I'm just not following the call paths correctly.

It looks to me like this causes a call to
cma_declare_contiguous_nid() with @size = 0, and that function says:

	if (!size)
		return -EINVAL;

> +	depends on CMA && (AMDTEE=y)
> +	help
> +	  Specify the default amount of memory in MiB reserved in CMA for AMD-TEE driver

	                                                                          driver.

> +	  Any amdtee shm buffer allocation larger than 64k will allocate memory from the CMA

	                                                                                 CMA.

> +	  The default can be overridden with the kernel commandline parameter "amdtee_cma".
> \ No newline at end of file

Please fix that ^^^ warning.

Thanks.
-- 
~Randy
