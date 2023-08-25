Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06D527891EA
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 00:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbjHYWqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 18:46:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbjHYWqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 18:46:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26B122703
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:46:00 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id 5614622812f47-3a9b40fc500so547620b6e.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 15:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693003559; x=1693608359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heNYWo9n/x0tJpQhcy1iYlmVJ/naJ3li5SnVYnnbK8c=;
        b=THJoaJ/t5z8gEzh3VC3e7oiS7dfNrsooFz/d8Z8Mg6Hh9oEJZYhqUuMY8uMo+7m6WN
         2COMr7Wn4I1Cro2Br//OzRjXuAGj2dixmKGWWXmDv2GqoRL0uHQHwBtig+cgm514KldP
         q8dsnafd8VUX077dCplQgbnlX2PMJzjlaFtx8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693003559; x=1693608359;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heNYWo9n/x0tJpQhcy1iYlmVJ/naJ3li5SnVYnnbK8c=;
        b=cdjTtvjaWG9pEFPDcejenPiEeqFfhpxH+2Ahqt56SDdPP45aw8vHHVDumrQa05X/JI
         5/Aut95yisHs2KD6XSioDAi0mVt2UQ6any7ZEMM4lEGvZuRRpgl8T4dN2iNPTL+/K0Cu
         0/bAxwAeHb5SEL1Igpc5Xb5+jQbxMQrWRKdQN4EHhpvowwplJ5Y1NcMZkgTwMGanscPq
         yopuQl90XbdJMJoR8iB5rVd1DL7VuKdIZpAvMOk5Uk2NdC3qgBdWztTrui0Tg+FZqQu0
         HazrBgo3dNHuyb7qYG/pkOJAp3Oh1Z33mQr0zN5T+RbJM1HdjrK7EVhFTYW25yoRAJvz
         Z0yQ==
X-Gm-Message-State: AOJu0YztPQ0DCBgyC9FUYYY6WTVSaO9IdOXe3+UPzD5dmE/zIUe9Y9dP
        XGDG6mLdst2j4oXMkN30XdNqQw==
X-Google-Smtp-Source: AGHT+IFMqAjVNLkBiSnPeDhWiFOqv3y6Of+VPj4mGDZXaViPM5HgePrq4dfVEvQg5qhcPCXFg/EFIA==
X-Received: by 2002:aca:f08:0:b0:3a4:316c:8eeb with SMTP id 8-20020aca0f08000000b003a4316c8eebmr3930842oip.40.1693003559399;
        Fri, 25 Aug 2023 15:45:59 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id g9-20020a633749000000b0053051d50a48sm2177361pgn.79.2023.08.25.15.45.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Aug 2023 15:45:58 -0700 (PDT)
Date:   Fri, 25 Aug 2023 15:45:57 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Florent Revest <revest@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        david@redhat.com, peterx@redhat.com, izbyshev@ispras.ru,
        broonie@kernel.org, szabolcs.nagy@arm.com, kpsingh@kernel.org,
        gthelen@google.com, toiwoton@gmail.com
Subject: Re: [PATCH v3 5/5] kselftest: vm: Add tests for no-inherit
 memory-deny-write-execute
Message-ID: <202308251538.F716651@keescook>
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-6-revest@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230704153630.1591122-6-revest@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 05:36:29PM +0200, Florent Revest wrote:
> Add some tests to cover the new PR_MDWE_NO_INHERIT flag of the
> PR_SET_MDWE prctl.
> 
> Check that:
> - it can't be set without PR_SET_MDWE
> - MDWE flags can't be unset
> - when set, PR_SET_MDWE doesn't propagate to children

I love more self tests! :)

> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> ---
>  tools/testing/selftests/mm/mdwe_test.c | 98 ++++++++++++++++++++++++--
>  1 file changed, 92 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index 91aa9c3099e7..7bfc98bf9baa 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -22,6 +22,8 @@
>  
>  TEST(prctl_flags)
>  {
> +	EXPECT_LT(prctl(PR_SET_MDWE, PR_MDWE_NO_INHERIT, 0L, 0L, 7L), 0);
> +

An existing issue, but I think the errno should be checked for each
of these...

>  	EXPECT_LT(prctl(PR_SET_MDWE, 7L, 0L, 0L, 0L), 0);
>  	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 7L, 0L, 0L), 0);
>  	EXPECT_LT(prctl(PR_SET_MDWE, 0L, 0L, 7L, 0L), 0);
> @@ -33,6 +35,69 @@ TEST(prctl_flags)
>  	EXPECT_LT(prctl(PR_GET_MDWE, 0L, 0L, 0L, 7L), 0);
>  }
>  
> +FIXTURE(consecutive_prctl_flags) {};
> +FIXTURE_SETUP(consecutive_prctl_flags) {}
> +FIXTURE_TEARDOWN(consecutive_prctl_flags) {}
> +
> +FIXTURE_VARIANT(consecutive_prctl_flags)
> +{
> +	unsigned long first_flags;
> +	unsigned long second_flags;
> +	bool should_work;
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, same)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.should_work = true,
> +};

I think two more variants should be added to get all the combinations:

FIXTURE_VARIANT_ADD(consecutive_prctl_no_flags, same)
{
	.first_flags = 0,
	.second_flags = 0,
	.should_work = true,
};

FIXTURE_VARIANT_ADD(consecutive_prctl_both_flags, same)
{
	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
	.should_work = true,
};

> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = 0,
> +	.should_work = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_mdwe_no_inherit)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.second_flags = 0,
> +	.should_work = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_disable_no_inherit)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.should_work = false,
> +};
> +
> +FIXTURE_VARIANT_ADD(consecutive_prctl_flags, cant_enable_no_inherit)
> +{
> +	.first_flags = PR_MDWE_REFUSE_EXEC_GAIN,
> +	.second_flags = PR_MDWE_REFUSE_EXEC_GAIN | PR_MDWE_NO_INHERIT,
> +	.should_work = false,
> +};
> +
> +TEST_F(consecutive_prctl_flags, two_prctls)
> +{
> +	int ret;
> +
> +	EXPECT_EQ(prctl(PR_SET_MDWE, variant->first_flags, 0L, 0L, 0L), 0);
> +
> +	ret = prctl(PR_SET_MDWE, variant->second_flags, 0L, 0L, 0L);
> +	if (variant->should_work) {
> +		EXPECT_EQ(ret, 0);
> +
> +		ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> +		ASSERT_EQ(ret, variant->second_flags);
> +	} else {
> +		EXPECT_NE(ret, 0);

Please test the expected errno value here.

> +	}
> +}
> +
>  FIXTURE(mdwe)
>  {
>  	void *p;
> @@ -45,28 +110,45 @@ FIXTURE_VARIANT(mdwe)
>  {
>  	bool enabled;
>  	bool forked;
> +	bool inherit;
>  };
>  
>  FIXTURE_VARIANT_ADD(mdwe, stock)
>  {
>  	.enabled = false,
>  	.forked = false,
> +	.inherit = false,
>  };
>  
>  FIXTURE_VARIANT_ADD(mdwe, enabled)
>  {
>  	.enabled = true,
>  	.forked = false,
> +	.inherit = true,
>  };
>  
> -FIXTURE_VARIANT_ADD(mdwe, forked)
> +FIXTURE_VARIANT_ADD(mdwe, inherited)
>  {
>  	.enabled = true,
>  	.forked = true,
> +	.inherit = true,
>  };
>  
> +FIXTURE_VARIANT_ADD(mdwe, not_inherited)
> +{
> +	.enabled = true,
> +	.forked = true,
> +	.inherit = false,
> +};
> +
> +static bool executable_map_should_fail(const FIXTURE_VARIANT(mdwe) *variant)
> +{
> +	return variant->enabled && (!variant->forked || variant->inherit);
> +}
> +
>  FIXTURE_SETUP(mdwe)
>  {
> +	unsigned long mdwe_flags;
>  	int ret, status;
>  
>  	self->p = NULL;
> @@ -76,13 +158,17 @@ FIXTURE_SETUP(mdwe)
>  	if (!variant->enabled)
>  		return;
>  
> -	ret = prctl(PR_SET_MDWE, PR_MDWE_REFUSE_EXEC_GAIN, 0L, 0L, 0L);
> +	mdwe_flags = PR_MDWE_REFUSE_EXEC_GAIN;
> +	if (!variant->inherit)
> +		mdwe_flags |= PR_MDWE_NO_INHERIT;
> +
> +	ret = prctl(PR_SET_MDWE, mdwe_flags, 0L, 0L, 0L);
>  	ASSERT_EQ(ret, 0) {
>  		TH_LOG("PR_SET_MDWE failed or unsupported");
>  	}
>  
>  	ret = prctl(PR_GET_MDWE, 0L, 0L, 0L, 0L);
> -	ASSERT_EQ(ret, 1);
> +	ASSERT_EQ(ret, mdwe_flags);
>  
>  	if (variant->forked) {
>  		self->pid = fork();
> @@ -113,7 +199,7 @@ TEST_F(mdwe, mmap_READ_EXEC)
>  TEST_F(mdwe, mmap_WRITE_EXEC)
>  {
>  	self->p = mmap(NULL, self->size, PROT_WRITE | PROT_EXEC, self->flags, 0, 0);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_EQ(self->p, MAP_FAILED);
>  	} else {
>  		EXPECT_NE(self->p, MAP_FAILED);
> @@ -139,7 +225,7 @@ TEST_F(mdwe, mprotect_add_EXEC)
>  	ASSERT_NE(self->p, MAP_FAILED);
>  
>  	ret = mprotect(self->p, self->size, PROT_READ | PROT_EXEC);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_LT(ret, 0);
>  	} else {
>  		EXPECT_EQ(ret, 0);
> @@ -154,7 +240,7 @@ TEST_F(mdwe, mprotect_WRITE_EXEC)
>  	ASSERT_NE(self->p, MAP_FAILED);
>  
>  	ret = mprotect(self->p, self->size, PROT_WRITE | PROT_EXEC);
> -	if (variant->enabled) {
> +	if (executable_map_should_fail(variant)) {
>  		EXPECT_LT(ret, 0);
>  	} else {
>  		EXPECT_EQ(ret, 0);
> -- 
> 2.41.0.255.g8b1d071c50-goog
> 

Otherwise looks good to me!

-- 
Kees Cook
