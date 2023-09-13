Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15B679EB10
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 16:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240050AbjIMO2p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 10:28:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230467AbjIMO2o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 10:28:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9288090;
        Wed, 13 Sep 2023 07:28:40 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B805C433C7;
        Wed, 13 Sep 2023 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694615320;
        bh=rcLzO3OYaAAvOX7rxWEj6f6QPwrFW+RcBo7p4jrFlQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=GuPlCbEW/5riWzVVkR2q4pi4+4FQ3n3/07c8v1dZfQiZgTfMCGdjAsDgTyJzpzGPM
         ZCFE9M5vr0v3/C/fH1ZwcywiLvLtPQN6vLWdHhYjp0v1fQTetwhZu/VUJD0vOao9V9
         pncz0Kq1DsuUTMa/lwnshyq9O7azG7wzA0WRJBGssm7aovU4DS4/R112mZv3ksrnbk
         yy72eWXn5YYThy/bvn6V38fWFcWYVy7SfWQCXY23ZjO7epSVemgIcJ9Q6XVhoa9ohi
         tgotR+PHk26zMUqvwFLkDK7AkQgBFCiEvUVEM0+neb6o9kuTkpnpHEadjRrRxcRqnX
         8inZeOOgidSfQ==
Date:   Wed, 13 Sep 2023 23:28:35 +0900
From:   Masami Hiramatsu (Google) <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ajay Kaher <akaher@vmware.com>, chinglinyu@google.com,
        lkp@intel.com, namit@vmware.com, oe-lkp@lists.linux.dev,
        amakhalov@vmware.com, er.ajay.kaher@gmail.com,
        srivatsa@csail.mit.edu, tkundu@vmware.com, vsirnapalli@vmware.com
Subject: Re: [PATCH 3/3] tracing/selftests: Update kprobe args char/string
 to match new functions
Message-Id: <20230913232835.9f19784575840d9bbe2bb7bd@kernel.org>
In-Reply-To: <20230913030021.967983629@goodmis.org>
References: <20230913025855.615399273@goodmis.org>
        <20230913030021.967983629@goodmis.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Sep 2023 22:58:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> 
> The function that the kprobe_args_char and kprobes_arg_string attaches to
> for its test has changed its name once again. Now we need to check for
> eventfs_create_dir(), and if it exists, use that, otherwise check for
> eventfs_add_dir() and if that exists use that, otherwise use the original
> tracefs_create_dir()!

OK, looks good to me.

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

Thank you,

> 
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_char.tc        | 4 +++-
>  .../selftests/ftrace/test.d/kprobe/kprobe_args_string.tc      | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> index ff7499eb98d6..c639c6c8ca03 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_char.tc
> @@ -34,7 +34,9 @@ mips*)
>  esac
>  
>  : "Test get argument (1)"
> -if grep -q eventfs_add_dir available_filter_functions; then
> +if grep -q eventfs_create_dir available_filter_functions; then
> +  DIR_NAME="eventfs_create_dir"
> +elif grep -q eventfs_add_dir available_filter_functions; then
>    DIR_NAME="eventfs_add_dir"
>  else
>    DIR_NAME="tracefs_create_dir"
> diff --git a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> index a202b2ea4baf..a5ab4d5c74ac 100644
> --- a/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> +++ b/tools/testing/selftests/ftrace/test.d/kprobe/kprobe_args_string.tc
> @@ -37,7 +37,9 @@ loongarch*)
>  esac
>  
>  : "Test get argument (1)"
> -if grep -q eventfs_add_dir available_filter_functions; then
> +if grep -q eventfs_create_dir available_filter_functions; then
> +  DIR_NAME="eventfs_create_dir"
> +elif grep -q eventfs_add_dir available_filter_functions; then
>    DIR_NAME="eventfs_add_dir"
>  else
>    DIR_NAME="tracefs_create_dir"
> -- 
> 2.40.1


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
