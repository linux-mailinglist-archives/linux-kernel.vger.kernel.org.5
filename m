Return-Path: <linux-kernel+bounces-21752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 031528293C5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 07:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 784B92898DB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 06:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DAD5364A9;
	Wed, 10 Jan 2024 06:39:05 +0000 (UTC)
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11426ECE;
	Wed, 10 Jan 2024 06:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ghiti.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ghiti.fr
Received: by mail.gandi.net (Postfix) with ESMTPSA id F13091C0004;
	Wed, 10 Jan 2024 06:38:48 +0000 (UTC)
Message-ID: <4e0da12a-62ed-47fa-9f75-a7de10bd8dc0@ghiti.fr>
Date: Wed, 10 Jan 2024 07:38:48 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] riscv: Fix an off-by-one in get_early_cmdline()
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?=
 <bjorn@rivosinc.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 Palmer Dabbelt <palmer@rivosinc.com>, linux-riscv@lists.infradead.org
References: <9f66d2b58c8052d4055e90b8477ee55d9a0914f9.1698564026.git.christophe.jaillet@wanadoo.fr>
From: Alexandre Ghiti <alex@ghiti.fr>
In-Reply-To: <9f66d2b58c8052d4055e90b8477ee55d9a0914f9.1698564026.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-GND-Sasl: alex@ghiti.fr

Hi Christophe,

On 29/10/2023 08:20, Christophe JAILLET wrote:
> The ending NULL is not taken into account by strncat(), so switch to
> strlcat() to correctly compute the size of the available memory when
> appending CONFIG_CMDLINE to 'early_cmdline'.
>
> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>   arch/riscv/kernel/pi/cmdline_early.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/arch/riscv/kernel/pi/cmdline_early.c b/arch/riscv/kernel/pi/cmdline_early.c
> index 68e786c84c94..f6d4dedffb84 100644
> --- a/arch/riscv/kernel/pi/cmdline_early.c
> +++ b/arch/riscv/kernel/pi/cmdline_early.c
> @@ -38,8 +38,7 @@ static char *get_early_cmdline(uintptr_t dtb_pa)
>   	if (IS_ENABLED(CONFIG_CMDLINE_EXTEND) ||
>   	    IS_ENABLED(CONFIG_CMDLINE_FORCE) ||
>   	    fdt_cmdline_size == 0 /* CONFIG_CMDLINE_FALLBACK */) {
> -		strncat(early_cmdline, CONFIG_CMDLINE,
> -			COMMAND_LINE_SIZE - fdt_cmdline_size);
> +		strlcat(early_cmdline, CONFIG_CMDLINE, COMMAND_LINE_SIZE);
>   	}
>   
>   	return early_cmdline;

This looks good to me, you can add:

Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks,

Alex


