Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D38C7BDCD9
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 14:52:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376606AbjJIMwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 08:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376608AbjJIMwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 08:52:10 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E2779D
        for <linux-kernel@vger.kernel.org>; Mon,  9 Oct 2023 05:52:08 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40572aeb6d0so42338395e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Oct 2023 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696855926; x=1697460726; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J6l32/EFAJt8oyMjZOw4LSiEQfFf8IwUnj2DGZ23c3I=;
        b=dVZNzC3OZwFUTAKVDxKMVIT895k+u+6no55CF4EITeCFoZF68q8rGWB+vPDOcQNPTi
         XfLeMA+rilg5WRscn1KEmLoARiarx2uePwnRpTEuCEL6Bkl7E9JvkIiK7g4B2V+nHVxS
         13Me12k8RRzG9hCOgtBQTQ8PfWVh2+MPobhll7Ooa+pscii/f2P78zCCECpi+EgbIyaY
         j7SF/l+szFz3Y8yxWRZwz/aA7jF5A5Gji3zdYFEXL6CWhMCcQqpDr7m8T2UrHbreTzrd
         6Zn9Askxy6t6fSg3Px9fqVROL/hoVYymO7oPo7h0/NHOwliy0B8bbWXR9BAH7sgWRSxX
         DSWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696855926; x=1697460726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J6l32/EFAJt8oyMjZOw4LSiEQfFf8IwUnj2DGZ23c3I=;
        b=NHw4v2b0P2b7sJOd8plzT0mgsytooUscz0nBFnaOb+l8yxCgoyc22kpYQcD62SzE44
         bdqIRYYpjbzITVKK9QTFGG6tggUhdpmDJmCc4Ocsx1XI4goaP3f94Q0VTQ6LaVJkLlP5
         DY/pNcGDNeVwvGidTHOnw+Tq+ZBdb6O14t0XMIC/pFTRBS3hjSgdsMFXCIU3MhufQU8K
         A4qNPDyOuMPL8muIKgjGCjSpqwJZyArORigeRhwKSga6Vo0h0moTSo9A1UYa+FraB4ay
         RBfOgveqd7AKHXPrNpNh46KXtB6PlYkh7PStBkHw/MF4nDs31jhKK8NFUw2M32PM8Y/U
         avCQ==
X-Gm-Message-State: AOJu0Yyr1tk471icp+rxzoEF2WE4CrFpUuEECMo+/gBjeYt0PHAVaEjs
        rBjyJX1Y/jQ+nGveGOgL0t0=
X-Google-Smtp-Source: AGHT+IGVP4sgQ/7YY7IWjbu1QSwb0vxUPMw29m+QEqmPQRKu5FPDxfPgyygtQPSTn00xQbePYutWWw==
X-Received: by 2002:adf:cd09:0:b0:317:5168:c21f with SMTP id w9-20020adfcd09000000b003175168c21fmr13130235wrm.31.1696855926132;
        Mon, 09 Oct 2023 05:52:06 -0700 (PDT)
Received: from gmail.com (1F2EF237.nat.pool.telekom.hu. [31.46.242.55])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00317b0155502sm9548260wro.8.2023.10.09.05.52.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 05:52:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Mon, 9 Oct 2023 14:52:02 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     yang.yang29@zte.com.cn
Cc:     surenb@google.com, peterz@infradead.org, hannes@cmpxchg.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org,
        juri.lelli@redhat.com
Subject: Re: [PATCH linux-next 2/3] sched/psi: Avoid update triggers and
 rtpoll_total when it is unnecessary
Message-ID: <ZSP3cuEsgwWcIKRw@gmail.com>
References: <ZSPayGSz6HQBp+3W@gmail.com>
 <202310092030430136422@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202310092030430136422@zte.com.cn>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* yang.yang29@zte.com.cn <yang.yang29@zte.com.cn> wrote:

> From: Yang Yang <yang.yang29@zte.com.cn>
> 
> When psimon wakes up and there are no state changes for rtpoll_states,
> it's unnecessary to update triggers and rtpoll_total because the pressures
> being monitored by user had not changed. This will help to slightly reduce
> unnecessary computations of psi.
> 
> And update group->rtpoll_next_update after called update_triggers() and
> update rtpoll_total. This will prevent bugs if update_triggers() uses
> group->rtpoll_next_update in the future, and it makes more sense
> to set the next update time after we finished the current update.

>  	if (now >= group->rtpoll_next_update) {
> -		update_triggers(group, now, &update_total, PSI_POLL);
> -		group->rtpoll_next_update = now + group->rtpoll_min_period;
> -		if (update_total)
> +		if (changed_states & group->rtpoll_states) {
> +			update_triggers(group, now, &update_total, PSI_POLL);
>  			memcpy(group->rtpoll_total, group->total[PSI_POLL],
>  				   sizeof(group->rtpoll_total));
> +		}
> +		group->rtpoll_next_update = now + group->rtpoll_min_period;

So please also split out the second change into a separate patch as well, 
as it's an unrelated patch to the state-change optimization.

We have a "one conceptual change per patch" rule for most things.

Thanks,

	Ingo
