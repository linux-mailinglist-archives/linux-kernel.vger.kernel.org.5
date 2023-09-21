Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3FA57A971F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjIURMC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:12:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbjIURKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:10:08 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E3C7683
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695315903;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eRU04s8x3xyTIu5kQQVDaBmHzp4m8wrqdJh+ENCEibE=;
        b=g6Op5FqijT/LgH+xOPVR7WHVT9Bayg0kH17eJWQeWkqfza3kVyfSh8vABJcQlmfyelrbKS
        2E0u0E4GWAHX6ZOia4nEUV/hPv8QfCNdFGEAS3zbNdwCkJ7ab3dUofhXVT5qwtjQXud2kg
        b/7NQqv2/FXvj/wkP9VsTi1oaj10VOQ=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-pi8FEVRFPjyTR_8wMgnc7w-1; Thu, 21 Sep 2023 07:44:12 -0400
X-MC-Unique: pi8FEVRFPjyTR_8wMgnc7w-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-500a9156daaso1134662e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 04:44:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695296651; x=1695901451;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eRU04s8x3xyTIu5kQQVDaBmHzp4m8wrqdJh+ENCEibE=;
        b=tS+LbeuLfz0hK27B2k4fwmcPITchTSXBw9puI98As0RE13KbUlR9fwDY05boR2Sbn6
         y85Z2FlDCSJte+8ZYWacftpAtCo7mTkecXLGKddMMaViMoU9P1MGBpMCxWiegGvzNST2
         h3IZrKWSurlD0VG7r74uFca8vWVEjLx14rTK02t17wVXWhEnVIJrLdthxODQmCPPGi9s
         Jc/f5Z9iskJqPPwlh7D1k4E++kBujs9ayGYfaI/NCi54WJST6yJZBDdMLnAqTQssjSyr
         MakWqAay06eSG4zd11ERpLfZWtvRt8Uc+g/WqBUQSXVh5MzYWORf1wsEsAyvRwtFaK29
         ltyQ==
X-Gm-Message-State: AOJu0YzBvrTIi5yqVQMLSbx4xWO9vcqUYmzGhbNSvUvZ7if1D0ZewMJu
        OIrN9bg9aqfCiStjQCepoTpjGKXR1kbzLYUdk9xagEV9VXR2kwTTNpNp8Fy+QwZabClHZSpgVir
        WKcKfb0SqvGiACK8IL607s6sE
X-Received: by 2002:a05:6512:3a8e:b0:4fe:1681:9377 with SMTP id q14-20020a0565123a8e00b004fe16819377mr5753144lfu.44.1695296650641;
        Thu, 21 Sep 2023 04:44:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH5GV8/baOpMr7/GmvUgeyp9wjUxfjm/iPabRuc8P8p7Gdqec3OZTU1KD7Ru8lcah55rWhSUw==
X-Received: by 2002:a05:6512:3a8e:b0:4fe:1681:9377 with SMTP id q14-20020a0565123a8e00b004fe16819377mr5753114lfu.44.1695296650114;
        Thu, 21 Sep 2023 04:44:10 -0700 (PDT)
Received: from ?IPV6:2003:cb:c70d:3c00:9eab:fce5:e6f3:e626? (p200300cbc70d3c009eabfce5e6f3e626.dip0.t-ipconnect.de. [2003:cb:c70d:3c00:9eab:fce5:e6f3:e626])
        by smtp.gmail.com with ESMTPSA id 17-20020a05600c229100b00401b242e2e6sm4592223wmf.47.2023.09.21.04.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Sep 2023 04:44:09 -0700 (PDT)
Message-ID: <a5e5b08f-851b-3dd1-889b-5b09eff5b7be@redhat.com>
Date:   Thu, 21 Sep 2023 13:44:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] mm/ksm: Test case for prctl fork/exec workflow
Content-Language: en-US
To:     Stefan Roesch <shr@devkernel.io>, kernel-team@fb.com
Cc:     akpm@linux-foundation.org, hannes@cmpxchg.org, riel@surriel.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20230920190117.784151-1-shr@devkernel.io>
 <20230920190117.784151-3-shr@devkernel.io>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230920190117.784151-3-shr@devkernel.io>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20.09.23 21:01, Stefan Roesch wrote:
> This adds a new test case to the ksm functional tests to make sure that
> the KSM setting is inherited by the child process when doing a
> fork/exec.
> 
> Signed-off-by: Stefan Roesch <shr@devkernel.io>
> ---
>   .../selftests/mm/ksm_functional_tests.c       | 67 ++++++++++++++++++-
>   1 file changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/testing/selftests/mm/ksm_functional_tests.c b/tools/testing/selftests/mm/ksm_functional_tests.c
> index 901e950f9138..40b86c9caf3a 100644
> --- a/tools/testing/selftests/mm/ksm_functional_tests.c
> +++ b/tools/testing/selftests/mm/ksm_functional_tests.c
> @@ -26,6 +26,7 @@
>   
>   #define KiB 1024u
>   #define MiB (1024 * KiB)
> +#define FORK_EXEC_CHILD_PRG_NAME "ksm_fork_exec_child"
>   
>   static int mem_fd;
>   static int ksm_fd;
> @@ -479,6 +480,65 @@ static void test_prctl_fork(void)
>   	ksft_test_result_pass("PR_SET_MEMORY_MERGE value is inherited\n");
>   }
>   
> +static int ksm_fork_exec_child(void)
> +{
> +	/* Test if KSM is enabled for the process. */
> +	int ksm = prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);
> +	return ksm == 1;

You can simply do "return prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0) == 1;"

Or maybe even "return prctl(PR_GET_MEMORY_MERGE, 0, 0, 0, 0);" and 
adjust the comparison below in the caller.

> +}
> +
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
> +		char *prg_name = "./ksm_functional_tests";
> +		char *argv_for_program[] = { prg_name, FORK_EXEC_CHILD_PRG_NAME };
> +

I'd simply have used the magic number "1" or so. But this works as well.

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

