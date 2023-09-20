Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DE1E7A8317
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:17:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234824AbjITNRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234696AbjITNRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:17:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67BDDF2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:16:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695215805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4TWOLSo8HNAumxEdXb8FwLPVqXlryu4M1tjfBv1puco=;
        b=i0bb6y5nnPMtvsexSzB62Y6zicDmQXrT2eSrjCJp8telsMmk+q9Wkz67xgnn68Wv5n9LH5
        BoQ582/sWQhnYeyC7a02TRzjrIpCrlo+bGXrBu6RqbrOB1Dg6xThVzc1aWhpRV5zoV39VI
        M7q8+vBEfo35zI8rQioI37yVZkwrkYo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-Awecw_Y6NYWtSFQLftGphA-1; Wed, 20 Sep 2023 09:16:41 -0400
X-MC-Unique: Awecw_Y6NYWtSFQLftGphA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40469bcd1eeso47756645e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:16:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695215800; x=1695820600;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4TWOLSo8HNAumxEdXb8FwLPVqXlryu4M1tjfBv1puco=;
        b=ccQDQ9iVQ832ASJWGeE0jjgy+JpqzABB987bk7JI1APXhody76kYPRG0rtv8UB8mIR
         YgPzO5gjXliAMwVhhyaZVXgXJuDlOBaK2KN7jElOub9wew5Uj3K1Kmi+17zmuXaYUIPr
         8pxsQxwme0hOjofavUGM8u/MLHC+/GWwqyp3hhZjAr3FKZLyzLg43xo0sqUbu+6UT5MG
         rhwYCjmX1svksyz1EnlwlpEW9o54wF4bR7zWOXCNhB8LV4LkCPMjtP2sRQYWCUJHUyz2
         C7Rt8lrRrubf8dolRpepuEX84rglqLgMAIjd6/H8QrUwbTNWoG6eYO0QRG1XbRG951AV
         Adgg==
X-Gm-Message-State: AOJu0Ywq+GZH6Pd+kV2IMnB8L5VA5LUqgrJjuuu4DLObAoKEC8JQPwb+
        hIAAUc67LH0PLa4m4dGOR0Dt+HiFQGn4BO+KFqd5r7R1BCFREFf647LFWsw2cod/nPDeRULtirU
        pEtnI/lYNgwhJqEtrxMtP7hKm
X-Received: by 2002:a5d:4c47:0:b0:317:5e91:5588 with SMTP id n7-20020a5d4c47000000b003175e915588mr2350962wrt.3.1695215800567;
        Wed, 20 Sep 2023 06:16:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoxkH4fJ4IWTtydyWVjX3Dh7sW3UjyelgPeBkHUWrD0hiFoSLYgkFFH/YN+BrbyFmyPjIFXg==
X-Received: by 2002:a5d:4c47:0:b0:317:5e91:5588 with SMTP id n7-20020a5d4c47000000b003175e915588mr2350938wrt.3.1695215800071;
        Wed, 20 Sep 2023 06:16:40 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70b:8600:dad5:13bb:38a9:3010? (p200300cbc70b8600dad513bb38a93010.dip0.t-ipconnect.de. [2003:cb:c70b:8600:dad5:13bb:38a9:3010])
        by smtp.gmail.com with ESMTPSA id j21-20020adfd215000000b003179d7ed4f3sm15175401wrh.12.2023.09.20.06.16.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Sep 2023 06:16:39 -0700 (PDT)
Message-ID: <daf57da6-b22d-bdfb-c6f0-0ac07824ab72@redhat.com>
Date:   Wed, 20 Sep 2023 15:16:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 2/2] mm/ksm: Test case for prctl fork/exec workflow
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230919205158.1897353-1-shr@devkernel.io>
 <20230919205158.1897353-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230919205158.1897353-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.23 22:51, Stefan Roesch wrote:
> This adds a new test case to the ksm functional tests to make sure that
> the KSM setting is inherited by the child process when doing a
> fork/exec.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   tools/testing/selftests/mm/Makefile           |  2 +
>   .../selftests/mm/ksm_fork_exec_child.c        |  9 ++++
>   .../selftests/mm/ksm_functional_tests.c       | 50 ++++++++++++++++++-
>   3 files changed, 60 insertions(+), 1 deletion(-)
>   create mode 100644 tools/testing/selftests/mm/ksm_fork_exec_child.c
> 
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index 6a9fc5693145..9ab6aa402544 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -73,6 +73,8 @@ ifneq ($(ARCH),arm64)
>   TEST_GEN_PROGS += soft-dirty
>   endif
>   
> +TEST_GEN_PROGS += ksm_fork_exec_child

It's not a test itself, so it shouldn't be run when running all tests. 
See below.

> +
>   ifeq ($(ARCH),x86_64)
>   CAN_BUILD_I386 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_32bit_program.c -m32)
>   CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_program.c)
> diff --git a/tools/testing/selftests/mm/ksm_fork_exec_child.c b/tools/testing/selftests/mm/ksm_fork_exec_child.c
> new file mode 100644
> index 000000000000..298439f0d55f
> --- /dev/null
> +++ b/tools/testing/selftests/mm/ksm_fork_exec_child.c
> @@ -0,0 +1,9 @@
> +#include <sys/prctl.h>
> +#include <stdlib.h>
> +
> +int main()
> +{
> +	/* Test if KSM is enabled for the process. */
> +	int ksm = prctl(68, 0, 0, 0, 0);

Can we use the define from a header? (PR_SET_MEMORY_MERGE)

I was wondering if we could simply exec() ourself (same binary), but 
pass a special cmdline argument. Then you don't have to build a separate 
binary.

Just special-case in main() on that argument and perform this check.

> +	exit(ksm == 1 ? 0 : 1);
> +}
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 901e950f9138..4dc0bb522c07 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -479,6 +479,53 @@ static void test_prctl_fork(void)
>   	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>   }
>   
> +static void test_prctl_fork_exec(void)
> +{
> +	int ret, status;
> +	pid_t child_pid;
> +
> +	ksft_print_msg("[RUN] %s\n", __func__);
> +
> +	ret = prctl(PR_SET_MEMORY_MERGE, 1, 0, 0, 0);
> +	if (ret < 0 && errno == EINVAL) {
> +		ksft_test_result_skip("PR_SET_MEMORY_MERGE not supported\n");
> +		return;
> +	} else if (ret) {
> +		ksft_test_result_fail("PR_SET_MEMORY_MERGE=1 failed\n");
> +		return;
> +	}
> +
> +	child_pid = fork();
> +	if (child_pid == -1) {
> +		ksft_test_result_skip("fork() failed\n");
> +		return;
> +	} else if (child_pid == 0) {
> +		char *filename = "./ksm_fork_exec_child";
> +		char *argv_for_program[] = { filename, NULL };
> +
> +		execv(filename, argv_for_program);;

s/;;/;/

Add a return; so you can simplify the code below (no need for the "else")

> +	} else {
> +		if (waitpid(child_pid, &status, 0) > 0) {
> +			if (WIFEXITED(status)) {
> +				status = WEXITSTATUS(status);
> +				if (status) {
> +					ksft_test_result_fail("KSM not enabled\n");
> +					return;
> +				}
> +
> +			} else {
> +				ksft_test_result_fail("program didn't terminate normally\n");
> +				return;
> +			}
> +		} else {
> +			ksft_test_result_fail("waitpid() failed\n");
> +			return;
> +		}
> +	}
> +
> +	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");

It's probably the cleanest to disable PR_SET_MEMORY_MERGE again when 
returning form this function, so the other tests have a clean slate.


-- 
Cheers,

David / dhildenb

