Return-Path: <linux-kernel+bounces-283-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 110C5813EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2131F22A2F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FF062F;
	Fri, 15 Dec 2023 00:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="k66B4ZhT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175201C11;
	Fri, 15 Dec 2023 00:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=xxhQ+xwa9s7UNFJzJpzsqjZYnGGzElD2a56jENA4R1Q=; b=k66B4ZhTh66U+fvx8hZaKWswcz
	4O9Ms4ph7xH+izP3b7T7TEtbmFQjxrOAAzQwQuAXceSUXHHwhNvsP8XvD+M6vBakKCPkM0+qfLysq
	elrHvdMXRRgAIBkCd481Acrmu0e1sPlUMIvkPN96V8xHLZ8VAkwV6TrX9OTsbU6OksrCqbBSdbHFO
	TDtv1u7/esxIV9lAXroaVSqB/M/5y+CHX++CVsBvlxIH1zYDvw4mQ/Az4U6LnUcbSd/R9TH37JpZ2
	E7Mby4sp+13Ob8xGTwVM1EaTKbG4UWTBhZB0bZwi28Qv/ez4GMzC792/2zJMbJKvTlsPAliDznf3f
	0jqSjBhg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvx7-001cxB-1c;
	Fri, 15 Dec 2023 00:21:17 +0000
Message-ID: <16d1510c-fa3e-4fa9-ba4d-c483a22f83a4@infradead.org>
Date: Thu, 14 Dec 2023 16:21:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: kernel-doc: Report excess struct member
 descriptions
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231215001451.work.746-kees@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215001451.work.746-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Kees,

On 12/14/23 16:14, Kees Cook wrote:
> While missing descriptions were already be reported, missing struct
> members were not. For example, previously this output was empty, but now
> produces:
> 
> $ ./scripts/kernel-doc -none ./drivers/leds/leds-mlxreg.c
> ./drivers/leds/leds-mlxreg.c:42: warning: Excess struct member 'led_data' description in 'mlxreg_led_data'

I just made a patch with similar functionality last night:

https://lore.kernel.org/linux-doc/20231214070200.24405-1-rdunlap@infradead.org/


> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>
> ---
>  scripts/kernel-doc | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 08a3e603db19..39e730ee1fef 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -1265,6 +1265,18 @@ sub dump_struct($$) {
>  		$declaration .= "\t" . $clause . "\n";
>  		$level++ if ($clause =~ m/(\{)/ && !($clause =~m/\}/));
>  	}
> +
> +	my %_members;
> +	$_members{$_}++ for (@parameterlist);
> +
> +	while (my ($k, $v) = each %parameterdescs) {
> +	    if (!exists($_members{$k})) {
> +	        if (show_warnings("struct", $declaration_name)) {
> +		     emit_warning("${file}:$.", "Excess struct member '$k' description in '$declaration_name'\n");
> +		}
> +	    }
> +	}
> +
>  	output_declaration($declaration_name,
>  			   'struct',
>  			   {'struct' => $declaration_name,

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

