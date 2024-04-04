Return-Path: <linux-kernel+bounces-131902-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 44F24898D6E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:44:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C70E51F21F95
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3429112DDBF;
	Thu,  4 Apr 2024 17:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bBQ85kwM"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1E81DFCE
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712252680; cv=none; b=s7n6ut4HfV7TsaCrCChWwiltkGL2UhYLIWzv7vB13KX85/bjdHlQHe1k891qPnNVEF37NrMOOWTiEx9UBmMhAGpcXBcC6XUrvDHJMKfmBOM9fERKDrb+gnGEmfeoe+Nb2nXkGG66wdKgpjqV21byfBh7ga8731lrgnTJ1VFuS3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712252680; c=relaxed/simple;
	bh=E8EvdLcWecli+qPyH79beE6yGJ/2t1vYm5PqxsJ7xIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uhfMe0+X6U2dqmW6aS0MF8z3NVdbYvbuFGI52DdQ+sQoAwW6/QW6q+q3s+aIvhmwnqsS1UEegAGemn0m4DycHlzo7FWlzbpGuWd65qnlU8Cy/QB01fmT7oYLzj1iPgpXbF8BHzzwp/5AaGwlkrWPmdryfimDydBE9Et22YeD45c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bBQ85kwM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712252677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M88VuRkfKMVZscqFvkjFz3QDb0lbfRFNBp4u3AbPwH4=;
	b=bBQ85kwMRvgDZRtJvIl0uFVbY2dySw33hNJPI42178ZNOrs7qBrmEnjfChddSJqyaIBLY8
	6zVu4ao7x4rUBtC1Vl3Kt40MfxhaB7SQgrEGjKddEVd+oLaA0vAJsiGy5/kWM0L+APF2Qn
	TXs1mYL0uQ2RmXVqTRMaEmWjTbRnv38=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-_vwPB5A-N0mIMDkdcIynVw-1; Thu, 04 Apr 2024 13:44:34 -0400
X-MC-Unique: _vwPB5A-N0mIMDkdcIynVw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 17ECC88D12A;
	Thu,  4 Apr 2024 17:44:34 +0000 (UTC)
Received: from [10.22.33.193] (unknown [10.22.33.193])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9AF751121306;
	Thu,  4 Apr 2024 17:44:33 +0000 (UTC)
Message-ID: <23fd78bb-76a7-46e8-9523-5d2cab4186f5@redhat.com>
Date: Thu, 4 Apr 2024 13:44:33 -0400
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Make reader optimistic spinning optional
Content-Language: en-US
To: Bongkyu Kim <bongkyu7.kim@samsung.com>, John Stultz <jstultz@google.com>
Cc: peterz@infradead.org, mingo@redhat.com, will@kernel.org,
 boqun.feng@gmail.com, linux-kernel@vger.kernel.org,
 gregkh@linuxfoundation.org
References: <CGME20230901010734epcas2p4aadced02d68d3db407fda23de34601d2@epcas2p4.samsung.com>
 <20230901010704.18493-1-bongkyu7.kim@samsung.com>
 <CANDhNCoFRr=qizswLm-dzxJK0fHuCx98Z2B1pUspdwGqBEejYg@mail.gmail.com>
 <20240403012132.GA460@KORCO045595.samsungds.net>
 <CANDhNCpvKj6Swer-8DtQEotdnOiqfAg43oZLw_HZs6ogwqPwzg@mail.gmail.com>
 <20240403014207.GA499@KORCO045595.samsungds.net>
From: Waiman Long <longman@redhat.com>
In-Reply-To: <20240403014207.GA499@KORCO045595.samsungds.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3


On 4/2/24 21:42, Bongkyu Kim wrote:
> On Tue, Apr 02, 2024 at 06:27:40PM -0700, John Stultz wrote:
>> On Tue, Apr 2, 2024 at 6:21 PM Bongkyu Kim <bongkyu7.kim@samsung.com> wrote:
>>> On Tue, Apr 02, 2024 at 04:46:06PM -0700, John Stultz wrote:
>>>> On Thu, Aug 31, 2023 at 6:07 PM Bongkyu Kim <bongkyu7.kim@samsung.com> wrote:
>>>>> This is rework of the following discussed patch.
>>>>> https://lore.kernel.org/all/20230613043308.GA1027@KORCO045595.samsungds.net/
>>>>>
>>>>> Changes from the previous patch
>>>>> - Split to revert and modify patches
>>>>> - Change according to Waiman Long's review
>>>>>      More wording to documentation part
>>>>>      Change module_param to early_param
>>>>>      Code change by Waiman Long's suggestion
>>>>>
>>>>> In mobile environment, reader optimistic spinning is still useful
>>>>> because there're not many readers. In my test result at android device,
>>>>> it improves application startup time about 3.8%
>>>>> App startup time is most important factor for android user expriences.
>>>>> So, re-enable reader optimistic spinning by this commit. And,
>>>>> make it optional feature by cmdline.
>>>>>
>>>>> Test result:
>>>>> This is 15 application startup performance in our exynos soc.
>>>>> - Cortex A78*2 + Cortex A55*6
>>>>> - unit: ms (lower is better)
>>>>>
>>>>> Application             base  opt_rspin  Diff  Diff(%)
>>>>> --------------------  ------  ---------  ----  -------
>>>>> * Total(geomean)         343        330   -13    +3.8%
>>>>> --------------------  ------  ---------  ----  -------
>>>>> helloworld               110        108    -2    +1.8%
>>>>> Amazon_Seller            397        388    -9    +2.3%
>>>>> Whatsapp                 311        304    -7    +2.3%
>>>>> Simple_PDF_Reader        500        463   -37    +7.4%
>>>>> FaceApp                  330        317   -13    +3.9%
>>>>> Timestamp_Camera_Free    451        443    -8    +1.8%
>>>>> Kindle                   629        597   -32    +5.1%
>>>>> Coinbase                 243        233   -10    +4.1%
>>>>> Firefox                  425        399   -26    +6.1%
>>>>> Candy_Crush_Soda         552        538   -14    +2.5%
>>>>> Hill_Climb_Racing        245        230   -15    +6.1%
>>>>> Call_Recorder            437        426   -11    +2.5%
>>>>> Color_Fill_3D            190        180   -10    +5.3%
>>>>> eToro                    512        505    -7    +1.4%
>>>>> GroupMe                  281        266   -15    +5.3%
>>>>>
>>>> Hey Bongkyu,
>>>>    I wanted to reach out to see what the current status of this patch
>>>> set? I'm seeing other parties trying to work around the loss of the
>>>> optimistic spinning functionality since commit 617f3ef95177
>>>> ("locking/rwsem: Remove reader optimistic spinning") as well, with
>>>> their own custom variants (providing some substantial gains), and
>>>> would really like to have a common solution.
>>>>
>>> I didn't get an reply, so I've been waiting.
>>> Could you let me know about their patch?
>> I don't have insight/access to any other implementations, but I have
>> nudged folks to test your patch and chime in here.
>>
>> Mostly I just wanted to share that others are also seeing performance
>> trouble from the loss of optimistic spinning, so it would be good to
>> get some sort of shared solution upstream.
>>
>> thanks
>> -john
>>
When this patch series was originally posted last year, we gave some 
comments and suggestion on how to improve it as well as request for more 
information on certain area. We were expecting a v2 with the suggested 
changes, but we never got one and so it just fell off the cliff.

Please send a v2 with the requested change and we can continue our 
discussion.

Thanks,
Longman



