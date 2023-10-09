Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F5D7BE411
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 17:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376461AbjJIPMx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 11:12:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376375AbjJIPMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 11:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BD0AA3
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 08:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696864326;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWheL9NPpP28/IT7qBTiYxZ/8MEfuddV0O/NUpo7MnE=;
        b=E1qUsZBQzMSsqmTC48gBNYns+Fz5Zfd4+xxzM7GCpX+orE81bkTwP8QEPSgVkciq7ObSab
        BGjAL9/x98B6lJpB5GBPLD4VfSZnISJMOBLEu7O4YuQJeV/t6eScgO34uNHPFZj+rTfjkV
        u2aufFGZxnxKHfUhuvHy5T0O/Qwz2K4=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-290-FNlJbYrgMp227rMS2-xE2w-1; Mon, 09 Oct 2023 11:12:05 -0400
X-MC-Unique: FNlJbYrgMp227rMS2-xE2w-1
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-4180bc4227bso88706521cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 08:12:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696864324; x=1697469124;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dWheL9NPpP28/IT7qBTiYxZ/8MEfuddV0O/NUpo7MnE=;
        b=fM7cLX+h2XOKUubdIlELocc25rKo0N5tszqreCNd5SQUZjp2+NxKBYWi/GRaadIFLH
         DDtLGN6Mp7NzYQW6gXiNBmhrUPaNJU/1kXB2A0AJjZazNZTLOU7Vi8uCPVxXsuprCwbz
         gNjPgmY6zCTlmIz12XBPYCPQew7mFxA+JH3FfzJeIgzWTjClgvAwiwmXBbSoYkKX10FK
         g4UhOO8K+k1kSbKmCKwMdLalE610DfOCijeHGVmg24PnX9UYwF+Ba9iE8QN2S25amP0G
         kzi7x24r6sVAGMvUw7Y9Uy9qFXWBav+Rb2MZPIKolXCxoiHZTH7Qog7N9N3lqS9tzAZS
         MR4g==
X-Gm-Message-State: AOJu0YxEf2TKUGw2ZCs5AWnmylsmRL3ySRw/Htgc52lH4TBxxaLZZqTW
        +gDuJrlyaMJNlHTB0npwg4Nhk+jnwjGZAIw3tJaSWAEpNmcFeaNxJCBEDx1Jdvm7v5fgDzPfUWF
        OLXHXIScaeTnCzIrNAfVbsscL4OJsaTnf
X-Received: by 2002:ac8:7d8c:0:b0:415:1804:d9ee with SMTP id c12-20020ac87d8c000000b004151804d9eemr15289308qtd.16.1696864324410;
        Mon, 09 Oct 2023 08:12:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF/8LPmeDeSvnmvknyt8UY5KqeAQPZ473cqIuwzMSe8130s3hhWp5rCz2VdJFee0PE7ktMtyg==
X-Received: by 2002:ac8:7d8c:0:b0:415:1804:d9ee with SMTP id c12-20020ac87d8c000000b004151804d9eemr15289288qtd.16.1696864324168;
        Mon, 09 Oct 2023 08:12:04 -0700 (PDT)
Received: from vschneid.remote.csb (213-44-141-166.abo.bbox.fr. [213.44.141.166])
        by smtp.gmail.com with ESMTPSA id g10-20020ac84b6a000000b00417dd1dd0adsm3753683qts.87.2023.10.09.08.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 08:12:03 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 1/3] sched/nohz: Update idle load-balancing (ILB) comments
In-Reply-To: <20231006102518.2452758-2-mingo@kernel.org>
References: <20231006102518.2452758-1-mingo@kernel.org>
 <20231006102518.2452758-2-mingo@kernel.org>
Date:   Mon, 09 Oct 2023 17:12:00 +0200
Message-ID: <xhsmhfs2jomnz.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/23 12:25, Ingo Molnar wrote:
>  - Fix incorrect/misleading comments,
>
>  - clarify some others,
>
>  - fix typos & grammar,
>
>  - and use more consistent style throughout.
>
> Signed-off-by: Ingo Molnar <mingo@kernel.org>
> Cc: linux-kernel@vger.kernel.org

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

