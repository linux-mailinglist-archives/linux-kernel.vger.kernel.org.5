Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35598779573
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Aug 2023 19:00:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235212AbjHKQ76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 12:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHKQ74 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 12:59:56 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA312D7F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:59:56 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-d6349e1d4c2so2192679276.2
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 09:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691773195; x=1692377995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=untyu5cPkqSeocr0e7g2AJW7Kz0HzBWNtTUvQZTy5oo=;
        b=5DP5lJFUvhDAbakc42v4F6JhqNfEhtf5706jOwb2pothaFWwWgrdshBhcnAIMtavPr
         y5Z9j14rSov3qH87AxlPd7GF6WPMskGlusDvru9TglXcqpt8Wy/1UoOFApBCg5egEzjg
         Fc6eRoyOMA7Dv4Eouq/dhZLubCTc68v2UhlSzNuLZNSP0RxAGJIP1+p6BHawezq7QUbQ
         mvkR3HSw/Qq+7ZYbVXt8cj2poIsnXH0GoFIB683vBnd6CJemFeGqHL5xMmtiXsV2V1RJ
         9A8WC6whP4mbbnGt6z2O+9Kfe3he3HqXcp0Q3LYsoOrNrgQILYMHKp2t1f8Q4/Ufdxs9
         agIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691773195; x=1692377995;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=untyu5cPkqSeocr0e7g2AJW7Kz0HzBWNtTUvQZTy5oo=;
        b=W1lgymlKahYpCBE+Z7/mOTW38OIR8jal9v7cJjM+8HTweCxCwS4wmWrQJ62+YeduUx
         lUGaEatAZA3Zho9vPWpzyYZz+ehzF7gBbXtCaWtX6b/6KLITqQxgzER2TX8gglN7GUO+
         gyNVV+8GPwhcWTBtJLW7eC4l2C4QNQ/2EQecJk0E2+RWQYKbXL1eQTxRJDJ+HfKQPoR5
         0szW9PcSOHD3rihHcOTOw//y8c3NCDBHqgMHF6NuF9mTpo3vuFqFRSMwxyWt0uNbtKw5
         7UGO+plKWCKPznUZDh3dVFNvsUzVuGona/0w1T4N6kXXkxknnr2hr+QPkZo/34zy2y+l
         iwvA==
X-Gm-Message-State: AOJu0YxzMP70fMkiOUPRPjFSUakaxXsDK2rYXmPPx24NjIVtPDNBsG5q
        po5yYeqr0hr1U2AKpkATpqATmTY=
X-Google-Smtp-Source: AGHT+IFdOZHUUKKXlMAzPVp6EEK112wR0UOVV5jhW02Fden7yGUp6sTA53QQzugnAjHIrOqphKo442I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:4f43:0:b0:d3f:ccc:2053 with SMTP id
 d64-20020a254f43000000b00d3f0ccc2053mr37037ybb.7.1691773195549; Fri, 11 Aug
 2023 09:59:55 -0700 (PDT)
Date:   Fri, 11 Aug 2023 09:59:54 -0700
In-Reply-To: <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
Mime-Version: 1.0
References: <ZNUnxJ26/4QfvoC+@google.com> <tencent_9C20DA1AB80A0564315EF2A91CBF7A8C260A@qq.com>
Message-ID: <ZNZpCqw7YiN7H3mU@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: trace_helpers.c: optimize
 kallsyms cache
From:   Stanislav Fomichev <sdf@google.com>
To:     Rong Tao <rtoax@foxmail.com>
Cc:     alexandre.torgue@foss.st.com, andrii@kernel.org, ast@kernel.org,
        bpf@vger.kernel.org, chantr4@gmail.com, daniel@iogearbox.net,
        deso@posteo.net, eddyz87@gmail.com, haoluo@google.com,
        iii@linux.ibm.com, john.fastabend@gmail.com, jolsa@kernel.org,
        kpsingh@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, martin.lau@linux.dev,
        mcoquelin.stm32@gmail.com, mykolal@fb.com, rongtao@cestc.cn,
        rostedt@goodmis.org, shuah@kernel.org, song@kernel.org,
        xukuohai@huawei.com, yonghong.song@linux.dev, zwisler@google.com
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/11, Rong Tao wrote:
> Thanks for your advise, you are right, i just submit v2 [0].
> 
> I just found that, because of the modified patch, your email address was not
> obtained through scripts/get_maintainer.pl, so the v2 [0] email was not sent
> to you, sorry.

No worries, as long as it reaches the list I'll get to it :-)
