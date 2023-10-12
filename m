Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2661B7C6D7A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 13:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378632AbjJLL4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 07:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379449AbjJLL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 07:56:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D1F4497;
        Thu, 12 Oct 2023 04:52:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B74BC433C7;
        Thu, 12 Oct 2023 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697111463;
        bh=4Y7rKxiCW01/9GQcbtlTps0JwLRbYTYOda2S200SdyM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CMlfZNUFFNjNNGnSL4zV2wmeRzpu1PDENqmw8/a5GL9RGEkHwBPZPjxI3lSAWHaqr
         v1Jn6MD0CvycLDWeJtP747k6A25vufz653mr9ZEgww2siCTlcS2k+avMPi2/2xIAt5
         B+xbjoZ3qkHOeCSrRQldqOR9rsQ4vBJN2+U7INmyqFZ7jdUrPQpSVVjr8Mvq76eyKH
         p+ElPXV/Gkp0LPqoQXZ61Y8ktFZqMdDrW0UC/HtT+4Uq0Ijao0AdLaLLAUKnlMN2hv
         DOqVa2IPVuBEXN1HY89YlwmvdR7HH4ZOhP1pzAsTIhTURMuY/380oQDjNDfbirzLNn
         KlgAf+2nb681A==
From:   Miguel Ojeda <ojeda@kernel.org>
To:     dan.j.williams@intel.com
Cc:     corbet@lwn.net, gregkh@linuxfoundation.org, joe@perches.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@roeck-us.net, max.kellermann@ionos.com,
        workflows@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>
Subject: RE: [PATCH v3] Documentation/process/coding-style.rst: space around const
Date:   Thu, 12 Oct 2023 13:50:39 +0200
Message-ID: <20231012115039.1680561-1-ojeda@kernel.org>
In-Reply-To: <65271731e25f4_7258329472@dwillia2-xfh.jf.intel.com.notmuch>
References: <65271731e25f4_7258329472@dwillia2-xfh.jf.intel.com.notmuch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Oct 2023 14:44:17 -0700, Dan Williams wrote:
>
> I notice that clang-format reflows that example to:
>
>     const void *a;
>     void *const b;
>     void **const c;
>     void *const *const d;
>     int strcmp(const char *a, const char *b);
>
> ...but someone more clang-format savvy than me would need to propose the
> changes to the kernel's .clang-format template to match the style
> suggestion.

I think we could use:

    diff --git a/.clang-format b/.clang-format
    index 0bbb1991defe..9eeb511c0814 100644
    --- a/.clang-format
    +++ b/.clang-format
    @@ -671,6 +671,7 @@ SortIncludes: false
     SortUsingDeclarations: false
     SpaceAfterCStyleCast: false
     SpaceAfterTemplateKeyword: true
    +SpaceAroundPointerQualifiers: Both
     SpaceBeforeAssignmentOperators: true
     SpaceBeforeCtorInitializerColon: true
     SpaceBeforeInheritanceColon: true

At least that makes it match the documentation example -- I got this:

    const void *a;
    void * const b;
    void ** const c;
    void * const * const d;
    int strcmp(const char *a, const char *b);

But it is only supported in version >= 12, so we need to wait for the
minimum LLVM version bump.

(Thanks for the ping, Joe!)

Cheers,
Miguel
