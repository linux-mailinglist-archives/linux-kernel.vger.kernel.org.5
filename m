Return-Path: <linux-kernel+bounces-66019-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E294185557B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E9492847C0
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:03:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6826D141989;
	Wed, 14 Feb 2024 22:03:19 +0000 (UTC)
Received: from alerce.blitiri.com.ar (alerce.blitiri.com.ar [49.12.208.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0995141987
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 22:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.208.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707948198; cv=none; b=tx8iXmNj8zYCkJO94BY49IaqnP+3pEAM1QIihWWoD8fwvOy376nQYaZYNcBwOXfDa0h62dj0tbjWBkjRiassxBfzgCmKWUaA2F6UXJHplVynhWFacCD2RSglfZNSJIJGao+yxPFOx/W/zrj+UeTOrjN06y+jlhiyg1riUv+yBkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707948198; c=relaxed/simple;
	bh=bm+DDeD+3WZc10UE4ly/LZAYH80yyDouR+N9Lw06dKE=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=c/jjwom0irt+xVAuV6YqfnMhoAy9EuD1Fqm1dc7/OqCAdfvFQVoNu9JSlaMB8RewJcpwyzIPdmd9UfSKXksfI6T8+95euLniEbou+CnHC5FNIteNxKN+00Zs1aUsaQ0Y1KyDT/FUEcF6EZ0e8nMqFvhPG5U3SGH2woTdzirMBmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar; spf=pass smtp.mailfrom=sdfg.com.ar; arc=none smtp.client-ip=49.12.208.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sdfg.com.ar
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sdfg.com.ar
Received: from [192.168.0.26]
	by sdfg.com.ar (chasquid) with ESMTPSA
	tls TLS_AES_128_GCM_SHA256
	(over submission+TLS, TLS-1.3, envelope from "rodrigo@sdfg.com.ar")
	; Wed, 14 Feb 2024 22:03:13 +0000
Message-ID: <197c0910-f1e5-4e55-81a3-59cb2069a1d7@sdfg.com.ar>
Date: Wed, 14 Feb 2024 19:03:10 -0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] tools/nolibc: Fix strlcat() return code and size
 usage
Content-Language: en-US
From: Rodrigo Campos <rodrigo@sdfg.com.ar>
To: Willy Tarreau <w@1wt.eu>
Cc: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-kernel@vger.kernel.org
References: <20240129141516.198636-1-rodrigo@sdfg.com.ar>
 <20240129141516.198636-3-rodrigo@sdfg.com.ar> <20240211104817.GA19364@1wt.eu>
 <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
In-Reply-To: <10b97cd3-5690-40b2-aa8e-3fea5dd4275f@sdfg.com.ar>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2/14/24 16:34, Rodrigo Campos wrote:
> size_t strlcat_rata(char *dst, const char *src, size_t size)
> {
>          const char *orig_src = src;
>          size_t len = 0;
>          for (;len < size; len++) {
>                  if (dst[len] == '\0')
>                          break;
>          }

If you think about it, this is strnlen() and what follows is strncat().

> size_t strlcat_willy_fixed(char *dst, const char *src, size_t size)
> {
>          const char *orig_src = src;
>          size_t len = strlen(dst);
>          if (size < len)
>                  len = size;

Same here.

We can simplify the code by using them, but the size doesn't seem to be 
smaller. Let me see what I can do.

