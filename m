Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6197C7FB6
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjJMIMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjJMIMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:12:14 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3FFCE
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:12:11 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3247cefa13aso1655985f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697184730; x=1697789530; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=SGC52X+6EfdOM44b7esjFLrzvMzDKL2p4mgyAiVtcQk=;
        b=erGPeaKd63nm7hBvQllthRPPjZtjjs5Q8i/uQX8KVRUBp8ShKblK6Ie9HkYbfDL2Zj
         3eunWTOMPs1Uy71MgzpYm5qbwxz2F4Fn6IiGZvFNjSPdNqKDS75f8RoAiQ0mqiK9Xvko
         9SqWgT9dgzm7x+Gd2qU+v0j43QccVHZXmV536A9rnb9q8tlcEbmry9SKlbTeB4CJhxNB
         nIeilfgWnhAq8W+g5fz7rjuCS5rfhk4nMHL6NhZSTDBKgtYb6o1t3E4iw/lwg77+N7EN
         aA2BqX/gmkhLtETUT2+8KQTHdvGO/S9TPKe9QnvuypxewJ1uk0YBDLKk2bHu0AgBMW4V
         1DAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697184730; x=1697789530;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SGC52X+6EfdOM44b7esjFLrzvMzDKL2p4mgyAiVtcQk=;
        b=OqwkHHDPHCpiWgDKTBEfucOdM0sqCw2Dtfc2iaOn691cSFQZrDBe6NxG9aVtzlJ9k6
         AebRfF2NW+G3GFICHvJGOM85HkNUYo70vbJBE21oHKw0dSavVTOR4H4g2JZotstrNH6Z
         bGy0kFk0ExPywhaojOnQRBvrCvHmUGwFJhQ6JpZ0iYjLIDbAV/obDiBVBKwotUZMuCyq
         I7YEGlQTAYj6Kxjib0uBSkKGO5MCNzvukpjVUO3uAQ2toYsgTr1OPmFgobinEnzB9Vxx
         J06mNLm4sR83FpBsQJRqYmQ93oRxUt6pA+iuoohKXCCxIMkhRMF2KIVxDU6CR43o3KBo
         veyw==
X-Gm-Message-State: AOJu0YyRTIry798y1S+d1PChm27SyhYusv1KrnlHbwuWo4ESb5g5sqvC
        RG8hxD4rHm8bjoRWfXWGFvYyTg==
X-Google-Smtp-Source: AGHT+IGXwzt6GufVlnOjsPlfsRIPzlaGtVvngq610MlsMUP7gghxkfnbbfFsixU3uwFuXhpwNvI7nA==
X-Received: by 2002:a5d:58ca:0:b0:31f:f65f:74ac with SMTP id o10-20020a5d58ca000000b0031ff65f74acmr21004242wrf.70.1697184730218;
        Fri, 13 Oct 2023 01:12:10 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id w14-20020adfee4e000000b0032d2489a399sm2745645wro.49.2023.10.13.01.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 01:12:09 -0700 (PDT)
Date:   Fri, 13 Oct 2023 11:12:07 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Uros Bizjak <ubizjak@gmail.com>
Subject: Re: [PATCH] perf/x86/amd/uncore: fix error codes in amd_uncore_init()
Message-ID: <0c973a20-e10c-4989-b7d9-86cb0f522718@kadam.mountain>
References: <cec62eba-c4b8-4cb7-9671-58894dd4b974@moroto.mountain>
 <ZSjyJuqk3z0RyKP2@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZSjyJuqk3z0RyKP2@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 09:30:46AM +0200, Ingo Molnar wrote:
> Ugh, why on Earth didn't GCC warn about this? The bad pattern is pretty 
> simple & obvious once pointed out ... compilers should have no trouble 
> realizing that 'ret' is returned uninitialized in some of these control 
> paths. Yet not a peep from the compiler ...

We disabled that warning years ago (5?) because GCC had too many false
positives.

regards,
dan carpenter

