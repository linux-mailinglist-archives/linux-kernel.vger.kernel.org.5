Return-Path: <linux-kernel+bounces-2042-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69CBD815744
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:19:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9CA231C242D7
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F54C10A1C;
	Sat, 16 Dec 2023 04:19:22 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.hallyn.com (mail.hallyn.com [178.63.66.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D3C13FEA;
	Sat, 16 Dec 2023 04:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hallyn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mail.hallyn.com
Received: by mail.hallyn.com (Postfix, from userid 1001)
	id 37D7A928; Fri, 15 Dec 2023 22:11:16 -0600 (CST)
Date: Fri, 15 Dec 2023 22:11:16 -0600
From: "Serge E. Hallyn" <serge@hallyn.com>
To: "T. Williams" <tdwilliamsiv@gmail.com>
Cc: jmorris@namei.org, serge@hallyn.com, Paul Moore <paul@paul-moore.com>,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fixing userspace memory dereference in security.c
Message-ID: <20231216041116.GA78578@mail.hallyn.com>
References: <CADN=F_ke996vNXDNz6vZ_As0Ms5Q2X7aT3t-SSGRiqdeKd6gCQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADN=F_ke996vNXDNz6vZ_As0Ms5Q2X7aT3t-SSGRiqdeKd6gCQ@mail.gmail.com>

On Wed, Oct 06, 2021 at 07:03:56PM -0400, T. Williams wrote:
>  security/security.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/security/security.c b/security/security.c
> index 9ffa9e9c5c55..7c41b5d732ab 100644
> --- a/security/security.c
> +++ b/security/security.c
> @@ -1737,6 +1737,8 @@ int security_kernel_read_file(struct file *file, enum
> kernel_read_file_id id,
>         int ret;
> 
>         ret = call_int_hook(kernel_read_file, 0, file, id, contents);
> +       if (ret > 0)
> +               return -EINVAL;
>         if (ret)
>                 return ret;
>         return ima_read_file(file, id, contents);
> -- 
> 2.25.1
> 
> This commit is to fix a userspace address dereference found by
> syzkaller.
> The crash is triggered by passing a file descriptor to an incorrectly
> formed kernel module to finit_module.
> 
> Kernel/module.c:4175 : Within the finit_module, info.len is set to the
> return value from kernel_read_file_from_fd. This value is then
> dereferenced by memcmp within module_sig_check from inside load_module.
> The value is 0xb000000 so the kernel dereferences user memory and kernel
> panics.

Hi,

thanks for sending this.  For some reason, I can't seem to find this
message-id in lore.kernel.org to see if there were ever any replies.

There is indeed a problem, although I think a more concise explanation
is:

1. security_kernel_read_file() returns any non-zero return value to mean
permission denied
2. kernel_read_file() returns > 0 meaning number of bytes read
3. hen kernel_read_file() gets any non-zero rv from security_kernel_read_file(),
it returns that value unchanged.

Since kernel_read_file() is the only caller of security_kernel_read_file(),
I think your patch is good, except you should also change the comment above
it to read

 * Return: Returns 0 if permission is granted, < 0 on error.

Reviewed-by: Serge Hallyn <serge@hallyn.com>

I think the reason it's not been a practical problem is because while
security_kernel_read_file() will honor a >0 error from an LSM, no
LSM implementation of that hook does that.  (Only loadpin and selinux
implement it)

-serge

