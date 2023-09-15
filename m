Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD997A2963
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 23:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234513AbjIOVbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 17:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbjIOVbD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 17:31:03 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21456B8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:30:58 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b962c226ceso41512481fa.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1694813456; x=1695418256; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWItdUT+koclwCUzu3KvMcq/1RkSa8EYbAgyFMCL9VA=;
        b=ZBoO0wdVK9ccT0pSfR7vw0qiaQggewwJ11weyXmhu5B3SkAu8UrtChEDs8grKMIbo1
         40M4NrpXwyK5YL2R69fIYlIi9Oc2Bb66uOFBEx6YQSQsXNvkMAFj51rXBURRqA9OJBGH
         Ven0fR+lKSzOWI0uIXjufX8poJrb94yoktcvg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694813456; x=1695418256;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bWItdUT+koclwCUzu3KvMcq/1RkSa8EYbAgyFMCL9VA=;
        b=gg6g1+6/2Pces68DiMV98G7PiwFSY2zh7dNgBhxlgO0Ga9Xxw1E0jh3T2avmqaBzfV
         dST4bwHNvjzSB3YmXatnTRV3XAY/OCSPiEl8JgwU2UvB7g3NQB52WJgLhvxtmza+Iw01
         td8OkgqxDF1HxbjWbWx1rXdxKRHgelCGcfx1ktA4YraJD7DP9MsdkSkxcjsTrNlgNaAj
         25qbv0Wnq72UOiBTuQefDpklu12axHvGiptIOtWhMV4w2ZJipzS3LHhGT00C2A8JgCFW
         IhCbF2JPKLh/S9+7ANJAP22VWpu7qS07y+L3mMsmO30fR3VphHrKRjLwFS4T0BHgJPUZ
         Rdog==
X-Gm-Message-State: AOJu0YxnJeoSkrV068fTD7qVFIEKTadWNIYqNMJnd3LtX7Hm7bFgdlHb
        TvIFjlBK68IUMgyWf3sliBAF46YO7TacSDd/6rkpoNeJ
X-Google-Smtp-Source: AGHT+IHpOyYSJeQ7V6qlibLuqepuPiPzdBrVYnypP3CTuGBNJbbFF4b0zlJSA9VcbIpBGbX8YEy1pg==
X-Received: by 2002:a2e:9d42:0:b0:2b9:e53f:e1fd with SMTP id y2-20020a2e9d42000000b002b9e53fe1fdmr2583565ljj.34.1694813456196;
        Fri, 15 Sep 2023 14:30:56 -0700 (PDT)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id e23-20020a2e9317000000b002b9899d0f0bsm863503ljh.83.2023.09.15.14.30.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Sep 2023 14:30:55 -0700 (PDT)
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5029e4bfa22so4248561e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 14:30:55 -0700 (PDT)
X-Received: by 2002:a19:c50e:0:b0:4fd:d0d5:8771 with SMTP id
 w14-20020a19c50e000000b004fdd0d58771mr1999280lfe.18.1694813454812; Fri, 15
 Sep 2023 14:30:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230913192905.0a92bcab@gandalf.local.home> <CAHk-=whAkgy10YVwjQGn1AO=1ZFc193ujvMXwmDOJAc=Jaeg5A@mail.gmail.com>
 <20230915163637.77c673a6@gandalf.local.home> <CAHk-=whNU3JaPMq_E7mwVGpTKxxeQxV=13o84u-tTeqfB_t05g@mail.gmail.com>
 <20230915171334.5c231ca7@gandalf.local.home>
In-Reply-To: <20230915171334.5c231ca7@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 15 Sep 2023 14:30:38 -0700
X-Gmail-Original-Message-ID: <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
Message-ID: <CAHk-=whbDQb5VzJbn6qQswxfbcp67uzfwpJ+R1DxHk0dHdg4pQ@mail.gmail.com>
Subject: Re: [GIT PULL] tracing: Add eventfs file to help with debugging any
 more issues
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ajay Kaher <akaher@vmware.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Sept 2023 at 14:13, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Are you entirely against this file, or is it fine if it's just wrapped
> around an CONFIG_EVENTFS_DEBUG?

Honestly, I think its' extra code that we'd carry around - probably
for much too long - with absolutely _zero_ indication that it's
actually worth it.

Not worth asking people about, but also not worth carrying around.

You worry about bugs in it now, because it's new code. That's normal.
That doesn't make your debug interface worth any kind of future.

Keep it around as a private patch. Send it out to people if there are
actual issues that might indicate this debug support would helkp. And
if it has shown itself to be useful several times, at that point you
have an argument for the code.

As it is, right now I look at that code and I see extra BS that we'll
carry around forever that helps *zero* users, and I find it very
questionable whether it would help you.

And if you really think that people need to know what the events exist
in eventfs, then dammit, make 'readdir()' see them. Not some stupid
specialty debug interface. That's what filesystems *have* readdir for.

              Linus
