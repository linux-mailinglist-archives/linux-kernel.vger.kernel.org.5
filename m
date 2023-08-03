Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4833A76E5B1
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 12:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234652AbjHCK3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 06:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbjHCK3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 06:29:43 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD97330D5;
        Thu,  3 Aug 2023 03:29:37 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-52229f084beso990243a12.2;
        Thu, 03 Aug 2023 03:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691058576; x=1691663376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4OiyaKIKW/8sCsLQAVeJ5l5BBs9EmO+LZdt/VsDvQqE=;
        b=B5ETJzlglwZWPdHU0yRHyqFFHKvtHPuo406G1NvYc9QSbMLbJecDC4bt94oyCXdlJw
         Vr7agCLRtVILSp7X1aRM/L7vDl/FjfrszUyY4M2MXhq+8Av+wX92+pvvcEJKEDKr9Cgt
         uib3kAvxwOeXWJffWysJ1dSJ+YMQVKLAgCvRqbJkNpUN/PTFbkB8FWjwhuPqOrfNiF6I
         QXoC68lcR2JLdNVmnBDQ2M/ELTMtpWw3R28tX+M/qpmBt9PyaypntzFmrasZ9lGxPniF
         Rm9ml36Q5Bz6pngJaw30YmN8i284U9vROP2R3iBy9VMIyn77yxBQ5dKpw9FF9wZI4yjA
         2afQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691058576; x=1691663376;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4OiyaKIKW/8sCsLQAVeJ5l5BBs9EmO+LZdt/VsDvQqE=;
        b=g9uGVjBBULx0CwpRIOgFFb1f1m71KnZVjP7zmeSKLRVrmDMB6xCKZJzrIKQK18W5WL
         MpFK/abdQroljxf1rWjY9W/TXN/5K3zgFKQeYCszlHzirPPUVB/28JX1B+EKxvxuQYMU
         CeGxE7wFf2EXUweu+W8VNAtz+xgHMmrVUNaCKqm4MYRHYmqFqzTHTNo7uJUG5pVHRlgE
         kkkmrId3kqMccaF9N5MF0lg5nrT3JXVrMOD8HKI5qShztACT5Hc6zIi9ic2jWvlQKR3s
         tEBNv3MJdMc9zq+UXvifczY6vWu6EQUqeerLL/Dg/+4zKIvNm6PxXn2jxk+f8Ej0tW2s
         +Q7w==
X-Gm-Message-State: AOJu0Yy3VPxpEG0Glo15srb30Sp8SG3dNRrhgfIpEbvwo/SCR2pHXykX
        yYW2Lec4LZP6vO+uENdzd9BKJCdX4wV4Zd16uHM=
X-Google-Smtp-Source: AGHT+IGp7Lpf0GJIbsiAhvBEgTIkej2hv61cCS0dKshSarVPSyPkdoMcVPcZgccQwEaA+Lc4lSuWfL8lL02IMkIcTxU=
X-Received: by 2002:a05:6402:150d:b0:523:9c:2dd3 with SMTP id
 f13-20020a056402150d00b00523009c2dd3mr3046034edw.40.1691058576140; Thu, 03
 Aug 2023 03:29:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230803083352.1585-1-zegao@tencent.com> <20230803083352.1585-2-zegao@tencent.com>
 <20230803050900.5007d2f5@gandalf.local.home>
In-Reply-To: <20230803050900.5007d2f5@gandalf.local.home>
From:   Ze Gao <zegao2021@gmail.com>
Date:   Thu, 3 Aug 2023 18:29:25 +0800
Message-ID: <CAD8CoPDNEyf9LN8HfOTUR7c5npPPivJe8yncTWr756ZzPyZkNQ@mail.gmail.com>
Subject: Re: [RFC PATCH v6 1/5] perf sched: sync state char array with the kernel
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, Ze Gao <zegao@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 3, 2023 at 5:09=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Thu,  3 Aug 2023 04:33:48 -0400
> Ze Gao <zegao2021@gmail.com> wrote:
>
> Hi Ze,
>
> > Update state char array and then remove unused and stale
> > macros, which are kernel internal representations and not
> > encouraged to use anymore.
> >
>
> A couple of things.
>
> First, the change logs of every commit need to specify the "why". The
> subject can say "what", but the change log really needs to explain why th=
is
> patch is important. For example, this patch is really two changes (and th=
us
> should actually be two patches). (I'll also comment on the other patches)

Thanks for the feedback! Will elaborate the changes in each changelog.

> 1. The update of the state char array. You should explain why it's being
> updated. If it was wrong, it needs to state the commit that changed to ma=
ke
> that happen.
>
> 2. For the removing the stale macros, the change log can simply state tha=
t
> the macros are unused in the code and are being removed.
>
> Finally, I know you're eager to get this patch set in, but please hold of=
f
> sending a new version immediately after a comment or two. Some maintainer=
s
> prefer submitters to wait a week or so, otherwise you will tend to "spam"
> their inboxes. There's more than one maintainer Cc'd on this series, and =
you
> need to be courteous not to send too many emails in a short period of tim=
e.

Noted!  Actually I'm in no rush and just to make sure people see the
latest patches so they do not have to waste time on the old series.

Will hold off to resolve all the comments in this thread.

And thanks for pointing this out.

Regards,
Ze
