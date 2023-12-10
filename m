Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54A4680B994
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 08:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjLJHGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 02:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbjLJHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 02:06:14 -0500
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ADF10DF;
        Sat,  9 Dec 2023 23:06:12 -0800 (PST)
X-QQ-mid: bizesmtpipv601t1702191953twkf
Received: from localhost.localdomain ( [255.141.82.1])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sun, 10 Dec 2023 15:05:51 +0800 (CST)
X-QQ-SSF: 01200000000000B0J000000A0000000
X-QQ-FEAT: PsQCk6chbj6h4FU2I72BeOc3gpNWlAN7ZYYwmfNI2bTPdpmO6QR0dRY7cSJ5H
        q57bZVSsSmCepYmP49Uz+fXk9R94bDJXxL7H9nH3DVBL8zHBPdTVHFZhtOJ55wkwRXpckLk
        askBWocVTeETXN1Ry1ID2yHgx+eyCm9rqfDGwDIfqutekJ7wBXcTTtfZsmMajrRzHY4R7Ac
        12XkPO5qz4A08IvDO3pnady/N56oY/hYwrr4MgaQa0bF8D1yMfRWHu78VFMpVcm3VhOjA8u
        +qxG5xkE95LnX6GSdyuJV3wu+qsM+ajjEOjPd9FD6SHld9Wt9O2qzOVOET10eu66YvZ+gln
        nWXlO7YBkdTw3mRACg=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 18368869975197440686
From:   Jialu Xu <xujialu@vimux.org>
To:     masahiroy@kernel.org
Cc:     justinstitt@google.com, linux-kbuild@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        morbo@google.com, nathan@kernel.org, ndesaulniers@google.com,
        xujialu@vimux.org
Subject: Re: [PATCH v4] gen_compile_commands.py: fix path resolve with symlinks in it
Date:   Sun, 10 Dec 2023 15:05:32 +0800
Message-Id: <20231210070533.925534-1-xujialu@vimux.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <CAK7LNAQAAZXV3i1sM0ZTFDC3eOaDWBVzOV9FmiLUM5YoX=89Wg@mail.gmail.com>
References: <CAK7LNAQAAZXV3i1sM0ZTFDC3eOaDWBVzOV9FmiLUM5YoX=89Wg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpipv:vimux.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_ILLEGAL_IP,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Is there any reason why you didn't simply replace
>os.path.abspath() with os.path.realpath() ?

I have tried it before, but obviously, I made a mistake.

>This patch uses pathlib.Path() just in one place,
>leaving many call-sites of os.path.*() functions.
>
>If it is just a matter of your preference,
>you need to convert os.path.*() for consistency
>(as a follow-up patch).

Keep os.path.* as os.path.realpath() works.

>I see one more os.path.abspath()
>
>    return (args.log_level,
>            os.path.abspath(args.directory),
>            args.output,
>            args.ar,
>            args.paths if len(args.paths) > 0 else [args.directory])
>
>Does it cause a similar issue for the 'directory' field
>with symbolic link jungles?

Yes, also fixed.


--
Best Regards
Jialu Xu


