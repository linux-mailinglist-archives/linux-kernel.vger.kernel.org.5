Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E096F751996
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:14:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbjGMHOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234134AbjGMHN5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:13:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E6A9B19BE
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:13:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8CE612FC;
        Thu, 13 Jul 2023 00:14:30 -0700 (PDT)
Received: from [10.57.78.6] (unknown [10.57.78.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 26E413F73F;
        Thu, 13 Jul 2023 00:13:46 -0700 (PDT)
Message-ID: <7830cca8-068b-ce56-79fa-61dcb0c18bc2@arm.com>
Date:   Thu, 13 Jul 2023 08:13:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/5] kselftest: vm: Fix mdwe's mmap_FIXED test case
To:     Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Cc:     akpm@linux-foundation.org, catalin.marinas@arm.com,
        anshuman.khandual@arm.com, joey.gouly@arm.com, mhocko@suse.com,
        keescook@chromium.org, david@redhat.com, peterx@redhat.com,
        izbyshev@ispras.ru, broonie@kernel.org, szabolcs.nagy@arm.com,
        kpsingh@kernel.org, gthelen@google.com, toiwoton@gmail.com
References: <20230704153630.1591122-1-revest@chromium.org>
 <20230704153630.1591122-3-revest@chromium.org>
From:   Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20230704153630.1591122-3-revest@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/07/2023 16:36, Florent Revest wrote:
> I checked with the original author, the mmap_FIXED test case wasn't
> properly tested and fails. Currently, it maps two consecutive (non
> overlapping) pages and expects the second mapping to be denied by MDWE
> but these two pages have nothing to do with each other so MDWE is
> actually out of the picture here.
> 
> What the test actually intended to do was to remap a virtual address
> using MAP_FIXED. However, this operation unmaps the existing mapping and
> creates a new one so the va is backed by a new page and MDWE is again
> out of the picture, all remappings should succeed.
> 
> This patch keeps the test case to make it clear that this situation is
> expected to work.
> 
> Signed-off-by: Florent Revest <revest@chromium.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Fixes: 4cf1fe34fd18 ("kselftest: vm: add tests for memory-deny-write-execute")

I'm currently working to get all the mm selftests running (and ideally passing!)
on arm64 and saw these same spurious failures. Thanks for the patch!

Reviewed-by: Ryan Roberts <ryan.roberts@arm.com>
Tested-by: Ryan Roberts <ryan.roberts@arm.com>


> ---
>  tools/testing/selftests/mm/mdwe_test.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/tools/testing/selftests/mm/mdwe_test.c b/tools/testing/selftests/mm/mdwe_test.c
> index d0954c657feb..91aa9c3099e7 100644
> --- a/tools/testing/selftests/mm/mdwe_test.c
> +++ b/tools/testing/selftests/mm/mdwe_test.c
> @@ -168,13 +168,10 @@ TEST_F(mdwe, mmap_FIXED)
>  	self->p = mmap(NULL, self->size, PROT_READ, self->flags, 0, 0);
>  	ASSERT_NE(self->p, MAP_FAILED);
>  
> -	p = mmap(self->p + self->size, self->size, PROT_READ | PROT_EXEC,
> +	/* MAP_FIXED unmaps the existing page before mapping which is allowed */
> +	p = mmap(self->p, self->size, PROT_READ | PROT_EXEC,
>  		 self->flags | MAP_FIXED, 0, 0);
> -	if (variant->enabled) {
> -		EXPECT_EQ(p, MAP_FAILED);
> -	} else {
> -		EXPECT_EQ(p, self->p);
> -	}
> +	EXPECT_EQ(p, self->p);
>  }
>  
>  TEST_F(mdwe, arm64_BTI)

