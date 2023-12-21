Return-Path: <linux-kernel+bounces-8184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 207FC81B345
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 11:12:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C67BC28917A
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 10:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7F14F20E;
	Thu, 21 Dec 2023 10:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bw8TdFBd"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF6951C20;
	Thu, 21 Dec 2023 10:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703153566; x=1734689566;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=CvUxQutvmhA/Tex/Z1ZHD66YcYgZjGrHj75tI6g3a1s=;
  b=bw8TdFBd/ykc2uZaxsjH7rnvl+4Bgf4vPHI8vu7pQRTNnjokEyQ2gSUH
   mDpnH8PxaRIoY3lVLq2XDPz2jFkjfIMpDMQmgPxekvPXpNATsWbvrPsKn
   74sYULD4x/AZ0+iJBvx2rLMcpjtTXinAeo1lhMHkBQW9A8pY8hvXkIsAI
   qu5cPC6v5jSSuX5i+tWUMyQ8X2lnExlW6TMSZqJEc97GzW51TghlFEB/E
   9gkLYd7Xpx57/vtH9j2N6gWDTtu+iblPXT2f1dbKBH1wvU41+1AoxTgoI
   FSgz//II11TBG9G8pMR9qdbHb6Dd7La4OwI/VBpiHBVa8EkYqn8RaoP1/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="17507251"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="17507251"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:12:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="780148554"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="780148554"
Received: from mohdfai2-mobl.gar.corp.intel.com (HELO [10.215.242.241]) ([10.215.242.241])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2023 02:12:42 -0800
Message-ID: <d4a29e26-b9cb-4bf9-9dc5-b85f29d3619d@linux.intel.com>
Date: Thu, 21 Dec 2023 18:12:39 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 net 0/4] qbv cycle time extension/truncation
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <vladimir.oltean@nxp.com>
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>,
 Jiri Pirko <jiri@resnulli.us>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231219081453.718489-1-faizal.abdul.rahim@linux.intel.com>
 <20231219165650.3amt4ftyt7gisz47@skbuf>
 <023377a7f227f8cd7d5eb73017dbe3f691b29b17.camel@redhat.com>
From: "Abdul Rahim, Faizal" <faizal.abdul.rahim@linux.intel.com>
In-Reply-To: <023377a7f227f8cd7d5eb73017dbe3f691b29b17.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 21/12/2023 4:52 pm, Paolo Abeni wrote:
> On Tue, 2023-12-19 at 18:56 +0200, Vladimir Oltean wrote:
>> How are you testing the behavior, and who reported the issues / what prompted
>> the changes? Honestly I'm not very confident in the changes we're
>> pushing down the linux-stable pipe. They don't look all that obvious, so
>> I still think that having selftests would help.
> 
> I agree with Vladimir, this looks quite a bit too complex for a net fix
> at this late point of the cycle. Given the period of the year, I think
> it could be too late even for net-next - for this cycle.
> 

Would it be better to just submit into net-next and target for the next 
cycle ? I'm okay with that.

> It would be great if you could add some self-tests.
> 
> @Faizal: I understand your setup is quite complex, but it would be
> great if you could come-up with something similar that could fit
> tools/testing/selftests/net
> 
> Thanks!
> 
> Paolo
> 

Ohh my bad, I thought selftest is just to develop and run the test case 
locally, but it seems that it also refers to integrating it into the 
existing selftest framework ?
Got it. I'll explore that and cover extension/truncation cases.



