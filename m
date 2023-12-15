Return-Path: <linux-kernel+bounces-282-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 345E3813EA6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 01:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF4841F22B47
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 00:19:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96F4651;
	Fri, 15 Dec 2023 00:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FqNszvlC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1407360;
	Fri, 15 Dec 2023 00:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=5r1yJnsUKVIP24tg1/QoYBS3T6bI2hVEff/j08ogpdw=; b=FqNszvlC9PfZBq9NysvYa8Hc5x
	f7Sql8HKln3L9sHq1N8IsLqhj0+XQzsmh1HZfkJNt+U5QVQzNoGl+MRI6ebmzJYe3SRRJP57UqMcZ
	efxxOuJkrjvFj7K7uFXgP0mggP1DSrvj4/AUtoNKS5AUmkhcg1SXww8TkxYpRIVit4YCv356B60zd
	WXZJ1fw19cLshtL7k1KDVx5sZhN+fbUiNLxjzp3iBSt8suddqxOQcN5QWLojjBcPzug9xiDMuIE+n
	ISVIPZo26JLOgyXI+pEMjZTxQhUf7qvGBcNxOAaLw3NJPYbIpvoBfUjOC9fGFfbV1GJFwRvP3ucGa
	wMy29iWA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rDvvT-001cpf-06;
	Fri, 15 Dec 2023 00:19:35 +0000
Message-ID: <6d8d2001-ea9e-4e3d-9e6d-8192064556a5@infradead.org>
Date: Thu, 14 Dec 2023 16:19:34 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts: kernel-doc: Disambiguate origin of warnings
Content-Language: en-US
To: Kees Cook <keescook@chromium.org>, Jonathan Corbet <corbet@lwn.net>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org
References: <20231215001535.work.434-kees@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231215001535.work.434-kees@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/14/23 16:15, Kees Cook wrote:
> There's no prefix to warnings and errors reported by scripts/kernel-doc
> which makes it frustrating to isolate errors reported from CI systems.
> Add a "$0: " prefix to all the STDERR output.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: linux-doc@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Matthew's reply to my patch with similar functionality, which I agree with:

https://lore.kernel.org/linux-doc/ZQke26HX9Am3k2sh@casper.infradead.org/

> ---
>  scripts/kernel-doc | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/scripts/kernel-doc b/scripts/kernel-doc
> index 41f838042364..2a7b975b03e7 100755
> --- a/scripts/kernel-doc
> +++ b/scripts/kernel-doc
> @@ -450,7 +450,7 @@ sub print_lineno {
>  sub emit_warning {
>      my $location = shift;
>      my $msg = shift;
> -    print STDERR "$location: warning: $msg";
> +    print STDERR "$0: $location: warning: $msg";
>      ++$warnings;
>  }
>  ##
> @@ -1292,7 +1292,7 @@ sub dump_struct($$) {
>  			   });
>      }
>      else {
> -	print STDERR "${file}:$.: error: Cannot parse struct or union!\n";
> +	print STDERR "$0: ${file}:$.: error: Cannot parse struct or union!\n";
>  	++$errors;
>      }
>  }
> @@ -1398,7 +1398,7 @@ sub dump_enum($$) {
>  			    'purpose' => $declaration_purpose
>  			   });
>      } else {
> -	print STDERR "${file}:$.: error: Cannot parse enum!\n";
> +	print STDERR "$0: ${file}:$.: error: Cannot parse enum!\n";
>  	++$errors;
>      }
>  }
> @@ -1469,7 +1469,7 @@ sub dump_typedef($$) {
>  			   });
>      }
>      else {
> -	print STDERR "${file}:$.: error: Cannot parse typedef!\n";
> +	print STDERR "$0: ${file}:$.: error: Cannot parse typedef!\n";
>  	++$errors;
>      }
>  }
> @@ -1993,7 +1993,7 @@ sub process_export_file($) {
>      my $file = map_filename($orig_file);
>  
>      if (!open(IN,"<$file")) {
> -	print STDERR "Error: Cannot open file $file\n";
> +	print STDERR "$0: Error: Cannot open file $file\n";
>  	++$errors;
>  	return;
>      }
> @@ -2102,7 +2102,7 @@ sub process_name($$) {
>  	}
>  
>  	if ($verbose) {
> -	    print STDERR "${file}:$.: info: Scanning doc for $decl_type $identifier\n";
> +	    print STDERR "$0: ${file}:$.: info: Scanning doc for $decl_type $identifier\n";
>  	}
>      } else {
>  	emit_warning("${file}:$.", "Cannot understand $_ on line $. - I thought it was a doc line\n");
> @@ -2320,7 +2320,7 @@ sub process_file($) {
>      $file = map_filename($orig_file);
>  
>      if (!open(IN_FILE,"<$file")) {
> -	print STDERR "Error: Cannot open file $file\n";
> +	print STDERR "$0: Error: Cannot open file $file\n";
>  	++$errors;
>  	return;
>      }
> @@ -2410,14 +2410,14 @@ foreach (@ARGV) {
>      process_file($_);
>  }
>  if ($verbose && $errors) {
> -  print STDERR "$errors errors\n";
> +  print STDERR "$0: $errors errors\n";
>  }
>  if ($verbose && $warnings) {
> -  print STDERR "$warnings warnings\n";
> +  print STDERR "$0: $warnings warnings\n";
>  }
>  
>  if ($Werror && $warnings) {
> -    print STDERR "$warnings warnings as Errors\n";
> +    print STDERR "$0: $warnings warnings as Errors\n";
>      exit($warnings);
>  } else {
>      exit($output_mode eq "none" ? 0 : $errors)

-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

