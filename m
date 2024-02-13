Return-Path: <linux-kernel+bounces-63757-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4554985341B
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 16:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D985FB299AB
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 15:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72DCD5F491;
	Tue, 13 Feb 2024 15:01:35 +0000 (UTC)
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D66A05F54C;
	Tue, 13 Feb 2024 15:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707836495; cv=none; b=V4oI+gqvcxjOCOJZyhs6h2elpmA+n0Zf6iGpumDlNB3gJoYDA5uwxj8ids+T1G9t24HqjktFvxMGjBdp7szHgwbNv2DNoMC7G0S8LA/IdxqpTWLRNuoIsCnJ6NOpO4TqnwVw6LmVrWgaemD6g8AXkzcoKVoBqWtofF3ZHgpyrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707836495; c=relaxed/simple;
	bh=80vLXOiXoOCTx/vCIvNl7N6ccNiqxnQSQ6P0aZ2qKGI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P1Tpjgu2RUyLeUzmFbDWcQQIPFZj8Z4o1wQxqUgp9HM1DHA6GNasJXye3I2HwBW8Abtv8p+Vnp9sh11qQeMN39PsRDJSQtIPjahuOXkiLhkCR2igpjjJRnm3fGmz9Q1I3lTrms5P6Wx3ymwlilhocWBFJ5p8jSApIhiaRtbIHcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rZuHl-0006qk-4S; Tue, 13 Feb 2024 16:01:25 +0100
Message-ID: <699726f6-8f5d-4482-8c27-8ea47a483f8a@leemhuis.info>
Date: Tue, 13 Feb 2024 16:01:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regression] linux-6.6.y, minmax: virtual memory exhausted in
 i586 chroot during kernel compilation
Content-Language: en-US, de-DE
To: Greg KH <gregkh@linuxfoundation.org>,
 Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Sasha Levin <sashal@kernel.org>, David Laight <David.Laight@aculab.com>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
References: <f9f89284-0f48-4971-ad8d-86938a82fafc@leemhuis.info>
 <2024021318-shifty-daybed-fca8@gregkh>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <2024021318-shifty-daybed-fca8@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1707836493;cb9dcd70;
X-HE-SMSGID: 1rZuHl-0006qk-4S

On 13.02.24 15:50, Greg KH wrote:
> On Mon, Feb 12, 2024 at 05:16:58PM +0100, Linux regression tracking (Thorsten Leemhuis) wrote:
>>
>> I noticed a regression report in bugzilla.kernel.org that seems to be
>> specific to the linux-6.6.y series:
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218484 :
>>
>>> After upgrading to version 6.6.16, the kernel compilation on a i586
>>> arch (on a 32bit chroot in a 64bit host) fails with a message:
>>>
>>> virtual memory exhausted: Cannot allocate memory
>>>
>>> this happens even lowering the number of parallel compilation
>>> threads. On a x86_64 arch the same problem doesn't occur. It's not
>>> clear whether some weird recursion is triggered that exhausts the
>>> memory, but it seems that the problem is caused by the patchset
>>> 'minmax' added to the 6.6.16 version, in particular it seems caused
>>> by these patches:
>>>
>>> - minmax-allow-min-max-clamp-if-the-arguments-have-the-same-signedness.patch
>>> - minmax-fix-indentation-of-__cmp_once-and-__clamp_once.patch
>>> - minmax-allow-comparisons-of-int-against-unsigned-char-short.patch
>>> - minmax-relax-check-to-allow-comparison-between-unsigned-arguments-and-signed-constants.patch
>>>
>>> Reverting those patches fixes the memory exhaustion problem during compilation.
>>
>> The reporter later added:
>>
>>> From a quick test the same problem doesn't occur in 6.8-rc4.
>> See the ticket for more details.
>
> I think this was already fixed in 6.7 or Linus's tree, but I can't seem
> to find the commit at the moment.

I thought so as well, but was in the same situation. But your comment
made me look again and now I found it: that was 31e97d7c9ae3de ("media:
solo6x10: replace max(a, min(b, c)) by clamp(b, a, c)"), which indeed is
not yet in 6.6.y.

> What file is causing the compiler to crash?  Is it some video or media
> driver?

HTH, Ciao, Thorsten

