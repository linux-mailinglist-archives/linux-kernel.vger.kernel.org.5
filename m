Return-Path: <linux-kernel+bounces-15062-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 727128226DA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 03:17:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E75C91F22651
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 02:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131211C32;
	Wed,  3 Jan 2024 02:17:28 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E93139E;
	Wed,  3 Jan 2024 02:17:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C53AC433C8;
	Wed,  3 Jan 2024 02:17:26 +0000 (UTC)
Date: Tue, 2 Jan 2024 21:18:27 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: <mhiramat@kernel.org>, <paulmck@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-fsdevel@vger.kernel.org>, <quic_tingweiz@quicinc.com>
Subject: Re: [PATCH 1/1] fs/proc: remove redudant comments from
 /proc/bootconfig
Message-ID: <20240102211827.0841c0df@gandalf.local.home>
In-Reply-To: <1704190777-26430-1-git-send-email-quic_zhenhuah@quicinc.com>
References: <1704190777-26430-1-git-send-email-quic_zhenhuah@quicinc.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 2 Jan 2024 18:19:37 +0800
Zhenhua Huang <quic_zhenhuah@quicinc.com> wrote:

> commit 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to
> /proc/bootconfig") adds bootloader argument comments into /proc/bootconfig.
> 
> /proc/bootconfig shows boot_command_line[] multiple times following
> every xbc key value pair, that's duplicated and not necessary.
> Remove redundant ones.
> 
> Output before and after the fix is like:
> key1 = value1
> *bootloader argument comments*
> key2 = value2
> *bootloader argument comments*
> key3 = value3
> *bootloader argument comments*
> ...
> 
> key1 = value1
> key2 = value2
> key3 = value3
> *bootloader argument comments*
> ...
> 
> Fixes: 717c7c894d4b ("fs/proc: Add boot loader arguments as comment to /proc/bootconfig")
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Nice catch.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve

> ---
>  fs/proc/bootconfig.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/proc/bootconfig.c b/fs/proc/bootconfig.c
> index 902b326..e5635a6 100644
> --- a/fs/proc/bootconfig.c
> +++ b/fs/proc/bootconfig.c
> @@ -62,12 +62,12 @@ static int __init copy_xbc_key_value_list(char *dst, size_t size)
>  				break;
>  			dst += ret;
>  		}
> -		if (ret >= 0 && boot_command_line[0]) {
> -			ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> -				       boot_command_line);
> -			if (ret > 0)
> -				dst += ret;
> -		}
> +	}
> +	if (ret >= 0 && boot_command_line[0]) {
> +		ret = snprintf(dst, rest(dst, end), "# Parameters from bootloader:\n# %s\n",
> +			       boot_command_line);
> +		if (ret > 0)
> +			dst += ret;
>  	}
>  out:
>  	kfree(key);


