Return-Path: <linux-kernel+bounces-70573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E43B859943
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 21:39:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C57761C20B8F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 20:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C73C71B5D;
	Sun, 18 Feb 2024 20:39:12 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19ECF1DFC6
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 20:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708288751; cv=none; b=C3+QnBn6kAmLz5ghWXkqGp2Ze4i/trU7tYiI4qJkukKrBKuTbudtvPErF0mG8b46vIk/2Px8QqkRddeny2IY3gA71VTzaieXl4RqPEwPk/hi2FXUg3Kh54W+S0wpMAQZaXYi+KuLotNTWbWET+NBJTAmjnFW+JAe9WVG4+eJIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708288751; c=relaxed/simple;
	bh=VvejCok1XJgX6s1aspcyZ9RXtz3XF6WUnKD755KRKhg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aGIdIFPHixga1BR2yjUwKtzSrM08PFrD7vxB9HIu0fqE20HXxbM8R40MdX0Ezx6rx2K+rp8Abf0yQOqcDYc6iZ/eR+5Ol9/tZ6Jw0A6vE/ko4SGURFTN412cPr2rEuXocM92b+bgSOBFBMZyMnnCA63Sx7jrM3MvX8QJ9iadTd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Sun, 18 Feb 2024 20:39:06 +0000
Message-ID: <2e1378df-ce3d-4f72-bbd6-6ba7654016bc@sdfg.com.ar>
Date: Sun, 18 Feb 2024 17:39:03 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] selftests/nolibc: Add tests for strlcat() and
 strlcpy()
To: Willy Tarreau <w@1wt.eu>, =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?=
 <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org
References: <20240218195110.1386840-1-rodrigo@sdfg.com.ar>
 <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
In-Reply-To: <20240218195110.1386840-5-rodrigo@sdfg.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/18/24 16:51, Rodrigo Campos wrote:
> diff --git a/tools/testing/selftests/nolibc/nolibc-test.c b/tools/testing/selftests/nolibc/nolibc-test.c
> index 6ba4f8275ac4..d373fc14706c 100644
> --- a/tools/testing/selftests/nolibc/nolibc-test.c
> +++ b/tools/testing/selftests/nolibc/nolibc-test.c
> @@ -600,6 +600,25 @@ int expect_strne(const char *expr, int llen, const char *cmp)
>   /* declare tests based on line numbers. There must be exactly one test per line. */
>   #define CASE_TEST(name) \
> @@ -991,6 +1010,14 @@ int run_stdlib(int min, int max)
>   	for (test = min; test >= 0 && test <= max; test++) {
>   		int llen = 0; /* line length */
>   
> +		/* For functions that take a long buffer, like strlcat()

Ouch, I didn't leave a "/*\n" for this comment :(

