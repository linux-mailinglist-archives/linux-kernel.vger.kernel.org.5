Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4A778DEDD
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243163AbjH3TMi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:12:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343811AbjH3RFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 13:05:09 -0400
Received: from smtp-42aa.mail.infomaniak.ch (smtp-42aa.mail.infomaniak.ch [IPv6:2001:1600:4:17::42aa])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD38719A
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 10:05:05 -0700 (PDT)
Received: from smtp-3-0001.mail.infomaniak.ch (unknown [10.4.36.108])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4RbVz407CRzMqBgm;
        Wed, 30 Aug 2023 17:05:04 +0000 (UTC)
Received: from unknown by smtp-3-0001.mail.infomaniak.ch (Postfix) with ESMTPA id 4RbVz343D9zMpp9q;
        Wed, 30 Aug 2023 19:05:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=digikod.net;
        s=20191114; t=1693415103;
        bh=wQ8zlZUErtY4oxJgQA7X3pCQwgl+/9+Lou2t/f0PtGw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=AyXUHpHh8v3MXsVgrb3g2LZ+YZX6JcfC6wbVq5fbt0122k2w7Ftmd6O2EWCmd17DS
         lZvDM9s0Ju+rihmQbsxuhVpKc1S/t5nrJRN3E6gCOkI2D+TZY1i8623/zvWpllINuo
         LUzX6s+8d7+vcGDOmyBY1Gdg8geGYrdl1YyYavKQ=
Date:   Wed, 30 Aug 2023 19:04:59 +0200
From:   =?utf-8?Q?Micka=C3=ABl_Sala=C3=BCn?= <mic@digikod.net>
To:     Ding Xiang <dingxiang@cmss.chinamobile.com>
Cc:     shuah@kernel.org, linux-security-module@vger.kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] selftests/landlock: Fix a resource leak
Message-ID: <20230830.paiqu8Caew1X@digikod.net>
References: <20230830101148.3738-1-dingxiang@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230830101148.3738-1-dingxiang@cmss.chinamobile.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to my next tree. Thanks!

On Wed, Aug 30, 2023 at 06:11:48PM +0800, Ding Xiang wrote:
> The opened file should be closed before return,
> otherwise resource leak will occur
> 
> Signed-off-by: Ding Xiang <dingxiang@cmss.chinamobile.com>
> ---
>  tools/testing/selftests/landlock/fs_test.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/landlock/fs_test.c b/tools/testing/selftests/landlock/fs_test.c
> index 83d565569512..251594306d40 100644
> --- a/tools/testing/selftests/landlock/fs_test.c
> +++ b/tools/testing/selftests/landlock/fs_test.c
> @@ -113,7 +113,7 @@ static bool supports_filesystem(const char *const filesystem)
>  {
>  	char str[32];
>  	int len;
> -	bool res;
> +	bool res = true;
>  	FILE *const inf = fopen("/proc/filesystems", "r");
>  
>  	/*
> @@ -125,14 +125,16 @@ static bool supports_filesystem(const char *const filesystem)
>  
>  	/* filesystem can be null for bind mounts. */
>  	if (!filesystem)
> -		return true;
> +		goto out;
>  
>  	len = snprintf(str, sizeof(str), "nodev\t%s\n", filesystem);
>  	if (len >= sizeof(str))
>  		/* Ignores too-long filesystem names. */
> -		return true;
> +		goto out;
>  
>  	res = fgrep(inf, str);
> +
> +out:
>  	fclose(inf);
>  	return res;
>  }
> -- 
> 2.38.1
> 
> 
> 
