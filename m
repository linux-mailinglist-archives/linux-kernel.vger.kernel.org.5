Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5CF881154A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:54:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1441935AbjLMOyO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:54:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233502AbjLMOyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:54:10 -0500
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6C7E3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:54:16 -0800 (PST)
Received: by mail-qk1-x72b.google.com with SMTP id af79cd13be357-77f380d8f6aso408357285a.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:54:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=maine.edu; s=google; t=1702479255; x=1703084055; darn=vger.kernel.org;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=sYhZKTO+n/Hy770LjqTnEQ/mbZOGO/ntqNbsrj+NvGk=;
        b=SzZPap/1VBkTdxomNGlMOzALXK62v3vANuZSl5XzIoYOLak5aJbE3cdTSmiHYjcE+Q
         JFd8eIHTrXRzO2OY7HHeqP1XL8zjNegG7RWAFah/+bECQlpUVfv9cksKW6yIAz54KWc5
         yB/zo9usXOvw0CKeHlpaBSaMIJcYtaS+p3XqU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702479255; x=1703084055;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:date
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sYhZKTO+n/Hy770LjqTnEQ/mbZOGO/ntqNbsrj+NvGk=;
        b=ry0rN3rJyiOoA2V5HGCp9ercx6e8/Mjc/h5aNMzJZEKhCmWndxlR4p2x/JfUiNOgyE
         gGqTcmExO8KNFby78OBPG2DKJQRaCE+4/u1DLbHcjtMcmXecmwayMS/2K7SAkO8Bn+si
         uYCYX3E2/8XeZlYJgudxbV2XkczMEuYpEZq7Hdffe5W8mt2ZU+WN6pkhkd9ed461XK3E
         Hps0N3LH7xR0vXJBs+TodXkDg9A0/yPKLe6S4baCc1aJbYcFe9Qf+OaTagC6Ft1GgJ/k
         BPugsgdmb8ViYgvJbhZExfAoCjIR3hFOS2Qdsq89khzGxluYTpG50XNtrft+T/FSCr5/
         /APg==
X-Gm-Message-State: AOJu0Yzfi7NQFLUpJd64LFeeCheGl+7G2OjHnuDoIO7BXnhPwjFsohJq
        TbLiThQauLwo+PcxWJuMhSNw6w==
X-Google-Smtp-Source: AGHT+IH0o9dvc/q99ZcvvS/TE42YBHUKs3xa0xzfNMF3FDuCvAzTxzCANGs7FzeNBNzX67Oh34TgTQ==
X-Received: by 2002:a05:620a:4496:b0:77f:8c7a:8a94 with SMTP id x22-20020a05620a449600b0077f8c7a8a94mr3011201qkp.72.1702479255429;
        Wed, 13 Dec 2023 06:54:15 -0800 (PST)
Received: from macbook-air.local (weaver.eece.maine.edu. [130.111.218.23])
        by smtp.gmail.com with ESMTPSA id re19-20020a05620a8e1300b0077f13650cb7sm4556860qkn.2.2023.12.13.06.54.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Dec 2023 06:54:15 -0800 (PST)
From:   Vince Weaver <vincent.weaver@maine.edu>
X-Google-Original-From: Vince Weaver <vince@maine.edu>
Date:   Wed, 13 Dec 2023 09:54:09 -0500 (EST)
To:     xingwei lee <xrivendell7@gmail.com>
cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: possible deadlock in down_trylock/perf_event_open
In-Reply-To: <CABOYnLxoG=YsE1XyOjfF0O+2UrdTyK1JMir3xPapGsRzh-XFAA@mail.gmail.com>
Message-ID: <227eb61b-8068-001e-47fa-b65104b3b226@maine.edu>
References: <CABOYnLxoG=YsE1XyOjfF0O+2UrdTyK1JMir3xPapGsRzh-XFAA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Dec 2023, xingwei lee wrote:

> Hello I found a bug in kernel/perf in the lastest upstream linux 6.7.rc5
> possible deadlock in down_trylock/perf_event_open
> 
> If you fix this issue, please add the following tag to the commit:
> Reported-by: xingwei Lee <xrivendell7@gmail.com>
> 

> 
> syzkaller login: root
> Linux syzkaller 6.7.0-rc5 #3 SMP PREEMPT_DYNAMIC Mon Dec 11 17:02:24
> HKT 2023 x86_64
> root@syzkaller:~# ./572
> [  113.795108][ T8266] ------------[ cut here ]------------
> [  113.795707][ T8266] WARNING: CPU: 1 PID: 8266 at
> kernel/events/core.c:1950 __do_sys_perf_event_open0


Just wanted to add that the perf_fuzzer will trigger this warning more or 
less immediately as well.

Vince
