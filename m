Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5847D6B53
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343883AbjJYMYy convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 25 Oct 2023 08:24:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343892AbjJYMYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:24:52 -0400
Received: from mail-oi1-f181.google.com (mail-oi1-f181.google.com [209.85.167.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6473C9C;
        Wed, 25 Oct 2023 05:24:50 -0700 (PDT)
Received: by mail-oi1-f181.google.com with SMTP id 5614622812f47-3b2d9a9c824so1254854b6e.0;
        Wed, 25 Oct 2023 05:24:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698236689; x=1698841489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DqrOjLRs28riw/P20lQEQPNQZ15w1j+cN1KPKpYivnA=;
        b=pyjgYoSsuTFksCGcLkOrD3TI+ID4Hp87AFiVvjcrAZ6xdHUNQ6VHVw1l7HpTrvN0vk
         AXgSsOxYqttU5yMB45637/86/cwKKNwKdaOA4Lna0uZtNaT+QYjUAi7H0omklqiJFoZ8
         g4l1jQKdDBMO0rM9ftFubGKtjYQ01pmvSQ8mi+KyfIJ7hqrhANSJP1Qvs0jpvd35ng1l
         qE201nYiH501Lk4rVHMd8vxLErnXslxEN0uU+5Gtm0O6EPSCVvMlfZX6BPOwZlPXb9Er
         ZbH+JCBNG46USIozBR9nUFk7a9UoFUOYUNszXP+JmxozT/oi+UUrPoHb6B2LyfzASZ7M
         HbFA==
X-Gm-Message-State: AOJu0YwcvUThHcItNrzXcB7IOFk4wdZaVUZvK/7ez6zoXuC213RCJHGP
        mkV1qnolF7t9MU2SIhU3qhyHD7tvlHcs0tZT2ps=
X-Google-Smtp-Source: AGHT+IH0abo2IUeh3MMH/ljYPbwfAcLVEOc9S12Py6b46kJ2D0FQnzYE6dwOuGyQPuXQTVW3E358Eq8mZL3ePrf5tJk=
X-Received: by 2002:a05:6808:2190:b0:3b2:f3c3:3874 with SMTP id
 be16-20020a056808219000b003b2f3c33874mr16080958oib.4.1698236689574; Wed, 25
 Oct 2023 05:24:49 -0700 (PDT)
MIME-Version: 1.0
References: <20231018162540.667646-1-vincent.guittot@linaro.org>
 <20231018162540.667646-5-vincent.guittot@linaro.org> <20231025115456.GD31201@noisy.programming.kicks-ass.net>
 <20231025121143.GA28289@noisy.programming.kicks-ass.net>
In-Reply-To: <20231025121143.GA28289@noisy.programming.kicks-ass.net>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 25 Oct 2023 14:24:38 +0200
Message-ID: <CAJZ5v0hrsC0TPUt8a+1Fqy7RQqsTQpA3K0H2z0twx4Ya6Apa9A@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] energy_model: use a fixed reference frequency
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        linux@armlinux.org.uk, catalin.marinas@arm.com, will@kernel.org,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, sudeep.holla@arm.com,
        gregkh@linuxfoundation.org, rafael@kernel.org, mingo@redhat.com,
        juri.lelli@redhat.com, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vschneid@redhat.com, viresh.kumar@linaro.org,
        lenb@kernel.org, robert.moore@intel.com, lukasz.luba@arm.com,
        ionela.voinescu@arm.com, pierre.gondois@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, acpica-devel@lists.linuxfoundation.org,
        conor.dooley@microchip.com, suagrfillet@gmail.com,
        ajones@ventanamicro.com, lftan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 25, 2023 at 2:11 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Wed, Oct 25, 2023 at 01:54:56PM +0200, Peter Zijlstra wrote:
>
> Also, can we pretty please not cross-post to moderated lists, that's
> rude.
>
> Rafael, can you please mark this acpica-devel crap as moderated in
> MAINTAINERS so that it can be auto-magically excluded from receiving
> mail?

I'm actually not sure why it is moderated.  I'll see if that can be changed.
