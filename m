Return-Path: <linux-kernel+bounces-125272-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D49DC892326
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 19:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AE2B225B6
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 18:08:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7826C1369AD;
	Fri, 29 Mar 2024 18:07:59 +0000 (UTC)
Received: from relay163.nicmail.ru (relay163.nicmail.ru [91.189.117.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7F11C0DC2;
	Fri, 29 Mar 2024 18:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.189.117.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711735679; cv=none; b=mxnGZfIb6z9l4mo1uIEjfE6/8K614KCuBd+sQQX45CBkpRl97DYWDrseMzo6ZkqhlqCSCJ2Oh6h75ZrxmEEwp++kdD8EKibht1c5faE9jjLitEHhuxylNPlJ7eKtSFZScWQzpFa2S+WW8MJ7nnIPFQH2JVxnKL8kLpv2HD5aGOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711735679; c=relaxed/simple;
	bh=ppBkloHHT+Aybl1NsacD70/lnYVpAG0Gn8A6J+takWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKX3sajgA2lcPuh1yGL0snARYKKU5LnICu7zh0TAzy8BUI+N3VCsBfSnjLL85QmQ2aAUT/B81f0bAoLUUKqOEkDojnmXGyLlvwHL2Dq8GYWz5zMO6LJV7OkGm/IDBEKF15tDn0YXInnuwxsIOAPHWX40Xkn2Sm+OthBXi8DxQhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru; spf=pass smtp.mailfrom=ancud.ru; arc=none smtp.client-ip=91.189.117.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ancud.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ancud.ru
Received: from [10.28.138.151] (port=11284 helo=[192.168.95.111])
	by relay.hosting.mail.nic.ru with esmtp (Exim 5.55)
	(envelope-from <kiryushin@ancud.ru>)
	id 1rqGSh-0008QS-9o;
	Fri, 29 Mar 2024 20:56:19 +0300
Received: from [87.245.155.195] (account kiryushin@ancud.ru HELO [192.168.95.111])
	by incarp1103.mail.hosting.nic.ru (Exim 5.55)
	with id 1rqGSg-002CSg-36;
	Fri, 29 Mar 2024 20:56:19 +0300
Message-ID: <a6e236f3-60a4-48da-840f-c38d7ba02475@ancud.ru>
Date: Fri, 29 Mar 2024 20:56:16 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Fix buffer overlow in print_cpu_stall_info()
To: paulmck@kernel.org
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Neeraj Upadhyay <quic_neeraju@quicinc.com>,
 Joel Fernandes <joel@joelfernandes.org>,
 Josh Triplett <josh@joshtriplett.org>, Boqun Feng <boqun.feng@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang1211@gmail.com>,
 rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20240328181914.869332-1-kiryushin@ancud.ru>
 <e3d3a612-4751-48ac-82c1-8bf61e8f3cd1@paulmck-laptop>
Content-Language: en-US
From: Nikita Kiryushin <kiryushin@ancud.ru>
In-Reply-To: <e3d3a612-4751-48ac-82c1-8bf61e8f3cd1@paulmck-laptop>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MS-Exchange-Organization-SCL: -1


Thank you for the feedback!
> would you like to resend keeping the buffer-overflow fix but leaving
> out the signed-to-unsigned conversion?
>
I will make a second version of the patch, without
conversion as it is intentional.
> However, the signed output is intentional.  The idea is that if the
> timekeeping code is confused enough to run the jiffies counter backwards,
> we see a small negative number rather than a huge positive number.
> For example, -132 is immediately obvious, while the 64-bit unsigned
> equivalent of 18446744073709551484 might not be.
I had suspicions that was the case, however, I did not find the pointers
in the code or in the commit message, that it was intentional, so I assumed
a mistake.
Maybe, it would be a good idea for me to add a comment with intent
clarification, to reduce possibility of the same confusion in the future,
while I am at it? If so, should I do it in the same patch, or make a separate one?

