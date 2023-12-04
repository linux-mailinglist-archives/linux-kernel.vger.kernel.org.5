Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4776C803E85
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233059AbjLDThQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjLDThP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:37:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81CE9102
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:37:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC3AEC433C7;
        Mon,  4 Dec 2023 19:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1701718641;
        bh=lK4GudktDVgm1iuvrLvxPY0Vvf+ce66Q63DHjs/RTW0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=CU1mRtxln5V5eOtpL7+7SyMQktbwgW6FxcuGkF2oQlwFTt6OKwrGbmDIrbqfkP3on
         8iHIhNCuADWxll7p8Z6ymnPxlRHC4jlmvI3zZfGMTfsqu9EaRNHgUhQwVVsPOgSvbR
         O5/q7newgVZ/fzt0iDlD28Wm/Zu67iP5evG1Jpsc=
Date:   Mon, 4 Dec 2023 11:37:20 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     liujing <liujing@cmss.chinamobile.com>
Cc:     shuah@kernel.org, adobriyan@gmail.com,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] Fixed an open function not judging the return value and
 closed the open function
Message-Id: <20231204113720.3c6ccf7b8eb11eda942d1215@linux-foundation.org>
In-Reply-To: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
References: <20231204080554.2424-1-liujing@cmss.chinamobile.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon,  4 Dec 2023 03:05:54 -0500 liujing <liujing@cmss.chinamobile.com> wrote:

> Signed-off-by: liujing <liujing@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/proc/proc-pid-vm.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/tools/testing/selftests/proc/proc-pid-vm.c b/tools/testing/selftests/proc/proc-pid-vm.c
> index cacbd2a4aec9..5fc9b46f236f 100644
> --- a/tools/testing/selftests/proc/proc-pid-vm.c
> +++ b/tools/testing/selftests/proc/proc-pid-vm.c
> @@ -205,7 +205,12 @@ static int make_exe(const uint8_t *payload, size_t len)
>  	/* Avoid ETXTBSY on exec. */
>  	snprintf(buf, sizeof(buf), "/proc/self/fd/%u", fd);
>  	fd1 = open(buf, O_RDONLY|O_CLOEXEC);
> +	if (fd == -1) {

fd1

> +		exit(1);
> +	}

unneeded braces

>  	close(fd);
> +	close(fd1);
>  
>  	return fd1;

Returning an fd which we just closed is clearly wrong.
