Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99BD07AFF5E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 11:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230412AbjI0JDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 05:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230364AbjI0JDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 05:03:09 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B13A2126
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:03:07 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-692c70bc440so5668612b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 02:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695805387; x=1696410187; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=bj8V1LOsiyIBiVIbCC3M9pEntNFhPwnOX9TJ48ByRxU=;
        b=rQMx0rpD5Z0UHop/JBlLieOjTeUYu6ymhm5r6jWgn3CLgYIc7J5w5tkDq9W8g6WKge
         chaUwx0H7ML+04ZEX7JmRg6pGzSPusOUkwx+NlbKgUuRdk1AISqUIQcnrvUZdfPngdOb
         NXGGrLxH5n/Es4rJifMochMoTjs4uZ7uIF/c1cd2fswy+Wrs1zn5/A4rArRwHFktkSjD
         I0Nrtf1Iwm8KDMbo59YppKN0ZtDSbMqMXFBqJQZBmphuLeexoXdRcbGMf+SzsilDcjhy
         hwBOVS47nKvfO2VxR54OkKP6nSJYYUbU4krozJY9adr2WJmwKCCITaScBHU0pKnIAH9m
         QmbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695805387; x=1696410187;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bj8V1LOsiyIBiVIbCC3M9pEntNFhPwnOX9TJ48ByRxU=;
        b=MnVR7YAT6eQGI6pU5L/A94kcJpFzVIe7mwJEvQsqXgWL1o44LRDTEy1Up0QcSfgB0g
         VoB2yHqjtHkUuTuW+i5y7rPekyC7++QUI/WswvGrjcWKfvIdX4T4Yk4tPbXxQXYZeQcp
         KdjnQMgi97hFQUO68/6GkQjBDw5vzn4PsFPrMKZbHjcw92CeVEgCaVKa6SDIdXMOAp2Y
         SUfXrMyo6ex0niAwoSv+QukiITXLZG1RA/KAmwP9WYadJ32yCAGOtIkcWZFS6HPQ03/J
         HpSsSyDiwGJ/mK4WmjqEBhVJd9Q9AgdvyLb6MHF/QQ/NC0fDUOaSDi5YRLg6XPeZKGqJ
         UIqQ==
X-Gm-Message-State: AOJu0YxbagwxYUXoJ0a0OzK/f7OMunMwPtT4pTkvYJNiyYTRMO3bKiyG
        uC4CUTbAEuBzojTQKtx1pdHojg==
X-Google-Smtp-Source: AGHT+IH34fm0MLU1qMf9l4MpWQP5vVLDgZuarSDcwS9vgr6ozY5QUXvIbDZ4b7rjEYsPSHrQV0Z0/g==
X-Received: by 2002:a05:6a00:2d9d:b0:68f:c9df:2ccb with SMTP id fb29-20020a056a002d9d00b0068fc9df2ccbmr1399270pfb.1.1695805386908;
        Wed, 27 Sep 2023 02:03:06 -0700 (PDT)
Received: from localhost ([122.172.81.92])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78251000000b0068feb378b89sm11677825pfn.171.2023.09.27.02.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 02:03:06 -0700 (PDT)
Date:   Wed, 27 Sep 2023 14:33:04 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Rob Herring <robh@kernel.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] cpufreq: pmac32: Use of_property_read_reg() to parse
 "reg"
Message-ID: <20230927090304.vddwsgdzblurwage@vireshk-i7>
References: <20230925190242.1712212-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230925190242.1712212-1-robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25-09-23, 14:02, Rob Herring wrote:
> Use the recently added of_property_read_reg() helper to get the
> untranslated "reg" address value.
> 
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
> v2:
>  - Add missing include
> ---
>  drivers/cpufreq/pmac32-cpufreq.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Applied. Thanks.

-- 
viresh
