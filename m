Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A56E3753099
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 06:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234907AbjGNEgx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 00:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234497AbjGNEgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 00:36:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0498EE5C;
        Thu, 13 Jul 2023 21:36:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8317D61BE3;
        Fri, 14 Jul 2023 04:36:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77953C433C7;
        Fri, 14 Jul 2023 04:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689309408;
        bh=qs1u/ZYJZiaTb0F8yk8LaI3dBfd09CDYXgEOadys3Ug=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VWryaICehPJ4j7l6Yaff5LNSlGsxj39Rrd1Uz6PbCHNVWRzzA8Lwz6LNOreIv6mgN
         fEw8/eQF0O5XIw57yGvmclZbN9HZ/UCeNZwxt2o8iUD0QxVQng61+qKRE3zICFlOCK
         eZIxponL92EMbdrsVsDYs77GlQNLf7L+5+PkO1D7i8Ll320U4lwVi7+zqejbtriIV0
         JY/I6/LeJGNvbUD9LZpJJ37WCFisfCORc8F+CQRiqOOiZZnhwMUfIz3+cOtQvYQlnS
         +eWeFlyHa61BInTgOjkxLUDLeOu1wd7nq07EmgPKQnQ2iW71jUikVQGWVw15JcVtQm
         A7si7OxTiNT0Q==
Message-ID: <6f1014cd-f8c5-f935-dcc7-4f5a6b85e473@kernel.org>
Date:   Fri, 14 Jul 2023 06:36:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH docs] docs: maintainer: document expectations of small
 time maintainers
To:     Jakub Kicinski <kuba@kernel.org>, corbet@lwn.net
Cc:     workflows@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
References: <20230713223432.1501133-1-kuba@kernel.org>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230713223432.1501133-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 00:34, Jakub Kicinski wrote:
> We appear to have a gap in our process docs. We go into detail
> on how to contribute code to the kernel, and how to be a subsystem
> maintainer. I can't find any docs directed towards the thousands
> of small scale maintainers, like folks maintaining a single driver
> or a single network protocol.
> 
> Document our expectations and best practices. I'm hoping this doc
> will be particularly useful to set expectations with HW vendors.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> Please consider this more of a draft than a statement of my opinion.
> IOW prefer suggesting edits over arguing about correctness, hope
> that makes sense.
> ---
>  .../feature-and-driver-maintainers.rst        | 159 ++++++++++++++++++
>  Documentation/maintainer/index.rst            |   1 +
>  2 files changed, 160 insertions(+)
>  create mode 100644 Documentation/maintainer/feature-and-driver-maintainers.rst
> 
> diff --git a/Documentation/maintainer/feature-and-driver-maintainers.rst b/Documentation/maintainer/feature-and-driver-maintainers.rst
> new file mode 100644
> index 000000000000..ee8ccc22b16a
> --- /dev/null
> +++ b/Documentation/maintainer/feature-and-driver-maintainers.rst
> @@ -0,0 +1,159 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +==============================
> +Feature and driver maintainers
> +==============================
> +
> +The term "maintainer" spans a very wide range of levels of engagement
> +from people handling patches and pull requests as almost a full time job
> +to people responsible for a small feature or a driver.
> +
> +Unlike most of the chapter, this section is meant for the latter (more
> +populous) group. It provides tips and describes the expectations and
> +responsibilities of maintainers of a small(ish) section of the code.
> +
> +Driver and alike most often do not have their own mailing lists and
> +git trees but instead send and review patches on the list of a larger
> +subsystem.
> +
> +Responsibilities
> +================
> +
> +The amount of maintenance work is usually proportional to the size
> +and popularity of the code base. Small features and drivers should
> +require relatively small amount of care and feeding. Nonetheless
> +when the work does arrive (in form of patches which need review,
> +user bug reports etc.) it has to be acted upon very promptly.
> +Even when single driver only sees one patch a month, or a quarter,
> +a subsystem could well have a hundred such drivers. Subsystem
> +maintainers cannot afford to wait a long time to hear from reviewers.
> +
> +The exact expectations on the review time will vary by subsystem
> +from 1 day (e.g. networking) to a week in smaller subsystems.

Two weeks is the upper limit.

> +
> +Mailing list participation
> +--------------------------
> +
> +Linux kernel uses mailing lists as the primary form of communication.
> +Maintainers must be subscribed and follow the appropriate subsystem-wide
> +mailing list. Either by subscribing to the whole list or using more
> +modern, selective setup like
> +`lei <https://people.kernel.org/monsieuricon/lore-lei-part-1-getting-started>`_.
> +
> +Maintainers must know how to communicate on the list (plain text, no invasive
> +legal footers, no top posting, etc.)
> +
> +Reviews
> +-------
> +
> +Maintainers must review *all* patches touching exclusively their drivers,

I don't agree with this as a small driver maintainer. Several subsystem
maintainers take the patches much faster than I am able to check the
inbox. I can provide names if you need some proves. With such criteria I
should be removed from maintainers, because I am not able to review
within 24h.

Either give reasonable time, like two weeks, or don't require driver
maintainers to be 24/7 for subystem maintainer disposal. This is very
unfair rule.

> +no matter how trivial. If the patch is a tree wide change and modifies
> +multiple drivers - whether to provide a review is left to the maintainer.
> +
> +There should be multiple maintainers for any piece of code, an ``Acked-by``
> +or ``Reviewed-by`` tag (or review comments) from a single maintainer is
> +enough to satisfy this requirement.
> +
> +If review process or validation for a particular change will take longer
> +than the expected review timeline for the subsystem, maintainer should
> +reply to the submission indicating that the work is being done, and when
> +to expect full results.
> +
> +Refactoring and core changes
> +----------------------------
> +
> +Occasionally core code needs to be changed to improve the maintainability
> +of the kernel as a whole. Maintainers are expected to be present and
> +help guide and test changes to their code to fit the new infrastructure.
> +
> +Bug reports
> +-----------
> +
> +Maintainers must respond to and address bug reports. The bug reports

This is even more unreasonable than previous 1 day review. I don't have
capabilities to address bug reports for numerous drivers I am
maintaining. I don't have hardware, I don't have time, no one pays me
for it. I still need some life outside of working hours, so expecting
both reviews in 1 day and addressing bugs is way too much.

> +range from users reporting real life crashes, thru errors discovered
> +in fuzzing to reports of issues with the code found by static analysis
> +tools and new compiler warnings.
> +
> +Volunteer maintainers are only required to address bugs and regressions.

"Only required"? That's not "only" but a lot.

> +It is understood that due to lack of access to documentation and
> +implementation details they may not be able to solve all problems.

So how do I address? Say "Oh, that's bad"?

Jakub, with both of your criteria - reviewing and addressing - I should
be dropped from all the driver maintainership. If this document passes,
I will do it - drop myself - because:
1. No one pays me for it,
2. I barely have hardware,
3. I want to live a life and I am already working much more than 8h per day.


Best regards,
Krzysztof

