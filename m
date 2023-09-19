Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0ABE7A6AE7
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232500AbjISSwt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:52:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjISSwr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:52:47 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC98BD
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:52:41 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-5033918c09eso404492e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695149560; x=1695754360; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qoumeRTE+qtQQI/kZW10ezE5GjBnHd3+HNtP5YPVTpo=;
        b=arpuIMn7vCmDj8p/w0bzkpy+Q50dZJ2llmtsXSvLfYCnyYMJqEaT1+rulS1MD5snYl
         VtTQZuF9K6O/iJsFLZ7eQ3eQUBhAwtjKu8zLZ7H6H4kiKLIBKi+lIbZTGnteMto7k3+J
         lV0QefUDpGJ6KFZv39XmxgpKHR9IB+CTamy8M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149560; x=1695754360;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qoumeRTE+qtQQI/kZW10ezE5GjBnHd3+HNtP5YPVTpo=;
        b=AJ00upn+CgztRomG5JXHta+HpCogWM4YBO+oPWCYgAIfMSyyRoFleEAva/Ec/zSif2
         XX8fGjnNccd5fCK09OGLNSxjY/e+ULMD8TgxCDDy/NmHwlI52kKw9MZfGZFou4XZ410t
         NcCWBzHumhzrFtbnpcE3kHkX1U/TFG7M37nWc28PMUFjpjBGFfrSjNgjW5R2Jx6D++Z1
         eIiftQaF30E4KPX9PPz8nM3iKTX2VoAcX6CxXL6PZVIPw9lz2RMP6qHeWxIHWS3brs3X
         tawKzoeDgZD2ZQvBtzMn6B+AOs+xWAH6kecBKaiSL8ooDSFf/ZpM7B9YmWSHPe/yBSdQ
         BklA==
X-Gm-Message-State: AOJu0YyczVjOA1jw0FOTH+jXo0MiBQp4mrI3xH3c3uCQq2poErCv6PNP
        MtBa4BcFKpNvvI88AHFJYaEbWOv2f388lwzAvFHKqM8L
X-Google-Smtp-Source: AGHT+IH6FB8MiVi/PZW7lWtdhdjbUxKYE4qzk62FRsq8yQQS+ISl0tjtnhzBLjv0HVHVs+OeEAe7eg==
X-Received: by 2002:a19:6903:0:b0:4fe:2d93:2b50 with SMTP id e3-20020a196903000000b004fe2d932b50mr367202lfc.31.1695149559856;
        Tue, 19 Sep 2023 11:52:39 -0700 (PDT)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id h25-20020aa7c619000000b0052fdc837d93sm7788779edq.47.2023.09.19.11.52.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:52:39 -0700 (PDT)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so7610791a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:52:39 -0700 (PDT)
X-Received: by 2002:a50:fc0e:0:b0:532:e71b:5ead with SMTP id
 i14-20020a50fc0e000000b00532e71b5eadmr258934edr.32.1695149559235; Tue, 19 Sep
 2023 11:52:39 -0700 (PDT)
MIME-Version: 1.0
References: <87zg1u1h5t.fsf@oracle.com> <CAHk-=whMkp68vNxVn1H3qe_P7n=X2sWPL9kvW22dsvMFH8FcQQ@mail.gmail.com>
 <20230911150410.GC9098@noisy.programming.kicks-ass.net> <87h6o01w1a.fsf@oracle.com>
 <20230912082606.GB35261@noisy.programming.kicks-ass.net> <87cyyfxd4k.ffs@tglx>
 <CAHk-=whnwC01m_1f-gaM1xbvvwzwTiKitrWniA-ChZv+bM03dg@mail.gmail.com>
 <87led2wdj0.ffs@tglx> <ZQmbhoQIINs8rLHp@casper.infradead.org>
 <0e69f7df80dc5878071deb0d80938138d19de1d1.camel@physik.fu-berlin.de>
 <20230919134218.GA39281@noisy.programming.kicks-ass.net> <a6c84803274116ec827cd4bdd4e72a8d0c304c27.camel@physik.fu-berlin.de>
 <CAHk-=wgUimqtF7PqFfRw4Ju5H1KYkp6+8F=hBz7amGQ8GaGKkA@mail.gmail.com>
 <87pm2eui95.ffs@tglx> <20230919143816.1741760a@gandalf.local.home>
In-Reply-To: <20230919143816.1741760a@gandalf.local.home>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Sep 2023 11:52:22 -0700
X-Gmail-Original-Message-ID: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Message-ID: <CAHk-=wizB-G40OxALNnz3-uNxuEAPf95H9hubAPeG2r2mrhwHA@mail.gmail.com>
Subject: Re: Arches that don't support PREEMPT
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Ankur Arora <ankur.a.arora@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k@lists.linux-m68k.org,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um@lists.infradead.org, Brian Cain <bcain@quicinc.com>,
        linux-hexagon@vger.kernel.org,
        Richard Henderson <richard.henderson@linaro.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 11:37, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> We could simply leave the cond_resched() around but defined as nops for
> everything but the "nostalgia club" to keep them from having any regressions.

I doubt the nostalgia club cares about some latencies (that are
usually only noticeable under extreme loads anyway).

And if they do, maybe that would make somebody sit down and look into
doing it right.

So I think keeping it around would actually be both useless and
counter-productive.

              Linus
