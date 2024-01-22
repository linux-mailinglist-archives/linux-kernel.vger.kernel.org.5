Return-Path: <linux-kernel+bounces-33656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 214EE836CCD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:17:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC495285A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10020651A3;
	Mon, 22 Jan 2024 16:06:33 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D7913EA92;
	Mon, 22 Jan 2024 16:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705939592; cv=none; b=ruuOrI2bMpWcCmy3wV/5g/qSqZBJAuO+mKhB1m+wTneEMyNvvFSlD+xhcBFR3XgliYt3JZLNiLD2McQD41Uh1ZXeIQt+O1ll2aJ6mpPQ2mr5HPNIDg9NJKBb2XXl13UMZYYwcv+z9vMYUgqGNaEvsezojoF6IclCOatjGvygiU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705939592; c=relaxed/simple;
	bh=/L2YrNxPOfocGWcSIQklbfEgmVRKuWexr+x6ZjSRXzM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JJGqSZ653Ah5yCicAUax+WXgineCF8HIRp0EtW7KovbBcDZhM+GYHM4ooL+DfmDsSZe0jWHEWFWWnwebrcp9oXmqRngltsoVIypCb83tHhTiqVhOURAL0FDnekRg29nYSrko1RtFu74Ou7PVCbOe/ZfJMSluFdXyC8xd+6r0F+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C547C433F1;
	Mon, 22 Jan 2024 16:06:31 +0000 (UTC)
Date: Mon, 22 Jan 2024 11:07:59 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Ye Bin <yebin10@huawei.com>
Cc: <mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 1/7] string.h: add str_has_suffix() helper for test
 string ends with specify string
Message-ID: <20240122110759.29c50a19@gandalf.local.home>
In-Reply-To: <20240122074015.4042575-2-yebin10@huawei.com>
References: <20240122074015.4042575-1-yebin10@huawei.com>
	<20240122074015.4042575-2-yebin10@huawei.com>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 22 Jan 2024 15:40:09 +0800
Ye Bin <yebin10@huawei.com> wrote:

> str_has_suffix() is test string if ends with specify string.
> 
> Signed-off-by: Ye Bin <yebin10@huawei.com>
> ---
>  include/linux/string.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/include/linux/string.h b/include/linux/string.h
> index 433c207a01da..e47e9597af27 100644
> --- a/include/linux/string.h
> +++ b/include/linux/string.h
> @@ -405,4 +405,24 @@ static __always_inline size_t str_has_prefix(const char *str, const char *prefix
>  	return strncmp(str, prefix, len) == 0 ? len : 0;
>  }
>  
> +/**
> + * str_has_suffix - Test if a string has a given suffix
> + * @str: The string to test
> + * @suffix: The string to see if @str ends with
> + *
> + * Returns:
> + * * strlen(@suffix) if @str ends with @suffix
> + * * 0 if @str does not end with @suffix
> + */
> +static __always_inline size_t str_has_suffix(const char *str, const char *suffix)
> +{
> +	size_t len = strlen(suffix);
> +	size_t str_len = strlen(str);
> +
> +	if (len > str_len)
> +		return 0;
> +
> +	return strncmp(str + str_len - len, suffix, len) == 0 ? len : 0;
> +}

I understand why you are returning the length of the suffix, as it matches
str_has_prefix(). But as the user of this will likely need the length of
the "str" too, we should either return the length of the string, or the
index of where the suffix was found.

/**
 [..]
 @index: The index into @str of where @suffix is if found (NULL to ignore)
 [..]
*/
static __always_inline size_t str_has_suffix(const char *str, const char *suffix, size_t *index)
{
	size_t len = strlen(suffix);
	size_t str_len = strlen(str);

	if (len > str_len)
		return 0;

	if (index)
		*index = str_len - len;

	return strncmp(str + str_len - len, suffix, len) == 0 ? len : 0;
}

-- Steve

> +
>  #endif /* _LINUX_STRING_H_ */


