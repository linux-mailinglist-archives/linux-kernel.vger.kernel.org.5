Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD2E771339
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 04:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229584AbjHFCGA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 22:06:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFCF6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 22:05:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22F5D1FF3
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 19:05:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A637E60F64
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 02:05:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 977F0C433C7;
        Sun,  6 Aug 2023 02:05:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691287557;
        bh=Z4QnozTfyOTeA6ryCGMdqKhzAe2vCk+mRvcfqr/TDAc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=dKJyxiFD3aOn3IzP847Q8tCFPdH+u9Cx9OqBpcqrUizUtkVlkZ5leIYSUl8IwbANo
         x5AvixfliXQjyqOQxw/n1CkuigL6VOQvlfNVLMhICwCQxJgpRLY7UkG3+NENE9fGfO
         tgZLnQR5iZyf4bxsBwvGBQrKqIz0z5Vx2oLWTwEFr59AWBeqvIHhwD1X3ZsPpkQ7ff
         9i49QGrRyFQ+mZ1ZZ8l64xiQuNpozK3qoK9+cnzdFVYG51Aw76ft+9F41MxFMef9Rh
         +T1j1/veJ6btMX81rdc361Sh/gr8jq42Y5dLMdNn71HXqxMxNXZU83BTetZn8patvz
         zfIzbhMfy3Oow==
Message-ID: <791fbf71-093e-3ef5-b02b-6d6bba72b57f@kernel.org>
Date:   Sun, 6 Aug 2023 10:05:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/1] f2fs: move fiemap to use iomap framework
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com,
        Daeho Jeong <daehojeong@google.com>
References: <20230731012626.6843-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230731012626.6843-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/7/31 9:26, Wu Bo wrote:
> This patch has been tested with xfstests by running 'kvm-xfstests -c
> f2fs -g auto' with and without this patch; no regressions were seen.
> 
> Some tests fail both before and after, and the test results are:
> f2fs/default: 683 tests, 9 failures, 226 skipped, 30297 seconds
>    Failures: generic/050 generic/064 generic/250 generic/252 generic/459
>        generic/506 generic/563 generic/634 generic/635

Can you please take a look at gerneic/473 ?

generic/473 1s ... - output mismatch (see /media/fstests/results//generic/473.out.bad)
     --- tests/generic/473.out	2022-11-10 08:42:19.231395230 +0000
     +++ /media/fstests/results//generic/473.out.bad	2023-08-04 02:02:01.000000000 +0000
     @@ -6,7 +6,7 @@
      1: [256..287]: hole
      Hole + Data
      0: [0..127]: hole
     -1: [128..255]: data
     +1: [128..135]: data
      Hole + Data + Hole
      0: [0..127]: hole
     ...
     (Run 'diff -u /media/fstests/tests/generic/473.out /media/fstests/results//generic/473.out.bad'  to see the entire diff)

Other concern is, it needs to test this implementation on compressed file,
since the logic is a little bit complicated.

+Cc Daeho Jeong

Thanks,
