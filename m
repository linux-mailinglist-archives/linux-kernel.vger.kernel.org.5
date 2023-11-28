Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3F787FAF23
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:38:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbjK1AiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjK1AiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:38:22 -0500
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082DB1B6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:38:29 -0800 (PST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-5c239897895so3280793a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701131908; x=1701736708; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=CHoMmJqx2jS7RlyJHItzIsplrhkC7rN3aK85plOL2Lw2gY+KncgWnls7PVO1wvMEVq
         4aYi5rZbGcaErAxVkuJzQfUjp5xN0qoVe5b4FOh+F+ut/KvxZVVh2oyBIFWYzwGDfMVo
         rfrW6qRFOMcCC5wqPKSovamCLNZYzVlIikCKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701131908; x=1701736708;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1fNw2eIUtbhcx1uJXLJPbzj/JB70v0tFbSwe06tS98E=;
        b=wVG1jTtKwBMAGShzgn0bRV1lK1cqJH3q9sy6vQCKuWychlrAIrUeigyHpne+xbw21Q
         wVQMrb9uBP9GG1Nzy7oshJRMn5aM1yMqUzEDBY0/zms5LzVlPsrZS5uf5izBVUny8Szn
         DhJWkvGOznU/2iz6McE6G70x6IEr+0pfUKTTFaxgBmprRqXwEG0BS6AmoLynX8EHmjAY
         uomHzBUCtdtFN+7H0iNY/+WQPgzkcTP6ku5Cpg6VNy2wcKwiARNiHEJIXNKUXQiaX8mK
         XYmGFDMi3sX8D+qvUSFSFnmkhX95/n2A1MI488lLMOT0cHKqJNU2LJWUmLRUTVNsRSbp
         vwOg==
X-Gm-Message-State: AOJu0Ywf3SdlKbEuCOKaTJPSy0sLqjfhLVX/pIHNp0MHuhrW9mWuUvqH
        LLhMZPfz8QoaqNToZRJWbfBpCw==
X-Google-Smtp-Source: AGHT+IHAitSTcXoIZlZjvSV2TgClAiDRvzC+m7Xe4lYvQu41xQFuy0SB9v8Un1QuYXWLLWDiwFuTWw==
X-Received: by 2002:a05:6a21:3514:b0:188:1df7:9afe with SMTP id zc20-20020a056a21351400b001881df79afemr15530469pzb.30.1701131908573;
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id x8-20020aa79188000000b00686b649cdd0sm7815539pfa.86.2023.11.27.16.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 16:38:28 -0800 (PST)
Date:   Mon, 27 Nov 2023 16:38:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Tejun Heo <tj@kernel.org>, Azeem Shaikh <azeemshaikh38@gmail.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Waiman Long <longman@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 0/3] kernfs: Convert from strlcpy() to strscpy()
Message-ID: <202311271637.38C4FD46@keescook>
References: <20231116191718.work.246-kees@kernel.org>
 <2023112751-cozy-dangle-3f5a@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2023112751-cozy-dangle-3f5a@gregkh>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 01:43:57PM +0000, Greg Kroah-Hartman wrote:
> On Thu, Nov 16, 2023 at 11:21:22AM -0800, Kees Cook wrote:
> > Hi,
> > 
> > One of the last users of strlcpy() is kernfs, which has some complex
> > calling hierarchies that needed to be carefully examined. This series
> > refactors the strlcpy() calls into strscpy() calls, and bubbles up all
> > changes in return value checking for callers.
> 
> Why not work instead to convert kernfs (and by proxy cgroups) to use the
> "safe" string functions based on seq_file?  This should be a simpler
> patch series to review, and implement on a per-function basis, and then
> we would not have any string functions in kernfs anymore.

One thing at a time. :) This lets us finish the strlcpy() removal. But
yes, replacing all of kernfs/sysfs to pass a seq_buf instead of a char *
is on the list. :) I think I see a way to transition to it, too.

-- 
Kees Cook
