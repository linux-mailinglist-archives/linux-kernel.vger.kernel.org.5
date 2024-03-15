Return-Path: <linux-kernel+bounces-104200-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A480287CA98
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 10:20:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C2DB222A3
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 09:20:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F5D17C6E;
	Fri, 15 Mar 2024 09:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UXX5qCHl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89F1917BCB
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 09:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710494410; cv=none; b=fR6Ad5WM0bNqdDdIes8b0ytWICLsYUIgeOE7J+lTtsf0+l2dLNxWLcEuDDPiNwDEg5/4RqMLSYk9a1TRx6A2ywHvG45DMnU6zDx8/7yyQUD41wmZzV/FHU4RvepHly315Wq5JbLcvUSk2XMh03gma+88F1Wd2Ctzk3m5RBymCZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710494410; c=relaxed/simple;
	bh=LXMAp98yYouLO2qKKxhEdORaYj4y2Lqsdjg6UNcPM7s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uM1pjynnTNBh6m3Fui9VDOT6Oe92whkvdyWDc7W7VisVOILjKGeOzsFa26KNH0IEHvb9Gxd5AW4D1L1tFUX3mUQJOBZF/mH7wbXOcbgQnNSCMyjHE7VXnfA5ZOSKOOy1dziIa5XZ0xQDvzp97adVBMnlTPIdzBQKi0OHocgkIwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UXX5qCHl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1710494406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MA4d9RmpAf+Zlw9q6wNWE3DUAtlrQpvK0bSCfYcQMp8=;
	b=UXX5qCHlyhGs4dG/utg3qddBwr40HDY5Q6dRfjjny+rzsZ5xi9k1jRoq5InP3e4fBayNzC
	JM3C+tOCl0lwzsL4wd+8ZKfCpevXHEOXbQOq4s/Tjp5APET8994l9nvQ7HfECVEh67d81o
	YJye1KNNyCgW8R9tXqy+caMA6qNgwWs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-Gxg4SC3YPSiX0_dKbJG3rg-1; Fri, 15 Mar 2024 05:19:58 -0400
X-MC-Unique: Gxg4SC3YPSiX0_dKbJG3rg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2415385A58B;
	Fri, 15 Mar 2024 09:19:58 +0000 (UTC)
Received: from [10.45.224.236] (unknown [10.45.224.236])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 47B71492BD0;
	Fri, 15 Mar 2024 09:19:56 +0000 (UTC)
Message-ID: <47003267-35b5-446e-aaca-f775b71bd01f@redhat.com>
Date: Fri, 15 Mar 2024 10:19:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] i40e: Enforce software interrupt during busy-poll
 exit
Content-Language: en-US
To: Jesse Brandeburg <jesse.brandeburg@intel.com>, netdev@vger.kernel.org
Cc: pawel.chmielewski@intel.com, aleksandr.loktionov@intel.com,
 mschmidt@redhat.com, Hugo Ferreira <hferreir@redhat.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20240313125457.19475-1-ivecera@redhat.com>
 <0249d506-6ab2-485a-b95f-6e32e5a92d9e@intel.com>
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <0249d506-6ab2-485a-b95f-6e32e5a92d9e@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10



On 15. 03. 24 1:53, Jesse Brandeburg wrote:
> On 3/13/2024 5:54 AM, Ivan Vecera wrote:
>> As for ice bug fixed by commit b7306b42beaf ("ice: manage interrupts
>> during poll exit") I'm seeing the similar issue also with i40e driver.
>>
>> In certain situation when busy-loop is enabled together with adaptive
>> coalescing, the driver occasionally miss that there are outstanding
>> descriptors to clean when exiting busy poll.
>>
>> Try to catch the remaining work by triggering a software interrupt
>> when exiting busy poll. No extra interrupts will be generated when
>> busy polling is not used.
>>
>> The issue was found when running sockperf ping-pong tcp test with
>> adaptive coalescing and busy poll enabled (50 as value busy_pool
>> and busy_read sysctl knobs) and results in huge latency spikes
>> with more than 100000us.
> 
> I like the results of this fix! Thanks for working on it.
> 
>>
>> The fix is inspired from the ice driver and do the following:
>> 1) During napi poll exit in case of busy-poll (napo_complete_done()
>>     returns false) this is recorded to q_vector that we were in busy
>>     loop.
>> 2) In i40e_update_enable_itr()
>>     - updates refreshed ITR intervals directly using PFINT_ITRN register
>>     - if we are exiting ordinary poll then just enables the interrupt
>>       using PFINT_DYN_CTLN
>>     - if we are exiting busy poll then enables the interrupt and
>>       additionally triggers an immediate software interrupt to catch any
>>       pending clean-ups
>> 3) Reuses unused 3rd ITR (interrupt throttle) index and set it to
>>     20K interrupts per second to limit the number of these sw interrupts.
> 
> This is a good idea.
> 
>>
>> @@ -2702,8 +2716,8 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>>   	 */
>>   	if (q_vector->rx.target_itr < q_vector->rx.current_itr) {
>>   		/* Rx ITR needs to be reduced, this is highest priority */
>> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
>> -					   q_vector->rx.target_itr);
>> +		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
>> +		     q_vector->rx.target_itr >> 1);
> 
> so here you write (this is a new write)
> 
>>   		q_vector->rx.current_itr = q_vector->rx.target_itr;
>>   		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>>   	} else if ((q_vector->tx.target_itr < q_vector->tx.current_itr) ||
>> @@ -2712,25 +2726,33 @@ static inline void i40e_update_enable_itr(struct i40e_vsi *vsi,
>>   		/* Tx ITR needs to be reduced, this is second priority
>>   		 * Tx ITR needs to be increased more than Rx, fourth priority
>>   		 */
>> -		intval = i40e_buildreg_itr(I40E_TX_ITR,
>> -					   q_vector->tx.target_itr);
>> +		wr32(hw, I40E_PFINT_ITRN(I40E_TX_ITR, q_vector->reg_idx),
>> +		     q_vector->tx.target_itr >> 1);
>>   		q_vector->tx.current_itr = q_vector->tx.target_itr;
>>   		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>>   	} else if (q_vector->rx.current_itr != q_vector->rx.target_itr) {
>>   		/* Rx ITR needs to be increased, third priority */
>> -		intval = i40e_buildreg_itr(I40E_RX_ITR,
>> -					   q_vector->rx.target_itr);
>> +		wr32(hw, I40E_PFINT_ITRN(I40E_RX_ITR, q_vector->reg_idx),
>> +		     q_vector->rx.target_itr >> 1);
> 
> or here (new write)
> 
>>   		q_vector->rx.current_itr = q_vector->rx.target_itr;
>>   		q_vector->itr_countdown = ITR_COUNTDOWN_START;
>>   	} else {
>>   		/* No ITR update, lowest priority */
>> -		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
>>   		if (q_vector->itr_countdown)
>>   			q_vector->itr_countdown--;
>>   	}
>>   
>> -	if (!test_bit(__I40E_VSI_DOWN, vsi->state))
>> -		wr32(hw, INTREG(q_vector->reg_idx), intval);
> 
> The above used to be the *only* write.
> 
>> +	/* Do not enable interrupt if VSI is down */
>> +	if (test_bit(__I40E_VSI_DOWN, vsi->state))
>> +		return;
>> +
>> +	if (!q_vector->in_busy_poll) {
>> +		intval = i40e_buildreg_itr(I40E_ITR_NONE, 0);
>> +	} else {
>> +		q_vector->in_busy_poll = false;
>> +		intval = i40e_buildreg_swint(I40E_SW_ITR);
>> +	}
>> +	wr32(hw, I40E_PFINT_DYN_CTLN(q_vector->reg_idx), intval);
> 
> and then you write again here.
> 
> So this function will now regularly have two writes in hot-path. Before
> it was very carefully crafted to reduce the number of writes to 1.
> 
> This is made possible because the PFINT_DYN_CTLN register can do
> multiple tasks at once with a single write.
> 
> Can you just modify intval to *both* trigger a software interrupt, and
> update the ITR simultaneously? I'm really not sure that's even possible.
> 
> It may make more sense to only do the second write when exiting busy
> poll, what do you think?

Yeah, you are right, we can eliminate these two writes by one and also 
for busy-poll exit. I'm setting up ITR2_IDX rate during MSI-X 
initialization and as this is fixed we do not need to update it 
everytime in i40e_update_enable_itr().

Per datasheet the PFINT_DYN_CTLN value can be encoded to do the 
following at once:
- enable interrupt
- update interval for particular ITR index
- software interrupt trigger limited by interval of different ITR index

Will prepare, test and submit v3 with this change.

Thanks,
Ivan


