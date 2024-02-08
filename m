Return-Path: <linux-kernel+bounces-57865-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BBC84DE56
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECAF11C2824E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA9149E1A;
	Thu,  8 Feb 2024 10:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MwhxLA5Z"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8F018E07;
	Thu,  8 Feb 2024 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388237; cv=none; b=uHx167f9zX/GUOYk0am/xQOzz8ENRUJaG/ZnVrJbhxEYn42q2XqbaoPYwo5u62X3mTgzrbTpvixRrSFzKtbpYEuN2yjiVVM/TqbJIG5duT0lT8PFAoPh10tQdOBvoY4mZlYsYbgx04oY6Yd5ml6jfTus4JrNSHC7R4jVnva8Goc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388237; c=relaxed/simple;
	bh=K13J9XbERyxSfjmPTDP4eJHI3fqY0e+Prqu0RLjcPXQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=g0quY0X+RvIETBdu8dxFz/XShG0pR9CYAEJd47I15Ls6qg/UUMSndWVcxj7JfpircsfK4bZg4W+GOmYnfiAGNQH9Z9gZU1I2NNZBuxPlZhVt1M5n4M0LjUnEAY05C8Ur48T7OSJ2dDyksn7ntDkGpI35Ln/EzA06NAX+UkkImJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MwhxLA5Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6671C433F1;
	Thu,  8 Feb 2024 10:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707388237;
	bh=K13J9XbERyxSfjmPTDP4eJHI3fqY0e+Prqu0RLjcPXQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MwhxLA5Zi9RKpJ9QTqGVbopqqTZUaVFxsO+wajyopWDswA5HhjWMh2WtVGvrgWQRx
	 ivHnMyk9i4zEwcgGCRseLKwajgc5OrPynE2onad4ETVupBaoTjxGdidCKRgdvQO1qN
	 BArJGTRoDg5zkjThawJYmKQtoWXdA7Pln4WYXTxfLpIFH5vsP9UBkltX2w0uo4HOJs
	 gE5jsS316D9kM9AS7Z/vMMer0WBxBTUjdWcBZJ7sOz8P1wjWpv3AEoSBLMdzzwh9Hv
	 5IVvVOuhLJkW7c9Um/af8hF4oyKMg0GVMg2R68oXSmlDWk4iBf5QXEnQwmRL6r08Kn
	 tbj3AcwO6Zw6g==
Message-ID: <684ec15f-6407-430d-af8f-8751e9aa4c43@kernel.org>
Date: Thu, 8 Feb 2024 11:30:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] tools/rtla: Fix Makefile compiler options for clang
To: Nathan Chancellor <nathan@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Nick Desaulniers <ndesaulniers@google.com>, Bill Wendling
 <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Donald Zickus <dzickus@redhat.com>, stable@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 llvm@lists.linux.dev
References: <cover.1707217097.git.bristot@kernel.org>
 <567ac1b94effc228ce9a0225b9df7232a9b35b55.1707217097.git.bristot@kernel.org>
 <20240206154835.GA1433705@dev-arch.thelio-3990X>
Content-Language: en-US, pt-BR, it-IT
From: Daniel Bristot de Oliveira <bristot@kernel.org>
In-Reply-To: <20240206154835.GA1433705@dev-arch.thelio-3990X>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/6/24 16:48, Nathan Chancellor wrote:
> On Tue, Feb 06, 2024 at 12:05:29PM +0100, Daniel Bristot de Oliveira wrote:
>> The following errors are showing up when compiling rtla with clang:
>>
>>  $ make HOSTCC=clang CC=clang LLVM_IAS=1
>>  [...]
>>
>>   clang -O -g -DVERSION=\"6.8.0-rc1\" -flto=auto -ffat-lto-objects
>> 	-fexceptions -fstack-protector-strong
>> 	-fasynchronous-unwind-tables -fstack-clash-protection  -Wall
>> 	-Werror=format-security -Wp,-D_FORTIFY_SOURCE=2
>> 	-Wp,-D_GLIBCXX_ASSERTIONS -Wno-maybe-uninitialized
>> 	$(pkg-config --cflags libtracefs)    -c -o src/utils.o src/utils.c
>>
>>   clang: warning: optimization flag '-ffat-lto-objects' is not supported [-Wignored-optimization-argument]
> 
> For what it's worth, this flag is supported in clang 17.0.0 and newer:
> 
> https://github.com/llvm/llvm-project/commit/610fc5cbcc8b68879c562f6458608afe2473ab7f

Good! still, I am getting this error on fedora, with this clang version:

bristot@x1:~/src/git/linux/tools/tracing/rtla$ clang --version
clang version 17.0.6 (Fedora 17.0.6-1.fc39)
Target: x86_64-redhat-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

:-(

> But if it is not critical, just dropping the flag like you have done
> here rather than conditionally supporting it is probably easier.

Yeah, I will drop it for now, and keep monitoring.

Thanks Natan!
-- Daniel

