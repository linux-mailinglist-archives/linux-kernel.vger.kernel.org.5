Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC6697E5008
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 06:28:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbjKHF2f convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 8 Nov 2023 00:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjKHF2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 00:28:33 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83213D79;
        Tue,  7 Nov 2023 21:28:31 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2802e5ae23bso6067484a91.2;
        Tue, 07 Nov 2023 21:28:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699421311; x=1700026111;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VhqXfRxwODhhIMbjXY7lqJJHtU2M4HLF+DRW34WH2pY=;
        b=jccfGloyVaxxYjINuLDk6D2Nmr/s5zl2Mnil2V5IGTdpyEqBKZXJI4Rzoy5IIaw9bm
         Dn4YObTNS+S52VZNOzDzgepeKcB3QlPM8aDV7krMGheVJW3f8T1b+HbShxQHqL6pwyN/
         fycOIpIug5HdtGRf5RyohSETPuKPejgPInCVBrNPnt34EhnKRwpEjJGI//ZzioveKaHj
         VxZ6s9qnPtQATPdrm6HavJFYlwEKdDyzUNk999FAAMDlD7eXtrDjrLsdQhzOYGEdU7Go
         XGcM9DfzEQ1feav/ACJgIjlGKI3Eia+fbz0sRBId4vnASfyKjMjP38dhM4CXIhEPGo80
         MM/A==
X-Gm-Message-State: AOJu0YySDu4aFzuatCiqFU+riRxVTeAU3t47xzF/gNKW3w/udjMQbJmA
        RUXz/4+d1gXAsrH5p0O2iOOeEWFeS//MoF8O138=
X-Google-Smtp-Source: AGHT+IGUlnjZKXAuA7oWD1Pyr0sd4s0r2JP7W9FalrLhepcNZMe45KUeZgtaZKn2c8+EL50HsdgSRkYzOX9GQLfo4DA=
X-Received: by 2002:a17:90b:2250:b0:27d:b811:2fe4 with SMTP id
 hk16-20020a17090b225000b0027db8112fe4mr940875pjb.26.1699421310757; Tue, 07
 Nov 2023 21:28:30 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-32-namhyung@kernel.org>
 <20231107095011.7538657bbe34f0d7171add09@kernel.org>
In-Reply-To: <20231107095011.7538657bbe34f0d7171add09@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Nov 2023 21:28:19 -0800
Message-ID: <CAM9d7chO4ktQv6QVJ2OFvnBdREGL0N6mjs-28caC2QYGitYPBw@mail.gmail.com>
Subject: Re: [PATCH 31/48] perf dwarf-aux: Add die_get_cfa()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 4:50 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Oct 2023 20:50:54 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > The die_get_cfa() is to get frame base register and offset at the given
> > instruction address (pc).  This info will be used to locate stack
> > variables which have location expression using DW_OP_fbreg.
> >
>
> In the util/probe-finder.c, I added the elfutils version checker
>
> #if _ELFUTILS_PREREQ(0, 142)
>
> for CFI related code, in commit 7752f1b096e1 ("perf probe: Don't
>  compile CFI related code if elfutils is old"). Maybe we'd better to have
> a config of HAVE_DWARF_CFI_SUPPORT for this.

Sounds like a good idea.  Will add.

Thanks,
Namhyung
