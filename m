Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18836791579
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239966AbjIDKGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjIDKGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:06:19 -0400
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F03C1B4;
        Mon,  4 Sep 2023 03:06:13 -0700 (PDT)
From:   Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
        t=1693821971; bh=5WAY946IOQQTcj5wp5y/IRvUL4IKQaLM3r/dURsTAw4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=iqSN4pb5ppwhx/u+VlCS2zXRPqbdSOD2INLvs8FGIQaspNUz9fq8rA+I/NvPtxu+W
         FTSZEA5brlOsZj3UvDF+J6EtIUsK0yrVSnVFGwtVRWWEpZtD8l6vu98seBTcIkPkxb
         BbbxTTdi+Q/pIJQwH9g+7EAhIK8qOJJd+Ub68dVWrhvg7k1ZKzUMjHIHfn48bRmBTK
         NlmuiG1Lcqpu/Kc6f3sELIWzWlVucWQShTZBEX6Wwlp838D8m5UvmFoxEscbYYzzSd
         gCtfV6MGrpzSWXPkOLVbAKKAgllHm5jOlMY4x9O4ElsCJN6+lyh6FqhmPkvjp8/h3I
         GFFlOw9jHiGbA==
To:     Dongliang Mu <dzm91@hust.edu.cn>, Kalle Valo <kvalo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: unify error handling code in ath9k_hif_usb_resume
In-Reply-To: <20230903123230.2116129-1-dzm91@hust.edu.cn>
References: <20230903123230.2116129-1-dzm91@hust.edu.cn>
Date:   Mon, 04 Sep 2023 12:06:10 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87v8cqs165.fsf@toke.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dongliang Mu <dzm91@hust.edu.cn> writes:

> In ath9k_hif_usb_resume, the error handling code calls
> ath9k_hif_usb_dealloc_urbs twice in different paths.
>
> To unify the error handling code, we replace one error handling path
> with a goto statement.
>
> Note that this patch does not incur any functionability change.
>
> Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>

Hmm, if you're cleaning up that function, how about changing that else
to an early error return? I.e. change the if at the top to:

	if (!(hif_dev->flags & HIF_USB_READY)) {
		ret = -EIO;
		goto fail_resume;
	}

and drop one level of indentation from what is currently in the top
branch of the if statement.

Also, while you're at it, please reorder the variable declarations at
the top of the function to be reverse x-mas tree order (moving the 'int
ret' declaration to the bottom).

-Toke
