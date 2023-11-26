Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B177F91FD
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 10:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbjKZJ2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 04:28:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjKZJ2d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 04:28:33 -0500
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 448B6D2;
        Sun, 26 Nov 2023 01:28:40 -0800 (PST)
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id 3AQ9SSUZ007756;
        Sun, 26 Nov 2023 10:28:28 +0100
Date:   Sun, 26 Nov 2023 10:28:28 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH 2/3] tools/nolibc: add support for getrlimit/setrlimit
Message-ID: <20231126092828.GB7407@1wt.eu>
References: <20231123-nolibc-rlimit-v1-0-a428b131de2a@weissschuh.net>
 <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231123-nolibc-rlimit-v1-2-a428b131de2a@weissschuh.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thomas,

> +int test_rlimit(void)
> +{
> +	struct rlimit rlim = {
> +		.rlim_cur = 1 << 20,
> +		.rlim_max = 1 << 20,
> +	};
> +	int ret;
> +
> +	ret = setrlimit(RLIMIT_CORE, &rlim);
> +	if (ret)
> +		return -1;
> +
> +	rlim.rlim_cur = 0;
> +	rlim.rlim_max = 0;
> +
> +	ret = getrlimit(RLIMIT_CORE, &rlim);
> +	if (ret)
> +		return -1;
> +
> +	if (rlim.rlim_cur != 1 << 20)
> +		return -1;
> +	if (rlim.rlim_max != 1 << 20)
> +		return -1;

I think you should used two different values here for cur and max so
that you can also detect stupid API bugs such as a union being used
instead of a struct, or copy-pastes in the implementation etc. For
example using 1<<20 and 1<<21 should do the trick.

Otherwise Ack-by me for the whole series, of course.

Thanks,
Willy
