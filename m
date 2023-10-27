Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 786727D9E21
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 18:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232282AbjJ0QjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 12:39:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231721AbjJ0QjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 12:39:18 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B66910A
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:39:15 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7a680e6a921so24638439f.1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 09:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1698424755; x=1699029555; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7kdmvgTdy/g1PBhSvm6d233+JuZBABCykzPO40F6Sb0=;
        b=WpbP58SL1YsZcQ28IaLr6XChr451hr3yIBwZY+cs0kNE+0PqIitjFDVUpKCSowo5eu
         37zAdNnzeUJLb43Um1n5qJxbDq2MzX7XNl0CB8SvSPsub+dPqAq8RoEYhEQcVZPKXheB
         Hq3jWEe4JgRMxeW3ekmbSMx0YJXno50rm7OPznqVEYrDRBOzMQDOu9+iNCT7nTyc/TBp
         512w3Cin1+WSapmi8TfJDhNYod8gB8nd/B7Gfep19FtZdotGxj9fHDAPd88KeC04ew+h
         7hmOctf5G1O+bPaKCTkkDBlxFBRhsQ1t3h/dOSxWt84FWusg7IORs3GoEO6/ur/qr71W
         dqtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698424755; x=1699029555;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7kdmvgTdy/g1PBhSvm6d233+JuZBABCykzPO40F6Sb0=;
        b=uOpHAZj9/PoaPmxFoE0lh5mwsn1ucsniiTcDZKda2DEK8as1+6JiIGPD2naVdzaIQj
         fIZ6XI5UM+OvewfURHZj/BJBf1hUaRoOUFBF2Vajdfp35zn0q0P17NOfUoGOGzwnVg99
         4ANukE0BRVGT89CVYTt8Aa/lnnM0qS+MIV9x5YIAYYRHAeBEXWSg8VwI7g67NqLB13Z8
         O3wOJEt+uAGOPe+hszownM0nB/NrTt7V66OXGhYb6Bn0IHqgZhJML8HWwVxuLjKlBbyH
         ihtDrfD0YUVWUR84rcFOePgGH4k4SGodGUboj5GRjLcykKGpf/Q3n+1x4wNJDUPZ1ASq
         KKVQ==
X-Gm-Message-State: AOJu0YwbyrGZg/bctoDETaBBNjwBuOfxNJH34sl3/XfAn0LWv/XTzw3H
        8/+OifgEMQUMoYywtm7UFoJu6A==
X-Google-Smtp-Source: AGHT+IHyvDg4e354FvKor58bSKB5yMzHQ5KKCOjphtgOLxoK7nsxBckMk0zNCusiKkEXByx7djxxXg==
X-Received: by 2002:a6b:5c10:0:b0:790:958e:a667 with SMTP id z16-20020a6b5c10000000b00790958ea667mr3344208ioh.2.1698424754862;
        Fri, 27 Oct 2023 09:39:14 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r8-20020a6b5d08000000b0077e3566a801sm592681iob.29.2023.10.27.09.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 09:39:14 -0700 (PDT)
Message-ID: <2d15edac-0227-415a-b12c-922c6873ae04@kernel.dk>
Date:   Fri, 27 Oct 2023 10:39:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: lockdep: holding locks across syscall boundaries
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@redhat.com>, LKML <linux-kernel@vger.kernel.org>
References: <a99a7fbe-ec31-4e31-87c7-1b7ae1dd1a5a@kernel.dk>
 <20231027155949.GA26550@noisy.programming.kicks-ass.net>
 <ed3c5450-3dce-4f6a-9a8c-04fcdba1cbf2@kernel.dk>
 <20231027161235.GB26550@noisy.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20231027161235.GB26550@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/23 10:12 AM, Peter Zijlstra wrote:
> The difference is that in this case the full lock order is determined by
> kernel code (under our full control), while in the earlier example, the
> lock order is determined by syscall order -- out of our control.

Ah yes, good point - this seems like the key concept here. I think we're
better off doing this seperately and just return -EDEADLK or something
like that if it's being violated, rather than spew complaints.

Thanks!

-- 
Jens Axboe

