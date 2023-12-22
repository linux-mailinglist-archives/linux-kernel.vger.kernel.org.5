Return-Path: <linux-kernel+bounces-10029-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD16F81CEEA
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C00D1F23D88
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8F7A2E658;
	Fri, 22 Dec 2023 19:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="qvUfuaMH"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529E12E821;
	Fri, 22 Dec 2023 19:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=gKd+L66yod8uEFMOkkJsz50fKS7oNh0JqJUaQ5OiA70=; b=qvUfuaMHAQaYqMURVQygCfszfG
	9QT7QwkPrtisjT+uboyWdYogLKeA6pEQo3JoPX45oIKIVjLOmnnENQS63rKdMoY4Gtzqpx8CjX4yp
	RYYJQFgtvBzHai73RMxlDyVNDKuiFnYPDo3vp9ttaHrIL1t11F+0A+qZh9AxZSFeQ9GVsO8g3tjkd
	JCpjmZ5m604zNxb3HgwF3ACgNIkopGDOqIAaiPIVm8jtkLOLt+AT/YNPRiZfUX2LocNmmCsznuxlg
	dSZ8/86tisux0kY54VR7z4KRr+GhuYMRE/4lOIAFbM63RIzaHG7EHcz6n/Ejfdipx9T1Eb9XbJE75
	gzf9eHgQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rGlQf-006kB4-0P;
	Fri, 22 Dec 2023 19:43:29 +0000
Message-ID: <a3b15524-8e50-4e50-b3d3-95fd2092ec8d@infradead.org>
Date: Fri, 22 Dec 2023 11:43:28 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tty/sysrq: Dump kernel ring buffer messages via sysrq
Content-Language: en-US
To: Sreenath Vijayan <sreenath.vijayan@sony.com>
Cc: anandakumar.balasubramaniam@sony.com, corbet@lwn.net,
 gregkh@linuxfoundation.org, jirislaby@kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
 taichi.shimoyashiki@sony.com
References: <cc5c5ceb-cb07-4fb3-95f0-c114dd12a755@infradead.org>
 <20231222115732.1683728-3-sreenath.vijayan@sony.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231222115732.1683728-3-sreenath.vijayan@sony.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 12/22/23 03:44, Sreenath Vijayan wrote:
> On Thu, Dec 21, 2023 at 03:12:46PM -0800, Randy Dunlap wrote:
>>
>>
>> On 12/21/23 08:52, Greg KH wrote:
>>> On Thu, Dec 21, 2023 at 07:09:53PM +0530, Sreenath Vijayan wrote:
>>>> When terminal is unresponsive, one cannot use dmesg to view kernel
>>>> ring buffer messages. Also, syslog services may be disabled,
>>>> to check them after a reboot, especially on embedded systems.
>>>> In this scenario, dump the kernel ring buffer messages via sysrq
>>>> by pressing sysrq+D.
>>>>
>>>> Signed-off-by: Sreenath Vijayan <sreenath.vijayan@sony.com>
>>>> Signed-off-by: Shimoyashiki Taichi <taichi.shimoyashiki@sony.com>
>>>> ---
>>>>  Documentation/admin-guide/sysrq.rst |  2 ++
>>>>  drivers/tty/sysrq.c                 | 43 ++++++++++++++++++++++++++++-
>>>>  2 files changed, 44 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/admin-guide/sysrq.rst b/Documentation/admin-guide/sysrq.rst
>>>> index 2f2e5bd440f9..464c4e138b9d 100644
>>>> --- a/Documentation/admin-guide/sysrq.rst
>>>> +++ b/Documentation/admin-guide/sysrq.rst
>>>> @@ -161,6 +161,8 @@ Command	    Function
>>>>              will be printed to your console. (``0``, for example would make
>>>>              it so that only emergency messages like PANICs or OOPSes would
>>>>              make it to your console.)
>>>> +
>>>> +``D``	    Dump the kernel ring buffer
>>>>  =========== ===================================================================
>>>
>>> Nit, this doesn't line up anymore :(
>>
>> Yes, that will cause a docs build warning.
> 
> Thank you for the review comments. When I apply the patch, I don't
> notice any alignment issues in the document. I tried with multiple
> editors(vim,emacs) and the combination of tabs and spaces looks to
> be the same as in the existing lines above the newly added line.
> Tried "make htmldocs" and no warnings were observed and the html
> page looks ok. Please suggest the modifications to be done.

You are correct. Sorry for the confusion. It can be messy trying to
read/review a diff when there is alignment involved.

>>
>> Also, can you be more explicit about which ring buffer this patch
>> is referring to, please.
>>
> 
> We see the term "kernel ring buffer" used throughout the documents
> and commit messages, and thought it is the right term. Even dmesg
> manual page uses it. Would "kernel log buffer" be a more appropriate
> term? Please share your suggestion.

Documentation/admin-guide/kernel-parameters.txt refers to:
	ftrace ring buffer
	printk ring buffer
	tracing ring buffer
so saying "kernel ring buffer" is not very specific.

I expect that you are referring to the printk ring buffer, although
I would prefer to call it something like the console log buffer (FWIW).

thanks.
-- 
#Randy
https://people.kernel.org/tglx/notes-about-netiquette
https://subspace.kernel.org/etiquette.html

