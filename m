Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A928F7B2CCF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 09:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjI2HGd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 03:06:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232670AbjI2HGa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 03:06:30 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAC441A7
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:06:27 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-32157c8e4c7so13633897f8f.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 00:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695971186; x=1696575986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+codVGGhv2SeiYMJcTB77YXyphBd1FT0aX06zEio1mg=;
        b=NvvaRq+0DFY6XYDSngozSYf7/TWPvDHl+sS/cSDT5/gKqEx+kplwc56Qmwb7duHoKe
         xDmx7ixh8Mv2h7X/ckK2VxvQgsHNMCmhYoP+CyBbk3AwWVvJNmazdxx6q8JhNWH6OuER
         01E4wnrYVpnvI0RLExNMVp2xeBz+Q9iNNUP984xfQb3f36Sq5T/pR9PIY32pXhuIk8hp
         wisj8kkLKSWRX/v77FA43Wsaydt252TZZEQnJ3vpaYO3FJkD3DMVBtZlZsYRowJ7ArMq
         E9YxCbPlZ+gtgRFVM4jj/vhOqKc6L0DuVMMQiLOjyVdINir6aKc4juVjP+X3vq9T1JnH
         8L+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695971186; x=1696575986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+codVGGhv2SeiYMJcTB77YXyphBd1FT0aX06zEio1mg=;
        b=JTxylHbhyXF1RMVnbQLcHDdL2VjkSllJqycwx5MVMn6K3/mrYGzwCmaigrtFkpR17O
         9aQL+i9GD15tox2LSsYGEU1/HCa9MzCiAIW0xgVGOT0Yu9v5W7/8x36Kz1aj00D82ZNY
         tJL8N7JGE6UYR+zDkb0qP+obOgJzD/7zBowXiQz5KQF5Op3pj32awd9I/CbXtI1sDicW
         uH7Qj9X7gqViFMsrlTNCvbXPDbyfLjWXRLsaZiazkdHKV9+2RbMDAqckv7tOH77Bu+tj
         7K3tnl+/XrybXZT95klQkpMOoy9Gg1br2PGKSJ6INz8ubVSfmc+vG28nuZ9iqXhibDZf
         rYIw==
X-Gm-Message-State: AOJu0YzurS90BZO0o7PGRmo6WhygQ6Ax/eLdagdp1WKRgqte7TAxSpSi
        jIGpjTJB6H093l99iUgnQXNvGA==
X-Google-Smtp-Source: AGHT+IHLqhqTQu0Fr5JMPqWwa7uQJwfQRsA/hKEBcTKE77tO24/89NMM282LtWvd6H4sBTkNo0TI5A==
X-Received: by 2002:a05:6000:1085:b0:323:2c39:bb3d with SMTP id y5-20020a056000108500b003232c39bb3dmr2776319wrw.64.1695971186094;
        Fri, 29 Sep 2023 00:06:26 -0700 (PDT)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id q18-20020adfb192000000b0031f8a59dbeasm8634280wra.62.2023.09.29.00.06.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 00:06:25 -0700 (PDT)
Date:   Fri, 29 Sep 2023 10:06:22 +0300
From:   Dan Carpenter <dan.carpenter@linaro.org>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>
Subject: Re: [PATCH] gfs2: fix 'passing zero to ERR_PTR()' warning
Message-ID: <a2d702b0-e819-47b0-a945-c2e38a162381@kadam.mountain>
References: <ZRXA7n0wD83zhPxC@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRXA7n0wD83zhPxC@runicha.com>
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 28, 2023 at 11:37:42PM +0530, Deepak R Varma wrote:
> Resolve the following Smatch static checker warning:
> 	fs/gfs2/acl.c:54 __gfs2_get_acl() warn: passing zero to 'ERR_PTR'
> 
> by returning NULL when an extended attribute length is zero, instead of
> passing on zero to the ERR_PTR().
> 
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Passing zero to ERR_PTR() is not a bug.

You're patch doesn't change how the code works at all, right?  So it's
like a cleanup patch.  But the code was nicer in the original.

This is just a false positive.  Ignore static checker false positives.
Fix the checker instead.  Although in this case, I can't think of an
easy way fix the checker.  Perhaps don't print a warning if the callers
check for NULL?

The passing zero to ERR_PTR() warning is actually a pretty good
heuristic.  90% of the time in new code this is a real bug.  But in old
code then probably it's 0% real bugs because we've been reviewing these
warnings for over a decade.

I have a blog which might be useful.
https://staticthinking.wordpress.com/2022/08/01/mixing-error-pointers-and-null/

When I'm reviewing this patch I think:
1) Does gfs2_xattr_acl_get() return zero?  And it does.
2) Does that look intentional.  It's harder to tell because there aren't
   comments and it looks like it might be a missing error code.  But
   when you read it closely then actually it does look intentional.
   In terms of Smatch, I consider it "intentional" if there is an
   "error = 0;" within 5 lines for the goto.  (Other languages like Rust
   are better than C because they force everyone to follow the rules.
   #trolling).
3) Do the callers of __gfs2_get_acl() check for NULL and they do.

So this code is fine.

I hope this helps you in your review process.  1)  Ignore old warnings.
2)  Ignore false positives.  3)  If you think it is a bug, then try to
figure out how it will cause a crash.  Look at the caller etc.

regards,
dan carpenter

