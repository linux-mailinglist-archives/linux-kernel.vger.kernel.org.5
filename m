Return-Path: <linux-kernel+bounces-16047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 18D77823772
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 23:06:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F465B23322
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 22:06:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 623821DA39;
	Wed,  3 Jan 2024 22:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="A66KHMrY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547B21DA2B;
	Wed,  3 Jan 2024 22:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=EdRu0W6GLHIJHEn2wYm3TYenMT7vzPnopJo0YAUEvEw=; b=A66KHMrYX8zsXLf5kNempcbVRt
	PUm25fnu4eg7G4U03eyDLL/8CJ/A+lJi/DevVYrbc5/MmOqLjPVSS3urBOo59shDywoxi9a3uQT9E
	h/d4sBYwKWXrMQZJTbWFgchV/0bkW+pOpjz/9gMw6jYGxNFEcY6aFuzEcyekX1f8VPMTPAoCB/Vaf
	/QEsdLie51L1ENWWg2v9uOOhFwP+Hru9SCctSHe6IckflttuIC20Al5ULivha9d8y0tkhsxGgtjvV
	f4ivLHbN16AXlcQ6H++ZEnJxPssGEq7ne9K75e2/Ro2X0vNs/lEzoVHgGgleidgljSlFs6uw6Japt
	bH6/r7Kg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rL9Ne-00CDji-2h;
	Wed, 03 Jan 2024 22:06:30 +0000
Message-ID: <bbe9f340-aea2-4847-b11e-31042a1440b9@infradead.org>
Date: Wed, 3 Jan 2024 14:06:30 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/get_abi.pl: ignore some temp files
Content-Language: en-US
To: Jonathan Corbet <corbet@lwn.net>, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-doc@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>
References: <20231228233113.5218-1-rdunlap@infradead.org>
 <87plyi86zg.fsf@meer.lwn.net>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <87plyi86zg.fsf@meer.lwn.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 13:03, Jonathan Corbet wrote:
> Randy Dunlap <rdunlap@infradead.org> writes:
> 
>> When there are filenames of the form ".orig" or ".rej" in
>> the Documenatation/ABI/ subdirectories, there can be confusing or
>> erroneous output generated. Example: the file
>> Documenation/ABI/testing/sysfs-bus-papr-pmem.orig causes this
>> warning message:
>>
>> Documentation/ABI/testing/sysfs-bus-papr-pmem:2: WARNING: unknown document: '/powerpc/papr_hcalls'
>>
>> Prevent this by skipping over filenames that may be created by
>> patch/diff tools etc.
>>
>> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>> Cc: Jonathan Corbet <corbet@lwn.net>
>> Cc: linux-doc@vger.kernel.org
>> Acked-by: Mauro Carvalho Chehab <mchehab@kernel.org>
>> ---
>>  scripts/get_abi.pl |    1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff -- a/scripts/get_abi.pl b/scripts/get_abi.pl
>> --- a/scripts/get_abi.pl
>> +++ b/scripts/get_abi.pl
>> @@ -93,6 +93,7 @@ sub parse_abi {
>>  	return if ($mode & S_IFDIR);
>>  	return if ($file =~ m,/README,);
>>  	return if ($file =~ m,/\.,);
>> +	return if ($file =~ m,\.(rej|org|orig|bak)$,);
> 
> Applied, thanks.
> 
> It would have been nice to create all of those files with a .abi
> extension so we didn't have to do this kind of blocklisting, but so be
> it.
> 
> Should we exclude emacs-style ~ files too?

Hm, probably. Someday.

-- 
#Randy

