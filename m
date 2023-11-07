Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 273157E4C07
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 23:50:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343574AbjKGWuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 17:50:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232452AbjKGWuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 17:50:05 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F00DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 14:50:03 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6c43f830566so967513b3a.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 14:50:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699397403; x=1700002203; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/+vhIz7LwiojaeUjPwh9VacelWUXCMWwhB6gmZPNvcI=;
        b=cn0xkmTVJVoK0y2t8vNBoRqFLFEjjpAFhRExyuLliqkqN6G13Jy0Ds3Fd1tBLfY0k2
         kqaw6nCua9OaQYMAcF5/ve6DwEzr3Iv5SOrWQCl/5lnfwoPJVaJzu4BaOY/+LB+NjX4J
         e8zOO627E4BLk45ihcbi6KiUktJQsDgYcNLMg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699397403; x=1700002203;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/+vhIz7LwiojaeUjPwh9VacelWUXCMWwhB6gmZPNvcI=;
        b=o+2kjIDYnCip+CobYAT+KX6xB5pd3r5YTuZB8cRth1oEbw1Q9v75shdPe6WonB/ExW
         jrZfaJBK0iYW+BTS+7w4ZDTYh2rZXWUtUc/tmyi1whJzHPE4HY3FYfmPAknPkhdpEJct
         2krkYmqj6SYwAnH1pqxZF/NdbGyhhKZ1Sc3gIez4Jv1AQxO3STxZDgB98aAHzja2u+6o
         DEnyArmCXhhRi0P3ogDm2P5AXjigIvAnB0/ZXgCn5i6CW7n2sNb6BrmapQ6UWve/yJaY
         syj5Ryay1SGYSaQS78xPgds4Ew581PSABF5L1F/xoIuxqqHcBkgWBgZ/0eduOt7lGzM/
         KoWg==
X-Gm-Message-State: AOJu0YySofKSw4qSPNZQGcbROlG9IlfQ+Ugo+bXO83MmYgc831v84UjH
        EovKILQRS0PcQDTEZgCYiRM1ow==
X-Google-Smtp-Source: AGHT+IH1d5SgbcL7itiPSWGAZKEFAhSQqcwo0xaVEpMRSh8OO+9Cff/xp9eUmO+GeaQGXC48IEgL7g==
X-Received: by 2002:a05:6a20:3ca4:b0:140:f6c4:aa71 with SMTP id b36-20020a056a203ca400b00140f6c4aa71mr434754pzj.8.1699397403202;
        Tue, 07 Nov 2023 14:50:03 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id jc4-20020a17090325c400b001cc52b58df6sm322717plb.215.2023.11.07.14.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Nov 2023 14:50:02 -0800 (PST)
Date:   Tue, 7 Nov 2023 14:50:01 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Mateusz Guzik <mjguzik@gmail.com>
Cc:     Josh Triplett <josh@joshtriplett.org>,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/exec.c: Add fast path for ENOENT on PATH search
 before allocating mm
Message-ID: <202311071445.53E5D72C@keescook>
References: <5c7333ea4bec2fad1b47a8fa2db7c31e4ffc4f14.1663334978.git.josh@joshtriplett.org>
 <202311071228.27D22C00@keescook>
 <20231107205151.qkwlw7aarjvkyrqs@f>
 <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGudoHFsqMPmVvaV7BebGkpkw=pSQY8PLdB-1S3W5NpYh6trmA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:23:16PM +0100, Mateusz Guzik wrote:
> If the patch which dodges second lookup still somehow appears slower a
> flamegraph or other profile would be nice. I can volunteer to take a
> look at what's going on provided above measurements will be done and
> show funkyness.

When I looked at this last, it seemed like all the work done in
do_filp_open() (my patch, which moved the lookup earlier) was heavier
than the duplicate filename_lookup().

What I didn't test was moving the sched_exec() before the mm creation,
which Peter confirmed shouldn't be a problem, but I think that might be
only a tiny benefit, if at all.

If you can do some comparisons, that would be great; it always takes me
a fair bit of time to get set up for flame graph generation, etc. :)

-Kees

-- 
Kees Cook
