Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BCB756A36
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 19:25:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbjGQRZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 13:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjGQRZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 13:25:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4F5E49
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689614679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R04z1muq70NOluT/MMgTjYXn9ojqeIcHprwCvVIitCI=;
        b=N6q60MiXOypq1QVsALFcyET6/KB+2Vymvwj6QvKzxzu6EMUlOeutcCfA6IeGQHYbCPA6la
        9OZoLXlGkojVoKhabUAf0SXcKj83kbq01lvz25CNbxnw0P41WzgGAQ2r8q3ZC5t9LozGdn
        5MIDO/77Vxfq19MoMLXEp18t7zpV8Wg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-345-zPGHox6VPWKswhm-nrgVrg-1; Mon, 17 Jul 2023 13:24:38 -0400
X-MC-Unique: zPGHox6VPWKswhm-nrgVrg-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-31432b25c2fso3007086f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 10:24:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689614677; x=1692206677;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R04z1muq70NOluT/MMgTjYXn9ojqeIcHprwCvVIitCI=;
        b=kYOKlb7t6St40UJqgW2UG17kqI8aTfMSaQm72KlAeIBD/8u6RlUlOyNWNfFEYvNP5K
         YOkfrOnBz1UQINKOp8DViwHHFgUxjKxSC7RzfGbB4O+HopMy+Nwr1hdFJjErzGSZUeba
         wWBDq8fprdiP1fFB9Tevcbjzq/3LPYxTEy0UjjKpLP7vkvWNOwS968IOfsAsqxlS52Ia
         1nM5C+72xhCO51gbeFbq7FXU0FyWvSeC+8gT78TMWBt9utlcNobFej8whdKR65K9RByo
         zA5JKFKh3hnasiYLLmtf6yrvsfNaicSHPeciCZ+8vA3lbXJHBanJKTOy6MJrKTNHS7Ff
         PfsQ==
X-Gm-Message-State: ABy/qLZ++3UhpTTQoOAq/HUYZLoWz+QSHIWCAA375r5OVzFtxwaJyBQ8
        ppKt6ePHjeUBeLVPgpgwwihKVWdDeONzfVFYE3fHEnEj2Zms8wcdIpSbyIA+r9AieSPb6lT037z
        Htf95Rjrt/Hoj3TyQfNUos0SK
X-Received: by 2002:adf:f588:0:b0:314:2faa:a23 with SMTP id f8-20020adff588000000b003142faa0a23mr13039975wro.43.1689614677060;
        Mon, 17 Jul 2023 10:24:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlERhG55UZ5P/9dNHty+NsytWcyoi/ydB9l/aWTsqzRmSyCe+1dol9syWV+mXx6pbV/YM3UgzQ==
X-Received: by 2002:adf:f588:0:b0:314:2faa:a23 with SMTP id f8-20020adff588000000b003142faa0a23mr13039954wro.43.1689614676687;
        Mon, 17 Jul 2023 10:24:36 -0700 (PDT)
Received: from ?IPV6:2003:cb:c735:400:2501:5a2e:13c6:88da? (p200300cbc735040025015a2e13c688da.dip0.t-ipconnect.de. [2003:cb:c735:400:2501:5a2e:13c6:88da])
        by smtp.gmail.com with ESMTPSA id 20-20020a05600c22d400b003fbc9d178a8sm8426294wmg.4.2023.07.17.10.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 10:24:36 -0700 (PDT)
Message-ID: <64f546e6-9c65-78ca-0157-f823450d151f@redhat.com>
Date:   Mon, 17 Jul 2023 19:24:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 7/8] selftests/mm: Optionally pass duration to
 transhuge-stress
Content-Language: en-US
To:     Ryan Roberts <ryan.roberts@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>,
        =?UTF-8?B?SsOpcsO0bWUgR2xpc3Nl?= <jglisse@redhat.com>,
        Mark Brown <broonie@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Florent Revest <revest@chromium.org>,
        Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
References: <20230717103152.202078-1-ryan.roberts@arm.com>
 <20230717103152.202078-8-ryan.roberts@arm.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230717103152.202078-8-ryan.roberts@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.07.23 12:31, Ryan Roberts wrote:
> Until now, transhuge-stress runs until its explicitly killed, so when
> invoked by run_kselftest.sh, it would run until the test timeout, then
> it would be killed and the test would be marked as failed.
> 
> Add a new, optional command line parameter that allows the user to
> specify the duration in seconds that the program should run. The program
> exits after this duration with a success (0) exit code. If the argument
> is omitted the old behacvior remains.
> 
> On it's own, this doesn't quite solve our problem because
> run_kselftest.sh does not allow passing parameters to the program under
> test. But we will shortly move this to run_vmtests.sh, which does allow
> parameter passing.
> 
> Signed-off-by: Ryan Roberts <ryan.roberts@arm.com>
> ---
>   tools/testing/selftests/mm/transhuge-stress.c | 12 ++++++++++--
>   1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/transhuge-stress.c b/tools/testing/selftests/mm/transhuge-stress.c
> index ba9d37ad3a89..c61fb9350b8c 100644
> --- a/tools/testing/selftests/mm/transhuge-stress.c
> +++ b/tools/testing/selftests/mm/transhuge-stress.c
> @@ -25,13 +25,14 @@ int main(int argc, char **argv)
>   {
>   	size_t ram, len;
>   	void *ptr, *p;
> -	struct timespec a, b;
> +	struct timespec start, a, b;
>   	int i = 0;
>   	char *name = NULL;
>   	double s;
>   	uint8_t *map;
>   	size_t map_len;
>   	int pagemap_fd;
> +	int duration = 0;
>   
>   	ram = sysconf(_SC_PHYS_PAGES);
>   	if (ram > SIZE_MAX / psize() / 4)
> @@ -42,9 +43,11 @@ int main(int argc, char **argv)
>   
>   	while (++i < argc) {
>   		if (!strcmp(argv[i], "-h"))
> -			errx(1, "usage: %s [size in MiB]", argv[0]);
> +			errx(1, "usage: %s [-f <filename>] [-d <duration>] [size in MiB]", argv[0]);
>   		else if (!strcmp(argv[i], "-f"))
>   			name = argv[++i];
> +		else if (!strcmp(argv[i], "-d"))
> +			duration = atoi(argv[++i]);
>   		else
>   			len = atoll(argv[i]) << 20;
>   	}
> @@ -78,6 +81,8 @@ int main(int argc, char **argv)
>   	if (!map)
>   		errx(2, "map malloc");
>   
> +	clock_gettime(CLOCK_MONOTONIC, &start);
> +
>   	while (1) {
>   		int nr_succeed = 0, nr_failed = 0, nr_pages = 0;
>   
> @@ -118,5 +123,8 @@ int main(int argc, char **argv)
>   		      "%4d succeed, %4d failed, %4d different pages",
>   		      s, s * 1000 / (len >> HPAGE_SHIFT), len / s / (1 << 20),
>   		      nr_succeed, nr_failed, nr_pages);
> +
> +		if (duration > 0 && b.tv_sec - start.tv_sec >= duration)
> +			return 0;
>   	}
>   }

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb

